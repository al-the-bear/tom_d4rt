// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ActionListener Deep Demo (Harness-Safe) ===');

  const actions = <String>[
    'ActivateIntent',
    'DoNothingIntent',
    'DismissIntent',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ActionListener',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...actions.map((action) => ListTile(title: Text(action))),
          ],
        ),
      ),
    ),
  );
}
