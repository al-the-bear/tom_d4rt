# D4rt Introduction Sample

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

> The on-ramp to D4rt. This project runs **multi-file D4rt programs with nothing
> but the interpreter** — no external libraries, no generated bridges, no host
> integration. It is the smallest complete picture of "embed an interpreter,
> hand it some source, get a result back", and it establishes the runner and
> run-script conventions reused by the other samples in `tom_d4rt_samples/`.

D4rt is a sandboxed Dart interpreter written in Dart. You give it Dart source as
a **string** and it executes that source inside your process — no `dart compile`,
no separate VM, no code generation. Because the program is data, you can load it
at runtime: from a file, a network response, or a database row. That is the
whole point of an interpreter, and this sample shows the bare mechanics before
any of the more advanced machinery (bridges, dcli, Flutter rendering) is layered
on top.

This article walks through **one** example in depth — a small multi-file
expression calculator — and explains *how it actually works*: how the runner is
built, how the interpreter resolves imports between files, and how a value
travels from your script back to your Dart program. The two other examples in
the project are summarised at the end.

---

## Table of contents

1. [What you'll build](#1-what-youll-build)
2. [Project layout](#2-project-layout)
3. [Running it](#3-running-it)
4. [The mental model: source in, value out](#4-the-mental-model-source-in-value-out)
5. [The runner, line by line](#5-the-runner-line-by-line)
6. [How multi-file resolution actually works](#6-how-multi-file-resolution-actually-works)
7. [The calculator, file by file](#7-the-calculator-file-by-file)
8. [What the interpreter does at run time](#8-what-the-interpreter-does-at-run-time)
9. [Passing arguments and reading results](#9-passing-arguments-and-reading-results)
10. [Stdin mode](#10-stdin-mode)
11. [The sandbox](#11-the-sandbox)
12. [The other examples](#12-the-other-examples)
13. [Where to go next](#13-where-to-go-next)

---

## 1. What you'll build

The focus example is a **mini expression language**: you type something like
`(2 + 3) * 4` or a short program with variables, and it computes the result. It
is intentionally *not* a toy one-liner — it is a real, if small, interpreter in
its own right, split across four files:

```
tokenizer.dart   →   parser.dart   →   evaluator.dart   →   main.dart
  (text→tokens)      (tokens→AST)      (AST→number)        (entry point)
```

The reason for choosing this example is that it exercises a broad slice of the
Dart language — classes, enums, a class hierarchy with a polymorphic method,
recursion, `switch`, collections, exceptions — **without needing a single host
type**. Everything it uses (`String`, `double`, `Map`, `List`, `print`) is built
into the interpreter. That makes it the perfect first sample: all the complexity
is in the *interpreted* program, none of it in plumbing.

---

## 2. Project layout

```
d4rt_introduction_sample/
├── pubspec.yaml                 # depends only on tom_d4rt
├── README.md                    # this article
├── run_example.sh               # POSIX runner (also accepts stdin)
├── run_example.ps1              # PowerShell runner (also accepts stdin)
├── she_bang_macos.sh            # compile run_example + open a shell with it on PATH (macOS)
├── she_bang_linux.sh            # compile run_example + open a shell with it on PATH (Linux)
├── bin/
│   └── run_example.dart         # the runner: builds D4rt, loads a folder, executes
└── example/
    ├── calculator/              # the focus example (multi-file)
    │   ├── tokenizer.dart
    │   ├── parser.dart
    │   ├── evaluator.dart
    │   ├── util/format.dart
    │   ├── main.dart            # executable: starts with #!/usr/bin/env run_example
    │   └── run.sh               # directly-executable convenience wrapper
    ├── json_report/             # collections + closures (multi-file)
    │   ├── model.dart
    │   ├── main.dart
    │   └── run.sh
    └── state_machine/           # enum state machine (single-file)
        ├── main.dart
        └── run.sh
```

Two kinds of code live here, and keeping them straight is the single most
important idea in the whole sample:

- **`bin/run_example.dart` is compiled Dart.** It is your *host program*. It
  imports `package:tom_d4rt/d4rt.dart`, constructs an interpreter, and runs it.
  It is ordinary Dart that you `dart run` or `dart compile`.
- **Everything under `example/` is interpreted D4rt.** Those `.dart` files are
  never compiled. They are read as text and fed to the interpreter at run time.
  They *look* exactly like normal Dart (and your editor will analyse them as
  such, which is a feature — you get tooling for free), but they execute inside
  the sandbox.

---

## 3. Running it

From the package root:

```sh
# Run the calculator's demo program:
./run_example.sh calculator

# Evaluate a single expression (args after the name are forwarded to the script):
./run_example.sh calculator "(2 + 3) * 4"

# The other examples:
./run_example.sh json_report
./run_example.sh state_machine
```

On Windows use the PowerShell runner:

```powershell
./run_example.ps1 calculator
./run_example.ps1 calculator "(2 + 3) * 4"
```

Each example folder also has a directly-executable `run.sh`:

```sh
example/calculator/run.sh "(2 + 3) * 4"
```

Expected output for `./run_example.sh calculator`:

```
Running calculator demo:
  radius = 3   -> 3.0
  pi = 3.14159   -> 3.14159
  area = pi * radius * radius   -> 28.274309999999996
  circumference = 2 * pi * radius   -> 18.849539999999998
  area + circumference   = 47.12384999999999

Final environment: {radius: 3.0, pi: 3.14159, area: 28.274309999999996, circumference: 18.849539999999998}
```

### Running an example directly (shebang launchers)

Each example's `main.dart` begins with a shebang line:

```dart
#!/usr/bin/env run_example
```

so it can be executed *as a file* — `./main.dart` — instead of going through
`run_example.sh`. For that to work, a real `run_example` binary has to be on
`PATH`. This is the same pattern `tom_d4rt_dcli` uses: it ships a compiled `dcli`
binary that runs a script passed as its argument, so a script starting with
`#!/usr/bin/env dcli` is directly executable.

The `she_bang_macos.sh` / `she_bang_linux.sh` helpers set this up for you: they
compile `bin/run_example.dart` to a native `bin/run_example` binary, put it on
`PATH`, and drop you into a shell where the shebang resolves:

```sh
./she_bang_macos.sh            # (or ./she_bang_linux.sh on Linux)
# ...then, inside the spawned shell:
cd example/calculator
./main.dart                    # runs the demo
./main.dart "(2 + 3) * 4"      # evaluates one expression
```

When `run_example` is handed a file path, it runs that file as the entry script,
loading the sibling `.dart` files in the same folder so relative imports (such as
the calculator's `util/format.dart`) still resolve. Both D4rt and the Dart
analyzer treat the leading `#!` line as a *script tag* and ignore it, so the same
files continue to work unchanged via `./run_example.sh <name>` and in your
editor. The compiled binary is gitignored — build it with the `she_bang_*`
helper on the machine where you want to run the launchers.

---

## 4. The mental model: source in, value out

Strip away the file loading and the calculator domain, and the entire
interaction with D4rt is three lines:

```dart
import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();
  final result = d4rt.execute(source: 'int main() => 6 * 7;');
  print(result); // 42
}
```

`D4rt()` builds a fresh interpreter with the standard library registered
(`dart:core`, `dart:math`, `dart:collection`, …) but no host bridges.
`execute()` parses the source, runs the function named `main` (the default), and
returns whatever that function returns — marshalled back into a native Dart
value. A `String` comes back as a `String`, an `int` as an `int`, a `List` as a
`List`. The interpreter is a black box that turns *text* into a *value*.

Everything else in this sample is about feeding `execute()` a **program that
spans several files** instead of a single string, and giving it arguments.

---

## 5. The runner, line by line

`bin/run_example.dart` is the host program. It has two modes: run an example
folder by name, or read a script from stdin. Here is the heart of folder mode:

```dart
const _packageRoot = 'package:example';

void _runFolder(String name, List<String> scriptArgs) {
  final folder = Directory('example/$name');
  // ... existence checks omitted ...

  // Mount every .dart file in the folder under the synthetic package.
  final sources = <String, String>{};
  for (final entity in folder.listSync()) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final fileName = entity.uri.pathSegments.last;
      sources['$_packageRoot/$fileName'] = entity.readAsStringSync();
    }
  }

  final entryUri = '$_packageRoot/main.dart';
  _execute(
    source: sources[entryUri]!,
    library: entryUri,
    sources: sources,
    scriptArgs: scriptArgs,
    label: name,
  );
}
```

And the shared execution path:

```dart
void _execute({
  required String source,
  required List<String> scriptArgs,
  required String label,
  String? library,
  Map<String, String>? sources,
}) {
  final d4rt = D4rt();
  final result = d4rt.execute(
    source: source,
    library: library,
    sources: sources,
    positionalArgs: [scriptArgs],
  );
  if (result != null) stdout.writeln('=> $result');
}
```

Read it from the outside in:

- **It reads files from disk in *compiled* Dart.** The host program is allowed
  to touch the filesystem — it is your code. What it does *not* do is ask the
  interpreter to read files. It reads them itself and hands the interpreter a
  map of `URI → source`.
- **It assigns each file a synthetic URI.** `tokenizer.dart` becomes
  `package:example/tokenizer.dart`, `main.dart` becomes
  `package:example/main.dart`, and so on. The package name `example` is
  arbitrary — what matters is that every file shares the same package prefix so
  relative imports between them resolve. (Section 6 explains why.)
- **It names the entry library.** `library: 'package:example/main.dart'` tells
  the interpreter "this source you're about to run *is* that library", so the
  imports written inside it are resolved relative to that URI.
- **A fresh `D4rt()` per run.** Each invocation gets a clean interpreter, so one
  example can never leak state into another.

That is the entire runner. The interpreter does the hard part; the host just
gathers source and forwards a result.

---

## 6. How multi-file resolution actually works

This is the one piece of machinery worth understanding precisely, because it is
where newcomers expect the interpreter to behave like the Dart VM and are
surprised when it does not.

**The pure `tom_d4rt` interpreter never reads the filesystem.** It has no notion
of "the current directory" or "a file on disk". When it encounters

```dart
import 'parser.dart';
```

inside `package:example/main.dart`, it does two things:

1. **Resolve the URI.** Relative import strings are resolved against the
   importing library's URI using ordinary URI resolution —
   `Uri.parse('package:example/main.dart').resolve('parser.dart')` yields
   `package:example/parser.dart`.
2. **Look the result up in the `sources` map.** If `package:example/parser.dart`
   is a key in the map you passed to `execute()`, the interpreter loads that
   source and processes its declarations. If it is *not* a key, you get
   `Unable to resolve … import` — the interpreter has nowhere to fetch it from.

This is why the runner mounts the whole folder under one package prefix: it
guarantees that every relative import a file writes will resolve to a sibling URI
that is also in the map. "Load all files in the folder so relative imports
resolve" is, concretely, "put every file in the `sources` map under the same
package".

Two consequences fall out of this design:

- **You control exactly what the program can import.** There is no ambient
  filesystem to wander into; the program can only import URIs you explicitly
  provided (plus the built-in `dart:` libraries). This is part of what makes the
  interpreter a sandbox.
- **The same shape works without a filesystem at all.** A Flutter app on a phone
  has no script directory, but it can download a JSON bundle of `URI → source`,
  drop it into the `sources` map, and run a multi-file program identically. The
  `d4rt_flutter_sample` does exactly this.

> **Aside — the `basePath` option.** You may see `execute(basePath: …,
> allowFileSystemImports: true)` in other code. That is a feature of the
> *execution* variant `tom_d4rt_exec`, which *does* read sibling files from disk.
> The published `tom_d4rt` used here resolves through the `sources` map instead.
> Both reach the same place; the map approach is the more fundamental one and the
> one that also works on platforms with no filesystem.

---

## 7. The calculator, file by file

The interpreted program is a textbook three-stage interpreter. Each stage is its
own file, and each imports the stage(s) before it.

### `tokenizer.dart` — text → tokens

The tokenizer turns a raw string like `"x = 6 * 7"` into a flat list of `Token`
objects. It defines an `enum TokenType`, a `Token` class, and a `tokenize`
function that scans character by character:

```dart
enum TokenType { number, plus, minus, star, slash, lparen, rparen, identifier, assign, eof }

class Token {
  final TokenType type;
  final String text;
  final double value;
  Token(this.type, this.text, [this.value = 0]);
}

List<Token> tokenize(String expr) { /* scan, emit tokens, append eof */ }
```

Note what is in play already: an enum, a class with an optional positional
constructor parameter, string indexing, `codeUnitAt`, `double.parse`, a `switch`
over single characters, and a thrown `FormatException` for unexpected input.
This is all interpreted — the interpreter implements `String.codeUnitAt`,
`double.parse`, and exception throwing/catching itself.

### `parser.dart` — tokens → AST

The parser is a hand-written recursive-descent parser that turns the token list
into an **abstract syntax tree** of `Expr` nodes. This file shows two things the
introduction is meant to teach: a **relative import** and a **polymorphic class
hierarchy**.

```dart
import 'tokenizer.dart';            // <- resolved via the sources map

abstract class Expr {
  double evaluate(Map<String, double> environment);
}

class NumberExpr extends Expr { /* returns a literal */ }
class VariableExpr extends Expr { /* looks a name up in the environment */ }
class BinaryExpr extends Expr { /* applies +, -, *, / to two sub-expressions */ }
class NegateExpr extends Expr { /* unary minus */ }
class AssignExpr extends Expr { /* stores into the environment */ }
```

Each node knows how to `evaluate` itself, so evaluating the whole tree is a
single polymorphic call on the root. The `Parser` class walks the tokens using a
small precedence-climbing grammar (`expression` → `term` → `factor`), building
the tree bottom-up. Recursion, `while` loops, lookahead, and exceptions all run
inside the interpreter exactly as they would compiled.

### `evaluator.dart` — AST → number

The evaluator ties the pipeline together and adds the one piece of state that
makes the calculator feel like a language: a **variable environment** that
survives across lines.

```dart
import 'tokenizer.dart';
import 'parser.dart';

class Calculator {
  final Map<String, double> environment = {};

  double eval(String line) {
    final tokens = tokenize(line);
    final ast = Parser(tokens).parse();
    return ast.evaluate(environment);
  }

  double run(List<String> program) { /* eval each non-blank line */ }
}
```

Because `environment` is a field on `Calculator`, an assignment on one line
(`radius = 3`) is visible to the next (`area = pi * radius * radius`). The
`Map<String, double>` is a genuine interpreted map; the interpreter implements
`Map`'s `[]`, `[]=`, `putIfAbsent`, and iteration.

### `main.dart` — the entry point

`main.dart` imports only the evaluator and provides the function the runner
calls:

```dart
import 'evaluator.dart';

void main(List<String> args) {
  final calc = Calculator();
  if (args.isNotEmpty) {
    final expr = args.join(' ');
    print('$expr = ${calc.eval(expr)}');
    return;
  }
  // otherwise run a short demo program ...
}
```

The transitive import graph is `main.dart → evaluator.dart → {parser.dart,
tokenizer.dart}`. When the interpreter processes `main.dart`'s
`import 'evaluator.dart'`, it pulls in the evaluator, which pulls in the parser
and tokenizer — every one resolved through the `sources` map. You never list the
files explicitly anywhere; the import graph discovers them.

---

## 8. What the interpreter does at run time

When `execute()` is called with the calculator's `main.dart` as `source` and the
folder as `sources`, roughly this happens:

1. **Parse the entry source.** The entry `main.dart` text is parsed into an AST.
2. **Process its imports.** `import 'evaluator.dart'` is resolved to
   `package:example/evaluator.dart`, fetched from the map, parsed, and *its*
   imports processed in turn — recursively loading the parser and tokenizer.
   Each module's top-level declarations (classes, enums, functions) are
   registered into the interpreter's environment.
3. **Two-pass declaration handling.** The interpreter first creates placeholders
   for every class and enum (so forward references work — a class can reference
   another defined later), then evaluates their members. This is why
   `evaluator.dart` can refer to `Parser` and `Expr` from other files regardless
   of load order.
4. **Invoke `main`.** The function named by `name` (default `'main'`) is called
   with the positional arguments you supplied. Its return value is marshalled
   back to native Dart and handed to you.

You do not orchestrate any of this — you hand over the source map and the entry
URI, and the module loader walks the graph.

---

## 9. Passing arguments and reading results

The runner forwards everything after the example name to the script:

```dart
d4rt.execute(
  source: source,
  library: library,
  sources: sources,
  positionalArgs: [scriptArgs],   // scriptArgs is a List<String>
);
```

`positionalArgs` is the list of positional arguments passed to the invoked
function. The calculator's `main(List<String> args)` therefore receives the
forwarded CLI words as its `args`. That is how

```sh
./run_example.sh calculator "(2 + 3) * 4"
```

ends up evaluating that expression: `["(2 + 3) * 4"]` arrives as `args`, the
script joins and evaluates it, and prints `(2 + 3) * 4 = 20.0`.

Reading a result back is just as direct. `execute()` *returns* the value of the
invoked function. The calculator's `main` returns `void`, so the runner prints
nothing extra; but if a script's `main` returned, say, a number, the runner's
`if (result != null) stdout.writeln('=> $result');` would surface it. Try it
from stdin:

```sh
printf 'num main(_) => 6 * 7;' | ./run_example.sh
# => 42
```

---

## 10. Stdin mode

With no example name, the runner reads a complete script from stdin and runs it:

```sh
printf 'void main(List<String> a) {
  var s = 0;
  for (var i = 1; i <= 10; i++) s += i;
  print("sum 1..10 = ${s}");
}' | ./run_example.sh
# sum 1..10 = 55
```

A stdin script has no sibling files, so it must be self-contained — no relative
imports. Internally this is the same `execute()` call with `library` and
`sources` left null: a single source string, the simplest possible case from
section 4.

---

## 11. The sandbox

This sample needs **no permissions at all**, and that is worth dwelling on. The
calculator never touches the filesystem, the network, or any process — it only
computes. So the interpreter runs it with its default-deny posture and nothing
is granted.

Sensitive capabilities are gated behind explicit grants
(`d4rt.grant(FilesystemPermission.any)`, `NetworkPermission`, …). A script that
tried to `import 'dart:io'` without a filesystem grant would be rejected. The
introduction deliberately stays inside the sandbox so the *next* samples can show
what crossing the boundary — via bridges and grants — looks like. Here, the
takeaway is simply: **an interpreter that has been granted nothing can still run
a substantial program, as long as that program only computes.**

---

## 12. The other examples

The project ships two more examples. They are mentioned here only briefly — each
is small enough to read directly.

- **`json_report`** (multi-file: `model.dart` + `main.dart`). Groups a list of
  employee records by department and prints a salary report. It leans on
  collections and higher-order functions — `map`, `putIfAbsent`, `reduce`,
  `sort` with a comparator closure — to show that the interpreter implements the
  full `Iterable`/`Map` API, not just control flow. Run it with
  `./run_example.sh json_report`.

- **`state_machine`** (single-file). Models a turnstile as a pure transition
  function over two enums (`Event`, `TurnstileState`) with nested `switch`
  statements. Because it is one self-contained file, it doubles as a stdin
  example: `cat example/state_machine/main.dart | ./run_example.sh`. Run it with
  `./run_example.sh state_machine`.

The full, runnable source for all three examples — and the runner — lives in this
repository under `tom_d4rt_samples/d4rt_introduction_sample/`. This article shows
the shape and the key fragments; the repository is the complete implementation.

---

## 13. Where to go next

This sample stopped at the interpreter boundary: pure computation, no host
types. The remaining samples in `tom_d4rt_samples/` each cross that boundary one
way:

- **`d4rt_advanced_sample`** — expose your own native Dart classes to scripts
  using the **bridge generator**.
- **`d4rt_dcli_sample`** — give scripts shell-scripting powers by bridging the
  **dcli** library alongside your own.
- **`d4rt_flutter_sample`** — render a **Flutter UI** described by a D4rt script,
  updated on the fly.
- **`d4rt_userbridges_sample`** — hand-tune bridges with **user-bridge
  overrides** and advanced generator configuration.

Start here, then pick whichever boundary you need to cross.
