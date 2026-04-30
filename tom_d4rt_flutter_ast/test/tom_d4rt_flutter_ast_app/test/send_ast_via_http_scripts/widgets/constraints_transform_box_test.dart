// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ConstraintsTransformBox Deep Demo (Harness-Safe) ===');

  const configs = <String>[
    'identity transform',
    'tighten constraints',
    'loosen constraints',
    'bounded transform preview',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ConstraintsTransformBox',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...configs.map(
              (item) => SizedBox(
                height: 52,
                child: Card(child: Center(child: Text(item))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
