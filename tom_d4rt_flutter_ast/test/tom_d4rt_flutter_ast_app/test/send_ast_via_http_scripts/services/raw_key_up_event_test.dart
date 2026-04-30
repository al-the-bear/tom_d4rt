// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RawKeyUpEvent Deep Demo (Harness-Safe) ===');

  const stages = <String>[
    'RawKeyDownEvent',
    'repeat xN',
    'RawKeyUpEvent',
  ];

  const notes = <String>[
    'Legacy raw keyboard lifecycle summary.',
    'Scenario intentionally uses bounded layout containers.',
    'No unbounded flex/paragraph composition in this harness path.',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RawKeyUpEvent',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...stages.map((stage) => Chip(label: Text(stage))),
            const SizedBox(height: 12),
            ...notes.map((note) => ListTile(title: Text(note))),
          ],
        ),
      ),
    ),
  );
}
