// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ModalBarrier Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'fundamentals',
    'blocking lab',
    'workflow stage',
    'matrix scene',
    'practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ModalBarrier',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: Text(scene),
                )),
          ],
        ),
      ),
    ),
  );
}
