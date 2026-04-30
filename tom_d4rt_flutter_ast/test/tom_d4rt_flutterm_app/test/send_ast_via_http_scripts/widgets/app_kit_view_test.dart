// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AppKitView Deep Demo (Harness-Safe) ===');

  const details = <String, String>{
    'platform': 'macOS AppKit',
    'mode': 'summary-only',
    'gesture recognizers': 'constructor bridge-safe placeholder',
  };

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'AppKitView',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...details.entries.map(
              (entry) => ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
