// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('=== RenderAndroidView Deep Demo (Harness-Safe) ===');

  final values = PlatformViewHitTestBehavior.values;
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
              'PlatformViewHitTestBehavior',
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
