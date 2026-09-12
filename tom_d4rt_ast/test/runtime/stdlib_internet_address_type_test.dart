import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`;
// reaching for them by same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCD24 mirror coverage for `tom_d4rt_ast` — what `InternetAddressType` offers.
///
/// `InternetAddressTypeIo` bridged four members the SDK does not declare:
/// `lookup`, `host`, `address` and `type`, each wired to whatever `Object`
/// member came to hand (`host` returned `.name`, `address` returned
/// `.hashCode`, `type` returned `.runtimeType`, `lookup` returned
/// `toString()`). They were copied from `InternetAddressIo`, which sits
/// directly above in the same file and where all four ARE correct — the doc
/// comment came across with them, still reading "Bridged InternetAddress
/// class", which is how the copy was eventually spotted.
///
/// THAT DIRECTION OF ERROR HAS NO TEST TO FAIL BY ITSELF. `type.address` handed
/// back an int and raised nothing, so a script doing arithmetic on a hash code
/// was green and does not compile as Dart at all. Per the rule SCC8
/// established, the absence is PINNED rather than merely deleted: a deletion
/// cannot be protected by an assertion that passes, and the next reader meets
/// `InternetAddress.host` one screen up.
///
/// REGISTRATION LEVEL is the honest level here, for the reason the SC5..SC8
/// mirrors give: `tom_d4rt_exec` is the only runner that could execute a script
/// against this tree, and it resolves `tom_d4rt_ast` from pub.dev rather than
/// by path, so it cannot see unpublished local edits. It is also the STRONGER
/// pin for this particular defect — the script-level twin observes that a call
/// throws, while these cases observe that the adapter map has no such key,
/// which is the thing that went wrong.
///
/// The script-level twin is
/// `tom_d4rt/test/stdlib/io/internet_address_type_test.dart`.
void main() {
  group('SCD24: InternetAddressType registers only what the SDK declares', () {
    late BridgedClass type;

    setUp(() {
      final env = Environment();
      Stdlib(env).register();
      IoStdlib.register(env);
      final found = env.findBridgedClassByName('InternetAddressType');
      expect(found, isNotNull, reason: 'the enum must still be bridged');
      type = found!;
    });

    for (final member in const ['host', 'address', 'type']) {
      test('F-SCD24-AST-${const {'host': 1, 'address': 2, 'type': 3}[member]}: '
          '$member is not a registered getter [2026-09-12] (PASS)', () {
        expect(
          type.getters.keys,
          isNot(contains(member)),
          reason:
              '`InternetAddressType.$member` does not exist in the SDK. It '
              'was copied from InternetAddressIo, where it does. Restoring '
              'it makes scripts green here and uncompilable as Dart.',
        );
      });
    }

    test('F-SCD24-AST-4: lookup is not a registered method, because it is a '
        'static on InternetAddress rather than a member of the type enum '
        '[2026-09-12] (PASS)', () {
      expect(type.methods.keys, isNot(contains('lookup')));
    });

    test('F-SCD24-AST-5: name IS registered, because EnumName really does give '
        'the enum one [2026-09-12] (PASS)', () {
      // Anti-vacuity for the four above: they would pass just as happily
      // against a class that registers nothing at all, or against a lookup
      // that silently returned an empty definition.
      expect(type.getters.keys, contains('name'));
      expect(
        type.staticGetters.keys,
        containsAll(const ['IPv4', 'IPv6', 'any', 'unix']),
        reason: 'the enum values are what the class is FOR',
      );
    });
  });
}
