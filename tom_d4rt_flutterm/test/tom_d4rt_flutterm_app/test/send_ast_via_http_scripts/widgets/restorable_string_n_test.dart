// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableStringN Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'nullable string state',
    'input normalization',
    'history checkpoint',
    'restore hydration',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(scenes[index]),
                subtitle: Text('Step ${index + 1}'),
              ),
            );
          },
        ),
      ),
    ),
  );
}
