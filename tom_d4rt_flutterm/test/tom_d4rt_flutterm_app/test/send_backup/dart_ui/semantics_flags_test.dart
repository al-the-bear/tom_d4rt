import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for semantics flag combinations.
/// Demonstrates combining multiple SemanticsFlag values.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SemanticsFlags Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Combined Flags', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildExampleNode('Checkbox', ['hasCheckedState', 'isChecked', 'isFocusable'], true),
          _buildExampleNode('Button', ['isButton', 'isEnabled', 'isFocusable'], true),
          _buildExampleNode('Disabled Link', ['isLink', 'isEnabled'], false),
          _buildExampleNode('Hidden Field', ['isHidden', 'isTextField'], null),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Flags are combined using bitwise operations to describe the complete state of a node.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildExampleNode(String name, List<String> flags, bool? enabled) {
  final color = enabled == null ? Colors.grey : (enabled ? Colors.green : Colors.red);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(enabled == true ? Icons.check_circle : (enabled == false ? Icons.cancel : Icons.help), color: color, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4, runSpacing: 4,
                children: flags.map((f) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                  child: Text(f, style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: color)),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
