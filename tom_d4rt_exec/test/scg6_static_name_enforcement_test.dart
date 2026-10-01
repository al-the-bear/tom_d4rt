// SCG6 (phase 2 of SCD95): a program that reads a name nothing defines is
// refused BEFORE `main` runs, as Dart rejects it at compile time.
//
// Before, d4rt ran everything up to the bad line: a script that recorded a
// side effect on its first line and misspelled a name on its second had
// already recorded it. `_refuseStaticallyUndefinedNames` in `d4rt_base.dart`
// runs after imports and declarations are registered and before `main`, in
// two stages: the syntactic pass NARROWS to candidates, the populated
// environment CONFIRMS, and only a name both agree on is refused, by
// evaluating it so the error is the one the line would have raised.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Host-owned record of what the script did.
final _log = <Object?>[];

class _Host {}

D4rt _interpreter() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _Host,
      name: 'Host',
      staticMethods: {
        'record': (visitor, positional, named, typeArgs) {
          _log.add(positional.first);
          return null;
        },
      },
    ),
    'package:test/host.dart',
  )
  ..registerGlobalVariable('hostGlobal', 41, 'package:test/host.dart');

Object? _run(String body) => _interpreter().execute(
  source:
      '''
import 'package:test/host.dart';
$body
''',
);

void main() {
  setUp(_log.clear);

  group('SCG6: an undefined name is refused before main runs', () {
    test('F-SCG6-1: no statement of main executes — the host list stays '
        'EMPTY [2026-09-30] (PASS)', () {
      expect(
        () => _run('main() { Host.record(1); return totallyUndefinedName; }'),
        throwsA(
          isA<UndefinedNameD4rtException>().having(
            (e) => e.name,
            'name',
            'totallyUndefinedName',
          ),
        ),
      );
      expect(_log, isEmpty, reason: 'main ran its first statement');
    });

    test('F-SCG6-2: a name in a branch that never runs is refused too, as in '
        'Dart [2026-09-30] (PASS)', () {
      expect(
        () => _run(
          'main() { Host.record(1); if (false) { return notDefinedEither; } '
          'return 0; }',
        ),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
      expect(_log, isEmpty);
    });

    test('F-SCG6-3: the environment confirms — a name only the host '
        'registered still runs [2026-09-30] (PASS)', () {
      // The syntactic pass is handed no registration set, so it flags
      // `hostGlobal`; the environment finds it, so the program runs.
      expect(_run('main() { Host.record(1); return hostGlobal + 1; }'), 42);
      expect(_log, [1]);
    });

    test('F-SCG6-4: locals, parameters, top-level declarations and SDK names '
        'resolve [2026-09-30] (PASS)', () {
      expect(
        _run('''
int twice(int x) => x * 2;
final base = 1;
main() {
  final values = [for (var i = 0; i < 3; i++) twice(i)];
  return values.fold(base, (a, b) => a + b) + max(0, 1);
}
int max(int a, int b) => a > b ? a : b;
'''),
        8,
      );
    });

    test('F-SCG6-5: the dynamic residue still raises at runtime — a member '
        'after a `.` is not the pass\'s to judge [2026-09-30] (PASS)', () {
      // `(x as dynamic).nope` is after a `.`, so nothing is refused up front:
      // main runs its first statement, then the member lookup fails.
      expect(
        () => _run(
          'main() { Host.record(1); final x = 1; return (x as dynamic).nope; }',
        ),
        throwsA(anything),
      );
      expect(_log, [1]);
    });

    test('F-SCG6-6: a conditional import\'s configuration is not a read '
        '[2026-10-01] (PASS)', () {
      // sci2: `dart.library.io` in `import ... if (dart.library.io) ...` is a
      // DottedName, and its first segment fell through to the read branch, so
      // every program with a conditional import was refused as reading an
      // undefined `dart`. exec's suite (F-SCE62-5) found it.
      expect(
        _run(
          "import 'dart:math' if (dart.library.io) 'dart:math' as m;\n"
          'main() => m.max(1, 2);',
        ),
        2,
      );
    });
  });
}
