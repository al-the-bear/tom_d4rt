/// Base AST node classes for the serializable AST.
///
/// This mirrors the structure of `package:analyzer/dart/ast/ast.dart`
/// but with serialization support.
library;

import 'package:meta/meta.dart';

import '../visitor.dart';

/// The base class for all AST nodes in the serializable AST.
///
/// Mirrors [analyzer.dart.ast.ast.AstNode].
@immutable
sealed class SAstNode {
  /// The offset of the first character of this node in the source.
  int get offset;

  /// The length of this node in the source.
  int get length;

  /// The offset after the last character of this node.
  int get end => offset + length;

  /// Returns the parent of this node, or `null` if this is the root.
  ///
  /// Note: Parent references are established during deserialization
  /// and are not serialized.
  SAstNode? get parent;

  /// The node type name for serialization.
  String get nodeType;

  /// Accepts a visitor and returns the result.
  R? accept<R>(SAstVisitor<R> visitor);

  /// Visits the children of this node with the given visitor.
  void visitChildren(SAstVisitor visitor);

  /// Converts this node to a JSON-serializable map.
  Map<String, dynamic> toJson();

  const SAstNode();
}

/// A node that has documentation or annotations.
///
/// Mirrors [analyzer.dart.ast.ast.AnnotatedNode].
sealed class SAnnotatedNode extends SAstNode {
  /// The documentation comment associated with this node, or `null`.
  SComment? get documentationComment;

  /// The metadata (annotations) associated with this node.
  List<SAnnotation> get metadata;

  const SAnnotatedNode();
}

/// A comment in the source code.
///
/// Mirrors [analyzer.dart.ast.ast.Comment].
@immutable
final class SComment extends SAstNode {
  @override
  final int offset;

  @override
  final int length;

  @override
  SAstNode? parent;

  /// The tokens representing the comment.
  final List<String> tokens;

  /// Whether this is a documentation comment (starts with `///` or `/**`).
  final bool isDocumentation;

  /// Whether this is a block comment (/* ... */).
  final bool isBlock;

  SComment({
    required this.offset,
    required this.length,
    required this.tokens,
    this.isDocumentation = false,
    this.isBlock = false,
  });

  @override
  String get nodeType => 'Comment';

  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitComment(this);

  @override
  void visitChildren(SAstVisitor visitor) {}

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'tokens': tokens,
        'isDocumentation': isDocumentation,
        'isBlock': isBlock,
      };

  factory SComment.fromJson(Map<String, dynamic> json) {
    return SComment(
      offset: json['offset'] as int,
      length: json['length'] as int,
      tokens: (json['tokens'] as List).cast<String>(),
      isDocumentation: json['isDocumentation'] as bool? ?? false,
      isBlock: json['isBlock'] as bool? ?? false,
    );
  }
}

/// An annotation (e.g., `@override`, `@deprecated`).
///
/// Mirrors [analyzer.dart.ast.ast.Annotation].
@immutable
final class SAnnotation extends SAstNode {
  @override
  final int offset;

  @override
  final int length;

  @override
  SAstNode? parent;

  /// The name of the annotation.
  final SIdentifier name;

  /// The type arguments, if any (e.g., `@TypeAnnotation<int>`).
  final STypeArgumentList? typeArguments;

  /// The constructor name, if this is a constructor invocation.
  final SSimpleIdentifier? constructorName;

  /// The arguments to the annotation, if any.
  final SArgumentList? arguments;

  SAnnotation({
    required this.offset,
    required this.length,
    required this.name,
    this.typeArguments,
    this.constructorName,
    this.arguments,
  });

