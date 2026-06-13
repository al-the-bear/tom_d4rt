# tom_d4rt_exec User Guide

> **Thin entry-point guide.** `tom_d4rt_exec` runs the *same* interpreter as
> `tom_d4rt_ast` and is API-compatible with `tom_d4rt`. The Dart **language
> semantics**, bridge registration model, permission sandbox, and standard
> library are identical — read the base guides for those and treat them as
> authoritative:
>
> - [tom_d4rt User Guide](../../tom_d4rt/doc/d4rt_user_guide.md) — execution
>   model, `execute`/`eval`/`continuedExecute`, bridge registration,
>   permissions, extension registration & facades.
> - [tom_d4rt Bridging Guide](../../tom_d4rt/doc/BRIDGING_GUIDE.md) and
>   [Advanced Bridging Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md).
> - [tom_d4rt Limitations (canonical)](../../tom_d4rt/doc/d4rt_limitations.md);
>   this package's deltas are in
>   [tom_d4rt_exec_limitations.md](tom_d4rt_exec_limitations.md).
>
> This guide documents only what is **specific to the exec entry point**: the
> parse-via-analyzer → mirror-AST → interpret pipeline, and the bundle /
> typed-execute API.

## What `tom_d4rt_exec` is

`tom_d4rt_exec` is the **CLI and embedding entry point** that splits the two
responsibilities the original monolithic `tom_d4rt` bundled together:

| Step | Owner | Runtime cost |
|------|-------|--------------|
| Parse Dart **source** → analyzer AST | `analyzer` package (compile-time dep of *this* package only) | host/build-time |
| Mirror analyzer AST → serializable `SAstNode` tree | `tom_ast_generator` (`AstConverter`) | host/build-time |
| Interpret the `SAstNode` tree | `tom_d4rt_ast` (`InterpreterVisitor` / `D4rtRunner`) | runtime |

The interpreter never sees an `analyzer` type. That separation is what lets a
downstream Flutter app embed `tom_d4rt_ast` alone (no analyzer, web-safe) and
run pre-built bundles, while `tom_d4rt_exec` does the parsing on a developer
machine or server.

```
Dart source
   │  analyzer (host-only)
   ▼
analyzer AST
   │  tom_ast_generator AstConverter (1:1 structural copy)
   ▼
SCompilationUnit (mirror AST)
   │  tom_d4rt_ast InterpreterVisitor / D4rtRunner
   ▼
Execution result
```

## Execution from source

The source-execution surface mirrors `tom_d4rt` exactly — same parameters, same
behaviour. Import the package via `package:tom_d4rt_exec/d4rt.dart`:

```dart
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  final result = d4rt.execute(
    source: 'String greet(String n) => "Hello \$n";',
    name: 'greet',
    positionalArgs: ['World'],
  );
  print(result); // Hello World
}
```

| API | Behaviour |
|-----|-----------|
| `execute({source, name, positionalArgs, namedArgs, sources, ...})` | Fresh-context run; resets the global environment, parses, then calls the entry point. |
| `continuedExecute({source, name, ...})` | Adds declarations to the existing context without reset. |
| `eval(String)` | REPL-style expression/statement evaluation in the established context. |
| `executeFile(d4rt, path, {log})` | Reads a `.dart`/`.d4rt.dart` file from disk and resolves relative imports before running. Returns a `ScriptExecutionResult`. |
| `executeFileContinued(...)` / `executeSource(...)` | File/string variants that evaluate into an existing context. |

For the full semantics of these calls (argument passing, multi-file `sources`
maps, filesystem imports, permissions) see the
[tom_d4rt User Guide](../../tom_d4rt/doc/d4rt_user_guide.md) — they are identical.

## Bundle execution and the typed-execute API

The exec-specific addition over `tom_d4rt` is the **bundle path**: for tight
startup or Flutter hot-reload, pre-bundle scripts so the analyzer parse step is
eliminated at runtime. `AstBundler` is re-exported from `tom_ast_generator`.

```dart
// Build-time: produce a bundle once.
final bundler = AstBundler(config: AstBundlerConfig(/* … */));
final bundle = await bundler.bundle('path/to/entry.dart');

// Run-time: execute the bundle with no parse step.
final d4rt = D4rt();
// … register bridges …
final raw = d4rt.executeBundle(bundle);                 // dynamic result
final typed = d4rt.executeBundleAs<int>(bundle);        // routed through D4.unwrapAs<int>
final fut = await d4rt.executeBundleAsAsync<String>(bundle);
```

`executeBundleAs<T>` / `executeBundleAsAsync<T>` forward to
`D4rtRunner.executeBundleAs` so the unwrap path is identical to `tom_d4rt_ast`:
the raw interpreter result is converted to a native value and cast with
`D4.unwrapAs<T>`, throwing `D4UnwrapException` on mismatch. This is the same
typed surface a Flutter app uses on `tom_d4rt_ast` — see the
[tom_d4rt_ast User Guide](../../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md).
The canonical contract for the typed-execute API (parameters, the unwrap
coercion rules, and how `finalizeBridges` ties in) lives in
[tom_d4rt_ast → Extension registration → Typed-execute API](../../tom_d4rt_ast/doc/extension_registration.md#typed-execute-api).

### Extension registration, warmup

`registerExtensions` / `finalizeBridges` and `warmup()` behave exactly as on the
base interpreter and on `D4rtRunner`. Both the source-direct `execute` path and
the `executeBundle` path call `finalizeBridges()` implicitly on first run.
`warmup()` here warms **both** halves — the analyzer front-end (by parsing +
executing a trivial throwaway script) *and* the bridge/stdlib registration —
unlike `D4rtRunner.warmup()`, which has no parser to warm.

```dart
final d4rt = D4rt();
// … register all bridges / extensions …
d4rt.warmup();                       // analyzer + bridge/stdlib warm
final w = d4rt.executeBundleAs<int>(bundle);
```

See [tom_d4rt User Guide → Extension Registration and Facades](../../tom_d4rt/doc/d4rt_user_guide.md#extension-registration-and-facades)
for the full contract, including the `registerRelaxerFactory` /
`registerInterfaceProxy` / `registerGenericConstructor` facades, which exec
exposes unchanged.

## Import surface

| Import | Purpose |
|--------|---------|
| `package:tom_d4rt_exec/d4rt.dart` | Full public API. |
| `package:tom_d4rt_exec/tom_d4rt.dart` | Compatibility re-export so bridge files generated for `tom_d4rt` (which import `tom_d4rt/tom_d4rt.dart`) work unchanged against exec. |
| `package:tom_d4rt_exec/tom_d4rt_exec.dart` | Convenience re-export of `d4rt.dart`. |

## Migrating from tom_d4rt

A bridge package or embedder built against `tom_d4rt` migrates by changing the
import from `package:tom_d4rt/tom_d4rt.dart` to
`package:tom_d4rt_exec/tom_d4rt.dart`. The public API is identical; the
difference is internal (analyzer is now confined to the parse step, and the
bundle path becomes available).
