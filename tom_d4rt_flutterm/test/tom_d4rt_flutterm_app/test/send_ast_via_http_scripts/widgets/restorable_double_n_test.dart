// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableDoubleN Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'nullable double state',
    'precision policy',
    'increment/decrement flow',
    'restore snapshot',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text('${index + 1}. ${scenes[index]}'),
            );
          },
        ),
      ),
    ),
  );
}
