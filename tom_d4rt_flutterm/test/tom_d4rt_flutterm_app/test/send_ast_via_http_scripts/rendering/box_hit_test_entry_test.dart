// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for BoxHitTestEntry from rendering
//
// BoxHitTestEntry is a specialized hit test entry for RenderBox targets.
// It extends HitTestEntry to add:
//   - localPosition: The position relative to the hit RenderBox's local coordinates
//
// This demo shows:
//   1. How BoxHitTestEntry fits into the hit testing system
//   2. The difference between localPosition and global position
//   3. Visual demonstration of coordinate transformation
//   4. Interactive hit testing with position display
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kBrown50 = Color(0xFFEFEBE9);
const _kBrown100 = Color(0xFFD7CCC8);
const _kBrown200 = Color(0xFFBCAAA4);
const _kBrown300 = Color(0xFFA1887F);
const _kBrown400 = Color(0xFF8D6E63);
const _kBrown500 = Color(0xFF795548);
const _kBrown600 = Color(0xFF6D4C41);
const _kBrown700 = Color(0xFF5D4037);
const _kBrown800 = Color(0xFF4E342E);
const _kBrown900 = Color(0xFF3E2723);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kBrown600, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
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
      color: _kBrown50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBrown200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kBrown100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kBrown600, size: 24),
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
                  color: _kBrown800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kBrown600),
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
      color: _kBrown900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kBrown800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kBrown200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kBrown200,
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
          width: 120,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: _kBrown600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? _kBrown800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Creates a visualization showing coordinate systems
Widget _buildCoordinateSystemDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBrown300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coordinate System Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _CoordinateSystemPainter(),
            size: const Size(double.infinity, 200),
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow('Global Origin', '(0, 0) - Screen top-left'),
        _buildPropertyRow('Local Origin', '(0, 0) - Box top-left'),
        _buildPropertyRow('localPosition', 'Relative to RenderBox'),
      ],
    ),
  );
}

/// Custom painter for coordinate system visualization
class _CoordinateSystemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw global coordinate system
    paint.color = _kBrown300;
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );

    // Label global
    _drawLabel(canvas, 'Global\nCoordinates', const Offset(20, 20), _kBrown400);

    // Draw a "RenderBox" region
    paint.color = _kBrown600;
    paint.strokeWidth = 3;
    final boxRect = Rect.fromLTWH(
      size.width * 0.3,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.5,
    );
    canvas.drawRect(boxRect, paint);

    // Fill with light color
    paint.style = PaintingStyle.fill;
    paint.color = _kBrown100.withAlpha(180);
    canvas.drawRect(boxRect, paint);

    // Label local box
    _drawLabel(
      canvas,
      'RenderBox\n(local coords)',
      Offset(boxRect.left + 10, boxRect.top + 10),
      _kBrown700,
    );

    // Draw tap point
    final tapGlobal = Offset(
      boxRect.left + boxRect.width * 0.6,
      boxRect.top + boxRect.height * 0.4,
    );
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(tapGlobal, 8, paint);

    // Draw position indicators
    paint.color = Colors.red.withAlpha(150);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    // Line from global origin
    canvas.drawLine(const Offset(10, 10), tapGlobal, paint..strokeWidth = 1);

    // Line from local origin
    paint.color = Colors.blue;
    canvas.drawLine(boxRect.topLeft, tapGlobal, paint);

    // Labels
    _drawLabel(
      canvas,
      'Global\nposition',
      Offset(tapGlobal.dx + 12, tapGlobal.dy - 20),
      Colors.red[700]!,
    );
    _drawLabel(
      canvas,
      'local\nPosition',
      Offset(boxRect.left + 20, boxRect.bottom - 30),
      Colors.blue[700]!,
    );

    // Draw axes hints
    _drawArrow(canvas, const Offset(10, 10), const Offset(60, 10), _kBrown400);
    _drawArrow(canvas, const Offset(10, 10), const Offset(10, 60), _kBrown400);
    _drawLabel(canvas, 'X', const Offset(65, 5), _kBrown500);
    _drawLabel(canvas, 'Y', const Offset(5, 65), _kBrown500);
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

  void _drawArrow(Canvas canvas, Offset start, Offset end, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);

    // Arrowhead
    final direction = (end - start).direction;
    final arrowSize = 8.0;
    final p1 = end - Offset.fromDirection(direction - 0.5, arrowSize);
    final p2 = end - Offset.fromDirection(direction + 0.5, arrowSize);
    canvas.drawLine(end, p1, paint);
    canvas.drawLine(end, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Builds hit testing hierarchy diagram
Widget _buildHitTestHierarchyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBrown200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hit Test Entry Class Hierarchy',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 16),
        _buildHierarchyNode('HitTestEntry<T>', 'Base class', 0, false),
        _buildHierarchyNode(
          '├── BoxHitTestEntry',
          'For RenderBox (has localPosition)',
          1,
          true,
        ),
        _buildHierarchyNode(
          '├── SliverHitTestEntry',
          'For RenderSliver',
          1,
          false,
        ),
        _buildHierarchyNode('└── etc.', 'Other specialized entries', 1, false),
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
            color: highlight ? _kBrown400 : _kBrown100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: highlight ? Colors.white : _kBrown700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(desc, style: TextStyle(fontSize: 10, color: _kBrown500)),
      ],
    ),
  );
}

