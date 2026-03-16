import 'package:flutter/material.dart';

/// Deep visual demo for IconTheme.
/// Shows how IconTheme affects descendant icons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('IconTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Default theme
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: const [
                    Icon(Icons.home),
                    SizedBox(width: 8),
                    Icon(Icons.star),
                    SizedBox(width: 8),
                    Icon(Icons.favorite),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Default', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 16),
          // Custom theme
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: const [
                    Icon(Icons.home, color: Colors.purple, size: 28),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.purple, size: 28),
                    SizedBox(width: 8),
                    Icon(Icons.favorite, color: Colors.purple, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Themed', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('InheritedWidget for icon defaults', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
