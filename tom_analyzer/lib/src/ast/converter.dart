/// Converts analyzer AST to serializable AST.
///
/// This converter transforms nodes from `package:analyzer/dart/ast/ast.dart`
/// to their serializable equivalents in `package:tom_d4rt_ast`.
library;

import 'package:analyzer/dart/ast/ast.dart' as a;
import 'package:analyzer/dart/ast/token.dart' as t;
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';

/// Converts analyzer AST nodes to serializable AST nodes.
///
/// Usage:
/// ```dart
/// import 'package:analyzer/dart/analysis/utilities.dart';
/// import 'package:tom_analyzer/ast.dart';
///
/// final parseResult = parseString(content: sourceCode);
/// final converter = AstConverter();
/// final serializableAst = converter.convertCompilationUnit(parseResult.unit);
/// final json = serializableAst.toJson();
/// ```
class AstConverter {
  const AstConverter();

  /// Converts a compilation unit.
  SCompilationUnit convertCompilationUnit(a.CompilationUnit node) {
    return SCompilationUnit(
      scriptTag: node.scriptTag != null
          ? SScriptTag(token: _convertToken(node.scriptTag!.scriptTag))
          : null,
      directives: node.directives.map(_convertDirective).toList(),
      declarations: node.declarations.map(_convertDeclaration).toList(),
      endToken: _convertToken(node.endToken),
    );
  }

  // ===== Tokens =====

  SToken _convertToken(t.Token token) {
    return SToken(
      offset: token.offset,
      lexeme: token.lexeme,
      type: _convertTokenType(token.type),
    );
  }

  SToken? _convertTokenOrNull(t.Token? token) {
    if (token == null) return null;
    return _convertToken(token);
  }

  STokenType _convertTokenType(t.TokenType type) {
    // Map analyzer token types to our STokenType enum
    return switch (type) {
      t.TokenType.AMPERSAND => STokenType.ampersand,
      t.TokenType.AMPERSAND_AMPERSAND => STokenType.ampersandAmpersand,
      t.TokenType.AMPERSAND_AMPERSAND_EQ => STokenType.ampersandAmpersandEq,
      t.TokenType.AMPERSAND_EQ => STokenType.ampersandEq,
      t.TokenType.AT => STokenType.at,
      t.TokenType.BANG => STokenType.bang,
      t.TokenType.BANG_EQ => STokenType.bangEq,
      t.TokenType.BAR => STokenType.bar,
      t.TokenType.BAR_BAR => STokenType.barBar,
      t.TokenType.BAR_BAR_EQ => STokenType.barBarEq,
      t.TokenType.BAR_EQ => STokenType.barEq,
      t.TokenType.CARET => STokenType.caret,
      t.TokenType.CARET_EQ => STokenType.caretEq,
      t.TokenType.CLOSE_CURLY_BRACKET => STokenType.closeBrace,
      t.TokenType.CLOSE_PAREN => STokenType.closeParen,
      t.TokenType.CLOSE_SQUARE_BRACKET => STokenType.closeBracket,
      t.TokenType.COLON => STokenType.colon,
      t.TokenType.COMMA => STokenType.comma,
      t.TokenType.DOUBLE => STokenType.doubleLiteral,
      t.TokenType.EQ => STokenType.eq,
      t.TokenType.EQ_EQ => STokenType.eqEq,
      t.TokenType.FUNCTION => STokenType.function,
      t.TokenType.GT => STokenType.gt,
      t.TokenType.GT_EQ => STokenType.gtEq,
      t.TokenType.GT_GT => STokenType.gtGt,
      t.TokenType.GT_GT_EQ => STokenType.gtGtEq,
      t.TokenType.GT_GT_GT => STokenType.gtGtGt,
      t.TokenType.GT_GT_GT_EQ => STokenType.gtGtGtEq,
      t.TokenType.HASH => STokenType.hash,
      t.TokenType.HEXADECIMAL => STokenType.hexLiteral,
      t.TokenType.IDENTIFIER => STokenType.identifier,
      t.TokenType.INDEX => STokenType.indexToken,
      t.TokenType.INDEX_EQ => STokenType.indexEq,
      t.TokenType.INT => STokenType.integerLiteral,
      t.TokenType.LT => STokenType.lt,
      t.TokenType.LT_EQ => STokenType.ltEq,
      t.TokenType.LT_LT => STokenType.ltLt,
      t.TokenType.LT_LT_EQ => STokenType.ltLtEq,
      t.TokenType.MINUS => STokenType.minus,
      t.TokenType.MINUS_EQ => STokenType.minusEq,
      t.TokenType.MINUS_MINUS => STokenType.minusMinus,
      t.TokenType.OPEN_CURLY_BRACKET => STokenType.openBrace,
      t.TokenType.OPEN_PAREN => STokenType.openParen,
      t.TokenType.OPEN_SQUARE_BRACKET => STokenType.openBracket,
      t.TokenType.PERCENT => STokenType.percent,
      t.TokenType.PERCENT_EQ => STokenType.percentEq,
      t.TokenType.PERIOD => STokenType.period,
      t.TokenType.PERIOD_PERIOD => STokenType.periodPeriod,
      t.TokenType.PERIOD_PERIOD_PERIOD => STokenType.periodPeriodPeriod,
      t.TokenType.PERIOD_PERIOD_PERIOD_QUESTION =>
        STokenType.periodPeriodPeriodQuestion,
      t.TokenType.PLUS => STokenType.plus,
      t.TokenType.PLUS_EQ => STokenType.plusEq,
      t.TokenType.PLUS_PLUS => STokenType.plusPlus,
      t.TokenType.QUESTION => STokenType.question,
      t.TokenType.QUESTION_PERIOD => STokenType.questionPeriod,
      t.TokenType.QUESTION_QUESTION => STokenType.questionQuestion,
      t.TokenType.QUESTION_QUESTION_EQ => STokenType.questionQuestionEq,
      t.TokenType.SEMICOLON => STokenType.semicolon,
      t.TokenType.SLASH => STokenType.slash,
      t.TokenType.SLASH_EQ => STokenType.slashEq,
      t.TokenType.STAR => STokenType.star,
      t.TokenType.STAR_EQ => STokenType.starEq,
      t.TokenType.STRING => STokenType.stringLiteral,
      t.TokenType.TILDE => STokenType.tilde,
      t.TokenType.TILDE_SLASH => STokenType.tildeSlash,
      t.TokenType.TILDE_SLASH_EQ => STokenType.tildeSlashEq,
      // Keywords
      t.Keyword.ABSTRACT => STokenType.$abstract,
      t.Keyword.AS => STokenType.$as,
      t.Keyword.ASSERT => STokenType.$assert,
      t.Keyword.ASYNC => STokenType.$async,
      t.Keyword.AUGMENT => STokenType.$augment,
      t.Keyword.AWAIT => STokenType.$await,
      t.Keyword.BASE => STokenType.$base,
      t.Keyword.BREAK => STokenType.$break,
      t.Keyword.CASE => STokenType.$case,
      t.Keyword.CATCH => STokenType.$catch,
      t.Keyword.CLASS => STokenType.$class,
      t.Keyword.CONST => STokenType.$const,
      t.Keyword.CONTINUE => STokenType.$continue,
      t.Keyword.COVARIANT => STokenType.$covariant,
      t.Keyword.DEFAULT => STokenType.$default,
      t.Keyword.DEFERRED => STokenType.$deferred,
      t.Keyword.DO => STokenType.$do,
      t.Keyword.DYNAMIC => STokenType.$dynamic,
      t.Keyword.ELSE => STokenType.$else,
      t.Keyword.ENUM => STokenType.$enum,
      t.Keyword.EXPORT => STokenType.$export,
      t.Keyword.EXTENDS => STokenType.$extends,
      t.Keyword.EXTENSION => STokenType.$extension,
      t.Keyword.EXTERNAL => STokenType.$external,
      t.Keyword.FACTORY => STokenType.$factory,
      t.Keyword.FALSE => STokenType.$false,
      t.Keyword.FINAL => STokenType.$final,
      t.Keyword.FINALLY => STokenType.$finally,
      t.Keyword.FOR => STokenType.$for,
      t.Keyword.FUNCTION => STokenType.$Function,
      t.Keyword.GET => STokenType.$get,
      t.Keyword.HIDE => STokenType.$hide,
      t.Keyword.IF => STokenType.$if,
      t.Keyword.IMPLEMENTS => STokenType.$implements,
      t.Keyword.IMPORT => STokenType.$import,
      t.Keyword.IN => STokenType.$in,
      t.Keyword.INTERFACE => STokenType.$interface,
      t.Keyword.IS => STokenType.$is,
      t.Keyword.LATE => STokenType.$late,
      t.Keyword.LIBRARY => STokenType.$library,
      t.Keyword.MIXIN => STokenType.$mixin,
      t.Keyword.NATIVE => STokenType.$native,
      t.Keyword.NEW => STokenType.$new,
      t.Keyword.NULL => STokenType.$null,
      t.Keyword.OF => STokenType.$of,
      t.Keyword.ON => STokenType.$on,
      t.Keyword.OPERATOR => STokenType.$operator,
      t.Keyword.PART => STokenType.$part,
      t.Keyword.REQUIRED => STokenType.$required,
      t.Keyword.RETHROW => STokenType.$rethrow,
      t.Keyword.RETURN => STokenType.$return,
      t.Keyword.SEALED => STokenType.$sealed,
      t.Keyword.SET => STokenType.$set,
      t.Keyword.SHOW => STokenType.$show,
      t.Keyword.STATIC => STokenType.$static,
      t.Keyword.SUPER => STokenType.$super,
      t.Keyword.SWITCH => STokenType.$switch,
      t.Keyword.SYNC => STokenType.$sync,
      t.Keyword.THIS => STokenType.$this,
      t.Keyword.THROW => STokenType.$throw,
      t.Keyword.TRUE => STokenType.$true,
      t.Keyword.TRY => STokenType.$try,
      t.Keyword.TYPEDEF => STokenType.$typedef,
      t.Keyword.VAR => STokenType.$var,
      t.Keyword.VOID => STokenType.$void,
      t.Keyword.WHEN => STokenType.$when,
      t.Keyword.WHILE => STokenType.$while,
      t.Keyword.WITH => STokenType.$with,
      t.Keyword.YIELD => STokenType.$yield,
      _ => STokenType.identifier, // Default for unrecognized types
    };
  }

