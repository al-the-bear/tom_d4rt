import 'package:flutter/material.dart';

/// Deep visual demo for EndDrawerButton - button that opens Scaffold endDrawer.
/// Shows the end drawer toggle button.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('EndDrawerButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // AppBar context
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('App Title', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
              ),
              child: const Icon(Icons.menu_open, color: Colors.white),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // Visualization
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            const Center(child: Text('Content', style: TextStyle(color: Colors.grey))),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('End', style: TextStyle(color: Colors.white, fontSize: 10)),
                    Text('Drawer', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
