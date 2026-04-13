// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableBoolN Deep Demo (Harness-Safe) ===');

  const checks = <String>[
    'null restoration state',
    'default fallback policy',
    'toggle event recording',
    'serialization preview',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RestorableBoolN')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: checks.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepOrange.shade200),
              ),
              child: Text('${index + 1}. ${checks[index]}'),
            );
          },
        ),
      ),
    ),
  );
}
