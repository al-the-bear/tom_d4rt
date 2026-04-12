// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== OverScrollHeaderStretchConfiguration Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Over-scroll Header Stretch',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Widget-boundary coercion path avoided in this stable summary.'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
