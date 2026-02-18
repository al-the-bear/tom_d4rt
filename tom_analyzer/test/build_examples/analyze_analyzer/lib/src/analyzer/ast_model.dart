// Generated AST model stub classes
// Contains the public API model from the analyzer package
// ignore_for_file: unused_element, unused_field, annotate_overrides
// ignore_for_file: constant_identifier_names, unused_element_parameter
// ignore_for_file: non_constant_identifier_names, dangling_library_doc_comments
// ignore_for_file: one_member_abstracts
// ignore_for_file: invalid_override, inconsistent_inheritance
// ignore_for_file: duplicate_definition

import '_stub_types.dart';

/// Two or more string literals that are implicitly concatenated because of
/// being adjacent (separated only by whitespace).
///
/// For example
/// ```dart
/// 'Hello ' 'World'
/// ```
///
/// While the grammar only allows adjacent strings where all of the strings are
/// of the same kind (single line or multi-line), this class doesn't enforce
/// that restriction.
///
///    adjacentStrings ::=
///        [StringLiteral] [StringLiteral]+

abstract class AdjacentStrings implements StringLiteral {
  NodeList get strings;

}


/// The result of performing some kind of analysis on a single file. Every
/// result that implements this interface will also implement a sub-interface.
///
/// Clients may not extend, implement or mix-in this class.

abstract class AnalysisResult {
  AnalysisSession get session;

}


/// An analysis result that includes the diagnostics computed during analysis.
///
/// Clients may not extend, implement or mix-in this class.

abstract class AnalysisResultWithDiagnostics implements FileResult {
  List get diagnostics;

}


/// An AST node that can be annotated with either a documentation comment, a
/// list of annotations (metadata), or both.

abstract class AnnotatedNode implements AstNode {
  Comment get documentationComment;
  Token get firstTokenAfterCommentAndMetadata;
  NodeList get metadata;
  List get sortedCommentAndAnnotations;

}


abstract class AnnotatedNodeImpl extends AstNodeImpl implements AnnotatedNode {
  Token get beginToken;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// An annotation that can be associated with a declaration.
///
/// For example
/// ```dart
/// @override
/// ```
///
/// or
/// ```dart
/// @Deprecated('1.3.2')
/// ```
///
///    metadata ::=
///        annotation*
///
///    annotation ::=
///        '@' metadatum
///
///    metadatum ::=
///        [Identifier]
///      | qualifiedName
///      | constructorDesignation argumentPart

abstract class Annotation implements AstNode {
  ArgumentList get arguments;
  Token get atSign;
  SimpleIdentifier get constructorName;
  Element get element;
  ElementAnnotation get elementAnnotation;
  Identifier get name;
  AstNode get parent;
  Token get period;
  TypeArgumentList get typeArguments;

}


/// A list of arguments in the invocation of an executable element (that is, a
/// function, method, or constructor).
///
///    argumentList ::=
///        '(' arguments? ')'
///
///    arguments ::=
///        [NamedExpression] (',' [NamedExpression])*
///      | [Expression] (',' [Expression])* (',' [NamedExpression])*

abstract class ArgumentList implements AstNode {
  NodeList get arguments;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


/// An as expression.
///
///    asExpression ::=
///        [Expression] 'as' [TypeAnnotation]

abstract class AsExpression implements Expression {
  Token get asOperator;
  Expression get expression;
  TypeAnnotation get type;

}


/// An assert in the initializer list of a constructor.
///
///    assertInitializer ::=
///        'assert' '(' [Expression] (',' [Expression])? ')'

abstract class AssertInitializer implements Assertion, ConstructorInitializer {
}


/// An assert statement.
///
///    assertStatement ::=
///        'assert' '(' [Expression] (',' [Expression])? ')' ';'

abstract class AssertStatement implements Assertion, Statement {
  Token get semicolon;

}


/// An assertion, either in a block or in the initializer list of a constructor.
abstract class Assertion implements AstNode {
  Token get assertKeyword;
  Token get comma;
  Expression get condition;
  Token get leftParenthesis;
  Expression get message;
  Token get rightParenthesis;

}


/// A variable pattern in [PatternAssignment].
///
///    variablePattern ::= identifier

abstract class AssignedVariablePattern implements VariablePattern {
  Element get element;

}


/// An assignment expression.
///
///    assignmentExpression ::=
///        [Expression] operator [Expression]

abstract class AssignmentExpression implements MethodReferenceExpression, CompoundAssignmentExpression {
  Expression get leftHandSide;
  Token get operator;
  Expression get rightHandSide;

}


/// A node in the AST structure for a Dart program.
abstract class AstNode implements SyntacticEntity {
  Token get beginToken;
  Iterable get childEntities;
  int get end;
  Token get endToken;
  bool get isSynthetic;
  int get length;
  int get offset;
  AstNode get parent;
  AstNode get root;

  Token findPrevious(Token target);
  String toSource();
  String toString();
  void visitChildren(AstVisitor visitor);
}


abstract class AstNodeImpl implements AstNode {
  AstNode get _parent;
  Iterable get childEntities;
  int get end;
  bool get isSynthetic;
  int get length;
  Iterable get namedChildEntities;
  int get offset;
  AstNode get parent;
  AstNode get root;
  ChildEntities get _childEntities;

  void detachFromParent();
  Token findPrevious(Token target);
  String toSource();
  String toString();
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
  bool _containsOffset(int rangeOffset, int rangeEnd);
}


/// An object that can be used to visit an AST structure.
///
/// Clients may not extend, implement or mix-in this class. There are classes
/// that implement this interface that provide useful default behaviors in
/// `package:analyzer/dart/ast/visitor.dart`. A couple of the most useful
/// include
/// - SimpleAstVisitor which implements every visit method by doing nothing,
/// - RecursiveAstVisitor which causes every node in a structure to be visited,
///   and
/// - ThrowingAstVisitor which implements every visit method by throwing an
///   exception.

abstract class AstVisitor<R> {
}


/// An await expression.
///
///    awaitExpression ::=
///        'await' [Expression]

abstract class AwaitExpression implements Expression {
  Token get awaitKeyword;
  Expression get expression;

}


/// A binary (infix) expression.
///
///    binaryExpression ::=
///        [Expression] [Token] [Expression]

abstract class BinaryExpression implements Expression, MethodReferenceExpression {
  Expression get leftOperand;
  Token get operator;
  Expression get rightOperand;
  FunctionType get staticInvokeType;

}


/// A pattern variable that is explicitly declared.
///
/// Clients may not extend, implement or mix-in this class.

abstract class BindPatternVariableElement implements PatternVariableElement {
  BindPatternVariableFragment get firstFragment;
  List get fragments;

}


/// The portion of a [BindPatternVariableElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class BindPatternVariableFragment implements PatternVariableFragment {
  BindPatternVariableElement get element;
  BindPatternVariableFragment? get nextFragment;
  BindPatternVariableFragment? get previousFragment;

}


/// A sequence of statements.
///
///    block ::=
///        '{' statement* '}'

abstract class Block implements Statement {
  Token get leftBracket;
  Token get rightBracket;
  NodeList get statements;

}


/// The class body with members.
abstract class BlockClassBody implements ClassBody {
  Token get leftBracket;
  NodeList get members;
  Token get rightBracket;

}


/// A function body that consists of a block of statements.
///
///    blockFunctionBody ::=
///        ('async' | 'async' '*' | 'sync' '*')? [Block]

abstract class BlockFunctionBody implements FunctionBody {
  Block get block;

}


/// A boolean literal expression.
///
///    booleanLiteral ::=
///        'false' | 'true'

abstract class BooleanLiteral implements Literal {
  Token get literal;
  bool get value;

}


/// A break statement.
///
///    breakStatement ::=
///        'break' [SimpleIdentifier]? ';'

abstract class BreakStatement implements Statement {
  Token get breakKeyword;
  SimpleIdentifier get label;
  Token get semicolon;
  AstNode get target;

}


/// A sequence of cascaded expressions: expressions that share a common target.
///
/// There are three kinds of expressions that can be used in a cascade
/// expression: [IndexExpression], [MethodInvocation] and [PropertyAccess].
///
///    cascadeExpression ::=
///        [Expression] cascadeSection*
///
///    cascadeSection ::=
///        ('..' | '?..') (cascadeSelector arguments*)
///        (assignableSelector arguments*)*
///        (assignmentOperator expressionWithoutCascade)?
///
///    cascadeSelector ::=
///        '[ ' expression '] '
///      | identifier

abstract class CascadeExpression implements Expression {
  NodeList get cascadeSections;
  bool get isNullAware;
  Expression get target;

}


/// The `case` clause that can optionally appear in an `if` statement.
///
///    caseClause ::=
///        'case' [GuardedPattern]

abstract class CaseClause implements AstNode {
  Token get caseKeyword;
  GuardedPattern get guardedPattern;

}


abstract class CaseNodeImpl implements AstNode {
  GuardedPatternImpl get guardedPattern;

}


/// A cast pattern.
///
///    castPattern ::=
///        [DartPattern] 'as' [TypeAnnotation]

abstract class CastPattern implements DartPattern {
  Token get asToken;
  DartPattern get pattern;
  TypeAnnotation get type;

}


/// A catch clause within a try statement.
///
///    onPart ::=
///        catchPart [Block]
///      | 'on' type catchPart? [Block]
///
///    catchPart ::=
///        'catch' '(' [CatchClauseParameter] (',' [CatchClauseParameter])? ')'

abstract class CatchClause implements AstNode {
  Block get body;
  Token get catchKeyword;
  Token get comma;
  CatchClauseParameter get exceptionParameter;
  TypeAnnotation get exceptionType;
  Token get leftParenthesis;
  Token get onKeyword;
  Token get rightParenthesis;
  CatchClauseParameter get stackTraceParameter;

}


/// An 'exception' or 'stackTrace' parameter in [CatchClause].
abstract class CatchClauseParameter extends AstNode {
  LocalVariableFragment get declaredFragment;
  Token get name;

}


/// The body of a class declaration.
abstract class ClassBody implements AstNode {
}


abstract class ClassBodyImpl extends AstNodeImpl implements ClassBody {
}


/// The declaration of a class.
///
///    classDeclaration ::=
///        classModifiers 'class' name [TypeParameterList]?
///        [ExtendsClause]? [WithClause]? [ImplementsClause]?
///        '{' [ClassMember]* '}'
///
///    classModifiers ::= 'sealed'
///      | 'abstract'? ('base' | 'interface' | 'final')?
///      | 'abstract'? 'base'? 'mixin'

abstract class ClassDeclaration implements NamedCompilationUnitMember {
  Token get abstractKeyword;
  Token get augmentKeyword;
  Token get baseKeyword;
  ClassBody get body;
  Token get classKeyword;
  ClassFragment get declaredFragment;
  ExtendsClause get extendsClause;
  Token get finalKeyword;
  ImplementsClause get implementsClause;
  Token get interfaceKeyword;
  Token get leftBracket;
  NodeList get members;
  Token get mixinKeyword;
  ClassNamePart get namePart;
  NativeClause get nativeClause;
  Token get rightBracket;
  Token get sealedKeyword;
  TypeParameterList get typeParameters;
  WithClause get withClause;

}


/// A class.
///
/// The class can be defined by either a class declaration (with a class body),
/// or a mixin application (without a class body).
///
/// Clients may not extend, implement or mix-in this class.

abstract class ClassElement implements InterfaceElement {
  ClassFragment get firstFragment;
  List get fragments;
  bool get hasNonFinalField;
  bool get isAbstract;
  bool get isBase;
  bool get isConstructable;
  bool get isDartCoreEnum;
  bool get isDartCoreObject;
  bool get isExhaustive;
  bool get isExtendableOutside;
  bool get isFinal;
  bool get isImplementableOutside;
  bool get isInterface;
  bool get isMixableOutside;
  bool get isMixinApplication;
  bool get isMixinClass;
  bool get isSealed;
  bool get isValidMixin;

}


/// The portion of a [ClassElement] contributed by a single declaration.
///
/// The fragment can be defined by either a class declaration (with a class
/// body), or a mixin application (without a class body).
///
/// Clients may not extend, implement or mix-in this class.

abstract class ClassFragment implements InterfaceFragment {
  ClassElement get element;
  ClassFragment? get nextFragment;
  ClassFragment? get previousFragment;

}


/// A node that declares a name within the scope of a class, enum, extension,
/// extension type, or mixin declaration.

abstract class ClassMember implements Declaration {
}


abstract class ClassMemberImpl extends DeclarationImpl implements ClassMember {
}


/// The name of a class, enum, or extension type declaration.
abstract class ClassNamePart implements AstNode {
  Token get typeName;
  TypeParameterList get typeParameters;

}


abstract class ClassNamePartImpl extends AstNodeImpl implements ClassNamePart {
}


/// A class type alias.
///
///    classTypeAlias ::=
///        classModifiers 'class' [SimpleIdentifier] [TypeParameterList]? '='
///        mixinApplication
///
///    classModifiers ::= 'sealed'
///      | 'abstract'? ('base' | 'interface' | 'final')?
///      | 'abstract'? 'base'? 'mixin'
///
///    mixinApplication ::=
///        [NamedType] [WithClause] [ImplementsClause]? ';'

abstract class ClassTypeAlias implements TypeAlias {
  Token get abstractKeyword;
  Token get baseKeyword;
  ClassFragment get declaredFragment;
  Token get equals;
  Token get finalKeyword;
  ImplementsClause get implementsClause;
  Token get interfaceKeyword;
  Token get mixinKeyword;
  Token get sealedKeyword;
  NamedType get superclass;
  TypeParameterList get typeParameters;
  WithClause get withClause;

}


abstract class CollectionElement implements AstNode {
}


abstract class CollectionElementImpl extends AstNodeImpl implements CollectionElement {
}


/// A combinator associated with an import or export directive.
///
///    combinator ::=
///        [HideCombinator]
///      | [ShowCombinator]

abstract class Combinator implements AstNode {
  Token get keyword;

}


abstract class CombinatorImpl extends AstNodeImpl implements Combinator {
  Token get keyword;
  Token get beginToken;

}


/// A comment within the source code.
///
///    comment ::=
///        endOfLineComment
///      | blockComment
///      | documentationComment
///
///    endOfLineComment ::=
///        '//' (CHARACTER - EOL)* EOL
///
///    blockComment ::=
///        '/ *' CHARACTER* '&#42;/'
///
///    documentationComment ::=
///        '/ **' (CHARACTER | [CommentReference])* '&#42;/'
///      | ('///' (CHARACTER - EOL)* EOL)+

abstract class Comment implements AstNode {
  List get codeBlocks;
  List get docDirectives;
  List get docImports;
  bool get hasNodoc;
  NodeList get references;
  List get tokens;

}


/// An interface for an [Expression] which can make up a [CommentReference].
///
///    commentReferableExpression ::=
///        [ConstructorReference]
///      | [FunctionReference]
///      | [PrefixedIdentifier]
///      | [PropertyAccess]
///      | [SimpleIdentifier]
///      | [TypeLiteral]
///
/// This interface should align closely with dartdoc's notion of
/// comment-referable expressions at:
/// https://github.com/dart-lang/dartdoc/blob/master/lib/src/comment_references/parser.dart

abstract class CommentReferableExpression implements Expression {
}


abstract class CommentReferableExpressionImpl extends ExpressionImpl implements CommentReferableExpression {
}


/// A reference to a Dart element that is found within a documentation comment.
///
///    commentReference ::=
///        '[' 'new'? [CommentReferableExpression] ']'

abstract class CommentReference implements AstNode {
  CommentReferableExpression get expression;
  Token get newKeyword;

}


/// A compilation unit.
///
/// While the grammar restricts the order of the directives and declarations
/// within a compilation unit, this class doesn't enforce those restrictions.
/// In particular, the children of a compilation unit are visited in lexical
/// order even if lexical order doesn't conform to the restrictions of the
/// grammar.
///
///    compilationUnit ::=
///        directives declarations
///
///    directives ::=
///        [ScriptTag]? [LibraryDirective]? namespaceDirective* [PartDirective]*
///      | [PartOfDirective]
///
///    namespaceDirective ::=
///        [ImportDirective]
///      | [ExportDirective]
///
///    declarations ::=
///        [CompilationUnitMember]*

abstract class CompilationUnit implements AstNode {
  Token get beginToken;
  NodeList get declarations;
  LibraryFragment get declaredFragment;
  NodeList get directives;
  Token get endToken;
  FeatureSet get featureSet;
  LibraryLanguageVersion get languageVersion;
  LineInfo get lineInfo;
  ScriptTag get scriptTag;
  List get sortedDirectivesAndDeclarations;

