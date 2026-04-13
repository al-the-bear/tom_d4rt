// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RepeatMode Deep Demo (Harness-Safe) ===');

  const scenarios = <String>[
    'restart cycle',
    'reverse cycle',
    'pause and resume',
    'duration mapping',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RepeatMode')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenarios.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(scenarios[index]),
              ),
            );
          },
        ),
      ),
    ),
  );
}
