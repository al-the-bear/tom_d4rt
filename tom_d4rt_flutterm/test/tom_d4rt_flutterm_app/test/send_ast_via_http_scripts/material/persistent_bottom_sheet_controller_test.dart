import 'package:flutter/material.dart';

/// Deep visual demo for PersistentBottomSheetController.
/// Controls persistent bottom sheet state.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PersistentBottomSheetController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Container(color: Colors.grey.shade100, child: const Center(child: Text('Scaffold', style: TextStyle(color: Colors.grey)))),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -2))],
                ),
                child: Column(
                  children: [
                    Container(width: 40, height: 4, margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                    const Text('Persistent Sheet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const Text('Stays open', style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('controller.close() to dismiss', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
