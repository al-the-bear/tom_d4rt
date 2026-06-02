## 0.1.0

- First public release on pub.dev.
- 1:1 converter from the Dart analyzer AST to the serializable mirror AST
  (`SAstNode` from `tom_ast_model`), node-for-node and field-for-field.
- AST bundling machinery: parse once with the analyzer, copy to the mirror
  AST, serialize to JSON, interpret later without the analyzer.
