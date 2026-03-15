import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for CheckedState - accessibility checkbox states.
/// Demonstrates checked, unchecked, and mixed states for accessibility.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CheckedState Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Accessibility Checked States', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Used by screen readers to announce checkbox status', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          _buildStateCard('checked', 'CheckedState.checked', Icons.check_box, Colors.green, 'Checkbox is selected'),
          const SizedBox(height: 16),
          _buildStateCard('unchecked', 'CheckedState.unchecked', Icons.check_box_outline_blank, Colors.grey, 'Checkbox is not selected'),
          const SizedBox(height: 16),
          _buildStateCard('mixed', 'CheckedState.mixed', Icons.indeterminate_check_box, Colors.orange, 'Checkbox has mixed selection'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.accessibility, color: Colors.blue),
                const SizedBox(width: 12),
                const Expanded(child: Text('Screen readers announce these states to users')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStateCard(String id, String code, IconData icon, Color color, String desc) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      borderRadius: BorderRadius.circular(12),
      color: color.withValues(alpha: 0.05),
    ),
    child: Row(
      children: [
        Icon(icon, size: 48, color: color),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
