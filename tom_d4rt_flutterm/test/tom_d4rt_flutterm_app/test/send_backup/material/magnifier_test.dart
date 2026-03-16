import 'package:flutter/material.dart';

/// Deep visual demo for Magnifier widget.
/// Shows text selection magnification lens.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Magnifier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Text beneath
            const Center(
              child: Text('Hello World', style: TextStyle(fontSize: 14)),
            ),
            // Magnifier lens
            Positioned(
              top: 20,
              left: 70,
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: const Center(
                  child: Text('Wor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Magnifies text during selection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
