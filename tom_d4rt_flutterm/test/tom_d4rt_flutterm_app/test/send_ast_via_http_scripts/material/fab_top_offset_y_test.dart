import 'package:flutter/material.dart';

/// Deep visual demo for FabTopOffsetY - mixin for top-positioned FAB.
/// Shows FAB positioned at the top of the Scaffold.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FabTopOffsetY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // App bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: const Text('App Bar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            // FAB at top right
            Positioned(
              top: 24,
              right: 16,
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
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('FAB positioned near top', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
