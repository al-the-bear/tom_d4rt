// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for AnnotationEntry from rendering
//
// AnnotationEntry<T> wraps an annotation with hit test position information.
// It pairs:
//   - annotation: The annotation data of type T
//   - localPosition: Where the hit test occurred relative to the annotation
//
// This demo shows:
//   1. How to create AnnotationEntry instances
//   2. Generic type system for annotations
//   3. Relationship with AnnotatedRegionLayer
//   4. Hit testing coordinate systems
//   5. Practical use cases
//
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kLime50 = Color(0xFFF9FBE7);
const _kLime100 = Color(0xFFF0F4C3);
const _kLime200 = Color(0xFFE6EE9C);
const _kLime300 = Color(0xFFDCE775);
const _kLime400 = Color(0xFFD4E157);
const _kLime500 = Color(0xFFCDDC39);
const _kLime600 = Color(0xFFC0CA33);
const _kLime700 = Color(0xFFAFB42B);
const _kLime800 = Color(0xFF9E9D24);
const _kLime900 = Color(0xFF827717);

// ═══════════════════════════════════════════════════════════════════════════
// SAMPLE ANNOTATION TYPES
// ═══════════════════════════════════════════════════════════════════════════

/// Simple string annotation type
class RegionName {
  final String name;
  final Color color;

  RegionName(this.name, this.color);

  @override
  String toString() => 'RegionName($name)';
}

/// Action annotation for buttons
class ActionAnnotation {
  final String actionId;
  final String label;
  final IconData icon;

  ActionAnnotation(this.actionId, this.label, this.icon);

  @override
  String toString() => 'Action($actionId: $label)';
}

/// Semantic region for accessibility
class SemanticRegion {
  final String role;
  final String description;

  SemanticRegion(this.role, this.description);

  @override
  String toString() => 'Semantic($role: $description)';
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kLime700, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kLime900,
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
      color: _kLime50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kLime300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kLime200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kLime700, size: 24),
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
                  color: _kLime900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kLime700),
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
      color: _kLime900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kLime800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kLime300, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kLime200,
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
              color: Color(0xFFE8F5E9),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// AnnotationEntry structure visualization
Widget _buildEntryStructureCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kLime400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnnotationEntry<T> Structure',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kLime900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStructureProperty(
                'annotation',
                'T',
                'The annotation value',
                Icons.label,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStructureProperty(
                'localPosition',
                'Offset',
                'Hit test position',
                Icons.my_location,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kLime100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: _kLime700, size: 16),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Generic type T allows any annotation data type.',
                  style: TextStyle(fontSize: 11, color: _kLime800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStructureProperty(
  String name,
  String type,
  String desc,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kLime50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kLime200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: _kLime600, size: 18),
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kLime900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kLime500,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(fontSize: 10, color: _kLime700)),
      ],
    ),
  );
}

/// Generic type examples
Widget _buildGenericTypeExamples() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kLime300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Generic Type Examples',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kLime900,
          ),
        ),
        const SizedBox(height: 16),
        _buildTypeExample(
          'String',
          'AnnotationEntry<String>',
          'Simple text identifier',
          Icons.text_fields,
        ),
        _buildTypeExample(
          'int',
          'AnnotationEntry<int>',
          'Numeric ID or index',
          Icons.numbers,
        ),
        _buildTypeExample(
          'RegionName',
          'AnnotationEntry<RegionName>',
          'Custom region with name + color',
          Icons.crop_square,
        ),
        _buildTypeExample(
          'ActionAnnotation',
          'AnnotationEntry<ActionAnnotation>',
          'Button or interactive element',
          Icons.touch_app,
        ),
        _buildTypeExample(
          'SemanticRegion',
          'AnnotationEntry<SemanticRegion>',
          'Accessibility semantic data',
          Icons.accessibility,
        ),
      ],
    ),
  );
}

