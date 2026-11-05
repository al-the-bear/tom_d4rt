// Serializable AST declarations
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Declaration base and common patterns
// ============================================================================

/// Mixin for named declarations
mixin SNamedDeclaration on SAstNode {
  SSimpleIdentifier? get name;
  List<SAnnotation> get metadata;
}

/// Mixin for declarations with a function body
mixin SFunctionBodyOwner on SAstNode {
  SFunctionBody? get body; // BlockFunctionBody, ExpressionFunctionBody, etc.
}

// ============================================================================
// Function Declaration
// ============================================================================

class SFunctionDeclaration extends SCompilationUnitMember
    with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// Return type annotation
  final STypeAnnotation? returnType;

  /// Whether this is a getter
  final bool isGetter;

  /// Whether this is a setter
  final bool isSetter;

  /// Whether external
  final bool isExternal;

  /// Type parameters (generics)
  final STypeParameterList? typeParameters;

  /// The function expression (parameters and body)
  final SFunctionExpression? functionExpression;

  SFunctionDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.returnType,
    this.isGetter = false,
    this.isSetter = false,
    this.isExternal = false,
    this.typeParameters,
    this.functionExpression,
  });

  @override
  String get nodeType => 'FunctionDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (returnType != null) 'returnType': returnType!.toJson(),
    'isGetter': isGetter,
    'isSetter': isSetter,
    'isExternal': isExternal,
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (functionExpression != null)
      'functionExpression': functionExpression!.toJson(),
  };

  factory SFunctionDeclaration.fromJson(Map<String, dynamic> json) {
    return SFunctionDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      returnType:
          SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      isGetter: json['isGetter'] as bool? ?? false,
      isSetter: json['isSetter'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>,
            )
          : null,
      functionExpression: json['functionExpression'] != null
          ? SFunctionExpression.fromJson(
              json['functionExpression'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFunctionDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    returnType?.accept(visitor);
    typeParameters?.accept(visitor);
    functionExpression?.accept(visitor);
  }
}

// ============================================================================
// Method Declaration
// ============================================================================

class SMethodDeclaration extends SClassMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// Return type annotation
  final STypeAnnotation? returnType;

  /// Method modifiers
  final bool isStatic;
  final bool isAbstract;
  final bool isExternal;
  final bool isGetter;
  final bool isSetter;
  final bool isOperator;

  /// Type parameters
  final STypeParameterList? typeParameters;

  /// Parameters
  final SFormalParameterList? parameters;

  /// Method body
  final SFunctionBody? body;

  SMethodDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.returnType,
    this.isStatic = false,
    this.isAbstract = false,
    this.isExternal = false,
    this.isGetter = false,
    this.isSetter = false,
    this.isOperator = false,
    this.typeParameters,
    this.parameters,
    this.body,
  });

  @override
  String get nodeType => 'MethodDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (returnType != null) 'returnType': returnType!.toJson(),
    'isStatic': isStatic,
    'isAbstract': isAbstract,
    'isExternal': isExternal,
    'isGetter': isGetter,
    'isSetter': isSetter,
    'isOperator': isOperator,
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    if (body != null) 'body': body!.toJson(),
  };

  factory SMethodDeclaration.fromJson(Map<String, dynamic> json) {
    return SMethodDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      returnType:
          SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      isStatic: json['isStatic'] as bool? ?? false,
      isAbstract: json['isAbstract'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      isGetter: json['isGetter'] as bool? ?? false,
      isSetter: json['isSetter'] as bool? ?? false,
      isOperator: json['isOperator'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>,
            )
          : null,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>,
            )
          : null,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SFunctionBody?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMethodDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    returnType?.accept(visitor);
    typeParameters?.accept(visitor);
    parameters?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Class Declaration
// ============================================================================

/// A class declaration. Mirrors analyzer's `ClassDeclaration`.
class SClassDeclaration extends SCompilationUnitMember {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;

  /// Class modifiers
  final bool isAbstract;
  final bool isSealed;
  final bool isBase;
  final bool isInterface;
  final bool isFinal;
  final bool isMixin;

  /// The name and type parameters.
  final SClassNamePart namePart;
  final SExtendsClause? extendsClause;
  final SWithClause? withClause;
  final SImplementsClause? implementsClause;

  /// The members (fields, methods, constructors).
  final SClassBody body;

  SClassDeclaration({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.isAbstract = false,
    this.isSealed = false,
    this.isBase = false,
    this.isInterface = false,
    this.isFinal = false,
    this.isMixin = false,
    required this.namePart,
    this.extendsClause,
    this.withClause,
    this.implementsClause,
    required this.body,
  });

  @override
  String get nodeType => 'ClassDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((e) => e.toJson()).toList(),
    'isAbstract': isAbstract,
    'isSealed': isSealed,
    'isBase': isBase,
    'isInterface': isInterface,
    'isFinal': isFinal,
    'isMixin': isMixin,
    'namePart': namePart.toJson(),
    if (extendsClause != null) 'extendsClause': extendsClause!.toJson(),
    if (withClause != null) 'withClause': withClause!.toJson(),
    if (implementsClause != null)
      'implementsClause': implementsClause!.toJson(),
    'body': body.toJson(),
  };

  factory SClassDeclaration.fromJson(Map<String, dynamic> json) {
    return SClassDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isAbstract: json['isAbstract'] as bool? ?? false,
      isSealed: json['isSealed'] as bool? ?? false,
      isBase: json['isBase'] as bool? ?? false,
      isInterface: json['isInterface'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isMixin: json['isMixin'] as bool? ?? false,
      namePart:
          SAstNodeFactory.fromJson(json['namePart'] as Map<String, dynamic>)
              as SClassNamePart,
      extendsClause:
          SAstNodeFactory.fromJson(
                json['extendsClause'] as Map<String, dynamic>?,
              )
              as SExtendsClause?,
      withClause:
          SAstNodeFactory.fromJson(json['withClause'] as Map<String, dynamic>?)
              as SWithClause?,
      implementsClause:
          SAstNodeFactory.fromJson(
                json['implementsClause'] as Map<String, dynamic>?,
              )
              as SImplementsClause?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>)
              as SClassBody,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitClassDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    namePart.accept(visitor);
    extendsClause?.accept(visitor);
    withClause?.accept(visitor);
    implementsClause?.accept(visitor);
    body.accept(visitor);
  }
}

