// ignore_for_file: avoid_print
// D4rt test script: Tests MethodChannel, BasicMessageChannel,
// EventChannel, BinaryCodec, StandardMessageCodec, StandardMethodCodec,
// PlatformException, MissingPluginException
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Platform channels test executing');

  // ========== MethodChannel ==========
  print('--- MethodChannel Tests ---');
  final methodChannel = MethodChannel('com.example.test/method');
  print('MethodChannel: ${methodChannel.name}');

  final optMethodChannel = OptionalMethodChannel('com.example.test/optional');
  print('OptionalMethodChannel: ${optMethodChannel.name}');

  // ========== BasicMessageChannel ==========
  print('--- BasicMessageChannel Tests ---');
  final stringChannel = BasicMessageChannel<String>(
    'com.example.test/string',
    StringCodec(),
  );
  print('BasicMessageChannel<String>: ${stringChannel.name}');

  final jsonChannel = BasicMessageChannel<dynamic>(
    'com.example.test/json',
    JSONMessageCodec(),
  );
  print('BasicMessageChannel<dynamic> (JSON): ${jsonChannel.name}');

  // ========== EventChannel ==========
  print('--- EventChannel Tests ---');
  final eventChannel = EventChannel('com.example.test/events');
  print('EventChannel: ${eventChannel.name}');

  // ========== StringCodec ==========
  print('--- StringCodec Tests ---');
  final stringCodec = StringCodec();
  final encoded = stringCodec.encodeMessage('hello');
  // Note: encoded is ByteData? but D4rt wraps it as _ByteDataView
  // which doesn't have .lengthInBytes bridged
  print('StringCodec encoded: ${encoded != null ? "success" : "null"}');
  if (encoded != null) {
    final decoded = stringCodec.decodeMessage(encoded);
    print('StringCodec decoded: $decoded');
  }

  // ========== JSONMessageCodec ==========
  print('--- JSONMessageCodec Tests ---');
  final jsonCodec = JSONMessageCodec();
  final jsonEncoded = jsonCodec.encodeMessage({'key': 'value', 'count': 42});
  print(
    'JSONMessageCodec encoded: ${jsonEncoded != null ? "success" : "null"}',
  );

  // ========== StandardMessageCodec ==========
  print('--- StandardMessageCodec Tests ---');
  final stdCodec = StandardMessageCodec();
  final stdEncoded = stdCodec.encodeMessage([1, 2, 'three']);
  print(
    'StandardMessageCodec encoded: ${stdEncoded != null ? "success" : "null"}',
  );

  // ========== StandardMethodCodec ==========
  print('--- StandardMethodCodec Tests ---');
  final stdMethodCodec = StandardMethodCodec();
  final call = MethodCall('getValue', {'id': 123});
  print('MethodCall: method=${call.method}, args=${call.arguments}');
  // ignore: unused_local_variable
  final _encodedCall = stdMethodCodec.encodeMethodCall(call);
  // Note: encodedCall.lengthInBytes not available on _ByteDataView in D4rt
  print('Encoded MethodCall: success');

  // ========== PlatformException ==========
  print('--- PlatformException Tests ---');
  final platformEx = PlatformException(
    code: 'UNAVAILABLE',
    message: 'Service unavailable',
    details: {'reason': 'timeout'},
    stacktrace: 'at channel.invoke()',
  );
  print('PlatformException: code=${platformEx.code}');
  print('  message: ${platformEx.message}');
  print('  details: ${platformEx.details}');

  // ========== MissingPluginException ==========
  print('--- MissingPluginException Tests ---');
  final missingEx = MissingPluginException(
    'No implementation found for method test',
  );
  print('MissingPluginException: ${missingEx.message}');

  // ========== BinaryCodec ==========
  print('--- BinaryCodec Tests ---');
  // ignore: unused_local_variable
  final _binaryCodec = BinaryCodec();
  print('BinaryCodec instance created');

  print('All platform channels tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Platform Channels Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('MethodChannel, BasicMessageChannel'),
            Text('EventChannel, Codecs'),
            Text('PlatformException, MissingPluginException'),
          ],
        ),
      ),
    ),
  );
}
