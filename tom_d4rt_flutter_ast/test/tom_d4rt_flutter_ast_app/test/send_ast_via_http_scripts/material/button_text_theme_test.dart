// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ButtonTextTheme Deep Demo (Harness-Safe) ===');

  final values = ButtonTextTheme.values;
  for (final v in values) {
    print('  ${v.index}: ${v.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ButtonTextTheme',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
              const SizedBox(height: 12),
              const Text('Resolved in harness-safe mode with non-null value rendering.'),
            ],
          ),
        ),
      ),
    ),
  );
}
