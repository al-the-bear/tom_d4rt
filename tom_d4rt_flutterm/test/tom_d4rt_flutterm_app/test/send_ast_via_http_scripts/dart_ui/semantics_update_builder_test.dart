import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsUpdateBuilder.
/// Demonstrates building accessibility tree updates.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SemanticsUpdateBuilder')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Semantics Update Builder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Constructs accessibility tree updates', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildPipeline(),
          const SizedBox(height: 24),
          const Text('Key Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildMethod('updateNode', 'Add or update a semantic node'),
          _buildMethod('updateCustomAction', 'Define custom action'),
          _buildMethod('build', 'Create SemanticsUpdate'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Updates are batched and sent to platform via PlatformDispatcher.updateSemantics().'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPipeline() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStep('Widget Tree', Icons.account_tree),
        const Icon(Icons.arrow_forward, color: Colors.grey),
        _buildStep('Semantics Tree', Icons.accessibility),
        const Icon(Icons.arrow_forward, color: Colors.grey),
        _buildStep('Platform A11y', Icons.phone_android),
      ],
    ),
  );
}

Widget _buildStep(String label, IconData icon) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.green),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
    ],
  );
}

Widget _buildMethod(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      const Icon(Icons.functions, size: 16, color: Colors.green),
      const SizedBox(width: 8),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w500)),
      const SizedBox(width: 8),
      Text('- $desc', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}
