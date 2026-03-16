import 'package:flutter/material.dart';

/// Deep visual demo for progress indicator variants.
/// Determinate vs indeterminate, styles.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Progress Variants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ProgressDemo('Determinate', 0.65),
          const SizedBox(width: 24),
          _ProgressDemo('Indeterminate', null),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 6,
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            Expanded(flex: 65, child: Container(decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(3)))),
            const Expanded(flex: 35, child: SizedBox()),
          ],
        ),
      ),
      const SizedBox(height: 4),
      const Text('Buffered progress', style: TextStyle(fontSize: 9, color: Colors.grey)),
    ],
  );
}

class _ProgressDemo extends StatelessWidget {
  final String label;
  final double? value;
  const _ProgressDemo(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: value != null
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(value: value, strokeWidth: 3, backgroundColor: Colors.grey.shade200),
                    Text('${(value! * 100).toInt()}%', style: const TextStyle(fontSize: 8)),
                  ],
                )
              : const CircularProgressIndicator(strokeWidth: 3),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
