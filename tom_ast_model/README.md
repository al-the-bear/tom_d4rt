# Tom Ast Model

Serializable AST model for Dart source code.

A complete, self-contained AST representation with JSON serialization — independent of the Dart analyzer and any interpreter runtime.

## Features

- Full Dart AST node hierarchy (`SAstNode` and subclasses)
- JSON serialization/deserialization for all node types
- Visitor pattern support (`SAstVisitor`, `SAstGeneralizingVisitor`)
- Zero external dependencies (only `dart:convert`)

## Usage

```dart
import 'package:tom_ast_model/tom_ast_model.dart';

// Deserialize an AST compilation unit from JSON
final unit = SCompilationUnit.fromJson(jsonMap);

// Serialize back to JSON
final json = unit.toJson();

// Use the visitor pattern
class MyVisitor extends SAstVisitor<void> {
  @override
  void visitFunctionDeclaration(SFunctionDeclaration node) {
    print('Found function: ${node.name}');
    super.visitFunctionDeclaration(node);
  }
}
```

## Package Structure

| File | Description |
|------|-------------|
| `ast_core.dart` | Base AST nodes, `SCompilationUnit`, serialization |
| `ast_declarations.dart` | Class, function, variable declarations |
| `ast_statements.dart` | Control flow, blocks, return statements |
| `ast_expressions.dart` | Method calls, operators, conditionals |
| `ast_literals.dart` | String, int, double, bool, list, map literals |
| `ast_types.dart` | Type annotations, generics |
| `ast_directives.dart` | Import, export, part directives |
| `ast_patterns.dart` | Dart 3.0+ pattern matching nodes |
| `ast_misc.dart` | Miscellaneous support nodes |
| `ast_visitor.dart` | Visitor pattern base classes |
| `ast_categories.dart` | Abstract category base classes |
