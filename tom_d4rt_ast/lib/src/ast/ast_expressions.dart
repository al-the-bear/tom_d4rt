// Serializable AST expressions
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Identifiers
// ============================================================================

class SSimpleIdentifier extends SIdentifier {
  @override
  final int offset;
  @override
  final int length;

  final String name;

  /// Whether this is a declaration (vs reference)
  final bool inDeclarationContext;

  SSimpleIdentifier({
    required this.offset,
    required this.length,
    required this.name,
    this.inDeclarationContext = false,
  });

  @override
  String get identifierName => name;

  @override
  String get nodeType => 'SimpleIdentifier';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'name': name,
    'inDeclarationContext': inDeclarationContext,
  };

  factory SSimpleIdentifier.fromJson(Map<String, dynamic> json) {
    return SSimpleIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] as String,
      inDeclarationContext: json['inDeclarationContext'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSimpleIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {}

  @override
  String toString() => 'SSimpleIdentifier($name)';
}

class SPrefixedIdentifier extends SIdentifier {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? prefix;
  final SSimpleIdentifier? identifier;

  SPrefixedIdentifier({
    required this.offset,
    required this.length,
    this.prefix,
    this.identifier,
  });

  @override
  String get identifierName =>
      '${prefix?.name ?? ''}.${identifier?.name ?? ''}';

  @override
  String get nodeType => 'PrefixedIdentifier';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (prefix != null) 'prefix': prefix!.toJson(),
    if (identifier != null) 'identifier': identifier!.toJson(),
  };

  factory SPrefixedIdentifier.fromJson(Map<String, dynamic> json) {
    return SPrefixedIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      prefix: json['prefix'] != null
          ? SSimpleIdentifier.fromJson(json['prefix'] as Map<String, dynamic>)
          : null,
      identifier: json['identifier'] != null
          ? SSimpleIdentifier.fromJson(
              json['identifier'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPrefixedIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    prefix?.accept(visitor);
    identifier?.accept(visitor);
  }
}

// ============================================================================
// Binary Expression
// ============================================================================

class SBinaryExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? leftOperand;
  final String operator;
  final SExpression? rightOperand;

  SBinaryExpression({
    required this.offset,
    required this.length,
    this.leftOperand,
    required this.operator,
    this.rightOperand,
  });

  @override
  String get nodeType => 'BinaryExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (leftOperand != null) 'leftOperand': leftOperand!.toJson(),
    'operator': operator,
    if (rightOperand != null) 'rightOperand': rightOperand!.toJson(),
  };

  factory SBinaryExpression.fromJson(Map<String, dynamic> json) {
    return SBinaryExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      leftOperand:
          SAstNodeFactory.fromJson(json['leftOperand'] as Map<String, dynamic>?)
              as SExpression?,
      operator: json['operator'] as String,
      rightOperand:
          SAstNodeFactory.fromJson(
                json['rightOperand'] as Map<String, dynamic>?,
              )
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBinaryExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    leftOperand?.accept(visitor);
    rightOperand?.accept(visitor);
  }
}

// ============================================================================
// Prefix Expression
// ============================================================================

class SPrefixExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final String operator;
  final SExpression? operand;

  SPrefixExpression({
    required this.offset,
    required this.length,
    required this.operator,
    this.operand,
  });

  @override
  String get nodeType => 'PrefixExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'operator': operator,
    if (operand != null) 'operand': operand!.toJson(),
  };

  factory SPrefixExpression.fromJson(Map<String, dynamic> json) {
    return SPrefixExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      operator: json['operator'] as String,
      operand:
          SAstNodeFactory.fromJson(json['operand'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPrefixExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    operand?.accept(visitor);
  }
}

// ============================================================================
// Postfix Expression
// ============================================================================

class SPostfixExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? operand;
  final String operator;

  SPostfixExpression({
    required this.offset,
    required this.length,
    this.operand,
    required this.operator,
  });

  @override
  String get nodeType => 'PostfixExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (operand != null) 'operand': operand!.toJson(),
    'operator': operator,
  };

  factory SPostfixExpression.fromJson(Map<String, dynamic> json) {
    return SPostfixExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      operand:
          SAstNodeFactory.fromJson(json['operand'] as Map<String, dynamic>?)
              as SExpression?,
      operator: json['operator'] as String,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPostfixExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    operand?.accept(visitor);
  }
}

// ============================================================================
// Conditional Expression
// ============================================================================

class SConditionalExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? condition;
  final SExpression? thenExpression;
  final SExpression? elseExpression;

  SConditionalExpression({
    required this.offset,
    required this.length,
    this.condition,
    this.thenExpression,
    this.elseExpression,
  });

  @override
  String get nodeType => 'ConditionalExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (condition != null) 'condition': condition!.toJson(),
    if (thenExpression != null) 'thenExpression': thenExpression!.toJson(),
    if (elseExpression != null) 'elseExpression': elseExpression!.toJson(),
  };

  factory SConditionalExpression.fromJson(Map<String, dynamic> json) {
    return SConditionalExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      thenExpression:
          SAstNodeFactory.fromJson(
                json['thenExpression'] as Map<String, dynamic>?,
              )
              as SExpression?,
      elseExpression:
          SAstNodeFactory.fromJson(
                json['elseExpression'] as Map<String, dynamic>?,
              )
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitConditionalExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    condition?.accept(visitor);
    thenExpression?.accept(visitor);
    elseExpression?.accept(visitor);
  }
}

// ============================================================================
// Assignment Expression
// ============================================================================

class SAssignmentExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? leftHandSide;
  final String operator;
  final SExpression? rightHandSide;

  SAssignmentExpression({
    required this.offset,
    required this.length,
    this.leftHandSide,
    required this.operator,
    this.rightHandSide,
  });

  @override
  String get nodeType => 'AssignmentExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (leftHandSide != null) 'leftHandSide': leftHandSide!.toJson(),
    'operator': operator,
    if (rightHandSide != null) 'rightHandSide': rightHandSide!.toJson(),
  };

  factory SAssignmentExpression.fromJson(Map<String, dynamic> json) {
    return SAssignmentExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      leftHandSide:
          SAstNodeFactory.fromJson(
                json['leftHandSide'] as Map<String, dynamic>?,
              )
              as SExpression?,
      operator: json['operator'] as String,
      rightHandSide:
          SAstNodeFactory.fromJson(
                json['rightHandSide'] as Map<String, dynamic>?,
              )
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitAssignmentExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    leftHandSide?.accept(visitor);
    rightHandSide?.accept(visitor);
  }
}

// ============================================================================
// Method Invocation
// ============================================================================

class SMethodInvocation extends SInvocationExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? target;
  final String? operator;
  final SSimpleIdentifier? methodName;
  final STypeArgumentList? typeArguments;
  @override
  final SArgumentList? argumentList;

  SMethodInvocation({
    required this.offset,
    required this.length,
    this.target,
    this.operator,
    this.methodName,
    this.typeArguments,
    this.argumentList,
  });

  @override
  String get nodeType => 'MethodInvocation';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (target != null) 'target': target!.toJson(),
    if (operator != null) 'operator': operator,
    if (methodName != null) 'methodName': methodName!.toJson(),
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    if (argumentList != null) 'argumentList': argumentList!.toJson(),
  };

  factory SMethodInvocation.fromJson(Map<String, dynamic> json) {
    return SMethodInvocation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      target:
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?)
              as SExpression?,
      operator: json['operator'] as String?,
      methodName: json['methodName'] != null
          ? SSimpleIdentifier.fromJson(
              json['methodName'] as Map<String, dynamic>,
            )
          : null,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitMethodInvocation(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    target?.accept(visitor);
    methodName?.accept(visitor);
    typeArguments?.accept(visitor);
    argumentList?.accept(visitor);
  }
}

// ============================================================================
// Function Expression Invocation
// ============================================================================

class SFunctionExpressionInvocation extends SInvocationExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? function;
  final STypeArgumentList? typeArguments;
  @override
  final SArgumentList? argumentList;

  SFunctionExpressionInvocation({
    required this.offset,
    required this.length,
    this.function,
    this.typeArguments,
    this.argumentList,
  });

  @override
  String get nodeType => 'FunctionExpressionInvocation';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (function != null) 'function': function!.toJson(),
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
    if (argumentList != null) 'argumentList': argumentList!.toJson(),
  };

  factory SFunctionExpressionInvocation.fromJson(Map<String, dynamic> json) {
    return SFunctionExpressionInvocation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      function:
          SAstNodeFactory.fromJson(json['function'] as Map<String, dynamic>?)
              as SExpression?,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>,
            )
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFunctionExpressionInvocation(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    function?.accept(visitor);
    typeArguments?.accept(visitor);
    argumentList?.accept(visitor);
  }
}

// ============================================================================
// Index Expression
// ============================================================================

class SIndexExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? target;
  final SExpression? index;
  final bool isCascaded;
  final bool isNullAware;

  SIndexExpression({
    required this.offset,
    required this.length,
    this.target,
    this.index,
    this.isCascaded = false,
    this.isNullAware = false,
  });

  @override
  String get nodeType => 'IndexExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (target != null) 'target': target!.toJson(),
    if (index != null) 'index': index!.toJson(),
    'isCascaded': isCascaded,
    'isNullAware': isNullAware,
  };

  factory SIndexExpression.fromJson(Map<String, dynamic> json) {
    return SIndexExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      target:
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?)
              as SExpression?,
      index:
          SAstNodeFactory.fromJson(json['index'] as Map<String, dynamic>?)
              as SExpression?,
      isCascaded: json['isCascaded'] as bool? ?? false,
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitIndexExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    target?.accept(visitor);
    index?.accept(visitor);
  }
}

// ============================================================================
// Property Access
// ============================================================================

class SPropertyAccess extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? target;
  final String? operator;
  final SSimpleIdentifier? propertyName;

  SPropertyAccess({
    required this.offset,
    required this.length,
    this.target,
    this.operator,
    this.propertyName,
  });

  @override
  String get nodeType => 'PropertyAccess';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (target != null) 'target': target!.toJson(),
    if (operator != null) 'operator': operator,
    if (propertyName != null) 'propertyName': propertyName!.toJson(),
  };

  factory SPropertyAccess.fromJson(Map<String, dynamic> json) {
    return SPropertyAccess(
      offset: json['offset'] as int,
      length: json['length'] as int,
      target:
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?)
              as SExpression?,
      operator: json['operator'] as String?,
      propertyName: json['propertyName'] != null
          ? SSimpleIdentifier.fromJson(
              json['propertyName'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPropertyAccess(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    target?.accept(visitor);
    propertyName?.accept(visitor);
  }
}

// ============================================================================
// Parenthesized Expression
// ============================================================================

class SParenthesizedExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

  SParenthesizedExpression({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'ParenthesizedExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
  };

  factory SParenthesizedExpression.fromJson(Map<String, dynamic> json) {
    return SParenthesizedExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitParenthesizedExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// Function Expression
// ============================================================================

class SFunctionExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final STypeParameterList? typeParameters;
  final SFormalParameterList? parameters;
  final SFunctionBody? body;

  SFunctionExpression({
    required this.offset,
    required this.length,
    this.typeParameters,
    this.parameters,
    this.body,
  });

  @override
  String get nodeType => 'FunctionExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (typeParameters != null) 'typeParameters': typeParameters!.toJson(),
    if (parameters != null) 'parameters': parameters!.toJson(),
    if (body != null) 'body': body!.toJson(),
  };

  factory SFunctionExpression.fromJson(Map<String, dynamic> json) {
    return SFunctionExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
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
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitFunctionExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    typeParameters?.accept(visitor);
    parameters?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Instance Creation Expression
// ============================================================================

class SInstanceCreationExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final bool isConst;
  final SConstructorName? constructorName;
  final SArgumentList? argumentList;

  SInstanceCreationExpression({
    required this.offset,
    required this.length,
    this.isConst = false,
    this.constructorName,
    this.argumentList,
  });

  @override
  String get nodeType => 'InstanceCreationExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'isConst': isConst,
    if (constructorName != null) 'constructorName': constructorName!.toJson(),
    if (argumentList != null) 'argumentList': argumentList!.toJson(),
  };

  factory SInstanceCreationExpression.fromJson(Map<String, dynamic> json) {
    return SInstanceCreationExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      isConst: json['isConst'] as bool? ?? false,
      constructorName: json['constructorName'] != null
          ? SConstructorName.fromJson(
              json['constructorName'] as Map<String, dynamic>,
            )
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitInstanceCreationExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    constructorName?.accept(visitor);
    argumentList?.accept(visitor);
  }
}

// ============================================================================
// This/Super Expressions
// ============================================================================

class SThisExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  SThisExpression({required this.offset, required this.length});

  @override
  String get nodeType => 'ThisExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SThisExpression.fromJson(Map<String, dynamic> json) {
    return SThisExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitThisExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

class SSuperExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  SSuperExpression({required this.offset, required this.length});

  @override
  String get nodeType => 'SuperExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SSuperExpression.fromJson(Map<String, dynamic> json) {
    return SSuperExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSuperExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Throw Expression
// ============================================================================

class SThrowExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

  SThrowExpression({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'ThrowExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
  };

  factory SThrowExpression.fromJson(Map<String, dynamic> json) {
    return SThrowExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitThrowExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// Await Expression
// ============================================================================

class SAwaitExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

  SAwaitExpression({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'AwaitExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
  };

  factory SAwaitExpression.fromJson(Map<String, dynamic> json) {
    return SAwaitExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitAwaitExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// Type Cast/Check Expressions
// ============================================================================

class SAsExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
  final STypeAnnotation? type;

  SAsExpression({
    required this.offset,
    required this.length,
    this.expression,
    this.type,
  });

  @override
  String get nodeType => 'AsExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
    if (type != null) 'type': type!.toJson(),
  };

  factory SAsExpression.fromJson(Map<String, dynamic> json) {
    return SAsExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitAsExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
    type?.accept(visitor);
  }
}

class SIsExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
  final bool isNot;
  final STypeAnnotation? type;

  SIsExpression({
    required this.offset,
    required this.length,
    this.expression,
    this.isNot = false,
    this.type,
  });

  @override
  String get nodeType => 'IsExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
    'isNot': isNot,
    if (type != null) 'type': type!.toJson(),
  };

  factory SIsExpression.fromJson(Map<String, dynamic> json) {
    return SIsExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      isNot: json['isNot'] as bool? ?? false,
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitIsExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
    type?.accept(visitor);
  }
}

// ============================================================================
// Cascade Expression
// ============================================================================

class SCascadeExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? target;
  final List<SExpression> cascadeSections;
  final bool isNullAware;

  SCascadeExpression({
    required this.offset,
    required this.length,
    this.target,
    this.cascadeSections = const [],
    this.isNullAware = false,
  });

  @override
  String get nodeType => 'CascadeExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (target != null) 'target': target!.toJson(),
    'cascadeSections': cascadeSections.map((c) => c.toJson()).toList(),
    'isNullAware': isNullAware,
  };

  factory SCascadeExpression.fromJson(Map<String, dynamic> json) {
    return SCascadeExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      target:
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?)
              as SExpression?,
      cascadeSections: SAstNodeFactory.listFromJson<SExpression>(
        json['cascadeSections'] as List?,
      ),
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitCascadeExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    target?.accept(visitor);
    for (final child in cascadeSections) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Rethrow Expression
// ============================================================================

class SRethrowExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  SRethrowExpression({required this.offset, required this.length});

  @override
  String get nodeType => 'RethrowExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
  };

  factory SRethrowExpression.fromJson(Map<String, dynamic> json) {
    return SRethrowExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitRethrowExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Named Expression
// ============================================================================

class SNamedExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  final SLabel? name;
  final SExpression? expression;

  SNamedExpression({
    required this.offset,
    required this.length,
    this.name,
    this.expression,
  });

  @override
  String get nodeType => 'NamedExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (expression != null) 'expression': expression!.toJson(),
  };

  factory SNamedExpression.fromJson(Map<String, dynamic> json) {
    return SNamedExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SLabel.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNamedExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    expression?.accept(visitor);
  }
}

