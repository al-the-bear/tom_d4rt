// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER HIT TEST RESULT — Deep Demo
// ============================================================================
//
// SliverHitTestResult is a specialised subclass of HitTestResult that adds
// the key method  addWithAxisOffset  which converts pointer coordinates from
// the viewport's box coordinate space into sliver-local coordinates:
//
//   • mainAxisPosition  – distance along the scroll axis from the sliver's
//                          zero scroll offset to the pointer hit.
//   • crossAxisPosition – distance along the perpendicular axis.
//
// When a Viewport dispatches a hit test to one of its sliver children, it
// wraps the existing HitTestResult into a SliverHitTestResult  and calls
// addWithAxisOffset.  This method pushes a coordinate-transform entry that
// later allows the framework to convert global positions back into local
// coordinates when delivering events to the sliver (or the boxes inside
// it).
//
// The four AxisDirection values (up / down / left / right) determine which
// physical dimension maps to mainAxis vs crossAxis and which direction is
// positive.
//
// This demo walks through the coordinate conversion visually, illustrates
// the hit-result propagation chain (Viewport → Sliver → Box), and shows
// how addWithAxisOffset differs from BoxHitTestResult.addWithPaintOffset.
//
// Color theme : Crimson Red (#C62828) / Rose (#FFCDD2)
// Helper prefix: _hr
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _hrCrimson = Color(0xFFC62828);
const Color _hrRose = Color(0xFFFFCDD2);
const Color _hrDarkRed = Color(0xFF8E0000);
const Color _hrLightRose = Color(0xFFFFF0F0);
const Color _hrCharcoal = Color(0xFF263238);
const Color _hrTeal = Color(0xFF00695C);
const Color _hrAmber = Color(0xFFFFA000);
const Color _hrIndigo = Color(0xFF283593);
const Color _hrOrange = Color(0xFFE65100);
const Color _hrPurple = Color(0xFF6A1B9A);
const Color _hrGreen = Color(0xFF2E7D32);
const Color _hrBrown = Color(0xFF4E342E);
const Color _hrSlate = Color(0xFF546E7A);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

/// Section header with gradient background.
Widget _hrSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [_hrCrimson, _hrDarkRed]),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(subtitle,
                style:
                    const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
          ),
      ],
    ),
  );
}

/// Explanatory text block with rose tint.
Widget _hrExplain(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    color: _hrLightRose,
    child: Text(text,
        style: const TextStyle(
            fontSize: 13, height: 1.55, color: _hrCharcoal)),
  );
}

/// Coloured label pill.
Widget _hrPill(String label, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(label,
        style: TextStyle(
            color: textColor, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

/// Titled card with optional border colour.
Widget _hrCard(String title, Widget child,
    {Color borderColor = _hrCrimson}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor, width: 1.4),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: borderColor.withValues(alpha: 0.08),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Text(title,
              style: TextStyle(
                  color: borderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
          child: child,
        ),
      ],
    ),
  );
}

/// Monospaced code snippet inside a dark container.
Widget _hrCode(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFD4D4D4),
            height: 1.5)),
  );
}

/// Small key-value row.
Widget _hrKv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(key,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _hrCharcoal)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12, color: valueColor ?? _hrSlate)),
        ),
      ],
    ),
  );
}

/// Divider.
Widget _hrDivider() {
  return Container(
    height: 1,
    color: _hrRose,
    margin: const EdgeInsets.symmetric(vertical: 6),
  );
}



// ============================================================================
// Build — main entry point
// ============================================================================

