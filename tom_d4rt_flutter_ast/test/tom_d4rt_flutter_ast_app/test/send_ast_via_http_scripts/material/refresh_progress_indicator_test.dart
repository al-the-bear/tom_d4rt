// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RefreshProgressIndicator Deep Demo (Harness-Safe) ===');

  const progressValue = 0.5;

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Refresh progress indicator',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              RefreshProgressIndicator(value: progressValue),
              SizedBox(height: 8),
              Text('value=0.5 min=0 max=1'),
            ],
          ),
        ),
      ),
    ),
  );
}
