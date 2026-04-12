// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== LiveTextInputStatus Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'status probe',
    'value transitions',
    'focus handoff',
    'guard rail checks',
    'practical monitor',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const Icon(Icons.keyboard_alt_outlined),
                const SizedBox(width: 10),
                Expanded(child: Text(scenes[index])),
              ],
            );
          },
        ),
      ),
    ),
  );
}
