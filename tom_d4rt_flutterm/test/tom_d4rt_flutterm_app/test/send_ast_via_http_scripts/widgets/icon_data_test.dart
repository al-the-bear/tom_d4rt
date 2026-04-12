// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== IconData Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'code point composer',
    'equality and hash',
    'directionality mapping',
    'family fallback',
    'practical registry',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'IconData',
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
