# Dart Analyzer AST Abstract Class Hierarchy

**Source:** `analyzer` package v8.4.1  
**File:** `lib/src/dart/ast/ast.dart` (26,370 lines)  
**Extracted:** 2026-02-18

---

## Root

```
SyntacticEntity  (from _fe_analyzer_shared)
  int get end
  int get length
  int get offset
```

## Complete Inheritance Tree

```
SyntacticEntity
└── AstNode
    ├── AnnotatedNode
    │   ├── Declaration
    │   │   ├── ClassMember (sealed)
    │   │   │   ├── ConstructorDeclaration
    │   │   │   ├── FieldDeclaration
    │   │   │   └── MethodDeclaration
    │   │   ├── CompilationUnitMember
    │   │   │   ├── NamedCompilationUnitMember
    │   │   │   │   ├── ClassDeclaration
    │   │   │   │   ├── EnumDeclaration
    │   │   │   │   ├── ExtensionTypeDeclaration
    │   │   │   │   ├── FunctionDeclaration
    │   │   │   │   ├── MixinDeclaration
    │   │   │   │   └── TypeAlias
    │   │   │   │       ├── ClassTypeAlias
    │   │   │   │       ├── FunctionTypeAlias
    │   │   │   │       └── GenericTypeAlias
    │   │   │   ├── ExtensionDeclaration
    │   │   │   └── TopLevelVariableDeclaration
    │   │   ├── DeclaredIdentifier
    │   │   ├── EnumConstantDeclaration
    │   │   ├── TypeParameter
    │   │   └── VariableDeclaration
    │   ├── Directive (sealed)
    │   │   ├── LibraryDirective
    │   │   ├── PartOfDirective
    │   │   ├── UriBasedDirective (sealed)
    │   │   │   ├── NamespaceDirective (sealed)
    │   │   │   │   ├── ExportDirective
    │   │   │   │   └── ImportDirective
    │   │   │   └── PartDirective
    │   │   └── (LibraryDirective, PartOfDirective — directly implement Directive)
    │   ├── NormalFormalParameter (sealed) [also implements FormalParameter]
    │   │   ├── FieldFormalParameter
    │   │   ├── FunctionTypedFormalParameter
    │   │   ├── SimpleFormalParameter
    │   │   └── SuperFormalParameter
    │   ├── PatternVariableDeclaration
    │   └── VariableDeclarationList
    │
    ├── CollectionElement (sealed)
    │   ├── Expression
    │   │   ├── Literal (sealed)
    │   │   │   ├── BooleanLiteral
    │   │   │   ├── DoubleLiteral
    │   │   │   ├── IntegerLiteral
    │   │   │   ├── NullLiteral
    │   │   │   ├── RecordLiteral
    │   │   │   ├── SymbolLiteral
    │   │   │   ├── TypedLiteral (sealed)
    │   │   │   │   ├── ListLiteral
    │   │   │   │   └── SetOrMapLiteral
    │   │   │   └── StringLiteral (sealed)
    │   │   │       ├── SingleStringLiteral (sealed)
    │   │   │       │   ├── SimpleStringLiteral
    │   │   │       │   └── StringInterpolation
    │   │   │       └── AdjacentStrings
    │   │   │
    │   │   ├── Identifier (sealed) [also implements CommentReferableExpression]
    │   │   │   ├── SimpleIdentifier
    │   │   │   ├── PrefixedIdentifier
    │   │   │   └── LibraryIdentifier
    │   │   │
    │   │   ├── InvocationExpression
    │   │   │   ├── FunctionExpressionInvocation [+NullShortableExpression]
    │   │   │   ├── MethodInvocation [+NullShortableExpression]
    │   │   │   ├── DotShorthandInvocation
    │   │   │   └── DotShorthandConstructorInvocation [+ConstructorReferenceNode]
    │   │   │
    │   │   ├── CommentReferableExpression
    │   │   │   ├── ConstructorReference [also implements Expression]
    │   │   │   ├── FunctionReference [also implements Expression]
    │   │   │   ├── PropertyAccess [+NullShortableExpression, +CommentReferableExpression]
    │   │   │   └── TypeLiteral [also implements Expression]
    │   │   │
    │   │   ├── MethodReferenceExpression
    │   │   │   ├── AssignmentExpression [+NullShortableExpression, +CompoundAssignmentExpression]
    │   │   │   ├── BinaryExpression
    │   │   │   ├── IndexExpression [+NullShortableExpression]
    │   │   │   ├── PostfixExpression [+NullShortableExpression, +CompoundAssignmentExpression]
    │   │   │   ├── PrefixExpression [+NullShortableExpression, +CompoundAssignmentExpression]
    │   │   │   └── ImplicitCallReference (NOT an Expression, directly implements MethodReferenceExpression)
    │   │   │
    │   │   ├── CompoundAssignmentExpression
    │   │   │   ├── AssignmentExpression
    │   │   │   ├── PostfixExpression
    │   │   │   └── PrefixExpression
    │   │   │
    │   │   ├── NullShortableExpression (@deprecated)
    │   │   │   ├── AssignmentExpression
    │   │   │   ├── CascadeExpression
    │   │   │   ├── FunctionExpressionInvocation
    │   │   │   ├── IndexExpression
    │   │   │   ├── MethodInvocation
    │   │   │   ├── PostfixExpression
    │   │   │   ├── PrefixExpression
    │   │   │   └── PropertyAccess
    │   │   │
    │   │   ├── (Other direct Expression implementors)
    │   │   │   ├── AsExpression
    │   │   │   ├── AwaitExpression
    │   │   │   ├── CascadeExpression [+NullShortableExpression]
    │   │   │   ├── ConditionalExpression
    │   │   │   ├── DotShorthandPropertyAccess (extends Expression)
    │   │   │   ├── ExtensionOverride
    │   │   │   ├── FunctionExpression
    │   │   │   ├── InstanceCreationExpression
    │   │   │   ├── IsExpression
    │   │   │   ├── NamedExpression
    │   │   │   ├── ParenthesizedExpression
    │   │   │   ├── PatternAssignment
    │   │   │   ├── RethrowExpression
    │   │   │   ├── SuperExpression
    │   │   │   ├── SwitchExpression
    │   │   │   ├── ThisExpression
    │   │   │   └── ThrowExpression
    │   │   │
    │   │   └── CompoundAssignmentExpression (interface for compound assignment read/write)
    │   │
    │   ├── ForElement [also implements ForLoop<CollectionElement>]
    │   ├── IfElement
    │   ├── MapLiteralEntry
    │   ├── NullAwareElement
    │   └── SpreadElement
    │
    ├── Statement
    │   ├── AssertStatement [also implements Assertion]
    │   ├── Block
    │   ├── BreakStatement
    │   ├── ContinueStatement
    │   ├── DoStatement
    │   ├── EmptyStatement
    │   ├── ExpressionStatement
    │   ├── ForStatement [also implements ForLoop<Statement>]
    │   ├── FunctionDeclarationStatement
    │   ├── IfStatement
    │   ├── LabeledStatement
    │   ├── PatternVariableDeclarationStatement
    │   ├── ReturnStatement
    │   ├── SwitchStatement
    │   ├── TryStatement
    │   ├── VariableDeclarationStatement
    │   ├── WhileStatement
    │   └── YieldStatement
    │
    ├── FormalParameter (sealed)
    │   ├── NormalFormalParameter (sealed) [also implements AnnotatedNode]
    │   │   ├── FieldFormalParameter
    │   │   ├── FunctionTypedFormalParameter
    │   │   ├── SimpleFormalParameter
    │   │   └── SuperFormalParameter
    │   └── DefaultFormalParameter
    │
    ├── FunctionBody (sealed)
    │   ├── BlockFunctionBody
    │   ├── EmptyFunctionBody
    │   ├── ExpressionFunctionBody
    │   └── NativeFunctionBody
    │
    ├── TypeAnnotation (sealed)
    │   ├── GenericFunctionType
    │   ├── NamedType
    │   └── RecordTypeAnnotation
    │
    ├── ClassBody (sealed)
    │   ├── BlockClassBody (sealed)
    │   ├── EmptyClassBody (sealed)
    │   └── EnumBody (sealed)
    │
    ├── DartPattern (sealed) [also implements ListPatternElement]
    │   ├── CastPattern
    │   ├── ConstantPattern
    │   ├── ListPattern
    │   ├── LogicalAndPattern
    │   ├── LogicalOrPattern
    │   ├── MapPattern
    │   ├── NullAssertPattern
    │   ├── NullCheckPattern
    │   ├── ObjectPattern
    │   ├── ParenthesizedPattern
    │   ├── RecordPattern
    │   ├── RelationalPattern
    │   ├── VariablePattern (sealed)
    │   │   ├── AssignedVariablePattern
    │   │   ├── DeclaredVariablePattern (sealed)
    │   │   └── WildcardPattern
    │   └── (WildcardPattern - also directly implements DartPattern)
    │
    ├── Combinator (sealed)
    │   ├── HideCombinator
    │   └── ShowCombinator
    │
    ├── ConstructorInitializer (sealed)
    │   ├── ConstructorFieldInitializer
    │   ├── RedirectingConstructorInvocation [+ConstructorReferenceNode]
    │   └── SuperConstructorInvocation [+ConstructorReferenceNode]
    │
    ├── SwitchMember (sealed)
    │   ├── SwitchCase
    │   ├── SwitchDefault
    │   └── SwitchPatternCase
    │
    ├── ForLoop<Body> (sealed, generic)
    │   ├── ForElement (Body = CollectionElement)
    │   └── ForStatement (Body = Statement)
    │
    ├── ForLoopParts (sealed)
    │   ├── ForEachParts (sealed)
    │   │   ├── ForEachPartsWithDeclaration
    │   │   ├── ForEachPartsWithIdentifier
    │   │   └── ForEachPartsWithPattern
    │   └── ForParts (sealed)
    │       ├── ForPartsWithDeclarations
    │       ├── ForPartsWithExpression
    │       └── ForPartsWithPattern
    │
    ├── InterpolationElement (sealed)
    │   ├── InterpolationExpression
    │   └── InterpolationString
    │
    ├── ListPatternElement (sealed)
    │   ├── DartPattern [all patterns are ListPatternElements]
    │   └── RestPatternElement [also implements MapPatternElement]
    │
    ├── MapPatternElement (sealed)
    │   ├── MapPatternEntry
    │   └── RestPatternElement
    │
    ├── RecordTypeAnnotationField (sealed)
    │   ├── RecordTypeAnnotationNamedField
    │   └── RecordTypeAnnotationPositionalField
    │
    ├── ClassNamePart (sealed)
    │   ├── NameWithTypeParameters
    │   └── PrimaryConstructorDeclaration
    │
    ├── ConstructorReferenceNode
    │   ├── ConstructorName [also implements AstNode]
    │   ├── DotShorthandConstructorInvocation [also extends InvocationExpression]
    │   ├── RedirectingConstructorInvocation [also implements ConstructorInitializer]
    │   └── SuperConstructorInvocation [also implements ConstructorInitializer]
    │
    ├── Assertion
    │   ├── AssertInitializer [also implements ConstructorInitializer]
    │   └── AssertStatement [also implements Statement]
    │
    ├── (Leaf AstNode types — directly implement AstNode)
    │   ├── Annotation
    │   ├── ArgumentList
    │   ├── CaseClause
    │   ├── CatchClause
    │   ├── CatchClauseParameter (extends AstNode)
    │   ├── Comment
    │   ├── CommentReference
    │   ├── CompilationUnit
    │   ├── Configuration
    │   ├── DottedName
    │   ├── EnumConstantArguments
    │   ├── ExtendsClause
    │   ├── ExtensionOnClause
    │   ├── FormalParameterList
    │   ├── GuardedPattern
    │   ├── ImplementsClause
    │   ├── ImportPrefixReference
    │   ├── Label
    │   ├── MixinOnClause
    │   ├── NativeClause
    │   ├── PatternField
    │   ├── PatternFieldName
    │   ├── PrimaryConstructorName
    │   ├── RecordTypeAnnotationNamedFields
    │   ├── RepresentationConstructorName
    │   ├── RepresentationDeclaration
    │   ├── ScriptTag
    │   ├── ConstructorSelector
    │   ├── SwitchExpressionCase
    │   ├── TypeArgumentList
    │   ├── TypeParameterList
    │   ├── WhenClause
    │   └── WithClause
    │
    └── (Deprecated / Marker types)
        └── ConstructorReferenceNode (deprecated marker)
```

