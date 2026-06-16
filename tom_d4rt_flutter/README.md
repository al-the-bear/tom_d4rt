# tom_d4rt_flutter

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

> Source-based D4rt interpreter with the full Flutter Material bridge surface —
> renders interpreted Dart UI against **real Flutter widgets**.

`tom_d4rt_flutter` is the reusable library at the centre of the Flutter-facing
D4rt stack, and the **primary, recommended** way to run interpreted Dart UI on
Flutter. It exposes `SourceFlutterD4rt`: a `tom_d4rt` interpreter pre-loaded
with the full generated Flutter Material bridge surface (17 generated bridge
files under `lib/src/bridges/`) plus hand-written runtime registrations
(interface proxies, type relaxers, generic factories) and the
`d4rt_user_bridges/` overrides. Feed it raw Dart source and it returns a live
`Widget`.

> **Start here for Flutter + D4rt.** Use this source-based package for desktop
> and mobile development — it parses Dart source directly and has the simplest
> workflow.

### Source-based vs analyzer-free — which D4rt family

D4rt ships in two execution families, and `tom_d4rt_flutter` is the
**source-based** Flutter member:

- **Source-based (analyzer)** — `tom_d4rt`, `tom_d4rt_dcli`,
  **`tom_d4rt_flutter`**. Parses Dart source with the analyzer, giving full
  type inference and precise error reporting. This is the **stable reference
  and usually the preferable choice** for desktop and mobile.
- **Analyzer-free (mirror AST)** — `tom_d4rt_ast`, `tom_ast_model`,
  `tom_ast_generator`, `tom_d4rt_exec`, `tom_dcli_exec`,
  **[`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast)** (`FlutterD4rt`). Runs
  from pre-compiled `SAstNode` bundles with **no analyzer dependency at
  runtime**, which is what makes it viable on the **web** (the analyzer is too
  large to ship via dart2js / dart2wasm) and for **over-the-air UI updates**
  (download a bundle, render it, no app-store round trip).

The two Flutter packages share the **same generated bridge surface and the
same conformance script corpus** (see *Testing*) — they differ only in the
underlying engine. Because generated AST bundles are large, prefer this
source-based package unless the web/OTA constraint applies; switch to
[`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast) only when you must run
without the analyzer.

---

## Public API

```dart
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

final runner = SourceFlutterD4rt();
final widget = runner.build(source, context); // interpret + render
```

The barrel (`lib/tom_d4rt_flutter.dart`) exports:

- `SourceFlutterD4rt` / `SourceFlutterD4rtException` — the interpreter runner.
- The sample-source types (`SampleProgram`, `SampleSource`, `createSampleSource`,
  `DiskSampleSource`, `AssetSampleSource`, `buildDiskProgram`, …) used to load
  multi-file sample apps; `SourceFlutterD4rt.buildMultiFile` builds these
  directly.

| Entry point | Use it for |
|---|---|
| `build<T>(source, [context])` | A single-file script — calls its top-level `build` function and unwraps the result as `T`. |
| `buildMultiFile<T>(mainFilePath, {buildContext})` | A multi-file program on disk (desktop) — resolves every relative `import` into the interpreter's source map, then runs `build`. |
| `buildProgram<T>(program, {buildContext})` | A pre-resolved `SampleProgram` (mobile / asset-bundled) — no filesystem access. |
| `execute<T>(source, {name, positionalArgs, namedArgs})` | Any named function, not just `build`. |

---

## Quick start — script → widget

A D4rt UI script is ordinary Dart: it declares a top-level
`Widget build(BuildContext context)` function that returns a widget tree built
from the **real** Flutter Material classes. `SourceFlutterD4rt.build` parses the
source, calls that function, and hands you back a live `Widget` you can drop
straight into your tree.

```dart
import 'package:flutter/material.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

// The interpreter pre-loaded with the full Flutter Material bridge surface.
// Construct it once and reuse it across builds.
final runner = SourceFlutterD4rt();

// In a real app this string would be fetched from a server, a file, or a
// text field — here it is inline for clarity.
const uiScript = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Hello from interpreted Dart!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => debugPrint('tapped'),
            child: const Text('Press me'),
          ),
        ],
      ),
    ),
  );
}
''';

class InterpretedPanel extends StatelessWidget {
  const InterpretedPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // Interpret the script and render its widget tree inline.
    return runner.build<Widget>(uiScript, context);
  }
}
```

Key points:

- The result is a genuine `Widget` made of real `Card`, `Column`,
  `ElevatedButton`, … instances — not a mock or a screenshot. State, gestures,
  and animations all work.
- The `BuildContext` you pass is forwarded as the first positional argument to
  the script's `build` function, so interpreted code can call
  `Theme.of(context)`, `MediaQuery.of(context)`, and friends.
- `build<T>` unwraps the interpreter's result to the native `T` for you via
  `D4.unwrapAs<T>`, so you get a `Widget`, not a wrapped interpreter value.
- For UI that spans several files (the usual shape of a real sample app), use
  `buildMultiFile<Widget>('lib/main.dart', buildContext: context)` instead — it
  resolves the relative `import` graph for you.

See the **authoritative** runtime walkthrough in
[doc/tom_d4rt_flutter_user_guide.md](doc/tom_d4rt_flutter_user_guide.md) for the
four execution entry points, multi-file programs, extension registration, and
the performance/GC notes.

---

## Documentation

