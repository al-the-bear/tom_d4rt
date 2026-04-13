// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableNum Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'numeric seed state',
    'clamp behavior',
    'delta operations',
    'restore replay',
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
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Text('${index + 1}. ${scenes[index]}'),
            );
          },
        ),
      ),
    ),
  );
}
