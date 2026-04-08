// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverFloatingPersistentHeader
//
// RenderSliverFloatingPersistentHeader is a sliver that renders a persistent
// header which "floats" back into view as soon as the user scrolls back,
// even when the header was previously scrolled off-screen. This is the
// render object behind SliverAppBar(floating: true).
//
// This demo visualises:
//   1. What a floating persistent header is and how it differs from pinned
//   2. The scroll-direction-dependent reveal/hide mechanics
//   3. Layout protocol: how the sliver communicates with the viewport
//   4. Geometry fields: paintExtent, layoutExtent, scrollExtent
//   5. Snap behaviour (optional snap-open / snap-closed animation)
//   6. Interaction with SliverConstraints (scrollOffset, overlap)
//   7. Stretch and overscroll behaviour
//   8. Comparison matrix: floating vs pinned vs scrolling headers
//   9. Integration with SliverAppBar and CustomScrollView
//
// All visuals are standard Flutter widgets — no custom render objects.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Amber / DeepOrange
// ---------------------------------------------------------------------------
const Color _fhPrimary = Color(0xFFF57F17);
const Color _fhPrimaryLight = Color(0xFFFFA000);
const Color _fhAccent = Color(0xFFFF6D00);
const Color _fhAccentDark = Color(0xFFE65100);
const Color _fhSurface = Color(0xFFFFF8E1);
const Color _fhSurfaceDark = Color(0xFFFFECB3);
const Color _fhOnPrimary = Color(0xFFFFFFFF);
const Color _fhTextDark = Color(0xFFE65100);
const Color _fhTextMedium = Color(0xFFF57C00);
const Color _fhDivider = Color(0xFFFFCC80);
const Color _fhBlue = Color(0xFF1565C0);
const Color _fhGreen = Color(0xFF2E7D32);
const Color _fhPurple = Color(0xFF6A1B9A);
const Color _fhGrey = Color(0xFF757575);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _fhSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _fhPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _fhTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _fhDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _fhBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _fhInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _fhPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _fhSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _fhTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _fhTextMedium, height: 1.4)),
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
Widget _fhCode(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _fhSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _fhPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Floating Header Overview
// ---------------------------------------------------------------------------
Widget _fhSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _fhSectionTitle('1 · Floating Header Overview', Icons.view_day_outlined),
      _fhInfoCard(
        'What is a floating persistent header?',
        'A sliver header that scrolls off-screen like normal content, but '
            'immediately begins to reappear when the user reverses scroll '
            'direction—even before reaching the top of the scroll view. '
            'This is the behaviour behind SliverAppBar(floating: true).',
        Icons.swap_vert,
      ),
      _fhInfoCard(
        'RenderSliverFloatingPersistentHeader',
        'The concrete RenderSliver subclass that implements floating-header '
            'layout logic. It extends RenderSliverPersistentHeader and overrides '
            'performLayout() to track reverse-scroll deltas and reveal the '
            'header proportionally.',
        Icons.layers,
        accent: _fhAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _fhBadge('scroll down', _fhGrey, _fhOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _fhGrey),
                _fhBadge('header hides', _fhAccentDark, _fhOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _fhBadge('scroll up', _fhGreen, _fhOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _fhGreen),
                _fhBadge('header reappears', _fhPrimary, _fhOnPrimary),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Floating vs Pinned vs Scrolling
// ---------------------------------------------------------------------------
Widget _fhSection2Comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('2 · Floating vs Pinned vs Scrolling', Icons.compare_arrows),
      _fhInfoCard(
        'Three header strategies',
        'Flutter provides three persistent header modes: scrolling (scrolls off '
            'and stays off), pinned (stays fixed at the top), and floating '
            '(scrolls off but reappears on reverse scroll).',
        Icons.view_agenda,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                Expanded(flex: 2, child: Text('Mode', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _fhTextDark))),
                Expanded(flex: 2, child: Text('Scroll down', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _fhTextDark))),
                Expanded(flex: 2, child: Text('Scroll up', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _fhTextDark))),
                Expanded(flex: 2, child: Text('Render class', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _fhTextDark))),
              ],
            ),
            Divider(color: _fhDivider, height: 8),
            _fhCompRow('Scrolling', 'Hides', 'Stays hidden', 'Scrolling…', _fhGrey),
            _fhCompRow('Pinned', 'Stays visible', 'Stays visible', 'Pinned…', _fhBlue),
            _fhCompRow('Floating', 'Hides', 'Reappears', 'Floating…', _fhPrimary),
          ],
        ),
      ),
      SizedBox(height: 8),
      _fhInfoCard(
        'Floating + pinned',
        'SliverAppBar can combine floating and pinned to achieve a header that '
            'shows when scrolling up AND stays visible at minExtent when scrolled '
            'down. This uses the floating header layout with an additional minimum '
            'extent constraint.',
        Icons.merge_type,
        accent: _fhPurple,
      ),
    ],
  );
}

