/// Collects a bundle's static facts from the analyzer's resolved units
/// (ghissues69, GitHub #18 option 3). See `SStaticFacts` in tom_ast_model
/// for what a fact is, and doc/resolved_bundles.md for how a runtime uses
/// them.
library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:tom_ast_model/tom_ast_model.dart';

/// Records the facts of resolved units into one [SStaticFactsBuilder].
///
/// Which node a fact is keyed by (its `offset:length` in its module):
///
/// * an extension member access - the [MethodInvocation], [PropertyAccess],
///   [PrefixedIdentifier], [IndexExpression], [BinaryExpression] or
///   [PrefixExpression] that reaches the member; for an assignment to an
///   extension setter, its left-hand side. Only an access with an explicit
///   receiver is recorded (inside an extension, `this` is the receiver it was
///   called on);
/// * inferred type arguments - the generic [MethodInvocation] or
///   [FunctionExpressionInvocation], the [InstanceCreationExpression] or the
///   [ListLiteral] / [SetOrMapLiteral] that does not write them. A node that
///   is both (a generic extension method called without type arguments)
///   keeps the extension fact.
///
/// A type the facts cannot name - one that did not resolve, e.g. from a
/// library that exists only at run time and has no stub - leaves its node
/// without a fact.
class StaticFactsCollector {
  final SStaticFactsBuilder _facts = SStaticFactsBuilder();

  /// `<module> <offset:length>` of every node that has a fact.
  final Set<String> _recorded = {};

  /// Records [fact] for [node] of [moduleUri]; a node keeps the first fact
  /// recorded for it (the extension fact is recorded first).
  void _add(String moduleUri, AstNode node, SStaticFact fact) {
    if (!_recorded.add('$moduleUri ${node.offset}:${node.length}')) return;
    _facts.add(moduleUri, node.offset, node.length, fact);
  }

  /// The libraries the recorded types come from (`package:` and `dart:`
  /// URIs), for the stamp.
  final Set<String> typeLibraries = {};

  /// Records the facts of [unit], the resolved unit of the module [moduleUri].
  void collect(String moduleUri, CompilationUnit unit) {
    unit.accept(_FactsVisitor(this, moduleUri));
  }

  /// Whether no fact was recorded.
  bool get isEmpty => _facts.isEmpty;

  /// The table, stamped with [stamp].
  SStaticFacts build(SFactsStamp stamp) => _facts.build(stamp);

  /// The interned index of [type], or null when it cannot be named.
  int? _type(DartType? type) {
    final fact = _factType(type);
    return fact == null ? null : _facts.intern(fact);
  }

  SFactType? _factType(DartType? type) {
    if (type == null || type is InvalidType) return null;
    final nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    switch (type) {
      case DynamicType():
        return const SFactType(kind: SFactTypeKind.dynamicType);
      case VoidType():
        return const SFactType(kind: SFactTypeKind.voidType);
      case NeverType():
        return SFactType(kind: SFactTypeKind.neverType, nullable: nullable);
      case TypeParameterType():
        return SFactType(
          kind: SFactTypeKind.typeParameter,
          name: type.element.name,
          nullable: nullable,
        );
      case InterfaceType():
        final library = type.element.library.uri.toString();
        final arguments = <int>[];
        for (final argument in type.typeArguments) {
          final index = _type(argument);
          if (index == null) return null;
          arguments.add(index);
        }
        typeLibraries.add(library);
        return SFactType(
          kind: SFactTypeKind.interface,
          libraryUri: library,
          name: type.element.name,
          typeArguments: arguments,
          nullable: nullable,
        );
      case FunctionType():
        return SFactType(
          kind: SFactTypeKind.function,
          display: type.getDisplayString(),
          nullable: nullable,
        );
      case RecordType():
        return SFactType(
          kind: SFactTypeKind.record,
          display: type.getDisplayString(),
          nullable: nullable,
        );
      default:
        return null;
    }
  }

  void _extensionCall(
    String moduleUri,
    AstNode node,
    Element? member,
    Expression? receiver,
  ) {
    final extension = member?.enclosingElement;
    if (extension is! ExtensionElement || receiver == null) return;
    final receiverType = receiver.staticType;
    final receiverIndex = _type(receiverType);
    if (receiverIndex == null) return;
    final arguments = <int>[];
    for (final argument in _extensionTypeArguments(extension, receiverType!)) {
      final index = _type(argument);
      if (index == null) return;
      arguments.add(index);
    }
    final library = extension.library.uri.toString();
    _add(
      moduleUri,
      node,
      SExtensionCallFact(
        receiverType: receiverIndex,
        extensionLibraryUri: library,
        extensionName: extension.name,
        typeArguments: arguments,
      ),
    );
  }