dynamic build(BuildContext context) {
  print('=== SliverHitTestResult Deep Demo START ===');

  final Widget demo = Container(
    color: _hrLightRose,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------------------
          // 1. Title banner
          // ----------------------------------------------------------------
          _buildTitleBanner(),

          // ----------------------------------------------------------------
          // 2. What is SliverHitTestResult
          // ----------------------------------------------------------------
          _hrSectionHeader('1  What Is SliverHitTestResult?',
              subtitle: 'The sliver-aware hit-test accumulator'),
          _buildWhatIs(),

          // ----------------------------------------------------------------
          // 3. Inheritance diagram
          // ----------------------------------------------------------------
          _hrSectionHeader('2  Inheritance Chain',
              subtitle: 'HitTestResult → BoxHitTestResult → SliverHitTestResult'),
          _buildInheritDiagram(),

          // ----------------------------------------------------------------
          // 4. addWithAxisOffset deep dive
          // ----------------------------------------------------------------
          _hrSectionHeader('3  addWithAxisOffset Deep Dive',
              subtitle: 'The method that converts viewport coords to sliver coords'),
          _buildAddWithAxisOffset(),

          // ----------------------------------------------------------------
          // 5. paintOffset → mainAxisPosition
          // ----------------------------------------------------------------
          _hrSectionHeader('4  paintOffset → mainAxisPosition',
              subtitle: 'How the physical offset maps to logical sliver position'),
          _buildPaintOffsetConversion(),

          // ----------------------------------------------------------------
          // 6. AxisDirection mapping
          // ----------------------------------------------------------------
          _hrSectionHeader('5  AxisDirection Mapping',
              subtitle: 'Four directions, four sign conventions'),
          _buildAxisDirectionMapping(),

          // ----------------------------------------------------------------
          // 7. Cross-axis offset
          // ----------------------------------------------------------------
          _hrSectionHeader('6  Cross-Axis Offset',
              subtitle: 'The secondary coordinate perpendicular to scroll'),
          _buildCrossAxisOffset(),

          // ----------------------------------------------------------------
          // 8. Transform matrix stack
          // ----------------------------------------------------------------
          _hrSectionHeader('7  Transform Matrix Stack',
              subtitle: 'How hit-test transforms accumulate through the tree'),
          _buildTransformStack(),

          // ----------------------------------------------------------------
          // 9. GrowthDirection impact
          // ----------------------------------------------------------------
          _hrSectionHeader('8  GrowthDirection Impact',
              subtitle: 'Forward vs reverse layout and hit math'),
          _buildGrowthDirection(),

          // ----------------------------------------------------------------
          // 10. Viewport → Sliver → Box chain
          // ----------------------------------------------------------------
          _hrSectionHeader('9  Viewport → Sliver → Box Chain',
              subtitle: 'Three-level hit propagation flow'),
          _buildHitChain(),

          // ----------------------------------------------------------------
          // 11. addWithAxisOffset vs addWithPaintOffset
          // ----------------------------------------------------------------
          _hrSectionHeader('10  addWithAxisOffset vs addWithPaintOffset',
              subtitle: 'Knowing which to use'),
          _buildComparison(),

          // ----------------------------------------------------------------
          // 12. Interactive hit probe grid
          // ----------------------------------------------------------------
          _hrSectionHeader('11  Hit Probe Grid',
              subtitle: 'Simulated coordinate conversion for a 4×6 grid of cells'),
          _buildHitGrid(),

          // ----------------------------------------------------------------
          // 13. Usage in RenderSliver
          // ----------------------------------------------------------------
          _hrSectionHeader('12  Usage in RenderSliver Subclasses',
              subtitle: 'Real-world patterns'),
          _buildUsagePatterns(),

          // ----------------------------------------------------------------
          // 14. Summary
          // ----------------------------------------------------------------
          _buildSummary(),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );

  print('=== SliverHitTestResult Deep Demo END ===');
  return demo;
}

// ============================================================================
// Section Builders
// ============================================================================

// -------------- 1. Title Banner ------------------------------------------

Widget _buildTitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_hrCrimson, Color(0xFFB71C1C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.center_focus_strong,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text('SliverHitTestResult',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'rendering library  •  extends BoxHitTestResult',
            style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 13),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'The hit-test result object that converts viewport box coordinates '
          'into sliver-local mainAxisPosition / crossAxisPosition via '
          'addWithAxisOffset.  Used by every Viewport when testing its '
          'sliver children for pointer hits.',
          style: TextStyle(
              color: Color(0xCCFFFFFF), fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

// -------------- 2. What Is -----------------------------------------------

Widget _buildWhatIs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'When a pointer event (tap, scroll, hover) reaches a Viewport, the '
        'viewport must determine which of its sliver children — and which box '
        'child inside those slivers — the event belongs to.  It does this by '
        'performing a hit test.\n\n'
        'HitTestResult is the base class: a simple list of HitTestEntry '
        'objects.  BoxHitTestResult adds addWithPaintOffset for box→box '
        'coordinate transforms.  SliverHitTestResult adds addWithAxisOffset '
        'for box→sliver transforms.\n\n'
        'A SliverHitTestResult wraps the same mutable path list. Each '
        'addWithAxisOffset call pushes a new entry that records how to '
        'convert between the two coordinate systems.',
      ),
      _hrCard('Key Properties & Methods', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrKv('path', 'List<HitTestEntry> — accumulated entries',
              valueColor: _hrCrimson),
          _hrDivider(),
          _hrKv('addWithAxisOffset()',
              'Push a sliver hit entry with axis transform'),
          _hrKv('  paintOffset', 'Offset — where the sliver paints in viewport'),
          _hrKv('  mainAxisOffset', 'double — scroll-axis pixel delta'),
          _hrKv('  crossAxisOffset', 'double — cross-axis pixel delta'),
          _hrKv('  mainAxisPosition', 'double — pointer pos along scroll axis'),
          _hrKv('  crossAxisPosition', 'double — pointer pos along cross axis'),
          _hrKv('  hitTest', 'callback — delegate to the sliver hitTest'),
          _hrDivider(),
          _hrKv('addWithPaintOffset()',
              'Inherited from BoxHitTestResult — box→box transform'),
          _hrKv('add()', 'Inherited from HitTestResult — raw entry push'),
        ],
      )),
      _hrCode(
        '// Signature of addWithAxisOffset:\n'
        'bool addWithAxisOffset({\n'
        '  required Offset? paintOffset,\n'
        '  required double mainAxisOffset,\n'
        '  required double crossAxisOffset,\n'
        '  required double mainAxisPosition,\n'
        '  required double crossAxisPosition,\n'
        '  required SliverHitTest hitTest,\n'
        '})\n\n'
        '// Where SliverHitTest is:\n'
        'typedef SliverHitTest = bool Function(\n'
        '  SliverHitTestResult result,\n'
        '  double mainAxisPosition,\n'
        '  double crossAxisPosition,\n'
        ');',
      ),
    ],
  );
}

// -------------- 3. Inheritance Diagram -----------------------------------

