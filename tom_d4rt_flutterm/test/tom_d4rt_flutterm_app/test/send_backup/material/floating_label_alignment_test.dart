import 'package:flutter/material.dart';

/// Deep visual demo for FloatingLabelAlignment.
/// Shows how floating labels align within InputDecoration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FloatingLabelAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _InputPreview('Start Aligned', FloatingLabelAlignment.start),
      const SizedBox(height: 12),
      _InputPreview('Center Aligned', FloatingLabelAlignment.center),
      const SizedBox(height: 12),
      const Text('Controls label position when floating', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _InputPreview extends StatelessWidget {
  final String title;
  final FloatingLabelAlignment alignment;
  const _InputPreview(this.title, this.alignment);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: alignment == FloatingLabelAlignment.start ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: Colors.blue.shade700)),
          const SizedBox(height: 4),
          Container(
            height: 32,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
            child: const Align(alignment: Alignment.centerLeft, child: Text('Input value', style: TextStyle(fontSize: 12))),
          ),
        ],
      ),
    );
  }
}
