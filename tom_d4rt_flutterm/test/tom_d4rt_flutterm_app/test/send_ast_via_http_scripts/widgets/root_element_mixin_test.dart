// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RootElementMixin Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'root attachment',
    'element traversal',
    'lifecycle snapshot',
    'rebuild trigger',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RootElementMixin')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.teal.shade300),
              ),
              child: Text('${index + 1}. ${scenes[index]}'),
            );
          },
        ),
      ),
    ),
  );
}
