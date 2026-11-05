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

/// A single field of a record type ANNOTATION — `int` or `String label` in
/// `(int, {String label})`.
///
/// The analyzer splits this into `RecordTypeAnnotationPositionalField` and
/// `RecordTypeAnnotationNamedField`; here one node covers both, because
/// [SRecordTypeAnnotation] already separates them into two lists. [name] is
/// therefore non-null exactly for a field in
/// [SRecordTypeAnnotation.namedFields].
class SRecordTypeField extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The declared field type. Null only for malformed source, or for a field
  /// deserialised from a bundle written before this node existed.
  final STypeAnnotation? type;

  /// The field name — non-null for a named field, null for a positional one.
  final SSimpleIdentifier? name;

  SRecordTypeField({
    required this.offset,
    required this.length,
    this.type,
    this.name,
  });

  @override
  String get nodeType => 'RecordTypeField';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (type != null) 'type': type!.toJson(),
    if (name != null) 'name': name!.toJson(),
  };

  factory SRecordTypeField.fromJson(Map<String, dynamic> json) {
    return SRecordTypeField(
      offset: json['offset'] as int,
      length: json['length'] as int,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRecordTypeField(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    type?.accept(visitor);
    name?.accept(visitor);
  }
}

class SRecordTypeAnnotation extends STypeAnnotation {
  @override
  final int offset;
  @override
  final int length;

  final List<SRecordTypeField> positionalFields;
  final List<SRecordTypeField> namedFields;
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
      positionalFields: _fieldsFromJson(json['positionalFields'] as List?),
      namedFields: _fieldsFromJson(json['namedFields'] as List?),
      isNullable: json['isNullable'] as bool? ?? false,
    );
  }

  /// Deserialises the field lists directly rather than through
  /// [SAstNodeFactory], so a bundle written before [SRecordTypeField] existed
  /// (its fields were opaque placeholders) still yields fields — typeless and
  /// nameless, i.e. exactly as much as was recorded — instead of dropping them
  /// and silently changing the record's arity.
  static List<SRecordTypeField> _fieldsFromJson(List? raw) => [
    for (final entry in raw ?? const [])
      SRecordTypeField.fromJson(entry as Map<String, dynamic>),
  ];

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

