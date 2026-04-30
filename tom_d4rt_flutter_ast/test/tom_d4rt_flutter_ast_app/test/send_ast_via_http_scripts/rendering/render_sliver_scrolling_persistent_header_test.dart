// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverScrollingPersistentHeader
//
// RenderSliverScrollingPersistentHeader is the simplest persistent header
// subclass. Unlike pinned headers, a scrolling header scrolls OFF screen
// with the content. It only appears when the user is at (or near) the top
// of the scroll view.
//
// It still compresses from maxExtent to minExtent as the user scrolls,
// but once it has fully compressed, it continues to scroll away. This
// makes it ideal for introductory content that should not permanently
// occupy viewport space.
//
// This demo visualises:
//   1. Overview — the scrolling header concept
//   2. Scrolling mechanics — how it disappears
//   3. Geometry differences from pinned
//   4. When to use scrolling headers
//   5. Comparison: scrolling vs pinned behaviour flow
//   6. SliverPersistentHeader(pinned: false) usage
//   7. Combining scrolling headers with other slivers
//   8. Visual demo with live scrolling header
//   9. Common pitfalls and tips
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Forest / Moss
// ---------------------------------------------------------------------------
const Color _shPrimary = Color(0xFF1B5E20);
const Color _shPrimaryLight = Color(0xFF2E7D32);
const Color _shAccent = Color(0xFF43A047);
const Color _shAccentLight = Color(0xFFA5D6A7);
const Color _shSurface = Color(0xFFE8F5E9);
const Color _shSurfaceDark = Color(0xFFC8E6C9);
const Color _shOnPrimary = Color(0xFFFFFFFF);
const Color _shTextDark = Color(0xFF1B5E20);
const Color _shTextMedium = Color(0xFF4E6E50);
const Color _shDivider = Color(0xFFA5D6A7);
const Color _shBlue = Color(0xFF1565C0);
const Color _shOrange = Color(0xFFE65100);
const Color _shTeal = Color(0xFF00695C);
const Color _shGrey = Color(0xFF757575);
const Color _shAmber = Color(0xFFF57F17);
const Color _shPurple = Color(0xFF6A1B9A);
const Color _shRed = Color(0xFFC62828);
const Color _shIndigo = Color(0xFF283593);
const Color _shCyan = Color(0xFF00838F);

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
// Helper: code snippet
// ---------------------------------------------------------------------------
Widget _shCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _shSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _shPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _shSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shSectionTitle('1 · Scrolling Header Overview', Icons.swap_vert),
      _shInfoCard(
        'What is RenderSliverScrollingPersistentHeader?',
        'A concrete subclass of RenderSliverPersistentHeader where the '
            'header scrolls off screen with the content. It compresses from '
            'maxExtent to minExtent, then continues to scroll away. It never '
            'pins or floats back.',
        Icons.vertical_align_bottom,
      ),
      _shInfoCard(
        'Key characteristic',
        'This is the simplest persistent header. It behaves like a regular '
            'sliver with a variable size. Once scrolled past, the user must '
            'scroll all the way back to the top to see it again.',
        Icons.info,
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
            Text('Header life cycle', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _shTextDark)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.unfold_more, size: 20, color: _shPrimary),
                    SizedBox(height: 4),
                    _shBadge('Expanded', _shPrimary, _shOnPrimary),
                    SizedBox(height: 2),
                    Text('at top', style: TextStyle(fontSize: 9, color: _shTextMedium)),
                  ],
                ),
                Icon(Icons.arrow_forward, size: 14, color: _shGrey),
                Column(
                  children: [
                    Icon(Icons.unfold_less, size: 20, color: _shAmber),
                    SizedBox(height: 4),
                    _shBadge('Compressed', _shAmber, _shOnPrimary),
                    SizedBox(height: 2),
                    Text('shrinking', style: TextStyle(fontSize: 9, color: _shTextMedium)),
                  ],
                ),
                Icon(Icons.arrow_forward, size: 14, color: _shGrey),
                Column(
                  children: [
                    Icon(Icons.keyboard_arrow_up, size: 20, color: _shRed),
                    SizedBox(height: 4),
                    _shBadge('Scrolled off', _shRed, _shOnPrimary),
                    SizedBox(height: 2),
                    Text('gone', style: TextStyle(fontSize: 9, color: _shTextMedium)),
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

// ---------------------------------------------------------------------------
// Section 2: Scrolling Mechanics
// ---------------------------------------------------------------------------
Widget _shSection2Mechanics() {
  final phases = <Map<String, dynamic>>[
    {'phase': 'Compression', 'range': 'scrollOffset: 0 → (max-min)', 'desc': 'Header shrinks from maxExtent to minExtent', 'color': _shPrimary, 'height': 50.0},
    {'phase': 'Scroll-out', 'range': 'scrollOffset: (max-min) → max', 'desc': 'At minExtent, header slides up and off screen', 'color': _shAmber, 'height': 40.0},
    {'phase': 'Off-screen', 'range': 'scrollOffset > maxExtent', 'desc': 'Header fully out of view, next sliver at top', 'color': _shRed, 'height': 30.0},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('2 · Scrolling Mechanics', Icons.animation),
      _shInfoCard(
        'Two-phase disappearance',
        'Phase 1: the header compresses from maxExtent to minExtent '
            '(same as pinned). Phase 2: instead of staying pinned, the '
            'header continues to scroll up, sliding out of the viewport. '
            'This two-phase behaviour distinguishes it from pinned headers.',
        Icons.straighten,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scroll phases', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _shTextDark)),
            SizedBox(height: 8),
            ...phases.map((p) => Container(
              height: p['height'] as double,
              margin: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: (p['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: (p['color'] as Color).withValues(alpha: 0.4)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  _shBadge(p['phase'] as String, p['color'] as Color, _shOnPrimary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['range'] as String, style: TextStyle(fontSize: 9, color: p['color'] as Color, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                        Text(p['desc'] as String, style: TextStyle(fontSize: 10, color: _shTextMedium)),
                      ],
                    ),
                  ),
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
// Section 3: Geometry Differences from Pinned
// ---------------------------------------------------------------------------
Widget _shSection3Geometry() {
  final diffs = <Map<String, String>>[
    {'field': 'paintOrigin', 'pinned': '0 (always at top)', 'scrolling': 'Negative (slides up)'},
    {'field': 'layoutExtent', 'pinned': 'max(min, max - offset)', 'scrolling': 'max(0, max - offset)'},
    {'field': 'visible?', 'pinned': 'Always', 'scrolling': 'Only when offset < max'},
    {'field': 'overlapsContent', 'pinned': 'Yes when content beneath', 'scrolling': 'No (not pinned)'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('3 · Geometry: Scrolling vs Pinned', Icons.grid_on),
      _shInfoCard(
        'The key difference in SliverGeometry',
        'Pinned headers set paintOrigin to 0, keeping them at the viewport '
            'edge. Scrolling headers let paintOrigin go negative, which means '
            'the header slides up and out. layoutExtent can reach zero, making '
            'the header consume no space.',
        Icons.compare_arrows,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(color: _shSurface, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('Field', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _shTextDark))),
                  Expanded(child: Text('Pinned', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _shBlue))),
                  Expanded(child: Text('Scrolling', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _shPrimary))),
                ],
              ),
            ),
            ...diffs.map((d) => Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _shDivider.withValues(alpha: 0.3)))),
              child: Row(
                children: [
                  SizedBox(width: 80, child: _shCode(d['field']!, color: _shTextDark)),
                  Expanded(child: Text(d['pinned']!, style: TextStyle(fontSize: 10, color: _shBlue))),
                  Expanded(child: Text(d['scrolling']!, style: TextStyle(fontSize: 10, color: _shPrimary))),
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
// Section 4: When to Use Scrolling Headers
// ---------------------------------------------------------------------------
Widget _shSection4WhenToUse() {
  final useCases = <Map<String, dynamic>>[
    {'case': 'Page introduction', 'desc': 'Hero image or welcome text that should not occupy permanent space', 'icon': Icons.article, 'color': _shPrimary},
    {'case': 'Section headers in lists', 'desc': 'Grouping headers that scroll naturally with their section', 'icon': Icons.list, 'color': _shTeal},
    {'case': 'Promotional banners', 'desc': 'Banners that show once and scroll away, not blocking content', 'icon': Icons.campaign, 'color': _shOrange},
    {'case': 'Form headers', 'desc': 'Instructions above a form that disappear as user focuses on fields', 'icon': Icons.description, 'color': _shPurple},
    {'case': 'Timeline markers', 'desc': 'Date headers in a timeline that scroll with the timeline content', 'icon': Icons.schedule, 'color': _shIndigo},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('4 · When to Use Scrolling Headers', Icons.help),
      _shInfoCard(
        'Choose scrolling when...',
        'Use a scrolling header when the header content is important initially '
            'but should not consume viewport space permanently. If the user needs '
            'constant access to the header, use pinned. If it should reappear on '
            'reverse scroll, use floating.',
        Icons.question_mark,
      ),
      ...useCases.map((u) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: u['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(u['icon'] as IconData, size: 18, color: u['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u['case'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
                  SizedBox(height: 2),
                  Text(u['desc'] as String, style: TextStyle(fontSize: 11, color: _shTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Behaviour Flow Comparison
// ---------------------------------------------------------------------------
Widget _shSection5FlowComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('5 · Behaviour Flow Comparison', Icons.compare),
      _shInfoCard(
        'Side-by-side scroll flow',
        'Visualising what happens at each scroll phase helps understand the '
            'fundamental difference: pinned headers stop at minExtent and stay, '
            'scrolling headers keep moving and leave the viewport.',
        Icons.view_column,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pinned flow
            Expanded(
              child: Column(
                children: [
                  _shBadge('Pinned', _shBlue, _shOnPrimary),
                  SizedBox(height: 6),
                  ...[
                    {'label': 'Expanded', 'color': _shBlue, 'h': 40.0},
                    {'label': 'Compressing...', 'color': _shBlue, 'h': 32.0},
                    {'label': 'At minExtent', 'color': _shBlue, 'h': 24.0},
                    {'label': 'Stays pinned ✓', 'color': _shBlue, 'h': 24.0},
                    {'label': 'Still pinned ✓', 'color': _shBlue, 'h': 24.0},
                  ].map((s) => Container(
                    height: s['h'] as double,
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: (s['color'] as Color).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
                    ),
                    alignment: Alignment.center,
                    child: Text(s['label'] as String, style: TextStyle(fontSize: 9, color: s['color'] as Color, fontWeight: FontWeight.w600)),
                  )),
                ],
              ),
            ),
            SizedBox(width: 8),
            // Scrolling flow
            Expanded(
              child: Column(
                children: [
                  _shBadge('Scrolling', _shPrimary, _shOnPrimary),
                  SizedBox(height: 6),
                  ...[
                    {'label': 'Expanded', 'color': _shPrimary, 'h': 40.0},
                    {'label': 'Compressing...', 'color': _shAmber, 'h': 32.0},
                    {'label': 'At minExtent', 'color': _shAmber, 'h': 24.0},
                    {'label': 'Sliding off ↑', 'color': _shRed, 'h': 18.0},
                    {'label': 'Gone', 'color': _shGrey, 'h': 14.0},
                  ].map((s) => Container(
                    height: s['h'] as double,
                    margin: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: (s['color'] as Color).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
                    ),
                    alignment: Alignment.center,
                    child: Text(s['label'] as String, style: TextStyle(fontSize: 9, color: s['color'] as Color, fontWeight: FontWeight.w600)),
                  )),
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
// Section 6: Usage with SliverPersistentHeader
// ---------------------------------------------------------------------------
Widget _shSection6Usage() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('6 · SliverPersistentHeader(pinned: false)', Icons.code),
      _shInfoCard(
        'Widget-level creation',
        'To create a scrolling persistent header, use SliverPersistentHeader '
            'with pinned: false (default) and floating: false (default). The '
            'widget layer then creates a RenderSliverScrollingPersistentHeader '
            'internally.',
        Icons.widgets,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Configuration matrix', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _shTextDark)),
            SizedBox(height: 8),
            ...[
              {'pinned': 'true', 'floating': 'false', 'result': 'Pinned', 'render': 'RenderSliverPinnedPersistentHeader', 'color': _shBlue},
              {'pinned': 'false', 'floating': 'true', 'result': 'Floating', 'render': 'RenderSliverFloatingPersistentHeader', 'color': _shTeal},
              {'pinned': 'false', 'floating': 'false', 'result': 'Scrolling ←', 'render': 'RenderSliverScrollingPersistentHeader', 'color': _shPrimary},
            ].map((cfg) => Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (cfg['color'] as Color).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border(left: BorderSide(color: cfg['color'] as Color, width: 3)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('pinned: ', style: TextStyle(fontSize: 9, color: _shTextMedium)),
                          _shCode(cfg['pinned'] as String),
                          SizedBox(width: 8),
                          Text('floating: ', style: TextStyle(fontSize: 9, color: _shTextMedium)),
                          _shCode(cfg['floating'] as String),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(cfg['render'] as String, style: TextStyle(fontSize: 9, color: _shTextMedium, fontFamily: 'monospace')),
                    ],
                  ),
                  Spacer(),
                  _shBadge(cfg['result'] as String, cfg['color'] as Color, _shOnPrimary),
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
// Section 7: Combining with Other Slivers
// ---------------------------------------------------------------------------
Widget _shSection7Combining() {
  final patterns = <Map<String, dynamic>>[
    {
      'pattern': 'Scrolling header + pinned tab bar',
      'desc': 'Intro section scrolls away, tab bar underneath stays pinned',
      'icon': Icons.tab,
      'color': _shPrimary,
    },
    {
      'pattern': 'Multiple scrolling headers',
      'desc': 'Sectioned list with scrolling headers between SliverList groups',
      'icon': Icons.view_list,
      'color': _shTeal,
    },
    {
      'pattern': 'Scrolling header + SliverAppBar',
      'desc': 'SliverAppBar (pinned) with an additional scrolling promotional area below',
      'icon': Icons.web,
      'color': _shOrange,
    },
    {
      'pattern': 'Scrolling header + SliverGrid',
      'desc': 'Category title header scrolls away, grid of items follows',
      'icon': Icons.grid_view,
      'color': _shPurple,
    },
    {
      'pattern': 'Animated scrolling header',
      'desc': 'Header with parallax or fade effects as it scrolls off screen',
      'icon': Icons.animation,
      'color': _shIndigo,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('7 · Combining with Other Slivers', Icons.layers),
      _shInfoCard(
        'Composition patterns',
        'Scrolling headers work well in CustomScrollView alongside other '
            'slivers. A common pattern is a scrolling hero header followed by '
            'a pinned tab bar, giving the best of both worlds.',
        Icons.merge_type,
      ),
      ...patterns.map((p) => Container(
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
                  Text(p['pattern'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _shTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Visual Demo
// ---------------------------------------------------------------------------

class _ShScrollingDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 160;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final bgColor = Color.lerp(_shPrimary, _shPrimaryLight, progress) ?? _shPrimary;
    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.swap_vert, color: _shOnPrimary, size: 20 - (progress * 4)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scrolling Header',
                  style: TextStyle(
                    color: _shOnPrimary,
                    fontSize: 16 - (progress * 3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (progress < 0.6)
                  Opacity(
                    opacity: 1.0 - (progress * 1.8),
                    child: Text(
                      'This header will scroll away',
                      style: TextStyle(color: _shOnPrimary.withValues(alpha: 0.7), fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            'offset: ${shrinkOffset.toStringAsFixed(0)}',
            style: TextStyle(color: _shOnPrimary.withValues(alpha: 0.7), fontSize: 9),
          ),
        ],
      ),
    );
  }
}

Widget _shSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('8 · Visual Demo', Icons.preview),
      _shInfoCard(
        'Scrolling header in action',
        'Scroll the list below. The green header compresses and then scrolls '
            'off screen entirely. Keep scrolling past — the header is gone. '
            'Scroll back to the top to see it reappear.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _shSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('Scrolling SliverPersistentHeader (pinned: false)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _shTextDark)),
            ),
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: false,
                      delegate: _ShScrollingDelegate(),
                    ),
                    SliverList.builder(
                      itemCount: 40,
                      itemBuilder: (ctx, i) => Container(
                        height: 44,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: i.isEven
                              ? _shPrimary.withValues(alpha: 0.03)
                              : _shAccent.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _shDivider.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.eco, size: 14, color: _shAccent),
                            SizedBox(width: 8),
                            Text('Item ${i + 1}', style: TextStyle(fontSize: 12, color: _shTextDark)),
                            Spacer(),
                            Text('row ${i + 1}', style: TextStyle(fontSize: 9, color: _shGrey)),
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
// Section 9: Common Pitfalls and Tips
// ---------------------------------------------------------------------------
Widget _shSection9Tips() {
  final tips = <Map<String, dynamic>>[
    {'title': 'Don\'t assume visibility', 'desc': 'Scrolling headers can be off-screen — never put critical controls there', 'icon': Icons.visibility_off, 'color': _shRed},
    {'title': 'Prefer pinned for navigation', 'desc': 'Tab bars and action buttons should be pinned, not scrolling', 'icon': Icons.push_pin, 'color': _shBlue},
    {'title': 'Use for introductory content', 'desc': 'Welcome banners, section titles, promotional areas work best', 'icon': Icons.campaign, 'color': _shPrimary},
    {'title': 'Mind the extent range', 'desc': 'If min ≈ max, the header barely compresses before scrolling off', 'icon': Icons.straighten, 'color': _shAmber},
    {'title': 'Combine with pinned slivers', 'desc': 'Place a scrolling header before a pinned tab bar for a layered effect', 'icon': Icons.layers, 'color': _shTeal},
    {'title': 'Test scroll-back behaviour', 'desc': 'Verify the header re-expands properly when scrolling back to the top', 'icon': Icons.autorenew, 'color': _shOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _shSectionTitle('9 · Common Pitfalls & Tips', Icons.tips_and_updates),
      _shInfoCard(
        'Getting the most from scrolling headers',
        'Scrolling headers are straightforward, but choosing the right '
            'header type matters. Misusing a scrolling header for navigation '
            'elements can hurt usability since the controls disappear.',
        Icons.warning,
      ),
      ...tips.map((t) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: t['color'] as Color, width: 3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(t['icon'] as IconData, size: 18, color: t['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _shTextDark)),
                  SizedBox(height: 2),
                  Text(t['desc'] as String, style: TextStyle(fontSize: 11, color: _shTextMedium)),
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
            colors: [_shPrimary.withValues(alpha: 0.08), _shAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _shPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.swap_vert, size: 32, color: _shPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverScrollingPersistentHeader',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _shTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The simplest persistent header — compresses, then scrolls away. '
              'Perfect for introductory content that should not permanently '
              'occupy viewport space.',
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
                  Icon(Icons.swap_vert, color: _shOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverScrolling\nPersistentHeader',
                      style: TextStyle(
                        fontSize: 17,
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
                'Headers that compress and scroll away with the content',
                style: TextStyle(fontSize: 12, color: _shOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _shSection1Overview(),
        _shSection2Mechanics(),
        _shSection3Geometry(),
        _shSection4WhenToUse(),
        _shSection5FlowComparison(),
        _shSection6Usage(),
        _shSection7Combining(),
        _shSection8Demo(),
        _shSection9Tips(),

        SizedBox(height: 24),
      ],
    ),
  );
}