// ============================================================================
// Mixin Declaration
// ============================================================================

/// A mixin declaration. Mirrors analyzer's `MixinDeclaration`.
class SMixinDeclaration extends SCompilationUnitMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;

  @override
  final SSimpleIdentifier? name;
  @override
  final List<SAnnotation> metadata;
  final bool isBase;
  final STypeParameterList? typeParameters;
  final SOnClause? onClause;
  final SImplementsClause? implementsClause;
  final SClassBody body;

  SMixinDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.isBase = false,
    this.typeParameters,
    this.onClause,
    this.implementsClause,
    required this.body,
  });

  @override
  String get nodeType => 'MixinDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((e) => e.toJson()).toList(),
    'isBase': isBase,
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (onClause != null) 'onClause': onClause!.toJson(),
    if (implementsClause != null)
      'implementsClause': implementsClause!.toJson(),
    'body': body.toJson(),
  };

  factory SMixinDeclaration.fromJson(Map<String, dynamic> json) {
    return SMixinDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name:
          SAstNodeFactory.fromJson(json['name'] as Map<String, dynamic>?)
              as SSimpleIdentifier?,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isBase: json['isBase'] as bool? ?? false,
      typeParameters:
          SAstNodeFactory.fromJson(
                json['typeParameters'] as Map<String, dynamic>?,
              )
              as STypeParameterList?,
      onClause:
          SAstNodeFactory.fromJson(json['onClause'] as Map<String, dynamic>?)
              as SOnClause?,
      implementsClause:
          SAstNodeFactory.fromJson(
                json['implementsClause'] as Map<String, dynamic>?,
              )
              as SImplementsClause?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>)
              as SClassBody,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMixinDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    onClause?.accept(visitor);
    implementsClause?.accept(visitor);
    body.accept(visitor);
  }
}

