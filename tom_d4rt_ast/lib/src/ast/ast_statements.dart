// Serializable AST statements
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Block
// ============================================================================

class SBlock extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final List<SStatement> statements;

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
      statements: SAstNodeFactory.listFromJson<SStatement>(
        json['statements'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBlock(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in statements) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Variable Declaration Statement
// ============================================================================

class SVariableDeclarationStatement extends SStatement {
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
              json['variables'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitVariableDeclarationStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    variables?.accept(visitor);
  }
}

// ============================================================================
// Function Declaration Statement
// ============================================================================

class SFunctionDeclarationStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SFunctionDeclaration functionDeclaration;

  SFunctionDeclarationStatement({
    required this.offset,
    required this.length,
    required this.functionDeclaration,
  });

  @override
  String get nodeType => 'FunctionDeclarationStatement';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'functionDeclaration': functionDeclaration.toJson(),
  };

  factory SFunctionDeclarationStatement.fromJson(Map<String, dynamic> json) {
    return SFunctionDeclarationStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      functionDeclaration: SFunctionDeclaration.fromJson(
          json['functionDeclaration'] as Map<String, dynamic>),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitFunctionDeclarationStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    functionDeclaration.accept(visitor);
  }
}

// ============================================================================
// Expression Statement
// ============================================================================

class SExpressionStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitExpressionStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// Return Statement
// ============================================================================

class SReturnStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitReturnStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// If Statement
// ============================================================================

class SIfStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? condition;
  final SStatement? thenStatement;
  final SStatement? elseStatement;

  /// Whether this uses case pattern (if-case)
  final SCaseClause? caseClause;

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
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      thenStatement:
          SAstNodeFactory.fromJson(
                json['thenStatement'] as Map<String, dynamic>?,
              )
              as SStatement?,
      elseStatement:
          SAstNodeFactory.fromJson(
                json['elseStatement'] as Map<String, dynamic>?,
              )
              as SStatement?,
      caseClause:
          SAstNodeFactory.fromJson(json['caseClause'] as Map<String, dynamic>?)
              as SCaseClause?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitIfStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    condition?.accept(visitor);
    thenStatement?.accept(visitor);
    elseStatement?.accept(visitor);
    caseClause?.accept(visitor);
  }
}

// ============================================================================
// For Statement
// ============================================================================

class SForStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  /// For loop parts (initialization, condition, updaters)
  final SForLoopParts? forLoopParts;
  final SStatement? body;

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
      forLoopParts:
          SAstNodeFactory.fromJson(
                json['forLoopParts'] as Map<String, dynamic>?,
              )
              as SForLoopParts?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SStatement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitForStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    forLoopParts?.accept(visitor);
    body?.accept(visitor);
  }
}

/// For loop parts for standard for loops
class SForPartsWithDeclarations extends SForParts {
  @override
  final int offset;
  @override
  final int length;

  final SVariableDeclarationList? variables;
  final SExpression? condition;
  final List<SExpression> updaters;

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
              json['variables'] as Map<String, dynamic>,
            )
          : null,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      updaters: SAstNodeFactory.listFromJson<SExpression>(
        json['updaters'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitForPartsWithDeclarations(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    variables?.accept(visitor);
    condition?.accept(visitor);
    for (final child in updaters) {
      child.accept(visitor);
    }
  }
}

/// For loop parts with an expression initializer
class SForPartsWithExpression extends SForParts {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? initialization;
  final SExpression? condition;
  final List<SExpression> updaters;

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
      initialization:
          SAstNodeFactory.fromJson(
                json['initialization'] as Map<String, dynamic>?,
              )
              as SExpression?,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      updaters: SAstNodeFactory.listFromJson<SExpression>(
        json['updaters'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitForPartsWithExpression(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    initialization?.accept(visitor);
    condition?.accept(visitor);
    for (final child in updaters) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// For-Each Statement
// ============================================================================

class SForEachStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SForLoopParts? forLoopParts;
  final SStatement? body;

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
      forLoopParts:
          SAstNodeFactory.fromJson(
                json['forLoopParts'] as Map<String, dynamic>?,
              )
              as SForLoopParts?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SStatement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitForEachStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    forLoopParts?.accept(visitor);
    body?.accept(visitor);
  }
}

/// For-each loop parts with a declaration
class SForEachPartsWithDeclaration extends SForEachParts {
  @override
  final int offset;
  @override
  final int length;

  final SDeclaredIdentifier? loopVariable;
  final SExpression? iterable;
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
      loopVariable:
          SAstNodeFactory.fromJson(
                json['loopVariable'] as Map<String, dynamic>?,
              )
              as SDeclaredIdentifier?,
      iterable:
          SAstNodeFactory.fromJson(json['iterable'] as Map<String, dynamic>?)
              as SExpression?,
      isAwait: json['isAwait'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitForEachPartsWithDeclaration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    loopVariable?.accept(visitor);
    iterable?.accept(visitor);
  }
}

/// For-each loop parts with an identifier
class SForEachPartsWithIdentifier extends SForEachParts {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? identifier;
  final SExpression? iterable;
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
              json['identifier'] as Map<String, dynamic>,
            )
          : null,
      iterable:
          SAstNodeFactory.fromJson(json['iterable'] as Map<String, dynamic>?)
              as SExpression?,
      isAwait: json['isAwait'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitForEachPartsWithIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    identifier?.accept(visitor);
    iterable?.accept(visitor);
  }
}

/// Declared identifier in a for-each loop
class SDeclaredIdentifier extends SDeclaration {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final STypeAnnotation? type;
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
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      type:
          SAstNodeFactory.fromJson(json['type'] as Map<String, dynamic>?)
              as STypeAnnotation?,
      identifier: json['identifier'] != null
          ? SSimpleIdentifier.fromJson(
              json['identifier'] as Map<String, dynamic>,
            )
          : null,
      isFinal: json['isFinal'] as bool? ?? false,
      isConst: json['isConst'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitDeclaredIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    type?.accept(visitor);
    identifier?.accept(visitor);
  }
}

// ============================================================================
// While Statement
// ============================================================================

class SWhileStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? condition;
  final SStatement? body;

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
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SStatement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitWhileStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    condition?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Do Statement
// ============================================================================

class SDoStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SStatement? body;
  final SExpression? condition;

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
      body:
          SAstNodeFactory.fromJson(json['body'] as Map<String, dynamic>?)
              as SStatement?,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitDoStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    body?.accept(visitor);
    condition?.accept(visitor);
  }
}

