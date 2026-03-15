import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MessageProperty - string message diagnostic.
/// Shows message-only properties without name display.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MessageProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Message Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _MessageCard(message: 'The widget tree has been modified during build.', type: 'error', color: Colors.red),
          _MessageCard(message: 'Consider using const constructors for better performance.', type: 'hint', color: Colors.amber),
          _MessageCard(message: 'Layout completed in 4.2ms', type: 'info', color: Colors.blue),
          _MessageCard(message: 'Widget disposed successfully', type: 'debug', color: Colors.grey),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('MessageProperty displays message text without a property name prefix, useful for diagnostic prose.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _MessageCard extends StatelessWidget {
  final String message;
  final String type;
  final Color color;
  const _MessageCard({required this.message, required this.type, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border(left: BorderSide(color: color, width: 4))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text(type.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