  AstNode nodeCovering({required int offset, int length});
}


/// A node that declares one or more names within the scope of a compilation
/// unit.
///
///    compilationUnitMember ::=
///        [ClassDeclaration]
///      | [MixinDeclaration]
///      | [ExtensionDeclaration]
///      | [EnumDeclaration]
///      | [TypeAlias]
///      | [FunctionDeclaration]
///      | [TopLevelVariableDeclaration]

abstract class CompilationUnitMember implements Declaration {
}


abstract class CompilationUnitMemberImpl extends DeclarationImpl implements CompilationUnitMember {
}


/// A potentially compound assignment.
///
/// A compound assignment is any node in which a single expression is used to
/// specify both where to access a value to be operated on (the "read") and to
/// specify where to store the result of the operation (the "write"). This
/// happens in an [AssignmentExpression] when the assignment operator is a
/// compound assignment operator, and in a [PrefixExpression] or
/// [PostfixExpression] when the operator is an increment operator.

abstract class CompoundAssignmentExpression implements Expression {
  Element get readElement;
  DartType get readType;
  Element get writeElement;
  DartType get writeType;

}


/// A conditional expression.
///
///    conditionalExpression ::=
///        [Expression] '?' [Expression] ':' [Expression]

abstract class ConditionalExpression implements Expression {
  Token get colon;
  Expression get condition;
  Expression get elseExpression;
  Token get question;
  Expression get thenExpression;

}


/// A configuration in either an import or export directive.
///
///    configuration ::=
///        'if' '(' test ')' uri
///
///    test ::=
///        dottedName ('==' stringLiteral)?
///
///    dottedName ::=
///        identifier ('.' identifier)*

abstract class Configuration implements AstNode {
  Token get equalToken;
  Token get ifKeyword;
  Token get leftParenthesis;
  DottedName get name;
  DirectiveUri get resolvedUri;
  Token get rightParenthesis;
  StringLiteral get uri;
  StringLiteral get value;

}


/// A constant expression being used as a pattern.
///
/// The only expressions that can be validly used as a pattern are
/// - `bool` literals
/// - `double` literals
/// - `int` literals
/// - `null` literals
/// - `String` literals
/// - references to constant variables
/// - constant constructor invocations
/// - constant list literals
/// - constant set or map literals
/// - constant expressions wrapped in parentheses and preceded by the `const`
///   keyword
///
/// This node is also used to recover from cases where a different kind of
/// expression is used as a pattern, so clients need to handle the case where
/// the expression isn't one of the valid alternatives.
///
///    constantPattern ::=
///        'const'? [Expression]

abstract class ConstantPattern implements DartPattern {
  Token get constKeyword;
  Expression get expression;

}


/// A constructor declaration.
///
///    constructorDeclaration ::=
///        constructorSignature [FunctionBody]?
///      | constructorName formalParameterList ':' 'this'
///        ('.' [SimpleIdentifier])? arguments
///
///    constructorSignature ::=
///        'external'? constructorName formalParameterList initializerList?
///      | 'external'? 'factory' factoryName formalParameterList
///        initializerList?
///      | 'external'? 'const' constructorName formalParameterList
///        initializerList?
///
///    constructorName ::=
///        [SimpleIdentifier] ('.' name)?
///
///    factoryName ::=
///        [Identifier] ('.' [SimpleIdentifier])?
///
///    initializerList ::=
///        ':' [ConstructorInitializer] (',' [ConstructorInitializer])*

abstract class ConstructorDeclaration implements ClassMember {
  Token get augmentKeyword;
  FunctionBody get body;
  Token get constKeyword;
  ConstructorFragment get declaredFragment;
  Token get externalKeyword;
  Token get factoryKeyword;
  NodeList get initializers;
  Token get name;
  FormalParameterList get parameters;
  Token get period;
  ConstructorName get redirectedConstructor;
  Identifier get returnType;
  Token get separator;

}


/// An element representing a constructor defined by a class, enum, or extension
/// type.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ConstructorElement implements ExecutableElement {
  ConstructorElement get baseElement;
  InterfaceElement get enclosingElement;
  ConstructorFragment get firstFragment;
  List get fragments;
  bool get isConst;
  bool get isDefaultConstructor;
  bool get isFactory;
  bool get isGenerative;
  String get name;
  ConstructorElement get redirectedConstructor;
  InterfaceType get returnType;
  ConstructorElement get superConstructor;

}


/// The initialization of a field within a constructor's initialization list.
///
///    fieldInitializer ::=
///        ('this' '.')? [SimpleIdentifier] '=' [Expression]

abstract class ConstructorFieldInitializer implements ConstructorInitializer {
  Token get equals;
  Expression get expression;
  SimpleIdentifier get fieldName;
  Token get period;
  Token get thisKeyword;

}


/// The portion of a [ConstructorElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ConstructorFragment implements ExecutableFragment {
  ConstructorElement get element;
  InstanceFragment get enclosingFragment;
  String get name;
  ConstructorFragment? get nextFragment;
  int get offset;
  int get periodOffset;
  ConstructorFragment? get previousFragment;
  String get typeName;
  int get typeNameOffset;

}


/// A node that can occur in the initializer list of a constructor declaration.
///
///    constructorInitializer ::=
///        [SuperConstructorInvocation]
///      | [ConstructorFieldInitializer]
///      | [RedirectingConstructorInvocation]

abstract class ConstructorInitializer implements AstNode {
}


abstract class ConstructorInitializerImpl extends AstNodeImpl implements ConstructorInitializer {
}


/// The name of a constructor.
///
///    constructorName ::=
///        type ('.' identifier)?

abstract class ConstructorName implements AstNode, ConstructorReferenceNode {
  SimpleIdentifier get name;
  Token get period;
  NamedType get type;

}


/// An expression representing a reference to a constructor.
///
/// For example, the expression `List.filled` in `var x = List.filled;`.
///
/// Objects of this type aren't produced directly by the parser (because the
/// parser can't tell whether an identifier refers to a type); they are
/// produced at resolution time.

abstract class ConstructorReference implements Expression, CommentReferableExpression {
  ConstructorName get constructorName;

}


/// An AST node that makes reference to a constructor.
abstract class ConstructorReferenceNode implements AstNode {
  ConstructorElement get element;

}


/// The name of a constructor being invoked.
///
///    constructorSelector ::=
///        '.' identifier

abstract class ConstructorSelector implements AstNode {
  SimpleIdentifier get name;
  Token get period;

}


/// A continue statement.
///
///    continueStatement ::=
///        'continue' [SimpleIdentifier]? ';'

abstract class ContinueStatement implements Statement {
  Token get continueKeyword;
  SimpleIdentifier get label;
  Token get semicolon;
  AstNode get target;

}


/// A pattern.
///
///    pattern ::=
///        [AssignedVariablePattern]
///      | [DeclaredVariablePattern]
///      | [CastPattern]
///      | [ConstantPattern]
///      | [ListPattern]
///      | [LogicalAndPattern]
///      | [LogicalOrPattern]
///      | [MapPattern]
///      | [NullAssertPattern]
///      | [NullCheckPattern]
///      | [ObjectPattern]
///      | [ParenthesizedPattern]
///      | [RecordPattern]
///      | [RelationalPattern]

abstract class DartPattern implements AstNode, ListPatternElement {
  DartType get matchedValueType;
  DartPattern get unParenthesized;

}


abstract class DartPatternImpl extends AstNodeImpl implements ListPatternElementImpl, DartPattern {
  AstNodeImpl get patternContext;
  DartPattern get unParenthesized;
  VariablePatternImpl get variablePattern;

}


/// The type associated with elements in the element model.
///
/// Clients may not extend, implement or mix-in this class.

abstract class DartType {
  InstantiatedTypeAliasElement get alias;
  Element get element;
  DartType get extensionTypeErasure;
  bool get isBottom;
  bool get isDartAsyncFuture;
  bool get isDartAsyncFutureOr;
  bool get isDartAsyncStream;
  bool get isDartCoreBool;
  bool get isDartCoreDouble;
  bool get isDartCoreEnum;
  bool get isDartCoreFunction;
  bool get isDartCoreInt;
  bool get isDartCoreIterable;
  bool get isDartCoreList;
  bool get isDartCoreMap;
  bool get isDartCoreNull;
  bool get isDartCoreNum;
  bool get isDartCoreObject;
  bool get isDartCoreRecord;
  bool get isDartCoreSet;
  bool get isDartCoreString;
  bool get isDartCoreSymbol;
  bool get isDartCoreType;
  NullabilitySuffix get nullabilitySuffix;

  InterfaceType asInstanceOf(InterfaceElement element);
  String getDisplayString({bool withNullability});
}


/// A node that represents the declaration of one or more names.
///
/// Each declared name is visible within a name scope.

abstract class Declaration implements AnnotatedNode {
  Fragment get declaredFragment;

}


abstract class DeclarationImpl extends AnnotatedNodeImpl implements Declaration {

}


/// The declaration of a single identifier.
///
///    declaredIdentifier ::=
///        [Annotation] finalConstVarOrType [SimpleIdentifier]

abstract class DeclaredIdentifier implements Declaration {
  LocalVariableFragment get declaredFragment;
  bool get isConst;
  bool get isFinal;
  Token get keyword;
  Token get name;
  TypeAnnotation get type;

}


/// A variable pattern that declares a variable.
///
///    variablePattern ::=
///        ( 'var' | 'final' | 'final'? [TypeAnnotation])? [Identifier]

abstract class DeclaredVariablePattern implements VariablePattern {
  BindPatternVariableFragment get declaredFragment;
  Token get keyword;
  TypeAnnotation get type;

}


/// A formal parameter with a default value.
///
/// There are two kinds of parameters that are both represented by this class:
/// named formal parameters and positional formal parameters.
///
///    defaultFormalParameter ::=
///        [NormalFormalParameter] ('=' [Expression])?
///
///    defaultNamedParameter ::=
///        [NormalFormalParameter] (':' [Expression])?

abstract class DefaultFormalParameter implements FormalParameter {
  Expression get defaultValue;
  NormalFormalParameter get parameter;
  Token get separator;

}


/// A node that represents a directive.
///
///    directive ::=
///        [ExportDirective]
///      | [ImportDirective]
///      | [LibraryDirective]
///      | [PartDirective]
///      | [PartOfDirective]

abstract class Directive implements AnnotatedNode {
}


abstract class DirectiveImpl extends AnnotatedNodeImpl implements Directive {
}


/// Meaning of a URI referenced in a directive.
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUri {
}


/// [DirectiveUriWithSource] that references a [LibraryElement].
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUriWithLibrary extends DirectiveUriWithSource {
  LibraryElement get library;

}


/// [DirectiveUriWithRelativeUriString] that can be parsed into a relative URI.
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUriWithRelativeUri extends DirectiveUriWithRelativeUriString {
  Uri get relativeUri;

}


/// [DirectiveUri] for which we can get its relative URI string.
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUriWithRelativeUriString extends DirectiveUri {
  String get relativeUriString;

}


/// [DirectiveUriWithRelativeUri] that resolves to a [Source].
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUriWithSource extends DirectiveUriWithRelativeUri {
  Source get source;

}


/// [DirectiveUriWithSource] that references a [LibraryFragment].
///
/// Clients may not extend, implement or mix-in this class.

abstract class DirectiveUriWithUnit extends DirectiveUriWithSource {
  LibraryFragment get libraryFragment;

}


/// A do statement.
///
///    doStatement ::=
///        'do' [Statement] 'while' '(' [Expression] ')' ';'

abstract class DoStatement implements Statement {
  Statement get body;
  Expression get condition;
  Token get doKeyword;
  Token get leftParenthesis;
  Token get rightParenthesis;
  Token get semicolon;
  Token get whileKeyword;

}


/// A node that represents a dot shorthand constructor invocation.
///
/// For example, `.fromCharCode(42)`.
///
///    dotShorthandHead ::=
///        '.' [SimpleIdentifier] [TypeArgumentList]? [ArgumentList]

abstract class DotShorthandConstructorInvocation extends InvocationExpression implements ConstructorReferenceNode {
  Token get constKeyword;
  SimpleIdentifier get constructorName;
  bool get isConst;
  Token get period;

}


/// A node that represents a dot shorthand static method or constructor
/// invocation.
///
/// For example, `.parse('42')`.
///
///    dotShorthandHead ::=
///        '.' [SimpleIdentifier] [TypeArgumentList]? [ArgumentList]

abstract class DotShorthandInvocation extends InvocationExpression {
  SimpleIdentifier get memberName;
  Token get period;

}


/// A node that represents a dot shorthand property access of a field or a
/// static getter.
///
/// For example, `.zero`.
///
///    dotShorthandHead ::= '.' [SimpleIdentifier]

abstract class DotShorthandPropertyAccess extends Expression {
  Token get period;
  SimpleIdentifier get propertyName;

}


/// A dotted name, used in a configuration within an import or export directive.
///
///    dottedName ::=
///        [SimpleIdentifier] ('.' [SimpleIdentifier])*

abstract class DottedName implements AstNode {
  NodeList get components;

}


/// A floating point literal expression.
///
///    doubleLiteral ::=
///        decimalDigit+ ('.' decimalDigit*)? exponent?
///      | '.' decimalDigit+ exponent?
///
///    exponent ::=
///        ('e' | 'E') ('+' | '-')? decimalDigit+

abstract class DoubleLiteral implements Literal {
  Token get literal;
  double get value;

}


/// The type `dynamic` is a type which is a supertype of all other types, just
/// like `Object`, with the difference that the static analysis assumes that
/// every member access has a corresponding member with a signature that
/// admits the given access.

abstract class DynamicType implements DartType {
}


/// The base class for all of the elements in the element model.
///
/// Generally speaking, the element model is a semantic model of the program
/// that represents things that are declared with a name and hence can be
/// referenced elsewhere in the code. There are two exceptions to the general
/// case.
///
/// First, there are elements in the element model that are created for the
/// convenience of various kinds of analysis but that don't have any
/// corresponding declaration within the source code. Such elements are marked
/// as being <i>synthetic</i>. Examples of synthetic elements include
/// - default constructors in classes that don't define any explicit
///   constructors,
/// - getters and setters that are induced by explicit field declarations,
/// - fields that are induced by explicit declarations of getters and setters,
///   and
/// - functions representing the initialization expression for a variable.
///
/// Second, there are elements in the element model that don't have, or are not
/// required to have a name. These correspond to things like unnamed functions
/// or extensions. They exist in order to more accurately represent the semantic
/// structure of the program.
///
/// Clients may not extend, implement or mix-in this class.

abstract class Element {
  Element get baseElement;
  List get children;
  String get displayName;
  String get documentationComment;
  Element get enclosingElement;
  Fragment get firstFragment;
  List get fragments;
  int get id;
  bool get isPrivate;
  bool get isPublic;
  bool get isSynthetic;
  ElementKind get kind;
  LibraryElement get library;
  String get lookupName;
  Metadata get metadata;
  String get name;
  Element get nonSynthetic;
  AnalysisSession get session;

  String displayString({bool multiline, bool preferTypeAlias});
  String getExtendedDisplayName({String shortName});
  bool isAccessibleIn(LibraryElement library);
  bool isDeprecatedWithKind(String kind);
  void visitChildren<T>(ElementVisitor2 visitor);
}


