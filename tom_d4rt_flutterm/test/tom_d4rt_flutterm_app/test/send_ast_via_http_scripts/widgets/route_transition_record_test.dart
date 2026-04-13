// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RouteTransitionRecord Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'transition state map',
    'enter/exit sequence',
    'animation handoff',
    'completion checkpoint',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RouteTransitionRecord')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: 0.08),
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