  /// The extension's type arguments for [receiver]: its `on` type matched
  /// against the receiver's static type (as Dart infers them), `dynamic` for
  /// a type parameter the match does not determine.
  List<DartType> _extensionTypeArguments(
    ExtensionElement extension,
    DartType receiver,
  ) {
    final parameters = extension.typeParameters;
    if (parameters.isEmpty) return const [];
    final bound = <TypeParameterElement, DartType>{};
    void match(DartType pattern, DartType actual) {
      if (pattern is TypeParameterType &&
          parameters.contains(pattern.element)) {
        bound.putIfAbsent(pattern.element, () => actual);
        return;
      }
      if (pattern is InterfaceType && actual is InterfaceType) {
        final instance = actual.asInstanceOf(pattern.element);
        if (instance == null) return;
        for (var i = 0; i < pattern.typeArguments.length; i++) {
          if (i < instance.typeArguments.length) {
            match(pattern.typeArguments[i], instance.typeArguments[i]);
          }
        }
      }
    }

    match(extension.extendedType, receiver);
    final dynamicType = extension.library.typeProvider.dynamicType;
    return [for (final p in parameters) bound[p] ?? dynamicType];
  }

  void _typeArguments(String moduleUri, AstNode node, List<DartType>? types) {
    if (types == null || types.isEmpty) return;
    final arguments = <int>[];
    for (final type in types) {
      final index = _type(type);
      if (index == null) return;
      arguments.add(index);
    }
    _add(moduleUri, node, STypeArgumentsFact(arguments));
  }
}

class _FactsVisitor extends RecursiveAstVisitor<void> {
  final StaticFactsCollector _collector;
  final String _module;

  _FactsVisitor(this._collector, this._module);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    _collector._extensionCall(
      _module,
      node,
      node.methodName.element,
      node.realTarget,
    );
    if (node.typeArguments == null) {
      _collector._typeArguments(_module, node, node.typeArgumentTypes);
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    if (node.typeArguments == null) {
      _collector._typeArguments(_module, node, node.typeArgumentTypes);
    }
    super.visitFunctionExpressionInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    _collector._extensionCall(
      _module,
      node,
      node.propertyName.element,
      node.realTarget,
    );
    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    _collector._extensionCall(
      _module,
      node,
      node.identifier.element,
      node.prefix.element is PrefixElement ? null : node.prefix,
    );
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitIndexExpression(IndexExpression node) {
    _collector._extensionCall(_module, node, node.element, node.realTarget);
    super.visitIndexExpression(node);
  }

  @override
  void visitBinaryExpression(BinaryExpression node) {
    _collector._extensionCall(_module, node, node.element, node.leftOperand);
    super.visitBinaryExpression(node);
  }

  @override
  void visitPrefixExpression(PrefixExpression node) {
    _collector._extensionCall(_module, node, node.element, node.operand);
    super.visitPrefixExpression(node);
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    final target = node.leftHandSide;
    final receiver = switch (target) {
      PropertyAccess() => target.realTarget,
      PrefixedIdentifier() =>
        target.prefix.element is PrefixElement ? null : target.prefix,
      IndexExpression() => target.realTarget,
      _ => null,
    };
    _collector._extensionCall(_module, target, node.writeElement, receiver);
    super.visitAssignmentExpression(node);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.staticType;
    if (node.constructorName.type.typeArguments == null &&
        type is InterfaceType) {
      _collector._typeArguments(_module, node, type.typeArguments);
    }
    super.visitInstanceCreationExpression(node);
  }

  @override
  void visitListLiteral(ListLiteral node) {
    final type = node.staticType;
    if (node.typeArguments == null && type is InterfaceType) {
      _collector._typeArguments(_module, node, type.typeArguments);
    }
    super.visitListLiteral(node);
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    final type = node.staticType;
    if (node.typeArguments == null && type is InterfaceType) {
      _collector._typeArguments(_module, node, type.typeArguments);
    }
    super.visitSetOrMapLiteral(node);
  }
}
