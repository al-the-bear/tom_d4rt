/// The near side of the port: a host that owns one resident worker.
library;

import 'dart:async';
import 'dart:isolate';

import 'package:tom_basics/utilities.dart';

import 'run_protocol.dart';
import 'worker.dart';

/// Receives one message the run sent on the application's channel.
///
/// Called in order, in the zone that called [D4rtHost.run], so whatever it
/// writes belongs to the caller's operation. A throw refuses the message: the
/// run fails with [D4rtRunError.rejectedKind] and the worker is killed,
/// because the program is still running and nobody can describe its state.
typedef D4rtMessageHandler = void Function(String tag, Object? data);

/// One request a run is awaiting an answer to (`D4rtWorkerRun.request`), as
/// the host's [D4rtRequestHandler] receives it.
class D4rtHostRequest {
  const D4rtHostRequest({
    required this.runId,
    required this.tag,
    required this.data,
    required this.runGone,
  });

  /// The run that asked.
  final String runId;

  /// What the run asked for, in the application's own vocabulary.
  final String tag;

  /// What it sent with the question.
  final Object? data;

  /// Fires when the run is gone — it ended, timed out, was cancelled, its
  /// worker died — so a handler still working on the answer can stop: nobody
  /// is waiting for it any more. Its reason says which.
  final TomCancellationToken runGone;
}

/// Answers one request a run sent ([D4rtHostRequest]); what it returns (or
/// completes with) is sent back to the run.
///
/// Called in the zone that called [D4rtHost.run], like [D4rtMessageHandler],
/// and possibly several times at once: a run that starts more than one request
/// before awaiting them has them all in flight. A throw — or a failed Future —
/// does not end the run: the run's request fails with a [D4rtHostException]
/// the script can catch. The value crosses the port, so it must be sendable.
typedef D4rtRequestHandler =
    FutureOr<Object?> Function(D4rtHostRequest request);

/// Runs programs in one resident worker isolate, one at a time.
///
/// * Runs are **serialized**: a worker serves one at a time — an `async` run
///   keeps it until its Future settles — and queueing them here makes that a
///   property rather than an accident.
/// * Every message from the worker is tagged with its run, and one from a run
///   the host has given up on is dropped.
/// * A run that is **abandoned** while the interpreter is still executing — a
///   deadline, a cancellation, a refused channel message — or whose worker dies
///   kills the worker; the next run spawns a fresh one. A program that merely
///   *fails* keeps it: its error came back through a clean `done`, the worker
///   is idle and correct, and respawning would charge a full restart for a
///   typo.
///
/// The application supplies a [D4rtWorkerDelegateFactory] — a top-level
/// function, since it crosses `Isolate.spawn` — that builds its delegate inside
/// the worker.
class D4rtHost {
  D4rtHost(this._delegateFactory, {this.debugName = 'd4rt-worker'});

  final D4rtWorkerDelegateFactory _delegateFactory;

  /// The isolate's name, as a debugger shows it.
  final String debugName;

  Future<_Worker>? _workerFuture;
  _CurrentRun? _current;
  Future<void> _queue = Future.value();

  /// How many worker isolates this host has spawned.
  ///
  /// The one externally visible fact about residency, stated as a property
  /// rather than a timing: ten runs served by one worker read 1, and a run
  /// that timed out before the next makes it 2.
  int get workerSpawnCount => _workerSpawnCount;
  int _workerSpawnCount = 0;

  /// How many runs had their source parsed rather than taken from the
  /// worker's cache, summed from each run's own report. A run that never
  /// reached the parse adds nothing.
  int get programParseCount => _programParseCount;
  int _programParseCount = 0;

