import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for BitField - efficient storage of boolean flags.
/// Shows how individual bits represent different feature flags.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BitField Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bit Field Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('8-bit Field: 10110101', 
                  style: TextStyle(fontFamily: 'monospace', fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 7; i >= 0; i--)
                      _BitDisplay(index: i, isSet: [true, false, true, true, false, true, false, true][7-i]),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Flag Meanings:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _FlagRow(bit: 7, label: 'Feature A', isSet: true),
          _FlagRow(bit: 6, label: 'Feature B', isSet: false),
          _FlagRow(bit: 5, label: 'Feature C', isSet: true),
          _FlagRow(bit: 4, label: 'Debug Mode', isSet: true),
          _FlagRow(bit: 3, label: 'Logging', isSet: false),
        ],
      ),
    ),
  );
}

class _BitDisplay extends StatelessWidget {
  final int index;
  final bool isSet;
  const _BitDisplay({required this.index, required this.isSet});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: isSet ? Colors.indigo : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(isSet ? '1' : '0', 
            style: TextStyle(color: isSet ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text('\$index', style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

class _FlagRow extends StatelessWidget {
  final int bit;
  final String label;
  final bool isSet;
  const _FlagRow({required this.bit, required this.label, required this.isSet});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24, height: 24,
            decoration: BoxDecoration(
              color: isSet ? Colors.green : Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(isSet ? Icons.check : Icons.close, size: 16, color: isSet ? Colors.white : Colors.red),
          ),
          const SizedBox(width: 12),
          Text('Bit \$bit: \$label'),
        ],
      ),
    );
  }
}
