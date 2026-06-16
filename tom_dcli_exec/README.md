# tom_dcli_exec

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

Analyzer-free D4rt REPL/CLI with full DCli shell-scripting bridges — the extensible base for building D4rt command-line tools.

## Overview

`tom_dcli_exec` is the DCli-equipped tier of the D4rt interpreter stack. It layers on top of
`tom_d4rt_exec` (the analyzer-free mirror-AST interpreter) and adds:

- A complete set of generated DCli shell-scripting bridges so that D4rt scripts can call
  `dcli`, `dcli_core`, `dcli_terminal`, `path`, and related packages directly.
- A production-grade interactive REPL built around an abstract base class (`D4rtReplBase`)
  that downstream tools subclass to add their own bridge sets and commands.
- A `cli` global variable available inside every D4rt script, giving programmatic access to
  all REPL operations (evaluate, execute files, navigate sessions, introspect bridges, etc.).
- VS Code scripting-API integration via `tom_vscode_scripting_api` — connect to a running VS
  Code bridge and evaluate expressions or run scripts from within the REPL.
- Telegram/chat bot mode via `tom_chattools` — run the REPL as a long-lived Telegram bot
  server with configurable security, file transfer, conversation trail, and Copilot-chat
  forwarding.

### Source-based vs analyzer-free — which D4rt family

D4rt ships in two execution families, and `tom_dcli_exec` belongs to the
second:

- **Source-based (analyzer)** — `tom_d4rt`, **`tom_d4rt_dcli`**,
  `tom_d4rt_flutter`. Parses Dart source with the analyzer, giving full type
  inference and precise error reporting. This is the **stable reference and
  usually the preferable choice**.
- **Analyzer-free (mirror AST)** — `tom_d4rt_ast`, `tom_ast_model`,
  `tom_ast_generator`, `tom_d4rt_exec`, **`tom_dcli_exec`**,
  `tom_d4rt_flutter_ast`. Runs from pre-compiled `SAstNode` trees with **no
  analyzer dependency at runtime**, which makes it viable on the **web** (the
  analyzer is too large to ship there) and for **on-the-fly / OTA updates**.
  It is a complete alternative, but because generated AST bundles are large,
  the source-based interpreter is usually preferable unless the web/OTA
  constraint applies.

The workspace therefore contains two parallel DCli-capable tools that expose
the same `D4rtReplBase` / `DcliRepl` surface and differ only in the underlying
engine:

| Package | Interpreter | Source parsing | Binary |
|---------|-------------|----------------|--------|
| `tom_dcli_exec` **(this)** | `tom_d4rt_exec` — analyzer-free, mirror AST | `tom_ast_generator` (analyzer only at parse time, not at runtime) | `dclie` |
| [`tom_d4rt_dcli`](../tom_d4rt_dcli/README.md) | `tom_d4rt` — full analyzer-based interpreter | built-in analyzer runtime | `dcli` |

`tom_dcli_exec` carries the `analyzer` package only to drive
`tom_ast_generator`'s source-to-mirror-AST conversion; the interpreter itself
never loads the analyzer at runtime, which is what makes the engine viable on
the web and for OTA bundle delivery. A tool written against the source-based
twin [`tom_d4rt_dcli`](../tom_d4rt_dcli/README.md) ports here by swapping the
dependency.

### Ecosystem position

