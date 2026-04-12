// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ImageIcon Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'asset source checks',
    'theme integration',
    'size and color variants',
    'fallback behavior',
    'practical toolbar',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ImageIcon',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => Row(
                  children: [
                    const Icon(Icons.image_outlined),
                    const SizedBox(width: 10),
                    Expanded(child: Text(scene)),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}
