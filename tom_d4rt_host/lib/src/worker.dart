/// The far side of the port: a resident worker that serves runs one at a time.
///
/// ## Why it is resident
///
/// The isolate outlives a run and serves many. Spawned per run, it would throw
/// away everything the interpreter had built the moment the run ended — and the
/// *spawn* is not what that costs. Measured on a 6.4 kB script: a bare
/// `Isolate.spawn` + round trip + kill is 0.2–0.6 ms, while a run against a
/// **fresh** interpreter is 7–8.6 ms against 3.5–5 ms for a resident one.
///
/// Residency costs two things, and both are answered here:
///
/// * **One interpreter per bridge set** ([D4rtInterpreterPool]). A registered
///   corpus cannot be withdrawn.
/// * **Per-run state must be repointed per run.** Bridges are registered once,
///   so whatever they read has to be a slot the application's delegate fills
///   in [D4rtWorkerDelegate.begin] and empties in [D4rtWorkerDelegate.end] —
///   a value captured at registration would make every later run read the
///   first run's state.
///
/// What residency cannot survive is a runaway: a script that never yields
/// cannot service a stop message, and the only way to end it is to kill the
/// isolate. The host does that on a timeout, a cancellation, a refused message
/// or a death; the next run spawns a fresh worker.
///
/// ## Async runs
///
/// An entry point may be `async`. The worker runs it with
/// `D4rt.executeProgramAsync` and holds the run — its interpreter checked out,
/// its output captured, its `done` unsent — until the Future settles, so one
/// run at a time still holds. While the script is suspended the worker's event
/// loop is free, which is what lets it receive the host's answers to
/// [D4rtWorkerRun.request].
library;

import 'dart:async';
import 'dart:isolate';

import 'package:tom_basics/utilities.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'interpreter_pool.dart';
import 'output_capture.dart';
import 'program_cache.dart';
import 'run_protocol.dart';

/// A failure the application recognises, with the words and kind it wants
/// reported.
class D4rtWorkerFailure {
  final String message;
  final String kind;

  /// Whether the interpreter's frames belong with it. False for a failure
  /// raised outside any interpreted frame, where the interpreter's last trace
  /// describes an earlier error.
  final bool withFrames;

  const D4rtWorkerFailure(
    this.message, {
    required this.kind,
    this.withFrames = true,
  });
}

/// One run, as the application's delegate sees it inside the worker.
class D4rtWorkerRun {
  D4rtWorkerRun._(this.runRequest, this._send, this._emit, this._request);

  /// The request this run serves.
  final D4rtRunRequest runRequest;
  final void Function(List<Object?> message) _send;
  final D4rtOutputEmitter _emit;
  final Future<Object?> Function(String tag, Object? data) _request;

  String get runId => runRequest.runId;

  /// The application's own part of the request.
  Map<String, Object?> get payload => runRequest.payload;

  /// Sends one message on the application's channel. The host hands it to the
  /// run's message handler, in order, tagged with this run.
  void send(String tag, Object? data) =>
      _send([D4rtWorkerMessage.channel, runRequest.runId, tag, data]);

  /// Asks the host and waits for its answer: the request/reply half of the
  /// application's channel, beside one-way [send].
  ///
  /// The host hands [tag] and [data] to the run's request handler, in the
  /// caller's zone, and sends back what it returns. A bridge that returns this
  /// Future gives the script something to `await`. When the host cannot
  /// answer — no handler, the handler threw, the answer cannot cross the port —
  /// the Future fails with a [D4rtHostException], which the script can catch.
  ///
  /// [data] crosses the port, so it must be sendable; an unsendable value
  /// throws here. Every request must be answered before the run ends: a run
  /// whose entry point returns while one is outstanding is reported failed
  /// ([D4rtRunError.outstandingKind]). Throws [StateError] once the run has
  /// ended.
  Future<Object?> request(String tag, Object? data) => _request(tag, data);

  /// Adds one line to the run's transcript — for the application's own output
  /// sinks; `print`, `stdout` and `stderr` are captured already.
  void emit(TomOutputStream stream, String text) => _emit(stream, text);
}

/// What an application supplies to the worker: its bridges and its per-run
/// state.
///
/// [K] identifies an interpreter by the bridge corpora registered in it.
abstract class D4rtWorkerDelegate<K> {
  /// Prepares [run]: fills whatever the registered bridges read. Called before
  /// the interpreter is obtained; a throw fails the run.
  void begin(D4rtWorkerRun run);

  /// The interpreter [run] must use — the set of corpora it is granted.
  K interpreterKey(D4rtWorkerRun run);

  /// Registers what an interpreter for [key] must have into a fresh one.
  /// Called once per key, for the life of the worker.
  void furnish(D4rt interpreter, K key);

