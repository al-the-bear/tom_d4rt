// Static lexical scope resolver for the serializable AST (perf plan_3 §9 S1/S2).
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

/// Does [node] open a new runtime `Environment` frame?
///
/// This is the **shared scope-frame predicate** (plan_3 §4.4, risk R1): the
/// single decision the resolver and the interpreter must agree on. It is
/// deliberately **over-approximating** — it may return `true` for a construct
/// the interpreter happens not to wrap in its own frame. Over-approximation is
/// safe for the depth-0 resolver: modelling an *extra* frame only ever raises a
/// computed depth (suppressing a coordinate), never lowers it, so it can never
/// manufacture a false depth-0. Under-approximation (missing a frame the
/// interpreter *does* push) is the unsafe direction and is what this list guards
/// against by erring generous.
bool opensLexicalFrame(SAstNode node) {
  return node is SBlock ||
      node is SForStatement ||
      node is SForElement ||
      node is SWhileStatement ||
      node is SDoStatement ||
      node is SSwitchStatement ||
      node is SSwitchExpression ||
      node is SCatchClause ||
      node is SFunctionExpression ||
      node is SMethodDeclaration ||
      node is SConstructorDeclaration;
}

/// One modelled local declaration on a resolver frame.
///
/// A declaration is a **slot candidate** iff [node] is non-null (only plain
/// `var`/`final` locals declared directly in a slottable [SBlock] qualify; local
/// function names are recorded with a null [node] so they correctly *shadow*
/// outer same-named locals but are never themselves slotted). A candidate stays
/// [eligible] until a depth>0 use (escape) or an assignment-target use demotes
/// it; only eligible candidates receive a compacted slot on block exit.
class _Decl {
  final String name;

  /// The declaration node to annotate with `declSlot`, or `null` for non-slot
  /// kinds (function names) which are tracked only for shadowing.
  final SVariableDeclaration? node;

  bool eligible;

  /// Depth-0 reads awaiting commit; annotated with `resolvedSlot` on block exit
  /// iff the declaration turns out eligible.
  final List<SSimpleIdentifier> pendingReads = [];

  _Decl(this.name, this.node) : eligible = node != null;

  bool get isCandidate => node != null;
}

/// One modelled lexical scope on the resolver's stack.
class _ScopeFrame {
  /// True only for [SBlock] frames — the only frames that can hold slots.
  /// Declarations are recorded **only** into the innermost slottable frame;
  /// declarations whose innermost frame is opaque (e.g. a bare `var` directly
  /// inside a `switch` case with no block) are left untracked — hence
  /// unresolved — which is conservative but always sound.
  final bool slottable;

  /// Declarations in lexical order (drives compacted slot assignment).
  final List<_Decl> decls = [];

  /// name → declaration (first wins on same-frame shadowing).
  final Map<String, _Decl> byName = {};

  _ScopeFrame(this.slottable);

  _Decl? declOf(String name) => byName[name];

  void declare(String name, SVariableDeclaration? node) {
    if (byName.containsKey(name)) return;
    final decl = _Decl(name, node);
    decls.add(decl);
    byName[name] = decl;
  }
}

/// Static lexical resolver (plan_3 §4.4 / §9 S1–S2), operating directly on the
/// serializable mirror AST.
///
/// Walks the AST maintaining a stack of [_ScopeFrame]s that mirror the
/// interpreter's `Environment` nesting (via [opensLexicalFrame]). For every
/// identifier *use* whose declaration it can prove lives in the **innermost**
/// modelled scope (depth 0), it writes the coordinate **onto the node**
/// ([SSimpleIdentifier.resolvedDepth] / [SSimpleIdentifier.resolvedSlot]) so it
/// serializes into the bundle (analyzer-free Flutter precompute target). All
/// other uses (cross-frame, parameters, top-level/global, bridge/prefixed/enum
/// names, anything ambiguous) are left unresolved and continue on the existing
/// name-keyed `Environment.get` path.
///
/// S1/S2 deliberately emit **only depth-0** coordinates: an innermost-block
/// local is, by construction, at live depth 0 from any use in that same block,
/// so the runtime depth assert can never fire on a sound emission. Widening to
/// cross-frame depths is a later increment (S3) under the same harness.
///
/// The mirror AST has no `.parent` back-pointer, so an analyzer-style
/// parent-based use-filter is not possible here. That filtering is a pure
/// optimisation (it avoids annotating inert nodes), not a correctness
/// requirement: emission is conditioned on the name matching an innermost-block
/// local, and any such match is at live depth 0 regardless of the node's
/// syntactic role — so the depth assert holds. The single cheap filter kept is
/// [SSimpleIdentifier.inDeclarationContext], which excludes declaration sites.
class StaticResolver extends GeneralizingSAstVisitor<void> {
  final List<_ScopeFrame> _stack = [];

  StaticResolver();

  /// Resolve every identifier use under [declarations], writing coordinates
  /// onto the nodes. Idempotent: re-running recomputes the same coordinates.
  void resolve(Iterable<SAstNode> declarations) {
    for (final declaration in declarations) {
      declaration.accept(this);
    }
  }

