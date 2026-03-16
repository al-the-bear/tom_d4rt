import 'package:flutter/material.dart';

/// Deep visual demo for WidgetState-aware OutlineInputBorder.
/// Shows different border styles based on interaction state.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('WidgetState Input Border', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _BorderPreview('Default', Colors.grey, 1),
      const SizedBox(height: 8),
      _BorderPreview('Focused', Colors.blue, 2),
      const SizedBox(height: 8),
      _BorderPreview('Error', Colors.red, 2),
      const SizedBox(height: 8),
      _BorderPreview('Disabled', Colors.grey.shade300, 1),
      const SizedBox(height: 12),
      const Text('Border adapts to state', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _BorderPreview extends StatelessWidget {
  final String state;
  final Color color;
  final double width;
  const _BorderPreview(this.state, this.color, this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(state, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}