Widget _fhCompRow(String mode, String down, String up, String cls, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
            child: Text(mode, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ),
        ),
        Expanded(flex: 2, child: Text(down, style: TextStyle(fontSize: 11, color: _fhTextMedium))),
        Expanded(flex: 2, child: Text(up, style: TextStyle(fontSize: 11, color: _fhTextMedium))),
        Expanded(flex: 2, child: Text(cls, style: TextStyle(fontSize: 10, color: _fhGrey, fontFamily: 'monospace'))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: Layout Protocol
// ---------------------------------------------------------------------------
Widget _fhSection3Layout() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('3 · Layout Protocol', Icons.grid_on),
      _fhInfoCard(
        'SliverConstraints → SliverGeometry',
        'Like all slivers, the floating header receives SliverConstraints from '
            'the viewport and returns a SliverGeometry describing how much space '
            'it consumes, paints, and scrolls.',
        Icons.input,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Layout steps', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 8),
            _fhStepItem(1, 'Receive scrollOffset and overlap from viewport', _fhPrimary),
            _fhStepItem(2, 'Compute effective scroll offset (tracking user delta)', _fhAccent),
            _fhStepItem(3, 'Lay out child with remaining visible extent', _fhGreen),
            _fhStepItem(4, 'Set geometry: paintExtent, layoutExtent, maxScrollObstructionExtent', _fhBlue),
            _fhStepItem(5, 'Viewport positions the sliver and paints accordingly', _fhPurple),
          ],
        ),
      ),
    ],
  );
}

