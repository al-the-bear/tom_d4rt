// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PopupMenuPosition Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Center(
          child: PopupMenuButton<String>(
            itemBuilder: (ctx) => const [
              PopupMenuItem<String>(value: 'one', child: Text('One')),
              PopupMenuItem<String>(value: 'two', child: Text('Two')),
            ],
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Open menu'),
            ),
          ),
        ),
      ),
    ),
  );
}
