# D4rt — a sandboxed Dart interpreter and its ecosystem

D4rt runs **Dart as a scripting language**: it interprets Dart source at
runtime inside a permission-gated sandbox, with a bridging system that exposes
selected native Dart and Flutter APIs to the interpreted code. Scripts get the
language you already know — classes, generics, pattern matching, `async`/`await`,
streams, generators, extensions — without compiling, and without uncontrolled
access to the host.

This repository ([`al-the-bear/tom_d4rt`](https://github.com/al-the-bear/tom_d4rt))
holds the whole ecosystem: the interpreter, the bridge generator that wires
native libraries into scripts, the REPL/CLI tools, the Flutter integration, the
sample corpus, and the analyzer-free runtime used for the web. This document is
the **map**; each component has its own README and `doc/` folder for the detail.

> **New here?** Start with [`tom_d4rt`](tom_d4rt/README.md) (the interpreter)
> and the [`d4rt_introduction_sample`](tom_d4rt_samples/d4rt_introduction_sample/)
> (the shortest path from "installed" to "running a script").

---

## What you can do with D4rt

- **Embed a scripting engine** in a Dart or Flutter application — let users (or
  an LLM) supply Dart that your app evaluates safely at runtime.
- **Bridge your own libraries** so scripts can call native code through a typed,
  generated surface instead of reflection.
- **Script the shell** with a Dart-flavoured REPL (`dcli`).
- **Render Flutter UIs from source at runtime**, including on-the-fly / OTA UI
  updates that ship without an app-store release.

---

## Two execution families

D4rt ships in two execution families. The **source-based** family is the one
you reach for by default; the **analyzer-free** family is a complete alternative
that exists to unlock the web and over-the-air updates.

- **Source-based (analyzer)** — [`tom_d4rt`](tom_d4rt/README.md),
  [`tom_d4rt_dcli`](tom_d4rt_dcli/README.md),
  [`tom_d4rt_flutter`](tom_d4rt_flutter/README.md). Parses Dart source with the
  `analyzer` package and interprets it directly. **This is the stable reference
  and is usually the preferable choice.**
- **Analyzer-free (mirror AST)** — runs from pre-compiled `SAstNode` trees with
  **no analyzer dependency**, which is what makes it viable on the **web** (where
  the analyzer package is too large to ship) and for **on-the-fly / OTA UI
  updates**. It is otherwise a complete alternative, but because the generated
  AST bundles are large, the source-based interpreter is usually preferable
  unless the web/OTA constraint applies. This family is covered in
  [its own section below](#the-analyzer-free-family-web--ota) and kept in the
  background throughout the rest of this overview.

Each member of the source-based family has an analyzer-free twin; the pairings
are listed in that section.

---

## The components

Every package below has a README (linked) and, where applicable, a `doc/`
folder. Base path for all entries is this repository root.

### Interpreter (source-based)

| Package | What it is | Binary |
| --- | --- | --- |
| [`tom_d4rt`](tom_d4rt/README.md) | The reference interpreter. Two-pass evaluation over the analyzer AST, full sandbox/permission system, and the `BridgedClass` bridging core. Everything else builds on this. | `interpreter` |

### Bridging (family-agnostic tooling)

| Package | What it is | Binary |
| --- | --- | --- |
| [`tom_d4rt_generator`](tom_d4rt_generator/README.md) | The bridge generator. Reads `buildkit.yaml` / barrel files and emits `*.b.dart` `BridgedClass` registrations — relaxers, generic-constructor factories, proxy classes — so native libraries become callable from scripts. Drives the Flutter bridge surface. | `d4rtgen` |

The generator produces the bridges that both interpreter families consume, which
is why it is family-agnostic. Its [`doc/index.md`](tom_d4rt_generator/doc/index.md)
is the navigation hub for the bridging mechanism docs (categories A–D).

### REPL / CLI

| Package | What it is | Binary |
| --- | --- | --- |
| [`tom_d4rt_dcli`](tom_d4rt_dcli/README.md) | A Dart-flavoured shell REPL on the source-based interpreter, with DCli shell bridges, multiline input, history, replay files, and bot mode. Supports shebang launchers (`#!/usr/bin/env dcli`) and piped scripts. | `dcli` |

### Flutter integration (source-based)

| Package | What it is |
| --- | --- |
| [`tom_d4rt_flutter`](tom_d4rt_flutter/README.md) | `SourceFlutterD4rt` plus the generated Flutter Material bridge surface. Interpret a Dart script that builds a `Widget` tree and render it live inside a real `BuildContext`. |
| [`tom_d4rt_flutter_test`](tom_d4rt_flutter_test/README.md) | Interactive test/demo app for `tom_d4rt_flutter` — a sample-app runner, script playback, and an AI-assisted UI generator over a 37-sample corpus. |

### Conformance

| Package | What it is |
| --- | --- |
| [`tom_d4rt_test`](tom_d4rt_test/README.md) | Behavioural conformance suite for `tom_d4rt` (scaffold today). The same fixtures double as the cross-engine reference the analyzer-free twin must reproduce. |

### Samples

| Package | What it is |
| --- | --- |
| [`tom_d4rt_samples`](tom_d4rt_samples/) | Runnable, self-contained learning-path samples (see the [Samples](#samples) table below). |

---

## Getting started (source-based)

Add the interpreter and run a script:

```dart
import 'package:tom_d4rt/tom_d4rt.dart';

void main() {
  final d4rt = D4rt();
  final result = d4rt.execute(source: '''
    int fib(int n) => n < 2 ? n : fib(n - 1) + fib(n - 2);
    main() => fib(10);
  ''');
  print(result); // 55
}
```

From here:

- **Learn the language surface** — clone the
  [`d4rt_introduction_sample`](tom_d4rt_samples/d4rt_introduction_sample/) and
  run one of its examples directly. It uses nothing but the interpreter (no
  bridges, no host wiring) and includes shebang launchers.
- **Read the guide** — [`tom_d4rt/doc/d4rt_user_guide.md`](tom_d4rt/doc/d4rt_user_guide.md).

### Bridging a native library

To let scripts call your own Dart code, generate a bridge with
[`tom_d4rt_generator`](tom_d4rt_generator/README.md) (the `d4rtgen` CLI or a
`build_runner` step), then register the generated `*.b.dart` with the
interpreter. The [`d4rt_advanced_sample`](tom_d4rt_samples/d4rt_advanced_sample/)
bridges a native library end-to-end; the
[`d4rt_userbridges_sample`](tom_d4rt_samples/d4rt_userbridges_sample/) shows
hand-written `D4UserBridge` overrides for what the generator cannot infer. The
manual-registration reference is
[`tom_d4rt/doc/BRIDGING_GUIDE.md`](tom_d4rt/doc/BRIDGING_GUIDE.md), with the
deeper patterns in
[`advanced_bridging_user_guide.md`](tom_d4rt/doc/advanced_bridging_user_guide.md).

### Scripting the shell

Install and run the [`dcli`](tom_d4rt_dcli/README.md) REPL, or make a script
executable:

```bash
#!/usr/bin/env dcli
print('hello from a Dart shell script');
```

The [`d4rt_dcli_sample`](tom_d4rt_samples/d4rt_dcli_sample/) is a self-contained
scripting tour.

### Rendering a Flutter UI from source

With [`tom_d4rt_flutter`](tom_d4rt_flutter/README.md), interpret a script that
returns a widget tree and render it:

```dart
final runner = SourceFlutterD4rt();
final widget = runner.build<Widget>(uiScript, context); // top-level Widget build(BuildContext)
```

The [`d4rt_flutter_sample`](tom_d4rt_samples/d4rt_flutter_sample/) is a focused
Flutter-Material script; the
[`tom_d4rt_flutter_test`](tom_d4rt_flutter_test/README.md) app runs the full
sample corpus interactively.

---

## The analyzer-free family (web / OTA)

The analyzer-free family is the same interpreter and the same bridges, but
driven from a **pre-compiled mirror AST** instead of parsing source on the
device. Because it carries **no `analyzer` dependency**, it runs where the
analyzer cannot — most importantly the **web** — and it lets a server compile a
UI to a bundle that an app downloads and renders **without an app-store
release** (on-the-fly / OTA updates). The trade-off is bundle size, so prefer
the source-based family unless you need the web or OTA.

The flow is: *source → analyzer →
[`tom_ast_generator`](tom_ast_generator/README.md) → `SAstNode` JSON bundle →
interpret with [`tom_d4rt_ast`](tom_d4rt_ast/README.md)*. Each source-based
member has a twin here:

| Concern | Source-based (foreground) | Analyzer-free twin |
| --- | --- | --- |
| Interpreter core | [`tom_d4rt`](tom_d4rt/README.md) | [`tom_d4rt_ast`](tom_d4rt_ast/README.md) — pure-runtime interpreter + serializable AST (zero deps) |
| Execution entry / CLI | [`tom_d4rt`](tom_d4rt/README.md) | [`tom_d4rt_exec`](tom_d4rt_exec/README.md) — analyzer used only at parse time |
| Shell REPL | [`tom_d4rt_dcli`](tom_d4rt_dcli/README.md) (`dcli`) | [`tom_dcli_exec`](tom_dcli_exec/README.md) (`dclie`) |
| Flutter bridges | [`tom_d4rt_flutter`](tom_d4rt_flutter/README.md) | [`tom_d4rt_flutter_ast`](tom_d4rt_flutter_ast/README.md) — `FlutterD4rt`, web/OTA |

Supporting packages in this family:

| Package | What it is |
| --- | --- |
| [`tom_ast_model`](tom_ast_model/README.md) | The serializable AST **data model** — the `SAstNode` mirror of the analyzer AST, with JSON round-trip and structural equality. Data only; zero deps. |
| [`tom_ast_generator`](tom_ast_generator/README.md) | The analyzer-AST → mirror-AST 1:1 copier, the bundler, and the `astgen` CLI that emits the JSON bundles an app ships. |
| [`tom_d4rt_flutter_ast_test`](tom_d4rt_flutter_ast_test/README.md) | Test/demo app for `tom_d4rt_flutter_ast`, running 33 shared samples from pre-compiled `AstBundle`s — the web-safe counterpart to `tom_d4rt_flutter_test`. |

---

## Samples

Runnable, self-contained samples live in
[`tom_d4rt_samples/`](tom_d4rt_samples/), ordered as a learning path — each
introduces one new capability on top of the last.

| Sample | Introduces |
| --- | --- |
| [`d4rt_introduction_sample`](tom_d4rt_samples/d4rt_introduction_sample/) | Multi-file D4rt programs with nothing but the interpreter; shebang launchers. **Start here.** |
| [`d4rt_advanced_sample`](tom_d4rt_samples/d4rt_advanced_sample/) | Bridging a native Dart library into scripts via `tom_d4rt_generator`. |
| [`d4rt_userbridges_sample`](tom_d4rt_samples/d4rt_userbridges_sample/) | Hand-written `D4UserBridge` overrides for what the generator can't infer. |
| [`d4rt_dcli_sample`](tom_d4rt_samples/d4rt_dcli_sample/) | Shell scripting plus custom bridges via the `dcli` REPL. |
| [`d4rt_flutter_sample`](tom_d4rt_samples/d4rt_flutter_sample/) | Interpreting a live Flutter UI from source at runtime. |

---

## Documentation index

Each package keeps its user documentation in its own `doc/` folder; the READMEs
above link the relevant files. The most common entry points:

| Topic | Document |
| --- | --- |
| Interpreter usage | [`tom_d4rt/doc/d4rt_user_guide.md`](tom_d4rt/doc/d4rt_user_guide.md) |
| Bridging (manual) | [`tom_d4rt/doc/BRIDGING_GUIDE.md`](tom_d4rt/doc/BRIDGING_GUIDE.md) · [`advanced_bridging_user_guide.md`](tom_d4rt/doc/advanced_bridging_user_guide.md) |
| Bridge generator | [`tom_d4rt_generator/doc/index.md`](tom_d4rt_generator/doc/index.md) (navigation hub) |
| Interpreter limits | [`tom_d4rt/doc/d4rt_limitations.md`](tom_d4rt/doc/d4rt_limitations.md) |
| Flutter (source) | [`tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md`](tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md) |
| Execution entry (analyzer-free) | [`tom_d4rt_exec/doc/tom_d4rt_exec_user_guide.md`](tom_d4rt_exec/doc/tom_d4rt_exec_user_guide.md) |
| AST runtime (analyzer-free) | [`tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md`](tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md) |
| AST generator / bundling | [`tom_ast_generator/doc/tom_ast_generator_user_guide.md`](tom_ast_generator/doc/tom_ast_generator_user_guide.md) |
| Flutter (web/OTA) | [`tom_d4rt_flutter_ast/doc/tom_d4rt_flutter_ast_user_guide.md`](tom_d4rt_flutter_ast/doc/tom_d4rt_flutter_ast_user_guide.md) · [`creating_fully_dynamic_applications.md`](tom_d4rt_flutter_ast/doc/creating_fully_dynamic_applications.md) |

---

## Repository layout

```
tom_d4rt/              source-based reference interpreter        (foreground)
tom_d4rt_generator/    bridge generator (d4rtgen)               (tooling)
tom_d4rt_dcli/         dcli REPL on the source-based engine     (foreground)
tom_d4rt_flutter/      source-based Flutter Material bridges    (foreground)
tom_d4rt_flutter_test/ demo/test app for tom_d4rt_flutter
tom_d4rt_test/         conformance suite for tom_d4rt
tom_d4rt_samples/      runnable learning-path samples

tom_d4rt_ast/          analyzer-free interpreter + AST runtime  (background)
tom_ast_model/         serializable AST data model              (background)
tom_ast_generator/     analyzer→mirror AST copier + astgen CLI  (background)
tom_d4rt_exec/         analyzer-free execution entry            (background)
tom_dcli_exec/         dclie REPL on the analyzer-free engine   (background)
tom_d4rt_flutter_ast/  analyzer-free Flutter bridges (web/OTA)  (background)
tom_d4rt_flutter_ast_test/  demo/test app for tom_d4rt_flutter_ast
```

Dependency direction, simplified: the source-based stack roots at `tom_d4rt`;
the analyzer-free stack roots at the zero-dependency `tom_ast_model` →
`tom_d4rt_ast`, with `tom_ast_generator` / `tom_d4rt_exec` adding the
analyzer-backed parse-and-copy step. `tom_d4rt_generator` produces bridges
consumed by both stacks.

## License

See [`LICENSE.md`](LICENSE.md).