// ============================================================================
// Switch Statement
// ============================================================================

class SSwitchStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
  final List<SSwitchMember> members;

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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      members: SAstNodeFactory.listFromJson<SSwitchMember>(
        json['members'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSwitchStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
    for (final child in members) {
      child.accept(visitor);
    }
  }
}

class SSwitchCase extends SSwitchMember {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  final SExpression? expression;
  @override
  final List<SStatement> statements;

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
      labels:
          (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      statements: SAstNodeFactory.listFromJson<SStatement>(
        json['statements'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSwitchCase(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in labels) {
      child.accept(visitor);
    }
    expression?.accept(visitor);
    for (final child in statements) {
      child.accept(visitor);
    }
  }
}

class SSwitchDefault extends SSwitchMember {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  @override
  final List<SStatement> statements;

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
      labels:
          (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      statements: SAstNodeFactory.listFromJson<SStatement>(
        json['statements'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitSwitchDefault(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in labels) {
      child.accept(visitor);
    }
    for (final child in statements) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Try Statement
// ============================================================================

class STryStatement extends SStatement {
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
      catchClauses:
          (json['catchClauses'] as List?)
              ?.map((c) => SCatchClause.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      finallyBlock: json['finallyBlock'] != null
          ? SBlock.fromJson(json['finallyBlock'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitTryStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    body?.accept(visitor);
    for (final child in catchClauses) {
      child.accept(visitor);
    }
    finallyBlock?.accept(visitor);
  }
}

class SCatchClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final STypeAnnotation? exceptionType;
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
      exceptionType:
          SAstNodeFactory.fromJson(
                json['exceptionType'] as Map<String, dynamic>?,
              )
              as STypeAnnotation?,
      exceptionParameter: json['exceptionParameter'] != null
          ? SSimpleIdentifier.fromJson(
              json['exceptionParameter'] as Map<String, dynamic>,
            )
          : null,
      stackTraceParameter: json['stackTraceParameter'] != null
          ? SSimpleIdentifier.fromJson(
              json['stackTraceParameter'] as Map<String, dynamic>,
            )
          : null,
      body: json['body'] != null
          ? SBlock.fromJson(json['body'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitCatchClause(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    exceptionType?.accept(visitor);
    exceptionParameter?.accept(visitor);
    stackTraceParameter?.accept(visitor);
    body?.accept(visitor);
  }
}

// ============================================================================
// Break and Continue
// ============================================================================

class SBreakStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? label;

  SBreakStatement({required this.offset, required this.length, this.label});

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

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitBreakStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    label?.accept(visitor);
  }
}

class SContinueStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? label;

  SContinueStatement({required this.offset, required this.length, this.label});

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

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitContinueStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    label?.accept(visitor);
  }
}

// ============================================================================
// Assert Statement
// ============================================================================

class SAssertStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? condition;
  final SExpression? message;

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
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?)
              as SExpression?,
      message:
          SAstNodeFactory.fromJson(json['message'] as Map<String, dynamic>?)
              as SExpression?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitAssertStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    condition?.accept(visitor);
    message?.accept(visitor);
  }
}

// ============================================================================
// Yield Statement
// ============================================================================

class SYieldStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final SExpression? expression;
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
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?)
              as SExpression?,
      isStar: json['isStar'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitYieldStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    expression?.accept(visitor);
  }
}

// ============================================================================
// Labeled Statement
// ============================================================================

class SLabeledStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  final List<SLabel> labels;
  final SStatement? statement;

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
      labels:
          (json['labels'] as List?)
              ?.map((l) => SLabel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      statement:
          SAstNodeFactory.fromJson(json['statement'] as Map<String, dynamic>?)
              as SStatement?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitLabeledStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in labels) {
      child.accept(visitor);
    }
    statement?.accept(visitor);
  }
}

// ============================================================================
// Empty Statement
// ============================================================================

class SEmptyStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  SEmptyStatement({required this.offset, required this.length});

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

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitEmptyStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

// ============================================================================
// Pattern Variable Declaration Statement
// ============================================================================

/// A pattern variable declaration statement: `var (a, b) = expr;`
class SPatternVariableDeclarationStatement extends SStatement {
  @override
  final int offset;
  @override
  final int length;

  /// The pattern variable declaration
  final SPatternVariableDeclaration declaration;

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
    Map<String, dynamic> json,
  ) {
    return SPatternVariableDeclarationStatement(
      offset: json['offset'] as int,
      length: json['length'] as int,
      declaration:
          SAstNodeFactory.fromJson(json['declaration'] as Map<String, dynamic>?)
              as SPatternVariableDeclaration,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) =>
      visitor.visitPatternVariableDeclarationStatement(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    declaration.accept(visitor);
  }
}
