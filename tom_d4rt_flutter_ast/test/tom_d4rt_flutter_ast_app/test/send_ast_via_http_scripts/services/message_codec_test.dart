// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('=== MessageCodec Deep Demo (Harness-Safe) ===');

  final codec = StandardMessageCodec();
  final payloads = <Object?>[
    'Hello World',
    42,
    3.14159,
    <Object?>[1, 2, 'three'],
    <String, Object?>{'key': 'value', 'count': 2},
  ];

  final decodedLabels = <String>[];
  for (final payload in payloads) {
    final encoded = codec.encodeMessage(payload);
    final decoded = codec.decodeMessage(encoded);
    decodedLabels.add('${decoded.runtimeType}: $decoded');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'MessageCodec',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...decodedLabels.map((line) => ListTile(title: Text(line))),
          ],
        ),
      ),
    ),
  );
}
