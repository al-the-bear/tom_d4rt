import 'package:flutter/material.dart';

/// Deep visual demo for TabPageSelectorIndicator widget.
/// Single dot indicator for TabPageSelector.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabPageSelectorIndicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IndicatorDemo(1.0),
          const SizedBox(width: 8),
          _IndicatorDemo(0.5),
          const SizedBox(width: 8),
          _IndicatorDemo(0.0),
        ],
      ),
      const SizedBox(height: 12),
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('backgroundColor: ', style: TextStyle(fontSize: 10)),
          _ColorChip('selected', Colors.blue),
          SizedBox(width: 8),
          _ColorChip('unselected', Colors.grey),
        ],
      ),
    ],
  );
}

class _IndicatorDemo extends StatelessWidget {
  final double value;
  const _IndicatorDemo(this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(Colors.grey, Colors.blue, value),
            border: Border.all(color: Colors.blue.withAlpha(50)),
          ),
        ),
        const SizedBox(height: 4),
        Text('${(value * 100).toInt()}%', style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _ColorChip extends StatelessWidget {
  final String label;
  final Color color;
  const _ColorChip(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
