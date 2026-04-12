// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AxisDirection Deep Demo (Harness-Safe) ===');

  final values = AxisDirection.values;
  for (final v in values) {
    print('  ${v.index}: ${v.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'AxisDirection',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...values.map((v) => ListTile(title: Text(v.name))),
          ],
        ),
      ),
    ),
  );
}