  @override
  String get nodeType => 'Annotation';

  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitAnnotation(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name.accept(visitor);
    typeArguments?.accept(visitor);
    constructorName?.accept(visitor);
    arguments?.accept(visitor);
  }

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'name': name.toJson(),
        if (typeArguments != null) 'typeArguments': typeArguments!.toJson(),
        if (constructorName != null)
          'constructorName': constructorName!.toJson(),
        if (arguments != null) 'arguments': arguments!.toJson(),
      };

  factory SAnnotation.fromJson(Map<String, dynamic> json) {
    return SAnnotation(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: SIdentifier.fromJson(json['name'] as Map<String, dynamic>),
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

// Forward declarations for types used above - these are defined in other files
// and imported when needed. Here we just need the base structure.

/// Base class for identifiers.
sealed class SIdentifier extends SExpression {
  /// The name of the identifier.
  String get name;

  const SIdentifier();

  /// Creates an identifier from JSON.
  static SIdentifier fromJson(Map<String, dynamic> json) {
    final nodeType = json['nodeType'] as String;
    return switch (nodeType) {
      'SimpleIdentifier' => SSimpleIdentifier.fromJson(json),
      'PrefixedIdentifier' => SPrefixedIdentifier.fromJson(json),
      _ => throw ArgumentError('Unknown identifier type: $nodeType'),
    };
  }
}

/// A simple identifier (single name).
@immutable
final class SSimpleIdentifier extends SIdentifier {
  @override
  final int offset;

  @override
  final int length;

  @override
  SAstNode? parent;

  @override
  final String name;

  SSimpleIdentifier({
    required this.offset,
    required this.length,
    required this.name,
  });

  /// Creates from just a name (synthetic, no source location).
  SSimpleIdentifier.synthetic(this.name)
      : offset = -1,
        length = name.length;

  String get lexeme => name;

  @override
  String get nodeType => 'SimpleIdentifier';

  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitSimpleIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {}

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'name': name,
      };

  factory SSimpleIdentifier.fromJson(Map<String, dynamic> json) {
    return SSimpleIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] as String,
    );
  }
}

/// A prefixed identifier (e.g., `prefix.name`).
@immutable
final class SPrefixedIdentifier extends SIdentifier {
  @override
  final int offset;

  @override
  final int length;

  @override
  SAstNode? parent;

  /// The prefix.
  final SSimpleIdentifier prefix;

  /// The identifier after the dot.
  final SSimpleIdentifier identifier;

  SPrefixedIdentifier({
    required this.offset,
    required this.length,
    required this.prefix,
    required this.identifier,
  });

  @override
  String get name => '${prefix.name}.${identifier.name}';

  @override
  String get nodeType => 'PrefixedIdentifier';

  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitPrefixedIdentifier(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    prefix.accept(visitor);
    identifier.accept(visitor);
  }

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'prefix': prefix.toJson(),
        'identifier': identifier.toJson(),
      };

  factory SPrefixedIdentifier.fromJson(Map<String, dynamic> json) {
    return SPrefixedIdentifier(
      offset: json['offset'] as int,
      length: json['length'] as int,
      prefix:
          SSimpleIdentifier.fromJson(json['prefix'] as Map<String, dynamic>),
      identifier: SSimpleIdentifier.fromJson(
          json['identifier'] as Map<String, dynamic>),
    );
  }
}

/// Base class for expressions.
///
/// Mirrors [analyzer.dart.ast.ast.Expression].
sealed class SExpression extends SAstNode {
  const SExpression();

  /// Creates an expression from JSON based on nodeType.
  static SExpression fromJson(Map<String, dynamic> json) {
    final nodeType = json['nodeType'] as String;
    return _expressionFromJson(nodeType, json);
  }
}

/// Dispatches to the correct expression factory based on nodeType.
SExpression _expressionFromJson(String nodeType, Map<String, dynamic> json) {
  // This will be filled in as we implement expression types
  return switch (nodeType) {
    'SimpleIdentifier' => SSimpleIdentifier.fromJson(json),
    'PrefixedIdentifier' => SPrefixedIdentifier.fromJson(json),
    'IntegerLiteral' => SIntegerLiteral.fromJson(json),
    'DoubleLiteral' => SDoubleLiteral.fromJson(json),
    'BooleanLiteral' => SBooleanLiteral.fromJson(json),
    'StringLiteral' => SStringLiteral.fromJson(json),
    'NullLiteral' => SNullLiteral.fromJson(json),
    'BinaryExpression' => SBinaryExpression.fromJson(json),
    'PrefixExpression' => SPrefixExpression.fromJson(json),
    'PostfixExpression' => SPostfixExpression.fromJson(json),
    'AssignmentExpression' => SAssignmentExpression.fromJson(json),
    'ConditionalExpression' => SConditionalExpression.fromJson(json),
    'ParenthesizedExpression' => SParenthesizedExpression.fromJson(json),
    'IndexExpression' => SIndexExpression.fromJson(json),
    'PropertyAccess' => SPropertyAccess.fromJson(json),
    'MethodInvocation' => SMethodInvocation.fromJson(json),
    'FunctionExpressionInvocation' =>
      SFunctionExpressionInvocation.fromJson(json),
    'InstanceCreationExpression' => SInstanceCreationExpression.fromJson(json),
    'ListLiteral' => SListLiteral.fromJson(json),
    'SetOrMapLiteral' => SSetOrMapLiteral.fromJson(json),
    'RecordLiteral' => SRecordLiteral.fromJson(json),
    'CascadeExpression' => SCascadeExpression.fromJson(json),
    'ThrowExpression' => SThrowExpression.fromJson(json),
    'RethrowExpression' => SRethrowExpression.fromJson(json),
    'AsExpression' => SAsExpression.fromJson(json),
    'IsExpression' => SIsExpression.fromJson(json),
    'AwaitExpression' => SAwaitExpression.fromJson(json),
    'ThisExpression' => SThisExpression.fromJson(json),
    'SuperExpression' => SSuperExpression.fromJson(json),
    'FunctionExpression' => SFunctionExpression.fromJson(json),
    'SymbolLiteral' => SSymbolLiteral.fromJson(json),
    'StringInterpolation' => SStringInterpolation.fromJson(json),
    'SwitchExpression' => SSwitchExpression.fromJson(json),
    'ConstructorReference' => SConstructorReference.fromJson(json),
    'FunctionReference' => SFunctionReference.fromJson(json),
    'PatternAssignment' => SPatternAssignment.fromJson(json),
    _ => throw ArgumentError('Unknown expression type: $nodeType'),
  };
}

