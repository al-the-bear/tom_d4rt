// Serializable AST model for D4rt interpretation
// This is a complete, self-contained serializable AST independent of the analyzer package.
// ignore_for_file: constant_identifier_names

import 'dart:convert';

part 'ast_categories.dart';
part 'ast_declarations.dart';
part 'ast_statements.dart';
part 'ast_expressions.dart';
part 'ast_literals.dart';
part 'ast_types.dart';
part 'ast_directives.dart';
part 'ast_misc.dart';
part 'ast_patterns.dart';
part 'ast_visitor.dart';

/// Base class for all serializable AST nodes
abstract class SAstNode {
  /// Unique node type identifier for serialization
  String get nodeType;

  /// Source offset of the node
  int get offset;

  /// Length of the source text
  int get length;

  /// Convert to JSON-serializable map
  Map<String, dynamic> toJson();

  /// Serialize to JSON string
  String toJsonString({bool pretty = false}) {
    final encoder = pretty
        ? const JsonEncoder.withIndent('  ')
        : const JsonEncoder();
    return encoder.convert(toJson());
  }

  /// Compares this node with [other]. If [log] is provided, differences
  /// are appended in a human-readable format with JSON-style paths.
  bool equals(Object other, [List<String>? log]) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SAstNode) {
      log?.add('Type mismatch: $runtimeType != ${other.runtimeType}');
      return false;
    }

    final left = toJson();
    final right = other.toJson();
    return _diffJson(left, right, r'$', log);
  }

  @override
  bool operator ==(Object other) => equals(other);

  @override
  int get hashCode => Object.hash(runtimeType, offset, length);

  /// Get the end offset
  int get end => offset + length;

  /// Accept a visitor and return the result.
  T? accept<T>(SAstVisitor<T> visitor);

  /// Visit all child nodes of this node.
  void visitChildren(SAstVisitor visitor);
}

bool _diffJson(Object? left, Object? right, String path, List<String>? log) {
  if (identical(left, right)) return true;

  if (left == null || right == null) {
    if (left == right) return true;
    log?.add('$path: $left != $right');
    return false;
  }

  if (left is Map && right is Map) {
    final leftKeys = left.keys.toSet();
    final rightKeys = right.keys.toSet();
    var ok = true;

    for (final key in leftKeys.difference(rightKeys)) {
      ok = false;
      log?.add('$path.$key: missing on right');
    }
    for (final key in rightKeys.difference(leftKeys)) {
      ok = false;
      log?.add('$path.$key: missing on left');
    }

    for (final key in leftKeys.intersection(rightKeys)) {
      final nextPath = '$path.$key';
      if (!_diffJson(left[key], right[key], nextPath, log)) {
        ok = false;
      }
    }
    return ok;
  }

  if (left is List && right is List) {
    var ok = true;
    if (left.length != right.length) {
      ok = false;
      log?.add('$path.length: ${left.length} != ${right.length}');
    }
    final minLen = left.length < right.length ? left.length : right.length;
    for (var i = 0; i < minLen; i++) {
      if (!_diffJson(left[i], right[i], '$path[$i]', log)) {
        ok = false;
      }
    }
    return ok;
  }

  if (left != right) {
    log?.add('$path: $left != $right');
    return false;
  }

  return true;
}

/// Serializable token representation
class SToken {
  final int offset;
  final int length;
  final String lexeme;
  final String tokenType;

  const SToken({
    required this.offset,
    required this.length,
    required this.lexeme,
    required this.tokenType,
  });

  Map<String, dynamic> toJson() => {
    'offset': offset,
    'length': length,
    'lexeme': lexeme,
    'tokenType': tokenType,
  };

  factory SToken.fromJson(Map<String, dynamic> json) {
    return SToken(
      offset: json['offset'] as int,
      length: json['length'] as int,
      lexeme: json['lexeme'] as String,
      tokenType: json['tokenType'] as String,
    );
  }