---

## Abstract Getters Per Class (API Surface)

### SyntacticEntity (root interface)
```dart
int get end;
int get length;
int get offset;
```

### AstNode implements SyntacticEntity
```dart
Token get beginToken;
Iterable<SyntacticEntity> get childEntities;
int get end;
Token get endToken;
bool get isSynthetic;
int get length;
int get offset;
AstNode? get parent;
AstNode get root;
// methods
E? accept<E>(AstVisitor<E> visitor);
Token? findPrevious(Token target);
E? thisOrAncestorMatching<E extends AstNode>(bool Function(AstNode) predicate);
E? thisOrAncestorOfType<E extends AstNode>();
String toSource();
void visitChildren(AstVisitor visitor);
```

### AnnotatedNode implements AstNode
```dart
Comment? get documentationComment;
Token get firstTokenAfterCommentAndMetadata;
NodeList<Annotation> get metadata;
List<AstNode> get sortedCommentAndAnnotations;
```

### Declaration implements AnnotatedNode
```dart
Fragment? get declaredFragment;
```

### ClassMember (sealed) implements Declaration
*(No additional getters — marker type)*

### CompilationUnitMember implements Declaration
*(No additional getters — marker type)*

### NamedCompilationUnitMember implements CompilationUnitMember
```dart
Token get name;
```

