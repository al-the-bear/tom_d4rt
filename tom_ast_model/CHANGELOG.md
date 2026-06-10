## 0.1.1

- Add `StaticResolver` and the `resolvedSlot` / `declSlot` node fields that
  back the interpreter's slot-based variable resolution (static name → frame
  slot binding computed once, replacing per-access map lookups).
- Add `ForEachPartsWithPattern` support so pattern-destructuring `for-in`
  loops round-trip through the serializable AST.

## 0.1.0

- Initial release — extracted from `tom_d4rt_ast`
- Pure AST model classes with JSON serialization
- Zero external dependencies
