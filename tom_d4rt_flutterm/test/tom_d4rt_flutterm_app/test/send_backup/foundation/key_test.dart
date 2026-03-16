import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Key - unique widget identity.
/// Shows ValueKey, ObjectKey, GlobalKey, and UniqueKey.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Key Types Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Widget Identity Keys',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _KeyCard(type: 'ValueKey', example: "ValueKey('item_1')", desc: 'Identity by value', icon: Icons.text_fields, color: Colors.blue),
          _KeyCard(type: 'ObjectKey', example: 'ObjectKey(myObject)', desc: 'Identity by object reference', icon: Icons.inventory_2, color: Colors.green),
          _KeyCard(type: 'GlobalKey', example: 'GlobalKey<State>()', desc: 'Access state/context globally', icon: Icons.public, color: Colors.orange),
          _KeyCard(type: 'UniqueKey', example: 'UniqueKey()', desc: 'Always unique identity', icon: Icons.fingerprint, color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('Use keys to preserve state when widgets change position in the tree')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _KeyCard extends StatelessWidget {
  final String type;
  final String example;
  final String desc;
  final IconData icon;
  final Color color;
  const _KeyCard({required this.type, required this.example, required this.desc, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                Text(example, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
