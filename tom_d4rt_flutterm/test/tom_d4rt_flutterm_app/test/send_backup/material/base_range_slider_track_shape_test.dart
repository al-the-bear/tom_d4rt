import 'package:flutter/material.dart';

/// Deep visual demo for BaseRangeSliderTrackShape - abstract base for range slider tracks.
/// Shows the track structure with active and inactive portions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BaseRangeSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Track visualization
            Container(
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Full track (inactive)
                  Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  // Active portion
                  Positioned(
                    left: 60,
                    right: 60,
                    child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2))),
                  ),
                  // Thumbs
                  Positioned(left: 50, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
                  Positioned(right: 50, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Label('Inactive', Colors.grey),
                _Label('Active', Colors.blue),
                _Label('Inactive', Colors.grey),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Base class for custom range slider tracks', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _Label extends StatelessWidget {
  final String text;
  final Color color;
  const _Label(this.text, this.color);
  @override
  Widget build(BuildContext context) => Text(text, style: TextStyle(fontSize: 10, color: color));
}
