// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderAnimatedSizeState Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text(
              'Animated Size State',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              child: SizedBox(
                height: 80,
                child: Card(child: Center(child: Text('Stable native widget child'))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
