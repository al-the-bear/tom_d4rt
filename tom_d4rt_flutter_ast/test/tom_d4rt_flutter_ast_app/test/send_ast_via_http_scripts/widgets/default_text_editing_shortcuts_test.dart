// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DefaultTextEditingShortcuts Deep Demo (Harness-Safe) ===');

  const rows = <String>[
    'Shortcut: Copy',
    'Shortcut: Paste',
    'Shortcut: Select All',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'DefaultTextEditingShortcuts',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...rows.map((row) => ListTile(title: Text(row))),
          ],
        ),
      ),
    ),
  );
}