  /// Ends [run], whatever its outcome — so a resident interpreter does not pin
  /// the previous run's state, and a stray access between runs fails loudly.
  void end(D4rtWorkerRun run);

  /// A failure the application recognises, or null for the default report
  /// (the message, and the runtime type as the kind).
  D4rtWorkerFailure? recognise(Object error) => null;
}

/// Makes the application's delegate inside the worker isolate. Must be a
/// top-level or static function, because it crosses `Isolate.spawn`.
typedef D4rtWorkerDelegateFactory = D4rtWorkerDelegate<Object?> Function();

/// The worker isolate's entry point: `[toHost, delegateFactory]`.
///
/// Announces itself with [D4rtWorkerMessage.ready] carrying the port the host
/// posts requests on, then serves them one at a time until the isolate is
/// killed.
void d4rtWorkerMain(List<Object?> payload) {
  final toHost = payload[0]! as SendPort;
  final factory = payload[1]! as D4rtWorkerDelegateFactory;
  final requests = ReceivePort();
  final worker = D4rtWorker(toHost.send, factory());
  toHost.send([D4rtWorkerMessage.ready, requests.sendPort]);
  requests.listen(worker.receive);
}

/// The worker body, with the port abstracted to a callback.
///
/// A class because residency is state: the interpreters and the program
/// cache. Separate from [d4rtWorkerMain] so a test can drive it without an
/// isolate.
class D4rtWorker<K> {
  D4rtWorker(this._send, this._delegate)
    : _pool = D4rtInterpreterPool<K>((interpreter, key) {
        registerD4rtHostBridges(interpreter);
        _delegate.furnish(interpreter, key);
      });

  final void Function(List<Object?> message) _send;
  final D4rtWorkerDelegate<K> _delegate;
  final D4rtInterpreterPool<K> _pool;

  /// The run being served, or null between runs.
  String? _activeRunId;

  /// The current run's requests awaiting the host's answer, by id.
  final Map<int, ({String tag, Completer<Object?> answer})> _pending = {};
  int _nextRequestId = 0;

  /// Runs are served one after another even if two arrive together.
  Future<void> _serving = Future.value();

  /// Handles one message from the host: a run request (a
  /// `D4rtRunRequest.toMap()` map), queued behind the run in flight, or a
  /// [D4rtHostMessage.reply], delivered at once — the run awaiting it is
  /// suspended, so it cannot wait in the queue.
  void receive(Object? message) {
    if (message is Map) {
      final request = D4rtRunRequest.fromMap(message);
      _serving = _serving.then((_) => serve(request));
      return;
    }
    final parts = message! as List<Object?>;
    if (parts[0] == D4rtHostMessage.reply) _reply(parts);
  }

  void _reply(List<Object?> parts) {
    // A reply for a run that has ended, or for an id it no longer owes, is
    // dropped: nothing awaits it.
    if (parts[1] != _activeRunId) return;
    final pending = _pending.remove(parts[2]! as int);
    if (pending == null) return;
    if (parts[3] == true) {
      pending.answer.complete(parts[4]);
      return;
    }
    final error = parts[4]! as Map;
    pending.answer.completeError(
      D4rtHostException(
        error['message'] as String? ?? 'The host could not answer.',
        kind: error['kind'] as String? ?? 'unknown',
        tag: pending.tag,
      ),
    );
  }

  Future<Object?> _request(String runId, String tag, Object? data) {
    if (runId != _activeRunId) {
      throw StateError(
        'Run $runId has ended; its request "$tag" cannot be sent.',
      );
    }
    final id = _nextRequestId++;
    final answer = Completer<Object?>();
    _pending[id] = (tag: tag, answer: answer);
    try {
      _send([D4rtWorkerMessage.request, runId, id, tag, data]);
    } catch (_) {
      _pending.remove(id);
      rethrow;
    }
    return answer.future;
  }

  /// The parsed programs this worker keeps.
  final D4rtProgramCache programs = D4rtProgramCache();

  /// How many interpreters the worker has furnished.
  int get interpreterCount => _pool.length;

