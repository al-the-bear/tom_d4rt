// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverPinnedPersistentHeader
//
// RenderSliverPinnedPersistentHeader is the concrete subclass of
// RenderSliverPersistentHeader that pins the header at the top of the
// viewport. As the user scrolls up, the header compresses from maxExtent
// to minExtent and then stays visible at minExtent while content scrolls
// beneath it.
//
// This is the render object behind SliverAppBar(pinned: true) and
// SliverPersistentHeader(pinned: true). It handles all the geometry
// calculations for pinned scroll behaviour.
//
// This demo visualises:
//   1. Overview — what pinned headers are
//   2. Pinning mechanics — how the header stays at top
//   3. Geometry calculation — paintOrigin and layoutExtent
//   4. Overlap handling — detecting when content is beneath
//   5. Comparison: pinned vs floating vs scrolling
//   6. SliverAppBar(pinned: true) integration
//   7. Custom pinned header patterns
//   8. Visual demo with live pinned header
//   9. Performance and troubleshooting
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Sapphire / Navy
// ---------------------------------------------------------------------------
const Color _ppPrimary = Color(0xFF0D47A1);
const Color _ppPrimaryLight = Color(0xFF1565C0);
const Color _ppAccent = Color(0xFF1976D2);
const Color _ppAccentLight = Color(0xFF90CAF9);
const Color _ppSurface = Color(0xFFE3F2FD);
const Color _ppSurfaceDark = Color(0xFFBBDEFB);
const Color _ppOnPrimary = Color(0xFFFFFFFF);
const Color _ppTextDark = Color(0xFF1A237E);
const Color _ppTextMedium = Color(0xFF3949AB);
const Color _ppDivider = Color(0xFF90CAF9);
const Color _ppGreen = Color(0xFF2E7D32);
const Color _ppOrange = Color(0xFFE65100);
const Color _ppTeal = Color(0xFF00695C);
const Color _ppGrey = Color(0xFF757575);
const Color _ppAmber = Color(0xFFF57F17);
const Color _ppPurple = Color(0xFF6A1B9A);
const Color _ppRed = Color(0xFFC62828);
const Color _ppIndigo = Color(0xFF283593);
const Color _ppCyan = Color(0xFF00838F);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _ppSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _ppPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _ppTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _ppDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _ppBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _ppInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _ppPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _ppSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _ppTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _ppTextMedium, height: 1.4)),
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
Widget _ppCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _ppSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _ppPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _ppSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ppSectionTitle('1 · Pinned Header Overview', Icons.push_pin),
      _ppInfoCard(
        'What is RenderSliverPinnedPersistentHeader?',
        'A concrete subclass of RenderSliverPersistentHeader that keeps '
            'the header pinned at the top of the viewport. When the user '
            'scrolls, the header compresses from maxExtent down to minExtent '
            'and then stays at minExtent while content flows beneath it.',
        Icons.vertical_align_top,
      ),
      _ppInfoCard(
        'Why it matters',
        'Pinned headers are the most common type of persistent header. '
            'They power SliverAppBar(pinned: true), collapsing toolbars, '
            'and sticky section headers. Understanding the render object '
            'helps debug layout and performance issues.',
        Icons.lightbulb,
        accent: _ppAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          children: [
            Text('Widget ↔ Render mapping', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _ppTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _ppBadge('Widget Layer', _ppPrimary, _ppOnPrimary),
                      SizedBox(height: 4),
                      Text('SliverPersistentHeader', style: TextStyle(fontSize: 10, color: _ppTextMedium)),
                      Text('pinned: true', style: TextStyle(fontSize: 9, color: _ppAccent, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, size: 16, color: _ppGrey),
                Expanded(
                  child: Column(
                    children: [
                      _ppBadge('Render Layer', _ppTeal, _ppOnPrimary),
                      SizedBox(height: 4),
                      Text('RenderSliverPinned\nPersistentHeader', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: _ppTextMedium)),
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
// Section 2: Pinning Mechanics
// ---------------------------------------------------------------------------
Widget _ppSection2PinningMechanics() {
  final steps = <Map<String, dynamic>>[
    {'step': '1', 'label': 'Fully expanded', 'desc': 'Header at maxExtent, content starts below', 'color': _ppGreen, 'height': 55.0},
    {'step': '2', 'label': 'Compressing', 'desc': 'Content scrolls up, header shrinks toward minExtent', 'color': _ppAmber, 'height': 40.0},
    {'step': '3', 'label': 'Fully collapsed', 'desc': 'Header at minExtent, stays pinned at top', 'color': _ppRed, 'height': 28.0},
    {'step': '4', 'label': 'Scrolling content', 'desc': 'Header remains at minExtent, content flows beneath', 'color': _ppPrimary, 'height': 28.0},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('2 · Pinning Mechanics', Icons.lock),
      _ppInfoCard(
        'How pinning works',
        'The header occupies space from the leading edge of the viewport. '
            'As scrollOffset increases, the header shrinks. Once it reaches '
            'minExtent, it stops shrinking and stays fixed. The key difference '
            'from other subclasses: it never scrolls off screen.',
        Icons.architecture,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scroll progression', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _ppTextDark)),
            SizedBox(height: 8),
            ...steps.map((s) => Container(
              height: s['height'] as double,
              margin: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.4)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(color: s['color'] as Color, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text(s['step'] as String, style: TextStyle(fontSize: 10, color: _ppOnPrimary, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['label'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: s['color'] as Color)),
                        Text(s['desc'] as String, style: TextStyle(fontSize: 9, color: _ppTextMedium)),
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
// Section 3: Geometry Calculation
// ---------------------------------------------------------------------------
Widget _ppSection3Geometry() {
  final fields = <Map<String, String>>[
    {'field': 'paintOrigin', 'value': '0.0 (always)', 'note': 'Pinned headers always paint at the viewport edge'},
    {'field': 'layoutExtent', 'value': 'max(minExtent, maxExtent - scrollOffset)', 'note': 'Space consumed in the sliver protocol'},
    {'field': 'paintExtent', 'value': 'Same as layoutExtent', 'note': 'Visual size matches layout size'},
    {'field': 'maxPaintExtent', 'value': 'maxExtent', 'note': 'Upper bound for the header size'},
    {'field': 'hasVisualOverflow', 'value': 'true when compressed', 'note': 'Child may paint beyond allocated extent'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('3 · Geometry Calculation', Icons.calculate),
      _ppInfoCard(
        'SliverGeometry for pinned headers',
        'The pinned header produces specific geometry values that tell the '
            'viewport it always occupies space at the leading edge. paintOrigin '
            'is always 0, meaning the header paints right at the viewport top.',
        Icons.grid_on,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          children: [
            ...fields.map((f) => Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _ppSurface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ppCode(f['field']!),
                      SizedBox(width: 8),
                      Expanded(child: Text(f['value']!, style: TextStyle(fontSize: 10, color: _ppAccent, fontWeight: FontWeight.w600))),
                    ],
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(f['note']!, style: TextStyle(fontSize: 10, color: _ppTextMedium, fontStyle: FontStyle.italic)),
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
// Section 4: Overlap Handling
// ---------------------------------------------------------------------------
Widget _ppSection4Overlap() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('4 · Overlap Handling', Icons.layers),
      _ppInfoCard(
        'overlapsContent parameter',
        'When content scrolls beneath the pinned header, overlapsContent '
            'becomes true. Delegates can use this to add elevation, shadows, '
            'or borders to visually indicate the header is floating above content.',
        Icons.flip_to_front,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overlap states', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _ppTextDark)),
            SizedBox(height: 8),
            // No overlap
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _ppPrimary,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.push_pin, size: 14, color: _ppOnPrimary),
                        SizedBox(width: 6),
                        Text('Header', style: TextStyle(fontSize: 11, color: _ppOnPrimary, fontWeight: FontWeight.w700)),
                        Spacer(),
                        _ppBadge('overlapsContent: false', _ppGreen, _ppOnPrimary),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _ppSurface,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                    ),
                    child: Text('Content starts right below — no overlap', style: TextStyle(fontSize: 10, color: _ppTextMedium)),
                  ),
                ],
              ),
            ),
            // Overlap
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _ppPrimary,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.push_pin, size: 14, color: _ppOnPrimary),
                      SizedBox(width: 6),
                      Text('Header', style: TextStyle(fontSize: 11, color: _ppOnPrimary, fontWeight: FontWeight.w700)),
                      Spacer(),
                      _ppBadge('overlapsContent: true', _ppAmber, _ppTextDark),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _ppSurface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                  ),
                  child: Text('Content is beneath header — shadow added', style: TextStyle(fontSize: 10, color: _ppTextMedium)),
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
// Section 5: Comparison Table
// ---------------------------------------------------------------------------
Widget _ppSection5Comparison() {
  final rows = <Map<String, dynamic>>[
    {'type': 'Pinned', 'scrollsOff': 'No', 'staysVisible': 'Always', 'floatsBack': 'N/A', 'color': _ppPrimary},
    {'type': 'Floating', 'scrollsOff': 'Yes', 'staysVisible': 'On scroll-down', 'floatsBack': 'Yes', 'color': _ppTeal},
    {'type': 'Scrolling', 'scrollsOff': 'Yes', 'staysVisible': 'Top only', 'floatsBack': 'No', 'color': _ppOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('5 · Pinned vs Floating vs Scrolling', Icons.compare),
      _ppInfoCard(
        'Three persistence modes',
        'All three subclasses share the same base class but differ in '
            'visibility behaviour. Pinned headers never leave the viewport. '
            'Floating headers reappear on reverse scroll. Scrolling headers '
            'leave and only return when scrolled back to the top.',
        Icons.view_carousel,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(color: _ppSurface, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  SizedBox(width: 70, child: Text('Type', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ppTextDark))),
                  Expanded(child: Text('Scrolls off?', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ppTextDark))),
                  Expanded(child: Text('Visible', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ppTextDark))),
                  Expanded(child: Text('Floats back?', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _ppTextDark))),
                ],
              ),
            ),
            ...rows.map((r) => Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _ppDivider.withValues(alpha: 0.3)))),
              child: Row(
                children: [
                  SizedBox(width: 70, child: _ppBadge(r['type'] as String, r['color'] as Color, _ppOnPrimary)),
                  Expanded(child: Text(r['scrollsOff'] as String, style: TextStyle(fontSize: 10, color: _ppTextMedium))),
                  Expanded(child: Text(r['staysVisible'] as String, style: TextStyle(fontSize: 10, color: _ppTextMedium))),
                  Expanded(child: Text(r['floatsBack'] as String, style: TextStyle(fontSize: 10, color: _ppTextMedium))),
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
// Section 6: SliverAppBar Integration
// ---------------------------------------------------------------------------
Widget _ppSection6SliverAppBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('6 · SliverAppBar(pinned: true)', Icons.web),
      _ppInfoCard(
        'The most common usage',
        'SliverAppBar with pinned: true uses RenderSliverPinnedPersistentHeader '
            'internally. It adds Material-specific features like FlexibleSpaceBar, '
            'elevation, and actions on top of the base pinning mechanics.',
        Icons.apps,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SliverAppBar layer structure', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _ppTextDark)),
            SizedBox(height: 8),
            // Layer diagram
            ...[
              {'layer': 'SliverAppBar', 'detail': 'Widget: configures floating, pinned, snap, stretch', 'color': _ppPrimary},
              {'layer': '_SliverAppBarDelegate', 'detail': 'Delegate: builds FlexibleSpaceBar with shrinkOffset', 'color': _ppAccent},
              {'layer': 'SliverPersistentHeader', 'detail': 'Widget: selects render object based on pinned flag', 'color': _ppTeal},
              {'layer': 'RenderSliverPinnedPersistentHeader', 'detail': 'Render: handles layout, geometry, and painting', 'color': _ppIndigo},
            ].map((l) => Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (l['color'] as Color).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: l['color'] as Color, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ppCode(l['layer'] as String, color: l['color'] as Color),
                  SizedBox(height: 2),
                  Text(l['detail'] as String, style: TextStyle(fontSize: 10, color: _ppTextMedium)),
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
// Section 7: Custom Pinned Header Patterns
// ---------------------------------------------------------------------------
Widget _ppSection7CustomPatterns() {
  final patterns = <Map<String, dynamic>>[
    {
      'pattern': 'Collapsing image header',
      'desc': 'Image fades out as header collapses, title crossfades from large to small',
      'icon': Icons.image,
      'color': _ppPrimary,
    },
    {
      'pattern': 'Sticky section header',
      'desc': 'Small pinned header separating list sections (like iOS Settings)',
      'icon': Icons.view_list,
      'color': _ppTeal,
    },
    {
      'pattern': 'Search bar + tab bar',
      'desc': 'Search collapses away but tabs remain pinned at minExtent',
      'icon': Icons.search,
      'color': _ppOrange,
    },
    {
      'pattern': 'Gradient to solid',
      'desc': 'Background transitions from a gradient to solid colour during collapse',
      'icon': Icons.gradient,
      'color': _ppPurple,
    },
    {
      'pattern': 'Content density change',
      'desc': 'Expanded shows details and actions, collapsed shows only the essential icon + title',
      'icon': Icons.density_medium,
      'color': _ppAmber,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('7 · Custom Pinned Header Patterns', Icons.palette),
      _ppInfoCard(
        'Beyond SliverAppBar',
        'SliverPersistentHeader(pinned: true) with a custom delegate lets '
            'you build any pinned header. The delegate receives shrinkOffset '
            'and overlapsContent for full control over appearance.',
        Icons.brush,
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
                  Text(p['pattern'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ppTextDark)),
                  SizedBox(height: 2),
                  Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _ppTextMedium)),
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

class _PpPinnedDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 180;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    final bgOpacity = 1.0 - (progress * 0.3);
    return Container(
      decoration: BoxDecoration(
        color: _ppPrimary.withValues(alpha: bgOpacity),
        boxShadow: overlapsContent
            ? [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))]
            : [],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.push_pin, color: _ppOnPrimary, size: 20 - (progress * 4)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pinned Header',
                  style: TextStyle(
                    color: _ppOnPrimary,
                    fontSize: 18 - (progress * 4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (progress < 0.5)
                  Opacity(
                    opacity: 1.0 - (progress * 2),
                    child: Text(
                      'Subtitle fades as you scroll',
                      style: TextStyle(color: _ppOnPrimary.withValues(alpha: 0.7), fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'offset: ${shrinkOffset.toStringAsFixed(0)}',
                style: TextStyle(color: _ppOnPrimary.withValues(alpha: 0.7), fontSize: 9),
              ),
              Text(
                overlapsContent ? 'overlaps' : 'no overlap',
                style: TextStyle(
                  color: overlapsContent ? _ppAmber : _ppOnPrimary.withValues(alpha: 0.5),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _ppSection8Demo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('8 · Visual Demo', Icons.preview),
      _ppInfoCard(
        'Pinned header in action',
        'Scroll the list below. The header compresses from 180px to 56px '
            'and stays pinned. The subtitle fades, shadow appears when content '
            'overlaps, and the shrinkOffset is displayed in real time.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _ppSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('Pinned SliverPersistentHeader', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _ppTextDark)),
            ),
            SizedBox(
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _PpPinnedDelegate(),
                    ),
                    SliverList.builder(
                      itemCount: 40,
                      itemBuilder: (ctx, i) => Container(
                        height: 44,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: i.isEven
                              ? _ppPrimary.withValues(alpha: 0.03)
                              : _ppAccent.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _ppDivider.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                color: _ppPrimary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Text('${i + 1}', style: TextStyle(fontSize: 10, color: _ppPrimary, fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 10),
                            Text('Content item ${i + 1}', style: TextStyle(fontSize: 12, color: _ppTextDark)),
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
// Section 9: Performance and Troubleshooting
// ---------------------------------------------------------------------------
Widget _ppSection9Performance() {
  final tips = <Map<String, dynamic>>[
    {'title': 'Keep shouldRebuild efficient', 'desc': 'Return false unless delegate state actually changed — avoids rebuild cascades', 'icon': Icons.speed, 'color': _ppGreen},
    {'title': 'Avoid expensive builds', 'desc': 'The delegate\'s build() is called on every frame during scroll — keep it lightweight', 'icon': Icons.memory, 'color': _ppAmber},
    {'title': 'Use RepaintBoundary', 'desc': 'Wrap complex header content in RepaintBoundary to reduce repaint cost', 'icon': Icons.layers, 'color': _ppPrimary},
    {'title': 'Don\'t change extents dynamically', 'desc': 'Changing min/maxExtent during scroll causes layout jumps — compute them once', 'icon': Icons.warning, 'color': _ppRed},
    {'title': 'Test with large lists', 'desc': 'Pinned headers interact with viewport and need testing with realistic item counts', 'icon': Icons.checklist, 'color': _ppTeal},
    {'title': 'Debug with DevTools', 'desc': 'Use Flutter DevTools to inspect SliverGeometry values if layouts look wrong', 'icon': Icons.bug_report, 'color': _ppOrange},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _ppSectionTitle('9 · Performance & Troubleshooting', Icons.speed),
      _ppInfoCard(
        'Optimising pinned headers',
        'Pinned headers are rebuilt on every scroll frame. Because the '
            'delegate\'s build() runs so frequently, even small inefficiencies '
            'compound. These tips help keep pinned headers smooth at 60fps.',
        Icons.trending_up,
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
                  Text(t['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _ppTextDark)),
                  SizedBox(height: 2),
                  Text(t['desc'] as String, style: TextStyle(fontSize: 11, color: _ppTextMedium)),
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
            colors: [_ppPrimary.withValues(alpha: 0.08), _ppAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _ppPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.push_pin, size: 32, color: _ppPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverPinnedPersistentHeader',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _ppTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The render object that keeps headers pinned at the viewport edge — '
              'compressing from maxExtent to minExtent and staying visible while '
              'content scrolls beneath.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _ppTextMedium, height: 1.4),
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
              colors: [_ppPrimary, _ppPrimaryLight],
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
                  Icon(Icons.push_pin, color: _ppOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverPinnedPersistentHeader',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _ppOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Headers that pin at the top and compress during scroll',
                style: TextStyle(fontSize: 12, color: _ppOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _ppSection1Overview(),
        _ppSection2PinningMechanics(),
        _ppSection3Geometry(),
        _ppSection4Overlap(),
        _ppSection5Comparison(),
        _ppSection6SliverAppBar(),
        _ppSection7CustomPatterns(),
        _ppSection8Demo(),
        _ppSection9Performance(),

        SizedBox(height: 24),
      ],
    ),
  );
}
