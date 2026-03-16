import 'package:flutter/material.dart';

/// Deep visual demo for GridTileBar.
/// Shows header/footer bar for GridTile with title and icons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('GridTileBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // Image area
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Center(child: Icon(Icons.image, size: 40, color: Colors.white)),
            ),
            // GridTileBar (footer)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 12, backgroundColor: Colors.white, child: Icon(Icons.person, size: 14)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Title', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        Text('Subtitle', style: TextStyle(color: Colors.white70, fontSize: 9)),
                      ],
                    ),
                  ),
                  const Icon(Icons.favorite_border, color: Colors.white, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('leading, title, subtitle, trailing', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
