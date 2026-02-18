// Serializable AST literals
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Integer Literal
// ============================================================================

class SIntegerLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  final int value;

  SIntegerLiteral({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'IntegerLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
  };

  factory SIntegerLiteral.fromJson(Map<String, dynamic> json) {
    return SIntegerLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: json['value'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitIntegerLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Double Literal
// ============================================================================

class SDoubleLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  final double value;

  SDoubleLiteral({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'DoubleLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
  };

  factory SDoubleLiteral.fromJson(Map<String, dynamic> json) {
    return SDoubleLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: (json['value'] as num).toDouble(),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitDoubleLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Boolean Literal
// ============================================================================

class SBooleanLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  final bool value;

  SBooleanLiteral({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'BooleanLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
  };

  factory SBooleanLiteral.fromJson(Map<String, dynamic> json) {
    return SBooleanLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: json['value'] as bool,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBooleanLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// String Literals
// ============================================================================

class SSimpleStringLiteral extends SSingleStringLiteral {
  @override
  final int offset;
  @override
  final int length;

  final String value;
  @override
  final bool isRaw;
  @override
  final bool isMultiline;
  final bool isSingleQuoted;

  SSimpleStringLiteral({
    required this.offset,
    required this.length,
    required this.value,
    this.isRaw = false,
    this.isMultiline = false,
    this.isSingleQuoted = true,
  });

  @override
  String get nodeType => 'SimpleStringLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
    'isRaw': isRaw,
    'isMultiline': isMultiline,
    'isSingleQuoted': isSingleQuoted,
  };

  factory SSimpleStringLiteral.fromJson(Map<String, dynamic> json) {
    return SSimpleStringLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: json['value'] as String,
      isRaw: json['isRaw'] as bool? ?? false,
      isMultiline: json['isMultiline'] as bool? ?? false,
      isSingleQuoted: json['isSingleQuoted'] as bool? ?? true,
    );
  }

  @override
  String? get stringValue => value;

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitSimpleStringLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

class SStringInterpolation extends SSingleStringLiteral {
  @override
  final int offset;
  @override
  final int length;

  final List<SInterpolationElement> elements;
  @override
  final bool isMultiline;
  @override
  final bool isRaw;

  SStringInterpolation({
    required this.offset,
    required this.length,
    this.elements = const [],
    this.isMultiline = false,
    this.isRaw = false,
  });

  @override
  String get nodeType => 'StringInterpolation';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'elements': elements.map((e) => e.toJson()).toList(),
    'isMultiline': isMultiline,
    'isRaw': isRaw,
  };

  factory SStringInterpolation.fromJson(Map<String, dynamic> json) {
    return SStringInterpolation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      elements: SAstNodeFactory.listFromJson<SInterpolationElement>(
        json['elements'] as List?,
      ),
      isMultiline: json['isMultiline'] as bool? ?? false,
      isRaw: json['isRaw'] as bool? ?? false,
    );
  }

  @override
  String? get stringValue => null;

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitStringInterpolation(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in elements) {
      child.accept(visitor);
    }
  }
}

class SInterpolationExpression extends SInterpolationElement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

  SInterpolationExpression({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'InterpolationExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
  };

  factory SInterpolationExpression.fromJson(Map<String, dynamic> json) {
    return SInterpolationExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitInterpolationExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

class SInterpolationString extends SInterpolationElement {
  @override
  final int offset;
  @override
  final int length;

  final String value;

  SInterpolationString({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'InterpolationString';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
  };

  factory SInterpolationString.fromJson(Map<String, dynamic> json) {
    return SInterpolationString(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: json['value'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitInterpolationString(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

class SAdjacentStrings extends SStringLiteral {
  @override
  final int offset;
  @override
  final int length;

  final List<SStringLiteral> strings;

  SAdjacentStrings({
    required this.offset,
    required this.length,
    this.strings = const [],
  });

  @override
  String get nodeType => 'AdjacentStrings';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'strings': strings.map((s) => s.toJson()).toList(),
  };

  factory SAdjacentStrings.fromJson(Map<String, dynamic> json) {
    return SAdjacentStrings(
      offset: json['offset'] as int,
      length: json['length'] as int,
      strings: SAstNodeFactory.listFromJson<SStringLiteral>(
        json['strings'] as List?,
      ),
    );
  }

  @override
  String? get stringValue => null;

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitAdjacentStrings(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in strings) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Null Literal
// ============================================================================

class SNullLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  SNullLiteral({required this.offset, required this.length});

  @override
  String get nodeType => 'NullLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SNullLiteral.fromJson(Map<String, dynamic> json) {
    return SNullLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNullLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Collection Literals
// ============================================================================

class SListLiteral extends STypedLiteral {
  @override
  final int offset;
  @override
  final int length;

  @override
  final STypeArgumentList? typeArguments;
  final List<SCollectionElement> elements;
  @override
  final bool isConst;

  SListLiteral({
    required this.offset,
    required this.length,
    this.typeArguments,
    this.elements = const [],
    this.isConst = false,
  });

  @override
  String get nodeType => 'ListLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    'elements': elements.map((e) => e.toJson()).toList(),
    'isConst': isConst,
  };

  factory SListLiteral.fromJson(Map<String, dynamic> json) {
    return SListLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      elements: SAstNodeFactory.listFromJson<SCollectionElement>(
        json['elements'] as List?,
      ),
      isConst: json['isConst'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitListLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeArguments?.accept(visitor);
    for (final child in elements) {
      child.accept(visitor);
    }
  }
}

class SSetOrMapLiteral extends STypedLiteral {
  @override
  final int offset;
  @override
  final int length;

  @override
  final STypeArgumentList? typeArguments;
  final List<SCollectionElement> elements;
  @override
  final bool isConst;
  final bool isMap;
  final bool isSet;

  SSetOrMapLiteral({
    required this.offset,
    required this.length,
    this.typeArguments,
    this.elements = const [],
    this.isConst = false,
    this.isMap = false,
    this.isSet = false,
  });

  @override
  String get nodeType => 'SetOrMapLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    'elements': elements.map((e) => e.toJson()).toList(),
    'isConst': isConst,
    'isMap': isMap,
    'isSet': isSet,
  };

  factory SSetOrMapLiteral.fromJson(Map<String, dynamic> json) {
    return SSetOrMapLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      elements: SAstNodeFactory.listFromJson<SCollectionElement>(
        json['elements'] as List?,
      ),
      isConst: json['isConst'] as bool? ?? false,
      isMap: json['isMap'] as bool? ?? false,
      isSet: json['isSet'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSetOrMapLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeArguments?.accept(visitor);
    for (final child in elements) {
      child.accept(visitor);
    }
  }
}

class SMapLiteralEntry extends SCollectionElement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? key;
  final SExpression? value;

  SMapLiteralEntry({
    required this.offset,
    required this.length,
    this.key,
    this.value,
  });

  @override
  String get nodeType => 'MapLiteralEntry';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (key != null) 'key': key!.toJson(),
    if (value != null) 'value': value!.toJson(),
  };

  factory SMapLiteralEntry.fromJson(Map<String, dynamic> json) {
    return SMapLiteralEntry(
      offset: json['offset'] as int,
      length: json['length'] as int,
      key:
          SAstNodeFactory.fromJson(json['key'] as Map<String, dynamic>?)
              as SExpression?,
      value:
          SAstNodeFactory.fromJson(json['value'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMapLiteralEntry(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    key?.accept(visitor);
    value?.accept(visitor);
  }
}

// ============================================================================
// Symbol Literal
// ============================================================================

class SSymbolLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  final String value;

  SSymbolLiteral({
    required this.offset,
    required this.length,
    required this.value,
  });

  @override
  String get nodeType => 'SymbolLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'value': value,
  };

  factory SSymbolLiteral.fromJson(Map<String, dynamic> json) {
    return SSymbolLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      value: json['value'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSymbolLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Record Literal
// ============================================================================

class SRecordLiteral extends SLiteral {
  @override
  final int offset;
  @override
  final int length;

  final List<SExpression> fields;
  final bool isConst;

  SRecordLiteral({
    required this.offset,
    required this.length,
    this.fields = const [],
    this.isConst = false,
  });

  @override
  String get nodeType => 'RecordLiteral';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'fields': fields.map((f) => f.toJson()).toList(),
    'isConst': isConst,
  };

  factory SRecordLiteral.fromJson(Map<String, dynamic> json) {
    return SRecordLiteral(
      offset: json['offset'] as int,
      length: json['length'] as int,
      fields: SAstNodeFactory.listFromJson<SExpression>(
        json['fields'] as List?,
      ),
      isConst: json['isConst'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRecordLiteral(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in fields) {
      child.accept(visitor);
    }
  }
}