### TypeAlias implements NamedCompilationUnitMember
```dart
Token? get augmentKeyword;
Token get semicolon;
Token get typedefKeyword;
```

### Directive (sealed) implements AnnotatedNode
*(No additional getters — marker type)*

### UriBasedDirective (sealed) implements Directive
```dart
StringLiteral get uri;
```

### NamespaceDirective (sealed) implements UriBasedDirective
```dart
NodeList<Combinator> get combinators;
NodeList<Configuration> get configurations;
Token get semicolon;
```

### CollectionElement (sealed) implements AstNode
*(No additional getters — marker type)*

### Expression implements CollectionElement
```dart
bool get canBeConst;
FormalParameterElement? get correspondingParameter;
bool get inConstantContext;
bool get isAssignable;
Precedence get precedence;
DartType? get staticType;
Expression get unParenthesized;
// methods
AttemptedConstantEvaluationResult? computeConstantValue();
```

### Literal (sealed) implements Expression
*(No additional getters beyond Expression)*

### TypedLiteral (sealed) implements Literal
```dart
Token? get constKeyword;
bool get isConst;
TypeArgumentList? get typeArguments;
```

### StringLiteral (sealed) implements Literal
```dart
String? get stringValue;
```

### SingleStringLiteral (sealed) implements StringLiteral
```dart
int get contentsEnd;
int get contentsOffset;
bool get isMultiline;
bool get isRaw;
bool get isSingleQuoted;
```

### Identifier (sealed) implements Expression, CommentReferableExpression
```dart
Element? get element;
String get name;
```

### InvocationExpression implements Expression
```dart
ArgumentList get argumentList;
Expression get function;
DartType? get staticInvokeType;
TypeArgumentList? get typeArguments;
List<DartType>? get typeArgumentTypes;
```

### CommentReferableExpression implements Expression
*(No additional getters — marker type)*

### MethodReferenceExpression implements Expression
```dart
MethodElement? get element;
```

### CompoundAssignmentExpression implements Expression
```dart
// (getters for read/write element exist in Impl, 
//  the abstract class declares the compound assignment contract)
```

### NullShortableExpression (@deprecated) implements Expression
```dart
Expression get nullShortingTermination;
```

### Statement implements AstNode
```dart
Statement get unlabeled;
```

### FormalParameter (sealed) implements AstNode
```dart
Token? get covariantKeyword;
FormalParameterFragment? get declaredFragment;
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
NodeList<Annotation> get metadata;
Token? get name;
Token? get requiredKeyword;
```

### NormalFormalParameter (sealed) implements FormalParameter, AnnotatedNode
*(Combines FormalParameter + AnnotatedNode; no new getters beyond those)*

### FunctionBody (sealed) implements AstNode
```dart
bool get isAsynchronous;
bool get isGenerator;
bool get isSynchronous;
Token? get keyword;
Token? get star;
// methods
bool isPotentiallyMutatedInScope(VariableElement variable);
bool isPotentiallyMutatedInScope2(VariableElement variable);
```

### TypeAnnotation (sealed) implements AstNode
```dart
Token? get question;
DartType? get type;
```

### DartPattern (sealed) implements AstNode, ListPatternElement
```dart
DartType? get matchedValueType;
PatternPrecedence get precedence;
DartPattern get unParenthesized;
```

### VariablePattern (sealed) implements DartPattern
```dart
Token get name;
```

