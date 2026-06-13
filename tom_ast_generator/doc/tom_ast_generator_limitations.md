# tom_ast_generator Limitations (delta)

> **Delta file.** `tom_ast_generator` is a host-side **converter + bundler**;
> it runs no interpreted code, so the *interpreter* limitations do not apply to
> it directly — they apply to whatever runtime executes the bundles it
> produces. Those are documented once in the canonical reference:
>
> **→ [tom_d4rt/doc/d4rt_limitations.md](../../tom_d4rt/doc/d4rt_limitations.md)**
>
> A script bundled here is subject to every interpreter limitation listed
> there once it is run by `tom_d4rt_ast` / `tom_d4rt_exec`. This file lists
> only the limitations that are **specific to the conversion / bundling step**.

## Conversion / bundling deltas

### G-1 — Host/build-time only; analyzer + `dart:io` are compile-time deps

This package depends on the `analyzer` package (to parse source) and on
`dart:io` (to read files during bundling and to run the `astgen` CLI). It is a
**developer-machine / server / CI** tool and is **not** web-safe or intended to
be embedded on a device. The whole reason it exists is to keep the analyzer out
of the runtime: produce the `AstBundle` here, ship the JSON, and interpret it
with the analyzer-free [`tom_d4rt_ast`](../../tom_d4rt_ast/README.md).

### G-2 — Conversion is structural, not semantic

`AstConverter` performs a **1:1 syntactic copy** of the analyzer AST. It does
**not** resolve types, bind elements, run const-evaluation, or report semantic
errors. A program that parses but is semantically invalid (unresolved symbol,
type error) converts cleanly here and only fails later — at interpretation
time, or never if that path is not exercised. Treat `astgen` as "did it parse,"
not "is it correct."

### G-3 — Unknown node types degrade to a placeholder

A Dart syntax newer than this package's analyzer pin, or any node subtype the
converter does not yet handle, is emitted as a `_SUnknownNode` (carrying
offset, length, and the original runtime type name) rather than throwing. This
keeps partial conversion working, but such a node is inert at runtime. Keep the
converter's analyzer pin current with the Dart SDK you author against, and
watch for `_SUnknownNode` in output when adopting brand-new language features.

### G-4 — Bundle / runtime version alignment

An `AstBundle` produced here carries `SAstNode` kinds and fields defined by the
`tom_ast_model` / `tom_d4rt_ast` version this package is built against. A bundle
consumed by a runtime built against a *different* `tom_d4rt_ast` may carry node
kinds or fields the runtime does not understand (or miss ones it expects). Keep
the generator and the consuming runtime version-aligned, and re-emit bundles
after upgrading either (mirrors `tom_d4rt_ast` delta D-4 and `tom_d4rt_exec`
delta E-3).

### G-5 — `astgen` CLI batch-import fields are placeholders

The `include_imports`, `import_depth`, and `include_relative_imports` fields in
the CLI `buildkit.yaml` configuration are accepted but **not yet implemented**
on the CLI path — they are reserved for a future batch-import feature. The
`AstBundler` *API* already resolves recursive imports fully; the gap is only in
the file-to-file CLI conversion path. See the README "Status" section.

## No other deltas

Beyond the points above, `tom_ast_generator` adds no behavioural limitations of
its own — the language coverage of a bundled script is exactly the interpreter's
coverage, documented in the canonical reference linked at the top.
