// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TimePickerEntryMode Deep Demo (Harness-Safe) ===');

  final modes = TimePickerEntryMode.values;
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
              'TimePickerEntryMode',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...modes.map((m) => ListTile(title: Text(m.name))),
            const SizedBox(height: 12),
            FilledButton(onPressed: null, child: Text('Input mode preview')),
            SizedBox(height: 8),
            OutlinedButton(onPressed: null, child: Text('Dial mode preview')),
          ],
        ),
      ),
    ),
  );
}
