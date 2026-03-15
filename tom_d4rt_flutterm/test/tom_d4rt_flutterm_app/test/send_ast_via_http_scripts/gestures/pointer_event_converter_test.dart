import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerEventConverter.
/// Shows conversion from raw UI events.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerEventConverter')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Event Conversion Pipeline',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              _ConversionStep(label: 'ui.PointerData', color: Colors.grey, desc: 'Raw platform event'),
              const Icon(Icons.arrow_downward, color: Colors.orange),
              _ConversionStep(label: 'PointerEventConverter', color: Colors.orange, desc: 'Expands/transforms'),
              const Icon(Icons.arrow_downward, color: Colors.orange),
              _ConversionStep(label: 'PointerEvent', color: Colors.green, desc: 'Flutter gesture event'),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Responsibilities:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• Expand move events into enter/exit'),
                Text('• Apply device pixel ratio'),
                Text('• Track pointer state changes'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ConversionStep extends StatelessWidget {
  final String label;
  final Color color;
  final String desc;
  const _ConversionStep({required this.label, required this.color, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Text(desc, style: const TextStyle(fontSize: 11)),
      ]),
    );
  }
}
