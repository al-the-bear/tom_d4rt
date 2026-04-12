// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== LockState Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'lock contract',
    'state transitions',
    'unlock boundary',
    'diagnostics lane',
    'practical board',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'LockState',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: Text(scene),
                )),
          ],
        ),
      ),
    ),
  );
}
