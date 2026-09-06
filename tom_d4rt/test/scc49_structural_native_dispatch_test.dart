/// SCC49: structural dispatch for native types no bridge explicitly claims.
///
/// WHY THIS EXISTS. `Environment.toBridgedClass` resolves a native object to a
/// bridge by *name*: exact `Type`, then the bridge's `name`, then its
/// `nativeNames` allowlist, then a suffix rule (`CastList` → `List`), then a
/// loose prefix fallback. The allowlist is the part that does not scale — every
/// private SDK implementation type has to be enumerated by hand, and the
/// `nativeNames` list on `Iterator` alone carries seventeen entries
/// (`_HashSetIterator`, `_CompactIterator`, `_SplayTreeKeyIterator`, …). Any
/// SDK version that introduces a new one, and any user library with its own
/// private iterator, falls off the end and raises
/// `Cannot bridge native object: No registered bridged class found`.
///
/// WHAT WAS ACTUALLY MEASURED (2026-09-06). The premise is narrower than it
/// looks. A census of ~40 lazy-collection `runtimeType`s showed that *public
/// generic* implementation types already resolve for free — `WhereIterator`,
/// `MappedListIterable`, `ReversedListIterable`, `EmptyIterable` and friends
/// are matched by the suffix rule and appear in no allowlist. The allowlist is
/// load-bearing for exactly two shapes:
///
///   1. **Private types** (`_CompactIterator`, `_SplayTreeKeyIterator`). The
///      suffix rule lives in the `else if (contains('<'))` arm of an
///      `if (name starts with '_') … else if …` chain, so it is *unreachable*
///      for any `_`-prefixed name regardless of whether the name is generic.
///   2. **Non-generic public types** (`Runes`, `RuneIterator`). No `<`, so the
///      same arm is never entered.
///
/// So the fix is not "add an `is` test"; it is to make the suffix rule reachable
/// for those two shapes.
///
/// WHY NOT WIDEN `isAssignable`. The obvious alternative — give the `Iterable`
/// and `Iterator` bridges an `isAssignable` so `toBridgedInstance` claims their
/// subtypes structurally — is wrong, and `collection_hierarchy.dart` says so in
/// its own header. `isAssignable` participates in step 2 of
/// `toBridgedInstance`, which runs *before* the name-based step 3, so a
/// supertype claiming assignability would steal dispatch from correct name
/// matches (`Runes`, `StringCharacters implements Characters`). Every
/// hand-written stdlib bridge carries `hierarchyDepth == 0`, so
/// `_filterToMostSpecific` cannot arbitrate between them.
///
/// THE SAFETY PROPERTY, which is what F-SCC49-1 pins down: the new structural
/// pass runs *last* — after every existing precise pass and after the loose
/// prefix fallback — so it fires only on objects that raise today. A pass that
/// only fires where an exception is currently thrown cannot regress a working
/// case. F-SCC49-5/6 are the guards that this stayed true.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const String _libUri = 'package:scc49/fixtures.dart';

// ---------------------------------------------------------------------------
// Fixtures.
//
// Deliberately named so that no fixture's type name *starts with* any
// registered bridge name. PASS B (the loose prefix fallback) runs before the
// new structural pass, so a shared prefix would have PASS B claim the object
// and the test would prove nothing about the pass under test.
// ---------------------------------------------------------------------------

/// Static holder for the fixture factories. Never instantiated.
class FixtureFactory {}

/// Native type behind the `Thing` bridge.
class NativeThing {}

/// Native type behind the `SpecialThing` bridge. `SpecialThing` ends with
/// `Thing`, so both bridge names are suffixes of the probe type names below —
/// that overlap is the point of F-SCC49-2 and F-SCC49-3.
class NativeSpecialThing {}

/// Private, non-generic. Reachable by neither arm of the PASS A `if/else if`.
class _HeavySpecialThing extends NativeSpecialThing {}

/// Public and generic, so its `runtimeType` carries a `<…>` and it *does* reach
/// the existing suffix rule — which resolves it with `firstWhereOrNull`, i.e.
/// by bridge registration order rather than by specificity.
class HeavySpecialThing<T> extends NativeSpecialThing {}

/// Private iterator over a fixed sequence. Stands in for `_CompactIterator`
/// and every other private SDK iterator, without depending on SDK internals
/// that a future Dart release may rename.
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

D4rt _interpreter() {
  final interpreter = D4rt();

  // Registration order matters: `Thing` first, so a registration-order-driven
  // match resolves the probes to `Thing` and a specificity-driven one resolves
  // them to `SpecialThing`. That is what makes F-SCC49-2/3 discriminating.
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: NativeThing,
      name: 'Thing',
      // Returns a constant rather than casting the target: the whole point is
      // that the target may be an unrelated native type that was mis-routed
      // here, and a cast would fail with a confusing message instead of
      // reporting which bridge answered.
      getters: {'bridgeName': (visitor, target) => 'Thing'},
    ),
    _libUri,
    sourceUri: _libUri,
  );

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: NativeSpecialThing,
      name: 'SpecialThing',
      getters: {'bridgeName': (visitor, target) => 'SpecialThing'},
    ),
    _libUri,
    sourceUri: _libUri,
  );

  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: FixtureFactory,
      name: 'Fixtures',
      staticMethods: {
        'privateSpecial': (visitor, positional, named, typeArgs) =>
            _HeavySpecialThing(),
        'genericSpecial': (visitor, positional, named, typeArgs) =>
            HeavySpecialThing<int>(),
        'privateIterator': (visitor, positional, named, typeArgs) =>
            _TallyIterator(<int>[7, 8]),
        'publicIterator': (visitor, positional, named, typeArgs) =>
            TallyCounterIterator(<int>[9]),
      },
    ),
    _libUri,
    sourceUri: _libUri,
  );

  return interpreter;
}

