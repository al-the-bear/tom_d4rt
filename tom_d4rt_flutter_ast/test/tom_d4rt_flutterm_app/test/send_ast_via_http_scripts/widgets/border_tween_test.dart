// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BorderTween Deep Demo (Harness-Safe) ===');

  final borders = <BoxBorder>[
    Border.all(color: Colors.blue, width: 2),
    Border.all(color: Colors.green, width: 3),
    Border.all(color: Colors.orange, width: 1),
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'BorderTween',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...borders.map(
              (border) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: border,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
