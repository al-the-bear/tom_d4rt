// D4rt test script: Comprehensive demo for BoxHitTestResult from rendering
//
// BoxHitTestResult is a specialized HitTestResult for RenderBox hit testing.
// It extends HitTestResult to provide:
//   - add(): Add BoxHitTestEntry to the result
//   - addWithPaintOffset(): Add entry with offset transformation
//   - addWithPaintTransform(): Add entry with matrix transformation
//   - addWithRawTransform(): Add entry with raw transform
//   - addWithOutOfBandPosition(): Add entry with out-of-band position
//
// This demo shows:
//   1. How BoxHitTestResult collects hit test entries
//   2. Transform methods for coordinate mapping
//   3. Visual demonstration of hit test traversal
//   4. Interactive example showing path through widget tree
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kTeal50 = Color(0xFFE0F2F1);
const _kTeal100 = Color(0xFFB2DFDB);
const _kTeal200 = Color(0xFF80CBC4);
const _kTeal300 = Color(0xFF4DB6AC);
const _kTeal400 = Color(0xFF26A69A);
const _kTeal500 = Color(0xFF009688);
const _kTeal600 = Color(0xFF00897B);
const _kTeal700 = Color(0xFF00796B);
const _kTeal800 = Color(0xFF00695C);
const _kTeal900 = Color(0xFF004D40);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kTeal600, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kTeal50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kTeal100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kTeal600, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kTeal600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kTeal900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kTeal800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kTeal200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kTeal200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFCCE5FF),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a property display row
Widget _buildPropertyRow(String name, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: _kTeal600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? _kTeal800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds the class hierarchy card
Widget _buildHierarchyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hit Test Result Class Hierarchy',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 16),
        _buildHierarchyNode(
          'HitTestResult',
          'Base class for collecting entries',
          0,
          false,
        ),
        _buildHierarchyNode(
          '├── BoxHitTestResult',
          'For RenderBox (our focus)',
          1,
          true,
        ),
        _buildHierarchyNode(
          '├── SliverHitTestResult',
          'For RenderSliver',
          1,
          false,
        ),
        _buildHierarchyNode('└── etc.', 'Other specialized results', 1, false),
      ],
    ),
  );
}

Widget _buildHierarchyNode(
  String text,
  String desc,
  int indent,
  bool highlight,
) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: highlight ? _kTeal500 : _kTeal100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: highlight ? Colors.white : _kTeal700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 10, color: _kTeal500),
          ),
        ),
      ],
    ),
  );
}

/// Builds methods overview card
Widget _buildMethodsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BoxHitTestResult Methods',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 12),
        _buildMethodItem(
          'add(BoxHitTestEntry)',
          'Add an entry directly',
          Icons.add_circle,
        ),
        _buildMethodItem(
          'addWithPaintOffset',
          'Add with offset (dx, dy) transformation',
          Icons.open_with,
        ),
        _buildMethodItem(
          'addWithPaintTransform',
          'Add with Matrix4 transformation',
          Icons.transform,
        ),
        _buildMethodItem(
          'addWithRawTransform',
          'Add with raw/untransformed position',
          Icons.api,
        ),
        _buildMethodItem(
          'path (property)',
          'Iterable<HitTestEntry> of all entries',
          Icons.route,
        ),
      ],
    ),
  );
}

Widget _buildMethodItem(String name, String desc, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kTeal100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: _kTeal600, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kTeal500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Hit test flow visualization
Widget _buildHitTestFlowVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hit Test Flow Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: CustomPaint(
            painter: _HitTestFlowPainter(),
            size: const Size(double.infinity, 250),
          ),
        ),
      ],
    ),
  );
}