/// A single annotation associated with an element.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ElementAnnotation {
  List get constantEvaluationErrors;
  String get deprecationKind;
  Element get element;
  bool get isAlwaysThrows;
  bool get isAwaitNotRequired;
  bool get isDeprecated;
  bool get isDoNotStore;
  bool get isDoNotSubmit;
  bool get isExperimental;
  bool get isFactory;
  bool get isImmutable;
  bool get isInternal;
  bool get isIsTest;
  bool get isIsTestGroup;
  bool get isJS;
  bool get isLiteral;
  bool get isMustBeConst;
  bool get isMustBeOverridden;
  bool get isMustCallSuper;
  bool get isNonVirtual;
  bool get isOptionalTypeArgs;
  bool get isOverride;
  bool get isProtected;
  bool get isProxy;
  bool get isRedeclare;
  bool get isReopen;
  bool get isRequired;
  bool get isSealed;
  bool get isTarget;
  bool get isUseResult;
  bool get isVisibleForOverriding;
  bool get isVisibleForTemplate;
  bool get isVisibleForTesting;
  bool get isVisibleOutsideTemplate;
  bool get isWidgetFactory;
  LibraryFragment get libraryFragment;

  String toSource();
}


/// A directive within a library fragment.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ElementDirective {
  LibraryFragment get libraryFragment;
  Metadata get metadata;
  DirectiveUri get uri;

}


/// An object that can be used to visit an element structure.
///
/// Clients may not extend, implement or mix-in this class. There are classes
/// that implement this interface that provide useful default behaviors in
/// `package:analyzer/dart/element/visitor.dart`. A couple of the most useful
/// include
/// * SimpleElementVisitor which implements every visit method by doing nothing,
/// * RecursiveElementVisitor which will cause every node in a structure to be
///   visited, and
/// * ThrowingElementVisitor which implements every visit method by throwing an
///   exception.

abstract class ElementVisitor2<R> {
}


/// The empty class body.
abstract class EmptyClassBody implements ClassBody {
  Token get semicolon;

}


/// An empty function body.
///
/// An empty function body can only appear in constructors or abstract methods.
///
///    emptyFunctionBody ::=
///        ';'

abstract class EmptyFunctionBody implements FunctionBody {
  Token get semicolon;

}


/// An empty statement.
///
///    emptyStatement ::=
///        ';'

abstract class EmptyStatement implements Statement {
  Token get semicolon;

}


/// The enum declaration body, with constants and members.
abstract class EnumBody implements ClassBody {
  NodeList get constants;
  Token get leftBracket;
  NodeList get members;
  Token get rightBracket;
  Token get semicolon;

}


/// The arguments part of an enum constant.
///
///    enumConstantArguments ::=
///        [TypeArgumentList]? [ConstructorSelector]? [ArgumentList]

abstract class EnumConstantArguments implements AstNode {
  ArgumentList get argumentList;
  ConstructorSelector get constructorSelector;
  TypeArgumentList get typeArguments;

}


/// The declaration of an enum constant.
abstract class EnumConstantDeclaration implements Declaration {
  EnumConstantArguments get arguments;
  Token get augmentKeyword;
  ConstructorElement get constructorElement;
  FieldFragment get declaredFragment;
  Token get name;

}


/// The declaration of an enumeration.
///
///    enumType ::=
///        metadata 'enum' name [TypeParameterList]?
///        [WithClause]? [ImplementsClause]? '{' [SimpleIdentifier]
///        (',' [SimpleIdentifier])* (';' [ClassMember]+)? '}'

abstract class EnumDeclaration implements NamedCompilationUnitMember {
  Token get augmentKeyword;
  EnumBody get body;
  NodeList get constants;
  EnumFragment get declaredFragment;
  Token get enumKeyword;
  ImplementsClause get implementsClause;
  Token get leftBracket;
  NodeList get members;
  ClassNamePart get namePart;
  Token get rightBracket;
  Token get semicolon;
  TypeParameterList get typeParameters;
  WithClause get withClause;

}


/// An element that represents an enum.
///
/// Clients may not extend, implement or mix-in this class.

abstract class EnumElement implements InterfaceElement {
  List get constants;
  EnumFragment get firstFragment;
  List get fragments;

}


/// The portion of an [EnumElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class EnumFragment implements InterfaceFragment {
  List get constants;
  EnumElement get element;
  EnumFragment? get nextFragment;
  EnumFragment? get previousFragment;

}


/// The result of computing all of the errors contained in a single file, both
/// syntactic and semantic.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ErrorsResult implements SomeErrorsResult, AnalysisResultWithDiagnostics {
}


/// An element representing an executable object, including functions, methods,
/// constructors, getters, and setters.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ExecutableElement implements FunctionTypedElement {
  ExecutableElement get baseElement;
  ExecutableFragment get firstFragment;
  List get fragments;
  bool get hasImplicitReturnType;
  bool get isAbstract;
  bool get isExtensionTypeMember;
  bool get isExternal;
  bool get isStatic;

}


/// The portion of an [ExecutableElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ExecutableFragment implements FunctionTypedFragment {
  ExecutableElement get element;
  bool get isAsynchronous;
  bool get isAugmentation;
  bool get isGenerator;
  bool get isSynchronous;
  bool get isSynthetic;
  LibraryFragment get libraryFragment;
  ExecutableFragment? get nextFragment;
  ExecutableFragment? get previousFragment;

}


/// An export directive.
///
///    exportDirective ::=
///        [Annotation] 'export' [StringLiteral] [Combinator]* ';'

abstract class ExportDirective implements NamespaceDirective {
  Token get exportKeyword;
  LibraryExport get libraryExport;

}


/// A node that represents an expression.
///
///    expression ::=
///        [AssignmentExpression]
///      | [ConditionalExpression] cascadeSection*
///      | [ThrowExpression]

abstract class Expression implements CollectionElement {
  bool get canBeConst;
  FormalParameterElement get correspondingParameter;
  bool get inConstantContext;
  bool get isAssignable;
  Precedence get precedence;
  DartType get staticType;
  Expression get unParenthesized;

  AttemptedConstantEvaluationResult computeConstantValue();
}


/// A function body consisting of a single expression.
///
///    expressionFunctionBody ::=
///        'async'? '=>' [Expression] ';'

abstract class ExpressionFunctionBody implements FunctionBody {
  Expression get expression;
  Token get functionDefinition;
  Token get keyword;
  Token get semicolon;
  Token get star;

}


abstract class ExpressionImpl extends CollectionElementImpl implements Expression {
  bool get canBeConst;
  bool get inConstantContext;
  bool get isAssignable;
  ExpressionImpl get unParenthesized;

  AttemptedConstantEvaluationResult computeConstantValue();
  void setPseudoExpressionStaticType(DartType type);
}


/// An expression used as a statement.
///
///    expressionStatement ::=
///        [Expression]? ';'

abstract class ExpressionStatement implements Statement {
  Expression get expression;
  Token get semicolon;

}


/// The "extends" clause in a class declaration.
///
///    extendsClause ::=
///        'extends' [NamedType]

abstract class ExtendsClause implements AstNode {
  Token get extendsKeyword;
  NamedType get superclass;

}


/// The declaration of an extension of a type.
///
///    extension ::=
///        'extension' [SimpleIdentifier]? [TypeParameterList]?
///        'on' [TypeAnnotation] [ShowClause]? [HideClause]?
///        '{' [ClassMember]* '}'

abstract class ExtensionDeclaration implements CompilationUnitMember {
  Token get augmentKeyword;
  BlockClassBody get body;
  ExtensionFragment get declaredFragment;
  Token get extensionKeyword;
  Token get leftBracket;
  NodeList get members;
  Token get name;
  ExtensionOnClause get onClause;
  Token get rightBracket;
  Token get typeKeyword;
  TypeParameterList get typeParameters;

}


/// An extension.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ExtensionElement implements InstanceElement {
  DartType get extendedType;
  ExtensionFragment get firstFragment;
  List get fragments;

}


/// The portion of an [ExtensionElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class ExtensionFragment implements InstanceFragment {
  ExtensionElement get element;
  ExtensionFragment? get nextFragment;
  int get offset;
  ExtensionFragment? get previousFragment;

}


/// The `on` clause in an extension declaration.
///
///    onClause ::= 'on' [TypeAnnotation]

abstract class ExtensionOnClause implements AstNode {
  TypeAnnotation get extendedType;
  Token get onKeyword;

}


/// An override to force resolution to choose a member from a specific
/// extension.
///
///    extensionOverride ::=
///        [Identifier] [TypeArgumentList]? [ArgumentList]

abstract class ExtensionOverride implements Expression {
  ArgumentList get argumentList;
  ExtensionElement get element;
  DartType get extendedType;
  ImportPrefixReference get importPrefix;
  bool get isNullAware;
  Token get name;
  TypeArgumentList get typeArguments;
  List get typeArgumentTypes;

}


/// The declaration of an extension type.
///
///    <extensionTypeDeclaration> ::=
///        'extension' 'type' 'const'? <typeIdentifier> <typeParameters>?
///        <representationDeclaration> <interfaces>?
///        '{'
///            (<metadata> <extensionTypeMemberDeclaration>)*
///        '}'

abstract class ExtensionTypeDeclaration implements NamedCompilationUnitMember {
  Token get augmentKeyword;
  ClassBody get body;
  Token get constKeyword;
  ExtensionTypeFragment get declaredFragment;
  Token get extensionKeyword;
  ImplementsClause get implementsClause;
  Token get leftBracket;
  NodeList get members;
  ClassNamePart get namePart;
  RepresentationDeclaration get representation;
  Token get rightBracket;
  Token get typeKeyword;
  TypeParameterList get typeParameters;

}


/// An extension type.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ExtensionTypeElement implements InterfaceElement {
  ExtensionTypeFragment get firstFragment;
  List get fragments;
  ConstructorElement get primaryConstructor;
  FieldElement get representation;
  DartType get typeErasure;

}


/// The portion of an [ExtensionTypeElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class ExtensionTypeFragment implements InterfaceFragment {
  ExtensionTypeElement get element;
  ExtensionTypeFragment? get nextFragment;
  ExtensionTypeFragment? get previousFragment;

}


/// The declaration of one or more fields of the same type.
///
///    fieldDeclaration ::=
///        'static' 'const' <type>? <staticFinalDeclarationList>
///      | 'static' 'final' <type>? <staticFinalDeclarationList>
///      | 'static' 'late' 'final' <type>? <initializedIdentifierList>
///      | 'static' 'late'? <varOrType> <initializedIdentifierList>
///      | 'covariant' 'late'? <varOrType> <initializedIdentifierList>
///      | 'late'? 'final' <type>? <initializedIdentifierList>
///      | 'late'? <varOrType> <initializedIdentifierList>
///      | 'external' ('static'? <finalVarOrType> | 'covariant' <varOrType>)
///            <identifierList>
///      | 'abstract' (<finalVarOrType> | 'covariant' <varOrType>)
///            <identifierList>
///
/// (Note: there's no `<fieldDeclaration>` production in the grammar; this is a
/// subset of the grammar production `<declaration>`, which encompasses
/// everything that can appear inside a class declaration except methods).

abstract class FieldDeclaration implements ClassMember {
  Token get abstractKeyword;
  Token get augmentKeyword;
  Token get covariantKeyword;
  Token get externalKeyword;
  VariableDeclarationList get fields;
  bool get isStatic;
  Token get semicolon;
  Token get staticKeyword;

}


/// A field defined within a class, enum, extension, or mixin.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FieldElement implements PropertyInducingElement {
  FieldElement get baseElement;
  InstanceElement get enclosingElement;
  FieldFragment get firstFragment;
  List get fragments;
  bool get isAbstract;
  bool get isCovariant;
  bool get isEnumConstant;
  bool get isExternal;
  bool get isPromotable;

}


/// A field formal parameter.
///
///    fieldFormalParameter ::=
///        ('final' [TypeAnnotation] | 'const' [TypeAnnotation] | 'var' |
///        [TypeAnnotation])?
///        'this' '.' name ([TypeParameterList]? [FormalParameterList])?

abstract class FieldFormalParameter implements NormalFormalParameter {
  FieldFormalParameterFragment get declaredFragment;
  Token get keyword;
  Token get name;
  FormalParameterList get parameters;
  Token get period;
  Token get question;
  Token get thisKeyword;
  TypeAnnotation get type;
  TypeParameterList get typeParameters;

}


/// A field formal parameter defined within a constructor element.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FieldFormalParameterElement implements FormalParameterElement {
  FieldElement get field;
  FieldFormalParameterFragment get firstFragment;
  List get fragments;

}


/// The portion of a [FieldFormalParameterElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class FieldFormalParameterFragment implements FormalParameterFragment {
  FieldFormalParameterElement get element;
  FieldFormalParameterFragment? get nextFragment;
  FieldFormalParameterFragment? get previousFragment;

}


/// The portion of a [FieldElement] contributed by a single declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class FieldFragment implements PropertyInducingFragment {
  FieldElement get element;
  FieldFragment? get nextFragment;
  int get offset;
  FieldFragment? get previousFragment;

}


/// The result of computing some cheap information for a single file, when full
/// parsed file is not required, so [ParsedUnitResult] is not necessary.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FileResult implements SomeFileResult, AnalysisResult {
  String get content;
  bool get isLibrary;
  bool get isPart;
  LineInfo get lineInfo;
  String get path;
  Uri get uri;

}


/// The parts of a for-each loop that control the iteration.
abstract class ForEachParts implements ForLoopParts {
  Token get inKeyword;
  Expression get iterable;

}


