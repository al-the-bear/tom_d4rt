import 'package:flutter/material.dart';

/// Deep visual demo for PredictiveBackPageTransitionsBuilder.
/// Android 14+ predictive back gesture support.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PredictiveBackPageTransitionsBuilder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Container(color: Colors.grey.shade200),
            // Gesture from edge
            Positioned(
              left: 0,
              top: 40,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue.withAlpha(100), Colors.transparent]),
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.blue, size: 20),
              ),
            ),
            // Scaled/translated page
            Center(
              child: Transform.scale(
                scale: 0.9,
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
                  child: const Center(child: Text('Page', style: TextStyle(fontSize: 12))),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Preview page behind on back', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
