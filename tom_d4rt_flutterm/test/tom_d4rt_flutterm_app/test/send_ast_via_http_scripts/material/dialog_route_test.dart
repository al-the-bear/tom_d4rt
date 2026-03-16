import 'package:flutter/material.dart';

/// Deep visual demo for DialogRoute - route for displaying dialogs.
/// Shows how DialogRoute integrates with Navigator.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DialogRoute Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Route stack visualization
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text('Navigator Stack', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // DialogRoute on top
            Container(
              width: 160,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: const Text('DialogRoute', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 4),
            // Page route below
            Container(
              width: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('PageRoute', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Adds dialog to Navigator as a route', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
