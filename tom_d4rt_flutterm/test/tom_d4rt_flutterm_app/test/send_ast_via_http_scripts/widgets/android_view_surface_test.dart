// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AndroidViewSurface Deep Demo (Harness-Safe) ===');

  const rows = <String, String>{
    'embedding': 'summary-only',
    'gesture recognizers': 'bridge-safe placeholder',
    'platform view': 'not instantiated in harness path',
  };

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'AndroidViewSurface',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...rows.entries.map(
              (entry) => ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
