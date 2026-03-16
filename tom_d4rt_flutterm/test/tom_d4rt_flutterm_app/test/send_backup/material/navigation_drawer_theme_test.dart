import 'package:flutter/material.dart';

/// Deep visual demo for NavigationDrawerTheme widget.
/// InheritedWidget providing NavigationDrawerThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationDrawerTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemeSample('Default', Colors.grey.shade100, Colors.grey),
          const SizedBox(width: 12),
          _ThemeSample('Custom', Colors.purple.shade50, Colors.purple),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Wraps subtree with theme', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemeSample extends StatelessWidget {
  final String label;
  final Color bg;
  final Color accent;
  const _ThemeSample(this.label, this.bg, this.accent);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: accent.withAlpha(50), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.home, size: 12, color: accent), const SizedBox(width: 4), Text('Home', style: TextStyle(fontSize: 8, color: accent))],
                ),
              ),
              const SizedBox(height: 4),
              Row(mainAxisSize: MainAxisSize.min, children: [const SizedBox(width: 6), Icon(Icons.inbox, size: 12, color: Colors.grey.shade600), const SizedBox(width: 4), Text('Inbox', style: TextStyle(fontSize: 8, color: Colors.grey.shade600))]),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
