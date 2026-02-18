// Serializable AST patterns (Dart 3.0+)
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Guarded Pattern & When Clause
// ============================================================================

/// A pattern with an optional `when` guard clause.
class SGuardedPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode pattern;
  final SAstNode? whenClause;

  SGuardedPattern({
    required this.offset,
    required this.length,
    required this.pattern,
    this.whenClause,
  });

  @override
  String get nodeType => 'GuardedPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
    if (whenClause != null) 'whenClause': whenClause!.toJson(),
  };

  factory SGuardedPattern.fromJson(Map<String, dynamic> json) {
    return SGuardedPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
      whenClause: SAstNodeFactory.fromJson(
        json['whenClause'] as Map<String, dynamic>?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitGuardedPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
    whenClause?.accept(visitor);
  }
}

/// A `when` clause that guards a pattern with a boolean expression.
class SWhenClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode expression;

  SWhenClause({
    required this.offset,
    required this.length,
    required this.expression,
  });

  @override
  String get nodeType => 'WhenClause';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'expression': expression.toJson(),
  };

  factory SWhenClause.fromJson(Map<String, dynamic> json) {
    return SWhenClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression: SAstNodeFactory.fromJson(
        json['expression'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitWhenClause(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression.accept(visitor);
  }
}

/// A `case` clause used in if-case statements.
class SCaseClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode guardedPattern;

  SCaseClause({
    required this.offset,
    required this.length,
    required this.guardedPattern,
  });

  @override
  String get nodeType => 'CaseClause';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'guardedPattern': guardedPattern.toJson(),
  };

  factory SCaseClause.fromJson(Map<String, dynamic> json) {
    return SCaseClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      guardedPattern: SAstNodeFactory.fromJson(
        json['guardedPattern'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitCaseClause(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    guardedPattern.accept(visitor);
  }
}

// ============================================================================
// Constant & Wildcard Patterns
// ============================================================================

/// A constant expression pattern (e.g., `case 42:`, `case const Foo():`).
class SConstantPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String? constKeyword;
  final SAstNode expression;

  SConstantPattern({
    required this.offset,
    required this.length,
    this.constKeyword,
    required this.expression,
  });

  @override
  String get nodeType => 'ConstantPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (constKeyword != null) 'constKeyword': constKeyword,
    'expression': expression.toJson(),
  };

  factory SConstantPattern.fromJson(Map<String, dynamic> json) {
    return SConstantPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      constKeyword: json['constKeyword'] as String?,
      expression: SAstNodeFactory.fromJson(
        json['expression'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitConstantPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression.accept(visitor);
  }
}

/// A wildcard pattern `_`, optionally typed (e.g., `int _`, `var _`).
class SWildcardPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String? keyword;
  final String name;
  final SAstNode? type;

  SWildcardPattern({
    required this.offset,
    required this.length,
    this.keyword,
    required this.name,
    this.type,
  });

  @override
  String get nodeType => 'WildcardPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (keyword != null) 'keyword': keyword,
    'name': name,
    if (type != null) 'type': type!.toJson(),
  };

  factory SWildcardPattern.fromJson(Map<String, dynamic> json) {
    return SWildcardPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      keyword: json['keyword'] as String?,
      name: json['name'] as String,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitWildcardPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    type?.accept(visitor);
  }
}

// ============================================================================
// Variable Patterns
// ============================================================================

/// A declared variable pattern (e.g., `var x`, `int x`, `final String name`).
class SDeclaredVariablePattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String? keyword;
  final String name;
  final SAstNode? type;

  SDeclaredVariablePattern({
    required this.offset,
    required this.length,
    this.keyword,
    required this.name,
    this.type,
  });

  @override
  String get nodeType => 'DeclaredVariablePattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (keyword != null) 'keyword': keyword,
    'name': name,
    if (type != null) 'type': type!.toJson(),
  };

  factory SDeclaredVariablePattern.fromJson(Map<String, dynamic> json) {
    return SDeclaredVariablePattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      keyword: json['keyword'] as String?,
      name: json['name'] as String,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitDeclaredVariablePattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    type?.accept(visitor);
  }
}

