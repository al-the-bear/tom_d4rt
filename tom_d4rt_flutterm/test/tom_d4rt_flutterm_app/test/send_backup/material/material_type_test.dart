import 'package:flutter/material.dart';

/// Deep visual demo for MaterialType enum.
/// Defines the shape of Material widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _TypeDemo('canvas', BoxShape.rectangle, false),
          _TypeDemo('card', BoxShape.rectangle, true),
          _TypeDemo('circle', BoxShape.circle, false),
          _TypeDemo('button', BoxShape.rectangle, true),
          _TypeDemo('transparency', BoxShape.rectangle, false, transparent: true),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Affects clipping and ink splash', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _TypeDemo extends StatelessWidget {
  final String label;
  final BoxShape shape;
  final bool elevated;
  final bool transparent;
  const _TypeDemo(this.label, this.shape, this.elevated, {this.transparent = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: transparent ? Colors.grey.shade200 : Colors.white,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
            boxShadow: elevated ? [BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
            border: transparent ? Border.all(color: Colors.grey, style: BorderStyle.solid) : null,
          ),
          child: Center(child: Icon(Icons.layers, color: transparent ? Colors.grey : Colors.blue)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
