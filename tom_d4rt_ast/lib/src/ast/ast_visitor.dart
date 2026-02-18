// SAstNode visitor pattern for D4rt AST traversal
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// SAstVisitor — flat visitor with visitNode as the universal fallback
// ============================================================================

/// A visitor for the serializable AST node hierarchy.
///
/// Every concrete [SAstNode] subclass has a corresponding `visit*` method.
/// All methods return `T?` and default to [visitNode], which itself returns
/// `null`. Override [visitNode] to provide a catch-all, or override individual
/// methods for targeted processing.
///
/// See also [GeneralizingSAstVisitor] which adds category-level fallback
/// methods (e.g. `visitExpression`, `visitStatement`).
abstract class SAstVisitor<T> {
  /// The universal fallback — called for any node that is not handled by a
  /// more specific method.
  T? visitNode(SAstNode node) => null;

  // --------------------------------------------------------------------------
  // Compilation unit
  // --------------------------------------------------------------------------

  /// Visit a [SCompilationUnit].
  T? visitCompilationUnit(SCompilationUnit node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Expressions
  // --------------------------------------------------------------------------

  /// Visit a [SSimpleIdentifier].
  T? visitSimpleIdentifier(SSimpleIdentifier node) => visitNode(node);

  /// Visit a [SPrefixedIdentifier].
  T? visitPrefixedIdentifier(SPrefixedIdentifier node) => visitNode(node);

  /// Visit a [SBinaryExpression].
  T? visitBinaryExpression(SBinaryExpression node) => visitNode(node);

  /// Visit a [SPrefixExpression].
  T? visitPrefixExpression(SPrefixExpression node) => visitNode(node);

  /// Visit a [SPostfixExpression].
  T? visitPostfixExpression(SPostfixExpression node) => visitNode(node);

  /// Visit a [SConditionalExpression].
  T? visitConditionalExpression(SConditionalExpression node) => visitNode(node);

  /// Visit a [SAssignmentExpression].
  T? visitAssignmentExpression(SAssignmentExpression node) => visitNode(node);

  /// Visit a [SMethodInvocation].
  T? visitMethodInvocation(SMethodInvocation node) => visitNode(node);

  /// Visit a [SFunctionExpressionInvocation].
  T? visitFunctionExpressionInvocation(SFunctionExpressionInvocation node) =>
      visitNode(node);

  /// Visit a [SIndexExpression].
  T? visitIndexExpression(SIndexExpression node) => visitNode(node);

  /// Visit a [SPropertyAccess].
  T? visitPropertyAccess(SPropertyAccess node) => visitNode(node);

  /// Visit a [SParenthesizedExpression].
  T? visitParenthesizedExpression(SParenthesizedExpression node) =>
      visitNode(node);

  /// Visit a [SFunctionExpression].
  T? visitFunctionExpression(SFunctionExpression node) => visitNode(node);

  /// Visit a [SInstanceCreationExpression].
  T? visitInstanceCreationExpression(SInstanceCreationExpression node) =>
      visitNode(node);

  /// Visit a [SThisExpression].
  T? visitThisExpression(SThisExpression node) => visitNode(node);

  /// Visit a [SSuperExpression].
  T? visitSuperExpression(SSuperExpression node) => visitNode(node);

  /// Visit a [SThrowExpression].
  T? visitThrowExpression(SThrowExpression node) => visitNode(node);

  /// Visit a [SAwaitExpression].
  T? visitAwaitExpression(SAwaitExpression node) => visitNode(node);

  /// Visit a [SAsExpression].
  T? visitAsExpression(SAsExpression node) => visitNode(node);

  /// Visit a [SIsExpression].
  T? visitIsExpression(SIsExpression node) => visitNode(node);

  /// Visit a [SCascadeExpression].
  T? visitCascadeExpression(SCascadeExpression node) => visitNode(node);

  /// Visit a [SRethrowExpression].
  T? visitRethrowExpression(SRethrowExpression node) => visitNode(node);

  /// Visit a [SNamedExpression].
  T? visitNamedExpression(SNamedExpression node) => visitNode(node);

  /// Visit a [SSpreadElement].
  T? visitSpreadElement(SSpreadElement node) => visitNode(node);

  /// Visit a [SIfElement].
  T? visitIfElement(SIfElement node) => visitNode(node);

  /// Visit a [SForElement].
  T? visitForElement(SForElement node) => visitNode(node);

  /// Visit a [SSwitchExpression].
  T? visitSwitchExpression(SSwitchExpression node) => visitNode(node);

  /// Visit a [SFunctionReference].
  T? visitFunctionReference(SFunctionReference node) => visitNode(node);

  /// Visit a [SConstructorReference].
  T? visitConstructorReference(SConstructorReference node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Literals
  // --------------------------------------------------------------------------

  /// Visit a [SIntegerLiteral].
  T? visitIntegerLiteral(SIntegerLiteral node) => visitNode(node);

  /// Visit a [SDoubleLiteral].
  T? visitDoubleLiteral(SDoubleLiteral node) => visitNode(node);

  /// Visit a [SBooleanLiteral].
  T? visitBooleanLiteral(SBooleanLiteral node) => visitNode(node);

  /// Visit a [SSimpleStringLiteral].
  T? visitSimpleStringLiteral(SSimpleStringLiteral node) => visitNode(node);

  /// Visit a [SStringInterpolation].
  T? visitStringInterpolation(SStringInterpolation node) => visitNode(node);

  /// Visit a [SAdjacentStrings].
  T? visitAdjacentStrings(SAdjacentStrings node) => visitNode(node);

  /// Visit a [SNullLiteral].
  T? visitNullLiteral(SNullLiteral node) => visitNode(node);

  /// Visit a [SListLiteral].
  T? visitListLiteral(SListLiteral node) => visitNode(node);

  /// Visit a [SSetOrMapLiteral].
  T? visitSetOrMapLiteral(SSetOrMapLiteral node) => visitNode(node);

  /// Visit a [SSymbolLiteral].
  T? visitSymbolLiteral(SSymbolLiteral node) => visitNode(node);

  /// Visit a [SRecordLiteral].
  T? visitRecordLiteral(SRecordLiteral node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Statements
  // --------------------------------------------------------------------------

  /// Visit a [SBlock].
  T? visitBlock(SBlock node) => visitNode(node);

  /// Visit a [SVariableDeclarationStatement].
  T? visitVariableDeclarationStatement(SVariableDeclarationStatement node) =>
      visitNode(node);

  /// Visit a [SExpressionStatement].
  T? visitExpressionStatement(SExpressionStatement node) => visitNode(node);

  /// Visit a [SReturnStatement].
  T? visitReturnStatement(SReturnStatement node) => visitNode(node);

  /// Visit a [SIfStatement].
  T? visitIfStatement(SIfStatement node) => visitNode(node);

  /// Visit a [SForStatement].
  T? visitForStatement(SForStatement node) => visitNode(node);

  /// Visit a [SWhileStatement].
  T? visitWhileStatement(SWhileStatement node) => visitNode(node);

  /// Visit a [SDoStatement].
  T? visitDoStatement(SDoStatement node) => visitNode(node);

  /// Visit a [SSwitchStatement].
  T? visitSwitchStatement(SSwitchStatement node) => visitNode(node);

  /// Visit a [STryStatement].
  T? visitTryStatement(STryStatement node) => visitNode(node);

  /// Visit a [SBreakStatement].
  T? visitBreakStatement(SBreakStatement node) => visitNode(node);

  /// Visit a [SContinueStatement].
  T? visitContinueStatement(SContinueStatement node) => visitNode(node);

  /// Visit a [SAssertStatement].
  T? visitAssertStatement(SAssertStatement node) => visitNode(node);

  /// Visit a [SYieldStatement].
  T? visitYieldStatement(SYieldStatement node) => visitNode(node);

  /// Visit a [SLabeledStatement].
  T? visitLabeledStatement(SLabeledStatement node) => visitNode(node);

  /// Visit a [SEmptyStatement].
  T? visitEmptyStatement(SEmptyStatement node) => visitNode(node);

  /// Visit a [SPatternVariableDeclarationStatement].
  T? visitPatternVariableDeclarationStatement(
    SPatternVariableDeclarationStatement node,
  ) => visitNode(node);

  // --------------------------------------------------------------------------
  // Declarations
  // --------------------------------------------------------------------------

  /// Visit a [SFunctionDeclaration].
  T? visitFunctionDeclaration(SFunctionDeclaration node) => visitNode(node);

  /// Visit a [SMethodDeclaration].
  T? visitMethodDeclaration(SMethodDeclaration node) => visitNode(node);

  /// Visit a [SClassDeclaration].
  T? visitClassDeclaration(SClassDeclaration node) => visitNode(node);

  /// Visit a [SMixinDeclaration].
  T? visitMixinDeclaration(SMixinDeclaration node) => visitNode(node);

  /// Visit a [SEnumDeclaration].
  T? visitEnumDeclaration(SEnumDeclaration node) => visitNode(node);

  /// Visit a [SExtensionDeclaration].
  T? visitExtensionDeclaration(SExtensionDeclaration node) => visitNode(node);

  /// Visit a [SVariableDeclaration].
  T? visitVariableDeclaration(SVariableDeclaration node) => visitNode(node);

  /// Visit a [SFieldDeclaration].
  T? visitFieldDeclaration(SFieldDeclaration node) => visitNode(node);

  /// Visit a [SConstructorDeclaration].
  T? visitConstructorDeclaration(SConstructorDeclaration node) =>
      visitNode(node);

  /// Visit a [STopLevelVariableDeclaration].
  T? visitTopLevelVariableDeclaration(STopLevelVariableDeclaration node) =>
      visitNode(node);

  /// Visit a [STypedefDeclaration].
  T? visitTypedefDeclaration(STypedefDeclaration node) => visitNode(node);

  /// Visit a [SEnumConstantDeclaration].
  T? visitEnumConstantDeclaration(SEnumConstantDeclaration node) =>
      visitNode(node);

  /// Visit a [SExtensionTypeDeclaration].
  T? visitExtensionTypeDeclaration(SExtensionTypeDeclaration node) =>
      visitNode(node);

  // --------------------------------------------------------------------------
  // Directives
  // --------------------------------------------------------------------------

  /// Visit a [SImportDirective].
  T? visitImportDirective(SImportDirective node) => visitNode(node);

  /// Visit a [SExportDirective].
  T? visitExportDirective(SExportDirective node) => visitNode(node);

  /// Visit a [SPartDirective].
  T? visitPartDirective(SPartDirective node) => visitNode(node);

  /// Visit a [SPartOfDirective].
  T? visitPartOfDirective(SPartOfDirective node) => visitNode(node);

  /// Visit a [SLibraryDirective].
  T? visitLibraryDirective(SLibraryDirective node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Type annotations
  // --------------------------------------------------------------------------

  /// Visit a [SNamedType].
  T? visitNamedType(SNamedType node) => visitNode(node);

  /// Visit a [SGenericFunctionType].
  T? visitGenericFunctionType(SGenericFunctionType node) => visitNode(node);

  /// Visit a [SRecordTypeAnnotation].
  T? visitRecordTypeAnnotation(SRecordTypeAnnotation node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Formal parameters
  // --------------------------------------------------------------------------

  /// Visit a [SSimpleFormalParameter].
  T? visitSimpleFormalParameter(SSimpleFormalParameter node) => visitNode(node);

  /// Visit a [SDefaultFormalParameter].
  T? visitDefaultFormalParameter(SDefaultFormalParameter node) =>
      visitNode(node);

  /// Visit a [SFieldFormalParameter].
  T? visitFieldFormalParameter(SFieldFormalParameter node) => visitNode(node);

  /// Visit a [SFunctionTypedFormalParameter].
  T? visitFunctionTypedFormalParameter(SFunctionTypedFormalParameter node) =>
      visitNode(node);

  /// Visit a [SSuperFormalParameter].
  T? visitSuperFormalParameter(SSuperFormalParameter node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Function bodies
  // --------------------------------------------------------------------------

  /// Visit a [SBlockFunctionBody].
  T? visitBlockFunctionBody(SBlockFunctionBody node) => visitNode(node);

  /// Visit a [SExpressionFunctionBody].
  T? visitExpressionFunctionBody(SExpressionFunctionBody node) =>
      visitNode(node);

  /// Visit a [SEmptyFunctionBody].
  T? visitEmptyFunctionBody(SEmptyFunctionBody node) => visitNode(node);

  /// Visit a [SNativeFunctionBody].
  T? visitNativeFunctionBody(SNativeFunctionBody node) => visitNode(node);

  // --------------------------------------------------------------------------
  // For parts
  // --------------------------------------------------------------------------

  /// Visit a [SForPartsWithDeclarations].
  T? visitForPartsWithDeclarations(SForPartsWithDeclarations node) =>
      visitNode(node);

  /// Visit a [SForPartsWithExpression].
  T? visitForPartsWithExpression(SForPartsWithExpression node) =>
      visitNode(node);

  /// Visit a [SForEachPartsWithDeclaration].
  T? visitForEachPartsWithDeclaration(SForEachPartsWithDeclaration node) =>
      visitNode(node);

  /// Visit a [SForEachPartsWithIdentifier].
  T? visitForEachPartsWithIdentifier(SForEachPartsWithIdentifier node) =>
      visitNode(node);

  // --------------------------------------------------------------------------
  // Combinators
  // --------------------------------------------------------------------------

  /// Visit a [SShowCombinator].
  T? visitShowCombinator(SShowCombinator node) => visitNode(node);

  /// Visit a [SHideCombinator].
  T? visitHideCombinator(SHideCombinator node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Constructor initializers
  // --------------------------------------------------------------------------

  /// Visit a [SSuperConstructorInvocation].
  T? visitSuperConstructorInvocation(SSuperConstructorInvocation node) =>
      visitNode(node);

  /// Visit a [SRedirectingConstructorInvocation].
  T? visitRedirectingConstructorInvocation(
    SRedirectingConstructorInvocation node,
  ) => visitNode(node);

  /// Visit a [SConstructorFieldInitializer].
  T? visitConstructorFieldInitializer(SConstructorFieldInitializer node) =>
      visitNode(node);

  /// Visit a [SAssertInitializer].
  T? visitAssertInitializer(SAssertInitializer node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Patterns
  // --------------------------------------------------------------------------

  /// Visit a [SConstantPattern].
  T? visitConstantPattern(SConstantPattern node) => visitNode(node);

  /// Visit a [SWildcardPattern].
  T? visitWildcardPattern(SWildcardPattern node) => visitNode(node);

  /// Visit a [SDeclaredVariablePattern].
  T? visitDeclaredVariablePattern(SDeclaredVariablePattern node) =>
      visitNode(node);

  /// Visit a [SAssignedVariablePattern].
  T? visitAssignedVariablePattern(SAssignedVariablePattern node) =>
      visitNode(node);

  /// Visit a [SObjectPattern].
  T? visitObjectPattern(SObjectPattern node) => visitNode(node);

  /// Visit a [SListPattern].
  T? visitListPattern(SListPattern node) => visitNode(node);

  /// Visit a [SMapPattern].
  T? visitMapPattern(SMapPattern node) => visitNode(node);

  /// Visit a [SRecordPattern].
  T? visitRecordPattern(SRecordPattern node) => visitNode(node);

  /// Visit a [SLogicalOrPattern].
  T? visitLogicalOrPattern(SLogicalOrPattern node) => visitNode(node);

  /// Visit a [SLogicalAndPattern].
  T? visitLogicalAndPattern(SLogicalAndPattern node) => visitNode(node);

  /// Visit a [SCastPattern].
  T? visitCastPattern(SCastPattern node) => visitNode(node);

  /// Visit a [SRelationalPattern].
  T? visitRelationalPattern(SRelationalPattern node) => visitNode(node);

  /// Visit a [SNullCheckPattern].
  T? visitNullCheckPattern(SNullCheckPattern node) => visitNode(node);

  /// Visit a [SNullAssertPattern].
  T? visitNullAssertPattern(SNullAssertPattern node) => visitNode(node);

  /// Visit a [SRestPatternElement].
  T? visitRestPatternElement(SRestPatternElement node) => visitNode(node);

  /// Visit a [SPatternAssignment].
  T? visitPatternAssignment(SPatternAssignment node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Misc
  // --------------------------------------------------------------------------

  /// Visit a [SVariableDeclarationList].
  T? visitVariableDeclarationList(SVariableDeclarationList node) =>
      visitNode(node);

  /// Visit a [SForEachStatement].
  T? visitForEachStatement(SForEachStatement node) => visitNode(node);

  /// Visit a [SDeclaredIdentifier].
  T? visitDeclaredIdentifier(SDeclaredIdentifier node) => visitNode(node);

  /// Visit a [SSwitchCase].
  T? visitSwitchCase(SSwitchCase node) => visitNode(node);

  /// Visit a [SSwitchDefault].
  T? visitSwitchDefault(SSwitchDefault node) => visitNode(node);

  /// Visit a [SCatchClause].
  T? visitCatchClause(SCatchClause node) => visitNode(node);

  /// Visit a [SArgumentList].
  T? visitArgumentList(SArgumentList node) => visitNode(node);

  /// Visit a [SAnnotation].
  T? visitAnnotation(SAnnotation node) => visitNode(node);

  /// Visit a [SComment].
  T? visitComment(SComment node) => visitNode(node);

  /// Visit a [SLabel].
  T? visitLabel(SLabel node) => visitNode(node);

  /// Visit a [SExtendsClause].
  T? visitExtendsClause(SExtendsClause node) => visitNode(node);

  /// Visit a [SImplementsClause].
  T? visitImplementsClause(SImplementsClause node) => visitNode(node);

  /// Visit a [SWithClause].
  T? visitWithClause(SWithClause node) => visitNode(node);

  /// Visit a [SOnClause].
  T? visitOnClause(SOnClause node) => visitNode(node);

  /// Visit a [SConstructorName].
  T? visitConstructorName(SConstructorName node) => visitNode(node);

  /// Visit a [SMapLiteralEntry].
  T? visitMapLiteralEntry(SMapLiteralEntry node) => visitNode(node);

  /// Visit a [SInterpolationExpression].
  T? visitInterpolationExpression(SInterpolationExpression node) =>
      visitNode(node);

  /// Visit a [SInterpolationString].
  T? visitInterpolationString(SInterpolationString node) => visitNode(node);

  /// Visit a [STypeArgumentList].
  T? visitTypeArgumentList(STypeArgumentList node) => visitNode(node);

  /// Visit a [STypeParameterList].
  T? visitTypeParameterList(STypeParameterList node) => visitNode(node);

  /// Visit a [STypeParameter].
  T? visitTypeParameter(STypeParameter node) => visitNode(node);

  /// Visit a [SFormalParameterList].
  T? visitFormalParameterList(SFormalParameterList node) => visitNode(node);

  /// Visit a [SSwitchExpressionCase].
  T? visitSwitchExpressionCase(SSwitchExpressionCase node) => visitNode(node);

  /// Visit a [SGuardedPattern].
  T? visitGuardedPattern(SGuardedPattern node) => visitNode(node);

  /// Visit a [SWhenClause].
  T? visitWhenClause(SWhenClause node) => visitNode(node);

  /// Visit a [SPatternFieldName].
  T? visitPatternFieldName(SPatternFieldName node) => visitNode(node);

  /// Visit a [SCaseClause].
  T? visitCaseClause(SCaseClause node) => visitNode(node);

  /// Visit a [SSwitchPatternCase].
  T? visitSwitchPatternCase(SSwitchPatternCase node) => visitNode(node);

  /// Visit a [SMapPatternEntry].
  T? visitMapPatternEntry(SMapPatternEntry node) => visitNode(node);

  /// Visit a [SPatternField].
  T? visitPatternField(SPatternField node) => visitNode(node);

  /// Visit a [SPatternVariableDeclaration].
  T? visitPatternVariableDeclaration(SPatternVariableDeclaration node) =>
      visitNode(node);

  /// Visit a [SParenthesizedPattern].
  T? visitParenthesizedPattern(SParenthesizedPattern node) => visitNode(node);

  /// Visit a [SRepresentationDeclaration].
  T? visitRepresentationDeclaration(SRepresentationDeclaration node) =>
      visitNode(node);
}

// ============================================================================
// GeneralizingSAstVisitor — category-level fallback hierarchy
// ============================================================================

/// A visitor that adds category-level fallback methods between specific visit
/// methods and [visitNode].
///
/// The delegation chain for a concrete node is:
///
///     visitSpecificNode → visitCategory → visitNode
///
/// For example, [visitBinaryExpression] delegates to [visitExpression], which
/// delegates to [visitNode]. Override a category method to handle all nodes of
/// that kind in one place.
///
/// The category hierarchy:
/// ```
/// visitNode
/// ├── visitExpression
/// │   └── visitLiteral
/// ├── visitStatement
/// ├── visitDeclaration
/// ├── visitDirective
/// ├── visitPattern
/// ├── visitTypeAnnotation
/// ├── visitFormalParameter
/// ├── visitFunctionBody
/// ├── visitForParts
/// ├── visitCombinator
/// └── visitConstructorInitializer
/// ```
class GeneralizingSAstVisitor<T> extends SAstVisitor<T> {
  // --------------------------------------------------------------------------
  // Category-level fallbacks
  // --------------------------------------------------------------------------

  /// Category fallback for all expression nodes.
  T? visitExpression(SAstNode node) => visitNode(node);

  /// Category fallback for all literal nodes (sub-category of expression).
  T? visitLiteral(SAstNode node) => visitExpression(node);

  /// Category fallback for all statement nodes.
  T? visitStatement(SAstNode node) => visitNode(node);

  /// Category fallback for all declaration nodes.
  T? visitDeclaration(SAstNode node) => visitNode(node);

  /// Category fallback for all directive nodes.
  T? visitDirective(SAstNode node) => visitNode(node);

  /// Category fallback for all pattern nodes.
  T? visitPattern(SAstNode node) => visitNode(node);

  /// Category fallback for all type annotation nodes.
  T? visitTypeAnnotation(SAstNode node) => visitNode(node);

  /// Category fallback for all formal parameter nodes.
  T? visitFormalParameter(SAstNode node) => visitNode(node);

  /// Category fallback for all function body nodes.
  T? visitFunctionBody(SAstNode node) => visitNode(node);

  /// Category fallback for all for-parts nodes.
  T? visitForParts(SAstNode node) => visitNode(node);

  /// Category fallback for all combinator nodes.
  T? visitCombinator(SAstNode node) => visitNode(node);

  /// Category fallback for all constructor initializer nodes.
  T? visitConstructorInitializer(SAstNode node) => visitNode(node);

  // --------------------------------------------------------------------------
  // Expressions → visitExpression
  // --------------------------------------------------------------------------

  @override
  T? visitSimpleIdentifier(SSimpleIdentifier node) => visitExpression(node);

  @override
  T? visitPrefixedIdentifier(SPrefixedIdentifier node) => visitExpression(node);

  @override
  T? visitBinaryExpression(SBinaryExpression node) => visitExpression(node);

  @override
  T? visitPrefixExpression(SPrefixExpression node) => visitExpression(node);

  @override
  T? visitPostfixExpression(SPostfixExpression node) => visitExpression(node);

  @override
  T? visitConditionalExpression(SConditionalExpression node) =>
      visitExpression(node);

  @override
  T? visitAssignmentExpression(SAssignmentExpression node) =>
      visitExpression(node);

  @override
  T? visitMethodInvocation(SMethodInvocation node) => visitExpression(node);

  @override
  T? visitFunctionExpressionInvocation(SFunctionExpressionInvocation node) =>
      visitExpression(node);

  @override
  T? visitIndexExpression(SIndexExpression node) => visitExpression(node);

  @override
  T? visitPropertyAccess(SPropertyAccess node) => visitExpression(node);

  @override
  T? visitParenthesizedExpression(SParenthesizedExpression node) =>
      visitExpression(node);

  @override
  T? visitFunctionExpression(SFunctionExpression node) => visitExpression(node);

  @override
  T? visitInstanceCreationExpression(SInstanceCreationExpression node) =>
      visitExpression(node);

  @override
  T? visitThisExpression(SThisExpression node) => visitExpression(node);

  @override
  T? visitSuperExpression(SSuperExpression node) => visitExpression(node);

  @override
  T? visitThrowExpression(SThrowExpression node) => visitExpression(node);

  @override
  T? visitAwaitExpression(SAwaitExpression node) => visitExpression(node);

  @override
  T? visitAsExpression(SAsExpression node) => visitExpression(node);

  @override
  T? visitIsExpression(SIsExpression node) => visitExpression(node);

  @override
  T? visitCascadeExpression(SCascadeExpression node) => visitExpression(node);

  @override
  T? visitRethrowExpression(SRethrowExpression node) => visitExpression(node);

  @override
  T? visitNamedExpression(SNamedExpression node) => visitExpression(node);

  @override
  T? visitSpreadElement(SSpreadElement node) => visitExpression(node);

  @override
  T? visitIfElement(SIfElement node) => visitExpression(node);

  @override
  T? visitForElement(SForElement node) => visitExpression(node);

  @override
  T? visitSwitchExpression(SSwitchExpression node) => visitExpression(node);

  @override
  T? visitFunctionReference(SFunctionReference node) => visitExpression(node);

  @override
  T? visitConstructorReference(SConstructorReference node) =>
      visitExpression(node);

  // --------------------------------------------------------------------------
  // Literals → visitLiteral → visitExpression
  // --------------------------------------------------------------------------

  @override
  T? visitIntegerLiteral(SIntegerLiteral node) => visitLiteral(node);

  @override
  T? visitDoubleLiteral(SDoubleLiteral node) => visitLiteral(node);

  @override
  T? visitBooleanLiteral(SBooleanLiteral node) => visitLiteral(node);

  @override
  T? visitSimpleStringLiteral(SSimpleStringLiteral node) => visitLiteral(node);

  @override
  T? visitStringInterpolation(SStringInterpolation node) => visitLiteral(node);

  @override
  T? visitAdjacentStrings(SAdjacentStrings node) => visitLiteral(node);

  @override
  T? visitNullLiteral(SNullLiteral node) => visitLiteral(node);

  @override
  T? visitListLiteral(SListLiteral node) => visitLiteral(node);

  @override
  T? visitSetOrMapLiteral(SSetOrMapLiteral node) => visitLiteral(node);

  @override
  T? visitSymbolLiteral(SSymbolLiteral node) => visitLiteral(node);

  @override
  T? visitRecordLiteral(SRecordLiteral node) => visitLiteral(node);

  // --------------------------------------------------------------------------
  // Statements → visitStatement
  // --------------------------------------------------------------------------

  @override
  T? visitBlock(SBlock node) => visitStatement(node);

  @override
  T? visitVariableDeclarationStatement(SVariableDeclarationStatement node) =>
      visitStatement(node);

  @override
  T? visitExpressionStatement(SExpressionStatement node) =>
      visitStatement(node);

  @override
  T? visitReturnStatement(SReturnStatement node) => visitStatement(node);

  @override
  T? visitIfStatement(SIfStatement node) => visitStatement(node);

  @override
  T? visitForStatement(SForStatement node) => visitStatement(node);

  @override
  T? visitWhileStatement(SWhileStatement node) => visitStatement(node);

  @override
  T? visitDoStatement(SDoStatement node) => visitStatement(node);

  @override
  T? visitSwitchStatement(SSwitchStatement node) => visitStatement(node);

  @override
  T? visitTryStatement(STryStatement node) => visitStatement(node);

  @override
  T? visitBreakStatement(SBreakStatement node) => visitStatement(node);

  @override
  T? visitContinueStatement(SContinueStatement node) => visitStatement(node);

  @override
  T? visitAssertStatement(SAssertStatement node) => visitStatement(node);

  @override
  T? visitYieldStatement(SYieldStatement node) => visitStatement(node);

  @override
  T? visitLabeledStatement(SLabeledStatement node) => visitStatement(node);

  @override
  T? visitEmptyStatement(SEmptyStatement node) => visitStatement(node);

  @override
  T? visitPatternVariableDeclarationStatement(
    SPatternVariableDeclarationStatement node,
  ) => visitStatement(node);

  // --------------------------------------------------------------------------
  // Declarations → visitDeclaration
  // --------------------------------------------------------------------------

  @override
  T? visitFunctionDeclaration(SFunctionDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitMethodDeclaration(SMethodDeclaration node) => visitDeclaration(node);

  @override
  T? visitClassDeclaration(SClassDeclaration node) => visitDeclaration(node);

  @override
  T? visitMixinDeclaration(SMixinDeclaration node) => visitDeclaration(node);

  @override
  T? visitEnumDeclaration(SEnumDeclaration node) => visitDeclaration(node);

  @override
  T? visitExtensionDeclaration(SExtensionDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitVariableDeclaration(SVariableDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitFieldDeclaration(SFieldDeclaration node) => visitDeclaration(node);

  @override
  T? visitConstructorDeclaration(SConstructorDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitTopLevelVariableDeclaration(STopLevelVariableDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitTypedefDeclaration(STypedefDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitEnumConstantDeclaration(SEnumConstantDeclaration node) =>
      visitDeclaration(node);

  @override
  T? visitExtensionTypeDeclaration(SExtensionTypeDeclaration node) =>
      visitDeclaration(node);

  // --------------------------------------------------------------------------
  // Directives → visitDirective
  // --------------------------------------------------------------------------

  @override
  T? visitImportDirective(SImportDirective node) => visitDirective(node);

  @override
  T? visitExportDirective(SExportDirective node) => visitDirective(node);

  @override
  T? visitPartDirective(SPartDirective node) => visitDirective(node);

  @override
  T? visitPartOfDirective(SPartOfDirective node) => visitDirective(node);

  @override
  T? visitLibraryDirective(SLibraryDirective node) => visitDirective(node);

  // --------------------------------------------------------------------------
  // Type annotations → visitTypeAnnotation
  // --------------------------------------------------------------------------

  @override
  T? visitNamedType(SNamedType node) => visitTypeAnnotation(node);

  @override
  T? visitGenericFunctionType(SGenericFunctionType node) =>
      visitTypeAnnotation(node);

  @override
  T? visitRecordTypeAnnotation(SRecordTypeAnnotation node) =>
      visitTypeAnnotation(node);

  // --------------------------------------------------------------------------
  // Formal parameters → visitFormalParameter
  // --------------------------------------------------------------------------

  @override
  T? visitSimpleFormalParameter(SSimpleFormalParameter node) =>
      visitFormalParameter(node);

  @override
  T? visitDefaultFormalParameter(SDefaultFormalParameter node) =>
      visitFormalParameter(node);

  @override
  T? visitFieldFormalParameter(SFieldFormalParameter node) =>
      visitFormalParameter(node);

  @override
  T? visitFunctionTypedFormalParameter(SFunctionTypedFormalParameter node) =>
      visitFormalParameter(node);

  @override
  T? visitSuperFormalParameter(SSuperFormalParameter node) =>
      visitFormalParameter(node);

  // --------------------------------------------------------------------------
  // Function bodies → visitFunctionBody
  // --------------------------------------------------------------------------

  @override
  T? visitBlockFunctionBody(SBlockFunctionBody node) => visitFunctionBody(node);

  @override
  T? visitExpressionFunctionBody(SExpressionFunctionBody node) =>
      visitFunctionBody(node);

  @override
  T? visitEmptyFunctionBody(SEmptyFunctionBody node) => visitFunctionBody(node);

  @override
  T? visitNativeFunctionBody(SNativeFunctionBody node) =>
      visitFunctionBody(node);

  // --------------------------------------------------------------------------
  // For parts → visitForParts
  // --------------------------------------------------------------------------

  @override
  T? visitForPartsWithDeclarations(SForPartsWithDeclarations node) =>
      visitForParts(node);

  @override
  T? visitForPartsWithExpression(SForPartsWithExpression node) =>
      visitForParts(node);

  @override
  T? visitForEachPartsWithDeclaration(SForEachPartsWithDeclaration node) =>
      visitForParts(node);

  @override
  T? visitForEachPartsWithIdentifier(SForEachPartsWithIdentifier node) =>
      visitForParts(node);

  // --------------------------------------------------------------------------
  // Combinators → visitCombinator
  // --------------------------------------------------------------------------

  @override
  T? visitShowCombinator(SShowCombinator node) => visitCombinator(node);

  @override
  T? visitHideCombinator(SHideCombinator node) => visitCombinator(node);

  // --------------------------------------------------------------------------
  // Constructor initializers → visitConstructorInitializer
  // --------------------------------------------------------------------------

  @override
  T? visitSuperConstructorInvocation(SSuperConstructorInvocation node) =>
      visitConstructorInitializer(node);

  @override
  T? visitRedirectingConstructorInvocation(
    SRedirectingConstructorInvocation node,
  ) => visitConstructorInitializer(node);

  @override
  T? visitConstructorFieldInitializer(SConstructorFieldInitializer node) =>
      visitConstructorInitializer(node);

  @override
  T? visitAssertInitializer(SAssertInitializer node) =>
      visitConstructorInitializer(node);

  // --------------------------------------------------------------------------
  // Patterns → visitPattern
  // --------------------------------------------------------------------------

  @override
  T? visitConstantPattern(SConstantPattern node) => visitPattern(node);

  @override
  T? visitWildcardPattern(SWildcardPattern node) => visitPattern(node);

  @override
  T? visitDeclaredVariablePattern(SDeclaredVariablePattern node) =>
      visitPattern(node);

  @override
  T? visitAssignedVariablePattern(SAssignedVariablePattern node) =>
      visitPattern(node);

  @override
  T? visitObjectPattern(SObjectPattern node) => visitPattern(node);

  @override
  T? visitListPattern(SListPattern node) => visitPattern(node);

  @override
  T? visitMapPattern(SMapPattern node) => visitPattern(node);

  @override
  T? visitRecordPattern(SRecordPattern node) => visitPattern(node);

  @override
  T? visitLogicalOrPattern(SLogicalOrPattern node) => visitPattern(node);

  @override
  T? visitLogicalAndPattern(SLogicalAndPattern node) => visitPattern(node);

  @override
  T? visitCastPattern(SCastPattern node) => visitPattern(node);

  @override
  T? visitRelationalPattern(SRelationalPattern node) => visitPattern(node);

  @override
  T? visitNullCheckPattern(SNullCheckPattern node) => visitPattern(node);

  @override
  T? visitNullAssertPattern(SNullAssertPattern node) => visitPattern(node);

  @override
  T? visitRestPatternElement(SRestPatternElement node) => visitPattern(node);

  @override
  T? visitPatternAssignment(SPatternAssignment node) => visitPattern(node);

  @override
  T? visitParenthesizedPattern(SParenthesizedPattern node) =>
      visitPattern(node);

  // --------------------------------------------------------------------------
  // Misc (no category — delegate to visitNode)
  // --------------------------------------------------------------------------

  @override
  T? visitSwitchPatternCase(SSwitchPatternCase node) => visitNode(node);

  @override
  T? visitMapPatternEntry(SMapPatternEntry node) => visitNode(node);

  @override
  T? visitPatternField(SPatternField node) => visitNode(node);

  @override
  T? visitPatternVariableDeclaration(SPatternVariableDeclaration node) =>
      visitNode(node);

  @override
  T? visitRepresentationDeclaration(SRepresentationDeclaration node) =>
      visitNode(node);
}
