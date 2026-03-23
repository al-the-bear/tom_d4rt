// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for AlignmentTween from rendering
//
// AlignmentTween animates between two Alignment values.
// It is a specialized Tween<Alignment> that provides smooth interpolation.
//
// This demo shows:
//   1. Basic AlignmentTween creation and lerp values
//   2. Visual representation of alignment positions
//   3. Comparison with AlignmentGeometryTween for RTL support
//   4. All 9 predefined Alignment constants
//   5. Custom alignment values with x,y coordinates
//   6. Animation timeline visualization
//   7. Practical use cases in layouts
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kIndigo50 = Color(0xFFE8EAF6);
const _kIndigo100 = Color(0xFFC5CAE9);
const _kIndigo200 = Color(0xFF9FA8DA);
const _kIndigo300 = Color(0xFF7986CB);
const _kIndigo400 = Color(0xFF5C6BC0);
const _kIndigo500 = Color(0xFF3F51B5);
const _kIndigo600 = Color(0xFF3949AB);
const _kIndigo700 = Color(0xFF303F9F);
const _kIndigo800 = Color(0xFF283593);
const _kIndigo900 = Color(0xFF1A237E);

const _kDeepOrange = Color(0xFFFF5722);
const _kAmber = Color(0xFFFFC107);
const _kTeal = Color(0xFF009688);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo700, _kIndigo500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kIndigo700.withAlpha(80),
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

/// Builds a card with content
Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  final color = accentColor ?? _kIndigo500;
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

/// Builds a visual alignment position indicator
Widget _buildAlignmentIndicator(
  Alignment alignment,
  String label, {
  double size = 100,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kIndigo300, width: 2),
    ),
    child: Stack(
      children: [
        // Grid lines
        Positioned.fill(child: CustomPaint(painter: _GridPainter())),
        // Alignment dot
        Align(
          alignment: alignment,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: _kDeepOrange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(color: _kDeepOrange.withAlpha(100), blurRadius: 6),
              ],
            ),
          ),
        ),
        // Label
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

/// Builds a lerp timeline visualization
Widget _buildLerpTimeline(AlignmentTween tween, List<double> values) {
  return Column(
    children: [
      // Timeline bar
      Container(
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_kIndigo200, _kIndigo500, _kDeepOrange],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: values.map((t) {
            return Positioned(
              left: t * 280 + 10,
              top: 8,
              child: Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: _kIndigo700, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${(t * 100).toInt()}',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: _kIndigo700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 16),
      // Alignment values at each point
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: values.map((t) {
          final lerped = tween.lerp(t);
          return _buildAlignmentIndicator(
            lerped,
            't=${t.toStringAsFixed(2)}',
            size: 60,
          );
        }).toList(),
      ),
    ],
  );
}

/// Grid painter for alignment visualization
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIndigo200
      ..strokeWidth = 1;

    // Vertical lines
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // Horizontal lines
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Builds a comparison row for alignment values
Widget _buildAlignmentRow(String name, Alignment alignment, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        _buildAlignmentIndicator(alignment, '', size: 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'x: ${alignment.x.toStringAsFixed(1)}, y: ${alignment.y.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 12,
                  color: color.withAlpha(180),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            alignment.toString().replaceAll('Alignment.', ''),
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
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
        color: Color(0xFF9CDCFE),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

/// Builds a property info tile
Widget _buildPropertyTile(String property, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _kIndigo500,
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
                  color: _kIndigo900,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _kIndigo700.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a use case example card
Widget _buildUseCaseCard(String title, String description, Widget example) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber.withAlpha(80)),
      boxShadow: [
        BoxShadow(
          color: _kAmber.withAlpha(30),
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
            color: _kAmber.withAlpha(30),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb, color: _kAmber, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF795548),
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

/// Builds an animated alignment demo container
Widget _buildAnimatedAlignmentDemo(Alignment alignment, String label) {
  return Container(
    width: 150,
    height: 100,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kIndigo100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo400),
    ),
    child: Stack(
      children: [
        Align(
          alignment: alignment,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kDeepOrange, _kAmber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: _kDeepOrange.withAlpha(100),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 18),
          ),
        ),
        Positioned(
          left: 8,
          bottom: 8,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: _kIndigo700,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds the RTL comparison section
Widget _buildRtlComparisonSection() {
  return Column(
    children: [
      // LTR section
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kTeal.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kTeal.withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.format_textdirection_l_to_r, color: _kTeal),
                const SizedBox(width: 8),
                const Text(
                  'LTR (Left-to-Right)',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _kTeal),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildAlignmentIndicator(
                  Alignment.centerLeft,
                  'start',
                  size: 60,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: _kTeal),
                const SizedBox(width: 8),
                _buildAlignmentIndicator(
                  Alignment.centerRight,
                  'end',
                  size: 60,
                ),
              ],
            ),
          ],
        ),
      ),
      // RTL section
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kDeepOrange.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kDeepOrange.withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.format_textdirection_r_to_l,
                  color: _kDeepOrange,
                ),
                const SizedBox(width: 8),
                const Text(
                  'RTL (Right-to-Left)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _kDeepOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildAlignmentIndicator(
                  Alignment.centerRight,
                  'start',
                  size: 60,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_back, color: _kDeepOrange),
                const SizedBox(width: 8),
                _buildAlignmentIndicator(Alignment.centerLeft, 'end', size: 60),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

/// Builds the type hierarchy diagram
Widget _buildTypeHierarchy() {
  return Column(
    children: [
      _buildHierarchyNode('Animatable<Alignment>', 0, _kIndigo300),
      _buildHierarchyConnector(),
      _buildHierarchyNode('Tween<Alignment>', 1, _kIndigo500),
      _buildHierarchyConnector(),
      _buildHierarchyNode('AlignmentTween', 2, _kIndigo700),
    ],
  );
}

Widget _buildHierarchyNode(String name, int level, Color color) {
  return Container(
    margin: EdgeInsets.only(left: level * 20.0),
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

Widget _buildHierarchyConnector() {
  return Container(
    margin: const EdgeInsets.only(left: 30),
    height: 20,
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Icon(Icons.arrow_downward, color: _kIndigo400, size: 20),
    ),
  );
}

/// Builds the main header
Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo800, _kIndigo600, _kIndigo400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kIndigo800.withAlpha(100),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.swap_horiz, color: Colors.white, size: 48),
        const SizedBox(height: 12),
        const Text(
          'AlignmentTween',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Animate between Alignment values',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge('Tween<Alignment>', Icons.animation),
            const SizedBox(width: 12),
            _buildStatBadge('lerp(t)', Icons.timeline),
            const SizedBox(width: 12),
            _buildStatBadge('Animation', Icons.play_arrow),
          ],
        ),
      ],
    ),
  );
}

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