/// Base class for statements.
///
/// Mirrors [analyzer.dart.ast.ast.Statement].
sealed class SStatement extends SAstNode {
  const SStatement();

  /// Creates a statement from JSON based on nodeType.
  static SStatement fromJson(Map<String, dynamic> json) {
    final nodeType = json['nodeType'] as String;
    return _statementFromJson(nodeType, json);
  }
}

/// Dispatches to the correct statement factory based on nodeType.
SStatement _statementFromJson(String nodeType, Map<String, dynamic> json) {
  return switch (nodeType) {
    'Block' => SBlock.fromJson(json),
    'ExpressionStatement' => SExpressionStatement.fromJson(json),
    'VariableDeclarationStatement' =>
      SVariableDeclarationStatement.fromJson(json),
    'ReturnStatement' => SReturnStatement.fromJson(json),
    'IfStatement' => SIfStatement.fromJson(json),
    'ForStatement' => SForStatement.fromJson(json),
    'WhileStatement' => SWhileStatement.fromJson(json),
    'DoStatement' => SDoStatement.fromJson(json),
    'BreakStatement' => SBreakStatement.fromJson(json),
    'ContinueStatement' => SContinueStatement.fromJson(json),
    'TryStatement' => STryStatement.fromJson(json),
    'SwitchStatement' => SSwitchStatement.fromJson(json),
    'AssertStatement' => SAssertStatement.fromJson(json),
    'EmptyStatement' => SEmptyStatement.fromJson(json),
    'YieldStatement' => SYieldStatement.fromJson(json),
    'LabeledStatement' => SLabeledStatement.fromJson(json),
    'PatternVariableDeclarationStatement' =>
      SPatternVariableDeclarationStatement.fromJson(json),
    _ => throw ArgumentError('Unknown statement type: $nodeType'),
  };
}

/// Base class for declarations.
///
/// Mirrors [analyzer.dart.ast.ast.Declaration].
sealed class SDeclaration extends SAnnotatedNode {
  const SDeclaration();
}

/// Base class for compilation unit members.
///
/// Mirrors [analyzer.dart.ast.ast.CompilationUnitMember].
sealed class SCompilationUnitMember extends SDeclaration {
  const SCompilationUnitMember();

  /// Creates a compilation unit member from JSON.
  static SCompilationUnitMember fromJson(Map<String, dynamic> json) {
    final nodeType = json['nodeType'] as String;
    return switch (nodeType) {
      'ClassDeclaration' => SClassDeclaration.fromJson(json),
      'MixinDeclaration' => SMixinDeclaration.fromJson(json),
      'EnumDeclaration' => SEnumDeclaration.fromJson(json),
      'ExtensionDeclaration' => SExtensionDeclaration.fromJson(json),
      'FunctionDeclaration' => SFunctionDeclaration.fromJson(json),
      'TopLevelVariableDeclaration' =>
        STopLevelVariableDeclaration.fromJson(json),
      _ => throw ArgumentError('Unknown compilation unit member: $nodeType'),
    };
  }
}

/// Base class for class members.
///
/// Mirrors [analyzer.dart.ast.ast.ClassMember].
sealed class SClassMember extends SDeclaration {
  const SClassMember();

