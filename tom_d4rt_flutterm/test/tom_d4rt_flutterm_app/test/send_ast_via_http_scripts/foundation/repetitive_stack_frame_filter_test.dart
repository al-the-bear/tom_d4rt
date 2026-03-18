import 'package:flutter/material.dart';

/// Deep visual demo for RepetitiveStackFrameFilter - filters repeated frames.
/// Shows how recursive call patterns are collapsed in stack traces.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('RepetitiveStackFrameFilter')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Repetitive Frame Filtering',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Before:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _Frame(text: '_build'),
                      _Frame(text: '_layout'),
                      _Frame(text: '_build'),
                      _Frame(text: '_layout'),
                      _Frame(text: '_build'),
                      _Frame(text: '_layout'),
                      _Frame(text: '_build'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'After:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _Frame(text: '_build'),
                      _Frame(text: '_layout'),
                      _Frame(text: '... (3x more)', italic: true),
                      _Frame(text: '_build'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'RepetitiveStackFrameFilter collapses repeated sequences of stack frames that indicate recursive patterns.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Frame extends StatelessWidget {
  final String text;
  final bool italic;
  const _Frame({required this.text, this.italic = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          color: italic ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}
