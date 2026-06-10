import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Statically-resolved lexical coordinate of an identifier *use*.
///
/// Produced by [StaticResolver] (perf plan_3 §4, sub-step S1) and carried on
/// the analyzer AST via an [Expando] side-table (the analyzer's
/// `SimpleIdentifier` is sealed/immutable, so a field cannot be added — see
/// plan_3 §4.3). [depth] is the number of enclosing `Environment` hops from the
/// use's runtime scope to the declaring scope; [slot] is the declaration index
/// within that scope (declaration order). In S1 only [depth] is validated at
/// runtime (against [Environment.resolveDepthOf]); [slot] is computed now so
/// that S3 can index per-frame slot arrays without re-resolving.
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

/// One modelled lexical scope on the resolver's stack.
class _Frame {
  /// True only for [Block] frames. Declarations are slotted **only** into the
  /// innermost slottable frame; declarations whose innermost frame is opaque
  /// (e.g. a bare `var` directly inside a `switch` case with no block) are left
  /// unslotted — hence unresolved — which is conservative but always sound.
  final bool slottable;

  /// name → slot index, in declaration order. Empty for opaque frames.
  final Map<String, int> slots = {};

  int _nextSlot = 0;

  _Frame(this.slottable);

  int? slotOf(String name) => slots[name];

  void declare(String name) {
    slots.putIfAbsent(name, () => _nextSlot++);
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
  final List<_Frame> _stack = [];

  StaticResolver(this._coords);

  void _pushAndDescend(AstNode node, {required bool slottable}) {
    _stack.add(_Frame(slottable));
    node.visitChildren(this);
    _stack.removeLast();
  }

  /// Slots [name] into the innermost frame **iff** that frame is slottable.
  /// A declaration whose innermost frame is opaque is intentionally dropped
  /// (left unresolved) rather than leaked into an outer frame, which would
  /// risk a false depth-0.
  void _declareLocal(String name) {
    if (name == '_') return;
    if (_stack.isEmpty) return;
    final top = _stack.last;
    if (top.slottable) top.declare(name);
  }

  @override
  void visitBlock(Block node) => _pushAndDescend(node, slottable: true);

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
      _pushAndDescend(node, slottable: false);

  @override
  void visitMethodDeclaration(MethodDeclaration node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) =>
      _pushAndDescend(node, slottable: false);

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    // Match the interpreter's executeBlock order: evaluate the initializer
    // BEFORE the name is in scope (so `var x = x` reads the outer `x`), then
    // declare the slot. Visiting only the initializer here (not the name node)
    // keeps the declaration identifier out of the use-resolution path.
    for (final v in node.variables.variables) {
      v.initializer?.accept(this);
      _declareLocal(v.name.lexeme);
    }
  }

  @override
  void visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    // Local function names are defined in declaration order by executeBlock.
    _declareLocal(node.functionDeclaration.name.lexeme);
    node.functionDeclaration.accept(this);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (_isVariableRead(node)) {
      final name = node.name;
      for (var depth = 0; depth < _stack.length; depth++) {
        final frame = _stack[_stack.length - 1 - depth];
        final slot = frame.slotOf(name);
        if (slot != null) {
          // Only the innermost scope (depth 0) is emitted in S1 — sound by
          // construction. Stop either way so an outer same-name declaration
          // never produces a spurious coordinate.
          if (depth == 0) _coords[node] = StaticCoord(0, slot);
          break;
        }
      }
    }
    // SimpleIdentifier has no children worth descending into for resolution.
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
