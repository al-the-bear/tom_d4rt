// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Flex Deep Demo (Harness-Safe) ===');

  const rows = <String>[
    'alignment matrix',
    'flexible vs expanded',
    'baseline behavior',
    'clip and practical',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Flex',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...rows.map((row) => SizedBox(height: 56, child: Card(child: Center(child: Text(row))))),
          ],
        ),
      ),
    ),
  );
}
