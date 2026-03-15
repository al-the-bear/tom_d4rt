import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for StringProperty - string diagnostic property.
/// Shows quoted string values in diagnostics output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('StringProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('String Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _StringProp(name: 'label', value: 'Click me'),
          _StringProp(name: 'tooltip', value: 'This is a tooltip'),
          _StringProp(name: 'semanticsLabel', value: null),
          _StringProp(name: 'fontFamily', value: 'Roboto'),
          _StringProp(name: 'heroTag', value: 'hero-123'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Options:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• quoted: true - wraps in quotes'),
                Text('• showName: false - value only'),
                Text('• null shows "null" or is hidden'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _StringProp extends StatelessWidget {
  final String name;
  final String? value;
  const _StringProp({required this.name, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: value != null ? Colors.teal.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        SizedBox(width: 120, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        const Text(':  '),
        Text(value != null ? '"$value"' : 'null', style: TextStyle(fontFamily: 'monospace', color: value != null ? Colors.teal.shade800 : Colors.grey)),
      ]),
    );
  }
}
