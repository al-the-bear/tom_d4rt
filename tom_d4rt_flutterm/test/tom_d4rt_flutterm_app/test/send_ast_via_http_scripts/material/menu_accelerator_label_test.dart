import 'package:flutter/material.dart';

/// Deep visual demo for MenuAcceleratorLabel.
/// Renders label with underlined accelerator key.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuAcceleratorLabel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Input: "&Save"', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
            const SizedBox(height: 12),
            const Icon(Icons.arrow_downward, color: Colors.blue),
            const SizedBox(height: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'S', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                  TextSpan(text: 'ave'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Parses & and underlines next char', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
