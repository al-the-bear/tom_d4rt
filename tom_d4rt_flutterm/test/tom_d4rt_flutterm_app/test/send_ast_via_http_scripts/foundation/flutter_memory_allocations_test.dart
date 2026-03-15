import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FlutterMemoryAllocations - memory tracking.
/// Shows object creation and disposal monitoring for leak detection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FlutterMemoryAllocations Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Memory Allocation Tracking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _MemCard(title: 'Created', count: 156, icon: Icons.add_circle, color: Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _MemCard(title: 'Disposed', count: 142, icon: Icons.remove_circle, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _MemCard(title: 'Active', count: 14, icon: Icons.memory, color: Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _MemCard(title: 'Leaked?', count: 2, icon: Icons.warning, color: Colors.orange)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tracking Events:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• ObjectCreated - new instance allocated'),
                Text('• ObjectDisposed - instance deallocated'),
                Text('• Enable via FlutterMemoryAllocations.instance'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _MemCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  const _MemCard({required this.title, required this.count, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text('\$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
