import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();
  const String testLibPath = 'd4rt-mem:/byte_data_test.dart';

  dynamic executeTestScript(String scriptBody) {
    final fullScript =
        '''
      import 'dart:typed_data';
      main() {
        $scriptBody
      }
    ''';
    return d4rt.execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('ByteData Tests', () {
    test(
      'I-TYPE-78: Constructor ByteData(length) and basic properties. [2026-02-10 06:37] (PASS)',
      () {
        final result = executeTestScript('''
        var bd = new ByteData(10);
        return {
          'length': bd.lengthInBytes,
          'elementSize': bd.elementSizeInBytes
        };
      ''');
        expect(result['length'], 10);
        expect(result['elementSize'], 1);
      },
    );

    test(
      'I-TYPE-79: ByteData getInt8 and setInt8. [2026-02-10 06:37] (PASS)',
      () {
        final result = executeTestScript('''
        var bd = new ByteData(2);
        bd.setInt8(0, -5); // Max negative for int8 is -128
        bd.setInt8(1, 127);
        return {
          'val0': bd.getInt8(0),
          'val1': bd.getInt8(1)
        };
      ''');
        expect(result['val0'], -5);
        expect(result['val1'], 127);
      },
    );

    test(
      'I-TYPE-80: ByteData getUint16 and setUint16 (default Endian.big). [2026-02-10 06:37] (PASS)',
      () {
        final result = executeTestScript('''
        var bd = new ByteData(4);
        // Default Endian.big: MSB first
        // For 0xABCD -> bd[0]=AB, bd[1]=CD
        bd.setUint16(0, 0xABCD); 
        bd.setUint16(2, 0x1234, Endian.little); // LSB first: bd[2]=34, bd[3]=12
        
        return {
          'valBig': bd.getUint16(0), // Reads with Endian.big by default
          'valLittle': bd.getUint16(2, Endian.little),
          // Raw bytes to verify
          'byte0': bd.buffer.asUint8List()[0],
          'byte1': bd.buffer.asUint8List()[1],
          'byte2': bd.buffer.asUint8List()[2],
          'byte3': bd.buffer.asUint8List()[3],
        };
      ''');
        expect(result['valBig'], 0xABCD);
        expect(result['valLittle'], 0x1234);
        expect(result['byte0'], 0xAB);
        expect(result['byte1'], 0xCD);
        expect(result['byte2'], 0x34);
        expect(result['byte3'], 0x12);
      },
    );

    test(
      'I-TYPE-81: ByteData getUint16 and setUint16 with explicit Endian. [2026-02-10 06:37] (PASS)',
      () {
        final result = executeTestScript('''
        var bd = new ByteData(2);
        bd.setUint16(0, 0x1234, Endian.little);
        return {
          'valDefaultBig': bd.getUint16(0), // default is big
          'valLittle': bd.getUint16(0, Endian.little),
          'byte0': bd.buffer.asUint8List()[0], // Should be 0x34 for little endian
          'byte1': bd.buffer.asUint8List()[1], // Should be 0x12 for little endian
        };
      ''');
        // Native getUint16(0) with default Endian.big will read 0x3412 if bytes are [0x34, 0x12]
        expect(
          result['valDefaultBig'],
          (ByteData(2)
                ..setUint8(0, 0x34)
                ..setUint8(1, 0x12))
              .getUint16(0, Endian.big),
        );
        expect(result['valLittle'], 0x1234);
        expect(result['byte0'], 0x34);
        expect(result['byte1'], 0x12);
      },
    );

    test('I-TYPE-82: ByteData buffer property. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var bd = new ByteData(3);
        var buffer = bd.buffer;
        return {
          'bufferLength': buffer.lengthInBytes
        };
      ''');
      expect(result['bufferLength'], 3);
    });

    test(
      'I-TYPE-77: Offset out of bounds throws error. [2026-02-10 06:37] (PASS)',
      () {
        // SCC27 CONTRACT CHANGE: the host receives the `RangeError` the native
        // `ByteData` raised for the bad byte offset, rather than the bridged
        // call site's wrapper. `IndexError` — what the read/write paths actually
        // raise — implements `RangeError`, so one matcher covers all three.
        expect(
          () => executeTestScript("var bd = new ByteData(1); bd.getInt8(1);"),
          throwsA(isA<RangeError>()),
        );
        expect(
          () =>
              executeTestScript("var bd = new ByteData(1); bd.setInt8(1, 0);"),
          throwsA(isA<RangeError>()),
        );
        expect(
          () => executeTestScript("var bd = new ByteData(1); bd.getUint16(0);"),
          throwsA(isA<RangeError>()), // Not enough space for Uint16
        );
      },
    );

    // OPEN C.6 / idx-279 (Gap-8 residue): lock in `ByteData` symbol
    // resolution along the exact `services/codecs_test.dart` shape that the
    // generator-issues log flagged — `ByteData` used as a function-parameter
    // and local type annotation, plus the `ByteData.view(<Uint8List>.buffer)`
    // static constructor over a byte buffer. The stdlib registration already
    // exposes all of this (see `byte_data.dart` "E1 fix"); this test pins it
    // so a future stdlib refactor cannot silently regress the symbol.
    test('GEN-C6-279: ByteData type annotation + ByteData.view over a '
        'Uint8List buffer resolves and round-trips', () {
      final result = executeTestScript('''
        Uint8List bytesOf(ByteData bd) {
          return bd.buffer.asUint8List();
        }
        var src = Uint8List.fromList([1, 2, 3, 4]);
        ByteData view = ByteData.view(src.buffer);
        var out = bytesOf(view);
        return {
          'len': view.lengthInBytes,
          'first': view.getUint8(0),
          'last': view.getUint8(3),
          'roundTrip': out.length,
        };
      ''');
      expect(result['len'], 4);
      expect(result['first'], 1);
      expect(result['last'], 4);
      expect(result['roundTrip'], 4);
    });
  });
}
