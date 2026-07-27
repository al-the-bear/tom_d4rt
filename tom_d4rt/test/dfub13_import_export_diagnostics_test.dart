// DFUB13: a failed import/export must produce an ACTIONABLE diagnostic.
//
// Three separate defects conspired to make a missing import one of the least
// helpful errors the interpreter could produce. Before this suite the message
// for a missing package import was:
//
//   Runtime Error: Unexpected error: SourceCodeException: Package module
//   source not preloaded for URI: package:does_not_exist/foo.dart. ...
//
// Everything after "Unexpected error:" is a perfectly good diagnostic that the
// loader went to the trouble of composing — and the execute() guard threw it
// away by relabelling it as something nobody can act on. A user reading
// "Unexpected error" reasonably concludes they hit an interpreter bug, not that
// they mistyped a package name.
//
// The second defect only shows up once a program has more than one file: the
// message named the module that could not be FOUND but never the module that
// ASKED for it. In a barrel chain that is the wrong half of the information —
// the missing URI is the symptom, the importing file is the thing you have to
// edit.
//
// GAP numbering matches the DFUB13 todo: GAP 1 = the "Unexpected error"
// re-wrap, GAP 2 = the package-scheme message (already landed in tom_d4rt by
// DFUB2, guarded here so it cannot silently regress), GAP 3 = directive
// context.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('DFUB13: missing import/export diagnostics', () {
    test('F-DFUB13-1: a missing package import is NOT reported as '
        '"Unexpected error" [2026-07-27]', () {
      // GAP 1. The loader's diagnostic is expected and actionable, so it must
      // survive execute() as its own type rather than being relabelled.
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

    test('F-DFUB13-2: a missing package import says how to fix it '
        '[2026-07-27]', () {
      // GAP 2. Landed in tom_d4rt by DFUB2; guarded here because DFUB13's whole
      // point is that this text is what GAP 1 was discarding.
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

    test('F-DFUB13-2b: a bare script gets NO synthetic owner in the message '
        '[2026-07-27]', () {
      // Deliberate divergence from the DFUB13 todo, which specified
      // `ownerUri = currentLibrary ?? Uri.parse('d4rt:direct-source')`.
      // Owner context exists to distinguish the file holding the directive from
      // the file that could not be found. For a single anonymous script those
      // are the same thing, so that fallback produced
      //   Failed to load import "package:x/y.dart" from module
      //   "d4rt:direct-source": ...
      // which restates the target and leaks an internal URI at the user. The
      // wrap is skipped instead.
      expect(
        () => D4rt().execute(source: '''
          import 'package:does_not_exist/foo.dart';
          int main() => 1;
        '''),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'message',
            isNot(contains('d4rt:direct-source')),
          ),
        ),
      );
    });

    test('F-DFUB13-3: a failed import inside a module names the OWNER and the '
        'target [2026-07-27]', () {
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

    test('F-DFUB13-4: a failed export names the OWNER and the target '
        '[2026-07-27]', () {
      // GAP 3, export side. Barrel files are exactly where this matters: the
      // barrel is usually not the file the user was editing.
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

    test('F-DFUB13-5: directive context is added ONCE, at the innermost '
        'failure [2026-07-27]', () {
      // loadModule recurses, so every frame on the way out sees the same
      // SourceCodeD4rtException and could prepend its own "Failed to load ..."
      // prefix. For a deep barrel chain that turns a one-line diagnostic into a
      // paragraph that repeats the same underlying cause N times, and buries
      // the one frame that matters — the innermost one, which names the file
      // that actually contains the bad directive.
      //
      // So the wrap is applied once and suppressed thereafter. This asserts
      // both halves: the innermost owner IS named, and the intermediate ones
      // are NOT stacked on top of it.
      String message;
      try {
        D4rt().execute(
          library: 'package:app/main.dart',
          sources: {
            'package:app/main.dart':
                "import 'package:app/a.dart';\nint main() => 1;",
            'package:app/a.dart': "export 'package:app/b.dart';",
            'package:app/b.dart': "export 'package:app/c.dart';",
            'package:app/c.dart': "import 'package:nope/deep.dart';\nint c() => 3;",
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
