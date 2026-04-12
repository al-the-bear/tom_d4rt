// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== LookupBoundary Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'boundary visibility',
    'inherited scope',
    'state lookup',
    'traversal render',
    'practical sandbox',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'LookupBoundary',
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
