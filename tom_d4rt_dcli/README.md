# tom_d4rt_dcli

Analyzer-based D4rt CLI with dcli shell-scripting bridges — the extensible foundation for building D4rt command-line tools.

## Overview

`tom_d4rt_dcli` is the **analyzer-based** base layer of the D4rt CLI ecosystem. It sits directly on top of `tom_d4rt` (the Dart-analyzer-powered sandboxed interpreter) and adds:

- Full dcli shell-scripting bridges (`dcli`, `dcli_core`, `dcli_terminal`)
- VS Code scripting-API bridges (`tom_vscode_scripting_api`)
- Telegram / chat integration bridges (`tom_chattools`)
- An abstract base REPL class (`D4rtReplBase`) that downstream tool packages extend
- A ready-to-run concrete REPL (`DcliRepl`) exposed as the `dcli` executable

The package is the **shared nucleus** of the stacked-REPL design used across the Tom workspace:

```
dcli  (DcliRepl in this package, bin/dcli.dart)
  └── tom_dartscript_bridges  (binary: d4rt — adds full Tom Framework bridges)
        └── tom_build_cli       (binary: tom — adds build/workspace bridges)
```

### Analyzer-based vs analyzer-free

`tom_d4rt_dcli` requires the Dart analyzer to resolve and execute scripts, which gives full type inference and precise error reporting. If you need a lightweight interpreter without that dependency, use its counterpart `tom_dcli_exec`, which is built on `tom_d4rt_exec` (analyzer-free runtime). Both packages expose the same `D4rtReplBase` / `DcliRepl` surface but differ in the underlying execution engine.

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tom_d4rt_dcli: ^1.1.4
```

Or via the command line:

```bash
dart pub add tom_d4rt_dcli
```

### `dcli` executable

The package ships a `bin/dcli.dart` entry point. After adding the dependency you can run the REPL directly through `dart run`:

```bash
dart run tom_d4rt_dcli:dcli
```

In downstream tool packages that compile the binary, the entry point is:

```dart
import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

Future<void> main(List<String> arguments) async {
  await DcliRepl().run(arguments);
}
```

---

## Features

### dcli shell-scripting bridges

Scripts executed inside the REPL or passed as files have transparent access to the full dcli API family:

| Package | Bridge class | Notable bridged types |
|---|---|---|
| `dcli` | `PackageDcliBridge` | `Ask`, `Confirm`, `FetchUrl`, `DartScript`, `DartSdk`, `Settings`, `Shell`, `DCliPaths`, `FileSyncFile`, `NamedLock`, `PubCache`, `ProcessDetails`, `Remote` |
| `dcli_core` | `PackageDcliCoreBridge` | `Cat`, `Env`, `Find`, `FindItem`, `FindConfig`, `Which`, `DCliPlatform`, `LineFile`, `RunException` |
| `dcli_terminal` | `PackageDcliTerminalBridge` | `Ansi`, `AnsiColor`, `Format`, `Terminal`, `TableAlignment` |

Scripts can use the standard dcli idioms directly in D4rt:

```dart
import 'package:dcli/dcli.dart';

// File operations
touch('output.txt', create: true);
'output.txt'.write('Hello from D4rt!');
final lines = read('output.txt').toList();
copy('output.txt', 'backup.txt');

// Process execution
'git status'.run;
final result = 'ls -la'.toList();

