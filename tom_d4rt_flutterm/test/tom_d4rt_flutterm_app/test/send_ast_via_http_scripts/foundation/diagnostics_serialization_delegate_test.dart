import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsSerializationDelegate - controls serialization.
/// Shows how diagnostic trees are converted to JSON for DevTools.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsSerializationDelegate')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Serialization Control',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _SerialBox(
                  title: 'Widget Tree',
                  icon: Icons.account_tree,
                  color: Colors.blue,
                  content: 'Container\n  Padding\n    Text',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                child: Icon(Icons.arrow_forward, color: Colors.grey),
              ),
              Expanded(
                child: _SerialBox(
                  title: 'JSON Output',
                  icon: Icons.data_object,
                  color: Colors.green,
                  content: '{\n "type": "Container",\n "children": [...]\n}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delegate Methods:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• additionalNodeProperties()'),
                Text('• filterChildren()'),
                Text('• filterProperties()'),
                Text('• truncateNodesList()'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _SerialBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String content;
  const _SerialBox({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              content,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
