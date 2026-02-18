// Serializable AST miscellaneous nodes
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Argument List
// ============================================================================

class SArgumentList extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SAstNode> arguments;

  SArgumentList({
    required this.offset,
    required this.length,
    this.arguments = const [],
  });

  @override
  String get nodeType => 'ArgumentList';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'arguments': arguments.map((a) => a.toJson()).toList(),
      };

  factory SArgumentList.fromJson(Map<String, dynamic> json) {
    return SArgumentList(
      offset: json['offset'] as int,
      length: json['length'] as int,
      arguments: SAstNodeFactory.listFromJson(json['arguments'] as List?),
    );
  }
}

// ============================================================================
// Annotation
// ============================================================================

class SAnnotation extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? name;
  final STypeArgumentList? typeArguments;
  final SSimpleIdentifier? constructorName;
  final SArgumentList? arguments;

  SAnnotation({
    required this.offset,
    required this.length,
    this.name,
    this.typeArguments,
    this.constructorName,
    this.arguments,
  });

  @override
  String get nodeType => 'Annotation';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (name != null) 'name': name!.toJson(),
        if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
        if (constructorName != null)
          'constructorName': constructorName!.toJson(),
        if (arguments != null) 'arguments': arguments!.toJson(),
      };

  factory SAnnotation.fromJson(Map<String, dynamic> json) {
    return SAnnotation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      typeArguments: json['typeArguments'] != null
          ? STypeArgumentList.fromJson(
              json['typeArguments'] as Map<String, dynamic>)
          : null,
      constructorName: json['constructorName'] != null
          ? SSimpleIdentifier.fromJson(
              json['constructorName'] as Map<String, dynamic>)
          : null,
      arguments: json['arguments'] != null
          ? SArgumentList.fromJson(json['arguments'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Comment
// ============================================================================

class SComment extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final String content;
  final String commentType; // 'line', 'block', 'documentation'

  SComment({
    required this.offset,
    required this.length,
    required this.content,
    required this.commentType,
  });

  @override
  String get nodeType => 'Comment';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'content': content,
        'commentType': commentType,
      };

  factory SComment.fromJson(Map<String, dynamic> json) {
    return SComment(
      offset: json['offset'] as int,
      length: json['length'] as int,
      content: json['content'] as String,
      commentType: json['commentType'] as String,
    );
  }
}

// ============================================================================
// Label
// ============================================================================

class SLabel extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? label;

  SLabel({
    required this.offset,
    required this.length,
    this.label,
  });

  @override
  String get nodeType => 'Label';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (label != null) 'label': label!.toJson(),
      };

  factory SLabel.fromJson(Map<String, dynamic> json) {
    return SLabel(
      offset: json['offset'] as int,
      length: json['length'] as int,
      label: json['label'] != null
          ? SSimpleIdentifier.fromJson(json['label'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ============================================================================
// Clauses
// ============================================================================

class SExtendsClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SNamedType? superclass;

  SExtendsClause({
    required this.offset,
    required this.length,
    this.superclass,
  });

  @override
  String get nodeType => 'ExtendsClause';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (superclass != null) 'superclass': superclass!.toJson(),
      };

  factory SExtendsClause.fromJson(Map<String, dynamic> json) {
    return SExtendsClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      superclass: json['superclass'] != null
          ? SNamedType.fromJson(json['superclass'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SImplementsClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SNamedType> interfaces;

  SImplementsClause({
    required this.offset,
    required this.length,
    this.interfaces = const [],
  });

  @override
  String get nodeType => 'ImplementsClause';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'interfaces': interfaces.map((i) => i.toJson()).toList(),
      };

  factory SImplementsClause.fromJson(Map<String, dynamic> json) {
    return SImplementsClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      interfaces: (json['interfaces'] as List?)
              ?.map((i) => SNamedType.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class SWithClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SNamedType> mixinTypes;

  SWithClause({
    required this.offset,
    required this.length,
    this.mixinTypes = const [],
  });

  @override
  String get nodeType => 'WithClause';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'mixinTypes': mixinTypes.map((m) => m.toJson()).toList(),
      };

  factory SWithClause.fromJson(Map<String, dynamic> json) {
    return SWithClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      mixinTypes: (json['mixinTypes'] as List?)
              ?.map((m) => SNamedType.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class SOnClause extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SNamedType> superclassConstraints;

  SOnClause({
    required this.offset,
    required this.length,
    this.superclassConstraints = const [],
  });

  @override
  String get nodeType => 'OnClause';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'superclassConstraints':
            superclassConstraints.map((s) => s.toJson()).toList(),
      };

  factory SOnClause.fromJson(Map<String, dynamic> json) {
    return SOnClause(
      offset: json['offset'] as int,
      length: json['length'] as int,
      superclassConstraints: (json['superclassConstraints'] as List?)
              ?.map((s) => SNamedType.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

// ============================================================================
// Constructor-related
// ============================================================================

class SConstructorName extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SNamedType? type;
  final SSimpleIdentifier? name;

  SConstructorName({
    required this.offset,
    required this.length,
    this.type,
    this.name,
  });

  @override
  String get nodeType => 'ConstructorName';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (type != null) 'type': type!.toJson(),
        if (name != null) 'name': name!.toJson(),
      };

  factory SConstructorName.fromJson(Map<String, dynamic> json) {
    return SConstructorName(
      offset: json['offset'] as int,
      length: json['length'] as int,
      type: json['type'] != null
          ? SNamedType.fromJson(json['type'] as Map<String, dynamic>)
          : null,
      name: json['name'] != null
          ? SSimpleIdentifier.fromJson(json['name'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SSuperConstructorInvocation extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? constructorName;
  final SArgumentList? argumentList;

  SSuperConstructorInvocation({
    required this.offset,
    required this.length,
    this.constructorName,
    this.argumentList,
  });

  @override
  String get nodeType => 'SuperConstructorInvocation';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (constructorName != null)
          'constructorName': constructorName!.toJson(),
        if (argumentList != null) 'argumentList': argumentList!.toJson(),
      };

  factory SSuperConstructorInvocation.fromJson(Map<String, dynamic> json) {
    return SSuperConstructorInvocation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      constructorName: json['constructorName'] != null
          ? SSimpleIdentifier.fromJson(
              json['constructorName'] as Map<String, dynamic>)
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SRedirectingConstructorInvocation extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? constructorName;
  final SArgumentList? argumentList;

  SRedirectingConstructorInvocation({
    required this.offset,
    required this.length,
    this.constructorName,
    this.argumentList,
  });

  @override
  String get nodeType => 'RedirectingConstructorInvocation';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (constructorName != null)
          'constructorName': constructorName!.toJson(),
        if (argumentList != null) 'argumentList': argumentList!.toJson(),
      };

  factory SRedirectingConstructorInvocation.fromJson(Map<String, dynamic> json) {
    return SRedirectingConstructorInvocation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      constructorName: json['constructorName'] != null
          ? SSimpleIdentifier.fromJson(
              json['constructorName'] as Map<String, dynamic>)
          : null,
      argumentList: json['argumentList'] != null
          ? SArgumentList.fromJson(json['argumentList'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SConstructorFieldInitializer extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SSimpleIdentifier? fieldName;
  final SAstNode? expression;

  SConstructorFieldInitializer({
    required this.offset,
    required this.length,
    this.fieldName,
    this.expression,
  });

  @override
  String get nodeType => 'ConstructorFieldInitializer';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (fieldName != null) 'fieldName': fieldName!.toJson(),
        if (expression != null) 'expression': expression!.toJson(),
      };

  factory SConstructorFieldInitializer.fromJson(Map<String, dynamic> json) {
    return SConstructorFieldInitializer(
      offset: json['offset'] as int,
      length: json['length'] as int,
      fieldName: json['fieldName'] != null
          ? SSimpleIdentifier.fromJson(
              json['fieldName'] as Map<String, dynamic>)
          : null,
      expression:
          SAstNodeFactory.fromJson(json['expression'] as Map<String, dynamic>?),
    );
  }
}

class SAssertInitializer extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final SAstNode? condition;
  final SAstNode? message;

  SAssertInitializer({
    required this.offset,
    required this.length,
    this.condition,
    this.message,
  });

  @override
  String get nodeType => 'AssertInitializer';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        if (condition != null) 'condition': condition!.toJson(),
        if (message != null) 'message': message!.toJson(),
      };

  factory SAssertInitializer.fromJson(Map<String, dynamic> json) {
    return SAssertInitializer(
      offset: json['offset'] as int,
      length: json['length'] as int,
      condition:
          SAstNodeFactory.fromJson(json['condition'] as Map<String, dynamic>?),
      message:
          SAstNodeFactory.fromJson(json['message'] as Map<String, dynamic>?),
    );
  }
}