/// An assigned variable pattern that binds to an existing variable.
class SAssignedVariablePattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String name;

  SAssignedVariablePattern({
    required this.offset,
    required this.length,
    required this.name,
  });

  @override
  String get nodeType => 'AssignedVariablePattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'name': name,
  };

  factory SAssignedVariablePattern.fromJson(Map<String, dynamic> json) {
    return SAssignedVariablePattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitAssignedVariablePattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Object Pattern
// ============================================================================

/// An object destructuring pattern (e.g., `MyType(field: pattern)`).
class SObjectPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode type;
  final List<SAstNode> fields;

  SObjectPattern({
    required this.offset,
    required this.length,
    required this.type,
    this.fields = const [],
  });

  @override
  String get nodeType => 'ObjectPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'type': type.toJson(),
    'fields': fields.map((e) => e.toJson()).toList(),
  };

  factory SObjectPattern.fromJson(Map<String, dynamic> json) {
    return SObjectPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)!,
      fields: SAstNodeFactory.listFromJson(json['fields'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitObjectPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    type.accept(visitor);
    for (final child in fields) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// List & Map Patterns
// ============================================================================

/// A list destructuring pattern (e.g., `[a, b, ...rest]`).
class SListPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? typeArguments;
  final List<SAstNode> elements;

  SListPattern({
    required this.offset,
    required this.length,
    this.typeArguments,
    this.elements = const [],
  });

  @override
  String get nodeType => 'ListPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    'elements': elements.map((e) => e.toJson()).toList(),
  };

  factory SListPattern.fromJson(Map<String, dynamic> json) {
    return SListPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeArguments: SAstNodeFactory.fromJson(
        json['typeArguments'] as Map<String, dynamic>?,
      ),
      elements: SAstNodeFactory.listFromJson(json['elements'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitListPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeArguments?.accept(visitor);
    for (final child in elements) {
      child.accept(visitor);
    }
  }
}

/// A map destructuring pattern (e.g., `{'key': valuePattern}`).
class SMapPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? typeArguments;
  final List<SAstNode> elements;

  SMapPattern({
    required this.offset,
    required this.length,
    this.typeArguments,
    this.elements = const [],
  });

  @override
  String get nodeType => 'MapPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    'elements': elements.map((e) => e.toJson()).toList(),
  };

  factory SMapPattern.fromJson(Map<String, dynamic> json) {
    return SMapPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      typeArguments: SAstNodeFactory.fromJson(
        json['typeArguments'] as Map<String, dynamic>?,
      ),
      elements: SAstNodeFactory.listFromJson(json['elements'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMapPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeArguments?.accept(visitor);
    for (final child in elements) {
      child.accept(visitor);
    }
  }
}

/// A single entry in a map pattern (e.g., `key: valuePattern`).
class SMapPatternEntry extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode key;
  final SAstNode value;

  SMapPatternEntry({
    required this.offset,
    required this.length,
    required this.key,
    required this.value,
  });

  @override
  String get nodeType => 'MapPatternEntry';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'key': key.toJson(),
    'value': value.toJson(),
  };

  factory SMapPatternEntry.fromJson(Map<String, dynamic> json) {
    return SMapPatternEntry(
      offset: json['offset'] as int,
      length: json['length'] as int,
      key: SAstNodeFactory.fromJson(json['key'] as Map<String, dynamic>?)!,
      value: SAstNodeFactory.fromJson(json['value'] as Map<String, dynamic>?)!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMapPatternEntry(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    key.accept(visitor);
    value.accept(visitor);
  }
}

// ============================================================================
// Record Pattern & Pattern Fields
// ============================================================================

/// A record destructuring pattern (e.g., `(pattern, name: pattern)`).
class SRecordPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SAstNode> fields;

  SRecordPattern({
    required this.offset,
    required this.length,
    this.fields = const [],
  });

  @override
  String get nodeType => 'RecordPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'fields': fields.map((e) => e.toJson()).toList(),
  };

  factory SRecordPattern.fromJson(Map<String, dynamic> json) {
    return SRecordPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      fields: SAstNodeFactory.listFromJson(json['fields'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRecordPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in fields) {
      child.accept(visitor);
    }
  }
}

/// A field in an object or record pattern.
class SPatternField extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The field name, or null for positional fields.
  final SAstNode? name;
  final SAstNode pattern;

  SPatternField({
    required this.offset,
    required this.length,
    this.name,
    required this.pattern,
  });

  @override
  String get nodeType => 'PatternField';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    'pattern': pattern.toJson(),
  };

  factory SPatternField.fromJson(Map<String, dynamic> json) {
    return SPatternField(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: SAstNodeFactory.fromJson(json['name'] as Map<String, dynamic>?),
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPatternField(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    pattern.accept(visitor);
  }
}

/// A field name identifier in a pattern field (null name for shorthand).
class SPatternFieldName extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The field name, or null for shorthand notation.
  final String? name;

  SPatternFieldName({required this.offset, required this.length, this.name});

  @override
  String get nodeType => 'PatternFieldName';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name,
  };

  factory SPatternFieldName.fromJson(Map<String, dynamic> json) {
    return SPatternFieldName(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] as String?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPatternFieldName(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Logical Patterns
// ============================================================================

/// A logical OR pattern (e.g., `pattern1 || pattern2`).
class SLogicalOrPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode leftOperand;
  final String operator;
  final SAstNode rightOperand;

  SLogicalOrPattern({
    required this.offset,
    required this.length,
    required this.leftOperand,
    required this.operator,
    required this.rightOperand,
  });

  @override
  String get nodeType => 'LogicalOrPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'leftOperand': leftOperand.toJson(),
    'operator': operator,
    'rightOperand': rightOperand.toJson(),
  };

  factory SLogicalOrPattern.fromJson(Map<String, dynamic> json) {
    return SLogicalOrPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      leftOperand: SAstNodeFactory.fromJson(
        json['leftOperand'] as Map<String, dynamic>?,
      )!,
      operator: json['operator'] as String,
      rightOperand: SAstNodeFactory.fromJson(
        json['rightOperand'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitLogicalOrPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    leftOperand.accept(visitor);
    rightOperand.accept(visitor);
  }
}

/// A logical AND pattern (e.g., `pattern1 && pattern2`).
class SLogicalAndPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode leftOperand;
  final String operator;
  final SAstNode rightOperand;

  SLogicalAndPattern({
    required this.offset,
    required this.length,
    required this.leftOperand,
    required this.operator,
    required this.rightOperand,
  });

  @override
  String get nodeType => 'LogicalAndPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'leftOperand': leftOperand.toJson(),
    'operator': operator,
    'rightOperand': rightOperand.toJson(),
  };

  factory SLogicalAndPattern.fromJson(Map<String, dynamic> json) {
    return SLogicalAndPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      leftOperand: SAstNodeFactory.fromJson(
        json['leftOperand'] as Map<String, dynamic>?,
      )!,
      operator: json['operator'] as String,
      rightOperand: SAstNodeFactory.fromJson(
        json['rightOperand'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitLogicalAndPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    leftOperand.accept(visitor);
    rightOperand.accept(visitor);
  }
}

// ============================================================================
// Cast & Relational Patterns
// ============================================================================

/// A cast pattern (e.g., `pattern as Type`).
class SCastPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode pattern;
  final SAstNode type;

  SCastPattern({
    required this.offset,
    required this.length,
    required this.pattern,
    required this.type,
  });

  @override
  String get nodeType => 'CastPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
    'type': type.toJson(),
  };

  factory SCastPattern.fromJson(Map<String, dynamic> json) {
    return SCastPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitCastPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
    type.accept(visitor);
  }
}

