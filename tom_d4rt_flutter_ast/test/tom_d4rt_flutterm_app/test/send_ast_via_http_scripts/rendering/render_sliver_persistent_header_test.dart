// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverPersistentHeader
//
// RenderSliverPersistentHeader is the abstract base class for sliver headers
// that remain visible while content scrolls beneath them. It defines the
// interface for minExtent and maxExtent, and manages how the header
// shrinks/grows as the user scrolls.
//
// Three concrete subclasses (pinned, floating, scrolling) implement different
// persistence strategies. This demo covers the base class concepts shared
// across all persistent headers.
//
// This demo visualises:
//   1. Overview — what persistent headers are
//   2. minExtent and maxExtent — the size range
//   3. Shrinking behaviour during scroll
//   4. The shrinkOffset value
//   5. Three subclass strategies
//   6. SliverPersistentHeaderDelegate
//   7. stretchConfiguration — stretching beyond max
//   8. Visual demo with SliverPersistentHeader
//   9. Best practices and integration patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Crimson / Wine
// ---------------------------------------------------------------------------
const Color _phPrimary = Color(0xFF7F0000);
const Color _phPrimaryLight = Color(0xFFB71C1C);
const Color _phAccent = Color(0xFFD32F2F);
const Color _phAccentLight = Color(0xFFEF9A9A);
const Color _phSurface = Color(0xFFFFEBEE);
const Color _phSurfaceDark = Color(0xFFFFCDD2);
const Color _phOnPrimary = Color(0xFFFFFFFF);
const Color _phTextDark = Color(0xFF4E342E);
const Color _phTextMedium = Color(0xFF6D4C41);
const Color _phDivider = Color(0xFFEF9A9A);
const Color _phGreen = Color(0xFF2E7D32);
const Color _phBlue = Color(0xFF1565C0);
const Color _phOrange = Color(0xFFE65100);
const Color _phTeal = Color(0xFF00695C);
const Color _phGrey = Color(0xFF757575);
const Color _phAmber = Color(0xFFF57F17);
const Color _phPurple = Color(0xFF6A1B9A);
const Color _phIndigo = Color(0xFF283593);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _phSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _phPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _phTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _phDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _phBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _phInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _phPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _phSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _phTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _phTextMedium, height: 1.4)),
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
Widget _phCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _phSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _phPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _phSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _phSectionTitle('1 · Persistent Header Overview', Icons.view_day),
      _phInfoCard(
        'What is RenderSliverPersistentHeader?',
        'An abstract base class for slivers that display a header with a '
            'variable size (between minExtent and maxExtent). As content '
            'scrolls, the header compresses. Depending on the subclass, it '
            'either pins at the top, scrolls away, or floats back in.',
        Icons.vertical_split,
      ),
      _phInfoCard(
        'Where it\'s used',
        'SliverAppBar, SliverPersistentHeader, and all tab bar headers '
            'are built on top of this render object. It is the foundation '
            'for all collapsing/expanding header patterns in Flutter.',
        Icons.foundation,
        accent: _phAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          children: [
            Text('Hierarchy', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _phTextDark)),
            SizedBox(height: 8),
            _phBadge('RenderSliverPersistentHeader (abstract)', _phPrimary, _phOnPrimary),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _phGrey),
                    _phBadge('Pinned', _phBlue, _phOnPrimary),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _phGrey),
                    _phBadge('Floating', _phTeal, _phOnPrimary),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 12, color: _phGrey),
                    _phBadge('Scrolling', _phOrange, _phOnPrimary),
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
// Section 2: minExtent and maxExtent
// ---------------------------------------------------------------------------
Widget _phSection2Extents() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('2 · minExtent & maxExtent', Icons.straighten),
      _phInfoCard(
        'The size range',
        'minExtent is the smallest the header can shrink to (typically the '
            'toolbar height). maxExtent is the largest (expanded state with '
            'background image, etc). The header always stays within this range '
            'unless stretch is enabled.',
        Icons.height,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Header extent range', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _phTextDark)),
            SizedBox(height: 8),
            // Max extent bar
            SizedBox(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: _phPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _phPrimary.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.unfold_more, size: 16, color: _phPrimary),
                    SizedBox(width: 4),
                    Text('maxExtent: 200px (expanded)', style: TextStyle(fontSize: 11, color: _phPrimary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            // Min extent bar
            SizedBox(
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: _phAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _phAccent.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.unfold_less, size: 16, color: _phAccent),
                    SizedBox(width: 4),
                    Text('minExtent: 56px (collapsed)', style: TextStyle(fontSize: 11, color: _phAccent, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('shrinkOffset range: ', style: TextStyle(fontSize: 10, color: _phTextMedium)),
                _phCode('0 .. (max - min) = 0 .. 144'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Shrinking Behaviour
// ---------------------------------------------------------------------------
Widget _phSection3Shrinking() {
  final states = <Map<String, dynamic>>[
    {'label': 'Fully expanded', 'offset': '0', 'height': 60, 'color': _phGreen},
    {'label': 'Partially collapsed', 'offset': '72', 'height': 42, 'color': _phAmber},
    {'label': 'Fully collapsed', 'offset': '144', 'height': 24, 'color': _phAccent},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('3 · Shrinking During Scroll', Icons.compress),
      _phInfoCard(
        'How the header compresses',
        'As the user scrolls up, the viewport tells the header how much '
            'content has scrolled past (via SliverConstraints.scrollOffset). '
            'The header converts this into a shrinkOffset and resizes its '
            'child accordingly. At shrinkOffset=0 it\'s fully expanded.',
        Icons.swap_vert,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Header at different scroll positions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _phTextDark)),
            SizedBox(height: 8),
            ...states.map((s) => Container(
              height: (s['height'] as int).toDouble(),
              margin: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _phBadge(s['label'] as String, s['color'] as Color, _phOnPrimary),
                  SizedBox(width: 8),
                  Text('shrinkOffset: ${s['offset']}', style: TextStyle(fontSize: 10, color: _phTextMedium)),
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
// Section 4: shrinkOffset Value
// ---------------------------------------------------------------------------
Widget _phSection4ShrinkOffset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('4 · The shrinkOffset Value', Icons.trending_down),
      _phInfoCard(
        'What is shrinkOffset?',
        'shrinkOffset is passed to the delegate\'s build() method. It '
            'ranges from 0 (fully expanded) to maxExtent - minExtent '
            '(fully collapsed). The delegate uses it to interpolate between '
            'expanded and collapsed states — fading title, changing colour, etc.',
        Icons.tune,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('shrinkOffset interpolation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _phTextDark)),
            SizedBox(height: 8),
            // Visual gradient bar
            Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_phGreen.withValues(alpha: 0.3), _phAmber.withValues(alpha: 0.3), _phAccent.withValues(alpha: 0.3)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('0', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _phGreen)),
                  ),
                  Text('shrinkOffset', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _phTextMedium)),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text('max-min', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _phAccent)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expanded', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _phGreen)),
                    Text('Full image visible', style: TextStyle(fontSize: 9, color: _phTextMedium)),
                    Text('Large title', style: TextStyle(fontSize: 9, color: _phTextMedium)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Collapsed', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _phAccent)),
                    Text('Image hidden', style: TextStyle(fontSize: 9, color: _phTextMedium)),
                    Text('Small title', style: TextStyle(fontSize: 9, color: _phTextMedium)),
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
// Section 5: Three Subclass Strategies
// ---------------------------------------------------------------------------
Widget _phSection5Subclasses() {
  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'Pinned',
      'class': 'RenderSliverPinnedPersistentHeader',
      'desc': 'Header stays pinned at the top while content scrolls beneath. '
          'Compresses from maxExtent to minExtent and stays visible.',
      'icon': Icons.push_pin,
      'color': _phBlue,
    },
    {
      'name': 'Floating',
      'class': 'RenderSliverFloatingPersistentHeader',
      'desc': 'Header scrolls off screen but floats back when user scrolls '
          'down even slightly. Useful for search bars and navigation.',
      'icon': Icons.arrow_upward,
      'color': _phTeal,
    },
    {
      'name': 'Scrolling',
      'class': 'RenderSliverScrollingPersistentHeader',
      'desc': 'Header scrolls off screen with content. No pinning or floating. '
          'Only visible when the scroll position is at the top.',
      'icon': Icons.swap_vert,
      'color': _phOrange,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('5 · Three Subclass Strategies', Icons.account_tree),
      _phInfoCard(
        'Concrete implementations',
        'RenderSliverPersistentHeader itself is abstract. Flutter provides '
            'three concrete subclasses that define different scroll persistence '
            'behaviours. All share the same min/max extent mechanics.',
        Icons.architecture,
      ),
      ...subclasses.map((s) => Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: s['color'] as Color, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(s['icon'] as IconData, size: 18, color: s['color'] as Color),
                SizedBox(width: 6),
                Text(s['name'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: s['color'] as Color)),
              ],
            ),
            SizedBox(height: 4),
            _phCode(s['class'] as String, color: s['color'] as Color),
            SizedBox(height: 6),
            Text(s['desc'] as String, style: TextStyle(fontSize: 11, color: _phTextMedium, height: 1.3)),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: SliverPersistentHeaderDelegate
// ---------------------------------------------------------------------------
Widget _phSection6Delegate() {
  final methods = <Map<String, String>>[
    {'method': 'build(context, shrinkOffset, overlapsContent)', 'desc': 'Build the header widget for current state'},
    {'method': 'get minExtent', 'desc': 'Minimum height when fully collapsed'},
    {'method': 'get maxExtent', 'desc': 'Maximum height when fully expanded'},
    {'method': 'shouldRebuild(old)', 'desc': 'Whether the delegate has changed'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('6 · SliverPersistentHeaderDelegate', Icons.settings),
      _phInfoCard(
        'The delegate pattern',
        'The widget layer uses SliverPersistentHeaderDelegate to provide '
            'the render object with minExtent, maxExtent, and a builder. '
            'The delegate\'s build() receives shrinkOffset and overlapsContent '
            'so it can adjust its appearance dynamically.',
        Icons.engineering,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delegate methods', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _phTextDark)),
            Divider(color: _phDivider, height: 12),
            ...methods.map((m) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _phCode(m['method']!),
                  SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(m['desc']!, style: TextStyle(fontSize: 10, color: _phTextMedium)),
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
// Section 7: Stretch Configuration
// ---------------------------------------------------------------------------
Widget _phSection7Stretch() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('7 · Stretch Beyond maxExtent', Icons.unfold_more),
      _phInfoCard(
        'Over-scroll stretching',
        'When stretchConfiguration is provided (via SliverAppBar), the header '
            'can grow beyond maxExtent during over-scroll. This creates the '
            'stretchy parallax effect seen in iOS-style scroll views.',
        Icons.expand,
      ),
      Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Stack(
          children: [
            // Normal max
            Positioned(
              left: 20, top: 50, right: 20,
              child: Container(
                height: 2,
                color: _phPrimary.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              left: 20, top: 38,
              child: Text('maxExtent', style: TextStyle(fontSize: 9, color: _phPrimary)),
            ),
            // Stretched
            Positioned(
              left: 30, top: 10, right: 30, bottom: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: _phPurple.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _phPurple.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.unfold_more, size: 20, color: _phPurple),
                    SizedBox(height: 4),
                    Text('Stretched beyond max', style: TextStyle(fontSize: 10, color: _phPurple, fontWeight: FontWeight.w700)),
                    Text('(over-scroll)', style: TextStyle(fontSize: 9, color: _phPurple)),
                  ],
                ),
              ),
            ),
            // Normal extent
            Positioned(
              left: 30, top: 50, right: 30, bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: _phPrimary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _phPrimary.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('Normal range (min..max)', style: TextStyle(fontSize: 10, color: _phPrimary, fontWeight: FontWeight.w600)),
              ),
            ),
            // Min line
            Positioned(
              left: 20, bottom: 20, right: 20,
              child: Container(
                height: 2,
                color: _phAccent.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              right: 20, bottom: 8,
              child: Text('minExtent', style: TextStyle(fontSize: 9, color: _phAccent)),
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

class _PhHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 160;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    final bgColor = Color.lerp(_phPrimary, _phPrimaryLight, progress) ?? _phPrimary;
    final titleSize = 20.0 - (progress * 6);
    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(Icons.view_day, color: _phOnPrimary, size: 20 - (progress * 4)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Persistent Header',
              style: TextStyle(
                color: _phOnPrimary,
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'offset: ${shrinkOffset.toStringAsFixed(0)}',
            style: TextStyle(color: _phOnPrimary.withValues(alpha: 0.7), fontSize: 10),
          ),
        ],
      ),
    );
  }
}

Widget _phSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('8 · Visual Demo', Icons.preview),
      _phInfoCard(
        'SliverPersistentHeader in action',
        'Below is a CustomScrollView with a SliverPersistentHeader using a '
            'pinned delegate. Scroll to see the header compress from 160px '
            'to 56px. The header interpolates colour and font size based on shrinkOffset.',
        Icons.view_list,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _phSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pinned SliverPersistentHeader', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _phTextDark)),
            SizedBox(height: 6),
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _PhHeaderDelegate(),
                    ),
                    SliverList.builder(
                      itemCount: 30,
                      itemBuilder: (ctx, i) => Container(
                        height: 48,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: i.isEven
                              ? _phPrimary.withValues(alpha: 0.04)
                              : _phAccent.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _phDivider.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.article, size: 14, color: _phAccent),
                            SizedBox(width: 8),
                            Text('Content item ${i + 1}', style: TextStyle(fontSize: 12, color: _phTextDark)),
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
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _phSection9BestPractices() {
  final practices = <Map<String, dynamic>>[
    {'title': 'Choose the right subclass', 'desc': 'Pinned for app bars, floating for search bars, scrolling for page headers', 'icon': Icons.account_tree, 'color': _phPrimary},
    {'title': 'Keep minExtent stable', 'desc': 'Changing minExtent dynamically can cause scroll jumps', 'icon': Icons.warning, 'color': _phAmber},
    {'title': 'Use shrinkOffset for interpolation', 'desc': 'Calculate progress = shrinkOffset / (max - min) for smooth transitions', 'icon': Icons.tune, 'color': _phBlue},
    {'title': 'Consider overlapsContent', 'desc': 'Add a shadow or border when overlapsContent is true to show depth', 'icon': Icons.layers, 'color': _phOrange},
    {'title': 'Pair with SliverAppBar', 'desc': 'SliverAppBar wraps SliverPersistentHeader with Material-specific features', 'icon': Icons.web, 'color': _phTeal},
    {'title': 'Test with BouncingScrollPhysics', 'desc': 'Verify stretch behaviour on iOS-style physics for edge cases', 'icon': Icons.phone_iphone, 'color': _phIndigo},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _phSectionTitle('9 · Best Practices', Icons.star),
      _phInfoCard(
        'Building great persistent headers',
        'Persistent headers are one of Flutter\'s most powerful scroll '
            'features. Understanding the base class mechanics helps you '
            'build custom headers beyond what SliverAppBar provides.',
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
                  Text(p['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _phTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _phTextMedium)),
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
            colors: [_phPrimary.withValues(alpha: 0.08), _phAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _phPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.view_day, size: 32, color: _phPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverPersistentHeader',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _phTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The foundation for all collapsing/expanding headers in Flutter — '
              'managing size transitions between minExtent and maxExtent as '
              'content scrolls beneath.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _phTextMedium, height: 1.4),
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
              colors: [_phPrimary, _phPrimaryLight],
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
                  Icon(Icons.view_day, color: _phOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverPersistentHeader',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _phOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'The base class for collapsing and expanding scroll headers',
                style: TextStyle(fontSize: 12, color: _phOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _phSection1Overview(),
        _phSection2Extents(),
        _phSection3Shrinking(),
        _phSection4ShrinkOffset(),
        _phSection5Subclasses(),
        _phSection6Delegate(),
        _phSection7Stretch(),
        _phSection8Demo(),
        _phSection9BestPractices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
