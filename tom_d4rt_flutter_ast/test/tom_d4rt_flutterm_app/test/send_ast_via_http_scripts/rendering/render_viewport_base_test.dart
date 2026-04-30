// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderViewportBase
//
// RenderViewportBase is the abstract base class for all viewport render
// objects. It manages the collection of slivers, coordinates their layout
// in response to a ViewportOffset (scroll position), handles cache extent,
// and orchestrates clipping. The concrete subclass RenderViewport is what
// CustomScrollView and most scroll views use.
//
// This demo visualises:
//   1. Overview — what a viewport does
//   2. Sliver management — how slivers are organised
//   3. ViewportOffset — scroll position integration
//   4. Layout protocol — the viewport layout algorithm
//   5. Cache extent — preparing off-screen content
//   6. Axes and growth direction — forward/reverse slivers
//   7. Clipping and painting
//   8. Visual demo — a viewport with multiple slivers
//   9. Concrete subclasses and summary
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Slate / Graphite
// ---------------------------------------------------------------------------
const Color _vbPrimary = Color(0xFF455A64);
const Color _vbPrimaryLight = Color(0xFF78909C);
const Color _vbAccent = Color(0xFF263238);
const Color _vbAccentLight = Color(0xFFCFD8DC);
const Color _vbSurface = Color(0xFFECEFF1);
const Color _vbSurfaceDark = Color(0xFFCFD8DC);
const Color _vbOnPrimary = Color(0xFFFFFFFF);
const Color _vbTextDark = Color(0xFF263238);
const Color _vbTextMedium = Color(0xFF37474F);
const Color _vbDivider = Color(0xFF90A4AE);
const Color _vbGreen = Color(0xFF2E7D32);
const Color _vbBlue = Color(0xFF1565C0);
const Color _vbOrange = Color(0xFFE65100);
const Color _vbTeal = Color(0xFF00695C);
const Color _vbGrey = Color(0xFF757575);
const Color _vbAmber = Color(0xFFF57F17);
const Color _vbPurple = Color(0xFF6A1B9A);
const Color _vbRed = Color(0xFFC62828);
const Color _vbIndigo = Color(0xFF283593);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _vbSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _vbPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _vbTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _vbDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _vbBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _vbInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _vbPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _vbSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _vbTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _vbTextMedium, height: 1.4)),
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
Widget _vbCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _vbSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _vbAccent, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _vbSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _vbSectionTitle('1 · Viewport Overview', Icons.crop_free),
      _vbInfoCard(
        'What is RenderViewportBase?',
        'The abstract base for render objects that display a subset of '
            'their children within a scrollable region. It receives a scroll '
            'offset and decides which slivers are visible, how much of each '
            'is painted, and manages the cache region.',
        Icons.panorama_wide_angle,
      ),
      _vbInfoCard(
        'The window into scrollable content',
        'Think of the viewport as a window that slides over a long strip '
            'of slivers. The scroll position determines where the window is. '
            'Only slivers within (and near) the window are laid out.',
        Icons.window,
        accent: _vbAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Viewport position in the tree', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _vbTextDark)),
            SizedBox(height: 8),
            ...[
              {'depth': 0, 'name': 'ScrollView (widget)', 'color': _vbGrey},
              {'depth': 1, 'name': 'Scrollable + ScrollController', 'color': _vbBlue},
              {'depth': 2, 'name': 'Viewport (creates RenderViewport)', 'color': _vbPrimary},
              {'depth': 3, 'name': 'RenderViewport extends RenderViewportBase', 'color': _vbAccent},
              {'depth': 4, 'name': 'SliverList, SliverGrid, SliverAppBar...', 'color': _vbGreen},
            ].map((e) => Padding(
              padding: EdgeInsets.only(left: (e['depth'] as int) * 16.0, bottom: 4),
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: e['color'] as Color, shape: BoxShape.circle)),
                  SizedBox(width: 6),
                  Flexible(child: Text(e['name'] as String, style: TextStyle(fontSize: 11, color: e['color'] as Color, fontWeight: FontWeight.w600))),
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
// Section 2: Sliver Management
// ---------------------------------------------------------------------------
Widget _vbSection2SliverManagement() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('2 · Sliver Management', Icons.table_rows),
      _vbInfoCard(
        'Managing a sequence of slivers',
        'The viewport maintains a linked list of child slivers. Each sliver '
            'reports its geometry (scrollExtent, paintExtent, etc.) and the '
            'viewport positions slivers sequentially along the scroll axis.',
        Icons.list,
      ),
      Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Stack(
          children: [
            // Scroll axis arrow
            Positioned(
              left: 10, top: 16, bottom: 16,
              child: Container(
                width: 2,
                color: _vbGrey.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              left: 5, bottom: 6,
              child: Icon(Icons.arrow_downward, size: 14, color: _vbGrey),
            ),
            Positioned(
              left: 2, top: 4,
              child: Text('scroll', style: TextStyle(fontSize: 8, color: _vbGrey)),
            ),
            // Slivers
            ...[
              {'top': 14.0, 'height': 36.0, 'label': 'SliverAppBar', 'color': _vbBlue},
              {'top': 56.0, 'height': 28.0, 'label': 'SliverToBoxAdapter', 'color': _vbTeal},
              {'top': 90.0, 'height': 44.0, 'label': 'SliverList', 'color': _vbOrange},
              {'top': 140.0, 'height': 28.0, 'label': 'SliverGrid', 'color': _vbPurple},
            ].map((s) => Positioned(
              left: 24, right: 12,
              top: s['top'] as double,
              child: Container(
                height: s['height'] as double,
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text(s['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: s['color'] as Color)),
              ),
            )),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: ViewportOffset
// ---------------------------------------------------------------------------
Widget _vbSection3Offset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('3 · ViewportOffset (Scroll Position)', Icons.swap_vert),
      _vbInfoCard(
        'The link to scroll position',
        'RenderViewportBase takes a ViewportOffset — typically a '
            'ScrollPosition. This tells the viewport where the user has '
            'scrolled to. The viewport listens for changes and triggers '
            'relayout when the offset changes.',
        Icons.link,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ViewportOffset provides', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _vbTextDark)),
            SizedBox(height: 8),
            ...[
              {'name': 'pixels', 'desc': 'Current scroll offset in logical pixels', 'color': _vbBlue},
              {'name': 'applyViewportDimension()', 'desc': 'Informs the offset of the viewport size', 'color': _vbGreen},
              {'name': 'applyContentDimensions()', 'desc': 'Informs the min/max scroll extent', 'color': _vbOrange},
              {'name': 'correctBy()', 'desc': 'Adjusts the scroll offset during layout', 'color': _vbPurple},
              {'name': 'userScrollDirection', 'desc': 'Forward, reverse, or idle', 'color': _vbTeal},
            ].map((p) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (p['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: p['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 120, child: _vbCode(p['name'] as String, color: p['color'] as Color)),
                  SizedBox(width: 8),
                  Expanded(child: Text(p['desc'] as String, style: TextStyle(fontSize: 10, color: _vbTextMedium))),
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
// Section 4: Layout Protocol
// ---------------------------------------------------------------------------
Widget _vbSection4Layout() {
  final steps = <Map<String, dynamic>>[
    {'step': '1', 'label': 'Determine viewport dimensions', 'detail': 'Size from parent constraints → main & cross axis sizes', 'color': _vbBlue},
    {'step': '2', 'label': 'Read scroll offset from ViewportOffset', 'detail': 'offset.pixels tells us where we are scrolled to', 'color': _vbPrimary},
    {'step': '3', 'label': 'Iterate through slivers', 'detail': 'Each sliver receives SliverConstraints and returns SliverGeometry', 'color': _vbGreen},
    {'step': '4', 'label': 'Accumulate scroll extents', 'detail': 'Sum up scrollExtent from each sliver to find total content size', 'color': _vbOrange},
    {'step': '5', 'label': 'Track remaining paint extent', 'detail': 'Decrease remaining space as slivers consume it', 'color': _vbPurple},
    {'step': '6', 'label': 'Report content dimensions', 'detail': 'Tell ViewportOffset the min/max scroll extents', 'color': _vbTeal},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('4 · Viewport Layout Algorithm', Icons.calculate),
      _vbInfoCard(
        'How the viewport lays out slivers',
        'The viewport iterates through its slivers, passing sliver constraints '
            'to each. Each sliver reports how much scroll extent it consumes '
            'and how much paint extent it uses. The viewport accumulates these.',
        Icons.format_list_numbered,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
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
                  child: Text(s['step'] as String, style: TextStyle(fontSize: 10, color: _vbOnPrimary, fontWeight: FontWeight.w700)),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s['label'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: s['color'] as Color)),
                      Text(s['detail'] as String, style: TextStyle(fontSize: 10, color: _vbTextMedium)),
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
// Section 5: Cache Extent
// ---------------------------------------------------------------------------
Widget _vbSection5CacheExtent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('5 · Cache Extent', Icons.cached),
      _vbInfoCard(
        'Pre-building off-screen content',
        'The viewport has a cacheExtent — extra pixels beyond the visible '
            'area where slivers are still laid out (but not painted). This '
            'ensures smooth scrolling by pre-building upcoming content.',
        Icons.speed,
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Stack(
          children: [
            // Cache region above
            Positioned(
              left: 20, top: 10, right: 20,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: _vbAmber.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                  border: Border.all(color: _vbAmber.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cache region (above)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: _vbAmber)),
                    Text('Built but not painted', style: TextStyle(fontSize: 8, color: _vbGrey)),
                  ],
                ),
              ),
            ),
            // Visible region
            Positioned(
              left: 20, top: 50, right: 20,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: _vbGreen.withValues(alpha: 0.08),
                  border: Border.all(color: _vbGreen, width: 2),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility, color: _vbGreen, size: 20),
                    Text('Visible viewport region', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _vbGreen)),
                    Text('Slivers are laid out AND painted', style: TextStyle(fontSize: 8, color: _vbTextMedium)),
                  ],
                ),
              ),
            ),
            // Cache region below
            Positioned(
              left: 20, top: 154, right: 20,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: _vbAmber.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                  border: Border.all(color: _vbAmber.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Cache region (below)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: _vbAmber)),
                    Text('Built but not painted', style: TextStyle(fontSize: 8, color: _vbGrey)),
                  ],
                ),
              ),
            ),
            // Annotations
            Positioned(
              right: 8, top: 16,
              child: Text('cacheExtent', style: TextStyle(fontSize: 8, color: _vbAmber, fontWeight: FontWeight.w600)),
            ),
            Positioned(
              right: 8, top: 92,
              child: Text('viewport', style: TextStyle(fontSize: 8, color: _vbGreen, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      SizedBox(height: 4),
      _vbInfoCard(
        'Default cache extent',
        'The default cacheExtent is 250.0 pixels in each direction. '
            'You can customise it via CustomScrollView(cacheExtent: ...). '
            'Larger values mean smoother scrolling but more memory usage.',
        Icons.settings,
        accent: _vbGrey,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Axes and Growth Direction
// ---------------------------------------------------------------------------
Widget _vbSection6Axes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('6 · Axes & Growth Direction', Icons.straighten),
      _vbInfoCard(
        'Main axis and cross axis',
        'The viewport scrolls along its main axis (vertical by default). '
            'Slivers lay out along this axis. The cross axis is perpendicular. '
            'The axisDirection property defines which direction is "forward".',
        Icons.compare_arrows,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Growth directions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _vbTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _vbBlue.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _vbBlue.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _vbBadge('AxisDirection.down', _vbBlue, _vbOnPrimary),
                        SizedBox(height: 6),
                        Icon(Icons.arrow_downward, size: 24, color: _vbBlue),
                        Text('Most common', style: TextStyle(fontSize: 9, color: _vbBlue)),
                        Text('GrowthDirection.forward', style: TextStyle(fontSize: 8, color: _vbGrey)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _vbOrange.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _vbOrange.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        _vbBadge('AxisDirection.right', _vbOrange, _vbOnPrimary),
                        SizedBox(height: 6),
                        Icon(Icons.arrow_forward, size: 24, color: _vbOrange),
                        Text('Horizontal', style: TextStyle(fontSize: 9, color: _vbOrange)),
                        Text('GrowthDirection.forward', style: TextStyle(fontSize: 8, color: _vbGrey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _vbPurple.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _vbPurple, width: 3)),
              ),
              child: Text(
                'RenderViewport supports center and anchor for bidirectional scrolling — '
                    'slivers before the center grow in the reverse direction.',
                style: TextStyle(fontSize: 10, color: _vbTextMedium),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Clipping and Painting
// ---------------------------------------------------------------------------
Widget _vbSection7Clipping() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('7 · Clipping & Painting', Icons.content_cut),
      _vbInfoCard(
        'Clipping the visible region',
        'The viewport clips its children to its own bounds. Slivers that '
            'extend beyond the viewport edges are clipped, creating the '
            'illusion of content scrolling behind a window.',
        Icons.crop,
      ),
      _vbInfoCard(
        'Painting order and overlaps',
        'Slivers are painted in the order they appear in the child list, '
            'which means later slivers paint on top of earlier ones. '
            'SliverAppBar uses this to overlap onto the first SliverList.',
        Icons.layers,
        accent: _vbAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clip behaviour options', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _vbTextDark)),
            SizedBox(height: 8),
            ...[
              {'value': 'Clip.hardEdge', 'desc': 'Sharp rectangular clip (cheapest)', 'color': _vbGreen},
              {'value': 'Clip.antiAlias', 'desc': 'Smooth clip edges (moderate cost)', 'color': _vbBlue},
              {'value': 'Clip.antiAliasWithSaveLayer', 'desc': 'Full save layer (expensive, rare)', 'color': _vbOrange},
              {'value': 'Clip.none', 'desc': 'No clipping — for debugging only', 'color': _vbRed},
            ].map((c) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (c['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: c['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 130, child: _vbCode(c['value'] as String, color: c['color'] as Color)),
                  SizedBox(width: 8),
                  Expanded(child: Text(c['desc'] as String, style: TextStyle(fontSize: 10, color: _vbTextMedium))),
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
Widget _vbSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('8 · Visual Demo – Viewport in Action', Icons.preview),
      _vbInfoCard(
        'A CustomScrollView is a viewport with slivers',
        'Below is a live CustomScrollView. It creates a RenderViewport '
            'that manages SliverAppBar, SliverToBoxAdapter, SliverList, '
            'and SliverGrid — each a sliver child of the viewport.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _vbSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Row(
                children: [
                  Text('CustomScrollView → RenderViewport', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _vbTextDark)),
                  SizedBox(width: 6),
                  _vbBadge('4 slivers', _vbPrimary, _vbOnPrimary),
                ],
              ),
            ),
            SizedBox(
              height: 360,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    // SliverAppBar
                    SliverAppBar(
                      backgroundColor: _vbAccent,
                      expandedHeight: 90,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Viewport Demo', style: TextStyle(fontSize: 13)),
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [_vbPrimary, _vbAccent]),
                          ),
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter — info panel
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _vbTeal.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _vbTeal.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, size: 16, color: _vbTeal),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'This viewport manages the AppBar, this panel, the list, and the grid below.',
                                style: TextStyle(fontSize: 10, color: _vbTeal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SliverList
                    SliverList.builder(
                      itemCount: 8,
                      itemBuilder: (ctx, i) => Container(
                        height: 42,
                        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: i % 2 == 0 ? Colors.white : _vbSurface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _vbDivider.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                color: _vbBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Text('${i + 1}', style: TextStyle(fontSize: 10, color: _vbBlue, fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 8),
                            Text('SliverList item ${i + 1}', style: TextStyle(fontSize: 11, color: _vbTextDark)),
                          ],
                        ),
                      ),
                    ),
                    // SliverGrid
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _vbPrimary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Grid section', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _vbPrimary)),
                      ),
                    ),
                    SliverGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1.4,
                      children: List.generate(9, (i) => Container(
                        decoration: BoxDecoration(
                          color: _vbPurple.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _vbPurple.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.grid_view, size: 14, color: _vbPurple),
                            Text('Grid ${i + 1}', style: TextStyle(fontSize: 9, color: _vbTextMedium)),
                          ],
                        ),
                      )),
                    ),
                    // Footer
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _vbGrey.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text('End of scrollable content', style: TextStyle(fontSize: 10, color: _vbGrey)),
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
// Section 9: Summary
// ---------------------------------------------------------------------------
Widget _vbSection9Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _vbSectionTitle('9 · Subclasses & Summary', Icons.menu_book),
      _vbInfoCard(
        'Concrete viewport subclasses',
        'RenderViewport is the main concrete subclass — used by '
            'CustomScrollView, ListView, GridView, etc. '
            'RenderShrinkWrappingViewport is a variant that sizes itself '
            'to the total extent of its children instead of filling the parent.',
        Icons.account_tree,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              color: _vbSurface,
              child: Row(
                children: [
                  SizedBox(width: 100, child: Text('Property', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _vbTextDark))),
                  Expanded(child: Text('RenderViewport', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _vbPrimary))),
                  Expanded(child: Text('ShrinkWrapping', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _vbOrange))),
                ],
              ),
            ),
            ...[
              {'prop': 'Sizing', 'vp': 'Fills parent', 'sw': 'Sizes to children'},
              {'prop': 'ScrollExtent', 'vp': 'Reported to offset', 'sw': 'Computed internally'},
              {'prop': 'UsedBy', 'vp': 'CustomScrollView', 'sw': 'ShrinkWrapping views'},
              {'prop': 'Cache extent', 'vp': 'Yes', 'sw': 'Yes'},
              {'prop': 'Center/anchor', 'vp': 'Yes', 'sw': 'No'},
              {'prop': 'Performance', 'vp': 'Optimal', 'sw': 'May be slower'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _vbDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 100, child: Text(r['prop']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _vbTextDark))),
                  Expanded(child: Text(r['vp']!, style: TextStyle(fontSize: 10, color: _vbPrimary))),
                  Expanded(child: Text(r['sw']!, style: TextStyle(fontSize: 10, color: _vbOrange))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbDivider),
        ),
        child: Column(
          children: [
            Text('Quick reference', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _vbTextDark)),
            SizedBox(height: 6),
            ...<Map<String, String>>[
              {'label': 'Base class', 'value': 'RenderViewportBase'},
              {'label': 'Concrete class', 'value': 'RenderViewport'},
              {'label': 'Widget', 'value': 'Viewport / CustomScrollView'},
              {'label': 'Input', 'value': 'ViewportOffset (scroll position)'},
              {'label': 'Children', 'value': 'Linked list of sliver render objects'},
              {'label': 'Cache extent', 'value': '250.0px default (each direction)'},
              {'label': 'Clip', 'value': 'Clip.hardEdge default'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _vbDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 100, child: Text(r['label']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _vbTextDark))),
                  Expanded(child: Text(r['value']!, style: TextStyle(fontSize: 10, color: _vbPrimary, fontWeight: FontWeight.w600))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_vbPrimary.withValues(alpha: 0.08), _vbAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vbPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.crop_free, size: 32, color: _vbPrimary),
            SizedBox(height: 8),
            Text(
              'RenderViewportBase',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _vbTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The abstract foundation for all viewports — managing slivers, '
              'scroll positions, cache extents, and clipping to create '
              'the scrolling experience.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _vbTextMedium, height: 1.4),
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
              colors: [_vbPrimary, _vbAccent],
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
                  Icon(Icons.crop_free, color: _vbOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderViewportBase',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _vbOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'The abstract foundation of all viewport render objects',
                style: TextStyle(fontSize: 12, color: _vbOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _vbSection1Overview(),
        _vbSection2SliverManagement(),
        _vbSection3Offset(),
        _vbSection4Layout(),
        _vbSection5CacheExtent(),
        _vbSection6Axes(),
        _vbSection7Clipping(),
        _vbSection8Demo(),
        _vbSection9Summary(),

        SizedBox(height: 24),
      ],
    ),
  );
}
