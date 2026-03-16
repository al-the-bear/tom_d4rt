import 'package:flutter/material.dart';

/// Deep visual demo for Slider widget.
/// Material Design slider for selecting values.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Slider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        child: Column(
          children: [
            _SliderDemo('Continuous', 0.6, false),
            const SizedBox(height: 8),
            _SliderDemo('Discrete', 0.4, true),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('value, onChanged, min, max, divisions', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _SliderDemo extends StatelessWidget {
  final String label;
  final double value;
  final bool discrete;
  const _SliderDemo(this.label, this.value, this.discrete);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          height: 30,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              Positioned(left: 0, right: (1 - value) * 200, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
              if (discrete) for (var i = 0; i < 5; i++) Positioned(left: i * 50.0, child: Container(width: 4, height: 4, decoration: BoxDecoration(color: i <= 2 ? Colors.white : Colors.grey, shape: BoxShape.circle))),
              Positioned(left: value * 200 - 10, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]))),
            ],
          ),
        ),
      ],
    );
  }
}
