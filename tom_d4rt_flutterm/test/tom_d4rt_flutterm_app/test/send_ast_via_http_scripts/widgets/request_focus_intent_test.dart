// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RequestFocusIntent Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'intent declaration',
    'focus target map',
    'keyboard trigger',
    'state handoff',
    'practical validation',
  ];

  return MaterialApp(
    home: Scaffold(
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
