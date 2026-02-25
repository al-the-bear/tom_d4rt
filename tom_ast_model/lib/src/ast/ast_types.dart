// Serializable AST types
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Named Type
// ============================================================================

class SNamedType extends STypeAnnotation {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeArgumentList? typeArguments;
  @override
  final bool isNullable;
  final SSimpleIdentifier? importPrefix;

  SNamedType({
    required this.offset,
    required this.length,
    this.name,
    this.typeArguments,
    this.isNullable = false,
    this.importPrefix,
  });

  @override
  String get nodeType => 'NamedType';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    'isNullable': isNullable,
    if (importPrefix != null) 'importPrefix': importPrefix!.toJson(),
  };

  factory SNamedType.fromJson(Map<String, dynamic> json) {
    return SNamedType(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      isNullable: json['isNullable'] as bool? ?? false,
      importPrefix:
          SAstNodeFactory.fromJson(
                json['importPrefix'] as Map<String, dynamic>?,
              )
              as SSimpleIdentifier?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNamedType(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    typeArguments?.accept(visitor);
    importPrefix?.accept(visitor);
  }
}

// ============================================================================
// Generic Function Type
// ============================================================================

class SGenericFunctionType extends STypeAnnotation {
  @override
  final int offset;
  @override
  final int length;

  final STypeAnnotation? returnType;
  final STypeParameterList? typeParameters;
  final SFormalParameterList? parameters;
  @override
  final bool isNullable;

  SGenericFunctionType({
    required this.offset,
    required this.length,
    this.returnType,
    this.typeParameters,
    this.parameters,
    this.isNullable = false,
  });

  @override
  String get nodeType => 'GenericFunctionType';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (returnType != null) 'returnType': returnType!.toJson(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    'isNullable': isNullable,
  };

  factory SGenericFunctionType.fromJson(Map<String, dynamic> json) {
    return SGenericFunctionType(
      offset: json['offset'] as int,
      length: json['length'] as int,
      returnType:
          SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?)
              as STypeAnnotation?,
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
      isNullable: json['isNullable'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitGenericFunctionType(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    returnType?.accept(visitor);
    typeParameters?.accept(visitor);
    parameters?.accept(visitor);
  }
}

// ============================================================================
// Type Arguments and Parameters
// ============================================================================

class STypeArgumentList extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<STypeAnnotation> arguments;

  STypeArgumentList({
    required this.offset,
    required this.length,
    this.arguments = const [],
  });

  @override
  String get nodeType => 'TypeArgumentList';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'arguments': arguments.map((a) => a.toJson()).toList(),
  };

  factory STypeArgumentList.fromJson(Map<String, dynamic> json) {
    return STypeArgumentList(
      offset: json['offset'] as int,
      length: json['length'] as int,
      arguments: SAstNodeFactory.listFromJson<STypeAnnotation>(
        json['arguments'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTypeArgumentList(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in arguments) {
      child.accept(visitor);
    }
  }
}

class STypeParameterList extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<STypeParameter> typeParameters;

  STypeParameterList({
    required this.offset,
    required this.length,
    this.typeParameters = const [],
  });

  @override
  String get nodeType => 'TypeParameterList';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'typeParameters': typeParameters.map((t) => t.toJson()).toList(),
  };

  factory STypeParameterList.fromJson(Map<String, dynamic> json) {
    return STypeParameterList(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeParameters:
          (json['typeParameters'] as List?)
              ?.map((t) => STypeParameter.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTypeParameterList(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in typeParameters) {
      child.accept(visitor);
    }
  }
}

class STypeParameter extends SDeclaration {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeAnnotation? bound;
  @override
  final List<SAnnotation> metadata;

  STypeParameter({
    required this.offset,
    required this.length,
    this.name,
    this.bound,
    this.metadata = const [],
  });

  @override
  String get nodeType => 'TypeParameter';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (bound != null) 'bound': bound!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
  };

  factory STypeParameter.fromJson(Map<String, dynamic> json) {
    return STypeParameter(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      bound:
          SAstNodeFactory.fromJson(json['bound'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTypeParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    bound?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Record Type
// ============================================================================

class SRecordTypeAnnotation extends STypeAnnotation {
  @override
  final int offset;
  @override
  final int length;

  final List<SAstNode> positionalFields;
  final List<SAstNode> namedFields;
  @override
  final bool isNullable;

  SRecordTypeAnnotation({
    required this.offset,
    required this.length,
    this.positionalFields = const [],
    this.namedFields = const [],
    this.isNullable = false,
  });

  @override
  String get nodeType => 'RecordTypeAnnotation';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'positionalFields': positionalFields.map((f) => f.toJson()).toList(),
    'namedFields': namedFields.map((f) => f.toJson()).toList(),
    'isNullable': isNullable,
  };

  factory SRecordTypeAnnotation.fromJson(Map<String, dynamic> json) {
    return SRecordTypeAnnotation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      positionalFields: SAstNodeFactory.listFromJson(
        json['positionalFields'] as List?,
      ),
      namedFields: SAstNodeFactory.listFromJson(json['namedFields'] as List?),
      isNullable: json['isNullable'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitRecordTypeAnnotation(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in positionalFields) {
      child.accept(visitor);
    }
    for (final child in namedFields) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Formal Parameters
// ============================================================================

class SFormalParameterList extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SFormalParameter> parameters;

  SFormalParameterList({
    required this.offset,
    required this.length,
    this.parameters = const [],
  });

  @override
  String get nodeType => 'FormalParameterList';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'parameters': parameters.map((p) => p.toJson()).toList(),
  };

  factory SFormalParameterList.fromJson(Map<String, dynamic> json) {
    return SFormalParameterList(
      offset: json['offset'] as int,
      length: json['length'] as int,
      parameters: SAstNodeFactory.listFromJson<SFormalParameter>(
        json['parameters'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFormalParameterList(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in parameters) {
      child.accept(visitor);
    }
  }
}

class SSimpleFormalParameter extends SNormalFormalParameter {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeAnnotation? type;
  final List<SAnnotation> metadata;
  final bool isConst;
  final bool isFinal;
  @override
  final bool isRequired;
  final bool isCovariant;
  @override
  final bool isPositional;
  @override
  final bool isNamed;

  @override
  bool get isOptional => !isRequired;

  @override
  String? get parameterName => name?.name;

  SSimpleFormalParameter({
    required this.offset,
    required this.length,
    this.name,
    this.type,
    this.metadata = const [],
    this.isConst = false,
    this.isFinal = false,
    this.isRequired = false,
    this.isCovariant = false,
    this.isPositional = true,
    this.isNamed = false,
  });

  @override
  String get nodeType => 'SimpleFormalParameter';

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
    'isRequired': isRequired,
    'isCovariant': isCovariant,
    'isPositional': isPositional,
    'isNamed': isNamed,
  };

  factory SSimpleFormalParameter.fromJson(Map<String, dynamic> json) {
    return SSimpleFormalParameter(
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
          [],
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isRequired: json['isRequired'] as bool? ?? false,
      isCovariant: json['isCovariant'] as bool? ?? false,
      isPositional: json['isPositional'] as bool? ?? true,
      isNamed: json['isNamed'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitSimpleFormalParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    type?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

class SDefaultFormalParameter extends SFormalParameter {
  @override
  final int offset;
  @override
  final int length;

  final SNormalFormalParameter? parameter;
  final SExpression? defaultValue;
  @override
  final bool isPositional;
  @override
  final bool isNamed;

  @override
  bool get isOptional => true;

  @override
  bool get isRequired => false;

  @override
  String? get parameterName => null;

  SDefaultFormalParameter({
    required this.offset,
    required this.length,
    this.parameter,
    this.defaultValue,
    this.isPositional = true,
    this.isNamed = false,
  });

  @override
  String get nodeType => 'DefaultFormalParameter';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (parameter != null) 'parameter': parameter!.toJson(),
    if (defaultValue != null) 'defaultValue': defaultValue!.toJson(),
    'isPositional': isPositional,
    'isNamed': isNamed,
  };

  factory SDefaultFormalParameter.fromJson(Map<String, dynamic> json) {
    return SDefaultFormalParameter(
      offset: json['offset'] as int,
      length: json['length'] as int,
      parameter:
          SAstNodeFactory.fromJson(json['parameter'] as Map<String, dynamic>?)
              as SNormalFormalParameter?,
      defaultValue:
          SAstNodeFactory.fromJson(
                json['defaultValue'] as Map<String, dynamic>?,
              )
              as SExpression?,
      isPositional: json['isPositional'] as bool? ?? true,
      isNamed: json['isNamed'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitDefaultFormalParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    parameter?.accept(visitor);
    defaultValue?.accept(visitor);
  }
}

class SFieldFormalParameter extends SNormalFormalParameter {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeAnnotation? type;
  final SFormalParameterList? parameters;
  final List<SAnnotation> metadata;
  final bool isConst;
  final bool isFinal;
  @override
  final bool isRequired;

  @override
  bool get isNamed => false;

  @override
  bool get isPositional => true;

  @override
  bool get isOptional => !isRequired;

  @override
  String? get parameterName => name?.name;

  SFieldFormalParameter({
    required this.offset,
    required this.length,
    this.name,
    this.type,
    this.parameters,
    this.metadata = const [],
    this.isConst = false,
    this.isFinal = false,
    this.isRequired = false,
  });

  @override
  String get nodeType => 'FieldFormalParameter';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (type != null) 'type': type!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isConst': isConst,
    'isFinal': isFinal,
    'isRequired': isRequired,
  };

  factory SFieldFormalParameter.fromJson(Map<String, dynamic> json) {
    return SFieldFormalParameter(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>,
            )
          : null,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isConst: json['isConst'] as bool? ?? false,
      isFinal: json['isFinal'] as bool? ?? false,
      isRequired: json['isRequired'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFieldFormalParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    type?.accept(visitor);
    parameters?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

class SFunctionTypedFormalParameter extends SNormalFormalParameter {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeAnnotation? returnType;
  final STypeParameterList? typeParameters;
  final SFormalParameterList? parameters;
  final List<SAnnotation> metadata;
  @override
  final bool isRequired;

  @override
  bool get isNamed => false;

  @override
  bool get isPositional => true;

  @override
  bool get isOptional => !isRequired;

  @override
  String? get parameterName => name?.name;

  SFunctionTypedFormalParameter({
    required this.offset,
    required this.length,
    this.name,
    this.returnType,
    this.typeParameters,
    this.parameters,
    this.metadata = const [],
    this.isRequired = false,
  });

  @override
  String get nodeType => 'FunctionTypedFormalParameter';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (returnType != null) 'returnType': returnType!.toJson(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isRequired': isRequired,
  };

  factory SFunctionTypedFormalParameter.fromJson(Map<String, dynamic> json) {
    return SFunctionTypedFormalParameter(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      returnType:
          SAstNodeFactory.fromJson(json['returnType'] as Map<String, dynamic>?)
              as STypeAnnotation?,
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
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isRequired: json['isRequired'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFunctionTypedFormalParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    returnType?.accept(visitor);
    typeParameters?.accept(visitor);
    parameters?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

class SSuperFormalParameter extends SNormalFormalParameter {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeAnnotation? type;
  final STypeParameterList? typeParameters;
  final SFormalParameterList? parameters;
  final List<SAnnotation> metadata;
  @override
  final bool isRequired;

  @override
  bool get isNamed => false;

  @override
  bool get isPositional => true;

  @override
  bool get isOptional => !isRequired;

  @override
  String? get parameterName => name?.name;

  SSuperFormalParameter({
    required this.offset,
    required this.length,
    this.name,
    this.type,
    this.typeParameters,
    this.parameters,
    this.metadata = const [],
    this.isRequired = false,
  });

  @override
  String get nodeType => 'SuperFormalParameter';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (type != null) 'type': type!.toJson(),
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    'metadata': metadata.map((a) => a.toJson()).toList(),
    'isRequired': isRequired,
  };

  factory SSuperFormalParameter.fromJson(Map<String, dynamic> json) {
    return SSuperFormalParameter(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
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
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      isRequired: json['isRequired'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitSuperFormalParameter(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    type?.accept(visitor);
    typeParameters?.accept(visitor);
    parameters?.accept(visitor);
    for (final child in metadata) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Function Bodies
// ============================================================================

class SBlockFunctionBody extends SFunctionBody {
  @override
  final int offset;
  @override
  final int length;

  final SBlock? block;
  final bool isAsync;
  @override
  final bool isGenerator;

  @override
  bool get isAsynchronous => isAsync;

  SBlockFunctionBody({
    required this.offset,
    required this.length,
    this.block,
    this.isAsync = false,
    this.isGenerator = false,
  });

  @override
  String get nodeType => 'BlockFunctionBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (block != null) 'block': block!.toJson(),
    'isAsync': isAsync,
    'isGenerator': isGenerator,
  };

  factory SBlockFunctionBody.fromJson(Map<String, dynamic> json) {
    return SBlockFunctionBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
      block: json['block'] != null
          ? SBlock.fromJson(json['block'] as Map<String, dynamic>)
          : null,
      isAsync: json['isAsync'] as bool? ?? false,
      isGenerator: json['isGenerator'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBlockFunctionBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    block?.accept(visitor);
  }
}

class SExpressionFunctionBody extends SFunctionBody {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
  final bool isAsync;

  @override
  bool get isAsynchronous => isAsync;

  @override
  bool get isGenerator => false;

  SExpressionFunctionBody({
    required this.offset,
    required this.length,
    this.expression,
    this.isAsync = false,
  });

  @override
  String get nodeType => 'ExpressionFunctionBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
    'isAsync': isAsync,
  };

  factory SExpressionFunctionBody.fromJson(Map<String, dynamic> json) {
    return SExpressionFunctionBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      isAsync: json['isAsync'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitExpressionFunctionBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

class SEmptyFunctionBody extends SFunctionBody {
  @override
  final int offset;
  @override
  final int length;

  @override
  bool get isAsynchronous => false;

  @override
  bool get isGenerator => false;

  SEmptyFunctionBody({required this.offset, required this.length});

  @override
  String get nodeType => 'EmptyFunctionBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SEmptyFunctionBody.fromJson(Map<String, dynamic> json) {
    return SEmptyFunctionBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEmptyFunctionBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

class SNativeFunctionBody extends SFunctionBody {
  @override
  final int offset;
  @override
  final int length;

  final SStringLiteral? stringLiteral;

  @override
  bool get isAsynchronous => false;

  @override
  bool get isGenerator => false;

  SNativeFunctionBody({
    required this.offset,
    required this.length,
    this.stringLiteral,
  });

  @override
  String get nodeType => 'NativeFunctionBody';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (stringLiteral != null) 'stringLiteral': stringLiteral!.toJson(),
  };

  factory SNativeFunctionBody.fromJson(Map<String, dynamic> json) {
    return SNativeFunctionBody(
      offset: json['offset'] as int,
      length: json['length'] as int,
      stringLiteral:
          SAstNodeFactory.fromJson(
                json['stringLiteral'] as Map<String, dynamic>?,
              )
              as SStringLiteral?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNativeFunctionBody(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    stringLiteral?.accept(visitor);
  }
}
