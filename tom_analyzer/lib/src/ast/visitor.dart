/// Visitor pattern for the serializable AST.
///
/// This mirrors the structure of `package:analyzer/dart/ast/visitor.dart`
/// so that existing interpreter code can be adapted with minimal changes.
library;

import 'nodes/node.dart';

/// An object that can be used to visit an AST structure.
///
/// Mirrors [analyzer.dart.ast.visitor.AstVisitor].
abstract class SAstVisitor<R> {
  // Compilation unit
  R? visitCompilationUnit(SCompilationUnit node);

  // Declarations
  R? visitClassDeclaration(SClassDeclaration node);
  R? visitMixinDeclaration(SMixinDeclaration node);
  R? visitEnumDeclaration(SEnumDeclaration node);
  R? visitExtensionDeclaration(SExtensionDeclaration node);
  R? visitFunctionDeclaration(SFunctionDeclaration node);
  R? visitTopLevelVariableDeclaration(STopLevelVariableDeclaration node);
  R? visitFieldDeclaration(SFieldDeclaration node);
  R? visitMethodDeclaration(SMethodDeclaration node);
  R? visitConstructorDeclaration(SConstructorDeclaration node);

  // Statements
  R? visitBlock(SBlock node);
  R? visitExpressionStatement(SExpressionStatement node);
  R? visitVariableDeclarationStatement(SVariableDeclarationStatement node);
  R? visitReturnStatement(SReturnStatement node);
  R? visitIfStatement(SIfStatement node);
  R? visitForStatement(SForStatement node);
  R? visitWhileStatement(SWhileStatement node);
  R? visitDoStatement(SDoStatement node);
  R? visitBreakStatement(SBreakStatement node);
  R? visitContinueStatement(SContinueStatement node);
  R? visitTryStatement(STryStatement node);
  R? visitSwitchStatement(SSwitchStatement node);
  R? visitAssertStatement(SAssertStatement node);
  R? visitEmptyStatement(SEmptyStatement node);
  R? visitYieldStatement(SYieldStatement node);
  R? visitLabeledStatement(SLabeledStatement node);
  R? visitPatternVariableDeclarationStatement(
      SPatternVariableDeclarationStatement node);

  // Expressions
  R? visitSimpleIdentifier(SSimpleIdentifier node);
  R? visitPrefixedIdentifier(SPrefixedIdentifier node);
  R? visitIntegerLiteral(SIntegerLiteral node);
  R? visitDoubleLiteral(SDoubleLiteral node);
  R? visitBooleanLiteral(SBooleanLiteral node);
  R? visitStringLiteral(SStringLiteral node);
  R? visitNullLiteral(SNullLiteral node);
  R? visitSymbolLiteral(SSymbolLiteral node);
  R? visitStringInterpolation(SStringInterpolation node);
  R? visitBinaryExpression(SBinaryExpression node);
  R? visitPrefixExpression(SPrefixExpression node);
  R? visitPostfixExpression(SPostfixExpression node);
  R? visitAssignmentExpression(SAssignmentExpression node);
  R? visitConditionalExpression(SConditionalExpression node);
  R? visitParenthesizedExpression(SParenthesizedExpression node);
  R? visitIndexExpression(SIndexExpression node);
  R? visitPropertyAccess(SPropertyAccess node);
  R? visitMethodInvocation(SMethodInvocation node);
  R? visitFunctionExpressionInvocation(SFunctionExpressionInvocation node);
  R? visitInstanceCreationExpression(SInstanceCreationExpression node);
  R? visitListLiteral(SListLiteral node);
  R? visitSetOrMapLiteral(SSetOrMapLiteral node);
  R? visitRecordLiteral(SRecordLiteral node);
  R? visitCascadeExpression(SCascadeExpression node);
  R? visitThrowExpression(SThrowExpression node);
  R? visitRethrowExpression(SRethrowExpression node);
  R? visitAsExpression(SAsExpression node);
  R? visitIsExpression(SIsExpression node);
  R? visitAwaitExpression(SAwaitExpression node);
  R? visitThisExpression(SThisExpression node);
  R? visitSuperExpression(SSuperExpression node);
  R? visitFunctionExpression(SFunctionExpression node);
  R? visitSwitchExpression(SSwitchExpression node);
  R? visitConstructorReference(SConstructorReference node);
  R? visitFunctionReference(SFunctionReference node);
  R? visitPatternAssignment(SPatternAssignment node);

