// Serializable AST statements
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Block
// ============================================================================

class SBlock extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SAstNode> statements;

  SBlock({
    required this.offset,
    required this.length,
    this.statements = const [],
  });

  @override
  String get nodeType => 'Block';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'statements': statements.map((s) => s.toJson()).toList(),
      };

  factory SBlock.fromJson(Map<String, dynamic> json) {
    return SBlock(
      offset: json['offset'] as int,
      length: json['length'] as int,
      statements: SAstNodeFactory.listFromJson(json['statements'] as List?),
    );
  }
}

// ============================================================================
// Variable Declaration Statement
// ============================================================================

class SVariableDeclarationStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SVariableDeclarationList? variables;

  SVariableDeclarationStatement({
    required this.offset,
    required this.length,
    this.variables,
  });

  @override
  String get nodeType => 'VariableDeclarationStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (variables != null) 'variables': variables!.toJson(),
      };

  factory SVariableDeclarationStatement.fromJson(Map<String, dynamic> json) {
    return SVariableDeclarationStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      variables: json['variables'] != null
          ? SVariableDeclarationList.fromJson(
              json['variables'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Expression Statement
// ============================================================================

class SExpressionStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;

  SExpressionStatement({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'ExpressionStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (expression != null) 'expression': expression!.toJson(),
      };

  factory SExpressionStatement.fromJson(Map<String, dynamic> json) {
    return SExpressionStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Return Statement
// ============================================================================

class SReturnStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;

  SReturnStatement({
    required this.offset,
    required this.length,
    this.expression,
  });

  @override
  String get nodeType => 'ReturnStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (expression != null) 'expression': expression!.toJson(),
      };

  factory SReturnStatement.fromJson(Map<String, dynamic> json) {
    return SReturnStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// If Statement
// ============================================================================

class SIfStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? thenStatement;
  final SAstNode? elseStatement;
  
  /// Whether this uses case pattern (if-case)
  final SAstNode? caseClause;

  SIfStatement({
    required this.offset,
    required this.length,
    this.condition,
    this.thenStatement,
    this.elseStatement,
    this.caseClause,
  });

  @override
  String get nodeType => 'IfStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (condition != null) 'condition': condition!.toJson(),
        if (thenStatement != null) 'thenStatement': thenStatement!.toJson(),
        if (elseStatement != null) 'elseStatement': elseStatement!.toJson(),
        if (caseClause != null) 'caseClause': caseClause!.toJson(),
      };

  factory SIfStatement.fromJson(Map<String, dynamic> json) {
    return SIfStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      thenStatement: SAstNodeFactory.fromJson(
          json['thenStatement'] as Map<String, dynamic>?),
      elseStatement: SAstNodeFactory.fromJson(
          json['elseStatement'] as Map<String, dynamic>?),
      caseClause:
          SAstNodeFactory.fromJson(json['caseClause'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// For Statement
// ============================================================================

class SForStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// For loop parts (initialization, condition, updaters)
  final SAstNode? forLoopParts;
  final SAstNode? body;

  SForStatement({
    required this.offset,
    required this.length,
    this.forLoopParts,
    this.body,
  });

  @override
  String get nodeType => 'ForStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (forLoopParts != null) 'forLoopParts': forLoopParts!.toJson(),
        if (body != null) 'body': body!.toJson(),
      };

  factory SForStatement.fromJson(Map<String, dynamic> json) {
    return SForStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      forLoopParts: SAstNodeFactory.fromJson(
          json['forLoopParts'] as Map<String, dynamic>?),
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
    );
  }
}

/// For loop parts for standard for loops
class SForPartsWithDeclarations extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SVariableDeclarationList? variables;
  final SAstNode? condition;
  final List<SAstNode> updaters;

  SForPartsWithDeclarations({
    required this.offset,
    required this.length,
    this.variables,
    this.condition,
    this.updaters = const [],
  });

  @override
  String get nodeType => 'ForPartsWithDeclarations';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (variables != null) 'variables': variables!.toJson(),
        if (condition != null) 'condition': condition!.toJson(),
        'updaters': updaters.map((u) => u.toJson()).toList(),
      };

  factory SForPartsWithDeclarations.fromJson(Map<String, dynamic> json) {
    return SForPartsWithDeclarations(
      offset: json['offset'] as int,
      length: json['length'] as int,
      variables: json['variables'] != null
          ? SVariableDeclarationList.fromJson(
              json['variables'] as Map<String, dynamic>)
          : null,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      updaters: SAstNodeFactory.listFromJson(json['updaters'] as List?),
    );
  }
}

/// For loop parts with an expression initializer
class SForPartsWithExpression extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? initialization;
  final SAstNode? condition;
  final List<SAstNode> updaters;

  SForPartsWithExpression({
    required this.offset,
    required this.length,
    this.initialization,
    this.condition,
    this.updaters = const [],
  });

  @override
  String get nodeType => 'ForPartsWithExpression';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (initialization != null) 'initialization': initialization!.toJson(),
        if (condition != null) 'condition': condition!.toJson(),
        'updaters': updaters.map((u) => u.toJson()).toList(),
      };

  factory SForPartsWithExpression.fromJson(Map<String, dynamic> json) {
    return SForPartsWithExpression(
      offset: json['offset'] as int,
      length: json['length'] as int,
      initialization: SAstNodeFactory.fromJson(
          json['initialization'] as Map<String, dynamic>?),
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      updaters: SAstNodeFactory.listFromJson(json['updaters'] as List?),
    );
  }
}