/// The default clause of an optional parameter: `= value` (or `: value` in
/// old named-parameter syntax). Mirrors analyzer's
/// `FormalParameterDefaultClause`.
class SFormalParameterDefaultClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SExpression value;

  SFormalParameterDefaultClause({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'FormalParameterDefaultClause';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value.toJson(),
  };

  factory SFormalParameterDefaultClause.fromJson(Map<String, dynamic> json) {
    return SFormalParameterDefaultClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value:
          SAstNodeFactory.fromJson(json['value'] as Map<String, dynamic>)
              as SExpression,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFormalParameterDefaultClause(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    value.accept(visitor);
  }
}

/// What follows the name of a function-typed parameter: `<T>(params)?` in
/// `int cb<T>(T x)?`. Mirrors analyzer's
/// `FunctionTypedFormalParameterSuffix`; the parameter's `type` is then the
/// function's return type.
class SFunctionTypedFormalParameterSuffix extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final STypeParameterList? typeParameters;
  final SFormalParameterList formalParameters;

  /// Whether the suffix ends in `?` (a nullable function type).
  final bool isNullable;

  SFunctionTypedFormalParameterSuffix({
    required this.offset,
    required this.length,
    this.typeParameters,
    required this.formalParameters,
    this.isNullable = false,
  });

  @override
  String get nodeType => 'FunctionTypedFormalParameterSuffix';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    'formalParameters': formalParameters.toJson(),
    'isNullable': isNullable,
  };

  factory SFunctionTypedFormalParameterSuffix.fromJson(
    Map<String, dynamic> json,
  ) {
    return SFunctionTypedFormalParameterSuffix(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeParameters: json['typeParameters'] != null
          ? STypeParameterList.fromJson(
              json['typeParameters'] as Map<String, dynamic>,
            )
          : null,
      formalParameters: SFormalParameterList.fromJson(
        json['formalParameters'] as Map<String, dynamic>,
      ),
      isNullable: json['isNullable'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFunctionTypedFormalParameterSuffix(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeParameters?.accept(visitor);
    formalParameters.accept(visitor);
  }
}

/// A parameter declared by name: `int x`, `[int x = 0]`, `{required int x}`,
/// `int cb(String s)`. Mirrors analyzer's `RegularFormalParameter`.
class SRegularFormalParameter extends SFormalParameter {
  SRegularFormalParameter({
    required super.offset,
    required super.length,
    super.name,
    super.type,
    super.metadata,
    super.isConst,
    super.isFinal,
    super.isCovariant,
    super.isRequired,
    super.isNamed,
    super.defaultClause,
    super.functionTypedSuffix,
  });

  @override
  String get nodeType => 'RegularFormalParameter';

  factory SRegularFormalParameter.fromJson(Map<String, dynamic> json) {
    final f = SFormalParameter._fieldsFromJson(json);
    return SRegularFormalParameter(
      offset: f.offset,
      length: f.length,
      name: f.name,
      type: f.type,
      metadata: f.metadata,
      isConst: f.isConst,
      isFinal: f.isFinal,
      isCovariant: f.isCovariant,
      isRequired: f.isRequired,
      isNamed: f.isNamed,
      defaultClause: f.defaultClause,
      functionTypedSuffix: f.functionTypedSuffix,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitRegularFormalParameter(this);
}

/// A field-initializing parameter: `this.x`. Mirrors analyzer's
/// `FieldFormalParameter`.
class SFieldFormalParameter extends SFormalParameter {
  SFieldFormalParameter({
    required super.offset,
    required super.length,
    super.name,
    super.type,
    super.metadata,
    super.isConst,
    super.isFinal,
    super.isCovariant,
    super.isRequired,
    super.isNamed,
    super.defaultClause,
    super.functionTypedSuffix,
  });

  @override
  String get nodeType => 'FieldFormalParameter';

  factory SFieldFormalParameter.fromJson(Map<String, dynamic> json) {
    final f = SFormalParameter._fieldsFromJson(json);
    return SFieldFormalParameter(
      offset: f.offset,
      length: f.length,
      name: f.name,
      type: f.type,
      metadata: f.metadata,
      isConst: f.isConst,
      isFinal: f.isFinal,
      isCovariant: f.isCovariant,
      isRequired: f.isRequired,
      isNamed: f.isNamed,
      defaultClause: f.defaultClause,
      functionTypedSuffix: f.functionTypedSuffix,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFieldFormalParameter(this);
}

/// A super-forwarding parameter: `super.x`. Mirrors analyzer's
/// `SuperFormalParameter`.
class SSuperFormalParameter extends SFormalParameter {
  SSuperFormalParameter({
    required super.offset,
    required super.length,
    super.name,
    super.type,
    super.metadata,
    super.isConst,
    super.isFinal,
    super.isCovariant,
    super.isRequired,
    super.isNamed,
    super.defaultClause,
    super.functionTypedSuffix,
  });

  @override
  String get nodeType => 'SuperFormalParameter';

  factory SSuperFormalParameter.fromJson(Map<String, dynamic> json) {
    final f = SFormalParameter._fieldsFromJson(json);
    return SSuperFormalParameter(
      offset: f.offset,
      length: f.length,
      name: f.name,
      type: f.type,
      metadata: f.metadata,
      isConst: f.isConst,
      isFinal: f.isFinal,
      isCovariant: f.isCovariant,
      isRequired: f.isRequired,
      isNamed: f.isNamed,
      defaultClause: f.defaultClause,
      functionTypedSuffix: f.functionTypedSuffix,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitSuperFormalParameter(this);
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
