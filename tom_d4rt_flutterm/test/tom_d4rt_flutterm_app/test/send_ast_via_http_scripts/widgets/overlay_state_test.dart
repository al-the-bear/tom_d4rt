// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== OverlayState Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'entry management',
    'rearrange flow',
    'state access',
    'property checks',
    'practical scene',
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
