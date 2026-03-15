import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ViewConstraints.
/// Demonstrates view sizing constraints.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ViewConstraints Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('View Constraints', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Size boundaries for FlutterView', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildProp('minWidth', 'Minimum allowed width'),
                _buildProp('maxWidth', 'Maximum allowed width'),
                _buildProp('minHeight', 'Minimum allowed height'),
                _buildProp('maxHeight', 'Maximum allowed height'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 150,
            decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                const Positioned(top: 8, left: 8, child: Text('maxWidth, maxHeight', style: TextStyle(fontSize: 10, color: Colors.green))),
                Center(
                  child: Container(
                    width: 100, height: 80,
                    decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.3), border: Border.all(color: Colors.green)),
                    child: const Center(child: Text('minWidth\nminHeight', style: TextStyle(fontSize: 10), textAlign: TextAlign.center)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildProp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      const Icon(Icons.straighten, color: Colors.green, size: 16),
      const SizedBox(width: 8),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}
