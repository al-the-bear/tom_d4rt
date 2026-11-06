## 0.2.0

### Added — async scripts (dasy1)

The worker runs a program with `tom_d4rt`'s `executeProgramAsync` and holds
the run until an `async` entry point's Future settles: its interpreter stays
checked out, what it prints after an `await` is in its transcript, its `done`
is sent only then, and its error is reported like a synchronous one (status
`failed`, its type, its frames). One run at a time still holds — the worker
queues what arrives while a run is in flight — and the deadline bounds a
Future that never completes. `D4rtWorker.serve` returns a `Future<void>`;
`D4rtWorker.receive` takes a message from the host.

### Added — the request/reply channel (tdimpa1)

`D4rtWorkerRun.request(tag, data)` sends a request and returns a Future of the
host's answer, so a bridge can return it and the script can `await` it.
`D4rtHost.run` takes `onRequest`, a `D4rtRequestHandler` that receives a
`D4rtHostRequest` (`runId`, `tag`, `data`, `runGone`) in the caller's zone and
returns `FutureOr<Object?>`. Replies are matched by id. A request with no
handler, a handler that throws and an answer that cannot cross the port fail
the awaiting call with a `D4rtHostException` (`refused`, the handler's error
type, `unsendable`), which the script can catch by name; every worker
interpreter has it, in `package:tom_d4rt_host/tom_d4rt_host.dart`. A run whose
entry point returns while a request is unanswered is reported failed
(`D4rtRunError.outstandingKind`), and `runGone` fires for the handlers in flight
when the run is gone — ended, timed out, cancelled or abandoned. New protocol
tags: `D4rtWorkerMessage.request`, `D4rtHostMessage.reply`.

### Changed (breaking)

`D4rtWorkerRun.request` is the new request method; the run's
`D4rtRunRequest` is `D4rtWorkerRun.runRequest`.

Requires `tom_d4rt` 1.231.1.

## 0.1.0

- `D4rtHost`: one resident worker isolate serving runs one at a time, with a
  deadline and a cancellation that kill the worker, an application message
  channel whose handler runs in the caller's zone and may refuse a message, live
  output in the root zone, and `workerSpawnCount`, `programParseCount`,
  `dispose` and `isDisposed`.
- `D4rtWorker`, `D4rtWorkerDelegate`, `D4rtWorkerRun` and `d4rtWorkerMain`: the
  worker body the application furnishes — its bridges, its per-run state, the
  failures it recognises.
- `D4rtInterpreterPool`: one interpreter per bridge set, released after every
  run.
- `D4rtProgramCache`: a bounded LRU of parsed programs keyed by source hash,
  with `parseCount`.
- `d4rtRunCapturing` and `D4rtCapturedStdout`: `print`, `stdout` and `stderr`
  into one emitter.
- `D4rtRunRequest`, `D4rtRunOutcome`, `D4rtRunStatus`, `D4rtRunError`,
  `D4rtFrame` and `D4rtWorkerMessage`: what crosses the port.
