/// Repro + regression for OPEN B.11 — cold-start flakiness (U25).
///
/// Historic failure: the first script run after a test harness' `setUpAll`
/// flaked under host load because the analyzer parser and the bridge/stdlib
/// registration path cold-started *during* that first build. The shipped
/// reset API warms nothing.
///
/// The fix adds an interpreter `warmup()` pass that pre-builds the parser +
/// bridge infrastructure before the first real build, so the first build
/// behaves like a warm one. This is the analyzer-based VM runtime; mirrors the
/// analyzer-free AST twin in
/// `tom_d4rt_exec/test/open_issues/b11_warmup_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// A native type, registered as a bridged class, that interpreted code can
/// instantiate and call — its presence makes `warmup()` exercise the
/// bridged-definition registration path, not just the stdlib path.
class Greeter {
  final String who;
  Greeter(this.who);
  String greet() => 'hello $who';
}

D4rt _interpreterWithGreeter() {
  final interpreter = D4rt();
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Greeter,
      name: 'Greeter',
      constructors: {
        '': (visitor, positionalArgs, namedArgs) =>
            Greeter(positionalArgs.isNotEmpty ? '${positionalArgs[0]}' : ''),
      },
      methods: {
        'greet': (visitor, target, positionalArgs, namedArgs, typeArgs) =>
            (target as Greeter).greet(),
      },
    ),
    'package:test/greeter.dart',
  );
  return interpreter;
}

/// Burn a little CPU synchronously to simulate the host being busy at the
/// moment the first build kicks off. Deterministic, single-threaded — the
/// point of the regression is that warmup makes the first build behave like a
/// warm build, not that we reproduce true preemptive scheduling.
int _simulateHostLoad() {
  var acc = 0;
  for (var i = 0; i < 200000; i++) {
    acc = (acc + i) & 0xffff;
  }
  return acc;
}

void main() {
  group('OPEN B.11 — warmup pre-builds infrastructure (VM)', () {
    test('warmup() finalizes bridges', () {
      final interpreter = _interpreterWithGreeter();
      expect(interpreter.bridgesFinalized, isFalse);
      interpreter.warmup();
      expect(interpreter.bridgesFinalized, isTrue);
    });

    test('warmup() is idempotent (callable more than once)', () {
      final interpreter = _interpreterWithGreeter();
      interpreter.warmup();
      expect(interpreter.warmup, returnsNormally);
      expect(interpreter.bridgesFinalized, isTrue);
    });

    test(
      'first build after warmup runs correctly under simulated host load',
      () {
        final interpreter = _interpreterWithGreeter();
        interpreter.warmup();

        _simulateHostLoad();
        final result = interpreter.execute(
          source: '''
import 'package:test/greeter.dart';
String main() => Greeter('world').greet();
''',
        );
        expect(result, 'hello world');
      },
    );

    test('warmed first build is deterministic across repeated runs', () {
      final interpreter = _interpreterWithGreeter();
      interpreter.warmup();

      for (var i = 0; i < 25; i++) {
        _simulateHostLoad();
        final result = interpreter.execute(
          source: '''
import 'package:test/greeter.dart';
String main() => Greeter('run').greet();
''',
        );
        expect(result, 'hello run', reason: 'iteration $i flaked');
      }
    });

    test('execute still works without an explicit warmup (no regression)', () {
      final interpreter = _interpreterWithGreeter();
      final result = interpreter.execute(
        source: '''
import 'package:test/greeter.dart';
String main() => Greeter('cold').greet();
''',
      );
      expect(result, 'hello cold');
    });
  });
}