### ForLoop<Body> (sealed, generic) implements AstNode
```dart
Token? get awaitKeyword;
Body get body;
Token get forKeyword;
ForLoopParts get forLoopParts;
Token get leftParenthesis;
Token get rightParenthesis;
```

### ForLoopParts (sealed) implements AstNode
```dart
ForLoop get parent;
```

### ForEachParts (sealed) implements ForLoopParts
```dart
Token get inKeyword;
Expression get iterable;
```

### ForParts (sealed) implements ForLoopParts
```dart
Expression? get condition;
Token get leftSeparator;
Token get rightSeparator;
NodeList<Expression> get updaters;
```

### Combinator (sealed) implements AstNode
```dart
Token get keyword;
```

### ConstructorInitializer (sealed) implements AstNode
*(No additional getters — marker type)*

### ConstructorReferenceNode implements AstNode
```dart
ConstructorElement? get element;
```

### SwitchMember (sealed) implements AstNode
```dart
Token get colon;
Token get keyword;
NodeList<Label> get labels;
NodeList<Statement> get statements;
```

### InterpolationElement (sealed) implements AstNode
*(No additional getters — marker type)*

### ListPatternElement (sealed) implements AstNode
*(No additional getters — marker type)*

### MapPatternElement (sealed) implements AstNode
*(No additional getters — marker type)*

### RecordTypeAnnotationField (sealed) implements AstNode
```dart
NodeList<Annotation> get metadata;
Token? get name;
TypeAnnotation get type;
```

### ClassBody (sealed) implements AstNode
*(No additional getters — marker type)*

### ClassNamePart (sealed) implements AstNode
*(No additional getters — marker type)*

### Assertion implements AstNode
```dart
Token get assertKeyword;
Expression get condition;
Token get leftParenthesis;
Expression? get message;
Token get rightParenthesis;
```

---

## Concrete-Level Getters (Key Classes)

### AdjacentStrings implements StringLiteral
```dart
NodeList<StringLiteral> get strings;
```

### Annotation implements AstNode
```dart
ArgumentList? get arguments;
Token get atSign;
SimpleIdentifier? get constructorName;
ConstructorElement? get element;
Element? get element2;
Identifier get name;
Token? get period;
TypeArgumentList? get typeArguments;
```

### ArgumentList implements AstNode
```dart
NodeList<Expression> get arguments;
Token get leftParenthesis;
Token get rightParenthesis;
```

### AsExpression implements Expression
```dart
Token get asOperator;
Expression get expression;
TypeAnnotation get type;
```

### AssertInitializer implements Assertion, ConstructorInitializer
*(only Assertion getters)*

### AssertStatement implements Assertion, Statement
```dart
Token get semicolon;
```

### AssignedVariablePattern implements VariablePattern
```dart
PromotableElement get element;
```

### AssignmentExpression implements NullShortableExpression, MethodReferenceExpression, CompoundAssignmentExpression
```dart
Expression get leftHandSide;
Token get operator;
Expression get rightHandSide;
```

### AwaitExpression implements Expression
```dart
Token get awaitKeyword;
Expression get expression;
```

### BinaryExpression implements Expression, MethodReferenceExpression
```dart
Expression get leftOperand;
Token get operator;
Expression get rightOperand;
```

### Block implements Statement
```dart
Token get leftBracket;
Token get rightBracket;
NodeList<Statement> get statements;
```

### BooleanLiteral implements Literal
```dart
Token get literal;
bool get value;
```

### BreakStatement implements Statement
```dart
Token get breakKeyword;
SimpleIdentifier? get label;
Token get semicolon;
AstNode? get target;
```

### CascadeExpression implements Expression, NullShortableExpression
```dart
NodeList<Expression> get cascadeSections;
bool get isNullAware;
Expression get target;
```

### CaseClause implements AstNode
```dart
GuardedPattern get guardedPattern;
Token get caseKeyword;
```

### CastPattern implements DartPattern
```dart
DartPattern get pattern;
TypeAnnotation get type;
```

### CatchClause implements AstNode
```dart
Block get body;
CatchClauseParameter? get exceptionParameter;
Token get leftParenthesis;
Token? get onKeyword;
Token get rightParenthesis;
CatchClauseParameter? get stackTraceParameter;
TypeAnnotation? get exceptionType;
```

### CatchClauseParameter extends AstNode
```dart
LocalVariableElement? get declaredElement;
Token get name;
```

### ClassDeclaration implements NamedCompilationUnitMember
```dart
Token? get abstractKeyword;
Token? get augmentKeyword;
Token? get baseKeyword;
ClassBody? get body;
Token get classKeyword;
ClassFragment? get declaredFragment;
ExtendsClause? get extendsClause;
Token? get finalKeyword;
ImplementsClause? get implementsClause;
Token? get interfaceKeyword;
Token get leftBracket;
Token? get macroKeyword;
NodeList<ClassMember> get members;
Token? get mixinKeyword;
ClassNamePart? get namePart;
Token get rightBracket;
Token? get sealedKeyword;
TypeParameterList? get typeParameters;
WithClause? get withClause;
```

### ClassTypeAlias implements TypeAlias
```dart
Token? get abstractKeyword;
ClassFragment? get declaredFragment;
ExtendsClause? get extendsClause;
ImplementsClause? get implementsClause;
bool get isAbstract;
TypeParameterList? get typeParameters;
WithClause get withClause;
```

### Comment implements AstNode
```dart
List<CommentReference> get references;
NodeList<CommentReference> get references2;
List<Token> get tokens;
CommentType get type;
```

### CommentReference implements AstNode
```dart
Expression get expression;
Token? get newKeyword;
```

