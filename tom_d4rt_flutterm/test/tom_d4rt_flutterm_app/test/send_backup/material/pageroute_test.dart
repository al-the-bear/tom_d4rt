import 'package:flutter/material.dart';

/// Deep visual demo for MaterialPageRoute.
/// Route with material design page transition.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialPageRoute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 100,
        child: Stack(
          children: [
            // Page A (going away)
            Positioned(
              left: 0,
              child: Opacity(
                opacity: 0.5,
                child: Transform.translate(
                  offset: const Offset(-30, 0),
                  child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Text('Page A', style: TextStyle(color: Colors.grey))),
                  ),
                ),
              ),
            ),
            // Page B (entering)
            Positioned(
              right: 0,
              child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(-4, 0))]),
                child: const Center(child: Text('Page B', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Slide transition from right', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
