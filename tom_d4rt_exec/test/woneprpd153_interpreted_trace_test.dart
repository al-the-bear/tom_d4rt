// WONEPRPD153: the interpreted call stack. An error that leaves a script
// carries the script's own frames — which interpreted function, which line —
// read back through `D4rt.lastErrorTrace`, innermost first.
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Runs [source] expecting it to throw; answers the trace it left.
List<D4rtStackFrame> traceOf(D4rt d4rt, String source) {
  expect(() => d4rt.execute(source: source), throwsA(anything));
  return d4rt.lastErrorTrace;
}

String shape(List<D4rtStackFrame> frames) =>
    frames.map((f) => '${f.member}@${f.line}:${f.column}').join(' < ');

void main() {
  group('D4rt.lastErrorTrace', () {
    test('WONEPRPD153-1: a throw three calls deep reports three frames, '
        'innermost first, each at its own line', () {
      final trace = traceOf(D4rt(), '''
int inner() {
  var x = 1;
  throw StateError('deep');
}

int middle() {
  return inner() + 1;
}

int main() {
  var y = 0;
  return middle();
}
''');
      expect(shape(trace), 'inner@3:3 < middle@7:3 < main@12:3');
      expect(
        trace.every((f) => f.source == null),
        isTrue,
        reason: 'all in the main source',
      );
    });

    test('WONEPRPD153-2: an interpreter fault, not a script throw, is located '
        'the same way', () {
      final trace = traceOf(D4rt(), '''
int broken() {
  String? s;
  return s!.length;
}

int main() {
  return broken();
}
''');
      expect(shape(trace), 'broken@3:3 < main@7:3');
    });

    test('WONEPRPD153-3: an expression-bodied function is at its body', () {
      final trace = traceOf(D4rt(), '''
int boom() => throw ArgumentError('x');

int main() {
  return boom();
}
''');
      expect(trace.first.member, 'boom');
      expect(trace.first.line, 1);
      expect(shape(trace.skip(1).toList()), 'main@4:3');
    });

    test('WONEPRPD153-4: a handled error leaves no trace on the run, and a '
        'later run starts clean', () {
      final d4rt = D4rt();
      traceOf(d4rt, 'int main() { throw "x"; }');
      expect(d4rt.lastErrorTrace, isNotEmpty);
      final ok = d4rt.execute(
        source: '''
int risky() => throw StateError('caught');
int main() {
  try { return risky(); } catch (_) { return 7; }
}
''',
      );
      expect(ok, 7);
      expect(d4rt.lastErrorTrace, isEmpty);
    });

    test('WONEPRPD153-5: frames are popped on return, so a later throw does '
        'not inherit an earlier call', () {
      final trace = traceOf(D4rt(), '''
int helper() => 1;

int main() {
  var a = helper();
  var b = helper();
  throw StateError('after');
}
''');
      expect(shape(trace), 'main@6:3');
    });
  });
}
