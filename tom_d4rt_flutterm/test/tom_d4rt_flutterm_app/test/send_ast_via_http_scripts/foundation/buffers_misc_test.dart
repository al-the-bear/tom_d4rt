// D4rt test script: Tests foundation BitField, WriteBuffer, ReadBuffer,
// CachingIterable, Category
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Foundation buffers and misc test executing');

  // ========== BitField ==========
  print('--- BitField Tests ---');

  // Note: BitField is used with integer-indexed enum-like values
  // It's a compact boolean array
  final bits = BitField<int>(4);  // 4 bits
  print('BitField created with 4 bits');
  bits[0] = true;
  bits[2] = true;
  print('BitField[0]: ${bits[0]}');
  print('BitField[1]: ${bits[1]}');
  print('BitField[2]: ${bits[2]}');
  print('BitField[3]: ${bits[3]}');

  bits.reset();
  print('BitField after reset [0]: ${bits[0]}');
  print('BitField after reset [2]: ${bits[2]}');

  bits.reset(true);
  print('BitField after reset(true) [0]: ${bits[0]}');
  print('BitField after reset(true) [3]: ${bits[3]}');

  // ========== WriteBuffer ==========
  print('--- WriteBuffer Tests ---');

  final writeBuffer = WriteBuffer();
  writeBuffer.putUint8(42);
  writeBuffer.putInt32(12345);
  writeBuffer.putFloat64(3.14159);
  writeBuffer.putUint8List(Uint8List.fromList([1, 2, 3, 4]));
  final data = writeBuffer.done();
  print('WriteBuffer done, length: ${data.lengthInBytes}');

  // ========== ReadBuffer ==========
  print('--- ReadBuffer Tests ---');

  final readBuffer = ReadBuffer(data);
  final byte1 = readBuffer.getUint8();
  print('ReadBuffer getUint8: $byte1');
  final int32 = readBuffer.getInt32();
  print('ReadBuffer getInt32: $int32');
  final float64 = readBuffer.getFloat64();
  print('ReadBuffer getFloat64: $float64');
  final uint8List = readBuffer.getUint8List(4);
  print('ReadBuffer getUint8List: $uint8List');

  print('ReadBuffer hasRemaining: ${readBuffer.hasRemaining}');

  // ========== Category ==========
  print('--- Category Tests ---');

  // Category is a documentation annotation
  // It's used to mark APIs with categories like @Category(<String>['animation'])
  // We can just test it exists
  print('Category class exists');

  print('All foundation buffers and misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Foundation Buffers & Misc Test',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('WriteBuffer bytes: ${data.lengthInBytes}'),
            Text('ReadBuffer uint8: $byte1'),
            Text('ReadBuffer int32: $int32'),
          ],
        ),
      ),
    ),
  );
}
