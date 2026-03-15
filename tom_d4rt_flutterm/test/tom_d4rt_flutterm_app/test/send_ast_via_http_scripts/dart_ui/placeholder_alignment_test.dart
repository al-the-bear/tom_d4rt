import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PlaceholderAlignment - inline element alignment.
/// Demonstrates alignment for inline widgets in text.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PlaceholderAlignment Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Placeholder Alignments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildAlignmentDemo('baseline', 'Align baselines'),
          _buildAlignmentDemo('aboveBaseline', 'Above text baseline'),
          _buildAlignmentDemo('belowBaseline', 'Below text baseline'),
          _buildAlignmentDemo('top', 'Align tops'),
          _buildAlignmentDemo('bottom', 'Align bottoms'),
          _buildAlignmentDemo('middle', 'Center vertically'),
        ],
      ),
    ),
  );
}

Widget _buildAlignmentDemo(String name, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade200), borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
          child: Text(name, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 10)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                const TextSpan(text: 'Text with '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const TextSpan(text: ' inline widget'),
              ],
            ),
          ),
        ),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
      ],
    ),
  );
}