  // Directives
  R? visitImportDirective(SImportDirective node);
  R? visitExportDirective(SExportDirective node);
  R? visitPartDirective(SPartDirective node);
  R? visitPartOfDirective(SPartOfDirective node);
  R? visitLibraryDirective(SLibraryDirective node);

  // Other nodes
  R? visitComment(SComment node);
  R? visitAnnotation(SAnnotation node);
  R? visitVariableDeclarationList(SVariableDeclarationList node);
  R? visitVariableDeclaration(SVariableDeclaration node);
  R? visitFormalParameterList(SFormalParameterList node);
  R? visitSimpleFormalParameter(SSimpleFormalParameter node);
  R? visitDefaultFormalParameter(SDefaultFormalParameter node);
  R? visitFieldFormalParameter(SFieldFormalParameter node);
  R? visitFunctionTypedFormalParameter(SFunctionTypedFormalParameter node);
  R? visitSuperFormalParameter(SSuperFormalParameter node);
  R? visitTypeParameterList(STypeParameterList node);
  R? visitTypeParameter(STypeParameter node);
  R? visitTypeArgumentList(STypeArgumentList node);
  R? visitArgumentList(SArgumentList node);
  R? visitNamedExpression(SNamedExpression node);
  R? visitBlockFunctionBody(SBlockFunctionBody node);
  R? visitExpressionFunctionBody(SExpressionFunctionBody node);
  R? visitEmptyFunctionBody(SEmptyFunctionBody node);
  R? visitNamedType(SNamedType node);
  R? visitGenericFunctionType(SGenericFunctionType node);
  R? visitRecordTypeAnnotation(SRecordTypeAnnotation node);
  R? visitCatchClause(SCatchClause node);
  R? visitSuperConstructorInvocation(SSuperConstructorInvocation node);
  R? visitRedirectingConstructorInvocation(
      SRedirectingConstructorInvocation node);
  R? visitConstructorFieldInitializer(SConstructorFieldInitializer node);
  R? visitExtendsClause(SExtendsClause node);
  R? visitImplementsClause(SImplementsClause node);
  R? visitWithClause(SWithClause node);
  R? visitOnClause(SOnClause node);
  R? visitEnumConstantDeclaration(SEnumConstantDeclaration node);
  R? visitShowCombinator(SShowCombinator node);
  R? visitHideCombinator(SHideCombinator node);
  R? visitInterpolationString(SInterpolationString node);
  R? visitInterpolationExpression(SInterpolationExpression node);
  R? visitLabel(SLabel node);
  R? visitSwitchCase(SSwitchCase node);
  R? visitSwitchDefault(SSwitchDefault node);
  R? visitSwitchExpressionCase(SSwitchExpressionCase node);
  R? visitMapLiteralEntry(SMapLiteralEntry node);
  R? visitSpreadElement(SSpreadElement node);
  R? visitIfElement(SIfElement node);
  R? visitForElement(SForElement node);
  R? visitConstructorName(SConstructorName node);

  // Patterns
  R? visitDeclaredVariablePattern(SDeclaredVariablePattern node);
  R? visitListPattern(SListPattern node);
  R? visitMapPattern(SMapPattern node);
  R? visitRecordPattern(SRecordPattern node);
  R? visitObjectPattern(SObjectPattern node);
  R? visitWildcardPattern(SWildcardPattern node);
  R? visitConstantPattern(SConstantPattern node);
  R? visitCastPattern(SCastPattern node);
  R? visitNullCheckPattern(SNullCheckPattern node);
  R? visitNullAssertPattern(SNullAssertPattern node);
  R? visitLogicalAndPattern(SLogicalAndPattern node);
  R? visitLogicalOrPattern(SLogicalOrPattern node);
  R? visitParenthesizedPattern(SParenthesizedPattern node);
  R? visitRelationalPattern(SRelationalPattern node);
  R? visitPatternField(SPatternField node);
  R? visitPatternVariableDeclaration(SPatternVariableDeclaration node);
  R? visitGuardedPattern(SGuardedPattern node);
  R? visitSwitchPatternCase(SSwitchPatternCase node);
}