  /// Runs one request and reports its outcome. Never throws: a program's
  /// failure is a value, and a throw here would kill the worker and its
  /// residency with it.
  ///
  /// Completes when the run's `done` has been sent — for an `async` entry
  /// point, after its Future settled. Serve one run at a time: [receive]
  /// queues them.
  Future<void> serve(D4rtRunRequest request) async {
    Object? value;
    Map<String, Object?>? error;
    var status = D4rtRunStatus.ok;
    var parsed = false;
    D4rt? interpreter;
    K? key;

    // Bounded **here** rather than at the host: a runaway loop that prints
    // would flood the port long before the host could drop anything.
    final recorder = TomOutputRecorder();
    void emit(TomOutputStream stream, String text) {
      final line = recorder.add(stream, text);
      if (line == null) return;
      _send([D4rtWorkerMessage.output, request.runId, line.toMap()]);
    }

    _activeRunId = request.runId;
    _pending.clear();
    final run = D4rtWorkerRun._(
      request,
      _send,
      emit,
      (tag, data) => _request(request.runId, tag, data),
    );
    try {
      _delegate.begin(run);
      key = _delegate.interpreterKey(run);
      final furnished = _pool.obtain(key as K);
      interpreter = furnished;
      final (program, didParse) = programs.obtain(
        furnished,
        sourceHash: request.sourceHash,
        source: request.source,
        capacity: request.programCacheCapacity,
      );
      parsed = didParse;
      value = d4rtSendable(
        await d4rtRunCapturing(
          () => furnished.executeProgramAsync(
            program,
            name: request.entryPoint,
            positionalArgs: request.arguments,
          ),
          emit,
        ),
      );
      if (_pending.isNotEmpty) {
        status = D4rtRunStatus.failed;
        value = null;
        error = {
          'message':
              'The run ended with ${_pending.length} request(s) unanswered: '
              '${[for (final p in _pending.values) p.tag].join(', ')}. '
              'Await every request before the entry point returns.',
          'kind': D4rtRunError.outstandingKind,
        };
      }
    } on SourceCodeD4rtException catch (e) {
      status = D4rtRunStatus.failed;
      error = {'message': e.toString(), 'kind': D4rtRunError.parseKind};
    } catch (e) {
      status = D4rtRunStatus.failed;
      final recognised = _delegate.recognise(e);
      final frames = recognised == null || recognised.withFrames
          ? _frames(interpreter)
          : null;
      error = {
        'message': recognised?.message ?? e.toString(),
        'kind': recognised?.kind ?? e.runtimeType.toString(),
        'frames': ?frames,
      };
    } finally {
      // Whatever is still pending belongs to a run that is over: its answers
      // are dropped when they arrive, and the Futures are never completed — a
      // failed one nobody listens to would surface in the NEXT run.
      _activeRunId = null;
      _pending.clear();
      _delegate.end(run);
      if (key != null) _pool.release(key as K);
    }

    _send([
      D4rtWorkerMessage.done,
      request.runId,
      {
        'status': status.name,
        'value': value,
        'error': ?error,
        'droppedLines': recorder.droppedLines,
        'parsed': parsed,
      },
    ]);
  }
}

/// The library a script imports to name [D4rtHostException], for example in
/// `on D4rtHostException catch (e)`.
const d4rtHostLibrary = 'package:tom_d4rt_host/tom_d4rt_host.dart';

/// Registers what every worker interpreter has from this package, before the
/// application's delegate furnishes it: [D4rtHostException] in
/// [d4rtHostLibrary], with its `message`, `kind` and `tag`.
void registerD4rtHostBridges(D4rt interpreter) {
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: D4rtHostException,
      name: 'D4rtHostException',
      getters: {
        'message': (visitor, target) => (target as D4rtHostException).message,
        'kind': (visitor, target) => (target as D4rtHostException).kind,
        'tag': (visitor, target) => (target as D4rtHostException).tag,
      },
      methods: {
        'toString': (visitor, target, positional, named, _) =>
            (target as D4rtHostException).toString(),
      },
    ),
    d4rtHostLibrary,
  );
}

/// [value] made sendable across a port: primitives and collections of them
/// pass through, anything else — an interpreted instance, a bridged handle, a
/// closure — is its `toString()`, which is what a caller on the far side can
/// use.
Object? d4rtSendable(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return value;
  }
  if (value is List) return [for (final entry in value) d4rtSendable(entry)];
  if (value is Map) {
    return {
      for (final entry in value.entries)
        entry.key.toString(): d4rtSendable(entry.value),
    };
  }
  return value.toString();
}

/// The frames of the error that just left [interpreter], innermost first, as
/// port-ready maps — or null when it reported none.
///
/// Only frames in the **main program** (an unnamed source) are positions in
/// the program the caller ran; a frame in an imported library is a line in
/// somebody else's file.
List<Map<String, Object?>>? _frames(D4rt? interpreter) {
  if (interpreter == null) return null;
  final frames = [
    for (final frame in interpreter.lastErrorTrace)
      if (frame.source == null)
        D4rtFrame(
          line: frame.line,
          column: frame.column,
          member: frame.member,
        ).toMap(),
  ];
  return frames.isEmpty ? null : frames;
}
