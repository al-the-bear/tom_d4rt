// sce43: the lifecycle `tom_d4rt`'s testing guideline documents works on this
// line too.
//
// That guideline tells readers to write
//
//     tearDown(() {
//       interpreter.dispose();
//     });
//
// and `dispose` was not declared on this package's `D4rt` at all — so the
// documented pattern did not compile here, while the capability sat on the
// inner `D4rtRunner` the whole time. F-SCD10-5 now compares the two class
// surfaces so that cannot recur silently; this file asserts the member does
// what it says rather than merely existing, which is the difference between a
// forwarded method and a working one.
//
// `dispose` is specified as NON-DESTRUCTIVE: it releases the finished run's
// per-run state (parsed units, visitor) and preserves process-global state, so
// the instance stays usable. Both halves are asserted — releasing without
// remaining usable would be a regression wearing the same name.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';

void main() {
  group('SCE43: the documented dispose lifecycle', () {
    test('G-SCE43-1: the guideline pattern runs — construct, execute, dispose '
        '[2026-09-18] (PASS)', () async {
      final interpreter = D4rt();
      addTearDown(interpreter.dispose);

      final result = await interpreter.execute(
        source: '''
            int main() {
              return 21 + 21;
            }
          ''',
      );

      expect(result, 42);
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('G-SCE43-2: dispose releases the run it retained, and the instance '
        'stays usable [2026-09-18] (PASS)', () async {
      final interpreter = D4rt();

      expect(
        interpreter.debugLoadedModuleCount,
        0,
        reason: 'nothing has executed yet',
      );

      // The counter counts LOADED MODULES, so the script has to import
      // something: measured, a script with no imports leaves it at 0, one
      // import gives 1 and two give 2. A trivial script would have made the
      // release below assert nothing.
      expect(
        await interpreter.execute(
          source:
              "import 'dart:math';\nimport 'dart:convert';\nint main() => 1;",
        ),
        1,
      );
      final afterRun = interpreter.debugLoadedModuleCount;
      expect(
        afterRun,
        greaterThan(0),
        reason:
            'the run must retain something, or releasing it proves '
            'nothing — this is the counter `dispose` exists to bring back '
            'down',
      );

      interpreter.dispose();
      expect(
        interpreter.debugLoadedModuleCount,
        0,
        reason: 'dispose releases the finished run\'s parsed modules',
      );

      // Non-destructive: a subsequent execute rebuilds the per-run loader.
      expect(
        await interpreter.execute(
          source: "import 'dart:math';\nint main() => 2;",
        ),
        2,
        reason: 'dispose must leave the instance usable, not spent',
      );
      interpreter.dispose();
    }, timeout: const Timeout(Duration(minutes: 2)));

    test(
      'G-SCE43-3: dispose before any execute is safe [2026-09-18] (PASS)',
      () {
        // The reference guards this with `_hasExecutedOnce`; a tearDown fires
        // even when the test body threw before executing anything, so this is
        // the path the documented pattern hits on a failing test.
        final interpreter = D4rt();
        expect(interpreter.dispose, returnsNormally);
      },
    );

    test('G-SCE43-4: the registration trio and the alias/typedef views are '
        'reachable through the facade [2026-09-18] (PASS)', () {
      // Not behaviour — reachability. Each of these existed on D4rtRunner
      // and a consumer had to go around the facade to use it.
      final interpreter = D4rt();
      addTearDown(interpreter.dispose);

      interpreter.registerClassAlias('AliasName', 'TargetName', 'pkg:x');
      interpreter.registerFunctionTypedef('VoidCallback', 'pkg:x');

      expect(
        interpreter.classAliases.map((a) => a.aliasName),
        contains('AliasName'),
        reason:
            'the facade must report what it registered; it used to keep '
            'a second list that nothing read',
      );
      expect(
        interpreter.functionTypedefs.map((t) => t.name),
        contains('VoidCallback'),
      );
      expect(D4rt.debugBridgedModuleEnvBuildCount, isA<int>());
      expect(interpreter.reuseAcrossRuns, isTrue);
      expect(D4rt(reuseAcrossRuns: false).reuseAcrossRuns, isFalse);
    });
  });
}