/// A visitor that does nothing for all nodes.
///
/// Useful as a base class when you only need to handle some node types.
class SimpleAstVisitor<R> implements SAstVisitor<R> {
  @override
  R? visitCompilationUnit(SCompilationUnit node) => null;

  @override
  R? visitClassDeclaration(SClassDeclaration node) => null;
  @override
  R? visitMixinDeclaration(SMixinDeclaration node) => null;
  @override
  R? visitEnumDeclaration(SEnumDeclaration node) => null;
  @override
  R? visitExtensionDeclaration(SExtensionDeclaration node) => null;
  @override
  R? visitFunctionDeclaration(SFunctionDeclaration node) => null;
  @override
  R? visitTopLevelVariableDeclaration(STopLevelVariableDeclaration node) =>
      null;
  @override
  R? visitFieldDeclaration(SFieldDeclaration node) => null;
  @override
  R? visitMethodDeclaration(SMethodDeclaration node) => null;
  @override
  R? visitConstructorDeclaration(SConstructorDeclaration node) => null;

  @override
  R? visitBlock(SBlock node) => null;
  @override
  R? visitExpressionStatement(SExpressionStatement node) => null;
  @override
  R? visitVariableDeclarationStatement(SVariableDeclarationStatement node) =>
      null;
  @override
  R? visitReturnStatement(SReturnStatement node) => null;
  @override
  R? visitIfStatement(SIfStatement node) => null;
  @override
  R? visitForStatement(SForStatement node) => null;
  @override
  R? visitWhileStatement(SWhileStatement node) => null;
  @override
  R? visitDoStatement(SDoStatement node) => null;
  @override
  R? visitBreakStatement(SBreakStatement node) => null;
  @override
  R? visitContinueStatement(SContinueStatement node) => null;
  @override
  R? visitTryStatement(STryStatement node) => null;
  @override
  R? visitSwitchStatement(SSwitchStatement node) => null;
  @override
  R? visitAssertStatement(SAssertStatement node) => null;
  @override
  R? visitEmptyStatement(SEmptyStatement node) => null;
  @override
  R? visitYieldStatement(SYieldStatement node) => null;
  @override
  R? visitLabeledStatement(SLabeledStatement node) => null;
  @override
  R? visitPatternVariableDeclarationStatement(
          SPatternVariableDeclarationStatement node) =>
      null;

  @override
  R? visitSimpleIdentifier(SSimpleIdentifier node) => null;
  @override
  R? visitPrefixedIdentifier(SPrefixedIdentifier node) => null;
  @override
  R? visitIntegerLiteral(SIntegerLiteral node) => null;
  @override
  R? visitDoubleLiteral(SDoubleLiteral node) => null;
  @override
  R? visitBooleanLiteral(SBooleanLiteral node) => null;
  @override
  R? visitStringLiteral(SStringLiteral node) => null;
  @override
  R? visitNullLiteral(SNullLiteral node) => null;
  @override
  R? visitSymbolLiteral(SSymbolLiteral node) => null;
  @override
  R? visitStringInterpolation(SStringInterpolation node) => null;
  @override
  R? visitBinaryExpression(SBinaryExpression node) => null;
  @override
  R? visitPrefixExpression(SPrefixExpression node) => null;
  @override
  R? visitPostfixExpression(SPostfixExpression node) => null;
  @override
  R? visitAssignmentExpression(SAssignmentExpression node) => null;
  @override
  R? visitConditionalExpression(SConditionalExpression node) => null;
  @override
  R? visitParenthesizedExpression(SParenthesizedExpression node) => null;
  @override
  R? visitIndexExpression(SIndexExpression node) => null;
  @override
  R? visitPropertyAccess(SPropertyAccess node) => null;
  @override
  R? visitMethodInvocation(SMethodInvocation node) => null;
  @override
  R? visitFunctionExpressionInvocation(SFunctionExpressionInvocation node) =>
      null;
  @override
  R? visitInstanceCreationExpression(SInstanceCreationExpression node) => null;
  @override
  R? visitListLiteral(SListLiteral node) => null;
  @override
  R? visitSetOrMapLiteral(SSetOrMapLiteral node) => null;
  @override
  R? visitRecordLiteral(SRecordLiteral node) => null;
  @override
  R? visitCascadeExpression(SCascadeExpression node) => null;
  @override
  R? visitThrowExpression(SThrowExpression node) => null;
  @override
  R? visitRethrowExpression(SRethrowExpression node) => null;
  @override
  R? visitAsExpression(SAsExpression node) => null;
  @override
  R? visitIsExpression(SIsExpression node) => null;
  @override
  R? visitAwaitExpression(SAwaitExpression node) => null;
  @override
  R? visitThisExpression(SThisExpression node) => null;
  @override
  R? visitSuperExpression(SSuperExpression node) => null;
  @override
  R? visitFunctionExpression(SFunctionExpression node) => null;
  @override
  R? visitSwitchExpression(SSwitchExpression node) => null;
  @override
  R? visitConstructorReference(SConstructorReference node) => null;
  @override
  R? visitFunctionReference(SFunctionReference node) => null;
  @override
  R? visitPatternAssignment(SPatternAssignment node) => null;

