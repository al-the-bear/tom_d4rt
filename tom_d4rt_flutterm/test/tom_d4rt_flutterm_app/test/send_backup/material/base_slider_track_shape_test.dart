import 'package:flutter/material.dart';

/// Deep visual demo for BaseSliderTrackShape - abstract base for slider tracks.
/// Shows the track structure with active and inactive portions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BaseSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Single slider track
            Container(
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Full track
                  Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  // Active portion (left side)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(height: 4, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2))),
                    ),
                  ),
                  // Thumb
                  Positioned(
                    left: 100,
                    child: Container(width: 24, height: 24, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)])),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text('Active', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.green))),
                Expanded(child: Text('Inactive', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey))),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Extend to create custom slider track shapes', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
