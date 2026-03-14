// D4rt test script: Tests MethodCodec from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MethodCodec test executing');

  // MethodCodec is abstract - test via StandardMethodCodec
  final codec = StandardMethodCodec();
  print('StandardMethodCodec: ${codec.runtimeType}');
  print('is MethodCodec: ${codec is MethodCodec}');

  // Test encoding method call
  print('\nEncoding method call:');
  final call = MethodCall('myMethod', {'arg1': 'value1', 'arg2': 42});
  print('MethodCall: ${call.method}');
  print('arguments: ${call.arguments}');

  final encoded = codec.encodeMethodCall(call);
  print('Encoded length: ${encoded.lengthInBytes} bytes');

  // Test decoding
  print('\nDecoding method call:');
  final decoded = codec.decodeMethodCall(encoded);
  print('Decoded method: ${decoded.method}');
  print('Decoded args: ${decoded.arguments}');

  // Test encoding success result
  print('\nEncoding success result:');
  final successResult = codec.encodeSuccessEnvelope('result data');
  print('Success envelope length: ${successResult.lengthInBytes} bytes');

  // Explain MethodCodec
  print('\nMethodCodec purpose:');
  print('- Encodes/decodes platform channel messages');
  print('- Used by MethodChannel');
  print('- StandardMethodCodec uses StandardMessageCodec');
  print('- JSONMethodCodec uses JSON encoding');

  // Codec implementations
  print('\nCodec implementations:');
  print('- StandardMethodCodec: binary, efficient');
  print('- JSONMethodCodec: JSON, readable');

  print('\nMethodCodec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MethodCodec Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Platform channel encoding'),
      Text('Method: ${decoded.method}'),
      Text('Args: ${decoded.arguments}'),
      Text('Impl: StandardMethodCodec'),
    ],
  );
}
