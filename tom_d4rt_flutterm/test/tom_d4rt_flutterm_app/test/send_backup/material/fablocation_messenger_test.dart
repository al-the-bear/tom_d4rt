import 'package:flutter/material.dart';

/// Deep visual demo for FloatingActionButtonLocation messaging.
/// Shows how different FAB locations communicate with Scaffold.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FAB Location Messenger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(Icons.message, size: 32, color: Colors.purple),
            const SizedBox(height: 8),
            const Text('Location → Scaffold', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _MessageRow('getOffset', 'Position calculation'),
            _MessageRow('isMiniSize', 'Use mini dimensions'),
            _MessageRow('isDockedMode', 'Dock to bar'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Locations communicate with Scaffold', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MessageRow extends StatelessWidget {
  final String method;
  final String desc;
  const _MessageRow(this.method, this.desc);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(4)),
            child: Text(method, style: const TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
