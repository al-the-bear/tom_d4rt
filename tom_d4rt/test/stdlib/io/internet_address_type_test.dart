// SCD24: `InternetAddressType` bridged four members the SDK does not declare.
//
// `InternetAddressTypeIo` offered `lookup`, `host`, `address` and `type`, each
// wired to whatever `Object` member came to hand: `host` returned `.name`,
// `address` returned `.hashCode`, `type` returned `.runtimeType`, and `lookup`
// returned `toString()`. They were copied from `InternetAddressIo`, which sits
// directly above it in the same file and where all four ARE correct — the doc
// comment above the class came across with them, still reading "Bridged
// InternetAddress class", which is how the copy was eventually spotted.
//
// THIS DIRECTION OF ERROR HAS NO TEST TO FAIL. `type.address` handed back an
// int and raised nothing, so a script doing arithmetic on a hash code was green
// here and does not compile as Dart at all. Every other entry in the sweep that
// found this either worked correctly or failed loudly.
//
// So the absence is pinned, per the rule SCC8 established: a deletion cannot be
// protected by an assertion that passes, and without a pin the next reader
// meets `InternetAddress.host` one screen up and restores the omission as an
// oversight. `name` is asserted alongside because it is the one instance member
// the enum really has (via the `EnumName` extension), and the same confusion
// that added four could remove it.
//
// THESE FOUR CASES DO NOT ALL ASSERT THE SAME EXCEPTION, and the reason is a
// finding rather than an inconsistency in the test. Measured 2026-09-12 on a
// bridged instance:
//
//   * a missing METHOD  -> `D4rtNoSuchMethodError`, which
//     `implements NoSuchMethodError`, so a script catches it exactly as it
//     would catch real Dart's. This is what F-SCC8-5 asserts for
//     `LinkedList.removeFirst`, and F-SCD24-4 asserts it here.
//   * a missing GETTER  -> `UndefinedMemberD4rtException`, which extends
//     `RuntimeD4rtException` and NOT `NoSuchMethodError`. A script cannot catch
//     it the way it would catch the real one.
//
// So the same absence reports differently depending on the member kind, and
// only one of the two matches Dart. F-SCD24-1..3 assert what is actually thrown
// rather than what ought to be: a pin exists to stop the members being
// reinstated and does that either way, whereas asserting an aspiration would
// leave this file red and teach the next reader to discount it. The divergence
// is sce67; when it is fixed, these three change to `NoSuchMethodError` and
// this paragraph goes with them.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();
  // `dart:io` sits behind an import gate keyed on FilesystemPermission, so the
  // scripts below cannot even load without it. Worth noting that the grant is
  // load-bearing for the NEGATIVE cases too: without it they still throw, but
  // with a permission error rather than a NoSuchMethodError — which is why they
  // assert the exact type instead of just `throwsA(anything)`.
  d4rt.grant(FilesystemPermission.any);
  const String testLibPath = 'd4rt-mem:/internet_address_type_test.dart';

  dynamic run(String scriptBody) {
    return d4rt.execute(
      library: testLibPath,
      sources: {
        testLibPath:
            '''
      import 'dart:io';

      main() {
        $scriptBody
      }
    ''',
      },
    );
  }

  group('SCD24: InternetAddressType offers only what the SDK declares', () {
    for (final member in const ['host', 'address', 'type']) {
      test('F-SCD24-${const {'host': 1, 'address': 2, 'type': 3}[member]}: '
          '$member is absent, because InternetAddressType has no such member '
          '[2026-09-12] (PASS)', () {
        expect(
          () => run('return InternetAddressType.IPv4.$member;'),
          // NOT `NoSuchMethodError`, which is what F-SCC8-5 asserts for the
          // same shape of absence on `LinkedList`. Measured: a missing member
          // on a BRIDGED instance raises `UndefinedMemberD4rtException`,
          // which extends `RuntimeD4rtException` and not `NoSuchMethodError`,
          // so a script cannot catch it the way it would catch the real one.
          //
          // Asserting what is actually thrown rather than what ought to be: a
          // pin exists to stop the members being reinstated and does that
          // either way, whereas asserting an aspiration leaves the file red
          // and teaches the next reader to discount it. The divergence is
          // sce67.
          throwsA(
            isA<UndefinedMemberD4rtException>().having(
              (e) => e.memberName,
              'memberName',
              equals(member),
            ),
          ),
        );
      });
    }

    test(
      'F-SCD24-4: lookup is absent, because it is a static on InternetAddress '
      'rather than a member of the type enum [2026-09-12] (PASS)',
      () {
        expect(
          () => run('return InternetAddressType.IPv4.lookup();'),
          // A METHOD, and it behaves correctly: `D4rtNoSuchMethodError`
          // implements `NoSuchMethodError`, so a script catches this exactly as
          // it would catch real Dart's. That it differs from the three getters
          // above is the point of sce67, and asserting the SDK supertype here
          // keeps the correct half correct.
          throwsA(isA<NoSuchMethodError>()),
        );
      },
    );

    test(
      'F-SCD24-5: name is present, because EnumName really does give the enum '
      'one [2026-09-12] (PASS)',
      () {
        // Anti-vacuity for the four above: they would pass just as happily
        // against a class that bridges nothing at all.
        expect(run("return InternetAddressType.IPv4.name;"), equals('IPv4'));
      },
    );
  });
}