// Environment
final home = env['HOME'];
if (isOnPATH('dart')) print('Dart is available');
```

### VS Code scripting-API bridge

The `PackageTomVscodeScriptingApiBridge` exposes `tom_vscode_scripting_api` classes to scripts running inside the interpreter, including `VSCodeBridgeClient`, `LazyVSCodeBridgeAdapter`, `VSCodeBridgeResult`, `VSCode`, `VSCodeCommands`, `VSCodeCommonCommands`, `VSCodeWindow`, `VSCodeWorkspace`, `VSCodeChat`, `VSCodeExtensions`, `VSCodeLanguageModel`, `LanguageModelChat`, `LanguageModelChatMessage`, `ChatParticipant`, `ChatRequest`, and related types.

### Telegram / chat bridge

The `PackageTomChattoolsBridge` bridges `tom_chattools` types — `ChatConfig`, `ChatMessage`, `ChatSender`, `ChatAttachment`, `ChatResponse`, `ChatReceiver`, `ChatApi`, `ChatMessageFilter`, and `TelegramChatConfig` — making them usable inside D4rt scripts without any native Dart compilation.

### REPL features

**Multiline input modes** — enter blocks spanning multiple lines:

| Command | Mode |
|---|---|
| `.start-define` | Define functions/classes (persist in session) |
| `.start-script` | Execute block with return value |
| `.start-file` | Run in current REPL environment |
| `.start-execute` | Run as isolated fresh program |
| `.start-vscode-eval` | Evaluate in connected VS Code bridge |
| `.start-vscode-script` | Execute full script in VS Code bridge |
| `.end` | Finish and execute the current block |

**Persistent command history** — history is stored to `~/.tom/dcli/.history` (up to 500 lines) and reloaded on the next REPL startup. Arrow-key navigation is provided by `dart_console`.

**Sessions** — all interactive input is recorded to `~/.tom/dcli/<session-id>.session.txt` and replayed on resume:

```bash
dcli -session mywork        # start or resume a named session
dcli -replace-session mywork  # delete session and start fresh
dcli -list-sessions           # list available sessions
```

**Replay files** — pre-written `.dcli` (or `.replay.txt`) files can be loaded interactively or executed headlessly:

```bash
dcli setup.dcli                          # execute replay file and exit
dcli -run-replay setup.dcli              # same, explicit flag
dcli -run-replay tests.dcli -test        # test mode (verifies assertions)
dcli -replay warmup.dcli -session main   # replay into a named session
dcli -replay warmup.dcli                 # replay before starting REPL
```

**Bot mode** — run the REPL as a Telegram bot server. Commands are received from authorised Telegram users, executed against the D4rt interpreter, and results are returned as formatted messages:

```bash
dcli --bot-mode --bot-config bot.yaml
```

Bot-mode configuration (`BotModeConfig`) is loaded from a YAML file and supports multiple bots, per-bot VS Code server connections, command whitelists/blacklists, directory allow/block lists, execution time/output-size limits, file-transfer policies, and Telegram message formatting options.

**stdin execution** — pipe code directly:

```bash
echo 'print(42);' | dcli --stdin
cat my_script.dart | dcli --stdin
echo 'return 5 + 6;' | dcli --stdin   # exit code = result
```

**Init source** — place a `dcli_init_source.dart` file in `~/.tom/dcli/` to auto-import packages or declare globals before every session.

**Command aliases (defines)** — create shorthand aliases with argument placeholders:

```
define greet=print("Hello, $1!");
@greet World    # → prints Hello, World!
```

**Keyboard shortcuts** — `Up/Down` history, `Home/Ctrl-A`, `End/Ctrl-E`, `Ctrl-U`, `Ctrl-K`, `Ctrl-L`, `Ctrl-C` (cancel async / exit on second press).

---

## Quick Start

### Running the REPL interactively

```bash
dart run tom_d4rt_dcli:dcli
```

The banner shows the tool version. Type `help` for the full command reference.

### Evaluating a single expression

```bash
dart run tom_d4rt_dcli:dcli "DateTime.now()"
dart run tom_d4rt_dcli:dcli "env['HOME']"
```

### Executing a Dart file

```bash
dart run tom_d4rt_dcli:dcli myscript.dart
```

### Running a replay file

```bash
dart run tom_d4rt_dcli:dcli my_setup.dcli
```

### Extending D4rtReplBase to build your own CLI tool

`D4rtReplBase` is the abstract backbone. Subclass it and override the extension points:

```dart
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

class MyToolRepl extends D4rtReplBase {
  @override
  String get toolName => 'MyTool';

  @override
  String get toolVersion => '1.0.0';

  /// Called once at startup — register every bridge the tool needs.
  @override
  void registerBridges(D4rt d4rt) {
    // Register the base dcli bridges provided by this package:
    TomD4rtDcliBridge.register(d4rt);
    // Add your own bridges here...
  }

  /// Return the import block prepended to every script.
  @override
  String getImportBlock() {
    return getStdlibImports() + TomD4rtDcliBridge.getImportBlock();
  }

  /// Describe available bridges in the `help` output.
  @override
  String getBridgesHelp([D4rt? d4rt]) => 'Bridges: dcli, my_custom_package';

  /// Handle tool-specific REPL commands.
  /// Return true to consume the command, false to fall through.
  @override
  Future<bool> handleAdditionalCommands(
    D4rt d4rt,
    ReplState state,
    String line, {
    bool silent = false,
  }) async {
    if (line == 'my-command') {
      print('Handled by MyTool!');
      return true;
    }
    return false;
  }
}

Future<void> main(List<String> arguments) async {
  await MyToolRepl().run(arguments);
}
```

To also include VS Code integration, mix in `VSCodeIntegrationMixin` (as `DcliRepl` itself does) and call `initVSCodeIntegration()` inside `createReplState`, then delegate to `handleVSCodeCommands` from `handleAdditionalCommands`.

### Using the `cli` global variable inside scripts

Every D4rt session exposes a `cli` global (type `D4rtCliApi`) that gives scripts programmatic access to REPL operations:

```dart
// Inside a D4rt script or replay file
cli.cd('/my/project');
await cli.replay('setup.dcli');

