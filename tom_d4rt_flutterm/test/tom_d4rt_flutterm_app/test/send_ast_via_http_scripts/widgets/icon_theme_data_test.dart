// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== IconThemeData Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'fundamentals',
    'merge and copy',
    'lerp transitions',
    'precedence rules',
    'practical dashboard',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'IconThemeData',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => Card(child: ListTile(title: Text(scene)))),
          ],
        ),
      ),
    ),
  );
}
