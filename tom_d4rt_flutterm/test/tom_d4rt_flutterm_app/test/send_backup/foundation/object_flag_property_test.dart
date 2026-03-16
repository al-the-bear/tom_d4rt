import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for ObjectFlagProperty - conditional object flag.
/// Shows boolean flags with custom display when null or set.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ObjectFlagProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Object Flag Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _FlagRow(name: 'onPressed', value: true, ifPresent: 'HAS CALLBACK'),
          _FlagRow(name: 'controller', value: true, ifPresent: 'HAS CONTROLLER'),
          _FlagRow(name: 'style', value: false, ifPresent: 'STYLED'),
          _FlagRow(name: 'key', value: false, ifPresent: 'KEYED'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Logic:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Shows ifPresent when value != null'),
                Text('• Hidden when value is null'),
                Text('• Useful for optional object properties'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _FlagRow extends StatelessWidget {
  final String name;
  final bool value;
  final String ifPresent;
  const _FlagRow({required this.name, required this.value, required this.ifPresent});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: [
        Icon(value ? Icons.check_box : Icons.check_box_outline_blank, color: value ? Colors.green : Colors.grey),
        const SizedBox(width: 12),
        Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        if (value) Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
          child: Text(ifPresent, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