// ============================================================================
// Enum Declaration
// ============================================================================

/// An enum declaration. Mirrors analyzer's `EnumDeclaration`.
class SEnumDeclaration extends SCompilationUnitMember {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;

  /// The name and type parameters.
  final SClassNamePart namePart;
  final SWithClause? withClause;
  final SImplementsClause? implementsClause;

  /// The constants and members.
  final SEnumBody body;

  SEnumDeclaration({
    required this.offset,
    required this.length,
    this.metadata = const [],
    required this.namePart,
    this.withClause,
    this.implementsClause,
    required this.body,
  });

  @override
  String get nodeType => 'EnumDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((e) => e.toJson()).toList(),
    'namePart': namePart.toJson(),
    if (withClause != null) 'withClause': withClause!.toJson(),
    if (implementsClause != null)
      'implementsClause': implementsClause!.toJson(),
    'body': body.toJson(),
  };

  factory SEnumDeclaration.fromJson(Map<String, dynamic> json) {
    return SEnumDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      namePart:
          SAstNodeFactory.fromJson(json['namePart'] as Map<String, dynamic>)
              as SClassNamePart,
      withClause:
          SAstNodeFactory.fromJson(json['withClause'] as Map<String, dynamic>?)
              as SWithClause?,
      implementsClause:
          SAstNodeFactory.fromJson(
                json['implementsClause'] as Map<String, dynamic>?,
              )
              as SImplementsClause?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>)
              as SEnumBody,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEnumDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    namePart.accept(visitor);
    withClause?.accept(visitor);
    implementsClause?.accept(visitor);
    body.accept(visitor);
  }
}

class SEnumConstantDeclaration extends SDeclaration with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  final STypeArgumentList? typeArguments;
  final SArgumentList? arguments;

  SEnumConstantDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeArguments,
    this.arguments,
  });

  @override
  String get nodeType => 'EnumConstantDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    if (arguments != null) 'arguments': arguments!.toJson(),
  };

  factory SEnumConstantDeclaration.fromJson(Map<String, dynamic> json) {
    return SEnumConstantDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      arguments: json['arguments'] != null
          ? SArgumentList.fromJson(json['arguments'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitEnumConstantDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeArguments?.accept(visitor);
    arguments?.accept(visitor);
  }
}

// ============================================================================
// Extension Declaration
// ============================================================================

/// An extension declaration. Mirrors analyzer's `ExtensionDeclaration`.
class SExtensionDeclaration extends SCompilationUnitMember
    with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;

  @override
  final SSimpleIdentifier? name;
  @override
  final List<SAnnotation> metadata;
  final STypeParameterList? typeParameters;

  /// The `on` type.
  final STypeAnnotation? extendedType;
  final SClassBody body;

  SExtensionDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeParameters,
    this.extendedType,
    required this.body,
  });

  @override
  String get nodeType => 'ExtensionDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((e) => e.toJson()).toList(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (extendedType != null) 'extendedType': extendedType!.toJson(),
    'body': body.toJson(),
  };

  factory SExtensionDeclaration.fromJson(Map<String, dynamic> json) {
    return SExtensionDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name:
          SAstNodeFactory.fromJson(json['name'] as Map<String, dynamic>?)
              as SSimpleIdentifier?,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters:
          SAstNodeFactory.fromJson(
                json['typeParameters'] as Map<String, dynamic>?,
              )
              as STypeParameterList?,
      extendedType:
          SAstNodeFactory.fromJson(
                json['extendedType'] as Map<String, dynamic>?,
              )
              as STypeAnnotation?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>)
              as SClassBody,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitExtensionDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    extendedType?.accept(visitor);
    body.accept(visitor);
  }
}

// ============================================================================
// Variable Declarations
// ============================================================================

