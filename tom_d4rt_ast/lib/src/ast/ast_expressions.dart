// Serializable AST expressions
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Identifiers
// ============================================================================

class SSimpleIdentifier extends SAstNode {
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
  String toString() => 'SSimpleIdentifier($name)';
}

class SPrefixedIdentifier extends SAstNode {
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
              json['identifier'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Binary Expression
// ============================================================================

class SBinaryExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? leftOperand;
  final String operator;
  final SAstNode? rightOperand;

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
      leftOperand: SAstNodeFactory.fromJson(
          json['leftOperand'] as Map<String, dynamic>?),
      operator: json['operator'] as String,
      rightOperand: SAstNodeFactory.fromJson(
          json['rightOperand'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Prefix Expression
// ============================================================================

class SPrefixExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String operator;
  final SAstNode? operand;

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
          SAstNodeFactory.fromJson(json['operand'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Postfix Expression
// ============================================================================

class SPostfixExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? operand;
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
          SAstNodeFactory.fromJson(json['operand'] as Map<String, dynamic>?),
      operator: json['operator'] as String,
    );
  }
}

// ============================================================================
// Conditional Expression
// ============================================================================

class SConditionalExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? thenExpression;
  final SAstNode? elseExpression;

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
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      thenExpression: SAstNodeFactory.fromJson(
          json['thenExpression'] as Map<String, dynamic>?),
      elseExpression: SAstNodeFactory.fromJson(
          json['elseExpression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Assignment Expression
// ============================================================================

class SAssignmentExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? leftHandSide;
  final String operator;
  final SAstNode? rightHandSide;

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
      leftHandSide: SAstNodeFactory.fromJson(
          json['leftHandSide'] as Map<String, dynamic>?),
      operator: json['operator'] as String,
      rightHandSide: SAstNodeFactory.fromJson(
          json['rightHandSide'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Method Invocation
// ============================================================================

class SMethodInvocation extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? target;
  final String? operator;
  final SSimpleIdentifier? methodName;
  final STypeArgumentList? typeArguments;
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
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?),
      operator: json['operator'] as String?,
      methodName: json['methodName'] != null
          ? SSimpleIdentifier.fromJson(
              json['methodName'] as Map<String, dynamic>)
          : null,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>)
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Function Expression Invocation
// ============================================================================

class SFunctionExpressionInvocation extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? function;
  final STypeArgumentList? typeArguments;
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
          SAstNodeFactory.fromJson(json['function'] as Map<String, dynamic>?),
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>)
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Index Expression
// ============================================================================

class SIndexExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? target;
  final SAstNode? index;
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
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?),
      index: SAstNodeFactory.fromJson(json['index'] as Map<String, dynamic>?),
      isCascaded: json['isCascaded'] as bool? ?? false,
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }
}

// ============================================================================
// Property Access
// ============================================================================

class SPropertyAccess extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? target;
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
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?),
      operator: json['operator'] as String?,
      propertyName: json['propertyName'] != null
          ? SSimpleIdentifier.fromJson(
              json['propertyName'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Parenthesized Expression
// ============================================================================

class SParenthesizedExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Function Expression
// ============================================================================

class SFunctionExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final STypeParameterList? typeParameters;
  final SFormalParameterList? parameters;
  final SAstNode? body;

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
              json['typeParameters'] as Map<String, dynamic>)
          : null,
      parameters: json['parameters'] != null
          ? SFormalParameterList.fromJson(
              json['parameters'] as Map<String, dynamic>)
          : null,
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Instance Creation Expression
// ============================================================================

class SInstanceCreationExpression extends SAstNode {
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
        if (constructorName != null)
          'constructorName': constructorName!.toJson(),
        if (argumentList != null) 'argumentList': argumentList!.toJson(),
      };

  factory SInstanceCreationExpression.fromJson(Map<String, dynamic> json) {
    return SInstanceCreationExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      isConst: json['isConst'] as bool? ?? false,
      constructorName: json['constructorName'] != null
          ? SConstructorName.fromJson(
              json['constructorName'] as Map<String, dynamic>)
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// This/Super Expressions
// ============================================================================

class SThisExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  SThisExpression({
    required this.offset,
    required this.length,
  });

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
}

class SSuperExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  SSuperExpression({
    required this.offset,
    required this.length,
  });

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
}

// ============================================================================
// Throw Expression
// ============================================================================

class SThrowExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Await Expression
// ============================================================================

class SAwaitExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Type Cast/Check Expressions
// ============================================================================

class SAsExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;
  final SAstNode? type;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?),
    );
  }
}

class SIsExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;
  final bool isNot;
  final SAstNode? type;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      isNot: json['isNot'] as bool? ?? false,
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Cascade Expression
// ============================================================================

class SCascadeExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? target;
  final List<SAstNode> cascadeSections;
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
        'cascadeSections':
            cascadeSections.map((c) => c.toJson()).toList(),
        'isNullAware': isNullAware,
      };

  factory SCascadeExpression.fromJson(Map<String, dynamic> json) {
    return SCascadeExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      target:
          SAstNodeFactory.fromJson(json['target'] as Map<String, dynamic>?),
      cascadeSections:
          SAstNodeFactory.listFromJson(json['cascadeSections'] as List?),
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }
}

// ============================================================================
// Rethrow Expression
// ============================================================================

class SRethrowExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  SRethrowExpression({
    required this.offset,
    required this.length,
  });

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
}

// ============================================================================
// Named Expression
// ============================================================================

class SNamedExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SLabel? name;
  final SAstNode? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Collection Elements (for list/set/map spread and control flow)
// ============================================================================

class SSpreadElement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;
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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      isNullAware: json['isNullAware'] as bool? ?? false,
    );
  }
}

class SIfElement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? thenElement;
  final SAstNode? elseElement;

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
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      thenElement: SAstNodeFactory.fromJson(
          json['thenElement'] as Map<String, dynamic>?),
      elseElement: SAstNodeFactory.fromJson(
          json['elseElement'] as Map<String, dynamic>?),
    );
  }
}

class SForElement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? forLoopParts;
  final SAstNode? body;

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
      forLoopParts: SAstNodeFactory.fromJson(
          json['forLoopParts'] as Map<String, dynamic>?),
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
    );
  }
}
