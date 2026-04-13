// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ReplaceTextIntent Deep Demo (Harness-Safe) ===');

  const steps = <String>[
    'selection capture',
    'replacement planning',
    'intent dispatch',
    'cursor recovery',
    'practical output',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: steps.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.indigo.withValues(alpha: 0.08),
              ),
              child: Text('${index + 1}. ${steps[index]}'),
            );
          },
        ),
      ),
    ),
  );
}
