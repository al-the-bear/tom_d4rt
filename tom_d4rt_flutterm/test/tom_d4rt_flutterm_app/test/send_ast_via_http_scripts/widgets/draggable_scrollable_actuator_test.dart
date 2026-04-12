// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DraggableScrollableActuator Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'single actuator scene',
    'controller vs actuator',
    'return-value probe',
    'scoped actuator',
    'practical pattern',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'DraggableScrollableActuator',
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
