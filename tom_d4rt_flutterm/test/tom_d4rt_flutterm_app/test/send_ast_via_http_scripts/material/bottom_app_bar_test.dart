import 'package:flutter/material.dart';

/// Deep visual demo for BottomAppBar - a material bottom app bar widget.
/// Shows the bottom app bar with FAB notch and actions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BottomAppBar Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 280,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Bottom app bar visual
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
                  ],
                ),
              ),
            ),
            // FAB
            Positioned(
              bottom: 28,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Supports FAB notch and elevation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