  /// Compares this token with [other]. If [log] is provided, differences
  /// are appended in a human-readable format with JSON-style paths.
  bool equals(Object other, [List<String>? log]) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SToken) {
      log?.add('Type mismatch: $runtimeType != ${other.runtimeType}');
      return false;
    }
    var ok = true;
    if (offset != other.offset) {
      ok = false;
      log?.add(r'$.offset: $offset != ${other.offset}');
    }
    if (length != other.length) {
      ok = false;
      log?.add(r'$.length: $length != ${other.length}');
    }
    if (lexeme != other.lexeme) {
      ok = false;
      log?.add(r'$.lexeme: $lexeme != ${other.lexeme}');
    }
    if (tokenType != other.tokenType) {
      ok = false;
      log?.add(r'$.tokenType: $tokenType != ${other.tokenType}');
    }
    return ok;
  }

  @override
  bool operator ==(Object other) => equals(other);

  @override
  int get hashCode => Object.hash(offset, length, lexeme, tokenType);

  @override
  String toString() => 'SToken($lexeme)';
}

/// Factory for deserializing AST nodes
class SAstNodeFactory {
  static final Map<String, SAstNode Function(Map<String, dynamic>)> _factories =
      {};
  static bool _initialized = false;

  /// Register a factory for a node type
  static void register(
    String nodeType,
    SAstNode Function(Map<String, dynamic>) factory,
  ) {
    _factories[nodeType] = factory;
  }

  /// Initialize all factories (called automatically on first use)
  static void _ensureInitialized() {
    if (_initialized) return;
    _initialized = true;
    _registerAllFactories();
  }

  /// Deserialize a node from JSON
  static SAstNode? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    _ensureInitialized();
    final nodeType = json['nodeType'] as String?;
    if (nodeType == null) return null;
    final factory = _factories[nodeType];
    if (factory == null) {
      // Return a generic node for unknown types
      return _SUnknownNode(json);
    }
    return factory(json);
  }

  /// Deserialize a list of nodes from JSON
  static List<T> listFromJson<T extends SAstNode>(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .cast<Map<String, dynamic>>()
        .map((json) => fromJson(json))
        .whereType<T>()
        .toList();
  }
}

/// Placeholder for unknown node types
class _SUnknownNode extends SAstNode {
  final Map<String, dynamic> _json;

  _SUnknownNode(this._json);

  @override
  String get nodeType => _json['nodeType'] as String? ?? 'Unknown';

  @override
  int get offset => _json['offset'] as int? ?? 0;

  @override
  int get length => _json['length'] as int? ?? 0;

  @override
  Map<String, dynamic> toJson() => _json;

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitNode(this);

  @override
  void visitChildren(SAstVisitor visitor) {}
}