/// Builds coordinate system explanation
Widget _buildCoordinateSystem() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      children: [
        Row(
          children: [
            // Visual coordinate display
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kIndigo300, width: 2),
              ),
              child: Stack(
                children: [
                  // Axes
                  Center(
                    child: Container(width: 100, height: 2, color: _kIndigo400),
                  ),
                  Center(
                    child: Container(width: 2, height: 100, color: _kIndigo400),
                  ),
                  // Labels
                  const Positioned(
                    right: 8,
                    top: 52,
                    child: Text(
                      'x+',
                      style: TextStyle(fontSize: 10, color: _kIndigo600),
                    ),
                  ),
                  const Positioned(
                    left: 8,
                    top: 52,
                    child: Text(
                      'x-',
                      style: TextStyle(fontSize: 10, color: _kIndigo600),
                    ),
                  ),
                  const Positioned(
                    left: 55,
                    top: 8,
                    child: Text(
                      'y-',
                      style: TextStyle(fontSize: 10, color: _kIndigo600),
                    ),
                  ),
                  const Positioned(
                    left: 55,
                    bottom: 8,
                    child: Text(
                      'y+',
                      style: TextStyle(fontSize: 10, color: _kIndigo600),
                    ),
                  ),
                  // Origin
                  Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _kDeepOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Explanation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Coordinate System',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _kIndigo800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCoordRow('x = -1.0', 'Left edge'),
                  _buildCoordRow('x = 0.0', 'Center'),
                  _buildCoordRow('x = 1.0', 'Right edge'),
                  _buildCoordRow('y = -1.0', 'Top edge'),
                  _buildCoordRow('y = 1.0', 'Bottom edge'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCoordRow(String coord, String meaning) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: _kIndigo200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            coord,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: _kIndigo800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(meaning, style: const TextStyle(fontSize: 11, color: _kIndigo700)),
      ],
    ),
  );
}