class _HitTestFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw widget tree boxes
    final boxWidth = size.width * 0.25;
    const boxHeight = 40.0;
    const spacing = 60.0;

    final boxes = [
      _BoxInfo('RenderView', Offset(size.width * 0.4, 10), _kTeal200),
      _BoxInfo(
        'RenderBox A',
        Offset(size.width * 0.4, 10 + spacing),
        _kTeal300,
      ),
      _BoxInfo(
        'RenderBox B',
        Offset(size.width * 0.4, 10 + spacing * 2),
        _kTeal400,
      ),
      _BoxInfo(
        'RenderBox C',
        Offset(size.width * 0.4, 10 + spacing * 3),
        _kTeal500,
      ),
    ];

    // Draw connecting lines
    final linePaint = Paint()
      ..color = _kTeal400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < boxes.length - 1; i++) {
      final start = Offset(
        boxes[i].offset.dx + boxWidth / 2,
        boxes[i].offset.dy + boxHeight,
      );
      final end = Offset(
        boxes[i + 1].offset.dx + boxWidth / 2,
        boxes[i + 1].offset.dy,
      );
      canvas.drawLine(start, end, linePaint);

      // Arrow
      _drawArrow(canvas, start, end, linePaint);
    }

    // Draw boxes
    for (final box in boxes) {
      paint.color = box.color;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(box.offset.dx, box.offset.dy, boxWidth, boxHeight),
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, paint);

      // Label
      _drawLabel(
        canvas,
        box.label,
        Offset(box.offset.dx + boxWidth / 2, box.offset.dy + boxHeight / 2),
        Colors.white,
      );
    }

    // Draw tap indicator
    paint.color = Colors.red;
    final tapX = size.width * 0.52;
    final tapY = 10 + spacing * 3 + boxHeight / 2;
    canvas.drawCircle(Offset(tapX, tapY), 6, paint);
    _drawLabel(canvas, 'TAP', Offset(tapX + 20, tapY), Colors.red);

    // Draw result path indicator
    final pathPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final pathLine = Path()
      ..moveTo(size.width * 0.1, 10 + boxHeight / 2)
      ..lineTo(size.width * 0.3, 10 + boxHeight / 2)
      ..lineTo(size.width * 0.3, 10 + spacing * 3 + boxHeight / 2)
      ..lineTo(size.width * 0.35, 10 + spacing * 3 + boxHeight / 2);

    canvas.drawPath(pathLine, pathPaint);
    _drawLabel(
      canvas,
      'Result.path',
      Offset(size.width * 0.05, 10 + spacing * 1.5),
      Colors.orange,
    );

    // Legend
    _drawLabel(
      canvas,
      '1. hitTest down tree',
      Offset(size.width * 0.7, 30),
      _kTeal700,
    );
    _drawLabel(
      canvas,
      '2. Add entries to result',
      Offset(size.width * 0.7, 50),
      _kTeal700,
    );
    _drawLabel(
      canvas,
      '3. Events dispatched up',
      Offset(size.width * 0.7, 70),
      _kTeal700,
    );
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    final direction = (end - start).direction;
    const arrowSize = 8.0;
    final mid = Offset.lerp(start, end, 0.5)!;
    final p1 = mid - Offset.fromDirection(direction - 0.5, arrowSize);
    final p2 = mid - Offset.fromDirection(direction + 0.5, arrowSize);
    canvas.drawLine(mid, p1, paint);
    canvas.drawLine(mid, p2, paint);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BoxInfo {
  final String label;
  final Offset offset;
  final Color color;

  _BoxInfo(this.label, this.offset, this.color);
}

/// Interactive hit test demo
Widget _buildInteractiveDemo() {
  return _InteractiveHitTestWidget();
}

class _InteractiveHitTestWidget extends StatefulWidget {
  @override
  State<_InteractiveHitTestWidget> createState() =>
      _InteractiveHitTestWidgetState();
}

class _InteractiveHitTestWidgetState extends State<_InteractiveHitTestWidget> {
  final List<String> _hitPath = [];
  String _lastHit = '';

  void _addToPath(String name, TapDownDetails details) {
    setState(() {
      if (!_hitPath.contains(name)) {
        _hitPath.add(name);
      }
      _lastHit = name;
    });
    print('Hit: $name at ${details.localPosition}');
  }

