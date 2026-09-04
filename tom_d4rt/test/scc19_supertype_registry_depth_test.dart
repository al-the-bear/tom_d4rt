// SCC19: `BridgedClass.isSubtypeOf` hand-rolled a walk over the supertype
// registry that checked the direct supertypes and ONE further hop, then
// stopped — while `transitiveSupertypeNames`, a correct BFS with a `seen` set,
// sat unused in the same file and served the MEMBER walk. So a bridge three
// levels deep resolved its inherited members correctly and answered `false` to
// `is` against its own root.
//
// WHY THE CORPUS COULD NOT SEE IT. Every hierarchy block in the stdlib was
// written with its transitive closure spelled out by hand — `'JsonEncoder':
// ['Converter', 'StreamTransformerBase', 'StreamTransformer']` where the SDK
// declares a single `implements Converter`. With the closure flattened, every
// answer comes from the DIRECT edge and the walk's depth is never exercised.
// The flattening was a workaround for this defect, documented as such in both
// blocks' class docs; the fix is what makes it unnecessary.
//
// SO DEPTH IS TESTED DIRECTLY, on a synthetic chain registered under names
// nothing else uses. A test built on the stdlib hierarchies would pass either
// way, because those hierarchies are declared so that it does. `F-SCC19-6`
// and `F-SCC19-7` then check the real blocks from the other side: now that
// they declare SINGLE-HOP edges only, the deep answers can only come from the
// transitive walk.
//
// THE REGISTRY IS PROCESS-GLOBAL AND ADDITIVE — there is no unregister. Every
// synthetic name below is prefixed `Zscc19` so it cannot collide with a real
// bridge or with another test's fixture.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

class _N0 {}

class _N1 {}

class _N2 {}

class _N3 {}

class _N4 {}

class _NUnrelated {}

BridgedClass _bc(String name, Type nativeType) =>
    BridgedClass(nativeType: nativeType, name: name);

dynamic execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source});
}

void main() {
  // A single chain, one edge per link, exactly as someone would declare it
  // from the SDK's own relationships: L0 -> L1 -> L2 -> L3 -> L4.
  final l0 = _bc('Zscc19L0', _N0);
  final l1 = _bc('Zscc19L1', _N1);
  final l2 = _bc('Zscc19L2', _N2);
  final l3 = _bc('Zscc19L3', _N3);
  final l4 = _bc('Zscc19L4', _N4);
  final unrelated = _bc('Zscc19Unrelated', _NUnrelated);

  setUpAll(() {
    BridgedClass.registerSupertypes(const {
      'Zscc19L0': ['Zscc19L1'],
      'Zscc19L1': ['Zscc19L2'],
      'Zscc19L2': ['Zscc19L3'],
      'Zscc19L3': ['Zscc19L4'],
    });
  });

  group('SCC19: the registry walk follows the whole chain', () {
    test(
        'F-SCC19-1: one and two hops still resolve — the depths that already '
        'worked [2026-09-04] (PASS)', () {
      expect(l0.isSubtypeOf(l1), isTrue, reason: 'direct supertype');
      expect(l0.isSubtypeOf(l2), isTrue, reason: 'one hop past direct');
    });

    test(
        'F-SCC19-2: THREE hops resolve — the first depth the old walk could '
        'not reach [2026-09-04] (PASS)', () {
      expect(l0.isSubtypeOf(l3), isTrue);
    });

    test(
        'F-SCC19-3: four hops resolve, so the walk has no depth limit at all '
        'rather than a larger one [2026-09-04] (PASS)', () {
      expect(l0.isSubtypeOf(l4), isTrue);
    });

    test(
        'F-SCC19-4: the walk does not over-match — an unregistered name is '
        'still not a supertype [2026-09-04] (PASS)', () {
      expect(l0.isSubtypeOf(unrelated), isFalse);
    });

    test(
        'F-SCC19-5: the relation stays directional — a supertype is not a '
        'subtype of its own subtype [2026-09-04] (PASS)', () {
      expect(l4.isSubtypeOf(l0), isFalse);
      expect(l2.isSubtypeOf(l0), isFalse);
    });

    test(
        'F-SCC19-6: a cycle in the registry terminates instead of hanging — '
        'the registry is caller-populated and nothing prevents one '
        '[2026-09-04] (PASS)', () {
      BridgedClass.registerSupertypes(const {
        'Zscc19CycleA': ['Zscc19CycleB'],
        'Zscc19CycleB': ['Zscc19CycleA'],
      });
      final a = _bc('Zscc19CycleA', _N0);
      final b = _bc('Zscc19CycleB', _N1);
      expect(a.isSubtypeOf(b), isTrue);
      expect(b.isSubtypeOf(a), isTrue);
      expect(a.isSubtypeOf(unrelated), isFalse,
          reason: 'the cycle must terminate on a MISS, which is the case that '
              'loops forever without a seen set');
    });
  });

  group('SCC19: the stdlib blocks now declare single-hop edges only', () {
    test(
        'F-SCC19-7: `dart:convert` answers at three hops from single-hop '
        'edges — JsonEncoder -> Converter -> StreamTransformerBase -> '
        'StreamTransformer [2026-09-04] (PASS)', () {
      expect(
          execute('''
            import 'dart:convert';
            import 'dart:async';
            main() {
              var e = JsonEncoder();
              return [
                e is Converter,
                e is StreamTransformerBase,
                e is StreamTransformer,
              ];
            }
          '''),
          [true, true, true]);
    });

    test(
        'F-SCC19-8: `dart:collection` answers at two hops from single-hop '
        'edges, for a set, a list view and a queue [2026-09-04] (PASS)', () {
      expect(
          execute('''
            import 'dart:collection';
            main() => [
              HashSet() is Iterable,
              UnmodifiableListView([1]) is Iterable,
              ListQueue() is Iterable,
            ];
          '''),
          [true, true, true]);
    });

    test(
        'F-SCC19-9: an encoding still reaches Codec through Encoding, and a '
        'non-encoding codec is still not an Encoding [2026-09-04] (PASS)', () {
      expect(
          execute('''
            import 'dart:convert';
            main() => [utf8 is Encoding, utf8 is Codec, json is Encoding];
          '''),
          [true, true, false]);
    });
  });
}
