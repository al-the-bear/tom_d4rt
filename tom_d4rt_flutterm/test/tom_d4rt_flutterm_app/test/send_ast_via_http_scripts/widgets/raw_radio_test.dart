// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RawRadio Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'group setup',
    'toggle behavior',
    'focus integration',
    'value mapping',
    'practical controls',
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
                const Icon(Icons.radio_button_checked),
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
