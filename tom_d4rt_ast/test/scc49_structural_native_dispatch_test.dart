/// SCC49 mirror coverage for `tom_d4rt_ast`: structural dispatch for native
/// types no bridge explicitly claims.
///
/// WHY THIS EXISTS. `Environment.toBridgedClass` resolves a native object to a
/// bridge by *name*: exact `Type`, then the bridge's `name`, then its
/// `nativeNames` allowlist, then a suffix rule (`CastList` → `List`), then a
/// loose prefix fallback. The allowlist is the part that does not scale — every
/// private SDK implementation type has to be enumerated by hand, and the
/// `nativeNames` list on `Iterator` alone carries seventeen entries. Any SDK
/// version that introduces a new one, and any user library with its own private
/// iterator, falls off the end.
///
/// The allowlist is load-bearing for exactly two shapes, because the suffix rule
/// lives in the `else if (contains('<'))` arm of an
/// `if (name starts with '_') … else if …` chain:
///
///   1. **Private types** (`_CompactIterator`) — take the first arm, so the
///      suffix rule is unreachable regardless of genericity.
///   2. **Non-generic public types** (`Runes`, `RuneIterator`) — no `<`, so the
///      second arm is never entered.
///
/// Public *generic* implementation types (`WhereIterator`, `MappedListIterable`)
/// already resolve for free and appear in no allowlist.
///
/// SCRIPT-FREE BY NECESSITY, AND STRONGER FOR IT. `tom_d4rt_ast` has no parser,
/// so the `tom_d4rt` twin of this file (which drives scripts through
/// `D4rt.execute`) cannot be carried over verbatim. Asserting on
/// [Environment.toBridgedInstance] directly is the same trade SCC24 documents:
/// a script probe only distinguishes "threw" from "did not throw", whereas the
/// resolver can also be asked WHICH bridge answered — which is the property
/// F-SCC49-AST-2/3 are actually about.
///
/// THE SAFETY PROPERTY, which is what F-SCC49-AST-5/6 pin down: the structural
/// pass runs *last* — after every existing precise pass and after the loose
/// prefix fallback — so it fires only on objects that raise today.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
// `Environment.toBridgedInstance` is this file's entire subject, so the
// dependency is declared directly rather than leaning on a stdlib barrel that
// happens to re-export it today.
// ignore: unnecessary_import
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

// ---------------------------------------------------------------------------
// Fixtures.
//
// Deliberately named so that no fixture's type name *starts with* any
// registered bridge name. The loose prefix fallback runs before the new
// structural pass, so a shared prefix would have it claim the object and the
// test would prove nothing about the pass under test.
// ---------------------------------------------------------------------------

/// Native type behind the `Thing` bridge.
class NativeThing {}

/// Native type behind the `SpecialThing` bridge. `SpecialThing` ends with
/// `Thing`, so both bridge names are suffixes of the probe type names below —
/// that overlap is the point of F-SCC49-AST-2 and F-SCC49-AST-3.
class NativeSpecialThing {}

/// Private, non-generic. Reachable by neither arm of the PASS A `if/else if`.
class _HeavySpecialThing extends NativeSpecialThing {}

/// Public and generic, so its `runtimeType` carries a `<…>` and it *does* reach
/// the existing suffix rule — which resolved it with `firstWhereOrNull`, i.e.
/// by bridge registration order rather than by specificity.
class HeavySpecialThing<T> extends NativeSpecialThing {}

/// Private iterator over a fixed sequence. Stands in for `_CompactIterator` and
/// every other private SDK iterator, without depending on SDK internals that a
/// future Dart release may rename.
class _TallyIterator implements Iterator<int> {
  _TallyIterator(this._values);

  final List<int> _values;
  int _index = -1;

  @override
  int get current => _values[_index];

  @override
  bool moveNext() => ++_index < _values.length;
}

/// Public but non-generic — the `Runes` / `RuneIterator` shape.
class TallyCounterIterator implements Iterator<int> {
  TallyCounterIterator(this._values);

  final List<int> _values;
  int _index = -1;

  @override
  int get current => _values[_index];

  @override
  bool moveNext() => ++_index < _values.length;
}

/// An environment carrying the two overlapping fixture bridges only.
///
/// Registration order matters: `Thing` first, so a registration-order-driven
/// match resolves the probes to `Thing` and a specificity-driven one resolves
/// them to `SpecialThing`. That is what makes F-SCC49-AST-2/3 discriminating.
Environment _fixtureEnv() => Environment()
  ..defineBridge(BridgedClass(nativeType: NativeThing, name: 'Thing'))
  ..defineBridge(
    BridgedClass(nativeType: NativeSpecialThing, name: 'SpecialThing'),
  );

