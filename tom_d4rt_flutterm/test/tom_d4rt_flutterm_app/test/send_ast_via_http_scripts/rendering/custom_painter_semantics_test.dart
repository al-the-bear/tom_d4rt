// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for CustomPainterSemantics from rendering
//
// CustomPainterSemantics describes semantics information for custom paint:
//   - key: optional Key for tracking
//   - rect: bounds of the semantic region
//   - properties: SemanticsProperties defining the semantics
//   - transform: optional Matrix4 transform
//   - tags: set of SemanticsTag for identification
//
// This demo shows:
//   1. CustomPainterSemantics structure and purpose
//   2. Visual representation of semantic regions
//   3. Custom painting with accessibility info
//   4. How painters communicate semantics to the framework
//   5. Semantic region visualization
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
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

const _kTeal400 = Color(0xFF26A69A);
const _kTeal500 = Color(0xFF009688);
const _kTeal600 = Color(0xFF00897B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, top: 8),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPurple100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPurple800, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kPurple50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPurple200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kPurple600, size: 24),
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
                  color: _kPurple900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kPurple700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a property row
Widget _buildPropertyRow(String name, String value, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: _kPurple500),
        const SizedBox(width: 8),
        Text(
          '$name:',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: _kPurple800,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: _kPurple600, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

/// Builds the structure explanation card
Widget _buildStructureCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
      boxShadow: [
        BoxShadow(
          color: _kPurple100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CustomPainterSemantics Structure',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        _buildPropertyRow('key', 'Key? - Optional tracking key', Icons.key),
        _buildPropertyRow('rect', 'Rect - Semantic region bounds', Icons.crop),
        _buildPropertyRow(
          'properties',
          'SemanticsProperties - Accessibility info',
          Icons.accessibility,
        ),
        _buildPropertyRow(
          'transform',
          'Matrix4? - Optional transform',
          Icons.transform,
        ),
        _buildPropertyRow(
          'tags',
          'Set<SemanticsTag>? - Optional tags',
          Icons.label,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: _kPurple600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'CustomPainterSemantics provides semantic information '
                  'for regions painted by CustomPainter.',
                  style: TextStyle(fontSize: 11, color: _kPurple700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Build semantic region visualization
Widget _buildSemanticRegionVisualization() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
      boxShadow: [
        BoxShadow(
          color: _kPurple100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semantic Regions on Canvas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Each colored region represents an area with associated semantic info',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPurple200, width: 2),
          ),
          child: Stack(
            children: [
              // Region 1 - Button semantic
              Positioned(
                left: 20,
                top: 20,
                child: _buildSemanticRegion(
                  'Button',
                  80,
                  50,
                  _kPurple300,
                  Icons.touch_app,
                  'Play',
                ),
              ),
              // Region 2 - Image semantic
              Positioned(
                right: 20,
                top: 20,
                child: _buildSemanticRegion(
                  'Image',
                  100,
                  80,
                  _kTeal400,
                  Icons.image,
                  'Chart',
                ),
              ),
              // Region 3 - Slider semantic
              Positioned(
                left: 20,
                bottom: 20,
                child: _buildSemanticRegion(
                  'Slider',
                  140,
                  40,
                  _kPurple400,
                  Icons.tune,
                  'Volume: 75%',
                ),
              ),
              // Region 4 - Label semantic
              Positioned(
                right: 20,
                bottom: 30,
                child: _buildSemanticRegion(
                  'Label',
                  80,
                  35,
                  _kTeal500,
                  Icons.label,
                  'Status',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a semantic region widget
Widget _buildSemanticRegion(
  String type,
  double width,
  double height,
  Color color,
  IconData icon,
  String label,
) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// Custom painter that demonstrates semantic regions
class _SemanticsDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw background grid
    paint.color = const Color(0x20000000);
    const gridSize = 20.0;
    for (var x = 0.0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint..strokeWidth = 0.5,
      );
    }
    for (var y = 0.0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint..strokeWidth = 0.5,
      );
    }

    // Draw interactive regions
    paint.style = PaintingStyle.fill;

    // Region 1: Play button
    paint.color = _kPurple400;
    final rect1 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(20, 20, 80, 60),
      const Radius.circular(12),
    );
    canvas.drawRRect(rect1, paint);

    // Region 2: Info card
    paint.color = _kTeal500;
    final rect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width - 120, 20, 100, 70),
      const Radius.circular(12),
    );
    canvas.drawRRect(rect2, paint);

    // Region 3: Slider track
    paint.color = _kPurple300;
    final rect3 = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, size.height - 60, size.width - 40, 40),
      const Radius.circular(20),
    );
    canvas.drawRRect(rect3, paint);

    // Slider thumb
    paint.color = _kPurple700;
    canvas.drawCircle(
      Offset(20 + (size.width - 40) * 0.7, size.height - 40),
      15,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback? get semanticsBuilder {
    return (Size size) {
      return [
        CustomPainterSemantics(
          rect: const Rect.fromLTWH(20, 20, 80, 60),
          properties: const SemanticsProperties(
            label: 'Play button',
            button: true,
          ),
        ),
        CustomPainterSemantics(
          rect: Rect.fromLTWH(size.width - 120, 20, 100, 70),
          properties: const SemanticsProperties(
            label: 'Information card',
            header: true,
          ),
        ),
        CustomPainterSemantics(
          rect: Rect.fromLTWH(20, size.height - 60, size.width - 40, 40),
          properties: SemanticsProperties(
            label: 'Volume slider',
            slider: true,
            value: '70%',
            increasedValue: '80%',
            decreasedValue: '60%',
            onIncrease: () {},
            onDecrease: () {},
          ),
        ),
      ];
    };
  }
}

/// Builds interactive custom paint demo
Widget _buildCustomPaintDemo() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
      boxShadow: [
        BoxShadow(
          color: _kPurple100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _kPurple100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.brush, color: _kPurple700, size: 18),
            ),
            const SizedBox(width: 8),
            const Text(
              'CustomPainter with Semantics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _kPurple900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'A CustomPainter can provide semantic regions via semanticsBuilder',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPurple200, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomPaint(
              size: const Size(double.infinity, 180),
              painter: _SemanticsDemoPainter(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kTeal400.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kTeal500.withValues(alpha: 0.3)),
          ),
          child: const Row(
            children: [
              Icon(Icons.accessibility_new, color: _kTeal600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Screen readers can navigate painted regions via semantics',
                  style: TextStyle(fontSize: 11, color: _kTeal600),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds the rect property visualization
Widget _buildRectVisualization() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rect Property',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Defines the bounds of the semantic region',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Coordinate labels
              const Positioned(
                left: 8,
                top: 8,
                child: Text(
                  '(0, 0)',
                  style: TextStyle(fontSize: 10, color: _kPurple400),
                ),
              ),
              // Rect visualization
              Positioned(
                left: 50,
                top: 30,
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _kPurple300.withValues(alpha: 0.3),
                    border: Border.all(color: _kPurple500, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Semantic Region',
                        style: TextStyle(
                          color: _kPurple700,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Rect(50, 30, 150, 80)',
                        style: TextStyle(color: _kPurple600, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              // Dimension arrows
              Positioned(
                left: 50,
                top: 115,
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 12, color: _kPurple500),
                    Container(width: 126, height: 1, color: _kPurple500),
                    const Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: _kPurple500,
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 110,
                top: 125,
                child: Text(
                  'width: 150',
                  style: TextStyle(fontSize: 10, color: _kPurple500),
                ),
              ),
              // Height indicator
              Positioned(
                left: 210,
                top: 30,
                child: Column(
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      size: 12,
                      color: _kPurple500,
                    ),
                    Container(width: 1, height: 56, color: _kPurple500),
                    const Icon(
                      Icons.arrow_downward,
                      size: 12,
                      color: _kPurple500,
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 220,
                top: 60,
                child: Text(
                  'h: 80',
                  style: TextStyle(fontSize: 10, color: _kPurple500),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds semantic properties grid
Widget _buildPropertiesGrid() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SemanticsProperties',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Accessibility information attached to regions',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildPropertyChip('label', Icons.label),
            _buildPropertyChip('value', Icons.text_fields),
            _buildPropertyChip('hint', Icons.help_outline),
            _buildPropertyChip('button', Icons.touch_app),
            _buildPropertyChip('slider', Icons.tune),
            _buildPropertyChip('header', Icons.title),
            _buildPropertyChip('textField', Icons.edit),
            _buildPropertyChip('image', Icons.image),
            _buildPropertyChip('link', Icons.link),
            _buildPropertyChip('container', Icons.inbox),
            _buildPropertyChip('checked', Icons.check_box),
            _buildPropertyChip('enabled', Icons.toggle_on),
          ],
        ),
      ],
    ),
  );
}

/// Builds a property chip
Widget _buildPropertyChip(String name, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kPurple100,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple300),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: _kPurple600),
        const SizedBox(width: 4),
        Text(
          name,
          style: const TextStyle(
            fontSize: 11,
            color: _kPurple800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

/// Builds multiple regions example
Widget _buildMultipleRegionsExample() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Multiple Semantic Regions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A single CustomPainter can define multiple accessible regions',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPurple50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildRegionRow(1, 'Play Button', 'button: true', _kPurple400),
              const SizedBox(height: 8),
              _buildRegionRow(2, 'Progress Bar', 'slider: true', _kPurple500),
              const SizedBox(height: 8),
              _buildRegionRow(3, 'Title Text', 'header: true', _kPurple600),
              const SizedBox(height: 8),
              _buildRegionRow(4, 'Icon Area', 'image: true', _kPurple700),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a region row
Widget _buildRegionRow(int number, String name, String property, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
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
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _kPurple900,
                  fontSize: 13,
                ),
              ),
              Text(property, style: TextStyle(fontSize: 11, color: color)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.accessibility, color: color, size: 16),
        ),
      ],
    ),
  );
}

/// Builds accessibility flow diagram
Widget _buildAccessibilityFlowDiagram() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accessibility Flow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildFlowBox('CustomPainter', _kPurple400, Icons.brush),
            _buildFlowArrow(),
            _buildFlowBox('Semantics\nBuilder', _kPurple500, Icons.build),
            _buildFlowArrow(),
            _buildFlowBox(
              'CustomPainter\nSemantics',
              _kPurple600,
              Icons.accessibility,
            ),
            _buildFlowArrow(),
            _buildFlowBox(
              'Screen\nReader',
              _kPurple700,
              Icons.record_voice_over,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kTeal400.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _kTeal600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'CustomPainterSemantics bridges custom painting with '
                  'accessibility services like VoiceOver and TalkBack.',
                  style: TextStyle(fontSize: 11, color: _kTeal600),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a flow box
Widget _buildFlowBox(String label, Color color, IconData icon) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

/// Builds a flow arrow
Widget _buildFlowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.arrow_forward, color: _kPurple400, size: 16),
  );
}

