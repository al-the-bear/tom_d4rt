import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsActionEvent - accessibility action.
/// Demonstrates events triggered by assistive technology.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SemanticsActionEvent Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Semantics Action Event', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Action triggered by accessibility tools', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(children: [Icon(Icons.numbers, size: 16), SizedBox(width: 8), Text('nodeId - Target semantics node')]),
                SizedBox(height: 8),
                Row(children: [Icon(Icons.touch_app, size: 16), SizedBox(width: 8), Text('type - Action type (tap, scroll, etc.)')]),
                SizedBox(height: 8),
                Row(children: [Icon(Icons.data_object, size: 16), SizedBox(width: 8), Text('arguments - Optional action data')]),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildEventExample('Tap', 'User double-tapped via TalkBack'),
          _buildEventExample('Scroll', 'User scrolled via VoiceOver'),
          _buildEventExample('Increase', 'User adjusted slider up'),
        ],
      ),
    ),
  );
}

Widget _buildEventExample(String action, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.green.shade200), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.accessibility, color: Colors.green),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SemanticsAction.$action', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    ]),
  );
}
