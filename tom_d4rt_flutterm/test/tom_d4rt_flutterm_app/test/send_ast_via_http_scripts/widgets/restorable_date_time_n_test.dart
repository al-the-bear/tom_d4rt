// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableDateTimeN Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'null value semantics',
    'restore timestamp baseline',
    'timezone presentation',
    'serialization lifecycle',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RestorableDateTimeN')),
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
