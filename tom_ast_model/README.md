# tom_ast_model

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

A zero-dependency, serializable AST model for Dart source code — a complete mirror of the Dart analyzer's node hierarchy with JSON round-tripping and structural diffing.

## Overview

`tom_ast_model` provides a self-contained representation of the Dart AST that deliberately carries **no dependency on the `analyzer` package**. Every node in the Dart analyzer's AST hierarchy has a direct counterpart here, prefixed with `S` (for Serializable). Each concrete node implements `toJson()` / `fromJson()`, carries `offset` and `length` source position fields, and participates in a double-dispatch visitor.

The primary motivation is **on-device Dart interpretation and pre-compiled AST distribution**. The `analyzer` package is too large to ship inside a Flutter application. By separating the pure data model from the parsing and analysis machinery, a Dart source file can be parsed once on a server or build machine, serialized to JSON, bundled into an app asset, and then deserialized and evaluated at runtime — all without any analyzer dependency in the deployed binary.

The package is extracted from `tom_d4rt_ast`, the analyzer-free interpreter runtime, so that the AST data contract is versioned and shared independently of any execution engine.

### Data only — where interpretation lives

`tom_ast_model` is **pure data**. It defines the `SAstNode` tree, JSON
round-tripping, structural equality/diffing, and the visitor scaffolding — and
nothing else. It does **not** parse Dart source, and it does **not** execute
anything:

- **Producing** these trees from Dart source is owned by
  [`tom_ast_generator`](../tom_ast_generator/) (analyzer-based, build time).
- **Interpreting** these trees is owned by
  [`tom_d4rt_ast`](../tom_d4rt_ast/) (the analyzer-free runtime), which adds the
  `InterpreterVisitor`, `Environment`, bridging, and standard library on top of
  this model.

Keeping the data contract in its own zero-dependency package is what lets the
same `SAstNode` JSON flow from a build server into a Flutter app without
dragging either the analyzer or an interpreter into the dependency graph.

### Where it sits — the analyzer-free family

D4rt ships in **two execution families**. The **source-based** line
(`tom_d4rt`, `tom_d4rt_dcli`, `tom_d4rt_flutter`) parses Dart with the
`analyzer` package and is the **stable reference, usually the preferable
choice**. The **analyzer-free** line — `tom_ast_model`, `tom_d4rt_ast`,
`tom_ast_generator`, `tom_d4rt_exec`, `tom_dcli_exec`, `tom_d4rt_flutter_ast`
— runs from pre-compiled `SAstNode` trees with **no analyzer dependency**,
which is what makes it viable on the **web** (the analyzer is too large to
ship) and for **on-the-fly / OTA UI updates**. Because the generated AST
bundles are large, reach for the analyzer-free line only when that web/OTA
constraint applies. This package is the **foundation of that line** — every
analyzer-free package depends, directly or transitively, on the model defined
here.

## Installation

```bash
dart pub add tom_ast_model
```

Or add it manually to `pubspec.yaml`:

```yaml
dependencies:
  tom_ast_model: ^0.1.3
```

The only transitive dependency is `dart:convert` from the Dart SDK itself; there are no pub.dev dependencies.

## Features

- **Complete node hierarchy** — every significant node category from the Dart analyzer AST is represented:
  - `SCompilationUnit` — the root node for a full Dart file
  - Declarations: `SClassDeclaration`, `SMixinDeclaration`, `SEnumDeclaration`, `SExtensionDeclaration`, `SExtensionTypeDeclaration`, `SFunctionDeclaration`, `SMethodDeclaration`, `SConstructorDeclaration`, `SFieldDeclaration`, `SVariableDeclaration`, `SVariableDeclarationList`, `STopLevelVariableDeclaration`, `STypedefDeclaration`, `SEnumConstantDeclaration`, `SRepresentationDeclaration`
  - Statements: `SBlock`, `SIfStatement`, `SForStatement`, `SForEachStatement`, `SWhileStatement`, `SDoStatement`, `SSwitchStatement`, `STryStatement`, `SReturnStatement`, `SBreakStatement`, `SContinueStatement`, `SAssertStatement`, `SYieldStatement`, `SLabeledStatement`, `SEmptyStatement`, `SExpressionStatement`, `SVariableDeclarationStatement`, `SFunctionDeclarationStatement`, `SPatternVariableDeclarationStatement`
  - Expressions: `SBinaryExpression`, `SPrefixExpression`, `SPostfixExpression`, `SAssignmentExpression`, `SConditionalExpression`, `SMethodInvocation`, `SFunctionExpressionInvocation`, `SIndexExpression`, `SPropertyAccess`, `SSimpleIdentifier`, `SPrefixedIdentifier`, `SFunctionExpression`, `SInstanceCreationExpression`, `SThisExpression`, `SSuperExpression`, `SThrowExpression`, `SAwaitExpression`, `SAsExpression`, `SIsExpression`, `SCascadeExpression`, `SRethrowExpression`, `SNamedExpression`, `SParenthesizedExpression`, `SSwitchExpression`, `SFunctionReference`, `SConstructorReference`, `SPatternAssignment`, plus collection-control elements `SSpreadElement`, `SNullAwareElement`, `SIfElement`, `SForElement`
  - Literals: `SIntegerLiteral`, `SDoubleLiteral`, `SBooleanLiteral`, `SNullLiteral`, `SSimpleStringLiteral`, `SStringInterpolation`, `SAdjacentStrings`, `SListLiteral`, `SSetOrMapLiteral`, `SMapLiteralEntry`, `SSymbolLiteral`, `SRecordLiteral`, `SInterpolationExpression`, `SInterpolationString`
  - Type annotations: `SNamedType`, `SGenericFunctionType`, `SRecordTypeAnnotation`, `SRecordTypeField`, `STypeArgumentList`, `STypeParameterList`, `STypeParameter`
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