/// Interactive hit test demo widget
Widget _buildInteractiveHitTestDemo() {
  return _InteractiveHitTestArea();
}

class _InteractiveHitTestArea extends StatefulWidget {
  @override
  State<_InteractiveHitTestArea> createState() =>
      _InteractiveHitTestAreaState();
}

class _InteractiveHitTestAreaState extends State<_InteractiveHitTestArea> {
  Offset? _lastGlobalPosition;
  Offset? _lastLocalPosition;
  final GlobalKey _boxKey = GlobalKey();

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _lastGlobalPosition = details.globalPosition;
      _lastLocalPosition = details.localPosition;
    });
    print('Tap detected:');
    print('  globalPosition: ${details.globalPosition}');
    print('  localPosition: ${details.localPosition}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _boxKey,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBrown300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Hit Test Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kBrown800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap anywhere in the orange box to see coordinates',
            style: TextStyle(fontSize: 12, color: _kBrown600),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTapDown: _handleTapDown,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_kBrown300, _kBrown500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _kBrown400.withAlpha(80),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'TAP HERE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  if (_lastLocalPosition != null)
                    Positioned(
                      left: _lastLocalPosition!.dx - 10,
                      top: _lastLocalPosition!.dy - 10,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kBrown50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 16),
                    const SizedBox(width: 8),
                    const Text(
                      'Last Tap Position:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _kBrown700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildPropertyRow(
                  'globalPosition',
                  _lastGlobalPosition != null
                      ? '(${_lastGlobalPosition!.dx.toStringAsFixed(1)}, ${_lastGlobalPosition!.dy.toStringAsFixed(1)})'
                      : '---',
                  valueColor: Colors.red[700],
                ),
                _buildPropertyRow(
                  'localPosition',
                  _lastLocalPosition != null
                      ? '(${_lastLocalPosition!.dx.toStringAsFixed(1)}, ${_lastLocalPosition!.dy.toStringAsFixed(1)})'
                      : '---',
                  valueColor: Colors.blue[700],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Builds BoxHitTestEntry properties card
Widget _buildPropertiesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBrown200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BoxHitTestEntry Properties',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyItem(
          'target',
          'RenderBox',
          'The RenderBox that was hit',
          Icons.crop_square,
        ),
        _buildPropertyItem(
          'localPosition',
          'Offset',
          'Position in local coordinates of the target',
          Icons.my_location,
        ),
        _buildPropertyItem(
          'transform',
          'Matrix4?',
          'Inherited: transform to apply to positions',
          Icons.transform,
        ),
      ],
    ),
  );
}

Widget _buildPropertyItem(
  String name,
  String type,
  String desc,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kBrown100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: _kBrown600, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kBrown800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _kBrown200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _kBrown700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kBrown500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Hit test process explanation card
Widget _buildHitTestProcessCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kBrown100, _kBrown50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How Hit Testing Works',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 16),
        _buildProcessStep(1, 'User taps screen', 'Global position captured'),
        _buildProcessStep(2, 'hitTest() called', 'Starts at root RenderObject'),
        _buildProcessStep(3, 'Traverses tree', 'Each RenderBox checks hit'),
        _buildProcessStep(
          4,
          'BoxHitTestEntry created',
          'With localPosition set',
        ),
        _buildProcessStep(
          5,
          'Added to result',
          'HitTestResult collects entries',
        ),
        _buildProcessStep(
          6,
          'Events dispatched',
          'In reverse order (front to back)',
        ),
      ],
    ),
  );
}

