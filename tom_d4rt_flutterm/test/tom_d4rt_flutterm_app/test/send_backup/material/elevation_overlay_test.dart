import 'package:flutter/material.dart';

/// Deep visual demo for ElevationOverlay - dark mode elevation tinting.
/// Shows how elevation adds tint overlay in dark themes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ElevationOverlay Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Light theme
          Column(
            children: [
              const Text('Light', style: TextStyle(fontSize: 10)),
              const SizedBox(height: 8),
              for (final elev in [0.0, 2.0, 4.0, 8.0])
                Container(
                  width: 60,
                  height: 30,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: elev)],
                  ),
                  child: Center(child: Text('${elev.toInt()}', style: const TextStyle(fontSize: 10))),
                ),
            ],
          ),
          const SizedBox(width: 24),
          // Dark theme
          Column(
            children: [
              const Text('Dark', style: TextStyle(fontSize: 10)),
              const SizedBox(height: 8),
              for (final elev in [0.0, 2.0, 4.0, 8.0])
                Container(
                  width: 60,
                  height: 30,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.lerp(Colors.grey.shade900, Colors.white, elev / 40),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(child: Text('${elev.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.white))),
                ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Dark theme: higher elevation = lighter', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
