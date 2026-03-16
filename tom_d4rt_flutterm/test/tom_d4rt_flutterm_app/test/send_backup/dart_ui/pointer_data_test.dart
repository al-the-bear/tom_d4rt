import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerData - raw pointer event data.
/// Demonstrates pointer properties from platform.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerData Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Raw pointer event from platform', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildPropGroup('Position', ['physicalX', 'physicalY', 'physicalDeltaX', 'physicalDeltaY']),
          _buildPropGroup('State', ['change', 'buttons', 'device', 'pointerIdentifier']),
          _buildPropGroup('Pressure', ['pressure', 'pressureMin', 'pressureMax']),
          _buildPropGroup('Stylus', ['distance', 'tilt', 'orientation']),
          _buildPropGroup('Scroll', ['scrollDeltaX', 'scrollDeltaY']),
          _buildPropGroup('Device', ['kind', 'platformData']),
        ],
      ),
    ),
  );
}

Widget _buildPropGroup(String title, List<String> props) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.purple.shade200),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: props.map((p) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(4)),
            child: Text(p, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          )).toList(),
        ),
      ],
    ),
  );
}
