import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SpellOutStringAttribute.
/// Demonstrates text-to-speech spell-out annotation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SpellOutStringAttribute')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Spell Out Attribute', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Tells TTS to spell text letter-by-letter', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Example:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildExample('NASA', 'N - A - S - A'),
                _buildExample('FBI', 'F - B - I'),
                _buildExample('URL', 'U - R - L'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Used to prevent TTS from pronouncing acronyms as words.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildExample(String text, String spelled) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const Icon(Icons.arrow_forward, size: 16),
      Text(spelled, style: const TextStyle(fontFamily: 'monospace', letterSpacing: 2)),
    ]),
  );
}
