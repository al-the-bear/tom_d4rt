// D4rt test script: Comprehensive demo for DebugOverflowIndicatorMixin
//
// DebugOverflowIndicatorMixin is used by RenderBox subclasses to paint
// overflow indicators (the yellow/black striped warnings):
//   - Paints on all sides where overflow occurs
//   - Uses distinctive warning pattern
//   - Helps debug layout issues during development
//
// This demo shows:
//   1. What overflow looks like and how it occurs
//   2. Visual representation of overflow indicators
//   3. Common overflow scenarios (Row, Column, Text)
//   4. How to fix overflow issues
//   5. Debug mode vs release mode behavior
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kRed50 = Color(0xFFFFEBEE);
const _kRed100 = Color(0xFFFFCDD2);
const _kRed200 = Color(0xFFEF9A9A);
const _kRed300 = Color(0xFFE57373);
const _kRed400 = Color(0xFFEF5350);
const _kRed500 = Color(0xFFF44336);
const _kRed600 = Color(0xFFE53935);
const _kRed700 = Color(0xFFD32F2F);
const _kRed800 = Color(0xFFC62828);
const _kRed900 = Color(0xFFB71C1C);

const _kYellow500 = Color(0xFFFFEB3B);
const _kYellow700 = Color(0xFFFBC02D);

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
            color: _kRed100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kRed800, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _kRed900,
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
      color: _kRed50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kRed200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kRed600, size: 24),
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
                  color: _kRed900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kRed700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a simulated overflow indicator stripe pattern
Widget _buildOverflowStripes(double width, double height, bool horizontal) {
  return ClipRect(
    child: CustomPaint(
      size: Size(width, height),
      painter: _OverflowStripePainter(horizontal: horizontal),
    ),
  );
}

/// Custom painter for overflow stripes
class _OverflowStripePainter extends CustomPainter {
  final bool horizontal;

  _OverflowStripePainter({required this.horizontal});