  @override
  R? visitImportDirective(SImportDirective node) => null;
  @override
  R? visitExportDirective(SExportDirective node) => null;
  @override
  R? visitPartDirective(SPartDirective node) => null;
  @override
  R? visitPartOfDirective(SPartOfDirective node) => null;
  @override
  R? visitLibraryDirective(SLibraryDirective node) => null;

  @override
  R? visitComment(SComment node) => null;
  @override
  R? visitAnnotation(SAnnotation node) => null;
  @override
  R? visitVariableDeclarationList(SVariableDeclarationList node) => null;
  @override
  R? visitVariableDeclaration(SVariableDeclaration node) => null;
  @override
  R? visitFormalParameterList(SFormalParameterList node) => null;
  @override
  R? visitSimpleFormalParameter(SSimpleFormalParameter node) => null;
  @override
  R? visitDefaultFormalParameter(SDefaultFormalParameter node) => null;
  @override
  R? visitFieldFormalParameter(SFieldFormalParameter node) => null;
  @override
  R? visitFunctionTypedFormalParameter(SFunctionTypedFormalParameter node) =>
      null;
  @override
  R? visitSuperFormalParameter(SSuperFormalParameter node) => null;
  @override
  R? visitTypeParameterList(STypeParameterList node) => null;
  @override
  R? visitTypeParameter(STypeParameter node) => null;
  @override
  R? visitTypeArgumentList(STypeArgumentList node) => null;
  @override
  R? visitArgumentList(SArgumentList node) => null;
  @override
  R? visitNamedExpression(SNamedExpression node) => null;
  @override
  R? visitBlockFunctionBody(SBlockFunctionBody node) => null;
  @override
  R? visitExpressionFunctionBody(SExpressionFunctionBody node) => null;
  @override
  R? visitEmptyFunctionBody(SEmptyFunctionBody node) => null;
  @override
  R? visitNamedType(SNamedType node) => null;
  @override
  R? visitGenericFunctionType(SGenericFunctionType node) => null;
  @override
  R? visitRecordTypeAnnotation(SRecordTypeAnnotation node) => null;
  @override
  R? visitCatchClause(SCatchClause node) => null;
  @override
  R? visitSuperConstructorInvocation(SSuperConstructorInvocation node) => null;
  @override
  R? visitRedirectingConstructorInvocation(
          SRedirectingConstructorInvocation node) =>
      null;
  @override
  R? visitConstructorFieldInitializer(SConstructorFieldInitializer node) =>
      null;
  @override
  R? visitExtendsClause(SExtendsClause node) => null;
  @override
  R? visitImplementsClause(SImplementsClause node) => null;
  @override
  R? visitWithClause(SWithClause node) => null;
  @override
  R? visitOnClause(SOnClause node) => null;
  @override
  R? visitEnumConstantDeclaration(SEnumConstantDeclaration node) => null;
  @override
  R? visitShowCombinator(SShowCombinator node) => null;
  @override
  R? visitHideCombinator(SHideCombinator node) => null;
  @override
  R? visitInterpolationString(SInterpolationString node) => null;
  @override
  R? visitInterpolationExpression(SInterpolationExpression node) => null;
  @override
  R? visitLabel(SLabel node) => null;
  @override
  R? visitSwitchCase(SSwitchCase node) => null;
  @override
  R? visitSwitchDefault(SSwitchDefault node) => null;
  @override
  R? visitSwitchExpressionCase(SSwitchExpressionCase node) => null;
  @override
  R? visitMapLiteralEntry(SMapLiteralEntry node) => null;
  @override
  R? visitSpreadElement(SSpreadElement node) => null;
  @override
  R? visitIfElement(SIfElement node) => null;
  @override
  R? visitForElement(SForElement node) => null;
  @override
  R? visitConstructorName(SConstructorName node) => null;