```
tom_ast_model
    └─ tom_d4rt_ast
           └─ tom_ast_generator      (source → mirror AST)
                  └─ tom_d4rt_exec   (analyzer-free interpreter)
                         └─ tom_dcli_exec   ← THIS PACKAGE
                                └─ tom_dartscript_bridges  (binary: d4rt)
                                └─ tom_build_cli           (binary: tom)
```

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tom_dcli_exec: ^1.1.3
```

Or via the command line:

```sh
dart pub add tom_dcli_exec
```

### Executable: `dclie`

The package ships a single CLI binary entry-point at `bin/dclie.dart` named **`dclie`**
(D4rt CLI Exec). After activating the package globally you can run it directly:

```sh
dart pub global activate tom_dcli_exec
dclie                          # start interactive REPL
dclie myscript.dart            # execute a Dart file and exit
dclie myscript.dcli            # execute a DCli replay file and exit
dclie "print('hello');"        # evaluate an expression and exit
```

## Features

### DCli shell-scripting bridges

All DCli shell functions (`ask`, `confirm`, `delete`, `echo`, `fetch`, `find`, `head`,
`menu`, `read`, `replace`, `run`, `tail`, `which`, and more) are available as D4rt bridges
generated from the real DCli source. Bridge coverage also includes:

- `dcli_core` — file system primitives (`cat`, `copy`, `move`, `mkdir`, `touch`, …)
- `dcli_terminal` — terminal control
- `path` — path manipulation utilities
- `dart_console` / `console_markdown` — formatted console output
- `tom_chattools` — Telegram chat integration types
- `tom_vscode_scripting_api` — VS Code bridge client

Bridges are registered with `TomD4rtDcliBridge.register(d4rt)` and the corresponding import
block is injected automatically so D4rt scripts can use `import 'package:dcli/dcli.dart';`
without further setup.

### Interactive REPL

The REPL (`DcliRepl`, backed by `D4rtReplBase`) provides:

- **Command history** — persistent scrollback saved to `~/.tom/dcli/.history`, pre-populated
  at startup; up to 500 lines retained.
- **Named sessions** — record all input to `*.session.txt` files; resume or replace them with
  `-session <id>` / `-replace-session <id>`.
- **Multiline modes** — `.start-define`, `.start-script`, `.start-file`, `.start-execute`,
  closed with `.end`. Inline shortcuts: `exec <code>` and `exp <expr>`.
- **Replay files** — `.dcli` and `.replay.txt` files executed via `.load` (with output) or
  `.replay` (silent). Pass a replay file as a positional argument to run-and-exit.
- **Command aliases (defines)** — `define greet=print("Hello, $1!");` then `@greet World`.
  Supports `$$` (entire args) and positional `$1`–`$9`.
- **Directory navigation** — `cd`, `cwd`, `home`, `ls`, `sessions`, `plays`, `scripts`,
  `executes`.
- **Bridge introspection** — `classes`, `enums`, `methods`, `variables`, `imports`,
  `registered-*` variants, `info [query]`, `--dump-configuration`.
- **Init source** — auto-loads `dcli_init_source.dart` from the data directory at startup;
  override with `-init-source <file>` or skip with `-no-init-source`.
- **stdin mode** — `echo 'return 5+6;' | dclie --stdin` — bare expression, auto-wrapped
  in `main()`, exit code set to integer result.
- **Test mode** — `-run-replay <file> -test [-output <file>]` — executes a replay file and
  writes a structured test-result JSON for CI integration.
- **CTRL-C handling** — single press interrupts an in-progress `await`; double-press within
  1 second exits the REPL.
- **Console markdown** — all output is processed through `console_markdown` so help text and
  error messages render with ANSI color tags (`<cyan>`, `<yellow>`, `<red>`, …).

### VS Code integration (`VSCodeIntegrationMixin`)

`DcliRepl` mixes in `VSCodeIntegrationMixin`, exposing these REPL commands:

| Command | Effect |
|---------|--------|
| `connect [host:port]` | Connect to VS Code bridge (default port 19900) |
| `disconnect` | Disconnect |
| `is-available [port]` | Probe availability |
| `vscode <expression>` | Evaluate expression in VS Code bridge |
| `.vscode <file>` | Execute a Dart file via VS Code bridge |
| `.start-vscode-eval` / `.start-vscode-script` | Multiline VS Code eval/script modes |

Connection is lazy — the `LazyVSCodeBridgeAdapter` defers the TCP connection until the first
command that actually needs it.

### Telegram bot mode

Start with `--bot-mode [--bot-config <file>]`. The `TelegramBotServer` (from
`src/bot_mode/`) manages multiple simultaneous bot connections and routes each incoming
Telegram message through:

1. **Security validation** (`SecurityManager`) — allow-list by user ID, command patterns,
   and path restrictions loaded from YAML config (`BotModeConfig`).
2. **Message classification** — explicit Copilot prompt (`?`-prefix), implicit Copilot
   prompt (ends with `.` / `?` / `---` or starts with `TODO:` / `QUESTION:`), or REPL
   command.
3. **REPL execution** — the command is processed exactly as if typed interactively.
4. **Conversation trail** — attachments and references accumulate in `ConversationTrail`;
   retrieve them with `list-attachments`, `get-attachments <ids>`, etc.
5. **Output formatting** — `OutputFormatter` converts ANSI console-markdown to Telegram
   MarkdownV2 via `telegram_markdown.dart`.

### `cli` global variable

Every D4rt script running inside this REPL can access the `cli` global, an instance of
`D4rtCliApi` (implemented by `D4rtCliController`):

```dart
import 'package:tom_dcli_exec/tom_d4rt_cli_api.dart';

