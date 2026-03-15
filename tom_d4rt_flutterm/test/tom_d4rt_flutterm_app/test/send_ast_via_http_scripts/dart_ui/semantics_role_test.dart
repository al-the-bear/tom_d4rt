import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for semantics roles.
/// Demonstrates widget roles for accessibility.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Semantics Role Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Semantics Roles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Widget role identification for accessibility', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildRoleCard('button', 'Clickable button', Icons.smart_button),
          _buildRoleCard('checkbox', 'Toggle checkbox', Icons.check_box),
          _buildRoleCard('radioButton', 'Radio selection', Icons.radio_button_checked),
          _buildRoleCard('toggleSwitch', 'On/off switch', Icons.toggle_on),
          _buildRoleCard('slider', 'Value slider', Icons.tune),
          _buildRoleCard('textField', 'Text input', Icons.text_fields),
          _buildRoleCard('link', 'Clickable link', Icons.link),
          _buildRoleCard('image', 'Image content', Icons.image),
          _buildRoleCard('header', 'Section header', Icons.title),
          _buildRoleCard('tab', 'Tab button', Icons.tab),
          _buildRoleCard('tabBar', 'Tab bar container', Icons.view_array),
        ],
      ),
    ),
  );
}

Widget _buildRoleCard(String name, String desc, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.teal.withValues(alpha: 0.1), Colors.teal.withValues(alpha: 0.05)]),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(children: [
      Icon(icon, color: Colors.teal, size: 24),
      const SizedBox(width: 12),
      Text('Role.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w500)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}
