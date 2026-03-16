import 'package:flutter/material.dart';

/// Deep visual demo for BottomAppBarThemeData - theme data for BottomAppBar.
/// Shows configurable properties for styling bottom app bars.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BottomAppBarThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemePreview('Light', Colors.grey.shade100, Colors.black),
          const SizedBox(width: 16),
          _ThemePreview('Dark', Colors.grey.shade800, Colors.white),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text('• color: Background color', style: TextStyle(fontSize: 10)),
            Text('• elevation: Shadow depth', style: TextStyle(fontSize: 10)),
            Text('• shadowColor: Shadow color', style: TextStyle(fontSize: 10)),
            Text('• surfaceTintColor: Tint overlay', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}

class _ThemePreview extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _ThemePreview(this.label, this.bg, this.fg);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.menu, color: fg, size: 18), const SizedBox(width: 8), Icon(Icons.search, color: fg, size: 18)],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
