// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for VerticalMultiDragGestureRecognizer.
/// Shows multi-pointer vertical-only drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('VerticalMultiDragRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Vertical Multi-Drag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Characteristics:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Multiple pointers tracked independently'),
                Text('• Only vertical movement allowed'),
                Text('• Horizontal movement ignored'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Visual demo of vertical drag
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(child: _VerticalTrack('A', Colors.blue)),
                const VerticalDivider(),
                Expanded(child: _VerticalTrack('B', Colors.green)),
                const VerticalDivider(),
                Expanded(child: _VerticalTrack('C', Colors.orange)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Center(child: Text('Each finger moves its own slider', style: TextStyle(fontSize: 11, color: Colors.grey))),
        ],
      ),
    ),
  );
}

class _VerticalTrack extends StatefulWidget {
  final String label;
  final Color color;
  const _VerticalTrack(this.label, this.color);
  @override
  State<_VerticalTrack> createState() => _VerticalTrackState();
}

class _VerticalTrackState extends State<_VerticalTrack> {
  double _value = 0.5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (d) => setState(() => _value = (_value - d.delta.dy / 150).clamp(0, 1)),
      child: Container(
        color: widget.color.withAlpha(30),
        child: Column(
          children: [
            Text(widget.label, style: TextStyle(fontWeight: FontWeight.bold, color: widget.color)),
            Expanded(
              child: Center(
                child: Container(
                  width: 30,
                  height: 150 * _value,
                  decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            Text('\${(_value * 100).toInt()}%', style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
