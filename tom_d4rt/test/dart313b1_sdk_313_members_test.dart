// DART313B1: the members Dart 3.13 added to bridged classes.
//
// Dart 3.13 added `int.oneBitCount`, `int.trailingZeroBitCount`,
// `Future.pause`, `List.unmodifiableOf`, `Map.unmodifiableOf` and an
// isolate-embedding API on `Isolate`. The packages declare `sdk: ^3.10.4`, so a
// bridge may not reference a 3.13 member directly. The five usable ones are
// bridged with an exact equivalent that every supported SDK has (the SDK's own
// bit-count algorithm, `Future.delayed`, `unmodifiable`), so a script gets the
// same answer on any host SDK. The eight `Isolate` members are declined (see
// the limitations doc and F-DART313B1-3 in
// `stdlib/intentionally_unbridged_test.dart`).
//
// The stdlib member audit measures only the surface every supported SDK has
// (`auditSdkFloor` in `tool/stdlib_member_diff.dart`), so its baseline and
// figures are the same on every SDK. F-DART313B1-5 holds what it leaves out to
// the same rule: every SDK member newer than the floor, on every bridged class,
// is bridged or declined.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/src/stdlib/core/int.dart';
import 'package:tom_d4rt/src/unbridged_reasons.dart';

import '../tool/stdlib_member_diff.dart';
import 'interpreter_test.dart';

/// Whether the running SDK is Dart 3.13 or newer, where the native members
/// exist to compare against.
final bool _sdkHas313 = () {
  final match = RegExp(r'^(\d+)\.(\d+)').firstMatch(Platform.version);
  if (match == null) return false;
  final major = int.parse(match.group(1)!);
  final minor = int.parse(match.group(2)!);
  return major > 3 || (major == 3 && minor >= 13);
}();

void main() {
  group('DART313B1: the Dart 3.13 members, on every SDK', () {
    test('F-DART313B1-1: int.oneBitCount and int.trailingZeroBitCount give '
        'the 64-bit answers the SDK documents [2026-11-09]', () {
      // (value, oneBitCount, trailingZeroBitCount) on a native platform.
      const cases = [
        ('0', 0, 64),
        ('1', 1, 0),
        ('2', 1, 1),
        ('7', 3, 0),
        ('8', 1, 3),
        ('-1', 64, 0),
        ('-8', 61, 3),
        ('1 << 40', 1, 40),
        ('0x7FFFFFFFFFFFFFFF', 63, 0),
        ('-0x8000000000000000', 1, 63),
      ];
      final list = cases.map((c) => '(${c.$1})').join(', ');
      expect(
        execute(
          'main() => [$list].map((v) => [v.oneBitCount, '
          'v.trailingZeroBitCount]).toList();',
        ),
        [
          for (final c in cases) [c.$2, c.$3],
        ],
      );
    });

    test('F-DART313B1-2: on Dart 3.13 or newer the bit counts equal the '
        "native int's [2026-11-09]", () {
      final values = <int>[
        for (var i = -300; i <= 300; i++) i,
        for (var s = 0; s < 64; s++) ...[1 << s, (1 << s) - 1, -(1 << s)],
        0x7FFFFFFFFFFFFFFF,
        -0x8000000000000000,
        0x0123456789ABCDEF,
      ];
      for (final v in values) {
        final native = v as dynamic;
        expect(intOneBitCount(v), native.oneBitCount, reason: '$v.oneBitCount');
        expect(
          intTrailingZeroBitCount(v),
          native.trailingZeroBitCount,
          reason: '$v.trailingZeroBitCount',
        );
      }
    }, skip: _sdkHas313 ? false : 'the native members exist from Dart 3.13');

    test('F-DART313B1-4: Future.pause completes with no value after its '
        'duration [2026-11-09]', () async {
      final result =
          await (execute('''
        main() async {
          final start = DateTime.now();
          final paused = await Future.pause(const Duration(milliseconds: 20));
          final waited = DateTime.now().difference(start).inMilliseconds;
          await Future.pause();
          return [paused, waited >= 15];
        }
      ''')
              as Future<Object?>);
      expect(result, [null, true]);
    });

    test('F-DART313B1-7: List.unmodifiableOf and Map.unmodifiableOf build '
        'unmodifiable copies [2026-11-09]', () {
      expect(
        execute('''
        main() {
          final list = List.unmodifiableOf([1, 2]);
          final map = Map.unmodifiableOf({'a': 1});
          var listRefused = false;
          var mapRefused = false;
          try { list.add(3); } catch (e) { listRefused = e is UnsupportedError; }
          try { map['b'] = 2; } catch (e) { mapRefused = e is UnsupportedError; }
          return [list, map, listRefused, mapRefused];
        }
      '''),
        [
          [1, 2],
          {'a': 1},
          true,
          true,
        ],
      );
    });

    test('F-DART313B1-5: every SDK member newer than the audit floor, on every '
        'bridged class, is bridged or declined [2026-11-09]', () {
      final env = buildFullyRegisteredEnvironment();
      final unaccounted = <String>[];
      var newer = 0;
      for (final name in env.bridgedClassNames) {
        final bc = env.findBridgedClassByName(name);
        if (bc == null || bc.nativeType == Function) continue;
        final members = sdkMembersNewerThanFloor(bc.nativeType);
        bool declined(String m) =>
            kUnbridgedMemberReasons.containsKey('$name.$m');
        for (final m in members.instance) {
          newer++;
          final bridged =
              bc.methods.containsKey(m) ||
              bc.getters.containsKey(m) ||
              bc.setters.containsKey(m);
          if (!bridged && !declined(m)) unaccounted.add('$name.$m');
        }
        for (final m in members.statics) {
          newer++;
          final bridged =
              bc.staticMethods.containsKey(m) ||
              bc.staticGetters.containsKey(m) ||
              bc.staticSetters.containsKey(m);
          if (!bridged && !declined(m)) unaccounted.add('$name.$m');
        }
        for (final c in members.constructors) {
          newer++;
          if (!bc.constructors.containsKey(c) && !declined(c)) {
            unaccounted.add('$name.${c.isEmpty ? '<unnamed>' : c}');
          }
        }
      }
      if (!_sdkHas313) {
        markTestSkipped(
          'this SDK has $newer member(s) newer than the audit floor; '
          'the Dart 3.13 members exist only on 3.13 or newer',
        );
      } else {
        // Anti-vacuity: 3.13 has the thirteen this todo found.
        expect(newer, greaterThanOrEqualTo(13));
      }
      expect(
        unaccounted,
        isEmpty,
        reason:
            'These SDK members are newer than the SDK floor the packages '
            'declare, so the member audit leaves them out, and nothing else '
            'accounts for them:\n  ${unaccounted.join('\n  ')}\n\n'
            'Bridge each one with an equivalent every supported SDK has, or '
            'decline it in kUnbridgedMemberReasons with a limitations-doc row.',
      );
    });

    test('F-DART313B1-6: the audit floor is the SDK floor the pubspec '
        'declares [2026-11-09]', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final match = RegExp(
        r'^\s+sdk:\s*\^(\d+)\.(\d+)\.',
        multiLine: true,
      ).firstMatch(pubspec);
      expect(match, isNotNull, reason: 'no `sdk: ^x.y.z` in pubspec.yaml');
      expect(
        (major: int.parse(match!.group(1)!), minor: int.parse(match.group(2)!)),
        auditSdkFloor,
        reason:
            'raise auditSdkFloor (both audit tools) together with the '
            "pubspecs' SDK floor",
      );
    });
  });
}
