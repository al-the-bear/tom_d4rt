// The eleven typed-data list variants expose the same member NAMES.
//
// WHY THIS EXISTS. SCC60 found two missing-member bugs and found both the same
// way: by running `diff` by hand over the eleven bridge files. Nothing in
// either suite would have surfaced them. SCB3 was the same shape in the other
// direction — `Uint8List` had three members the other ten lacked — and SCD166
// closed the last structural instance of it. Three findings, one cause: eleven
// near-identical registries kept in step by hand.
//
// WHAT "THE SAME" MEANS HERE, AND WHAT IT DOES NOT. Member NAMES, not
// behaviour. The variants genuinely differ — `Float32List` and `Float64List`
// take `double` elements where the others take `int`, and `Uint8ClampedList`
// clamps instead of truncating. None of that changes which names are
// registered, which is why parity over names is assertable without an
// allow-list full of judgement calls. Measured 2026-09-15: the accepted-
// asymmetry list below is EMPTY, and that is a result rather than a stub.
//
// UNION PLUS A FLOOR, which is the trade-off SCD167 asked to be decided.
// Asserting each variant declares the union of all eleven is self-maintaining
// — a new member added to ten of eleven fails immediately, with no list to
// update. Its one weakness is that dropping a member from ALL eleven shrinks
// the union and passes, so each kind also carries a floor on the union size.
// A hand-maintained canonical list would catch that too, at the cost of an
// edit on every legitimate change; the floors get the same protection for the
// case that actually happens, which is a member disappearing rather than
// eleven of them doing so at once.
//
// ONE TREE, BOTH TREES. This reads `tom_d4rt`'s registry only. It transfers to
// `tom_d4rt_ast` by SCD49's argument — the two stdlib trees are code-identical
// except at four recorded points, none of them under `typed_data/` — and
// F-SCD167-4 checks that the guard carrying that argument is still there,
// because this file's reach depends on it. Reading the twin directly is not
// possible: `tom_d4rt` cannot import `tom_d4rt_ast`, and the twin must stay
// dependency-free.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import '../../../tool/stdlib_member_diff.dart';

/// The eleven `List` views of `dart:typed_data`.
///
/// `ByteData` is deliberately absent: it is a typed *view*, not a list, and
/// shares none of this surface. `Uint8ClampedList` is present — it clamps on
/// assignment, which changes what a member DOES and not which members exist.
const _variants = <String>[
  'Int8List',
  'Int16List',
  'Int32List',
  'Int64List',
  'Uint8List',
  'Uint16List',
  'Uint32List',
  'Uint64List',
  'Uint8ClampedList',
  'Float32List',
  'Float64List',
];

/// Member kinds compared, with the floor each union must clear.
///
/// The floors are set below the measured union sizes (41 / 14 / 3 / 0 / 1 / 4
/// on 2026-09-15) by enough that a legitimate removal does not trip them and a
/// sweep does. `staticMethods` measures zero — the variants declare none — so
/// it has no floor and is compared for parity only.
const _floors = <String, int>{
  'methods': 35,
  'getters': 12,
  'setters': 3,
  'staticMethods': 0,
  'staticGetters': 1,
  'constructors': 4,
};

Map<String, Set<String>> _membersByKind(BridgedClass bc) => {
  'methods': bc.methods.keys.toSet(),
  'getters': bc.getters.keys.toSet(),
  'setters': bc.setters.keys.toSet(),
  'staticMethods': bc.staticMethods.keys.toSet(),
  'staticGetters': bc.staticGetters.keys.toSet(),
  'constructors': bc.constructors.keys.toSet(),
};

/// Members one variant may legitimately lack, keyed `<variant>.<kind>`.
///
/// EMPTY, AND MEASURED SO. SCD167 expected this to hold the `Float*` and
/// `Uint8ClampedList` differences; those are differences of element type and
/// of behaviour, and the registered NAMES are identical across all eleven. An
/// entry here is a claim that two variants cannot agree, and F-SCD167-3 fails
/// when such a claim stops being true — no exemption outlives its cause.
const _acceptedAsymmetry = <String, Set<String>>{};

final Environment _registry = buildFullyRegisteredEnvironment();

