import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _SuperellipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final shape = RSuperellipse.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(24),
    );
    return Path()..addRSuperellipse(shape);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

dynamic build(BuildContext context) {
  final shape = RSuperellipse.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, 220, 120),
    const Radius.circular(24),
  );
  final layer = ClipRSuperellipseLayer(
    clipRSuperellipse: shape,
    clipBehavior: Clip.antiAlias,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ClipRSuperellipseLayer Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipPath(
          clipper: _SuperellipseClipper(),
          child: Container(
            width: 220,
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Clipped Superellipse',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Layer type: ${layer.runtimeType}'),
        Text('Clip behavior: ${layer.clipBehavior.name}'),
      ],
    ),
  );
}
