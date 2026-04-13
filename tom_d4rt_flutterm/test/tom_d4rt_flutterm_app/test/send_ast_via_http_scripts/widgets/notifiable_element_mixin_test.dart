// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NotifiableElementMixin Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'notification channels',
    'subscription lifecycle',
    'element updates',
    'dispatch matrix',
    'practical board',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Container(
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(scenes[index]),
            );
          },
        ),
      ),
    ),
  );
}
