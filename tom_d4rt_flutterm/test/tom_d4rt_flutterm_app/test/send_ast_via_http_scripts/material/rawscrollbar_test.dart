import 'package:flutter/material.dart';

/// Deep visual demo for RawScrollbar widget.
/// Scrollbar without Material styling.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RawScrollbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Item 1', style: TextStyle(fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Item 2', style: TextStyle(fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Item 3', style: TextStyle(fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Item 4', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            Positioned(
              right: 2,
              top: 8,
              child: Container(
                width: 6,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('thumbColor, thickness, radius', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
