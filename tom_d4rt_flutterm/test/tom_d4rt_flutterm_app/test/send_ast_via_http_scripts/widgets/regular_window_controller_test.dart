// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RegularWindowController Deep Demo (Harness-Safe) ===');

  const scenes = <String>[
    'controller overview',
    'platform strategy',
    'event routing',
    'state matrix',
    'practical board',
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
                const Icon(Icons.window_outlined),
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