  // ===== Directives =====

  SDirective _convertDirective(a.Directive node) {
    return switch (node) {
      a.ImportDirective n => _convertImportDirective(n),
      a.ExportDirective n => _convertExportDirective(n),
      a.PartDirective n => _convertPartDirective(n),
      a.PartOfDirective n => _convertPartOfDirective(n),
      a.LibraryDirective n => _convertLibraryDirective(n),
    };
  }

  SImportDirective _convertImportDirective(a.ImportDirective node) {
    return SImportDirective(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      importKeyword: _convertToken(node.importKeyword),
      uri: _convertStringLiteral(node.uri),
      configurations: node.configurations.map(_convertConfiguration).toList(),
      deferredKeyword: _convertTokenOrNull(node.deferredKeyword),
      asKeyword: _convertTokenOrNull(node.asKeyword),
      prefix: node.prefix != null ? _convertSimpleIdentifier(node.prefix!) : null,
      combinators: node.combinators.map(_convertCombinator).toList(),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SExportDirective _convertExportDirective(a.ExportDirective node) {
    return SExportDirective(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      exportKeyword: _convertToken(node.exportKeyword),
      uri: _convertStringLiteral(node.uri),
      configurations: node.configurations.map(_convertConfiguration).toList(),
      combinators: node.combinators.map(_convertCombinator).toList(),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SPartDirective _convertPartDirective(a.PartDirective node) {
    return SPartDirective(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      partKeyword: _convertToken(node.partKeyword),
      uri: _convertStringLiteral(node.uri),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SPartOfDirective _convertPartOfDirective(a.PartOfDirective node) {
    return SPartOfDirective(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      partKeyword: _convertToken(node.partKeyword),
      ofKeyword: _convertToken(node.ofKeyword),
      libraryName: node.libraryName != null 
          ? _convertLibraryIdentifier(node.libraryName!) 
          : null,
      uri: node.uri != null ? _convertStringLiteral(node.uri!) : null,
      semicolon: _convertToken(node.semicolon),
    );
  }

  SLibraryDirective _convertLibraryDirective(a.LibraryDirective node) {
    return SLibraryDirective(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      libraryKeyword: _convertToken(node.libraryKeyword),
      name: node.name2 != null ? _convertLibraryIdentifier(node.name2!) : null,
      semicolon: _convertToken(node.semicolon),
    );
  }

  SLibraryIdentifier _convertLibraryIdentifier(a.LibraryIdentifier node) {
    return SLibraryIdentifier(
      components: node.components.map(_convertSimpleIdentifier).toList(),
    );
  }

  SConfiguration _convertConfiguration(a.Configuration node) {
    return SConfiguration(
      ifKeyword: _convertToken(node.ifKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      name: _convertDottedName(node.name),
      equalToken: _convertTokenOrNull(node.equalToken),
      value: node.value != null ? _convertStringLiteral(node.value!) : null,
      rightParenthesis: _convertToken(node.rightParenthesis),
      uri: _convertStringLiteral(node.uri),
    );
  }

  SDottedName _convertDottedName(a.DottedName node) {
    return SDottedName(
      components: node.components.map(_convertSimpleIdentifier).toList(),
    );
  }

  SCombinator _convertCombinator(a.Combinator node) {
    return switch (node) {
      a.ShowCombinator n => SShowCombinator(
          keyword: _convertToken(n.keyword),
          shownNames: n.shownNames.map(_convertSimpleIdentifier).toList(),
        ),
      a.HideCombinator n => SHideCombinator(
          keyword: _convertToken(n.keyword),
          hiddenNames: n.hiddenNames.map(_convertSimpleIdentifier).toList(),
        ),
    };
  }

  // ===== Declarations =====

  SDeclaration _convertDeclaration(a.CompilationUnitMember node) {
    return switch (node) {
      a.ClassDeclaration n => _convertClassDeclaration(n),
      a.EnumDeclaration n => _convertEnumDeclaration(n),
      a.ExtensionDeclaration n => _convertExtensionDeclaration(n),
      a.MixinDeclaration n => _convertMixinDeclaration(n),
      a.FunctionDeclaration n => _convertFunctionDeclaration(n),
      a.TopLevelVariableDeclaration n => _convertTopLevelVariableDeclaration(n),
      a.GenericTypeAlias n => _convertGenericTypeAlias(n),
      a.FunctionTypeAlias n => _convertFunctionTypeAlias(n),
      a.ExtensionTypeDeclaration n => _convertExtensionTypeDeclaration(n),
      _ => throw UnsupportedError(
          'Unsupported declaration: ${node.runtimeType}'),
    };
  }

  SClassDeclaration _convertClassDeclaration(a.ClassDeclaration node) {
    return SClassDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      abstractKeyword: _convertTokenOrNull(node.abstractKeyword),
      baseKeyword: _convertTokenOrNull(node.baseKeyword),
      interfaceKeyword: _convertTokenOrNull(node.interfaceKeyword),
      finalKeyword: _convertTokenOrNull(node.finalKeyword),
      sealedKeyword: _convertTokenOrNull(node.sealedKeyword),
      mixinKeyword: _convertTokenOrNull(node.mixinKeyword),
      classKeyword: _convertToken(node.classKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      extendsClause: node.extendsClause != null
          ? _convertExtendsClause(node.extendsClause!)
          : null,
      withClause: node.withClause != null
          ? _convertWithClause(node.withClause!)
          : null,
      implementsClause: node.implementsClause != null
          ? _convertImplementsClause(node.implementsClause!)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      members: node.members.map(_convertClassMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SEnumDeclaration _convertEnumDeclaration(a.EnumDeclaration node) {
    return SEnumDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      enumKeyword: _convertToken(node.enumKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      withClause: node.withClause != null
          ? _convertWithClause(node.withClause!)
          : null,
      implementsClause: node.implementsClause != null
          ? _convertImplementsClause(node.implementsClause!)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      constants: node.constants.map(_convertEnumConstantDeclaration).toList(),
      semicolon: _convertTokenOrNull(node.semicolon),
      members: node.members.map(_convertClassMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SEnumConstantDeclaration _convertEnumConstantDeclaration(
      a.EnumConstantDeclaration node) {
    return SEnumConstantDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      name: _convertSimpleIdentifierFromToken(node.name),
      arguments: node.arguments != null
          ? _convertArgumentList(node.arguments!.argumentList)
          : null,
    );
  }

  SExtensionDeclaration _convertExtensionDeclaration(
      a.ExtensionDeclaration node) {
    return SExtensionDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      extensionKeyword: _convertToken(node.extensionKeyword),
      name: node.name != null ? _convertSimpleIdentifierFromToken(node.name!) : null,
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      onKeyword: node.onClause != null ? _convertToken(node.onClause!.onKeyword) : null,
      extendedType: node.onClause != null
          ? _convertTypeAnnotation(node.onClause!.extendedType)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      members: node.members.map(_convertClassMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SExtensionDeclaration _convertExtensionTypeDeclaration(
      a.ExtensionTypeDeclaration node) {
    return SExtensionDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      extensionKeyword: _convertToken(node.extensionKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      onKeyword: null,
      extendedType: null,
      leftBrace: _convertToken(node.leftBracket),
      members: node.members.map(_convertClassMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SMixinDeclaration _convertMixinDeclaration(a.MixinDeclaration node) {
    return SMixinDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      baseKeyword: _convertTokenOrNull(node.baseKeyword),
      mixinKeyword: _convertToken(node.mixinKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      onClause: node.onClause != null
          ? _convertOnClause(node.onClause!)
          : null,
      implementsClause: node.implementsClause != null
          ? _convertImplementsClause(node.implementsClause!)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      members: node.members.map(_convertClassMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SFunctionDeclaration _convertFunctionDeclaration(a.FunctionDeclaration node) {
    return SFunctionDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      externalKeyword: _convertTokenOrNull(node.externalKeyword),
      returnType: node.returnType != null
          ? _convertTypeAnnotation(node.returnType!)
          : null,
      propertyKeyword: _convertTokenOrNull(node.propertyKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      functionExpression: _convertFunctionExpression(node.functionExpression),
    );
  }

  STopLevelVariableDeclaration _convertTopLevelVariableDeclaration(
      a.TopLevelVariableDeclaration node) {
    return STopLevelVariableDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      externalKeyword: _convertTokenOrNull(node.externalKeyword),
      variables: _convertVariableDeclarationList(node.variables),
      semicolon: _convertToken(node.semicolon),
    );
  }

  STypeAlias _convertGenericTypeAlias(a.GenericTypeAlias node) {
    return STypeAlias(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      typedefKeyword: _convertToken(node.typedefKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      equals: _convertToken(node.equals),
      type: _convertTypeAnnotation(node.type),
      semicolon: _convertToken(node.semicolon),
    );
  }

  STypeAlias _convertFunctionTypeAlias(a.FunctionTypeAlias node) {
    // Convert FunctionTypeAlias to GenericFunctionType format
    return STypeAlias(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      typedefKeyword: _convertToken(node.typedefKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      equals: _convertToken(node.typedefKeyword), // Placeholder
      type: SGenericFunctionType(
        returnType: node.returnType != null
            ? _convertTypeAnnotation(node.returnType!)
            : null,
        functionKeyword: _convertToken(node.typedefKeyword), // Placeholder
        typeParameters: null,
        parameters: _convertFormalParameterList(node.parameters),
        question: null,
      ),
      semicolon: _convertToken(node.semicolon),
    );
  }

  // ===== Class Members =====

  SClassMember _convertClassMember(a.ClassMember node) {
    return switch (node) {
      a.MethodDeclaration n => _convertMethodDeclaration(n),
      a.ConstructorDeclaration n => _convertConstructorDeclaration(n),
      a.FieldDeclaration n => _convertFieldDeclaration(n),
    };
  }

  SMethodDeclaration _convertMethodDeclaration(a.MethodDeclaration node) {
    return SMethodDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      externalKeyword: _convertTokenOrNull(node.externalKeyword),
      staticKeyword: _convertTokenOrNull(node.modifierKeyword),
      returnType: node.returnType != null
          ? _convertTypeAnnotation(node.returnType!)
          : null,
      propertyKeyword: _convertTokenOrNull(node.propertyKeyword),
      operatorKeyword: _convertTokenOrNull(node.operatorKeyword),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: node.parameters != null
          ? _convertFormalParameterList(node.parameters!)
          : null,
      body: _convertFunctionBody(node.body),
    );
  }

  SConstructorDeclaration _convertConstructorDeclaration(
      a.ConstructorDeclaration node) {
    final returnType = node.returnType;
    return SConstructorDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      externalKeyword: _convertTokenOrNull(node.externalKeyword),
      constKeyword: _convertTokenOrNull(node.constKeyword),
      factoryKeyword: _convertTokenOrNull(node.factoryKeyword),
      returnType: returnType is a.SimpleIdentifier
          ? _convertSimpleIdentifier(returnType)
          : _convertSimpleIdentifierFromToken(returnType.beginToken),
      period: _convertTokenOrNull(node.period),
      name: node.name != null ? _convertSimpleIdentifierFromToken(node.name!) : null,
      parameters: _convertFormalParameterList(node.parameters),
      separator: _convertTokenOrNull(node.separator),
      initializers:
          node.initializers.map(_convertConstructorInitializer).toList(),
      redirectedConstructor: node.redirectedConstructor != null
          ? _convertConstructorName(node.redirectedConstructor!)
          : null,
      body: _convertFunctionBody(node.body),
    );
  }

  SConstructorInitializer _convertConstructorInitializer(
      a.ConstructorInitializer node) {
    return switch (node) {
      a.SuperConstructorInvocation n => SSuperConstructorInvocation(
          superKeyword: _convertToken(n.superKeyword),
          period: _convertTokenOrNull(n.period),
          constructorName:
              n.constructorName != null ? _convertSimpleIdentifier(n.constructorName!) : null,
          argumentList: _convertArgumentList(n.argumentList),
        ),
      a.RedirectingConstructorInvocation n => SRedirectingConstructorInvocation(
          thisKeyword: _convertToken(n.thisKeyword),
          period: _convertTokenOrNull(n.period),
          constructorName:
              n.constructorName != null ? _convertSimpleIdentifier(n.constructorName!) : null,
          argumentList: _convertArgumentList(n.argumentList),
        ),
      a.ConstructorFieldInitializer n => SConstructorFieldInitializer(
          thisKeyword: _convertTokenOrNull(n.thisKeyword),
          period: _convertTokenOrNull(n.period),
          fieldName: _convertSimpleIdentifier(n.fieldName),
          equals: _convertToken(n.equals),
          expression: _convertExpression(n.expression),
        ),
      a.AssertInitializer n => SAssertInitializer(
          assertKeyword: _convertToken(n.assertKeyword),
          leftParenthesis: _convertToken(n.leftParenthesis),
          condition: _convertExpression(n.condition),
          comma: _convertTokenOrNull(n.comma),
          message: n.message != null ? _convertExpression(n.message!) : null,
          rightParenthesis: _convertToken(n.rightParenthesis),
        ),
    };
  }

  SFieldDeclaration _convertFieldDeclaration(a.FieldDeclaration node) {
    return SFieldDeclaration(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      abstractKeyword: _convertTokenOrNull(node.abstractKeyword),
      covariantKeyword: _convertTokenOrNull(node.covariantKeyword),
      externalKeyword: _convertTokenOrNull(node.externalKeyword),
      staticKeyword: _convertTokenOrNull(node.staticKeyword),
      fields: _convertVariableDeclarationList(node.fields),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SVariableDeclarationList _convertVariableDeclarationList(
      a.VariableDeclarationList node) {
    return SVariableDeclarationList(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      lateKeyword: _convertTokenOrNull(node.lateKeyword),
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      variables: node.variables.map(_convertVariableDeclaration).toList(),
    );
  }

  SVariableDeclaration _convertVariableDeclaration(
      a.VariableDeclaration node) {
    return SVariableDeclaration(
      name: _convertSimpleIdentifierFromToken(node.name),
      equals: _convertTokenOrNull(node.equals),
      initializer:
          node.initializer != null ? _convertExpression(node.initializer!) : null,
    );
  }

  // ===== Expressions =====

  SExpression _convertExpression(a.Expression node) {
    return switch (node) {
      a.IntegerLiteral n => _convertIntegerLiteral(n),
      a.DoubleLiteral n => _convertDoubleLiteral(n),
      a.BooleanLiteral n => _convertBooleanLiteral(n),
      a.NullLiteral n => _convertNullLiteral(n),
      a.SimpleStringLiteral n => _convertSimpleStringLiteral(n),
      a.AdjacentStrings n => _convertAdjacentStrings(n),
      a.StringInterpolation n => _convertStringInterpolation(n),
      a.SymbolLiteral n => _convertSymbolLiteral(n),
      a.ListLiteral n => _convertListLiteral(n),
      a.SetOrMapLiteral n => _convertSetOrMapLiteral(n),
      a.RecordLiteral n => _convertRecordLiteral(n),
      a.SimpleIdentifier n => _convertSimpleIdentifier(n),
      a.PrefixedIdentifier n => _convertPrefixedIdentifier(n),
      a.BinaryExpression n => _convertBinaryExpression(n),
      a.PrefixExpression n => _convertPrefixExpression(n),
      a.PostfixExpression n => _convertPostfixExpression(n),
      a.AssignmentExpression n => _convertAssignmentExpression(n),
      a.ConditionalExpression n => _convertConditionalExpression(n),
      a.ParenthesizedExpression n => _convertParenthesizedExpression(n),
      a.IndexExpression n => _convertIndexExpression(n),
      a.PropertyAccess n => _convertPropertyAccess(n),
      a.MethodInvocation n => _convertMethodInvocation(n),
      a.FunctionExpressionInvocation n => _convertFunctionExpressionInvocation(n),
      a.InstanceCreationExpression n => _convertInstanceCreationExpression(n),
      a.FunctionExpression n => _convertFunctionExpression(n),
      a.CascadeExpression n => _convertCascadeExpression(n),
      a.ThrowExpression n => _convertThrowExpression(n),
      a.RethrowExpression n => _convertRethrowExpression(n),
      a.AwaitExpression n => _convertAwaitExpression(n),
      a.IsExpression n => _convertIsExpression(n),
      a.AsExpression n => _convertAsExpression(n),
      a.ThisExpression n => _convertThisExpression(n),
      a.SuperExpression n => _convertSuperExpression(n),
      a.SwitchExpression n => _convertSwitchExpression(n),
      a.NamedExpression n => _convertNamedExpression(n),
      a.PatternAssignment n => _convertPatternAssignment(n),
      a.FunctionReference n => _convertFunctionReference(n),
      a.ConstructorReference n => _convertConstructorReference(n),
      _ => throw UnsupportedError(
          'Unsupported expression: ${node.runtimeType}'),
    };
  }

  SIntegerLiteral _convertIntegerLiteral(a.IntegerLiteral node) {
    return SIntegerLiteral(
      literal: _convertToken(node.literal),
      value: node.value ?? 0,
    );
  }

  SDoubleLiteral _convertDoubleLiteral(a.DoubleLiteral node) {
    return SDoubleLiteral(
      literal: _convertToken(node.literal),
      value: node.value,
    );
  }

  SBooleanLiteral _convertBooleanLiteral(a.BooleanLiteral node) {
    return SBooleanLiteral(
      literal: _convertToken(node.literal),
      value: node.value,
    );
  }

  SNullLiteral _convertNullLiteral(a.NullLiteral node) {
    return SNullLiteral(
      literal: _convertToken(node.literal),
    );
  }

  SSimpleStringLiteral _convertSimpleStringLiteral(a.SimpleStringLiteral node) {
    return SSimpleStringLiteral(
      literal: _convertToken(node.literal),
      stringValue: node.value,
    );
  }

  SAdjacentStrings _convertAdjacentStrings(a.AdjacentStrings node) {
    return SAdjacentStrings(
      strings: node.strings.map(_convertStringLiteral).toList(),
    );
  }

  SStringInterpolation _convertStringInterpolation(a.StringInterpolation node) {
    return SStringInterpolation(
      elements: node.elements.map(_convertInterpolationElement).toList(),
    );
  }

  SInterpolationElement _convertInterpolationElement(
      a.InterpolationElement node) {
    return switch (node) {
      a.InterpolationString n => SInterpolationString(
          contents: _convertToken(n.contents),
          value: n.value,
        ),
      a.InterpolationExpression n => SInterpolationExpression(
          leftBracket: _convertToken(n.leftBracket),
          expression: _convertExpression(n.expression),
          rightBracket: _convertTokenOrNull(n.rightBracket),
        ),
    };
  }

  SStringLiteral _convertStringLiteral(a.StringLiteral node) {
    return switch (node) {
      a.SimpleStringLiteral n => _convertSimpleStringLiteral(n),
      a.AdjacentStrings n => _convertAdjacentStrings(n),
      a.StringInterpolation n => _convertStringInterpolation(n),
    };
  }

  SSymbolLiteral _convertSymbolLiteral(a.SymbolLiteral node) {
    return SSymbolLiteral(
      poundSign: _convertToken(node.poundSign),
      components: node.components.map(_convertToken).toList(),
    );
  }

  SListLiteral _convertListLiteral(a.ListLiteral node) {
    return SListLiteral(
      constKeyword: _convertTokenOrNull(node.constKeyword),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      leftBracket: _convertToken(node.leftBracket),
      elements: node.elements.map(_convertCollectionElement).toList(),
      rightBracket: _convertToken(node.rightBracket),
    );
  }

  SSetOrMapLiteral _convertSetOrMapLiteral(a.SetOrMapLiteral node) {
    return SSetOrMapLiteral(
      constKeyword: _convertTokenOrNull(node.constKeyword),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      elements: node.elements.map(_convertCollectionElement).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SRecordLiteral _convertRecordLiteral(a.RecordLiteral node) {
    return SRecordLiteral(
      constKeyword: _convertTokenOrNull(node.constKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      fields: node.fields.map(_convertExpression).toList(),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SCollectionElement _convertCollectionElement(a.CollectionElement node) {
    return switch (node) {
      a.Expression n => SExpressionElement(expression: _convertExpression(n)),
      a.SpreadElement n => _convertSpreadElement(n),
      a.IfElement n => _convertIfElement(n),
      a.ForElement n => _convertForElement(n),
      a.MapLiteralEntry n => _convertMapLiteralEntry(n),
      _ => throw UnsupportedError(
          'Unsupported collection element: ${node.runtimeType}'),
    };
  }

  SSpreadElement _convertSpreadElement(a.SpreadElement node) {
    return SSpreadElement(
      spreadOperator: _convertToken(node.spreadOperator),
      expression: _convertExpression(node.expression),
    );
  }

  SIfElement _convertIfElement(a.IfElement node) {
    return SIfElement(
      ifKeyword: _convertToken(node.ifKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      expression: _convertExpression(node.expression),
      caseClause: node.caseClause != null
          ? _convertCaseClause(node.caseClause!)
          : null,
      rightParenthesis: _convertToken(node.rightParenthesis),
      thenElement: _convertCollectionElement(node.thenElement),
      elseKeyword: _convertTokenOrNull(node.elseKeyword),
      elseElement:
          node.elseElement != null ? _convertCollectionElement(node.elseElement!) : null,
    );
  }

  SForElement _convertForElement(a.ForElement node) {
    return SForElement(
      awaitKeyword: _convertTokenOrNull(node.awaitKeyword),
      forKeyword: _convertToken(node.forKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      forLoopParts: _convertForLoopParts(node.forLoopParts),
      rightParenthesis: _convertToken(node.rightParenthesis),
      body: _convertCollectionElement(node.body),
    );
  }

  SMapLiteralEntry _convertMapLiteralEntry(a.MapLiteralEntry node) {
    return SMapLiteralEntry(
      key: _convertExpression(node.key),
      separator: _convertToken(node.separator),
      value: _convertExpression(node.value),
    );
  }

  SSimpleIdentifier _convertSimpleIdentifier(a.SimpleIdentifier node) {
    return SSimpleIdentifier(
      token: _convertToken(node.token),
    );
  }

  /// Creates an SSimpleIdentifier from a raw Token (for name2/name properties)
  SSimpleIdentifier _convertSimpleIdentifierFromToken(t.Token token) {
    return SSimpleIdentifier(
      token: _convertToken(token),
    );
  }

  SPrefixedIdentifier _convertPrefixedIdentifier(a.PrefixedIdentifier node) {
    return SPrefixedIdentifier(
      prefix: _convertSimpleIdentifier(node.prefix),
      period: _convertToken(node.period),
      identifier: _convertSimpleIdentifier(node.identifier),
    );
  }

  SBinaryExpression _convertBinaryExpression(a.BinaryExpression node) {
    return SBinaryExpression(
      leftOperand: _convertExpression(node.leftOperand),
      operator: _convertToken(node.operator),
      rightOperand: _convertExpression(node.rightOperand),
    );
  }

  SPrefixExpression _convertPrefixExpression(a.PrefixExpression node) {
    return SPrefixExpression(
      operator: _convertToken(node.operator),
      operand: _convertExpression(node.operand),
    );
  }

  SPostfixExpression _convertPostfixExpression(a.PostfixExpression node) {
    return SPostfixExpression(
      operand: _convertExpression(node.operand),
      operator: _convertToken(node.operator),
    );
  }

  SAssignmentExpression _convertAssignmentExpression(
      a.AssignmentExpression node) {
    return SAssignmentExpression(
      leftHandSide: _convertExpression(node.leftHandSide),
      operator: _convertToken(node.operator),
      rightHandSide: _convertExpression(node.rightHandSide),
    );
  }

  SConditionalExpression _convertConditionalExpression(
      a.ConditionalExpression node) {
    return SConditionalExpression(
      condition: _convertExpression(node.condition),
      question: _convertToken(node.question),
      thenExpression: _convertExpression(node.thenExpression),
      colon: _convertToken(node.colon),
      elseExpression: _convertExpression(node.elseExpression),
    );
  }

  SParenthesizedExpression _convertParenthesizedExpression(
      a.ParenthesizedExpression node) {
    return SParenthesizedExpression(
      leftParenthesis: _convertToken(node.leftParenthesis),
      expression: _convertExpression(node.expression),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SIndexExpression _convertIndexExpression(a.IndexExpression node) {
    return SIndexExpression(
      target: node.target != null ? _convertExpression(node.target!) : null,
      question: _convertTokenOrNull(node.question),
      leftBracket: _convertToken(node.leftBracket),
      index: _convertExpression(node.index),
      rightBracket: _convertToken(node.rightBracket),
    );
  }

  SPropertyAccess _convertPropertyAccess(a.PropertyAccess node) {
    return SPropertyAccess(
      target: node.target != null ? _convertExpression(node.target!) : null,
      operator: _convertToken(node.operator),
      propertyName: _convertSimpleIdentifier(node.propertyName),
    );
  }

  SMethodInvocation _convertMethodInvocation(a.MethodInvocation node) {
    return SMethodInvocation(
      target: node.target != null ? _convertExpression(node.target!) : null,
      operator: _convertTokenOrNull(node.operator),
      methodName: _convertSimpleIdentifier(node.methodName),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      argumentList: _convertArgumentList(node.argumentList),
    );
  }

  SFunctionExpressionInvocation _convertFunctionExpressionInvocation(
      a.FunctionExpressionInvocation node) {
    return SFunctionExpressionInvocation(
      function: _convertExpression(node.function),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      argumentList: _convertArgumentList(node.argumentList),
    );
  }

  SInstanceCreationExpression _convertInstanceCreationExpression(
      a.InstanceCreationExpression node) {
    return SInstanceCreationExpression(
      keyword: _convertTokenOrNull(node.keyword),
      constructorName: _convertConstructorName(node.constructorName),
      argumentList: _convertArgumentList(node.argumentList),
    );
  }

  SConstructorName _convertConstructorName(a.ConstructorName node) {
    return SConstructorName(
      type: _convertNamedType(node.type),
      period: _convertTokenOrNull(node.period),
      name: node.name != null ? _convertSimpleIdentifier(node.name!) : null,
    );
  }

  SFunctionExpression _convertFunctionExpression(a.FunctionExpression node) {
    return SFunctionExpression(
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: node.parameters != null
          ? _convertFormalParameterList(node.parameters!)
          : SFormalParameterList(
              leftParenthesis: SToken(
                  offset: node.offset, lexeme: '(', type: STokenType.openParen),
              parameters: [],
              leftDelimiter: null,
              rightDelimiter: null,
              rightParenthesis: SToken(
                  offset: node.offset + 1,
                  lexeme: ')',
                  type: STokenType.closeParen),
            ),
      body: _convertFunctionBody(node.body),
    );
  }

  SCascadeExpression _convertCascadeExpression(a.CascadeExpression node) {
    return SCascadeExpression(
      target: _convertExpression(node.target),
      cascadeSections: node.cascadeSections.map(_convertExpression).toList(),
    );
  }

  SThrowExpression _convertThrowExpression(a.ThrowExpression node) {
    return SThrowExpression(
      throwKeyword: _convertToken(node.throwKeyword),
      expression: _convertExpression(node.expression),
    );
  }

  SRethrowExpression _convertRethrowExpression(a.RethrowExpression node) {
    return SRethrowExpression(
      rethrowKeyword: _convertToken(node.rethrowKeyword),
    );
  }

  SAwaitExpression _convertAwaitExpression(a.AwaitExpression node) {
    return SAwaitExpression(
      awaitKeyword: _convertToken(node.awaitKeyword),
      expression: _convertExpression(node.expression),
    );
  }

  SIsExpression _convertIsExpression(a.IsExpression node) {
    return SIsExpression(
      expression: _convertExpression(node.expression),
      isOperator: _convertToken(node.isOperator),
      notOperator: _convertTokenOrNull(node.notOperator),
      type: _convertTypeAnnotation(node.type),
    );
  }

  SAsExpression _convertAsExpression(a.AsExpression node) {
    return SAsExpression(
      expression: _convertExpression(node.expression),
      asOperator: _convertToken(node.asOperator),
      type: _convertTypeAnnotation(node.type),
    );
  }

  SThisExpression _convertThisExpression(a.ThisExpression node) {
    return SThisExpression(
      thisKeyword: _convertToken(node.thisKeyword),
    );
  }

  SSuperExpression _convertSuperExpression(a.SuperExpression node) {
    return SSuperExpression(
      superKeyword: _convertToken(node.superKeyword),
    );
  }

  SSwitchExpression _convertSwitchExpression(a.SwitchExpression node) {
    return SSwitchExpression(
      switchKeyword: _convertToken(node.switchKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      expression: _convertExpression(node.expression),
      rightParenthesis: _convertToken(node.rightParenthesis),
      leftBrace: _convertToken(node.leftBracket),
      cases: node.cases.map(_convertSwitchExpressionCase).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SSwitchExpressionCase _convertSwitchExpressionCase(
      a.SwitchExpressionCase node) {
    return SSwitchExpressionCase(
      guardedPattern: _convertGuardedPattern(node.guardedPattern),
      arrow: _convertToken(node.arrow),
      expression: _convertExpression(node.expression),
    );
  }

  SGuardedPattern _convertGuardedPattern(a.GuardedPattern node) {
    return SGuardedPattern(
      pattern: _convertPattern(node.pattern),
      whenClause: node.whenClause != null
          ? _convertToken(node.whenClause!.whenKeyword)
          : null,
      guard: node.whenClause?.expression != null
          ? _convertExpression(node.whenClause!.expression)
          : null,
    );
  }

  SNamedExpression _convertNamedExpression(a.NamedExpression node) {
    return SNamedExpression(
      name: _convertLabel(node.name),
      expression: _convertExpression(node.expression),
    );
  }

  SLabel _convertLabel(a.Label node) {
    return SLabel(
      label: _convertSimpleIdentifier(node.label),
      colon: _convertToken(node.colon),
    );
  }

  SPatternAssignment _convertPatternAssignment(a.PatternAssignment node) {
    return SPatternAssignment(
      pattern: _convertPattern(node.pattern),
      equals: _convertToken(node.equals),
      expression: _convertExpression(node.expression),
    );
  }

  SFunctionReference _convertFunctionReference(a.FunctionReference node) {
    return SFunctionReference(
      function: _convertExpression(node.function),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
    );
  }

  SConstructorReference _convertConstructorReference(
      a.ConstructorReference node) {
    return SConstructorReference(
      constructorName: _convertConstructorName(node.constructorName),
    );
  }

  // ===== Statements =====

  SStatement _convertStatement(a.Statement node) {
    return switch (node) {
      a.Block n => _convertBlock(n),
      a.ExpressionStatement n => _convertExpressionStatement(n),
      a.VariableDeclarationStatement n => _convertVariableDeclarationStatement(n),
      a.IfStatement n => _convertIfStatement(n),
      a.ForStatement n => _convertForStatement(n),
      a.WhileStatement n => _convertWhileStatement(n),
      a.DoStatement n => _convertDoStatement(n),
      a.SwitchStatement n => _convertSwitchStatement(n),
      a.TryStatement n => _convertTryStatement(n),
      a.ReturnStatement n => _convertReturnStatement(n),
      a.BreakStatement n => _convertBreakStatement(n),
      a.ContinueStatement n => _convertContinueStatement(n),
      a.EmptyStatement n => _convertEmptyStatement(n),
      a.AssertStatement n => _convertAssertStatement(n),
      a.YieldStatement n => _convertYieldStatement(n),
      a.LabeledStatement n => _convertLabeledStatement(n),
      a.FunctionDeclarationStatement n =>
        _convertFunctionDeclarationStatement(n),
      a.PatternVariableDeclarationStatement n =>
        _convertPatternVariableDeclarationStatement(n),
      _ => throw UnsupportedError(
          'Unsupported statement: ${node.runtimeType}'),
    };
  }

  SBlock _convertBlock(a.Block node) {
    return SBlock(
      leftBrace: _convertToken(node.leftBracket),
      statements: node.statements.map(_convertStatement).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SExpressionStatement _convertExpressionStatement(
      a.ExpressionStatement node) {
    return SExpressionStatement(
      expression: _convertExpression(node.expression),
      semicolon: _convertTokenOrNull(node.semicolon),
    );
  }

  SVariableDeclarationStatement _convertVariableDeclarationStatement(
      a.VariableDeclarationStatement node) {
    return SVariableDeclarationStatement(
      variables: _convertVariableDeclarationList(node.variables),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SIfStatement _convertIfStatement(a.IfStatement node) {
    return SIfStatement(
      ifKeyword: _convertToken(node.ifKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      expression: _convertExpression(node.expression),
      caseClause: node.caseClause != null
          ? _convertCaseClause(node.caseClause!)
          : null,
      rightParenthesis: _convertToken(node.rightParenthesis),
      thenStatement: _convertStatement(node.thenStatement),
      elseKeyword: _convertTokenOrNull(node.elseKeyword),
      elseStatement:
          node.elseStatement != null ? _convertStatement(node.elseStatement!) : null,
    );
  }

  SCaseClause _convertCaseClause(a.CaseClause node) {
    return SCaseClause(
      caseKeyword: _convertToken(node.caseKeyword),
      guardedPattern: _convertGuardedPattern(node.guardedPattern),
    );
  }

  SForStatement _convertForStatement(a.ForStatement node) {
    return SForStatement(
      awaitKeyword: _convertTokenOrNull(node.awaitKeyword),
      forKeyword: _convertToken(node.forKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      forLoopParts: _convertForLoopParts(node.forLoopParts),
      rightParenthesis: _convertToken(node.rightParenthesis),
      body: _convertStatement(node.body),
    );
  }

  SForLoopParts _convertForLoopParts(a.ForLoopParts node) {
    return switch (node) {
      a.ForPartsWithDeclarations n => SForParts(
          initialization: _convertVariableDeclarationList(n.variables),
          leftSeparator: _convertToken(n.leftSeparator),
          condition: n.condition != null ? _convertExpression(n.condition!) : null,
          rightSeparator: _convertToken(n.rightSeparator),
          updaters: n.updaters.map(_convertExpression).toList(),
        ),
      a.ForPartsWithExpression n => SForParts(
          initialization:
              n.initialization != null ? _convertExpression(n.initialization!) : null,
          leftSeparator: _convertToken(n.leftSeparator),
          condition: n.condition != null ? _convertExpression(n.condition!) : null,
          rightSeparator: _convertToken(n.rightSeparator),
          updaters: n.updaters.map(_convertExpression).toList(),
        ),
      a.ForEachPartsWithDeclaration n => SForEachParts(
          loopVariable: _convertDeclaredIdentifier(n.loopVariable),
          inKeyword: _convertToken(n.inKeyword),
          iterable: _convertExpression(n.iterable),
        ),
      a.ForEachPartsWithIdentifier n => SForEachParts(
          loopVariable: _convertSimpleIdentifier(n.identifier),
          inKeyword: _convertToken(n.inKeyword),
          iterable: _convertExpression(n.iterable),
        ),
      a.ForEachPartsWithPattern n => SForEachParts(
          loopVariable: _convertPattern(n.pattern),
          inKeyword: _convertToken(n.inKeyword),
          iterable: _convertExpression(n.iterable),
        ),
      a.ForPartsWithPattern n => SForParts(
          initialization: _convertPatternVariableDeclaration(n.variables),
          leftSeparator: _convertToken(n.leftSeparator),
          condition: n.condition != null ? _convertExpression(n.condition!) : null,
          rightSeparator: _convertToken(n.rightSeparator),
          updaters: n.updaters.map(_convertExpression).toList(),
        ),
    };
  }

  SDeclaredIdentifier _convertDeclaredIdentifier(a.DeclaredIdentifier node) {
    return SDeclaredIdentifier(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      name: _convertSimpleIdentifierFromToken(node.name),
    );
  }

  SPatternVariableDeclaration _convertPatternVariableDeclaration(
      a.PatternVariableDeclaration node) {
    return SPatternVariableDeclaration(
      keyword: _convertToken(node.keyword),
      pattern: _convertPattern(node.pattern),
      equals: _convertToken(node.equals),
      expression: _convertExpression(node.expression),
    );
  }

  SWhileStatement _convertWhileStatement(a.WhileStatement node) {
    return SWhileStatement(
      whileKeyword: _convertToken(node.whileKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      condition: _convertExpression(node.condition),
      rightParenthesis: _convertToken(node.rightParenthesis),
      body: _convertStatement(node.body),
    );
  }

  SDoStatement _convertDoStatement(a.DoStatement node) {
    return SDoStatement(
      doKeyword: _convertToken(node.doKeyword),
      body: _convertStatement(node.body),
      whileKeyword: _convertToken(node.whileKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      condition: _convertExpression(node.condition),
      rightParenthesis: _convertToken(node.rightParenthesis),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SSwitchStatement _convertSwitchStatement(a.SwitchStatement node) {
    return SSwitchStatement(
      switchKeyword: _convertToken(node.switchKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      expression: _convertExpression(node.expression),
      rightParenthesis: _convertToken(node.rightParenthesis),
      leftBrace: _convertToken(node.leftBracket),
      members: node.members.map(_convertSwitchMember).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SSwitchMember _convertSwitchMember(a.SwitchMember node) {
    return switch (node) {
      a.SwitchPatternCase n => SSwitchPatternCase(
          labels: n.labels.map(_convertLabel).toList(),
          keyword: _convertToken(n.keyword),
          guardedPattern: _convertGuardedPattern(n.guardedPattern),
          colon: _convertToken(n.colon),
          statements: n.statements.map(_convertStatement).toList(),
        ),
      a.SwitchDefault n => SSwitchDefault(
          labels: n.labels.map(_convertLabel).toList(),
          keyword: _convertToken(n.keyword),
          colon: _convertToken(n.colon),
          statements: n.statements.map(_convertStatement).toList(),
        ),
      _ => throw UnsupportedError(
          'Unsupported switch member: ${node.runtimeType}'),
    };
  }

  STryStatement _convertTryStatement(a.TryStatement node) {
    return STryStatement(
      tryKeyword: _convertToken(node.tryKeyword),
      body: _convertBlock(node.body),
      catchClauses: node.catchClauses.map(_convertCatchClause).toList(),
      finallyKeyword: _convertTokenOrNull(node.finallyKeyword),
      finallyBlock:
          node.finallyBlock != null ? _convertBlock(node.finallyBlock!) : null,
    );
  }

  SCatchClause _convertCatchClause(a.CatchClause node) {
    return SCatchClause(
      onKeyword: _convertTokenOrNull(node.onKeyword),
      exceptionType:
          node.exceptionType != null ? _convertTypeAnnotation(node.exceptionType!) : null,
      catchKeyword: _convertTokenOrNull(node.catchKeyword),
      leftParenthesis: _convertTokenOrNull(node.leftParenthesis),
      exceptionParameter: node.exceptionParameter != null
          ? _convertSimpleIdentifierFromToken(node.exceptionParameter!.name)
          : null,
      comma: _convertTokenOrNull(node.comma),
      stackTraceParameter: node.stackTraceParameter != null
          ? _convertSimpleIdentifierFromToken(node.stackTraceParameter!.name)
          : null,
      rightParenthesis: _convertTokenOrNull(node.rightParenthesis),
      body: _convertBlock(node.body),
    );
  }

  SReturnStatement _convertReturnStatement(a.ReturnStatement node) {
    return SReturnStatement(
      returnKeyword: _convertToken(node.returnKeyword),
      expression:
          node.expression != null ? _convertExpression(node.expression!) : null,
      semicolon: _convertToken(node.semicolon),
    );
  }

  SBreakStatement _convertBreakStatement(a.BreakStatement node) {
    return SBreakStatement(
      breakKeyword: _convertToken(node.breakKeyword),
      label: node.label != null ? _convertSimpleIdentifier(node.label!) : null,
      semicolon: _convertToken(node.semicolon),
    );
  }

  SContinueStatement _convertContinueStatement(a.ContinueStatement node) {
    return SContinueStatement(
      continueKeyword: _convertToken(node.continueKeyword),
      label: node.label != null ? _convertSimpleIdentifier(node.label!) : null,
      semicolon: _convertToken(node.semicolon),
    );
  }

  SEmptyStatement _convertEmptyStatement(a.EmptyStatement node) {
    return SEmptyStatement(
      semicolon: _convertToken(node.semicolon),
    );
  }

  SAssertStatement _convertAssertStatement(a.AssertStatement node) {
    return SAssertStatement(
      assertKeyword: _convertToken(node.assertKeyword),
      leftParenthesis: _convertToken(node.leftParenthesis),
      condition: _convertExpression(node.condition),
      comma: _convertTokenOrNull(node.comma),
      message: node.message != null ? _convertExpression(node.message!) : null,
      rightParenthesis: _convertToken(node.rightParenthesis),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SYieldStatement _convertYieldStatement(a.YieldStatement node) {
    return SYieldStatement(
      yieldKeyword: _convertToken(node.yieldKeyword),
      star: _convertTokenOrNull(node.star),
      expression: _convertExpression(node.expression),
      semicolon: _convertToken(node.semicolon),
    );
  }

  SLabeledStatement _convertLabeledStatement(a.LabeledStatement node) {
    return SLabeledStatement(
      labels: node.labels.map(_convertLabel).toList(),
      statement: _convertStatement(node.statement),
    );
  }

  SFunctionDeclarationStatement _convertFunctionDeclarationStatement(
      a.FunctionDeclarationStatement node) {
    return SFunctionDeclarationStatement(
      functionDeclaration: _convertFunctionDeclaration(node.functionDeclaration),
    );
  }

  SPatternVariableDeclarationStatement
      _convertPatternVariableDeclarationStatement(
          a.PatternVariableDeclarationStatement node) {
    return SPatternVariableDeclarationStatement(
      declaration: _convertPatternVariableDeclaration(node.declaration),
      semicolon: _convertToken(node.semicolon),
    );
  }

  // ===== Function Bodies =====

  SFunctionBody _convertFunctionBody(a.FunctionBody node) {
    return switch (node) {
      a.BlockFunctionBody n => SBlockFunctionBody(
          keyword: _convertTokenOrNull(n.keyword),
          star: _convertTokenOrNull(n.star),
          block: _convertBlock(n.block),
        ),
      a.ExpressionFunctionBody n => SExpressionFunctionBody(
          keyword: _convertTokenOrNull(n.keyword),
          functionDefinition: _convertToken(n.functionDefinition),
          expression: _convertExpression(n.expression),
          semicolon: _convertTokenOrNull(n.semicolon),
        ),
      a.EmptyFunctionBody n => SEmptyFunctionBody(
          semicolon: _convertToken(n.semicolon),
        ),
      a.NativeFunctionBody n => SNativeFunctionBody(
          nativeKeyword: _convertToken(n.nativeKeyword),
          stringLiteral:
              n.stringLiteral != null ? _convertStringLiteral(n.stringLiteral!) : null,
          semicolon: _convertToken(n.semicolon),
        ),
    };
  }

  // ===== Parameters =====

  SFormalParameterList _convertFormalParameterList(
      a.FormalParameterList node) {
    return SFormalParameterList(
      leftParenthesis: _convertToken(node.leftParenthesis),
      parameters: node.parameters.map(_convertFormalParameter).toList(),
      leftDelimiter: _convertTokenOrNull(node.leftDelimiter),
      rightDelimiter: _convertTokenOrNull(node.rightDelimiter),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SFormalParameter _convertFormalParameter(a.FormalParameter node) {
    return switch (node) {
      a.SimpleFormalParameter n => _convertSimpleFormalParameter(n),
      a.DefaultFormalParameter n => _convertDefaultFormalParameter(n),
      a.FieldFormalParameter n => _convertFieldFormalParameter(n),
      a.FunctionTypedFormalParameter n =>
        _convertFunctionTypedFormalParameter(n),
      a.SuperFormalParameter n => _convertSuperFormalParameter(n),
    };
  }

  SSimpleFormalParameter _convertSimpleFormalParameter(
      a.SimpleFormalParameter node) {
    return SSimpleFormalParameter(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      covariantKeyword: _convertTokenOrNull(node.covariantKeyword),
      requiredKeyword: _convertTokenOrNull(node.requiredKeyword),
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      name: node.name != null ? _convertSimpleIdentifierFromToken(node.name!) : null,
    );
  }

  SDefaultFormalParameter _convertDefaultFormalParameter(
      a.DefaultFormalParameter node) {
    // DefaultFormalParameter doesn't expose kind directly via interface,
    // use boolean helpers to determine kind
    final kind = _inferParameterKind(node);
    return SDefaultFormalParameter(
      parameter: _convertFormalParameter(node.parameter),
      kind: kind,
      separator: _convertTokenOrNull(node.separator),
      defaultValue:
          node.defaultValue != null ? _convertExpression(node.defaultValue!) : null,
    );
  }

  SParameterKind _inferParameterKind(a.FormalParameter node) {
    // Use the boolean helpers on FormalParameter to infer kind
    if (node.isRequiredPositional) return SParameterKind.requiredPositional;
    if (node.isOptionalPositional) return SParameterKind.optionalPositional;
    if (node.isRequiredNamed) return SParameterKind.requiredNamed;
    if (node.isOptionalNamed) return SParameterKind.optionalNamed;
    // Default fallback
    return SParameterKind.requiredPositional;
  }

  SFieldFormalParameter _convertFieldFormalParameter(
      a.FieldFormalParameter node) {
    return SFieldFormalParameter(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      covariantKeyword: _convertTokenOrNull(node.covariantKeyword),
      requiredKeyword: _convertTokenOrNull(node.requiredKeyword),
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      thisKeyword: _convertToken(node.thisKeyword),
      period: _convertToken(node.period),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: node.parameters != null
          ? _convertFormalParameterList(node.parameters!)
          : null,
      question: _convertTokenOrNull(node.question),
    );
  }

  SFunctionTypedFormalParameter _convertFunctionTypedFormalParameter(
      a.FunctionTypedFormalParameter node) {
    return SFunctionTypedFormalParameter(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      covariantKeyword: _convertTokenOrNull(node.covariantKeyword),
      requiredKeyword: _convertTokenOrNull(node.requiredKeyword),
      returnType:
          node.returnType != null ? _convertTypeAnnotation(node.returnType!) : null,
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: _convertFormalParameterList(node.parameters),
      question: _convertTokenOrNull(node.question),
    );
  }

  SSuperFormalParameter _convertSuperFormalParameter(
      a.SuperFormalParameter node) {
    return SSuperFormalParameter(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      covariantKeyword: _convertTokenOrNull(node.covariantKeyword),
      requiredKeyword: _convertTokenOrNull(node.requiredKeyword),
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      superKeyword: _convertToken(node.superKeyword),
      period: _convertToken(node.period),
      name: _convertSimpleIdentifierFromToken(node.name),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: node.parameters != null
          ? _convertFormalParameterList(node.parameters!)
          : null,
    );
  }

  SArgumentList _convertArgumentList(a.ArgumentList node) {
    return SArgumentList(
      leftParenthesis: _convertToken(node.leftParenthesis),
      arguments: node.arguments.map(_convertExpression).toList(),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  // ===== Types =====

  STypeAnnotation _convertTypeAnnotation(a.TypeAnnotation node) {
    return switch (node) {
      a.NamedType n => _convertNamedType(n),
      a.GenericFunctionType n => _convertGenericFunctionType(n),
      a.RecordTypeAnnotation n => _convertRecordTypeAnnotation(n),
    };
  }

  SNamedType _convertNamedType(a.NamedType node) {
    return SNamedType(
      importPrefix:
          node.importPrefix != null ? _convertSimpleIdentifierFromToken(node.importPrefix!.name) : null,
      period:
          node.importPrefix != null ? _convertToken(node.importPrefix!.period) : null,
      name2: _convertSimpleIdentifierFromToken(node.name2),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      question: _convertTokenOrNull(node.question),
    );
  }

  SGenericFunctionType _convertGenericFunctionType(a.GenericFunctionType node) {
    return SGenericFunctionType(
      returnType:
          node.returnType != null ? _convertTypeAnnotation(node.returnType!) : null,
      functionKeyword: _convertToken(node.functionKeyword),
      typeParameters: node.typeParameters != null
          ? _convertTypeParameterList(node.typeParameters!)
          : null,
      parameters: _convertFormalParameterList(node.parameters),
      question: _convertTokenOrNull(node.question),
    );
  }

  SRecordTypeAnnotation _convertRecordTypeAnnotation(
      a.RecordTypeAnnotation node) {
    return SRecordTypeAnnotation(
      leftParenthesis: _convertToken(node.leftParenthesis),
      positionalFields:
          node.positionalFields.map(_convertRecordTypeAnnotationField).toList(),
      namedFields: node.namedFields != null
          ? _convertRecordTypeAnnotationNamedFields(node.namedFields!)
          : null,
      rightParenthesis: _convertToken(node.rightParenthesis),
      question: _convertTokenOrNull(node.question),
    );
  }

  SRecordTypeAnnotationPositionalField _convertRecordTypeAnnotationField(
      a.RecordTypeAnnotationPositionalField node) {
    return SRecordTypeAnnotationPositionalField(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      type: _convertTypeAnnotation(node.type),
      name: node.name != null
          ? _convertSimpleIdentifierFromToken(node.name!)
          : null,
    );
  }

  SRecordTypeAnnotationNamedFields _convertRecordTypeAnnotationNamedFields(
      a.RecordTypeAnnotationNamedFields node) {
    return SRecordTypeAnnotationNamedFields(
      leftBrace: _convertToken(node.leftBracket),
      fields: node.fields.map(_convertRecordTypeAnnotationNamedField).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SRecordTypeAnnotationNamedField _convertRecordTypeAnnotationNamedField(
      a.RecordTypeAnnotationNamedField node) {
    return SRecordTypeAnnotationNamedField(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      type: _convertTypeAnnotation(node.type),
      name: _convertSimpleIdentifierFromToken(node.name),
    );
  }

  STypeArgumentList _convertTypeArgumentList(a.TypeArgumentList node) {
    return STypeArgumentList(
      leftBracket: _convertToken(node.leftBracket),
      arguments: node.arguments.map(_convertTypeAnnotation).toList(),
      rightBracket: _convertToken(node.rightBracket),
    );
  }

  STypeParameterList _convertTypeParameterList(a.TypeParameterList node) {
    return STypeParameterList(
      leftBracket: _convertToken(node.leftBracket),
      typeParameters: node.typeParameters.map(_convertTypeParameter).toList(),
      rightBracket: _convertToken(node.rightBracket),
    );
  }

  STypeParameter _convertTypeParameter(a.TypeParameter node) {
    return STypeParameter(
      metadata: node.metadata.map(_convertAnnotation).toList(),
      name: _convertSimpleIdentifierFromToken(node.name),
      extendsKeyword: _convertTokenOrNull(node.extendsKeyword),
      bound: node.bound != null ? _convertTypeAnnotation(node.bound!) : null,
    );
  }

  // ===== Clauses =====

  SExtendsClause _convertExtendsClause(a.ExtendsClause node) {
    return SExtendsClause(
      extendsKeyword: _convertToken(node.extendsKeyword),
      superclass: _convertNamedType(node.superclass),
    );
  }

  SWithClause _convertWithClause(a.WithClause node) {
    return SWithClause(
      withKeyword: _convertToken(node.withKeyword),
      mixinTypes: node.mixinTypes.map(_convertNamedType).toList(),
    );
  }

  SImplementsClause _convertImplementsClause(a.ImplementsClause node) {
    return SImplementsClause(
      implementsKeyword: _convertToken(node.implementsKeyword),
      interfaces: node.interfaces.map(_convertNamedType).toList(),
    );
  }

  SOnClause _convertOnClause(a.MixinOnClause node) {
    return SOnClause(
      onKeyword: _convertToken(node.onKeyword),
      superclassConstraints:
          node.superclassConstraints.map(_convertNamedType).toList(),
    );
  }

  // ===== Patterns =====

  SDartPattern _convertPattern(a.DartPattern node) {
    return switch (node) {
      a.WildcardPattern n => _convertWildcardPattern(n),
      a.ConstantPattern n => _convertConstantPattern(n),
      // AssignedVariablePattern before VariablePattern (subtype ordering)
      a.AssignedVariablePattern n => _convertAssignedVariablePattern(n),
      a.VariablePattern n => _convertVariablePattern(n),
      a.ListPattern n => _convertListPattern(n),
      a.MapPattern n => _convertMapPattern(n),
      a.RecordPattern n => _convertRecordPattern(n),
      a.ObjectPattern n => _convertObjectPattern(n),
      a.ParenthesizedPattern n => _convertParenthesizedPattern(n),
      a.LogicalAndPattern n => _convertLogicalAndPattern(n),
      a.LogicalOrPattern n => _convertLogicalOrPattern(n),
      a.CastPattern n => _convertCastPattern(n),
      a.NullCheckPattern n => _convertNullCheckPattern(n),
      a.NullAssertPattern n => _convertNullAssertPattern(n),
      a.RelationalPattern n => _convertRelationalPattern(n),
    };
  }

  SWildcardPattern _convertWildcardPattern(a.WildcardPattern node) {
    return SWildcardPattern(
      keyword: _convertTokenOrNull(node.keyword),
      type: node.type != null ? _convertTypeAnnotation(node.type!) : null,
      name: _convertToken(node.name),
    );
  }

  SConstantPattern _convertConstantPattern(a.ConstantPattern node) {
    return SConstantPattern(
      constKeyword: _convertTokenOrNull(node.constKeyword),
      expression: _convertExpression(node.expression),
    );
  }

  SVariablePattern _convertVariablePattern(a.VariablePattern node) {
    // Check if it's a DeclaredVariablePattern (has keyword and type)
    final keyword = node is a.DeclaredVariablePattern ? node.keyword : null;
    final type = node is a.DeclaredVariablePattern ? node.type : null;
    return SVariablePattern(
      keyword: keyword != null ? _convertToken(keyword) : null,
      type: type != null ? _convertTypeAnnotation(type) : null,
      name: _convertSimpleIdentifierFromToken(node.name),
    );
  }

  SAssignedVariablePattern _convertAssignedVariablePattern(
      a.AssignedVariablePattern node) {
    return SAssignedVariablePattern(
      name: _convertSimpleIdentifierFromToken(node.name),
    );
  }

  SListPattern _convertListPattern(a.ListPattern node) {
    return SListPattern(
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      leftBracket: _convertToken(node.leftBracket),
      elements: node.elements.map(_convertListPatternElement).toList(),
      rightBracket: _convertToken(node.rightBracket),
    );
  }

  SListPatternElement _convertListPatternElement(a.ListPatternElement node) {
    return switch (node) {
      a.DartPattern n => SPatternElement(pattern: _convertPattern(n)),
      a.RestPatternElement n => SRestPatternElement(
          operator: _convertToken(n.operator),
          pattern: n.pattern != null ? _convertPattern(n.pattern!) : null,
        ),
      _ => throw UnsupportedError(
          'Unsupported list pattern element: ${node.runtimeType}'),
    };
  }

  SMapPattern _convertMapPattern(a.MapPattern node) {
    return SMapPattern(
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      leftBrace: _convertToken(node.leftBracket),
      elements: node.elements.map(_convertMapPatternEntry).toList(),
      rightBrace: _convertToken(node.rightBracket),
    );
  }

  SMapPatternEntry _convertMapPatternEntry(a.MapPatternElement node) {
    return switch (node) {
      a.MapPatternEntry n => SMapPatternKeyValue(
          key: _convertExpression(n.key),
          separator: _convertToken(n.separator),
          value: _convertPattern(n.value),
        ),
      a.RestPatternElement n => SMapPatternRest(
          operator: _convertToken(n.operator),
        ),
    };
  }

  SRecordPattern _convertRecordPattern(a.RecordPattern node) {
    return SRecordPattern(
      leftParenthesis: _convertToken(node.leftParenthesis),
      fields: node.fields.map(_convertPatternField).toList(),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SPatternField _convertPatternField(a.PatternField node) {
    return SPatternField(
      name: node.name != null ? _convertPatternFieldName(node.name!) : null,
      pattern: _convertPattern(node.pattern),
    );
  }

  SPatternFieldName _convertPatternFieldName(a.PatternFieldName node) {
    return SPatternFieldName(
      name: node.name != null
          ? _convertSimpleIdentifierFromToken(node.name!)
          : null,
      colon: _convertToken(node.colon),
    );
  }

  SObjectPattern _convertObjectPattern(a.ObjectPattern node) {
    return SObjectPattern(
      type: _convertNamedType(node.type),
      leftParenthesis: _convertToken(node.leftParenthesis),
      fields: node.fields.map(_convertPatternField).toList(),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SParenthesizedPattern _convertParenthesizedPattern(
      a.ParenthesizedPattern node) {
    return SParenthesizedPattern(
      leftParenthesis: _convertToken(node.leftParenthesis),
      pattern: _convertPattern(node.pattern),
      rightParenthesis: _convertToken(node.rightParenthesis),
    );
  }

  SLogicalAndPattern _convertLogicalAndPattern(a.LogicalAndPattern node) {
    return SLogicalAndPattern(
      leftOperand: _convertPattern(node.leftOperand),
      operator: _convertToken(node.operator),
      rightOperand: _convertPattern(node.rightOperand),
    );
  }

  SLogicalOrPattern _convertLogicalOrPattern(a.LogicalOrPattern node) {
    return SLogicalOrPattern(
      leftOperand: _convertPattern(node.leftOperand),
      operator: _convertToken(node.operator),
      rightOperand: _convertPattern(node.rightOperand),
    );
  }

  SCastPattern _convertCastPattern(a.CastPattern node) {
    return SCastPattern(
      pattern: _convertPattern(node.pattern),
      asToken: _convertToken(node.asToken),
      type: _convertTypeAnnotation(node.type),
    );
  }

  SNullCheckPattern _convertNullCheckPattern(a.NullCheckPattern node) {
    return SNullCheckPattern(
      pattern: _convertPattern(node.pattern),
      operator: _convertToken(node.operator),
    );
  }

  SNullAssertPattern _convertNullAssertPattern(a.NullAssertPattern node) {
    return SNullAssertPattern(
      pattern: _convertPattern(node.pattern),
      operator: _convertToken(node.operator),
    );
  }

  SRelationalPattern _convertRelationalPattern(a.RelationalPattern node) {
    return SRelationalPattern(
      operator: _convertToken(node.operator),
      operand: _convertExpression(node.operand),
    );
  }

  // ===== Annotations =====

  SAnnotation _convertAnnotation(a.Annotation node) {
    return SAnnotation(
      atSign: _convertToken(node.atSign),
      name: _convertIdentifier(node.name),
      typeArguments: node.typeArguments != null
          ? _convertTypeArgumentList(node.typeArguments!)
          : null,
      constructorName: node.constructorName != null
          ? _convertSimpleIdentifier(node.constructorName!)
          : null,
      arguments:
          node.arguments != null ? _convertArgumentList(node.arguments!) : null,
    );
  }

  SIdentifier _convertIdentifier(a.Identifier node) {
    return switch (node) {
      a.SimpleIdentifier n => _convertSimpleIdentifier(n),
      a.PrefixedIdentifier n => _convertPrefixedIdentifier(n),
      _ => throw UnsupportedError(
          'Unsupported identifier: ${node.runtimeType}'),
    };
  }
}
