import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for Category annotation - categorizes library members.
/// Shows how documentation categories organize API elements.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Category Annotation Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'API Documentation Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _CategoryCard(
            category: 'Widgets',
            icon: Icons.widgets,
            color: Colors.blue,
            items: ['Container', 'Row', 'Column', 'Text'],
          ),
          const SizedBox(height: 12),
          _CategoryCard(
            category: 'Animation',
            icon: Icons.animation,
            color: Colors.orange,
            items: ['AnimationController', 'Tween', 'Curve'],
          ),
          const SizedBox(height: 12),
          _CategoryCard(
            category: 'Painting',
            icon: Icons.brush,
            color: Colors.purple,
            items: ['Canvas', 'Paint', 'Path'],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "@Category(['Widgets']) annotation helps organize API docs",
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;
  final Color color;
  final List<String> items;
  const _CategoryCard({
    required this.category,
    required this.icon,
    required this.color,
    required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: items
                      .map(
                        (item) => Chip(
                          label: Text(
                            item,
                            style: const TextStyle(fontSize: 11),
                          ),
                          backgroundColor: color.withValues(alpha: 0.1),
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