Widget _buildTypeExample(
  String type,
  String signature,
  String desc,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _kLime200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kLime700, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                signature,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kLime900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 10, color: _kLime600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Interactive hit test demo
Widget _buildInteractiveDemo() {
  return _InteractiveAnnotationDemo();
}

class _InteractiveAnnotationDemo extends StatefulWidget {
  @override
  State<_InteractiveAnnotationDemo> createState() =>
      _InteractiveAnnotationDemoState();
}

class _InteractiveAnnotationDemoState
    extends State<_InteractiveAnnotationDemo> {
  String _lastAnnotation = 'Tap a region';
  Offset _lastPosition = Offset.zero;
  bool _hasHit = false;

  void _handleTap(TapUpDetails details, String annotation) {
    setState(() {
      _lastAnnotation = annotation;
      _lastPosition = details.localPosition;
      _hasHit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLime400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Annotation Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kLime900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap regions to see annotation and localPosition:',
            style: TextStyle(fontSize: 12, color: _kLime700),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Row(
              children: [
                _buildTappableRegion('Alpha', _kLime300),
                const SizedBox(width: 8),
                _buildTappableRegion('Beta', _kLime500),
                const SizedBox(width: 8),
                _buildTappableRegion('Gamma', _kLime700),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildResultDisplay(),
        ],
      ),
    );
  }

  Widget _buildTappableRegion(String name, Color color) {
    return Expanded(
      child: GestureDetector(
        onTapUp: (details) => _handleTap(details, name),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.touch_app, color: Colors.white, size: 32),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _hasHit ? _kLime100 : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _hasHit ? _kLime500 : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'annotation:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _kLime900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _hasHit ? _kLime500 : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _lastAnnotation,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'localPosition:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _kLime900,
                ),
              ),
              Text(
                _hasHit
                    ? 'Offset(${_lastPosition.dx.toStringAsFixed(1)}, ${_lastPosition.dy.toStringAsFixed(1)})'
                    : 'N/A',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kLime700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Coordinate system visualization
Widget _buildCoordinateSystemDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kLime300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Local Position Coordinate System',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kLime900,
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
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kLime50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'localPosition is relative to the annotation layer origin (top-left).',
            style: TextStyle(fontSize: 11, color: _kLime800),
          ),
        ),
      ],
    ),
  );
}

class _CoordinateSystemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw annotation region
    final regionRect = Rect.fromLTWH(40, 30, 200, 130);
    paint.color = _kLime300;
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionRect, const Radius.circular(8)),
      paint,
    );

    paint.style = PaintingStyle.fill;
    paint.color = _kLime100;
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionRect, const Radius.circular(8)),
      paint,
    );

    // Origin point
    paint.color = _kLime700;
    canvas.drawCircle(regionRect.topLeft, 6, paint);

    // Draw axes
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    // X axis
    final xEnd = Offset(regionRect.left + 60, regionRect.top);
    canvas.drawLine(regionRect.topLeft, xEnd, paint);
    _drawArrow(canvas, xEnd, paint, 0);

    // Y axis
    final yEnd = Offset(regionRect.left, regionRect.top + 50);
    canvas.drawLine(regionRect.topLeft, yEnd, paint);
    _drawArrow(canvas, yEnd, paint, math.pi / 2);

    // Hit point
    final hitPoint = Offset(regionRect.left + 120, regionRect.top + 70);
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(hitPoint, 8, paint);

    // Draw dashed lines to axes
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    final dashPaint = Paint()
      ..color = Colors.red.withAlpha(150)
      ..strokeWidth = 1;
    canvas.drawLine(hitPoint, Offset(hitPoint.dx, regionRect.top), dashPaint);
    canvas.drawLine(hitPoint, Offset(regionRect.left, hitPoint.dy), dashPaint);

    // Labels
    _drawLabel(
      canvas,
      'Origin (0,0)',
      Offset(regionRect.left - 10, regionRect.top - 15),
      _kLime900,
    );
    _drawLabel(canvas, 'X+', Offset(xEnd.dx + 5, xEnd.dy - 5), _kLime700);
    _drawLabel(canvas, 'Y+', Offset(yEnd.dx - 20, yEnd.dy + 5), _kLime700);
    _drawLabel(
      canvas,
      'localPosition\n(120, 70)',
      Offset(hitPoint.dx + 10, hitPoint.dy - 10),
      Colors.red,
    );

    // Annotation label
    _drawLabel(
      canvas,
      'Annotation Region',
      Offset(regionRect.center.dx - 45, regionRect.bottom + 10),
      _kLime800,
    );
  }

  void _drawArrow(Canvas canvas, Offset tip, Paint paint, double angle) {
    final arrowSize = 8.0;
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      tip.dx - arrowSize * math.cos(angle - 0.4),
      tip.dy - arrowSize * math.sin(angle - 0.4),
    );
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      tip.dx - arrowSize * math.cos(angle + 0.4),
      tip.dy - arrowSize * math.sin(angle + 0.4),
    );
    canvas.drawPath(path, paint);
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