// `execute` returns a `FutureOr`, and a non-async script `main` makes it
// return synchronously — so this has to be `async` rather than a plain
// forwarding `return`.
Future<Object?> _run(String body) async {
  return _interpreter().execute(
    source:
        '''
import '$_libUri';

dynamic main() {
$body
}
''',
  );
}

void main() {
  group('SCC49: structural dispatch for unclaimed native types', () {
    test(
      'F-SCC49-1: a private native type in no nativeNames list dispatches to '
      'the bridge whose name it ends with',
      () async {
        expect(
          await _run('''
  var it = Fixtures.privateIterator();
  var seen = [];
  while (it.moveNext()) { seen.add(it.current); }
  return seen;
'''),
          equals([7, 8]),
          reason:
              'THIS IS THE SCC49 ASSERTION. `_TallyIterator` appears in no '
              "`nativeNames` list, and its `_` prefix means it takes the first "
              'arm of the `if/else if` in toBridgedClass PASS A — the arm that '
              'does NOT contain the suffix rule. Measured before the fix on '
              "2026-09-06: \"Undefined property or method 'moveNext' on "
              '_TallyIterator" — note that is NOT the "Cannot bridge native '
              'object" text at the end of toBridgedClass. The resolution '
              'failure is absorbed upstream and the object surfaces as a raw '
              'native with no members, so the diagnostic never names the real '
              'cause. Every private SDK iterator is in the same position; the '
              'seventeen-entry allowlist on the Iterator bridge exists only '
              'because of this.',
        );
      },
    );

    test(
      'F-SCC49-2: among competing suffix matches the most specific bridge wins '
      '(private name)',
      () async {
        expect(
          await _run('  return Fixtures.privateSpecial().bridgeName;'),
          equals('SpecialThing'),
          reason:
              '`_HeavySpecialThing` ends with both registered bridge names. '
              'Resolving it to `Thing` would mean the structural pass picks by '
              'registration order, which is the defect F-SCC49-3 documents for '
              'the pre-existing public path.',
        );
      },
    );

    test('F-SCC49-3: the pre-existing public suffix rule also picks the most '
        'specific bridge, not the first-registered one', () async {
      expect(
        await _run('  return Fixtures.genericSpecial().bridgeName;'),
        equals('SpecialThing'),
        reason:
            '`HeavySpecialThing<int>` DOES reach the existing suffix rule '
            '(public + generic), but that rule uses `firstWhereOrNull`, so it '
            'returns whichever of `Thing` / `SpecialThing` was registered '
            'first. That is a latent nondeterminism in shipped behaviour — '
            'e.g. `_BodyBoxConstraints` suffix-matches both `Constraints` and '
            '`BoxConstraints` — not merely a property of the new pass.',
      );
    });

    test('F-SCC49-4: a public non-generic type in no nativeNames list also '
        'dispatches structurally', () async {
      expect(
        await _run('''
  var it = Fixtures.publicIterator();
  it.moveNext();
  return it.current;
'''),
        equals(9),
        reason:
            'The `Runes` / `RuneIterator` shape: no `_` prefix so the first '
            'arm is skipped, no `<` so the second arm is skipped too. Both '
            'are in the Iterator bridge allowlist today purely because of '
            'this gap.',
      );
    });

    test(
      'F-SCC49-5: a List still resolves to the List bridge, not to Iterable',
      () async {
        expect(
          await _run('''
  var l = [1, 2, 3];
  l.add(4);
  return [l.length, l[0], l.last];
'''),
          equals([4, 1, 4]),
          reason:
              'The most-specific check from the DONE WHEN. `List` has a direct '
              '`Type` match in step 1 of toBridgedInstance, and `add`/`[]`/'
              '`last` exist only on the List bridge — resolving to `Iterable` '
              'would fail on `add`. If this breaks, the new pass is running '
              'too early in the chain.',
        );
      },
    );

    test(
      'F-SCC49-6: a lazy iterable still resolves to Iterable, not to a bridge '
      'its name happens to end with',
      () async {
        expect(
          await _run('''
  return [1, 2, 3].map((e) => e * 2).toList();
'''),
          equals([2, 4, 6]),
          reason:
              'Guards the ordering from the other side. `MappedListIterable` '
              'is resolved by the *existing* precise passes; the structural '
              'pass must never get a chance to re-route it. This is the same '
              'object that once resolved to `Map` via the loose prefix '
              'fallback (see the toBridgedClass header).',
        );
      },
    );
  });
}
