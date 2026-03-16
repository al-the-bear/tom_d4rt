import 'package:flutter/material.dart';

/// Deep visual demo for ButtonBar.
/// Shows deprecated button bar widget.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonBar')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
          child: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(child: Text('Deprecated: Use OverflowBar instead', style: TextStyle(color: Colors.orange))),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Basic ButtonBar', style: TextStyle(fontWeight: FontWeight.bold)),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dialog Footer Example'),
                ButtonBar(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('CANCEL')),
                    ElevatedButton(onPressed: () {}, child: const Text('SAVE')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('OverflowBar Replacement', style: TextStyle(fontWeight: FontWeight.bold)),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Modern Approach'),
                const SizedBox(height: 8),
                OverflowBar(
                  spacing: 8,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('CANCEL')),
                    ElevatedButton(onPressed: () {}, child: const Text('SAVE')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
