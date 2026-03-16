import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DocumentationIcon annotation - marks doc icon members.
/// Shows how API elements can specify their documentation icon.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DocumentationIcon Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('API Documentation Icons',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DocIconCard(icon: Icons.widgets, name: 'Widget', desc: 'UI building blocks'),
          _DocIconCard(icon: Icons.brush, name: 'Painting', desc: 'Canvas and drawing'),
          _DocIconCard(icon: Icons.animation, name: 'Animation', desc: 'Motion and curves'),
          _DocIconCard(icon: Icons.touch_app, name: 'Gestures', desc: 'Touch handling'),
          _DocIconCard(icon: Icons.settings, name: 'Services', desc: 'Platform features'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              '@DocumentationIcon("icon_url") annotates classes for API docs visualization',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DocIconCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String desc;
  const _DocIconCard({required this.icon, required this.name, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
