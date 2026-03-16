import 'package:flutter/material.dart';

/// Deep visual demo for GridTile.
/// Shows grid item with optional header/footer bars.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('GridTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simple GridTile
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.green.shade200, borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('Child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 16),
          // GridTile with footer
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.purple.shade200),
            child: Column(
              children: [
                const Expanded(child: Center(child: Icon(Icons.photo, color: Colors.white, size: 32))),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: const Text('Footer', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('child + header/footer', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
