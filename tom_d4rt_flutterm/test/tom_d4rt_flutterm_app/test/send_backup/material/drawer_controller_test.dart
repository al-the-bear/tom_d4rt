import 'package:flutter/material.dart';

/// Deep visual demo for DrawerController - controls drawer animation.
/// Shows how the controller manages drawer open/close states.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DrawerController Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 250,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Main content
            const Center(child: Text('Main Content', style: TextStyle(color: Colors.grey))),
            // Drawer sliding in
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu, color: Colors.white),
                    SizedBox(height: 8),
                    Text('Drawer', style: TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Text('drawerController.open()\ndrawerController.close()', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ),
    ],
  );
}