  @override
  void paint(Canvas canvas, Size size) {
    final yellowPaint = Paint()..color = _kYellow500;
    final blackPaint = Paint()..color = Colors.black;

    const stripeWidth = 8.0;
    final count =
        ((horizontal ? size.width : size.height) / stripeWidth).ceil() + 10;

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    if (horizontal) {
      for (var i = -10; i < count; i++) {
        final x = i * stripeWidth * 2;
        canvas.drawRect(
          Rect.fromLTWH(x, 0, stripeWidth, size.height),
          i.isEven ? yellowPaint : blackPaint,
        );
      }
    } else {
      for (var i = -10; i < count; i++) {
        final y = i * stripeWidth * 2;
        canvas.drawRect(
          Rect.fromLTWH(0, y, size.width, stripeWidth),
          i.isEven ? yellowPaint : blackPaint,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Builds the mixin explanation card
Widget _buildMixinExplanationCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
      boxShadow: [
        BoxShadow(
          color: _kRed100.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.extension, color: _kRed700, size: 20),
            SizedBox(width: 8),
            Text(
              'DebugOverflowIndicatorMixin',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _kRed900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildPropertyItem('Purpose', 'Paints visual overflow warnings'),
        _buildPropertyItem('Used by', 'RenderFlex, RenderParagraph, etc.'),
        _buildPropertyItem('Pattern', 'Yellow/black diagonal stripes'),
        _buildPropertyItem('Mode', 'Debug builds only'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kYellow500.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kYellow700),
          ),
          child: const Row(
            children: [
              Icon(Icons.warning, color: Color(0xFFF57F17), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Overflow indicators only appear in debug mode!',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF57F17),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a property item
Widget _buildPropertyItem(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: _kRed800,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: _kRed600, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

/// Builds overflow direction visualization
Widget _buildOverflowDirectionsVisualization() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overflow Directions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kRed900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Indicators appear on any side where content exceeds bounds',
          style: TextStyle(fontSize: 12, color: _kRed600),
        ),
        const SizedBox(height: 16),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: _kRed50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Center box (the container)
              Center(
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _kRed400, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Container\nBounds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _kRed700,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Top overflow
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.arrow_upward, color: _kRed500, size: 20),
                      Container(
                        width: 80,
                        height: 12,
                        child: _buildOverflowStripes(80, 12, true),
                      ),
                      const Text(
                        'Top',
                        style: TextStyle(fontSize: 10, color: _kRed600),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom overflow
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Bottom',
                        style: TextStyle(fontSize: 10, color: _kRed600),
                      ),
                      Container(
                        width: 80,
                        height: 12,
                        child: _buildOverflowStripes(80, 12, true),
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        color: _kRed500,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Left overflow
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: _kRed500, size: 20),
                      Container(
                        width: 12,
                        height: 50,
                        child: _buildOverflowStripes(12, 50, false),
                      ),
                      const RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Left',
                          style: TextStyle(fontSize: 10, color: _kRed600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right overflow
              Positioned(
                right: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    children: [
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          'Right',
                          style: TextStyle(fontSize: 10, color: _kRed600),
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 50,
                        child: _buildOverflowStripes(12, 50, false),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: _kRed500,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a common overflow scenario card
Widget _buildOverflowScenarioCard(
  String title,
  String description,
  Widget visualization,
  String solution,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _kRed100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.warning_amber, color: _kRed600, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kRed900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: _kRed600),
        ),
        const SizedBox(height: 12),
        visualization,
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF81C784)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF388E3C),
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Fix: $solution',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds row overflow scenario visualization
Widget _buildRowOverflowVisualization() {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: _kRed50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    color: _kRed300,
                  ),
                  Container(
                    width: 60,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    color: _kRed400,
                  ),
                  Container(
                    width: 60,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    color: _kRed500,
                  ),
                  Container(
                    width: 60,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    color: _kRed600,
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  child: _buildOverflowStripes(20, 80, false),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds column overflow scenario visualization
Widget _buildColumnOverflowVisualization() {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: _kRed50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 25,
              margin: const EdgeInsets.all(2),
              color: _kRed300,
            ),
            Container(
              width: double.infinity,
              height: 25,
              margin: const EdgeInsets.all(2),
              color: _kRed400,
            ),
            Container(
              width: double.infinity,
              height: 25,
              margin: const EdgeInsets.all(2),
              color: _kRed500,
            ),
            Container(
              width: double.infinity,
              height: 25,
              margin: const EdgeInsets.all(2),
              color: _kRed600,
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 15,
            child: _buildOverflowStripes(double.infinity, 15, true),
          ),
        ),
      ],
    ),
  );
}

/// Builds text overflow scenario visualization
Widget _buildTextOverflowVisualization() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: _kRed50,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(8),
    child: Stack(
      children: [
        const Text(
          'This is a very long text that overflows its container because it has too many characters to fit in a single line without wrapping',
          style: TextStyle(fontSize: 14),
          maxLines: 1,
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 30,
            child: _buildOverflowStripes(30, 50, false),
          ),
        ),
      ],
    ),
  );
}

/// Builds the stripe pattern explanation
Widget _buildStripePatternExplanation() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The Warning Pattern',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kRed900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Yellow and black diagonal stripes are used because:',
          style: TextStyle(fontSize: 12, color: _kRed600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 100,
              height: 60,
              child: _buildOverflowStripes(100, 60, true),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReasonItem('High visibility', Icons.visibility),
                  _buildReasonItem('Universal warning symbol', Icons.warning),
                  _buildReasonItem('Easy to spot in debug', Icons.search),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Builds a reason item
Widget _buildReasonItem(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(icon, size: 14, color: _kYellow700),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, color: _kRed700)),
      ],
    ),
  );
}

