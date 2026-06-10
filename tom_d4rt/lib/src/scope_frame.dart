import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Statically-resolved lexical coordinate of an identifier *use*.
///
/// Produced by [StaticResolver] (perf plan_3 §4, sub-step S1) and carried on
/// the analyzer AST via an [Expando] side-table (the analyzer's
/// `SimpleIdentifier` is sealed/immutable, so a field cannot be added — see
/// plan_3 §4.3). [depth] is the number of enclosing `Environment` hops from the
/// use's runtime scope to the declaring scope; [slot] is the declaration index
/// within that scope (declaration order). A coordinate is emitted only for an
/// eligible depth-0 local, so [depth] is always 0; S3c (plan_3 §9.3) indexes
/// the current frame's slot array by [slot] directly on the read path.
class StaticCoord {
  /// Enclosing-hop distance from the use to its declaring scope.
  final int depth;

  /// Declaration index within the declaring scope (declaration order).
  final int slot;

  const StaticCoord(this.depth, this.slot);

  @override
  String toString() => 'StaticCoord(depth: $depth, slot: $slot)';
}

/// Does [node] open a new runtime [Environment] frame?
///
/// This is the **shared scope-frame predicate** (plan_3 §4.4, risk R1): the
/// single decision the resolver and the interpreter must agree on. It is
/// deliberately **over-approximating** — it may return `true` for a construct
/// the interpreter happens not to wrap in its own frame. Over-approximation is
/// safe for the S1 depth-0 resolver: modelling an *extra* frame only ever
/// raises a computed depth (suppressing a coordinate), never lowers it, so it
/// can never manufacture a false depth-0. Under-approximation (missing a frame
/// the interpreter *does* push) is the unsafe direction and is what this list
/// guards against by erring generous.
bool opensLexicalFrame(AstNode node) {
  return node is Block ||
      node is ForStatement ||
      node is ForElement ||
      node is WhileStatement ||
      node is DoStatement ||
      node is SwitchStatement ||
      node is SwitchExpression ||
      node is CatchClause ||
      node is FunctionExpression ||
      node is MethodDeclaration ||
      node is ConstructorDeclaration;
}

/// One modelled local declaration on a resolver frame.
///
/// A declaration is a **slot candidate** iff [node] is non-null (only plain
/// `var`/`final` locals declared directly in a slottable [Block] qualify; local
/// function names are recorded with a null [node] so they correctly *shadow*
/// outer same-named locals but are never themselves slotted). A candidate stays
/// [eligible] until a depth>0 use (escape) or an assignment-target use demotes
/// it; only eligible candidates receive a compacted slot on block exit.
class _Decl {
  final String name;

  /// The declaration node (carrier key for a future `declSlot` side-table), or
  /// `null` for non-slot kinds (function names) tracked only for shadowing.
  final VariableDeclaration? node;

  bool eligible;

  /// Depth-0 reads awaiting commit; recorded into the coordinate Expando on
  /// block exit iff the declaration turns out eligible.
  final List<SimpleIdentifier> pendingReads = [];

  _Decl(this.name, this.node) : eligible = node != null;

  bool get isCandidate => node != null;
}

/// One modelled lexical scope on the resolver's stack.
class _Frame {
  /// True only for [Block] frames — the only frames that can hold slots.
  /// Declarations are recorded **only** into the innermost slottable frame;
  /// declarations whose innermost frame is opaque (e.g. a bare `var` directly
  /// inside a `switch` case with no block) are left untracked — hence
  /// unresolved — which is conservative but always sound.
  final bool slottable;

  /// Declarations in lexical order (drives compacted slot assignment).
  final List<_Decl> decls = [];

  /// name → declaration (first wins on same-frame shadowing).
  final Map<String, _Decl> byName = {};

  _Frame(this.slottable);

  _Decl? declOf(String name) => byName[name];

  void declare(String name, VariableDeclaration? node) {
    if (byName.containsKey(name)) return;
    final decl = _Decl(name, node);
    decls.add(decl);
    byName[name] = decl;
  }
}

