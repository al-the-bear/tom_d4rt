import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart' show UndefinedNameD4rtException;

import 'interpreter_test.dart' show execute;

/// SCD96 — the host receives the error the SCRIPT raised, not a carrier.
///
/// WHAT THE TODO SAID, AND WHAT WAS ACTUALLY THERE
///
/// The todo was written against a measurement that `D4rtRunner.executeBundle`
/// leaked `InternalInterpreterD4rtException`. That premise had gone stale —
/// `throwAsHostFacingError` has unwrapped that carrier since SCC27, and
/// `executeBundle` has routed through it. Re-measuring found a DIFFERENT leak
/// at the same boundary, one peel further in:
///
/// ```dart
/// // script:            throw FormatException('boom');
/// // host received:     BridgedInstance<Object>   ← `on FormatException` missed
/// ```
///
/// A *bridged* exception holds its native object one level inside the carrier.
/// `throwAsHostFacingError` peeled the carrier and stopped, so the host got the
/// `BridgedInstance` shell — which it cannot name in a `catch`, and which is
/// exactly the harm the todo describes with a different type in the slot.
///
/// **`unwrapScriptError` has documented this pair since SCD73**: "Two peels,
/// not one … a host that peeled only the first would get a `BridgedInstance` it
/// cannot `catch` on." The zone-callback route already did both peels, which is
/// why the ASYNC path was correct and the synchronous one was not — the two
/// halves of one boundary disagreeing, which is the shape SCC27 was written to
/// remove.
///
/// THE CHOICE THE TODO PUT, AND WHY (1)
///
/// (1) teach the shared helper, or (2) unwrap only at the leaking entry point.
/// The todo says prefer (1) if the sweep is clean "because the asymmetry is the
/// defect and (2) only relocates it". It is clean: both full suites pass
/// unchanged (tom_d4rt 3716, tom_d4rt_ast 810 + the standing sce55), so the fix
/// is one line in `throwAsHostFacingError`, mirrored, and every present and
/// future caller of that boundary gets it.
///
/// WHAT IS DELIBERATELY NOT UNWRAPPED
///
///   - A script-declared exception class arrives as `InterpretedInstance`
///     (F-SCD96-5). There is no native object to peel to, and the host cannot
///     name a type the script invented — F-SCD73-4 pins that it at least
///     renders its own `toString()`.
///   - A thrown non-error value arrives as itself (F-SCD96-6). Real Dart lets a
///     script `throw 'plain'`, and the host gets the String.
///   - `UndefinedNameD4rtException` arrives as ITSELF (F-SCD96-4). It is
///     d4rt's own signal with no native counterpart, and SCC31 exists to make
///     it reach the host rather than be swallowed — peeling it would undo that.
void main() {
  group('SCD96: an escaping error reaches the host as the script raised it', () {
    test('F-SCD96-1: a bridged exception arrives as its native type '
        '[2026-09-14]', () {
      // The defect: this used to be a `BridgedInstance<Object>`, so the
      // `isA<FormatException>` below — and any `on FormatException` a host
      // wrote around `execute` — did not match.
      expect(
        () => execute("main() { throw FormatException('boom'); }"),
        throwsA(
          isA<FormatException>().having((e) => e.message, 'message', 'boom'),
        ),
      );
    });

    test('F-SCD96-2: the same holds for other bridged error types '
        '[2026-09-14]', () {
      // One type could be a special case; two say the peel is general.
      expect(
        () => execute("main() { throw ArgumentError('bad'); }"),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => execute("main() { throw StateError('nope'); }"),
        throwsA(isA<StateError>()),
      );
    });

    test('F-SCD96-3: an error raised by an OPERATION was already correct '
        '[2026-09-14]', () {
      // It never went through a BridgedInstance — a native callee throws a
      // native value. Pinned because it is what made the defect hard to see:
      // half the shapes at this boundary were already right.
      expect(
        () => execute('main() { var l = <int>[]; return l.first; }'),
        throwsA(isA<StateError>()),
      );
    });

    test('F-SCD96-4: an undefined name still arrives as its own signal '
        '[2026-09-14]', () {
      // SCC31 made this type reach the host rather than be swallowed. It has
      // no native counterpart to peel to, and peeling it would undo SCC31.
      expect(
        () => execute('main() { return totallyUndefinedThing; }'),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test('F-SCD96-5: a script-declared exception arrives as itself '
        '[2026-09-14]', () {
      // No native object to peel to. The host cannot name a type the script
      // invented, so what it gets is the interpreted instance — and F-SCD73-4
      // pins that it renders its own `toString()`.
      expect(
        () => execute('''
          class MyEx implements Exception {
            String toString() => 'MyEx!';
          }
          main() { throw MyEx(); }
        '''),
        throwsA(
          isA<Object>().having((e) => e.toString(), 'toString()', 'MyEx!'),
        ),
      );
    });

    test(
      'F-SCD96-6: a thrown non-error value arrives as itself [2026-09-14]',
      () {
        // Real Dart permits `throw 'plain'`, and the boundary must not turn it
        // into a diagnostic about an unexpected error.
        expect(() => execute("main() { throw 'plain'; }"), throwsA('plain'));
      },
    );

    test('F-SCD96-7: a host `catch` on the script\'s type now matches '
        '[2026-09-14]', () {
      // The property the whole todo is about, written the way an embedder
      // would: a real `on` clause around the call, not an `isA` matcher.
      String caught() {
        try {
          execute("main() { throw FormatException('boom'); }");
          return 'no throw';
        } on FormatException {
          return 'on FormatException';
        } catch (e) {
          return 'bare catch: ${e.runtimeType}';
        }
      }

      expect(caught(), 'on FormatException');
    });
  });
}
