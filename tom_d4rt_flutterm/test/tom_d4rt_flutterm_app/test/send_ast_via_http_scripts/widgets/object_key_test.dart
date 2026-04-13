// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ObjectKey Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'identity semantics',
    'stable references',
    'diff tracking',
    'list updates',
    'practical board',
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
