// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderAbstractViewport Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text(
              'Render Abstract Viewport',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Viewport')),
                Chip(label: Text('Bounded')),
                Chip(label: Text('No overflow')),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
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