abstract class ForEachPartsImpl extends ForLoopPartsImpl implements ForEachParts {
  Token get inKeyword;
  ExpressionImpl get _iterable;
  Token get beginToken;
  Token get endToken;
  ExpressionImpl get iterable;
  ChildEntities get _childEntities;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// The parts of a for-each loop that control the iteration when the loop
/// variable is declared as part of the for loop.
///
///   forLoopParts ::=
///       [DeclaredIdentifier] 'in' [Expression]

abstract class ForEachPartsWithDeclaration implements ForEachParts {
  DeclaredIdentifier get loopVariable;

}


/// The parts of a for-each loop that control the iteration when the loop
/// variable is declared outside of the for loop.
///
///   forLoopParts ::=
///       [SimpleIdentifier] 'in' [Expression]

abstract class ForEachPartsWithIdentifier implements ForEachParts {
  SimpleIdentifier get identifier;

}


/// A for-loop part with a pattern.
///
///    forEachPartsWithPattern ::=
///        ( 'final' | 'var' ) [DartPattern] 'in' [Expression]

abstract class ForEachPartsWithPattern implements ForEachParts {
  Token get keyword;
  NodeList get metadata;
  DartPattern get pattern;

}


/// The basic structure of a for element.
abstract class ForElement implements CollectionElement, ForLoop {
}


/// A for or for-each statement or collection element.
abstract class ForLoop<Body extends AstNode> implements AstNode {
  Token get awaitKeyword;
  Token get forKeyword;
  ForLoopParts get forLoopParts;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


abstract class ForLoopImpl<Body extends AstNode, BodyImpl> implements AstNodeImpl, ForLoop {

}


/// The parts of a for or for-each loop that control the iteration.
///
///   forLoopParts ::=
///       [VariableDeclaration] ';' [Expression]? ';' expressionList?
///     | [Expression]? ';' [Expression]? ';' expressionList?
///     | [DeclaredIdentifier] 'in' [Expression]
///     | [SimpleIdentifier] 'in' [Expression]
///
///   expressionList ::=
///       [Expression] (',' [Expression])*

abstract class ForLoopParts implements AstNode {
  ForLoop get parent;

}


abstract class ForLoopPartsImpl extends AstNodeImpl implements ForLoopParts {
  ForLoopImpl get parent;

}


/// The parts of a for loop that control the iteration.
///
///   forLoopParts ::=
///       [VariableDeclaration] ';' [Expression]? ';' expressionList?
///     | [Expression]? ';' [Expression]? ';' expressionList?

abstract class ForParts implements ForLoopParts {
  Expression get condition;
  Token get leftSeparator;
  Token get rightSeparator;
  NodeList get updaters;

}


abstract class ForPartsImpl extends ForLoopPartsImpl implements ForParts {
  Token get leftSeparator;
  ExpressionImpl get _condition;
  Token get rightSeparator;
  NodeListImpl get _updaters;
  Token get beginToken;
  ExpressionImpl get condition;
  Token get endToken;
  NodeListImpl get updaters;
  ChildEntities get _childEntities;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// The parts of a for loop that control the iteration when there are one or
/// more variable declarations as part of the for loop.
///
///   forLoopParts ::=
///       [VariableDeclarationList] ';' [Expression]? ';' expressionList?

abstract class ForPartsWithDeclarations implements ForParts {
  VariableDeclarationList get variables;

}


/// The parts of a for loop that control the iteration when there are no
/// variable declarations as part of the for loop.
///
///   forLoopParts ::=
///       [Expression]? ';' [Expression]? ';' expressionList?

abstract class ForPartsWithExpression implements ForParts {
  Expression get initialization;

}


/// The parts of a for loop that control the iteration when there's a pattern
/// declaration as part of the for loop.
///
///   forLoopParts ::=
///       [PatternVariableDeclaration] ';' [Expression]? ';' expressionList?

abstract class ForPartsWithPattern implements ForParts {
  PatternVariableDeclaration get variables;

}


/// A for or for-each statement.
///
///    forStatement ::=
///        'for' '(' forLoopParts ')' [Statement]
///
///    forLoopParts ::=
///       [VariableDeclaration] ';' [Expression]? ';' expressionList?
///     | [Expression]? ';' [Expression]? ';' expressionList?
///     | [DeclaredIdentifier] 'in' [Expression]
///     | [SimpleIdentifier] 'in' [Expression]

abstract class ForStatement implements Statement, ForLoop {
}


/// A node representing a parameter to a function.
///
///    formalParameter ::=
///        [NormalFormalParameter]
///      | [DefaultFormalParameter]

abstract class FormalParameter implements AstNode {
  Token get covariantKeyword;
  FormalParameterFragment get declaredFragment;
  bool get isConst;
  bool get isExplicitlyTyped;
  bool get isFinal;
  bool get isNamed;
  bool get isOptional;
  bool get isOptionalNamed;
  bool get isOptionalPositional;
  bool get isPositional;
  bool get isRequired;
  bool get isRequiredNamed;
  bool get isRequiredPositional;
  NodeList get metadata;
  Token get name;
  Token get requiredKeyword;

}


/// A formal parameter defined by an executable element.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FormalParameterElement implements VariableElement, LocalElement {
  FormalParameterElement get baseElement;
  String get defaultValueCode;
  FormalParameterFragment get firstFragment;
  List get formalParameters;
  List get fragments;
  bool get hasDefaultValue;
  bool get isCovariant;
  bool get isInitializingFormal;
  bool get isNamed;
  bool get isOptional;
  bool get isOptionalNamed;
  bool get isOptionalPositional;
  bool get isPositional;
  bool get isRequired;
  bool get isRequiredNamed;
  bool get isRequiredPositional;
  bool get isSuperFormal;
  List get typeParameters;

}


/// The portion of a [FormalParameterElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class FormalParameterFragment implements VariableFragment, LocalFragment {
  FormalParameterElement get element;
  FormalParameterFragment? get nextFragment;
  int get offset;
  FormalParameterFragment? get previousFragment;

}


abstract class FormalParameterImpl extends AstNodeImpl implements FormalParameter {
  bool get isNamed;
  bool get isOptional;
  bool get isOptionalNamed;
  bool get isOptionalPositional;
  bool get isPositional;
  bool get isRequired;
  bool get isRequiredNamed;
  bool get isRequiredPositional;
  NodeList get metadata;

}


/// The formal parameter list of a method declaration, function declaration, or
/// function type alias.
///
/// While the grammar requires all required positional parameters to be first,
/// optionally being followed by either optional positional parameters or named
/// parameters (but not both), this class doesn't enforce those constraints. All
/// parameters are flattened into a single list, which can have any or all kinds
/// of parameters (normal, named, and positional) in any order.
///
///    formalParameterList ::=
///        '(' ')'
///      | '(' normalFormalParameters (',' optionalFormalParameters)? ')'
///      | '(' optionalFormalParameters ')'
///
///    normalFormalParameters ::=
///        [NormalFormalParameter] (',' [NormalFormalParameter])*
///
///    optionalFormalParameters ::=
///        optionalPositionalFormalParameters
///      | namedFormalParameters
///
///    optionalPositionalFormalParameters ::=
///        '[' [DefaultFormalParameter] (',' [DefaultFormalParameter])* ']'
///
///    namedFormalParameters ::=
///        '{' [DefaultFormalParameter] (',' [DefaultFormalParameter])* '}'

abstract class FormalParameterList implements AstNode {
  Token get leftDelimiter;
  Token get leftParenthesis;
  List get parameterFragments;
  NodeList get parameters;
  Token get rightDelimiter;
  Token get rightParenthesis;

}


/// A fragment that wholly or partially defines an element.
///
/// When an element is defined by one or more fragments, those fragments form an
/// augmentation chain. This is represented in the element model as a
/// doubly-linked list.
///
/// In valid code the first fragment is the base declaration and all of the
/// other fragments are augmentations. This can be violated in the element model
/// in the case of invalid code, such as when an augmentation is declared even
/// though there is no base declaration.

abstract class Fragment {
  List get children;
  String get documentationComment;
  Element get element;
  Fragment get enclosingFragment;
  LibraryFragment get libraryFragment;
  Metadata get metadata;
  String get name;
  int get nameOffset;
  Fragment? get nextFragment;
  int get offset;
  Fragment? get previousFragment;

}


/// The declaration of a [Fragment].
abstract class FragmentDeclarationResult {
  Fragment get fragment;
  AstNode get node;
  ParsedUnitResult get parsedUnit;
  ResolvedUnitResult get resolvedUnit;

}


/// A node representing the body of a function or method.
///
///    functionBody ::=
///        [BlockFunctionBody]
///      | [EmptyFunctionBody]
///      | [ExpressionFunctionBody]
///      | [NativeFunctionBody]

abstract class FunctionBody implements AstNode {
  bool get isAsynchronous;
  bool get isGenerator;
  bool get isSynchronous;
  Token get keyword;
  Token get star;

  bool isPotentiallyMutatedInScope(VariableElement variable);
}


abstract class FunctionBodyImpl extends AstNodeImpl implements FunctionBody {
  LocalVariableInfo get localVariableInfo;
  bool get isAsynchronous;
  bool get isGenerator;
  bool get isSynchronous;
  Token get keyword;
  Token get star;

  bool isPotentiallyMutatedInScope(VariableElement variable);
}


/// A function declaration.
///
/// Wrapped in a [FunctionDeclarationStatement] to represent a local function
/// declaration, otherwise a top-level function declaration.
///
///    functionDeclaration ::=
///        'external' functionSignature
///      | functionSignature [FunctionBody]
///
///    functionSignature ::=
///        [Type]? ('get' | 'set')? name [FormalParameterList]

abstract class FunctionDeclaration implements NamedCompilationUnitMember {
  Token get augmentKeyword;
  ExecutableFragment get declaredFragment;
  Token get externalKeyword;
  FunctionExpression get functionExpression;
  bool get isGetter;
  bool get isSetter;
  Token get propertyKeyword;
  TypeAnnotation get returnType;

}


/// A [FunctionDeclaration] used as a statement.
abstract class FunctionDeclarationStatement implements Statement {
  FunctionDeclaration get functionDeclaration;

}


/// A function expression.
///
///    functionExpression ::=
///        [TypeParameterList]? [FormalParameterList] [FunctionBody]

abstract class FunctionExpression implements Expression {
  FunctionBody get body;
  ExecutableFragment get declaredFragment;
  FormalParameterList get parameters;
  TypeParameterList get typeParameters;

}


/// The invocation of a function resulting from evaluating an expression.
///
/// Invocations of methods and other forms of functions are represented by
/// [MethodInvocation] nodes. Invocations of getters and setters are represented
/// by either [PrefixedIdentifier] or [PropertyAccess] nodes.
///
///    functionExpressionInvocation ::=
///        [Expression] [TypeArgumentList]? [ArgumentList]

abstract class FunctionExpressionInvocation implements InvocationExpression {
  ExecutableElement get element;
  Expression get function;

}


/// An expression representing a reference to a function, possibly with type
/// arguments applied to it.
///
/// For example, the expression `print` in `var x = print;`.

abstract class FunctionReference implements Expression, CommentReferableExpression {
  Expression get function;
  TypeArgumentList get typeArguments;
  List get typeArgumentTypes;

}


/// The type of a function, method, constructor, getter, or setter. Function
/// types come in three variations:
///
/// * The types of functions that only have required parameters. These have the
///   general form <i>(T<sub>1</sub>, &hellip;, T<sub>n</sub>) &rarr; T</i>.
/// * The types of functions with optional positional parameters. These have the
///   general form <i>(T<sub>1</sub>, &hellip;, T<sub>n</sub>, [T<sub>n+1</sub>
///   &hellip;, T<sub>n+k</sub>]) &rarr; T</i>.
/// * The types of functions with named parameters. These have the general form
///   <i>(T<sub>1</sub>, &hellip;, T<sub>n</sub>, {T<sub>x1</sub> x1, &hellip;,
///   T<sub>xk</sub> xk}) &rarr; T</i>.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FunctionType implements DartType {
  List get formalParameters;
  Map get namedParameterTypes;
  List get normalParameterTypes;
  List get optionalParameterTypes;
  DartType get returnType;
  List get typeParameters;

  FunctionType instantiate(List argumentTypes);
}


/// A function type alias.
///
///    functionTypeAlias ::=
///        'typedef' functionPrefix [TypeParameterList]?
///        [FormalParameterList] ';'
///
///    functionPrefix ::=
///        [TypeAnnotation]? [SimpleIdentifier]

abstract class FunctionTypeAlias implements TypeAlias {
  TypeAliasFragment get declaredFragment;
  FormalParameterList get parameters;
  TypeAnnotation get returnType;
  TypeParameterList get typeParameters;

}


/// An element that has a [FunctionType] as its [type].
///
/// This also provides convenient access to the parameters and return type.
///
/// Clients may not extend, implement or mix-in this class.

abstract class FunctionTypedElement implements TypeParameterizedElement {
  FunctionTypedFragment get firstFragment;
  List get formalParameters;
  List get fragments;
  DartType get returnType;
  FunctionType get type;

}


/// A function-typed formal parameter.
///
///    functionSignature ::=
///        [TypeAnnotation]? name [TypeParameterList]?
///        [FormalParameterList] '?'?

abstract class FunctionTypedFormalParameter implements NormalFormalParameter {
  Token get name;
  FormalParameterList get parameters;
  Token get question;
  TypeAnnotation get returnType;
  TypeParameterList get typeParameters;

}


/// The portion of a [FunctionTypedElement] contributed by a single declaration.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class FunctionTypedFragment implements TypeParameterizedFragment {
  FunctionTypedElement get element;
  List get formalParameters;
  FunctionTypedFragment? get nextFragment;
  FunctionTypedFragment? get previousFragment;

}


/// An anonymous function type.
///
///    functionType ::=
///        [TypeAnnotation]? 'Function' [TypeParameterList]?
///        [FormalParameterList] '?'?
///
/// where the FormalParameterList is being used to represent the following
/// grammar, despite the fact that FormalParameterList can represent a much
/// larger grammar than the one below. This is done in order to simplify the
/// implementation.
///
///    parameterTypeList ::=
///        () |
///        ( normalParameterTypes ,? ) |
///        ( normalParameterTypes , optionalParameterTypes ) |
///        ( optionalParameterTypes )
///    namedParameterTypes ::=
///        { namedParameterType (, namedParameterType)* ,? }
///    namedParameterType ::=
///        [TypeAnnotation]? [SimpleIdentifier]
///    normalParameterTypes ::=
///        normalParameterType (, normalParameterType)*
///    normalParameterType ::=
///        [TypeAnnotation] [SimpleIdentifier]?
///    optionalParameterTypes ::=
///        optionalPositionalParameterTypes | namedParameterTypes
///    optionalPositionalParameterTypes ::=
///        [ normalParameterTypes ,? ]

abstract class GenericFunctionType implements TypeAnnotation {
  GenericFunctionTypeFragment get declaredFragment;
  Token get functionKeyword;
  FormalParameterList get parameters;
  TypeAnnotation get returnType;
  TypeParameterList get typeParameters;

}


/// The pseudo-declaration that defines a generic function type.
///
/// Clients may not extend, implement, or mix-in this class.

abstract class GenericFunctionTypeElement implements FunctionTypedElement {
  GenericFunctionTypeFragment get firstFragment;
  List get fragments;

}


/// The portion of a [GenericFunctionTypeElement] coming from a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class GenericFunctionTypeFragment implements FunctionTypedFragment {
  GenericFunctionTypeElement get element;
  GenericFunctionTypeFragment? get nextFragment;
  int get offset;
  GenericFunctionTypeFragment? get previousFragment;

}


/// A generic type alias.
///
///    functionTypeAlias ::=
///        'typedef' [SimpleIdentifier] [TypeParameterList]? =
///        [FunctionType] ';'

abstract class GenericTypeAlias implements TypeAlias {
  Token get equals;
  GenericFunctionType get functionType;
  TypeAnnotation get type;
  TypeParameterList get typeParameters;

}


/// A getter.
///
/// Getters can either be defined explicitly or they can be induced by either a
/// top-level variable or a field. Induced getters are synthetic.
///
/// Clients may not extend, implement or mix-in this class.

abstract class GetterElement implements PropertyAccessorElement {
  GetterElement get baseElement;
  SetterElement get correspondingSetter;
  GetterFragment get firstFragment;
  List get fragments;

}


/// The portion of a [GetterElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class GetterFragment implements PropertyAccessorFragment {
  GetterElement get element;
  GetterFragment? get nextFragment;
  int get offset;
  GetterFragment? get previousFragment;

}


/// The pattern with an optional [WhenClause].
///
///    guardedPattern ::=
///        [DartPattern] [WhenClause]?

abstract class GuardedPattern implements AstNode {
  DartPattern get pattern;
  WhenClause get whenClause;

}


/// A combinator that restricts the names being imported to those that aren't
/// in a given list.
///
///    hideCombinator ::=
///        'hide' [SimpleIdentifier] (',' [SimpleIdentifier])*

abstract class HideCombinator implements Combinator {
  NodeList get hiddenNames;

}


/// A combinator that causes some of the names in a namespace to be hidden when
/// being imported.
///
/// Clients may not extend, implement or mix-in this class.

abstract class HideElementCombinator implements NamespaceCombinator {
  List get hiddenNames;

}


/// A node that represents an identifier.
///
///    identifier ::=
///        [SimpleIdentifier]
///      | [PrefixedIdentifier]

abstract class Identifier implements Expression, CommentReferableExpression {
  Element get element;
  String get name;

}


abstract class IdentifierImpl extends CommentReferableExpressionImpl implements Identifier {
  bool get isAssignable;

}


/// The basic structure of an if element.
abstract class IfElement implements CollectionElement {
  CaseClause get caseClause;
  CollectionElement get elseElement;
  Token get elseKeyword;
  Expression get expression;
  Token get ifKeyword;
  Token get leftParenthesis;
  Token get rightParenthesis;
  CollectionElement get thenElement;

}


abstract class IfElementOrStatementImpl<E extends AstNodeImpl> implements AstNodeImpl {
  CaseClauseImpl get caseClause;
  ExpressionImpl get expression;

}


/// An if statement.
///
///    ifStatement ::=
///        'if' '(' [Expression] [CaseClause]? ')'[Statement]
///        ('else' [Statement])?

abstract class IfStatement implements Statement {
  CaseClause get caseClause;
  Token get elseKeyword;
  Statement get elseStatement;
  Expression get expression;
  Token get ifKeyword;
  Token get leftParenthesis;
  Token get rightParenthesis;
  Statement get thenStatement;

}


