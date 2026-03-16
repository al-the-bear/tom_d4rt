import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for StringAttribute base class.
/// Demonstrates text annotation attributes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('StringAttribute Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('String Attributes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Annotate text with metadata', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Attribute Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildAttrType('LocaleStringAttribute', 'Language locale'),
                _buildAttrType('SpellOutStringAttribute', 'Spell out letters'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
          _buildProp('range', 'TextRange for attribute'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('String attributes provide metadata for accessibility and TTS engines.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAttrType(String name, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      const Icon(Icons.label, color: Colors.blue, size: 20),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}

Widget _buildProp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Text(name, style: const TextStyle(fontFamily: 'monospace')),
      const SizedBox(width: 12),
      Text(desc, style: TextStyle(color: Colors.grey.shade600)),
    ]),
  );
}
