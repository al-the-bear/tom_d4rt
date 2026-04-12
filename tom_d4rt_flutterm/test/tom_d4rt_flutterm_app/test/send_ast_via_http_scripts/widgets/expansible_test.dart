// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Expansible Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'controller api scene',
    'maintain state scene',
    'custom builder scene',
    'page storage scene',
    'practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Expansible',
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
