// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ThemeMode Deep Demo (Harness-Safe) ===');

  final modes = ThemeMode.values;
  for (final m in modes) {
    print('  ${m.index}: ${m.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ThemeMode',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...modes.map(
              (m) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Mode: ${m.name}'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