Widget _buildInheritDiagram() {
  return Column(
    children: [
      _hrExplain(
        'The three-level class hierarchy mirrors the three rendering layers: '
        'abstract hit testing (HitTestResult), box-model hit testing '
        '(BoxHitTestResult), and sliver hit testing (SliverHitTestResult).  '
        'A SliverHitTestResult IS-A BoxHitTestResult, so it can also call '
        'addWithPaintOffset when a sliver delegates to a box child.',
      ),
      const SizedBox(height: 8),
      // Visual: three stacked rounded boxes
      _hrCard('Inheritance Chain', Column(
        children: [
          _hrInheritBox('HitTestResult', 'Base class • path list', _hrSlate),
          _hrInheritArrow(),
          _hrInheritBox(
              'BoxHitTestResult', 'addWithPaintOffset()', _hrIndigo),
          _hrInheritArrow(),
          _hrInheritBox(
              'SliverHitTestResult', 'addWithAxisOffset()', _hrCrimson),
        ],
      )),
      const SizedBox(height: 4),
      _hrCard('Why a Separate Sub-Type?', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'Slivers live in a scroll-axis / cross-axis coordinate space that '
            'is fundamentally different from the (x, y) box coordinate space.  '
            'addWithPaintOffset works with 2D Offset, but slivers need to '
            'express the split between mainAxisPosition (along scroll) and '
            'crossAxisPosition (perpendicular).  The separate subclass keeps '
            'the API type-safe: a sliver\'s hitTest method receives a '
            'SliverHitTestResult, ensuring the sliver-specific conversion '
            'method is always available.',
          ),
        ],
      )),
      const SizedBox(height: 4),
      _hrCard('Created By', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrKv('RenderViewport', 'wraps HitTestResult for sliver children'),
          _hrKv('RenderShrinkWrappingViewport', 'same wrapping pattern'),
          _hrKv('SliverHitTestResult.wrap()',
              'factory: SliverHitTestResult.wrap(result)'),
        ],
      )),
      _hrCode(
        '// From RenderViewport.hitTestChildren:\n'
        'final SliverHitTestResult sliverResult =\n'
        '    SliverHitTestResult.wrap(result);\n'
        '// Now the viewport calls child.hitTest(sliverResult, ...);\n'
        '// and the sliver receives a typed result.',
      ),
    ],
  );
}

Widget _hrInheritBox(String name, String detail, Color color) {
  return Container(
    width: 280,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Text(name,
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(detail,
            style: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 11)),
      ],
    ),
  );
}

Widget _hrInheritArrow() {
  return Column(
    children: [
      Container(width: 2, height: 14, color: _hrCrimson),
      const Icon(Icons.arrow_drop_down, size: 18, color: _hrCrimson),
    ],
  );
}

Widget _hrExplainInline(String text) {
  return Text(text,
      style: const TextStyle(
          fontSize: 12, height: 1.5, color: _hrCharcoal));
}

// -------------- 4. addWithAxisOffset Deep Dive ---------------------------

Widget _buildAddWithAxisOffset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'addWithAxisOffset is the heart of SliverHitTestResult .  It performs '
        'these steps:\n\n'
        '1. Subtracts mainAxisOffset from the mainAxisPosition the caller '
        '   provides, yielding a local main-axis position.\n'
        '2. Subtracts crossAxisOffset similarly.\n'
        '3. Calls the supplied hitTest callback with these local coordinates.\n'
        '4. If the callback returns true (hit found), pushes a transform '
        '   entry based on paintOffset so that the framework can later '
        '   convert global coords → local coords for event delivery.\n\n'
        'The separation of paintOffset from (mainAxisOffset, crossAxisOffset) '
        'is necessary because painting and hit testing in slivers can use '
        'different offsets (e.g. when a sliver has a different paint origin '
        'than its layout origin due to scroll caching).',
      ),
      _hrCard('Step-by-Step Conversion', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrStepRow(1, 'Receive pointer in viewport box coords', _hrCrimson),
          _hrStepRow(2, 'Viewport computes mainAxisPosition from pointer '
              'position and scroll offset', _hrOrange),
          _hrStepRow(3, 'Viewport computes crossAxisPosition from pointer '
              'position on the other axis', _hrTeal),
          _hrStepRow(4, 'addWithAxisOffset subtracts offsets → local coords',
              _hrIndigo),
          _hrStepRow(5, 'hitTest callback invoked with local coords', _hrPurple),
          _hrStepRow(6, 'If hit: push paintOffset transform to path', _hrGreen),
        ],
      )),
      _hrCode(
        '// Simplified pseudocode:\n'
        'bool addWithAxisOffset({\n'
        '  Offset? paintOffset,\n'
        '  double mainAxisOffset,\n'
        '  double crossAxisOffset,\n'
        '  double mainAxisPosition,\n'
        '  double crossAxisPosition,\n'
        '  SliverHitTest hitTest,\n'
        '}) {\n'
        '  // Step 4: convert to local\n'
        '  final localMain = mainAxisPosition - mainAxisOffset;\n'
        '  final localCross = crossAxisPosition - crossAxisOffset;\n'
        '\n'
        '  // Step 5: delegate\n'
        '  if (paintOffset != null) {\n'
        '    pushOffset(-paintOffset);\n'
        '  }\n'
        '  final bool isHit = hitTest(this, localMain, localCross);\n'
        '  if (paintOffset != null) {\n'
        '    popTransform();\n'
        '  }\n'
        '  return isHit;\n'
        '}',
      ),
    ],
  );
}