class SVariableDeclaration extends SDeclaration with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// Initializer expression
  final SExpression? initializer;

  /// Whether declared with `const`
  final bool isConst;

  /// Whether declared with `final`
  final bool isFinal;

  /// Whether declared with `late`
  final bool isLate;

  /// S3 (perf plan_3 §4.6): this declaration's **slot index** within its
  /// enclosing block frame's `_slots` array, assigned by [StaticResolver] when
  /// the variable is slot-eligible (every occurrence is a depth-0, non-escaped,
  /// non-assignment access). `null` = ineligible → the variable lives in
  /// `_values` and is accessed by name (status quo). Mutable because the
  /// resolver assigns it on block exit; the index is consulted by *both* the
  /// runtime `define` (writing the slot) and the resolved use's `resolvedSlot`
  /// (reading it), so they address the same cell by construction. Emitted into
  /// [toJson] only when non-null (backward compatible).
  int? declSlot;

  SVariableDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.initializer,
    this.isConst = false,
    this.isFinal = false,
    this.isLate = false,
  });

  @override
  String get nodeType => 'VariableDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (initializer != null) 'initializer': initializer!.toJson(),
    'isConst': isConst,
    'isFinal': isFinal,
    'isLate': isLate,
    if (declSlot != null) 'declSlot': declSlot,
  };

  factory SVariableDeclaration.fromJson(Map<String, dynamic> json) {
    return SVariableDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      initializer:
          SAstNodeFactory.fromJson(json['initializer'] as Map<String, dynamic>?)
              as SExpression?,
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isLate: json['isLate'] as bool? ?? false,
    )..declSlot = json['declSlot'] as int?;
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitVariableDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    initializer?.accept(visitor);
  }
}

class SVariableDeclarationList extends SDeclaration {
  @override
  final int offset;
  @override
  final int length;

  /// Type annotation
  final STypeAnnotation? type;

  /// Variable declarations
  final List<SVariableDeclaration> variables;

  /// Keywords
  final bool isConst;
  final bool isFinal;
  final bool isLate;

  @override
  final List<SAnnotation> metadata;

  SVariableDeclarationList({
    required this.offset,
    required this.length,
    this.type,
    this.variables = const [],
    this.isConst = false,
    this.isFinal = false,
    this.isLate = false,
    this.metadata = const [],
  });

