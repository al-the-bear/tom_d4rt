// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ConstrainedLayoutBuilder Deep Demo (Harness-Safe) ===');

  final cards = List<String>.generate(6, (index) => 'Layout card ${index + 1}');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'ConstrainedLayoutBuilder',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...cards.map(
                (title) => SizedBox(
                  height: 64,
                  child: Card(child: Center(child: Text(title))),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
