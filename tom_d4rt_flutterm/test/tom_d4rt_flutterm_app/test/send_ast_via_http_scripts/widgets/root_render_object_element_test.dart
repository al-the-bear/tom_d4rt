// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RootRenderObjectElement Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'root element wiring',
    'render object pairing',
    'lifecycle order',
    'rebuild observations',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RootRenderObjectElement')),
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
