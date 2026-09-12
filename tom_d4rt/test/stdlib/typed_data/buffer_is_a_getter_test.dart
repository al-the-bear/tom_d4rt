// SCD27: `buffer` was registered as a METHOD as well as a getter, on all eleven
// typed lists and in both trees.
//
// In the SDK `buffer` is a getter inherited from `TypedData`. Registering it in
// the `methods:` map as well meant `l.buffer()` resolved — and that call does
// not compile as Dart. This is the WIDENING shape: a script green here and
// invalid there, which is the one bridge defect no passing test can catch,
// because every assertion anyone would write uses the form that already worked.
//
// The duplicate registration is why it went unnoticed for so long. `l.buffer`
// read correctly the whole time, so nothing was broken to trip over — the extra
// surface simply sat beside the correct surface.
//
// Removing script-visible surface needs the absence PINNED, per the rule SCC8
// established for `LinkedList.removeFirst`: a deletion cannot be protected by
// an assertion that passes, and the next reader meets ten other adapters in the
// same `methods:` map and restores this one as an oversight.
//
// The property form is asserted alongside, on every variant. Pinning only the
// absence would pass just as happily against a bridge that had lost `buffer`
// altogether, which is the opposite defect and just as bad.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  const variants = [
    'Float32List',
    'Float64List',
    'Int8List',
    'Int16List',
    'Int32List',
    'Int64List',
    'Uint8List',
    'Uint8ClampedList',
    'Uint16List',
    'Uint32List',
    'Uint64List',
  ];

  dynamic run(String body) =>
      D4rt().execute(source: "import 'dart:typed_data'; main() { $body }");

  group('SCD27: buffer reads as a property on every typed list', () {
    for (final type in variants) {
      test('F-SCD27-1-$type: `l.buffer` is readable [2026-09-12] (PASS)', () {
        expect(
          run('var l = $type(2); return l.buffer.lengthInBytes;'),
          isA<int>().having((v) => v > 0, 'a non-empty buffer', isTrue),
        );
      });
    }
  });

  group('SCD27: buffer is not callable, because Dart does not call getters', () {
    for (final type in variants) {
      test('F-SCD27-2-$type: `l.buffer()` does not resolve [2026-09-12] '
          '(PASS)', () {
        expect(
          () => run('var l = $type(2); return l.buffer().lengthInBytes;'),
          // A missing METHOD on a bridged instance raises
          // `D4rtNoSuchMethodError`, which implements `NoSuchMethodError` — so
          // a script catches this exactly as it would catch real Dart's. (The
          // getter direction differs; see sce67.)
          throwsA(isA<NoSuchMethodError>()),
        );
      });
    }
  });
}
