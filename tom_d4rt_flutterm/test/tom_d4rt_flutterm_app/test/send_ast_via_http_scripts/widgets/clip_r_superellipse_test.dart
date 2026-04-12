// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ClipRSuperellipse Deep Demo (Harness-Safe) ===');

  const scales = <double>[0.8, 1.0, 1.2];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'ClipRSuperellipse',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...scales.map(
              (scale) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text('pulse scale: $scale'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