/// Static lexical resolver (plan_3 §4.4 / §9 S1).
///
/// Walks the analyzer AST maintaining a stack of [_Frame]s that mirror the
/// interpreter's `Environment` nesting (via [opensLexicalFrame]). For every
/// identifier *use* whose declaration it can prove lives in the **innermost**
/// modelled scope (depth 0), it records a [StaticCoord] into [_coords]. All
/// other uses (cross-frame, parameters, top-level/global, bridge/prefixed/enum
/// names, anything ambiguous) are left unresolved and continue on the existing
/// name-keyed `Environment.get` path.
///
/// S1 deliberately emits **only depth-0** coordinates: an innermost-block local
/// is, by construction, at live depth 0 from any use in that same block, so the
/// runtime depth assert can never fire on a sound emission. Widening to
/// cross-frame depths is a later increment under the same harness.
class StaticResolver extends GeneralizingAstVisitor<void> {
  final Expando<StaticCoord> _coords;

  /// Side-table carrying the compacted slot index of each eligible
  /// *declaration* node (the analyzer's `VariableDeclaration` is sealed, so a
  /// field cannot be added — plan_3 §4.3). Populated on block exit; read by the
  /// interpreter at `visitVariableDeclarationList` to dual-write the slot.
  final Expando<int> _declSlots;

  final List<_Frame> _stack = [];

  /// True while resolving inside the body of the *nearest enclosing* function
  /// that is `async`, `async*`, or `sync*`. Slot eligibility is suppressed in
  /// such bodies (plan_3 §4.6, read-only first cut): the async/generator state
  /// machine delivers awaited values and re-entered loop variables through a
  /// back-channel (`callable.dart` resume: a direct `Environment.define` +
  /// speculative `assign` on the resumed frame) that does not flow through the
  /// declaration's `defineSlot`, so a slot would go stale. Tracks the *nearest*
  /// function (not a depth count) so a synchronous closure nested inside an
  /// async function re-enables slotting for its own body.
  bool _inAsyncFunction = false;

  StaticResolver(this._coords, this._declSlots);

  void _pushAndDescend(AstNode node, {required bool slottable}) {
    _stack.add(_Frame(slottable));
    node.visitChildren(this);
    _stack.removeLast();
  }

  /// Push a function frame, setting [_inAsyncFunction] to *this* function's
  /// async/generator-ness for the duration of its body (nearest-function wins),
  /// then restore the enclosing value on exit.
  void _descendFunction(AstNode node, FunctionBody body) {
    final saved = _inAsyncFunction;
    _inAsyncFunction = body.isAsynchronous || body.isGenerator;
    _stack.add(_Frame(false));
    node.visitChildren(this);
    _stack.removeLast();
    _inAsyncFunction = saved;
  }

  /// Records [name] in the innermost frame **iff** that frame is slottable.
  /// A declaration whose innermost frame is opaque is intentionally dropped
  /// (left unresolved) rather than leaked into an outer frame, which would
  /// risk a false depth-0. [node] is the slot-carrier (`null` for non-slot
  /// kinds, e.g. function names, which are tracked only for shadowing).
  void _declareLocal(String name, VariableDeclaration? node) {
    if (name == '_') return;
    if (_stack.isEmpty) return;
    final top = _stack.last;
    if (top.slottable) top.declare(name, node);
  }

  /// Resolve a block frame, then commit compacted slots (perf plan_3 §4.6):
  /// eligible candidate decls get dense indices `0..k-1` in lexical order, the
  /// declaration node records its slot in [_declSlots], and its pending depth-0
  /// reads receive a coordinate in [_coords].
  @override
  void visitBlock(Block node) {
    // A block inside an async/generator function body is non-slottable: its
    // locals can be rebound by the state-machine resume back-channel.
    final frame = _Frame(!_inAsyncFunction);
    _stack.add(frame);
    node.visitChildren(this);
    _stack.removeLast();

    var slot = 0;
    for (final decl in frame.decls) {
      if (!decl.isCandidate || !decl.eligible) continue;
      _declSlots[decl.node!] = slot;
      for (final use in decl.pendingReads) {
        _coords[use] = StaticCoord(0, slot);
      }
      slot++;
    }
  }

