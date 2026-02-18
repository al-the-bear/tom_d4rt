// Abstract category base classes mirroring the Dart analyzer's AST hierarchy.
// These provide type-safe intermediate types between SAstNode and concrete nodes.
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Level 1: Direct children of SAstNode
// ============================================================================

/// Base class for nodes that have documentation comments and metadata.
/// Mirrors analyzer's `AnnotatedNode`.
abstract class SAnnotatedNode extends SAstNode {
  /// Documentation comment, if any.
  List<SAnnotation> get metadata;
}

/// Base class for collection elements (expressions, spread, if/for elements, map entries).
/// Mirrors analyzer's `CollectionElement`.
abstract class SCollectionElement extends SAstNode {}

/// Base class for all statements.
/// Mirrors analyzer's `Statement`.
abstract class SStatement extends SAstNode {}

/// Base class for formal parameters.
/// Mirrors analyzer's `FormalParameter`.
abstract class SFormalParameter extends SAstNode {
  /// Whether this parameter is named.
  bool get isNamed;

  /// Whether this parameter is positional.
  bool get isPositional;

  /// Whether this parameter is required.
  bool get isRequired;

  /// Whether this parameter is optional.
  bool get isOptional;

  /// The name of the parameter, if any.
  String? get parameterName;
}

/// Base class for function bodies.
/// Mirrors analyzer's `FunctionBody`.
abstract class SFunctionBody extends SAstNode {
  /// Whether the function body is asynchronous.
  bool get isAsynchronous;

  /// Whether the function body is a generator.
  bool get isGenerator;

  /// Whether the function body is synchronous.
  bool get isSynchronous => !isAsynchronous;
}

/// Base class for type annotations.
/// Mirrors analyzer's `TypeAnnotation`.
abstract class STypeAnnotation extends SAstNode {
  /// Whether the type is nullable (has a trailing '?').
  bool get isNullable;
}

/// Base class for Dart patterns (Dart 3 pattern matching).
/// Mirrors analyzer's `DartPattern`.
abstract class SDartPattern extends SAstNode {}

/// Base class for show/hide combinators on directives.
/// Mirrors analyzer's `Combinator`.
abstract class SCombinator extends SAstNode {}

/// Base class for constructor initializers.
/// Mirrors analyzer's `ConstructorInitializer`.
abstract class SConstructorInitializer extends SAstNode {}

/// Base class for switch case/default members.
/// Mirrors analyzer's `SwitchMember`.
abstract class SSwitchMember extends SAstNode {
  /// The statements in this switch member.
  List<SStatement> get statements;
}

/// Base class for string interpolation elements.
/// Mirrors analyzer's `InterpolationElement`.
abstract class SInterpolationElement extends SAstNode {}

/// Base class for for-loop parts.
/// Mirrors analyzer's `ForLoopParts`.
abstract class SForLoopParts extends SAstNode {}

// ============================================================================
// Level 2: Sub-categories
// ============================================================================

/// Base class for all expressions. Extends CollectionElement because
/// expressions can appear in collection literals.
/// Mirrors analyzer's `Expression`.
abstract class SExpression extends SCollectionElement {}

/// Base class for all declarations.
/// Mirrors analyzer's `Declaration`.
abstract class SDeclaration extends SAnnotatedNode {}

/// Base class for all directives (import, export, part, library).
/// Mirrors analyzer's `Directive`.
abstract class SDirective extends SAnnotatedNode {}

/// Base class for normal (non-default) formal parameters.
/// Mirrors analyzer's `NormalFormalParameter`.
abstract class SNormalFormalParameter extends SFormalParameter {}

/// Base class for for-each loop parts.
/// Mirrors analyzer's `ForEachParts`.
abstract class SForEachParts extends SForLoopParts {}

/// Base class for traditional for-loop parts.
/// Mirrors analyzer's `ForParts`.
abstract class SForParts extends SForLoopParts {}

/// Base class for variable patterns.
/// Mirrors analyzer's `VariablePattern`.
abstract class SVariablePattern extends SDartPattern {
  /// The variable name.
  String get variableName;
}

/// Base class for uri-based directives (import, export, part).
/// Mirrors analyzer's `UriBasedDirective`.
abstract class SUriBasedDirective extends SDirective {}

/// Base class for namespace directives (import, export).
/// Mirrors analyzer's `NamespaceDirective`.
abstract class SNamespaceDirective extends SUriBasedDirective {}

// ============================================================================
// Level 3: Deeper sub-categories
// ============================================================================

/// Base class for class members (methods, fields, constructors).
/// Mirrors analyzer's `ClassMember`.
abstract class SClassMember extends SDeclaration {}

/// Base class for compilation unit members (top-level declarations).
/// Mirrors analyzer's `CompilationUnitMember`.
abstract class SCompilationUnitMember extends SDeclaration {}

/// Base class for all literals.
/// Mirrors analyzer's `Literal`.
abstract class SLiteral extends SExpression {}

/// Base class for identifiers (simple and prefixed).
/// Mirrors analyzer's `Identifier`.
abstract class SIdentifier extends SExpression {
  /// The name of the identifier.
  String get identifierName;
}

/// Base class for invocation expressions (method calls, function calls).
/// Mirrors analyzer's `InvocationExpression`.
abstract class SInvocationExpression extends SExpression {
  /// The argument list.
  SArgumentList get argumentList;
}

// ============================================================================
// Level 4: Deepest sub-categories
// ============================================================================

/// Base class for named compilation unit members.
/// Mirrors analyzer's `NamedCompilationUnitMember`.
abstract class SNamedCompilationUnitMember extends SCompilationUnitMember {}

/// Base class for typed literals (list, set/map).
/// Mirrors analyzer's `TypedLiteral`.
abstract class STypedLiteral extends SLiteral {
  /// Whether this literal has a const keyword.
  bool get isConst;

  /// The type arguments, if any.
  STypeArgumentList? get typeArguments;
}

/// Base class for string literals.
/// Mirrors analyzer's `StringLiteral`.
abstract class SStringLiteral extends SLiteral {
  /// The value of this string literal, or null if it contains interpolations
  /// that cannot be statically evaluated.
  String? get stringValue;
}

/// Base class for single string literals (non-adjacent).
/// Mirrors analyzer's `SingleStringLiteral`.
abstract class SSingleStringLiteral extends SStringLiteral {
  /// Whether this is a multiline string.
  bool get isMultiline;

  /// Whether this is a raw string.
  bool get isRaw;
}
