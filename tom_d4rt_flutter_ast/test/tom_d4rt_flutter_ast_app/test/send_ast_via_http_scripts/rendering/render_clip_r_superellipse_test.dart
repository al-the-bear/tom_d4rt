// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderClipRSuperellipse Deep Demo (Harness-Safe) ===');

  final labels = <String>['superellipse', 'clip', 'preview'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RenderClipRSuperellipse',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...labels.map((label) => ListTile(title: Text(label))),
          ],
        ),
      ),
    ),
  );
}
