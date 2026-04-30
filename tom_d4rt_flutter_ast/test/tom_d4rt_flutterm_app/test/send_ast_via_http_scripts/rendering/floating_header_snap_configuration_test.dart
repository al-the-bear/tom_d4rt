// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FloatingHeaderSnapConfiguration Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text(
              'Floating Header Snap Configuration',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('Bounded scrolling summary layout to avoid overflow.'),
            SizedBox(height: 8),
            Card(child: Padding(padding: EdgeInsets.all(12), child: Text('Snap preview'))),
          ],
        ),
      ),
    ),
  );
}
