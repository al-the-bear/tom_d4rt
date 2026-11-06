# tom_d4rt_host

Published on pub.dev as [`tom_d4rt_host`](https://pub.dev/packages/tom_d4rt_host).

Running D4rt scripts inside an application. A `D4rtHost` owns one **resident**
worker isolate and serves runs one at a time; the application supplies its
bridges, the per-run state they read and its own message channel, and gets back
how each run ended and what it printed.

- **Resident worker.** The isolate outlives a run, so an interpreter furnished
  once serves every later run with the same bridges.
- **One interpreter per bridge set** (`D4rtInterpreterPool`). A registered
  bridge corpus cannot be withdrawn, so an interpreter is identified by every
  corpus registered in it, and a program never reaches a corpus it was not
  granted because an earlier run had it.
- **A parsed-program cache** (`D4rtProgramCache`): a bounded LRU keyed by a
  hash of the source, so an unmodified script is not parsed again.
- **Deadline and cancellation that work.** A runaway cannot be asked to stop;
  the host kills the worker and spawns a fresh one for the next run. A program
  that merely fails keeps the worker.
- **Async scripts.** An `async` entry point is served to completion: the run
  keeps the worker, its output capture and its report until the Future
  settles.
- **The application's channel.** A script's calls into the application's
  bridges send messages back (`D4rtWorkerRun.send`); the host hands each to the
  run's handler in order, in the caller's zone. A message the handler refuses
  fails the run.
- **Requests the host answers.** A bridge returns `D4rtWorkerRun.request(tag,
  data)`, a Future the script awaits; the host's `onRequest` answers it in the
  caller's zone. A request the host cannot answer fails the script's call with a
  catchable `D4rtHostException`, not the run.
- **One transcript.** `print`, `dart:io`'s `stdout` and `stderr`, and the
  application's own sinks land in one bounded `TomOutputTranscript`
  (`tom_basics`), interleaved in the order they happened, with any dropped lines
  counted.

A Dart VM library: it spawns isolates and redirects `dart:io`.

## Install

```yaml
dependencies:
  tom_d4rt_host: ^0.2.0
```

## Usage

The application's side runs inside the worker, so it is a
`D4rtWorkerDelegate` built by a **top-level** factory function (it crosses
`Isolate.spawn`):

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

class TodoDelegate extends D4rtWorkerDelegate<Object?> {
  D4rtWorkerRun? _run;

  @override
  void begin(D4rtWorkerRun run) => _run = run;

  @override
  Object? interpreterKey(D4rtWorkerRun run) => 'todo';

  @override
  void furnish(D4rt interpreter, Object? key) {
    interpreter
      ..registerGlobalGetter(
          'items', () => _run!.payload['items'], 'package:todo/todo.dart')
      ..registertopLevelFunction('complete', (visitor, args, named, types) {
        _run!.send('complete', args.single);
        return null;
      }, 'package:todo/todo.dart');
  }

  @override
  void end(D4rtWorkerRun run) => _run = null;
}

D4rtWorkerDelegate<Object?> todoDelegate() => TodoDelegate();

Future<void> main() async {
  final host = D4rtHost(todoDelegate);
  final outcome = await host.run(
    const D4rtRunRequest(
      runId: 'run-1',
      source: "import 'package:todo/todo.dart';\n"
          "int main() { complete(items.first); print('done'); return 1; }",
      sourceHash: 'todo-1',
      payload: {'items': ['write the README']},
    ),
    deadline: const Duration(seconds: 10),
    onMessage: (tag, data) => print('host: $tag $data'),
  );
  print('${outcome.status.name} ${outcome.value}'); // ok 1
  print(outcome.transcript.lines.single.text); // done
  await host.dispose();
}
```

The runnable version is [`example/tom_d4rt_host_example.dart`](example/tom_d4rt_host_example.dart).

## Async bridges over `request`

`send` is one-way. A bridge that needs an answer from the application — a value
it holds outside the worker, a call into a service only the host can make —
returns `run.request(tag, data)`. The script awaits it like any other Future
(`tom_d4rt` awaits a bridged Future natively), and the host answers with
`onRequest`:

```dart
// Inside the worker: the delegate's furnish.
interpreter.registertopLevelFunction(
  'loadNote',
  (visitor, args, named, types) => _run!.request('note.load', args.single),
  'package:notes/notes.dart',
);

// The script.
//   import 'package:notes/notes.dart';
//   import 'package:tom_d4rt_host/tom_d4rt_host.dart';
//   Future<String> main() async {
//     try {
//       final note = await loadNote(1);
//       return note['title'];
//     } on D4rtHostException catch (e) {
//       return 'unavailable: ${e.message}';
//     }
//   }

// On the host: answered in the caller's zone, synchronously or with a Future.
final outcome = await host.run(
  request,
  deadline: const Duration(seconds: 10),
  onRequest: (request) async {
    if (request.runGone.isCancelled) return null; // nobody waits any more
    return store.load(request.data! as int);
  },
);
```

- **Replies are matched by id**, so a script may have several requests in
  flight (`Future.wait`) and each answer reaches the call that asked.
- **A request the host cannot answer fails the call, not the run**: with no
  `onRequest`, a handler that throws, or an answer that cannot cross the port,
  the awaiting call fails with a `D4rtHostException` (`tag`, `kind` — `refused`,
  `unsendable` or the handler's error type — and `message`). The worker is kept.
- **Every request must be awaited**: a run whose entry point returns while one
  is unanswered is reported failed (`kind: outstanding`).
- **The run going away is announced**: `request.runGone` fires when the run
  ends, times out, is cancelled or loses its worker. The deadline and the
  cancellation still kill the isolate, a run suspended on a request included.

The runnable version is [`example/async_request_example.dart`](example/async_request_example.dart).

## How a run ends

| Status | When | The worker |
| --- | --- | --- |
| `ok` | the entry point returned — an `async` one once its Future completed | kept |
| `failed` | the source did not parse (`kind: parse`), the program threw (its runtime type, or a kind the delegate's `recognise` named), the begin step threw | kept |
| `failed` | the entry point returned while a request was unanswered (`kind: outstanding`) | kept |
| `failed` | the run's handler refused a channel message (`kind: rejected`, `cause` holds what it threw) | killed |
| `failed` | the worker died or exited without reporting (`kind: isolate`) | killed |
| `timedOut` | the run passed its deadline | killed |
| `cancelled` | the cancellation token fired; the message is its reason | killed |

`run` never throws for anything the program did; it throws only when no worker
can be started. A failed run's outcome still carries what it printed, and a
runtime failure carries the interpreter's frames in the program that was run
(`D4rtFrame`: line, column, function), innermost first.

## Why the worker is resident

Measured on a 6.4 kB script in Webwork's script host, in one process,
alternating:

| | per-run isolate | resident | |
| --- | --- | --- | --- |
| without the dcli corpus | 6 509 µs / 4 186 µs | 3 391 µs / 2 296 µs | **≈ 47 % less** |
| with the dcli corpus | 3 211 µs / 3 288 µs | 1 719 µs / 1 322 µs | **≈ 50 % less** |

A bare `Isolate.spawn` + round trip + kill is 0.2–0.6 ms of that; the rest is
the interpreter being furnished again. The parse is about 2.2 ms of a run, which
is what the program cache saves.

Residency has costs, each answered here rather than hoped for:

- **Per-run state is repointed, not captured.** Bridges are registered once,
  so they must read a slot the delegate fills in `begin` and empties in `end`.
  `end` is called whatever the outcome.
- **Each run releases what its interpreter retained.** A resident `D4rt` pins
  its last run's parsed unit, visitor and script-declared environment; the pool
  calls `D4rt.dispose` after every run. It keeps the bridges and the bound
  module environments, so it costs nothing residency is for, and it leaves the
  program cache alone.
- **A message from an abandoned run is dropped.** Every message carries its
  run id, and the host drops one from a run it has given up on.

## Output capture

`print` reaches the run's zone (the interpreter's `print` calls Dart's);
`dart:io`'s `stdout` and `stderr` are replaced through `IOOverrides` with
`D4rtCapturedStdout`, which treats `write` and `writeln` as one line each and
splits bytes into lines. Every producer calls one emitter, so the order is a
fact. The transcript is bounded **in the worker** — 2 000 lines of at most
4 000 characters, the oldest kept — because a host-side cap would still pay the
port for every line of a runaway, and the dropped count arrives with the
outcome. `d4rtRunCapturing` is the same capture for any other body.

## Dependencies

| Package | Why |
| --- | --- |
| [`tom_d4rt`](../tom_d4rt/README.md) | the interpreter, from pub.dev |
| `tom_basics` | the output transcript and the cancellation token |

## Documentation

- [User guide](doc/tom_d4rt_host_user_guide.md)
- [Limitations](doc/tom_d4rt_host_limitations.md)
- [API summary](doc/tom_d4rt_host_api_summary.md)

## License

BSD-3-Clause — see [`LICENSE`](LICENSE).
