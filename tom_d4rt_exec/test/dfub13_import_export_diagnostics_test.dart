// DFUB13 (exec tree): a failed import/export must produce an ACTIONABLE
// diagnostic — the twin of `tom_d4rt/test/dfub13_import_export_diagnostics_test.dart`.
//
// The DFUB13 todo scoped itself to tom_d4rt + tom_d4rt_ast and never mentions
// this package, but tom_d4rt_exec carries its OWN third copy of `d4rt_base.dart`
// and `module_loader.dart` — and it is what downstream consumers actually run.
// All three defects were present here too, so all three are fixed and pinned
// here rather than being left to rot in the copy nobody was looking at.
//
// The exec loader has no filesystem machinery, so it gets the package-scheme
// branch of the DFUB2 diagnostic and not the two filesystem branches.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('DFUB13/exec: missing import/export diagnostics', () {
    test('F-DFUB13-EXEC-1: a missing package import is NOT reported as '
        '"Unexpected error" [2026-07-27]', () {
      // GAP 1. The loader's diagnostic is expected and actionable, so it must
      // survive execute() as its own type rather than being relabelled as an
      // interpreter bug.
      expect(
        () => D4rt().execute(source: '''
          import 'package:does_not_exist/foo.dart';
          int main() => 1;
        '''),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'message',
            isNot(contains('Unexpected error')),
          ),
        ),
      );
    });

    test('F-DFUB13-EXEC-2: a missing package import says how to fix it '
        '[2026-07-27]', () {
      // GAP 2. The generic "not a recognized Dart standard library" tail is
      // noise for a package: URI — nobody expected it to be a stdlib library,
      // and neither real fix was mentioned.
      expect(
        () => D4rt().execute(source: '''
          import 'package:does_not_exist/foo.dart';
          int main() => 1;
        '''),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('Package module source not preloaded'),
              contains('package:does_not_exist/foo.dart'),
              contains('register a bridge'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-EXEC-3: a failed import inside a module names the OWNER and '
        'the target [2026-07-27]', () {
      // GAP 3. `helper.dart` is the file the user has to edit; without this the
      // message only ever named `package:nope/missing.dart`.
      expect(
        () => D4rt().execute(
          library: 'package:app/main.dart',
          sources: {
            'package:app/main.dart':
                "import 'package:app/helper.dart';\nint main() => 1;",
            'package:app/helper.dart':
                "import 'package:nope/missing.dart';\nint h() => 2;",
          },
          source: '',
        ),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('Failed to load import'),
              contains('package:nope/missing.dart'),
              contains('package:app/helper.dart'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-EXEC-4: a failed export names the OWNER and the target '
        '[2026-07-27]', () {
      // Barrel files are exactly where this matters: the barrel is usually not
      // the file the user was editing.
      expect(
        () => D4rt().execute(
          library: 'package:app/main.dart',
          sources: {
            'package:app/main.dart':
                "import 'package:app/barrel.dart';\nint main() => 1;",
            'package:app/barrel.dart': "export 'package:nope/gone.dart';",
          },
          source: '',
        ),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('Failed to load export'),
              contains('package:nope/gone.dart'),
              contains('package:app/barrel.dart'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-EXEC-5: directive context is added ONCE, at the innermost '
        'failure [2026-07-27]', () {
      // loadModule recurses, so every frame on the way out sees the same
      // exception and could prepend its own "Failed to load ..." prefix. For a
      // deep barrel chain that repeats one cause N times and buries the frame
      // that matters — the innermost one, which names the file that actually
      // contains the bad directive.
      String message;
      try {
        D4rt().execute(
          library: 'package:app/main.dart',
          sources: {
            'package:app/main.dart':
                "import 'package:app/a.dart';\nint main() => 1;",
            'package:app/a.dart': "export 'package:app/b.dart';",
            'package:app/b.dart': "export 'package:app/c.dart';",
            'package:app/c.dart':
                "import 'package:nope/deep.dart';\nint c() => 3;",
          },
          source: '',
        );
        fail('expected a SourceCodeD4rtException');
      } on SourceCodeD4rtException catch (e) {
        message = e.toString();
      }

      expect(message, contains('package:app/c.dart'),
          reason: 'the innermost owner is the file with the bad directive');
      expect('Failed to load'.allMatches(message).length, equals(1),
          reason: 'one directive-context prefix, not one per frame in the '
              'import chain. Got:\n$message');
    });
  });
}
