import 'package:flutter/material.dart';

/// Deep visual demo for MaterialTapTargetSize enum.
/// Controls minimum tap target size for accessibility.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialTapTargetSize', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TapTargetDemo('padded', 48, true),
          const SizedBox(width: 24),
          _TapTargetDemo('shrinkWrap', 24, false),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('48x48 minimum for accessibility', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _TapTargetDemo extends StatelessWidget {
  final String label;
  final double size;
  final bool padded;
  const _TapTargetDemo(this.label, this.size, this.padded);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: padded ? Colors.blue.withAlpha(50) : Colors.transparent,
            border: Border.all(color: Colors.blue, style: BorderStyle.solid),
          ),
          child: Center(
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10)),
        Text('${size.toInt()}x${size.toInt()}', style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}
