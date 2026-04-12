// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TimeOfDayFormat Deep Demo (Harness-Safe) ===');

  final formats = TimeOfDayFormat.values;
  for (final f in formats) {
    print('  ${f.index}: ${f.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'TimeOfDayFormat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...formats.map((f) => ListTile(title: Text(f.name))),
          ],
        ),
      ),
    ),
  );
}
