import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ClipPathEngineLayer - path-based clipping layer.
/// Demonstrates custom path clipping in the rendering layer.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ClipPathEngineLayer Demo')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Custom Path Clipping', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ClipPath(
            clipper: _StarClipper(),
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text('Clipped!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('ClipPathEngineLayer clips using custom Path shapes', textAlign: TextAlign.center),
          ),
        ],
      ),
    ),
  );
}

class _StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = size.width / 4;
    
    for (int i = 0; i < 10; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * 36 - 90) * 3.14159 / 180;
      final point = Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  double cos(double radians) => radians.abs() < 0.001 ? 1 : (1 - radians * radians / 2);
  double sin(double radians) => radians;

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
