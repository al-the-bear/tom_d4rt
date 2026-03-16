import 'package:flutter/material.dart';

/// Deep visual demo for ListTileTitleAlignment enum.
/// Controls vertical alignment of title relative to leading/trailing.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListTileTitleAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _AlignDemo('top', CrossAxisAlignment.start),
          const SizedBox(width: 12),
          _AlignDemo('center', CrossAxisAlignment.center),
          const SizedBox(width: 12),
          _AlignDemo('bottom', CrossAxisAlignment.end),
        ],
      ),
      const SizedBox(height: 12),
      const Text('titleAlignment: threeLine|titleHeight', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _AlignDemo extends StatelessWidget {
  final String label;
  final CrossAxisAlignment align;
  const _AlignDemo(this.label, this.align);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: align,
        children: [
          Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Expanded(
            child: Container(color: Colors.green.shade200, height: 40),
          ),
        ],
      ),
    );
  }
}