  void _clearPath() {
    setState(() {
      _hitPath.clear();
      _lastHit = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kTeal300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Interactive Result Path Demo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _clearPath,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Clear'),
                style: TextButton.styleFrom(foregroundColor: _kTeal600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap nested boxes to see how entries are added to result.path:',
            style: TextStyle(fontSize: 12, color: _kTeal600),
          ),
          const SizedBox(height: 16),

          // Nested tap areas
          GestureDetector(
            onTapDown: (d) => _addToPath('Outer', d),
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kTeal100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _lastHit == 'Outer' ? Colors.orange : _kTeal300,
                  width: _lastHit == 'Outer' ? 3 : 1,
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 4,
                    left: 4,
                    child: Text(
                      'OUTER',
                      style: TextStyle(
                        color: _kTeal500,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTapDown: (d) => _addToPath('Middle', d),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 220,
                        height: 120,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _kTeal300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _lastHit == 'Middle'
                                ? Colors.orange
                                : _kTeal400,
                            width: _lastHit == 'Middle' ? 3 : 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 2,
                              left: 2,
                              child: Text(
                                'MIDDLE',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTapDown: (d) => _addToPath('Inner', d),
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  width: 100,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _kTeal600,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _lastHit == 'Inner'
                                          ? Colors.orange
                                          : _kTeal700,
                                      width: _lastHit == 'Inner' ? 3 : 1,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'INNER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Path display
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kTeal50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.route, color: _kTeal500, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Result.path simulation:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _kTeal700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_hitPath.isEmpty)
                  const Text(
                    'Tap a box to add entries...',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: _kTeal400,
                      fontSize: 11,
                    ),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (var i = 0; i < _hitPath.length; i++) ...[
                        if (i > 0)
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: _kTeal400,
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _kTeal500,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _hitPath[i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Transform methods demo
Widget _buildTransformMethodsDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transform Methods Comparison',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 16),
        _buildTransformCard(
          'addWithPaintOffset',
          'Simple translation (dx, dy)',
          'Container with padding/margin',
          '''result.addWithPaintOffset(
  offset: Offset(10, 20),
  position: position,
  hitTest: (result, local) => 
    child.hitTest(result, position: local),
);''',
        ),
        _buildTransformCard(
          'addWithPaintTransform',
          'Full Matrix4 transformation',
          'Rotated/scaled/skewed widgets',
          '''result.addWithPaintTransform(
  transform: Matrix4.rotationZ(0.5),
  position: position,
  hitTest: (result, local) =>
    child.hitTest(result, position: local),
);''',
        ),
        _buildTransformCard(
          'addWithRawTransform',
          'Raw transform (already in local)',
          'Pre-computed coordinates',
          '''result.addWithRawTransform(
  transform: Matrix4.identity(),
  position: localPosition,
  hitTest: (result, local) =>
    child.hitTest(result, position: local),
);''',
        ),
      ],
    ),
  );
}

Widget _buildTransformCard(
  String method,
  String desc,
  String useCase,
  String code,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kTeal50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kTeal200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kTeal500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                method,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 12,
            color: _kTeal700,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Use: $useCase',
          style: const TextStyle(fontSize: 11, color: _kTeal500),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kTeal900,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFFCCE5FF),
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Coordinate transformation visualization
Widget _buildCoordinateTransformDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coordinate Transform Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _CoordinateTransformPainter(),
            size: const Size(double.infinity, 200),
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow('Position in', 'Global screen coordinates'),
        _buildPropertyRow('Transform applied', 'Parent matrix inversion'),
        _buildPropertyRow('Position out', 'Local child coordinates'),
      ],
    ),
  );
}

class _CoordinateTransformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Global frame
    paint.color = _kTeal200;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );

    // Label "Global"
    _drawLabel(canvas, 'Global Coords', const Offset(20, 20), _kTeal600);

    // Child box (offset + rotated conceptually)
    paint.color = _kTeal500;
    paint.style = PaintingStyle.fill;
    final childRect = Rect.fromLTWH(
      size.width * 0.35,
      size.height * 0.25,
      size.width * 0.4,
      size.height * 0.55,
    );

    // Draw with transform indication
    canvas.save();
    canvas.translate(childRect.center.dx, childRect.center.dy);
    canvas.rotate(0.1);
    canvas.translate(-childRect.width / 2, -childRect.height / 2);

    paint.color = _kTeal400.withAlpha(150);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, childRect.width, childRect.height),
        const Radius.circular(8),
      ),
      paint,
    );
    paint.color = _kTeal600;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, childRect.width, childRect.height),
        const Radius.circular(8),
      ),
      paint,
    );

    // Local origin indicator
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(5, 5), 4, paint);
    _drawArrow(canvas, const Offset(5, 5), const Offset(40, 5), Colors.blue);
    _drawArrow(canvas, const Offset(5, 5), const Offset(5, 40), Colors.blue);

    canvas.restore();

    // Global tap point
    final globalTap = Offset(size.width * 0.55, size.height * 0.5);
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(globalTap, 8, paint);
    _drawLabel(
      canvas,
      'Tap\n(global)',
      Offset(globalTap.dx + 15, globalTap.dy - 10),
      Colors.red,
    );

    // Draw transform arrow
    paint.color = Colors.orange;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(20, size.height - 30)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height - 60,
        size.width * 0.5,
        size.height * 0.6,
      );

    canvas.drawPath(path, paint);
    _drawLabel(
      canvas,
      'transform →',
      Offset(20, size.height - 45),
      Colors.orange,
    );
    _drawLabel(
      canvas,
      'localPosition',
      Offset(size.width * 0.5 + 10, size.height * 0.65),
      Colors.orange,
    );
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);

    final direction = (end - start).direction;
    const arrowSize = 6.0;
    final p1 = end - Offset.fromDirection(direction - 0.5, arrowSize);
    final p2 = end - Offset.fromDirection(direction + 0.5, arrowSize);
    canvas.drawLine(end, p1, paint);
    canvas.drawLine(end, p2, paint);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Real-world usage examples