### CompilationUnit implements AstNode
```dart
NodeList<CompilationUnitMember> get declarations;
NodeList<Directive> get directives;
CompilationUnitElement? get declaredElement;
LibraryFragment? get declaredFragment;
LanguageVersionToken? get languageVersionToken;
LineInfo get lineInfo;
ScriptTag? get scriptTag;
```

### ConditionalExpression implements Expression
```dart
Token get colon;
Expression get condition;
Expression get elseExpression;
Token get question;
Expression get thenExpression;
```

### Configuration implements AstNode
```dart
Token? get equalToken;
Token get ifKeyword;
Token get leftParenthesis;
DottedName get name;
DirectiveUri? get resolvedUri;
Token get rightParenthesis;
StringLiteral get uri;
StringLiteral? get value;
```

### ConstantPattern implements DartPattern
```dart
Token? get constKeyword;
Expression get expression;
```

### ConstructorDeclaration implements ClassMember
```dart
Token? get augmentKeyword;
FunctionBody get body;
Token? get constKeyword;
ConstructorFragment? get declaredFragment;
Token? get externalKeyword;
Token? get factoryKeyword;
NodeList<ConstructorInitializer> get initializers;
Token? get name;
FormalParameterList get parameters;
Token? get period;
ConstructorName? get redirectedConstructor;
Identifier get returnType;
Token? get separator;
```

### ConstructorFieldInitializer implements ConstructorInitializer
```dart
Token get equals;
Expression get expression;
SimpleIdentifier get fieldName;
Token? get period;
Token? get thisKeyword;
```

### ConstructorName implements AstNode, ConstructorReferenceNode
```dart
SimpleIdentifier? get name;
Token? get period;
NamedType get type;
```

### ConstructorReference implements Expression, CommentReferableExpression
```dart
ConstructorName get constructorName;
```

### ContinueStatement implements Statement
```dart
Token get continueKeyword;
SimpleIdentifier? get label;
Token get semicolon;
AstNode? get target;
```

### DeclaredIdentifier implements Declaration
```dart
LocalVariableElement? get declaredElement;
LocalVariableFragment? get declaredFragment;
bool get isConst;
bool get isFinal;
Token? get keyword;
Token get name;
TypeAnnotation? get type;
```

### DeclaredVariablePattern (sealed) implements VariablePattern
```dart
BindPatternVariableElement? get declaredElement;
BindPatternVariableFragment? get declaredFragment;
Token? get keyword;
TypeAnnotation? get type;
```

### DefaultFormalParameter implements FormalParameter
```dart
Expression? get defaultValue;
NormalFormalParameter get parameter;
Token? get separator;
```

### DoStatement implements Statement
```dart
Statement get body;
Expression get condition;
Token get doKeyword;
Token get leftParenthesis;
Token get rightParenthesis;
Token get semicolon;
Token get whileKeyword;
```

### DotShorthandConstructorInvocation extends InvocationExpression, implements ConstructorReferenceNode
```dart
Token? get constKeyword;
SimpleIdentifier get constructorName;
bool get isConst;
Token get period;
```

### DotShorthandInvocation extends InvocationExpression
```dart
SimpleIdentifier get memberName;
Token get period;
```

### DotShorthandPropertyAccess extends Expression
```dart
Token get period;
SimpleIdentifier get propertyName;
```

### DoubleLiteral implements Literal
```dart
Token get literal;
double get value;
```

### EnumConstantDeclaration implements Declaration
```dart
EnumConstantArguments? get arguments;
Token? get augmentKeyword;
ConstructorElement? get constructorElement;
FieldFragment? get declaredFragment;
Token get name;
```

### EnumDeclaration implements NamedCompilationUnitMember
```dart
Token? get augmentKeyword;
EnumBody? get body;
NodeList<EnumConstantDeclaration> get constants;
EnumFragment? get declaredFragment;
Token get enumKeyword;
ImplementsClause? get implementsClause;
ClassNamePart? get namePart;
TypeParameterList? get typeParameters;
WithClause? get withClause;
```

### ExportDirective implements NamespaceDirective
```dart
Token get exportKeyword;
LibraryExport? get libraryExport;
```

### ExpressionFunctionBody implements FunctionBody
```dart
Expression get expression;
Token get functionDefinition;
Token? get keyword;
Token? get semicolon;
Token? get star;
```

### ExpressionStatement implements Statement
```dart
Expression get expression;
Token? get semicolon;
```

### ExtensionDeclaration implements CompilationUnitMember
```dart
Token? get augmentKeyword;
BlockClassBody? get body;
ExtensionFragment? get declaredFragment;
Token get extensionKeyword;
NodeList<ClassMember> get members;
Token? get name;
ExtensionOnClause? get onClause;
Token? get typeKeyword;
TypeParameterList? get typeParameters;
```

### ExtensionOverride implements Expression
```dart
ArgumentList get argumentList;
ExtensionElement get element;
DartType? get extendedType;
ImportPrefixReference? get importPrefix;
bool get isNullAware;
Token get name;
TypeArgumentList? get typeArguments;
List<DartType>? get typeArgumentTypes;
```

### ExtensionTypeDeclaration implements NamedCompilationUnitMember
```dart
Token? get augmentKeyword;
ClassBody? get body;
Token? get constKeyword;
ExtensionTypeFragment? get declaredFragment;
Token get extensionKeyword;
ImplementsClause? get implementsClause;
NodeList<ClassMember> get members;
ClassNamePart? get namePart;
RepresentationDeclaration get representation;
Token get typeKeyword;
TypeParameterList? get typeParameters;
```

### FieldDeclaration implements ClassMember
```dart
Token? get abstractKeyword;
Token? get augmentKeyword;
Token? get covariantKeyword;
Token? get externalKeyword;
VariableDeclarationList get fields;
bool get isStatic;
Token get semicolon;
Token? get staticKeyword;
```

