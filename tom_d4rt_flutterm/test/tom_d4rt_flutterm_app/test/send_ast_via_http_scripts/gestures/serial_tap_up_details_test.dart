import 'package:flutter/material.dart';

/// Deep visual demo for SerialTapUpDetails.
/// Shows info when serial tap completes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SerialTapUpDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Serial Tap Up Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.touch_app, color: Colors.green), SizedBox(width: 8),
                  Text('When Fired', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('When finger lifts during serial tap sequence'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• globalPosition: Offset'),
                Text('  Where the tap ended globally'),
                SizedBox(height: 4),
                Text('• localPosition: Offset'),
                Text('  Where the tap ended in widget'),
                SizedBox(height: 4),
                Text('• count: int'),
                Text('  Which tap number (1, 2, 3...)'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Like TapUpDetails but with tap count', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    ),
  );
}
