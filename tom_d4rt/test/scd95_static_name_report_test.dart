import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/src/static_name_report.dart';

/// SCD95 — the report-only static name pass, and what sweeping it measured.
///
/// SCC31 made an undefined name unswallowable: it is raised as
/// `UndefinedNameD4rtException`, and both catch-dispatch sites decline to match
/// any clause against it, so a typo unwinds past every interpreted handler.
/// That removed the harm but not the divergence. Real Dart rejects the program
/// at COMPILE time, so it never runs; d4rt runs everything up to the bad line
/// first. A script that writes a file on line 3 and mistypes a name on line 9
/// has already written the file.
///
/// Closing that means a pass that can REFUSE to run a program — and a resolver
/// that is wrong in the aggressive direction rejects working scripts, which is
/// far worse than the bug it fixes. So this is built report-only and swept over
/// corpora of programs known to work FIRST. That ordering is the whole
/// risk-management strategy, and this file is the half of it that a test can
/// hold.
///
/// WHAT THE SWEEP MEASURED (2026-09-14, `tool/scd95_sweep.dart` and
/// `tool/scd95_sweep_inline.dart`)
///
/// | corpus                         | units | clean | flagged |
/// | ------------------------------ | ----: | ----: | ------: |
/// | flutter-material cluster       |  2085 |  2083 |       1 |
/// | tom_d4rt inline `execute(...)` |   807 |   799 |       8 |
///
/// **Every remaining flag is a TRUE positive** — a name the script genuinely
/// does not define, in a script written on purpose to contain one:
/// `ButtonBar` in `a5_deprecated_symbol_absent_test.dart` (a deprecated symbol
/// the generator skips), `totallyUndefinedThing` in SCC31's own fixture,
/// `notDefinedAnywhere` in SCD69's, and `Zone`/`Zoen` in
/// `intentionally_unbridged_test.dart`. The sweep reached that state by
/// closing four real resolver holes, each of which is pinned below:
/// cascade sections, switch-EXPRESSION patterns, extension-opened classes and
/// import prefixes.
///
/// WHY THIS IS NOT YET ENFORCING, stated so it reads as a decision
///
/// The sweeps supply `knownGlobals` by REGEX-HARVESTING the bridge and stdlib
/// sources. That is good enough to measure the syntactic resolver, and it is
/// not good enough to reject a program: the real registration set lives in the
/// `Environment` at execute time. Wiring that is the other half, and it carries
/// its own question the sweep cannot answer — see sce128, which records the
/// design this measurement arrived at.
///
/// TWO NUMBERS THAT KEEP THE CLEAN SWEEP HONEST
///
/// The flutter sweep skipped **12 201** class bodies as "open" (a supertype
/// leaving the unit, or an extension targeting the class). So the pass checks
/// top-level and function-local reads and waves through most class interiors.
/// A clean sweep means "found no false positives", NOT "checked everything" —
/// and `NameReport.openClasses` exists so that distinction is visible in the
/// data rather than only in this comment.
void main() {
  /// Report over [source] with [globals] treated as registered.
  NameReport report(String source, {Set<String> globals = const {}}) {
    final result = parseString(
      content: source,
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    );
    return reportUnresolvedNames(result.unit, {
      'print',
      'int',
      'String',
      'bool',
      'double',
      'List',
      'Map',
      'num',
      ...globals,
    });
  }

  List<String> names(String source, {Set<String> globals = const {}}) =>
      report(source, globals: globals).unresolved.map((u) => u.name).toList();

  group('SCD95: the report-only pass finds undefined names', () {
    test('F-SCD95-1: a bare undefined name is reported [2026-09-14]', () {
      expect(names('main() { return totallyUndefinedThing; }'), [
        'totallyUndefinedThing',
      ]);
    });

    test(
      'F-SCD95-2: a program whose names all resolve is clean [2026-09-14]',
      () {
        expect(
          report('''
          int twice(int x) => x * 2;
          main() {
            final a = 3;
            return twice(a);
          }
        ''').isClean,
          isTrue,
        );
      },
    );

    test('F-SCD95-3: every scope kind that binds a name is honoured '
        '[2026-09-14]', () {
      // One case per binder. A resolver that missed any one of these would
      // report a working program's own variable as undefined, which is the
      // failure mode that makes an aggressive resolver worse than the bug.
      expect(report('main() { var x = 1; return x; }').isClean, isTrue);
      expect(
        report('main() { for (var i = 0; i < 1; i++) { print(i); } }').isClean,
        isTrue,
      );
      expect(
        report('main() { for (final v in [1]) { print(v); } }').isClean,
        isTrue,
      );
      expect(
        report(
          'main() { try { print(1); } catch (e, st) { print(e); print(st); } }',
        ).isClean,
        isTrue,
      );
      expect(report('main() { f(int p) => p; return f(1); }').isClean, isTrue);
      expect(
        report('main() { final g = (int q) => q; return g(1); }').isClean,
        isTrue,
      );
    });

    // ------------------------------------------------------------------
    // The four holes the sweep found. Each is pinned with the shape that
    // exposed it, because each one produced a page of false positives.

    test('F-SCD95-4: a cascade section is not a bare read [2026-09-14]', () {
      // `x..moveTo(0, 0)` has no target in the AST — the receiver is the
      // cascade's. Reading `MethodInvocation.target` alone reported `moveTo`,
      // `lineTo`, `setEntry`, `scale`, `sort`, `writeln` and `add` as
      // undefined across the flutter corpus: 833 hits from one missing
      // `isCascaded`.
      expect(
        report(
          'main() { var b = StringBuffer(); b..write("a")..writeln("b"); }',
          globals: {'StringBuffer'},
        ).isClean,
        isTrue,
      );
    });

    test('F-SCD95-5: a switch EXPRESSION binds its pattern variables '
        '[2026-09-14]', () {
      // Handling only the statement form (`SwitchPatternCase`) left every
      // `switch (s) { Circle(:var radius) => radius * radius }` reporting the
      // name it had just bound.
      expect(
        report(
          '''
          sealed class Shape {}
          class Circle extends Shape { final double radius; Circle(this.radius); }
          double area(Shape s) => switch (s) {
            Circle(:var radius) => 3.14 * radius * radius,
            _ => 0.0,
          };
        ''',
          globals: {'double'},
        ).isClean,
        isTrue,
      );
    });

    test('F-SCD95-6: an extension opens the class it targets [2026-09-14]', () {
      // An extension member is reachable through implicit `this` by a route no
      // class body mentions, and applicability is decided at the call site.
      // Without this, `int use() => tripled;` reported `tripled`.
      final r = report('''
        class Box {
          int v = 4;
          int use() => tripled;
        }
        extension BoxX on Box { int get tripled => v * 3; }
      ''');
      expect(r.isClean, isTrue);
      expect(r.openClasses, contains('Box'));
    });

    test('F-SCD95-7: an import prefix is a name in its own right '
        '[2026-09-14]', () {
      expect(
        report("import 'dart:math' as m;\nmain() => m.pi;").isClean,
        isTrue,
      );
    });

    // ------------------------------------------------------------------
    // The silences. Each is a deliberate false negative, and a pass that
    // stopped being silent here would reject working programs.

    test('F-SCD95-8: anything after a `.` is never reported [2026-09-14]', () {
      // Resolving these needs the receiver's type, which an unresolved AST
      // does not carry — and a `dynamic` receiver makes the name legitimately
      // unknowable until runtime.
      expect(
        report('main() { var x = 1; return x.whateverThisIs; }').isClean,
        isTrue,
      );
      expect(
        report('main() { var x = 1; return x.noSuchMethod(); }').isClean,
        isTrue,
      );
    });

    test('F-SCD95-9: a class whose supertype leaves the unit is not checked '
        '[2026-09-14]', () {
      // It inherits members this pass cannot enumerate — including from a
      // BRIDGED supertype, which is the common case in the flutter corpus.
      final r = report(
        'class W extends SomeBridgedThing { build() => inheritedThing; }',
        globals: {'SomeBridgedThing'},
      );
      expect(r.isClean, isTrue);
      expect(r.openClasses, contains('W'));
    });

    test('F-SCD95-10: a unit with unaccounted imports is suppressed, and says '
        'so [2026-09-14]', () {
      // Suppressing on the mere PRESENCE of an import would be worse than
      // useless — it reports nothing, looks clean, and has checked nothing.
      // The first sweep did exactly that and "passed" over all 2085 corpus
      // files without examining one. `suppressed` is what makes the
      // difference legible.
      final r = reportUnresolvedNames(
        parseString(
          content: 'main() => nope;',
          featureSet: FeatureSet.latestLanguageVersion(),
          throwIfDiagnostics: false,
        ).unit,
        const {},
        hasUnresolvedImports: true,
      );
      expect(r.suppressed, isTrue);
      expect(r.isClean, isTrue);
      expect(
        r.isClean && r.suppressed,
        isTrue,
        reason:
            'a suppressed report is not a clean one; callers must read '
            '`suppressed` before believing `isClean`',
      );
    });

    test('F-SCD95-12: a label reference is not a read [2026-09-14, added by '
        'SCE128 2026-09-22]', () {
      // SCE128 tried to ENFORCE this pass and ran it over the reference suite
      // — a broader corpus than either of phase 1's sweeps. A label reference
      // was the single most frequent false positive: the DECLARATION is a
      // `Label` node and was excluded, but `break outer;` puts the name in a
      // bare `SimpleIdentifier` under a `BreakStatement`.
      expect(
        names('main() { outer: for (var i = 0; i < 1; i++) { break outer; } }'),
        isEmpty,
      );
      expect(
        names(
          'main() { loop: for (var i = 0; i < 1; i++) { continue loop; } }',
        ),
        isEmpty,
      );
      expect(names('main() { block: { break block; } }'), isEmpty);
    });

    test('F-SCD95-13: an extension type declares its representation [2026-09-14, '
        'added by SCE128 2026-09-22]', () {
      // The second hole the reference suite found. An extension type's members
      // read the representation bare, and nothing recorded it as declared, so
      // every such read was reported — twelve distinct members across the
      // suite, including the operator ones (`*`, `>`, `~`, `[]`).
      expect(
        names(
          'extension type X(int value) { int get doubled => value * 2; }\n'
          'main() { return X(1).doubled; }',
        ),
        isEmpty,
      );
      expect(
        names(
          'extension type X(List items) { int get sum => items.length; '
          'Object operator [](int i) => items[i]; }\n'
          'main() { return X([1]).sum; }',
        ),
        isEmpty,
      );
      // AND THE COVERAGE COST IS STATED RATHER THAN DISCOVERED: an extension
      // type is now an OPEN class, like a mixin or an extension, because it
      // `implements` types that can leave the unit. So a genuinely undefined
      // name inside one is NOT reported either — the fix bought correctness at
      // the price of reach, which is the trade every entry in `openClasses`
      // makes.
      const withBad =
          'extension type X(int value) { int get bad => nope; }\n'
          'main() { return X(1).bad; }';
      expect(names(withBad), isEmpty);
      expect(
        report(withBad).openClasses,
        contains('X'),
        reason:
            'and the count is visible in the data, which is what '
            '`openClasses` exists for',
      );
    });
  });
}
