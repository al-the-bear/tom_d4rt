// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ScrollDecelerationRate Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'platform profile',
    'velocity damping',
    'gesture transfer',
    'distance projection',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollDecelerationRate')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.08),
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
