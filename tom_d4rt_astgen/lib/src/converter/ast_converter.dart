// AST Converter: Converts from Dart analyzer AST to serializable AST
// ignore_for_file: implementation_imports

import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:analyzer/dart/ast/token.dart' as analyzer show Token;

import 'package:tom_d4rt_ast/src/ast/ast_core.dart';

/// Converts Dart analyzer AST nodes to serializable AST nodes
class AstConverter {
  /// Convert a compilation unit
  SCompilationUnit convertCompilationUnit(analyzer.CompilationUnit unit) {
    final directives = <SAstNode>[];
    final declarations = <SAstNode>[];
    final comments = <SComment>[];

    // Convert directives
    for (final directive in unit.directives) {
      final converted = convert(directive);
      if (converted != null) {
        directives.add(converted);
      }
    }

    // Convert declarations
    for (final declaration in unit.declarations) {
      final converted = convert(declaration);
      if (converted != null) {
        declarations.add(converted);
      }
    }

    return SCompilationUnit(
      offset: unit.offset,
      length: unit.length,
      scriptTag: unit.scriptTag?.scriptTag.lexeme,
      directives: directives,
      declarations: declarations,
      comments: comments,
    );
  }

  /// Main dispatch method to convert any AST node
  SAstNode? convert(analyzer.AstNode? node) {
    if (node == null) return null;

    // Declarations
    if (node is analyzer.FunctionDeclaration) return _convertFunctionDeclaration(node);
    if (node is analyzer.MethodDeclaration) return _convertMethodDeclaration(node);
    if (node is analyzer.ClassDeclaration) return _convertClassDeclaration(node);
    if (node is analyzer.MixinDeclaration) return _convertMixinDeclaration(node);
    if (node is analyzer.EnumDeclaration) return _convertEnumDeclaration(node);
    if (node is analyzer.ExtensionDeclaration) return _convertExtensionDeclaration(node);
    if (node is analyzer.VariableDeclaration) return _convertVariableDeclaration(node);
    if (node is analyzer.VariableDeclarationList) return _convertVariableDeclarationList(node);
    if (node is analyzer.FieldDeclaration) return _convertFieldDeclaration(node);
    if (node is analyzer.ConstructorDeclaration) return _convertConstructorDeclaration(node);
    if (node is analyzer.TopLevelVariableDeclaration) return _convertTopLevelVariableDeclaration(node);
    if (node is analyzer.FunctionTypeAlias) return _convertFunctionTypeAlias(node);
    if (node is analyzer.GenericTypeAlias) return _convertGenericTypeAlias(node);
    if (node is analyzer.EnumConstantDeclaration) return _convertEnumConstantDeclaration(node);

    // Statements
    if (node is analyzer.Block) return _convertBlock(node);
    if (node is analyzer.VariableDeclarationStatement) return _convertVariableDeclarationStatement(node);
    if (node is analyzer.ExpressionStatement) return _convertExpressionStatement(node);
    if (node is analyzer.ReturnStatement) return _convertReturnStatement(node);
    if (node is analyzer.IfStatement) return _convertIfStatement(node);
    if (node is analyzer.ForStatement) return _convertForStatement(node);
    if (node is analyzer.WhileStatement) return _convertWhileStatement(node);
    if (node is analyzer.DoStatement) return _convertDoStatement(node);
    if (node is analyzer.SwitchStatement) return _convertSwitchStatement(node);
    if (node is analyzer.TryStatement) return _convertTryStatement(node);
    if (node is analyzer.BreakStatement) return _convertBreakStatement(node);
    if (node is analyzer.ContinueStatement) return _convertContinueStatement(node);
    if (node is analyzer.AssertStatement) return _convertAssertStatement(node);
    if (node is analyzer.YieldStatement) return _convertYieldStatement(node);
    if (node is analyzer.LabeledStatement) return _convertLabeledStatement(node);
    if (node is analyzer.EmptyStatement) return _convertEmptyStatement(node);

    // Expressions
    if (node is analyzer.SimpleIdentifier) return _convertSimpleIdentifier(node);
    if (node is analyzer.PrefixedIdentifier) return _convertPrefixedIdentifier(node);
    if (node is analyzer.BinaryExpression) return _convertBinaryExpression(node);
    if (node is analyzer.PrefixExpression) return _convertPrefixExpression(node);
    if (node is analyzer.PostfixExpression) return _convertPostfixExpression(node);
    if (node is analyzer.ConditionalExpression) return _convertConditionalExpression(node);
    if (node is analyzer.AssignmentExpression) return _convertAssignmentExpression(node);
    if (node is analyzer.MethodInvocation) return _convertMethodInvocation(node);
    if (node is analyzer.FunctionExpressionInvocation) return _convertFunctionExpressionInvocation(node);
    if (node is analyzer.IndexExpression) return _convertIndexExpression(node);
    if (node is analyzer.PropertyAccess) return _convertPropertyAccess(node);
    if (node is analyzer.ParenthesizedExpression) return _convertParenthesizedExpression(node);
    if (node is analyzer.FunctionExpression) return _convertFunctionExpression(node);
    if (node is analyzer.InstanceCreationExpression) return _convertInstanceCreationExpression(node);
    if (node is analyzer.ThisExpression) return _convertThisExpression(node);
    if (node is analyzer.SuperExpression) return _convertSuperExpression(node);
    if (node is analyzer.ThrowExpression) return _convertThrowExpression(node);
    if (node is analyzer.AwaitExpression) return _convertAwaitExpression(node);
    if (node is analyzer.AsExpression) return _convertAsExpression(node);
    if (node is analyzer.IsExpression) return _convertIsExpression(node);
    if (node is analyzer.CascadeExpression) return _convertCascadeExpression(node);
    if (node is analyzer.RethrowExpression) return _convertRethrowExpression(node);
    if (node is analyzer.NamedExpression) return _convertNamedExpression(node);
    if (node is analyzer.SpreadElement) return _convertSpreadElement(node);
    if (node is analyzer.IfElement) return _convertIfElement(node);
    if (node is analyzer.ForElement) return _convertForElement(node);

    // Literals
    if (node is analyzer.IntegerLiteral) return _convertIntegerLiteral(node);
    if (node is analyzer.DoubleLiteral) return _convertDoubleLiteral(node);
    if (node is analyzer.BooleanLiteral) return _convertBooleanLiteral(node);
    if (node is analyzer.SimpleStringLiteral) return _convertSimpleStringLiteral(node);
    if (node is analyzer.StringInterpolation) return _convertStringInterpolation(node);
    if (node is analyzer.AdjacentStrings) return _convertAdjacentStrings(node);
    if (node is analyzer.NullLiteral) return _convertNullLiteral(node);
    if (node is analyzer.ListLiteral) return _convertListLiteral(node);
    if (node is analyzer.SetOrMapLiteral) return _convertSetOrMapLiteral(node);
    if (node is analyzer.MapLiteralEntry) return _convertMapLiteralEntry(node);
    if (node is analyzer.SymbolLiteral) return _convertSymbolLiteral(node);
    if (node is analyzer.RecordLiteral) return _convertRecordLiteral(node);

    // Types
    if (node is analyzer.NamedType) return _convertNamedType(node);
    if (node is analyzer.GenericFunctionType) return _convertGenericFunctionType(node);
    if (node is analyzer.TypeArgumentList) return _convertTypeArgumentList(node);
    if (node is analyzer.TypeParameterList) return _convertTypeParameterList(node);
    if (node is analyzer.TypeParameter) return _convertTypeParameter(node);
    if (node is analyzer.RecordTypeAnnotation) return _convertRecordTypeAnnotation(node);

    // Parameters
    if (node is analyzer.FormalParameterList) return _convertFormalParameterList(node);
    if (node is analyzer.SimpleFormalParameter) return _convertSimpleFormalParameter(node);
    if (node is analyzer.DefaultFormalParameter) return _convertDefaultFormalParameter(node);
    if (node is analyzer.FieldFormalParameter) return _convertFieldFormalParameter(node);
    if (node is analyzer.FunctionTypedFormalParameter) return _convertFunctionTypedFormalParameter(node);
    if (node is analyzer.SuperFormalParameter) return _convertSuperFormalParameter(node);

    // Function bodies
    if (node is analyzer.BlockFunctionBody) return _convertBlockFunctionBody(node);
    if (node is analyzer.ExpressionFunctionBody) return _convertExpressionFunctionBody(node);
    if (node is analyzer.EmptyFunctionBody) return _convertEmptyFunctionBody(node);
    if (node is analyzer.NativeFunctionBody) return _convertNativeFunctionBody(node);

    // Directives
    if (node is analyzer.ImportDirective) return _convertImportDirective(node);
    if (node is analyzer.ExportDirective) return _convertExportDirective(node);
    if (node is analyzer.PartDirective) return _convertPartDirective(node);
    if (node is analyzer.PartOfDirective) return _convertPartOfDirective(node);
    if (node is analyzer.LibraryDirective) return _convertLibraryDirective(node);

    // Misc
    if (node is analyzer.ArgumentList) return _convertArgumentList(node);
    if (node is analyzer.Annotation) return _convertAnnotation(node);
    if (node is analyzer.Comment) return _convertComment(node);
    if (node is analyzer.Label) return _convertLabel(node);
    if (node is analyzer.ExtendsClause) return _convertExtendsClause(node);
    if (node is analyzer.ImplementsClause) return _convertImplementsClause(node);
    if (node is analyzer.WithClause) return _convertWithClause(node);
    if (node is analyzer.ConstructorName) return _convertConstructorName(node);
    if (node is analyzer.SuperConstructorInvocation) return _convertSuperConstructorInvocation(node);
    if (node is analyzer.RedirectingConstructorInvocation) return _convertRedirectingConstructorInvocation(node);
    if (node is analyzer.ConstructorFieldInitializer) return _convertConstructorFieldInitializer(node);
    if (node is analyzer.AssertInitializer) return _convertAssertInitializer(node);
    if (node is analyzer.ShowCombinator) return _convertShowCombinator(node);
    if (node is analyzer.HideCombinator) return _convertHideCombinator(node);

    // For parts
    if (node is analyzer.ForPartsWithDeclarations) return _convertForPartsWithDeclarations(node);
    if (node is analyzer.ForPartsWithExpression) return _convertForPartsWithExpression(node);
    if (node is analyzer.ForEachPartsWithDeclaration) return _convertForEachPartsWithDeclaration(node);
    if (node is analyzer.ForEachPartsWithIdentifier) return _convertForEachPartsWithIdentifier(node);
    if (node is analyzer.DeclaredIdentifier) return _convertDeclaredIdentifier(node);

    // Switch parts
    if (node is analyzer.SwitchCase) return _convertSwitchCase(node);
    if (node is analyzer.SwitchDefault) return _convertSwitchDefault(node);

    // Catch clause
    if (node is analyzer.CatchClause) return _convertCatchClause(node);

    // Interpolation parts
    if (node is analyzer.InterpolationExpression) return _convertInterpolationExpression(node);
    if (node is analyzer.InterpolationString) return _convertInterpolationString(node);

    // Unknown node type - return a placeholder
    return _SUnknownNode(
      offset: node.offset,
      length: node.length,
      originalType: node.runtimeType.toString(),
    );
  }

