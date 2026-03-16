import 'package:flutter/material.dart';

/// Deep visual demo for Scrollbar widget.
/// Displays a scrollbar that indicates current scroll position.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Scrollbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, i) => Container(
                  height: 24,
                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  color: Colors.blue.shade100,
                  alignment: Alignment.center,
                  child: Text('Item \$i', style: const TextStyle(fontSize: 10)),
                ),
              ),
            ),
            Positioned(
              right: 2,
              top: 20,
              child: Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('thumbVisibility, trackVisibility, radius', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
