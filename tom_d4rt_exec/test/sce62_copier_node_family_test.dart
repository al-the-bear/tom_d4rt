// SCE62: the node families exec's suite had never driven through the
// analyzer-to-mirror copier.
//
// WHY THESE FILES AND NOT FOURTEEN PORTS. `_coveredElsewhere` names fourteen
// script suites resting on an `ast:` twin, and the obvious reading is that
// porting them closes the copier's gap. It does not: those files have no
// relationship to the copy surface, they are the ones that happen to have
// twins. What the copier's correctness depends on is which NODE TYPES it has
// transcribed, because a node whose fields are copied wrongly yields a mirror
// tree that interprets consistently and wrongly.
//
// So the selection here is measured rather than chosen.
// `tom_ast_generator/tool/census_copier.dart` reads a `dart test --coverage`
// hit-map and reports which `_convert*` methods never ran. Against this
// suite it reported 15 of 153 — and driving those 15 by hand found four
// failures, of two different kinds.
//
// ONE WAS A COPIER BUG, fixed in tom_ast_generator 0.1.8: `library foo;`
// crashed, because `LibraryIdentifier` had no dispatch arm and the
// placeholder failed a cast to `SIdentifier?`. The reference interpreter runs
// that source and returns 42.
//
// THREE WERE DGUC6, not defects: null-check, null-assert and parenthesized
// patterns fail against the PUBLISHED tom_d4rt_ast while its working tree
// already implements all three (interpreter_visitor.dart, `_matchAndBind`).
// They are pinned below rather than ported or skipped.
//
// TWO OF THE FIFTEEN ARE UNREACHABLE RATHER THAN UNTESTED, which is the
// distinction the census exists to draw and which no amount of reading the
// copier would have shown. `_convertConstructorReference` handles a node the
// analyzer only builds when it RESOLVES; the copier front end calls
// `parseString`, so one can never arrive. `_convertSwitchCase` handles the
// pre-patterns switch case, and at language 3.0+ `case 1:` parses as
// `SwitchPatternCase` — so that arm is dead for every script this interpreter
// will ever see. Both were verified by walking the parsed tree, not inferred.
// They are left in place rather than deleted: the mirror model still declares
// the corresponding node types, and removing a transcription is a larger
// decision than this todo carries.
//
// FOUR MORE ARE DELIBERATELY NOT COVERED HERE, and none of them can be:
// `_convertComment` is trivia with no runtime effect; `_convertNativeFunctionBody`
// is a VM-internal form no sandboxed script may use; `_convertPartDirective`
// and `_convertPartOfDirective` need a second file, and `execute(source:)`
// takes one. Recording them is the point — the census reports them every run,
// and a reader needs to know they were considered rather than missed.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source);

void main() {
  group('SCE62: node families the copier had never been driven on', () {
    test('F-SCE62-5: the families exec already handles still work '
        '[2026-09-21]', () {
      // Six of the fifteen. Each was never executed by any test in this
      // suite before this one, which is the only thing they have in common —
      // so a regression in any of them would previously have been invisible.
      expect(
        run('main() { var r = 0; switch (2) { case 1: r = 1; break; '
            'case 2: r = 2; break; default: r = 9; } return r; }'),
        2,
        reason: 'the old-style switch statement. NOTE: this does NOT drive '
            '_convertSwitchCase, and measuring said so — at language 3.0+ '
            'the analyzer parses `case 1:` as SwitchPatternCase, so '
            '_convertSwitchCase is unreachable rather than untested. The '
            'assertion is kept because the statement form is worth holding; '
            'the census entry is answered by the note, not by this line.',
      );
      expect(
        run('main() { var s = 0; for (var (a, b) in [(1, 2), (3, 4)]) '
            '{ s += a + b; } return s; }'),
        10,
        reason: 'ForEachPartsWithPattern',
      );
      expect(
        run('typedef int F(int x);\nmain() { F f = (int x) => x * 2; '
            'return f(21); }'),
        42,
        reason: 'FunctionTypeAlias — the pre-2.13 typedef form',
      );
      expect(
        run('class A { final int v; A(this.v); }\n'
            'main() { var f = A.new; return f(4).v; }'),
        4,
        reason: 'the `A.new` tear-off. Like the switch case above, this does '
            'NOT drive _convertConstructorReference: that node exists only '
            'in a RESOLVED tree, and the copier front end parses with '
            'parseString, so nothing in this pipeline can produce one.',
      );
      expect(
        run('T id<T>(T v) => v;\nmain() { var f = id<int>; return f(9); }'),
        9,
        reason: 'FunctionReference — generic function instantiation',
      );
      expect(
        run("import 'dart:math' if (dart.library.io) 'dart:math' as m;\n"
            'main() => m.max(1, 2);'),
        2,
        reason: 'Configuration and DottedName — the conditional-import '
            'branch sce49 taught the copier to carry, never driven since',
      );
    });

    test('F-SCE62-6: a library directive is interpreted [2026-09-21]', () {
      // The census`s one genuine copier bug. Before tom_ast_generator 0.1.8
      // this threw `type '_SUnknownNode' is not a subtype of type
      // 'SIdentifier?' in type cast` — valid Dart, accepted by the reference
      // interpreter, that exec could not run at all.
      expect(run('library foo;\nmain() => 42;'), 42);
      expect(
        run('library a.b.c;\nmain() => 7;'),
        7,
        reason: 'three components — the name is flattened to one identifier '
            'precisely so that this case is not special',
      );
    });

    test('F-SCE62-7: three pattern forms await the interpreter publish '
        '[2026-09-21]', () {
      // PUBLISH-PIN(sce162_aioc-four-unpublished-base-corpus-regressions-block-the-publish):
      // tom_d4rt_ast's working tree implements SNullCheckPattern,
      // SNullAssertPattern and SParenthesizedPattern in `_matchAndBind`; the
      // PUBLISHED 0.65.0 this package resolves does not, and sce162 forbids
      // the publish that would close the gap. The reference interpreter
      // answers all three correctly (5, 1, 3).
      //
      // This case asserts the DISAGREEMENT rather than the contract, which is
      // this repo's established form for a publish gap — F-SCD74-5 is the
      // same shape. When sce162 closes, F-SCD103-1 turns this file red and
      // names it; invert the assertion then, to the values above.
      for (final source in const [
        'main() { Object? o = 5; if (o case int? x?) return x; return 0; }',
        'main() { var (a!,) = (1,); return a; }',
        'main() { Object o = 3; return switch (o) { (int x) => x, _ => 0 }; }',
      ]) {
        expect(
          () => run(source),
          throwsA(
            predicate(
              (e) => e.toString().contains('not yet supported'),
              'an unimplemented-pattern error from the published interpreter',
            ),
          ),
          reason: source,
        );
      }
    });
  });
}
