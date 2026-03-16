import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for GestureRecognizerState enum.
/// Shows states of gesture recognition lifecycle.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('GestureRecognizerState')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recognizer State Machine',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _StateStep(state: 'ready', desc: 'Waiting for pointer down', isFirst: true),
          _StateStep(state: 'possible', desc: 'Pointer down, evaluating'),
          _StateStep(state: 'defunct', desc: 'Recognition complete', isLast: true),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('GestureRecognizerState tracks where the recognizer is in its lifecycle from initial touch to completion.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _StateStep extends StatelessWidget {
  final String state;
  final String desc;
  final bool isFirst;
  final bool isLast;
  const _StateStep({required this.state, required this.desc, this.isFirst = false, this.isLast = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),
            child: const Icon(Icons.circle, color: Colors.white, size: 16),
          ),
          if (!isLast) Container(width: 2, height: 40, color: Colors.indigo),
        ]),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