/// Register all node type factories
void _registerAllFactories() {
  // Compilation unit
  SAstNodeFactory.register('CompilationUnit', SCompilationUnit.fromJson);

  // Declarations
  SAstNodeFactory.register(
    'FunctionDeclaration',
    SFunctionDeclaration.fromJson,
  );
  SAstNodeFactory.register('MethodDeclaration', SMethodDeclaration.fromJson);
  SAstNodeFactory.register('ClassDeclaration', SClassDeclaration.fromJson);
  SAstNodeFactory.register('MixinDeclaration', SMixinDeclaration.fromJson);
  SAstNodeFactory.register('EnumDeclaration', SEnumDeclaration.fromJson);
  SAstNodeFactory.register(
    'ExtensionDeclaration',
    SExtensionDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'VariableDeclaration',
    SVariableDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'VariableDeclarationList',
    SVariableDeclarationList.fromJson,
  );
  SAstNodeFactory.register('FieldDeclaration', SFieldDeclaration.fromJson);
  SAstNodeFactory.register(
    'ConstructorDeclaration',
    SConstructorDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'TopLevelVariableDeclaration',
    STopLevelVariableDeclaration.fromJson,
  );
  SAstNodeFactory.register('TypedefDeclaration', STypedefDeclaration.fromJson);
  SAstNodeFactory.register(
    'EnumConstantDeclaration',
    SEnumConstantDeclaration.fromJson,
  );

  // Statements
  SAstNodeFactory.register('Block', SBlock.fromJson);
  SAstNodeFactory.register(
    'VariableDeclarationStatement',
    SVariableDeclarationStatement.fromJson,
  );
  SAstNodeFactory.register(
    'ExpressionStatement',
    SExpressionStatement.fromJson,
  );
  SAstNodeFactory.register('ReturnStatement', SReturnStatement.fromJson);
  SAstNodeFactory.register('IfStatement', SIfStatement.fromJson);
  SAstNodeFactory.register('ForStatement', SForStatement.fromJson);
  SAstNodeFactory.register(
    'ForPartsWithDeclarations',
    SForPartsWithDeclarations.fromJson,
  );
  SAstNodeFactory.register(
    'ForPartsWithExpression',
    SForPartsWithExpression.fromJson,
  );
  SAstNodeFactory.register('ForEachStatement', SForEachStatement.fromJson);
  SAstNodeFactory.register(
    'ForEachPartsWithDeclaration',
    SForEachPartsWithDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'ForEachPartsWithIdentifier',
    SForEachPartsWithIdentifier.fromJson,
  );
  SAstNodeFactory.register('DeclaredIdentifier', SDeclaredIdentifier.fromJson);
  SAstNodeFactory.register('WhileStatement', SWhileStatement.fromJson);
  SAstNodeFactory.register('DoStatement', SDoStatement.fromJson);
  SAstNodeFactory.register('SwitchStatement', SSwitchStatement.fromJson);
  SAstNodeFactory.register('SwitchCase', SSwitchCase.fromJson);
  SAstNodeFactory.register('SwitchDefault', SSwitchDefault.fromJson);
  SAstNodeFactory.register('TryStatement', STryStatement.fromJson);
  SAstNodeFactory.register('CatchClause', SCatchClause.fromJson);
  SAstNodeFactory.register('BreakStatement', SBreakStatement.fromJson);
  SAstNodeFactory.register('ContinueStatement', SContinueStatement.fromJson);
  SAstNodeFactory.register('AssertStatement', SAssertStatement.fromJson);
  SAstNodeFactory.register('YieldStatement', SYieldStatement.fromJson);
  SAstNodeFactory.register('LabeledStatement', SLabeledStatement.fromJson);
  SAstNodeFactory.register('EmptyStatement', SEmptyStatement.fromJson);

  // Expressions
  SAstNodeFactory.register('BinaryExpression', SBinaryExpression.fromJson);
  SAstNodeFactory.register('PrefixExpression', SPrefixExpression.fromJson);
  SAstNodeFactory.register('PostfixExpression', SPostfixExpression.fromJson);
  SAstNodeFactory.register(
    'ConditionalExpression',
    SConditionalExpression.fromJson,
  );
  SAstNodeFactory.register(
    'AssignmentExpression',
    SAssignmentExpression.fromJson,
  );
  SAstNodeFactory.register('MethodInvocation', SMethodInvocation.fromJson);
  SAstNodeFactory.register(
    'FunctionExpressionInvocation',
    SFunctionExpressionInvocation.fromJson,
  );
  SAstNodeFactory.register('IndexExpression', SIndexExpression.fromJson);
  SAstNodeFactory.register('PropertyAccess', SPropertyAccess.fromJson);
  SAstNodeFactory.register('PrefixedIdentifier', SPrefixedIdentifier.fromJson);
  SAstNodeFactory.register('SimpleIdentifier', SSimpleIdentifier.fromJson);
  SAstNodeFactory.register(
    'ParenthesizedExpression',
    SParenthesizedExpression.fromJson,
  );
  SAstNodeFactory.register('FunctionExpression', SFunctionExpression.fromJson);
  SAstNodeFactory.register(
    'InstanceCreationExpression',
    SInstanceCreationExpression.fromJson,
  );
  SAstNodeFactory.register('ThisExpression', SThisExpression.fromJson);
  SAstNodeFactory.register('SuperExpression', SSuperExpression.fromJson);
  SAstNodeFactory.register('ThrowExpression', SThrowExpression.fromJson);
  SAstNodeFactory.register('AwaitExpression', SAwaitExpression.fromJson);
  SAstNodeFactory.register('AsExpression', SAsExpression.fromJson);
  SAstNodeFactory.register('IsExpression', SIsExpression.fromJson);
  SAstNodeFactory.register('CascadeExpression', SCascadeExpression.fromJson);
  SAstNodeFactory.register('RethrowExpression', SRethrowExpression.fromJson);
  SAstNodeFactory.register('NamedExpression', SNamedExpression.fromJson);
  SAstNodeFactory.register('SpreadElement', SSpreadElement.fromJson);
  SAstNodeFactory.register('NullAwareElement', SNullAwareElement.fromJson);
  SAstNodeFactory.register('IfElement', SIfElement.fromJson);
  SAstNodeFactory.register('ForElement', SForElement.fromJson);

  // Literals
  SAstNodeFactory.register('IntegerLiteral', SIntegerLiteral.fromJson);
  SAstNodeFactory.register('DoubleLiteral', SDoubleLiteral.fromJson);
  SAstNodeFactory.register('BooleanLiteral', SBooleanLiteral.fromJson);
  SAstNodeFactory.register(
    'SimpleStringLiteral',
    SSimpleStringLiteral.fromJson,
  );
  SAstNodeFactory.register(
    'StringInterpolation',
    SStringInterpolation.fromJson,
  );
  SAstNodeFactory.register('AdjacentStrings', SAdjacentStrings.fromJson);
  SAstNodeFactory.register('NullLiteral', SNullLiteral.fromJson);
  SAstNodeFactory.register('ListLiteral', SListLiteral.fromJson);
  SAstNodeFactory.register('SetOrMapLiteral', SSetOrMapLiteral.fromJson);
  SAstNodeFactory.register('MapLiteralEntry', SMapLiteralEntry.fromJson);
  SAstNodeFactory.register('SymbolLiteral', SSymbolLiteral.fromJson);
  SAstNodeFactory.register(
    'InterpolationExpression',
    SInterpolationExpression.fromJson,
  );
  SAstNodeFactory.register(
    'InterpolationString',
    SInterpolationString.fromJson,
  );
  SAstNodeFactory.register('RecordLiteral', SRecordLiteral.fromJson);

  // Types
  SAstNodeFactory.register('NamedType', SNamedType.fromJson);
  SAstNodeFactory.register(
    'GenericFunctionType',
    SGenericFunctionType.fromJson,
  );
  SAstNodeFactory.register('TypeArgumentList', STypeArgumentList.fromJson);
  SAstNodeFactory.register('TypeParameterList', STypeParameterList.fromJson);
  SAstNodeFactory.register('TypeParameter', STypeParameter.fromJson);
  SAstNodeFactory.register(
    'RecordTypeAnnotation',
    SRecordTypeAnnotation.fromJson,
  );

  // Function-related
  SAstNodeFactory.register(
    'FormalParameterList',
    SFormalParameterList.fromJson,
  );
  SAstNodeFactory.register(
    'SimpleFormalParameter',
    SSimpleFormalParameter.fromJson,
  );
  SAstNodeFactory.register(
    'DefaultFormalParameter',
    SDefaultFormalParameter.fromJson,
  );
  SAstNodeFactory.register(
    'FieldFormalParameter',
    SFieldFormalParameter.fromJson,
  );
  SAstNodeFactory.register(
    'FunctionTypedFormalParameter',
    SFunctionTypedFormalParameter.fromJson,
  );
  SAstNodeFactory.register(
    'SuperFormalParameter',
    SSuperFormalParameter.fromJson,
  );
  SAstNodeFactory.register('BlockFunctionBody', SBlockFunctionBody.fromJson);
  SAstNodeFactory.register(
    'ExpressionFunctionBody',
    SExpressionFunctionBody.fromJson,
  );
  SAstNodeFactory.register('EmptyFunctionBody', SEmptyFunctionBody.fromJson);
  SAstNodeFactory.register('NativeFunctionBody', SNativeFunctionBody.fromJson);

  // Constructor-related
  SAstNodeFactory.register('ConstructorName', SConstructorName.fromJson);
  SAstNodeFactory.register(
    'SuperConstructorInvocation',
    SSuperConstructorInvocation.fromJson,
  );
  SAstNodeFactory.register(
    'RedirectingConstructorInvocation',
    SRedirectingConstructorInvocation.fromJson,
  );
  SAstNodeFactory.register(
    'ConstructorFieldInitializer',
    SConstructorFieldInitializer.fromJson,
  );
  SAstNodeFactory.register('AssertInitializer', SAssertInitializer.fromJson);

  // Directives
  SAstNodeFactory.register('ImportDirective', SImportDirective.fromJson);
  SAstNodeFactory.register('ExportDirective', SExportDirective.fromJson);
  SAstNodeFactory.register('PartDirective', SPartDirective.fromJson);
  SAstNodeFactory.register('PartOfDirective', SPartOfDirective.fromJson);
  SAstNodeFactory.register('LibraryDirective', SLibraryDirective.fromJson);

  // Misc
  SAstNodeFactory.register('ArgumentList', SArgumentList.fromJson);
  SAstNodeFactory.register('Annotation', SAnnotation.fromJson);
  SAstNodeFactory.register('Comment', SComment.fromJson);
  SAstNodeFactory.register('ShowCombinator', SShowCombinator.fromJson);
  SAstNodeFactory.register('HideCombinator', SHideCombinator.fromJson);
  SAstNodeFactory.register('Label', SLabel.fromJson);
  SAstNodeFactory.register('ExtendsClause', SExtendsClause.fromJson);
  SAstNodeFactory.register('ImplementsClause', SImplementsClause.fromJson);
  SAstNodeFactory.register('WithClause', SWithClause.fromJson);
  SAstNodeFactory.register('OnClause', SOnClause.fromJson);

  // Patterns
  SAstNodeFactory.register('GuardedPattern', SGuardedPattern.fromJson);
  SAstNodeFactory.register('WhenClause', SWhenClause.fromJson);
  SAstNodeFactory.register('CaseClause', SCaseClause.fromJson);
  SAstNodeFactory.register('ConstantPattern', SConstantPattern.fromJson);
  SAstNodeFactory.register('WildcardPattern', SWildcardPattern.fromJson);
  SAstNodeFactory.register(
    'DeclaredVariablePattern',
    SDeclaredVariablePattern.fromJson,
  );
  SAstNodeFactory.register(
    'AssignedVariablePattern',
    SAssignedVariablePattern.fromJson,
  );
  SAstNodeFactory.register('ObjectPattern', SObjectPattern.fromJson);
  SAstNodeFactory.register('ListPattern', SListPattern.fromJson);
  SAstNodeFactory.register('MapPattern', SMapPattern.fromJson);
  SAstNodeFactory.register('MapPatternEntry', SMapPatternEntry.fromJson);
  SAstNodeFactory.register('RecordPattern', SRecordPattern.fromJson);
  SAstNodeFactory.register('PatternField', SPatternField.fromJson);
  SAstNodeFactory.register('PatternFieldName', SPatternFieldName.fromJson);
  SAstNodeFactory.register('LogicalOrPattern', SLogicalOrPattern.fromJson);
  SAstNodeFactory.register('LogicalAndPattern', SLogicalAndPattern.fromJson);
  SAstNodeFactory.register('CastPattern', SCastPattern.fromJson);
  SAstNodeFactory.register('RelationalPattern', SRelationalPattern.fromJson);
  SAstNodeFactory.register('NullCheckPattern', SNullCheckPattern.fromJson);
  SAstNodeFactory.register('NullAssertPattern', SNullAssertPattern.fromJson);
  SAstNodeFactory.register(
    'ParenthesizedPattern',
    SParenthesizedPattern.fromJson,
  );
  SAstNodeFactory.register('RestPatternElement', SRestPatternElement.fromJson);
  SAstNodeFactory.register(
    'PatternVariableDeclaration',
    SPatternVariableDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'SwitchExpressionCase',
    SSwitchExpressionCase.fromJson,
  );
  SAstNodeFactory.register('SwitchPatternCase', SSwitchPatternCase.fromJson);

  // Pattern statements/expressions (in other files)
  SAstNodeFactory.register(
    'PatternVariableDeclarationStatement',
    SPatternVariableDeclarationStatement.fromJson,
  );
  SAstNodeFactory.register('SwitchExpression', SSwitchExpression.fromJson);
  SAstNodeFactory.register('PatternAssignment', SPatternAssignment.fromJson);
  SAstNodeFactory.register('FunctionReference', SFunctionReference.fromJson);
  SAstNodeFactory.register(
    'ConstructorReference',
    SConstructorReference.fromJson,
  );

  // New declarations
  SAstNodeFactory.register(
    'ExtensionTypeDeclaration',
    SExtensionTypeDeclaration.fromJson,
  );
  SAstNodeFactory.register(
    'RepresentationDeclaration',
    SRepresentationDeclaration.fromJson,
  );
}

