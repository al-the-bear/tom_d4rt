// SCD69 — source that does not parse is rejected before anything runs.
//
// THE TODO THAT ASKED FOR THIS WAS ALREADY SATISFIED WHEN IT WAS OPENED, and
// the measurement is the point: `on void catch (e)` and
// `main() { this is not dart ]]] }` both reach the interpreter, said the todo.
// Measured 2026-09-12, both are rejected with a `SourceCodeD4rtException`
// naming the analyzer's diagnostic and its line and column — SCC35 fixed it
// (commit 4116884d7) between the todo being written and being run.
//
// SO WHAT WAS ACTUALLY MISSING WAS THIS FILE. The behaviour was correct in BOTH
// front ends and pinned in NEITHER: a grep for the diagnostic wording across
// both test trees found nothing, and exec's F-SCC20-18 covers the one
// `on void` case as a by-product of testing catch clauses. A correct behaviour
// with no test is one publish away from being an incorrect behaviour with no
// test, which for this one means a script running a fragment the parser
// salvaged from something the author never wrote.
//
// F-SCD69-3 IS THE CASE THAT MATTERS. Asserting the exception type only proves
// something objected; it does not prove the program did not run first.
// `main() => 42; @@@` has a complete, valid `main` in front of the garbage, so
// before SCC35 it returned 42 — a successful answer for a source file the
// analyzer rejects. Throwing instead of returning 42 is the whole fix.
//
// THE BOUNDARY IS SYNTAX, AND F-SCD69-5 SAYS SO OUT LOUD. The front end parses
// without resolving, so it sees syntactic errors and nothing else: an undefined
// name still reaches the interpreter and fails there, which is correct and is
// the only thing the interpreter could do about it. Without that case a reader
// would reasonably conclude the front end validates, and file the next
// undefined-name report as a regression here.
//
// F-SCD69-4 IS THE RAIL. The check filters on `severity == ERROR`, and a fix
// that dropped that filter would reject every script with an unused variable —
// turning a lint into a fatal error, which is a far worse outcome than the
// defect being fixed.
//
// MIRRORED, and mirrored on purpose: `tom_d4rt` and `tom_d4rt_exec` are
// separate front ends over the same analyzer, and the todo's done-when asked
// for exec to match `tom_d4rt` "as it does today". Measured on eight inputs,
// the two produce byte-identical exception types, messages and positions — so
// the same cases are asserted on both sides rather than one side asserting and
// the other being assumed. `tom_d4rt_ast` is deliberately absent: it has no
// parser, which is the entire reason exec exists.
//
// CONTROL, measured by disabling the rejection in each front end: `+2 -3` on
// BOTH sides, with the same split. -1, -2 and -3 fail; -4 and -5 keep passing.
// That is what they are there for — a "fix" that also rejected warnings would
// satisfy every case that fails above and be worse than the defect, and one
// that started reporting undefined names as source errors would move a runtime
// diagnostic into the front end where it cannot be right.
//
// Disabling it in `tom_d4rt_exec` also turns exec's own F-SCC20-18 red. That
// case is a real guard, and narrower: it covers the one `on void` spelling as a
// by-product of testing catch clauses, and says nothing about whether a
// salvaged fragment runs.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

/// The `SourceCodeD4rtException` [source] raises, or null when it raises none.
Object? rejectionOf(String source) {
  try {
    run(source);
    return null;
  } on SourceCodeD4rtException catch (e) {
    return e;
  }
}

