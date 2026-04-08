// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverToBoxAdapter
//
// RenderSliverToBoxAdapter is the concrete render object created by the
// SliverToBoxAdapter widget. It extends RenderSliverSingleBoxAdapter and
// provides the actual performLayout() implementation that measures the
// child, computes SliverGeometry, and positions the child for painting.
//
// This is the most commonly used sliver adapter — it turns any ordinary
// box widget (Container, Card, Image, Row, etc.) into something that can
// live inside a CustomScrollView alongside other slivers.
//
// This demo visualises:
//   1. Overview — what SliverToBoxAdapter does
//   2. How it wraps box widgets — the rendering pipeline
//   3. Layout computation in detail — performLayout walkthrough
//   4. Painting and compositing — child offset during scroll
//   5. Common use-cases with live examples
//   6. Multiple adapters in a single scroll view
//   7. Interaction with SliverAppBar and SliverList
//   8. Edge cases and gotchas
//   9. Summary and reference
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Coral / Salmon
// ---------------------------------------------------------------------------
const Color _taPrimary = Color(0xFFE57373);
const Color _taPrimaryLight = Color(0xFFEF9A9A);
const Color _taAccent = Color(0xFFD32F2F);
const Color _taAccentLight = Color(0xFFFFCDD2);
const Color _taSurface = Color(0xFFFFF5F5);
const Color _taSurfaceDark = Color(0xFFFFEBEE);
const Color _taOnPrimary = Color(0xFFFFFFFF);
const Color _taTextDark = Color(0xFF4E342E);
const Color _taTextMedium = Color(0xFF795548);
const Color _taDivider = Color(0xFFEF9A9A);
const Color _taGreen = Color(0xFF388E3C);
const Color _taBlue = Color(0xFF1976D2);
const Color _taOrange = Color(0xFFE65100);
const Color _taTeal = Color(0xFF00796B);
const Color _taGrey = Color(0xFF757575);
const Color _taAmber = Color(0xFFF9A825);
const Color _taPurple = Color(0xFF7B1FA2);
const Color _taIndigo = Color(0xFF303F9F);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _taSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _taPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _taTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _taDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _taBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _taInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _taPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _taSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _taTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _taTextMedium, height: 1.4)),
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
Widget _taCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _taSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _taAccent, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _taSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _taSectionTitle('1 · SliverToBoxAdapter Overview', Icons.view_in_ar),
      _taInfoCard(
        'The universal sliver adapter',
        'SliverToBoxAdapter wraps a single box widget so it can be placed '
            'inside a CustomScrollView. The render object — '
            'RenderSliverToBoxAdapter — handles translating sliver constraints '
            'to box constraints and computing the right SliverGeometry.',
        Icons.swap_vert,
      ),
      _taInfoCard(
        'Usage pattern',
        'CustomScrollView(slivers: [ SliverToBoxAdapter(child: MyWidget()), '
            'SliverList(...), SliverToBoxAdapter(child: Footer()), ])',
        Icons.code,
        accent: _taAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Where it fits in the tree', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _taTextDark)),
            SizedBox(height: 8),
            ...[
              {'depth': 0, 'name': 'CustomScrollView', 'color': _taBlue},
              {'depth': 1, 'name': 'Viewport (viewport render object)', 'color': _taIndigo},
              {'depth': 2, 'name': 'SliverToBoxAdapter', 'color': _taPrimary},
              {'depth': 3, 'name': 'RenderSliverToBoxAdapter', 'color': _taAccent},
              {'depth': 4, 'name': 'Your box child (Card, Image...)', 'color': _taGreen},
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
// Section 2: Wrapping Box Widgets
// ---------------------------------------------------------------------------
Widget _taSection2Wrapping() {
  final wrappable = <Map<String, dynamic>>[
    {'widget': 'Container', 'icon': Icons.square_outlined, 'desc': 'Any sized container with decoration'},
    {'widget': 'Card', 'icon': Icons.credit_card, 'desc': 'Material card with elevation'},
    {'widget': 'Image', 'icon': Icons.image, 'desc': 'Network, asset, or memory images'},
    {'widget': 'Row / Column', 'icon': Icons.view_column, 'desc': 'Horizontal or vertical flex layouts'},
    {'widget': 'Text / RichText', 'icon': Icons.text_fields, 'desc': 'Text content of any length'},
    {'widget': 'Custom widgets', 'icon': Icons.extension, 'desc': 'Any widget that uses box layout'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('2 · Wrapping Box Widgets', Icons.wrap_text),
      _taInfoCard(
        'Any box widget can be wrapped',
        'SliverToBoxAdapter accepts any widget as its child. The render '
            'object gives the child a tight cross-axis constraint (the viewport '
            'width) and an unconstrained main-axis, so the child picks its '
            'natural height (or width for horizontal scroll).',
        Icons.all_inclusive,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: wrappable.map((w) => Container(
            width: 140,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _taSurface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _taDivider.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(w['icon'] as IconData, size: 14, color: _taPrimary),
                    SizedBox(width: 4),
                    Text(w['widget'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _taTextDark)),
                  ],
                ),
                SizedBox(height: 2),
                Text(w['desc'] as String, style: TextStyle(fontSize: 9, color: _taTextMedium)),
              ],
            ),
          )).toList(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Layout Computation
// ---------------------------------------------------------------------------
Widget _taSection3Layout() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('3 · performLayout() Walkthrough', Icons.calculate),
      _taInfoCard(
        'How layout works step by step',
        'performLayout() is where the adapter measures the child, computes '
            'the visible paint extent, and reports SliverGeometry back to the '
            'viewport. Here is the exact sequence.',
        Icons.format_list_numbered,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _taCode('void performLayout() {'),
            SizedBox(height: 6),
            // Step 1
            Container(
              margin: EdgeInsets.only(left: 12, bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _taBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _taBlue, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taCode('// 1. Bail out if no remaining extent', color: _taGrey),
                  SizedBox(height: 2),
                  _taCode('if (child == null) { geometry = SliverGeometry.zero; return; }'),
                  SizedBox(height: 4),
                  Text('If there is no child, report zero geometry.', style: TextStyle(fontSize: 10, color: _taTextMedium)),
                ],
              ),
            ),
            // Step 2
            Container(
              margin: EdgeInsets.only(left: 12, bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _taGreen.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _taGreen, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taCode('// 2. Lay out child with box constraints', color: _taGrey),
                  SizedBox(height: 2),
                  _taCode('child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);'),
                  SizedBox(height: 4),
                  Text('asBoxConstraints() creates tight cross-axis, unconstrained main-axis.', style: TextStyle(fontSize: 10, color: _taTextMedium)),
                ],
              ),
            ),
            // Step 3
            Container(
              margin: EdgeInsets.only(left: 12, bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _taOrange.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _taOrange, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taCode('// 3. Compute child extent and paint extent', color: _taGrey),
                  SizedBox(height: 2),
                  _taCode('final childExtent = ...child main-axis size'),
                  SizedBox(height: 2),
                  _taCode('final paintedChildSize = clamp(childExtent - scrollOffset, 0, remaining)'),
                  SizedBox(height: 4),
                  Text('Subtract scrollOffset to find the visible portion.', style: TextStyle(fontSize: 10, color: _taTextMedium)),
                ],
              ),
            ),
            // Step 4
            Container(
              margin: EdgeInsets.only(left: 12, bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _taPurple.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _taPurple, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taCode('// 4. Build and set SliverGeometry', color: _taGrey),
                  SizedBox(height: 2),
                  _taCode('geometry = SliverGeometry('),
                  _taCode('  scrollExtent: childExtent,'),
                  _taCode('  paintExtent: paintedChildSize,'),
                  _taCode('  maxPaintExtent: childExtent,'),
                  _taCode(');'),
                  SizedBox(height: 4),
                  Text('scrollExtent is always the full child size.', style: TextStyle(fontSize: 10, color: _taTextMedium)),
                ],
              ),
            ),
            // Step 5
            Container(
              margin: EdgeInsets.only(left: 12, bottom: 6),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _taTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _taTeal, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taCode('// 5. Set child paint offset', color: _taGrey),
                  SizedBox(height: 2),
                  _taCode('setChildParentData(child!, constraints, geometry!);'),
                  SizedBox(height: 4),
                  Text('Positions child relative to the sliver\'s paint origin.', style: TextStyle(fontSize: 10, color: _taTextMedium)),
                ],
              ),
            ),
            _taCode('}'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Painting and Compositing
// ---------------------------------------------------------------------------
Widget _taSection4Painting() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('4 · Painting & Child Offset', Icons.brush),
      _taInfoCard(
        'How the child is painted',
        'During painting, the child\'s offset within the sliver is set by '
            'SliverPhysicalParentData. The y-offset equals '
            '-constraints.scrollOffset (the child scrolls upward as the user '
            'scrolls down). The viewport clips anything above its top edge.',
        Icons.format_paint,
      ),
      Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Stack(
          children: [
            // Viewport boundary
            Positioned(
              left: 16, top: 30, right: 16, bottom: 16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _taPrimary, width: 2),
                ),
              ),
            ),
            Positioned(
              left: 20, top: 22,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                color: Colors.white,
                child: Text('Visible region', style: TextStyle(fontSize: 9, color: _taPrimary, fontWeight: FontWeight.w700)),
              ),
            ),
            // Clipped portion (above viewport)
            Positioned(
              left: 40, top: 6, right: 40,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: _taAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  border: Border.all(color: _taAccent.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('Clipped (scrolled off top)', style: TextStyle(fontSize: 8, color: _taAccent)),
              ),
            ),
            // Visible portion
            Positioned(
              left: 40, top: 36, right: 40,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: _taGreen.withValues(alpha: 0.1),
                  border: Border.all(color: _taGreen.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Painted portion', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _taGreen)),
                    Text('paintExtent = visible part', style: TextStyle(fontSize: 8, color: _taTextMedium)),
                  ],
                ),
              ),
            ),
            // Below visible portion
            Positioned(
              left: 40, top: 116, right: 40, bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: _taAmber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                  border: Border.all(color: _taAmber.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('Not yet visible (below viewport)', style: TextStyle(fontSize: 8, color: _taAmber)),
              ),
            ),
            // Offset annotation
            Positioned(
              right: 20, top: 40,
              child: Column(
                children: [
                  Icon(Icons.arrow_upward, size: 12, color: _taAccent),
                  Text('scrollOffset', style: TextStyle(fontSize: 8, color: _taAccent, fontWeight: FontWeight.w600)),
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
// Section 5: Common Use-Cases
// ---------------------------------------------------------------------------
Widget _taSection5UseCases() {
  final cases = <Map<String, dynamic>>[
    {'title': 'Section header', 'desc': 'Place a titled header between SliverList sections', 'icon': Icons.title, 'color': _taPrimary},
    {'title': 'Hero banner', 'desc': 'Full-width image or promotional banner', 'icon': Icons.photo_size_select_actual, 'color': _taBlue},
    {'title': 'Search bar', 'desc': 'A search TextField above the list content', 'icon': Icons.search, 'color': _taTeal},
    {'title': 'Footer / copyright', 'desc': 'A footer at the end of all scrollable content', 'icon': Icons.copyright, 'color': _taGrey},
    {'title': 'Empty state', 'desc': '"No results found" placeholder widget', 'icon': Icons.inbox, 'color': _taOrange},
    {'title': 'Loading spinner', 'desc': 'A CircularProgressIndicator at the list bottom', 'icon': Icons.autorenew, 'color': _taPurple},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('5 · Common Use-Cases', Icons.apps),
      _taInfoCard(
        'Versatile placement patterns',
        'SliverToBoxAdapter shines when you need to insert a single non-list '
            'element into a CustomScrollView. Here are the most common patterns.',
        Icons.lightbulb,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          children: cases.map((c) => Container(
            margin: EdgeInsets.only(bottom: 6),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: (c['color'] as Color).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border(left: BorderSide(color: c['color'] as Color, width: 3)),
            ),
            child: Row(
              children: [
                Icon(c['icon'] as IconData, size: 18, color: c['color'] as Color),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: c['color'] as Color)),
                      Text(c['desc'] as String, style: TextStyle(fontSize: 10, color: _taTextMedium)),
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
// Section 6: Multiple Adapters Demo
// ---------------------------------------------------------------------------
Widget _taSection6MultiAdapters() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('6 · Multiple Adapters in Action', Icons.view_agenda),
      _taInfoCard(
        'Mix and match slivers freely',
        'You can interleave any number of SliverToBoxAdapters with '
            'SliverList, SliverGrid, and other slivers. Each adapter '
            'independently participates in the sliver layout protocol.',
        Icons.dashboard,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _taSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('Scrollable with mixed slivers', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _taTextDark)),
            ),
            SizedBox(
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    // Header adapter
                    SliverToBoxAdapter(
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [_taPrimary, _taAccent]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.view_in_ar, color: _taOnPrimary, size: 20),
                            Text('Header Adapter', style: TextStyle(color: _taOnPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    // List section
                    SliverList.builder(
                      itemCount: 4,
                      itemBuilder: (ctx, i) => Container(
                        height: 36,
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _taBlue.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _taDivider.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12),
                        child: Text('List item ${i + 1}', style: TextStyle(fontSize: 11, color: _taTextDark)),
                      ),
                    ),
                    // Divider adapter
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _taTeal.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _taTeal.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, size: 16, color: _taTeal),
                            SizedBox(width: 8),
                            Text('Section divider adapter', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _taTeal)),
                          ],
                        ),
                      ),
                    ),
                    // Grid section
                    SliverGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1.5,
                      children: List.generate(6, (i) => Container(
                        decoration: BoxDecoration(
                          color: _taOrange.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _taOrange.withValues(alpha: 0.3)),
                        ),
                        alignment: Alignment.center,
                        child: Text('G${i + 1}', style: TextStyle(fontSize: 10, color: _taOrange, fontWeight: FontWeight.w600)),
                      )),
                    ),
                    // Footer adapter
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _taGrey.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _taGrey.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.center,
                        child: Text('Footer adapter — end of content', style: TextStyle(fontSize: 11, color: _taGrey)),
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
// Section 7: With SliverAppBar and SliverList
// ---------------------------------------------------------------------------
Widget _taSection7WithAppBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('7 · With SliverAppBar & SliverList', Icons.web),
      _taInfoCard(
        'The classic scroll view pattern',
        'The most common CustomScrollView pattern: SliverAppBar at the top, '
            'SliverToBoxAdapter for search or banners, SliverList for the main '
            'content. Each is a separate sliver in the viewport.',
        Icons.layers,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _taSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Text('SliverAppBar + SliverToBoxAdapter + SliverList', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _taTextDark)),
            ),
            SizedBox(
              height: 340,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: _taAccent,
                      expandedHeight: 100,
                      floating: true,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Coral App', style: TextStyle(fontSize: 14)),
                        background: Container(color: _taAccent),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _taDivider),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 18, color: _taGrey),
                            SizedBox(width: 8),
                            Text('Search items...', style: TextStyle(fontSize: 12, color: _taGrey)),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _taPrimary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _taPrimary.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.campaign, size: 16, color: _taPrimary),
                            SizedBox(width: 8),
                            Expanded(child: Text('Promotional banner via SliverToBoxAdapter', style: TextStyle(fontSize: 11, color: _taPrimary))),
                          ],
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: 20,
                      itemBuilder: (ctx, i) => Container(
                        height: 44,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: i % 2 == 0 ? Colors.white : _taSurface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _taDivider.withValues(alpha: 0.2)),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(
                                color: _taPrimary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: Text('${i + 1}', style: TextStyle(fontSize: 10, color: _taPrimary, fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 10),
                            Text('List item ${i + 1}', style: TextStyle(fontSize: 12, color: _taTextDark)),
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
// Section 8: Edge Cases and Gotchas
// ---------------------------------------------------------------------------
Widget _taSection8EdgeCases() {
  final gotchas = <Map<String, dynamic>>[
    {
      'title': 'Unconstrained child height',
      'desc': 'A child with no height constraint (e.g. unbounded Column) '
          'may overflow. Always give the child a defined size.',
      'icon': Icons.warning,
      'color': _taOrange,
    },
    {
      'title': 'Too many adapters',
      'desc': 'Using 50+ SliverToBoxAdapters instead of a SliverList is '
          'wasteful — each has its own render object overhead.',
      'icon': Icons.report,
      'color': _taAccent,
    },
    {
      'title': 'No lazy building',
      'desc': 'Unlike SliverList, SliverToBoxAdapter always builds its child. '
          'It cannot defer construction to when items scroll into view.',
      'icon': Icons.memory,
      'color': _taPurple,
    },
    {
      'title': 'Horizontal scrolling',
      'desc': 'For horizontal CustomScrollViews, the adapter constrains height '
          '(cross-axis) tightly and leaves width (main-axis) unbounded.',
      'icon': Icons.swap_horiz,
      'color': _taBlue,
    },
    {
      'title': 'Scroll position calculation',
      'desc': 'The adapter does not know its own absolute scroll position. Use '
          'ScrollController to query viewport offset if needed.',
      'icon': Icons.straight,
      'color': _taTeal,
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('8 · Edge Cases & Gotchas', Icons.warning_amber),
      _taInfoCard(
        'Things to watch out for',
        'SliverToBoxAdapter is straightforward, but there are pitfalls '
            'that can lead to layout errors or performance issues.',
        Icons.visibility,
      ),
      ...gotchas.map((g) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: g['color'] as Color, width: 3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(g['icon'] as IconData, size: 18, color: g['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _taTextDark)),
                  SizedBox(height: 2),
                  Text(g['desc'] as String, style: TextStyle(fontSize: 11, color: _taTextMedium)),
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
// Section 9: Summary
// ---------------------------------------------------------------------------
Widget _taSection9Summary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _taSectionTitle('9 · Summary & Reference', Icons.menu_book),
      _taInfoCard(
        'Key takeaways',
        'RenderSliverToBoxAdapter is simple but essential. It bridges '
            'box ↔ sliver protocols for exactly one child. Almost every '
            'CustomScrollView uses at least one SliverToBoxAdapter.',
        Icons.lightbulb,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taDivider),
        ),
        child: Column(
          children: [
            ...<Map<String, String>>[
              {'label': 'Widget', 'value': 'SliverToBoxAdapter'},
              {'label': 'Render object', 'value': 'RenderSliverToBoxAdapter'},
              {'label': 'Base class', 'value': 'RenderSliverSingleBoxAdapter'},
              {'label': 'Child count', 'value': 'Exactly one RenderBox'},
              {'label': 'Main-axis constraint', 'value': 'Unconstrained'},
              {'label': 'Cross-axis constraint', 'value': 'Tight (viewport width)'},
              {'label': 'Lazy building', 'value': 'No — always built'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _taDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(r['label']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _taTextDark)),
                  ),
                  Expanded(child: Text(r['value']!, style: TextStyle(fontSize: 11, color: _taPrimary, fontWeight: FontWeight.w600))),
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
            colors: [_taPrimary.withValues(alpha: 0.08), _taAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _taPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.view_in_ar, size: 32, color: _taPrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverToBoxAdapter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _taTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The concrete adapter that turns any box widget into a sliver — '
              'the most used sliver adapter in Flutter applications.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _taTextMedium, height: 1.4),
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
              colors: [_taPrimary, _taAccent],
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
                  Icon(Icons.view_in_ar, color: _taOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverToBoxAdapter',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _taOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'The concrete adapter that places any box widget in a sliver context',
                style: TextStyle(fontSize: 12, color: _taOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _taSection1Overview(),
        _taSection2Wrapping(),
        _taSection3Layout(),
        _taSection4Painting(),
        _taSection5UseCases(),
        _taSection6MultiAdapters(),
        _taSection7WithAppBar(),
        _taSection8EdgeCases(),
        _taSection9Summary(),

        SizedBox(height: 24),
      ],
    ),
  );
}
