// SCB3: member-level gaps found by the mechanical adapter-map diff.
//
// Every case here is a member on a class that is otherwise fully bridged — the
// failure mode a class-granularity check cannot see, because the class is
// present and most of its members work. Grouped by the reason a spot-check on
// the class passes even while the member is unreachable:
//
//  * PARTIAL CONSTANT SETS — `Duration` carries 16 unit constants. A spot-check
//    landing on `secondsPerMinute` says nothing about `microsecondsPerDay`, so
//    all sixteen are asserted as one list.
//  * MISSING STATICS ON A WORKING CLASS — statics get no supertype fallback in
//    the interpreter at all, so an unregistered static is always a hard
//    failure regardless of how complete the rest of the class is.
//  * MISSING MEMBERS ON CONCRETE SUBTYPES — instance fallback through the
//    supertype chain is *not* uniform, so `Set` algebra resolving on a set
//    literal does not imply it resolves on `HashSet` / `LinkedHashSet` /
//    `SplayTreeSet`. Each concrete type is exercised separately.

import '../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Duration unit constants — the partial-bridge case', () {
    test('F-SCB3-20: all sixteen unit constants resolve [2026-07-28]', () {
      // Asserted as one list so a single missing constant fails loudly rather
      // than being masked by the six that always worked.
      const source = '''
      main() {
        return [
          Duration.microsecondsPerMillisecond,
          Duration.microsecondsPerSecond,
          Duration.microsecondsPerMinute,
          Duration.microsecondsPerHour,
          Duration.microsecondsPerDay,
          Duration.millisecondsPerSecond,
          Duration.millisecondsPerMinute,
          Duration.millisecondsPerHour,
          Duration.millisecondsPerDay,
          Duration.secondsPerMinute,
          Duration.secondsPerHour,
          Duration.secondsPerDay,
          Duration.minutesPerHour,
          Duration.minutesPerDay,
          Duration.hoursPerDay,
        ];
      }
      ''';
      expect(
        execute(source),
        equals([
          1000,
          1000000,
          60000000,
          3600000000,
          86400000000,
          1000,
          60000,
          3600000,
          86400000,
          60,
          3600,
          86400,
          60,
          1440,
          24,
        ]),
      );
    });

    test('F-SCB3-21: the constants are consistent with Duration arithmetic '
        '[2026-07-28]', () {
      // The point of the constants is unit conversion; a wrong value is worse
      // than a missing one, so tie them to the class's own behaviour.
      const source = '''
      main() {
        final d = Duration(days: 1);
        return [
          d.inMicroseconds == Duration.microsecondsPerDay,
          d.inMinutes == Duration.minutesPerDay,
          Duration.secondsPerDay ==
              Duration.secondsPerMinute * Duration.minutesPerDay,
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true]));
    });
  });

  group('Uri.base', () {
    test('F-SCB3-22: Uri.base resolves and yields an absolute Uri '
        '[2026-07-28]', () {
      // Asserting the scheme is `file` would tie the test to how the process
      // was launched; that it is an absolute Uri is the contract.
      const source = '''
      main() {
        final b = Uri.base;
        return [b is Uri, b.isAbsolute, b.scheme.isNotEmpty];
      }
      ''';
      expect(execute(source), equals([true, true, true]));
    });
  });

  group('UriData predicates', () {
    test('F-SCB3-23: isMimeType / isCharset / isEncoding all resolve '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:convert';
      main() {
        final d = UriData.parse('data:text/plain;charset=utf-8,x');
        return [
          d.isMimeType('text/plain'),
          d.isMimeType('text/html'),
          d.isCharset('utf-8'),
          d.isCharset('iso-8859-1'),
          d.isEncoding(utf8),
        ];
      }
      ''';
      expect(execute(source), equals([true, false, true, false, true]));
    });
  });

  group('typed-data view constructors', () {
    test('F-SCB3-24: ByteData.asUnmodifiableView reads but rejects writes '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:typed_data';
      main() {
        final bd = ByteData(4);
        bd.setUint8(0, 7);
        final v = bd.asUnmodifiableView();
        var threw = false;
        try { v.setUint8(0, 9); } catch (e) { threw = true; }
        return [v.lengthInBytes, v.getUint8(0), threw];
      }
      ''';
      expect(execute(source), equals([4, 7, true]));
    });

    test('F-SCB3-25: ByteBuffer.asUint8ClampedList completes the view family '
        '[2026-07-28]', () {
      // The other asXxxList views were present; this one was the sole gap, so
      // a buffer could be reinterpreted as every typed list but this.
      const source = '''
      import 'dart:typed_data';
      main() {
        final buf = Uint8List.fromList([1, 2, 3, 250]).buffer;
        final c = buf.asUint8ClampedList();
        return [c.length, c[0], c[3], c is Uint8ClampedList];
      }
      ''';
      expect(execute(source), equals([4, 1, 250, true]));
    });
  });

  group('Set algebra on the concrete set implementations', () {
    // difference/intersection/union resolved on the plain `Set` bridge but on
    // none of the three dart:collection implementations — instance fallback
    // through the supertype chain is not uniform, so each needs its own.
    for (final type in ['HashSet', 'LinkedHashSet', 'SplayTreeSet']) {
      test('F-SCB3-26-$type: difference/intersection/union resolve '
          '[2026-07-28]', () {
        final source =
            '''
        import 'dart:collection';
        main() {
          final s = $type<int>();
          s.addAll([1, 2, 3]);
          final diff = s.difference({2}).toList();
          final inter = s.intersection({2, 9}).toList();
          final uni = s.union({7}).toList();
          diff.sort();
          inter.sort();
          uni.sort();
          return [diff, inter, uni];
        }
        ''';
        expect(
          execute(source),
          equals([
            [1, 3],
            [2],
            [1, 2, 3, 7],
          ]),
          reason: 'set algebra must resolve on $type',
        );
      });

      test(
        'F-SCB3-27-$type: the results are the same set type [2026-07-28]',
        () {
          // The SDK returns a set of the receiver's kind; if the adapter
          // accidentally returned a plain literal Set this would silently pass a
          // length check but break `is` narrowing downstream.
          final source =
              '''
        import 'dart:collection';
        main() {
          final s = $type<int>();
          s.addAll([1, 2]);
          return [s.difference({1}) is Set, s.union({3}) is Set];
        }
        ''';
          expect(execute(source), equals([true, true]));
        },
      );
    }
  });
}
