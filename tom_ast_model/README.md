# tom_ast_model

A zero-dependency, serializable AST model for Dart source code — a complete mirror of the Dart analyzer's node hierarchy with JSON round-tripping and structural diffing.

## Overview

`tom_ast_model` provides a self-contained representation of the Dart AST that deliberately carries **no dependency on the `analyzer` package**. Every node in the Dart analyzer's AST hierarchy has a direct counterpart here, prefixed with `S` (for Serializable). Each concrete node implements `toJson()` / `fromJson()`, carries `offset` and `length` source position fields, and participates in a double-dispatch visitor.

The primary motivation is **on-device Dart interpretation and pre-compiled AST distribution**. The `analyzer` package is too large to ship inside a Flutter application. By separating the pure data model from the parsing and analysis machinery, a Dart source file can be parsed once on a server or build machine, serialized to JSON, bundled into an app asset, and then deserialized and evaluated at runtime — all without any analyzer dependency in the deployed binary.

The package is extracted from `tom_d4rt_ast`, the analyzer-free interpreter runtime, so that the AST data contract is versioned and shared independently of any execution engine.

## Installation

```bash
dart pub add tom_ast_model
```

Or add it manually to `pubspec.yaml`:

```yaml
dependencies:
  tom_ast_model: ^0.1.0
```

The only transitive dependency is `dart:convert` from the Dart SDK itself; there are no pub.dev dependencies.

## Features

- **Complete node hierarchy** — every significant node category from the Dart analyzer AST is represented:
  - `SCompilationUnit` — the root node for a full Dart file
  - Declarations: `SClassDeclaration`, `SMixinDeclaration`, `SEnumDeclaration`, `SExtensionDeclaration`, `SExtensionTypeDeclaration`, `SFunctionDeclaration`, `SMethodDeclaration`, `SConstructorDeclaration`, `SFieldDeclaration`, `SVariableDeclaration`, `SVariableDeclarationList`, `STopLevelVariableDeclaration`, `STypedefDeclaration`, `SEnumConstantDeclaration`, `SRepresentationDeclaration`
  - Statements: `SBlock`, `SIfStatement`, `SForStatement`, `SForEachStatement`, `SWhileStatement`, `SDoStatement`, `SSwitchStatement`, `STryStatement`, `SReturnStatement`, `SBreakStatement`, `SContinueStatement`, `SAssertStatement`, `SYieldStatement`, `SLabeledStatement`, `SEmptyStatement`, `SExpressionStatement`, `SVariableDeclarationStatement`, `SFunctionDeclarationStatement`, `SPatternVariableDeclarationStatement`
  - Expressions: `SBinaryExpression`, `SPrefixExpression`, `SPostfixExpression`, `SAssignmentExpression`, `SConditionalExpression`, `SMethodInvocation`, `SFunctionExpressionInvocation`, `SIndexExpression`, `SPropertyAccess`, `SSimpleIdentifier`, `SPrefixedIdentifier`, `SFunctionExpression`, `SInstanceCreationExpression`, `SThisExpression`, `SSuperExpression`, `SThrowExpression`, `SAwaitExpression`, `SAsExpression`, `SIsExpression`, `SCascadeExpression`, `SRethrowExpression`, `SNamedExpression`, `SParenthesizedExpression`, `SSwitchExpression`, `SFunctionReference`, `SConstructorReference`, `SPatternAssignment`, plus collection-control elements `SSpreadElement`, `SNullAwareElement`, `SIfElement`, `SForElement`
  - Literals: `SIntegerLiteral`, `SDoubleLiteral`, `SBooleanLiteral`, `SNullLiteral`, `SSimpleStringLiteral`, `SStringInterpolation`, `SAdjacentStrings`, `SListLiteral`, `SSetOrMapLiteral`, `SMapLiteralEntry`, `SSymbolLiteral`, `SRecordLiteral`, `SInterpolationExpression`, `SInterpolationString`
  - Type annotations: `SNamedType`, `SGenericFunctionType`, `SRecordTypeAnnotation`, `STypeArgumentList`, `STypeParameterList`, `STypeParameter`
  - Directives: `SImportDirective`, `SExportDirective`, `SPartDirective`, `SPartOfDirective`, `SLibraryDirective`
  - Patterns (Dart 3.0+): `SConstantPattern`, `SWildcardPattern`, `SDeclaredVariablePattern`, `SAssignedVariablePattern`, `SObjectPattern`, `SListPattern`, `SMapPattern`, `SRecordPattern`, `SLogicalOrPattern`, `SLogicalAndPattern`, `SCastPattern`, `SRelationalPattern`, `SNullCheckPattern`, `SNullAssertPattern`, `SParenthesizedPattern`, `SGuardedPattern`, `SWhenClause`, `SCaseClause`, `SSwitchPatternCase`, `SSwitchExpressionCase`, `SRestPatternElement`, `SPatternVariableDeclaration`, `SPatternField`, `SPatternFieldName`, `SMapPatternEntry`
  - Miscellaneous support nodes: `SArgumentList`, `SAnnotation`, `SComment`, `SToken`, `SFormalParameterList`, `SSimpleFormalParameter`, `SDefaultFormalParameter`, `SFieldFormalParameter`, `SFunctionTypedFormalParameter`, `SSuperFormalParameter`, `SBlockFunctionBody`, `SExpressionFunctionBody`, `SEmptyFunctionBody`, `SNativeFunctionBody`, `SConstructorName`, `SSuperConstructorInvocation`, `SRedirectingConstructorInvocation`, `SConstructorFieldInitializer`, `SAssertInitializer`, `SExtendsClause`, `SImplementsClause`, `SWithClause`, `SOnClause`, `SShowCombinator`, `SHideCombinator`, `SLabel`, `SDeclaredIdentifier`, `SForPartsWithDeclarations`, `SForPartsWithExpression`, `SForEachPartsWithDeclaration`, `SForEachPartsWithIdentifier`, `SForEachPartsWithPattern`, `SSwitchCase`, `SSwitchDefault`, `SCatchClause`