## Examples and next steps

This package is **infrastructure** — a data model consumed by the interpreter
and generator, not a runtime you write programs against — so it ships no sample
programs of its own. See [`example/README.md`](example/README.md), which points
at the three canonical sample homes for runnable D4rt scripts.

Where to go next depends on what you need:

- To **run** an `SAstNode` tree, move to [`tom_d4rt_ast`](../tom_d4rt_ast/) — the
  analyzer-free interpreter that consumes this model.
- To **produce** an `SAstNode` tree from Dart source, see
  [`tom_ast_generator`](../tom_ast_generator/).
- For the full **source → bundle → run** pipeline, see
  [`tom_d4rt_exec`](../tom_d4rt_exec/).
- For runnable language/bridging samples, see
  [`tom_d4rt_samples/`](../tom_d4rt_samples/) (e.g.
  [`d4rt_introduction_sample`](../tom_d4rt_samples/d4rt_introduction_sample/),
  [`d4rt_advanced_sample`](../tom_d4rt_samples/d4rt_advanced_sample/)).

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

## Further documentation

| Document | Purpose |
|----------|---------|
| [doc/tom_ast_model_user_guide.md](doc/tom_ast_model_user_guide.md) | Differences-only orientation: the model's shape, the four capabilities (typed tree, JSON round-trip, equality/diff, visitors), and the interpreter binding-hint fields. |
| [doc/tom_ast_model_limitations.md](doc/tom_ast_model_limitations.md) | Model-specific deltas (syntax-not-semantics, coverage tracking, JSON compatibility boundary); backlinks to the canonical interpreter limitations. |

This package adds no interpreter behaviour of its own — shared semantics and
language coverage are documented once in the base projects:

- [tom_d4rt User Guide](../tom_d4rt/doc/d4rt_user_guide.md) and
  [Limitations (canonical)](../tom_d4rt/doc/d4rt_limitations.md).
- [tom_ast_generator User Guide](../tom_ast_generator/doc/tom_ast_generator_user_guide.md)
  — produces these trees; [tom_d4rt_ast User Guide](../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md)
  — interprets them.

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

This is an early-stage package at version `0.1.3`, extracted from `tom_d4rt_ast` and first independently published at `0.1.0`. The API surface may evolve as the D4rt ecosystem matures.

- **Repository**: https://github.com/al-the-bear/tom_d4rt/tree/main/tom_ast_model
- **SDK requirement**: Dart `^3.10.4`
- **License**: see `LICENSE` in the repository

## Changelog

### 0.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder;
  `doc/` no longer ships machine-generated baselines or `last_testrun.json`.
  No code changes.

### 0.1.2

- Documentation: limitations and user guide updated; README aligned with the
  source-primary documentation reframe across the D4rt ecosystem.

### 0.1.1

- Add `StaticResolver` and the `resolvedSlot` / `declSlot` node fields that
  back the interpreter's slot-based variable resolution (static name → frame
  slot binding computed once, replacing per-access map lookups).
- Add `ForEachPartsWithPattern` support so pattern-destructuring `for-in`
  loops round-trip through the serializable AST.

### 0.1.0

- Initial release — extracted from `tom_d4rt_ast`
- Pure AST model classes with JSON serialization
- Zero external dependencies
