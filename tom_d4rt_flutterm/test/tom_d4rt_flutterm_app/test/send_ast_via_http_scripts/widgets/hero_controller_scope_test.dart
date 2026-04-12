// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== HeroControllerScope Deep Demo (Harness-Safe) ===');

  const lanes = <String>[
    'scope introspection',
    'single scoped navigator',
    'scope boundary',
    'parallel navigator',
    'practical workspace',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'HeroControllerScope',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...lanes.map((lane) => Card(child: ListTile(title: Text(lane)))),
          ],
        ),
      ),
    ),
  );
}