- **JSON round-tripping** — every node serializes to a plain `Map<String, dynamic>` via `toJson()` and deserializes through `SAstNodeFactory.fromJson()` with automatic dispatch on the `"nodeType"` discriminator field

- **Structural equality and diffing** — `SAstNode.equals(other, [log])` compares two trees via their JSON representations; an optional `List<String>` collects human-readable difference messages using JSON-path notation (`$.declarations[0].name`)

- **Visitor pattern** — two visitor base classes cover all node types:
  - `SAstVisitor<T>` — flat visitor; all methods default to `visitNode(node)` which returns `null`
  - `GeneralizingSAstVisitor<T>` — mirrors the analyzer's generalizing visitor; overriding a category method (e.g. `visitExpression`) handles all subtypes automatically

- **Token model** — `SToken` captures `offset`, `length`, `lexeme`, and `tokenType` with its own `equals()` and `toJson()`/`fromJson()`

- **Unknown-node recovery** — `SAstNodeFactory.fromJson()` returns a lightweight `_SUnknownNode` for any unrecognized `nodeType`, enabling forward compatibility

- **Zero external dependencies** — only `dart:convert`

## Usage

### Deserializing a pre-compiled AST

When a tool such as `tom_ast_generator` converts analyzer output to JSON, the result is fed into `SAstNodeFactory.fromJson()` or directly into `SCompilationUnit.fromJson()`:

```dart
import 'dart:convert';
import 'package:tom_ast_model/tom_ast_model.dart';

// Load a pre-serialized AST (e.g., from an app asset)
final String jsonString = await rootBundle.loadString('assets/my_script.ast.json');
final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;

final SCompilationUnit unit = SCompilationUnit.fromJson(jsonMap);

print('Directives : ${unit.directives.length}');
print('Declarations: ${unit.declarations.length}');
```

### JSON round-trip

```dart
import 'dart:convert';
import 'package:tom_ast_model/tom_ast_model.dart';

// Construct a minimal compilation unit by hand
final unit = SCompilationUnit(
  offset: 0,
  length: 42,
  declarations: [
    SFunctionDeclaration(
      offset: 0,
      length: 42,
      name: SSimpleIdentifier(offset: 9, length: 4, name: 'main'),
    ),
  ],
);

// Serialize
final Map<String, dynamic> jsonMap = unit.toJson();
final String prettyJson = unit.toJsonString(pretty: true);

// Deserialize
final SCompilationUnit restored = SCompilationUnit.fromJson(jsonMap);

// Structural equality
assert(unit == restored);
```

### Structural diffing

```dart
final List<String> diffs = [];
final bool identical = unit.equals(other, diffs);
if (!identical) {
  for (final d in diffs) {
    print(d);
    // e.g. "$.declarations[0].name.name: main != greet"
  }
}
```

### Visitor pattern

```dart
import 'package:tom_ast_model/tom_ast_model.dart';

// Flat visitor — override only what you need
class FunctionCollector extends SAstVisitor<void> {
  final List<String> names = [];

  @override
  void visitFunctionDeclaration(SFunctionDeclaration node) {
    final n = node.name?.name;
    if (n != null) names.add(n);
    node.visitChildren(this);
  }

  @override
  void visitMethodDeclaration(SMethodDeclaration node) {
    final n = node.name?.name;
    if (n != null) names.add(n);
    node.visitChildren(this);
  }
}

final collector = FunctionCollector();
unit.accept(collector);
print(collector.names);
```

