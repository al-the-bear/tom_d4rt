/// A small application delegate for the suites: one gated corpus, a per-run
/// slot the bridges read, a channel, a request bridge (`ask`), and a failure it
/// recognises.
library;

import 'dart:isolate';

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

/// The library only the `greet` interpreter has.
const greetLibrary = 'package:fixture/greet.dart';

/// The library every interpreter has: the per-run slot and the channel.
const runLibrary = 'package:fixture/run.dart';

/// The delegate the worker isolate builds.
D4rtWorkerDelegate<Object?> fixtureDelegate() => FixtureDelegate();

class FixtureDelegate extends D4rtWorkerDelegate<Object?> {
  /// The run in flight — what the registered getters read.
  D4rtWorkerRun? current;

  /// Which interpreters were furnished, in order.
  final List<Object?> furnished = [];

  /// How many runs were ended.
  int ended = 0;

  @override
  void begin(D4rtWorkerRun run) {
    if (run.payload['failBegin'] == true) {
      throw StateError('the run could not be prepared');
    }
    current = run;
  }

  @override
  Object? interpreterKey(D4rtWorkerRun run) =>
      run.payload['corpus'] as String? ?? 'none';

  @override
  void furnish(D4rt interpreter, Object? key) {
    furnished.add(key);
    interpreter
      ..grant(FilesystemPermission.any)
      ..grant(ProcessRunPermission.any)
      ..grant(DangerousPermission.any)
      ..registerGlobalGetter(
        'runTag',
        () => current!.payload['tag'],
        runLibrary,
      )
      ..registertopLevelFunction('post', (visitor, args, named, types) {
        current!.send(args[0]! as String, args[1]);
        return null;
      }, runLibrary)
      // The async bridge the request channel exists for: its Future is the
      // host's answer, and the script awaits it.
      ..registertopLevelFunction(
        'ask',
        (visitor, args, named, types) => current!.request(
          args[0]! as String,
          args.length > 1 ? args[1] : null,
        ),
        runLibrary,
      )
      ..registertopLevelFunction('note', (visitor, args, named, types) {
        current!.emit(TomOutputStream.stderr, args[0]! as String);
        return null;
      }, runLibrary)
      ..registertopLevelFunction('die', (visitor, args, named, types) {
        Isolate.current.kill(priority: Isolate.immediate);
        return null;
      }, runLibrary)
      ..registertopLevelFunction(
        'overrun',
        (visitor, args, named, types) => throw const FixtureBudgetException(),
        runLibrary,
      );
    if (key == 'greet') {
      interpreter.registerGlobalVariable('greeting', 'hello', greetLibrary);
    }
  }

  @override
  void end(D4rtWorkerRun run) {
    ended++;
    current = null;
  }

  @override
  D4rtWorkerFailure? recognise(Object error) {
    const marker = 'FixtureBudgetException';
    final message = error.toString();
    final at = message.indexOf(marker);
    if (at < 0) return null;
    return D4rtWorkerFailure(message.substring(at), kind: 'budget');
  }
}

class FixtureBudgetException implements Exception {
  const FixtureBudgetException();

  @override
  String toString() => 'FixtureBudgetException: the run wrote too much';
}

/// A request for [source], tagged and hashed the way an application would.
D4rtRunRequest fixtureRequest(
  String source, {
  String? runId,
  String corpus = 'none',
  Object? tag,
  bool failBegin = false,
  int capacity = 32,
}) => D4rtRunRequest(
  runId: runId ?? 'run-${source.hashCode}-${tag ?? ''}',
  source: source,
  sourceHash: 'h${source.hashCode}',
  programCacheCapacity: capacity,
  payload: {'corpus': corpus, 'tag': tag, 'failBegin': failBegin},
);
