// ignore_for_file: avoid_print
// D4rt test script: Comprehensive deep demo for FractionalOffsetTween
//
// FractionalOffsetTween extends Tween<FractionalOffset?> (rendering library).
// It interpolates between two FractionalOffset values using lerp.
//
// FractionalOffset uses (0,0) = topLeft, (1,1) = bottomRight
// compared to Alignment which uses (-1,-1) = topLeft, (1,1) = bottomRight.
//
// This demo shows:
//   1. Header banner with gradient, icon, title
//   2. FractionalOffset vs Alignment coordinate system comparison
//   3. Key positions grid (9 named positions)
//   4. Lerp timeline at t = 0, 0.25, 0.5, 0.75, 1.0
//   5. Diagonal path animation concept (topLeft -> bottomRight)
//   6. Custom tween paths (various begin/end combos)
//   7. Fractional vs Alignment side-by-side
//   8. Code snippets (basic tween, AnimatedBuilder, TweenAnimationBuilder)
//   9. Real-world use cases (sliding panels, tooltip positioning, drag feedback)
//  10. Summary with test result badge
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Purple / Lavender theme
// ═══════════════════════════════════════════════════════════════════════════

const _kPurple50 = Color(0xFFF3E5F5);
const _kPurple100 = Color(0xFFE1BEE7);
const _kPurple200 = Color(0xFFCE93D8);
const _kPurple300 = Color(0xFFBA68C8);
const _kPurple400 = Color(0xFFAB47BC);
const _kPurple500 = Color(0xFF9C27B0);
const _kPurple600 = Color(0xFF8E24AA);
const _kPurple700 = Color(0xFF7B1FA2);
const _kPurple800 = Color(0xFF6A1B9A);
const _kPurple900 = Color(0xFF4A148C);

const _kAccent = Color(0xFFCE93D8);
const _kSurface = Color(0xFFF3E5F5);
const _kDeepAmber = Color(0xFFFFA000);
const _kTealAccent = Color(0xFF00897B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Section header with gradient and icon
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPurple700, _kPurple500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kPurple700.withAlpha(80),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Themed card wrapper
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  final color = accentColor ?? _kPurple500;
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

/// Dot indicator that shows a position inside a bounded box.
/// [dx] and [dy] are in 0..1 fractional coordinates.
Widget _buildPositionIndicator(
  double dx,
  double dy,
  String label, {
  double size = 100,
  Color? dotColor,
}) {
  final dot = dotColor ?? _kPurple700;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPurple300, width: 2),
    ),
    child: Stack(
      children: [
        // crosshair guides
        Positioned(
          left: size / 2 - 0.5,
          top: 0,
          bottom: 0,
          child: Container(width: 1, color: _kPurple200),
        ),
        Positioned(
          top: size / 2 - 0.5,
          left: 0,
          right: 0,
          child: Container(height: 1, color: _kPurple200),
        ),
        // dot
        Positioned(
          left: dx * (size - 16),
          top: dy * (size - 16),
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [BoxShadow(color: dot.withAlpha(100), blurRadius: 6)],
            ),
          ),
        ),
        // label
        Positioned(
          left: 4,
          bottom: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(180),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Dark code snippet box
Widget _buildCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFFCE93D8),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

/// Property information tile
Widget _buildPropertyTile(String property, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _kPurple500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kPurple900,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _kPurple700.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Labelled value chip
Widget _buildValueChip(String label, String value, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: color.withAlpha(200),
          ),
        ),
      ],
    ),
  );
}

/// Stat badge used in the header area
Widget _buildStatBadge(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(40),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

/// A row comparing two coordinate values side-by-side
Widget _buildCoordCompareRow(
  String coordLabel,
  String fractionalVal,
  String alignmentVal,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            coordLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _kPurple800,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kPurple100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              fractionalVal,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _kPurple900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kTealAccent.withAlpha(30),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              alignmentVal,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _kTealAccent,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Use-case card with icon, description, and example widget
Widget _buildUseCaseCard(String title, String description, Widget example) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepAmber.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: _kDeepAmber.withAlpha(30),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kDeepAmber.withAlpha(30),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb, color: _kDeepAmber, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF795548),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Color(0xFF5D4037)),
              ),
              const SizedBox(height: 12),
              example,
            ],
          ),
        ),
      ],
    ),
  );
}