  // ============================================================================
  // Helper to convert token to SSimpleIdentifier
  // ============================================================================

  SSimpleIdentifier? _tokenToIdentifier(analyzer.Token? token) {
    if (token == null) return null;
    return SSimpleIdentifier(
      offset: token.offset,
      length: token.length,
      name: token.lexeme,
      inDeclarationContext: true,
    );
  }

  // ============================================================================
  // Declaration converters
  // ============================================================================

  SFunctionDeclaration _convertFunctionDeclaration(analyzer.FunctionDeclaration node) {
    return SFunctionDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      returnType: convert(node.returnType),
      isGetter: node.isGetter,
      isSetter: node.isSetter,
      isExternal: node.externalKeyword != null,
      typeParameters: convert(node.functionExpression.typeParameters) as STypeParameterList?,
      functionExpression: convert(node.functionExpression) as SFunctionExpression?,
    );
  }

  SMethodDeclaration _convertMethodDeclaration(analyzer.MethodDeclaration node) {
    return SMethodDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      returnType: convert(node.returnType),
      isStatic: node.isStatic,
      isAbstract: node.isAbstract,
      isExternal: node.externalKeyword != null,
      isGetter: node.isGetter,
      isSetter: node.isSetter,
      isOperator: node.isOperator,
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      parameters: convert(node.parameters) as SFormalParameterList?,
      body: convert(node.body),
    );
  }

  SClassDeclaration _convertClassDeclaration(analyzer.ClassDeclaration node) {
    return SClassDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      isAbstract: node.abstractKeyword != null,
      isSealed: node.sealedKeyword != null,
      isBase: node.baseKeyword != null,
      isInterface: node.interfaceKeyword != null,
      isFinal: node.finalKeyword != null,
      isMixin: node.mixinKeyword != null,
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      extendsClause: convert(node.extendsClause) as SExtendsClause?,
      withClause: convert(node.withClause) as SWithClause?,
      implementsClause: convert(node.implementsClause) as SImplementsClause?,
      members: _convertNodes(node.members),
    );
  }

  SMixinDeclaration _convertMixinDeclaration(analyzer.MixinDeclaration node) {
    return SMixinDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      onClause: _convertOnClause(node.onClause),
      implementsClause: convert(node.implementsClause) as SImplementsClause?,
      members: _convertNodes(node.members),
    );
  }

  SEnumDeclaration _convertEnumDeclaration(analyzer.EnumDeclaration node) {
    return SEnumDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      withClause: convert(node.withClause) as SWithClause?,
      implementsClause: convert(node.implementsClause) as SImplementsClause?,
      constants: _convertNodes(node.constants).cast<SEnumConstantDeclaration>(),
      members: _convertNodes(node.members),
    );
  }

  SExtensionDeclaration _convertExtensionDeclaration(analyzer.ExtensionDeclaration node) {
    return SExtensionDeclaration(
      offset: node.offset,
      length: node.length,
      name: node.name != null ? _tokenToIdentifier(node.name!) : null,
      metadata: _convertAnnotations(node.metadata),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      extendedType: convert(node.onClause?.extendedType),
      members: _convertNodes(node.members),
    );
  }

  SVariableDeclaration _convertVariableDeclaration(analyzer.VariableDeclaration node) {
    return SVariableDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      initializer: convert(node.initializer),
    );
  }

  SVariableDeclarationList _convertVariableDeclarationList(analyzer.VariableDeclarationList node) {
    return SVariableDeclarationList(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      isLate: node.lateKeyword != null,
      isFinal: node.isFinal,
      isConst: node.isConst,
      type: convert(node.type),
      variables: _convertNodes(node.variables).cast<SVariableDeclaration>(),
    );
  }

  SFieldDeclaration _convertFieldDeclaration(analyzer.FieldDeclaration node) {
    return SFieldDeclaration(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      isStatic: node.isStatic,
      isAbstract: node.abstractKeyword != null,
      isCovariant: node.covariantKeyword != null,
      isExternal: node.externalKeyword != null,
      fields: convert(node.fields) as SVariableDeclarationList?,
    );
  }

  SConstructorDeclaration _convertConstructorDeclaration(analyzer.ConstructorDeclaration node) {
    return SConstructorDeclaration(
      offset: node.offset,
      length: node.length,
      name: node.name != null ? _tokenToIdentifier(node.name!) : null,
      metadata: _convertAnnotations(node.metadata),
      isConst: node.constKeyword != null,
      isFactory: node.factoryKeyword != null,
      isExternal: node.externalKeyword != null,
      parameters: convert(node.parameters) as SFormalParameterList?,
      redirectedConstructor: convert(node.redirectedConstructor) as SConstructorName?,
      initializers: _convertNodes(node.initializers),
      body: convert(node.body),
    );
  }

  STopLevelVariableDeclaration _convertTopLevelVariableDeclaration(analyzer.TopLevelVariableDeclaration node) {
    return STopLevelVariableDeclaration(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      isExternal: node.externalKeyword != null,
      variables: convert(node.variables) as SVariableDeclarationList?,
    );
  }

  STypedefDeclaration _convertFunctionTypeAlias(analyzer.FunctionTypeAlias node) {
    return STypedefDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      type: null,
    );
  }

  STypedefDeclaration _convertGenericTypeAlias(analyzer.GenericTypeAlias node) {
    return STypedefDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      type: convert(node.type),
    );
  }

  SEnumConstantDeclaration _convertEnumConstantDeclaration(analyzer.EnumConstantDeclaration node) {
    return SEnumConstantDeclaration(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      metadata: _convertAnnotations(node.metadata),
      arguments: convert(node.arguments?.argumentList) as SArgumentList?,
    );
  }

  // ============================================================================
  // Statement converters
  // ============================================================================

  SBlock _convertBlock(analyzer.Block node) {
    return SBlock(
      offset: node.offset,
      length: node.length,
      statements: _convertNodes(node.statements),
    );
  }

  SVariableDeclarationStatement _convertVariableDeclarationStatement(analyzer.VariableDeclarationStatement node) {
    return SVariableDeclarationStatement(
      offset: node.offset,
      length: node.length,
      variables: convert(node.variables) as SVariableDeclarationList?,
    );
  }

  SExpressionStatement _convertExpressionStatement(analyzer.ExpressionStatement node) {
    return SExpressionStatement(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SReturnStatement _convertReturnStatement(analyzer.ReturnStatement node) {
    return SReturnStatement(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SIfStatement _convertIfStatement(analyzer.IfStatement node) {
    return SIfStatement(
      offset: node.offset,
      length: node.length,
      condition: convert(node.expression),
      thenStatement: convert(node.thenStatement),
      elseStatement: convert(node.elseStatement),
    );
  }

  SForStatement _convertForStatement(analyzer.ForStatement node) {
    return SForStatement(
      offset: node.offset,
      length: node.length,
      forLoopParts: convert(node.forLoopParts),
      body: convert(node.body),
    );
  }

  SForPartsWithDeclarations _convertForPartsWithDeclarations(analyzer.ForPartsWithDeclarations node) {
    return SForPartsWithDeclarations(
      offset: node.offset,
      length: node.length,
      variables: convert(node.variables) as SVariableDeclarationList?,
      condition: convert(node.condition),
      updaters: _convertNodes(node.updaters),
    );
  }

  SForPartsWithExpression _convertForPartsWithExpression(analyzer.ForPartsWithExpression node) {
    return SForPartsWithExpression(
      offset: node.offset,
      length: node.length,
      initialization: convert(node.initialization),
      condition: convert(node.condition),
      updaters: _convertNodes(node.updaters),
    );
  }

  SForEachPartsWithDeclaration _convertForEachPartsWithDeclaration(analyzer.ForEachPartsWithDeclaration node) {
    return SForEachPartsWithDeclaration(
      offset: node.offset,
      length: node.length,
      loopVariable: convert(node.loopVariable) as SDeclaredIdentifier?,
      iterable: convert(node.iterable),
    );
  }

  SForEachPartsWithIdentifier _convertForEachPartsWithIdentifier(analyzer.ForEachPartsWithIdentifier node) {
    return SForEachPartsWithIdentifier(
      offset: node.offset,
      length: node.length,
      identifier: convert(node.identifier) as SSimpleIdentifier?,
      iterable: convert(node.iterable),
    );
  }

  SDeclaredIdentifier _convertDeclaredIdentifier(analyzer.DeclaredIdentifier node) {
    return SDeclaredIdentifier(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      isFinal: node.isFinal,
      isConst: node.isConst,
      type: convert(node.type),
      identifier: _tokenToIdentifier(node.name),
    );
  }

  SWhileStatement _convertWhileStatement(analyzer.WhileStatement node) {
    return SWhileStatement(
      offset: node.offset,
      length: node.length,
      condition: convert(node.condition),
      body: convert(node.body),
    );
  }

  SDoStatement _convertDoStatement(analyzer.DoStatement node) {
    return SDoStatement(
      offset: node.offset,
      length: node.length,
      body: convert(node.body),
      condition: convert(node.condition),
    );
  }

  SSwitchStatement _convertSwitchStatement(analyzer.SwitchStatement node) {
    final members = <SAstNode>[];
    for (final member in node.members) {
      final converted = convert(member);
      if (converted != null) {
        members.add(converted);
      }
    }
    return SSwitchStatement(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
      members: members,
    );
  }

  SSwitchCase _convertSwitchCase(analyzer.SwitchCase node) {
    return SSwitchCase(
      offset: node.offset,
      length: node.length,
      labels: _convertNodes(node.labels).cast<SLabel>(),
      expression: convert(node.expression),
      statements: _convertNodes(node.statements),
    );
  }

  SSwitchDefault _convertSwitchDefault(analyzer.SwitchDefault node) {
    return SSwitchDefault(
      offset: node.offset,
      length: node.length,
      labels: _convertNodes(node.labels).cast<SLabel>(),
      statements: _convertNodes(node.statements),
    );
  }

  STryStatement _convertTryStatement(analyzer.TryStatement node) {
    return STryStatement(
      offset: node.offset,
      length: node.length,
      body: convert(node.body) as SBlock?,
      catchClauses: _convertNodes(node.catchClauses).cast<SCatchClause>(),
      finallyBlock: convert(node.finallyBlock) as SBlock?,
    );
  }

  SCatchClause _convertCatchClause(analyzer.CatchClause node) {
    return SCatchClause(
      offset: node.offset,
      length: node.length,
      exceptionType: convert(node.exceptionType),
      exceptionParameter: node.exceptionParameter != null
          ? _tokenToIdentifier(node.exceptionParameter!.name)
          : null,
      stackTraceParameter: node.stackTraceParameter != null
          ? _tokenToIdentifier(node.stackTraceParameter!.name)
          : null,
      body: convert(node.body) as SBlock?,
    );
  }

  SBreakStatement _convertBreakStatement(analyzer.BreakStatement node) {
    return SBreakStatement(
      offset: node.offset,
      length: node.length,
      label: node.label != null ? convert(node.label!) as SSimpleIdentifier? : null,
    );
  }

  SContinueStatement _convertContinueStatement(analyzer.ContinueStatement node) {
    return SContinueStatement(
      offset: node.offset,
      length: node.length,
      label: node.label != null ? convert(node.label!) as SSimpleIdentifier? : null,
    );
  }

  SAssertStatement _convertAssertStatement(analyzer.AssertStatement node) {
    return SAssertStatement(
      offset: node.offset,
      length: node.length,
      condition: convert(node.condition),
      message: convert(node.message),
    );
  }

  SYieldStatement _convertYieldStatement(analyzer.YieldStatement node) {
    return SYieldStatement(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
      isStar: node.star != null,
    );
  }

  SLabeledStatement _convertLabeledStatement(analyzer.LabeledStatement node) {
    return SLabeledStatement(
      offset: node.offset,
      length: node.length,
      labels: _convertNodes(node.labels).cast<SLabel>(),
      statement: convert(node.statement),
    );
  }

  SEmptyStatement _convertEmptyStatement(analyzer.EmptyStatement node) {
    return SEmptyStatement(
      offset: node.offset,
      length: node.length,
    );
  }

  // ============================================================================
  // Expression converters
  // ============================================================================

  SSimpleIdentifier _convertSimpleIdentifier(analyzer.SimpleIdentifier node) {
    return SSimpleIdentifier(
      offset: node.offset,
      length: node.length,
      name: node.name,
      inDeclarationContext: node.inDeclarationContext(),
    );
  }

  SPrefixedIdentifier _convertPrefixedIdentifier(analyzer.PrefixedIdentifier node) {
    return SPrefixedIdentifier(
      offset: node.offset,
      length: node.length,
      prefix: convert(node.prefix) as SSimpleIdentifier?,
      identifier: convert(node.identifier) as SSimpleIdentifier?,
    );
  }

  SBinaryExpression _convertBinaryExpression(analyzer.BinaryExpression node) {
    return SBinaryExpression(
      offset: node.offset,
      length: node.length,
      leftOperand: convert(node.leftOperand),
      operator: node.operator.lexeme,
      rightOperand: convert(node.rightOperand),
    );
  }

  SPrefixExpression _convertPrefixExpression(analyzer.PrefixExpression node) {
    return SPrefixExpression(
      offset: node.offset,
      length: node.length,
      operator: node.operator.lexeme,
      operand: convert(node.operand),
    );
  }

  SPostfixExpression _convertPostfixExpression(analyzer.PostfixExpression node) {
    return SPostfixExpression(
      offset: node.offset,
      length: node.length,
      operand: convert(node.operand),
      operator: node.operator.lexeme,
    );
  }

  SConditionalExpression _convertConditionalExpression(analyzer.ConditionalExpression node) {
    return SConditionalExpression(
      offset: node.offset,
      length: node.length,
      condition: convert(node.condition),
      thenExpression: convert(node.thenExpression),
      elseExpression: convert(node.elseExpression),
    );
  }

  SAssignmentExpression _convertAssignmentExpression(analyzer.AssignmentExpression node) {
    return SAssignmentExpression(
      offset: node.offset,
      length: node.length,
      leftHandSide: convert(node.leftHandSide),
      operator: node.operator.lexeme,
      rightHandSide: convert(node.rightHandSide),
    );
  }

  SMethodInvocation _convertMethodInvocation(analyzer.MethodInvocation node) {
    return SMethodInvocation(
      offset: node.offset,
      length: node.length,
      target: convert(node.target),
      operator: node.operator?.lexeme,
      methodName: convert(node.methodName) as SSimpleIdentifier?,
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      argumentList: convert(node.argumentList) as SArgumentList?,
    );
  }

  SFunctionExpressionInvocation _convertFunctionExpressionInvocation(analyzer.FunctionExpressionInvocation node) {
    return SFunctionExpressionInvocation(
      offset: node.offset,
      length: node.length,
      function: convert(node.function),
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      argumentList: convert(node.argumentList) as SArgumentList?,
    );
  }

  SIndexExpression _convertIndexExpression(analyzer.IndexExpression node) {
    return SIndexExpression(
      offset: node.offset,
      length: node.length,
      target: convert(node.target),
      index: convert(node.index),
      isNullAware: node.period != null,
    );
  }

  SPropertyAccess _convertPropertyAccess(analyzer.PropertyAccess node) {
    return SPropertyAccess(
      offset: node.offset,
      length: node.length,
      target: convert(node.target),
      operator: node.operator.lexeme,
      propertyName: convert(node.propertyName) as SSimpleIdentifier?,
    );
  }

  SParenthesizedExpression _convertParenthesizedExpression(analyzer.ParenthesizedExpression node) {
    return SParenthesizedExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SFunctionExpression _convertFunctionExpression(analyzer.FunctionExpression node) {
    return SFunctionExpression(
      offset: node.offset,
      length: node.length,
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      parameters: convert(node.parameters) as SFormalParameterList?,
      body: convert(node.body),
    );
  }

  SInstanceCreationExpression _convertInstanceCreationExpression(analyzer.InstanceCreationExpression node) {
    return SInstanceCreationExpression(
      offset: node.offset,
      length: node.length,
      isConst: node.isConst,
      constructorName: convert(node.constructorName) as SConstructorName?,
      argumentList: convert(node.argumentList) as SArgumentList?,
    );
  }

  SThisExpression _convertThisExpression(analyzer.ThisExpression node) {
    return SThisExpression(
      offset: node.offset,
      length: node.length,
    );
  }

  SSuperExpression _convertSuperExpression(analyzer.SuperExpression node) {
    return SSuperExpression(
      offset: node.offset,
      length: node.length,
    );
  }

  SThrowExpression _convertThrowExpression(analyzer.ThrowExpression node) {
    return SThrowExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SAwaitExpression _convertAwaitExpression(analyzer.AwaitExpression node) {
    return SAwaitExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SAsExpression _convertAsExpression(analyzer.AsExpression node) {
    return SAsExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
      type: convert(node.type),
    );
  }

  SIsExpression _convertIsExpression(analyzer.IsExpression node) {
    return SIsExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
      isNot: node.notOperator != null,
      type: convert(node.type),
    );
  }

  SCascadeExpression _convertCascadeExpression(analyzer.CascadeExpression node) {
    return SCascadeExpression(
      offset: node.offset,
      length: node.length,
      target: convert(node.target),
      cascadeSections: _convertNodes(node.cascadeSections),
    );
  }

  SRethrowExpression _convertRethrowExpression(analyzer.RethrowExpression node) {
    return SRethrowExpression(
      offset: node.offset,
      length: node.length,
    );
  }

  SNamedExpression _convertNamedExpression(analyzer.NamedExpression node) {
    return SNamedExpression(
      offset: node.offset,
      length: node.length,
      name: convert(node.name) as SLabel?,
      expression: convert(node.expression),
    );
  }

  SSpreadElement _convertSpreadElement(analyzer.SpreadElement node) {
    return SSpreadElement(
      offset: node.offset,
      length: node.length,
      isNullAware: node.spreadOperator.lexeme == '...?',
      expression: convert(node.expression),
    );
  }

  SIfElement _convertIfElement(analyzer.IfElement node) {
    return SIfElement(
      offset: node.offset,
      length: node.length,
      condition: convert(node.expression),
      thenElement: convert(node.thenElement),
      elseElement: convert(node.elseElement),
    );
  }

  SForElement _convertForElement(analyzer.ForElement node) {
    return SForElement(
      offset: node.offset,
      length: node.length,
      forLoopParts: convert(node.forLoopParts),
      body: convert(node.body),
    );
  }

  // ============================================================================
  // Literal converters
  // ============================================================================

  SIntegerLiteral _convertIntegerLiteral(analyzer.IntegerLiteral node) {
    return SIntegerLiteral(
      offset: node.offset,
      length: node.length,
      value: node.value ?? 0,
    );
  }

  SDoubleLiteral _convertDoubleLiteral(analyzer.DoubleLiteral node) {
    return SDoubleLiteral(
      offset: node.offset,
      length: node.length,
      value: node.value,
    );
  }

  SBooleanLiteral _convertBooleanLiteral(analyzer.BooleanLiteral node) {
    return SBooleanLiteral(
      offset: node.offset,
      length: node.length,
      value: node.value,
    );
  }

  SSimpleStringLiteral _convertSimpleStringLiteral(analyzer.SimpleStringLiteral node) {
    return SSimpleStringLiteral(
      offset: node.offset,
      length: node.length,
      value: node.value,
      isMultiline: node.isMultiline,
      isRaw: node.isRaw,
    );
  }

  SStringInterpolation _convertStringInterpolation(analyzer.StringInterpolation node) {
    return SStringInterpolation(
      offset: node.offset,
      length: node.length,
      elements: _convertNodes(node.elements),
    );
  }

  SInterpolationExpression _convertInterpolationExpression(analyzer.InterpolationExpression node) {
    return SInterpolationExpression(
      offset: node.offset,
      length: node.length,
      expression: convert(node.expression),
    );
  }

  SInterpolationString _convertInterpolationString(analyzer.InterpolationString node) {
    return SInterpolationString(
      offset: node.offset,
      length: node.length,
      value: node.value,
    );
  }

  SAdjacentStrings _convertAdjacentStrings(analyzer.AdjacentStrings node) {
    return SAdjacentStrings(
      offset: node.offset,
      length: node.length,
      strings: _convertNodes(node.strings),
    );
  }

  SNullLiteral _convertNullLiteral(analyzer.NullLiteral node) {
    return SNullLiteral(
      offset: node.offset,
      length: node.length,
    );
  }

  SListLiteral _convertListLiteral(analyzer.ListLiteral node) {
    return SListLiteral(
      offset: node.offset,
      length: node.length,
      isConst: node.constKeyword != null,
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      elements: _convertNodes(node.elements),
    );
  }

  SSetOrMapLiteral _convertSetOrMapLiteral(analyzer.SetOrMapLiteral node) {
    return SSetOrMapLiteral(
      offset: node.offset,
      length: node.length,
      isConst: node.constKeyword != null,
      isMap: node.isMap,
      isSet: node.isSet,
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      elements: _convertNodes(node.elements),
    );
  }

  SMapLiteralEntry _convertMapLiteralEntry(analyzer.MapLiteralEntry node) {
    return SMapLiteralEntry(
      offset: node.offset,
      length: node.length,
      key: convert(node.key),
      value: convert(node.value),
    );
  }

  SSymbolLiteral _convertSymbolLiteral(analyzer.SymbolLiteral node) {
    final components = node.components.map((t) => t.lexeme).join('.');
    return SSymbolLiteral(
      offset: node.offset,
      length: node.length,
      value: components,
    );
  }

  SRecordLiteral _convertRecordLiteral(analyzer.RecordLiteral node) {
    return SRecordLiteral(
      offset: node.offset,
      length: node.length,
      isConst: node.constKeyword != null,
      fields: _convertNodes(node.fields),
    );
  }

  // ============================================================================
  // Type converters
  // ============================================================================

  SNamedType _convertNamedType(analyzer.NamedType node) {
    return SNamedType(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      isNullable: node.question != null,
      importPrefix: node.importPrefix != null
          ? _tokenToIdentifier(node.importPrefix!.name)
          : null,
    );
  }

  SGenericFunctionType _convertGenericFunctionType(analyzer.GenericFunctionType node) {
    return SGenericFunctionType(
      offset: node.offset,
      length: node.length,
      returnType: convert(node.returnType),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      parameters: convert(node.parameters) as SFormalParameterList?,
      isNullable: node.question != null,
    );
  }

  STypeArgumentList _convertTypeArgumentList(analyzer.TypeArgumentList node) {
    return STypeArgumentList(
      offset: node.offset,
      length: node.length,
      arguments: _convertNodes(node.arguments),
    );
  }

  STypeParameterList _convertTypeParameterList(analyzer.TypeParameterList node) {
    return STypeParameterList(
      offset: node.offset,
      length: node.length,
      typeParameters: _convertNodes(node.typeParameters).cast<STypeParameter>(),
    );
  }

  STypeParameter _convertTypeParameter(analyzer.TypeParameter node) {
    return STypeParameter(
      offset: node.offset,
      length: node.length,
      name: _tokenToIdentifier(node.name),
      bound: convert(node.bound),
    );
  }

  SRecordTypeAnnotation _convertRecordTypeAnnotation(analyzer.RecordTypeAnnotation node) {
    final positionalFields = <SAstNode>[];
    final namedFields = <SAstNode>[];
    
    for (final field in node.positionalFields) {
      final converted = convert(field);
      if (converted != null) {
        positionalFields.add(converted);
      }
    }
    
    if (node.namedFields != null) {
      for (final field in node.namedFields!.fields) {
        final converted = convert(field);
        if (converted != null) {
          namedFields.add(converted);
        }
      }
    }

    return SRecordTypeAnnotation(
      offset: node.offset,
      length: node.length,
      positionalFields: positionalFields,
      namedFields: namedFields,
      isNullable: node.question != null,
    );
  }

  // ============================================================================
  // Parameter converters
  // ============================================================================

  SFormalParameterList _convertFormalParameterList(analyzer.FormalParameterList node) {
    return SFormalParameterList(
      offset: node.offset,
      length: node.length,
      parameters: _convertNodes(node.parameters),
    );
  }

  SSimpleFormalParameter _convertSimpleFormalParameter(analyzer.SimpleFormalParameter node) {
    return SSimpleFormalParameter(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      type: convert(node.type),
      name: node.name != null ? _tokenToIdentifier(node.name!) : null,
      isCovariant: node.covariantKeyword != null,
      isRequired: node.requiredKeyword != null,
      isFinal: node.keyword?.lexeme == 'final',
    );
  }

  SDefaultFormalParameter _convertDefaultFormalParameter(analyzer.DefaultFormalParameter node) {
    return SDefaultFormalParameter(
      offset: node.offset,
      length: node.length,
      parameter: convert(node.parameter),
      defaultValue: convert(node.defaultValue),
      isNamed: node.isNamed,
    );
  }

  SFieldFormalParameter _convertFieldFormalParameter(analyzer.FieldFormalParameter node) {
    return SFieldFormalParameter(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      type: convert(node.type),
      name: _tokenToIdentifier(node.name),
      parameters: convert(node.parameters) as SFormalParameterList?,
      isRequired: node.requiredKeyword != null,
      isFinal: node.keyword?.lexeme == 'final',
    );
  }

  SFunctionTypedFormalParameter _convertFunctionTypedFormalParameter(analyzer.FunctionTypedFormalParameter node) {
    return SFunctionTypedFormalParameter(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      returnType: convert(node.returnType),
      name: _tokenToIdentifier(node.name),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      parameters: convert(node.parameters) as SFormalParameterList?,
      isRequired: node.requiredKeyword != null,
    );
  }

  SSuperFormalParameter _convertSuperFormalParameter(analyzer.SuperFormalParameter node) {
    return SSuperFormalParameter(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      type: convert(node.type),
      name: _tokenToIdentifier(node.name),
      typeParameters: convert(node.typeParameters) as STypeParameterList?,
      parameters: convert(node.parameters) as SFormalParameterList?,
    );
  }

  // ============================================================================
  // Function body converters
  // ============================================================================

  SBlockFunctionBody _convertBlockFunctionBody(analyzer.BlockFunctionBody node) {
    return SBlockFunctionBody(
      offset: node.offset,
      length: node.length,
      isAsync: node.isAsynchronous,
      isGenerator: node.isGenerator,
      block: convert(node.block) as SBlock?,
    );
  }

  SExpressionFunctionBody _convertExpressionFunctionBody(analyzer.ExpressionFunctionBody node) {
    return SExpressionFunctionBody(
      offset: node.offset,
      length: node.length,
      isAsync: node.isAsynchronous,
      expression: convert(node.expression),
    );
  }

  SEmptyFunctionBody _convertEmptyFunctionBody(analyzer.EmptyFunctionBody node) {
    return SEmptyFunctionBody(
      offset: node.offset,
      length: node.length,
    );
  }

  SNativeFunctionBody _convertNativeFunctionBody(analyzer.NativeFunctionBody node) {
    return SNativeFunctionBody(
      offset: node.offset,
      length: node.length,
      stringLiteral: convert(node.stringLiteral) as SSimpleStringLiteral?,
    );
  }

  // ============================================================================
  // Directive converters
  // ============================================================================

  SImportDirective _convertImportDirective(analyzer.ImportDirective node) {
    return SImportDirective(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      uri: convert(node.uri),
      prefix: node.prefix != null ? _convertSimpleIdentifier(node.prefix!) : null,
      isDeferred: node.deferredKeyword != null,
      combinators: _convertCombinators(node.combinators),
    );
  }

  SExportDirective _convertExportDirective(analyzer.ExportDirective node) {
    return SExportDirective(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      uri: convert(node.uri),
      combinators: _convertCombinators(node.combinators),
    );
  }

  SPartDirective _convertPartDirective(analyzer.PartDirective node) {
    return SPartDirective(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      uri: convert(node.uri),
    );
  }

  SPartOfDirective _convertPartOfDirective(analyzer.PartOfDirective node) {
    return SPartOfDirective(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      libraryName: convert(node.libraryName),
      uri: convert(node.uri),
    );
  }

  SLibraryDirective _convertLibraryDirective(analyzer.LibraryDirective node) {
    return SLibraryDirective(
      offset: node.offset,
      length: node.length,
      metadata: _convertAnnotations(node.metadata),
      // ignore: deprecated_member_use
      name: convert(node.name2),
    );
  }

  SShowCombinator _convertShowCombinator(analyzer.ShowCombinator node) {
    return SShowCombinator(
      offset: node.offset,
      length: node.length,
      shownNames: node.shownNames.map(_convertSimpleIdentifier).toList(),
    );
  }

  SHideCombinator _convertHideCombinator(analyzer.HideCombinator node) {
    return SHideCombinator(
      offset: node.offset,
      length: node.length,
      hiddenNames: node.hiddenNames.map(_convertSimpleIdentifier).toList(),
    );
  }

  // ============================================================================
  // Misc converters
  // ============================================================================

  SArgumentList _convertArgumentList(analyzer.ArgumentList node) {
    return SArgumentList(
      offset: node.offset,
      length: node.length,
      arguments: _convertNodes(node.arguments),
    );
  }

  SAnnotation _convertAnnotation(analyzer.Annotation node) {
    return SAnnotation(
      offset: node.offset,
      length: node.length,
      name: convert(node.name) as SSimpleIdentifier?,
      typeArguments: convert(node.typeArguments) as STypeArgumentList?,
      constructorName: node.constructorName != null
          ? convert(node.constructorName!) as SSimpleIdentifier?
          : null,
      arguments: convert(node.arguments) as SArgumentList?,
    );
  }

  SComment _convertComment(analyzer.Comment node) {
    // Collect all tokens as content
    final buffer = StringBuffer();
    var token = node.beginToken;
    while (true) {
      buffer.write(token.lexeme);
      if (token == node.endToken) break;
      final next = token.next;
      if (next == null) break;
      token = next;
    }

    String commentType;
    final lexeme = node.beginToken.lexeme;
    if (lexeme.startsWith('///') || lexeme.startsWith('/**')) {
      commentType = 'documentation';
    } else if (lexeme.startsWith('//')) {
      commentType = 'line';
    } else {
      commentType = 'block';
    }

    return SComment(
      offset: node.offset,
      length: node.length,
      content: buffer.toString(),
      commentType: commentType,
    );
  }

  SLabel _convertLabel(analyzer.Label node) {
    return SLabel(
      offset: node.offset,
      length: node.length,
      label: convert(node.label) as SSimpleIdentifier?,
    );
  }

  SExtendsClause _convertExtendsClause(analyzer.ExtendsClause node) {
    return SExtendsClause(
      offset: node.offset,
      length: node.length,
      superclass: convert(node.superclass) as SNamedType?,
    );
  }

  SImplementsClause _convertImplementsClause(analyzer.ImplementsClause node) {
    return SImplementsClause(
      offset: node.offset,
      length: node.length,
      interfaces: _convertNodes(node.interfaces).cast<SNamedType>(),
    );
  }

  SWithClause _convertWithClause(analyzer.WithClause node) {
    return SWithClause(
      offset: node.offset,
      length: node.length,
      mixinTypes: _convertNodes(node.mixinTypes).cast<SNamedType>(),
    );
  }

  SOnClause? _convertOnClause(analyzer.MixinOnClause? node) {
    if (node == null) return null;
    return SOnClause(
      offset: node.offset,
      length: node.length,
      superclassConstraints: _convertNodes(node.superclassConstraints).cast<SNamedType>(),
    );
  }

  SConstructorName _convertConstructorName(analyzer.ConstructorName node) {
    return SConstructorName(
      offset: node.offset,
      length: node.length,
      type: convert(node.type) as SNamedType?,
      name: node.name != null ? convert(node.name!) as SSimpleIdentifier? : null,
    );
  }

  SSuperConstructorInvocation _convertSuperConstructorInvocation(analyzer.SuperConstructorInvocation node) {
    return SSuperConstructorInvocation(
      offset: node.offset,
      length: node.length,
      constructorName: node.constructorName != null
          ? convert(node.constructorName!) as SSimpleIdentifier?
          : null,
      argumentList: convert(node.argumentList) as SArgumentList?,
    );
  }

  SRedirectingConstructorInvocation _convertRedirectingConstructorInvocation(analyzer.RedirectingConstructorInvocation node) {
    return SRedirectingConstructorInvocation(
      offset: node.offset,
      length: node.length,
      constructorName: node.constructorName != null
          ? convert(node.constructorName!) as SSimpleIdentifier?
          : null,
      argumentList: convert(node.argumentList) as SArgumentList?,
    );
  }

  SConstructorFieldInitializer _convertConstructorFieldInitializer(analyzer.ConstructorFieldInitializer node) {
    return SConstructorFieldInitializer(
      offset: node.offset,
      length: node.length,
      fieldName: convert(node.fieldName) as SSimpleIdentifier?,
      expression: convert(node.expression),
    );
  }

  SAssertInitializer _convertAssertInitializer(analyzer.AssertInitializer node) {
    return SAssertInitializer(
      offset: node.offset,
      length: node.length,
      condition: convert(node.condition),
      message: convert(node.message),
    );
  }

  // ============================================================================
  // Helper methods
  // ============================================================================

  /// Convert a list of nodes
  List<SAstNode> _convertNodes(List<analyzer.AstNode> nodes) {
    final result = <SAstNode>[];
    for (final node in nodes) {
      final converted = convert(node);
      if (converted != null) {
        result.add(converted);
      }
    }
    return result;
  }

  /// Convert annotations/metadata
  List<SAnnotation> _convertAnnotations(analyzer.NodeList<analyzer.Annotation> metadata) {
    final result = <SAnnotation>[];
    for (final annotation in metadata) {
      result.add(_convertAnnotation(annotation));
    }
    return result;
  }

  /// Convert combinators
  List<SAstNode> _convertCombinators(analyzer.NodeList<analyzer.Combinator> combinators) {
    final result = <SAstNode>[];
    for (final combinator in combinators) {
      final converted = convert(combinator);
      if (converted != null) {
        result.add(converted);
      }
    }
    return result;
  }
}

/// Unknown node placeholder
class _SUnknownNode extends SAstNode {
  @override
  final int offset;
  @override
  final int length;
  final String originalType;

  _SUnknownNode({
    required this.offset,
    required this.length,
    required this.originalType,
  });

  @override
  String get nodeType => 'Unknown';

  @override
  Map<String, dynamic> toJson() => {
        'nodeType': nodeType,
        'offset': offset,
        'length': length,
        'originalType': originalType,
      };
}