/// A relational pattern (e.g., `< 5`, `>= 10`).
class SRelationalPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String operator;
  final SAstNode operand;

  SRelationalPattern({
    required this.offset,
    required this.length,
    required this.operator,
    required this.operand,
  });

  @override
  String get nodeType => 'RelationalPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'operator': operator,
    'operand': operand.toJson(),
  };

  factory SRelationalPattern.fromJson(Map<String, dynamic> json) {
    return SRelationalPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      operator: json['operator'] as String,
      operand: SAstNodeFactory.fromJson(
        json['operand'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRelationalPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    operand.accept(visitor);
  }
}

// ============================================================================
// Null-Check & Null-Assert Patterns
// ============================================================================

/// A null-check pattern (e.g., `pattern?`).
class SNullCheckPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode pattern;
  final String operator;

  SNullCheckPattern({
    required this.offset,
    required this.length,
    required this.pattern,
    required this.operator,
  });

  @override
  String get nodeType => 'NullCheckPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
    'operator': operator,
  };

  factory SNullCheckPattern.fromJson(Map<String, dynamic> json) {
    return SNullCheckPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
      operator: json['operator'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNullCheckPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
  }
}

/// A null-assert pattern (e.g., `pattern!`).
class SNullAssertPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode pattern;
  final String operator;

  SNullAssertPattern({
    required this.offset,
    required this.length,
    required this.pattern,
    required this.operator,
  });

  @override
  String get nodeType => 'NullAssertPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
    'operator': operator,
  };

  factory SNullAssertPattern.fromJson(Map<String, dynamic> json) {
    return SNullAssertPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
      operator: json['operator'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNullAssertPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
  }
}

