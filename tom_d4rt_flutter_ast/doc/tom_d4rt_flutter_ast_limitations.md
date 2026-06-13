# tom_d4rt_flutter_ast — Limitations (delta)

This file lists only the limitations **specific to the analyzer-free,
bundle-driven Flutter runtime**. It is a delta on top of two upstream
sources, which it does not repeat:

- **Flutter bridge-adapter limits** (ticker mixins, enum/sealed
  exhaustiveness, abstract-class inheritance, `Actions`/`Intent` dispatch,
  isolates, platform-capability gaps) are **shared with the source-based
  runtime** → see
  [`tom_d4rt_flutter/doc/interpreter_limits_and_workarounds.md`](../../tom_d4rt_flutter/doc/interpreter_limits_and_workarounds.md).
- **Interpreter / language-level limits** are owned by the canon →
  [`tom_d4rt/doc/d4rt_limitations.md`](../../tom_d4rt/doc/d4rt_limitations.md).

The Flutter bridge surface, proxy/relaxer/user-bridge machinery, and the
registration order are identical to `tom_d4rt_flutter`, so every limitation
documented for the base also applies here. The deltas below are the only
ones introduced by the AST execution path.

---

## A-1 — No on-device source parsing

`FlutterD4rt` executes a pre-compiled `AstBundle`; it does **not** accept a
raw Dart source string at the render call. Source must be compiled to a
bundle first (`createBundleFromSource`, or downloaded as JSON). The
compile step still uses the `analyzer` package, so it runs **off-device / at
build time** — not on web and not on the device that renders the UI.

**Consequence.** Anything that depends on parsing source at the render site
(the base runtime's `buildMultiFile` / `buildProgram` disk/asset resolvers)
has no equivalent here. Multi-file programs must be compiled into a single
bundle that already embeds every transitive source.

## A-2 — Bundle ↔ runtime version alignment

An `AstBundle` is the serialized `SAstNode` model from `tom_ast_model`. A
bundle produced by one version of the AST toolchain must be executed by a
compatible runtime: the JSON shape is the compatibility boundary. When the
`SAstNode` model gains or changes fields, regenerate bundles rather than
shipping a stale one to a newer runtime (or vice-versa). For over-the-air
delivery this means the server's compiler and the app's embedded runtime
must track the same `tom_ast_model` / `tom_d4rt_ast` version.

## A-3 — Newer syntax degrades to unknown nodes

The bundle can only represent the syntax the AST model knows at compile
time; syntax newer than the model maps to a fallback node and will not
execute meaningfully. This mirrors `tom_ast_model`'s `_SUnknownNode`
behaviour — keep the compiler's `tom_ast_generator` / `tom_ast_model`
current. See
[`tom_ast_model/doc/tom_ast_model_limitations.md`](../../tom_ast_model/doc/tom_ast_model_limitations.md).

---

No other deltas beyond the Flutter base and the interpreter canon. If you hit
a limit not listed here, it belongs to one of the two upstream documents
linked above.
