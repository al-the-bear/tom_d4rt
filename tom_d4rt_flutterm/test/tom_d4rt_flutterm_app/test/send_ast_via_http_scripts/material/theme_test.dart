import 'package:flutter/material.dart';

/// Deep visual demo for Theme widget.
/// Inherited widget providing ThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Theme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ThemeAccess('.colorScheme.primary', Colors.blue),
                const SizedBox(width: 8),
                _ThemeAccess('.colorScheme.secondary', Colors.teal),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('.textTheme.bodyLarge', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Provides theming to all descendants', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemeAccess extends StatelessWidget {
  final String path;
  final Color color;
  const _ThemeAccess(this.path, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 4),
          Text(path, style: const TextStyle(fontFamily: 'monospace', fontSize: 7)),
        ],
      ),
    );
  }
}
