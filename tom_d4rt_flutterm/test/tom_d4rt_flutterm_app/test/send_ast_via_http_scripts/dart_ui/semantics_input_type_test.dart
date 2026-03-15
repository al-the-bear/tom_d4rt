import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for semantics input types.
/// Demonstrates text, number, phone, and other input types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Semantics InputType')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Input Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Keyboard type hints for text fields', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildInputTypeCard('text', Icons.text_fields, 'General text input'),
                _buildInputTypeCard('number', Icons.numbers, 'Numeric keypad'),
                _buildInputTypeCard('phone', Icons.phone, 'Phone number format'),
                _buildInputTypeCard('email', Icons.email, 'Email address format'),
                _buildInputTypeCard('url', Icons.link, 'URL format'),
                _buildInputTypeCard('datetime', Icons.calendar_today, 'Date/time picker'),
                _buildInputTypeCard('multiline', Icons.format_align_left, 'Multi-line text'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInputTypeCard(String name, IconData icon, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade200), borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.purple),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('InputType.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    ]),
  );
}
