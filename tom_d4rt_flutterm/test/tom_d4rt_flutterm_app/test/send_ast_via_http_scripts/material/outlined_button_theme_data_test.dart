import 'package:flutter/material.dart';

/// Deep visual demo for OutlinedButtonThemeData.
/// Configures visual properties of OutlinedButton.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('OutlinedButtonThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Column(
        children: [
          _ThemedButton('Default', Colors.blue, 1),
          const SizedBox(height: 8),
          _ThemedButton('Bold Border', Colors.purple, 2),
          const SizedBox(height: 8),
          _ThemedButton('Rounded', Colors.green, 1, rounded: true),
        ],
      ),
      const SizedBox(height: 12),
      const Text('style property on OutlinedButton', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemedButton extends StatelessWidget {
  final String label;
  final Color color;
  final double borderWidth;
  final bool rounded;
  const _ThemedButton(this.label, this.color, this.borderWidth, {this.rounded = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: borderWidth),
        borderRadius: BorderRadius.circular(rounded ? 20 : 8),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