/// Info callout row (icon + text)
Widget _buildInfoCallout(String text, {Color? color, IconData? icon}) {
  final c = color ?? _kTealAccent;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: c.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withAlpha(80)),
    ),
    child: Row(
      children: [
        Icon(icon ?? Icons.info, color: c, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: c)),
        ),
      ],
    ),
  );
}

/// Comparison row (icon + title + subtitle)
Widget _buildComparisonRow(
  String title,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Type hierarchy node
Widget _buildHierarchyNode(String name, int level, Color color) {
  return Container(
    margin: EdgeInsets.only(left: level * 24.0),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      name,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

/// Connector arrow between hierarchy nodes
Widget _buildHierarchyConnector() {
  return Container(
    margin: const EdgeInsets.only(left: 30),
    height: 20,
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Icon(Icons.arrow_downward, color: _kPurple400, size: 20),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// SECTION BUILDER FUNCTIONS
// ─────────────────────────────────────────────────────────────────────────

/// 1. Header banner
Widget _buildHeaderBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPurple900, _kPurple700, _kPurple500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kPurple900.withAlpha(100),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.open_with, color: Colors.white, size: 48),
        const SizedBox(height: 12),
        const Text(
          'FractionalOffsetTween',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Deep Demo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: _kAccent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Interpolate fractional positions within a parent',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge('Tween<FractionalOffset?>', Icons.animation),
            const SizedBox(width: 12),
            _buildStatBadge('lerp(t)', Icons.timeline),
            const SizedBox(width: 12),
            _buildStatBadge('0..1 coords', Icons.grid_on),
          ],
        ),
      ],
    ),
  );
}

