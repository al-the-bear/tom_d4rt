// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverHelpers
//
// RenderSliverHelpers is a mixin on RenderSliver that provides utility
// methods for implementing custom slivers that contain box children.
// It bridges the gap between sliver geometry and box geometry, providing:
// - Hit testing: translates sliver coordinates to box child coordinates
// - Position helpers: main axis and cross axis child positions
// - Paint transform: applies correct paint offsets for box children
// - Overflow indicators: debug-mode overflow painting
//
// This demo visualises:
//   1. Overview of RenderSliverHelpers mixin
//   2. hitTestBoxChild — coordinate translation for hit testing
//   3. childMainAxisPosition — position along scroll direction
//   4. childCrossAxisPosition — position perpendicular to scroll
//   5. applyPaintTransform — transform matrix for box children
//   6. Axis-aware coordinate mapping
//   7. GrowthDirection interaction
//   8. Overflow indicator painting (debug mode)
//   9. Practical sliver implementation patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Brown / DeepBrown
// ---------------------------------------------------------------------------
const Color _shPrimary = Color(0xFF4E342E);
const Color _shPrimaryLight = Color(0xFF6D4C41);
const Color _shAccent = Color(0xFF8D6E63);
const Color _shAccentLight = Color(0xFFA1887F);
const Color _shSurface = Color(0xFFEFEBE9);
const Color _shSurfaceDark = Color(0xFFD7CCC8);
const Color _shOnPrimary = Color(0xFFFFFFFF);
const Color _shTextDark = Color(0xFF3E2723);
const Color _shTextMedium = Color(0xFF5D4037);
const Color _shDivider = Color(0xFFBCAAA4);
const Color _shGreen = Color(0xFF2E7D32);
const Color _shRed = Color(0xFFC62828);
const Color _shBlue = Color(0xFF1565C0);
const Color _shOrange = Color(0xFFE65100);
const Color _shPurple = Color(0xFF6A1B9A);
const Color _shTeal = Color(0xFF00695C);
const Color _shGrey = Color(0xFF757575);
const Color _shAmber = Color(0xFFF57F17);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _shSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _shPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _shTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _shDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _shBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _shInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _shPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _shSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _shTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _shTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: code block
// ---------------------------------------------------------------------------
Widget _shCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _shSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _shPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: RenderSliverHelpers Overview
// ---------------------------------------------------------------------------
Widget _shSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionTitle('1 · RenderSliverHelpers Overview', Icons.build_circle),
      _shInfoCard(
        'Mixin for sliver render objects',
        'RenderSliverHelpers is a mixin applied to RenderSliver subclasses '
            'that contain box children. It provides utility methods for the '
            'common operations needed when a sliver hosts box-protocol children '
            'inside a sliver-protocol layout.',
        Icons.extension,
      ),
      _shInfoCard(
        'Bridging sliver and box protocols',
        'Slivers use SliverConstraints and SliverGeometry while box children '
            'use BoxConstraints and Size. RenderSliverHelpers translates '
            'coordinates, hit test positions, and paint offsets between these '
            'two layout protocols.',
        Icons.swap_horiz,
        accent: _shAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          children: [
            Text('Mixin method catalogue', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            _shMethodRow('hitTestBoxChild()', 'Translate sliver hit coords to box child', _shBlue),
            _shMethodRow('childMainAxisPosition()', 'Child offset along scroll axis', _shGreen),
            _shMethodRow('childCrossAxisPosition()', 'Child offset perpendicular to scroll', _shTeal),
            _shMethodRow('childScrollOffset()', 'Scroll offset for a specific child', _shPurple),
            _shMethodRow('applyPaintTransform()', 'Paint matrix for box child in sliver', _shOrange),
          ],
        ),
      ),
    ],
  );
}

