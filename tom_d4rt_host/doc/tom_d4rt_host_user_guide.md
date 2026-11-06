# tom_d4rt_host — User Guide

How to run D4rt scripts from an application with `tom_d4rt_host`. The
interpreter's language and bridging are documented in
[`tom_d4rt`](../../tom_d4rt/README.md); this guide covers hosting.

## 1. The two sides

A host has a **near side**, in the application's isolate, and a **far side**,
in the worker isolate:

| Side | Type | What it does |
| --- | --- | --- |
| near | `D4rtHost` | spawns and keeps the worker, queues runs, enforces the deadline and the cancellation, receives channel messages and output |
| far | `D4rtWorker` | keeps the interpreters and the program cache, captures output, runs a request, reports how it ended |
| far | your `D4rtWorkerDelegate` | registers your bridges, fills the per-run state they read, names the failures you recognise |

Only primitives cross between them: a `D4rtRunRequest` going out, and tagged
messages coming back (`D4rtWorkerMessage`).

## 2. Writing the delegate

```dart
class MyDelegate extends D4rtWorkerDelegate<Object?> {
  D4rtWorkerRun? current;

  @override
  void begin(D4rtWorkerRun run) => current = run;          // per-run state

  @override
  Object? interpreterKey(D4rtWorkerRun run) =>
      run.payload['withShell'] == true ? 'shell' : 'plain'; // the bridge set

  @override
  void furnish(D4rt interpreter, Object? key) {            // once per key
    interpreter.registerGlobalGetter(
        'input', () => current!.payload['input'], 'package:my_app/api.dart');
    if (key == 'shell') registerShellBridges(interpreter);
  }

  @override
  void end(D4rtWorkerRun run) => current = null;           // always called
}

D4rtWorkerDelegate<Object?> myDelegate() => MyDelegate();  // top-level
```

- **`begin`** runs before the interpreter is chosen. Build the run's state from
  `run.payload` there; a throw fails the run.
- **`interpreterKey`** must name **every** corpus a run is granted. An
  interpreter keeps what was registered in it, so a key that ignored a corpus
  would let a run reach it because an earlier run had it.
- **`furnish`** is called once per key for the life of the worker. Register
  getters and functions that read the per-run state, never a value captured at
  registration time.
- **`end`** is called whatever the outcome; empty the per-run state so a stray
  access between runs fails rather than reading a finished run.
- **`recognise`** (optional) turns an error into your own words and kind.
  Errors thrown inside interpreted code arrive wrapped by the interpreter, so
  recognise by the exception type's name in `error.toString()`; set
  `withFrames: false` for an error raised outside any interpreted frame.

## 3. Sending messages back

A bridge function calls `run.send(tag, data)`. The host hands each message to
the run's `onMessage(tag, data)` in order, in the zone that called `run` — so a
write the handler performs belongs to the caller's operation (an undo group,
for instance). If the handler throws, the run fails with `kind: rejected` and
the error's `cause`, and the worker is killed: the program is still running and
nobody can describe its state.

`run.emit(stream, text)` adds a line to the transcript, for the application's
own `stdout`/`stderr` sinks; `print` and `dart:io` are captured already.

## 3a. Asking the host: async bridges

`send` is one-way. When a bridge needs an answer — a value the application
holds outside the worker, a call into a service only the host can make — it
returns `run.request(tag, data)`, a `Future` the script awaits:

```dart
// In the delegate's furnish:
interpreter.registertopLevelFunction(
  'loadNote',
  (visitor, args, named, types) => _run!.request('note.load', args.single),
  'package:notes/notes.dart',
);
```

The host answers with `onRequest`, in the zone that called `run`, returning a
value or a `Future` of one; requests in flight together are matched to their
answers by id. When it cannot answer — no `onRequest` was given, the handler
threw, the answer cannot cross the port — the script's call fails with a
`D4rtHostException` (`tag`, `kind`, `message`), which the script catches like
any exception, by name after importing `package:tom_d4rt_host/tom_d4rt_host.dart`.
The run goes on; the worker is kept.

Each `D4rtHostRequest` carries `runGone`, a `TomCancellationToken` that fires
when the run is gone — it ended, timed out, was cancelled, its worker died — so
a handler still working can stop: nobody waits for the answer any more. A run
that returns while a request is unanswered is reported failed
(`kind: outstanding`).

An entry point that awaits must be `async`; the worker runs it with
`executeProgramAsync` and keeps the run — interpreter, output capture, `done` —
until its Future settles, so what it prints after an await is in its
transcript and its error is reported like a synchronous one.

## 4. Running

```dart
final host = D4rtHost(myDelegate, debugName: 'my-scripts');
final outcome = await host.run(
  D4rtRunRequest(
    runId: uuid,                       // unique per run
    source: source,
    sourceHash: sha256Of(source),      // the program-cache key
    entryPoint: 'main',
    arguments: const [],
    programCacheCapacity: 32,
    payload: {'input': 'hello'},
  ),
  deadline: const Duration(seconds: 30),
  cancellation: token,                 // optional
  onMessage: (tag, data) { /* ... */ },
  onRequest: (request) async => answer(request.tag, request.data),
  onOutput: (line) { /* live, in the root zone */ },
);
```

The outcome's `status`, `value`, `error` (message, kind, frames, cause),
`transcript`, `parsed` and `abandonedWorker` say how the run ended; see the
README's table. `workerSpawnCount` and `programParseCount` state residency and
the cache as counts, which is how to test them.

## 5. Releasing

The host holds an isolate, so whoever builds it calls `dispose()`.
`isDisposed` records that it happened.

## 6. Output capture outside a host

`d4rtRunCapturing(body, emit)` runs any body with `print`, `stdout` and
`stderr` sent to `emit`, and `TomOutputRecorder` (from `tom_basics`) keeps the
lines up to a bound and counts the rest.
