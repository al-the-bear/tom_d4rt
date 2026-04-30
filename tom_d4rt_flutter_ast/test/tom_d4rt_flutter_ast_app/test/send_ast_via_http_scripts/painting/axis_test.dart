// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Axis Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Axis Layout',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Horizontal')),
                Chip(label: Text('Vertical')),
                Chip(label: Text('Bounded')),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(child: ColoredBox(color: Colors.blueGrey)),
                  SizedBox(width: 8),
                  Expanded(child: ColoredBox(color: Colors.teal)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