Widget _hrStepRow(int number, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$number',
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(text,
                style: const TextStyle(fontSize: 12, color: _hrCharcoal)),
          ),
        ),
      ],
    ),
  );
}

// -------------- 5. paintOffset → mainAxisPosition -----------------------

Widget _buildPaintOffsetConversion() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'The viewport tells each sliver where to paint by setting its '
        'parentData.paintOffset.  For a vertical down-scrolling list, the '
        'paintOffset.dy is positive going from top to bottom.  The '
        'mainAxisPosition is the pointer\'s distance from the top of the '
        'sliver\'s visible area.  The relationship depends on axis direction.',
      ),
      // Visual: vertical strip showing the offset mapping
      _hrCard('Vertical Scroll-Down Example', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: viewport column
          Column(
            children: [
              const Text('Viewport',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: _hrSlate)),
              const SizedBox(height: 4),
              Container(
                width: 100,
                height: 220,
                decoration: BoxDecoration(
                  border: Border.all(color: _hrSlate, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    _hrViewportSliver('Sliver A', 60, _hrIndigo),
                    _hrViewportSliver('Sliver B', 80, _hrCrimson),
                    _hrViewportSliver('Sliver C', 80, _hrTeal),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Right: explanation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _hrKv('Sliver A paint', 'Offset(0, 0)'),
                _hrKv('Sliver B paint', 'Offset(0, 60)'),
                _hrKv('Sliver C paint', 'Offset(0, 140)'),
                _hrDivider(),
                const Text(
                  'Tap at viewport y=100:\n'
                  '→ Inside Sliver B\n'
                  '→ mainAxisOffset = 60\n'
                  '→ mainAxisPosition = 100 - 60 = 40\n'
                  '→ crossAxisPosition = tap.x',
                  style: TextStyle(
                      fontSize: 11,
                      height: 1.55,
                      color: _hrCharcoal,
                      fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      )),
      const SizedBox(height: 4),
      _hrCard('Horizontal Scroll-Right Example', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text('Viewport',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: _hrSlate)),
              const SizedBox(height: 4),
              Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: _hrSlate, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    _hrViewportSliverH('A', 70, _hrIndigo),
                    _hrViewportSliverH('B', 100, _hrCrimson),
                    _hrViewportSliverH('C', 80, _hrTeal),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hrKv('Sliver A paint', 'Offset(0, 0)'),
            _hrKv('Sliver B paint', 'Offset(70, 0)'),
            _hrKv('Sliver C paint', 'Offset(170, 0)'),
            _hrDivider(),
            const Text(
              'Tap at viewport x=120:\n'
              '→ Inside Sliver B  →  mainAxisPosition = 120 - 70 = 50',
              style: TextStyle(fontSize: 11, color: _hrCharcoal,
                  fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _hrViewportSliver(String label, double height, Color color) {
  return Container(
    width: double.infinity,
    height: height,
    color: color.withValues(alpha: 0.2),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            color: color, fontSize: 11, fontWeight: FontWeight.bold)),
  );
}

Widget _hrViewportSliverH(String label, double width, Color color) {
  return Container(
    width: width,
    height: double.infinity,
    color: color.withValues(alpha: 0.2),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            color: color, fontSize: 11, fontWeight: FontWeight.bold)),
  );
}

// -------------- 6. AxisDirection Mapping ----------------------------------

Widget _buildAxisDirectionMapping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'The AxisDirection enum (down, up, right, left) tells the framework '
        'which physical screen direction is "forward" along the main axis.  '
        'This affects how pointer (x, y) maps to (mainAxisPosition, '
        'crossAxisPosition) and which direction is positive.',
      ),
      _hrCard('AxisDirection.down (default vertical scroll)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrAxisDirVisual('↓', 'down', 'mainAxis = dy, cross = dx',
              _hrCrimson),
          _hrKv('mainAxisPosition', 'pointer.dy - sliverPaint.dy'),
          _hrKv('crossAxisPosition', 'pointer.dx - sliverPaint.dx'),
          _hrKv('Positive direction', '↓ (top to bottom)'),
        ],
      )),
      _hrCard('AxisDirection.up (reverse vertical)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrAxisDirVisual('↑', 'up', 'mainAxis = viewH - dy, cross = dx',
              _hrPurple),
          _hrKv('mainAxisPosition',
              'viewportHeight - pointer.dy - sliverPaint.dy'),
          _hrKv('crossAxisPosition', 'pointer.dx - sliverPaint.dx'),
          _hrKv('Positive direction', '↑ (bottom to top)'),
        ],
      )),
      _hrCard('AxisDirection.right (horizontal)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrAxisDirVisual('→', 'right', 'mainAxis = dx, cross = dy',
              _hrTeal),
          _hrKv('mainAxisPosition', 'pointer.dx - sliverPaint.dx'),
          _hrKv('crossAxisPosition', 'pointer.dy - sliverPaint.dy'),
          _hrKv('Positive direction', '→ (left to right)'),
        ],
      )),
      _hrCard('AxisDirection.left (reverse horizontal)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrAxisDirVisual('←', 'left', 'mainAxis = viewW - dx, cross = dy',
              _hrOrange),
          _hrKv('mainAxisPosition',
              'viewportWidth - pointer.dx - sliverPaint.dx'),
          _hrKv('crossAxisPosition', 'pointer.dy - sliverPaint.dy'),
          _hrKv('Positive direction', '← (right to left)'),
        ],
      )),
    ],
  );
}

