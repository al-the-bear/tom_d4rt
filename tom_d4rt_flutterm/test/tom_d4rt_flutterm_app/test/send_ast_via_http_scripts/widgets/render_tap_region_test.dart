// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderTapRegion Deep Demo (Harness-Safe) ===');

  const scenarios = <String>[
    'basic registration',
    'nested regions',
    'gesture arbitration',
    'focus + semantics',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenarios.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(scenarios[index]),
                  trailing: const Icon(Icons.touch_app_outlined),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
