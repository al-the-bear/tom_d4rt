// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MetaData Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'fundamentals',
    'overlap behavior',
    'hover inspector',
    'catalog',
    'practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Card(child: ListTile(title: Text(scenes[index])));
          },
        ),
      ),
    ),
  );
}
