// SCE109 — a runtime condition raises the SDK's Error, so `on RangeError`
// catches.
//
// Two adapters reported a runtime condition of the SCRIPT — an index out of
// range, no element matching a test — with an interpreter exception instead of
// the SDK's Error. `RuntimeD4rtException` is not an `Error` at all, so the
// idiomatic handler was skipped and the script fell through to a bare `catch`,
// or to nothing. A dead recovery path, not a cosmetic message.
//
// EVERY CASE HERE IS WRITTEN AS `try { … } on <SdkError> { }`, never as a
// `runtimeType` assertion. That is the todo's instruction and it is load-
// bearing: a `runtimeType` check passes against a subclass that still fails to
// be caught, and being caught is the whole property.
//
// THE TWO HAD DIFFERENT CAUSES, and only one was the "hand-written guard" the
// defect looked like from outside.
//
//   * `firstWhere` was a hand-rolled loop whose no-match branch threw
//     `RuntimeD4rtException('No element found matching the test condition')` —
//     an invented contract. Its neighbours `lastWhere` and `singleWhere`
//     delegate to the native call and were already correct, which is what made
//     the loop's stated reason ("éviter les problèmes de types génériques")
//     checkable: all three wrap the callback identically.
//
//   * `elementAt` had no guard at all. SCB28 added a heuristic at the DISPATCH
//     boundary: a bridged call that throws `RangeError` is assumed to be an
//     adapter that read past the end of `positionalArgs`, and the error is
//     restated as an arity failure. `[1].elementAt(5)` is one positional
//     argument on a one-element list, so the reported range 0..0 matches the
//     argument list's 0..0 exactly and the heuristic fires on the script's own
//     error.
//
// THE HEURISTIC CANNOT BE MADE EXACT, and that is measured rather than assumed.
// `[1].elementAt(5)` and an adapter's `positionalArgs[5]` produce byte-identical
// errors — `name: length`, `start: 0`, `end: 0`, `invalidValue: 5`, and neither
// is an `IndexError`, so there is no `indexable` back-reference to compare. Its
// own doc had judged this acceptable because misattribution "only ever changes
// the wording of an error that was already being thrown"; the wording was not
// the only thing that changed.
//
// So the fix makes being wrong cheap instead of pretending to be right: the
// detection and the arity message stay, the original error text leads, and the
// TYPE is preserved. `on RangeError` now catches under either reading.
//
// ABLATED: reverting the nine `throw RangeError(arityError)` sites to
// `RuntimeD4rtException` fails F-SCE109-1; restoring the hand-rolled
// `firstWhere` loop fails F-SCE109-2. F-SCE109-4 and -5 pass on both, which is
// why they are here — they are the rails that stop the next version of this
// from being "make every stdlib failure a StateError".

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [body] as the body of `main`.
Object? runBody(String body) =>
    D4rt().execute(source: 'main() {\n$body\n}', name: 'main');

/// `'caught'` when [expression] raises something `on $error` catches,
/// `'fell through'` when it raises something else, `'no throw'` otherwise.
///
/// The catch is asked from INSIDE the script, because that is where the
/// property lives: a host-side matcher sees the exception object and would
/// report a type that the interpreted `on` clause still fails to select.
String caught(String setup, String expression, String error) =>
    runBody(
          '$setup\n'
          'try { $expression; } on $error { return "caught"; } '
          'catch (e) { return "fell through"; }\n'
          'return "no throw";',
        )
        as String;

