// D4rt test script: Tests BasicMessageChannel, EventChannel, OptionalMethodChannel, MethodChannel, MethodCall from services
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services channels test executing');

  // ========== METHODCALL ==========
  print('--- MethodCall Tests ---');

  final call1 = MethodCall('testMethod');
  print('MethodCall("testMethod"):');
  print('  method: ${call1.method}');
  print('  arguments: ${call1.arguments}');
  print('  runtimeType: ${call1.runtimeType}');

  final call2 = MethodCall('getData', {'id': 42, 'name': 'test'});
  print('MethodCall("getData", {id: 42, name: "test"}):');
  print('  method: ${call2.method}');
  print('  arguments: ${call2.arguments}');

  final call3 = MethodCall('processList', [1, 2, 3, 'four']);
  print('MethodCall("processList", [1, 2, 3, "four"]):');
  print('  method: ${call3.method}');
  print('  arguments: ${call3.arguments}');

  final callNoArgs = MethodCall('ping');
  print('MethodCall("ping"):');
  print('  method: ${callNoArgs.method}');
  print('  arguments: ${callNoArgs.arguments}');

  // MethodCall toString
  print('MethodCall.toString: ${call2.toString()}');

  // ========== METHODCHANNEL ==========
  print('--- MethodChannel Tests ---');

  final methodChannel = MethodChannel('com.example.test/method');
  print('MethodChannel created');
  print('  name: ${methodChannel.name}');
  print('  codec: ${methodChannel.codec.runtimeType}');
  print('  runtimeType: ${methodChannel.runtimeType}');

  final methodChannel2 = MethodChannel(
    'com.example.test/custom',
    JSONMethodCodec(),
  );
  print('MethodChannel with JSONMethodCodec:');
  print('  name: ${methodChannel2.name}');
  print('  codec: ${methodChannel2.codec.runtimeType}');

  // Set method call handler
  methodChannel.setMethodCallHandler((MethodCall call) async {
    print('  Handler received: ${call.method}');
    return 'response';
  });
  print('Method call handler set');

  // ========== OPTIONALMETHODCHANNEL ==========
  print('--- OptionalMethodChannel Tests ---');

  final optionalChannel = OptionalMethodChannel('com.example.test/optional');
  print('OptionalMethodChannel created');
  print('  name: ${optionalChannel.name}');
  print('  codec: ${optionalChannel.codec.runtimeType}');
  print('  runtimeType: ${optionalChannel.runtimeType}');

  // ========== BASICMESSAGECHANNEL ==========
  print('--- BasicMessageChannel Tests ---');

  final basicChannel = BasicMessageChannel<String>(
    'com.example.test/basic',
    StringCodec(),
  );
  print('BasicMessageChannel<String> created');
  print('  name: ${basicChannel.name}');
  print('  codec: ${basicChannel.codec.runtimeType}');
  print('  runtimeType: ${basicChannel.runtimeType}');

  final jsonBasicChannel = BasicMessageChannel<dynamic>(
    'com.example.test/json_basic',
    JSONMessageCodec(),
  );
  print('BasicMessageChannel<dynamic> with JSON created');
  print('  name: ${jsonBasicChannel.name}');
  print('  codec: ${jsonBasicChannel.codec.runtimeType}');

  // Set message handler
  basicChannel.setMessageHandler((String? message) async {
    print('  Basic handler received: $message');
    return 'reply';
  });
  print('Basic message handler set');

  // ========== EVENTCHANNEL ==========
  print('--- EventChannel Tests ---');

  final eventChannel = EventChannel('com.example.test/events');
  print('EventChannel created');
  print('  name: ${eventChannel.name}');
  print('  codec: ${eventChannel.codec.runtimeType}');
  print('  runtimeType: ${eventChannel.runtimeType}');

  final jsonEventChannel = EventChannel(
    'com.example.test/json_events',
    JSONMethodCodec(),
  );
  print('EventChannel with JSONMethodCodec:');
  print('  name: ${jsonEventChannel.name}');
  print('  codec: ${jsonEventChannel.codec.runtimeType}');

  // ========== CHANNEL NAMING CONVENTIONS ==========
  print('--- Channel Naming Conventions ---');

  print('Platform channels use reverse domain naming:');
  print('  com.example.app/method_name');
  print('  io.flutter.plugins/plugin_name');
  print('Common Flutter channels:');
  print('  flutter/platform - platform events');
  print('  flutter/navigation - route navigation');
  print('  flutter/lifecycle - app lifecycle');

  // ========== RETURN WIDGET ==========
  print('Services channels test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Channels Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('Classes Tested:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• MethodCall - method invocation data'),
          Text('• MethodChannel - bidirectional method calls'),
          Text('• OptionalMethodChannel - nullable methods'),
          Text('• BasicMessageChannel - simple messaging'),
          Text('• EventChannel - event streams'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF3E5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Channel Names:'),
                Text('  MethodChannel: ${methodChannel.name}'),
                Text('  OptionalMethodChannel: ${optionalChannel.name}'),
                Text('  BasicMessageChannel: ${basicChannel.name}'),
                Text('  EventChannel: ${eventChannel.name}'),
                SizedBox(height: 8.0),
                Text('MethodCall: ${call2.method}(${call2.arguments})'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
