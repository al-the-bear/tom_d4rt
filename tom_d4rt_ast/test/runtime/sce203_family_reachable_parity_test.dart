/// SCE203 (AST twin of `tom_d4rt/test/stdlib/sce203_family_reachable_parity_test.dart`)
/// — member parity across the near-identical collection families,
/// measured over REACHABLE members.
///
/// SCD167 compares directly registered names across the eleven typed-data
/// lists, which is right there and only there: those register
/// `['TypedData', 'List']` and re-declare the whole `Iterable` surface. Every
/// other family leans on the supertype walk, so a member missing from a direct
/// registration is usually not missing at all. Measured 2026-09-15 by
/// registration, the three collection families showed some thirty asymmetries;
/// measured by reachability they show exactly the two interface differences
/// the SDK has, which is what the allow-list below records — and nothing else.
///
/// `Object` members (`toString`, `hashCode`, `runtimeType`, `noSuchMethod`,
/// `==`) are OUTSIDE the comparison, because the interpreter answers them for
/// every bridged value whether or not a bridge declares them. `tom_d4rt`'s
/// F-SCE203-2 pins that with a script; this tree has no parser, so the case
/// lives there alone.
/// Counting them would allow-list a registration style, which is what this
/// file exists to stop doing.
@TestOn('vm')
library;

import 'dart:collection';
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

import '../bridge_reachability.dart';

const _objectMembers = {
  'toString',
  'hashCode',
  'runtimeType',
  'noSuchMethod',
  '==',
};

/// Each family, with the SDK type behind each bridge (for the mirror check).
const Map<String, Map<String, Type>> _families = {
  'sets': {
    'HashSet': HashSet,
    'LinkedHashSet': LinkedHashSet,
    'SplayTreeSet': SplayTreeSet,
  },
  'maps': {
    'HashMap': HashMap,
    'LinkedHashMap': LinkedHashMap,
    'SplayTreeMap': SplayTreeMap,
  },
  'queues': {
    'Queue': Queue,
    'ListQueue': ListQueue,
    'DoubleLinkedQueue': DoubleLinkedQueue,
  },
};

/// Members only ONE class of its family has, keyed by that class. Every entry
/// is an interface difference in the SDK, and F-SCE203-3 checks that it is.
const Map<String, Map<String, String>> _interfaceOnly = {
  'SplayTreeMap': {
    'firstKey': 'the sorted-map navigation API',
    'firstKeyAfter': 'the sorted-map navigation API',
    'lastKey': 'the sorted-map navigation API',
    'lastKeyBefore': 'the sorted-map navigation API',
  },
  'DoubleLinkedQueue': {
    'firstEntry': 'the entry API of the linked queue',
    'lastEntry': 'the entry API of the linked queue',
    'forEachEntry': 'the entry API of the linked queue',
  },
};

Environment _registry() {
  final env = Environment();
  Stdlib(env).register();
  CollectionStdlib.register(env);
  return env;
}

/// Every method and getter a script can reach on [className], through
/// SCD151's resolution helpers.
Set<String> _reachable(Environment env, String className) => {
  ...reachableMethodNames(env, className),
  ...reachableGetterNames(env, className),
}.difference(_objectMembers);

void main() {
  final env = _registry();

  test('F-SCE203-1: within each collection family, only the SDK\'s own '
      'interface differences separate the members [2026-09-28]', () {
    final unexpected = <String>[];
    for (final family in _families.entries) {
      final classes = family.value.keys.toList();
      final reach = {for (final c in classes) c: _reachable(env, c)};
      final union = reach.values.expand((s) => s).toSet();
      for (final c in classes) {
        final lacks = union.difference(reach[c]!);
        final allowed = {
          for (final owner in classes)
            if (owner != c) ...?_interfaceOnly[owner]?.keys,
        };
        for (final m in lacks.difference(allowed)) {
          unexpected.add(
            '${family.key}: $c cannot reach `$m`, which a sibling '
            'can',
          );
        }
        for (final m in allowed.difference(lacks)) {
          unexpected.add(
            '${family.key}: $c reaches `$m`, which the allow-list '
            'says only its owner has — delete the stale entry',
          );
        }
      }
    }
    unexpected.sort();
    expect(
      unexpected,
      isEmpty,
      reason:
          'A family member lost or gained a member its siblings do not '
          'share. If the SDK really separates them, record it in '
          '_interfaceOnly with the reason; otherwise the bridge is missing a '
          'member (or the walk stopped reaching one):\n  '
          '${unexpected.join('\n  ')}',
    );
  });

  test('F-SCE203-3: every allow-list entry is an interface difference in the '
      'SDK, not a registration style [2026-09-28]', () {
    // An entry here is a claim about Dart, so Dart is asked: the owner's SDK
    // class declares the member, and no sibling's does.
    final wrong = <String>[];
    for (final family in _families.values) {
      for (final owner in _interfaceOnly.keys.where(family.containsKey)) {
        for (final member in _interfaceOnly[owner]!.keys) {
          final symbol = MirrorSystem.getSymbol(member);
          for (final c in family.entries) {
            final has = reflectClass(
              c.value,
            ).instanceMembers.containsKey(symbol);
            if (c.key == owner && !has) {
              wrong.add('$owner does not declare `$member` in the SDK');
            }
            if (c.key != owner && has) {
              wrong.add(
                '${c.key} DOES declare `$member` in the SDK — not an '
                'interface difference',
              );
            }
          }
        }
      }
    }
    expect(wrong, isEmpty, reason: wrong.join('\n'));
  });
}