// Navigate
cli.cd('/my/project');
print(cli.cwd());

// Introspect
final all = cli.classes();
for (final c in all) {
  print('${c.name}: ${c.methods.length} methods');
}

// Evaluate
final result = await cli.eval('1 + 2');
print(result); // 3

// Replay a file silently, then check defines
await cli.replay('setup.dcli');
print(cli.defines());
```

The `cli` object exposes the full command surface: `processPrompt`, `processPrompts`, `eval`,
`execute`, `executeFile`, `file`, `script`, `load`, `replay`, `session`, `reset`, multiline
helpers (`startDefine`, `startScript`, `startFile`, `startExecute`, `end`), define management
(`define`, `undefine`, `defines`, `loadDefines`, `invokeDefine`, `expandDefine`), directory
operations (`cd`, `cwd`, `home`, `ls`, `sessions`, `plays`, `scripts`, `executes`), and
introspection (`classes`, `enums`, `methods`, `variables`, `imports`, `registeredClasses`,
etc.).

### Test utilities

`verify(condition, message)` and related helpers in `src/api/cli_test_utils.dart` are
registered as D4rt bridges and available in scripts. Failures accumulate in
`verificationFailures` for batch reporting at the end of a `-test` run.

## Quick start — running scripts

Once `dclie` is on your `PATH` (`dart pub global activate tom_dcli_exec`), a
D4rt script can carry a shebang and run directly like any shell script:

```dart
#!/usr/bin/env dclie
import 'package:dcli/dcli.dart';

// A throwaway maintenance script — no compile step needed.
final stale = find('*.tmp', workingDirectory: '.').toList();
for (final f in stale) {
  print('removing $f');
  delete(f);
}
print('cleaned ${stale.length} temp files');
```

```sh
chmod +x cleanup.dart
./cleanup.dart          # the shebang routes the file through dclie
```

For one-liners, generated code, or composing with other shell tools, pipe the
source straight into `dclie --stdin`. The process exit code is the script's
return value, so scripts slot into pipelines and `&&` chains:

```sh
echo 'print(42);' | dclie --stdin
cat my_script.dart | dclie --stdin
echo 'return 5 + 6;' | dclie --stdin          # exit code = 11
generate_script | dclie --stdin && echo ok    # gate on the script's result
```

### Examples

The [`example/`](example/README.md) folder collects runnable DCli snippets and
multi-file CLI apps for this analyzer-free base. For a standalone,
repo-curated walkthrough see the
[`d4rt_dcli_sample`](../tom_d4rt_samples/d4rt_dcli_sample/README.md) in the
shared `tom_d4rt_samples` collection. Both run unchanged on the source-based
twin [`tom_d4rt_dcli`](../tom_d4rt_dcli/example/README.md) — the sample homes
are shared across the two engines rather than duplicated.

## Quick start — extending the REPL

Subclass `D4rtReplBase` to create a tool with your own bridges:

```dart
import 'package:tom_dcli_exec/tom_dcli_exec.dart';

class MyRepl extends D4rtReplBase {
  @override
  String get toolName => 'MyTool';

  @override
  String get toolVersion => '1.0.0';

  @override
  void registerBridges(D4rt d4rt) {
    // Register the DCli bridges from this package
    TomD4rtDcliBridge.register(d4rt);
    // Register your own additional bridges here
  }

  @override
  String getImportBlock() {
    return getStdlibImports() + TomD4rtDcliBridge.getImportBlock();
  }

  @override
  String getBridgesHelp([D4rt? d4rt]) => 'My bridge help...';
}

