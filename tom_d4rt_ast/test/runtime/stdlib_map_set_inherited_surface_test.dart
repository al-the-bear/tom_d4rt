import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// Same reason as the SC7 mirror: the stdlib registrars are not re-exported from
// `runtime.dart`, and driving the lazy `dart:collection` registration through
// `ast_module_loader.dart` would mean building a parsed AST module.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

/// SCB17 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level, for the reason the SC5/SC6/SC7
/// mirrors give: `tom_d4rt_exec` — the only runner that could execute a script
/// against *this* tree — resolves `tom_d4rt_ast` from pub.dev rather than by
/// path, so it cannot see unpublished local edits. The script-level equivalents
/// are `tom_d4rt/test/scb17_map_set_inherited_surface_test.dart`.
///
/// SCB17's three findings are all decisions visible without an interpreter:
/// which native implementation names route to the `Iterator` and `Iterable`
/// bridges, and whether `HashMap` / `LinkedHashMap` still shadow the inherited
/// `addEntries` with a local copy that cannot unwrap a bridged `MapEntry`.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
  });

  BridgedClass bridgeNamed(String name) => env.findBridgedClassByName(name)!;

  /// The runtime type name the SDK actually produces, minus type arguments.
  /// Asserting against these rather than against string literals is the point:
  /// a hand-maintained allowlist is only correct relative to what the SDK
  /// returns, so the test asks the SDK.
  String nameOf(Object? o) => o.runtimeType.toString().split('<').first;

  group('SCB17: iterator and iterable implementation names', () {
    test('F-SCB17-AST-1: every bridged collection\'s iterator routes to the '
        'Iterator bridge [2026-07-28]', () {
      final iterator = bridgeNamed('Iterator');
      final receivers = <String, Iterable<Object?>>{
        'List': <int>[1],
        'set literal': <int>{1},
        'HashSet': HashSet<int>()..add(1),
        // The explicit constructor rather than a literal on purpose: the point
        // is to name the class whose iterator must be claimed.
        // ignore: prefer_collection_literals
        'LinkedHashSet': LinkedHashSet<int>()..add(1),
        'SplayTreeSet': SplayTreeSet<int>()..add(1),
        'UnmodifiableSetView': UnmodifiableSetView<int>(<int>{1}),
        'ListQueue': ListQueue<int>()..add(1),
        'DoubleLinkedQueue': DoubleLinkedQueue<int>()..add(1),
      };
      for (final entry in receivers.entries) {
        expect(
          iterator.nativeNames,
          contains(nameOf(entry.value.iterator)),
          reason:
              '${entry.key}.iterator is a '
              '${nameOf(entry.value.iterator)}, which must route to Iterator '
              "or `.moveNext()` fails with \"Undefined property or method\"",
        );
      }
    });

    test('F-SCB17-AST-2: every map view\'s iterator routes to the Iterator '
        'bridge [2026-07-28]', () {
      final iterator = bridgeNamed('Iterator');
      final maps = <String, Map<String, int>>{
        'map literal': <String, int>{'a': 1},
        'HashMap': HashMap<String, int>()..['a'] = 1,
        // ignore: prefer_collection_literals
        'LinkedHashMap': LinkedHashMap<String, int>()..['a'] = 1,
        'SplayTreeMap': SplayTreeMap<String, int>()..['a'] = 1,
        'UnmodifiableMapView': UnmodifiableMapView<String, int>(<String, int>{
          'a': 1,
        }),
      };
      for (final entry in maps.entries) {
        for (final view in <String, Iterable<Object?>>{
          'keys': entry.value.keys,
          'values': entry.value.values,
          'entries': entry.value.entries,
        }.entries) {
          expect(
            iterator.nativeNames,
            contains(nameOf(view.value.iterator)),
            reason:
                '${entry.key}.${view.key}.iterator is a '
                '${nameOf(view.value.iterator)}',
          );
        }
      }
    });

    test('F-SCB17-AST-3: every map view itself routes to the Iterable bridge '
        '[2026-07-28]', () {
      final iterable = bridgeNamed('Iterable');
      final maps = <String, Map<String, int>>{
        'HashMap': HashMap<String, int>()..['a'] = 1,
        // ignore: prefer_collection_literals
        'LinkedHashMap': LinkedHashMap<String, int>()..['a'] = 1,
        'SplayTreeMap': SplayTreeMap<String, int>()..['a'] = 1,
        'UnmodifiableMapView': UnmodifiableMapView<String, int>(<String, int>{
          'a': 1,
        }),
      };
      for (final entry in maps.entries) {
        for (final view in <String, Iterable<Object?>>{
          'keys': entry.value.keys,
          'values': entry.value.values,
          'entries': entry.value.entries,
        }.entries) {
          expect(
            iterable.nativeNames,
            contains(nameOf(view.value)),
            reason:
                '${entry.key}.${view.key} is a ${nameOf(view.value)}; '
                'SplayTreeMap.entries was the one that was missing',
          );
        }
      }
    });
  });

  group('SCB17: addEntries is inherited, not shadowed', () {
    test('F-SCB17-AST-4: the mutable map bridges declare no local addEntries '
        '[2026-07-28]', () {
      // The local copies did `newEntries.cast()`, which cannot unwrap a
      // `BridgedInstance<MapEntry>`. Removing them lets `MapCore`'s correct
      // copy be reached through the `-> Map` edge, so the assertion is that
      // they stay absent.
      for (final name in ['HashMap', 'LinkedHashMap', 'SplayTreeMap']) {
        expect(
          bridgeNamed(name).methods.keys,
          isNot(contains('addEntries')),
          reason: '$name must inherit addEntries from Map, not shadow it',
        );
      }
    });

    test(
      'F-SCB17-AST-5: Map itself still provides addEntries [2026-07-28]',
      () {
        expect(bridgeNamed('Map').methods.keys, contains('addEntries'));
      },
    );

    test('F-SCB17-AST-6: the -> Map edge that carries addEntries is registered '
        '[2026-07-28]', () {
      for (final name in ['HashMap', 'LinkedHashMap', 'SplayTreeMap']) {
        expect(
          bridgeNamed(name).isSubtypeOf(bridgeNamed('Map')),
          isTrue,
          reason: 'without this edge the inherited addEntries is unreachable',
        );
      }
    });
  });
}
