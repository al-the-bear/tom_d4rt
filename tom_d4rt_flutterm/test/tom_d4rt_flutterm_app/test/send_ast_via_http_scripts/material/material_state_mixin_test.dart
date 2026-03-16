import 'package:flutter/material.dart';

/// Deep visual demo for MaterialStateMixin.
/// Mixin for widgets that track Material interaction states.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialStateMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _StateChip('hovered', Colors.blue),
          _StateChip('focused', Colors.purple),
          _StateChip('pressed', Colors.green),
          _StateChip('dragged', Colors.orange),
          _StateChip('selected', Colors.teal),
          _StateChip('disabled', Colors.grey),
          _StateChip('error', Colors.red),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Track WidgetState for styling', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _StateChip extends StatelessWidget {
  final String state;
  final Color color;
  const _StateChip(this.state, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(state, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
