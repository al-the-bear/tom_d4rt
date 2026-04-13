// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderNestedScrollViewViewport Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'viewport anatomy',
    'overlap contract',
    'anchor behavior',
    'clip boundaries',
    'practical lane',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
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
