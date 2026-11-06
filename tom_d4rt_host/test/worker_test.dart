/// The worker body, driven without an isolate: the program cache, the
/// interpreter pool, per-run state, output capture, the error report, the
/// application's channel, async runs and the request channel.
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart' show D4rt;
import 'package:tom_d4rt_host/tom_d4rt_host.dart';

import 'support/fixture_delegate.dart';

/// A worker over [FixtureDelegate] and the messages it sent, oldest first.
(D4rtWorker<Object?>, FixtureDelegate, List<List<Object?>>) worker() {
  final sent = <List<Object?>>[];
  final delegate = FixtureDelegate();
  return (D4rtWorker<Object?>(sent.add, delegate), delegate, sent);
}

/// A worker whose requests are answered by [answer] — `(ok, payload)` — as the
/// host would answer them, a turn of the event loop later; or left unanswered
/// when [answer] returns null.
(D4rtWorker<Object?>, List<List<Object?>>) answeringWorker(
  (bool, Object?)? Function(String tag, Object? data) answer,
) {
  final sent = <List<Object?>>[];
  late final D4rtWorker<Object?> w;
  w = D4rtWorker<Object?>((message) {
    sent.add(message);
    if (message[0] != D4rtWorkerMessage.request) return;
    final reply = answer(message[3]! as String, message[4]);
    if (reply == null) return;
    Timer.run(
      () => w.receive([
        D4rtHostMessage.reply,
        message[1],
        message[2],
        reply.$1,
        reply.$2,
      ]),
    );
  }, FixtureDelegate());
  return (w, sent);
}

List<Map<Object?, Object?>> dones(List<List<Object?>> sent) => [
  for (final m in sent)
    if (m[0] == D4rtWorkerMessage.done) m[2]! as Map<Object?, Object?>,
];

