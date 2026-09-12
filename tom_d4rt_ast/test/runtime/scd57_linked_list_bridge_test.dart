// SCD57 — the LinkedList / LinkedListEntry bridges, at registration level.
//
// SCD57 was filed because `collection.dart` registers fifteen bridge classes
// and these two were named in ZERO files of this tree — a registered,
// reachable bridge nothing exercised, the same shape scc16 found in the view
// family. Two of its premises have since moved, and this file is what is left
// after re-measuring them:
//
//   * NOT UNCOVERED ANY MORE. Three tests arrived between 2026-09-04 and
//     2026-09-12: `F-SCC51-5` (empty `first`/`last` raise StateError),
//     `F-SCC74-AST-1` (`insertAfter` orders the list), and the native-name
//     coverage map in `scc24_native_name_coverage_test.dart`. The behaviour is
//     covered; what none of them touches is the SURFACE.
//   * THE DIVERGENCE IT WAS WRITTEN TO PIN HAS RESOLVED. SCD57's second step
//     was to state, as an assertion, the drift `tom_d4rt_exec`'s
//     `_divergentBaseline` recorded in prose — "the working-tree LinkedList
//     bridge dropped `removeFirst` and gained `addAll` / `addFirst`" — so that
//     the next `tom_d4rt_ast` publish could be checked against it. That entry
//     is gone: the publish landed and the two trees agree.
//
// So this is the weaker of the two artifacts SCD57 described, and its own
// sequencing note says so: written before the publish it would have asserted
// what the publish was SUPPOSED to contain; written after, it records what
// shipped. It is still worth having — the surface is the half nothing asserts,
// and the three members the divergence was about are exactly the ones a
// careless "restore parity with tom_d4rt" edit would put back.
//
// WHY REGISTRATION LEVEL. This package cannot execute a script: it interprets
// pre-parsed `SAstNode` trees, and the parser lives in `tom_ast_generator`,
// which depends back on it. `tom_d4rt` carries the script-level equivalents.
// The shape here follows `stdlib_unmodifiable_views_test.dart`.
//
// EACH CASE HAS BEEN SEEN TO FAIL — see the matrix above F-SCD57-3, which is
// the one the DONE WHEN names.

import 'dart:collection';

import 'package:test/test.dart';
// `CollectionStdlib` is deliberately not re-exported from `runtime.dart`;
// `dart:collection` is registered lazily when a script imports it, and driving
// that path from a unit test would mean building a parsed AST module.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
// The tops of the hierarchy (`Iterable`) are `dart:core` bridges, and SCC51
// moved `first` / `last` up onto them — so a test that resolves by
// reachability needs CoreStdlib registered too.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

import '../bridge_reachability.dart';

/// The members `LinkedList` declares itself.
///
/// `removeFirst` is deliberately ABSENT and `addAll` / `addFirst` deliberately
/// PRESENT: that is the change `tom_d4rt_exec`'s drift guard recorded while the
/// two trees disagreed, and the reason this list is written out rather than
/// asserted with `containsAll`. A `containsAll` cannot say a member is gone.
const _linkedListMethods = <String>{
  'add',
  'addAll',
  'addFirst',
  'clear',
  'remove',
};

const _linkedListEntryMethods = <String>{
  'insertAfter',
  'insertBefore',
  'unlink',
};

