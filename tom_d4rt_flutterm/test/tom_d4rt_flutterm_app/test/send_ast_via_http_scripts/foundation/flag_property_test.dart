import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FlagProperty - boolean diagnostic property.
/// Shows conditional display based on flag state.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FlagProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Boolean Flag Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _FlagCard(name: 'enabled', value: true, ifTrue: 'ENABLED', ifFalse: 'disabled'),
          _FlagCard(name: 'visible', value: true, ifTrue: 'visible', ifFalse: 'HIDDEN'),
          _FlagCard(name: 'clipped', value: false, ifTrue: 'clipping', ifFalse: null),
          _FlagCard(name: 'offstage', value: true, ifTrue: 'OFFSTAGE', ifFalse: null),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Rules:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• ifTrue: shown when value is true'),
                Text('• ifFalse: shown when value is false'),
                Text('• null ifFalse: hidden when false'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _FlagCard extends StatelessWidget {
  final String name;
  final bool value;
  final String ifTrue;
  final String? ifFalse;
  const _FlagCard({required this.name, required this.value, required this.ifTrue, this.ifFalse});
  @override
  Widget build(BuildContext context) {
    final display = value ? ifTrue : ifFalse;
    final color = value ? Colors.green : Colors.red;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Row(
        children: [
          Icon(value ? Icons.check_circle : Icons.cancel, color: color),
          const SizedBox(width: 12),
          SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
          if (display != null) Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text(display, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ) else const Text('(hidden)', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12)),
        ],
      ),
    );
  }
}