  @override
  String get nodeType => 'VariableDeclarationList';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (type != null) 'type': type!.toJson(),
    'variables': variables.map((v) => v.toJson()).toList(),
    'isConst': isConst,
    'isFinal': isFinal,
    'isLate': isLate,
    'metadata': metadata.map((a) => a.toJson()).toList(),
  };

  factory SVariableDeclarationList.fromJson(Map<String, dynamic> json) {
    return SVariableDeclarationList(
      offset: json['offset'] as int,
      length: json['length'] as int,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      variables:
          (json['variables'] as List?)
              ?.map(
                (v) => SVariableDeclaration.fromJson(v as Map<String, dynamic>),
              )
              .toList() ??
          [],
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isLate: json['isLate'] as bool? ?? false,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitVariableDeclarationList(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    type?.accept(visitor);
    for (final child in variables) {
      child.accept(visitor);
    }
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

class SFieldDeclaration extends SClassMember {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final bool isStatic;
  final bool isAbstract;
  final bool isCovariant;
  final bool isExternal;
  final SVariableDeclarationList? fields;

  SFieldDeclaration({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.isStatic = false,
    this.isAbstract = false,
    this.isCovariant = false,
    this.isExternal = false,
    this.fields,
  });

  @override
  String get nodeType => 'FieldDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isStatic': isStatic,
    'isAbstract': isAbstract,
    'isCovariant': isCovariant,
    'isExternal': isExternal,
    if (fields != null) 'fields': fields!.toJson(),
  };

  factory SFieldDeclaration.fromJson(Map<String, dynamic> json) {
    return SFieldDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isStatic: json['isStatic'] as bool? ?? false,
      isAbstract: json['isAbstract'] as bool? ?? false,
      isCovariant: json['isCovariant'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      fields: json['fields'] != null
          ? SVariableDeclarationList.fromJson(
              json['fields'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitFieldDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    fields?.accept(visitor);
  }
}

class STopLevelVariableDeclaration extends SCompilationUnitMember {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final bool isExternal;
  final SVariableDeclarationList? variables;

  STopLevelVariableDeclaration({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.isExternal = false,
    this.variables,
  });

  @override
  String get nodeType => 'TopLevelVariableDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isExternal': isExternal,
    if (variables != null) 'variables': variables!.toJson(),
  };

  factory STopLevelVariableDeclaration.fromJson(Map<String, dynamic> json) {
    return STopLevelVariableDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isExternal: json['isExternal'] as bool? ?? false,
      variables: json['variables'] != null
          ? SVariableDeclarationList.fromJson(
              json['variables'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitTopLevelVariableDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    variables?.accept(visitor);
  }
}

// ============================================================================
// Constructor Declaration
// ============================================================================

class SConstructorDeclaration extends SClassMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// The class name the constructor is declared with.
  final SSimpleIdentifier? typeName;

  /// Whether factory constructor
  final bool isFactory;

  /// Whether const constructor
  final bool isConst;

  /// Whether external
  final bool isExternal;

  /// Parameters
  final SFormalParameterList? parameters;

  /// Initializers
  final List<SConstructorInitializer> initializers;

  /// Redirect to another constructor
  final SConstructorName? redirectedConstructor;

  /// Function body
  final SFunctionBody? body;

  SConstructorDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeName,
    this.isFactory = false,
    this.isConst = false,
    this.isExternal = false,
    this.parameters,
    this.initializers = const [],
    this.redirectedConstructor,
    this.body,
  });

  @override
  String get nodeType => 'ConstructorDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (typeName != null) 'typeName': typeName!.toJson(),
    'isFactory': isFactory,
    'isConst': isConst,
    'isExternal': isExternal,
    if (parameters != null) 'parameters': parameters!.toJson(),
    'initializers': initializers.map((i) => i.toJson()).toList(),
    if (redirectedConstructor != null)
      'redirectedConstructor': redirectedConstructor!.toJson(),
    if (body != null) 'body': body!.toJson(),
  };

  factory SConstructorDeclaration.fromJson(Map<String, dynamic> json) {
    return SConstructorDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeName: json['typeName'] != null
          ? SSimpleIdentifier.fromJson(json['typeName'] as Map<String, dynamic>)
          : null,
      isFactory: json['isFactory'] as bool? ?? false,
      isConst: json['isConst'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>,
            )
          : null,
      initializers: SAstNodeFactory.listFromJson<SConstructorInitializer>(
        json['initializers'] as List?,
      ),
      redirectedConstructor: json['redirectedConstructor'] != null
          ? SConstructorName.fromJson(
              json['redirectedConstructor'] as Map<String, dynamic>,
            )
          : null,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SFunctionBody?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitConstructorDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeName?.accept(visitor);
    parameters?.accept(visitor);
    for (final child in initializers) {
      child.accept(visitor);
    }
    redirectedConstructor?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Typedef Declaration
// ============================================================================

class STypedefDeclaration extends SCompilationUnitMember
    with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  final STypeParameterList? typeParameters;
  final STypeAnnotation? type;

  STypedefDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeParameters,
    this.type,
  });

  @override
  String get nodeType => 'TypedefDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (type != null) 'type': type!.toJson(),
  };

  factory STypedefDeclaration.fromJson(Map<String, dynamic> json) {
    return STypedefDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>,
            )
          : null,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTypedefDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    type?.accept(visitor);
  }
}

// ============================================================================
// Extension Type Declaration
// ============================================================================

/// An extension type declaration, such as
/// `extension type const Foo<T>(int it) implements int { ... }`. Mirrors analyzer's `ExtensionTypeDeclaration`.
class SExtensionTypeDeclaration extends SCompilationUnitMember {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;