void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
  });

  group('SCD57: LinkedList collection bridge', () {
    test('F-SCD57-1: is registered under the name LinkedList [2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedList');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, LinkedList);
      // Zero, not one. `LinkedList<E extends LinkedListEntry<E>>` has an
      // F-bounded parameter the bridge cannot represent, so it is registered
      // raw — which is why `scc51_shadowed_adapter_test.dart` needs its own
      // `BridgedLinkedListEntry` to build one at all.
      expect(bridge.typeParameterCount, 0);
      expect(
        bridge.isAssignable?.call(LinkedList<BridgedLinkedListEntry>()),
        isTrue,
      );
      // A sibling collection, to show the predicate discriminates rather than
      // accepting anything list-shaped.
      expect(bridge.isAssignable?.call(<int>[1]), isFalse);
    });

    test('F-SCD57-2: exposes the getters that read through [2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedList')!;
      final list = LinkedList<BridgedLinkedListEntry>()
        ..add(BridgedLinkedListEntry('a'))
        ..add(BridgedLinkedListEntry('b'));
      expect(
        bridge.getters.keys,
        containsAll(['length', 'isEmpty', 'isNotEmpty']),
      );
      expect(bridge.getters['length']!(null, list), 2);
      expect(bridge.getters['isEmpty']!(null, list), isFalse);
      expect(bridge.getters['isNotEmpty']!(null, list), isTrue);
      // `first` and `last` are NOT declared here — SCC51 deleted the local
      // copies so `Iterable`'s delegating adapters answer, which is what makes
      // an empty list raise the SDK's StateError (F-SCC51-5) instead of a
      // D4rt-specific exception. Resolved by reachability for that reason.
      expect(
        readReachable(env, 'LinkedList', list, 'first'),
        isA<BridgedLinkedListEntry>(),
      );
    });

    // EACH ROW OBSERVED, by editing the bridge and re-running:
    //
    //   | Injected fault                     | Fires                        |
    //   | ---------------------------------- | ---------------------------- |
    //   | `addFirst` removed from the bridge | F-SCD57-3, naming addFirst   |
    //   | `addAll` removed                   | F-SCD57-3, naming addAll     |
    //   | `removeFirst` restored             | F-SCD57-3, naming removeFirst|
    //
    // That is SCD57's DONE WHEN, and it is why this asserts SET EQUALITY
    // rather than `containsAll`: a `containsAll` cannot fail on a member that
    // came back, and "removeFirst is gone" is half of what the divergence was.
    test('F-SCD57-3: declares exactly the expected mutating surface '
        '[2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedList')!;
      expect(
        bridge.methods.keys.toSet(),
        equals(_linkedListMethods),
        reason:
            'The declared surface moved. `removeFirst` must stay absent and '
            '`addAll` / `addFirst` present — that is the shape tom_d4rt_ast '
            'settled on, and tom_d4rt_exec pinned the disagreement in its '
            '_divergentBaseline until the publish that resolved it. If this '
            'is a deliberate change, mirror it in tom_d4rt and update this '
            'set in the same commit.',
      );
    });
  });

  group('SCD57: LinkedListEntry collection bridge', () {
    test('F-SCD57-4: is registered under the name LinkedListEntry '
        '[2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedListEntry');
      expect(bridge, isNotNull);
      // The SDK's own `LinkedListEntry` is abstract and F-bounded, so the
      // bridge names the concrete stand-in this package ships. A script never
      // sees that name — it sees `LinkedListEntry`.
      expect(bridge!.nativeType, BridgedLinkedListEntry);
      expect(bridge.typeParameterCount, 0);
      expect(bridge.isAssignable?.call(BridgedLinkedListEntry('a')), isTrue);
      expect(bridge.isAssignable?.call('a'), isFalse);
    });

    test('F-SCD57-5: declares exactly the expected surface [2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedListEntry')!;
      expect(bridge.methods.keys.toSet(), equals(_linkedListEntryMethods));
      expect(
        bridge.getters.keys,
        containsAll(['list', 'next', 'previous', 'value']),
      );
    });

    test('F-SCD57-6: the getters read through to the native entry '
        '[2026-09-12]', () {
      final bridge = env.findBridgedClassByName('LinkedListEntry')!;
      final first = BridgedLinkedListEntry('a');
      final second = BridgedLinkedListEntry('b');
      LinkedList<BridgedLinkedListEntry>()
        ..add(first)
        ..add(second);
      expect(bridge.getters['value']!(null, first), 'a');
      expect(bridge.getters['next']!(null, first), same(second));
      expect(bridge.getters['previous']!(null, second), same(first));
      // An attached entry knows its list; the getter must hand back the native
      // one rather than null, which is what `unlink` then operates on.
      expect(bridge.getters['list']!(null, first), isNotNull);
    });
  });
}
