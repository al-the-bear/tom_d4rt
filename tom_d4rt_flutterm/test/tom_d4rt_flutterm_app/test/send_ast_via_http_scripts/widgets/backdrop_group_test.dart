// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BackdropGroup Deep Demo (Harness-Safe) ===');

  const layers = <String>[
    'foreground pane',
    'back layer summary',
    'group composition preview',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'BackdropGroup',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...layers.map((layer) => Card(child: ListTile(title: Text(layer)))),
          ],
        ),
      ),
    ),
  );
}