/// 2. Coordinate system comparison: FractionalOffset vs Alignment
Widget _buildCoordinateComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Visual side-by-side boxes
      Row(
        children: [
          // FractionalOffset box
          Expanded(
            child: Container(
              height: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kPurple50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kPurple300, width: 2),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 4,
                    left: 4,
                    child: Text(
                      'FractionalOffset',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _kPurple700,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 4,
                    top: 22,
                    child: Text(
                      '(0,0)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kPurple600,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 4,
                    top: 22,
                    child: Text(
                      '(1,0)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kPurple600,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 4,
                    bottom: 4,
                    child: Text(
                      '(0,1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kPurple600,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 4,
                    bottom: 4,
                    child: Text(
                      '(1,1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kPurple600,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '(0.5, 0.5)',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: _kPurple900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Alignment box
          Expanded(
            child: Container(
              height: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kTealAccent.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _kTealAccent.withAlpha(120),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Text(
                      'Alignment',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    top: 22,
                    child: Text(
                      '(-1,-1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 22,
                    child: Text(
                      '(1,-1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Text(
                      '(-1,1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Text(
                      '(1,1)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '(0.0, 0.0)',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: _kTealAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      // Tabular comparison
      Row(
        children: [
          const SizedBox(width: 100),
          Expanded(
            child: Text(
              'FractionalOffset',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kPurple700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'Alignment',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kTealAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      _buildCoordCompareRow('Top-Left', '(0.0, 0.0)', '(-1.0, -1.0)'),
      _buildCoordCompareRow('Top-Right', '(1.0, 0.0)', '(1.0, -1.0)'),
      _buildCoordCompareRow('Center', '(0.5, 0.5)', '(0.0, 0.0)'),
      _buildCoordCompareRow('Bottom-Left', '(0.0, 1.0)', '(-1.0, 1.0)'),
      _buildCoordCompareRow('Bottom-Right', '(1.0, 1.0)', '(1.0, 1.0)'),
      const SizedBox(height: 12),
      _buildInfoCallout(
        'Conversion: Alignment = FractionalOffset * 2.0 - 1.0  '
        'and  FractionalOffset = (Alignment + 1.0) / 2.0',
        color: _kPurple600,
        icon: Icons.calculate,
      ),
    ],
  );
}

/// 3. Key positions grid (9 named FractionalOffset positions)
Widget _buildPositionsGrid() {
  final positions = [
    ('topLeft', 0.0, 0.0),
    ('topCenter', 0.5, 0.0),
    ('topRight', 1.0, 0.0),
    ('centerLeft', 0.0, 0.5),
    ('center', 0.5, 0.5),
    ('centerRight', 1.0, 0.5),
    ('bottomLeft', 0.0, 1.0),
    ('bottomCenter', 0.5, 1.0),
    ('bottomRight', 1.0, 1.0),
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: positions.map((p) {
      return _buildPositionIndicator(p.$2, p.$3, p.$1, size: 80);
    }).toList(),
  );
}

/// 4. Lerp timeline (shows interpolated values at several t)
Widget _buildLerpTimeline(
  FractionalOffset begin,
  FractionalOffset end,
  List<double> tValues,
) {
  return Column(
    children: [
      // Gradient bar
      Container(
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_kPurple200, _kPurple500, _kDeepAmber],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: tValues.map((t) {
            return Positioned(
              left: t * 280 + 10,
              top: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: _kPurple700, width: 2),
                ),
                child: Center(
                  child: Text(
                    '${(t * 100).toInt()}',
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: _kPurple700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 16),
      // Position indicators per t value
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tValues.map((t) {
          final lerpDx = begin.dx + (end.dx - begin.dx) * t;
          final lerpDy = begin.dy + (end.dy - begin.dy) * t;
          return _buildPositionIndicator(
            lerpDx,
            lerpDy,
            't=${t.toStringAsFixed(2)}',
            size: 60,
          );
        }).toList(),
      ),
    ],
  );
}

/// 5. Diagonal path visualisation
Widget _buildDiagonalPath() {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple300, width: 2),
    ),
    child: Stack(
      children: [
        // bounding area
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            width: 240,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: _kPurple200),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Start dot
        Positioned(
          left: 16,
          top: 16,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _kPurple700,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Mid dot
        Positioned(
          left: 130,
          top: 90,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _kDeepAmber,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // End dot
        Positioned(
          right: 24,
          bottom: 24,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _kPurple400,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                'E',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Legend
        Positioned(
          right: 8,
          top: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildLegendItem('S = begin (0,0)', _kPurple700),
              const SizedBox(height: 4),
              _buildLegendItem('M = t=0.5 (0.5,0.5)', _kDeepAmber),
              const SizedBox(height: 4),
              _buildLegendItem('E = end (1,1)', _kPurple400),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Small legend item for the diagonal path
Widget _buildLegendItem(String text, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 4),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    ],
  );
}

/// 6. Custom tween path card
Widget _buildCustomTweenPathCard(
  String title,
  FractionalOffset begin,
  FractionalOffset end,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        _buildPositionIndicator(
          begin.dx,
          begin.dy,
          'begin',
          size: 60,
          dotColor: color,
        ),
        Expanded(
          child: Column(
            children: [
              Icon(Icons.arrow_forward, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '(${begin.dx.toStringAsFixed(1)},${begin.dy.toStringAsFixed(1)}) -> '
                '(${end.dx.toStringAsFixed(1)},${end.dy.toStringAsFixed(1)})',
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: color.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        _buildPositionIndicator(
          end.dx,
          end.dy,
          'end',
          size: 60,
          dotColor: color,
        ),
      ],
    ),
  );
}

/// 7. Side-by-side comparison block (FractionalOffset vs Alignment)
Widget _buildSideBySideComparison() {
  return Column(
    children: [
      _buildComparisonRow(
        'FractionalOffset',
        'Origin at topLeft (0,0), range 0..1',
        _kPurple600,
        Icons.crop_square,
      ),
      const SizedBox(height: 8),
      _buildComparisonRow(
        'Alignment',
        'Origin at center (0,0), range -1..1',
        _kTealAccent,
        Icons.center_focus_strong,
      ),
      const SizedBox(height: 12),
      _buildCodeSnippet(
        '// Equivalent positions:\n'
        'FractionalOffset(0.0, 0.0)  ==  Alignment(-1.0, -1.0)  // topLeft\n'
        'FractionalOffset(0.5, 0.5)  ==  Alignment(0.0, 0.0)    // center\n'
        'FractionalOffset(1.0, 1.0)  ==  Alignment(1.0, 1.0)    // bottomRight\n'
        'FractionalOffset(0.25, 0.75) == Alignment(-0.5, 0.5)   // custom',
      ),
      const SizedBox(height: 12),
      _buildInfoCallout(
        'FractionalOffset is typically used with FractionalTranslation '
        'and SlideTransition for intuitive 0-to-1 positioning.',
        color: _kPurple500,
        icon: Icons.swap_horiz,
      ),
    ],
  );
}

/// 8a. Code snippet: basic tween
Widget _buildCodeBasicTween() {
  return _buildCodeSnippet(
    'final tween = FractionalOffsetTween(\n'
    '  begin: FractionalOffset(0.0, 0.0),\n'
    '  end: FractionalOffset(1.0, 1.0),\n'
    ');\n'
    '\n'
    '// Evaluate at midpoint\n'
    'final mid = tween.lerp(0.5);\n'
    'print(mid); // FractionalOffset(0.5, 0.5)',
  );
}

/// 8b. Code snippet: AnimatedBuilder usage
Widget _buildCodeAnimatedBuilder() {
  return _buildCodeSnippet(
    'late final _ctrl = AnimationController(\n'
    '  duration: Duration(seconds: 1),\n'
    '  vsync: this,\n'
    ');\n'
    '\n'
    'late final _offsetAnim = FractionalOffsetTween(\n'
    '  begin: FractionalOffset(0, 0),\n'
    '  end: FractionalOffset(1, 1),\n'
    ').animate(CurvedAnimation(\n'
    '  parent: _ctrl,\n'
    '  curve: Curves.easeInOut,\n'
    '));\n'
    '\n'
    'AnimatedBuilder(\n'
    '  animation: _offsetAnim,\n'
    '  builder: (context, child) {\n'
    '    return Align(\n'
    '      alignment: _offsetAnim.value!,\n'
    '      child: child,\n'
    '    );\n'
    '  },\n'
    '  child: Icon(Icons.star),\n'
    ')',
  );
}

/// 8c. Code snippet: TweenAnimationBuilder
Widget _buildCodeTweenAnimationBuilder() {
  return _buildCodeSnippet(
    'TweenAnimationBuilder<FractionalOffset?>(\n'
    '  tween: FractionalOffsetTween(\n'
    '    begin: FractionalOffset(0, 0),\n'
    '    end: FractionalOffset(1, 0.5),\n'
    '  ),\n'
    '  duration: Duration(milliseconds: 600),\n'
    '  builder: (context, value, child) {\n'
    '    return Align(\n'
    '      alignment: value ?? FractionalOffset.center,\n'
    '      child: child,\n'
    '    );\n'
    '  },\n'
    '  child: Container(\n'
    '    width: 40, height: 40,\n'
    '    color: Colors.purple,\n'
    '  ),\n'
    ')',
  );
}

/// 9. Real-world use-case illustrative block
Widget _buildUseCaseSlidingPanel() {
  return Row(
    children: [
      _buildPositionIndicator(
        0.0,
        0.5,
        'hidden',
        size: 60,
        dotColor: _kPurple800,
      ),
      const SizedBox(width: 8),
      const Icon(Icons.arrow_forward, color: _kPurple400),
      const SizedBox(width: 8),
      _buildPositionIndicator(
        0.8,
        0.5,
        'visible',
        size: 60,
        dotColor: _kPurple400,
      ),
    ],
  );
}

Widget _buildUseCaseTooltip() {
  return Row(
    children: [
      _buildPositionIndicator(
        0.5,
        1.0,
        'below',
        size: 60,
        dotColor: _kDeepAmber,
      ),
      const SizedBox(width: 8),
      const Icon(Icons.swap_vert, color: _kDeepAmber),
      const SizedBox(width: 8),
      _buildPositionIndicator(
        0.5,
        0.0,
        'above',
        size: 60,
        dotColor: _kDeepAmber,
      ),
    ],
  );
}

Widget _buildUseCaseDragFeedback() {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _buildPositionIndicator(
        0.2,
        0.3,
        'pick',
        size: 55,
        dotColor: _kTealAccent,
      ),
      _buildPositionIndicator(
        0.5,
        0.5,
        'drag',
        size: 55,
        dotColor: _kTealAccent,
      ),
      _buildPositionIndicator(
        0.8,
        0.7,
        'drop',
        size: 55,
        dotColor: _kTealAccent,
      ),
    ],
  );
}

/// 10. Summary / result badge
Widget _buildSummaryBadge() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPurple100, _kPurple50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple300),
    ),
    child: Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _kPurple700,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: _kPurple700.withAlpha(80), blurRadius: 12),
            ],
          ),
          child: const Icon(Icons.check_circle, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 12),
        const Text(
          'FractionalOffsetTween Demo Complete',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kPurple800,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _kPurple700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'ALL SECTIONS RENDERED',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildValueChip('Sections', '10', _kPurple700),
            _buildValueChip('Coord System', '0..1', _kPurple600),
            _buildValueChip('Positions', '9', _kPurple500),
            _buildValueChip('Theme', 'Purple', _kPurple400),
          ],
        ),
      ],
    ),
  );
}

/// Type hierarchy for FractionalOffsetTween
Widget _buildTypeHierarchy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildHierarchyNode('Animatable<FractionalOffset?>', 0, _kPurple300),
      _buildHierarchyConnector(),
      _buildHierarchyNode('Tween<FractionalOffset?>', 1, _kPurple500),
      _buildHierarchyConnector(),
      _buildHierarchyNode('FractionalOffsetTween', 2, _kPurple700),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // ── Create test tweens ──────────────────────────────────────────────
  final diagonalTween = FractionalOffsetTween(
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 1.0),
  );

  final horizontalTween = FractionalOffsetTween(
    begin: const FractionalOffset(0.0, 0.5),
    end: const FractionalOffset(1.0, 0.5),
  );

  final verticalTween = FractionalOffsetTween(
    begin: const FractionalOffset(0.5, 0.0),
    end: const FractionalOffset(0.5, 1.0),
  );

  // ── Lerp calculations for print output ─────────────────────────────
  final lerpSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

  print('=== FractionalOffsetTween Deep Demo ===');
  print('');
  print('Diagonal tween: ${diagonalTween.begin} -> ${diagonalTween.end}');
  for (final t in lerpSteps) {
    final v = diagonalTween.lerp(t);
    print('  lerp($t) = $v');
  }
  print('');
  print('Horizontal tween: ${horizontalTween.begin} -> ${horizontalTween.end}');
  print('  lerp(0.5) = ${horizontalTween.lerp(0.5)}');
  print('');
  print('Vertical tween: ${verticalTween.begin} -> ${verticalTween.end}');
  print('  lerp(0.5) = ${verticalTween.lerp(0.5)}');
  print('');
  print('Demo rendering complete.');

  // ── UI ──────────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Header Banner ──────────────────────────────────────────
        _buildHeaderBanner(),
        const SizedBox(height: 24),

        // ── 2. Coordinate System Comparison ───────────────────────────
        _buildSectionHeader(
          'FractionalOffset vs Alignment Coordinates',
          Icons.compare_arrows,
        ),
        _buildCard('Coordinate Systems', _buildCoordinateComparison()),

        // ── 3. Key Positions Grid ─────────────────────────────────────
        _buildSectionHeader('Key FractionalOffset Positions', Icons.grid_3x3),
        _buildCard(
          '9 Named Positions (0-to-1 space)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPositionsGrid(),
              const SizedBox(height: 12),
              const Text(
                'Each square shows a dot at the named FractionalOffset position. '
                '(0,0) is the topLeft corner and (1,1) is the bottomRight corner.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // ── 4. Lerp Timeline ──────────────────────────────────────────
        _buildSectionHeader('Lerp Interpolation Timeline', Icons.timeline),
        _buildCard(
          'Diagonal: (0,0) -> (1,1)',
          Column(
            children: [
              _buildLerpTimeline(
                const FractionalOffset(0.0, 0.0),
                const FractionalOffset(1.0, 1.0),
                lerpSteps,
              ),
              const SizedBox(height: 12),
              // Show numeric values from the actual tween
              ...lerpSteps.map((t) {
                final v = diagonalTween.lerp(t);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          't = $t',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _kPurple700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _kPurple50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'dx=${v!.dx.toStringAsFixed(3)}, dy=${v.dy.toStringAsFixed(3)}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: _kPurple800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        _buildCard(
          'Horizontal: (0, 0.5) -> (1, 0.5)',
          _buildLerpTimeline(
            const FractionalOffset(0.0, 0.5),
            const FractionalOffset(1.0, 0.5),
            [0.0, 0.5, 1.0],
          ),
          accentColor: _kPurple400,
        ),
        _buildCard(
          'Vertical: (0.5, 0) -> (0.5, 1)',
          _buildLerpTimeline(
            const FractionalOffset(0.5, 0.0),
            const FractionalOffset(0.5, 1.0),
            [0.0, 0.5, 1.0],
          ),
          accentColor: _kPurple600,
        ),

        // ── 5. Diagonal Path Animation Concept ────────────────────────
        _buildSectionHeader('Diagonal Path Visualisation', Icons.moving),
        _buildCard(
          'topLeft -> bottomRight animation path',
          Column(
            children: [
              _buildDiagonalPath(),
              const SizedBox(height: 12),
              const Text(
                'The tween linearly interpolates both dx and dy simultaneously, '
                'producing a straight diagonal path from start to end.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // ── 6. Custom Tween Paths ─────────────────────────────────────
        _buildSectionHeader('Custom Tween Paths', Icons.route),
        _buildCard(
          'Various begin/end Combinations',
          Column(
            children: [
              _buildCustomTweenPathCard(
                'Left to Right (horizontal)',
                const FractionalOffset(0.0, 0.5),
                const FractionalOffset(1.0, 0.5),
                _kPurple700,
              ),
              _buildCustomTweenPathCard(
                'Top to Bottom (vertical)',
                const FractionalOffset(0.5, 0.0),
                const FractionalOffset(0.5, 1.0),
                _kPurple500,
              ),
              _buildCustomTweenPathCard(
                'TopRight to BottomLeft (anti-diagonal)',
                const FractionalOffset(1.0, 0.0),
                const FractionalOffset(0.0, 1.0),
                _kPurple400,
              ),
              _buildCustomTweenPathCard(
                'Quarter step (subtle shift)',
                const FractionalOffset(0.25, 0.25),
                const FractionalOffset(0.75, 0.75),
                _kDeepAmber,
              ),
              _buildCustomTweenPathCard(
                'Bottom edge sweep',
                const FractionalOffset(0.0, 1.0),
                const FractionalOffset(1.0, 1.0),
                _kTealAccent,
              ),
            ],
          ),
        ),

        // ── 7. Fractional vs Alignment Side-by-Side ───────────────────
        _buildSectionHeader('FractionalOffset vs Alignment', Icons.compare),
        _buildCard('Side-by-Side Comparison', _buildSideBySideComparison()),

        // ── 8. Code Snippets ──────────────────────────────────────────
        _buildSectionHeader('Code Snippets', Icons.code),
        _buildCard(
          'Basic FractionalOffsetTween',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeBasicTween(),
              const SizedBox(height: 12),
              _buildPropertyTile(
                'begin',
                'Starting FractionalOffset (nullable)',
                Icons.first_page,
              ),
              _buildPropertyTile(
                'end',
                'Ending FractionalOffset (nullable)',
                Icons.last_page,
              ),
              _buildPropertyTile(
                'lerp(t)',
                'Returns interpolated FractionalOffset at time t (0.0 - 1.0)',
                Icons.timeline,
              ),
            ],
          ),
        ),
        _buildCard(
          'AnimatedBuilder Usage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeAnimatedBuilder(),
              const SizedBox(height: 12),
              _buildInfoCallout(
                'FractionalOffsetTween.animate() returns Animation<FractionalOffset?> '
                'to drive position changes frame by frame.',
              ),
            ],
          ),
          accentColor: _kPurple600,
        ),
        _buildCard(
          'TweenAnimationBuilder (Implicit)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeTweenAnimationBuilder(),
              const SizedBox(height: 12),
              _buildInfoCallout(
                'TweenAnimationBuilder provides implicit animation without '
                'managing an AnimationController manually.',
                color: _kPurple600,
                icon: Icons.auto_awesome,
              ),
            ],
          ),
          accentColor: _kPurple400,
        ),

        // ── Type Hierarchy ────────────────────────────────────────────
        _buildSectionHeader('Type Hierarchy', Icons.account_tree),
        _buildCard(
          'Inheritance Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypeHierarchy(),
              const SizedBox(height: 12),
              const Text(
                'FractionalOffsetTween specialises Tween to work specifically '
                'with FractionalOffset values, providing correct lerp semantics.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // ── 9. Real-World Use Cases ───────────────────────────────────
        _buildSectionHeader('Real-World Use Cases', Icons.lightbulb_outline),
        _buildUseCaseCard(
          'Sliding Panel',
          'Animate a side panel from off-screen (0.0, 0.5) '
              'to its resting position (0.8, 0.5).',
          _buildUseCaseSlidingPanel(),
        ),
        _buildUseCaseCard(
          'Tooltip Positioning',
          'Move a tooltip from below (0.5, 1.0) to above (0.5, 0.0) '
              'its anchor when the layout changes.',
          _buildUseCaseTooltip(),
        ),
        _buildUseCaseCard(
          'Drag Feedback',
          'Interpolate a ghost image along the drag path using '
              'fractional coordinates relative to the drop target.',
          _buildUseCaseDragFeedback(),
        ),

        // ── 10. Summary ───────────────────────────────────────────────
        const SizedBox(height: 8),
        _buildSectionHeader('Summary', Icons.summarize),
        _buildSummaryBadge(),
        const SizedBox(height: 32),
      ],
    ),
  );
}