### FieldFormalParameter implements NormalFormalParameter
```dart
FieldFormalParameterFragment? get declaredFragment;
Token? get keyword;
Token get name;
FormalParameterList? get parameters;
Token get period;
Token? get question;
Token get thisKeyword;
TypeAnnotation? get type;
TypeParameterList? get typeParameters;
```

### ForEachPartsWithDeclaration implements ForEachParts
```dart
DeclaredIdentifier get loopVariable;
```

### ForEachPartsWithIdentifier implements ForEachParts
```dart
SimpleIdentifier get identifier;
```

### ForEachPartsWithPattern implements ForEachParts
```dart
Token get keyword;
NodeList<Annotation> get metadata;
DartPattern get pattern;
```

### ForPartsWithDeclarations implements ForParts
```dart
VariableDeclarationList get variables;
```

### ForPartsWithExpression implements ForParts
```dart
Expression? get initialization;
```

### ForPartsWithPattern implements ForParts
```dart
PatternVariableDeclaration get variables;
```

### FunctionDeclaration implements NamedCompilationUnitMember
```dart
Token? get augmentKeyword;
ExecutableFragment? get declaredFragment;
Token? get externalKeyword;
FunctionExpression get functionExpression;
bool get isGetter;
bool get isSetter;
Token? get propertyKeyword;
TypeAnnotation? get returnType;
```

### FunctionExpression implements Expression
```dart
FunctionBody get body;
ExecutableFragment? get declaredFragment;
FormalParameterList? get parameters;
TypeParameterList? get typeParameters;
```

### FunctionExpressionInvocation implements NullShortableExpression, InvocationExpression
```dart
ExecutableElement? get element;
Expression get function;
```

### FunctionReference implements Expression, CommentReferableExpression
```dart
Expression get function;
TypeArgumentList? get typeArguments;
List<DartType>? get typeArgumentTypes;
```

### FunctionTypeAlias implements TypeAlias
```dart
TypeAliasFragment? get declaredFragment;
FormalParameterList get parameters;
TypeAnnotation? get returnType;
TypeParameterList? get typeParameters;
```

### FunctionTypedFormalParameter implements NormalFormalParameter
```dart
Token get name;
FormalParameterList get parameters;
Token? get question;
TypeAnnotation? get returnType;
TypeParameterList? get typeParameters;
```

### GenericFunctionType implements TypeAnnotation
```dart
GenericFunctionTypeFragment? get declaredFragment;
Token get functionKeyword;
FormalParameterList get parameters;
TypeAnnotation? get returnType;
TypeParameterList? get typeParameters;
```

### GenericTypeAlias implements TypeAlias
```dart
Token get equals;
GenericFunctionType? get functionType;
TypeAnnotation get type;
TypeParameterList? get typeParameters;
```

### HideCombinator implements Combinator
```dart
NodeList<SimpleIdentifier> get hiddenNames;
```

### IfElement implements CollectionElement
```dart
CaseClause? get caseClause;
CollectionElement? get elseElement;
Token? get elseKeyword;
Expression get expression;
Token get ifKeyword;
Token get leftParenthesis;
Token get rightParenthesis;
CollectionElement get thenElement;
```

### IfStatement implements Statement
```dart
CaseClause? get caseClause;
Token? get elseKeyword;
Statement? get elseStatement;
Expression get expression;
Token get ifKeyword;
Token get leftParenthesis;
Token get rightParenthesis;
Statement get thenStatement;
```

### ImplicitCallReference implements MethodReferenceExpression
```dart
Expression get expression;
TypeArgumentList? get typeArguments;
List<DartType> get typeArgumentTypes;
```

### ImportDirective implements NamespaceDirective
```dart
Token? get asKeyword;
Token? get deferredKeyword;
Token get importKeyword;
LibraryImport? get libraryImport;
SimpleIdentifier? get prefix;
```

### IndexExpression implements NullShortableExpression, MethodReferenceExpression
```dart
Expression get index;
bool get isCascaded;
bool get isNullAware;
Token get leftBracket;
Token? get period;
Token? get question;
Expression get realTarget;
Token get rightBracket;
Expression? get target;
// methods
bool inGetterContext();
bool inSetterContext();
```

### InstanceCreationExpression implements Expression
```dart
ArgumentList get argumentList;
ConstructorName get constructorName;
bool get isConst;
Token? get keyword;
```

### IntegerLiteral implements Literal
```dart
Token get literal;
int? get value;
```

### InterpolationExpression implements InterpolationElement
```dart
Expression get expression;
Token get leftBracket;
Token? get rightBracket;
```

### InterpolationString implements InterpolationElement
```dart
Token get contents;
int get contentsEnd;
int get contentsOffset;
String get value;
```

### IsExpression implements Expression
```dart
Expression get expression;
Token get isOperator;
Token? get notOperator;
TypeAnnotation get type;
```

### LabeledStatement implements Statement
```dart
NodeList<Label> get labels;
Statement get statement;
```

### LibraryDirective implements Directive
```dart
LibraryElement? get element;
Token get libraryKeyword;
LibraryIdentifier? get name2;
Token get semicolon;
```

### LibraryIdentifier implements Identifier
```dart
NodeList<SimpleIdentifier> get components;
```

### ListLiteral implements TypedLiteral
```dart
NodeList<CollectionElement> get elements;
Token get leftBracket;
Token get rightBracket;
```

### ListPattern implements DartPattern
```dart
NodeList<ListPatternElement> get elements;
Token get leftBracket;
DartType? get requiredType;
Token get rightBracket;
TypeArgumentList? get typeArguments;
```

### MethodDeclaration implements ClassMember
```dart
Token? get augmentKeyword;
FunctionBody get body;
ExecutableFragment? get declaredFragment;
Token? get externalKeyword;
bool get isAbstract;
bool get isGetter;
bool get isOperator;
bool get isSetter;
bool get isStatic;
Token? get modifierKeyword;
Token get name;
Token? get operatorKeyword;
FormalParameterList? get parameters;
Token? get propertyKeyword;
TypeAnnotation? get returnType;
TypeParameterList? get typeParameters;
```

