import 'package:flutter/material.dart';

/// Deep visual demo for TextButton widget.
/// Material text button without elevation.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ButtonDemo('Default', Colors.blue, false),
          const SizedBox(width: 12),
          _ButtonDemo('Disabled', Colors.grey, true),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add, size: 16, color: Colors.blue),
                const SizedBox(width: 8),
                const Text('With Icon', style: TextStyle(color: Colors.blue, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('onPressed, child, style', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ButtonDemo extends StatelessWidget {
  final String label;
  final Color color;
  final bool disabled;
  const _ButtonDemo(this.label, this.color, this.disabled);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: Text(label, style: TextStyle(color: disabled ? Colors.grey : color, fontSize: 12)),
        ),
        Text(disabled ? 'Disabled' : 'Enabled', style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}
