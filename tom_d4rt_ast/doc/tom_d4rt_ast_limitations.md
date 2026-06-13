# tom_d4rt_ast Limitations (delta)

> **Delta file.** `tom_d4rt_ast` shares its interpreter with the
> analyzer-based base, so all *interpreter* limitations are documented once in
> the canonical reference:
>
> **→ [tom_d4rt/doc/d4rt_limitations.md](../../tom_d4rt/doc/d4rt_limitations.md)**
>
> Every entry there applies identically here — the two packages are kept in
> strict 1:1 sync (`_copilot_guidelines/sync_with_tom_d4rt.md` enforces it).
> This file lists only the limitations that are **specific to the
> analyzer-free runtime**.

## Runtime-specific deltas

### D-1 — No on-device source parsing

`D4rtRunner` executes a pre-built `SAstNode` tree (`AstBundle`); it has **no
Dart source parser**. Converting `String` source → AST requires the `analyzer`
package and is intentionally kept out of this zero-dependency runtime. Produce
bundles ahead of time with `tom_ast_generator` (or `tom_d4rt_exec`, which wraps
it) on a developer machine or CI server.

- `runner.parseJson(jsonString)` accepts a serialized `SCompilationUnit` JSON
  string — **not** Dart source. It is a deserialization shortcut, not a parser.
- There is no analyzer-free equivalent of `tom_d4rt`'s `execute(source: ...)`
  or `eval(String)`. Use `executeBundleAs<T>` / `execute(ast: ...)`.

### D-2 — `dart:io` stdlib is unavailable on web

The platform-conditional stdlib entry point selects `stdlib_io.dart` on the VM
and `stdlib_web.dart` on web. The web variant registers **no `dart:io`
bridges** (`StdlibIo.register` is a no-op there). On a web build, scripts that
use `File`, `Directory`, `Process`, `Platform`, `stdout` / `stderr`,
`HttpClient`, or `Socket` will fail to resolve those symbols. Run such scripts
on the VM, or supply web-appropriate bridges (e.g. an HTTP client backed by
`package:http`/`fetch`) yourself.

This is a *platform* delta, not an interpreter-semantics delta — the same
script runs identically on the VM build of `tom_d4rt_ast` as on `tom_d4rt`.

### D-3 — Imports resolve against the bundle, not the filesystem

`AstModuleLoader` resolves `import` directives against the bundle's pre-loaded
module map with **zero file I/O**. There is no runtime equivalent of
`tom_d4rt`'s `basePath` / `allowFileSystemImports` filesystem-import mode: every
module a script imports must already be present in the `AstBundle`. Multi-module
programs are bundled together at build time by `tom_ast_generator`.

### D-4 — Bundle format compatibility

`AstBundle` carries a manifest format version. A bundle produced by a newer
`tom_ast_generator` than the embedded `tom_d4rt_ast` runtime may contain node
kinds or fields the runtime does not understand. Keep the generator and the
embedded runtime version-aligned, and re-emit bundles after upgrading either.

## No other deltas

Beyond the four points above, `tom_d4rt_ast` has **no project-specific
interpreter limitations**. For language coverage gaps, bridging edge cases, and
the two long-standing `Won't Fix` items (records with >9 positional fields;
spawning interpreted closures across isolate boundaries), see the canonical
reference linked at the top of this file.
