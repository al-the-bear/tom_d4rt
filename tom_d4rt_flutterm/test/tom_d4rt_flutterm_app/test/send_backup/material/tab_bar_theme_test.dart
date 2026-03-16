import 'package:flutter/material.dart';

/// Deep visual demo for TabBarTheme widget.
/// Inherited widget that provides TabBarThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabBarTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('TabBarTheme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ThemeProp('labelColor', Colors.indigo),
                  _ThemeProp('unselectedLabelColor', Colors.indigo.shade300),
                  _ThemeProp('indicatorColor', Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.indigo.shade100), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemedTab('Home', true),
            _ThemedTab('Profile', false),
          ],
        ),
      ),
    ],
  );
}

class _ThemeProp extends StatelessWidget {
  final String name;
  final Color color;
  const _ThemeProp(this.name, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(width: 12, height: 12, color: color),
          const SizedBox(width: 6),
          Text(name, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class _ThemedTab extends StatelessWidget {
  final String label;
  final bool selected;
  const _ThemedTab(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: selected ? const Border(bottom: BorderSide(color: Colors.indigo, width: 2)) : null),
      child: Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.indigo : Colors.indigo.shade300)),
    );
  }
}
