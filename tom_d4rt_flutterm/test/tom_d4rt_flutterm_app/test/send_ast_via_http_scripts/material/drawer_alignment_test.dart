import 'package:flutter/material.dart';

/// Deep visual demo for DrawerAlignment - enum for drawer position.
/// Shows start vs end drawer alignment.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DrawerAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Start
          _AlignmentDemo('start', Alignment.centerLeft, Colors.blue),
          const SizedBox(width: 24),
          // End
          _AlignmentDemo('end', Alignment.centerRight, Colors.green),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('LTR: start=left, end=right\nRTL: start=right, end=left', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _AlignmentDemo extends StatelessWidget {
  final String label;
  final Alignment align;
  final Color color;
  const _AlignmentDemo(this.label, this.align, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Align(
                alignment: align,
                child: Container(
                  width: 30,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.horizontal(
                      left: align == Alignment.centerRight ? const Radius.circular(4) : Radius.zero,
                      right: align == Alignment.centerLeft ? const Radius.circular(4) : Radius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
