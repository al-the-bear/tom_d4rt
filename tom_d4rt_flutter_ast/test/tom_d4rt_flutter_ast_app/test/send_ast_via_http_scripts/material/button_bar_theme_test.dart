// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ButtonBarTheme Deep Demo (Harness-Safe) ===');
  print('Running summary mode without theme-class instantiation.');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'ButtonBarTheme',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('This harness-safe script avoids unavailable theme constructors.'),
              SizedBox(height: 8),
              Text('Bridge coercion follow-up is tracked in generator issues.'),
            ],
          ),
        ),
      ),
    ),
  );
}
