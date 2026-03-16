import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsFlag - accessibility boolean flags.
/// Demonstrates flags for node properties.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SemanticsFlag Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Semantics Flags', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Boolean properties for accessibility', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          _buildFlagCategory('Interactive', ['hasCheckedState', 'isChecked', 'isSelected', 'isButton', 'isLink', 'isTextField']),
          _buildFlagCategory('State', ['isEnabled', 'isFocused', 'isFocusable', 'isReadOnly', 'isHidden', 'isObscured']),
          _buildFlagCategory('Focus', ['scopesRoute', 'namesRoute', 'isHeader', 'hasImplicitScrolling']),
          _buildFlagCategory('Slider', ['isSlider', 'hasEnabledState', 'hasExpandedState', 'isExpanded']),
        ],
      ),
    ),
  );
}

Widget _buildFlagCategory(String title, List<String> flags) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.orange.shade200), borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6, runSpacing: 6,
          children: flags.map((f) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
            child: Text(f, style: const TextStyle(fontFamily: 'monospace', fontSize: 10)),
          )).toList(),
        ),
      ],
    ),
  );
}