// ============================================================================
// Compilation Unit
// ============================================================================

/// A complete Dart compilation unit (file)
class SCompilationUnit extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// Script tag (e.g., #!/usr/bin/env dart)
  final String? scriptTag;

  /// Directives (imports, exports, parts, library)
  final List<SDirective> directives;

  /// Declarations (classes, functions, variables, etc.)
  final List<SDeclaration> declarations;

  /// Comments in the file
  final List<SComment> comments;

  /// Whether the source had parse errors (e.g., from error recovery).
  /// Used by eval() to distinguish valid declarations from error recovery artifacts.
  final bool hasParseErrors;

  SCompilationUnit({
    required this.offset,
    required this.length,
    this.scriptTag,
    this.directives = const [],
    this.declarations = const [],
    this.comments = const [],
    this.hasParseErrors = false,
  });

  @override
  String get nodeType => 'CompilationUnit';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (scriptTag != null) 'scriptTag': scriptTag,
    'directives': directives.map((d) => d.toJson()).toList(),
    'declarations': declarations.map((d) => d.toJson()).toList(),
    'comments': comments.map((c) => c.toJson()).toList(),
    if (hasParseErrors) 'hasParseErrors': true,
  };

  factory SCompilationUnit.fromJson(Map<String, dynamic> json) {
    return SCompilationUnit(
      offset: json['offset'] as int,
      length: json['length'] as int,
      scriptTag: json['scriptTag'] as String?,
      directives: SAstNodeFactory.listFromJson<SDirective>(
        json['directives'] as List?,
      ),
      declarations: SAstNodeFactory.listFromJson<SDeclaration>(
        json['declarations'] as List?,
      ),
      comments:
          (json['comments'] as List?)
              ?.map((c) => SComment.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      hasParseErrors: json['hasParseErrors'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitCompilationUnit(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final directive in directives) {
      directive.accept(visitor);
    }
    for (final declaration in declarations) {
      declaration.accept(visitor);
    }
    for (final comment in comments) {
      comment.accept(visitor);
    }
  }
}
