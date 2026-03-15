import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Summary annotation - marks API summaries.
/// Shows @Summary usage for API documentation indexing.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Summary Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('@Summary Annotation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('/// A widget for displaying buttons.', style: TextStyle(color: Colors.green, fontSize: 12)),
                Text('@Summary("Button widget")', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                Text('class Button extends Widget {', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('  // ...', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('}', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.info_outline, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(child: Text('Used by documentation tools to extract API summaries for search indexing.')),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• text - short API summary'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