void main() {
  group('SCD69: malformed source never reaches the interpreter', () {
    test(
      'F-SCD69-1: a syntax error is a SourceCodeD4rtException, not a runtime '
      'error [2026-09-12] (PASS)',
      () {
        // Five shapes, because the parser recovers differently from each and a
        // fix that rejected only one of them would look right against a single
        // case. The todo's own two probes are the first and the last.
        const malformed = <String, String>{
          'unparseable statement': 'main() { this is not dart ]]] }',
          'missing closing brace': 'main() { return 1;',
          'stray token after a valid unit': 'main() { return 1; } @@@',
          'misspelled top-level keyword': 'clas Foo {} main() => 1;',
          'unterminated string': "main() => 'abc;",
        };
        malformed.forEach((label, source) {
          expect(
            rejectionOf(source),
            isA<SourceCodeD4rtException>(),
            reason: '$label should be rejected by the front end',
          );
        });

        // `on void catch (e)` — void is not a type that can appear in an
        // on-clause, so this is a syntax error and not a clause that fails to
        // match. Before SCC35 the script ran and took the `catch` arm, which
        // reads as a working program.
        expect(
          rejectionOf(
            "main() { try { throw 1; } on void catch (e) { return 'void'; } "
            "catch (e) { return 'generic'; } }",
          ),
          isA<SourceCodeD4rtException>(),
        );
      },
    );

    test(
      'F-SCD69-2: the message carries the analyzer diagnostic and its position '
      '[2026-09-12] (PASS)',
      () {
        // A bare "could not parse" would satisfy F-SCD69-1 and tell the author
        // nothing. The analyzer already knows what is wrong and where; the
        // front end's job is to pass that through rather than replace it.
        final message = rejectionOf("main() => 'abc;").toString();
        expect(message, contains('Unterminated string literal'));
        expect(message, contains('line 1'));
        expect(message, contains('column 15'));
      },
    );

    test(
      'F-SCD69-3: the salvaged fragment does not run [2026-09-12] (PASS)',
      () {
        // THE CASE THE OTHERS CANNOT MAKE. `main` here is complete and valid,
        // and the garbage is behind it — so a front end that parses, keeps what
        // the recovery salvaged and carries on returns 42 and reports success
        // for a file the analyzer rejects. Asserting the exception type alone
        // would pass against that, because something did object; only the
        // ABSENCE of 42 says the program never ran.
        expect(
          rejectionOf('main() => 42; @@@'),
          isA<SourceCodeD4rtException>(),
        );
        expect(
          () => run('main() => 42; @@@'),
          throwsA(isA<SourceCodeD4rtException>()),
        );
        // The mirror image: garbage first, valid declaration after.
        expect(
          rejectionOf('@@@ main() => 42;'),
          isA<SourceCodeD4rtException>(),
        );
      },
    );

    test('F-SCD69-4: warnings and lints still run [2026-09-12] (PASS)', () {
      // The rail. The check filters on ERROR severity; dropping that filter
      // would turn an unused variable into a fatal error, which is worse than
      // the defect this file guards. Each of these is diagnosed by the
      // analyzer at a lower severity and each is a program somebody would
      // reasonably write.
      expect(run('main() { var unused = 1; return 7; }'), 7);
      expect(run('main() { return 7; var x = 1; }'), 7);
      expect(run('main() { var a = 1; return a + 1; }'), 2);
    });

    test('F-SCD69-5: SEMANTIC errors are not the front end\'s job '
        '[2026-09-12] (PASS)', () {
      // The front end parses without resolving, so it sees syntax and nothing
      // else. An undefined name is legal Dart syntax and reaches the
      // interpreter, which reports it at the point of use — correct, and the
      // only thing available, since resolution would need the whole program
      // including every bridge.
      //
      // Written down because the alternative reading is attractive and wrong:
      // a reader who sees this file reject bad source may file the next
      // undefined-name report as a regression here.
      expect(
        () => run('main() { return notDefinedAnywhere; }'),
        throwsA(isNot(isA<SourceCodeD4rtException>())),
      );
      expect(
        () => run('int f(int a) => a; main() => f();'),
        throwsA(isNot(isA<SourceCodeD4rtException>())),
      );
    });

    test('F-SCD69-6: an imported module is rejected too, and named '
        '[2026-09-12] (PASS)', () {
      // The front end parses the entry script AND every module it loads, so
      // the rejection has to reach both. This is the half a test written
      // against direct source only would miss — and the half where getting
      // it wrong is worst, because the salvaged fragment would come from a
      // file the author is not currently looking at.
      const source = "import 'package:m/bad.dart';\nmain() => helper();";
      const modules = {'package:m/bad.dart': 'int helper() => 7;\n@@@ broken'};
      expect(
        () => D4rt().execute(source: source, name: 'main', sources: modules),
        throwsA(
          isA<SourceCodeD4rtException>().having(
            (e) => e.toString(),
            'names the module',
            contains('package:m/bad.dart'),
          ),
        ),
      );
      // Even when nothing in it is used: the module is parsed because it was
      // imported, not because a name resolved to it.
      expect(
        () => D4rt().execute(
          source: "import 'package:m/bad.dart';\nmain() => 1;",
          name: 'main',
          sources: modules,
        ),
        throwsA(isA<SourceCodeD4rtException>()),
      );
      // The control: the same shape with a module that parses.
      expect(
        D4rt().execute(
          source: "import 'package:m/good.dart';\nmain() => helper();",
          name: 'main',
          sources: const {'package:m/good.dart': 'int helper() => 7;'},
        ),
        7,
      );

      // ASSERTED ON THE URI, NOT THE MESSAGE PREFIX, and deliberately:
      // measured
      // 2026-09-12, `tom_d4rt` says "Parsing errors in module <uri>" and
      // `tom_d4rt_exec` says "Fatal parsing errors for <uri>". They agree
      // exactly on direct source and diverge only here. What matters is that
      // the failure names the MODULE rather than the entry script, which both
      // do; the wording difference is recorded rather than pinned.
    });
  });
}