/// The "implements" clause in an class declaration.
///
///    implementsClause ::=
///        'implements' [NamedType] (',' [NamedType])*

abstract class ImplementsClause implements AstNode {
  Token get implementsKeyword;
  NodeList get interfaces;

}


/// An expression representing an implicit 'call' method reference.
///
/// Objects of this type aren't produced directly by the parser (because the
/// parser can't tell whether an expression refers to a callable type); they
/// are produced at resolution time.

abstract class ImplicitCallReference implements MethodReferenceExpression {
  Expression get expression;
  TypeArgumentList get typeArguments;
  List get typeArgumentTypes;

}


/// An import directive.
///
///    importDirective ::=
///        [Annotation] 'import' [StringLiteral] ('as' identifier)?
///        [Combinator]* ';'
///      | [Annotation] 'import' [StringLiteral] 'deferred' 'as' identifier
///        [Combinator]* ';'

abstract class ImportDirective implements NamespaceDirective {
  Token get asKeyword;
  Token get deferredKeyword;
  Token get importKeyword;
  LibraryImport get libraryImport;
  SimpleIdentifier get prefix;

}


/// Reference to an import prefix name.
abstract class ImportPrefixReference implements AstNode {
  Element get element;
  Token get name;
  Token get period;

}


/// An index expression.
///
///    indexExpression ::=
///        [Expression] '[' [Expression] ']'

abstract class IndexExpression implements MethodReferenceExpression {
  Expression get index;
  bool get isCascaded;
  bool get isNullAware;
  Token get leftBracket;
  Token get period;
  Token get question;
  Expression get realTarget;
  Token get rightBracket;
  Expression get target;

  bool inGetterContext();
  bool inSetterContext();
}


/// An instance creation expression.
///
///    newExpression ::=
///        ('new' | 'const')? [NamedType] ('.' [SimpleIdentifier])?
///        [ArgumentList]

abstract class InstanceCreationExpression implements Expression {
  ArgumentList get argumentList;
  ConstructorName get constructorName;
  bool get isConst;
  Token get keyword;

}


/// An element whose instance members can refer to `this`.
///
/// Clients may not extend, implement or mix-in this class.

abstract class InstanceElement implements TypeParameterizedElement {
  InstanceElement get baseElement;
  LibraryElement get enclosingElement;
  List get fields;
  InstanceFragment get firstFragment;
  List get fragments;
  List get getters;
  List get methods;
  List get setters;
  DartType get thisType;

  FieldElement getField(String name);
  GetterElement getGetter(String name);
  MethodElement getMethod(String name);
  SetterElement getSetter(String name);
  GetterElement lookUpGetter({required String name, required LibraryElement library});
  MethodElement lookUpMethod({required String name, required LibraryElement library});
  SetterElement lookUpSetter({required String name, required LibraryElement library});
}


/// The portion of an [InstanceElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class InstanceFragment implements TypeParameterizedFragment {
  InstanceElement get element;
  LibraryFragment get enclosingFragment;
  List get fields;
  List get getters;
  bool get isAugmentation;
  LibraryFragment get libraryFragment;
  List get methods;
  InstanceFragment? get nextFragment;
  InstanceFragment? get previousFragment;
  List get setters;

}


/// Information about an instantiated [TypeAliasElement] and the type
/// arguments with which it is instantiated.

abstract class InstantiatedTypeAliasElement {
  TypeAliasElement get element;
  List get typeArguments;

}


/// An integer literal expression.
///
///    integerLiteral ::=
///        decimalIntegerLiteral
///      | hexadecimalIntegerLiteral
///
///    decimalIntegerLiteral ::=
///        decimalDigit+
///
///    hexadecimalIntegerLiteral ::=
///        '0x' hexadecimalDigit+
///      | '0X' hexadecimalDigit+

abstract class IntegerLiteral implements Literal {
  Token get literal;
  int get value;

}


/// An element that defines an [InterfaceType].
///
/// Clients may not extend, implement or mix-in this class.

abstract class InterfaceElement implements InstanceElement {
  List get allSupertypes;
  List get constructors;
  InterfaceFragment get firstFragment;
  List get fragments;
  Map get inheritedConcreteMembers;
  Map get inheritedMembers;
  Map get interfaceMembers;
  List get interfaces;
  List get mixins;
  InterfaceType get supertype;
  InterfaceType get thisType;
  ConstructorElement get unnamedConstructor;

  ExecutableElement getInheritedConcreteMember(Name name);
  ExecutableElement getInheritedMember(Name name);
  ExecutableElement getInterfaceMember(Name name);
  ConstructorElement getNamedConstructor(String name);
  List getOverridden(Name name);
  InterfaceType instantiate({required List typeArguments, required NullabilitySuffix nullabilitySuffix});
  MethodElement lookUpConcreteMethod(String methodName, LibraryElement library);
  MethodElement lookUpInheritedMethod({required String methodName, required LibraryElement library});
}


/// The portion of an [InterfaceElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class InterfaceFragment implements InstanceFragment {
  List get constructors;
  InterfaceElement get element;
  InterfaceFragment? get nextFragment;
  InterfaceFragment? get previousFragment;

}


/// The type introduced by either a class or an interface, or a reference to
/// such a type.
///
/// Clients may not extend, implement or mix-in this class.

abstract class InterfaceType implements ParameterizedType {
  List get allSupertypes;
  List get constructors;
  InterfaceElement get element;
  List get getters;
  List get interfaces;
  List get methods;
  List get mixins;
  List get setters;
  InterfaceType get superclass;
  List get superclassConstraints;

  GetterElement getGetter(String name);
  MethodElement getMethod(String name);
  SetterElement getSetter(String name);
  ConstructorElement lookUpConstructor(String name, LibraryElement library);
  GetterElement lookUpGetter(String name, LibraryElement library, {bool concrete, bool inherited, bool recoveryStatic});
  MethodElement lookUpMethod(String name, LibraryElement library, {bool concrete, bool inherited, bool recoveryStatic});
  SetterElement lookUpSetter(String name, LibraryElement library, {bool concrete, bool inherited, bool recoveryStatic});
}


/// A node within a [StringInterpolation].
///
///    interpolationElement ::=
///        [InterpolationExpression]
///      | [InterpolationString]

abstract class InterpolationElement implements AstNode {
}


abstract class InterpolationElementImpl extends AstNodeImpl implements InterpolationElement {
}


/// An expression embedded in a string interpolation.
///
///    interpolationExpression ::=
///        '$' [SimpleIdentifier]
///      | '$' '{' [Expression] '}'

abstract class InterpolationExpression implements InterpolationElement {
  Expression get expression;
  Token get leftBracket;
  Token get rightBracket;

}


/// A non-empty substring of an interpolated string.
///
///    interpolationString ::=
///        characters

abstract class InterpolationString implements InterpolationElement {
  Token get contents;
  int get contentsEnd;
  int get contentsOffset;
  String get value;

}


/// The base class for any invalid result.
///
/// Clients may not extend, implement or mix-in this class.

abstract class InvalidResult {
}


/// The type arising from code with errors, such as invalid type annotations,
/// wrong number of type arguments, invocation of undefined methods, etc.
///
/// Can usually be treated as [DynamicType], but should occasionally be handled
/// differently, e.g. it does not cause follow-on implicit cast errors.

abstract class InvalidType implements DartType {
}


/// The invocation of a function or method.
///
/// This will either be a [FunctionExpressionInvocation], a [MethodInvocation],
/// a [DotShorthandConstructorInvocation], or a [DotShorthandInvocation].

abstract class InvocationExpression implements Expression {
  ArgumentList get argumentList;
  Expression get function;
  DartType get staticInvokeType;
  TypeArgumentList get typeArguments;
  List get typeArgumentTypes;

}


abstract class InvocationExpressionImpl extends ExpressionImpl implements InvocationExpression {
  ArgumentListImpl get _argumentList;
  TypeArgumentListImpl get _typeArguments;
  List get typeArgumentTypes;
  ArgumentListImpl get argumentList;
  TypeArgumentListImpl get typeArguments;

}


/// An is expression.
///
///    isExpression ::=
///        [Expression] 'is' '!'? [TypeAnnotation]

abstract class IsExpression implements Expression {
  Expression get expression;
  Token get isOperator;
  Token get notOperator;
  TypeAnnotation get type;

}


/// A pattern variable that is a join of other pattern variables, created
/// for a logical-or patterns, or shared `case` bodies in `switch` statements.
///
/// Clients may not extend, implement or mix-in this class.

abstract class JoinPatternVariableElement implements PatternVariableElement {
  JoinPatternVariableFragment get firstFragment;
  List get fragments;
  bool get isConsistent;
  List get variables;

}


/// The portion of a [JoinPatternVariableElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class JoinPatternVariableFragment implements PatternVariableFragment {
  JoinPatternVariableElement get element;
  JoinPatternVariableFragment? get nextFragment;
  int get offset;
  JoinPatternVariableFragment? get previousFragment;

}


/// A label on either a [LabeledStatement] or a [NamedExpression].
///
///    label ::=
///        [SimpleIdentifier] ':'

abstract class Label implements AstNode {
  Token get colon;
  LabelFragment get declaredFragment;
  SimpleIdentifier get label;

}


/// A label associated with a statement.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LabelElement implements Element {
  ExecutableElement get enclosingElement;
  LabelFragment get firstFragment;
  List get fragments;
  LibraryElement get library;

}


/// The portion of a [LabelElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LabelFragment implements Fragment {
  LabelElement get element;
  LabelFragment? get nextFragment;
  LabelFragment? get previousFragment;

}


/// A statement that has a label associated with them.
///
///    labeledStatement ::=
///       [Label]+ [Statement]

abstract class LabeledStatement implements Statement {
  NodeList get labels;
  Statement get statement;

}


/// A library directive.
///
///    libraryDirective ::=
///        [Annotation] 'library' [LibraryIdentifier]? ';'

abstract class LibraryDirective implements Directive {
  LibraryElement get element;
  Token get libraryKeyword;
  LibraryIdentifier get name;
  Token get semicolon;

}


/// A library.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LibraryElement implements Element {
  List get classes;
  TopLevelFunctionElement get entryPoint;
  List get enums;
  List get exportedLibraries;
  List get extensions;
  List get extensionTypes;
  FeatureSet get featureSet;
  LibraryFragment get firstFragment;
  List get fragments;
  List get getters;
  String get identifier;
  bool get isDartAsync;
  bool get isDartCore;
  bool get isInSdk;
  LibraryLanguageVersion get languageVersion;
  LibraryElement get library;
  TopLevelFunctionElement get loadLibraryFunction;
  List get mixins;
  AnalysisSession get session;
  List get setters;
  List get topLevelFunctions;
  List get topLevelVariables;
  List get typeAliases;
  TypeProvider get typeProvider;
  Uri get uri;

  ClassElement getClass(String name);
  EnumElement getEnum(String name);
  ExtensionElement getExtension(String name);
  ExtensionTypeElement getExtensionType(String name);
  GetterElement getGetter(String name);
  MixinElement getMixin(String name);
  SetterElement getSetter(String name);
  TopLevelFunctionElement getTopLevelFunction(String name);
  TopLevelVariableElement getTopLevelVariable(String name);
  TypeAliasElement getTypeAlias(String name);
}


/// The result of building the element model for a library.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LibraryElementResult implements SomeLibraryElementResult {
  LibraryElement get element;

}


/// An `export` directive within a library fragment.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LibraryExport implements ElementDirective {
  List get combinators;
  LibraryElement get exportedLibrary;
  int get exportKeywordOffset;

}


/// The portion of a [LibraryElement] coming from a single compilation unit.
abstract class LibraryFragment implements Fragment {
  List get accessibleExtensions;
  List get classes;
  LibraryElement get element;
  LibraryFragment get enclosingFragment;
  List get enums;
  List get extensions;
  List get extensionTypes;
  List get functions;
  List get getters;
  List get importedLibraries;
  List get libraryExports;
  List get libraryImports;
  LineInfo get lineInfo;
  List get mixins;
  LibraryFragment? get nextFragment;
  int get offset;
  List get partIncludes;
  List get prefixes;
  LibraryFragment? get previousFragment;
  List get setters;
  Source get source;
  List get topLevelVariables;
  List get typeAliases;

}


/// The identifier for a library.
///
///    libraryIdentifier ::=
///        [SimpleIdentifier] ('.' [SimpleIdentifier])*

abstract class LibraryIdentifier implements Identifier {
  NodeList get components;

}


/// An `import` directive within a library fragment.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LibraryImport implements ElementDirective {
  List get combinators;
  LibraryElement get importedLibrary;
  int get importKeywordOffset;
  bool get isSynthetic;
  PrefixFragment get prefix;

}


/// A list literal.
///
///    listLiteral ::=
///        'const'? [TypeAnnotationList]? '[' elements? ']'
///
///    elements ::=
///        [CollectionElement] (',' [CollectionElement])* ','?

abstract class ListLiteral implements TypedLiteral {
  NodeList get elements;
  Token get leftBracket;
  Token get rightBracket;

}


/// A list pattern.
///
///    listPattern ::=
///        [TypeArgumentList]? '[' [DartPattern] (',' [DartPattern])* ','? ']'

abstract class ListPattern implements DartPattern {
  NodeList get elements;
  Token get leftBracket;
  DartType get requiredType;
  Token get rightBracket;
  TypeArgumentList get typeArguments;

}


/// An element of a list pattern.
abstract class ListPatternElement implements AstNode {
}


abstract class ListPatternElementImpl implements AstNodeImpl, ListPatternElement {
}


/// A node that represents a literal expression.
///
///    literal ::=
///        [BooleanLiteral]
///      | [DoubleLiteral]
///      | [IntegerLiteral]
///      | [ListLiteral]
///      | [NullLiteral]
///      | [RecordLiteral]
///      | [SetOrMapLiteral]
///      | [StringLiteral]
///      | [SymbolLiteral]
///      | [TypedLiteral]

abstract class Literal implements Expression {
}


abstract class LiteralImpl extends ExpressionImpl implements Literal {
  Precedence get precedence;

}


/// An element that can be (but is not required to be) defined within a method
/// or function (an [ExecutableFragment]).
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalElement implements Element {
}


/// The portion of an [LocalElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalFragment implements Fragment {
}


/// A local function.
///
/// This can be either a local function, a closure, or the initialization
/// expression for a field or variable.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalFunctionElement implements ExecutableElement, LocalElement {
  LocalFunctionFragment get firstFragment;
  List get fragments;

}


/// The portion of a [LocalFunctionElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalFunctionFragment implements ExecutableFragment, LocalFragment {
  LocalFunctionElement get element;
  LocalFunctionFragment? get nextFragment;
  int get offset;
  LocalFunctionFragment? get previousFragment;

}


/// A local variable.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalVariableElement implements VariableElement, LocalElement {
  LocalVariableElement get baseElement;
  LocalVariableFragment get firstFragment;
  List get fragments;

}


/// The portion of a [LocalVariableElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class LocalVariableFragment implements VariableFragment, LocalFragment {
  LocalVariableElement get element;
  LocalVariableFragment? get nextFragment;
  LocalVariableFragment? get previousFragment;

}


/// A logical-and pattern.
///
///    logicalAndPattern ::=
///        [DartPattern] '&&' [DartPattern]

abstract class LogicalAndPattern implements DartPattern {
  DartPattern get leftOperand;
  Token get operator;
  DartPattern get rightOperand;

}


/// A logical-or pattern.
///
///    logicalOrPattern ::=
///        [DartPattern] '||' [DartPattern]

abstract class LogicalOrPattern implements DartPattern {
  DartPattern get leftOperand;
  Token get operator;
  DartPattern get rightOperand;

}


/// A single key/value pair in a map literal.
///
///    mapLiteralEntry ::=
///        '?'? [Expression] ':' '?'? [Expression]

