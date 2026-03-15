import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for DisplayFeatureState - foldable device states.
/// Demonstrates flat vs half-opened posture states.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DisplayFeatureState Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Foldable Device States', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildStateCard('DisplayFeatureState.postureFlat', 'Flat', Icons.stay_current_landscape, 'Device fully unfolded', Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildStateCard('DisplayFeatureState.postureHalfOpened', 'Half-Opened', Icons.laptop, 'Device partially folded', Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStateCard(String code, String name, IconData icon, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.1)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: color),
        const SizedBox(height: 16),
        Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 8),
        Text(desc, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
        ),
      ],
    ),
  );
}
