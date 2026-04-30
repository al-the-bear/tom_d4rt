// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ProgressIndicator Deep Demo (Harness-Safe) ===');

  const progressValue = 0.67;

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Linear progress (numeric value)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              LinearProgressIndicator(value: progressValue),
              SizedBox(height: 8),
              Text('value=0.67 min=0 max=1'),
              SizedBox(height: 24),
              CircularProgressIndicator(value: progressValue),
            ],
          ),
        ),
      ),
    ),
  );
}
