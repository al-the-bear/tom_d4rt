// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== OrientationBuilder Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'fundamentals',
    'adaptive shell',
    'viewport lab',
    'reflow matrix',
    'practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'OrientationBuilder',
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
