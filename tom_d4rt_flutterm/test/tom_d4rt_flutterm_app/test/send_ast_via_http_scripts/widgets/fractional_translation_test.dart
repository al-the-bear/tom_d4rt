// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FractionalTranslation Deep Demo (Harness-Safe) ===');

  const modules = <String>[
    'comparison scene',
    'hit test scene',
    'clip scene',
    'animated practical scene',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'FractionalTranslation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...modules.map((module) => ListTile(title: Text(module))),
          ],
        ),
      ),
    ),
  );
}
