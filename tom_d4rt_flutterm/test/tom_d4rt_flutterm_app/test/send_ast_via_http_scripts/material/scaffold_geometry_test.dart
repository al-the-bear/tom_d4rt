import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldGeometry class.
/// Describes geometry of Scaffold components.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldGeometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            // FAB notch
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 30,
                color: Colors.blue.shade100,
                alignment: Alignment.center,
                child: const Text('bottomNavigationBar', style: TextStyle(fontSize: 8)),
              ),
            ),
            // FAB with geometry annotation
            Positioned(
              right: 60,
              bottom: 15,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
                    child: const Text('floatingActionButtonArea', style: TextStyle(fontSize: 6)),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('floatingActionButtonArea, bottomNavigationBarTop', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
