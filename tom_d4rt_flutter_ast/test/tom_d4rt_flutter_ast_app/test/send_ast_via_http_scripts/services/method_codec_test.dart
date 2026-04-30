// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('=== MethodCodec Deep Demo (Harness-Safe) ===');

  final codec = const StandardMethodCodec();
  final originalCall = MethodCall('myMethod', <String, Object?>{'arg1': 'value1', 'arg2': 42});
  final encodedCall = codec.encodeMethodCall(originalCall);
  final decodedCall = codec.decodeMethodCall(encodedCall);

  final successEnvelope = codec.encodeSuccessEnvelope('result data');
  final decodedSuccess = codec.decodeEnvelope(successEnvelope);

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'MethodCodec',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(title: const Text('Method'), subtitle: Text(decodedCall.method)),
            ListTile(title: const Text('Arguments'), subtitle: Text('${decodedCall.arguments}')),
            ListTile(title: const Text('Decoded success'), subtitle: Text('$decodedSuccess')),
          ],
        ),
      ),
    ),
  );
}
