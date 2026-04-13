// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderTapRegionSurface Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'surface overview',
    'hit test routing',
    'region grouping',
    'focus handoff',
    'practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RenderTapRegionSurface')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(scenes[index]),
              ),
            );
          },
        ),
      ),
    ),
  );
}