  /// Default descent. Unlike the analyzer's `GeneralizingAstVisitor`, the mirror
  /// [GeneralizingSAstVisitor.visitNode] returns without recursing, so an
  /// un-overridden node would halt the walk. Recurse into children here so the
  /// resolver reaches nested blocks and identifier uses.
  @override
  void visitNode(SAstNode node) => node.visitChildren(this);

  void _pushAndDescend(SAstNode node, {required bool slottable}) {
    _stack.add(_ScopeFrame(slottable));
    node.visitChildren(this);
    _stack.removeLast();
  }

  /// Records [name] in the innermost frame **iff** that frame is slottable.
  /// A declaration whose innermost frame is opaque is intentionally dropped
  /// (left unresolved) rather than leaked into an outer frame, which would risk
  /// a false depth-0. [node] is the slot-carrier (`null` for non-slot kinds,
  /// e.g. function names, which are tracked only for shadowing).
  void _declareLocal(String name, SVariableDeclaration? node) {
    if (name == '_') return;
    if (_stack.isEmpty) return;
    final top = _stack.last;
    if (top.slottable) top.declare(name, node);
  }

  /// Resolve a block frame, then commit compacted slots (perf plan_3 §4.6):
  /// eligible candidate decls get dense indices `0..k-1` in lexical order, their
  /// pending depth-0 reads get `resolvedSlot`, and the block records `slotCount`.
  @override
  void visitBlock(SBlock node) {
    final frame = _ScopeFrame(true);
    _stack.add(frame);
    node.visitChildren(this);
    _stack.removeLast();

    var slot = 0;
    for (final decl in frame.decls) {
      if (!decl.isCandidate || !decl.eligible) continue;
      decl.node!.declSlot = slot;
      for (final use in decl.pendingReads) {
        use.resolvedDepth = 0;
        use.resolvedSlot = slot;
      }
      slot++;
    }
    node.slotCount = slot;
  }

  @override
  void visitForStatement(SForStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitForElement(SForElement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitWhileStatement(SWhileStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitDoStatement(SDoStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitSwitchStatement(SSwitchStatement node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitSwitchExpression(SSwitchExpression node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitCatchClause(SCatchClause node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitFunctionExpression(SFunctionExpression node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitMethodDeclaration(SMethodDeclaration node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitConstructorDeclaration(SConstructorDeclaration node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitVariableDeclarationStatement(SVariableDeclarationStatement node) {
    // Match the interpreter's executeBlock order: evaluate the initializer
    // BEFORE the name is in scope (so `var x = x` reads the outer `x`), then
    // declare the slot. Visiting only the initializer here (not the name node)
    // keeps the declaration identifier out of the use-resolution path.
    for (final v in node.variables?.variables ?? const []) {
      v.initializer?.accept(this);
      final name = v.name?.name;
      if (name != null) _declareLocal(name, v);
    }
  }

  @override
  void visitFunctionDeclarationStatement(SFunctionDeclarationStatement node) {
    // Local function names are defined in declaration order by executeBlock.
    // Tracked with a null carrier (non-slot kind) so they shadow correctly but
    // are never slotted (a recursive/closed-over function reference is a
    // depth>0 use anyway → would be ineligible).
    final name = node.functionDeclaration.name?.name;
    if (name != null) _declareLocal(name, null);
    node.functionDeclaration.accept(this);
  }

  @override
  void visitAssignmentExpression(SAssignmentExpression node) {
    // An assignment target (`x = …`, `x += …`) demotes the local out of slot
    // eligibility in this read-only first cut (S3d widens to `setSlot`). A
    // complex target (`a.b = …`, `a[i] = …`) is descended normally.
    final lhs = node.leftHandSide;
    if (lhs is SSimpleIdentifier) {
      _useAssignTarget(lhs.name);
    } else {
      lhs?.accept(this);
    }
    node.rightHandSide?.accept(this);
  }

  @override
  void visitPrefixExpression(SPrefixExpression node) {
    final operand = node.operand;
    if ((node.operator == '++' || node.operator == '--') &&
        operand is SSimpleIdentifier) {
      _useAssignTarget(operand.name);
    } else {
      operand?.accept(this);
    }
  }

  @override
  void visitPostfixExpression(SPostfixExpression node) {
    final operand = node.operand;
    if ((node.operator == '++' || node.operator == '--') &&
        operand is SSimpleIdentifier) {
      _useAssignTarget(operand.name);
    } else {
      operand?.accept(this);
    }
  }

  @override
  void visitSimpleIdentifier(SSimpleIdentifier node) {
    if (!node.inDeclarationContext) _useRead(node);
    // SSimpleIdentifier has no children worth descending into for resolution.
  }

  /// Classify a bare identifier *read* against the frame stack. A depth-0 read
  /// of a candidate is queued for commit; a depth>0 read *escapes* the
  /// candidate (used from a nested frame → ineligible). Stops at the first
  /// declaring frame (shadowing); names not declared in any modelled frame
  /// (params, globals, bridged/enum/prefixed) stay unresolved → name path.
  void _useRead(SSimpleIdentifier node) {
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
}
