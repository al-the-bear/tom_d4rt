// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RegularWindowControllerWin32 Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'win32 controller init',
    'window lifecycle',
    'message bridge',
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
              'RegularWindowControllerWin32',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scenes.map((scene) => ListTile(
                  leading: const Icon(Icons.desktop_windows_outlined),
                  title: Text(scene),
                )),
          ],
        ),
      ),
    ),
  );
}
