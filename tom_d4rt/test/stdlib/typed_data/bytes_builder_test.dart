import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  const String testLibPath = 'd4rt-mem:/bytes_builder_test.dart';

  dynamic run(String scriptBody) {
    final fullScript =
        '''
      import 'dart:typed_data';
      main() {
        $scriptBody
      }
    ''';
    return D4rt().execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('BytesBuilder (SC8)', () {
    test(
      'F-SC8-1: default constructor yields an empty builder. [2026-07-27]',
      () {
        final result = run('''
        final b = BytesBuilder();
        return [b.length, b.isEmpty, b.isNotEmpty];
      ''');
        expect(result, [0, true, false]);
      },
    );

    test('F-SC8-2: a constructed builder satisfies `is BytesBuilder`. '
        '[2026-07-27]', () {
      // The factory returns the private `_CopyingBytesBuilder`, so this only
      // holds because the bridge declares `isAssignable`.
      expect(run('return BytesBuilder() is BytesBuilder;'), isTrue);
    });

    test('F-SC8-3: addByte and add accumulate in order. [2026-07-27]', () {
      final result = run('''
        final b = BytesBuilder();
        b.addByte(1);
        b.add([2, 3]);
        b.addByte(4);
        return [b.takeBytes().join(','), b.length];
      ''');
      expect(result, ['1,2,3,4', 0]);
    });

    test('F-SC8-4: takeBytes drains the builder. [2026-07-27]', () {
      final result = run('''
        final b = BytesBuilder();
        b.add([1, 2, 3]);
        final taken = b.takeBytes();
        return [taken.join(','), b.length, b.isEmpty];
      ''');
      expect(result, ['1,2,3', 0, true]);
    });

    test('F-SC8-5: toBytes snapshots without draining. [2026-07-27]', () {
      final result = run('''
        final b = BytesBuilder();
        b.add([1, 2, 3]);
        final snapshot = b.toBytes();
        return [snapshot.join(','), b.length];
      ''');
      expect(result, ['1,2,3', 3]);
    });

    test('F-SC8-6: toBytes returns a usable Uint8List. [2026-07-27]', () {
      // The returned object routes to the existing Uint8List bridge, so its
      // indexing and sublist surface must work without further registration.
      final result = run('''
        final b = BytesBuilder();
        b.add([65, 66, 67]);
        final u = b.toBytes();
        return [u.length, u[0], u.sublist(1).join(',')];
      ''');
      expect(result, [3, 65, '66,67']);
    });

    test('F-SC8-7: clear empties the builder. [2026-07-27]', () {
      final result = run('''
        final b = BytesBuilder();
        b.add([1, 2, 3]);
        b.clear();
        return [b.length, b.isEmpty];
      ''');
      expect(result, [0, true]);
    });

    test('F-SC8-8: `copy: false` works past construction. [2026-07-27]', () {
      // `BytesBuilder(copy: false)` returns the *other* private implementation
      // (`_BytesBuilder`), so this is what proves the second `nativeNames`
      // entry is load-bearing: without it the object constructs but every
      // member call afterwards reaches no bridge.
      final result = run('''
        final b = BytesBuilder(copy: false);
        b.addByte(7);
        b.add([8, 9]);
        return [b.length, b.takeBytes().join(','), b.isEmpty];
      ''');
      expect(result, [3, '7,8,9', true]);
    });

    test('F-SC8-9: both flavours accumulate identically in a loop. '
        '[2026-07-27]', () {
      final result = run('''
        final out = [];
        for (final copy in [true, false]) {
          final b = BytesBuilder(copy: copy);
          for (var i = 0; i < 5; i++) { b.addByte(i * 2); }
          out.add(b.takeBytes().join(','));
        }
        return out.join(' | ');
      ''');
      expect(result, '0,2,4,6,8 | 0,2,4,6,8');
    });

    test(
      'F-SC8-10: takeBytes on an untouched builder is empty. [2026-07-27]',
      () {
        expect(run('return BytesBuilder().takeBytes().length;'), 0);
      },
    );

    test('F-SC8-11: argument errors surface as catchable script errors. '
        '[2026-07-27]', () {
      final result = run('''
        final r = [];
        final b = BytesBuilder();
        try { b.addByte('x'); } catch (e) { r.add('addByte'); }
        try { b.add(42); } catch (e) { r.add('add-nonlist'); }
        try { b.add([1, 'x']); } catch (e) { r.add('add-nonint'); }
        try { BytesBuilder(true); } catch (e) { r.add('positional'); }
        return r.join(',');
      ''');
      expect(result, 'addByte,add-nonlist,add-nonint,positional');
    });
  });
}