// ============================================================================
// For-Each Statement
// ============================================================================

class SForEachStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? forLoopParts;
  final SAstNode? body;

  SForEachStatement({
    required this.offset,
    required this.length,
    this.forLoopParts,
    this.body,
  });

  @override
  String get nodeType => 'ForEachStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (forLoopParts != null) 'forLoopParts': forLoopParts!.toJson(),
        if (body != null) 'body': body!.toJson(),
      };

  factory SForEachStatement.fromJson(Map<String, dynamic> json) {
    return SForEachStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      forLoopParts: SAstNodeFactory.fromJson(
          json['forLoopParts'] as Map<String, dynamic>?),
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
    );
  }
}

/// For-each loop parts with a declaration
class SForEachPartsWithDeclaration extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? loopVariable;
  final SAstNode? iterable;
  final bool isAwait;

  SForEachPartsWithDeclaration({
    required this.offset,
    required this.length,
    this.loopVariable,
    this.iterable,
    this.isAwait = false,
  });

  @override
  String get nodeType => 'ForEachPartsWithDeclaration';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (loopVariable != null) 'loopVariable': loopVariable!.toJson(),
        if (iterable != null) 'iterable': iterable!.toJson(),
        'isAwait': isAwait,
      };

  factory SForEachPartsWithDeclaration.fromJson(Map<String, dynamic> json) {
    return SForEachPartsWithDeclaration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      loopVariable: SAstNodeFactory.fromJson(
          json['loopVariable'] as Map<String, dynamic>?),
      iterable:
          SAstNodeFactory.fromJson(json['iterable'] as Map<String, dynamic>?),
      isAwait: json['isAwait'] as bool? ?? false,
    );
  }
}

/// For-each loop parts with an identifier
class SForEachPartsWithIdentifier extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? identifier;
  final SAstNode? iterable;
  final bool isAwait;

  SForEachPartsWithIdentifier({
    required this.offset,
    required this.length,
    this.identifier,
    this.iterable,
    this.isAwait = false,
  });

  @override
  String get nodeType => 'ForEachPartsWithIdentifier';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (identifier != null) 'identifier': identifier!.toJson(),
        if (iterable != null) 'iterable': iterable!.toJson(),
        'isAwait': isAwait,
      };

  factory SForEachPartsWithIdentifier.fromJson(Map<String, dynamic> json) {
    return SForEachPartsWithIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      identifier: json['identifier'] != null
          ? SSimpleIdentifier.fromJson(
              json['identifier'] as Map<String, dynamic>)
          : null,
      iterable:
          SAstNodeFactory.fromJson(json['iterable'] as Map<String, dynamic>?),
      isAwait: json['isAwait'] as bool? ?? false,
    );
  }
}

/// Declared identifier in a for-each loop
class SDeclaredIdentifier extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SAnnotation> metadata;
  final SAstNode? type;
  final SSimpleIdentifier? identifier;
  final bool isFinal;
  final bool isConst;

  SDeclaredIdentifier({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.type,
    this.identifier,
    this.isFinal = false,
    this.isConst = false,
  });

  @override
  String get nodeType => 'DeclaredIdentifier';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'metadata': metadata.map((a) => a.toJson()).toList(),
        if (type != null) 'type': type!.toJson(),
        if (identifier != null) 'identifier': identifier!.toJson(),
        'isFinal': isFinal,
        'isConst': isConst,
      };

  factory SDeclaredIdentifier.fromJson(Map<String, dynamic> json) {
    return SDeclaredIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata: (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      type: SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?),
      identifier: json['identifier'] != null
          ? SSimpleIdentifier.fromJson(
              json['identifier'] as Map<String, dynamic>)
          : null,
      isFinal: json['isFinal'] as bool? ?? false,
      isConst: json['isConst'] as bool? ?? false,
    );
  }
}