final allClasses = cli.classes();
for (final c in allClasses) {
  print('${c.name}: ${c.methods.length} methods');
}

final result = await cli.eval('1 + 2');
print(result); // 3
```

---

## Examples

The [`example/`](example/README.md) folder is the **canonical DCli sample
home** for the D4rt CLI ecosystem. Alongside the single-file snippets it
ships two extended, multi-file CLI applications:

| Sample | Description |
|--------|-------------|
| [`example/build_suite/`](example/build_suite/README.md) | Build/automation tool — `BuildTask` hierarchy + `TaskRunner` across files, shell bridges, and a `buildkit.yaml` BuildKit pipeline |
| [`example/log_pipeline/`](example/log_pipeline/README.md) | File-processing pipeline — parse → filter → aggregate stages over generated `.log` files, with a written report and coloured summary |

Both run unchanged on the analyzer-free sibling
[`tom_dcli_exec`](../tom_dcli_exec/example/README.md), which points back here
instead of duplicating samples.

---

## Architecture

### Stacked-REPL design

```
D4rtReplBase  (abstract base — this package)
    │
    ├─ DcliRepl + VSCodeIntegrationMixin  (concrete dcli REPL — this package)
    │
    └─ [downstream tool packages extend D4rtReplBase directly]
         e.g. tom_dartscript_bridges (d4rt binary),
              tom_build_cli (tom binary)
```

`D4rtReplBase` owns the full REPL loop, argument parsing, session management, history, multiline input, bot mode, stdin mode, `--help`/`--version` output, and the `cli` global registration. Downstream tools add only bridges, additional commands, and branding.

### Bridge registration

Bridges are generated by `tom_d4rt_generator` (dev dependency `^1.9.0`) via `build_runner`. The generation marker is tracked in `lib/d4rt_bridges.g.info`. The generated bridge modules registered by `TomD4rtDcliBridge.register(d4rt)` are:

| Module | Bridged package |
|---|---|
| `PackageDcliBridge` | `dcli` |
| `PackageDcliCoreBridge` | `dcli_core` |
| `PackageDcliTerminalBridge` | `dcli_terminal` |
| `PackageTomVscodeScriptingApiBridge` | `tom_vscode_scripting_api` |
| `PackageTomChattoolsBridge` | `tom_chattools` |
| `PackageCryptoBridge` | `crypto` |
| `PackageTomD4rtDcliBridge` | `tom_d4rt_dcli` itself (the `cli` API) |

Total bridged classes across all modules: 70 (as of v1.1.4 build 2026-02-07).

### Data directory layout

The REPL stores all persistent state under `~/.tom/dcli/`:

```
~/.tom/dcli/
├── .history                      # Persistent command history (up to 500 lines)
├── dcli_init_source.dart         # Optional custom init script (auto-loaded)
├── <session-id>.session.txt      # Recorded session files (auto-managed)
```

---

## Ecosystem fit

| Package | Role | Notes |
|---|---|---|
| `tom_d4rt` | Analyzer-based interpreter runtime | Direct dependency |
| `tom_d4rt_dcli` | **This package** — dcli CLI base | Analyzer-based |
| `tom_dcli_exec` | Analyzer-free dcli CLI base | Lighter weight, no analyzer |
| `tom_dartscript_bridges` | Full D4rt binary (`d4rt`) | Extends `D4rtReplBase` |
| `tom_build_cli` | Tom workspace CLI (`tom`) | Extends `D4rtReplBase` |
| `tom_d4rt_generator` | Bridge code generator | Dev dependency |
| `tom_vscode_scripting_api` | VS Code bridge API | Runtime dependency |
| `tom_chattools` | Telegram / chat API | Runtime dependency |

All packages live in the `tom_d4rt` monorepo at
[github.com/al-the-bear/tom_d4rt](https://github.com/al-the-bear/tom_d4rt).
This package resides at
[tom_ai/d4rt/tom_d4rt_dcli](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_dcli).

---

## Status

**Current version: 1.1.4** — regenerated all bridges against `tom_d4rt_generator` 1.9.0.

Requires Dart SDK `^3.10.4`.

```
tom_d4rt:                ^1.8.20
tom_vscode_scripting_api: ^1.0.1
tom_chattools:            ^1.0.2
dcli:                    ^8.4.2
dcli_core:               ^8.2.8
dcli_terminal:           ^8.4.2
```

---

## License

BSD 3-Clause. See [LICENSE](LICENSE).
