import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for BoxHeightStyle - text selection box height styles.
/// Demonstrates tight, max, includeLineSpacingMiddle, etc.
dynamic build(BuildContext context) {
  final styles = [
    ('tight', 'Boxes fit tightly around glyphs'),
    ('max', 'Full line height for all boxes'),
    ('includeLineSpacingMiddle', 'Include half line spacing'),
    ('includeLineSpacingTop', 'Include top line spacing'),
    ('includeLineSpacingBottom', 'Include bottom line spacing'),
    ('strut', 'Use strut for box heights'),
  ];
  
  return Scaffold(
    appBar: AppBar(title: const Text('BoxHeightStyle Demo')),
    body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: styles.length,
      itemBuilder: (context, i) {
        final (name, desc) = styles[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade200),
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade50,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.height, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BoxHeightStyle.$name', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(desc, style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