Widget _hrAxisDirVisual(
    String arrow, String name, String formula, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(arrow,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AxisDirection.$name',
                  style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              Text(formula,
                  style: const TextStyle(fontSize: 11, color: _hrSlate)),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------- 7. Cross-Axis Offset ------------------------------------

Widget _buildCrossAxisOffset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'While mainAxisPosition tracks along the scroll direction, '
        'crossAxisPosition tracks the perpendicular direction.  In a '
        'vertical list, cross = horizontal.  In a horizontal list, '
        'cross = vertical.\n\n'
        'For SliverGrid, the cross-axis position determines which '
        'column/row the pointer is in.  For SliverList, cross-axis is '
        'less critical but still present for accurate coordinate '
        'propagation to box children.',
      ),
      // Visual: grid showing cross-axis slices
      _hrCard('Cross-Axis in a Vertical Grid', Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: _hrSlate),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              height: 28,
              color: _hrCrimson.withValues(alpha: 0.1),
              child: Row(
                children: [
                  _hrCrossAxisCell('cross=0..100', _hrCrimson, flex: 1),
                  _hrCrossAxisCell('cross=100..200', _hrIndigo, flex: 1),
                  _hrCrossAxisCell('cross=200..300', _hrTeal, flex: 1),
                ],
              ),
            ),
            // Grid rows
            Expanded(
              child: Row(
                children: [
                  _hrGridColumn(_hrCrimson, ['Item 0', 'Item 3', 'Item 6']),
                  _hrGridColumn(_hrIndigo, ['Item 1', 'Item 4', 'Item 7']),
                  _hrGridColumn(_hrTeal, ['Item 2', 'Item 5', 'Item 8']),
                ],
              ),
            ),
          ],
        ),
      )),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hrKv('Tap at (150, 80)', 'crossAxisPosition = 150'),
            _hrKv('Column', '→ second column (100..200)'),
            _hrKv('mainAxisPosition', '= 80 (first row, height 56 each)'),
          ],
        ),
      ),
      _hrCard('Cross-Axis in SliverList', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'A SliverList spans the full cross-axis extent.  The '
            'crossAxisPosition is still provided and forwarded to the box '
            'child so that the box\'s own hitTest knows the horizontal '
            'position of the pointer within the child.',
          ),
          const SizedBox(height: 8),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: _hrAmber),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                _hrListRow('Item 0', _hrAmber, 33),
                _hrListRow('Item 1', _hrOrange, 34),
                _hrListRow('Item 2', _hrBrown, 33),
              ],
            ),
          ),
          const SizedBox(height: 6),
          _hrKv('crossAxisPosition',
              'Pointer x position within the full width'),
          _hrKv('mainAxisPosition',
              'Pointer y, offset by scroll and sliver paint'),
        ],
      )),
    ],
  );
}

Widget _hrCrossAxisCell(String label, Color color, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: color.withValues(alpha: 0.3)),
        ),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 9, fontWeight: FontWeight.bold, color: color)),
    ),
  );
}

Widget _hrGridColumn(Color color, List<String> items) {
  return Expanded(
    child: Column(
      children: items
          .map((label) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    border: Border.all(
                        color: color.withValues(alpha: 0.2), width: 0.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(label,
                      style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.w600)),
                ),
              ))
          .toList(),
    ),
  );
}

Widget _hrListRow(String label, Color color, double height) {
  return Container(
    height: height,
    width: double.infinity,
    color: color.withValues(alpha: 0.12),
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 12),
    child: Text(label,
        style: TextStyle(
            fontSize: 11, color: color, fontWeight: FontWeight.w600)),
  );
}

// -------------- 8. Transform Stack --------------------------------------

Widget _buildTransformStack() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'The HitTestResult maintains a stack of transforms.  Each time '
        'addWithAxisOffset is called, it pushes a translation transform '
        'equivalent to -paintOffset.  When a sliver in turn delegates to a '
        'box child via addWithPaintOffset, another transform is pushed.\n\n'
        'After the hit test completes, the framework reverses these '
        'transforms to convert global pointer positions into local '
        'coordinates for event delivery.',
      ),
      _hrCard('Transform Stack Example', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrTransformLayer(0, 'Viewport → Sliver A',
              'push(-paintOffset(0, 60))', _hrCrimson),
          _hrTransformLayer(1, 'Sliver A → Box child',
              'push(-childPaintOffset(0, 0))', _hrIndigo),
          _hrTransformLayer(2, 'Box → inner widget',
              'push(-localOffset(8, 8))', _hrTeal),
          _hrDivider(),
          const Text(
            'After hit found, the framework uses the inverse of each '
            'accumulated transform to convert global coords to local.',
            style: TextStyle(fontSize: 11, color: _hrSlate, height: 1.5),
          ),
        ],
      )),
      _hrCode(
        '// The transform stack after hitting a widget in Sliver A:\n'
        '// Stack top → bottom:\n'
        '//   translate(-8, -8)    ← box→widget offset\n'
        '//   translate(0, 0)      ← sliver→box offset\n'
        '//   translate(0, -60)    ← viewport→sliver paintOffset\n'
        '//\n'
        '// To convert global(150, 100) to local:\n'
        '//   (150, 100) + (0, -60) + (0, 0) + (-8, -8)\n'
        '//   = (142, 32)  ← local coords in the widget',
      ),
    ],
  );
}

