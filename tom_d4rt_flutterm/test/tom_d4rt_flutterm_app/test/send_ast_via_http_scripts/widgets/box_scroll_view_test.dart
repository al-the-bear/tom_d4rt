// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BoxScrollView Deep Demo (Harness-Safe) ===');

  final stripes = List<int>.generate(8, (index) => index + 1);

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'BoxScrollView',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...stripes.map(
              (value) => SizedBox(
                height: 44,
                child: Card(
                  child: Center(child: Text('Row $value')),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
