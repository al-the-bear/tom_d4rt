## 0.1.1

- Consume `tom_ast_model ^0.1.1` / `tom_d4rt_ast ^0.1.5`: the converter now
  populates the `StaticResolver` slot-resolution members
  (`resolvedSlot` / `declSlot`) on the mirror AST it emits.

## 0.1.0

- First public release on pub.dev.
- 1:1 converter from the Dart analyzer AST to the serializable mirror AST
  (`SAstNode` from `tom_ast_model`), node-for-node and field-for-field.
- AST bundling machinery: parse once with the analyzer, copy to the mirror
  AST, serialize to JSON, interpret later without the analyzer.