Widget _hrTransformLayer(int depth, String title, String transform, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                TextSpan(
                  text: transform,
                  style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: _hrSlate),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// -------------- 9. GrowthDirection Impact --------------------------------

Widget _buildGrowthDirection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'GrowthDirection tells the viewport whether slivers grow in the '
        'same direction as AxisDirection (forward) or opposite (reverse).  '
        'In a standard ListView, slivers grow forward.  But a '
        'CustomScrollView can place slivers before AND after the center '
        'sliver — those before grow in reverse.\n\n'
        'For hit testing, GrowthDirection affects which sliver is checked '
        'first and how paintOffset is calculated, but the '
        'addWithAxisOffset logic itself is unaffected — it just receives '
        'the pre-computed offset values.',
      ),
      _hrCard('GrowthDirection.forward', Column(
        children: [
          _hrGrowthRow('Sliver 1', 0, _hrCrimson),
          _hrGrowthRow('Sliver 2', 80, _hrIndigo),
          _hrGrowthRow('Sliver 3', 160, _hrTeal),
          _hrDivider(),
          _hrKv('Order', 'paintOffset increases with sliver index'),
          _hrKv('Hit test order', 'Last painted (Sliver 3) tested first'),
        ],
      )),
      _hrCard('GrowthDirection.reverse', Column(
        children: [
          _hrGrowthRow('Center-1', 160, _hrCrimson),
          _hrGrowthRow('Center-2', 80, _hrPurple),
          _hrGrowthRow('Center-3', 0, _hrOrange),
          _hrDivider(),
          _hrKv('Order', 'paintOffset decreases with sliver index'),
          _hrKv('Hit test order', 'First (Center-3 at top) tested last'),
          _hrKv('Note', 'Reverse slivers appear ABOVE the center sliver'),
        ],
      )),
      _hrCode(
        '// In a CustomScrollView with center:\n'
        'CustomScrollView(\n'
        '  center: centerKey,\n'
        '  slivers: [\n'
        '    // These grow REVERSE (upward from center)\n'
        '    SliverList(...),\n'
        '    SliverList(key: centerKey, ...),  // center\n'
        '    // These grow FORWARD (downward from center)\n'
        '    SliverList(...),\n'
        '  ],\n'
        ')',
      ),
    ],
  );
}

Widget _hrGrowthRow(String label, double offset, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.layers, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text('$label  (paintOffset.dy = $offset)',
              style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _hrCharcoal)),
        ),
      ],
    ),
  );
}

// -------------- 10. Viewport → Sliver → Box chain -----------------------

Widget _buildHitChain() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'A complete hit test passes through three levels:\n\n'
        '1. Viewport: receives (position) in box coords.  Creates '
        'SliverHitTestResult.wrap(result). For each sliver child, calls '
        'addWithAxisOffset.\n\n'
        '2. Sliver: receives (mainAxisPosition, crossAxisPosition).  If '
        'the hit is within its geometry, it delegates to its box children '
        'by calling addWithPaintOffset on the same result (which is also '
        'a BoxHitTestResult).\n\n'
        '3. Box child: receives standard Offset position and performs '
        'normal box hit testing.',
      ),
      _hrCard('Three-Level Propagation',
        _buildChainVisual(),
      ),
      _hrCode(
        '// Level 1: Viewport\n'
        'bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {\n'
        '  final sliverResult = SliverHitTestResult.wrap(result);\n'
        '  for (final child in childrenInHitTestOrder) {\n'
        '    final hit = sliverResult.addWithAxisOffset(\n'
        '      paintOffset: child.parentData.paintOffset,\n'
        '      mainAxisOffset: mainAxisOf(child),\n'
        '      crossAxisOffset: crossAxisOf(child),\n'
        '      mainAxisPosition: mainAxisPositionFor(position),\n'
        '      crossAxisPosition: crossAxisPositionFor(position),\n'
        '      hitTest: child.hitTest,  // → Level 2\n'
        '    );\n'
        '    if (hit) return true;\n'
        '  }\n'
        '  return false;\n'
        '}\n\n'
        '// Level 2: Sliver (e.g. RenderSliverList)\n'
        'bool hitTestChildren(SliverHitTestResult result,\n'
        '    {required double mainAxisPosition,\n'
        '     required double crossAxisPosition}) {\n'
        '  final boxResult = BoxHitTestResult.wrap(result);\n'
        '  // ... find the right child ...\n'
        '  return boxResult.addWithPaintOffset(\n'
        '    offset: childOffset,  // → Level 3\n'
        '    position: Offset(crossAxisPosition, mainAxisPosition),\n'
        '    hitTest: (result, pos) => child.hitTest(result, position: pos),\n'
        '  );\n'
        '}',
      ),
    ],
  );
}