  /// The primary constructor, which names the type.
  final SClassNamePart namePart;
  final SImplementsClause? implementsClause;
  final SClassBody body;

  SExtensionTypeDeclaration({
    required this.offset,
    required this.length,
    this.metadata = const [],
    required this.namePart,
    this.implementsClause,
    required this.body,
  });

  /// The primary constructor; its one parameter is the representation field.
  SPrimaryConstructorDeclaration get primaryConstructor =>
      namePart as SPrimaryConstructorDeclaration;

  @override
  String get nodeType => 'ExtensionTypeDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((e) => e.toJson()).toList(),
    'namePart': namePart.toJson(),
    if (implementsClause != null)
      'implementsClause': implementsClause!.toJson(),
    'body': body.toJson(),
  };

  factory SExtensionTypeDeclaration.fromJson(Map<String, dynamic> json) {
    return SExtensionTypeDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      namePart:
          SAstNodeFactory.fromJson(json['namePart'] as Map<String, dynamic>)
              as SClassNamePart,
      implementsClause:
          SAstNodeFactory.fromJson(
                json['implementsClause'] as Map<String, dynamic>?,
              )
              as SImplementsClause?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>)
              as SClassBody,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitExtensionTypeDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    namePart.accept(visitor);
    implementsClause?.accept(visitor);
    body.accept(visitor);
  }
}

// ============================================================================
// Class name parts and bodies
// ============================================================================

/// The name of a class-like declaration with its type parameters: `Foo<T>`,
/// or for an extension type its primary constructor `Foo<T>(int it)`.
/// Mirrors analyzer's `ClassNamePart`.
abstract class SClassNamePart extends SAstNode {
  SSimpleIdentifier get typeName;
  STypeParameterList? get typeParameters;
}

/// The members of a class, mixin, extension or extension type. Mirrors
/// analyzer's `ClassBody`.
abstract class SClassBody extends SAstNode {
  List<SClassMember> get members;
}

/// The constants and members of an enum. Mirrors analyzer's `EnumBody`.
abstract class SEnumBody extends SAstNode {
  List<SEnumConstantDeclaration> get constants;
  List<SClassMember> get members;
}

/// A plain class name part: `Foo<T>`. Mirrors analyzer's
/// `NameWithTypeParameters`.
class SNameWithTypeParameters extends SClassNamePart {
  @override
  final int offset;
  @override
  final int length;

  @override
  final SSimpleIdentifier typeName;
  @override
  final STypeParameterList? typeParameters;

  SNameWithTypeParameters({
    required this.offset,
    required this.length,
    required this.typeName,
    this.typeParameters,
  });

  @override
  String get nodeType => 'NameWithTypeParameters';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'typeName': typeName.toJson(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
  };