  /// Runs [request] in the worker.
  ///
  /// [deadline] bounds the run; [cancellation] stops it early. [onMessage]
  /// receives the application's channel messages (see [D4rtMessageHandler]);
  /// [onRequest] answers the run's requests (see [D4rtRequestHandler]) — a
  /// run that asks with no handler set gets a [D4rtHostException] of kind
  /// [D4rtHostException.refusedKind]; [onOutput] receives each line as it
  /// arrives, in the root zone, since what a caller does with a line is not
  /// part of the run.
  ///
  /// Never throws for anything the program did: the outcome says how it
  /// ended. Throws only when the worker cannot be started.
  Future<D4rtRunOutcome> run(
    D4rtRunRequest request, {
    required Duration deadline,
    TomCancellationToken cancellation = TomCancellationToken.none,
    D4rtMessageHandler? onMessage,
    D4rtRequestHandler? onRequest,
    void Function(TomOutputLine line)? onOutput,
  }) async {
    final mine = Completer<void>();
    final earlier = _queue;
    _queue = mine.future;
    await earlier;

    final lines = <TomOutputLine>[];
    try {
      final worker = await _worker();
      final done = Completer<Map<String, Object?>>();
      final current = _CurrentRun(
        request.runId,
        done,
        onMessage,
        onRequest,
        onOutput,
        lines,
        Zone.current,
      );
      _current = current;
      worker.requests.send(request.toMap());

      unawaited(
        cancellation.whenCancelled.then((reason) {
          _fail(
            current,
            D4rtRunStatus.cancelled,
            D4rtRunError(reason, kind: D4rtRunError.cancelledKind),
          );
        }),
      );

      try {
        final outcome = await done.future.timeout(
          deadline,
          onTimeout: () => throw _Abandoned(
            D4rtRunStatus.timedOut,
            D4rtRunError(
              'The run exceeded its ${deadline.inMilliseconds}ms deadline.',
              kind: D4rtRunError.timeoutKind,
            ),
          ),
        );
        final parsed = outcome['parsed'] == true;
        if (parsed) _programParseCount++;
        final status = D4rtRunStatus.values.byName(
          outcome['status']! as String,
        );
        final raw = outcome['error'] as Map?;
        return D4rtRunOutcome(
          status: status,
          value: outcome['value'],
          error: raw == null
              ? null
              : D4rtRunError(
                  raw['message'] as String? ?? 'The run failed.',
                  kind: raw['kind'] as String? ?? 'unknown',
                  frames: [
                    for (final frame in raw['frames'] as List? ?? const [])
                      D4rtFrame.fromMap(frame as Map),
                  ],
                ),
          transcript: TomOutputTranscript(
            lines: List.unmodifiable(lines),
            droppedLines: (outcome['droppedLines'] as int?) ?? 0,
          ),
          parsed: parsed,
        );
      } on _Abandoned catch (abandoned) {
        // Cleared first: a message from a run already given up on must not be
        // handled, and the kill below is awaited.
        _current = null;
        current.runGone.cancel(abandoned.error.message);
        await _discardWorker();
        return D4rtRunOutcome(
          status: abandoned.status,
          error: abandoned.error,
          transcript: TomOutputTranscript(lines: List.unmodifiable(lines)),
          abandonedWorker: true,
        );
      } finally {
        _current = null;
        // A handler still working on an answer is told nobody waits for it.
        if (!current.runGone.isCancelled) {
          current.runGone.cancel('The run ${request.runId} has ended.');
        }
      }
    } finally {
      mine.complete();
    }
  }

  /// Answers one [D4rtWorkerMessage.request] of [run] on [toWorker].
  void _answer(
    _CurrentRun run,
    SendPort toWorker,
    int id,
    String tag,
    Object? data,
  ) {
    void reply(bool ok, Object? payload) {
      // The run is gone: its worker no longer waits, and may be serving the
      // next run already.
      if (!identical(_current, run)) return;
      try {
        toWorker.send([D4rtHostMessage.reply, run.runId, id, ok, payload]);
      } catch (e) {
        toWorker.send([
          D4rtHostMessage.reply,
          run.runId,
          id,
          false,
          {
            'message': 'The answer could not cross the port: $e',
            'kind': D4rtHostException.unsendableKind,
          },
        ]);
      }
    }

    final handler = run.onRequest;
    if (handler == null) {
      reply(false, {
        'message': 'The host has no request handler for "$tag".',
        'kind': D4rtHostException.refusedKind,
      });
      return;
    }
    run.zone.run(() {
      // The reply is the continuation; nothing awaits the chain itself.
      unawaited(
        Future<Object?>.sync(
          () => handler(
            D4rtHostRequest(
              runId: run.runId,
              tag: tag,
              data: data,
              runGone: run.runGone.token,
            ),
          ),
        ).then(
          (value) => reply(true, value),
          onError: (Object e) =>
              reply(false, {'message': '$e', 'kind': e.runtimeType.toString()}),
        ),
      );
    });
  }

  Future<_Worker> _worker() async {
    final existing = _workerFuture;
    if (existing != null) return existing;
    final future = _spawnWorker();
    _workerFuture = future;
    try {
      return await future;
    } catch (_) {
      // A failed spawn must not be cached: the next run would await a future
      // that is already broken.
      if (identical(_workerFuture, future)) _workerFuture = null;
      rethrow;
    }
  }

