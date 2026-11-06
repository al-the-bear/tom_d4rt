/// The host over a real worker isolate: residency, the endings that kill the
/// worker and the one that keeps it, the channel, live output, the queue,
/// async runs and the request channel.
///
/// Each test spawns an isolate; the bound is for one that hangs.
@Timeout(Duration(seconds: 120))
library;

import 'dart:async';
import 'dart:isolate';

import 'package:test/test.dart';
import 'package:tom_basics/utilities.dart' show TomCancellationSource;
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

import 'support/fixture_delegate.dart';

const deadline = Duration(seconds: 30);

D4rtHost newHost() {
  final host = D4rtHost(fixtureDelegate, debugName: 'host-test');
  addTearDown(host.dispose);
  return host;
}

void main() {
  group('HOST-H1 residency', () {
    test('HOST-H1-1: ten runs are served by one worker, and one unmodified '
        'source is parsed once', () async {
      final host = newHost();
      for (var i = 0; i < 10; i++) {
        final outcome = await host.run(
          fixtureRequest('int main() => 7;', runId: 'r$i'),
          deadline: deadline,
        );
        expect(outcome.value, 7);
      }
      expect(host.workerSpawnCount, 1);
      expect(host.programParseCount, 1);
    });

    test('HOST-H1-2: a program that fails keeps the worker', () async {
      final host = newHost();
      final failed = await host.run(
        fixtureRequest('int main() => throw StateError("typo");'),
        deadline: deadline,
      );
      expect(failed.status, D4rtRunStatus.failed);
      expect(failed.abandonedWorker, isFalse);
      final next = await host.run(
        fixtureRequest('int main() => 1;'),
        deadline: deadline,
      );
      expect(next.isOk, isTrue);
      expect(host.workerSpawnCount, 1);
    });
  });

  group('HOST-H2 the endings that kill the worker', () {
    const spins = 'void main() { while (true) {} }';

    test('HOST-H2-1: a run past its deadline is timed out, its worker killed, '
        'and the next run spawns a fresh one', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest(spins),
        deadline: const Duration(milliseconds: 500),
      );
      expect(outcome.status, D4rtRunStatus.timedOut);
      expect(outcome.error!.kind, D4rtRunError.timeoutKind);
      expect(outcome.abandonedWorker, isTrue);
      final next = await host.run(
        fixtureRequest('int main() => 2;'),
        deadline: deadline,
      );
      expect(next.value, 2);
      expect(host.workerSpawnCount, 2);
    });

    test(
      'HOST-H2-2: a cancellation stops a runaway and states its reason',
      () async {
        final host = newHost();
        final source = TomCancellationSource();
        Timer(const Duration(milliseconds: 300), () => source.cancel('stop'));
        final outcome = await host.run(
          fixtureRequest(spins),
          deadline: deadline,
          cancellation: source.token,
        );
        expect(outcome.status, D4rtRunStatus.cancelled);
        expect(outcome.error!.message, 'stop');
        expect(outcome.abandonedWorker, isTrue);
      },
    );

    test('HOST-H2-3: a channel message the application refuses fails the run '
        'with its cause and kills the worker', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
void main() {
  post('write', 1);
  while (true) {}
}
'''),
        deadline: deadline,
        onMessage: (tag, data) => throw ArgumentError('not this one'),
      );
      expect(outcome.status, D4rtRunStatus.failed);
      expect(outcome.error!.kind, D4rtRunError.rejectedKind);
      expect(outcome.error!.cause, isA<ArgumentError>());
      expect(outcome.abandonedWorker, isTrue);
      expect(host.workerSpawnCount, 1);
      await host.run(fixtureRequest('int main() => 1;'), deadline: deadline);
      expect(host.workerSpawnCount, 2);
    });

    test('HOST-H2-4: a worker that exits without reporting fails the run as '
        'an isolate failure, not a timeout', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
void main() => die();
'''),
        deadline: deadline,
      );
      expect(outcome.status, D4rtRunStatus.failed);
      expect(outcome.error!.kind, D4rtRunError.isolateKind);
      expect(outcome.abandonedWorker, isTrue);
    });
  });

  group('HOST-H3 the channel and the output', () {
    test('HOST-H3-1: channel messages arrive in order, in the caller\'s zone; '
        'output arrives live, in the root zone', () async {
      final host = newHost();
      final received = <Object?>[];
      final zones = <Object?>[];
      final outputZones = <Object?>[];
      final live = <String>[];
      await runZoned(
        () => host.run(
          fixtureRequest('''
import 'package:fixture/run.dart';
void main() {
  post('write', 1);
  print('between');
  post('write', 2);
}
'''),
          deadline: deadline,
          onMessage: (tag, data) {
            received.add('$tag:$data');
            zones.add(Zone.current[#caller]);
          },
          onOutput: (line) {
            live.add(line.text);
            outputZones.add(Zone.current[#caller]);
          },
        ),
        zoneValues: {#caller: 'mine'},
      );
      expect(received, ['write:1', 'write:2']);
      expect(zones, ['mine', 'mine']);
      expect(live, ['between']);
      expect(outputZones, [null]);
    });

    test('HOST-H3-2: the outcome carries what the run printed, a failed run '
        'included', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
void main() {
  print('before');
  throw StateError('after');
}
'''),
        deadline: deadline,
      );
      expect(outcome.status, D4rtRunStatus.failed);
      expect([for (final l in outcome.transcript.lines) l.text], ['before']);
    });
  });

  group('HOST-H4 the queue and the lifecycle', () {
    test('HOST-H4-1: runs started together are served one at a time, in '
        'order', () async {
      final host = newHost();
      final outcomes = await Future.wait([
        for (var i = 0; i < 4; i++)
          host.run(fixtureRequest('int main() => $i;'), deadline: deadline),
      ]);
      expect([for (final o in outcomes) o.value], [0, 1, 2, 3]);
      expect(host.workerSpawnCount, 1);
    });

    test('HOST-H4-2: dispose is idempotent and recorded', () async {
      final host = D4rtHost(fixtureDelegate);
      await host.run(fixtureRequest('int main() => 1;'), deadline: deadline);
      expect(host.isDisposed, isFalse);
      await host.dispose();
      await host.dispose();
      expect(host.isDisposed, isTrue);
    });
  });

  group('HOST-H5 async runs', () {
    test(
      'HOST-H5-1: an async main is served to completion, and what it prints '
      'after an await arrives live and in the transcript [2026-11-06]',
      () async {
        final host = newHost();
        final live = <String>[];
        final outcome = await host.run(
          fixtureRequest('''
Future<int> main() async {
  print('before');
  await Future.delayed(Duration(milliseconds: 20));
  print('after');
  return 7;
}
'''),
          deadline: deadline,
          onOutput: (line) => live.add(line.text),
        );
        expect(outcome.status, D4rtRunStatus.ok);
        expect(outcome.value, 7);
        expect(live, ['before', 'after']);
        expect([for (final l in outcome.transcript.lines) l.text], live);
      },
    );

    test('HOST-H5-2: an async error fails the run with its type and keeps the '
        'worker [2026-11-06]', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
Future<void> main() async {
  await Future.delayed(Duration(milliseconds: 5));
  throw StateError('later');
}
'''),
        deadline: deadline,
      );
      expect(outcome.status, D4rtRunStatus.failed);
      expect(outcome.error!.kind, 'StateError');
      expect(outcome.error!.frames, isNotEmpty);
      expect(outcome.abandonedWorker, isFalse);
    });

    test('HOST-H5-3: the deadline bounds a Future that never completes '
        '[2026-11-06]', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
Future<void> main() async {
  await Future.delayed(Duration(days: 1));
}
'''),
        deadline: const Duration(milliseconds: 500),
      );
      expect(outcome.status, D4rtRunStatus.timedOut);
      expect(outcome.abandonedWorker, isTrue);
      final next = await host.run(
        fixtureRequest('int main() => 3;'),
        deadline: deadline,
      );
      expect(next.value, 3);
    });
  });

  group('HOST-H6 the request channel', () {
    const asksTwice = '''
import 'package:fixture/run.dart';
Future<List<Object?>> main() async {
  final first = await ask('sync', 1);
  final second = await ask('async', 2);
  return [first, second];
}
''';

    test(
      'HOST-H6-1: the handler answers in the caller\'s zone, synchronously '
      'or with a Future, and the script awaits each answer [2026-11-06]',
      () async {
        final host = newHost();
        final zones = <Object?>[];
        final outcome = await runZoned(
          () => host.run(
            fixtureRequest(asksTwice),
            deadline: deadline,
            onRequest: (request) {
              zones.add(Zone.current[#caller]);
              final n = request.data! as int;
              if (request.tag == 'sync') return n * 10;
              return Future.delayed(
                const Duration(milliseconds: 10),
                () => {'n': n * 10},
              );
            },
          ),
          zoneValues: {#caller: 'mine'},
        );
        expect(outcome.status, D4rtRunStatus.ok);
        expect(outcome.value, [
          10,
          {'n': 20},
        ]);
        expect(zones, ['mine', 'mine']);
      },
    );

    test('HOST-H6-2: requests answered out of order reach the call that asked '
        '[2026-11-06]', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
Future<List<Object?>> main() async =>
    await Future.wait([ask('slow', 60), ask('mid', 30), ask('fast', 1)]);
'''),
        deadline: deadline,
        onRequest: (request) => Future.delayed(
          Duration(milliseconds: request.data! as int),
          () => request.tag,
        ),
      );
      expect(outcome.value, ['slow', 'mid', 'fast']);
    });

    test('HOST-H6-3: a throwing handler fails the awaiting call with a host '
        'exception the script catches; the run goes on and the worker is kept '
        '[2026-11-06]', () async {
      final host = newHost();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';
Future<String> main() async {
  try {
    await ask('load', 7);
    return 'not reached';
  } on D4rtHostException catch (e) {
    return '\${e.tag}/\${e.kind}/\${e.message}';
  }
}
'''),
        deadline: deadline,
        onRequest: (request) => throw StateError('row 7 is gone'),
      );
      expect(outcome.status, D4rtRunStatus.ok);
      expect(outcome.value, 'load/StateError/Bad state: row 7 is gone');
      expect(outcome.abandonedWorker, isFalse);
    });

    test('HOST-H6-4: a request with no handler is refused, and an answer that '
        'cannot cross the port is reported as such [2026-11-06]', () async {
      final host = newHost();
      const catches = '''
import 'package:fixture/run.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';
Future<String> main() async {
  try {
    await ask('load');
    return 'not reached';
  } on D4rtHostException catch (e) {
    return e.kind;
  }
}
''';
      final refused = await host.run(
        fixtureRequest(catches, runId: 'refused'),
        deadline: deadline,
      );
      expect(refused.value, D4rtHostException.refusedKind);

      final port = ReceivePort();
      addTearDown(port.close);
      final unsendable = await host.run(
        fixtureRequest(catches, runId: 'unsendable'),
        deadline: deadline,
        onRequest: (request) => port,
      );
      expect(unsendable.value, D4rtHostException.unsendableKind);
    });

    test('HOST-H6-5: a run that ends with a request unanswered is failed, and '
        'its handler is told the run is gone [2026-11-06]', () async {
      final host = newHost();
      final gone = Completer<String>();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
int main() {
  ask('never-awaited');
  return 1;
}
'''),
        deadline: deadline,
        onRequest: (request) {
          unawaited(request.runGone.whenCancelled.then(gone.complete));
          return Completer<Object?>().future; // never answers
        },
      );
      expect(outcome.status, D4rtRunStatus.failed);
      expect(outcome.error!.kind, D4rtRunError.outstandingKind);
      expect(outcome.abandonedWorker, isFalse);
      expect(await gone.future, contains('has ended'));
    });

    test('HOST-H6-6: the deadline still kills a run awaiting an answer, and '
        'the handler in flight is told why [2026-11-06]', () async {
      final host = newHost();
      final gone = Completer<String>();
      final outcome = await host.run(
        fixtureRequest('''
import 'package:fixture/run.dart';
Future<Object?> main() async => await ask('slow');
'''),
        deadline: const Duration(milliseconds: 500),
        onRequest: (request) {
          unawaited(request.runGone.whenCancelled.then(gone.complete));
          return Future.delayed(const Duration(seconds: 2), () => 'late');
        },
      );
      expect(outcome.status, D4rtRunStatus.timedOut);
      expect(outcome.abandonedWorker, isTrue);
      expect(await gone.future, contains('deadline'));
      final next = await host.run(
        fixtureRequest('int main() => 4;'),
        deadline: deadline,
      );
      expect(next.value, 4);
    });
  });
}
