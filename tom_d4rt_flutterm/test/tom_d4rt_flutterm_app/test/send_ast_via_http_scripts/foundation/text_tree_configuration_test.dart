import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for TextTreeConfiguration - tree rendering config.
/// Shows how diagnostics tree output is customized.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TextTreeConfiguration Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tree Rendering Configuration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _TreeStyle(
                name: 'Dense',
                prefixLineOne: '├─',
                prefixLastChildLineOne: '└─',
                prefixOtherLines: '│ ',
                linkCharacter: '─',
              )),
              const SizedBox(width: 16),
              Expanded(child: _TreeStyle(
                name: 'Sparse',
                prefixLineOne: '├───',
                prefixLastChildLineOne: '└───',
                prefixOtherLines: '│   ',
                linkCharacter: '───',
              )),
            ],
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
                Text('prefixLineOne, prefixLastChildLineOne'),
                Text('prefixOtherLines, linkCharacter'),
                Text('propertyPrefixIfChildren, addBlankLineIfNoChildren'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TreeStyle extends StatelessWidget {
  final String name;
  final String prefixLineOne;
  final String prefixLastChildLineOne;
  final String prefixOtherLines;
  final String linkCharacter;
  const _TreeStyle({required this.name, required this.prefixLineOne, required this.prefixLastChildLineOne, required this.prefixOtherLines, required this.linkCharacter});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Root', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          Text('\$prefixLineOne Child A', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          Text('\$prefixOtherLines\$prefixLineOne Grandchild', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          Text('\$prefixLastChildLineOne Child B', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
        ],
      ),
    );
  }
}
