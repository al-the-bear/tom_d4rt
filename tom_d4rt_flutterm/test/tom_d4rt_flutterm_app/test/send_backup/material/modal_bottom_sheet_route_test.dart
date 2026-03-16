import 'package:flutter/material.dart';

/// Deep visual demo for ModalBottomSheetRoute.
/// Route that shows bottom sheet modally.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ModalBottomSheetRoute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 240,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Container(color: Colors.grey.shade200, child: const Center(child: Text('Page Content', style: TextStyle(color: Colors.grey)))),
            // Scrim overlay
            Container(color: Colors.black45),
            // Bottom sheet
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Container(width: 40, height: 4, margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                    const Padding(padding: EdgeInsets.all(12), child: Text('Modal Sheet', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Text('Blocks interaction behind', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('isScrollControlled, showDragHandle', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
