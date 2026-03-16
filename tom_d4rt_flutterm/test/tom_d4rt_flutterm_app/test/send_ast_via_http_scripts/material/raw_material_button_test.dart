import 'package:flutter/material.dart';

/// Deep visual demo for RawMaterialButton widget.
/// Low-level material button for custom designs.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RawMaterialButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _RawButton(Colors.blue, Colors.white, 'Filled', 0),
          const SizedBox(width: 12),
          _RawButton(Colors.transparent, Colors.blue, 'Outline', 2),
          const SizedBox(width: 12),
          _RawButton(Colors.grey.shade200, Colors.black, 'Flat', 0),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Full control over material properties', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _RawButton extends StatelessWidget {
  final Color fill;
  final Color text;
  final String label;
  final double borderWidth;
  const _RawButton(this.fill, this.text, this.label, this.borderWidth);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(8),
        border: borderWidth > 0 ? Border.all(color: text, width: borderWidth) : null,
        boxShadow: fill != Colors.transparent ? [BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
      ),
      child: Text(label, style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}