abstract class MapLiteralEntry implements CollectionElement {
  Expression get key;
  Token get keyQuestion;
  Token get separator;
  Expression get value;
  Token get valueQuestion;

}


/// A map pattern.
///
///    mapPattern ::=
///        [TypeArgumentList]? '{' [MapPatternEntry] (',' [MapPatternEntry])*
///        ','? '}'

abstract class MapPattern implements DartPattern {
  NodeList get elements;
  Token get leftBracket;
  DartType get requiredType;
  Token get rightBracket;
  TypeArgumentList get typeArguments;

}


/// An element of a map pattern.
abstract class MapPatternElement implements AstNode {
}


abstract class MapPatternElementImpl implements AstNodeImpl, MapPatternElement {
}


/// An entry in a map pattern.
///
///    mapPatternEntry ::=
///        [Expression] ':' [DartPattern]

abstract class MapPatternEntry implements AstNode, MapPatternElement {
  Expression get key;
  Token get separator;
  DartPattern get value;

}


/// The metadata (annotations) associated with an element or fragment.
abstract class Metadata {
  List get annotations;
  bool get hasAlwaysThrows;
  bool get hasAwaitNotRequired;
  bool get hasDeprecated;
  bool get hasDoNotStore;
  bool get hasDoNotSubmit;
  bool get hasExperimental;
  bool get hasFactory;
  bool get hasImmutable;
  bool get hasInternal;
  bool get hasIsTest;
  bool get hasIsTestGroup;
  bool get hasJS;
  bool get hasLiteral;
  bool get hasMustBeConst;
  bool get hasMustBeOverridden;
  bool get hasMustCallSuper;
  bool get hasNonVirtual;
  bool get hasOptionalTypeArgs;
  bool get hasOverride;
  bool get hasProtected;
  bool get hasRedeclare;
  bool get hasReopen;
  bool get hasRequired;
  bool get hasSealed;
  bool get hasUseResult;
  bool get hasVisibleForOverriding;
  bool get hasVisibleForTemplate;
  bool get hasVisibleForTesting;
  bool get hasVisibleOutsideTemplate;
  bool get hasWidgetFactory;

}


/// A method declaration.
///
///    methodDeclaration ::=
///        methodSignature [FunctionBody]
///
///    methodSignature ::=
///        'external'? ('abstract' | 'static')? [Type]? ('get' | 'set')?
///        methodName [TypeParameterList] [FormalParameterList]
///
///    methodName ::=
///        [SimpleIdentifier]
///      | 'operator' [SimpleIdentifier]
///
/// Prior to the 'extension-methods' experiment, these nodes were always
/// children of a class declaration. When the experiment is enabled, these nodes
/// can also be children of an extension declaration.

abstract class MethodDeclaration implements ClassMember {
  Token get augmentKeyword;
  FunctionBody get body;
  ExecutableFragment get declaredFragment;
  Token get externalKeyword;
  bool get isAbstract;
  bool get isGetter;
  bool get isOperator;
  bool get isSetter;
  bool get isStatic;
  Token get modifierKeyword;
  Token get name;
  Token get operatorKeyword;
  FormalParameterList get parameters;
  Token get propertyKeyword;
  TypeAnnotation get returnType;
  TypeParameterList get typeParameters;

}


/// A method.
///
/// The method can be either an instance method, an operator, or a static
/// method.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MethodElement implements ExecutableElement {
  MethodElement get baseElement;
  MethodFragment get firstFragment;
  List get fragments;
  bool get isOperator;

}


/// The portion of a [MethodElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MethodFragment implements ExecutableFragment {
  MethodElement get element;
  InstanceFragment get enclosingFragment;
  MethodFragment? get nextFragment;
  MethodFragment? get previousFragment;

}


/// The invocation of either a function or a method.
///
/// Invocations of functions resulting from evaluating an expression are
/// represented by [FunctionExpressionInvocation] nodes. Invocations of getters
/// and setters are represented by either [PrefixedIdentifier] or
/// [PropertyAccess] nodes.
///
///    methodInvocation ::=
///        ([Expression] '.')? [SimpleIdentifier] [TypeArgumentList]?
///        [ArgumentList]

abstract class MethodInvocation implements InvocationExpression {
  bool get isCascaded;
  bool get isNullAware;
  SimpleIdentifier get methodName;
  Token get operator;
  Expression get realTarget;
  Expression get target;

}


/// An expression that implicitly makes reference to a method.
abstract class MethodReferenceExpression implements Expression {
  MethodElement get element;

}


/// The type of [InvalidResult] returned when Dart SDK does not have a
/// required library, e.g. `dart:core` or `dart:async`.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MissingSdkLibraryResult implements InvalidResult, SomeErrorsResult, SomeResolvedLibraryResult, SomeResolvedUnitResult, SomeLibraryElementResult, SomeUnitElementResult {
  Uri get missingUri;

}


/// The declaration of a mixin.
///
///    mixinDeclaration ::=
///        'base'? 'mixin' name [TypeParameterList]?
///        [OnClause]? [ImplementsClause]? '{' [ClassMember]* '}'

abstract class MixinDeclaration implements NamedCompilationUnitMember {
  Token get augmentKeyword;
  Token get baseKeyword;
  ClassBody get body;
  MixinFragment get declaredFragment;
  ImplementsClause get implementsClause;
  Token get leftBracket;
  NodeList get members;
  Token get mixinKeyword;
  MixinOnClause get onClause;
  Token get rightBracket;
  TypeParameterList get typeParameters;

}


/// An element that represents a mixin.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MixinElement implements InterfaceElement {
  MixinFragment get firstFragment;
  List get fragments;
  bool get isBase;
  bool get isImplementableOutside;
  List get superclassConstraints;

}


/// The portion of a [PrefixElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MixinFragment implements InterfaceFragment {
  MixinElement get element;
  MixinFragment? get nextFragment;
  MixinFragment? get previousFragment;
  List get superclassConstraints;

}


/// The "on" clause in a mixin declaration.
///
///    onClause ::=
///        'on' [NamedType] (',' [NamedType])*

abstract class MixinOnClause implements AstNode {
  Token get onKeyword;
  NodeList get superclassConstraints;

}


/// A pseudo-element that represents multiple elements defined within a single
/// scope that have the same name. This situation is not allowed by the
/// language, so objects implementing this interface always represent an error.
/// As a result, most of the normal operations on elements do not make sense
/// and will return useless results.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MultiplyDefinedElement implements Element {
  List get conflictingElements;
  MultiplyDefinedFragment get firstFragment;
  List get fragments;

}


/// The fragment for a [MultiplyDefinedElement].
///
/// It has no practical use, and exists for consistency, so that the
/// corresponding element has a fragment.
///
/// Clients may not extend, implement or mix-in this class.

abstract class MultiplyDefinedFragment implements Fragment {
  MultiplyDefinedElement get element;
  int get offset;

}


/// The type name with optional type parameters.
abstract class NameWithTypeParameters implements ClassNamePart {
}


/// A node that declares a single name within the scope of a compilation unit.
abstract class NamedCompilationUnitMember implements CompilationUnitMember {
  Token get name;

}


abstract class NamedCompilationUnitMemberImpl extends CompilationUnitMemberImpl implements NamedCompilationUnitMember {
  Token get name;

}


/// An expression that has a name associated with it.
///
/// They are only used in method invocations when there are named parameters.
///
///    namedExpression ::=
///        [Label] [Expression]

abstract class NamedExpression implements Expression {
  FormalParameterElement get element;
  Expression get expression;
  Label get name;

}


/// A named type, which can optionally include type arguments.
///
///    namedType ::=
///        [ImportPrefixReference]? name typeArguments?

abstract class NamedType implements TypeAnnotation {
  Element get element;
  ImportPrefixReference get importPrefix;
  bool get isDeferred;
  Token get name;
  DartType get type;
  TypeArgumentList get typeArguments;

}


/// An object that controls how namespaces are combined.
///
/// Clients may not extend, implement or mix-in this class.

abstract class NamespaceCombinator {
  int get end;
  int get offset;

}


/// A node that represents a directive that impacts the namespace of a library.
///
///    directive ::=
///        [ExportDirective]
///      | [ImportDirective]

abstract class NamespaceDirective implements UriBasedDirective {
  NodeList get combinators;
  NodeList get configurations;
  Token get semicolon;

}


abstract class NamespaceDirectiveImpl extends UriBasedDirectiveImpl implements NamespaceDirective {
  NodeListImpl get _configurations;
  NodeListImpl get _combinators;
  Token get semicolon;
  NodeListImpl get combinators;
  NodeListImpl get configurations;
  Token get endToken;

}


/// The "native" clause in an class declaration.
///
///    nativeClause ::=
///        'native' [StringLiteral]

abstract class NativeClause implements AstNode {
  StringLiteral get name;
  Token get nativeKeyword;

}


/// A function body that consists of a native keyword followed by a string
/// literal.
///
///    nativeFunctionBody ::=
///        'native' [SimpleStringLiteral] ';'

abstract class NativeFunctionBody implements FunctionBody {
  Token get nativeKeyword;
  Token get semicolon;
  StringLiteral get stringLiteral;

}


/// The type `Never` represents the uninhabited bottom type.
abstract class NeverType implements DartType {
}


/// A list of AST nodes that have a common parent.
abstract class NodeList<E extends AstNode> implements List {
  Token get beginToken;
  Token get endToken;
  AstNode get owner;

  void accept(AstVisitor visitor);
}


/// A formal parameter that is required (isn't optional).
///
///    normalFormalParameter ::=
///        [FunctionTypedFormalParameter]
///      | [FieldFormalParameter]
///      | [SimpleFormalParameter]

abstract class NormalFormalParameter implements FormalParameter, AnnotatedNode {
}


abstract class NormalFormalParameterImpl extends FormalParameterImpl implements NormalFormalParameter {
  Token get covariantKeyword;
  Token get requiredKeyword;
  Token get name;
  Token get beginToken;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// A null-assert pattern.
///
///    nullAssertPattern ::=
///        [DartPattern] '!'

abstract class NullAssertPattern implements DartPattern {
  Token get operator;
  DartPattern get pattern;

}


/// A null-aware element in a list or set literal.
///
///    <nullAwareExpressionElement> ::= '?' <expression>

abstract class NullAwareElement implements CollectionElement {
  Token get question;
  Expression get value;

}


/// A null-check pattern.
///
///    nullCheckPattern ::=
///        [DartPattern] '?'

abstract class NullCheckPattern implements DartPattern {
  Token get operator;
  DartPattern get pattern;

}


/// A null literal expression.
///
///    nullLiteral ::=
///        'null'

abstract class NullLiteral implements Literal {
  Token get literal;

}


/// An object pattern.
///
///    objectPattern ::=
///        [Identifier] [TypeArgumentList]? '(' [PatternField] ')'

abstract class ObjectPattern implements DartPattern {
  NodeList get fields;
  Token get leftParenthesis;
  Token get rightParenthesis;
  NamedType get type;

}


/// A type that can track substituted type parameters, either for itself after
/// instantiation, or from a surrounding context.
///
/// For example, given a class `Foo<T>`, after instantiation with S for T, it
/// will track the substitution `{S/T}`.
///
/// This substitution will be propagated to its members. For example, say our
/// `Foo<T>` class has a field `T bar;`. When we look up this field, we will get
/// back a [FieldElement] that tracks the substituted type as `{S/T}T`, so when
/// we ask for the field type we will get `S`.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ParameterizedType implements DartType {
  List get typeArguments;

}


/// A parenthesized expression.
///
///    parenthesizedExpression ::=
///        '(' [Expression] ')'

abstract class ParenthesizedExpression implements Expression {
  Expression get expression;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


/// A parenthesized pattern.
///
///    parenthesizedPattern ::=
///        '(' [DartPattern] ')'

abstract class ParenthesizedPattern implements DartPattern {
  Token get leftParenthesis;
  DartPattern get pattern;
  Token get rightParenthesis;

}


/// The result of parsing of a single file. The errors returned include only
/// those discovered during scanning and parsing.
///
/// Similar to [ParsedUnitResult], but does not allow access to an analysis
/// session.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ParseStringResult {
  String get content;
  List get errors;
  LineInfo get lineInfo;
  CompilationUnit get unit;

}


/// The result of building parsed AST(s) for the whole library.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ParsedLibraryResult implements SomeParsedLibraryResult, AnalysisResult {
  List get units;

  FragmentDeclarationResult getFragmentDeclaration(Fragment fragment);
}


/// The result of parsing of a single file. The errors returned include only
/// those discovered during scanning and parsing.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ParsedUnitResult implements SomeParsedUnitResult, AnalysisResultWithDiagnostics {
  CompilationUnit get unit;

}


/// A part directive.
///
///    partDirective ::=
///        [Annotation] 'part' [StringLiteral] ';'

abstract class PartDirective implements UriBasedDirective {
  PartInclude get partInclude;
  Token get partKeyword;
  Token get semicolon;

}


/// A 'part' directive within a library fragment.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PartInclude implements ElementDirective {
  LibraryFragment get includedFragment;
  int get partKeywordOffset;

}


/// A part-of directive.
///
///    partOfDirective ::=
///        [Annotation] 'part' 'of' [Identifier] ';'

abstract class PartOfDirective implements Directive {
  LibraryIdentifier get libraryName;
  Token get ofKeyword;
  Token get partKeyword;
  Token get semicolon;
  StringLiteral get uri;

}


/// A pattern assignment.
///
///    patternAssignment ::=
///        [DartPattern] '=' [Expression]

abstract class PatternAssignment implements Expression {
  Token get equals;
  Expression get expression;
  DartPattern get pattern;

}


/// A field in an object or record pattern.
///
///    patternField ::=
///        [PatternFieldName]? [DartPattern]

abstract class PatternField implements AstNode {
  String get effectiveName;
  Element get element;
  PatternFieldName get name;
  DartPattern get pattern;

}


/// A field name in an object or record pattern field.
///
///    patternFieldName ::=
///        [Token]? ':'

abstract class PatternFieldName implements AstNode {
  Token get colon;
  Token get name;

}


/// A pattern variable declaration.
///
///    patternDeclaration ::=
///        ( 'final' | 'var' ) [DartPattern] '=' [Expression]

abstract class PatternVariableDeclaration implements AnnotatedNode {
  Token get equals;
  Expression get expression;
  Token get keyword;
  DartPattern get pattern;

}


/// A pattern variable declaration statement.
///
///    patternDeclaration ::=
///        [PatternVariableDeclaration] ';'

abstract class PatternVariableDeclarationStatement implements Statement {
  PatternVariableDeclaration get declaration;
  Token get semicolon;

}


/// A pattern variable.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PatternVariableElement implements LocalVariableElement {
  PatternVariableFragment get firstFragment;
  List get fragments;
  JoinPatternVariableElement get join;

}


/// The portion of a [PatternVariableElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PatternVariableFragment implements LocalVariableFragment {
  PatternVariableElement get element;
  JoinPatternVariableFragment get join;
  PatternVariableFragment? get nextFragment;
  PatternVariableFragment? get previousFragment;

}


/// A postfix unary expression.
///
///    postfixExpression ::=
///        [Expression] [Token]

abstract class PostfixExpression implements Expression, MethodReferenceExpression, CompoundAssignmentExpression {
  MethodElement get element;
  Expression get operand;
  Token get operator;

}


/// A prefix used to import one or more libraries into another library.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PrefixElement implements Element {
  PrefixFragment get firstFragment;
  List get fragments;
  List get imports;
  LibraryElement get library;

}


/// A prefix unary expression.
///
///    prefixExpression ::=
///        [Token] [Expression]

abstract class PrefixExpression implements Expression, MethodReferenceExpression, CompoundAssignmentExpression {
  MethodElement get element;
  Expression get operand;
  Token get operator;

}


/// The portion of a [PrefixElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PrefixFragment implements Fragment {
  PrefixElement get element;
  LibraryFragment get enclosingFragment;
  bool get isDeferred;
  PrefixFragment? get nextFragment;
  PrefixFragment? get previousFragment;

}