Future<void> main(List<String> arguments) async {
  await MyRepl().run(arguments);
}
```

Override additional hooks as needed:

| Override | Purpose |
|----------|---------|
| `toolExtension` | Replay file extension (default: `toolName.toLowerCase()`) |
| `replayFilePatterns` | Patterns matched when listing replay files |
| `dataDirectory` | Storage root for sessions, history (default: `~/.tom/<toolname>`) |
| `handleAdditionalCommands` | Add custom REPL commands; return `true` when handled |
| `handleAdditionalMultilineEnd` | Handle custom multiline modes |
| `getAdditionalHelpSections` | Inject extra sections into `help` output |
| `onReplStartup` | Run logic after the REPL banner is printed |
| `createReplState` | Return a custom `ReplState` subclass |

Mix in `VSCodeIntegrationMixin` to add VS Code commands without re-implementing them (see
`DcliRepl` in `lib/tom_dcli_exec.dart` for the canonical example).

## Architecture

```
D4rtReplBase  (lib/src/cli/repl_base.dart)
  │
  ├─ ReplState              console + history + sessions + prompt rendering
  ├─ CliReplIntegration     wires D4rtCliController into the REPL loop
  ├─ PersistentHistory      ~/.tom/<tool>/.history  (dart_console scrollback)
  ├─ VSCodeIntegrationMixin lazy TCP bridge to VS Code (optional mixin)
  └─ BotMode/               TelegramBotServer + SecurityManager + ConversationTrail
         └─ tom_chattools   Telegram API client

D4rtCliController  (lib/src/api/cli_controller.dart)
  │  implements D4rtCliApi
  └─ no Console dependency — usable in scripts, tests, headless contexts

TomD4rtDcliBridge  (lib/dartscript.b.dart)
  │  generated by tom_d4rt_generator at build time
  ├─ DcliBridge              dcli + dcli_core + dcli_terminal bridges
  ├─ PathBridge              path bridges
  ├─ TomChattoolsBridge      tom_chattools bridges
  ├─ TomVscodeScriptingApiBridge  tom_vscode_scripting_api bridges
  └─ CliApiBridge            cli global + D4rtCliApi bridges
```

The REPL loop in `D4rtReplBase.run()` is wrapped in a `runZonedGuarded` zone that pipes all
`print()` output through `console_markdown`, so ANSI color tags work transparently in every
bridge and user script.

## CLI reference

```
dclie [options] [script.dart | replay.dcli | "expression"]

Positional Arguments
  dclie script.dart           Execute a Dart file and exit
  dclie replay.dcli           Execute replay file and exit
  dclie "expression"          Evaluate a Dart expression and exit

Options
  -h, --help                  Show help
  -v, --version               Show version
  --stdin                     Read and execute source from stdin
  -session <id>               Resume or start a named session
  -replace-session <id>       Delete existing session and start fresh
  -replay <file>              Replay a file before starting REPL
  -run-replay <file>          Execute replay file and exit
  -test                       Run replay in test mode (with -run-replay)
  -output <file>              Write test output to file (with -test)
  -list-sessions              List available sessions
  -init-source <file>         Use custom init source file
  -no-init-source             Do not load init source
  --dump-configuration        Dump registered bridges and configuration
  --debug                     Print init source and debug info
  --bot-mode                  Run as Telegram bot server
  --bot-config <file>         Bot mode configuration YAML file
```

## Further documentation

| Document | What it covers |
|---|---|
| [`doc/build.md`](doc/build.md) | Building and compiling the `dclie` binary; bridge regeneration via `build_runner`. |
| [`doc/testing.md`](doc/testing.md) | Test layout and how to run the suite with `testkit`. |

### Related packages

| Package | Relationship |
|---|---|
| [`tom_d4rt_exec`](../tom_d4rt_exec/README.md) | The analyzer-free interpreter this package is built on. |
| [`tom_d4rt_dcli`](../tom_d4rt_dcli/README.md) | Source-based twin — same `DcliRepl` surface on `tom_d4rt`. |
| [`tom_ast_generator`](../tom_ast_generator/README.md) | Source → mirror-AST conversion used at parse time. |

## Status

Current release: **1.1.3** (389 tests, 0 failures, 0 skips).

Source repository: <https://github.com/al-the-bear/tom_d4rt/tree/main/tom_dcli_exec>

Downstream packages that build on this base:

- **`tom_dartscript_bridges`** — adds Tom Framework bridges; compiles the `d4rt` binary.
- **`tom_build_cli`** — adds build tooling bridges; compiles the `tom` binary.
