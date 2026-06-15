# D4rt DCli Sample — shell scripting plus your own bridges

> The advanced sample bridged **one** library: your own compiled geometry/physics
> engine. Real scripts rarely live in such a closed world — they read files, run
> commands, and talk to the operating system. This sample shows how to give D4rt
> scripts those powers by registering a **ready-made bridge package** —
> [`dcli`](https://pub.dev/packages/dcli), the popular Dart shell-scripting
> library — *alongside* your own generated bridges, in the same interpreter.

A D4rt script can only use types the interpreter has been told about. The
advanced sample taught the interpreter about a library you wrote and generated
bridges for. But you do not have to generate every bridge yourself: a package can
**ship its bridges pre-built**. `tom_d4rt_dcli` does exactly that — it bundles
generated bridges for the whole `dcli` API and exposes a one-call registration
entry point, `TomD4rtDcliBridge.register(d4rt)`.

This article walks through **one** example in depth — `log_report`, a script that
reads a log file with `dcli`, analyses it with a small native library of *your*
own, and writes a report back to disk — and explains *how two bridge sources
coexist*: where each one comes from, how they are registered together, and why
`dcli`'s file functions reach real files even though the script runs in the
sandboxed interpreter. The other two examples are summarised at the end.

---

## Table of contents

1. [The idea: two bridge sources, one interpreter](#1-the-idea-two-bridge-sources-one-interpreter)
2. [Project layout](#2-project-layout)
3. [Running it](#3-running-it)
4. [Bridge source A: the dcli package (pre-built)](#4-bridge-source-a-the-dcli-package-pre-built)
5. [Bridge source B: your native library (generated)](#5-bridge-source-b-your-native-library-generated)
6. [The generator configuration: `buildkit.yaml`](#6-the-generator-configuration-buildkityaml)
7. [Registering both sources in the runner](#7-registering-both-sources-in-the-runner)
8. [The focus example: `log_report`](#8-the-focus-example-log_report)
9. [Why native bridges sidestep the sandbox](#9-why-native-bridges-sidestep-the-sandbox)
10. [A dcli gotcha: `'string'.toList()` runs, `read()` reads](#10-a-dcli-gotcha-stringtolist-runs-read-reads)
11. [The other examples](#11-the-other-examples)
12. [Where to go next](#12-where-to-go-next)

---

## 1. The idea: two bridge sources, one interpreter

Consider this script:

```dart
import 'package:dcli/dcli.dart';
import 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart';

void main() {
  final lines = read('sample.log').toList();   // dcli — reads a real file
  final stats = LogStats();                     // your library — pure logic
  stats.addAll(LogParser().parseAll(lines));
  'report.txt'.write(stats.summary());          // dcli — writes a real file
}
```

Two different `import`s, two different origins of bridged types:

- `read`, `'…'.write`, `'…'.toList` come from **`dcli`**. The interpreter knows
  about them because `tom_d4rt_dcli` shipped pre-generated bridges and we
  registered them.
- `LogStats`, `LogParser` come from **this project's library**. The interpreter
  knows about them because *we* ran the bridge generator over our barrel.

From the script's point of view there is no difference — both look like ordinary
Dart. The whole point of this sample is that mixing the two is nothing more than
calling **two registration functions** before `execute()`.

---

## 2. Project layout

```
d4rt_dcli_sample/
├── pubspec.yaml                 # depends on tom_d4rt, tom_d4rt_dcli, dcli
├── buildkit.yaml                # generator config — for OUR library only
├── bin/
│   └── run_example.dart         # the runner (registers BOTH bridge sources)
├── lib/
│   ├── d4rt_dcli_sample.dart    # barrel for the native log-analysis library
│   ├── dartscript.b.dart        # GENERATED — DcliSampleBridges.register(...)
│   ├── d4rt_bridges.b.dart      # GENERATED — bridge barrel
│   └── src/
│       ├── loglib/              # the native library (hand-written)
│       │   ├── log_entry.dart   #   LogLevel enum + LogEntry
│       │   ├── log_parser.dart  #   LogParser
│       │   └── log_stats.dart   #   LogStats
│       └── d4rt_bridges/        # GENERATED — *.b.dart for loglib
└── example/
    ├── log_report/              # ← the focus example
    │   ├── main.dart
    │   └── sample.log           # bundled data file
    ├── file_toolkit/main.dart   # pure dcli filesystem ops
    └── shell_run/main.dart      # running processes + reading env
```

The `*.b.dart` files are **generated** from `buildkit.yaml` and must never be
hand-edited. Note they only cover *our* library — the `dcli` bridges live inside
the `tom_d4rt_dcli` package, not here.

---

## 3. Running it

```bash
# from the project root
./run_example.sh log_report        # reads sample.log, writes report.txt
./run_example.sh file_toolkit      # create/find/read/delete files
./run_example.sh shell_run         # run `dart --version`, read $PATH

# Windows
./run_example.ps1 log_report

# a one-off script on stdin
echo "import 'package:dcli/dcli.dart'; void main(){ print(exists('.')); }" \
  | ./run_example.sh
```

The first run fetches dependencies and, if `lib/dartscript.b.dart` is missing,
runs the generator. Each example folder also has a `run.sh` you can launch from
anywhere; it just calls back into the root runner.

Expected output of `log_report`:

```
Read 15 line(s) from sample.log

  #1 INFO    service starting up
  ...
  #13 ERROR   unhandled exception in /reports: NullPointer
  ...

Log summary — 15 record(s)
--------------------------------
  DEBUG   2
  INFO    8
  WARNING 2
  ERROR   3

Errors:
  line 7: database connection refused (attempt 1)
  line 9: database connection refused (attempt 2)
  line 13: unhandled exception in /reports: NullPointer

Report written to report.txt (3 error(s) of 15 records)
```

---

## 4. Bridge source A: the dcli package (pre-built)

`dcli` is a general-purpose shell-scripting library: top-level functions like
`read`, `createDir`, `exists`, `delete`, `find`; a `StringAsProcess` extension
that turns a string into a runnable command (`'ls -la'.run`); helpers like `Env`,
`Ask`, and `Confirm`. Bridging all of that by hand would be a large job.

We do not have to. The `tom_d4rt_dcli` package already contains the generated
bridges for the entire `dcli` surface, plus `path`, `tom_chattools`, and the CLI
helper API. It bundles them behind a single registration class:

```dart
// from package:tom_d4rt_dcli/tom_d4rt_dcli.dart
class TomD4rtDcliBridge {
  static void register([D4rt? interpreter]) {
    // registers dcli, path, env, StringAsProcess, ... under their package URIs
  }
}
```

So consuming a third-party bridge package is two lines: add the dependency, then
call its `register`. This is the recommended way to share bridges — publish them
once, register them everywhere.

---

## 5. Bridge source B: your native library (generated)

The analysis logic is plain, testable native Dart in `lib/src/loglib/`. Three
small types:

`log_entry.dart` — the model:

```dart
enum LogLevel {
  debug, info, warning, error;
  static LogLevel? fromName(String name) { /* ... */ }
  String get label => name.toUpperCase().padRight(7);
}

class LogEntry {
  LogEntry(this.lineNumber, this.level, this.message);
  final int lineNumber;
  final LogLevel level;
  final String message;
  bool get isError => level == LogLevel.error;
}
```

`log_parser.dart` — turns raw lines into entries, skipping noise:

```dart
class LogParser {
  LogEntry? parse(String line, int lineNumber) { /* regex match */ }
  List<LogEntry> parseAll(List<String> lines) { /* ... */ }
}
```

`log_stats.dart` — aggregates counts per level and collects errors, with a
`summary()` that renders the report text.

None of this code knows anything about D4rt. It is exported by the barrel
`lib/d4rt_dcli_sample.dart`, and the generator turns the barrel into bridges.

---

## 6. The generator configuration: `buildkit.yaml`

```yaml
d4rtgen:
  name: d4rt_dcli_sample
  helpersImport: package:tom_d4rt/tom_d4rt.dart
  generateBarrel: true
  barrelPath: lib/d4rt_bridges.b.dart
  generateDartscript: true
  dartscriptPath: lib/dartscript.b.dart
  registrationClass: DcliSampleBridges
  modules:
    - name: loglib
      barrelFiles:
        - lib/d4rt_dcli_sample.dart
      barrelImport: package:d4rt_dcli_sample/d4rt_dcli_sample.dart
      outputPath: lib/src/d4rt_bridges/loglib_bridges.b.dart
```

The key point: this config describes **only our library**. We do not, and must
not, list `dcli` here — its bridges already exist in `tom_d4rt_dcli`. Regenerate
with:

```bash
dart run tom_d4rt_generator:d4rtgen
```

The generator emits `lib/src/d4rt_bridges/loglib_bridges.b.dart` (the
`BridgedClass` definitions for `LogEntry`, `LogParser`, `LogStats`, and the
`LogLevel` enum) and a `DcliSampleBridges.register(...)` entry point in
`lib/dartscript.b.dart`.

> The generator also prints `No generic extraction sites collected` and writes an
> empty `relaxers.b.dart`. That is expected — our library has no generic methods
> that need relaxation wrappers.

---

## 7. Registering both sources in the runner

`bin/run_example.dart` is the advanced sample's runner with **one extra
registration call**. Before every script runs:

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';
import 'package:d4rt_dcli_sample/dartscript.b.dart';

final d4rt = D4rt();

// Source B: this project's native log-analysis library.
DcliSampleBridges.register(d4rt);
// Source A: the dcli shell-scripting bridges.
TomD4rtDcliBridge.register(d4rt);

d4rt.execute(source: ..., library: ..., sources: ..., positionalArgs: [args]);
```

Order does not matter here — the two sources register types under different
package URIs (`package:d4rt_dcli_sample/...` and `package:dcli/...`), so there is
no collision. After both calls the single interpreter knows the union of both
APIs, and a script can `import` and use either.

The runner has one dcli-specific twist. In folder mode it loads every `.dart`
file into the in-memory `sources` map (so relative script imports resolve), and
then sets the **process working directory** to the example folder:

```dart
Directory.current = folder.absolute.path;
```

That is what lets `read('sample.log')` and `'report.txt'.write(...)` use simple
relative paths — they resolve next to the script, the way a real shell script
behaves when you `cd` into a directory first.

---

## 8. The focus example: `log_report`

Here is the whole script (`example/log_report/main.dart`):

```dart
import 'package:dcli/dcli.dart';
import 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart';

void main(List<String> args) {
  const logPath = 'sample.log';
  const reportPath = 'report.txt';

  if (!exists(logPath)) {                 // dcli: filesystem check
    print('No $logPath found in the current directory.');
    return;
  }

  final lines = read(logPath).toList();   // dcli: read file → List<String>
  print('Read ${lines.length} line(s) from $logPath\n');

  final parser = LogParser();             // your library
  final stats = LogStats();
  final entries = parser.parseAll(lines);
  stats.addAll(entries);

  for (final entry in entries) {
    print('  $entry');
  }

  final report = stats.summary();         // your library renders the report
  print('\n$report');

  reportPath.write(report);               // dcli: write file
  print('Report written to $reportPath '
      '(${stats.countOf(LogLevel.error)} error(s) of ${stats.total} records)');
}
```

Trace the data across the two bridge sources:

1. `exists(logPath)` and `read(logPath)` are **dcli** top-level functions. They
   run as compiled native code and touch the real filesystem.
2. `read(...).toList()` hands back a native `List<String>`, which the interpreter
   treats as an ordinary list.
3. `LogParser().parseAll(lines)` is **your** bridge. The interpreter constructs a
   native `LogParser`, passes the list across, and gets back a native
   `List<LogEntry>`.
4. `stats.summary()` builds the report string entirely in native code.
5. `'report.txt'.write(report)` is **dcli** again — the report lands on disk.

No glue, no marshalling code: each `import` simply resolves to its registered
bridge, and values flow between them as native objects.

---

## 9. Why native bridges sidestep the sandbox

D4rt is a **sandboxed** interpreter. Interpreted `dart:io` access is gated by a
permission system — a script that `import 'dart:io'` and tries to open a file
must be granted a `FilesystemPermission`, or the import is refused. So how does
`read('sample.log')` reach the disk without any permission grant?

Because a **bridge is compiled native code**. When the script calls `read(...)`,
the interpreter does not execute interpreted `dart:io`; it invokes the adapter
function inside `tom_d4rt_dcli`, which is ordinary Dart running at full trust in
the host process. The sandbox governs what the *interpreted* program may do
directly; it does not — and cannot — restrict what the native functions you chose
to expose go on to do.

This is the safety contract to keep in mind when you register bridges: **you are
deciding what the script is allowed to touch.** Registering `dcli` is handing a
script the keys to the filesystem and the process table. For trusted developer
tooling (the natural home of dcli scripting) that is exactly what you want; for
running untrusted code you would register a narrower set of bridges.

---

## 10. A dcli gotcha: `'string'.toList()` runs, `read()` reads

dcli's `StringAsProcess` extension overloads on *intent*, and it trips up
newcomers (it tripped up the first draft of this sample):

| Expression | What it does |
| ---------- | ------------ |
| `'dart --version'.run` | **runs** the string as a process, streaming output |
| `'dart --version'.toList()` | **runs** it, returns stdout as `List<String>` |
| `read('file.txt').toList()` | **reads** the file `file.txt` as lines |
| `'file.txt'.write('hi')` | **writes** to the file `file.txt` |
| `read('file.txt').toParagraph()` | **reads** the file as one string |

So the string-extension methods that *capture output* (`toList`, `toParagraph`,
`firstLine`, `forEach`) treat the receiver as a **command**, while file reading
goes through the top-level **`read()`** function (which returns a `Progress` you
then drain). File *writing*, confusingly, is the `'path'.write(content)`
extension. When in doubt: `read()` for input, `'path'.write()` for output,
`'cmd'.run`/`.toList()` for processes.

---

## 11. The other examples

Two more scripts in `example/` reuse the same runner and registrations:

- **`file_toolkit`** — pure dcli filesystem work: `createDir`, `'path'.write`,
  `find('*.txt', ...)`, `read(...).toParagraph()`, `deleteDir`. A self-contained
  tour of dcli's file API, creating a scratch directory and cleaning it up.
- **`shell_run`** — process execution and the environment: capture a command with
  `'dart --version'.toList()`, stream one with `.run`, and read a variable with
  `env['PATH']`.

Both work the same way as the focus example: they `import 'package:dcli/dcli.dart'`
and rely on the dcli bridges the runner registered.

---

## 12. Where to go next

- **The next sample** (`d4rt_userbridges_sample`) goes the other direction: when
  the generator's automatic output is not quite right, you override individual
  classes by hand with `@D4rtUserBridge` / `D4UserBridge`, and tune the rest with
  advanced `buildkit.yaml` configuration.
- **Publish your own bridge package.** `tom_d4rt_dcli` is just a package that
  generated its bridges and exposed a `register` function. You can do the same
  with the log-analysis library here: ship `loglib_bridges.b.dart` and let other
  projects register it in one call — exactly how this sample consumes dcli.
- **Read the dcli docs** at <https://pub.dev/packages/dcli> for the full API the
  bridges expose.

The complete, runnable source for this sample lives in the git repository at
`tom_ai/d4rt/tom_d4rt_samples/d4rt_dcli_sample/`.