Widget _buildProcessStep(int num, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: _kBrown500, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$num',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kBrown800,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kBrown600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Custom RenderBox demonstration
Widget _buildCustomRenderBoxDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kBrown200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom hitTest Implementation',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'RenderBox classes must implement hitTest or hitTestSelf:',
          style: TextStyle(fontSize: 12, color: _kBrown600),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBrown900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '''@override
bool hitTest(BoxHitTestResult result, {
  required Offset position,
}) {
  // Check if position is within bounds
  if (size.contains(position)) {
    // Add entry with local position
    result.add(BoxHitTestEntry(
      this,       // target RenderBox
      position,   // becomes localPosition
    ));
    return true;
  }
  return false;
}''',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0xFFCCE5FF),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Nested boxes demo showing coordinate transformation
Widget _buildNestedBoxesDemo() {
  return _NestedBoxesWidget();
}

class _NestedBoxesWidget extends StatefulWidget {
  @override
  State<_NestedBoxesWidget> createState() => _NestedBoxesWidgetState();
}

class _NestedBoxesWidgetState extends State<_NestedBoxesWidget> {
  String _lastTapped = '';
  Offset? _lastLocal;

  void _handleBoxTap(String boxName, TapDownDetails details) {
    setState(() {
      _lastTapped = boxName;
      _lastLocal = details.localPosition;
    });
    print('$boxName tapped: local=${details.localPosition}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBrown200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nested Boxes - Coordinate Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kBrown800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Each box reports its own local coordinates:',
            style: TextStyle(fontSize: 12, color: _kBrown600),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTapDown: (d) => _handleBoxTap('Outer', d),
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kBrown200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 4,
                    left: 4,
                    child: Text(
                      'OUTER',
                      style: TextStyle(color: _kBrown600, fontSize: 10),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTapDown: (d) => _handleBoxTap('Middle', d),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 200,
                        height: 100,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _kBrown400,
                          borderRadius: BorderRadius.circular(10),
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
                                ),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTapDown: (d) => _handleBoxTap('Inner', d),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 80,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: _kBrown700,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'INNER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kBrown50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.touch_app, color: _kBrown500, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _lastTapped.isNotEmpty
                            ? 'Tapped: $_lastTapped box'
                            : 'Tap a box',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _kBrown700,
                          fontSize: 12,
                        ),
                      ),
                      if (_lastLocal != null)
                        Text(
                          'localPosition: (${_lastLocal!.dx.toStringAsFixed(0)}, ${_lastLocal!.dy.toStringAsFixed(0)})',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            color: _kBrown600,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Comparison with other hit test entries
Widget _buildComparisonCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kBrown50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hit Test Entry Types',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 12),
        _buildComparisonRow(
          'BoxHitTestEntry',
          'RenderBox',
          'localPosition (Offset)',
          _kBrown500,
        ),
        _buildComparisonRow(
          'SliverHitTestEntry',
          'RenderSliver',
          'mainAxisPosition, crossAxisPosition',
          _kBrown400,
        ),
        _buildComparisonRow(
          'HitTestEntry',
          'Any RenderObject',
          'Base: target, transform',
          _kBrown300,
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String name,
  String target,
  String extra,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: _kBrown800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Target: $target',
          style: const TextStyle(fontSize: 11, color: _kBrown600),
        ),
        Text(
          'Extra: $extra',
          style: const TextStyle(fontSize: 11, color: _kBrown500),
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

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about BoxHitTestEntry
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║        BoxHitTestEntry Deep Demo                                 ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- BoxHitTestEntry Overview ---');
  print('BoxHitTestEntry is a specialized HitTestEntry for RenderBox.');
  print('It adds localPosition to track where within the RenderBox was hit.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CLASS STRUCTURE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Class Structure ---');
  print('class BoxHitTestEntry extends HitTestEntry<RenderBox>');
  print('  - target: RenderBox (the hit render object)');
  print('  - localPosition: Offset (position in local coordinates)');
  print('  - transform: Matrix4? (inherited from HitTestEntry)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: COORDINATE TRANSFORMATION
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Coordinate Transformation ---');
  print(
    'Global position → transformed through parent matrices → localPosition',
  );
  print('Each RenderBox has its own coordinate system.');
  print('localPosition is relative to the RenderBox\'s top-left corner.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: HIT TEST FLOW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Hit Test Flow ---');
  print('1. GestureBinding receives pointer event');
  print('2. RenderView.hitTest() starts traversal');
  print('3. Each child RenderBox checks if position is within bounds');
  print('4. If hit, creates BoxHitTestEntry with localPosition');
  print('5. Entry added to BoxHitTestResult');
  print('6. Events dispatched in reverse order (front-to-back)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PRACTICAL USAGE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Usage ---');
  print('GestureDetector reports both global and local positions:');
  print('  onTapDown: (TapDownDetails details) {');
  print('    details.globalPosition; // Screen coordinates');
  print('    details.localPosition;  // Widget-local coordinates');
  print('  }');

  print('\nBoxHitTestEntry test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFAF3E0), Color(0xFFF5E6D3)],
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
                colors: [_kBrown600, _kBrown800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kBrown700.withAlpha(80),
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
                        Icons.touch_app,
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
                            'BoxHitTestEntry',
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
                    'A hit test entry for RenderBox, storing the local position '
                    'where the hit occurred within the box\'s coordinate system.',
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
            'Records a RenderBox that was hit during hit testing, '
                'along with the position in local coordinates.',
            Icons.info_outline,
          ),
          _buildInfoCard(
            'Key Property: localPosition',
            'Offset relative to the hit RenderBox\'s origin (top-left). '
                'Different from globalPosition which is screen-relative.',
            Icons.my_location,
          ),

          // Class hierarchy
          _buildSectionTitle('Class Hierarchy', Icons.account_tree),
          _buildHitTestHierarchyCard(),
          const SizedBox(height: 20),

          // Properties
          _buildSectionTitle('Properties', Icons.list),
          _buildPropertiesCard(),
          const SizedBox(height: 20),

          // Coordinate system visualization
          _buildSectionTitle('Coordinate Systems', Icons.grid_on),
          _buildCoordinateSystemDemo(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Interactive Demo', Icons.touch_app),
          _buildInteractiveHitTestDemo(),
          const SizedBox(height: 20),

          // Nested boxes demo
          _buildSectionTitle('Nested Coordinate Demo', Icons.layers),
          _buildNestedBoxesDemo(),
          const SizedBox(height: 20),

          // Hit test process
          _buildSectionTitle('Hit Test Process', Icons.account_tree),
          _buildHitTestProcessCard(),
          const SizedBox(height: 20),

          // Custom implementation
          _buildSectionTitle('Custom Implementation', Icons.code),
          _buildCustomRenderBoxDemo(),
          const SizedBox(height: 20),

          // Comparison
          _buildSectionTitle('Entry Type Comparison', Icons.compare),
          _buildComparisonCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'Creating BoxHitTestEntry',
            '''// In RenderBox.hitTest:
bool hitTest(BoxHitTestResult result, {
  required Offset position,
}) {
  if (size.contains(position)) {
    result.add(BoxHitTestEntry(this, position));
    return true;
  }
  return false;
}''',
          ),
          _buildCodeSnippet('Accessing in GestureDetector', '''GestureDetector(
  onTapDown: (TapDownDetails details) {
    // These come from BoxHitTestEntry.localPosition
    final globalPos = details.globalPosition;
    final localPos = details.localPosition;
    
    print('Global: \$globalPos');
    print('Local: \$localPos');
  },
  child: MyWidget(),
)'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'BoxHitTestEntry'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kBrown100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kBrown600, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kBrown800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BoxHitTestEntry is essential for Flutter\'s hit testing system. '
                  'It stores which RenderBox was hit and where (in local coordinates), '
                  'enabling precise gesture handling and event routing.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kBrown700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('localPosition', Icons.my_location),
                    const SizedBox(width: 8),
                    _buildSummaryChip('RenderBox target', Icons.crop_square),
                    const SizedBox(width: 8),
                    _buildSummaryChip('Hit testing', Icons.touch_app),
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

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kBrown500,
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
