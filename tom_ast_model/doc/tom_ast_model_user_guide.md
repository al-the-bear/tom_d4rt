# tom_ast_model User Guide

> **Differences-only guide (P1).** `tom_ast_model` is a **pure data model**.
> It carries **no interpreter, no analyzer, no bridges, and no execution
> engine** — only the serializable `SAstNode` tree, its JSON contract,
> structural equality, and the visitor surface. It is the *data contract* that
> the rest of the analyzer-free stack agrees on. For how that tree is produced
> and executed, read the neighbouring projects and treat them as authoritative:
>
> - [tom_ast_generator User Guide](../../tom_ast_generator/doc/tom_ast_generator_user_guide.md)
>   — **produces** `SAstNode` trees / `AstBundle`s from Dart source.
> - [tom_d4rt_ast User Guide](../../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md)
>   — **consumes** and interprets them on-device (no analyzer).
> - [tom_d4rt User Guide](../../tom_d4rt/doc/d4rt_user_guide.md) — the
>   interpreter execution model and language semantics (shared, unchanged).
>
> This guide documents only what is specific to this package: the model's
> shape, the serialization contract, and the few non-obvious fields. The README
> has the full node catalogue and code examples; this guide is the orientation.

## What this package is — and is not

`tom_ast_model` is a **1:1 mirror of the Dart analyzer's AST**, expressed as
plain, serializable Dart objects with **zero pub.dev dependencies** (the only
import is `dart:convert`). Every analyzer `AstNode` has a counterpart here
prefixed `S` (for *Serializable*): `SCompilationUnit`, `SClassDeclaration`,
`SMethodInvocation`, and so on, with the same inheritance ladder reproduced in
`ast_categories.dart`.

What it deliberately does **not** do:

| Not in this package | Lives in |
|---------------------|----------|
| Parsing Dart source → AST | `tom_ast_generator` (needs the analyzer) |
| Interpreting / evaluating the AST | `tom_d4rt_ast` runtime |
| Bridges, permissions, stdlib | `tom_d4rt_ast` / `tom_d4rt` |
| Type resolution, const-eval, semantic checks | the analyzer (host-side only) |

The whole point of the split is that a Flutter or web app can depend on
`tom_ast_model` (and the `tom_d4rt_ast` runtime) **without** pulling in the
heavyweight `analyzer` package. Parse once on a server/build machine, serialize
to JSON, ship the JSON, deserialize and run on-device.

## The four things the model gives you

Everything in this package is one of four capabilities. The README has the
worked examples; this is the map.

1. **A typed node tree.** Construct or hold an `SCompilationUnit` and walk its
   typed children (`declarations`, `directives`, statement/expression fields).
   Every node carries `offset` and `length` for source mapping.

2. **JSON round-trip.** `node.toJson()` → plain `Map<String, dynamic>` (null
   fields omitted for compactness); `SCompilationUnit.fromJson(map)` or
   `SAstNodeFactory.fromJson(map)` rebuilds it. Dispatch is keyed on a
   `"nodeType"` discriminator. An unrecognized `nodeType` deserializes to a
   lightweight `_SUnknownNode` rather than throwing — forward-compatibility for
   bundles produced by a newer model than the reader.

3. **Structural equality / diffing.** `a.equals(b, log)` compares two trees via
   their JSON form; `operator ==` delegates to it. Passing a `List<String> log`
   records every discrepancy as a JSON-path message
   (`$.declarations[0].name.name: main != greet`) — built for round-trip tests.

4. **Visitors.** `SAstVisitor<T>` (flat, one method per concrete node) and
   `GeneralizingSAstVisitor<T>` (category methods that chain up the analyzer's
   generalizing ladder, e.g. `visitSimpleIdentifier → visitIdentifier →
   visitExpression → visitNode`).

## Non-obvious fields — interpreter binding hints

Two model fields exist to *serve* the runtime even though the model never acts
on them itself. They are pure data the interpreter pre-computes and the model
faithfully round-trips:

- **`resolvedSlot` / `declSlot`** (with `StaticResolver` in
  `ast_scope_resolver.dart`) — slot-based variable-resolution hints. A static
  pass binds each name to a frame slot once, so the runtime replaces
  per-access map lookups with an index. The model just stores and serializes
  the slot numbers; it performs no resolution.
- **`ForEachPartsWithPattern`** — carries pattern-destructuring `for-in`
  loops through the serializable form.

If you are building tools *on top of* the model (linters, transformers,
diffing), you can usually ignore these — they are interpreter-internal.

## Limitations

See [tom_ast_model_limitations.md](tom_ast_model_limitations.md). The model
itself adds essentially no behavioural limitations beyond the serialization
contract; language-coverage gaps belong to the interpreter, documented in the
canonical [tom_d4rt limitations](../../tom_d4rt/doc/d4rt_limitations.md).
