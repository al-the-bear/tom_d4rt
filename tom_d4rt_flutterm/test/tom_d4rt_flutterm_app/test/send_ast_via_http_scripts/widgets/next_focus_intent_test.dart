// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NextFocusIntent Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'intent primer',
    'focus chain',
    'directional hops',
    'guard conditions',
    'practical shortcuts',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: scenes.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const Icon(Icons.keyboard_tab),
                const SizedBox(width: 10),
                Expanded(child: Text(scenes[index])),
              ],
            );
          },
        ),
      ),
    ),
  );
}