| Doc | What it covers |
|-----|----------------|
| [doc/tom_d4rt_flutter_user_guide.md](doc/tom_d4rt_flutter_user_guide.md) | **Authoritative Flutter-runtime guide** — `SourceFlutterD4rt`, the four execution entry points, multi-file programs, extension registration, performance/GC, and the known-limits summary. |
| [doc/tom_d4rt_flutter_limitations.md](doc/tom_d4rt_flutter_limitations.md) | Full bridge-adapter limits catalogue (Flutter-runtime delta) with per-case script workarounds. |
| [doc/manual_bridge_interventions.md](doc/manual_bridge_interventions.md) | The hand-written runtime registrations layered on top of the generated bridges — interface proxies, type relaxers, generic factories, and `d4rt_user_bridges/` overrides — and why each is needed. |
| [../tom_d4rt/doc/d4rt_user_guide.md](../tom_d4rt/doc/d4rt_user_guide.md) | Base interpreter — language subset, bridging model, shared semantics. |
| [../tom_d4rt/doc/d4rt_limitations.md](../tom_d4rt/doc/d4rt_limitations.md) | Canonical interpreter-level limitations. |

> `doc/example_app_plan.md` is an **internal development record** (sample-app
> build plan), not user documentation — it ships only for development context.

---

## Where it sits in the D4rt ecosystem

| Package | Role | Relationship |
|---------|------|--------------|
| **`tom_d4rt`** | Analyzer-based, source-driven D4rt interpreter. | **Path dependency** (`../tom_d4rt`) — the interpreter this library drives. |
| **`tom_d4rt_generator`** | The `d4rtgen` bridge generator. | **Dev path dependency** — regenerates `lib/src/bridges/*.b.dart`. |
| **`tom_d4rt_flutter_ast`** | AST/bundle parallel (`FlutterD4rt`). | Sibling. Shares the conformance script corpus (see *Testing*). |
| **`tom_d4rt_flutter_test`** | Interactive demo/test application. | Downstream consumer — depends on this library via `../tom_d4rt_flutter`. |

---

## Example applications

The companion **`tom_d4rt_flutter_test`** project holds 33 self-contained
example apps under `tom_d4rt_flutter_test/example/`, each a multi-file D4rt
program rendered through `SourceFlutterD4rt`. They double as the broadest
real-world exercise of the bridge surface:

| | | | |
|---|---|---|---|
| `bezier_curve_editor` | `bottom_nav_shell` | `bouncing_balls_physics` | `calculator` |
| `card_swiper` | `carousel_pager` | `chat_ui` | `clock_face` |
| `color_picker_studio` | `conway_life` | `counter2` | `counter_app` |
| `drawing_pad` | `form_wizard` | `kanban_board` | `memory_match` |
| `note_app` | `particle_field` | `photo_gallery_hero` | `pomodoro_timer` |
| `slide_puzzle` | `snake_game` | `solitaire` | `solitaire2` |
| `stopwatch_laps` | `stpauls` | `stpeters` | `sudoku_app` |
| `tabbed_dashboard` | `tic_tac_toe` | `tip_calculator` | `todo_list` |
| `tron` | | | |

Run the demo application to browse and execute them interactively:

```bash
cd ../tom_d4rt_flutter_test
flutter run
```

The same sample set is mirrored in the AST sibling
(`tom_d4rt_flutter_ast_test/example/`), so the source-direct and AST paths can
be compared app-for-app.

For a single, repo-curated starter see the
[`d4rt_flutter_sample`](../tom_d4rt_samples/d4rt_flutter_sample/README.md) in
the shared `tom_d4rt_samples` collection — a focused Flutter-Material script
rendered through `SourceFlutterD4rt`, sitting alongside the interpreter, dcli,
and advanced samples. This package's own [`example/`](example/README.md) folder
holds the minimal library-usage snippet.

---

## Regenerating the bridges

The `lib/src/bridges/*.b.dart` files are generated from `buildkit.yaml`. Never
hand-edit them — fix the generator (`tom_d4rt_generator`) or the
`buildkit.yaml`/user-bridge sources, then regenerate:

```bash
dart run tool/regenerate_bridges.dart
```

`buildkit.yaml` retargets the analyzer-based `tom_d4rt` runner and sets
`generateTestRunner: false` (playback is driven by the consumers, not a
generated HTTP stub).

---

## Testing

The bridge conformance suite lives under `test/`. It drives a Flutter HTTP
harness app (`test/tom_d4rt_flutter_test_app/`, port `4248`) over HTTP: each
test POSTs raw Dart source to `/build` and asserts on the rendered widget,
captured `print()` output, and framework errors. The harness is launched and
recycled automatically by `test/send_test_runner.dart`.

The test scripts are the **shared corpus** in the sibling `tom_d4rt_flutter_ast`
package
(`../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts`),
so the source-based and AST-based suites run identical scripts. The sibling
package must be checked out alongside this one.

```bash
# All HTTP-server tests share one local server — run serially (concurrency: 1).
flutter test test/essential_classes_test.dart
flutter test test/important_classes_test.dart
```

Suites, in rough order of coverage breadth: `essential_classes_test`,
`important_classes_test`, `secondary_classes_test`,
`hardly_relevant_classes_{1..5}_test`, plus the interpreter-issue,
cluster-repro, blocking, timeout, interactive, and suspicious-rewrite suites.

---

## Status

Current version: **1.0.1**. Source repository:
<https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_flutter>.

This package lives in the `tom_d4rt` monorepo at `tom_ai/d4rt/tom_d4rt_flutter`.
For the analyzer-free Flutter path see
[`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast/README.md); for the base
interpreter and the bridge generator see
[`tom_d4rt`](../tom_d4rt/README.md) and
[`tom_d4rt_generator`](../tom_d4rt_generator/README.md).