  @override
  R? visitDeclaredVariablePattern(SDeclaredVariablePattern node) => null;
  @override
  R? visitListPattern(SListPattern node) => null;
  @override
  R? visitMapPattern(SMapPattern node) => null;
  @override
  R? visitRecordPattern(SRecordPattern node) => null;
  @override
  R? visitObjectPattern(SObjectPattern node) => null;
  @override
  R? visitWildcardPattern(SWildcardPattern node) => null;
  @override
  R? visitConstantPattern(SConstantPattern node) => null;
  @override
  R? visitCastPattern(SCastPattern node) => null;
  @override
  R? visitNullCheckPattern(SNullCheckPattern node) => null;
  @override
  R? visitNullAssertPattern(SNullAssertPattern node) => null;
  @override
  R? visitLogicalAndPattern(SLogicalAndPattern node) => null;
  @override
  R? visitLogicalOrPattern(SLogicalOrPattern node) => null;
  @override
  R? visitParenthesizedPattern(SParenthesizedPattern node) => null;
  @override
  R? visitRelationalPattern(SRelationalPattern node) => null;
  @override
  R? visitPatternField(SPatternField node) => null;
  @override
  R? visitPatternVariableDeclaration(SPatternVariableDeclaration node) => null;
  @override
  R? visitGuardedPattern(SGuardedPattern node) => null;
  @override
  R? visitSwitchPatternCase(SSwitchPatternCase node) => null;
}

