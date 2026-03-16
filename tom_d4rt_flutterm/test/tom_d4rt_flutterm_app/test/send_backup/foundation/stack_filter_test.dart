import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for StackFilter - filters stack trace frames.
/// Shows how framework internals are removed from error output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('StackFilter Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Stack Trace Filtering',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _FilterBox(
            title: 'Filtered (Hidden)',
            color: Colors.red,
            frames: ['ComponentElement.performRebuild', 'Element.rebuild', 'BuildOwner.buildScope'],
          ),
          const SizedBox(height: 12),
          _FilterBox(
            title: 'Shown (Visible)',
            color: Colors.green,
            frames: ['MyWidget.build', 'MyApp.createState', 'main'],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• StackFilter - base filter interface'),
                Text('• PartialStackFrame - pattern matching'),
                Text('• RepetitiveStackFrameFilter - collapse repeats'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _FilterBox extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> frames;
  const _FilterBox({required this.title, required this.color, required this.frames});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(color == Colors.red ? Icons.visibility_off : Icons.visibility, color: color, size: 18),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ]),
          const SizedBox(height: 8),
          ...frames.map((f) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text('  \$f', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          )),
        ],
      ),
    );
  }
}
