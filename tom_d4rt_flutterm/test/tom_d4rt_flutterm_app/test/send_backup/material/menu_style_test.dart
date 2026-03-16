import 'package:flutter/material.dart';

/// Deep visual demo for MenuStyle class.
/// Configures visual properties of Menu widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuStyle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StyleDemo('Default', Colors.white, Colors.grey.shade300, 4),
          const SizedBox(width: 16),
          _StyleDemo('Custom', Colors.blue.shade50, Colors.blue, 12),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Text('backgroundColor, shape, elevation, padding', style: TextStyle(fontSize: 9)),
      ),
    ],
  );
}

class _StyleDemo extends StatelessWidget {
  final String label;
  final Color bg;
  final Color border;
  final double radius;
  const _StyleDemo(this.label, this.bg, this.border, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: border),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Item 1', style: TextStyle(fontSize: 10)),
              Divider(height: 8),
              Text('Item 2', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
