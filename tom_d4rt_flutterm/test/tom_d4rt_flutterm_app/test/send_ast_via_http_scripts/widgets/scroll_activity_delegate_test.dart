// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ScrollActivityDelegate Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'delegate contract',
    'activity lifecycle',
    'position handoff',
    'idle transition',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollActivityDelegate')),
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
