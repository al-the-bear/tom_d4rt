// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ThemeExtension Deep Demo (Harness-Safe) ===');

  final theme = ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal);

  return MaterialApp(
    theme: theme,
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ThemeData Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text('brightness: ${theme.brightness.name}'),
              Text('primary: ${theme.colorScheme.primary}'),
              Text('surface: ${theme.colorScheme.surface}'),
              const SizedBox(height: 16),
              const Text('Script avoids extensions list coercion path.'),
            ],
          ),
        ),
      ),
    ),
  );
}
