import 'package:flutter/material.dart';

/// Deep visual demo for TextButtonTheme widget.
/// Inherited widget providing TextButtonThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextButtonTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('TextButtonTheme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ThemedButton('Default', Colors.blue, Colors.blue.shade50),
                const SizedBox(width: 12),
                _ThemedButton('Custom', Colors.purple, Colors.purple.shade100),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('style: ButtonStyle', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemedButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color overlayColor;
  const _ThemedButton(this.label, this.textColor, this.overlayColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: overlayColor.withAlpha(75), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}