Widget _buildChainVisual() {
  return Column(
    children: [
      _hrChainBox('VIEWPORT', 'RenderViewport', 'box coords (x, y)',
          _hrSlate),
      _hrChainArrowWithLabel('addWithAxisOffset'),
      _hrChainBox('SLIVER', 'RenderSliverList',
          'mainAxisPosition, crossAxisPosition', _hrCrimson),
      _hrChainArrowWithLabel('addWithPaintOffset'),
      _hrChainBox('BOX CHILD', 'RenderBox',
          'box coords (x, y) local', _hrIndigo),
      _hrChainArrowWithLabel('hitTest → HitTestEntry'),
      _hrChainBox('WIDGET', 'GestureDetector',
          'receives pointer event', _hrGreen),
    ],
  );
}

Widget _hrChainBox(String tier, String clazz, String coords, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        _hrPill(tier, color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clazz,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(coords,
                  style:
                      const TextStyle(fontSize: 10, color: _hrSlate)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hrChainArrowWithLabel(String label) {
  return Column(
    children: [
      Container(
        width: 2,
        height: 8,
        color: _hrCrimson.withValues(alpha: 0.4),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: _hrRose,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 9, color: _hrCrimson,
                fontWeight: FontWeight.w600)),
      ),
      const Icon(Icons.arrow_drop_down, size: 16, color: _hrCrimson),
    ],
  );
}

// -------------- 11. addWithAxisOffset vs addWithPaintOffset ---------------

Widget _buildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'Both methods convert coordinates and push transforms, but they '
        'differ in their coordinate models and where they are used.',
      ),
      _hrCard('Side-by-Side', Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _hrComparisonColumn(
                'addWithAxisOffset',
                _hrCrimson,
                [
                  'On SliverHitTestResult',
                  'Params: mainAxisOffset / crossAxisOffset',
                  'Coords: mainAxisPosition / crossAxisPosition',
                  'Used by: Viewport → Sliver',
                  'Callback: SliverHitTest',
                  'Converts: box → sliver coords',
                ],
              ),
              const SizedBox(width: 8),
              _hrComparisonColumn(
                'addWithPaintOffset',
                _hrIndigo,
                [
                  'On BoxHitTestResult',
                  'Params: offset (Offset)',
                  'Coords: position (Offset)',
                  'Used by: parent box → child box',
                  'Callback: BoxHitTest',
                  'Converts: parent box → child box',
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hrAmber.withValues(alpha: 0.1),
              border: Border.all(color: _hrAmber),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Key insight: addWithAxisOffset splits the Offset into '
              'mainAxis + crossAxis components, while addWithPaintOffset '
              'works with 2D Offset directly.  Both eventually push the '
              'same kind of translate transform based on paintOffset.',
              style: TextStyle(fontSize: 11, color: _hrCharcoal, height: 1.5),
            ),
          ),
        ],
      )),
      _hrCode(
        '// addWithPaintOffset (BoxHitTestResult):\n'
        '// Subtracts offset from position, pushes -offset transform.\n'
        '// Used for box-to-box delegation.\n\n'
        '// addWithAxisOffset (SliverHitTestResult):\n'
        '// Subtracts mainAxisOffset/crossAxisOffset from corresponding\n'
        '// positions, pushes -paintOffset transform.\n'
        '// Used for viewport-to-sliver delegation.\n'
        '//\n'
        '// BOTH push paintOffset as the transform, but\n'
        '// addWithAxisOffset applies separate 1D offsets to the\n'
        '// hit-test callback parameters.',
      ),
    ],
  );
}

Widget _hrComparisonColumn(String title, Color color, List<String> items) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color, fontSize: 11)),
                    Expanded(
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 10, color: _hrCharcoal)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

// -------------- 12. Hit Probe Grid ---------------------------------------

Widget _buildHitGrid() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'This section simulates a 4 × 6 grid of sliver children and shows '
        'the computed mainAxisPosition and crossAxisPosition for each cell.  '
        'The grid assumes AxisDirection.down (vertical scroll) with each '
        'cell being 70 wide and 50 tall.',
      ),
      _hrCard('Simulated Coordinate Grid',
        _buildGridVisual(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Each cell displays:',
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold, color: _hrCharcoal)),
            const SizedBox(height: 2),
            _hrKv('m:', 'mainAxisPosition (scroll direction = vertical)'),
            _hrKv('c:', 'crossAxisPosition (horizontal)'),
            _hrDivider(),
            const Text(
              'When a pointer hits cell (col=2, row=3), the sliver\'s '
              'hitTest receives:\n'
              '  mainAxisPosition = row*50 + intra-cell-y\n'
              '  crossAxisPosition = col*70 + intra-cell-x',
              style: TextStyle(fontSize: 11, color: _hrSlate, height: 1.5),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildGridVisual() {
  const int cols = 4;
  const int rows = 6;
  const double cellW = 68;
  const double cellH = 42;

  final List<Color> colColors = [_hrCrimson, _hrIndigo, _hrTeal, _hrOrange];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column header
        Row(
          children: List.generate(cols, (c) {
            return Container(
              width: cellW,
              height: 22,
              alignment: Alignment.center,
              child: Text('col $c',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: colColors[c])),
            );
          }),
        ),
        // Grid
        ...List.generate(rows, (r) {
          return Row(
            children: List.generate(cols, (c) {
              final mainPos = r * 50;
              final crossPos = c * 70;
              final colorBase = colColors[c];
              final shade = r.isEven ? 0.08 : 0.15;
              return Container(
                width: cellW,
                height: cellH,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: colorBase.withValues(alpha: shade),
                  border: Border.all(
                      color: colorBase.withValues(alpha: 0.3), width: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('m:$mainPos',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: colorBase)),
                    Text('c:$crossPos',
                        style:
                            TextStyle(fontSize: 8, color: colorBase.withValues(alpha: 0.7))),
                  ],
                ),
              );
            }),
          );
        }),
      ],
    ),
  );
}

