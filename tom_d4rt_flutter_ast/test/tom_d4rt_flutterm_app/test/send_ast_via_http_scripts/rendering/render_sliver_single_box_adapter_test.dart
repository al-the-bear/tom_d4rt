// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverSingleBoxAdapter
//
// RenderSliverSingleBoxAdapter is the render object base class for slivers
// that host exactly one box child. It bridges the sliver protocol and the
// box protocol, laying out a single RenderBox within sliver constraints.
//
// SliverToBoxAdapter is the most common widget built on top of this class.
// Whenever you place a non-sliver widget inside a CustomScrollView, you
// wrap it in SliverToBoxAdapter, which creates a
// RenderSliverSingleBoxAdapter under the hood.
//
// This demo visualises:
//   1. Overview — adapting a single box child into a sliver
//   2. Box-to-sliver bridge — how constraints translate
//   3. Layout protocol — how the child is measured and positioned
//   4. SliverGeometry produced — scrollExtent, paintExtent, etc.
//   5. Scroll clipping — partial visibility during scroll
//   6. Hit testing through the adapter
//   7. Comparison: single box vs multi box adaptors
//   8. Visual demo with SliverToBoxAdapter
//   9. Patterns and best practices
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Copper / Bronze
// ---------------------------------------------------------------------------
const Color _sbPrimary = Color(0xFF8D6E63);
const Color _sbPrimaryLight = Color(0xFFA1887F);
const Color _sbAccent = Color(0xFF6D4C41);
const Color _sbAccentLight = Color(0xFFD7CCC8);
const Color _sbSurface = Color(0xFFEFEBE9);
const Color _sbSurfaceDark = Color(0xFFD7CCC8);
const Color _sbOnPrimary = Color(0xFFFFFFFF);
const Color _sbTextDark = Color(0xFF3E2723);
const Color _sbTextMedium = Color(0xFF5D4037);
const Color _sbDivider = Color(0xFFBCAAA4);
const Color _sbGreen = Color(0xFF2E7D32);
const Color _sbBlue = Color(0xFF1565C0);
const Color _sbOrange = Color(0xFFE65100);
const Color _sbTeal = Color(0xFF00695C);
const Color _sbGrey = Color(0xFF757575);
const Color _sbAmber = Color(0xFFF57F17);
const Color _sbPurple = Color(0xFF6A1B9A);
const Color _sbRed = Color(0xFFC62828);
const Color _sbIndigo = Color(0xFF283593);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _sbSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _sbPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _sbTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _sbDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _sbBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _sbInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _sbPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _sbSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _sbTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _sbTextMedium, height: 1.4)),
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
Widget _sbCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _sbSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _sbAccent, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _sbSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sbSectionTitle('1 · Single Box Adapter Overview', Icons.crop_square),
      _sbInfoCard(
        'What is RenderSliverSingleBoxAdapter?',
        'A sliver render object that hosts exactly one RenderBox child. '
            'It receives sliver constraints from the viewport and translates '
            'them into box constraints for its child. The child is a normal '
            'box widget — card, container, image, etc.',
        Icons.transform,
      ),
      _sbInfoCard(
        'The most used sliver adapter',
        'Every time you place a non-sliver widget inside a CustomScrollView, '
            'you use SliverToBoxAdapter. Under the hood, it creates a '
            'RenderSliverSingleBoxAdapter that handles the protocol bridge.',
        Icons.star,
        accent: _sbAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          children: [
            Text('Widget ↔ Render mapping', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _sbTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _sbBadge('SliverToBoxAdapter', _sbPrimary, _sbOnPrimary),
                      SizedBox(height: 4),
                      Text('Widget layer', style: TextStyle(fontSize: 9, color: _sbTextMedium)),
                      Text('accepts any child widget', style: TextStyle(fontSize: 9, color: _sbGrey)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, size: 14, color: _sbGrey),
                Expanded(
                  child: Column(
                    children: [
                      _sbBadge('RenderSliverSingleBoxAdapter', _sbAccent, _sbOnPrimary),
                      SizedBox(height: 4),
                      Text('Render layer', style: TextStyle(fontSize: 9, color: _sbTextMedium)),
                      Text('lays out one RenderBox', style: TextStyle(fontSize: 9, color: _sbGrey)),
                    ],
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
// Section 2: Box-to-Sliver Bridge
// ---------------------------------------------------------------------------
Widget _sbSection2Bridge() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('2 · Box-to-Sliver Bridge', Icons.swap_horiz),
      _sbInfoCard(
        'Two different layout protocols',
        'Box layout uses BoxConstraints (min/max width and height). '
            'Sliver layout uses SliverConstraints (crossAxisExtent, '
            'remainingPaintExtent, scrollOffset, etc.). The adapter translates '
            'between these two incompatible constraint systems.',
        Icons.compare_arrows,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constraint translation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _sbTextDark)),
            SizedBox(height: 8),
            // Sliver constraints (input)
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _sbBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border(left: BorderSide(color: _sbBlue, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sbBadge('SliverConstraints (input)', _sbBlue, _sbOnPrimary),
                  SizedBox(height: 4),
                  _sbCode('crossAxisExtent: 400.0'),
                  SizedBox(height: 2),
                  _sbCode('remainingPaintExtent: 600.0'),
                  SizedBox(height: 2),
                  _sbCode('scrollOffset: 50.0'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Center(child: Icon(Icons.arrow_downward, size: 20, color: _sbPrimary)),
            ),
            // Translated box constraints
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _sbPrimary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border(left: BorderSide(color: _sbPrimary, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sbBadge('BoxConstraints (to child)', _sbPrimary, _sbOnPrimary),
                  SizedBox(height: 4),
                  _sbCode('minWidth: 400.0, maxWidth: 400.0'),
                  SizedBox(height: 2),
                  _sbCode('minHeight: 0.0, maxHeight: ∞'),
                  SizedBox(height: 2),
                  Text('Cross-axis is tight, main-axis is unconstrained', style: TextStyle(fontSize: 10, color: _sbTextMedium, fontStyle: FontStyle.italic)),
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
// Section 3: Layout Protocol
// ---------------------------------------------------------------------------
Widget _sbSection3Layout() {
  final steps = <Map<String, dynamic>>[
    {'step': '1', 'desc': 'Viewport passes SliverConstraints', 'detail': 'crossAxisExtent, scrollOffset, remaining paint extent', 'color': _sbBlue},
    {'step': '2', 'desc': 'Adapter creates BoxConstraints', 'detail': 'Tight cross-axis, unbounded main-axis', 'color': _sbPrimary},
    {'step': '3', 'desc': 'Child is laid out with box constraints', 'detail': 'Child picks its natural main-axis size', 'color': _sbTeal},
    {'step': '4', 'desc': 'Child size → SliverGeometry', 'detail': 'scrollExtent = child main-axis size', 'color': _sbOrange},
    {'step': '5', 'desc': 'Adapter paints child at correct offset', 'detail': 'Adjusted for current scroll position', 'color': _sbGreen},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('3 · Layout Protocol', Icons.grid_on),
      _sbInfoCard(
        'Step-by-step layout',
        'The adapter\'s performLayout() follows a clear sequence: receive '
            'sliver constraints, translate to box constraints, lay out child, '
            'produce SliverGeometry from the child\'s size.',
        Icons.format_list_numbered,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          children: steps.map((s) => Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: (s['color'] as Color).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(color: s['color'] as Color, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(s['step'] as String, style: TextStyle(fontSize: 10, color: _sbOnPrimary, fontWeight: FontWeight.w700)),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s['desc'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: s['color'] as Color)),
                      Text(s['detail'] as String, style: TextStyle(fontSize: 10, color: _sbTextMedium)),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: SliverGeometry Produced
// ---------------------------------------------------------------------------
Widget _sbSection4Geometry() {
  final fields = <Map<String, String>>[
    {'field': 'scrollExtent', 'value': 'child.size.height', 'note': 'Total scrollable size of this sliver'},
    {'field': 'paintExtent', 'value': 'visible portion', 'note': 'How much is currently visible in viewport'},
    {'field': 'maxPaintExtent', 'value': 'child.size.height', 'note': 'Maximum possible paint extent'},
    {'field': 'layoutExtent', 'value': 'same as paintExtent', 'note': 'Space consumed in the viewport'},
    {'field': 'paintOrigin', 'value': '0 or negative', 'note': 'Where painting starts relative to layout position'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('4 · SliverGeometry Produced', Icons.architecture),
      _sbInfoCard(
        'Geometry from child size',
        'After laying out the child, the adapter computes SliverGeometry. '
            'scrollExtent equals the child\'s main-axis size. paintExtent '
            'is the portion currently visible within the viewport (clamped '
            'to remaining paint extent).',
        Icons.straighten,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          children: fields.map((f) => Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _sbSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _sbCode(f['field']!),
                    SizedBox(width: 8),
                    Expanded(child: Text(f['value']!, style: TextStyle(fontSize: 10, color: _sbAccent, fontWeight: FontWeight.w600))),
                  ],
                ),
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(f['note']!, style: TextStyle(fontSize: 10, color: _sbTextMedium, fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Scroll Clipping
// ---------------------------------------------------------------------------
Widget _sbSection5Clipping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('5 · Scroll Clipping', Icons.content_cut),
      _sbInfoCard(
        'Partial visibility during scroll',
        'When a sliver is partially scrolled off, only part of the child '
            'is visible. The adapter reports the visible portion as paintExtent '
            'and offsets the child painting accordingly. The viewport clips '
            'the rest.',
        Icons.crop,
      ),
      Container(
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Stack(
          children: [
            // Viewport frame
            Positioned(
              left: 20, top: 10, right: 20, bottom: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _sbPrimary.withValues(alpha: 0.4), width: 2),
                ),
              ),
            ),
            Positioned(
              left: 24, top: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                color: Colors.white,
                child: Text('Viewport', style: TextStyle(fontSize: 9, color: _sbPrimary, fontWeight: FontWeight.w700)),
              ),
            ),
            // Fully visible child
            Positioned(
              left: 40, top: 28, right: 40,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: _sbGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _sbGreen.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Fully visible', style: TextStyle(fontSize: 10, color: _sbGreen, fontWeight: FontWeight.w700)),
                    Text('paintExtent = scrollExtent', style: TextStyle(fontSize: 8, color: _sbTextMedium)),
                  ],
                ),
              ),
            ),
            // Partially visible child (bottom)
            Positioned(
              left: 40, top: 86, right: 40, bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: _sbAmber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _sbAmber.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Text('Partially visible', style: TextStyle(fontSize: 10, color: _sbAmber, fontWeight: FontWeight.w700)),
                    Text('paintExtent < scrollExtent', style: TextStyle(fontSize: 8, color: _sbTextMedium)),
                    SizedBox(height: 4),
                    Text('Clipped by viewport ↓', style: TextStyle(fontSize: 8, color: _sbRed)),
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
// Section 6: Hit Testing
// ---------------------------------------------------------------------------
Widget _sbSection6HitTest() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('6 · Hit Testing Through the Adapter', Icons.touch_app),
      _sbInfoCard(
        'Touch events reach the child',
        'Hit testing in slivers is different from box layout. The adapter '
            'translates the sliver hit test coordinates into box hit test '
            'coordinates, forwarding taps and gestures to the child widget. '
            'Only the visible portion responds to touches.',
        Icons.ads_click,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hit test flow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _sbTextDark)),
            SizedBox(height: 8),
            ...[
              {'step': 'Viewport receives pointer event', 'color': _sbBlue},
              {'step': 'Delegates to sliver hit test', 'color': _sbPrimary},
              {'step': 'Adapter checks if within paint bounds', 'color': _sbTeal},
              {'step': 'Converts sliver position → box position', 'color': _sbOrange},
              {'step': 'Child hitTest() is called with box coordinates', 'color': _sbGreen},
            ].map((s) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_right, size: 14, color: s['color'] as Color),
                  SizedBox(width: 6),
                  Expanded(child: Text(s['step'] as String, style: TextStyle(fontSize: 11, color: _sbTextMedium))),
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
// Section 7: Comparison
// ---------------------------------------------------------------------------
Widget _sbSection7Comparison() {
  final diffs = <Map<String, String>>[
    {'aspect': 'Children', 'single': 'Exactly one', 'multi': 'Dynamic list'},
    {'aspect': 'Widget', 'single': 'SliverToBoxAdapter', 'multi': 'SliverList, SliverGrid'},
    {'aspect': 'Recycling', 'single': 'None (one child)', 'multi': 'Lazily built children'},
    {'aspect': 'Use case', 'single': 'Headers, banners, single items', 'multi': 'Long lists, grids'},
    {'aspect': 'Performance', 'single': 'O(1) fixed cost', 'multi': 'O(visible) amortised'},
    {'aspect': 'Complexity', 'single': 'Simple', 'multi': 'Complex (keep-alive, indices)'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('7 · Single vs Multi Box Adaptor', Icons.compare),
      _sbInfoCard(
        'When to use which',
        'RenderSliverSingleBoxAdapter hosts one child. '
            'RenderSliverMultiBoxAdaptor hosts many lazily-built children '
            '(like SliverList). Use single for standalone elements, multi '
            'for dynamic lists.',
        Icons.view_carousel,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(color: _sbSurface, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  SizedBox(width: 70, child: Text('Aspect', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _sbTextDark))),
                  Expanded(child: Text('SingleBox', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _sbPrimary))),
                  Expanded(child: Text('MultiBox', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _sbBlue))),
                ],
              ),
            ),
            ...diffs.map((d) => Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _sbDivider.withValues(alpha: 0.3)))),
              child: Row(
                children: [
                  SizedBox(width: 70, child: Text(d['aspect']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _sbTextDark))),
                  Expanded(child: Text(d['single']!, style: TextStyle(fontSize: 10, color: _sbPrimary))),
                  Expanded(child: Text(d['multi']!, style: TextStyle(fontSize: 10, color: _sbBlue))),
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
// Section 8: Visual Demo
// ---------------------------------------------------------------------------
Widget _sbSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('8 · Visual Demo', Icons.preview),
      _sbInfoCard(
        'SliverToBoxAdapter in a CustomScrollView',
        'Below is a scroll view mixing SliverToBoxAdapter (single-box) '
            'with SliverList (multi-box). Each SliverToBoxAdapter wraps a '
            'regular box widget — a card, banner, or info panel.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _sbSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('Mixed slivers: SliverToBoxAdapter + SliverList', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _sbTextDark)),
            ),
            SizedBox(
              height: 360,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    // Banner via SliverToBoxAdapter
                    SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_sbPrimary, _sbAccent],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.crop_square, color: _sbOnPrimary, size: 24),
                            SizedBox(height: 4),
                            Text('SliverToBoxAdapter #1', style: TextStyle(color: _sbOnPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                            _sbBadge('Single box child: Banner', _sbOnPrimary.withValues(alpha: 0.2), _sbOnPrimary),
                          ],
                        ),
                      ),
                    ),
                    // A few list items
                    SliverList.builder(
                      itemCount: 5,
                      itemBuilder: (ctx, i) => Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _sbBlue.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _sbDivider.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.list, size: 14, color: _sbBlue),
                            SizedBox(width: 8),
                            Text('SliverList item ${i + 1}', style: TextStyle(fontSize: 11, color: _sbTextDark)),
                          ],
                        ),
                      ),
                    ),
                    // Info panel via SliverToBoxAdapter
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _sbTeal.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _sbTeal.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: _sbTeal, size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SliverToBoxAdapter #2', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _sbTeal)),
                                  Text('An info panel — just a regular box widget', style: TextStyle(fontSize: 10, color: _sbTextMedium)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // More list items
                    SliverList.builder(
                      itemCount: 5,
                      itemBuilder: (ctx, i) => Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _sbOrange.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _sbDivider.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.list, size: 14, color: _sbOrange),
                            SizedBox(width: 8),
                            Text('SliverList item ${i + 6}', style: TextStyle(fontSize: 11, color: _sbTextDark)),
                          ],
                        ),
                      ),
                    ),
                    // Card via SliverToBoxAdapter
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _sbPurple.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _sbPurple.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(
                                color: _sbPurple.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.widgets, color: _sbPurple, size: 24),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SliverToBoxAdapter #3', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _sbPurple)),
                                  Text('A card-like element mixing into the sliver list', style: TextStyle(fontSize: 10, color: _sbTextMedium)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Final list items
                    SliverList.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, i) => Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _sbGreen.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _sbDivider.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.list, size: 14, color: _sbGreen),
                            SizedBox(width: 8),
                            Text('SliverList item ${i + 11}', style: TextStyle(fontSize: 11, color: _sbTextDark)),
                          ],
                        ),
                      ),
                    ),
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
// Section 9: Patterns and Best Practices
// ---------------------------------------------------------------------------
Widget _sbSection9Patterns() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Headers and footers', 'desc': 'Use SliverToBoxAdapter for page headers, footers, or section dividers between SliverLists', 'icon': Icons.vertical_split, 'color': _sbPrimary},
    {'title': 'Promotional banners', 'desc': 'Insert advertising or announcement blocks between list items', 'icon': Icons.campaign, 'color': _sbOrange},
    {'title': 'Empty states', 'desc': 'Show a "no results" widget when the list is empty via SliverToBoxAdapter', 'icon': Icons.inbox, 'color': _sbGrey},
    {'title': 'Loading indicators', 'desc': 'Place a spinner at the bottom of a CustomScrollView for pagination', 'icon': Icons.autorenew, 'color': _sbBlue},
    {'title': 'Avoid for long lists', 'desc': 'Don\'t create dozens of SliverToBoxAdapters — use SliverList instead', 'icon': Icons.warning, 'color': _sbRed},
    {'title': 'Child sizing matters', 'desc': 'The child determines the sliver\'s scroll extent — oversized children cause excessive scrolling', 'icon': Icons.straighten, 'color': _sbAmber},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _sbSectionTitle('9 · Patterns & Best Practices', Icons.star),
      _sbInfoCard(
        'Getting the most from single-box adapters',
        'SliverToBoxAdapter is the workhorse for inserting standalone widgets '
            'into CustomScrollViews. Use it wisely — one adapter per distinct '
            'element, not as a replacement for SliverList.',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, size: 18, color: p['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _sbTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _sbTextMedium)),
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
            colors: [_sbPrimary.withValues(alpha: 0.08), _sbAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _sbPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.crop_square, size: 32, color: _sbPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverSingleBoxAdapter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _sbTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The bridge between box layout and sliver layout — hosting '
              'a single box child inside a sliver protocol container.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _sbTextMedium, height: 1.4),
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
              colors: [_sbPrimary, _sbAccent],
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
                  Icon(Icons.crop_square, color: _sbOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverSingleBoxAdapter',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _sbOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Hosting a single box child inside a sliver container',
                style: TextStyle(fontSize: 12, color: _sbOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _sbSection1Overview(),
        _sbSection2Bridge(),
        _sbSection3Layout(),
        _sbSection4Geometry(),
        _sbSection5Clipping(),
        _sbSection6HitTest(),
        _sbSection7Comparison(),
        _sbSection8Demo(),
        _sbSection9Patterns(),

        SizedBox(height: 24),
      ],
    ),
  );
}
