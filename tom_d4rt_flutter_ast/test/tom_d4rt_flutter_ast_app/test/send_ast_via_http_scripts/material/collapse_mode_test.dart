// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== CollapseMode Deep Demo (Harness-Safe) ===');

  final values = CollapseMode.values;
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
                'CollapseMode',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Valid non-null labels are always provided in this script.'),
              const SizedBox(height: 8),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
            ],
          ),
        ),
      ),
    ),
  );
}
