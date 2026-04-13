// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableNumN Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'nullable numeric state',
    'precision boundary',
    'step update policy',
    'restore lifecycle',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RestorableNumN')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(scenes[index]),
              ),
            );
          },
        ),
      ),
    ),
  );
}
