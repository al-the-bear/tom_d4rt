import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldMessenger widget.
/// Ancestor widget for managing SnackBars/Banners.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldMessenger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 140,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Container(color: Colors.grey.shade100),
            // Banner at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.amber.shade100,
                child: const Row(
                  children: [
                    Icon(Icons.info, size: 14, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('MaterialBanner', style: TextStyle(fontSize: 9)),
                  ],
                ),
              ),
            ),
            // SnackBar at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade800,
                child: const Row(
                  children: [
                    Expanded(child: Text('SnackBar message', style: TextStyle(color: Colors.white, fontSize: 9))),
                    Text('ACTION', style: TextStyle(color: Colors.blue, fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Persists across route changes', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