### MethodInvocation implements NullShortableExpression, InvocationExpression
```dart
bool get isCascaded;
bool get isNullAware;
SimpleIdentifier get methodName;
Token? get operator;
Expression? get realTarget;
Expression? get target;
```

### MixinDeclaration implements NamedCompilationUnitMember
```dart
Token? get augmentKeyword;
Token? get baseKeyword;
ClassBody? get body;
MixinFragment? get declaredFragment;
ImplementsClause? get implementsClause;
NodeList<ClassMember> get members;
Token get mixinKeyword;
MixinOnClause? get onClause;
TypeParameterList? get typeParameters;
```

### NamedExpression implements Expression
```dart
FormalParameterElement? get element;
Expression get expression;
Label get name;
```

### NamedType implements TypeAnnotation
```dart
Element? get element;
ImportPrefixReference? get importPrefix;
bool get isDeferred;
Token get name2;
DartType? get type;
TypeArgumentList? get typeArguments;
```

### NullLiteral implements Literal
```dart
Token get literal;
```

### ParenthesizedExpression implements Expression
```dart
Expression get expression;
Token get leftParenthesis;
Token get rightParenthesis;
```

### PatternAssignment implements Expression
```dart
Token get equals;
Expression get expression;
DartPattern get pattern;
```

### PostfixExpression implements Expression, NullShortableExpression, MethodReferenceExpression, CompoundAssignmentExpression
```dart
MethodElement? get element;
Expression get operand;
Token get operator;
```

### PrefixExpression implements Expression, NullShortableExpression, MethodReferenceExpression, CompoundAssignmentExpression
```dart
MethodElement? get element;
Expression get operand;
Token get operator;
```

### PrefixedIdentifier implements Identifier
```dart
SimpleIdentifier get identifier;
bool get isDeferred;
Token get period;
SimpleIdentifier get prefix;
```

### PropertyAccess implements NullShortableExpression, CommentReferableExpression
```dart
bool get isCascaded;
bool get isNullAware;
Token get operator;
SimpleIdentifier get propertyName;
Expression get realTarget;
Expression? get target;
```

### RecordLiteral implements Literal
```dart
Token? get constKeyword;
NodeList<Expression> get fields;
bool get isConst;
Token get leftParenthesis;
Token get rightParenthesis;
```

### RecordTypeAnnotation implements TypeAnnotation
```dart
Token get leftParenthesis;
RecordTypeAnnotationNamedFields? get namedFields;
NodeList<RecordTypeAnnotationPositionalField> get positionalFields;
Token get rightParenthesis;
```

### RedirectingConstructorInvocation implements ConstructorInitializer, ConstructorReferenceNode
```dart
ArgumentList get argumentList;
SimpleIdentifier? get constructorName;
Token? get period;
Token get thisKeyword;
```

### ReturnStatement implements Statement
```dart
Expression? get expression;
Token get returnKeyword;
Token get semicolon;
```

### SetOrMapLiteral implements TypedLiteral
```dart
NodeList<CollectionElement> get elements;
bool get isMap;
bool get isSet;
Token get leftBracket;
Token get rightBracket;
```

### ShowCombinator implements Combinator
```dart
NodeList<SimpleIdentifier> get shownNames;
```

### SimpleFormalParameter implements NormalFormalParameter
```dart
Token? get keyword;
TypeAnnotation? get type;
```

### SimpleIdentifier implements Identifier
```dart
bool get isQualified;
List<DartType>? get tearOffTypeArgumentTypes;
Token get token;
// methods
bool inDeclarationContext();
bool inGetterContext();
bool inSetterContext();
```

### SimpleStringLiteral implements SingleStringLiteral
```dart
Token get literal;
String get value;
```

### StringInterpolation implements SingleStringLiteral
```dart
NodeList<InterpolationElement> get elements;
InterpolationString get firstString;
InterpolationString get lastString;
```

### SuperExpression implements Expression
```dart
Token get superKeyword;
```

### SuperConstructorInvocation implements ConstructorInitializer, ConstructorReferenceNode
```dart
ArgumentList get argumentList;
SimpleIdentifier? get constructorName;
Token? get period;
Token get superKeyword;
```

### SuperFormalParameter implements NormalFormalParameter
```dart
SuperFormalParameterFragment? get declaredFragment;
Token? get keyword;
Token get name;
FormalParameterList? get parameters;
Token get period;
Token? get question;
Token get superKeyword;
TypeAnnotation? get type;
TypeParameterList? get typeParameters;
```

### SwitchCase implements SwitchMember
```dart
Expression get expression;
```

### SwitchExpression implements Expression
```dart
NodeList<SwitchExpressionCase> get cases;
Expression get expression;
Token get leftBracket;
Token get leftParenthesis;
Token get rightBracket;
Token get rightParenthesis;
Token get switchKeyword;
```

### SwitchStatement implements Statement
```dart
Expression get expression;
Token get leftBracket;
Token get leftParenthesis;
NodeList<SwitchMember> get members;
Token get rightBracket;
Token get rightParenthesis;
Token get switchKeyword;
```

### SymbolLiteral implements Literal
```dart
List<Token> get components;
Token get poundSign;
```

### ThisExpression implements Expression
```dart
Token get thisKeyword;
```

### ThrowExpression implements Expression
```dart
Expression get expression;
Token get throwKeyword;
```

### TopLevelVariableDeclaration implements CompilationUnitMember
```dart
Token? get augmentKeyword;
Token? get externalKeyword;
Token get semicolon;
VariableDeclarationList get variables;
```

