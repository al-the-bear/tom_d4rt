// D4rt test script: Tests MessageCodec from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('MessageCodec test executing');
  print('=' * 50);

  // MessageCodec is abstract - test via StandardMessageCodec
  final standardCodec = StandardMessageCodec();
  print('\nStandardMessageCodec (MessageCodec impl):');
  print('runtimeType: ${standardCodec.runtimeType}');
  print('is MessageCodec: ${standardCodec is MessageCodec}');

  // Test encodeMessage and decodeMessage with various types
  print('\nEncode/Decode primitives:');

  // String
  final stringBytes = standardCodec.encodeMessage('Hello World');
  print('String encoded: ${stringBytes?.lengthInBytes} bytes');
  final decodedString = standardCodec.decodeMessage(stringBytes);
  print('Decoded string: $decodedString');

  // Integer
  final intBytes = standardCodec.encodeMessage(42);
  print('Int encoded: ${intBytes?.lengthInBytes} bytes');
  final decodedInt = standardCodec.decodeMessage(intBytes);
  print('Decoded int: $decodedInt');

  // Double
  final doubleBytes = standardCodec.encodeMessage(3.14159);
  print('Double encoded: ${doubleBytes?.lengthInBytes} bytes');
  final decodedDouble = standardCodec.decodeMessage(doubleBytes);
  print('Decoded double: $decodedDouble');

  // List
  final listBytes = standardCodec.encodeMessage([1, 2, 3, 'four', 5.0]);
  print('List encoded: ${listBytes?.lengthInBytes} bytes');
  final decodedList = standardCodec.decodeMessage(listBytes);
  print('Decoded list: $decodedList');

  // Map
  final mapBytes = standardCodec.encodeMessage({'key': 'value', 'number': 42});
  print('Map encoded: ${mapBytes?.lengthInBytes} bytes');
  final decodedMap = standardCodec.decodeMessage(mapBytes);
  print('Decoded map: $decodedMap');

  // Test other codec implementations
  print('\nOther MessageCodec implementations:');
  final stringCodec = StringCodec();
  final jsonCodec = JSONMessageCodec();
  final binaryCodec = BinaryCodec();
  print('StringCodec: ${stringCodec.runtimeType}');
  print('JSONMessageCodec: ${jsonCodec.runtimeType}');
  print('BinaryCodec: ${binaryCodec.runtimeType}');

  // StringCodec example
  print('\nStringCodec example:');
  final stringEncoded = stringCodec.encodeMessage('Text message');
  final stringDecoded = stringCodec.decodeMessage(stringEncoded);
  print('Encoded bytes: ${stringEncoded?.lengthInBytes}');
  print('Decoded: $stringDecoded');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'StandardMessageCodec is MessageCodec: ${standardCodec is MessageCodec}',
  );
  print('StringCodec is MessageCodec: ${stringCodec is MessageCodec}');

  // Explain purpose
  print('\nMessageCodec purpose:');
  print('- Abstract base for message encoding/decoding');
  print('- encodeMessage(T?): Convert message to ByteData');
  print('- decodeMessage(ByteData?): Convert ByteData to T?');
  print('- Used by BasicMessageChannel');
  print('- StandardMessageCodec supports Dart primitives');
  print('- Enables platform channel communication');

  print('\n' + '=' * 50);
  print('MessageCodec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MessageCodec Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract base'),
      Text('Impl: StandardMessageCodec'),
      Text('String: "$decodedString"'),
      Text('Int: $decodedInt'),
      Text('Purpose: Message encoding'),
    ],
  );
}