void main() {
  group('SCD167: the eleven typed-data variants declare the same members', () {
    late Map<String, Map<String, Set<String>>> byVariant;

    setUpAll(() {
      byVariant = {
        for (final name in _variants)
          if (_registry.findBridgedClassByName(name) case final bc?)
            name: _membersByKind(bc),
      };
    });

    test('F-SCD167-1: all eleven variants resolve, and each union clears its '
        'floor [2026-09-15] (PASS)', () {
      // Anti-vacuity, twice over. F-SCD167-2 iterates the variants, so a
      // registry that resolves none of them satisfies it while checking
      // nothing; and it compares against the union, so a union that has
      // collapsed makes every variant trivially complete.
      expect(
        byVariant.keys.toList()..sort(),
        equals(_variants.toList()..sort()),
        reason:
            'these typed-data variants are not in the registry, so the parity '
            'comparison below would silently cover fewer than eleven',
      );
      for (final entry in _floors.entries) {
        final union = <String>{
          for (final kinds in byVariant.values) ...kinds[entry.key]!,
        };
        expect(
          union.length,
          greaterThanOrEqualTo(entry.value),
          reason:
              'the ${entry.key} union is down to ${union.length}, below the '
              'floor of ${entry.value}. Either members were removed from all '
              'eleven variants at once — which parity alone cannot see — or '
              'the registry is not fully built here.',
        );
      }
    });

    test('F-SCD167-2: every variant declares the union of all eleven '
        '[2026-09-15] (PASS)', () {
      final gaps = <String>[];
      for (final kind in _floors.keys) {
        final union = <String>{
          for (final kinds in byVariant.values) ...kinds[kind]!,
        };
        for (final variant in _variants) {
          final accepted = _acceptedAsymmetry['$variant.$kind'] ?? const {};
          final missing = union.difference(byVariant[variant]![kind]!)
            ..removeAll(accepted);
          if (missing.isNotEmpty) {
            gaps.add('$variant.$kind lacks ${(missing.toList()..sort())}');
          }
        }
      }
      expect(
        gaps,
        isEmpty,
        reason:
            'These variants are missing members their siblings declare. This is '
            'the shape of SCB3, SCC60 and SCD166 — eleven near-identical '
            'registries kept in step by hand. Add the member, in the same file '
            'the siblings declare it in and preferably via the shared helper in '
            'inherited_list_methods.dart. Only if the variant genuinely cannot '
            'have it, add a _acceptedAsymmetry entry saying why.',
      );
    });

    test('F-SCD167-3: no accepted asymmetry outlives its cause '
        '[2026-09-15] (PASS)', () {
      final stale = <String>[];
      for (final entry in _acceptedAsymmetry.entries) {
        final parts = entry.key.split('.');
        final declared = byVariant[parts.first]?[parts.last];
        if (declared == null) {
          stale.add('${entry.key}: no such variant or kind');
          continue;
        }
        final present = entry.value.where(declared.contains).toList()..sort();
        if (present.isNotEmpty) {
          stale.add('${entry.key}: $present is declared after all');
        }
      }
      expect(
        stale,
        isEmpty,
        reason:
            'A permission that is no longer needed reads as a known limitation '
            'and hides the next real one. Delete these entries.',
      );
    });

    test('F-SCD167-4: the twin-sync guard this file relies on is still present '
        '[2026-09-15] (PASS)', () {
      // This file reads ONE registry and is read as evidence about TWO trees.
      // That inference is SCD49's — "the two stdlib trees are code-identical
      // except at four recorded points" — and if SCD49 goes away, this file
      // quietly narrows from a claim about the shipped interpreter to a claim
      // about the reference one, with nothing saying so.
      final sync = File('test/scd49_stdlib_twin_sync_test.dart');
      expect(
        sync.existsSync(),
        isTrue,
        reason:
            'scd49_stdlib_twin_sync_test.dart is gone. Without it nothing '
            'checks that tom_d4rt_ast carries the same typed-data registries, '
            'so this file no longer says anything about the tree that ships '
            'inside Flutter apps.',
      );
      final source = sync.readAsStringSync();
      expect(
        source,
        contains('lib/src/stdlib'),
        reason: 'the twin-sync guard no longer names the reference stdlib root',
      );
      expect(
        source,
        contains('tom_d4rt_ast/lib/src/runtime/stdlib'),
        reason: 'the twin-sync guard no longer names the AST stdlib root',
      );
    });
  });
}
