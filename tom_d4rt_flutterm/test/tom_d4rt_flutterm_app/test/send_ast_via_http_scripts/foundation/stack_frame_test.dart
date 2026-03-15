import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for StackFrame - parsed stack trace frame.
/// Shows individual frame details from stack traces.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('StackFrame Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Parsed Stack Frame',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('#0  MyWidget.build (package:my_app/my_widget.dart:42:15)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                const Divider(),
                _FrameField(label: 'number', value: '0'),
                _FrameField(label: 'member', value: 'MyWidget.build'),
                _FrameField(label: 'package', value: 'my_app'),
                _FrameField(label: 'packagePath', value: 'lib/my_widget.dart'),
                _FrameField(label: 'line', value: '42'),
                _FrameField(label: 'column', value: '15'),
                _FrameField(label: 'className', value: 'MyWidget'),
                _FrameField(label: 'method', value: 'build'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('StackFrame.fromStackTraceLine() parses raw stack trace text into structured data.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _FrameField extends StatelessWidget {
  final String label;
  final String value;
  const _FrameField({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        SizedBox(width: 100, child: Text('\$label:', style: const TextStyle(color: Colors.grey, fontSize: 12))),
        Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
      ]),
    );
  }
}
