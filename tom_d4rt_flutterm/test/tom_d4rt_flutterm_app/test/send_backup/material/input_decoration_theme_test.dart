import 'package:flutter/material.dart';

/// Deep visual demo for InputDecorationTheme widget.
/// Shows how InputDecorationTheme provides defaults for descendant TextFields.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputDecorationTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          children: [
            const Text('Themed Inputs', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            const SizedBox(height: 12),
            _ThemedInput('Username'),
            const SizedBox(height: 8),
            _ThemedInput('Password'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Provides defaults to all nested TextFields', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemedInput extends StatelessWidget {
  final String label;
  const _ThemedInput(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple.shade300),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.purple.shade300, fontSize: 12)),
        ],
      ),
    );
  }
}
