import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FontStyle - normal vs italic font styling.
/// Demonstrates visual difference between font styles.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FontStyle Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Font Styles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _buildStyleDemo(
            'FontStyle.normal',
            FontStyle.normal,
            'Standard upright text rendering',
            Colors.blue,
          ),
          const SizedBox(height: 24),
          _buildStyleDemo(
            'FontStyle.italic',
            FontStyle.italic,
            'Slanted text for emphasis',
            Colors.purple,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage in TextStyle:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('TextStyle(fontStyle: FontStyle.italic)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStyleDemo(String code, FontStyle style, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      borderRadius: BorderRadius.circular(16),
      color: color.withValues(alpha: 0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          'The quick brown fox jumps over the lazy dog',
          style: TextStyle(fontSize: 18, fontStyle: style, color: color),
        ),
        const SizedBox(height: 8),
        Text(desc, style: TextStyle(color: Colors.grey.shade600)),
      ],
    ),
  );
}
