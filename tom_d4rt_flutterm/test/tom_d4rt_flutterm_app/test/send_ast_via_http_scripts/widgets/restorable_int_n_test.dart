// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RestorableIntN Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'nullable integer state',
    'step policy',
    'bounds behavior',
    'restoration replay',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RestorableIntN')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(scenes[index]),
            );
          },
        ),
      ),
    ),
  );
}