  factory SNameWithTypeParameters.fromJson(Map<String, dynamic> json) {
    return SNameWithTypeParameters(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeName:
          SAstNodeFactory.fromJson(json['typeName'] as Map<String, dynamic>)
              as SSimpleIdentifier,
      typeParameters:
          SAstNodeFactory.fromJson(
                json['typeParameters'] as Map<String, dynamic>?,
              )
              as STypeParameterList?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitNameWithTypeParameters(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeName.accept(visitor);
    typeParameters?.accept(visitor);
  }
}

/// A primary constructor as a class name part: `const Foo<T>.named(int it)`.
/// Mirrors analyzer's `PrimaryConstructorDeclaration`.
class SPrimaryConstructorDeclaration extends SClassNamePart {
  @override
  final int offset;
  @override
  final int length;

  @override
  final SSimpleIdentifier typeName;
  @override
  final STypeParameterList? typeParameters;

  /// Whether declared `const`.
  final bool isConst;

  /// The `.named` part, when there is one.
  final SSimpleIdentifier? constructorName;
  final SFormalParameterList formalParameters;

  SPrimaryConstructorDeclaration({
    required this.offset,
    required this.length,
    required this.typeName,
    this.typeParameters,
    this.isConst = false,
    this.constructorName,
    required this.formalParameters,
  });

  @override
  String get nodeType => 'PrimaryConstructorDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'typeName': typeName.toJson(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    'isConst': isConst,
    if (constructorName != null) 'constructorName': constructorName!.toJson(),
    'formalParameters': formalParameters.toJson(),
  };

  factory SPrimaryConstructorDeclaration.fromJson(Map<String, dynamic> json) {
    return SPrimaryConstructorDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeName:
          SAstNodeFactory.fromJson(json['typeName'] as Map<String, dynamic>)
              as SSimpleIdentifier,
      typeParameters:
          SAstNodeFactory.fromJson(
                json['typeParameters'] as Map<String, dynamic>?,
              )
              as STypeParameterList?,
      isConst: json['isConst'] as bool? ?? false,
      constructorName:
          SAstNodeFactory.fromJson(
                json['constructorName'] as Map<String, dynamic>?,
              )
              as SSimpleIdentifier?,
      formalParameters:
          SAstNodeFactory.fromJson(
                json['formalParameters'] as Map<String, dynamic>,
              )
              as SFormalParameterList,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitPrimaryConstructorDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeName.accept(visitor);
    typeParameters?.accept(visitor);
    constructorName?.accept(visitor);
    formalParameters.accept(visitor);
  }
}

/// A class body in braces. Mirrors analyzer's `BlockClassBody`.
class SBlockClassBody extends SClassBody {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SClassMember> members;

  SBlockClassBody({
    required this.offset,
    required this.length,
    this.members = const [],
  });

  @override
  String get nodeType => 'BlockClassBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'members': members.map((e) => e.toJson()).toList(),
  };

  factory SBlockClassBody.fromJson(Map<String, dynamic> json) {
    return SBlockClassBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
      members: SAstNodeFactory.listFromJson<SClassMember>(
        json['members'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBlockClassBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

/// The body `;` of a class-like declaration without members. Mirrors
/// analyzer's `EmptyClassBody`.
class SEmptyClassBody extends SClassBody {
  @override
  final int offset;
  @override
  final int length;

  SEmptyClassBody({required this.offset, required this.length});

  @override
  List<SClassMember> get members => const [];

  @override
  String get nodeType => 'EmptyClassBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SEmptyClassBody.fromJson(Map<String, dynamic> json) =>
      SEmptyClassBody(
        offset: json['offset'] as int,
        length: json['length'] as int,
      );

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEmptyClassBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

/// An enum body in braces. Mirrors analyzer's `BlockEnumBody`.
class SBlockEnumBody extends SEnumBody {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SEnumConstantDeclaration> constants;
  @override
  final List<SClassMember> members;

  SBlockEnumBody({
    required this.offset,
    required this.length,
    this.constants = const [],
    this.members = const [],
  });

  @override
  String get nodeType => 'BlockEnumBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'constants': constants.map((e) => e.toJson()).toList(),
    'members': members.map((e) => e.toJson()).toList(),
  };

  factory SBlockEnumBody.fromJson(Map<String, dynamic> json) {
    return SBlockEnumBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
      constants: SAstNodeFactory.listFromJson<SEnumConstantDeclaration>(
        json['constants'] as List?,
      ),
      members: SAstNodeFactory.listFromJson<SClassMember>(
        json['members'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBlockEnumBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in constants) {
      child.accept(visitor);
    }
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

/// The body `;` of an enum without constants or members (invalid code).
/// Mirrors analyzer's `EmptyEnumBody`.
class SEmptyEnumBody extends SEnumBody {
  @override
  final int offset;
  @override
  final int length;

  SEmptyEnumBody({required this.offset, required this.length});

  @override
  List<SEnumConstantDeclaration> get constants => const [];

  @override
  List<SClassMember> get members => const [];

  @override
  String get nodeType => 'EmptyEnumBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SEmptyEnumBody.fromJson(Map<String, dynamic> json) => SEmptyEnumBody(
    offset: json['offset'] as int,
    length: json['length'] as int,
  );

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEmptyEnumBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}
