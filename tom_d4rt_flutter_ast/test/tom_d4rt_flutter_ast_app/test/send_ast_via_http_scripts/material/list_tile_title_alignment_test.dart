// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ListTileTitleAlignment Deep Demo (Harness-Safe) ===');

  final values = ListTileTitleAlignment.values;
  for (final v in values) {
    print('  ${v.index}: ${v.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ListTileTitleAlignment',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...values.map(
              (v) => ListTile(
                dense: true,
                titleAlignment: v,
                leading: const Icon(Icons.label_outline),
                title: Text('Alignment: ${v.name}'),
                subtitle: const Text('Bounded list tile preview.'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
