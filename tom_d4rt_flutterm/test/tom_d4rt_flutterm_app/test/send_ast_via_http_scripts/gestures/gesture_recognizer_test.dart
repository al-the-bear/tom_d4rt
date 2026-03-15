import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for GestureRecognizer base class.
/// Shows base class for all gesture recognizers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('GestureRecognizer')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('GestureRecognizer Base Class',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                  child: const Text('GestureRecognizer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _SubclassChip(name: 'TapGestureRecognizer'),
                  _SubclassChip(name: 'DragGestureRecognizer'),
                ]),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _SubclassChip(name: 'ScaleGestureRecognizer'),
                  _SubclassChip(name: 'LongPressGestureRecognizer'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• addPointer() - start tracking pointer'),
                Text('• acceptGesture() - win the arena'),
                Text('• rejectGesture() - lose the arena'),
                Text('• dispose() - clean up'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _SubclassChip extends StatelessWidget {
  final String name;
  const _SubclassChip({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.blue)),
      child: Text(name, style: const TextStyle(fontSize: 10)),
    );
  }
}
