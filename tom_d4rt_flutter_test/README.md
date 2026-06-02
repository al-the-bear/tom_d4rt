# tom_d4rt_flutter_test

> Interactive D4rt test runner — executes D4rt scripts and multi-file sample
> apps against **real Flutter widgets** via the source-based `tom_d4rt`
> interpreter.

`tom_d4rt_flutter_test` is the hands-on validation harness for the D4rt
interpreter when it is asked to drive a live Flutter UI. It feeds raw Dart
source straight into the analyzer-free `tom_d4rt` interpreter, registers the
full Flutter Material bridge surface, and renders the resulting widgets inside
a running Flutter app — so you can watch an interpreted `setState`, a periodic
ticker, or a `KeyboardListener` behave (or misbehave) on real hardware and in
the simulator.

This is an **application, not a library**. Its `pubspec.yaml` declares
`publish_to: 'none'` — it is never published to pub.dev and exists only inside
the D4rt monorepo for testing and demonstration.

---

## Where it sits in the D4rt ecosystem

This package lives in the D4rt interpreter ecosystem at
[github.com/al-the-bear/tom_d4rt](https://github.com/al-the-bear/tom_d4rt).
It is the **Flutter-facing, source-driven** counterpart of the AST-driven test
app, and it depends on its siblings via path dependencies:

| Package | Role | This app's relationship |
|---------|------|--------------------------|
| **`tom_d4rt`** | The analyzer-based, source-driven D4rt interpreter (`D4rt`, `D4`, `resolveImportsRecursively`). | **Path dependency** (`../tom_d4rt`). Provides the interpreter this app runs scripts through. |
| **`tom_d4rt_ast`** | The AST/bundle format and `FlutterD4rt` runner that consumes pre-compiled `AstBundle`s. | Sibling. `SourceFlutterD4rt` here is the source-based parallel of `tom_d4rt_ast`'s `FlutterD4rt`. |
| **`tom_d4rt_exec`** | The AST-based execution runner (`tom_d4rt_ast`'s runtime backend). | Sibling. The AST test app retargets it; this app deliberately retargets `tom_d4rt` instead. |
| **`tom_d4rt_generator`** | The `d4rtgen` bridge generator. | **Dev path dependency** (`../tom_d4rt_generator`). Generates the `lib/src/bridges/*.b.dart` Flutter bridges. |

The key distinction from the AST test app: scripts are loaded as **plain Dart
source strings** and interpreted on the fly — there is **no offline compile
step** and no `AstBundle`. See `buildkit.yaml`, whose header documents that this
config "mirrors `tom_d4rt_flutter_ast/buildkit.yaml`" but retargets the
analyzer-based `tom_d4rt` runner and disables the HTTP test-runner stub
(`generateTestRunner: false`) because playback is driven by the UI.

---

## What it does

* Constructs a `SourceFlutterD4rt` (`lib/src/source_flutter_d4rt.dart`) — a
  `D4rt` interpreter pre-loaded with the full generated Flutter Material bridge
  surface (17 generated bridge files under `lib/src/bridges/`) plus hand-written
  runtime registrations (interface proxies, type relaxers, generic factories).
* Loads single-file scripts and **multi-file sample apps** and runs their
  `build(BuildContext)` function, rendering the returned widget on screen.
* On desktop, offers a multi-tab shell (Examples / Generate / Log / Files) that
  doubles as a test runner, a code generator, and a file inspector.
* On mobile, collapses to a simple bundled-sample browser.

### Two runtime shells

The app adapts to the platform it runs on (the switch lives in
`lib/src/sample_source.dart`, via `isMobileRuntime` → `AssetSampleSource` vs
`DiskSampleSource`; the shell choice is in `lib/main.dart`):

| Platform | Shell | Sample source |
|----------|-------|---------------|
| macOS / Linux / Windows | Full multi-tab UI: **Examples** (test runner + sample picker), **Generate**, **Log**, **Files** | Live `example/` tree on disk |
| iOS / iPadOS / Android | Simplified sample grid — tap a sample to run it | Bundled assets snapshot |

On mobile the workspace filesystem is sandboxed away, so the **test runner and
code generator are disabled** and samples are loaded from assets copied in at
build time. The desktop shell still reads the live `example/` directory, so
edits to a sample show up on the next reload.

The desktop `Examples` tab is wired in `lib/main.dart` from these pieces:
`PathBar`, `ScriptSearchBar`, `SamplesBar`, `ScriptInfoPanel`, `D4rtScriptView`
(executes a script inside a real `build` so it gets a live `BuildContext`), and
`ResultPanel`. Playback has **no autoplay** — a script runs only on explicit
`next` / `back` / `jumpTo` input, and the produced widget stays on screen so
Flutter's normal frame pump drives any animations the script defines (see
`lib/src/test_runner.dart`).

---

## Running the app

### iOS Simulator (iPad / iPhone) on macOS

Prerequisites: Xcode installed, with an iOS Simulator runtime
(Xcode → Settings → Platforms).

```bash
# From this project directory:
./run_ipad.sh             # iPad simulator
./run_iphone.sh           # iPhone simulator
./run_simulator.sh        # follow the VS Code-selected device, else first booted sim
./run_simulator.sh ipad   # force an iPad simulator
./run_simulator.sh iphone # force an iPhone simulator
./run_simulator.sh <udid> # a specific simulator by UDID
```

`run_ipad.sh` and `run_iphone.sh` are thin wrappers that call
`run_simulator.sh ipad` / `iphone`. `run_simulator.sh` itself:

1. Resolves a simulator UDID, preferring (in order) an explicit UDID argument,
   the requested kind (`ipad`/`iphone`), the VS Code-selected
   `$FLUTTER_TARGET_DEVICE`, the first already-booted simulator, then the first
   available iPad or any iOS simulator.
2. Boots the simulator (`xcrun simctl bootstatus`) and opens the Simulator app.
3. **Refreshes the bundled samples** (`dart run tool/sync_samples_to_assets.dart`).
4. Runs `flutter run -d <udid>`.

In the VS Code integrated terminal, `./run_simulator.sh` with no argument
follows the device you picked in the Flutter status-bar selector (the extension
exports it as `$FLUTTER_TARGET_DEVICE`).

To run on a **physical** iPad/iPhone, plug it in, find its id with
`flutter devices`, and run `flutter run -d <id>` — a real device additionally
needs a signing team set in `ios/Runner.xcodeproj`.

### Desktop and other targets

```bash
flutter run -d macos     # macOS desktop (full multi-tab shell)
flutter run -d linux     # Linux desktop
flutter run -d windows   # Windows desktop
flutter run -d chrome    # web
```

Desktop builds read samples live from `example/`, so no asset sync is needed.

---

## How the asset-based sample scripts work

Both platforms converge on a `SampleProgram` (`lib/src/sample_source.dart`) — a
`{libraryUri: source}` map in which every transitively-imported relative file is
already resolved — which feeds `SourceFlutterD4rt.buildProgram`. The interpreter
performs **no filesystem access itself** (`allowFileSystemImports: false`):

* **Disk path (desktop):** `DiskSampleSource` walks up from the running
  executable to locate the `example/` root (so it works for `flutter run`,
  macOS `.app` bundles, and packaged Linux/Windows builds), then resolves
  imports with `tom_d4rt`'s `resolveImportsRecursively`.
* **Asset path (mobile):** `AssetSampleSource` reads the manifest at
  `assets/samples/index.json`, loads each sample's `.dart` files via
  `rootBundle`, and keys them by synthetic `file:///samples/<name>/...` URIs so
  relative imports resolve identically to the disk layout without a real
  filesystem.

### Refreshing the bundled samples

The mobile build reads a snapshot of `example/` from `assets/samples/`. The run
scripts regenerate this automatically, but you can do it by hand after adding,
removing, or editing a sample:

```bash
dart run tool/sync_samples_to_assets.dart
```

This tool (`tool/sync_samples_to_assets.dart`):

1. Scans `example/<name>/` for every immediate subdirectory containing a
   `main.dart`.
2. Mirrors every `.dart` file of each sample into `assets/samples/<name>/...`,
   preserving relative sub-paths.
3. Writes the manifest `assets/samples/index.json` (each sample's name, entry
   file, and full file list).
4. Rewrites the generated asset block in `pubspec.yaml` between the
   `# >>> BEGIN generated sample assets ... <<<` / `# >>> END ... <<<` markers —
   Flutter does not bundle nested asset directories recursively, so each sample
   folder must be listed explicitly.

`assets/samples/` and the generated `pubspec.yaml` block are fully regenerated
each run, so deleted samples are pruned automatically.

### The samples

Each sample under `example/<name>/` is a small, self-contained multi-file
Flutter app whose entry point is `main.dart` and whose `build(BuildContext)`
returns the root widget. They range from trivial (`counter_app/` —
`main.dart` + `counter.dart`) to fairly involved (`snake_game/` — six files
including `board_painter.dart`, `snake.dart`, `keymap.dart`). The current set
covers UI, animation, physics, gameplay, and custom-painter scenarios, e.g.:

`bezier_curve_editor`, `bottom_nav_shell`, `bouncing_balls_physics`,
`calculator`, `card_swiper`, `carousel_pager`, `chat_ui`, `clock_face`,
`color_picker_studio`, `conway_life`, `counter_app`, `drawing_pad`,
`form_wizard`, `kanban_board`, `memory_match`, `note_app`, `particle_field`,
`photo_gallery_hero`, `pomodoro_timer`, `slide_puzzle`, `snake_game`,
`solitaire`, `stopwatch_laps`, `sudoku_app`, `tabbed_dashboard`, `tic_tac_toe`,
`tip_calculator`, `todo_list`, `tron`, and more.

---

## The test suite

Tests live in `test/`. Run them with `flutter test`.

> **Important:** `dart_test.yaml` pins `concurrency: 1` (serial). The
> HTTP-server-backed test suites share a single local HTTP server on a fixed
> port, so running invocations in parallel corrupts results.

Two styles of test coexist:

* **In-process widget tests** — e.g. `test/sample_apps_in_tester_test.dart`
  runs `SourceFlutterD4rt.buildMultiFile` *directly* inside a `WidgetTester`, so
  it can `tester.tap()` / send key events to interpreted widgets and assert that
  interpreted state actually updates the rendered UI. Each test runs inside a
  `runZonedGuarded` block that captures every `print()` from the interpreted
  script and dumps the trail on teardown, so failures come with a record of what
  the interpreter executed. This harness is used to reproduce and regress
  interpreter bugs (e.g. user-defined `State.setState` not scheduling a rebuild,
  or classic `for` loop variable capture).
* **HTTP-driven script suites** — `test/*_test.dart` files such as
  `important_classes_test.dart`, `essential_classes_test.dart`,
  `secondary_classes_test.dart`, the `hardly_relevant_classes_*_test.dart`
  family, `interactive_tests_test.dart`, `blocking_tests_test.dart`,
  `timeout_tests_test.dart`, and others drive scripts through the local HTTP
  server. `test/send_test_runner.dart` is the shared driver.

Diagnostic and regression logs from past investigations are archived under
`doc/testlog_*` directories.

---

## Regenerating the Flutter bridges

The bridge surface under `lib/src/bridges/*.b.dart` is generated by `d4rtgen`
from `buildkit.yaml`:

```bash
dart run tool/regenerate_bridges.dart
```

This invokes `tom_d4rt_generator`'s `generateBridges` against `buildkit.yaml`,
which produces a barrel (`flutter_bridges_barrel.b.dart`) and the registration
class `FlutterMaterialBridges` consumed by `SourceFlutterD4rt`. Hand-written
runtime extensions (interface proxies, type relaxers, generic factories) live
alongside in `lib/src/d4rt_runtime_registrations.dart` and the
`lib/src/d4rt_user_bridges/` and `lib/src/bridges/flutter_relaxers.b.dart`
files, and are registered together in `SourceFlutterD4rt._registerBridges()`.

---

## Project layout

```text
tom_d4rt_flutter_test/
├── pubspec.yaml                # name, deps (tom_d4rt path dep), publish_to: none
├── buildkit.yaml               # d4rtgen config — targets analyzer-based tom_d4rt
├── dart_test.yaml              # concurrency: 1 (serial; shared HTTP server)
├── analysis_options.yaml
├── run_ipad.sh                 # wrapper → run_simulator.sh ipad
├── run_iphone.sh               # wrapper → run_simulator.sh iphone
├── run_simulator.sh            # boot sim, sync assets, flutter run -d <udid>
├── lib/
│   ├── main.dart               # composition root; desktop vs mobile shell
│   ├── tom_d4rt_flutter_test.dart   # public export: SourceFlutterD4rt
│   └── src/
│       ├── source_flutter_d4rt.dart # source-based Flutter D4rt entry point
│       ├── sample_source.dart       # Disk vs Asset SampleSource; SampleProgram
│       ├── test_runner.dart         # reactive playback state machine
│       ├── test_script_loader.dart
│       ├── sample_apps_notifier.dart
│       ├── script_root_notifier.dart
│       ├── d4rt_runtime_registrations.dart  # proxies / relaxers / factories
│       ├── bridges/            # generated *.b.dart Flutter Material bridges
│       ├── d4rt_user_bridges/  # hand-written user bridges
│       ├── generator/          # the "Generate" tab (LLM-driven sample gen)
│       └── widgets/            # UI panels (control_bar, log_panel, etc.)
├── example/                    # multi-file sample apps (live, disk-backed)
│   ├── counter_app/  (main.dart + counter.dart)
│   ├── snake_game/   (main.dart + 5 more)
│   └── ...                     # ~30+ samples
├── assets/
│   └── samples/                # generated snapshot of example/ for mobile
│       └── index.json          # manifest written by sync_samples_to_assets.dart
├── tool/
│   ├── sync_samples_to_assets.dart  # bundle example/ → assets + pubspec block
│   └── regenerate_bridges.dart      # run d4rtgen from buildkit.yaml
├── test/                       # in-process widget tests + HTTP-driven suites
├── doc/                        # implementation plans + testlog_* archives
├── android/ ios/ macos/ linux/ windows/ web/   # Flutter platform runners
```

---

## Related packages

* [`tom_d4rt`](../tom_d4rt) — the source-based D4rt interpreter (the engine this
  app runs every script through).
* [`tom_d4rt_ast`](../tom_d4rt_ast) — the AST/bundle format and `FlutterD4rt`
  runner that `SourceFlutterD4rt` parallels.
* [`tom_d4rt_exec`](../tom_d4rt_exec) — the AST-based execution runner.
* [`tom_d4rt_generator`](../tom_d4rt_generator) — the `d4rtgen` bridge generator
  used to (re)generate `lib/src/bridges/`.

Ecosystem home: <https://github.com/al-the-bear/tom_d4rt>