// ============================================================================
// Collection Elements (for list/set/map spread and control flow)
// ============================================================================

class SSpreadElement extends SCollectionElement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
  final bool isNullAware;

  SSpreadElement({
    required this.offset,
    required this.length,
    this.expression,
    this.isNullAware = false,
  });

  @override
  String get nodeType => 'SpreadElement';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (expression != null) 'expression': expression!.toJson(),
    'isNullAware': isNullAware,
  };

  factory SSpreadElement.fromJson(Map<String, dynamic> json) {
    return SSpreadElement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSpreadElement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

class SIfElement extends SCollectionElement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? condition;
  final SCollectionElement? thenElement;
  final SCollectionElement? elseElement;

  SIfElement({
    required this.offset,
    required this.length,
    this.condition,
    this.thenElement,
    this.elseElement,
  });

  @override
  String get nodeType => 'IfElement';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (condition != null) 'condition': condition!.toJson(),
    if (thenElement != null) 'thenElement': thenElement!.toJson(),
    if (elseElement != null) 'elseElement': elseElement!.toJson(),
  };

  factory SIfElement.fromJson(Map<String, dynamic> json) {
    return SIfElement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      thenElement:
          SAstNodeFactory.fromJson(json['thenElement'] as Map<String, dynamic>?)
              as SCollectionElement?,
      elseElement:
          SAstNodeFactory.fromJson(json['elseElement'] as Map<String, dynamic>?)
              as SCollectionElement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitIfElement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    condition?.accept(visitor);
    thenElement?.accept(visitor);
    elseElement?.accept(visitor);
  }
}

