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

class SFunctionDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      returnType: SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?) as STypeAnnotation?,
      isGetter: json['isGetter'] as bool? ?? false,
      isSetter: json['isSetter'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      functionExpression: json['functionExpression'] != null
          ? SFunctionExpression.fromJson(
              json['functionExpression'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitFunctionDeclaration(this);

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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      returnType: SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?) as STypeAnnotation?,
      isStatic: json['isStatic'] as bool? ?? false,
      isAbstract: json['isAbstract'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      isGetter: json['isGetter'] as bool? ?? false,
      isSetter: json['isSetter'] as bool? ?? false,
      isOperator: json['isOperator'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>)
          : null,
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?) as SFunctionBody?,
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

class SClassDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// Class modifiers
  final bool isAbstract;
  final bool isSealed;
  final bool isBase;
  final bool isInterface;
  final bool isFinal;
  final bool isMixin;

  /// Type parameters
  final STypeParameterList? typeParameters;

  /// Extends clause
  final SExtendsClause? extendsClause;

  /// Implements clause
  final SImplementsClause? implementsClause;

  /// With clause
  final SWithClause? withClause;

  /// Class members (fields, methods, constructors)
  final List<SClassMember> members;

  SClassDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.isAbstract = false,
    this.isSealed = false,
    this.isBase = false,
    this.isInterface = false,
    this.isFinal = false,
    this.isMixin = false,
    this.typeParameters,
    this.extendsClause,
    this.implementsClause,
    this.withClause,
    this.members = const [],
  });

  @override
  String get nodeType => 'ClassDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        'metadata': metadata.map((a) => a.toJson()).toList(),
        'isAbstract': isAbstract,
        'isSealed': isSealed,
        'isBase': isBase,
        'isInterface': isInterface,
        'isFinal': isFinal,
        'isMixin': isMixin,
        if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
        if (extendsClause != null) 'extendsClause': extendsClause!.toJson(),
        if (implementsClause != null)
          'implementsClause': implementsClause!.toJson(),
        if (withClause != null) 'withClause': withClause!.toJson(),
        'members': members.map((m) => m.toJson()).toList(),
      };

  factory SClassDeclaration.fromJson(Map<String, dynamic> json) {
    return SClassDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isAbstract: json['isAbstract'] as bool? ?? false,
      isSealed: json['isSealed'] as bool? ?? false,
      isBase: json['isBase'] as bool? ?? false,
      isInterface: json['isInterface'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isMixin: json['isMixin'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      extendsClause: json['extendsClause'] != null
          ? SExtendsClause.fromJson(
              json['extendsClause'] as Map<String, dynamic>)
          : null,
      implementsClause: json['implementsClause'] != null
          ? SImplementsClause.fromJson(
              json['implementsClause'] as Map<String, dynamic>)
          : null,
      withClause: json['withClause'] != null
          ? SWithClause.fromJson(json['withClause'] as Map<String, dynamic>)
          : null,
      members: SAstNodeFactory.listFromJson<SClassMember>(json['members'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitClassDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    extendsClause?.accept(visitor);
    implementsClause?.accept(visitor);
    withClause?.accept(visitor);
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Mixin Declaration
// ============================================================================

class SMixinDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  final bool isBase;
  final STypeParameterList? typeParameters;
  final SOnClause? onClause;
  final SImplementsClause? implementsClause;
  final List<SClassMember> members;

  SMixinDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.isBase = false,
    this.typeParameters,
    this.onClause,
    this.implementsClause,
    this.members = const [],
  });

  @override
  String get nodeType => 'MixinDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        'metadata': metadata.map((a) => a.toJson()).toList(),
        'isBase': isBase,
        if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
        if (onClause != null) 'onClause': onClause!.toJson(),
        if (implementsClause != null)
          'implementsClause': implementsClause!.toJson(),
        'members': members.map((m) => m.toJson()).toList(),
      };

  factory SMixinDeclaration.fromJson(Map<String, dynamic> json) {
    return SMixinDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isBase: json['isBase'] as bool? ?? false,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      onClause: json['onClause'] != null
          ? SOnClause.fromJson(json['onClause'] as Map<String, dynamic>)
          : null,
      implementsClause: json['implementsClause'] != null
          ? SImplementsClause.fromJson(
              json['implementsClause'] as Map<String, dynamic>)
          : null,
      members: SAstNodeFactory.listFromJson<SClassMember>(json['members'] as List?),
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
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Enum Declaration
// ============================================================================

class SEnumDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
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
  final SImplementsClause? implementsClause;
  final SWithClause? withClause;
  final List<SEnumConstantDeclaration> constants;
  final List<SClassMember> members;

  SEnumDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeParameters,
    this.implementsClause,
    this.withClause,
    this.constants = const [],
    this.members = const [],
  });

  @override
  String get nodeType => 'EnumDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        'metadata': metadata.map((a) => a.toJson()).toList(),
        if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
        if (implementsClause != null)
          'implementsClause': implementsClause!.toJson(),
        if (withClause != null) 'withClause': withClause!.toJson(),
        'constants': constants.map((c) => c.toJson()).toList(),
        'members': members.map((m) => m.toJson()).toList(),
      };

  factory SEnumDeclaration.fromJson(Map<String, dynamic> json) {
    return SEnumDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      implementsClause: json['implementsClause'] != null
          ? SImplementsClause.fromJson(
              json['implementsClause'] as Map<String, dynamic>)
          : null,
      withClause: json['withClause'] != null
          ? SWithClause.fromJson(json['withClause'] as Map<String, dynamic>)
          : null,
      constants: (json['constants'] as List?)
              ?.map((c) =>
                  SEnumConstantDeclaration.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      members: SAstNodeFactory.listFromJson<SClassMember>(json['members'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEnumDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    implementsClause?.accept(visitor);
    withClause?.accept(visitor);
    for (final child in constants) {
      child.accept(visitor);
    }
    for (final child in members) {
      child.accept(visitor);
    }
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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>)
          : null,
      arguments: json['arguments'] != null
          ? SArgumentList.fromJson(json['arguments'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEnumConstantDeclaration(this);

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

class SExtensionDeclaration extends SCompilationUnitMember with SNamedDeclaration {
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
  final STypeAnnotation? extendedType;
  final List<SClassMember> members;

  SExtensionDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeParameters,
    this.extendedType,
    this.members = const [],
  });

  @override
  String get nodeType => 'ExtensionDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        'metadata': metadata.map((a) => a.toJson()).toList(),
        if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
        if (extendedType != null) 'extendedType': extendedType!.toJson(),
        'members': members.map((m) => m.toJson()).toList(),
      };

  factory SExtensionDeclaration.fromJson(Map<String, dynamic> json) {
    return SExtensionDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      extendedType:
          SAstNodeFactory.fromJson(json['extendedType'] as Map<String, dynamic>?) as STypeAnnotation?,
      members: SAstNodeFactory.listFromJson<SClassMember>(json['members'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitExtensionDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    extendedType?.accept(visitor);
    for (final child in members) {
      child.accept(visitor);
    }
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
      };

  factory SVariableDeclaration.fromJson(Map<String, dynamic> json) {
    return SVariableDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      initializer:
          SAstNodeFactory.fromJson(json['initializer'] as Map<String, dynamic>?) as SExpression?,
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isLate: json['isLate'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitVariableDeclaration(this);

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
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?) as STypeAnnotation?,
      variables: (json['variables'] as List?)
              ?.map((v) =>
                  SVariableDeclaration.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isLate: json['isLate'] as bool? ?? false,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitVariableDeclarationList(this);

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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isStatic: json['isStatic'] as bool? ?? false,
      isAbstract: json['isAbstract'] as bool? ?? false,
      isCovariant: json['isCovariant'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      fields: json['fields'] != null
          ? SVariableDeclarationList.fromJson(
              json['fields'] as Map<String, dynamic>)
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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isExternal: json['isExternal'] as bool? ?? false,
      variables: json['variables'] != null
          ? SVariableDeclarationList.fromJson(
              json['variables'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTopLevelVariableDeclaration(this);

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

  /// Return type (class name)
  final SSimpleIdentifier? returnType;

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
    this.returnType,
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
        if (returnType != null) 'returnType': returnType!.toJson(),
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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      returnType: json['returnType'] != null
          ? SSimpleIdentifier.fromJson(
              json['returnType'] as Map<String, dynamic>)
          : null,
      isFactory: json['isFactory'] as bool? ?? false,
      isConst: json['isConst'] as bool? ?? false,
      isExternal: json['isExternal'] as bool? ?? false,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>)
          : null,
      initializers:
          SAstNodeFactory.listFromJson<SConstructorInitializer>(json['initializers'] as List?),
      redirectedConstructor: json['redirectedConstructor'] != null
          ? SConstructorName.fromJson(
              json['redirectedConstructor'] as Map<String, dynamic>)
          : null,
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?) as SFunctionBody?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitConstructorDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    returnType?.accept(visitor);
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

class STypedefDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
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
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?) as STypeAnnotation?,
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

/// An extension type declaration: `extension type MyType(int value) implements int { ... }`
class SExtensionTypeDeclaration extends SNamedCompilationUnitMember with SNamedDeclaration {
  @override
  final int offset;
  @override
  final int length;
  @override
  final SSimpleIdentifier? name;
  @override
  @override
  final List<SAnnotation> metadata;

  /// Optional type parameters
  final STypeParameterList? typeParameters;

  /// The representation declaration (e.g., `int value`)
  final SRepresentationDeclaration representation;

  /// Optional implements clause
  final SImplementsClause? implementsClause;

  /// Members (methods, getters, etc.)
  final List<SClassMember> members;

  /// Whether declared with `const` keyword
  final bool isConst;

  SExtensionTypeDeclaration({
    required this.offset,
    required this.length,
    this.name,
    this.metadata = const [],
    this.typeParameters,
    required this.representation,
    this.implementsClause,
    this.members = const [],
    this.isConst = false,
  });

  @override
  String get nodeType => 'ExtensionTypeDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        'metadata': metadata.map((a) => a.toJson()).toList(),
        if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
        'representation': representation.toJson(),
        if (implementsClause != null)
          'implementsClause': implementsClause!.toJson(),
        'members': members.map((m) => m.toJson()).toList(),
        'isConst': isConst,
      };

  factory SExtensionTypeDeclaration.fromJson(Map<String, dynamic> json) {
    return SExtensionTypeDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      representation: SAstNodeFactory.fromJson(
          json['representation'] as Map<String, dynamic>?) as SRepresentationDeclaration,
      implementsClause: json['implementsClause'] != null
          ? SImplementsClause.fromJson(
              json['implementsClause'] as Map<String, dynamic>)
          : null,
      members: SAstNodeFactory.listFromJson<SClassMember>(json['members'] as List?),
      isConst: json['isConst'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitExtensionTypeDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
    typeParameters?.accept(visitor);
    representation.accept(visitor);
    implementsClause?.accept(visitor);
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Representation Declaration
// ============================================================================

/// The representation declaration of an extension type: `(int value)`
class SRepresentationDeclaration extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// Name of the representation field
  final String fieldName;

  /// Type annotation of the representation field
  final STypeAnnotation fieldType;

  SRepresentationDeclaration({
    required this.offset,
    required this.length,
    required this.fieldName,
    required this.fieldType,
  });

  @override
  String get nodeType => 'RepresentationDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'fieldName': fieldName,
        'fieldType': fieldType.toJson(),
      };

  factory SRepresentationDeclaration.fromJson(Map<String, dynamic> json) {
    return SRepresentationDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      fieldName: json['fieldName'] as String,
      fieldType:
          SAstNodeFactory.fromJson(json['fieldType'] as Map<String, dynamic>?) as STypeAnnotation,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRepresentationDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    fieldType.accept(visitor);
  }
}
