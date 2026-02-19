import '../../test_helpers.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt(parseSourceCallback: parseSource);
  const String testLibPath = 'd4rt-mem:/byte_buffer_test.dart';

  dynamic executeTestScript(String scriptBody) {
    final fullScript = '''
      import 'dart:typed_data';
      // For Uint8List and ByteBuffer if they are used explicitly in script
      // However, Endian is accessed like a class with static members.
      // ByteBuffer is usually obtained from other TypedData objects.
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

  group('ByteBuffer Tests', () {
    test('I-TYPE-74: Get ByteBuffer from Uint8List and check lengthInBytes. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = new Uint8List(10);
        var buffer = list.buffer;
        return {
          'length': buffer.lengthInBytes,
        };
      ''');
      expect(result['length'], 10);
    });

    test('I-TYPE-75: ByteBuffer asUint8List. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = new Uint8List(5);
        for (var i = 0; i < 5; i++) { list[i] = i * 10; }
        var buffer = list.buffer;
        var view = buffer.asUint8List();
        
        var sum = 0;
        for (var i = 0; i < view.length; i++) { sum += view[i]; }

        return {
          'viewLength': view.length,
          'viewSum': sum,
          'viewType': view.runtimeType.toString() // Check if it becomes a bridged Uint8List
        };
      ''');
      expect(result['viewLength'], 5);
      expect(result['viewSum'], 0 + 10 + 20 + 30 + 40);
    });

    test('I-TYPE-76: ByteBuffer asUint8List with offset and length. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = new Uint8List(10);
        for (var i = 0; i < 10; i++) { list[i] = i; }
        var buffer = list.buffer;
        
        // View of bytes 2, 3, 4
        var view = buffer.asUint8List(2, 3);
        
        var values = [];
        for (var i = 0; i < view.length; i++) { values.add(view[i]); }

        return {
          'viewLength': view.length,
          'viewValues': values
        };
      ''');
      expect(result['viewLength'], 3);
      expect(result['viewValues'], orderedEquals([2, 3, 4]));
    });
  });
}