// -------------- 13. Usage in RenderSliver --------------------------------

Widget _buildUsagePatterns() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _hrExplain(
        'RenderSliver subclasses interact with SliverHitTestResult in two '
        'ways: (1) their hitTest method receives it, and (2) they use the '
        'wrapped BoxHitTestResult to delegate to box children.',
      ),
      _hrCard('Pattern 1: RenderSliverList', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'RenderSliverList has box children laid out linearly along the '
            'main axis.  It iterates through visible children, computes each '
            'child\'s main-axis extent, and delegates with '
            'addWithPaintOffset when the hit falls within a child.',
          ),
          const SizedBox(height: 8),
          _hrKv('Receives', 'SliverHitTestResult'),
          _hrKv('Delegates via', 'BoxHitTestResult.addWithPaintOffset'),
          _hrKv('Child type', 'RenderBox'),
        ],
      )),
      _hrCard('Pattern 2: RenderSliverGrid', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'RenderSliverGrid is similar but considers cross-axis position '
            'to determine which column the pointer is in, then which child '
            'sits at that grid location.',
          ),
          const SizedBox(height: 8),
          _hrKv('Receives', 'SliverHitTestResult'),
          _hrKv('Cross-axis used', 'Yes, to select column'),
          _hrKv('Delegates via', 'BoxHitTestResult.addWithPaintOffset'),
        ],
      )),
      _hrCard('Pattern 3: RenderSliverToBoxAdapter', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'The simplest sliver-to-box bridge. Has a single box child.  '
            'Converts sliver coords to box coords and delegates immediately.',
          ),
          const SizedBox(height: 8),
          _hrKv('Receives', 'SliverHitTestResult'),
          _hrKv('Child count', 'Exactly one RenderBox'),
          _hrKv('Conversion', 'mainAxisPosition → y (or x), crossAxisPosition → x (or y)'),
        ],
      )),
      _hrCard('Pattern 4: Nested Viewports', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hrExplainInline(
            'When a SliverFillViewport or nested scrollable is a sliver\'s '
            'box child, the inner viewport creates yet another '
            'SliverHitTestResult for its own sliver children.  This can '
            'produce deeply nested transform stacks.',
          ),
          const SizedBox(height: 8),
          _hrKv('Outer viewport', 'SliverHitTestResult (outer)'),
          _hrKv('Outer sliver', 'delegates → box child (inner viewport)'),
          _hrKv('Inner viewport', 'SliverHitTestResult (inner)'),
          _hrKv('Inner sliver', 'delegates → final box child'),
          _hrKv('Transform depth', 'Can be 4+ levels of coordinate transforms'),
        ],
      )),
      _hrCode(
        '// RenderSliverToBoxAdapter.hitTestChildren:\n'
        '@override\n'
        'bool hitTestChildren(\n'
        '  SliverHitTestResult result, {\n'
        '  required double mainAxisPosition,\n'
        '  required double crossAxisPosition,\n'
        '}) {\n'
        '  if (child != null) {\n'
        '    return hitTestBoxChild(\n'
        '      BoxHitTestResult.wrap(result),\n'
        '      child!,\n'
        '      mainAxisPosition: mainAxisPosition,\n'
        '      crossAxisPosition: crossAxisPosition,\n'
        '    );\n'
        '  }\n'
        '  return false;\n'
        '}\n\n'
        '// hitTestBoxChild converts sliver coords back to box coords:\n'
        '// Offset(crossAxisPosition, mainAxisPosition) for vertical,\n'
        '// Offset(mainAxisPosition, crossAxisPosition) for horizontal.',
      ),
    ],
  );
}

// -------------- 14. Summary card -----------------------------------------

Widget _buildSummary() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_hrCrimson, Color(0xFFB71C1C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Summary',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 14),
        _hrSummaryPoint(
          'SliverHitTestResult extends BoxHitTestResult with '
          'addWithAxisOffset.'),
        _hrSummaryPoint(
          'addWithAxisOffset converts viewport box coords into sliver '
          'mainAxisPosition / crossAxisPosition.'),
        _hrSummaryPoint(
          'Four AxisDirection values determine the mapping between '
          'physical screen axes and sliver coordinates.'),
        _hrSummaryPoint(
          'The transform stack accumulates coordinate transforms that '
          'the framework reverses for event delivery.'),
        _hrSummaryPoint(
          'GrowthDirection affects sliver ordering but not the offset '
          'conversion math inside addWithAxisOffset.'),
        _hrSummaryPoint(
          'Three-level hit chain: Viewport → Sliver → Box, with '
          'SliverHitTestResult bridging the first two levels.'),
        _hrSummaryPoint(
          'RenderSliver subclasses receive a SliverHitTestResult and '
          'delegate to box children via BoxHitTestResult.wrap().'),
        _hrSummaryPoint(
          'Nested viewports create additional SliverHitTestResult layers, '
          'deepening the transform stack.'),
      ],
    ),
  );
}

Widget _hrSummaryPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.arrow_right, color: _hrRose, size: 16),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, height: 1.5)),
        ),
      ],
    ),
  );
}
