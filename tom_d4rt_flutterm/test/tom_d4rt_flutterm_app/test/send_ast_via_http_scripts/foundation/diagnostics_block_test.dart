// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsBlock - groups diagnostic properties.
/// Shows how properties are organized into logical blocks.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsBlock Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Diagnostic Property Grouping',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _DiagBlock(
            title: 'Layout Properties',
            icon: Icons.dashboard,
            color: Colors.blue,
            props: ['width: 200.0', 'height: 100.0', 'alignment: center'],
          ),
          const SizedBox(height: 12),
          _DiagBlock(
            title: 'Decoration',
            icon: Icons.palette,
            color: Colors.purple,
            props: ['color: blue', 'borderRadius: 8.0', 'shadow: elevation(4)'],
          ),
          const SizedBox(height: 12),
          _DiagBlock(
            title: 'Children',
            icon: Icons.account_tree,
            color: Colors.green,
            props: ['child: Text', 'childCount: 1'],
          ),
        ],
      ),
    ),
  );
}

class _DiagBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> props;
  const _DiagBlock({
    required this.title,
    required this.icon,
    required this.color,
    required this.props,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(7),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: props
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        p,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