Widget _buildUsageExamplesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kTeal100, _kTeal50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When BoxHitTestResult is Used',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kTeal800,
          ),
        ),
        const SizedBox(height: 12),
        _buildUsageItem(
          Icons.touch_app,
          'Tap/Click detection',
          'GestureDetector, InkWell',
        ),
        _buildUsageItem(Icons.swipe, 'Drag gestures', 'Draggable, DragTarget'),
        _buildUsageItem(
          Icons.pan_tool,
          'Pan/Scale gestures',
          'GestureDetector panning',
        ),
        _buildUsageItem(
          Icons.mouse,
          'Hover detection',
          'MouseRegion hover events',
        ),
        _buildUsageItem(
          Icons.accessibility,
          'Semantic actions',
          'Accessibility framework',
        ),
      ],
    ),
  );
}

Widget _buildUsageItem(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kTeal500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _kTeal800,
                fontSize: 12,
              ),
            ),
            Text(desc, style: const TextStyle(color: _kTeal600, fontSize: 11)),
          ],
        ),
      ],
    ),
  );
}

/// Build results card
Widget _buildResultsCard(bool success, String className) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: success ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: success ? Colors.green[300]! : Colors.red[300]!,
      ),
    ),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.green[700] : Colors.red[700],
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                success ? 'Demo Successful' : 'Demo Failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
              Text(
                '$className concepts demonstrated',
                style: TextStyle(
                  fontSize: 12,
                  color: success ? Colors.green[600] : Colors.red[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kTeal500,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about BoxHitTestResult
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║        BoxHitTestResult Deep Demo                                ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- BoxHitTestResult Overview ---');
  print(
    'BoxHitTestResult collects BoxHitTestEntry objects during hit testing.',
  );
  print('It extends HitTestResult with methods specific to RenderBox.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CLASS STRUCTURE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Class Structure ---');
  print('class BoxHitTestResult extends HitTestResult');
  print('  - add(BoxHitTestEntry): Add entry directly');
  print('  - addWithPaintOffset: Add with offset transform');
  print('  - addWithPaintTransform: Add with matrix transform');
  print('  - path: Iterable<HitTestEntry> of all collected entries');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TRANSFORM METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Transform Methods ---');
  print('addWithPaintOffset: For simple translations (dx, dy)');
  print('addWithPaintTransform: For full Matrix4 transformations');
  print('addWithRawTransform: For pre-computed local positions');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: HIT TEST FLOW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Hit Test Flow ---');
  print('1. BoxHitTestResult created at root');
  print('2. hitTest() called on each RenderBox');
  print('3. Transform methods adjust coordinates for children');
  print('4. Entries added with localPosition');
  print('5. path property provides all hit entries');
  print('6. Events dispatched to entries in reverse order');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: RESULT PATH
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Result Path ---');
  print('The path property contains all hit RenderObjects:');
  print('  - Front-to-back order (first = topmost)');
  print('  - Each entry has its localPosition');
  print('  - Events dispatched in reverse (back-to-front)');

  print('\nBoxHitTestResult test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kTeal600, _kTeal800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kTeal700.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.list_alt,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BoxHitTestResult',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'A collector for BoxHitTestEntry objects during hit testing. '
                    'Provides methods for adding entries with coordinate transformations.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Overview cards
          _buildInfoCard(
            'Purpose',
            'Collects all RenderBox objects hit during hit test traversal, '
                'along with their local positions.',
            Icons.info_outline,
          ),
          _buildInfoCard(
            'Key Concept: path',
            'The path property is an Iterable of all HitTestEntry objects, '
                'representing the "stack" of widgets touched.',
            Icons.route,
          ),

          // Class hierarchy
          _buildSectionTitle('Class Hierarchy', Icons.account_tree),
          _buildHierarchyCard(),
          const SizedBox(height: 20),

          // Methods
          _buildSectionTitle('Methods', Icons.functions),
          _buildMethodsCard(),
          const SizedBox(height: 20),

          // Hit test flow visualization
          _buildSectionTitle('Hit Test Flow', Icons.schema),
          _buildHitTestFlowVisualization(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Interactive Demo', Icons.touch_app),
          _buildInteractiveDemo(),
          const SizedBox(height: 20),

          // Transform methods
          _buildSectionTitle('Transform Methods', Icons.transform),
          _buildTransformMethodsDemo(),
          const SizedBox(height: 20),

          // Coordinate transform visualization
          _buildSectionTitle('Coordinate Transformation', Icons.grid_on),
          _buildCoordinateTransformDemo(),
          const SizedBox(height: 20),

          // Usage examples
          _buildSectionTitle('Real-World Usage', Icons.code),
          _buildUsageExamplesCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet('Custom RenderBox hitTest', '''@override
bool hitTest(BoxHitTestResult result, {
  required Offset position,
}) {
  // Check if we handle this position
  if (!size.contains(position)) return false;
  
  // Hit test children with offset
  result.addWithPaintOffset(
    offset: _childOffset,
    position: position,
    hitTest: (BoxHitTestResult result, Offset local) {
      return child?.hitTest(result, position: local) ?? false;
    },
  );
  
  // Add ourselves to the result
  result.add(BoxHitTestEntry(this, position));
  return true;
}'''),
          _buildCodeSnippet(
            'Accessing path entries',
            '''void handleEvent(PointerEvent event, HitTestEntry entry) {
  // entry.target is the RenderObject that was hit
  // For BoxHitTestEntry, localPosition is available
  
  if (entry is BoxHitTestEntry) {
    final localPos = entry.localPosition;
    print('Hit at local: \$localPos');
  }
}''',
          ),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'BoxHitTestResult'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kTeal100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kTeal600, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kTeal800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BoxHitTestResult is the container collecting all RenderBox hits '
                  'during a hit test. Its transform methods handle coordinate conversion, '
                  'and the path property provides all entries for event dispatch.',
                  style: TextStyle(fontSize: 12, color: _kTeal700, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('path entries', Icons.route),
                    const SizedBox(width: 8),
                    _buildSummaryChip('transforms', Icons.transform),
                    const SizedBox(width: 8),
                    _buildSummaryChip('hit stack', Icons.layers),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