  /// Creates a class member from JSON.
  static SClassMember fromJson(Map<String, dynamic> json) {
    final nodeType = json['nodeType'] as String;
    return switch (nodeType) {
      'FieldDeclaration' => SFieldDeclaration.fromJson(json),
      'MethodDeclaration' => SMethodDeclaration.fromJson(json),
      'ConstructorDeclaration' => SConstructorDeclaration.fromJson(json),
      _ => throw ArgumentError('Unknown class member: $nodeType'),
    };
  }
}

// Forward declarations for types used in fromJson
// These classes are defined in their respective files

// From expressions.dart
class SIntegerLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'IntegerLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SIntegerLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SDoubleLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'DoubleLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SDoubleLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SBooleanLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'BooleanLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SBooleanLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SStringLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'StringLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SStringLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SNullLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'NullLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SNullLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// Placeholder classes - to be properly defined in expressions.dart
class SBinaryExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'BinaryExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SBinaryExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SPrefixExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PrefixExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SPrefixExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SPostfixExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PostfixExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SPostfixExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SAssignmentExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'AssignmentExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SAssignmentExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SConditionalExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConditionalExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SConditionalExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SParenthesizedExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ParenthesizedExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SParenthesizedExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SIndexExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'IndexExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SIndexExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SPropertyAccess extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PropertyAccess';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SPropertyAccess fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SMethodInvocation extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'MethodInvocation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SMethodInvocation fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SFunctionExpressionInvocation extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FunctionExpressionInvocation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SFunctionExpressionInvocation fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SInstanceCreationExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'InstanceCreationExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SInstanceCreationExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SListLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ListLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SListLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SSetOrMapLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SetOrMapLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SSetOrMapLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SRecordLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RecordLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SRecordLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SCascadeExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'CascadeExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SCascadeExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SThrowExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ThrowExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SThrowExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SRethrowExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RethrowExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SRethrowExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SAsExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'AsExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SAsExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SIsExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'IsExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SIsExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SAwaitExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'AwaitExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SAwaitExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SThisExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ThisExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SThisExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SSuperExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SuperExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SSuperExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SFunctionExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FunctionExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SFunctionExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SSymbolLiteral extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SymbolLiteral';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SSymbolLiteral fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SStringInterpolation extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'StringInterpolation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SStringInterpolation fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SSwitchExpression extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SSwitchExpression fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SConstructorReference extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConstructorReference';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SConstructorReference fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SFunctionReference extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FunctionReference';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SFunctionReference fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SPatternAssignment extends SExpression {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PatternAssignment';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SPatternAssignment fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// Statement placeholders
class SBlock extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'Block';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SBlock fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SExpressionStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ExpressionStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SExpressionStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SVariableDeclarationStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'VariableDeclarationStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SVariableDeclarationStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SReturnStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ReturnStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SReturnStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SIfStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'IfStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SIfStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SForStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ForStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SForStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SWhileStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'WhileStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SWhileStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SDoStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'DoStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SDoStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SBreakStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'BreakStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SBreakStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SContinueStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ContinueStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SContinueStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class STryStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'TryStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static STryStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SSwitchStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SSwitchStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SAssertStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'AssertStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SAssertStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SEmptyStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'EmptyStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SEmptyStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SYieldStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'YieldStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SYieldStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SLabeledStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'LabeledStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SLabeledStatement fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SPatternVariableDeclarationStatement extends SStatement {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PatternVariableDeclarationStatement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SPatternVariableDeclarationStatement fromJson(
          Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// Declaration placeholders
class SClassDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ClassDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SClassDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SMixinDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'MixinDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SMixinDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SEnumDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'EnumDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SEnumDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SExtensionDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ExtensionDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SExtensionDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SFunctionDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FunctionDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SFunctionDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class STopLevelVariableDeclaration extends SCompilationUnitMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'TopLevelVariableDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static STopLevelVariableDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// Class member placeholders
class SFieldDeclaration extends SClassMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FieldDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SFieldDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SMethodDeclaration extends SClassMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'MethodDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SMethodDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SConstructorDeclaration extends SClassMember {
  @override
  SComment? get documentationComment => throw UnimplementedError();
  @override
  List<SAnnotation> get metadata => throw UnimplementedError();
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConstructorDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SConstructorDeclaration fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

// Utility types
class STypeArgumentList extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'TypeArgumentList';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static STypeArgumentList fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}

class SArgumentList extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ArgumentList';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => throw UnimplementedError();
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
  static SArgumentList fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError();
}
