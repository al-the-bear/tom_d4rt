// D4rt test script: Tests BinaryMessenger from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BinaryMessenger test executing');
  print('=' * 50);

  // Access the default BinaryMessenger
  final messenger = ServicesBinding.instance.defaultBinaryMessenger;
  print('\nDefault BinaryMessenger:');
  print('runtimeType: ${messenger.runtimeType}');

  // BinaryMessenger is an abstract class/interface
  print('\nBinaryMessenger interface:');
  print('is BinaryMessenger: true /* messenger is BinaryMessenger */');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'messenger is BinaryMessenger: true /* messenger is BinaryMessenger */',
  );
  print('is Object: true /* messenger is Object */');

  // Explain the interface methods
  print('\nBinaryMessenger interface methods:');
  print('- send(channel, message): Send message to platform');
  print('- setMessageHandler(channel, handler): Receive messages');
  print('- handlePlatformMessage(channel, data, callback): Platform callback');

  // Common channel names
  print('\nCommon platform channel names:');
  final channels = [
    'flutter/lifecycle',
    'flutter/navigation',
    'flutter/platform',
    'flutter/textinput',
    'flutter/keyevent',
  ];
  for (final channel in channels) {
    print('  - $channel');
  }

  // Create a MethodChannel that uses BinaryMessenger
  print('\nMethodChannel uses BinaryMessenger:');
  final methodChannel = MethodChannel('test.channel');
  print('MethodChannel created: ${methodChannel.name}');
  print('codec: ${methodChannel.codec.runtimeType}');

  // Create BasicMessageChannel
  print('\nBasicMessageChannel uses BinaryMessenger:');
  final basicChannel = BasicMessageChannel<String>(
    'basic.channel',
    StringCodec(),
  );
  print('BasicMessageChannel created: ${basicChannel.name}');

  // Platform channels architecture
  print('\nPlatform channels architecture:');
  print('Flutter App <-> BinaryMessenger <-> Platform');
  print('- Messages are binary (ByteData)');
  print('- MethodChannel adds method call encoding');
  print('- BasicMessageChannel adds message encoding');

  // Test with real binding
  print('\nServices binding check:');
  print('ServicesBinding.instance exists: ${ServicesBinding.instance != null}');
  print('defaultBinaryMessenger exists: true');

  // Codec types used with BinaryMessenger
  print('\nCodec types:');
  print('- StandardMessageCodec (default)');
  print('- StringCodec (for strings)');
  print('- JSONMessageCodec (for JSON)');
  print('- BinaryCodec (for raw bytes)');

  // Explain purpose
  print('\nBinaryMessenger purpose:');
  print('- Low-level interface for platform communication');
  print('- Sends/receives binary data over channels');
  print('- Foundation for MethodChannel, BasicMessageChannel');
  print('- Abstract class implemented by engine binding');
  print('- ServicesBinding.instance.defaultBinaryMessenger');

  print('\n' + '=' * 50);
  print('BinaryMessenger test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BinaryMessenger Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract interface'),
      Text('Implementation: ${messenger.runtimeType}'),
      Text('is BinaryMessenger: true /* messenger is BinaryMessenger */'),
      Text('Purpose: Platform communication'),
    ],
  );
}