```dart
// Generalizing visitor — override a category to catch all subtypes
class LiteralCounter extends GeneralizingSAstVisitor<void> {
  int count = 0;

  @override
  void visitLiteral(SLiteral node) {
    count++;
    node.visitChildren(this);
  }
}

final counter = LiteralCounter();
unit.accept(counter);
print('Literals found: ${counter.count}');
```

### Working with the factory directly

```dart
// Deserialize any node whose type is not known at compile time
final SAstNode? node = SAstNodeFactory.fromJson(rawMap);

// Deserialize a typed list
final List<SStatement> stmts =
    SAstNodeFactory.listFromJson<SStatement>(rawList);
```

## Architecture and Key Concepts

### SAstNode — the universal base

Every node in the model extends `SAstNode`, which mandates:

- `String get nodeType` — the discriminator string used during deserialization (e.g. `'ClassDeclaration'`)
- `int get offset` / `int get length` — source position in the original file
- `Map<String, dynamic> toJson()` — self-serialization
- `String toJsonString({bool pretty})` — convenience wrapper around `dart:convert`
- `bool equals(Object other, [List<String>? log])` — deep structural comparison via JSON diff
- `T? accept<T>(SAstVisitor<T> visitor)` — double-dispatch entry point
- `void visitChildren(SAstVisitor visitor)` — iterates over direct child nodes

`operator ==` delegates to `equals()` so nodes can be compared with `==` directly.

### 1:1 mapping with the analyzer AST

The class hierarchy mirrors the Dart analyzer's `AstNode` hierarchy at every level. The abstract intermediate types in `ast_categories.dart` reproduce the same inheritance ladder (`SAnnotatedNode`, `SDeclaration`, `SCompilationUnitMember`, `SNamedCompilationUnitMember`, `SExpression`, `SLiteral`, `STypedLiteral`, `SStringLiteral`, `SSingleStringLiteral`, `SDirective`, `SNamespaceDirective`, `SFormalParameter`, `SNormalFormalParameter`, `SFunctionBody`, `STypeAnnotation`, `SDartPattern`, `SVariablePattern`, `SForLoopParts`, `SForEachParts`, `SForParts`, etc.) so that interpreter or analysis code written against the analyzer hierarchy can be ported with minimal friction.

### JSON serialization contract

Each node serializes to an object that always includes a `"nodeType"` string key. `SAstNodeFactory` maintains a registry of `String -> fromJson` factory functions, initialized lazily on first use. Deserialization dispatches on `"nodeType"` and falls through to `_SUnknownNode` for any key not in the registry.

Child nodes are embedded as nested objects; lists of children are JSON arrays. Optional fields are omitted from `toJson()` output when `null`, keeping payloads compact.

### Structural equality and diffing

`SAstNode.equals()` serializes both sides to `Map<String, dynamic>` and recursively compares the maps. When a `List<String> log` is passed, every discrepancy is recorded as a JSON-path string:

```
$.declarations[1].members[0].body.statements[2].expression.operator: + != -
```

This is useful for test assertions and round-trip verification.

### Visitor hierarchy

`SAstVisitor<T>` is a flat interface with one method per concrete node type, all defaulting to `visitNode(node)`. `GeneralizingSAstVisitor<T>` extends it with category-level methods that chain up to their parent category, reproducing the delegation ladder documented in the analyzer. The full chain for, say, `SSimpleIdentifier` is:

```
visitSimpleIdentifier → visitIdentifier → visitExpression
    → visitCollectionElement → visitNode
```

## Where it fits in the D4rt ecosystem

```
tom_ast_model            (this package — zero-dep serializable AST model)
    ^
    |  consumed by
tom_d4rt_ast             (analyzer-free interpreter runtime and eval engine)
    ^
    |  produced by
tom_ast_generator        (1:1 analyzer-AST to mirror-AST converter; requires analyzer)
    ^
    |  entry point
tom_d4rt_exec            (analyzer-free interpreter exec entry point)
    ^
    |
tom_dcli_exec            (analyzer-free DCli CLI)
```

Separately, `tom_d4rt` is the original analyzer-based interpreter and `tom_d4rt_generator` is the D4rt bridge generator. `tom_ast_model` lives at the bottom of the analyzer-free chain so it can be used in Flutter apps and other contexts where the `analyzer` package cannot be included.

## Status and Repository

This is an early-stage package at version `0.1.0`, extracted from `tom_d4rt_ast` as its first independent public release. The API surface may evolve as the D4rt ecosystem matures.

- **Repository**: https://github.com/al-the-bear/tom_d4rt/tree/main/tom_ast_model
- **SDK requirement**: Dart `^3.10.4`
- **License**: see `LICENSE` in the repository

## Changelog

### 0.1.0

- Initial release — extracted from `tom_d4rt_ast`
- Pure AST model classes with JSON serialization
- Zero external dependencies
