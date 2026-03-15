import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsNode - base class for all diagnostic nodes.
/// Shows node types, properties, and tree structure.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsNode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnostics Node Types',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _NodeTypeCard(type: 'DiagnosticsNode', desc: 'Base class', color: Colors.grey, icon: Icons.circle_outlined)),
              const SizedBox(width: 8),
              Expanded(child: _NodeTypeCard(type: 'DiagnosticsProperty', desc: 'Name-value pair', color: Colors.blue, icon: Icons.label)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _NodeTypeCard(type: 'DiagnosticableNode', desc: 'Object wrapper', color: Colors.green, icon: Icons.inventory_2)),
              const SizedBox(width: 8),
              Expanded(child: _NodeTypeCard(type: 'DiagnosticsBlock', desc: 'Property group', color: Colors.orange, icon: Icons.view_module)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Node Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• name - identifier for the node'),
                Text('• value - associated object'),
                Text('• style - DiagnosticsTreeStyle'),
                Text('• level - DiagnosticLevel'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _NodeTypeCard extends StatelessWidget {
  final String type;
  final String desc;
  final Color color;
  final IconData icon;
  const _NodeTypeCard({required this.type, required this.desc, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: color), textAlign: TextAlign.center),
          Text(desc, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
