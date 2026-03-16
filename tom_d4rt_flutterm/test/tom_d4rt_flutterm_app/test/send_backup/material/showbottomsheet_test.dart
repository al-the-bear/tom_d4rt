import 'package:flutter/material.dart';

/// Deep visual demo for showBottomSheet function.
/// Shows a persistent bottom sheet attached to scaffold.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showBottomSheet()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Container(color: Colors.grey.shade100),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(width: 32, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 8),
                    const Text('Content', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Returns PersistentBottomSheetController', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