### TryStatement implements Statement
```dart
Block get body;
NodeList<CatchClause> get catchClauses;
Block? get finallyBlock;
Token? get finallyKeyword;
Token get tryKeyword;
```

### TypeParameter implements Declaration
```dart
TypeAnnotation? get bound;
TypeParameterFragment? get declaredFragment;
Token? get extendsKeyword;
Token get name;
```

### VariableDeclaration implements Declaration
```dart
VariableFragment? get declaredFragment;
Token? get equals;
Expression? get initializer;
bool get isConst;
bool get isFinal;
bool get isLate;
Token get name;
```

### VariableDeclarationList implements AnnotatedNode
```dart
bool get isConst;
bool get isFinal;
bool get isLate;
Token? get keyword;
Token? get lateKeyword;
TypeAnnotation? get type;
NodeList<VariableDeclaration> get variables;
```

### VariableDeclarationStatement implements Statement
```dart
Token get semicolon;
VariableDeclarationList get variables;
```

### WhileStatement implements Statement
```dart
Statement get body;
Expression get condition;
Token get leftParenthesis;
Token get rightParenthesis;
Token get whileKeyword;
```

### WildcardPattern implements DartPattern
```dart
Token? get keyword;
Token get name;
TypeAnnotation? get type;
```

### YieldStatement implements Statement
```dart
Expression get expression;
Token get semicolon;
Token? get star;
Token get yieldKeyword;
```

---

## Mixins (Implementation-level, in ast.dart)

| Mixin | Applied on | Purpose |
|-------|-----------|---------|
| `AstNodeWithNameScopeMixin` | `AstNodeImpl` | Adds `Scope? nameScope` for resolution |
| `DotShorthandMixin` | `ExpressionImpl` | Shared behavior for dot-shorthand expressions |
| `_AnnotatedNodeMixin` | `AstNodeImpl` | Implements `AnnotatedNode` (comment + metadata storage) |

---

## Summary Statistics

| Category | Count |
|----------|-------|
| Total abstract/sealed types (non-Impl) | ~134 |
| Intermediate abstract types (not leaf) | ~32 |
| Leaf abstract final classes | ~102 |
| Sealed types (acting as interfaces) | ~25 |
| Mixins | 3 |
| Maximum hierarchy depth | 6 (SyntacticEntity → AstNode → CollectionElement → Expression → Literal → StringLiteral → SingleStringLiteral → SimpleStringLiteral) |

## Key Hierarchy Chains (Deepest Paths)

```
SyntacticEntity → AstNode → AnnotatedNode → Declaration → CompilationUnitMember → NamedCompilationUnitMember → TypeAlias → GenericTypeAlias
SyntacticEntity → AstNode → CollectionElement → Expression → Literal → StringLiteral → SingleStringLiteral → SimpleStringLiteral
SyntacticEntity → AstNode → CollectionElement → Expression → Literal → TypedLiteral → ListLiteral
SyntacticEntity → AstNode → AnnotatedNode → Directive → UriBasedDirective → NamespaceDirective → ImportDirective
SyntacticEntity → AstNode → AnnotatedNode → Declaration → ClassMember → MethodDeclaration
SyntacticEntity → AstNode → FormalParameter → NormalFormalParameter[+AnnotatedNode] → FieldFormalParameter
SyntacticEntity → AstNode → CollectionElement → Expression → InvocationExpression → MethodInvocation
SyntacticEntity → AstNode → ForLoopParts → ForEachParts → ForEachPartsWithDeclaration
SyntacticEntity → AstNode → DartPattern → VariablePattern → DeclaredVariablePattern
```

## Multiple Inheritance (Diamond) Patterns

Several classes implement multiple abstract types:

| Class | Implements |
|-------|-----------|
| `NormalFormalParameter` | `FormalParameter` + `AnnotatedNode` |
| `AssertInitializer` | `Assertion` + `ConstructorInitializer` |
| `AssertStatement` | `Assertion` + `Statement` |
| `AssignmentExpression` | `NullShortableExpression` + `MethodReferenceExpression` + `CompoundAssignmentExpression` |
| `PostfixExpression` | `Expression` + `NullShortableExpression` + `MethodReferenceExpression` + `CompoundAssignmentExpression` |
| `PrefixExpression` | `Expression` + `NullShortableExpression` + `MethodReferenceExpression` + `CompoundAssignmentExpression` |
| `IndexExpression` | `NullShortableExpression` + `MethodReferenceExpression` |
| `PropertyAccess` | `NullShortableExpression` + `CommentReferableExpression` |
| `MethodInvocation` | `NullShortableExpression` + `InvocationExpression` |
| `FunctionExpressionInvocation` | `NullShortableExpression` + `InvocationExpression` |
| `ConstructorName` | `AstNode` + `ConstructorReferenceNode` |
| `RedirectingConstructorInvocation` | `ConstructorInitializer` + `ConstructorReferenceNode` |
| `SuperConstructorInvocation` | `ConstructorInitializer` + `ConstructorReferenceNode` |
| `DotShorthandConstructorInvocation` | extends `InvocationExpression` + `ConstructorReferenceNode` |
| `MapPatternEntry` | `AstNode` + `MapPatternElement` |
| `DartPattern` | `AstNode` + `ListPatternElement` |
| `RestPatternElement` | `ListPatternElement` + `MapPatternElement` |
| `Identifier` | `Expression` + `CommentReferableExpression` |
| `ConstructorReference` | `Expression` + `CommentReferableExpression` |
| `FunctionReference` | `Expression` + `CommentReferableExpression` |
| `TypeLiteral` | `Expression` + `CommentReferableExpression` |
| `ForElement` | `CollectionElement` + `ForLoop<CollectionElement>` |
| `ForStatement` | `Statement` + `ForLoop<Statement>` |
