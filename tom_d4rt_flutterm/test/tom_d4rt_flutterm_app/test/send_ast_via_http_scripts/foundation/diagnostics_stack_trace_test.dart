import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsStackTrace - stack trace in diagnostics.
/// Shows how errors display stack traces in debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsStackTrace Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Stack Trace Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [Icon(Icons.error_outline, color: Colors.red), SizedBox(width: 8), Text('FlutterError', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))]),
                const Divider(),
                _StackLine(num: 0, location: 'build_method', file: 'my_widget.dart', line: 45),
                _StackLine(num: 1, location: 'StatelessElement.build', file: 'framework.dart', line: 4867),
                _StackLine(num: 2, location: 'ComponentElement.performRebuild', file: 'framework.dart', line: 4754),
                _StackLine(num: 3, location: 'Element.rebuild', file: 'framework.dart', line: 4477),
                _StackLine(num: 4, location: '...more frames...', file: '', line: 0),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('DiagnosticsStackTrace formats stack traces for readable debug output, filtering framework internals when appropriate.'),
          ),
        ],
      ),
    ),
  );
}

class _StackLine extends StatelessWidget {
  final int num;
  final String location;
  final String file;
  final int line;
  const _StackLine({required this.num, required this.location, required this.file, required this.line});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 24,
            alignment: Alignment.center,
            child: Text('#\$num', style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(location, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
          if (file.isNotEmpty) Text('\$file:\$line', style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}
