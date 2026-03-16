import 'package:flutter/material.dart';

/// Deep visual demo for InputDecorationTheme.
/// Shows themed input decoration styling.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputDecorationTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemePreview('Outlined', true),
          const SizedBox(width: 12),
          _ThemePreview('Filled', false),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Theme.of(context).inputDecorationTheme', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
      ),
    ],
  );
}

class _ThemePreview extends StatelessWidget {
  final String label;
  final bool outlined;
  const _ThemePreview(this.label, this.outlined);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: outlined ? null : Colors.grey.shade200,
        border: outlined ? Border.all(color: Colors.blue) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text('Label', style: TextStyle(fontSize: 9, color: Colors.blue.shade700)),
          const Text('Input', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    );
  }
}
