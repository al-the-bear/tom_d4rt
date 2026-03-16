import 'package:flutter/material.dart';

/// Deep visual demo for Typography class.
/// Material Design typography definitions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Typography', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Typography.material2021()', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypoColumn('black', ['displayLarge', 'bodyLarge']),
                const SizedBox(width: 16),
                _TypoColumn('white', ['displayLarge', 'bodyLarge']),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('black, white, englishLike, dense, tall', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TypoColumn extends StatelessWidget {
  final String theme;
  final List<String> styles;
  const _TypoColumn(this.theme, this.styles);
  @override
  Widget build(BuildContext context) {
    final isDark = theme == 'white';
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(theme, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 4),
          for (final style in styles)
            Text(style, style: TextStyle(fontSize: 8, color: isDark ? Colors.white70 : Colors.black54)),
        ],
      ),
    );
  }
}