/// An identifier that is prefixed or an access to an object property where the
/// target of the property access is a simple identifier.
///
///    prefixedIdentifier ::=
///        [SimpleIdentifier] '.' [SimpleIdentifier]

abstract class PrefixedIdentifier implements Identifier {
  SimpleIdentifier get identifier;
  bool get isDeferred;
  Token get period;
  SimpleIdentifier get prefix;

}


/// The declaration of a primary constructor.
abstract class PrimaryConstructorDeclaration implements ClassNamePart {
  Token get constKeyword;
  PrimaryConstructorName get constructorName;
  FormalParameterList get formalParameters;

}


/// The name of a primary constructor.
abstract class PrimaryConstructorName implements AstNode {
  Token get name;
  Token get period;

}


/// The access of a property of an object.
///
/// Note, however, that accesses to properties of objects can also be
/// represented as [PrefixedIdentifier] nodes in cases where the target is also
/// a simple identifier.
///
///    propertyAccess ::=
///        [Expression] '.' [SimpleIdentifier]

abstract class PropertyAccess implements CommentReferableExpression {
  bool get isCascaded;
  bool get isNullAware;
  Token get operator;
  SimpleIdentifier get propertyName;
  Expression get realTarget;
  Expression get target;

}


/// A getter or a setter.
///
/// Property accessors can either be defined explicitly or they can be induced
/// by either a top-level variable or a field. Induced property accessors are
/// synthetic.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PropertyAccessorElement implements ExecutableElement {
  PropertyAccessorElement get baseElement;
  Element get enclosingElement;
  PropertyAccessorFragment get firstFragment;
  List get fragments;
  PropertyInducingElement get variable;

}


/// The portion of a [GetterElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PropertyAccessorFragment implements ExecutableFragment {
  PropertyAccessorElement get element;
  PropertyAccessorFragment? get nextFragment;
  PropertyAccessorFragment? get previousFragment;

}


/// A variable that has an associated getter and possibly a setter. Note that
/// explicitly defined variables implicitly define a synthetic getter and that
/// non-`final` explicitly defined variables implicitly define a synthetic
/// setter. Symmetrically, synthetic fields are implicitly created for
/// explicitly defined getters and setters. The following rules apply:
///
/// * Every explicit variable is represented by a non-synthetic
///   [PropertyInducingElement].
/// * Every explicit variable induces a synthetic [GetterElement],
///   possibly a synthetic [SetterElement.
/// * Every explicit getter by a non-synthetic [GetterElement].
/// * Every explicit setter by a non-synthetic [SetterElement].
/// * Every explicit getter or setter (or pair thereof if they have the same
///   name) induces a variable that is represented by a synthetic
///   [PropertyInducingElement].
///
/// Clients may not extend, implement or mix-in this class.

abstract class PropertyInducingElement implements VariableElement {
  PropertyInducingFragment get firstFragment;
  List get fragments;
  GetterElement get getter;
  bool get hasInitializer;
  LibraryElement get library;
  SetterElement get setter;

}


/// The portion of a [PropertyInducingElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class PropertyInducingFragment implements VariableFragment {
  PropertyInducingElement get element;
  bool get hasInitializer;
  bool get isAugmentation;
  bool get isSynthetic;
  LibraryFragment get libraryFragment;
  PropertyInducingFragment? get nextFragment;
  PropertyInducingFragment? get previousFragment;

}


/// A record literal.
///
///    recordLiteral ::= '(' recordField (',' recordField)* ','? ')'
///
///    recordField  ::= (identifier ':')? [Expression]

abstract class RecordLiteral implements Literal {
  Token get constKeyword;
  NodeList get fields;
  bool get isConst;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


/// A record pattern.
///
///    recordPattern ::=
///        '(' [PatternField] (',' [PatternField])* ')'

abstract class RecordPattern implements DartPattern {
  NodeList get fields;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


/// The type of a record literal or a record type annotation.
///
/// Clients may not extend, implement or mix-in this class.

abstract class RecordType implements DartType {
  List get namedFields;
  List get positionalFields;

}


/// A record type.
///
/// recordType ::=
///     '(' recordTypeFields ',' recordTypeNamedFields ')'
///   | '(' recordTypeFields ','? ')'
///   | '(' recordTypeNamedFields ')'
///
/// recordTypeFields ::= recordTypeField ( ',' recordTypeField )*
///
/// recordTypeField ::= metadata type identifier?
///
/// recordTypeNamedFields ::=
///     '{' recordTypeNamedField
///     ( ',' recordTypeNamedField )* ','? '}'
///
/// recordTypeNamedField ::= metadata type identifier

abstract class RecordTypeAnnotation implements TypeAnnotation {
  Token get leftParenthesis;
  RecordTypeAnnotationNamedFields get namedFields;
  NodeList get positionalFields;
  Token get rightParenthesis;

}


/// A field in a [RecordTypeAnnotation].
abstract class RecordTypeAnnotationField implements AstNode {
  NodeList get metadata;
  Token get name;
  TypeAnnotation get type;

}


abstract class RecordTypeAnnotationFieldImpl extends AstNodeImpl implements RecordTypeAnnotationField {
  NodeListImpl get metadata;
  TypeAnnotationImpl get type;
  Token get beginToken;
  Token get endToken;
  ChildEntities get _childEntities;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// A named field in a [RecordTypeAnnotation].
abstract class RecordTypeAnnotationNamedField implements RecordTypeAnnotationField {
  Token get name;

}


/// The portion of a [RecordTypeAnnotation] with named fields.
abstract class RecordTypeAnnotationNamedFields implements AstNode {
  NodeList get fields;
  Token get leftBracket;
  Token get rightBracket;

}


/// A positional field in a [RecordTypeAnnotation].
abstract class RecordTypeAnnotationPositionalField implements RecordTypeAnnotationField {
}


/// A field in a [RecordType].
///
/// Clients may not extend, implement or mix-in this class.

abstract class RecordTypeField {
  DartType get type;

}


/// A named field in a [RecordType].
///
/// Clients may not extend, implement or mix-in this class.

abstract class RecordTypeNamedField implements RecordTypeField {
  String get name;

}


/// A positional field in a [RecordType].
///
/// Clients may not extend, implement or mix-in this class.

abstract class RecordTypePositionalField implements RecordTypeField {
}


/// The invocation of a constructor in the same class from within a
/// constructor's initialization list.
///
///    redirectingConstructorInvocation ::=
///        'this' ('.' identifier)? arguments

abstract class RedirectingConstructorInvocation implements ConstructorInitializer, ConstructorReferenceNode {
  ArgumentList get argumentList;
  SimpleIdentifier get constructorName;
  Token get period;
  Token get thisKeyword;

}


/// A relational pattern.
///
///    relationalPattern ::=
///        (equalityOperator | relationalOperator) [Expression]

abstract class RelationalPattern implements DartPattern {
  MethodElement get element;
  Expression get operand;
  Token get operator;

}


/// The name of the primary constructor of an extension type.
abstract class RepresentationConstructorName implements AstNode {
  Token get name;
  Token get period;

}


/// The declaration of an extension type representation.
///
/// It declares both the representation field and the primary constructor.
///
///    <representationDeclaration> ::=
///        ('.' <identifierOrNew>)? '(' <metadata> <type> <identifier> ')'

abstract class RepresentationDeclaration implements AstNode {
  ConstructorFragment get constructorFragment;
  RepresentationConstructorName get constructorName;
  FieldFragment get fieldFragment;
  NodeList get fieldMetadata;
  Token get fieldName;
  TypeAnnotation get fieldType;
  Token get leftParenthesis;
  Token get rightParenthesis;

}


/// The result of building resolved AST(s) for the whole library.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ResolvedLibraryResult implements ParsedLibraryResult, SomeResolvedLibraryResult {
  LibraryElement get element;
  TypeProvider get typeProvider;
  List get units;

  ResolvedUnitResult unitWithPath(String path);
}


/// The result of building a resolved AST for a single file. The errors returned
/// include both syntactic and semantic errors.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ResolvedUnitResult implements ParsedUnitResult, SomeResolvedUnitResult {
  bool get exists;
  LibraryElement get libraryElement;
  LibraryFragment get libraryFragment;
  TypeProvider get typeProvider;

}


/// A rest pattern element.
///
///    restPatternElement ::= '...' [DartPattern]?

abstract class RestPatternElement implements ListPatternElement, MapPatternElement {
  Token get operator;
  DartPattern get pattern;

}


/// A rethrow expression.
///
///    rethrowExpression ::=
///        'rethrow'

abstract class RethrowExpression implements Expression {
  Token get rethrowKeyword;

}


/// A return statement.
///
///    returnStatement ::=
///        'return' [Expression]? ';'

abstract class ReturnStatement implements Statement {
  Expression get expression;
  Token get returnKeyword;
  Token get semicolon;

}


/// A resolved dot shorthand invocation.
///
/// Either a [FunctionExpressionInvocationImpl], a static method invocation, or
/// a [DotShorthandConstructorInvocationImpl], a constructor invocation.

abstract class RewrittenMethodInvocationImpl implements ExpressionImpl {
}


/// A script tag that can optionally occur at the beginning of a compilation
/// unit.
///
///    scriptTag ::=
///        '#!' (~NEWLINE)* NEWLINE

abstract class ScriptTag implements AstNode {
  Token get scriptTag;

}


/// A set or map literal.
///
///    setOrMapLiteral ::=
///        'const'? [TypeArgumentList]? '{' elements? '}'
///
///    elements ::=
///        [CollectionElement] ( ',' [CollectionElement] )* ','?
///
/// This is the class that is used to represent either a map or set literal when
/// either the 'control-flow-collections' or 'spread-collections' experiments
/// are enabled. If neither of those experiments are enabled, then `MapLiteral`
/// is used to represent a map literal and `SetLiteral` is used for set
/// literals.

abstract class SetOrMapLiteral implements TypedLiteral {
  NodeList get elements;
  bool get isMap;
  bool get isSet;
  Token get leftBracket;
  Token get rightBracket;

}


/// A setter.
///
/// Setters can either be defined explicitly or they can be induced by either a
/// top-level variable or a field. Induced setters are synthetic.
///
/// Clients may not extend, implement or mix-in this class.

abstract class SetterElement implements PropertyAccessorElement {
  SetterElement get baseElement;
  GetterElement get correspondingGetter;
  SetterFragment get firstFragment;
  List get fragments;

}


/// The portion of a [SetterElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class SetterFragment implements PropertyAccessorFragment {
  SetterElement get element;
  SetterFragment? get nextFragment;
  int get offset;
  SetterFragment? get previousFragment;

}


/// A combinator that restricts the names being imported to those in a given
/// list.
///
///    showCombinator ::=
///        'show' [SimpleIdentifier] (',' [SimpleIdentifier])*

abstract class ShowCombinator implements Combinator {
  NodeList get shownNames;

}


/// A combinator that cause some of the names in a namespace to be visible (and
/// the rest hidden) when being imported.
///
/// Clients may not extend, implement or mix-in this class.

abstract class ShowElementCombinator implements NamespaceCombinator {
  List get shownNames;

}


/// A simple formal parameter.
///
///    simpleFormalParameter ::=
///        ('final' [TypeAnnotation] | 'var' | [TypeAnnotation])?
///        [SimpleIdentifier]

abstract class SimpleFormalParameter implements NormalFormalParameter {
  Token get keyword;
  TypeAnnotation get type;

}


/// A simple identifier.
///
///    simpleIdentifier ::=
///        initialCharacter internalCharacter*
///
///    initialCharacter ::= '_' | '$' | letter
///
///    internalCharacter ::= '_' | '$' | letter | digit

abstract class SimpleIdentifier implements Identifier {
  bool get isQualified;
  List get tearOffTypeArgumentTypes;
  Token get token;

  bool inDeclarationContext();
  bool inGetterContext();
  bool inSetterContext();
}


/// A string literal expression that doesn't contain any interpolations.
///
///    simpleStringLiteral ::=
///        rawStringLiteral
///      | basicStringLiteral
///
///    rawStringLiteral ::=
///        'r' basicStringLiteral
///
///    basicStringLiteral ::=
///        multiLineStringLiteral
///      | singleLineStringLiteral
///
///    multiLineStringLiteral ::=
///        "'''" characters "'''"
///      | '"""' characters '"""'
///
///    singleLineStringLiteral ::=
///        "'" characters "'"
///      | '"' characters '"'

abstract class SimpleStringLiteral implements SingleStringLiteral {
  Token get literal;
  String get value;

}


/// A single string literal expression.
///
///    singleStringLiteral ::=
///        [SimpleStringLiteral]
///      | [StringInterpolation]

abstract class SingleStringLiteral implements StringLiteral {
  int get contentsEnd;
  int get contentsOffset;
  bool get isMultiline;
  bool get isRaw;
  bool get isSingleQuoted;

}


abstract class SingleStringLiteralImpl extends StringLiteralImpl implements SingleStringLiteral {
}


/// The result of computing all of the errors contained in a single file, both
/// syntactic and semantic.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [ErrorsResult] represents a valid result.

abstract class SomeErrorsResult {
}


/// The result of computing some cheap information for a single file, when full
/// parsed file is not required, so [ParsedUnitResult] is not necessary.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [FileResult] represents a valid result.

abstract class SomeFileResult {
}


/// The result of building the element model for a library.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [LibraryElementResult] represents a valid result.

abstract class SomeLibraryElementResult {
}


/// The result of building parsed AST(s) for the whole library.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [ParsedLibraryResult] represents a valid result.

abstract class SomeParsedLibraryResult {
}


/// The result of parsing of a single file. The errors returned include only
/// those discovered during scanning and parsing.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [ParsedUnitResult] represents a valid result.

abstract class SomeParsedUnitResult {
}


/// The result of building resolved AST(s) for the whole library.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [ResolvedLibraryResult] represents a valid result.

abstract class SomeResolvedLibraryResult {
}


/// The result of building a resolved AST for a single file. The errors returned
/// include both syntactic and semantic errors.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [ResolvedUnitResult] represents a valid result.

abstract class SomeResolvedUnitResult {
}


/// The result of building the element model for a single file.
///
/// Clients may not extend, implement or mix-in this class.
///
/// There are existing implementations of this class.
/// [UnitElementResult] represents a valid result.

abstract class SomeUnitElementResult {
}


/// A spread element.
///
///    spreadElement:
///        ( '...' | '...?' ) [Expression]

abstract class SpreadElement implements CollectionElement {
  Expression get expression;
  bool get isNullAware;
  Token get spreadOperator;

}


/// A node that represents a statement.
///
///    statement ::=
///        [Block]
///      | [VariableDeclarationStatement]
///      | [ForStatement]
///      | [ForEachStatement]
///      | [WhileStatement]
///      | [DoStatement]
///      | [SwitchStatement]
///      | [IfStatement]
///      | [TryStatement]
///      | [BreakStatement]
///      | [ContinueStatement]
///      | [ReturnStatement]
///      | [ExpressionStatement]
///      | [FunctionDeclarationStatement]

abstract class Statement implements AstNode {
  Statement get unlabeled;

}


abstract class StatementImpl extends AstNodeImpl implements Statement {
  StatementImpl get unlabeled;

}


/// A string interpolation literal.
///
///    stringInterpolation ::=
///        ''' [InterpolationElement]* '''
///      | '"' [InterpolationElement]* '"'

abstract class StringInterpolation implements SingleStringLiteral {
  NodeList get elements;
  InterpolationString get firstString;
  InterpolationString get lastString;

}


/// A string literal expression.
///
///    stringLiteral ::=
///        [SimpleStringLiteral]
///      | [AdjacentStrings]
///      | [StringInterpolation]

abstract class StringLiteral implements Literal {
  String get stringValue;

}


abstract class StringLiteralImpl extends LiteralImpl implements StringLiteral {
  String get stringValue;

}


/// The invocation of a superclass' constructor from within a constructor's
/// initialization list.
///
///    superInvocation ::=
///        'super' ('.' [SimpleIdentifier])? [ArgumentList]

