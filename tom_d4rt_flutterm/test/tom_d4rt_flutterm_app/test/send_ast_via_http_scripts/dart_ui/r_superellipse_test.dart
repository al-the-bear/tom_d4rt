import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for RSuperellipse - squircle rounded shape.
/// Demonstrates continuous corner radius curves.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('RSuperellipse Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RSuperellipse', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('iOS-style continuous corner curves', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(24)),
                      ),
                      const SizedBox(height: 8),
                      const Text('RRect', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Standard corners', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: _SuperellipseClipper(),
                        child: Container(width: 100, height: 100, color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      const Text('RSuperellipse', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Continuous curves', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Used in iOS app icons and UI elements for smoother corner transitions.'),
          ),
        ],
      ),
    ),
  );
}

class _SuperellipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final r = size.width * 0.22;
    path.moveTo(r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(size.width, size.height, size.width - r, size.height);
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
