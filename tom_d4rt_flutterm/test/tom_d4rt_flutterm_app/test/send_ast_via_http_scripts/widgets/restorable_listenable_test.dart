// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableListenable Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'listenable lifecycle',
    'listener registration',
    'change notification',
    'restore handoff',
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
                color: Colors.teal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
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