abstract class SuperConstructorInvocation implements ConstructorInitializer, ConstructorReferenceNode {
  ArgumentList get argumentList;
  SimpleIdentifier get constructorName;
  Token get period;
  Token get superKeyword;

}


/// A super expression.
///
///    superExpression ::=
///        'super'

abstract class SuperExpression implements Expression {
  Token get superKeyword;

}


/// A super-initializer formal parameter.
///
///    superFormalParameter ::=
///        ('final' [TypeAnnotation] | 'const' [TypeAnnotation] | 'var' |
///        [TypeAnnotation])?
///        'super' '.' name ([TypeParameterList]? [FormalParameterList])?

abstract class SuperFormalParameter implements NormalFormalParameter {
  SuperFormalParameterFragment get declaredFragment;
  Token get keyword;
  Token get name;
  FormalParameterList get parameters;
  Token get period;
  Token get question;
  Token get superKeyword;
  TypeAnnotation get type;
  TypeParameterList get typeParameters;

}


/// A super formal parameter.
///
/// Super formal parameters can only be defined within a constructor element.
///
/// Clients may not extend, implement or mix-in this class.

abstract class SuperFormalParameterElement implements FormalParameterElement {
  SuperFormalParameterFragment get firstFragment;
  List get fragments;
  FormalParameterElement get superConstructorParameter;

}


/// The portion of a [SuperFormalParameterElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class SuperFormalParameterFragment implements FormalParameterFragment {
  SuperFormalParameterElement get element;
  SuperFormalParameterFragment? get nextFragment;
  SuperFormalParameterFragment? get previousFragment;

}


/// A case in a switch statement.
///
///    switchCase ::=
///        [SimpleIdentifier]* 'case' [Expression] ':' [Statement]*

abstract class SwitchCase implements SwitchMember {
  Expression get expression;

}


/// The default case in a switch statement.
///
///    switchDefault ::=
///        [SimpleIdentifier]* 'default' ':' [Statement]*

abstract class SwitchDefault implements SwitchMember {
}


/// A switch expression.
///
///    switchExpression ::=
///        'switch' '(' [Expression] ')' '{' [SwitchExpressionCase]
///        (',' [SwitchExpressionCase])* ','? '}'

abstract class SwitchExpression implements Expression {
  NodeList get cases;
  Expression get expression;
  Token get leftBracket;
  Token get leftParenthesis;
  Token get rightBracket;
  Token get rightParenthesis;
  Token get switchKeyword;

}


/// A case in a switch expression.
///
///    switchExpressionCase ::=
///        [GuardedPattern] '=>' [Expression]

abstract class SwitchExpressionCase implements AstNode {
  Token get arrow;
  Expression get expression;
  GuardedPattern get guardedPattern;

}


/// An element within a switch statement.
///
///    switchMember ::=
///        [SwitchCase]
///      | [SwitchDefault]
///      | [SwitchPatternCase]
///
/// The class [SwitchPatternCase] exists only to support the 'patterns' feature.
///
/// Note that when the patterns feature is enabled by default, the class
/// [SwitchPatternCase] might replace [SwitchCase] entirely. If we do that, then
/// legacy code (code opted into a version prior to the release of patterns)
/// will likely wrap the expression in a [ConstantPattern] with synthetic
/// tokens.

abstract class SwitchMember implements AstNode {
  Token get colon;
  Token get keyword;
  NodeList get labels;
  NodeList get statements;

}


abstract class SwitchMemberImpl extends AstNodeImpl implements SwitchMember {
  NodeListImpl get _labels;
  Token get keyword;
  Token get colon;
  NodeListImpl get _statements;
  Token get beginToken;
  Token get endToken;
  NodeListImpl get labels;
  NodeListImpl get statements;

}


/// A pattern-based case in a switch statement.
///
///    switchPatternCase ::=
///        [Label]* 'case' [DartPattern] [WhenClause]? ':' [Statement]*

abstract class SwitchPatternCase implements SwitchMember {
  GuardedPattern get guardedPattern;

}


/// A switch statement.
///
///    switchStatement ::=
///        'switch' '(' [Expression] ')' '{' [SwitchCase]* [SwitchDefault]? '}'

abstract class SwitchStatement implements Statement {
  Expression get expression;
  Token get leftBracket;
  Token get leftParenthesis;
  NodeList get members;
  Token get rightBracket;
  Token get rightParenthesis;
  Token get switchKeyword;

}


/// A symbol literal expression.
///
///    symbolLiteral ::=
///        '#' (operator | (identifier ('.' identifier)*))

abstract class SymbolLiteral implements Literal {
  List get components;
  Token get poundSign;

}


/// A this expression.
///
///    thisExpression ::=
///        'this'

abstract class ThisExpression implements Expression {
  Token get thisKeyword;

}


/// A throw expression.
///
///    throwExpression ::=
///        'throw' [Expression]

abstract class ThrowExpression implements Expression {
  Expression get expression;
  Token get throwKeyword;

}


/// A top-level function.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TopLevelFunctionElement implements ExecutableElement {
  TopLevelFunctionElement get baseElement;
  TopLevelFunctionFragment get firstFragment;
  List get fragments;
  bool get isDartCoreIdentical;
  bool get isEntryPoint;

}


/// The portion of a [TopLevelFunctionElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TopLevelFunctionFragment implements ExecutableFragment {
  TopLevelFunctionElement get element;
  TopLevelFunctionFragment? get nextFragment;
  TopLevelFunctionFragment? get previousFragment;

}


/// The declaration of one or more top-level variables of the same type.
///
///    topLevelVariableDeclaration ::=
///        ('final' | 'const') <type>? <staticFinalDeclarationList> ';'
///      | 'late' 'final' <type>? <initializedIdentifierList> ';'
///      | 'late'? <varOrType> <initializedIdentifierList> ';'
///      | 'external' <finalVarOrType> <identifierList> ';'
///
/// (Note: there's no `<topLevelVariableDeclaration>` production in the grammar;
/// this is a subset of the grammar production `<topLevelDeclaration>`, which
/// encompasses everything that can appear inside a Dart file after part
/// directives).

abstract class TopLevelVariableDeclaration implements CompilationUnitMember {
  Token get augmentKeyword;
  Token get externalKeyword;
  Token get semicolon;
  VariableDeclarationList get variables;

}


/// A top-level variable.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TopLevelVariableElement implements PropertyInducingElement {
  TopLevelVariableElement get baseElement;
  TopLevelVariableFragment get firstFragment;
  List get fragments;
  bool get isExternal;

}


/// The portion of a [TopLevelVariableElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TopLevelVariableFragment implements PropertyInducingFragment {
  TopLevelVariableElement get element;
  TopLevelVariableFragment? get nextFragment;
  TopLevelVariableFragment? get previousFragment;

}


/// A try statement.
///
///    tryStatement ::=
///        'try' [Block] ([CatchClause]+ finallyClause? | finallyClause)
///
///    finallyClause ::=
///        'finally' [Block]

abstract class TryStatement implements Statement {
  Block get body;
  NodeList get catchClauses;
  Block get finallyBlock;
  Token get finallyKeyword;
  Token get tryKeyword;

}


/// The declaration of a type alias.
///
///    typeAlias ::=
///        [ClassTypeAlias]
///      | [FunctionTypeAlias]
///      | [GenericTypeAlias]

abstract class TypeAlias implements NamedCompilationUnitMember {
  Token get augmentKeyword;
  Token get semicolon;
  Token get typedefKeyword;

}


/// A type alias (`typedef`).
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeAliasElement implements TypeParameterizedElement {
  DartType get aliasedType;
  LibraryElement get enclosingElement;
  TypeAliasFragment get firstFragment;
  List get fragments;

  DartType instantiate({required List typeArguments, required NullabilitySuffix nullabilitySuffix});
}


/// The portion of a [TypeAliasElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeAliasFragment implements TypeParameterizedFragment {
  TypeAliasElement get element;
  LibraryFragment get enclosingFragment;

}


abstract class TypeAliasImpl extends NamedCompilationUnitMemberImpl implements TypeAlias {
  Token get augmentKeyword;
  Token get typedefKeyword;
  Token get semicolon;
  Token get endToken;
  Token get firstTokenAfterCommentAndMetadata;

}


/// A type annotation.
///
///    type ::=
///        [NamedType]
///      | [GenericFunctionType]
///      | [RecordTypeAnnotation]

abstract class TypeAnnotation implements AstNode {
  Token get question;
  DartType get type;

}


abstract class TypeAnnotationImpl extends AstNodeImpl implements TypeAnnotation {

}


/// A list of type arguments.
///
///    typeArguments ::=
///        '<' typeName (',' typeName)* '>'

abstract class TypeArgumentList implements AstNode {
  NodeList get arguments;
  Token get leftBracket;
  Token get rightBracket;

}


/// An expression representing a type, such as the expression `int` in
/// `var x = int;`.
///
/// Objects of this type aren't produced directly by the parser (because the
/// parser can't tell whether an identifier refers to a type); they are
/// produced at resolution time.
///
/// The `.staticType` getter returns the type of the expression (which is
/// always the type `Type`). To get the type represented by the type literal
/// use `.typeName.type`.

abstract class TypeLiteral implements Expression, CommentReferableExpression {
  NamedType get type;

}


/// A type parameter.
///
///    typeParameter ::=
///        name ('extends' [TypeAnnotation])?

abstract class TypeParameter implements Declaration {
  TypeAnnotation get bound;
  TypeParameterFragment get declaredFragment;
  Token get extendsKeyword;
  Token get name;

}


/// A type parameter.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeParameterElement {
  TypeParameterElement get baseElement;
  DartType get bound;
  TypeParameterFragment get firstFragment;
  List get fragments;

  TypeParameterType instantiate({required NullabilitySuffix nullabilitySuffix});
}


/// The portion of a [TypeParameterElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeParameterFragment {
  TypeParameterElement get element;
  TypeParameterFragment? get nextFragment;
  TypeParameterFragment? get previousFragment;

}


/// Type parameters within a declaration.
///
///    typeParameterList ::=
///        '<' [TypeParameter] (',' [TypeParameter])* '>'

abstract class TypeParameterList implements AstNode {
  Token get leftBracket;
  Token get rightBracket;
  NodeList get typeParameters;

}


/// The type introduced by a type parameter.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeParameterType implements DartType {
  DartType get bound;
  TypeParameterElement get element;

}


/// An element that has type parameters, such as a class, typedef, or method.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeParameterizedElement implements Element {
  TypeParameterizedFragment get firstFragment;
  List get fragments;
  bool get isSimplyBounded;
  LibraryElement get library;
  List get typeParameters;

}


/// The portion of a [TypeParameterizedElement] contributed by a single
/// declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class TypeParameterizedFragment implements Fragment {
  TypeParameterizedElement get element;
  TypeParameterizedFragment? get nextFragment;
  TypeParameterizedFragment? get previousFragment;
  List get typeParameters;

}


/// A literal that has a type associated with it.
///
///    typedLiteral ::=
///        [ListLiteral]
///      | [SetOrMapLiteral]

abstract class TypedLiteral implements Literal {
  Token get constKeyword;
  bool get isConst;
  TypeArgumentList get typeArguments;

}


abstract class TypedLiteralImpl extends LiteralImpl implements TypedLiteral {
  Token get constKeyword;
  TypeArgumentListImpl get _typeArguments;
  bool get canBeConst;
  bool get isConst;
  TypeArgumentListImpl get typeArguments;
  ChildEntities get _childEntities;

  void visitChildren(AstVisitor visitor);
  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// The result of building the element model for a single file.
///
/// Clients may not extend, implement or mix-in this class.
///

abstract class UnitElementResult implements SomeUnitElementResult, FileResult {
  LibraryFragment get fragment;

}


/// A directive that references a URI.
///
///    uriBasedDirective ::=
///        [LibraryAugmentationDirective]
///        [ExportDirective]
///      | [ImportDirective]
///      | [PartDirective]

abstract class UriBasedDirective implements Directive {
  StringLiteral get uri;

}


abstract class UriBasedDirectiveImpl extends DirectiveImpl implements UriBasedDirective {
  StringLiteralImpl get _uri;
  StringLiteralImpl get uri;

  AstNodeImpl _childContainingRange(int rangeOffset, int rangeEnd);
}


/// An identifier that has an initial value associated with it.
///
/// Instances of this class are always children of the class
/// [VariableDeclarationList].
///
///    variableDeclaration ::=
///        name ('=' [Expression])?

abstract class VariableDeclaration implements Declaration {
  VariableFragment get declaredFragment;
  Token get equals;
  Expression get initializer;
  bool get isConst;
  bool get isFinal;
  bool get isLate;
  Token get name;

}


/// The declaration of one or more variables of the same type.
///
///    variableDeclarationList ::=
///        finalConstVarOrType [VariableDeclaration]
///        (',' [VariableDeclaration])*
///
///    finalConstVarOrType ::=
///      'final' 'late'? [TypeAnnotation]?
///      | 'const' [TypeAnnotation]?
///      | 'var'
///      | 'late'? [TypeAnnotation]

abstract class VariableDeclarationList implements AnnotatedNode {
  bool get isConst;
  bool get isFinal;
  bool get isLate;
  Token get keyword;
  Token get lateKeyword;
  TypeAnnotation get type;
  NodeList get variables;

}


/// A list of variables that are being declared in a context where a statement
/// is required.
///
///    variableDeclarationStatement ::=
///        [VariableDeclarationList] ';'

abstract class VariableDeclarationStatement implements Statement {
  Token get semicolon;
  VariableDeclarationList get variables;

}


/// A variable.
///
/// There are more specific subclasses for more specific kinds of variables.
///
/// Clients may not extend, implement or mix-in this class.

abstract class VariableElement implements Element {
  Expression get constantInitializer;
  VariableFragment get firstFragment;
  List get fragments;
  bool get hasImplicitType;
  bool get isConst;
  bool get isFinal;
  bool get isLate;
  bool get isStatic;
  DartType get type;

}


/// The portion of a [VariableElement] contributed by a single declaration.
///
/// Clients may not extend, implement or mix-in this class.

abstract class VariableFragment implements Fragment {
  VariableElement get element;
  VariableFragment? get nextFragment;
  VariableFragment? get previousFragment;

}


/// The shared interface of [AssignedVariablePattern] and
/// [DeclaredVariablePattern].

abstract class VariablePattern implements DartPattern {
  Token get name;

}


abstract class VariablePatternImpl extends DartPatternImpl implements VariablePattern {
  Token get name;
  PatternFieldNameImpl get fieldNameWithImplicitName;
  VariablePatternImpl get variablePattern;

}


/// The special type `void` is used to indicate that the value of an
/// expression is meaningless, and intended to be discarded.

abstract class VoidType implements DartType {

}


/// A guard in a pattern-based `case` in a `switch` statement, `switch`
/// expression, `if` statement, or `if` element.
///
///    switchCase ::=
///        'when' [Expression]

abstract class WhenClause implements AstNode {
  Expression get expression;
  Token get whenKeyword;

}


/// A while statement.
///
///    whileStatement ::=
///        'while' '(' [Expression] ')' [Statement]

abstract class WhileStatement implements Statement {
  Statement get body;
  Expression get condition;
  Token get leftParenthesis;
  Token get rightParenthesis;
  Token get whileKeyword;

}


/// A wildcard pattern.
///
///    wildcardPattern ::=
///        ( 'var' | 'final' | 'final'? [TypeAnnotation])? '_'

abstract class WildcardPattern implements DartPattern {
  Token get keyword;
  Token get name;
  TypeAnnotation get type;

}


/// The with clause in a class declaration.
///
///    withClause ::=
///        'with' [NamedType] (',' [NamedType])*

abstract class WithClause implements AstNode {
  NodeList get mixinTypes;
  Token get withKeyword;

}


/// A yield statement.
///
///    yieldStatement ::=
///        'yield' '*'? [Expression] ‘;’

abstract class YieldStatement implements Statement {
  Expression get expression;
  Token get semicolon;
  Token get star;
  Token get yieldKeyword;

}


