// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverMainAxisGroup
//
// RenderSliverMainAxisGroup groups multiple child slivers along the scroll
// axis and treats them as a single sliver. The viewport sees one sliver whose
// total extent equals the sum of its children's.
//
// This demo visualises:
//   1. Overview of SliverMainAxisGroup
//   2. Grouping concept — one logical sliver from many
//   3. Layout: children placed sequentially along main axis
//   4. Geometry aggregation: scrollExtent, paintExtent, maxPaintExtent
//   5. Paint origin and overlap handling
//   6. Hit testing within the group
//   7. Comparison with nested CustomScrollViews
//   8. Visual demonstration with grouped slivers
//   9. Best practices and integration patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Rose / Magenta
// ---------------------------------------------------------------------------
const Color _mgPrimary = Color(0xFFAD1457);
const Color _mgPrimaryLight = Color(0xFFD81B60);
const Color _mgAccent = Color(0xFFF50057);
const Color _mgAccentLight = Color(0xFFFF80AB);
const Color _mgSurface = Color(0xFFFCE4EC);
const Color _mgSurfaceDark = Color(0xFFF8BBD0);
const Color _mgOnPrimary = Color(0xFFFFFFFF);
const Color _mgTextDark = Color(0xFF880E4F);
const Color _mgTextMedium = Color(0xFFC2185B);
const Color _mgDivider = Color(0xFFF48FB1);
const Color _mgGreen = Color(0xFF2E7D32);
const Color _mgBlue = Color(0xFF1565C0);
const Color _mgOrange = Color(0xFFE65100);
const Color _mgTeal = Color(0xFF00695C);
const Color _mgGrey = Color(0xFF757575);
const Color _mgAmber = Color(0xFFF57F17);
const Color _mgIndigo = Color(0xFF283593);
const Color _mgDeepPurple = Color(0xFF4527A0);
const Color _mgRed = Color(0xFFC62828);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _mgSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _mgPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _mgTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _mgDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _mgBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _mgInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _mgPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _mgSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _mgTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _mgTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: code snippet
// ---------------------------------------------------------------------------
Widget _mgCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _mgSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _mgPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _mgSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _mgSectionTitle('1 · SliverMainAxisGroup Overview', Icons.group_work),
      _mgInfoCard(
        'What is RenderSliverMainAxisGroup?',
        'A sliver render object that groups multiple child slivers and '
            'lays them out sequentially along the main axis (scroll direction). '
            'The viewport treats the group as a single sliver, simplifying '
            'layout logic for complex scroll compositions.',
        Icons.view_stream,
      ),
      _mgInfoCard(
        'Widget: SliverMainAxisGroup',
        'The widget API is SliverMainAxisGroup, which takes a list of '
            'sliver children and creates a RenderSliverMainAxisGroup to '
            'manage their combined layout and painting.',
        Icons.widgets,
        accent: _mgAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _mgBadge('Sliver A', _mgBlue, _mgOnPrimary),
                Icon(Icons.add, size: 12, color: _mgGrey),
                _mgBadge('Sliver B', _mgTeal, _mgOnPrimary),
                Icon(Icons.add, size: 12, color: _mgGrey),
                _mgBadge('Sliver C', _mgOrange, _mgOnPrimary),
              ],
            ),
            SizedBox(height: 6),
            Icon(Icons.arrow_downward, size: 16, color: _mgGrey),
            SizedBox(height: 4),
            _mgBadge('SliverMainAxisGroup', _mgPrimary, _mgOnPrimary),
            SizedBox(height: 6),
            Text(
              'Viewport sees one sliver with combined geometry',
              style: TextStyle(fontSize: 10, color: _mgTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Grouping Concept
// ---------------------------------------------------------------------------
Widget _mgSection2Grouping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('2 · Grouping Concept', Icons.merge_type),
      _mgInfoCard(
        'One logical sliver from many',
        'Without grouping, each sliver is an independent child of the viewport. '
            'With SliverMainAxisGroup, a set of slivers is treated as one child. '
            'This matters for scroll position calculations, paint order, and '
            'cacheExtent management.',
        Icons.account_tree,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Row(
          children: [
            // Without grouping
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _mgGrey.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _mgGrey.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Text('Without grouping', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _mgGrey)),
                    SizedBox(height: 6),
                    _mgBadge('Viewport', _mgGrey, _mgOnPrimary),
                    SizedBox(height: 4),
                    Text('├─ Sliver A', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgGrey)),
                    Text('├─ Sliver B', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgGrey)),
                    Text('├─ Sliver C', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgGrey)),
                    Text('├─ Sliver D', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgGrey)),
                    Text('└─ Sliver E', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgGrey)),
                    SizedBox(height: 4),
                    Text('5 children', style: TextStyle(fontSize: 9, color: _mgGrey)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            // With grouping
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _mgPrimary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _mgPrimary.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Text('With grouping', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _mgPrimary)),
                    SizedBox(height: 6),
                    _mgBadge('Viewport', _mgPrimary, _mgOnPrimary),
                    SizedBox(height: 4),
                    Text('├─ Group 1', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgPrimary)),
                    Text('│  ├─ A', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgTextMedium)),
                    Text('│  ├─ B', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgTextMedium)),
                    Text('│  └─ C', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgTextMedium)),
                    Text('└─ Group 2', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgPrimary)),
                    Text('   ├─ D', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgTextMedium)),
                    Text('   └─ E', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _mgTextMedium)),
                    SizedBox(height: 4),
                    Text('2 children', style: TextStyle(fontSize: 9, color: _mgPrimary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Layout – Sequential Placement
// ---------------------------------------------------------------------------
Widget _mgSection3Layout() {
  final slivers = <Map<String, dynamic>>[
    {'name': 'SliverAppBar', 'height': 64, 'color': _mgBlue},
    {'name': 'SliverList (5 items)', 'height': 100, 'color': _mgTeal},
    {'name': 'SliverPadding', 'height': 24, 'color': _mgOrange},
    {'name': 'SliverGrid (2×2)', 'height': 80, 'color': _mgIndigo},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('3 · Layout: Sequential Placement', Icons.view_stream),
      _mgInfoCard(
        'Children laid out sequentially',
        'RenderSliverMainAxisGroup performs layout on each child sliver in '
            'order. Each child receives a SliverConstraints with its '
            'scrollOffset adjusted by the preceding children\'s extents. '
            'Children are placed one after another along the scroll axis.',
        Icons.sort,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group children — stacked along main axis', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _mgTextDark)),
            SizedBox(height: 8),
            ...slivers.map((s) => Container(
              height: (s['height'] as int) * 0.4,
              margin: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _mgBadge(s['name'] as String, s['color'] as Color, _mgOnPrimary),
                  SizedBox(width: 6),
                  Text('${s['height']}px', style: TextStyle(fontSize: 10, color: _mgGrey)),
                ],
              ),
            )),
            Divider(color: _mgDivider, height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total scrollExtent = ', style: TextStyle(fontSize: 11, color: _mgTextMedium)),
                _mgCode('64 + 100 + 24 + 80 = 268px'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Geometry Aggregation
// ---------------------------------------------------------------------------
Widget _mgSection4Geometry() {
  final fields = <Map<String, String>>[
    {'field': 'scrollExtent', 'desc': 'Sum of all children\'s scrollExtent'},
    {'field': 'paintExtent', 'desc': 'Portion of group visible in viewport'},
    {'field': 'maxPaintExtent', 'desc': 'Maximum paint extent of all children combined'},
    {'field': 'layoutExtent', 'desc': 'How much space the group occupies in viewport layout'},
    {'field': 'hasVisualOverflow', 'desc': 'True if any child overflows or group is partially visible'},
    {'field': 'cacheExtent', 'desc': 'Combined cache extent for off-screen pre-rendering'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('4 · Geometry Aggregation', Icons.straighten),
      _mgInfoCard(
        'Combined SliverGeometry',
        'The group produces a single SliverGeometry from all children. '
            'scrollExtent is the total of all children, paintExtent and '
            'maxPaintExtent are computed from what\'s currently visible.',
        Icons.crop_square,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SliverGeometry fields', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _mgTextDark)),
            Divider(color: _mgDivider, height: 12),
            ...fields.map((f) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: _mgCode(f['field']!),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(f['desc']!, style: TextStyle(fontSize: 10, color: _mgTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Paint Origin and Overlap
// ---------------------------------------------------------------------------
Widget _mgSection5PaintOrigin() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('5 · Paint Origin & Overlap', Icons.format_paint),
      _mgInfoCard(
        'Paint origin management',
        'Each child sliver within the group has its own paint origin. '
            'The group offsets each child based on the accumulated scroll '
            'extent of preceding children. When the group is partially '
            'scrolled, earlier children scroll off while later ones enter.',
        Icons.swap_vert,
      ),
      Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Stack(
          children: [
            // Viewport rectangle
            Positioned(
              left: 20, top: 10, right: 20, bottom: 10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _mgGrey, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            // Visible area label
            Positioned(
              left: 30, top: 14,
              child: _mgBadge('Viewport visible area', _mgGrey, _mgOnPrimary),
            ),
            // Child A (partially scrolled off)
            Positioned(
              left: 30, top: 35, right: 30,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: _mgBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _mgBlue.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text('Child A (partly scrolled off)', style: TextStyle(fontSize: 9, color: _mgBlue, fontWeight: FontWeight.w600)),
              ),
            ),
            // Child B (fully visible)
            Positioned(
              left: 30, top: 68, right: 30,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _mgTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _mgTeal.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text('Child B (fully visible)', style: TextStyle(fontSize: 9, color: _mgTeal, fontWeight: FontWeight.w600)),
              ),
            ),
            // Child C (partly entering)
            Positioned(
              left: 30, top: 111, right: 30,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: _mgOrange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _mgOrange.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text('Child C (partly entering)', style: TextStyle(fontSize: 9, color: _mgOrange, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Hit Testing
// ---------------------------------------------------------------------------
Widget _mgSection6HitTesting() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('6 · Hit Testing Within the Group', Icons.touch_app),
      _mgInfoCard(
        'Delegated hit testing',
        'RenderSliverMainAxisGroup delegates hit testing to its children '
            'in reverse paint order (last painted = topmost). Each child\'s '
            'hit test receives coordinates adjusted for its position within '
            'the group.',
        Icons.gesture,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hit test flow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _mgTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.touch_app, size: 18, color: _mgPrimary),
                SizedBox(width: 6),
                Text('Pointer event', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _mgPrimary)),
              ],
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _mgHitTestStep('1. Group receives hit test', _mgPrimary),
                  _mgHitTestStep('2. Iterates children in reverse order', _mgAccent),
                  _mgHitTestStep('3. Adjusts coordinates for each child offset', _mgBlue),
                  _mgHitTestStep('4. First child that returns true wins', _mgGreen),
                  _mgHitTestStep('5. Result added to HitTestResult', _mgTeal),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _mgHitTestStep(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 6, height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 11, color: _mgTextMedium)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Comparison with Nested ScrollViews
// ---------------------------------------------------------------------------
Widget _mgSection7Comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('7 · vs Nested CustomScrollViews', Icons.compare),
      _mgInfoCard(
        'Why not just nest scroll views?',
        'Nesting CustomScrollViews creates separate scrollable regions with '
            'independent physics — the inner view doesn\'t share the outer '
            'scroll position. SliverMainAxisGroup keeps all slivers in the '
            'same scroll context with shared physics.',
        Icons.compare_arrows,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nested approach
            Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _mgRed.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _mgRed.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cancel, size: 14, color: _mgRed),
                      SizedBox(width: 4),
                      Text('Nested CustomScrollViews', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _mgRed)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('• Separate scroll positions and physics', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• Confusing scroll behaviour for users', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• Requires NeverScrollableScrollPhysics hacks', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• ScrollController conflicts', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                ],
              ),
            ),
            // Group approach
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _mgGreen.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _mgGreen.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 14, color: _mgGreen),
                      SizedBox(width: 4),
                      Text('SliverMainAxisGroup', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _mgGreen)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('• Single scroll position and physics', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• Natural scroll behaviour', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• No hacks needed', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
                  Text('• Clean architecture', style: TextStyle(fontSize: 10, color: _mgTextMedium)),
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
// Section 8: Visual Demo
// ---------------------------------------------------------------------------
Widget _mgSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('8 · Visual Demo', Icons.preview),
      _mgInfoCard(
        'Grouped slivers in action',
        'Below is a CustomScrollView with two SliverMainAxisGroups. '
            'Each group contains multiple slivers that scroll as one unit. '
            'The viewport treats each group as a single child.',
        Icons.view_list,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _mgSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CustomScrollView with SliverMainAxisGroup', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _mgTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 280,
              child: CustomScrollView(
                slivers: [
                  // Group 1: Header section
                  SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: _mgPrimary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text('Group 1 — Header', style: TextStyle(color: _mgOnPrimary, fontWeight: FontWeight.w700, fontSize: 13)),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 35,
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: _mgPrimaryLight.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: _mgPrimaryLight.withValues(alpha: 0.3)),
                          ),
                          alignment: Alignment.center,
                          child: Text('Sub-header sliver', style: TextStyle(fontSize: 10, color: _mgPrimaryLight)),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: _mgAccentLight.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: _mgAccentLight.withValues(alpha: 0.3)),
                          ),
                          alignment: Alignment.center,
                          child: Text('Navigation sliver', style: TextStyle(fontSize: 10, color: _mgAccent)),
                        ),
                      ),
                    ],
                  ),
                  // Group 2: Content section
                  SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: _mgBlue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text('Group 2 — Content', style: TextStyle(color: _mgOnPrimary, fontWeight: FontWeight.w700, fontSize: 13)),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: 6,
                        itemBuilder: (ctx, i) => Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            color: _mgBlue.withValues(alpha: 0.06 + i * 0.02),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: _mgBlue.withValues(alpha: 0.15)),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.article, size: 14, color: _mgBlue),
                              SizedBox(width: 4),
                              Text('Content item ${i + 1}', style: TextStyle(fontSize: 11, color: _mgBlue)),
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
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _mgSection9BestPractices() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Logical grouping', 'desc': 'Group slivers that form a logical section (header + body + footer)', 'icon': Icons.category, 'color': _mgPrimary},
    {'title': 'Keep groups small', 'desc': 'Avoid putting dozens of slivers in one group — it defeats the purpose', 'icon': Icons.compress, 'color': _mgBlue},
    {'title': 'Combine with SliverCrossAxisGroup', 'desc': 'Use main-axis groups along scroll and cross-axis groups across it', 'icon': Icons.grid_view, 'color': _mgTeal},
    {'title': 'Use for sticky headers', 'desc': 'Group a pinned SliverAppBar with its content slivers', 'icon': Icons.push_pin, 'color': _mgOrange},
    {'title': 'Test scroll positions', 'desc': 'Verify scrollExtent calculations with your specific content', 'icon': Icons.straighten, 'color': _mgGreen},
    {'title': 'Avoid nested groups', 'desc': 'Keep group hierarchy flat — deeply nested groups add complexity', 'icon': Icons.layers_clear, 'color': _mgRed},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _mgSectionTitle('9 · Best Practices', Icons.star),
      _mgInfoCard(
        'Getting the most from SliverMainAxisGroup',
        'SliverMainAxisGroup shines when you have logically related slivers '
            'that should be treated as a single scroll unit. Use it wisely '
            'to simplify complex CustomScrollView layouts.',
        Icons.tips_and_updates,
      ),
      ...practices.map((p) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: p['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(p['icon'] as IconData, size: 18, color: p['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _mgTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _mgTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_mgPrimary.withValues(alpha: 0.08), _mgAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _mgPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.group_work, size: 32, color: _mgPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverMainAxisGroup',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _mgTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Combine multiple slivers into a single logical scroll '
              'unit — clean architecture, shared physics, unified geometry.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _mgTextMedium, height: 1.4),
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
              colors: [_mgPrimary, _mgPrimaryLight],
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
                  Icon(Icons.group_work, color: _mgOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverMainAxisGroup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _mgOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Grouping slivers along the scroll axis as one logical unit',
                style: TextStyle(fontSize: 12, color: _mgOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _mgSection1Overview(),
        _mgSection2Grouping(),
        _mgSection3Layout(),
        _mgSection4Geometry(),
        _mgSection5PaintOrigin(),
        _mgSection6HitTesting(),
        _mgSection7Comparison(),
        _mgSection8Demo(),
        _mgSection9BestPractices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
