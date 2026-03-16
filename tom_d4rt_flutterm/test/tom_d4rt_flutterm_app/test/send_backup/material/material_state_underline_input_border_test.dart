import 'package:flutter/material.dart';

/// Deep visual demo for WidgetState-aware UnderlineInputBorder.
/// Shows underline styles based on interaction state.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('WidgetState Underline Border', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _UnderlinePreview('Default', Colors.grey, 1),
      const SizedBox(height: 12),
      _UnderlinePreview('Focused', Colors.blue, 2),
      const SizedBox(height: 12),
      _UnderlinePreview('Error', Colors.red, 2),
      const SizedBox(height: 12),
      const Text('Underline adapts to state', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _UnderlinePreview extends StatelessWidget {
  final String state;
  final Color color;
  final double width;
  const _UnderlinePreview(this.state, this.color, this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(state, style: TextStyle(color: color, fontSize: 12)),
          const SizedBox(height: 4),
          Container(height: width, color: color),
        ],
      ),
    );
  }
}
