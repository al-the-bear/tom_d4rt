# D4rt Flutter Sample — interpret UI from source at runtime

> The earlier samples ran D4rt scripts on the command line. This one runs them
> **inside a live Flutter app**: the screens you see are not compiled into the
> binary — they are Dart *source files*, shipped as assets, parsed and
> interpreted into a real Flutter widget tree while the app is running. The same
> compiled binary renders every sample on macOS, Linux, Windows, iOS and iPadOS
> without a recompile.

A normal Flutter screen is Dart code that the Dart compiler turned into machine
code before the app shipped. Changing it means recompiling and redeploying. This
sample flips that around: it bundles the screen's *source text* and asks
[`SourceFlutterD4rt`](https://pub.dev/packages/tom_d4rt_flutter) to interpret it
on the spot. Because interpretation happens at runtime, the very same binary can
render UI that was written — or changed — after the app was built. That is the
foundation for shipping UI updates without an app-store round trip.

This article walks through **one** example in depth — `counter_app`, the smallest
program that proves the whole pipeline — and explains *how interpreted UI
actually works*: how source becomes a widget tree, how a multi-file program is
resolved without a filesystem, why everything is bundled as assets, and how the
script's own `setState` drives later frames. The two richer examples
(`tip_calculator`, `clock_face`) are summarised at the end.

---

## Table of contents

1. [The idea: ship source, not widgets](#1-the-idea-ship-source-not-widgets)
2. [Project layout](#2-project-layout)
3. [Running it](#3-running-it)
4. [The focus example: `counter_app`](#4-the-focus-example-counter_app)
5. [One interpreter for the whole app](#5-one-interpreter-for-the-whole-app)
6. [From source to widget: `build` and `buildProgram`](#6-from-source-to-widget-build-and-buildprogram)
7. [Multi-file programs without a filesystem](#7-multi-file-programs-without-a-filesystem)
8. [Why everything is an asset: the `SampleSource` abstraction](#8-why-everything-is-an-asset-the-samplesource-abstraction)
9. [Bundling: `tool/sync_samples_to_assets.dart`](#9-bundling-toolsync_samples_to_assetsdart)
10. [The host page: load, interpret once, let the script drive](#10-the-host-page-load-interpret-once-let-the-script-drive)
11. [Why this enables over-the-air UI updates](#11-why-this-enables-over-the-air-ui-updates)
12. [The other examples](#12-the-other-examples)
13. [Where to go next](#13-where-to-go-next)

---

## 1. The idea: ship source, not widgets

Here is the entire `counter_app/main.dart` — a sample, not app code:

```dart
import 'package:flutter/material.dart';
import 'counter.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Counter',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: const CounterHome(),
  );
}
```

It reads like ordinary Flutter, but nothing here was compiled into the app. At
runtime the app hands this text — plus the `counter.dart` it imports — to an
interpreter that walks the Dart AST and, every time it meets `MaterialApp(...)`
or `Scaffold(...)`, constructs the **real** Flutter widget. The result is an
ordinary `Widget` the app drops straight into its tree.

The contract is small and fixed: **a sample is a Dart program that exposes a
top-level `Widget build(BuildContext context)` function.** The app calls that
function through the interpreter and renders whatever it returns.

How can interpreted code create real `MaterialApp` and `Scaffold` instances? Via
**bridges**. `SourceFlutterD4rt` registers the entire Flutter Material API as
bridged classes, so when the script says `Scaffold(appBar: ...)` the interpreter
calls the genuine `Scaffold` constructor with the interpreted arguments. The
script *thinks* it is writing Flutter; the bridges make that literally true.

---

## 2. Project layout

```
d4rt_flutter_sample/
├── lib/
│   ├── main.dart                      # the app shell (tabbed home + host page)
│   └── src/
│       ├── asset_catalog.dart         # lists/loads every bundled .dart file
│       ├── paste_run_tab.dart         # "Paste & Run" tab (editor + execute)
│       └── files_tab.dart             # "Files" tab (tree + read-only viewer)
├── example/                           # the runnable samples — plain Dart source
│   ├── counter_app/
│   │   ├── main.dart                  # exposes `Widget build(BuildContext)`
│   │   └── counter.dart               # imported by main.dart
│   ├── tip_calculator/                # 6-file sample
│   └── clock_face/                    # 5-file sample (CustomPainter clock)
├── assets/
│   ├── samples/                       # generated mirror of example/ (see §9)
│   │   ├── index.json                 #   manifest the app reads at runtime
│   │   └── counter_app/...
│   └── copy_paste_samples/            # short single-file snippets (see §3)
│       ├── index.json                 #   non-runnable group, paste-and-run only
│       └── hello_card.dart, ...
├── tool/
│   └── sync_samples_to_assets.dart    # bundles example/ → assets/
├── run_macos.sh  run_linux.sh         # platform launchers (§3)
├── run_ios.sh    run_ipad.sh
├── run_windows.ps1
└── pubspec.yaml                       # depends on tom_d4rt_flutter
```

The crucial split: `example/` holds the runnable samples as **editable source**;
`assets/samples/` holds a **bundled snapshot** of that source, generated by the
tool in `tool/`. The app only ever reads the snapshot — see §8 for why. The
hand-authored single-file snippets under `assets/copy_paste_samples/` are a
separate, **non-runnable** group: they exist to be copied into the Paste & Run
editor and browsed in the Files tab, and never appear in the run gallery.

---

## 3. Running it

Each launcher re-bundles the samples (so any edit to `example/` shows up) and
then runs the app on its platform:

```bash
# Desktop
./run_macos.sh
./run_linux.sh

# iOS / iPadOS (simulator or device)
./run_ios.sh                 # first booted iOS device
./run_ipad.sh                # boots / picks an iPad simulator
```

```powershell
# Windows
./run_windows.ps1
```

If you add or edit a sample, re-run the bundler before launching:

```bash
dart run tool/sync_samples_to_assets.dart
```

The app opens on a tabbed home with three ways to explore interpreted UI:

- **Samples** — the run gallery. Pick a bundled multi-file sample by tapping its
  name, or type the name into the field and press **Run**. The chosen sample is
  interpreted and shown full-screen. This is the path the rest of this article
  walks through (§4 onward).
- **Paste & Run** — a live editor. Paste (or **Load snippet** to pull one of the
  bundled `copy_paste_samples`) a single Dart file that exposes a top-level
  `Widget build(BuildContext context)`, press **Execute**, and the result renders
  in the pane below. Same `build` contract as a sample, but interpreted straight
  from the editor text — the quickest way to try a snippet.
- **Files** — a read-only browser. A tree on the left lists every bundled `.dart`
  file (each runnable sample group plus the non-runnable `copy-paste-samples`
  group); selecting one shows its source on the right in a selectable, copyable
  viewer. Nothing is interpreted here — it is for reading and copying source.

The `copy_paste_samples` snippets are surfaced **only** in Paste & Run (via Load
snippet) and Files — never as a runnable entry in the Samples gallery.

---

## 4. The focus example: `counter_app`

`counter_app` is two files. `main.dart` (shown in §1) returns a `MaterialApp`
whose home is `CounterHome`, defined in `counter.dart`:

```dart
import 'package:flutter/material.dart';

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter (multi-file)')),
      body: Center(
        child: Text('count = $_count', style: theme.textTheme.displayMedium),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

This is deliberately humble, because it exercises the two hardest parts of the
pipeline:

- a **script-defined `StatefulWidget`** — the interpreter must let interpreted
  classes subclass bridged Flutter classes (`StatefulWidget`, `State`), and
- a **script-side `setState`** that schedules a *real* Flutter rebuild, so
  tapping the FAB actually repaints `count = 1`.

If `counter_app` renders and counts, the interpreter's class-bridging and the
state-rebuild plumbing are both working.

---

## 5. One interpreter for the whole app

The app builds exactly one interpreter and reuses it for every sample:

```dart
class _D4rtFlutterSampleAppState extends State<D4rtFlutterSampleApp> {
  // Constructing it registers the full Flutter Material bridge surface and
  // calls finalizeBridges() — reusable across every sample we run.
  final SourceFlutterD4rt _d4rt = SourceFlutterD4rt();

  // Assets work the same on desktop and mobile, so we always read the bundled
  // snapshot rather than branching on platform.
  final SampleSource _source = AssetSampleSource();
  ...
}
```

Constructing `SourceFlutterD4rt` is where all the machinery is registered:
relaxers (which loosen interpreted argument types to the native ones the real
constructors expect), runtime extensions, the `FlutterMaterialBridges` (every
`dart:ui` / `painting` / `widgets` / `material` class), interface-proxy
overrides, and finally `finalizeBridges()`. After that the interpreter is ready
to turn any Flutter-shaped source into widgets.

It is intentionally constructed once. Bridge registration installs into the
interpreter's global environment; one interpreter per app keeps that setup cost
out of every navigation.

---

## 6. From source to widget: `build` and `buildProgram`

`SourceFlutterD4rt` exposes two related entry points. For a *single* source
string:

```dart
T build<T>(String source, [BuildContext? buildContext]);
```

It executes the function named `build`, passing `buildContext` as the first
positional argument, and unwraps the result to `T` (here `Widget`). That is the
fixed contract behind "a sample exposes `Widget build(BuildContext)`".

For a *multi-file* program whose files are already resolved into a map:

```dart
T buildProgram<T>(SampleProgram program, {BuildContext? buildContext});
```

which under the hood calls:

```dart
_interpreter.execute(
  library: program.libraryUri,      // entry-point URI (main.dart)
  sources: program.sources,         // {uri: source} for every file
  basePath: program.basePath,
  allowFileSystemImports: false,    // no disk access — sources are pre-resolved
  name: 'build',
  positionalArgs: buildContext != null ? [buildContext] : null,
);
```

`counter_app` is multi-file, so the app uses `buildProgram`. The key flag is
`allowFileSystemImports: false`: the interpreter never touches a filesystem.
Every file the program imports is already present in `program.sources`. That is
exactly what makes the same code run on an iOS device, which has no workspace
filesystem to read.

---

## 7. Multi-file programs without a filesystem

`counter_app/main.dart` does `import 'counter.dart';`. On the command line the
interpreter would resolve that relative import off disk. In a packaged app there
is no disk to resolve against, so the import is **pre-resolved** into a
`SampleProgram`:

```dart
class SampleProgram {
  final String libraryUri;           // file://…/counter_app/main.dart
  final String basePath;
  final Map<String, String> sources; // every file's URI → its source text
}
```

`sources` contains both `main.dart` and `counter.dart`, each keyed by a stable
`file://` URI. When the interpreter meets `import 'counter.dart';` it resolves
the relative URI against `libraryUri` and finds the entry already in the map —
no I/O required. Relative imports work exactly as written; they are just
satisfied from memory instead of from a filesystem.

The URIs are *synthetic* on mobile (`file:///samples/counter_app/main.dart`).
They never name a real file; they only give the interpreter stable keys to
resolve relative imports against — mirroring the disk layout without a disk.

---

## 8. Why everything is an asset: the `SampleSource` abstraction

`tom_d4rt_flutter` defines a strategy interface for *finding* and *loading*
samples:

```dart
abstract class SampleSource {
  Future<List<SampleAppEntry>> list();               // enumerate samples
  Future<SampleProgram> loadProgram(SampleAppEntry);  // resolve one to sources
}
```

Two implementations ship with it:

- `DiskSampleSource` reads a live `example/` tree off disk — handy during
  development on desktop, but it has nothing to read on iOS.
- `AssetSampleSource` reads a bundled snapshot from Flutter **assets** via
  `rootBundle`, which is available identically on every platform.

This sample deliberately uses `AssetSampleSource` **everywhere**, including
desktop:

```dart
final SampleSource _source = AssetSampleSource();
```

Why not branch — disk on desktop, assets on mobile? Because assets give one code
path that behaves the same on all five targets. The trade-off is that you
re-bundle after editing a sample (the launchers do this for you), in exchange
for a single, predictable load path. `loadProgram` reads each file listed in the
manifest with `rootBundle.loadString` and assembles the `SampleProgram` map — no
filesystem, no platform `if`s.

---

## 9. Bundling: `tool/sync_samples_to_assets.dart`

Flutter only ships files that are declared as assets, and it does not bundle
nested asset directories recursively — each sample directory must be listed. The
bundler automates all of it. Run from the project root:

```bash
dart run tool/sync_samples_to_assets.dart
```

It:

1. scans `example/<name>/` for every directory containing a `main.dart`;
2. mirrors each sample's `.dart` files into `assets/samples/<name>/…`;
3. writes `assets/samples/index.json` — the manifest the app reads at runtime to
   enumerate samples and their files; and
4. rewrites a marker-delimited asset block inside `pubspec.yaml` so each sample
   directory is declared.

The manifest is what `AssetSampleSource.list()` parses, and the per-file entries
are what `loadProgram` reads. The whole `assets/samples` tree is regenerated on
every run, so deleting a sample from `example/` removes it from the app too.

---

## 10. The host page: load, interpret once, let the script drive

When you pick a sample, the app pushes a `SampleHostPage` that resolves the
program asynchronously (assets load via `rootBundle`) and then interprets it once
a real `BuildContext` is in scope:

```dart
Future<void> _load() async {
  final program = await widget.loadProgram(widget.entry);
  setState(() => _program = program);
}

void _interpret(BuildContext context) {
  _built = widget.d4rt.buildProgram<Widget>(_program!, buildContext: context);
}

@override
Widget build(BuildContext context) {
  if (_program != null && _built == null && _errorMessage == null) {
    _interpret(context);     // interpret exactly once, on first build
  }
  ...
}
```

Two details matter:

- **Interpret once.** The sample is interpreted on the first `build` after the
  program loads, and the resulting widget is cached in `_built`. After that the
  sample is a normal subtree.
- **The script drives later frames.** `counter_app`'s `_increment` calls
  `setState` on its *own* interpreted `State`. That schedules an ordinary Flutter
  rebuild through the normal pump loop — the host page does nothing special. The
  interpreted widget behaves like any compiled widget once it is in the tree.

Interpretation failures are caught and shown as a readable error panel rather
than crashing the app, so a broken sample is debuggable in place.

---

## 11. Why this enables over-the-air UI updates

Put the pieces together and the strategic payoff is clear:

- the UI is **source**, not compiled code;
- the interpreter needs **no filesystem and no analyzer** at runtime — just the
  source text and the bridge surface baked into the binary;
- source arrives as **data** (here, bundled assets — but it could just as easily
  be downloaded JSON).

So a server can hold the latest screen definitions, the app can fetch them, and
`buildProgram` renders the new UI immediately — no recompile, no store review, no
user-side update. This sample uses local assets to keep things self-contained,
but the loading path (`SampleSource`) is an interface: swap `AssetSampleSource`
for one that fetches from your backend and the same `buildProgram` call renders
remotely-authored UI.

The analyzer-free interpretation path (precompiled AST bundles consumed by
`tom_d4rt_ast`) is the production-grade version of this idea; this sample
demonstrates the source-driven form end to end.

---

## 12. The other examples

Two richer samples are bundled to show the same pipeline carrying real UI:

- **`tip_calculator`** — a six-file program (`main`, `home`, `inputs`,
  `summary`, `currency`, `locale_dropdown`). Demonstrates a multi-widget program
  with form inputs, derived state, and number/locale formatting — all
  interpreted. A good look at how a non-trivial app splits across files that
  resolve through the in-memory `sources` map.
- **`clock_face`** — a five-file program including a `CustomPainter`
  (`clock_painter.dart`) that draws an analog clock face. Shows that interpreted
  code can drive the canvas/painting API through the bridges, not just compose
  widgets.

Both are selected and run exactly like `counter_app`; open them in the app to see
the same `buildProgram` path handle progressively more of Flutter.

---

## 13. Where to go next

- **Point the loader at a server.** Implement `SampleSource` to fetch source over
  HTTP instead of from assets, and you have remotely-updatable UI with the same
  `buildProgram` render call.
- **Write your own sample.** Drop a folder under `example/` whose `main.dart`
  exposes `Widget build(BuildContext context)`, re-run the bundler, and it
  appears in the gallery.
- **Read the `SourceFlutterD4rt` API** in
  [`tom_d4rt_flutter`](https://pub.dev/packages/tom_d4rt_flutter) for `build`,
  `buildProgram`, `buildMultiFile`, and the `SampleSource` types.
- **Compare with the CLI samples** (`d4rt_introduction_sample`,
  `d4rt_advanced_sample`, `d4rt_dcli_sample`) to see the same interpreter driving
  non-UI scripts.

The complete, runnable source for this sample lives in the git repository at
`tom_ai/d4rt/tom_d4rt_samples/d4rt_flutter_sample/`.
