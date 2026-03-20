// D4rt test script: Deep demo for RSuperellipse from dart:ui
//
// RSuperellipse is a rounded shape similar to RRect but with smoother,
// continuous-curvature corners (iOS-style "squircle" shapes). Unlike RRect
// which uses circular arcs for corners, RSuperellipse uses superellipse curves.
//
// Key characteristics:
//   - Extends _RRectLike<RSuperellipse> (similar API to RRect)
//   - Smoother corners than circular RRect
//   - Used for iOS-style rounded rectangles
//   - Has various constructors: fromLTRBXY, fromRectXY, fromRectAndCorners, etc.
//   - Properties: left, top, right, bottom, width, height, corner radii
//   - Methods: contains, shift, inflate, deflate
//
// This demo visually compares RSuperellipse with RRect and demonstrates
// various corner configurations.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF6A1B9A), const Color(0xFF9C27B0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6A1B9A).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.rounded_corner, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF9C27B0).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF9C27B0), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShapeComparison() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'RSuperellipse vs RRect',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Standard RRect
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3949AB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'RRect',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Circular arcs',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            // RSuperellipse (simulated with ClipPath)
            Column(
              children: [
                ClipPath(
                  clipper: _SuperellipseClipper(20),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFF9C27B0),
                    child: const Center(
                      child: Text(
                        'Squircle',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Continuous curve',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'RSuperellipse uses continuous-curvature corners (superellipse formula) '
            'creating smoother transitions, like iOS app icons.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

class _SuperellipseClipper extends CustomClipper<Path> {
  final double radius;
  _SuperellipseClipper(this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    final r = radius;
    // Approximate superellipse using cubic bezier curves
    // n=4 superellipse: more squared than circle

    path.moveTo(r, 0);
    path.lineTo(size.width - r, 0);
    // Top-right corner
    path.cubicTo(size.width - r * 0.45, 0, size.width, r * 0.45, size.width, r);
    path.lineTo(size.width, size.height - r);
    // Bottom-right corner
    path.cubicTo(
      size.width,
      size.height - r * 0.45,
      size.width - r * 0.45,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    // Bottom-left corner
    path.cubicTo(
      r * 0.45,
      size.height,
      0,
      size.height - r * 0.45,
      0,
      size.height - r,
    );
    path.lineTo(0, r);
    // Top-left corner
    path.cubicTo(0, r * 0.45, r * 0.45, 0, r, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Widget _buildRadiusVariationsGrid() {
  final radii = [5.0, 10.0, 15.0, 20.0, 25.0, 30.0];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Radius Variations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: radii.map((r) {
            return Column(
              children: [
                ClipPath(
                  clipper: _SuperellipseClipper(r),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.lerp(
                            const Color(0xFF9C27B0),
                            const Color(0xFFE91E63),
                            r / 30,
                          )!,
                          Color.lerp(
                            const Color(0xFF6A1B9A),
                            const Color(0xFFC2185B),
                            r / 30,
                          )!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${r.toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'r=${r.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildAsymmetricCornersDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Asymmetric Corners',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Top corners only
            _buildAsymmetricShape(
              'Top Only',
              topLeft: 20,
              topRight: 20,
              bottomLeft: 0,
              bottomRight: 0,
            ),
            // One corner
            _buildAsymmetricShape(
              'One Corner',
              topLeft: 30,
              topRight: 0,
              bottomLeft: 0,
              bottomRight: 0,
            ),
            // Diagonal
            _buildAsymmetricShape(
              'Diagonal',
              topLeft: 20,
              topRight: 0,
              bottomLeft: 0,
              bottomRight: 20,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left side rounded
            _buildAsymmetricShape(
              'Left Side',
              topLeft: 20,
              topRight: 0,
              bottomLeft: 20,
              bottomRight: 0,
            ),
            // Bottom corners
            _buildAsymmetricShape(
              'Bottom',
              topLeft: 0,
              topRight: 0,
              bottomLeft: 20,
              bottomRight: 20,
            ),
            // All different
            _buildAsymmetricShape(
              'Mixed',
              topLeft: 10,
              topRight: 20,
              bottomLeft: 25,
              bottomRight: 5,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAsymmetricShape(
  String label, {
  required double topLeft,
  required double topRight,
  required double bottomLeft,
  required double bottomRight,
}) {
  return Column(
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
    ],
  );
}

Widget _buildPropertiesCard(ui.RSuperellipse rse) {
  final properties = [
    ['left', '${rse.left.toStringAsFixed(1)}'],
    ['top', '${rse.top.toStringAsFixed(1)}'],
    ['right', '${rse.right.toStringAsFixed(1)}'],
    ['bottom', '${rse.bottom.toStringAsFixed(1)}'],
    ['width', '${rse.width.toStringAsFixed(1)}'],
    ['height', '${rse.height.toStringAsFixed(1)}'],
    ['tlRadiusX', '${rse.tlRadiusX.toStringAsFixed(1)}'],
    ['trRadiusX', '${rse.trRadiusX.toStringAsFixed(1)}'],
    ['blRadiusX', '${rse.blRadiusX.toStringAsFixed(1)}'],
    ['brRadiusX', '${rse.brRadiusX.toStringAsFixed(1)}'],
    ['isFinite', '${rse.isFinite}'],
    ['isEmpty', '${rse.isEmpty}'],
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'RSuperellipse Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: properties.map((p) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 11),
                  children: [
                    TextSpan(
                      text: '${p[0]}: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                    TextSpan(
                      text: p[1],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildConstructorsDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.build, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Constructors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildConstructorItem(
          'fromLTRBXY(l, t, r, b, radiusX, radiusY)',
          'Uniform radii from edges',
        ),
        _buildConstructorItem(
          'fromLTRBR(l, t, r, b, Radius)',
          'Single radius from edges',
        ),
        _buildConstructorItem(
          'fromRectXY(rect, radiusX, radiusY)',
          'Uniform radii from Rect',
        ),
        _buildConstructorItem(
          'fromRectAndRadius(rect, Radius)',
          'Single radius from Rect',
        ),
        _buildConstructorItem(
          'fromLTRBAndCorners(...)',
          'Individual corner radii from edges',
        ),
        _buildConstructorItem(
          'fromRectAndCorners(rect, ...)',
          'Individual corner radii from Rect',
        ),
      ],
    ),
  );
}

Widget _buildConstructorItem(String constructor, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                constructor,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMethodsDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.functions, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Methods',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildMethodItem(
          'contains(Offset point)',
          'Check if point is inside',
          Icons.gps_fixed,
        ),
        _buildMethodItem(
          'shift(Offset offset)',
          'Move by offset',
          Icons.open_with,
        ),
        _buildMethodItem(
          'inflate(double delta)',
          'Expand outward',
          Icons.zoom_out_map,
        ),
        _buildMethodItem(
          'deflate(double delta)',
          'Shrink inward',
          Icons.zoom_in_map,
        ),
        _buildMethodItem('outerRect', 'Bounding rectangle', Icons.crop_square),
        _buildMethodItem(
          'safeInnerRect',
          'Largest inscribed rect',
          Icons.crop_din,
        ),
      ],
    ),
  );
}

Widget _buildMethodItem(String method, String description, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF9C27B0)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                method,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildContainsDemo(ui.RSuperellipse rse) {
  final testPoints = [
    ['Center (100, 50)', const Offset(100, 50)],
    ['Inside (50, 30)', const Offset(50, 30)],
    ['Edge (5, 5)', const Offset(5, 5)],
    ['Outside (250, 150)', const Offset(250, 150)],
    ['Top-left corner', const Offset(2, 2)],
    ['Far outside', const Offset(-50, -50)],
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.my_location, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Point Containment Test',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...testPoints.map((p) {
          final label = p[0] as String;
          final point = p[1] as Offset;
          final contains = rse.contains(point);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  contains ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: contains
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE53935),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 12)),
                ),
                Text(
                  contains ? 'Inside' : 'Outside',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: contains
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFE53935),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildTransformationsDemo(ui.RSuperellipse original) {
  final shifted = original.shift(const Offset(20, 10));
  final inflated = original.inflate(5);
  final deflated = original.deflate(5);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.transform, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'Transformations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTransformRow(
          'Original',
          'left: ${original.left.toInt()}, top: ${original.top.toInt()}',
          const Color(0xFF9C27B0),
        ),
        _buildTransformRow(
          'shift(20, 10)',
          'left: ${shifted.left.toInt()}, top: ${shifted.top.toInt()}',
          const Color(0xFF3949AB),
        ),
        _buildTransformRow(
          'inflate(5)',
          'width: ${inflated.width.toInt()}, height: ${inflated.height.toInt()}',
          const Color(0xFF4CAF50),
        ),
        _buildTransformRow(
          'deflate(5)',
          'width: ${deflated.width.toInt()}, height: ${deflated.height.toInt()}',
          const Color(0xFFFF9800),
        ),
      ],
    ),
  );
}

Widget _buildTransformRow(String operation, String result, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(
            operation,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            result,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIOSStyleDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone_iphone, color: const Color(0xFF9C27B0)),
            const SizedBox(width: 8),
            const Text(
              'iOS-Style App Icons',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'RSuperellipse creates the smooth "squircle" corners used in iOS',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAppIcon(const Color(0xFFFF2D55), Icons.favorite, 'Health'),
            _buildAppIcon(const Color(0xFF5856D6), Icons.music_note, 'Music'),
            _buildAppIcon(const Color(0xFF007AFF), Icons.camera_alt, 'Camera'),
            _buildAppIcon(
              const Color(0xFF34C759),
              Icons.chat_bubble,
              'Messages',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAppIcon(Color color, IconData icon, String label) {
  return Column(
    children: [
      ClipPath(
        clipper: _SuperellipseClipper(14),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, Color.lerp(color, Colors.black, 0.3)!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== RSuperellipse Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- RSuperellipse Overview ---');
  print('RSuperellipse: Rounded rectangle with superellipse corners');
  print('Creates smoother curves than circular RRect corners');
  print('Used for iOS-style "squircle" shapes');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CREATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating RSuperellipse ---');

  // fromRectAndCorners
  final rse1 = ui.RSuperellipse.fromRectAndCorners(
    const Rect.fromLTWH(0, 0, 200, 100),
    topLeft: const Radius.circular(20),
    topRight: const Radius.circular(15),
    bottomLeft: const Radius.circular(10),
    bottomRight: const Radius.circular(25),
  );
  print('fromRectAndCorners:');
  print('  left=${rse1.left}, top=${rse1.top}');
  print('  width=${rse1.width}, height=${rse1.height}');
  print('  tlRadiusX=${rse1.tlRadiusX}, trRadiusX=${rse1.trRadiusX}');
  print('  blRadiusX=${rse1.blRadiusX}, brRadiusX=${rse1.brRadiusX}');

  // fromRectXY
  final rse2 = ui.RSuperellipse.fromRectXY(
    const Rect.fromLTWH(10, 20, 150, 80),
    12.0,
    12.0,
  );
  print('\nfromRectXY (uniform 12x12):');
  print('  width=${rse2.width}, height=${rse2.height}');
  print('  isFinite=${rse2.isFinite}, isEmpty=${rse2.isEmpty}');

  // fromLTRBXY
  final rse3 = ui.RSuperellipse.fromLTRBXY(0, 0, 100, 50, 8, 8);
  print('\nfromLTRBXY:');
  print('  left=${rse3.left}, right=${rse3.right}');

  // fromRectAndRadius
  final rse4 = ui.RSuperellipse.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, 80, 80),
    const Radius.circular(16),
  );
  print('\nfromRectAndRadius (Radius.circular(16)):');
  print('  All corners: ${rse4.tlRadiusX}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Properties ---');
  print('left: ${rse1.left}');
  print('top: ${rse1.top}');
  print('right: ${rse1.right}');
  print('bottom: ${rse1.bottom}');
  print('width: ${rse1.width}');
  print('height: ${rse1.height}');
  print('tlRadiusX: ${rse1.tlRadiusX}, tlRadiusY: ${rse1.tlRadiusY}');
  print('trRadiusX: ${rse1.trRadiusX}, trRadiusY: ${rse1.trRadiusY}');
  print('blRadiusX: ${rse1.blRadiusX}, blRadiusY: ${rse1.blRadiusY}');
  print('brRadiusX: ${rse1.brRadiusX}, brRadiusY: ${rse1.brRadiusY}');
  print('isFinite: ${rse1.isFinite}');
  print('isEmpty: ${rse1.isEmpty}');
  print('outerRect: ${rse1.outerRect}');
  print('safeInnerRect: ${rse1.safeInnerRect}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Methods ---');

  // contains
  final inside = rse1.contains(const Offset(100, 50));
  final outside = rse1.contains(const Offset(300, 300));
  print('contains(100, 50): $inside');
  print('contains(300, 300): $outside');

  // shift
  final shifted = rse1.shift(const Offset(10, 20));
  print('\nshift(10, 20):');
  print('  new left=${shifted.left}, new top=${shifted.top}');

  // inflate/deflate
  final inflated = rse1.inflate(5);
  final deflated = rse1.deflate(5);
  print('\ninflate(5): width=${inflated.width}, height=${inflated.height}');
  print('deflate(5): width=${deflated.width}, height=${deflated.height}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COMPARISON WITH RRECT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- RSuperellipse vs RRect ---');
  print('RRect: Uses circular arc corners');
  print('RSuperellipse: Uses superellipse (squircle) corners');
  print('RSuperellipse has smoother, more continuous curvature');
  print('iOS app icons use superellipse-style corners');

  print('\n=== RSuperellipse Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('RSuperellipse', 'Smooth Continuous-Curvature Corners'),
        const SizedBox(height: 20),

        // Shape comparison
        _buildSectionTitle('Shape Comparison', Icons.compare_arrows),
        _buildShapeComparison(),
        const SizedBox(height: 20),

        // iOS-style demo
        _buildSectionTitle('iOS Design', Icons.phone_iphone),
        _buildIOSStyleDemo(),
        const SizedBox(height: 20),

        // Radius variations
        _buildSectionTitle('Corner Radius', Icons.rounded_corner),
        _buildRadiusVariationsGrid(),
        const SizedBox(height: 20),

        // Asymmetric corners
        _buildAsymmetricCornersDemo(),
        const SizedBox(height: 20),

        // Properties
        _buildSectionTitle('Properties', Icons.list_alt),
        _buildPropertiesCard(rse1),
        const SizedBox(height: 20),

        // Constructors
        _buildConstructorsDemo(),
        const SizedBox(height: 20),

        // Methods
        _buildMethodsDemo(),
        const SizedBox(height: 20),

        // Contains test
        _buildContainsDemo(rse1),
        const SizedBox(height: 20),

        // Transformations
        _buildTransformationsDemo(rse1),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• RSuperellipse provides superellipse (squircle) corners\n'
                '• Smoother than circular RRect corners\n'
                '• Used for iOS-style app icon shapes\n'
                '• Multiple constructors for different needs\n'
                '• Supports asymmetric corner radii\n'
                '• Methods: contains, shift, inflate, deflate',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
