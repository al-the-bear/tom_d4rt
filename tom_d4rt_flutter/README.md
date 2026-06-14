# tom_d4rt_flutter

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
> workflow. The analyzer-free sibling
> [`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast) (`FlutterD4rt`) shares the
> same bridge surface but is only needed when you must run without the Dart
> analyzer: embedding in a shipping app for over-the-air updates, or targeting
> the web (dart2js / dart2wasm).

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

---

## Documentation

| Doc | What it covers |
|-----|----------------|
| [doc/tom_d4rt_flutter_user_guide.md](doc/tom_d4rt_flutter_user_guide.md) | **Authoritative Flutter-runtime guide** — `SourceFlutterD4rt`, the four execution entry points, multi-file programs, extension registration, performance/GC, and the known-limits summary. |
| [doc/tom_d4rt_flutter_limitations.md](doc/tom_d4rt_flutter_limitations.md) | Full bridge-adapter limits catalogue (Flutter-runtime delta) with per-case script workarounds. |
| [../tom_d4rt/doc/d4rt_user_guide.md](../tom_d4rt/doc/d4rt_user_guide.md) | Base interpreter — language subset, bridging model, shared semantics. |
| [../tom_d4rt/doc/d4rt_limitations.md](../tom_d4rt/doc/d4rt_limitations.md) | Canonical interpreter-level limitations. |

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
