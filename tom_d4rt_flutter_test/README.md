# tom_d4rt_flutter_test

Interactive D4rt test runner — executes `tom_d4rt_flutter_ast` test scripts and
the multi-file sample apps under `example/` via the `tom_d4rt` source-based
interpreter.

## Two runtime shells

The app adapts to the platform it runs on:

| Platform                | Shell                                                           | Sample source                |
|-------------------------|-----------------------------------------------------------------|------------------------------|
| macOS / Linux / Windows | Full multi-tab UI: Examples (test runner), Generate, Log, Files | Live `example/` tree on disk |
| iOS / iPadOS / Android  | Simplified sample browser only — tap a sample to run it         | Bundled assets snapshot      |

On mobile the workspace filesystem is sandboxed away, so the **test runner and
code generator are disabled** and samples are loaded from assets that were
copied in at build time. The desktop shell is unchanged and still reads the
live `example/` directory so edits show up on the next reload.

The platform switch lives in `lib/src/sample_source.dart` (`isMobileRuntime` →
`AssetSampleSource` vs `DiskSampleSource`).

## Running the samples on iPad / iPhone (simulator)

Prerequisites: Xcode installed, with an iOS Simulator runtime
(Xcode → Settings → Platforms).

```bash
# From this project directory:
./run_ipad.sh          # iPad simulator
./run_iphone.sh        # iPhone simulator
./run_simulator.sh     # follow the VS Code-selected device, else first booted sim
./run_simulator.sh <udid>   # a specific simulator
```

Each script (re)bundles the samples, boots/opens the Simulator, and runs the
app via `flutter run -d <udid>`. In the VS Code integrated terminal,
`./run_simulator.sh` with no argument follows the device you picked in the
Flutter status-bar selector (`$FLUTTER_TARGET_DEVICE`).

To run on a physical iPad/iPhone instead, plug it in and pass its device id
(`flutter devices`) — the same `flutter run -d <id>` applies; a real device
additionally needs a signing team set in `ios/Runner.xcodeproj`.

## Refreshing the bundled samples

The mobile build reads a snapshot of `example/` from `assets/samples/`. The run
scripts do this automatically, but you can regenerate it by hand after adding,
removing, or editing a sample:

```bash
dart run tool/sync_samples_to_assets.dart
```

This mirrors every `example/<name>/*.dart` into `assets/samples/<name>/`, writes
the manifest `assets/samples/index.json`, and regenerates the asset list in
`pubspec.yaml` (between the `# >>> ... generated sample assets ...` markers —
Flutter does not bundle nested asset directories recursively, so each sample
folder is listed explicitly). `assets/samples/` is fully regenerated each run,
so deleted samples are pruned.

## How sample loading works

Both platforms converge on a `SampleProgram` — a `{libraryUri: source}` map
with every transitively-imported relative file already resolved — which feeds
`SourceFlutterD4rt.buildProgram`. The interpreter performs no filesystem access
itself (`allowFileSystemImports: false`); the disk path resolves imports via
`resolveImportsRecursively`, while the asset path keys sources by synthetic
`file:///samples/<name>/...` URIs so relative imports resolve identically
without a real filesystem.
