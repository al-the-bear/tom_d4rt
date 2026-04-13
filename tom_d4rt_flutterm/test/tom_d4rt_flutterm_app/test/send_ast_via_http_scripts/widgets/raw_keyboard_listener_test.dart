// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RawKeyboardListener Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'focus bridge',
    'key stream',
    'shortcut path',
    'boundary checks',
    'practical workspace',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RawKeyboardListener',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => ListTile(title: Text(scene))),
          ],
        ),
      ),
    ),
  );
}