/// Builds the practical examples section
Widget _buildPracticalExamples() {
  return Column(
    children: [
      // Example 1: Badge positioning
      _buildUseCaseCard(
        'Badge Positioning',
        'Animate badge between different corners of a container',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedAlignmentDemo(Alignment.topLeft, 'Start'),
            const Icon(Icons.arrow_forward, color: _kIndigo400),
            _buildAnimatedAlignmentDemo(Alignment.topRight, 'End'),
          ],
        ),
      ),
      // Example 2: Notification dot
      _buildUseCaseCard(
        'Notification Indicators',
        'Move indicator dot to draw attention',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedAlignmentDemo(Alignment.center, 'Resting'),
            const Icon(Icons.arrow_forward, color: _kIndigo400),
            _buildAnimatedAlignmentDemo(Alignment.topCenter, 'Active'),
          ],
        ),
      ),
      // Example 3: Content alignment
      _buildUseCaseCard(
        'Content Layout',
        'Smoothly transition content alignment for responsive layouts',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedAlignmentDemo(Alignment.centerLeft, 'Mobile'),
            const Icon(Icons.arrow_forward, color: _kIndigo400),
            _buildAnimatedAlignmentDemo(Alignment.center, 'Tablet'),
          ],
        ),
      ),
    ],
  );
}

