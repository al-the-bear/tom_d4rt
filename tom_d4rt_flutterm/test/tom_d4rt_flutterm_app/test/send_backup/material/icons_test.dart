import 'package:flutter/material.dart';

/// Deep visual demo for Material Icons.
/// Shows commonly used Material Design icons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Material Icons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _IconPreview(Icons.home, 'home'),
          _IconPreview(Icons.search, 'search'),
          _IconPreview(Icons.menu, 'menu'),
          _IconPreview(Icons.settings, 'settings'),
          _IconPreview(Icons.person, 'person'),
          _IconPreview(Icons.favorite, 'favorite'),
          _IconPreview(Icons.star, 'star'),
          _IconPreview(Icons.add, 'add'),
          _IconPreview(Icons.delete, 'delete'),
          _IconPreview(Icons.edit, 'edit'),
          _IconPreview(Icons.share, 'share'),
          _IconPreview(Icons.close, 'close'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('7,000+ icons available', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _IconPreview extends StatelessWidget {
  final IconData icon;
  final String name;
  const _IconPreview(this.icon, this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 2),
          Text(name, style: const TextStyle(fontSize: 7)),
        ],
      ),
    );
  }
}
