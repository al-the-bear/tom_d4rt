// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RedoTextIntent Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'intent basics',
    'action routing',
    'history stack',
    'redo execution',
    'practical editor',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RedoTextIntent',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => ListTile(
                  leading: const Icon(Icons.redo),
                  title: Text(scene),
                )),
          ],
        ),
      ),
    ),
  );
}