/// Builds the 9 predefined alignments grid
Widget _build9AlignmentsGrid() {
  final alignments = [
    ('topLeft', Alignment.topLeft),
    ('topCenter', Alignment.topCenter),
    ('topRight', Alignment.topRight),
    ('centerLeft', Alignment.centerLeft),
    ('center', Alignment.center),
    ('centerRight', Alignment.centerRight),
    ('bottomLeft', Alignment.bottomLeft),
    ('bottomCenter', Alignment.bottomCenter),
    ('bottomRight', Alignment.bottomRight),
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: alignments.map((a) {
      return _buildAlignmentIndicator(a.$2, a.$1, size: 80);
    }).toList(),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════');
  print('AlignmentTween Deep Demo');
  print('═══════════════════════════════════════════════════════════════');

  // Create test tweens
  final basicTween = AlignmentTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final horizontalTween = AlignmentTween(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final verticalTween = AlignmentTween(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  print('Basic tween: ${basicTween.begin} → ${basicTween.end}');
  print('Horizontal tween: ${horizontalTween.begin} → ${horizontalTween.end}');
  print('Vertical tween: ${verticalTween.begin} → ${verticalTween.end}');

  // Test lerp values
  print('\nLerp interpolation:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final lerped = basicTween.lerp(t);
    print(
      '  t=$t: ${lerped.x.toStringAsFixed(2)}, ${lerped.y.toStringAsFixed(2)}',
    );
  }

  print('\nAlignmentTween demo completed');
  print('═══════════════════════════════════════════════════════════════');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main header
        _buildMainHeader(),
        const SizedBox(height: 24),

        // Section 1: What is AlignmentTween
        _buildSectionHeader('What is AlignmentTween?', Icons.help_outline),
        _buildCard(
          'Overview',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AlignmentTween is a specialized Tween that smoothly interpolates '
                'between two Alignment values using linear interpolation (lerp).',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildTypeHierarchy(),
            ],
          ),
        ),

        // Section 2: Coordinate System
        _buildSectionHeader('Alignment Coordinate System', Icons.grid_on),
        _buildCard(
          'Understanding Coordinates',
          Column(
            children: [
              _buildCoordinateSystem(),
              const SizedBox(height: 12),
              const Text(
                'Alignment uses a coordinate system where (0,0) is the center, '
                '(-1,-1) is top-left, and (1,1) is bottom-right.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // Section 3: The 9 Predefined Alignments
        _buildSectionHeader('9 Predefined Alignments', Icons.apps),
        _buildCard('Alignment Constants', _build9AlignmentsGrid()),

        // Section 4: Creating AlignmentTween
        _buildSectionHeader('Creating AlignmentTween', Icons.add_circle),
        _buildCard(
          'Basic Construction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeSnippet(
                'final tween = AlignmentTween(\n'
                '  begin: Alignment.topLeft,\n'
                '  end: Alignment.bottomRight,\n'
                ');',
              ),
              const SizedBox(height: 16),
              _buildPropertyTile(
                'begin',
                'Starting alignment value (can be null)',
                Icons.first_page,
              ),
              _buildPropertyTile(
                'end',
                'Ending alignment value (can be null)',
                Icons.last_page,
              ),
              _buildPropertyTile(
                'lerp(t)',
                'Returns interpolated Alignment at time t (0.0 to 1.0)',
                Icons.timeline,
              ),
            ],
          ),
        ),

        // Section 5: Lerp Visualization
        _buildSectionHeader('Lerp Animation Timeline', Icons.timeline),
        _buildCard(
          'Diagonal Movement: topLeft → bottomRight',
          Column(
            children: [
              _buildLerpTimeline(basicTween, [0.0, 0.25, 0.5, 0.75, 1.0]),
              const SizedBox(height: 12),
              _buildAlignmentRow(
                'begin (t=0.0)',
                Alignment.topLeft,
                _kIndigo500,
              ),
              _buildAlignmentRow('mid (t=0.5)', Alignment.center, _kAmber),
              _buildAlignmentRow(
                'end (t=1.0)',
                Alignment.bottomRight,
                _kDeepOrange,
              ),
            ],
          ),
        ),

        // Section 6: Different Tween Directions
        _buildSectionHeader('Movement Directions', Icons.swap_calls),
        _buildCard(
          'Horizontal Movement',
          Column(
            children: [
              _buildLerpTimeline(horizontalTween, [0.0, 0.5, 1.0]),
              const SizedBox(height: 8),
              const Text(
                'centerLeft → centerRight (y stays at 0)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        _buildCard(
          'Vertical Movement',
          Column(
            children: [
              _buildLerpTimeline(verticalTween, [0.0, 0.5, 1.0]),
              const SizedBox(height: 8),
              const Text(
                'topCenter → bottomCenter (x stays at 0)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // Section 7: RTL Support
        _buildSectionHeader(
          'RTL Text Direction Support',
          Icons.format_textdirection_r_to_l,
        ),
        _buildCard(
          'AlignmentDirectional vs Alignment',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Use AlignmentGeometryTween with AlignmentDirectional for '
                'layouts that need to respect text direction (LTR/RTL).',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildRtlComparisonSection(),
              const SizedBox(height: 12),
              _buildCodeSnippet(
                '// RTL-aware tween\n'
                'final rtlTween = AlignmentGeometryTween(\n'
                '  begin: AlignmentDirectional.topStart,\n'
                '  end: AlignmentDirectional.bottomEnd,\n'
                ');',
              ),
            ],
          ),
        ),

        // Section 8: Practical Use Cases
        _buildSectionHeader('Practical Use Cases', Icons.lightbulb),
        _buildPracticalExamples(),

        // Section 9: Animation Integration
        _buildSectionHeader('Animation Integration', Icons.animation),
        _buildCard(
          'Using with AnimationController',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeSnippet(
                '// In a StatefulWidget with TickerProviderStateMixin\n'
                'late AnimationController _controller;\n'
                'late Animation<Alignment> _alignAnimation;\n\n'
                '@override\n'
                'void initState() {\n'
                '  super.initState();\n'
                '  _controller = AnimationController(\n'
                '    duration: Duration(milliseconds: 500),\n'
                '    vsync: this,\n'
                '  );\n'
                '  _alignAnimation = AlignmentTween(\n'
                '    begin: Alignment.topLeft,\n'
                '    end: Alignment.bottomRight,\n'
                '  ).animate(CurvedAnimation(\n'
                '    parent: _controller,\n'
                '    curve: Curves.easeInOut,\n'
                '  ));\n'
                '}',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kTeal.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kTeal.withAlpha(80)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: _kTeal, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: const Text(
                        'AlignmentTween.animate() returns an Animation<Alignment?> '
                        'that you can use with AnimatedBuilder.',
                        style: TextStyle(fontSize: 12, color: _kTeal),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 10: Comparison with AnimatedAlign
        _buildSectionHeader('vs AnimatedAlign Widget', Icons.compare),
        _buildCard(
          'When to Use Each',
          Column(
            children: [
              _buildComparisonRow(
                'AlignmentTween',
                'Fine-grained control, custom curves',
                _kIndigo500,
                Icons.tune,
              ),
              const SizedBox(height: 8),
              _buildComparisonRow(
                'AnimatedAlign',
                'Simple implicit animation',
                _kTeal,
                Icons.auto_awesome,
              ),
              const SizedBox(height: 12),
              _buildCodeSnippet(
                '// Implicit animation (simpler)\n'
                'AnimatedAlign(\n'
                '  alignment: _isExpanded \n'
                '    ? Alignment.center \n'
                '    : Alignment.topLeft,\n'
                '  duration: Duration(milliseconds: 300),\n'
                '  child: MyWidget(),\n'
                ')',
              ),
            ],
          ),
        ),

        // Footer
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kIndigo100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: _kIndigo700, size: 32),
              const SizedBox(height: 8),
              const Text(
                'AlignmentTween Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _kIndigo800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Smooth alignment animations for Flutter',
                style: TextStyle(fontSize: 12, color: _kIndigo600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

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
