import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FoundationServiceExtensions - debug service bindings.
/// Shows debug service endpoints for DevTools and inspection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FoundationServiceExtensions')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Debug Service Extensions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _ServiceCard(name: 'ext.flutter.reassemble', desc: 'Hot reload trigger', icon: Icons.refresh),
          _ServiceCard(name: 'ext.flutter.exit', desc: 'Exit application', icon: Icons.exit_to_app),
          _ServiceCard(name: 'ext.flutter.connectedVmServiceUri', desc: 'VM service URI', icon: Icons.link),
          _ServiceCard(name: 'ext.flutter.activeDevToolsServerAddress', desc: 'DevTools address', icon: Icons.developer_mode),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('Service extensions enable DevTools and IDE debugging integration')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ServiceCard extends StatelessWidget {
  final String name;
  final String desc;
  final IconData icon;
  const _ServiceCard({required this.name, required this.desc, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