void main() {
  group('HOST-W1 the program cache', () {
    test('HOST-W1-1: the second run of one source does not parse', () async {
      final (w, _, sent) = worker();
      const source = 'int main() => 41 + 1;';
      await w.serve(fixtureRequest(source));
      await w.serve(fixtureRequest(source));
      expect(w.programs.parseCount, 1);
      expect([for (final d in dones(sent)) d['value']], [42, 42]);
      expect([for (final d in dones(sent)) d['parsed']], [true, false]);
    });

    test('HOST-W1-2: an edit invalidates exactly the edited source', () async {
      final (w, _, _) = worker();
      for (final n in [1, 2, 1, 2]) {
        await w.serve(fixtureRequest('int main() => $n;'));
      }
      expect(w.programs.parseCount, 2);
    });

    test('HOST-W1-3: bounded and least-recently-used; a smaller capacity '
        'evicts at once', () async {
      final (w, _, _) = worker();
      Future<void> runIt(int n, {int capacity = 2}) =>
          w.serve(fixtureRequest('int main() => $n;', capacity: capacity));
      await runIt(1);
      await runIt(2);
      await runIt(1);
      await runIt(3); // evicts 2
      expect(w.programs.length, 2);
      await runIt(1);
      expect(w.programs.parseCount, 3, reason: '1 was used after 2');
      await runIt(2);
      expect(w.programs.parseCount, 4, reason: '2 was evicted');
      for (var n = 10; n < 15; n++) {
        await runIt(n, capacity: 32);
      }
      await runIt(99, capacity: 1);
      expect(w.programs.length, 1);
    });

    test('HOST-W1-4: a source that does not parse is not cached and is '
        'reported as a parse failure', () async {
      final (w, _, sent) = worker();
      const broken = 'int main() { var a = ; }';
      await w.serve(fixtureRequest(broken));
      await w.serve(fixtureRequest(broken));
      expect(w.programs.parseCount, 2);
      expect(w.programs.length, 0);
      expect(
        [for (final d in dones(sent)) (d['error']! as Map)['kind']],
        [D4rtRunError.parseKind, D4rtRunError.parseKind],
      );
    });

    test('HOST-W1-5: two runs of one cached program share no state', () async {
      final (w, _, sent) = worker();
      const source = '''
var counter = 0;
int main() {
  counter = counter + 1;
  return counter;
}
''';
      await w.serve(fixtureRequest(source));
      await w.serve(fixtureRequest(source));
      expect([for (final d in dones(sent)) d['value']], [1, 1]);
    });
  });

  group('HOST-W2 one interpreter per bridge set', () {
    const greets = '''
import 'package:fixture/greet.dart';
String main() => greeting;
''';

    test('HOST-W2-1: a corpus is reachable only from the interpreter it was '
        'registered in, even after another run registered it', () async {
      final (w, delegate, sent) = worker();
      await w.serve(fixtureRequest(greets, corpus: 'greet'));
      await w.serve(fixtureRequest(greets, corpus: 'none', tag: 'second'));
      final results = dones(sent);
      expect(results[0]['value'], 'hello');
      expect(
        results[1]['status'],
        'failed',
        reason: 'the none interpreter never had the greet corpus',
      );
      expect(delegate.furnished, ['greet', 'none']);
    });

    test(
      'HOST-W2-2: each key is furnished once, however many runs use it',
      () async {
        final (w, delegate, _) = worker();
        for (var i = 0; i < 4; i++) {
          await w.serve(fixtureRequest('int main() => $i;', corpus: 'greet'));
        }
        expect(delegate.furnished, ['greet']);
        expect(w.interpreterCount, 1);
      },
    );
  });

  group('HOST-W3 per-run state', () {
    const readsTag = '''
import 'package:fixture/run.dart';
Object? main() => runTag;
''';

    test(
      'HOST-W3-1: a bridge registered once reads each run\'s own state',
      () async {
        final (w, _, sent) = worker();
        await w.serve(fixtureRequest(readsTag, tag: 'first'));
        await w.serve(fixtureRequest(readsTag, tag: 'second'));
        expect([for (final d in dones(sent)) d['value']], ['first', 'second']);
      },
    );

    test('HOST-W3-2: the run is ended whatever its outcome, so nothing reads '
        'a finished run', () async {
      final (w, delegate, sent) = worker();
      await w.serve(fixtureRequest('int main() => throw StateError("x");'));
      await w.serve(fixtureRequest('int main() => 1;', failBegin: true));
      expect(delegate.ended, 2);
      expect(delegate.current, isNull);
      final second = dones(sent)[1];
      expect(second['status'], 'failed');
      expect((second['error']! as Map)['kind'], 'StateError');
      expect(
        (second['error']! as Map).containsKey('frames'),
        isFalse,
        reason: 'a run that failed before the interpreter has no frames',
      );
    });
  });

  group('HOST-W4 output capture', () {
    test('HOST-W4-1: print, stdout, stderr and the application\'s own sink '
        'arrive as one transcript in the order they happened', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
import 'dart:io';
import 'package:fixture/run.dart';
void main() {
  print('one');
  stderr.writeln('two');
  note('three');
  stdout.write('four');
}
'''),
      );
      final lines = [
        for (final m in sent)
          if (m[0] == D4rtWorkerMessage.output)
            TomOutputLine.fromMap(m[2]! as Map),
      ];
      expect([for (final l in lines) l.text], ['one', 'two', 'three', 'four']);
      expect(
        [for (final l in lines) l.stream],
        [
          TomOutputStream.stdout,
          TomOutputStream.stderr,
          TomOutputStream.stderr,
          TomOutputStream.stdout,
        ],
      );
      expect(dones(sent).single['droppedLines'], 0);
    });

    test('HOST-W4-2: a runaway that prints is bounded in the worker, and the '
        'drop is counted, not silent', () async {
      final (w, _, sent) = worker();
      final extra = 5;
      await w.serve(
        fixtureRequest('''
void main() {
  for (var i = 0; i < ${TomOutputTranscript.maxLines + extra}; i++) {
    print('line \$i');
  }
}
'''),
      );
      final outputs = sent.where((m) => m[0] == D4rtWorkerMessage.output);
      expect(outputs.length, TomOutputTranscript.maxLines);
      expect(dones(sent).single['droppedLines'], extra);
    });
  });

  group('HOST-W5 the error report', () {
    test('HOST-W5-1: a thrown error names its type and the frames in the '
        'program that was run', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
void inner() {
  throw ArgumentError('bad');
}
void main() {
  inner();
}
'''),
      );
      final error = dones(sent).single['error']! as Map;
      expect(error['message'], contains('bad'));
      final frames = [
        for (final f in error['frames']! as List) D4rtFrame.fromMap(f as Map),
      ];
      expect(frames, isNotEmpty);
      expect(frames.first.line, 2);
      expect(frames.first.member, 'inner');
    });

    test('HOST-W5-2: a failure the application recognises is reported in its '
        'words and kind; one it does not is the default', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
void main() => overrun();
'''),
      );
      final error = dones(sent).single['error']! as Map;
      expect(error['kind'], 'budget');
      expect(error['message'], startsWith('FixtureBudgetException'));
    });
  });

  group('HOST-W6 the channel and the value', () {
    test('HOST-W6-1: a channel message is tagged with its run and sent before '
        'done', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
void main() {
  post('write', {'n': 1});
  post('write', {'n': 2});
}
''', runId: 'r1'),
      );
      final channel = [
        for (final m in sent)
          if (m[0] == D4rtWorkerMessage.channel) m,
      ];
      expect(channel, [
        [
          D4rtWorkerMessage.channel,
          'r1',
          'write',
          {'n': 1},
        ],
        [
          D4rtWorkerMessage.channel,
          'r1',
          'write',
          {'n': 2},
        ],
      ]);
      expect(sent.last[0], D4rtWorkerMessage.done);
    });

    test('HOST-W6-2: a returned value is made sendable', () async {
      expect(d4rtSendable([1, 'a', true, null]), [1, 'a', true, null]);
      expect(d4rtSendable({1: Uri.parse('x:y')}), {'1': 'x:y'});
      expect(d4rtSendable(Duration.zero), Duration.zero.toString());
    });
  });

  group('HOST-W7 async runs', () {
    test('HOST-W7-1: an async main is reported with its settled value, after '
        'it settles [2026-11-06]', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
Future<int> main() async {
  await Future.delayed(Duration(milliseconds: 10));
  return 42;
}
'''),
      );
      final done = dones(sent).single;
      expect(done['status'], 'ok');
      expect(done['value'], 42);
    });

    test('HOST-W7-2: what an async main prints after an await is in the run\'s '
        'transcript, before done [2026-11-06]', () async {
      final (w, _, sent) = worker();
      await w.serve(
        fixtureRequest('''
import 'dart:io';
Future<void> main() async {
  print('before');
  await Future.delayed(Duration(milliseconds: 10));
  print('after');
  stderr.writeln('late');
}
'''),
      );
      final kinds = [for (final m in sent) m[0]];
      expect(kinds.last, D4rtWorkerMessage.done);
      expect(
        [
          for (final m in sent)
            if (m[0] == D4rtWorkerMessage.output)
              TomOutputLine.fromMap(m[2]! as Map).text,
        ],
        ['before', 'after', 'late'],
      );
    });

    test('HOST-W7-3: an async error is reported like a sync one: failed, its '
        'type, its frames [2026-11-06]', () async {
      final (w, delegate, sent) = worker();
      await w.serve(
        fixtureRequest('''
Future<void> inner() async {
  await Future.delayed(Duration(milliseconds: 5));
  throw StateError('late failure');
}
Future<void> main() async {
  await inner();
}
'''),
      );
      final done = dones(sent).single;
      expect(done['status'], 'failed');
      final error = done['error']! as Map;
      expect(error['kind'], 'StateError');
      expect(error['message'], contains('late failure'));
      expect(error['frames'], isNotEmpty);
      expect(delegate.ended, 1, reason: 'the run is ended after it settles');
    });

    test('HOST-W7-4: runs received together are served one at a time, an '
        'async one holding the worker until it settles [2026-11-06]', () async {
      final (w, _, sent) = worker();
      w.receive(
        fixtureRequest('''
Future<String> main() async {
  await Future.delayed(Duration(milliseconds: 30));
  return 'slow';
}
''', runId: 'a').toMap(),
      );
      w.receive(fixtureRequest("String main() => 'fast';", runId: 'b').toMap());
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect([for (final d in dones(sent)) d['value']], ['slow', 'fast']);
      expect(
        [
          for (final m in sent)
            if (m[0] == D4rtWorkerMessage.done) m[1],
        ],
        ['a', 'b'],
      );
    });
  });

  group('HOST-W8 the request channel', () {
    test('HOST-W8-1: a request is sent tagged with its run and an id, and the '
        'answer is what the script awaits [2026-11-06]', () async {
      final (w, sent) = answeringWorker(
        (tag, data) => (true, {'tag': tag, 'twice': (data! as int) * 2}),
      );
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
Future<Object?> main() async {
  final answer = await ask('double', 21);
  return answer['twice'];
}
''', runId: 'r1'),
      );
      final requests = [
        for (final m in sent)
          if (m[0] == D4rtWorkerMessage.request) m,
      ];
      expect(requests, [
        [D4rtWorkerMessage.request, 'r1', 0, 'double', 21],
      ]);
      expect(dones(sent).single['value'], 42);
    });

    test('HOST-W8-2: requests in flight together are matched to their answers '
        'by id [2026-11-06]', () async {
      final (w, sent) = answeringWorker((tag, data) => (true, '$tag!'));
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
Future<List<Object?>> main() async =>
    await Future.wait([ask('a'), ask('b'), ask('c')]);
'''),
      );
      expect(dones(sent).single['value'], ['a!', 'b!', 'c!']);
    });

    test('HOST-W8-3: an answer the host could not give is a D4rtHostException '
        'the script catches by name [2026-11-06]', () async {
      final (w, sent) = answeringWorker(
        (tag, data) =>
            (false, {'message': 'no such row', 'kind': 'StateError'}),
      );
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
import 'package:tom_d4rt_host/tom_d4rt_host.dart';
Future<String> main() async {
  try {
    await ask('load', 7);
    return 'not reached';
  } on D4rtHostException catch (e) {
    return '\${e.tag} \${e.kind} \${e.message}';
  }
}
'''),
      );
      final done = dones(sent).single;
      expect(done['status'], 'ok');
      expect(done['value'], 'load StateError no such row');
    });

    test('HOST-W8-4: an uncaught failed request fails the run with the host '
        'exception [2026-11-06]', () async {
      final (w, sent) = answeringWorker(
        (tag, data) => (
          false,
          {'message': 'nobody home', 'kind': D4rtHostException.refusedKind},
        ),
      );
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
Future<Object?> main() async => await ask('load');
'''),
      );
      final error = dones(sent).single['error']! as Map;
      expect(error['kind'], 'D4rtHostException');
      expect(error['message'], contains('nobody home'));
    });

    test('HOST-W8-5: a run that returns with a request unanswered is failed, '
        'and the late answer is dropped [2026-11-06]', () async {
      final (w, sent) = answeringWorker((tag, data) => null);
      await w.serve(
        fixtureRequest('''
import 'package:fixture/run.dart';
int main() {
  ask('fire-and-forget');
  return 1;
}
''', runId: 'r1'),
      );
      final done = dones(sent).single;
      expect(done['status'], 'failed');
      expect(done['value'], isNull);
      final error = done['error']! as Map;
      expect(error['kind'], D4rtRunError.outstandingKind);
      expect(error['message'], contains('fire-and-forget'));

      // Delivered after the run ended: nothing awaits it, nothing breaks.
      w.receive([D4rtHostMessage.reply, 'r1', 0, true, 'late']);
      await w.serve(fixtureRequest('int main() => 2;', runId: 'r2'));
      expect(dones(sent).last['value'], 2);
    });

    test('HOST-W8-6: a request made after its run ended is refused at once '
        '[2026-11-06]', () async {
      final runs = <D4rtWorkerRun>[];
      final w = D4rtWorker<Object?>(
        (_) {},
        _CapturingDelegate(runs, FixtureDelegate()),
      );
      await w.serve(fixtureRequest('int main() => 1;'));
      expect(
        () => runs.single.request('late', null),
        throwsA(isA<StateError>()),
      );
    });
  });
}

/// A [FixtureDelegate] that keeps every run it began, so a test can use one
/// after it ended.
class _CapturingDelegate extends D4rtWorkerDelegate<Object?> {
  _CapturingDelegate(this.runs, this.inner);
  final List<D4rtWorkerRun> runs;
  final FixtureDelegate inner;

  @override
  void begin(D4rtWorkerRun run) {
    runs.add(run);
    inner.begin(run);
  }

  @override
  Object? interpreterKey(D4rtWorkerRun run) => inner.interpreterKey(run);

  @override
  void furnish(D4rt interpreter, Object? key) =>
      inner.furnish(interpreter, key);

  @override
  void end(D4rtWorkerRun run) => inner.end(run);
}