/// AnnotatedRegionLayer connection
Widget _buildLayerRelationshipCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kLime200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Relationship with AnnotatedRegionLayer',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kLime900,
          ),
        ),
        const SizedBox(height: 16),
        _buildRelationshipSteps(),
      ],
    ),
  );
}

Widget _buildRelationshipSteps() {
  return Column(
    children: [
      _buildStep(
        1,
        'Create Region',
        'AnnotatedRegionLayer defines a region with annotation',
      ),
      _buildStep(2, 'Hit Test', 'System performs hit test on layer tree'),
      _buildStep(
        3,
        'Entry Created',
        'AnnotationEntry created with local position',
      ),
      _buildStep(4, 'Result Returned', 'Entry added to AnnotationResult'),
    ],
  );
}

Widget _buildStep(int number, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: _kLime500, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
                  color: _kLime900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kLime700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Live entry creation demo
Widget _buildLiveEntryDemo() {
  return _LiveEntryCreationDemo();
}

class _LiveEntryCreationDemo extends StatefulWidget {
  @override
  State<_LiveEntryCreationDemo> createState() => _LiveEntryCreationDemoState();
}

class _LiveEntryCreationDemoState extends State<_LiveEntryCreationDemo> {
  final List<AnnotationEntry<String>> _entries = [];

  void _addEntry(String annotation, Offset position) {
    setState(() {
      _entries.add(
        AnnotationEntry<String>(
          annotation: annotation,
          localPosition: position,
        ),
      );
      if (_entries.length > 5) {
        _entries.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLime400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Entry Creation',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kLime900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap buttons to create new AnnotationEntry instances:',
            style: TextStyle(fontSize: 12, color: _kLime700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildEntryButton('Create A', () {
                _addEntry('region-A', const Offset(10, 20));
              }),
              const SizedBox(width: 8),
              _buildEntryButton('Create B', () {
                _addEntry('region-B', const Offset(50, 75));
              }),
              const SizedBox(width: 8),
              _buildEntryButton('Create C', () {
                _addEntry('region-C', const Offset(120, 45));
              }),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 180,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kLime50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _entries.isEmpty
                ? const Center(
                    child: Text(
                      'No entries yet',
                      style: TextStyle(color: _kLime600),
                    ),
                  )
                : ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (context, index) {
                      final entry = _entries[_entries.length - 1 - index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _kLime300),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: _kLime500,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '#${_entries.length - index}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'annotation: "${entry.annotation}"',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 10,
                                        color: _kLime900,
                                      ),
                                    ),
                                    Text(
                                      'localPosition: (${entry.localPosition.dx}, ${entry.localPosition.dy})',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 10,
                                        color: _kLime700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kLime600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

/// Use cases visualization
Widget _buildUseCasesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kLime100, _kLime50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Use Cases',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kLime900,
          ),
        ),
        const SizedBox(height: 16),
        _buildUseCase(
          Icons.mouse,
          'Mouse Tracking',
          'Track hover/click positions in annotated regions',
        ),
        _buildUseCase(
          Icons.accessibility,
          'Accessibility',
          'Semantic region detection for screen readers',
        ),
        _buildUseCase(
          Icons.layers,
          'Layer Hit Testing',
          'Find which layer elements were tapped',
        ),
        _buildUseCase(
          Icons.gamepad,
          'Interactive Areas',
          'Detect taps on game elements or buttons',
        ),
      ],
    ),
  );
}

Widget _buildUseCase(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kLime500,
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kLime900,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kLime700),
              ),
            ],
          ),
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
      color: _kLime600,
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
  // Print information about AnnotationEntry
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║           AnnotationEntry<T> Deep Demo                           ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- AnnotationEntry Overview ---');
  print('Wraps annotation data with hit test position.');
  print('Generic type T allows any annotation type.');

  // Create and demonstrate entries
  print('\n--- Creating Entries ---');

  // String annotation
  final stringEntry = AnnotationEntry<String>(
    annotation: 'button-submit',
    localPosition: const Offset(50.0, 25.0),
  );
  print(
    'String entry: ${stringEntry.annotation} at ${stringEntry.localPosition}',
  );

  // Int annotation
  final intEntry = AnnotationEntry<int>(
    annotation: 42,
    localPosition: const Offset(100.0, 75.0),
  );
  print('Int entry: ${intEntry.annotation} at ${intEntry.localPosition}');

  // Custom type
  final regionEntry = AnnotationEntry<RegionName>(
    annotation: RegionName('Header Area', _kLime500),
    localPosition: const Offset(200.0, 30.0),
  );
  print(
    'Custom entry: ${regionEntry.annotation} at ${regionEntry.localPosition}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- AnnotationEntry Properties ---');
  print('annotation: The annotation value of type T');
  print('localPosition: Offset where hit test occurred');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: USAGE CONTEXT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Usage Context ---');
  print('- Returned by AnnotationResult.entries');
  print('- Created during AnnotatedRegionLayer hit testing');
  print('- Carries position relative to annotation layer');
  print('- Enables precise interaction detection');

  print('\nAnnotationEntry test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF5F8E8), Color(0xFFF0F4E0)],
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
                colors: [_kLime700, _kLime900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kLime800.withAlpha(80),
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
                        Icons.label,
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
                            'AnnotationEntry<T>',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                    'Wraps annotation data with hit test position, enabling precise '
                    'interaction detection in annotated regions.',
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
            'Generic Type T',
            'Allows any annotation data type: String, int, custom classes, etc.',
            Icons.data_object,
          ),
          _buildInfoCard(
            'Local Position',
            'Records where hit test occurred relative to annotation layer origin.',
            Icons.my_location,
          ),

          // Structure
          _buildSectionTitle('Entry Structure', Icons.schema),
          _buildEntryStructureCard(),
          const SizedBox(height: 20),

          // Generic types
          _buildSectionTitle('Generic Type Examples', Icons.code),
          _buildGenericTypeExamples(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Interactive Demo', Icons.touch_app),
          _buildInteractiveDemo(),
          const SizedBox(height: 20),

          // Coordinate system
          _buildSectionTitle('Coordinate System', Icons.grid_on),
          _buildCoordinateSystemDemo(),
          const SizedBox(height: 20),

          // Layer relationship
          _buildSectionTitle('Layer Relationship', Icons.layers),
          _buildLayerRelationshipCard(),
          const SizedBox(height: 20),

          // Live creation
          _buildSectionTitle('Live Entry Creation', Icons.add_circle),
          _buildLiveEntryDemo(),
          const SizedBox(height: 20),

          // Use cases
          _buildSectionTitle('Use Cases', Icons.apps),
          _buildUseCasesCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet('Creating AnnotationEntry', '''// String annotation
final entry = AnnotationEntry<String>(
  annotation: 'button-submit',
  localPosition: const Offset(50.0, 25.0),
);

// Access properties
print(entry.annotation);      // 'button-submit'
print(entry.localPosition);   // Offset(50.0, 25.0)'''),
          _buildCodeSnippet(
            'Custom Annotation Type',
            '''class ButtonAnnotation {
  final String id;
  final String label;
  ButtonAnnotation(this.id, this.label);
}

final entry = AnnotationEntry<ButtonAnnotation>(
  annotation: ButtonAnnotation('btn-1', 'Submit'),
  localPosition: const Offset(100.0, 50.0),
);

print(entry.annotation.label);  // 'Submit' ''',
          ),
          _buildCodeSnippet('Processing Entries', '''// From AnnotationResult
for (final entry in result.entries) {
  print('Found: \${entry.annotation}');
  print('At: \${entry.localPosition}');
  
  // Handle based on position
  if (entry.localPosition.dx > 50) {
    // Right side tap
  }
}'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'AnnotationEntry<T>'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kLime200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kLime800, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kLime900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'AnnotationEntry<T> pairs annotation data with hit test position, '
                  'enabling precise detection of which annotated regions were tapped '
                  'and exactly where within each region.',
                  style: TextStyle(fontSize: 12, color: _kLime800, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('generic', Icons.code),
                    const SizedBox(width: 8),
                    _buildSummaryChip('position', Icons.my_location),
                    const SizedBox(width: 8),
                    _buildSummaryChip('hit test', Icons.touch_app),
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
