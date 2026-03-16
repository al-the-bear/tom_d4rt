import 'package:flutter/material.dart';

/// Deep visual demo for ExpandIcon - animated expand/collapse icon.
/// Shows the rotating chevron icon for expandable content.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ExpandIcon Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Collapsed
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.expand_more, size: 36),
              ),
              const SizedBox(height: 8),
              const Text('Collapsed', style: TextStyle(fontSize: 10)),
              const Text('isExpanded: false', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.arrow_forward, color: Colors.grey),
          ),
          // Expanded
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.expand_less, size: 36, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              const Text('Expanded', style: TextStyle(fontSize: 10)),
              const Text('isExpanded: true', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Rotates 180° with animation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