  Future<_Worker> _spawnWorker() async {
    _workerSpawnCount++;
    final fromWorker = ReceivePort();
    final onError = ReceivePort();
    final onExit = ReceivePort();
    final ready = Completer<SendPort>();
    SendPort? toWorker;

    fromWorker.listen((message) {
      final parts = message as List<Object?>;
      if (parts[0] == D4rtWorkerMessage.ready) {
        toWorker = parts[1]! as SendPort;
        if (!ready.isCompleted) ready.complete(toWorker);
        return;
      }
      final current = _current;
      // The run id is why the tag exists: a message from a run the host has
      // given up on belongs to nobody.
      if (current == null || current.runId != parts[1]) return;
      switch (parts[0]) {
        case D4rtWorkerMessage.channel:
          final handler = current.onMessage;
          if (handler == null) return;
          try {
            current.zone.run(() => handler(parts[2]! as String, parts[3]));
          } catch (e) {
            _fail(
              current,
              D4rtRunStatus.failed,
              D4rtRunError('$e', kind: D4rtRunError.rejectedKind, cause: e),
            );
          }
        case D4rtWorkerMessage.request:
          _answer(
            current,
            toWorker!,
            parts[2]! as int,
            parts[3]! as String,
            parts[4],
          );
        case D4rtWorkerMessage.output:
          final line = TomOutputLine.fromMap(parts[2]! as Map);
          current.lines.add(line);
          // Outside the run's zone, always: a worker is spawned inside the
          // first run that needs one, so this listener would otherwise carry
          // that run's zone into every later caller's callback.
          Zone.root.run(() => current.onOutput?.call(line));
        case D4rtWorkerMessage.done:
          if (!current.done.isCompleted) {
            current.done.complete(Map<String, Object?>.from(parts[2]! as Map));
          }
      }
    });
    onError.listen((message) {
      final parts = message as List<Object?>;
      final current = _current;
      if (current != null) {
        _fail(
          current,
          D4rtRunStatus.failed,
          D4rtRunError('${parts.first}', kind: D4rtRunError.isolateKind),
        );
      }
      if (!ready.isCompleted) ready.completeError(StateError('${parts.first}'));
    });
    onExit.listen((_) {
      // Reached only when the worker died without reporting — a crash, or an
      // `exit()` a program reached. Without this the run would wait for its
      // deadline and be reported as a timeout, which is the wrong diagnosis.
      final current = _current;
      if (current != null) {
        _fail(
          current,
          D4rtRunStatus.failed,
          const D4rtRunError(
            'The worker isolate exited without reporting a result.',
            kind: D4rtRunError.isolateKind,
          ),
        );
      }
      if (!ready.isCompleted) {
        ready.completeError(
          StateError('The worker isolate exited before reporting ready.'),
        );
      }
    });

    final isolate = await Isolate.spawn(
      d4rtWorkerMain,
      [fromWorker.sendPort, _delegateFactory],
      onError: onError.sendPort,
      onExit: onExit.sendPort,
      debugName: debugName,
    );

    try {
      return _Worker(isolate, await ready.future, fromWorker, onError, onExit);
    } catch (_) {
      isolate.kill(priority: Isolate.immediate);
      fromWorker.close();
      onError.close();
      onExit.close();
      rethrow;
    }
  }

  Future<void> _discardWorker() async {
    final future = _workerFuture;
    _workerFuture = null;
    if (future == null) return;
    try {
      (await future).close();
    } catch (_) {
      // A worker that never came up has nothing to close; the failure that
      // stopped it was reported through the run it was spawned for.
    }
  }

  void _fail(_CurrentRun run, D4rtRunStatus status, D4rtRunError error) {
    if (!identical(_current, run)) return;
    if (!run.done.isCompleted) {
      run.done.completeError(_Abandoned(status, error));
    }
  }

  /// Releases the resident worker. Idempotent; [isDisposed] records that it
  /// happened, which is the only way anybody can check that the owner released
  /// what it built — an isolate leak is invisible to a test framework.
  Future<void> dispose() {
    _disposed = true;
    return _discardWorker();
  }

  /// Whether [dispose] has been called.
  bool get isDisposed => _disposed;
  bool _disposed = false;
}

/// A run the host gave up on while the interpreter was still executing, or
/// whose worker died — on its way out of `done`.
class _Abandoned implements Exception {
  _Abandoned(this.status, this.error);
  final D4rtRunStatus status;
  final D4rtRunError error;
}

class _Worker {
  _Worker(
    this.isolate,
    this.requests,
    this._fromWorker,
    this._onError,
    this._onExit,
  );

  final Isolate isolate;
  final SendPort requests;
  final ReceivePort _fromWorker;
  final ReceivePort _onError;
  final ReceivePort _onExit;

  void close() {
    isolate.kill(priority: Isolate.immediate);
    _fromWorker.close();
    _onError.close();
    _onExit.close();
  }
}

class _CurrentRun {
  _CurrentRun(
    this.runId,
    this.done,
    this.onMessage,
    this.onRequest,
    this.onOutput,
    this.lines,
    this.zone,
  );

  final String runId;
  final Completer<Map<String, Object?>> done;
  final D4rtMessageHandler? onMessage;
  final D4rtRequestHandler? onRequest;

  /// Fired when the run is gone; handed to every request handler.
  final TomCancellationSource runGone = TomCancellationSource();
  final void Function(TomOutputLine line)? onOutput;
  final List<TomOutputLine> lines;

  /// The zone [D4rtHost.run] was called in.
  final Zone zone;
}