void main() {
  group('SCE109: a runtime condition raises the SDK Error', () {
    test('F-SCE109-1: an out-of-range elementAt is caught by `on RangeError` '
        '[2026-09-22] (PASS)', () {
      expect(caught('var l = [1];', 'l.elementAt(5)', 'RangeError'), 'caught');
      // `on Error` too: the defect made it not an Error at all, which is the
      // sharper statement and the one a `runtimeType` check would miss.
      expect(caught('var l = [1];', 'l.elementAt(5)', 'Error'), 'caught');
    });

    test('F-SCE109-2: a firstWhere with no match is caught by `on StateError` '
        '[2026-09-22] (PASS)', () {
      expect(
        caught('var l = [1];', 'l.firstWhere((e) => e == 9)', 'StateError'),
        'caught',
      );
      expect(
        caught('var l = [1];', 'l.firstWhere((e) => e == 9)', 'Error'),
        'caught',
      );
    });

    test('F-SCE109-3: the neighbours that were already right stay right '
        '[2026-09-22] (PASS)', () {
      // The population the probe covered. They are here because "three
      // adapters" was the shape of the defect from outside, and a fix aimed at
      // three adapters could have moved one of these.
      const rangeCases = <String, String>{
        'l[5]': 'var l = [1];',
        'l.removeLast()': 'var l = [];',
        'l.sublist(0, 9)': 'var l = [1];',
        'l.elementAt(-1)': 'var l = [1];',
        "s.substring(0, 9)": "var s = 'ab';",
      };
      rangeCases.forEach((expression, setup) {
        expect(
          caught(setup, expression, 'RangeError'),
          'caught',
          reason: expression,
        );
      });
      const stateCases = <String, String>{
        'l.first': 'var l = [];',
        'l.last': 'var l = [];',
        'l.single': 'var l = [];',
        'l.reduce((a, b) => a)': 'var l = [];',
        'l.lastWhere((e) => e == 9)': 'var l = [1];',
        'l.singleWhere((e) => e == 9)': 'var l = [1];',
        'm.entries.first': 'var m = {};',
        'm.keys.first': 'var m = {};',
        'm.values.first': 'var m = {};',
      };
      stateCases.forEach((expression, setup) {
        expect(
          caught(setup, expression, 'StateError'),
          'caught',
          reason: expression,
        );
      });
    });

    // ---- the rails ---------------------------------------------------------

    test('F-SCE109-4 (control): a correct call still returns [2026-09-22] '
        '(PASS)', () {
      // Everything above is a throw that must be catchable, so "throw
      // StateError from everything" satisfies all of it.
      expect(runBody('var l = [1, 2]; return l.elementAt(1);'), 2);
      expect(runBody('var l = [1]; return l.firstWhere((e) => e == 1);'), 1);
      expect(
        runBody(
          'var l = [1]; return l.firstWhere((e) => e == 9, '
          'orElse: () => -1);',
        ),
        -1,
      );
    });

    test('F-SCE109-6: `orElse` works on a TYPED list, in all three of the '
        '*Where family [2026-09-22] (PASS)', () {
      // A THIRD defect, latent before this work and found by it. The native
      // `orElse` is typed `() => E`, so an interpreted callback returning
      // `Object?` is rejected on any list whose element type is not `Object?`:
      //
      //   E.values.firstWhere(…, orElse: () => E.a)
      //   → type '() => Object?' is not a subtype of type
      //     '(() => InterpretedEnumValue)?' of 'orElse'
      //
      // `firstWhere` avoided it by hand-rolling the loop — which is exactly
      // what its comment claimed ("éviter les problèmes de types génériques"),
      // so the comment was RIGHT and the first version of this fix, which
      // deleted the loop and delegated, was wrong. `lastWhere` and
      // `singleWhere` had delegated all along and carried the same defect
      // unmeasured, because nothing passed `orElse` to them on a typed list.
      //
      // All three now delegate through `cast<Object?>()`, whose element type
      // makes the callback fit while leaving the no-match behaviour to the SDK.
      for (final method in ['firstWhere', 'lastWhere', 'singleWhere']) {
        expect(
          D4rt().execute(
            source:
                'enum E { a, b }\n'
                'main() { var v = E.values;\n'
                'return v.$method((e) => e.name == "z", '
                'orElse: () => E.a).name; }',
            name: 'main',
          ),
          'a',
          reason: method,
        );
      }
    });

    test('F-SCE109-5 (control): a real arity failure still says so '
        '[2026-09-22] (PASS)', () {
      // SCB28's purpose survives the type change. The message is what carries
      // it, and it now leads with the native error because the dispatcher
      // cannot tell the two readings apart — so the arity reading is offered
      // as a hypothesis rather than asserted.
      final message =
          runBody(
                'var l = [1];\n'
                'try { l.elementAt(5); } catch (e) { return e.toString(); }',
              )
              as String;
      expect(message, contains('RangeError'));
      expect(message, contains('if this call passed too few arguments'));
      expect(message, contains('List.elementAt'));
    });
  });
}
