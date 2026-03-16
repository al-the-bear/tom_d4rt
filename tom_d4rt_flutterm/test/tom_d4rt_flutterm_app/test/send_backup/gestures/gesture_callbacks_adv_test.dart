import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for scale gesture callbacks.
/// Shows advanced scale gesture callback signatures.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Scale Gesture Callbacks')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scale Gesture Callbacks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _CallbackCard(
            name: 'GestureScaleStartCallback',
            signature: 'void Function(ScaleStartDetails)',
            desc: 'When scale gesture starts',
          ),
          _CallbackCard(
            name: 'GestureScaleUpdateCallback',
            signature: 'void Function(ScaleUpdateDetails)',
            desc: 'During scale gesture',
          ),
          _CallbackCard(
            name: 'GestureScaleEndCallback',
            signature: 'void Function(ScaleEndDetails)',
            desc: 'When scale gesture ends',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.pinch, color: Colors.purple),
              SizedBox(width: 8),
              Expanded(child: Text('Scale gestures handle pinch-to-zoom and rotation from multi-touch input.')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _CallbackCard extends StatelessWidget {
  final String name;
  final String signature;
  final String desc;
  const _CallbackCard({required this.name, required this.signature, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(signature, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.purple)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
