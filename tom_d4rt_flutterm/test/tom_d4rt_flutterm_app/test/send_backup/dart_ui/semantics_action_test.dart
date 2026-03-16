import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsAction - accessibility actions.
/// Demonstrates various actions for assistive technology.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SemanticsAction Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Semantics Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildActionCard('tap', 'Activate the node', Icons.touch_app),
          _buildActionCard('longPress', 'Long press action', Icons.fingerprint),
          _buildActionCard('scrollLeft', 'Scroll content left', Icons.arrow_back),
          _buildActionCard('scrollRight', 'Scroll content right', Icons.arrow_forward),
          _buildActionCard('scrollUp', 'Scroll content up', Icons.arrow_upward),
          _buildActionCard('scrollDown', 'Scroll content down', Icons.arrow_downward),
          _buildActionCard('increase', 'Increase adjustable', Icons.add),
          _buildActionCard('decrease', 'Decrease adjustable', Icons.remove),
          _buildActionCard('copy', 'Copy selected text', Icons.copy),
          _buildActionCard('cut', 'Cut selected text', Icons.cut),
          _buildActionCard('paste', 'Paste content', Icons.paste),
          _buildActionCard('dismiss', 'Dismiss action', Icons.close),
        ],
      ),
    ),
  );
}

Widget _buildActionCard(String name, String desc, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Icon(icon, color: Colors.green, size: 20),
      const SizedBox(width: 12),
      Text('SemanticsAction.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w500)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
    ]),
  );
}
