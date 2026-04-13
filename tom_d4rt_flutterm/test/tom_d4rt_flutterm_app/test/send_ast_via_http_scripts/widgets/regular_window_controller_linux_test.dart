// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RegularWindowControllerLinux Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'linux controller init',
    'window lifecycle',
    'input bridge',
    'state updates',
    'practical lane',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RegularWindowControllerLinux',
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
