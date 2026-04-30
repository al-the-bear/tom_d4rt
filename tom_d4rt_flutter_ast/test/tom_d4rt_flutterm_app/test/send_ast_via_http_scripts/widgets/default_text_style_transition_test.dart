// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DefaultTextStyleTransition Deep Demo (Harness-Safe) ===');

  const styles = <TextStyle>[
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'DefaultTextStyleTransition',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...styles.map(
              (style) => DefaultTextStyle(
                style: style,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('Transition style preview'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