// ============================================================================
// While Statement
// ============================================================================

class SWhileStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? body;

  SWhileStatement({
    required this.offset,
    required this.length,
    this.condition,
    this.body,
  });

  @override
  String get nodeType => 'WhileStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (condition != null) 'condition': condition!.toJson(),
        if (body != null) 'body': body!.toJson(),
      };

  factory SWhileStatement.fromJson(Map<String, dynamic> json) {
    return SWhileStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Do Statement
// ============================================================================

class SDoStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? body;
  final SAstNode? condition;

  SDoStatement({
    required this.offset,
    required this.length,
    this.body,
    this.condition,
  });

  @override
  String get nodeType => 'DoStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (body != null) 'body': body!.toJson(),
        if (condition != null) 'condition': condition!.toJson(),
      };

  factory SDoStatement.fromJson(Map<String, dynamic> json) {
    return SDoStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      body: SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?),
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Switch Statement
// ============================================================================

class SSwitchStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;
  final List<SAstNode> members;

  SSwitchStatement({
    required this.offset,
    required this.length,
    this.expression,
    this.members = const [],
  });

  @override
  String get nodeType => 'SwitchStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (expression != null) 'expression': expression!.toJson(),
        'members': members.map((m) => m.toJson()).toList(),
      };

  factory SSwitchStatement.fromJson(Map<String, dynamic> json) {
    return SSwitchStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      members: SAstNodeFactory.listFromJson(json['members'] as List?),
    );
  }
}

class SSwitchCase extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  final SAstNode? expression;
  final List<SAstNode> statements;

  SSwitchCase({
    required this.offset,
    required this.length,
    this.labels = const [],
    this.expression,
    this.statements = const [],
  });

  @override
  String get nodeType => 'SwitchCase';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'labels': labels.map((l) => l.toJson()).toList(),
        if (expression != null) 'expression': expression!.toJson(),
        'statements': statements.map((s) => s.toJson()).toList(),
      };

  factory SSwitchCase.fromJson(Map<String, dynamic> json) {
    return SSwitchCase(
      offset: json['offset'] as int,
      length: json['length'] as int,
      labels: (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      statements: SAstNodeFactory.listFromJson(json['statements'] as List?),
    );
  }
}

class SSwitchDefault extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  final List<SAstNode> statements;

  SSwitchDefault({
    required this.offset,
    required this.length,
    this.labels = const [],
    this.statements = const [],
  });

  @override
  String get nodeType => 'SwitchDefault';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'labels': labels.map((l) => l.toJson()).toList(),
        'statements': statements.map((s) => s.toJson()).toList(),
      };

  factory SSwitchDefault.fromJson(Map<String, dynamic> json) {
    return SSwitchDefault(
      offset: json['offset'] as int,
      length: json['length'] as int,
      labels: (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      statements: SAstNodeFactory.listFromJson(json['statements'] as List?),
    );
  }
}

// ============================================================================
// Try Statement
// ============================================================================

class STryStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SBlock? body;
  final List<SCatchClause> catchClauses;
  final SBlock? finallyBlock;

  STryStatement({
    required this.offset,
    required this.length,
    this.body,
    this.catchClauses = const [],
    this.finallyBlock,
  });

  @override
  String get nodeType => 'TryStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (body != null) 'body': body!.toJson(),
        'catchClauses': catchClauses.map((c) => c.toJson()).toList(),
        if (finallyBlock != null) 'finallyBlock': finallyBlock!.toJson(),
      };

  factory STryStatement.fromJson(Map<String, dynamic> json) {
    return STryStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      body: json['body'] != null
          ? SBlock.fromJson(json['body'] as Map<String, dynamic>)
          : null,
      catchClauses: (json['catchClauses'] as List?)
              ?.map((c) => SCatchClause.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      finallyBlock: json['finallyBlock'] != null
          ? SBlock.fromJson(json['finallyBlock'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SCatchClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? exceptionType;
  final SSimpleIdentifier? exceptionParameter;
  final SSimpleIdentifier? stackTraceParameter;
  final SBlock? body;

  SCatchClause({
    required this.offset,
    required this.length,
    this.exceptionType,
    this.exceptionParameter,
    this.stackTraceParameter,
    this.body,
  });

  @override
  String get nodeType => 'CatchClause';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (exceptionType != null) 'exceptionType': exceptionType!.toJson(),
        if (exceptionParameter != null)
          'exceptionParameter': exceptionParameter!.toJson(),
        if (stackTraceParameter != null)
          'stackTraceParameter': stackTraceParameter!.toJson(),
        if (body != null) 'body': body!.toJson(),
      };

  factory SCatchClause.fromJson(Map<String, dynamic> json) {
    return SCatchClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      exceptionType: SAstNodeFactory.fromJson(
          json['exceptionType'] as Map<String, dynamic>?),
      exceptionParameter: json['exceptionParameter'] != null
          ? SSimpleIdentifier.fromJson(
              json['exceptionParameter'] as Map<String, dynamic>)
          : null,
      stackTraceParameter: json['stackTraceParameter'] != null
          ? SSimpleIdentifier.fromJson(
              json['stackTraceParameter'] as Map<String, dynamic>)
          : null,
      body: json['body'] != null
          ? SBlock.fromJson(json['body'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Break and Continue
// ============================================================================

class SBreakStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? label;

  SBreakStatement({
    required this.offset,
    required this.length,
    this.label,
  });

  @override
  String get nodeType => 'BreakStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (label != null) 'label': label!.toJson(),
      };

  factory SBreakStatement.fromJson(Map<String, dynamic> json) {
    return SBreakStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      label: json['label'] != null
          ? SSimpleIdentifier.fromJson(json['label'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SContinueStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? label;

  SContinueStatement({
    required this.offset,
    required this.length,
    this.label,
  });

  @override
  String get nodeType => 'ContinueStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (label != null) 'label': label!.toJson(),
      };

  factory SContinueStatement.fromJson(Map<String, dynamic> json) {
    return SContinueStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      label: json['label'] != null
          ? SSimpleIdentifier.fromJson(json['label'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Assert Statement
// ============================================================================

class SAssertStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? message;

  SAssertStatement({
    required this.offset,
    required this.length,
    this.condition,
    this.message,
  });

  @override
  String get nodeType => 'AssertStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (condition != null) 'condition': condition!.toJson(),
        if (message != null) 'message': message!.toJson(),
      };

  factory SAssertStatement.fromJson(Map<String, dynamic> json) {
    return SAssertStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      message:
          SAstNodeFactory.fromJson(json['message'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Yield Statement
// ============================================================================

class SYieldStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? expression;
  final bool isStar;

  SYieldStatement({
    required this.offset,
    required this.length,
    this.expression,
    this.isStar = false,
  });

  @override
  String get nodeType => 'YieldStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (expression != null) 'expression': expression!.toJson(),
        'isStar': isStar,
      };

  factory SYieldStatement.fromJson(Map<String, dynamic> json) {
    return SYieldStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
      isStar: json['isStar'] as bool? ?? false,
    );
  }
}

// ============================================================================
// Labeled Statement
// ============================================================================

class SLabeledStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  final SAstNode? statement;

  SLabeledStatement({
    required this.offset,
    required this.length,
    this.labels = const [],
    this.statement,
  });

  @override
  String get nodeType => 'LabeledStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'labels': labels.map((l) => l.toJson()).toList(),
        if (statement != null) 'statement': statement!.toJson(),
      };

  factory SLabeledStatement.fromJson(Map<String, dynamic> json) {
    return SLabeledStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      labels: (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      statement:
          SAstNodeFactory.fromJson(json['statement'] as Map<String, dynamic>?),
    );
  }
}

// ============================================================================
// Empty Statement
// ============================================================================

class SEmptyStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  SEmptyStatement({
    required this.offset,
    required this.length,
  });

  @override
  String get nodeType => 'EmptyStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
      };

  factory SEmptyStatement.fromJson(Map<String, dynamic> json) {
    return SEmptyStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }
}

// ============================================================================
// Pattern Variable Declaration Statement
// ============================================================================

/// A pattern variable declaration statement: `var (a, b) = expr;`
class SPatternVariableDeclarationStatement extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The pattern variable declaration
  final SAstNode declaration;

  SPatternVariableDeclarationStatement({
    required this.offset,
    required this.length,
    required this.declaration,
  });

  @override
  String get nodeType => 'PatternVariableDeclarationStatement';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'declaration': declaration.toJson(),
      };

  factory SPatternVariableDeclarationStatement.fromJson(
      Map<String, dynamic> json) {
    return SPatternVariableDeclarationStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      declaration: SAstNodeFactory.fromJson(
          json['declaration'] as Map<String, dynamic>?)!,
    );
  }
}