// ============================================================================
// Parenthesized & Rest Patterns
// ============================================================================

/// A parenthesized pattern (e.g., `(pattern)`).
class SParenthesizedPattern extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode pattern;

  SParenthesizedPattern({
    required this.offset,
    required this.length,
    required this.pattern,
  });

  @override
  String get nodeType => 'ParenthesizedPattern';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
  };

  factory SParenthesizedPattern.fromJson(Map<String, dynamic> json) {
    return SParenthesizedPattern(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitParenthesizedPattern(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
  }
}

/// A rest element in a list or map pattern (e.g., `...subPattern`).
class SRestPatternElement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? pattern;

  SRestPatternElement({
    required this.offset,
    required this.length,
    this.pattern,
  });

  @override
  String get nodeType => 'RestPatternElement';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (pattern != null) 'pattern': pattern!.toJson(),
  };

  factory SRestPatternElement.fromJson(Map<String, dynamic> json) {
    return SRestPatternElement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRestPatternElement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern?.accept(visitor);
  }
}

// ============================================================================
// Pattern Variable Declaration
// ============================================================================

/// A pattern variable declaration (e.g., `var (a, b) = expr`).
class SPatternVariableDeclaration extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String keyword;
  final SAstNode pattern;
  final SAstNode expression;

  SPatternVariableDeclaration({
    required this.offset,
    required this.length,
    required this.keyword,
    required this.pattern,
    required this.expression,
  });

  @override
  String get nodeType => 'PatternVariableDeclaration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'keyword': keyword,
    'pattern': pattern.toJson(),
    'expression': expression.toJson(),
  };

  factory SPatternVariableDeclaration.fromJson(Map<String, dynamic> json) {
    return SPatternVariableDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      keyword: json['keyword'] as String,
      pattern: SAstNodeFactory.fromJson(
        json['pattern'] as Map<String, dynamic>?,
      )!,
      expression: SAstNodeFactory.fromJson(
        json['expression'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitPatternVariableDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
    expression.accept(visitor);
  }
}

// ============================================================================
// Switch Pattern Cases
// ============================================================================

/// A case in a switch expression (e.g., `pattern => expression`).
class SSwitchExpressionCase extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode guardedPattern;
  final SAstNode expression;

  SSwitchExpressionCase({
    required this.offset,
    required this.length,
    required this.guardedPattern,
    required this.expression,
  });

  @override
  String get nodeType => 'SwitchExpressionCase';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'guardedPattern': guardedPattern.toJson(),
    'expression': expression.toJson(),
  };

  factory SSwitchExpressionCase.fromJson(Map<String, dynamic> json) {
    return SSwitchExpressionCase(
      offset: json['offset'] as int,
      length: json['length'] as int,
      guardedPattern: SAstNodeFactory.fromJson(
        json['guardedPattern'] as Map<String, dynamic>?,
      )!,
      expression: SAstNodeFactory.fromJson(
        json['expression'] as Map<String, dynamic>?,
      )!,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitSwitchExpressionCase(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    guardedPattern.accept(visitor);
    expression.accept(visitor);
  }
}

/// A Dart 3.0 switch statement case with pattern matching.
class SSwitchPatternCase extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SAstNode> labels;
  final SAstNode guardedPattern;
  final List<SAstNode> statements;

  SSwitchPatternCase({
    required this.offset,
    required this.length,
    this.labels = const [],
    required this.guardedPattern,
    this.statements = const [],
  });

  @override
  String get nodeType => 'SwitchPatternCase';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'labels': labels.map((e) => e.toJson()).toList(),
    'guardedPattern': guardedPattern.toJson(),
    'statements': statements.map((e) => e.toJson()).toList(),
  };

  factory SSwitchPatternCase.fromJson(Map<String, dynamic> json) {
    return SSwitchPatternCase(
      offset: json['offset'] as int,
      length: json['length'] as int,
      labels: SAstNodeFactory.listFromJson(json['labels'] as List?),
      guardedPattern: SAstNodeFactory.fromJson(
        json['guardedPattern'] as Map<String, dynamic>?,
      )!,
      statements: SAstNodeFactory.listFromJson(json['statements'] as List?),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSwitchPatternCase(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in labels) {
      child.accept(visitor);
    }
    guardedPattern.accept(visitor);
    for (final child in statements) {
      child.accept(visitor);
    }
  }
}
