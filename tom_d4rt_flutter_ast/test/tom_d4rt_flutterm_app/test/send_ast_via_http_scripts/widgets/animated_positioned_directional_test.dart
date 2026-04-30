// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AnimatedPositionedDirectional Deep Demo (Harness-Safe) ===');

  const states = <String>[
    'start: 8, top: 8',
    'start: 24, top: 16',
    'start: 48, top: 24',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'AnimatedPositionedDirectional',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...states.map((state) => ListTile(title: Text(state))),
          ],
        ),
      ),
    ),
  );
}