/// Builds transform visualization
Widget _buildTransformVisualization() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transform Property',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kPurple900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Matrix4 transform applied to semantic region',
          style: TextStyle(fontSize: 12, color: _kPurple600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'No Transform',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kPurple700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: _kPurple50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _kPurple300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'Region',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'With Rotation',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kPurple700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: _kPurple50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: 0.3,
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _kPurple500,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Region',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'With Scale',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kPurple700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: _kPurple50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Transform.scale(
                        scale: 1.3,
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _kPurple700,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Region',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('CustomPainterSemantics comprehensive demo executing');
  print('════════════════════════════════════════════════════════════════');

  // Log CustomPainterSemantics info
  print('CustomPainterSemantics provides semantic info for CustomPainter');
  print('Properties:');
  print('  - key: Key? (optional tracking key)');
  print('  - rect: Rect (semantic region bounds)');
  print('  - properties: SemanticsProperties (accessibility info)');
  print('  - transform: Matrix4? (optional transform)');
  print('  - tags: Set<SemanticsTag>? (optional tags)');
  print('════════════════════════════════════════════════════════════════');

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kPurple50, Colors.white, _kPurple50],
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
              gradient: const LinearGradient(
                colors: [_kPurple700, _kPurple500],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kPurple500.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.accessibility_new,
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
                        'CustomPainterSemantics',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Accessibility for Custom Painting',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Introduction
          _buildInfoCard(
            'What is CustomPainterSemantics?',
            'CustomPainterSemantics describes semantic information for regions '
                'painted by a CustomPainter. It enables screen readers and other '
                'accessibility services to understand custom-painted content.',
            Icons.info_outline,
          ),

          // Structure
          _buildSectionHeader('Structure', Icons.account_tree),
          _buildStructureCard(),

          // Rect visualization
          _buildSectionHeader('Region Bounds', Icons.crop),
          _buildRectVisualization(),

          // Properties
          _buildSectionHeader('Semantic Properties', Icons.settings),
          _buildPropertiesGrid(),

          // Semantic regions visualization
          _buildSectionHeader('Visual Regions', Icons.grid_view),
          _buildSemanticRegionVisualization(),

          // Custom paint demo
          _buildSectionHeader('CustomPainter Demo', Icons.brush),
          _buildCustomPaintDemo(),

          // Multiple regions
          _buildSectionHeader('Multiple Regions', Icons.layers),
          _buildMultipleRegionsExample(),

          // Transform
          _buildSectionHeader('Transform Property', Icons.transform),
          _buildTransformVisualization(),

          // Flow diagram
          _buildSectionHeader('Accessibility Flow', Icons.account_tree),
          _buildAccessibilityFlowDiagram(),

          // Footer
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kPurple100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: _kPurple700),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'CustomPainterSemantics demo complete! Demonstrated '
                    'structure, regions, properties, and accessibility flow.',
                    style: TextStyle(color: _kPurple800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