/// A realistic environment — the same core registration a script gets.
Environment _stdlibEnv() {
  final env = Environment();
  Stdlib(env).register();
  return env;
}

/// The bridge name [env] resolves [value] to, or a sentinel when nothing does.
///
/// The sentinel rather than a thrown matcher: a failure message that names the
/// bridge that answered is worth more than one that says an exception was
/// expected. Same helper shape as SCC24's `_resolvedBridgeName`.
String _resolved(Environment env, Object value) {
  try {
    final instance = env.toBridgedInstance(value);
    if (instance == null) return '<null instance>';
    return instance.bridgedClass.name;
  } on RuntimeD4rtException {
    return '<inert: no bridge>';
  }
}

void main() {
  group('SCC49: structural dispatch for unclaimed native types', () {
    test(
      'F-SCC49-AST-1: a private native type in no nativeNames list dispatches '
      'to the bridge whose name it ends with [2026-09-06]',
      () {
        expect(
          _resolved(_stdlibEnv(), _TallyIterator(<int>[7, 8])),
          'Iterator',
          reason:
              'THIS IS THE SCC49 ASSERTION. `_TallyIterator` appears in no '
              "`nativeNames` list, and its `_` prefix means it takes the first "
              'arm of the `if/else if` in toBridgedClass PASS A — the arm that '
              'does NOT contain the suffix rule. Every private SDK iterator is '
              'in the same position; the seventeen-entry allowlist on the '
              'Iterator bridge exists only because of this.',
        );
      },
    );

    test(
      'F-SCC49-AST-2: among competing suffix matches the most specific bridge '
      'wins (private name) [2026-09-06]',
      () {
        expect(
          _resolved(_fixtureEnv(), _HeavySpecialThing()),
          'SpecialThing',
          reason:
              '`_HeavySpecialThing` ends with both registered bridge names. '
              'Resolving it to `Thing` would mean the structural pass picks by '
              'registration order, which is the defect F-SCC49-AST-3 documents '
              'for the pre-existing public path.',
        );
      },
    );

    test('F-SCC49-AST-3: the pre-existing public suffix rule also picks the most '
        'specific bridge, not the first-registered one [2026-09-06]', () {
      expect(
        _resolved(_fixtureEnv(), HeavySpecialThing<int>()),
        'SpecialThing',
        reason:
            '`HeavySpecialThing<int>` DOES reach the existing suffix rule '
            '(public + generic), but that rule used `firstWhereOrNull`, so it '
            'returned whichever of `Thing` / `SpecialThing` was registered '
            'first. That is a latent nondeterminism in shipped behaviour — '
            'e.g. `_BodyBoxConstraints` suffix-matches both `Constraints` and '
            '`BoxConstraints` — not merely a property of the new pass.',
      );
    });

    test('F-SCC49-AST-4: a public non-generic type in no nativeNames list also '
        'dispatches structurally [2026-09-06]', () {
      expect(
        _resolved(_stdlibEnv(), TallyCounterIterator(<int>[9])),
        'Iterator',
        reason:
            'The `Runes` / `RuneIterator` shape: no `_` prefix so the first '
            'arm is skipped, no `<` so the second arm is skipped too. Both '
            'are in the Iterator bridge allowlist today purely because of '
            'this gap.',
      );
    });

    test(
      'F-SCC49-AST-5: a List still resolves to the List bridge, not to Iterable '
      '[2026-09-06]',
      () {
        expect(
          _resolved(_stdlibEnv(), <int>[1, 2, 3]),
          'List',
          reason:
              'The most-specific check from the DONE WHEN. `List` has a direct '
              '`Type` match in step 1 of toBridgedInstance. Resolving to '
              '`Iterable` would lose `add` / `[]` / `last`, and would mean the '
              'new pass is running too early in the chain.',
        );
      },
    );

    test('F-SCC49-AST-6: a lazy iterable still resolves to Iterable, not to a '
        'bridge its name happens to end with [2026-09-06]', () {
      expect(
        _resolved(_stdlibEnv(), <int>[1, 2, 3].map((e) => e * 2)),
        'Iterable',
        reason:
            'Guards the ordering from the other side. `MappedListIterable` '
            'is resolved by the *existing* precise passes; the structural '
            'pass must never get a chance to re-route it. This is the same '
            'object that once resolved to `Map` via the loose prefix '
            'fallback (see the toBridgedClass header).',
      );
    });
  });
}