Widget _shMethodRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(width: 4, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 8),
        _shCode(name, color: color),
        SizedBox(width: 8),
        Expanded(child: Text(desc, style: TextStyle(fontSize: 10, color: _shTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: hitTestBoxChild
// ---------------------------------------------------------------------------
Widget _shSection2HitTest() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('2 · hitTestBoxChild', Icons.touch_app),
      _shInfoCard(
        'Coordinate translation for hit testing',
        'When a sliver receives a hit test at a sliver-relative position '
            '(mainAxisPosition, crossAxisPosition), hitTestBoxChild translates '
            'that into box-relative coordinates (x, y) using the child\'s '
            'layout position and the current axis direction.',
        Icons.adjust,
      ),
      Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Stack(
          children: [
            // Sliver area (full)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: _shPrimary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Label
            Positioned(
              left: 8, top: 8,
              child: _shBadge('Sliver coordinate space', _shPrimary, _shOnPrimary),
            ),
            // Box child inside sliver
            Positioned(
              left: 40, top: 50, right: 40, bottom: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: _shBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _shBlue, width: 1.5),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 8, top: 8,
                      child: _shBadge('Box child', _shBlue, _shOnPrimary),
                    ),
                    // Hit point in sliver space
                    Positioned(
                      left: 80, top: 40,
                      child: Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _shRed,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hit point\n(mainAxis: 90, crossAxis: 120)',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9, color: _shRed, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    // Translated point
                    Positioned(
                      right: 20, bottom: 15,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _shGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _shGreen),
                        ),
                        child: Text(
                          'Translated → (x: 80, y: 40)',
                          style: TextStyle(fontSize: 9, color: _shGreen, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Arrow showing translation
            Positioned(
              right: 8, top: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_downward, size: 16, color: _shAccent),
                  Text('hitTestBoxChild()', style: TextStyle(fontSize: 9, color: _shAccent, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: childMainAxisPosition
// ---------------------------------------------------------------------------
Widget _shSection3MainAxis() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('3 · childMainAxisPosition', Icons.straighten),
      _shInfoCard(
        'Position along the scroll direction',
        'childMainAxisPosition(child) returns the offset in logical pixels '
            'from the zero-scroll-offset edge of the sliver to the given child. '
            'For a vertical scrollable, this is the y-offset; for horizontal, '
            'the x-offset.',
        Icons.vertical_distribute,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vertical sliver — main axis = Y', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            // Vertical axis demo
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Axis indicator
                SizedBox(
                  width: 40,
                  height: 180,
                  child: Column(
                    children: [
                      Icon(Icons.arrow_upward, size: 14, color: _shGreen),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: _shGreen.withValues(alpha: 0.4),
                        ),
                      ),
                      Icon(Icons.arrow_downward, size: 14, color: _shGreen),
                      Text('main', style: TextStyle(fontSize: 9, color: _shGreen, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                // Children stacked vertically
                Expanded(
                  child: Column(
                    children: [
                      _shAxisChild('Child A', 0, _shBlue),
                      _shAxisChild('Child B', 50, _shPurple),
                      _shAxisChild('Child C', 110, _shTeal),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Horizontal sliver — main axis = X', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back, size: 14, color: _shOrange),
                    Expanded(
                      child: Container(height: 2, color: _shOrange.withValues(alpha: 0.4)),
                    ),
                    Icon(Icons.arrow_forward, size: 14, color: _shOrange),
                  ],
                ),
                Text('main axis', style: TextStyle(fontSize: 9, color: _shOrange, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Row(
                  children: [
                    _shHAxisChild('A', 0, _shBlue),
                    SizedBox(width: 4),
                    _shHAxisChild('B', 80, _shPurple),
                    SizedBox(width: 4),
                    _shHAxisChild('C', 170, _shTeal),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shAxisChild(String label, int offset, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 4),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: color)),
        Spacer(),
        _shBadge('mainAxisPos: $offset', color, _shOnPrimary),
      ],
    ),
  );
}

Widget _shHAxisChild(String label, int offset, Color color) {
  return Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: color)),
          Text('pos: $offset', style: TextStyle(fontSize: 9, color: color)),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: childCrossAxisPosition
// ---------------------------------------------------------------------------
Widget _shSection4CrossAxis() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('4 · childCrossAxisPosition', Icons.swap_horiz),
      _shInfoCard(
        'Position perpendicular to scroll',
        'childCrossAxisPosition(child) returns the child\'s offset along '
            'the cross axis. For vertical scrolling, this is the x-offset. '
            'RenderSliverHelpers defaults to 0.0, meaning the child is '
            'flush with the leading edge of the cross axis.',
        Icons.horizontal_distribute,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cross axis positioning', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: _shSurface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _shDivider),
              ),
              child: Stack(
                children: [
                  // Cross axis arrow
                  Positioned(
                    left: 10, right: 10, top: 10,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, size: 12, color: _shTeal),
                        Expanded(child: Container(height: 1, color: _shTeal.withValues(alpha: 0.4))),
                        Icon(Icons.arrow_forward, size: 12, color: _shTeal),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0, right: 0, top: 22,
                    child: Text('cross axis', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: _shTeal)),
                  ),
                  // Main axis arrow
                  Positioned(
                    left: 10, top: 30, bottom: 10,
                    child: Column(
                      children: [
                        Icon(Icons.arrow_upward, size: 12, color: _shGreen),
                        Expanded(child: Container(width: 1, color: _shGreen.withValues(alpha: 0.4))),
                        Icon(Icons.arrow_downward, size: 12, color: _shGreen),
                      ],
                    ),
                  ),
                  // Child with crossAxisPosition = 0
                  Positioned(
                    left: 30, top: 40,
                    child: Container(
                      width: 100, height: 30,
                      decoration: BoxDecoration(
                        color: _shBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _shBlue),
                      ),
                      alignment: Alignment.center,
                      child: Text('crossPos: 0', style: TextStyle(fontSize: 10, color: _shBlue, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  // Child with crossAxisPosition > 0
                  Positioned(
                    left: 140, top: 75,
                    child: Container(
                      width: 120, height: 30,
                      decoration: BoxDecoration(
                        color: _shPurple.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _shPurple),
                      ),
                      alignment: Alignment.center,
                      child: Text('crossPos: 110', style: TextStyle(fontSize: 10, color: _shPurple, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: applyPaintTransform
// ---------------------------------------------------------------------------
Widget _shSection5PaintTransform() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('5 · applyPaintTransform', Icons.transform),
      _shInfoCard(
        'Paint offset matrix',
        'applyPaintTransform(child, transform) applies the correct paint '
            'offset to a Matrix4 so the box child is painted at its actual '
            'position within the sliver. It accounts for scroll offset, axis '
            'direction, and growth direction.',
        Icons.grid_on,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transform pipeline', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 10),
            _shPipelineStep(1, 'Start with identity Matrix4', Icons.crop_square, _shGrey),
            _shPipelineStep(2, 'Translate by paintOffset (from layout)', Icons.open_with, _shBlue),
            _shPipelineStep(3, 'Adjust for axis direction', Icons.swap_vert, _shGreen),
            _shPipelineStep(4, 'Adjust for growth direction', Icons.trending_up, _shPurple),
            _shPipelineStep(5, 'Result: child painted at correct sliver position', Icons.check_circle, _shPrimary),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Visual: before and after transform
      Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _shRed.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _shRed.withValues(alpha: 0.3)),
              ),
              child: Stack(
                children: [
                  Text('Without transform', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _shRed)),
                  Positioned(
                    left: 0, top: 30,
                    child: Container(
                      width: 60, height: 40,
                      decoration: BoxDecoration(color: _shRed.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: Text('(0,0)', style: TextStyle(fontSize: 9, color: _shRed)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward, color: _shAccent),
          ),
          Expanded(
            child: Container(
              height: 100,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _shGreen.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _shGreen.withValues(alpha: 0.3)),
              ),
              child: Stack(
                children: [
                  Text('With transform', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _shGreen)),
                  Positioned(
                    left: 40, top: 45,
                    child: Container(
                      width: 60, height: 40,
                      decoration: BoxDecoration(color: _shGreen.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: Text('(40,45)', style: TextStyle(fontSize: 9, color: _shGreen)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _shPipelineStep(int num, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$num', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
        ),
        SizedBox(width: 8),
        Icon(icon, size: 16, color: color),
        SizedBox(width: 6),
        Expanded(child: Text(desc, style: TextStyle(fontSize: 11, color: _shTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: Axis-aware Coordinate Mapping
// ---------------------------------------------------------------------------
Widget _shSection6AxisMapping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('6 · Axis-aware Coordinate Mapping', Icons.explore),
      _shInfoCard(
        'Vertical vs horizontal slivers',
        'RenderSliverHelpers automatically accounts for the scroll axis. '
            'For Axis.vertical, main axis = Y and cross axis = X. '
            'For Axis.horizontal, main axis = X and cross axis = Y. '
            'All helper methods handle this transparently.',
        Icons.compare_arrows,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          children: [
            // Vertical mapping
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _shGreen.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _shGreen.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        _shBadge('Axis.vertical', _shGreen, _shOnPrimary),
                        SizedBox(height: 8),
                        _shMappingRow('mainAxisPos', 'Y offset', _shGreen),
                        _shMappingRow('crossAxisPos', 'X offset', _shGreen),
                        _shMappingRow('paintOffset', 'dy = pos', _shGreen),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _shOrange.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _shOrange.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        _shBadge('Axis.horizontal', _shOrange, _shOnPrimary),
                        SizedBox(height: 8),
                        _shMappingRow('mainAxisPos', 'X offset', _shOrange),
                        _shMappingRow('crossAxisPos', 'Y offset', _shOrange),
                        _shMappingRow('paintOffset', 'dx = pos', _shOrange),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shMappingRow(String from, String to, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        _shCode(from, color: color),
        Icon(Icons.arrow_forward, size: 12, color: _shGrey),
        Expanded(
          child: Text(to, style: TextStyle(fontSize: 10, color: _shTextMedium)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: GrowthDirection Interaction
// ---------------------------------------------------------------------------
Widget _shSection7GrowthDirection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('7 · GrowthDirection Interaction', Icons.trending_up),
      _shInfoCard(
        'Forward vs reverse growth',
        'Slivers can grow either forward (towards higher scroll offsets) or '
            'reverse (towards lower scroll offsets). GrowthDirection affects '
            'how RenderSliverHelpers calculates paint offsets and hit test '
            'positions — forward growth places children at increasing offsets, '
            'reverse growth at decreasing offsets.',
        Icons.swap_vert,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _shBadge('GrowthDirection.forward', _shGreen, _shOnPrimary),
                  SizedBox(height: 8),
                  _shGrowthBlock('Child A', 'pos: 0', _shBlue),
                  Icon(Icons.arrow_downward, size: 14, color: _shGrey),
                  _shGrowthBlock('Child B', 'pos: 60', _shPurple),
                  Icon(Icons.arrow_downward, size: 14, color: _shGrey),
                  _shGrowthBlock('Child C', 'pos: 120', _shTeal),
                ],
              ),
            ),
            Container(width: 1, height: 160, color: _shDivider),
            Expanded(
              child: Column(
                children: [
                  _shBadge('GrowthDirection.reverse', _shRed, _shOnPrimary),
                  SizedBox(height: 8),
                  _shGrowthBlock('Child C', 'pos: 120', _shTeal),
                  Icon(Icons.arrow_upward, size: 14, color: _shGrey),
                  _shGrowthBlock('Child B', 'pos: 60', _shPurple),
                  Icon(Icons.arrow_upward, size: 14, color: _shGrey),
                  _shGrowthBlock('Child A', 'pos: 0', _shBlue),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _shGrowthBlock(String label, String pos, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        _shBadge(pos, color.withValues(alpha: 0.15), color),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Overflow Indicator (Debug)
// ---------------------------------------------------------------------------
Widget _shSection8Overflow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('8 · Overflow Indicator (Debug)', Icons.warning_amber),
      _shInfoCard(
        'Debug overflow painting',
        'In debug mode, RenderSliverHelpers can paint overflow indicators '
            '(the familiar yellow-and-black striped bars) when a box child '
            'exceeds the sliver\'s available extent. This is the same visual '
            'used by RenderFlex overflow.',
        Icons.pest_control,
        accent: _shAmber,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overflow indicator visualisation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _shPrimary),
              ),
              child: Row(
                children: [
                  // Content that fits
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: _shBlue.withValues(alpha: 0.1),
                      alignment: Alignment.center,
                      child: Text('Content (fits)', style: TextStyle(fontSize: 10, color: _shBlue)),
                    ),
                  ),
                  // Overflow area with stripe pattern
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _shAmber.withValues(alpha: 0.3),
                        border: Border(left: BorderSide(color: _shRed, width: 2)),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning, size: 16, color: _shRed),
                          Text('OVERFLOW', style: TextStyle(fontSize: 8, color: _shRed, fontWeight: FontWeight.w800)),
                          Text('48px', style: TextStyle(fontSize: 8, color: _shRed)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: _shTextMedium),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Debug-only: overflow indicators are not painted in release builds',
                    style: TextStyle(fontSize: 10, color: _shTextMedium, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Practical Sliver Implementation
// ---------------------------------------------------------------------------
Widget _shSection9Practical() {
  final steps = <Map<String, dynamic>>[
    {'step': 'Extend RenderSliver with RenderSliverHelpers', 'icon': Icons.extension, 'color': _shPrimary},
    {'step': 'Set up RenderObjectWithChildMixin for box child', 'icon': Icons.child_care, 'color': _shBlue},
    {'step': 'In performLayout(), lay out child with box constraints', 'icon': Icons.straighten, 'color': _shGreen},
    {'step': 'Use childMainAxisPosition/crossAxisPosition in hit test', 'icon': Icons.touch_app, 'color': _shPurple},
    {'step': 'Override applyPaintTransformForChild() for painting', 'icon': Icons.brush, 'color': _shOrange},
    {'step': 'Call hitTestBoxChild() in hitTestChildren()', 'icon': Icons.adjust, 'color': _shTeal},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('9 · Practical Sliver Implementation', Icons.engineering),
      _shInfoCard(
        'Building a custom sliver with box children',
        'When implementing a custom sliver that contains box-protocol children '
            '(e.g. a sliver that embeds a single box widget), mix in '
            'RenderSliverHelpers to get correct hit testing, painting, and '
            'position queries without reimplementing coordinate translation.',
        Icons.architecture,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Implementation steps', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
            SizedBox(height: 8),
            ...steps.asMap().entries.map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: (e.value['color'] as Color).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${e.key + 1}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: e.value['color'] as Color)),
                  ),
                  SizedBox(width: 8),
                  Icon(e.value['icon'] as IconData, size: 16, color: e.value['color'] as Color),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(e.value['step'] as String, style: TextStyle(fontSize: 11, color: _shTextMedium)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      // Live example: SliverToBoxAdapter uses these helpers internally
      _shInfoCard(
        'Real-world usage: SliverToBoxAdapter',
        'SliverToBoxAdapter is a sliver that contains a single box child. '
            'Its render object, RenderSliverToBoxAdapter, uses '
            'RenderSliverHelpers to handle hit testing and painting. '
            'This is the most common use case.',
        Icons.apps,
        accent: _shAccent,
      ),
      // Visual: SliverToBoxAdapter in a scroll view
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _shSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CustomScrollView with slivers using helpers', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _shTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 150,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _shBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _shBlue.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text('SliverToBoxAdapter — uses RenderSliverHelpers', style: TextStyle(fontSize: 10, color: _shBlue, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _shPurple.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _shPurple.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text('Each sliver delegates hit test via helpers', style: TextStyle(fontSize: 10, color: _shPurple, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: _shTeal.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _shTeal.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text('Paint transform computed by applyPaintTransform', style: TextStyle(fontSize: 10, color: _shTeal, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_shPrimary.withValues(alpha: 0.08), _shAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.build_circle, size: 32, color: _shPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverHelpers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _shTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The essential mixin for slivers hosting box children — providing '
              'coordinate translation between sliver and box layout protocols '
              'for correct hit testing, painting, and position queries.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _shTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_shPrimary, _shPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.build_circle, color: _shOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverHelpers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _shOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Utility mixin for slivers with box children — coordinate translation',
                style: TextStyle(fontSize: 12, color: _shOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _shSection1Overview(),
        _shSection2HitTest(),
        _shSection3MainAxis(),
        _shSection4CrossAxis(),
        _shSection5PaintTransform(),
        _shSection6AxisMapping(),
        _shSection7GrowthDirection(),
        _shSection8Overflow(),
        _shSection9Practical(),

        SizedBox(height: 24),
      ],
    ),
  );
}