class SForElement extends SCollectionElement {
  @override
  final int offset;
  @override
  final int length;

  final SForLoopParts? forLoopParts;
  final SCollectionElement? body;

  SForElement({
    required this.offset,
    required this.length,
    this.forLoopParts,
    this.body,
  });

  @override
  String get nodeType => 'ForElement';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (forLoopParts != null) 'forLoopParts': forLoopParts!.toJson(),
    if (body != null) 'body': body!.toJson(),
  };

  factory SForElement.fromJson(Map<String, dynamic> json) {
    return SForElement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      forLoopParts:
          SAstNodeFactory.fromJson(
                json['forLoopParts'] as Map<String, dynamic>?,
              )
              as SForLoopParts?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SCollectionElement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitForElement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    forLoopParts?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Switch Expression
// ============================================================================

/// A switch expression: `switch (expr) { case1 => val1, ... }`
class SSwitchExpression extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  /// The expression being switched on
  final SExpression expression;

  /// The cases (list of [SSwitchExpressionCase])
  final List<SSwitchExpressionCase> cases;

  SSwitchExpression({
    required this.offset,
    required this.length,
    required this.expression,
    this.cases = const [],
  });

  @override
  String get nodeType => 'SwitchExpression';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'expression': expression.toJson(),
    'cases': cases.map((c) => c.toJson()).toList(),
  };

  factory SSwitchExpression.fromJson(Map<String, dynamic> json) {
    return SSwitchExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression,
      cases: SAstNodeFactory.listFromJson<SSwitchExpressionCase>(
        json['cases'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSwitchExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression.accept(visitor);
    for (final child in cases) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Function Reference
// ============================================================================

/// A function reference expression: `myFunc<int>` (tear-off with type args)
class SFunctionReference extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  /// The function expression (identifier, property access, etc.)
  final SExpression function;

  /// Optional explicit type arguments
  final STypeArgumentList? typeArguments;

  SFunctionReference({
    required this.offset,
    required this.length,
    required this.function,
    this.typeArguments,
  });

  @override
  String get nodeType => 'FunctionReference';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'function': function.toJson(),
    if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
  };

  factory SFunctionReference.fromJson(Map<String, dynamic> json) {
    return SFunctionReference(
      offset: json['offset'] as int,
      length: json['length'] as int,
      function:
          SAstNodeFactory.fromJson(json['function'] as Map<String, dynamic>?)
              as SExpression,
      typeArguments:
          SAstNodeFactory.fromJson(
                json['typeArguments'] as Map<String, dynamic>?,
              )
              as STypeArgumentList?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitFunctionReference(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    function.accept(visitor);
    typeArguments?.accept(visitor);
  }
}

// ============================================================================
// Constructor Reference
// ============================================================================

/// A constructor reference expression: `MyClass.new` or `MyClass<T>.named`
class SConstructorReference extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  /// The constructor name (includes type and optional named constructor)
  final SConstructorName constructorName;

  SConstructorReference({
    required this.offset,
    required this.length,
    required this.constructorName,
  });

  @override
  String get nodeType => 'ConstructorReference';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'constructorName': constructorName.toJson(),
  };

  factory SConstructorReference.fromJson(Map<String, dynamic> json) {
    return SConstructorReference(
      offset: json['offset'] as int,
      length: json['length'] as int,
      constructorName:
          SAstNodeFactory.fromJson(
                json['constructorName'] as Map<String, dynamic>?,
              )
              as SConstructorName,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitConstructorReference(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    constructorName.accept(visitor);
  }
}

// ============================================================================
// Pattern Assignment
// ============================================================================

/// A pattern assignment expression: `(a, b) = expr`
class SPatternAssignment extends SExpression {
  @override
  final int offset;
  @override
  final int length;

  /// The pattern (left side)
  final SDartPattern pattern;

  /// The expression (right side)
  final SExpression expression;

  SPatternAssignment({
    required this.offset,
    required this.length,
    required this.pattern,
    required this.expression,
  });

  @override
  String get nodeType => 'PatternAssignment';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'pattern': pattern.toJson(),
    'expression': expression.toJson(),
  };

  factory SPatternAssignment.fromJson(Map<String, dynamic> json) {
    return SPatternAssignment(
      offset: json['offset'] as int,
      length: json['length'] as int,
      pattern:
          SAstNodeFactory.fromJson(json['pattern'] as Map<String, dynamic>?)
              as SDartPattern,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPatternAssignment(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    pattern.accept(visitor);
    expression.accept(visitor);
  }
}