  @override
  void visitForStatement(ForStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitForElement(ForElement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitWhileStatement(WhileStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitDoStatement(DoStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitSwitchStatement(SwitchStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitSwitchExpression(SwitchExpression node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitCatchClause(CatchClause node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitFunctionExpression(FunctionExpression node) =>
      _descendFunction(node, node.body);

  @override
  void visitMethodDeclaration(MethodDeclaration node) =>
      _descendFunction(node, node.body);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) =>
      _descendFunction(node, node.body);

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    // Match the interpreter's executeBlock order: evaluate the initializer
    // BEFORE the name is in scope (so `var x = x` reads the outer `x`), then
    // declare the slot. Visiting only the initializer here (not the name node)
    // keeps the declaration identifier out of the use-resolution path.
    for (final v in node.variables.variables) {
      v.initializer?.accept(this);
      _declareLocal(v.name.lexeme, v);
    }
  }

  @override
  void visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    // Local function names are defined in declaration order by executeBlock.
    // Tracked with a null carrier (non-slot kind) so they shadow correctly but
    // are never slotted (a recursive/closed-over function reference is a
    // depth>0 use anyway → would be ineligible).
    _declareLocal(node.functionDeclaration.name.lexeme, null);
    node.functionDeclaration.accept(this);
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    // An assignment target (`x = …`, `x += …`) demotes the local out of slot
    // eligibility in this read-only first cut (S3e widens to `setSlot`). A
    // complex target (`a.b = …`, `a[i] = …`) is descended normally.
    final lhs = node.leftHandSide;
    if (lhs is SimpleIdentifier) {
      _useAssignTarget(lhs.name);
    } else {
      lhs.accept(this);
    }
    node.rightHandSide.accept(this);
  }

  @override
  void visitPrefixExpression(PrefixExpression node) {
    final operand = node.operand;
    final op = node.operator.lexeme;
    if ((op == '++' || op == '--') && operand is SimpleIdentifier) {
      _useAssignTarget(operand.name);
    } else {
      operand.accept(this);
    }
  }

  @override
  void visitPostfixExpression(PostfixExpression node) {
    final operand = node.operand;
    final op = node.operator.lexeme;
    if ((op == '++' || op == '--') && operand is SimpleIdentifier) {
      _useAssignTarget(operand.name);
    } else {
      operand.accept(this);
    }
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (_isVariableRead(node)) _useRead(node);
    // SimpleIdentifier has no children worth descending into for resolution.
  }

  /// Classify a bare identifier *read* against the frame stack. A depth-0 read
  /// of a candidate is queued for commit; a depth>0 read *escapes* the
  /// candidate (used from a nested frame → ineligible). Stops at the first
  /// declaring frame (shadowing); names not declared in any modelled frame
  /// (params, globals, bridged/enum/prefixed) stay unresolved → name path.
  void _useRead(SimpleIdentifier node) {
    final name = node.name;
    for (var depth = 0; depth < _stack.length; depth++) {
      final frame = _stack[_stack.length - 1 - depth];
      final decl = frame.declOf(name);
      if (decl == null) continue;
      if (decl.isCandidate) {
        if (depth == 0) {
          decl.pendingReads.add(node);
        } else {
          decl.eligible = false; // escaped: read from a nested frame
        }
      }
      return;
    }
  }

  /// Classify a bare identifier *assignment target*: demote the matching
  /// candidate to ineligible (read-only cut). Stops at the first declaring
  /// frame (shadowing).
  void _useAssignTarget(String name) {
    for (var depth = 0; depth < _stack.length; depth++) {
      final frame = _stack[_stack.length - 1 - depth];
      final decl = frame.declOf(name);
      if (decl == null) continue;
      if (decl.isCandidate) decl.eligible = false;
      return;
    }
  }

  /// True when [node] is a bare variable *read* — the only position for which
  /// the interpreter routes through `Environment.get` in `visitSimpleIdentifier`.
  /// Excludes declaration sites, member/method/label/type/constructor name
  /// positions, etc. Imperfect filtering is harmless for S1: a stray emission
  /// only ever annotates a node whose name genuinely *is* an innermost local,
  /// so the depth assert still holds.
  bool _isVariableRead(SimpleIdentifier node) {
    if (node.inDeclarationContext()) return false;
    final parent = node.parent;
    if (parent == null) return false;
    if (parent is PropertyAccess && identical(parent.propertyName, node)) {
      return false;
    }
    if (parent is PrefixedIdentifier && identical(parent.identifier, node)) {
      return false;
    }
    if (parent is MethodInvocation && identical(parent.methodName, node)) {
      return false;
    }
    if (parent is NamedExpression && identical(parent.name.label, node)) {
      return false;
    }
    if (parent is Label) return false;
    if (parent is ConstructorName) return false;
    if (parent is NamedType) return false;
    if (parent is TypeParameter) return false;
    if (parent is FormalParameter) return false;
    if (parent is Declaration) return false;
    if (parent is ConstructorFieldInitializer &&
        identical(parent.fieldName, node)) {
      return false;
    }
    return true;
  }
}
