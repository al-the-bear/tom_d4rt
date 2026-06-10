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

/// One modelled lexical scope on the resolver's stack.
class _ScopeFrame {
  /// True only for [SBlock] frames. Declarations are slotted **only** into the
  /// innermost slottable frame; declarations whose innermost frame is opaque
  /// (e.g. a bare `var` directly inside a `switch` case with no block) are left
  /// unslotted — hence unresolved — which is conservative but always sound.
  final bool slottable;

  /// name → slot index, in declaration order. Empty for opaque frames.
  final Map<String, int> slots = {};

  int _nextSlot = 0;

  _ScopeFrame(this.slottable);

  int? slotOf(String name) => slots[name];

  void declare(String name) {
    slots.putIfAbsent(name, () => _nextSlot++);
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

  /// Slots [name] into the innermost frame **iff** that frame is slottable.
  /// A declaration whose innermost frame is opaque is intentionally dropped
  /// (left unresolved) rather than leaked into an outer frame, which would risk
  /// a false depth-0.
  void _declareLocal(String name) {
    if (name == '_') return;
    if (_stack.isEmpty) return;
    final top = _stack.last;
    if (top.slottable) top.declare(name);
  }

  @override
  void visitBlock(SBlock node) => _pushAndDescend(node, slottable: true);

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
      if (name != null) _declareLocal(name);
    }
  }

  @override
  void visitFunctionDeclarationStatement(SFunctionDeclarationStatement node) {
    // Local function names are defined in declaration order by executeBlock.
    final name = node.functionDeclaration.name?.name;
    if (name != null) _declareLocal(name);
    node.functionDeclaration.accept(this);
  }

  @override
  void visitSimpleIdentifier(SSimpleIdentifier node) {
    if (!node.inDeclarationContext) {
      final name = node.name;
      for (var depth = 0; depth < _stack.length; depth++) {
        final frame = _stack[_stack.length - 1 - depth];
        final slot = frame.slotOf(name);
        if (slot != null) {
          // Only the innermost scope (depth 0) is emitted in S1/S2 — sound by
          // construction. Stop either way so an outer same-name declaration
          // never produces a spurious coordinate.
          if (depth == 0) {
            node.resolvedDepth = 0;
            node.resolvedSlot = slot;
          }
          break;
        }
      }
    }
    // SSimpleIdentifier has no children worth descending into for resolution.
  }
}