Widget _fhStepItem(int n, String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22, height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text('$n', style: TextStyle(fontSize: 10, color: _fhOnPrimary, fontWeight: FontWeight.w700)),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: _fhTextMedium))),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Geometry Fields
// ---------------------------------------------------------------------------
Widget _fhSection4Geometry() {
  final fields = <Map<String, String>>[
    {'field': 'scrollExtent', 'desc': 'Total scrollable height (maxExtent)'},
    {'field': 'paintExtent', 'desc': 'Currently visible portion of the header'},
    {'field': 'layoutExtent', 'desc': 'Space the header occupies in the layout (pushes content)'},
    {'field': 'maxPaintExtent', 'desc': 'Maximum height the header can paint to (stretch limit)'},
    {'field': 'maxScrollObstructionExtent', 'desc': 'Height that obstructs scrollable area when pinned'},
    {'field': 'hasVisualOverflow', 'desc': 'Whether child is clipped during partial visibility'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('4 · Geometry Fields', Icons.straighten),
      _fhInfoCard(
        'SliverGeometry output',
        'The floating header computes its SliverGeometry dynamically based on '
            'how far the header has been revealed. Key fields control painting, '
            'hit testing, and space allocation.',
        Icons.square_foot,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...fields.map((f) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: _fhSurfaceDark, borderRadius: BorderRadius.circular(4)),
                    child: Text(f['field']!, style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _fhPrimary, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(f['desc']!, style: TextStyle(fontSize: 11, color: _fhTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        height: 170,
        decoration: BoxDecoration(
          color: _fhSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Stack(
          children: [
            // Viewport region
            Positioned(
              left: 16, top: 8,
              child: Text('Viewport', style: TextStyle(fontSize: 10, color: _fhGrey)),
            ),
            // Header partially visible
            Positioned(
              left: 40, top: 30,
              right: 40,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _fhPrimary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _fhPrimary),
                ),
                alignment: Alignment.center,
                child: Text('paintExtent (visible part)', style: TextStyle(fontSize: 10, color: _fhTextDark, fontWeight: FontWeight.w600)),
              ),
            ),
            // Scrolled-off portion
            Positioned(
              left: 40, top: 10,
              right: 40,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: _fhGrey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  border: Border.all(color: _fhGrey.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('scrolled off', style: TextStyle(fontSize: 9, color: _fhGrey)),
              ),
            ),
            // Content below
            Positioned(
              left: 40, top: 80,
              right: 40,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _fhDivider),
                ),
                alignment: Alignment.center,
                child: Text('Scroll content\n(pushed by layoutExtent)', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: _fhGrey)),
              ),
            ),
            // Arrow labels
            Positioned(
              right: 12, top: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _fhBadge('paintExtent', _fhPrimary, _fhOnPrimary),
                  SizedBox(height: 4),
                  _fhBadge('layoutExtent', _fhGreen, _fhOnPrimary),
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
// Section 5: Snap Behaviour
// ---------------------------------------------------------------------------
Widget _fhSection5Snap() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('5 · Snap Behaviour', Icons.swipe_vertical),
      _fhInfoCard(
        'Snap open / snap closed',
        'When snap: true is set on SliverAppBar, the floating header animates '
            'to either fully visible or fully hidden rather than stopping at a '
            'partial position. The render object calls showOnScreen() via the '
            'floating header state to drive the snap animation.',
        Icons.animation,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          children: [
            Text('Snap decision', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fhPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.expand_less, size: 24, color: _fhPrimary),
                        SizedBox(height: 4),
                        Text('> 50% visible', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _fhTextDark)),
                        SizedBox(height: 2),
                        Text('Snap OPEN', style: TextStyle(fontSize: 10, color: _fhPrimary, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fhAccentDark.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.expand_more, size: 24, color: _fhAccentDark),
                        SizedBox(height: 4),
                        Text('< 50% visible', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _fhTextDark)),
                        SizedBox(height: 2),
                        Text('Snap CLOSED', style: TextStyle(fontSize: 10, color: _fhAccentDark, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'midpoint = maxExtent / 2',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _fhTextMedium),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _fhInfoCard(
        'Snap animation',
        'The FloatingHeaderSnapConfiguration provides the vsync and curve for '
            'the snap animation. The render object uses _snapAnimation to smoothly '
            'interpolate the scroll position to the nearest snap point.',
        Icons.speed,
        accent: _fhAccent,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: SliverConstraints Interaction
// ---------------------------------------------------------------------------
Widget _fhSection6Constraints() {
  final constraints = <Map<String, String>>[
    {'name': 'scrollOffset', 'desc': 'How far the sliver base has scrolled from zero'},
    {'name': 'overlap', 'desc': 'Space already painted by preceding pinned slivers'},
    {'name': 'remainingPaintExtent', 'desc': 'Remaining visual space in the viewport'},
    {'name': 'crossAxisExtent', 'desc': 'Width of the viewport (for full-width headers)'},
    {'name': 'cacheOrigin', 'desc': 'Start of the cache area (leading edge)'},
    {'name': 'remainingCacheExtent', 'desc': 'Cache space available beyond visible area'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('6 · SliverConstraints Interaction', Icons.input),
      _fhInfoCard(
        'Constraint inputs',
        'The viewport passes SliverConstraints that tell the sliver how much '
            'space is available and how far it has scrolled. The floating header '
            'uses scrollOffset to determine how much to reveal.',
        Icons.arrow_downward,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...constraints.map((c) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: _fhSurfaceDark, borderRadius: BorderRadius.circular(4)),
                    child: Text(c['name']!, style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _fhPrimary, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(c['desc']!, style: TextStyle(fontSize: 11, color: _fhTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _fhSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Effective scroll offset tracking', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 6),
            Text(
              'The floating header maintains an internal _effectiveScrollOffset. '
              'When the user scrolls DOWN, it increases (header hides). When the '
              'user scrolls UP, it decreases (header reveals). The delta is '
              'computed as the difference between current and previous scrollOffset.',
              style: TextStyle(fontSize: 11, color: _fhTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Stretch & Overscroll
// ---------------------------------------------------------------------------
Widget _fhSection7Stretch() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('7 · Stretch & Overscroll', Icons.unfold_more),
      _fhInfoCard(
        'Stretch mode',
        'When stretch: true is set, overscrolling at the top causes the header '
            'to expand beyond its maxExtent. The render object increases its '
            'child\'s layout height to match the overscroll amount, creating '
            'a pull-to-reveal effect.',
        Icons.open_in_full,
      ),
      _fhInfoCard(
        'Overscroll handling',
        'The floating header treats negative scrollOffset (overscroll at top) '
            'differently from positive scrollOffset. During overscroll the header '
            'is always fully visible and may stretch if configured.',
        Icons.vertical_align_top,
        accent: _fhAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          children: [
            Text('Stretch modes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fhSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _fhPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.photo_size_select_large, size: 24, color: _fhPrimary),
                        SizedBox(height: 4),
                        Text('zoomBackground', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _fhTextDark)),
                        Text('Scale background image', style: TextStyle(fontSize: 9, color: _fhTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fhSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _fhAccent.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.opacity, size: 24, color: _fhAccent),
                        SizedBox(height: 4),
                        Text('fadeTitle', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _fhTextDark)),
                        Text('Dim title on stretch', style: TextStyle(fontSize: 9, color: _fhTextMedium)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _fhSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _fhBlue.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.blur_on, size: 24, color: _fhBlue),
                        SizedBox(height: 4),
                        Text('blurBackground', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _fhTextDark)),
                        Text('Blur on overscroll', style: TextStyle(fontSize: 9, color: _fhTextMedium)),
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

// ---------------------------------------------------------------------------
// Section 8: Header Extent Ranges
// ---------------------------------------------------------------------------
Widget _fhSection8Extents() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('8 · Header Extent Ranges', Icons.height),
      _fhInfoCard(
        'minExtent and maxExtent',
        'The floating header has a minimum and maximum extent. During normal '
            'scrolling, the header\'s child extent transitions between these two '
            'values. minExtent is the collapsed height; maxExtent is the expanded '
            'height.',
        Icons.expand,
      ),
      Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Stack(
          children: [
            // Max extent bar
            Positioned(
              left: 30, top: 20,
              right: 100,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: _fhPrimary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _fhPrimary.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text('maxExtent (200px)', style: TextStyle(fontSize: 11, color: _fhTextDark, fontWeight: FontWeight.w600)),
              ),
            ),
            // Min extent bar
            Positioned(
              left: 30, top: 100,
              right: 180,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _fhAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _fhAccent.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text('minExtent (56px)', style: TextStyle(fontSize: 11, color: _fhTextDark, fontWeight: FontWeight.w600)),
              ),
            ),
            // Labels
            Positioned(
              right: 12, top: 35,
              child: _fhBadge('expanded', _fhPrimary, _fhOnPrimary),
            ),
            Positioned(
              right: 12, top: 108,
              child: _fhBadge('collapsed', _fhAccent, _fhOnPrimary),
            ),
            // Info
            Positioned(
              left: 30, bottom: 12,
              child: Text(
                'Header interpolates between min and max based on scroll position',
                style: TextStyle(fontSize: 10, color: _fhGrey, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _fhSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Extent formula', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 6),
            _fhCode('childExtent = max(minExtent, maxExtent - effectiveScrollOffset)'),
            SizedBox(height: 4),
            _fhCode('paintExtent = clamp(childExtent, 0, remainingPaintExtent)'),
            SizedBox(height: 6),
            Text(
              'The child is sized to childExtent. The sliver\'s visible portion '
              '(paintExtent) is clamped to available viewport space.',
              style: TextStyle(fontSize: 11, color: _fhTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Integration with SliverAppBar
// ---------------------------------------------------------------------------
Widget _fhSection9Integration() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _fhSectionTitle('9 · Integration with SliverAppBar', Icons.web),
      _fhInfoCard(
        'SliverAppBar(floating: true)',
        'Setting floating: true on SliverAppBar causes _SliverAppBarDelegate '
            'to report shouldRebuild and the scroll view to use '
            'RenderSliverFloatingPersistentHeader. The header rebuilds with '
            'SliverAppBarDelegate.build() during layout.',
        Icons.widgets,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Widget → Render chain', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _fhTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _fhBadge('SliverAppBar', _fhPrimary, _fhOnPrimary)),
                Icon(Icons.arrow_forward, size: 14, color: _fhGrey),
                Expanded(child: _fhBadge('SliverPersistentHeader', _fhAccent, _fhOnPrimary)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _fhBadge('_SliverFloatingHeader', _fhBlue, _fhOnPrimary)),
                Icon(Icons.arrow_forward, size: 14, color: _fhGrey),
                Expanded(child: _fhBadge('RenderSliverFloating…', _fhGreen, _fhOnPrimary)),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _fhInfoCard(
        'CustomScrollView usage',
        'The floating header is always used within a CustomScrollView (or '
            'NestedScrollView). It participates in the sliver protocol alongside '
            'SliverList, SliverGrid, and other slivers.',
        Icons.view_list,
        accent: _fhGreen,
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_fhPrimary.withValues(alpha: 0.08), _fhAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _fhPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.view_day, size: 32, color: _fhPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverFloatingPersistentHeader',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _fhTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Implements the floating-header layout—the render object reappears '
              'as soon as the user reverses scroll direction, with optional snap '
              'and stretch behaviour for rich app-bar experiences.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _fhTextMedium, height: 1.4),
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
              colors: [_fhPrimary, _fhPrimaryLight],
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
                  Icon(Icons.view_day, color: _fhOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverFloating\nPersistentHeader',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _fhOnPrimary,
                        letterSpacing: 0.3,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Floating header sliver — reappears on reverse scroll',
                style: TextStyle(fontSize: 12, color: _fhOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _fhSection1Overview(),
        _fhSection2Comparison(),
        _fhSection3Layout(),
        _fhSection4Geometry(),
        _fhSection5Snap(),
        _fhSection6Constraints(),
        _fhSection7Stretch(),
        _fhSection8Extents(),
        _fhSection9Integration(),

        SizedBox(height: 24),
      ],
    ),
  );
}
