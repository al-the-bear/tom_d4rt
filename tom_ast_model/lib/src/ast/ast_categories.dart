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

/// Base class for formal parameters. Mirrors analyzer's `FormalParameter`,
/// which holds every parameter's fields itself: the kind subclasses
/// ([SRegularFormalParameter], [SFieldFormalParameter],
/// [SSuperFormalParameter]) add nothing but their kind.
abstract class SFormalParameter extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The parameter's name; null only in invalid code.
  final SSimpleIdentifier? name;

  /// The declared type, or for a function-typed parameter its return type.
  final STypeAnnotation? type;
  final List<SAnnotation> metadata;
  final bool isConst;
  final bool isFinal;
  final bool isCovariant;

  /// A positional parameter outside `[]`, or a named one marked `required`.
  final bool isRequired;

  /// Whether the parameter is declared inside `{}`.
  final bool isNamed;

  /// `= value`, when the parameter declares a default.
  final SFormalParameterDefaultClause? defaultClause;

  /// `(params)` after the name of a function-typed parameter.
  final SFunctionTypedFormalParameterSuffix? functionTypedSuffix;

  SFormalParameter({
    required this.offset,
    required this.length,
    this.name,
    this.type,
    this.metadata = const [],
    this.isConst = false,
    this.isFinal = false,
    this.isCovariant = false,
    this.isRequired = true,
    this.isNamed = false,
    this.defaultClause,
    this.functionTypedSuffix,
  });

  bool get isPositional => !isNamed;
  bool get isOptional => !isRequired;
  bool get isRequiredPositional => isRequired && !isNamed;
  bool get isOptionalPositional => !isRequired && !isNamed;
  bool get isRequiredNamed => isRequired && isNamed;
  bool get isOptionalNamed => !isRequired && isNamed;

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (type != null) 'type': type!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isConst': isConst,
    'isFinal': isFinal,
    'isCovariant': isCovariant,
    'isRequired': isRequired,
    'isNamed': isNamed,
    if (defaultClause != null) 'defaultClause': defaultClause!.toJson(),
    if (functionTypedSuffix != null)
      'functionTypedSuffix': functionTypedSuffix!.toJson(),
  };

  /// The fields every kind reads back the same way.
  static ({
    int offset,
    int length,
    SSimpleIdentifier? name,
    STypeAnnotation? type,
    List<SAnnotation> metadata,
    bool isConst,
    bool isFinal,
    bool isCovariant,
    bool isRequired,
    bool isNamed,
    SFormalParameterDefaultClause? defaultClause,
    SFunctionTypedFormalParameterSuffix? functionTypedSuffix,
  })
  _fieldsFromJson(Map<String, dynamic> json) => (
    offset: json['offset'] as int,
    length: json['length'] as int,
    name: json['name'] != null
        ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
        : null,
    type:
        SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
            as STypeAnnotation?,
    metadata:
        (json['metadata'] as List?)
            ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
            .toList() ??
        <SAnnotation>[],
    isConst: json['isConst'] as bool? ?? false,
    isFinal: json['isFinal'] as bool? ?? false,
    isCovariant: json['isCovariant'] as bool? ?? false,
    isRequired: json['isRequired'] as bool? ?? true,
    isNamed: json['isNamed'] as bool? ?? false,
    defaultClause: json['defaultClause'] != null
        ? SFormalParameterDefaultClause.fromJson(
            json['defaultClause'] as Map<String, dynamic>,
          )
        : null,
    functionTypedSuffix: json['functionTypedSuffix'] != null
        ? SFunctionTypedFormalParameterSuffix.fromJson(
            json['functionTypedSuffix'] as Map<String, dynamic>,
          )
        : null,
  );

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    type?.accept(visitor);
    name?.accept(visitor);
    functionTypedSuffix?.accept(visitor);
    defaultClause?.accept(visitor);
  }
}

/// An entry of an argument list: an expression or a [SNamedArgument].
/// Mirrors analyzer's `Argument`.
abstract interface class SArgument implements SAstNode {}

/// A field of a record literal: an expression or a
/// [SRecordLiteralNamedField]. Mirrors analyzer's `RecordLiteralField`.
abstract interface class SRecordLiteralField implements SAstNode {}

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
  /// The labels before this switch member, for `continue <label>`.
  List<SLabel> get labels;

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
abstract class SExpression extends SCollectionElement
    implements SArgument, SRecordLiteralField {}

/// Base class for all declarations.
/// Mirrors analyzer's `Declaration`.
abstract class SDeclaration extends SAnnotatedNode {}

/// Base class for all directives (import, export, part, library).
/// Mirrors analyzer's `Directive`.
abstract class SDirective extends SAnnotatedNode {}

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
  SArgumentList? get argumentList;
}

// ============================================================================
// Level 4: Deepest sub-categories
// ============================================================================

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
