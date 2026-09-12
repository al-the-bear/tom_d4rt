import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// SCD27 mirror coverage for `tom_d4rt_ast` — `buffer` is a getter, not a method.
///
/// It was registered in BOTH maps on all eleven typed lists, so `l.buffer()`
/// resolved. In the SDK `buffer` is a getter inherited from `TypedData` and that
/// call does not compile as Dart: the widening shape, where a script is green
/// here and invalid there.
///
/// REGISTRATION LEVEL is the honest level for this tree (no parser, DGUC6) and
/// the stronger one for this defect. The script-level twin observes that a call
/// throws; these cases observe that the `methods:` map has no such key and the
/// `getters:` map does — which is the thing that was wrong, and the thing a
/// future edit would get wrong again.
///
/// Both directions are asserted. Pinning only the absence would pass just as
/// happily against a bridge that had lost `buffer` altogether.
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

  late Environment env;

  setUp(() {
    env = Environment();
    TypedDataStdlib.register(env);
  });

  group('SCD27: buffer is registered as a getter on every typed list', () {
    for (final type in variants) {
      test('F-SCD27-AST-1-$type: buffer is in getters [2026-09-12] (PASS)', () {
        final c = env.findBridgedClassByName(type);
        expect(c, isNotNull, reason: '$type must still be bridged');
        expect(c!.getters.keys, contains('buffer'));
      });
    }
  });

  group('SCD27: buffer is not registered as a method', () {
    for (final type in variants) {
      test('F-SCD27-AST-2-$type: buffer is absent from methods [2026-09-12] '
          '(PASS)', () {
        final c = env.findBridgedClassByName(type)!;
        expect(
          c.methods.keys,
          isNot(contains('buffer')),
          reason:
              'A method registration makes `l.buffer()` resolve, and that does '
              'not compile as Dart. The getter beside it is the correct one.',
        );
      });
    }
  });
}