/// Builds debug vs release comparison
Widget _buildDebugVsReleaseComparison() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Debug vs Release Mode',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kRed900,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kRed100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.bug_report, color: _kRed700, size: 24),
                    const SizedBox(height: 8),
                    const Text(
                      'DEBUG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _kRed800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 40,
                      child: Stack(
                        children: [
                          Container(
                            color: _kRed200,
                            child: const Center(child: Text('Content')),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 15,
                              child: _buildOverflowStripes(15, 40, false),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stripes visible',
                      style: TextStyle(fontSize: 11, color: _kRed600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      color: Color(0xFF388E3C),
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'RELEASE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8E6C9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(child: Text('Content')),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No stripes',
                      style: TextStyle(fontSize: 11, color: Color(0xFF388E3C)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kRed50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: _kRed600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Overflow indicators are stripped in release builds for performance.',
                  style: TextStyle(fontSize: 11, color: _kRed700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds common fixes grid
Widget _buildCommonFixesGrid() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Fixes for Overflow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kRed900,
          ),
        ),
        const SizedBox(height: 16),
        _buildFixItem(
          'Expanded/Flexible',
          'Wrap children in Expanded or Flexible',
          Icons.open_in_full,
        ),
        _buildFixItem(
          'SingleChildScrollView',
          'Make content scrollable',
          Icons.swap_vert,
        ),
        _buildFixItem(
          'Wrap',
          'Use Wrap instead of Row/Column',
          Icons.wrap_text,
        ),
        _buildFixItem(
          'Text overflow',
          'Use overflow: TextOverflow.ellipsis',
          Icons.more_horiz,
        ),
        _buildFixItem(
          'Constraints',
          'Apply proper size constraints',
          Icons.crop,
        ),
        _buildFixItem(
          'FittedBox',
          'Scale content to fit available space',
          Icons.fit_screen,
        ),
      ],
    ),
  );
}

/// Builds a fix item
Widget _buildFixItem(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFA5D6A7)),
    ),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF388E3C), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                  fontSize: 13,
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 11, color: Color(0xFF388E3C)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds which widgets use this mixin
Widget _buildWidgetsUsingMixin() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kRed200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Widgets Using This Mixin',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _kRed900,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildWidgetChip('RenderFlex', Icons.view_week),
            _buildWidgetChip('RenderParagraph', Icons.text_fields),
            _buildWidgetChip('RenderTable', Icons.table_chart),
            _buildWidgetChip('RenderStack', Icons.layers),
            _buildWidgetChip('RenderWrap', Icons.wrap_text),
            _buildWidgetChip('RenderListBody', Icons.list),
          ],
        ),
      ],
    ),
  );
}

/// Builds a widget chip
Widget _buildWidgetChip(String name, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _kRed100,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kRed300),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: _kRed700),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            color: _kRed800,
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
  print('DebugOverflowIndicatorMixin comprehensive demo executing');
  print('════════════════════════════════════════════════════════════════');

  // Log mixin info
  print('DebugOverflowIndicatorMixin:');
  print('  - Paints overflow indicators in debug mode');
  print('  - Uses yellow/black striped pattern');
  print('  - Applied by RenderFlex, RenderParagraph, etc.');
  print('  - Indicators appear where content exceeds bounds');
  print('════════════════════════════════════════════════════════════════');

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kRed50, Colors.white, _kRed50],
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
              gradient: const LinearGradient(colors: [_kRed700, _kRed500]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kRed500.withValues(alpha: 0.4),
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
                    Icons.warning_rounded,
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
                        'DebugOverflowIndicatorMixin',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Visual Overflow Debug Helpers',
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
            'What is DebugOverflowIndicatorMixin?',
            'A mixin that paints colorful warning indicators when a widget\'s '
                'content overflows its bounds. These yellow/black striped patterns '
                'help developers identify layout issues during debugging.',
            Icons.info_outline,
          ),

          // Mixin explanation
          _buildSectionHeader('Mixin Overview', Icons.extension),
          _buildMixinExplanationCard(),

          // Stripe pattern
          _buildSectionHeader('Warning Pattern', Icons.pattern),
          _buildStripePatternExplanation(),

          // Overflow directions
          _buildSectionHeader('Overflow Directions', Icons.open_in_full),
          _buildOverflowDirectionsVisualization(),

          // Common scenarios
          _buildSectionHeader('Common Overflow Scenarios', Icons.warning),

          _buildOverflowScenarioCard(
            'Row Overflow',
            'Too many or too wide children in a Row',
            _buildRowOverflowVisualization(),
            'Wrap with Expanded/Flexible, use ListView, or Wrap widget',
          ),

          _buildOverflowScenarioCard(
            'Column Overflow',
            'Too many or too tall children in a Column',
            _buildColumnOverflowVisualization(),
            'Use SingleChildScrollView, ListView, or Expanded',
          ),

          _buildOverflowScenarioCard(
            'Text Overflow',
            'Text too long for its container',
            _buildTextOverflowVisualization(),
            'Use overflow: TextOverflow.ellipsis or Expanded',
          ),

          // Debug vs Release
          _buildSectionHeader('Build Modes', Icons.build),
          _buildDebugVsReleaseComparison(),

          // Common fixes
          _buildSectionHeader('Fixing Overflow', Icons.build_circle),
          _buildCommonFixesGrid(),

          // Widgets using mixin
          _buildSectionHeader('Implementation', Icons.code),
          _buildWidgetsUsingMixin(),

          // Footer
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kRed100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: _kRed700),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'DebugOverflowIndicatorMixin demo complete! '
                    'Demonstrated overflow indicators, patterns, and fixes.',
                    style: TextStyle(color: _kRed800),
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
