# tom_d4rt_exec Limitations (delta)

> **Delta file.** `tom_d4rt_exec` interprets through the same `tom_d4rt_ast`
> engine as the analyzer-based base, so all *interpreter* limitations are
> documented once in the canonical reference:
>
> **→ [tom_d4rt/doc/d4rt_limitations.md](../../tom_d4rt/doc/d4rt_limitations.md)**
>
> Every entry there applies identically here. This file lists only the
> limitations that are **specific to the exec entry point**. (Until this todo,
> this directory shipped a byte-identical 2880-line copy of the canon — that
> duplication is now replaced by this delta.)

## Entry-point-specific deltas

### E-1 — Not web-safe; analyzer + `dart:io` are compile-time dependencies

`tom_d4rt_exec` exists to *parse* Dart source, so it depends on the `analyzer`
package and on `dart:io` (file reads, `executeFile`). This is a host/build-time
tool — CLI, server, or CI. It is **not** the package to embed in a Flutter app
or a web build. For on-device / web execution, embed
[`tom_d4rt_ast`](../../tom_d4rt_ast/README.md) and run pre-built `AstBundle`s
produced here (or by `tom_ast_generator`). See
[tom_d4rt_ast_limitations.md](../../tom_d4rt_ast/doc/tom_d4rt_ast_limitations.md)
for the runtime-side deltas.

### E-2 — Parse errors surface at the analyzer boundary

Because parsing is delegated to the `analyzer` package, syntax errors are
reported by the analyzer front-end (as `SourceCodeD4rtException`) before the
interpreter runs, rather than by the interpreter itself. The accepted Dart
syntax therefore tracks the analyzer / Dart SDK version this package is built
against, not the interpreter's own node coverage.

### E-3 — Bundle / runtime version alignment

The `executeBundle` path skips the analyzer parse but shares the
`tom_d4rt_ast` runtime. An `AstBundle` produced by a newer `AstBundler` /
`tom_ast_generator` than the linked `tom_d4rt_ast` runtime may carry node kinds
or fields the runtime does not understand. Keep the generator and the runtime
version-aligned, and re-emit bundles after upgrading either (same constraint as
`tom_d4rt_ast` delta D-4).

## No other deltas

Beyond the three points above, `tom_d4rt_exec` has **no project-specific
interpreter limitations** — the source-execution surface is API-identical to
`tom_d4rt`, and the runtime behaviour is identical to `tom_d4rt_ast`. For
language-coverage gaps and the two long-standing `Won't Fix` items (records
with >9 positional fields; spawning interpreted closures across isolate
boundaries), see the canonical reference linked at the top.