/// A visitor that recursively visits all children of each node.
///
/// Override the visit methods you need to customize behavior.
class RecursiveAstVisitor<R> extends SimpleAstVisitor<R> {
  @override
  R? visitCompilationUnit(SCompilationUnit node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitClassDeclaration(SClassDeclaration node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitMixinDeclaration(SMixinDeclaration node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitEnumDeclaration(SEnumDeclaration node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitExtensionDeclaration(SExtensionDeclaration node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitFunctionDeclaration(SFunctionDeclaration node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitBlock(SBlock node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitIfStatement(SIfStatement node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitForStatement(SForStatement node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitWhileStatement(SWhileStatement node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitTryStatement(STryStatement node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitSwitchStatement(SSwitchStatement node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitMethodInvocation(SMethodInvocation node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitBinaryExpression(SBinaryExpression node) {
    node.visitChildren(this);
    return null;
  }

  @override
  R? visitCascadeExpression(SCascadeExpression node) {
    node.visitChildren(this);
    return null;
  }

  // Add more recursive implementations as needed...
}

// Forward declarations for types referenced in visitor
// These are placeholders that will be properly defined in their respective files

class SCompilationUnit extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => null;
  @override
  String get nodeType => 'CompilationUnit';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitCompilationUnit(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

// Directive placeholders
class SImportDirective extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ImportDirective';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitImportDirective(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SExportDirective extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ExportDirective';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitExportDirective(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SPartDirective extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PartDirective';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitPartDirective(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SPartOfDirective extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PartOfDirective';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitPartOfDirective(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SLibraryDirective extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'LibraryDirective';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitLibraryDirective(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

// Other node placeholders
class SVariableDeclarationList extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'VariableDeclarationList';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitVariableDeclarationList(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SVariableDeclaration extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'VariableDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitVariableDeclaration(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SFormalParameterList extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FormalParameterList';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitFormalParameterList(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSimpleFormalParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SimpleFormalParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitSimpleFormalParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SDefaultFormalParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'DefaultFormalParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitDefaultFormalParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SFieldFormalParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FieldFormalParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitFieldFormalParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SFunctionTypedFormalParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'FunctionTypedFormalParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitFunctionTypedFormalParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSuperFormalParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SuperFormalParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitSuperFormalParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class STypeParameterList extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'TypeParameterList';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitTypeParameterList(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class STypeParameter extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'TypeParameter';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitTypeParameter(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SNamedExpression extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'NamedExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitNamedExpression(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SBlockFunctionBody extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'BlockFunctionBody';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitBlockFunctionBody(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SExpressionFunctionBody extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ExpressionFunctionBody';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitExpressionFunctionBody(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SEmptyFunctionBody extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'EmptyFunctionBody';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitEmptyFunctionBody(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SNamedType extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'NamedType';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitNamedType(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SGenericFunctionType extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'GenericFunctionType';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitGenericFunctionType(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SRecordTypeAnnotation extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RecordTypeAnnotation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitRecordTypeAnnotation(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SCatchClause extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'CatchClause';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitCatchClause(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSuperConstructorInvocation extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SuperConstructorInvocation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitSuperConstructorInvocation(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SRedirectingConstructorInvocation extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RedirectingConstructorInvocation';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitRedirectingConstructorInvocation(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SConstructorFieldInitializer extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConstructorFieldInitializer';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitConstructorFieldInitializer(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SExtendsClause extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ExtendsClause';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitExtendsClause(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SImplementsClause extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ImplementsClause';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitImplementsClause(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SWithClause extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'WithClause';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitWithClause(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SOnClause extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'OnClause';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitOnClause(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SEnumConstantDeclaration extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'EnumConstantDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitEnumConstantDeclaration(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SShowCombinator extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ShowCombinator';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitShowCombinator(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SHideCombinator extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'HideCombinator';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitHideCombinator(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SInterpolationString extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'InterpolationString';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitInterpolationString(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SInterpolationExpression extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'InterpolationExpression';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitInterpolationExpression(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SLabel extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'Label';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitLabel(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSwitchCase extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchCase';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitSwitchCase(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSwitchDefault extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchDefault';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitSwitchDefault(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSwitchExpressionCase extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchExpressionCase';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitSwitchExpressionCase(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SMapLiteralEntry extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'MapLiteralEntry';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitMapLiteralEntry(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSpreadElement extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SpreadElement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitSpreadElement(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SIfElement extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'IfElement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitIfElement(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SForElement extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ForElement';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitForElement(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SConstructorName extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConstructorName';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitConstructorName(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

// Pattern placeholders
class SDeclaredVariablePattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'DeclaredVariablePattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitDeclaredVariablePattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SListPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ListPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitListPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SMapPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'MapPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitMapPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SRecordPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RecordPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitRecordPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SObjectPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ObjectPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitObjectPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SWildcardPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'WildcardPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitWildcardPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SConstantPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ConstantPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitConstantPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SCastPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'CastPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitCastPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SNullCheckPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'NullCheckPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitNullCheckPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SNullAssertPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'NullAssertPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitNullAssertPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SLogicalAndPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'LogicalAndPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitLogicalAndPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SLogicalOrPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'LogicalOrPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitLogicalOrPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SParenthesizedPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'ParenthesizedPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitParenthesizedPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SRelationalPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'RelationalPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitRelationalPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SPatternField extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PatternField';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitPatternField(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SPatternVariableDeclaration extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'PatternVariableDeclaration';
  @override
  R? accept<R>(SAstVisitor<R> visitor) =>
      visitor.visitPatternVariableDeclaration(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SGuardedPattern extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'GuardedPattern';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitGuardedPattern(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class SSwitchPatternCase extends SAstNode {
  @override
  int get offset => throw UnimplementedError();
  @override
  int get length => throw UnimplementedError();
  @override
  SAstNode? get parent => throw UnimplementedError();
  @override
  String get nodeType => 'SwitchPatternCase';
  @override
  R? accept<R>(SAstVisitor<R> visitor) => visitor.visitSwitchPatternCase(this);
  @override
  void visitChildren(SAstVisitor visitor) {}
  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();
}
