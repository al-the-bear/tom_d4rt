// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderSliverVariedExtentList
//
// RenderSliverVariedExtentList is a sliver that lays out its children in a
// linear arrangement where each child can have a different main-axis extent
// (height for vertical, width for horizontal). Unlike SliverFixedExtentList
// where all items share the same extent, varied-extent lists allow per-item
// sizing — useful for things like message lists, feeds, or catalogs where
// items have varying heights.
//
// The widget counterpart is SliverVariedExtentList, which takes an
// itemExtentBuilder callback that returns the extent for each index.
//
// This demo visualises:
//   1. Overview — varied vs fixed extent lists
//   2. The itemExtentBuilder callback — how extents are provided
//   3. Layout protocol — efficient position calculation
//   4. Scroll offset ↔ index mapping — binary search
//   5. Performance characteristics — compared to SliverList
//   6. Visual demo — items with different heights
//   7. Use-cases — feeds, messages, heterogeneous lists
//   8. Comparison table — FixedExtent vs VariedExtent vs SliverList
//   9. Best practices
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Emerald / Jade
// ---------------------------------------------------------------------------
const Color _vePrimary = Color(0xFF2E7D32);
const Color _vePrimaryLight = Color(0xFF4CAF50);
const Color _veAccent = Color(0xFF1B5E20);
const Color _veAccentLight = Color(0xFFC8E6C9);
const Color _veSurface = Color(0xFFF1F8E9);
const Color _veSurfaceDark = Color(0xFFDCEDC8);
const Color _veOnPrimary = Color(0xFFFFFFFF);
const Color _veTextDark = Color(0xFF1B5E20);
const Color _veTextMedium = Color(0xFF33691E);
const Color _veDivider = Color(0xFFA5D6A7);
const Color _veBlue = Color(0xFF1565C0);
const Color _veOrange = Color(0xFFE65100);
const Color _veTeal = Color(0xFF00695C);
const Color _veGrey = Color(0xFF757575);
const Color _veAmber = Color(0xFFF57F17);
const Color _vePurple = Color(0xFF6A1B9A);
const Color _veRed = Color(0xFFC62828);
const Color _veIndigo = Color(0xFF283593);
const Color _veBrown = Color(0xFF4E342E);

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _veSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _vePrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _veTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _veDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _veBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _veInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _vePrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _veSurface,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _veTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _veTextMedium, height: 1.4)),
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
Widget _veCode(String text, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _veSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color ?? _veAccent, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview
// ---------------------------------------------------------------------------
Widget _veSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _veSectionTitle('1 · Varied Extent List Overview', Icons.view_list),
      _veInfoCard(
        'What is RenderSliverVariedExtentList?',
        'A sliver render object that lays out children in a linear list '
            'where each child can have a different main-axis extent. Unlike '
            'SliverFixedExtentList (all items same height), this allows '
            'per-item sizing through an itemExtentBuilder callback.',
        Icons.height,
      ),
      _veInfoCard(
        'Why not just use SliverList?',
        'SliverList has to lay out each child to discover its size. '
            'VariedExtentList knows sizes up front from the callback, enabling '
            'efficient scroll-offset-to-index mapping without building all items.',
        Icons.speed,
        accent: _veAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Extent comparison', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _veTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _veBadge('FixedExtent', _veBlue, _veOnPrimary),
                      SizedBox(height: 6),
                      ...List.generate(4, (_) => Container(
                        height: 24, width: double.infinity,
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(color: _veBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                        alignment: Alignment.center,
                        child: Text('same height', style: TextStyle(fontSize: 8, color: _veBlue)),
                      )),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      _veBadge('VariedExtent', _vePrimary, _veOnPrimary),
                      SizedBox(height: 6),
                      ...[20.0, 32.0, 16.0, 28.0].map((h) => Container(
                        height: h, width: double.infinity,
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(color: _vePrimary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                        alignment: Alignment.center,
                        child: Text('${h.toInt()}px', style: TextStyle(fontSize: 8, color: _vePrimary)),
                      )),
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
// Section 2: itemExtentBuilder
// ---------------------------------------------------------------------------
Widget _veSection2Builder() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('2 · The itemExtentBuilder Callback', Icons.functions),
      _veInfoCard(
        'Providing per-item extents',
        'itemExtentBuilder is a callback (int index, SliverLayoutDimensions) → double? '
            'that returns the extent for each item. Return null to signal no more items. '
            'The framework calls this during layout to position and build only visible items.',
        Icons.code,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _veCode('SliverVariedExtentList('),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _veCode('delegate: SliverChildBuilderDelegate('),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: _veCode('(ctx, i) => ItemWidget(i),'),
                  ),
                  _veCode('),'),
                  _veCode('itemExtentBuilder: (i, dimensions) {'),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _veCode('// Return height for item at index i', color: _veGrey),
                        _veCode('return itemHeights[i];'),
                      ],
                    ),
                  ),
                  _veCode('},'),
                ],
              ),
            ),
            _veCode(')'),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _veAmber.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _veAmber, width: 3)),
              ),
              child: Text(
                'The callback receives SliverLayoutDimensions which includes '
                    'crossAxisExtent, viewportMainAxisExtent, and precedingScrollExtent — '
                    'useful for sizing items based on available space.',
                style: TextStyle(fontSize: 10, color: _veTextMedium),
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
Widget _veSection3Layout() {
  final steps = <Map<String, dynamic>>[
    {'label': 'Receive sliver constraints', 'detail': 'scrollOffset, remainingPaintExtent, crossAxisExtent', 'color': _veBlue},
    {'label': 'Compute cumulative offsets', 'detail': 'Sum up item extents from 0..N to find positions', 'color': _vePrimary},
    {'label': 'Find first visible index', 'detail': 'Binary search: which item\'s offset >= scrollOffset', 'color': _veTeal},
    {'label': 'Build visible items only', 'detail': 'Create widgets from firstVisible to lastVisible', 'color': _veOrange},
    {'label': 'Position children', 'detail': 'Each child at its cumulative offset minus scrollOffset', 'color': _vePurple},
    {'label': 'Report SliverGeometry', 'detail': 'scrollExtent = total of all extents, paintExtent = visible portion', 'color': _veAccent},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('3 · Layout Protocol', Icons.grid_on),
      _veInfoCard(
        'Efficient layout with known extents',
        'Because all extents are known ahead of time, the layout can use '
            'cumulative offset arrays and binary search to find the first '
            'and last visible items without building everything.',
        Icons.bolt,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          children: steps.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Container(
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
                    child: Text('${i + 1}', style: TextStyle(fontSize: 10, color: _veOnPrimary, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['label'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: s['color'] as Color)),
                        Text(s['detail'] as String, style: TextStyle(fontSize: 10, color: _veTextMedium)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Scroll Offset to Index Mapping
// ---------------------------------------------------------------------------
Widget _veSection4ScrollMapping() {
  final items = <Map<String, dynamic>>[
    {'index': 0, 'extent': 60.0, 'offset': 0.0},
    {'index': 1, 'extent': 40.0, 'offset': 60.0},
    {'index': 2, 'extent': 80.0, 'offset': 100.0},
    {'index': 3, 'extent': 50.0, 'offset': 180.0},
    {'index': 4, 'extent': 70.0, 'offset': 230.0},
    {'index': 5, 'extent': 45.0, 'offset': 300.0},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('4 · Scroll Offset → Index Mapping', Icons.search),
      _veInfoCard(
        'Binary search for fast lookup',
        'Given a scroll offset, which item is at that position? With known '
            'extents, compute cumulative offsets and binary search. This is '
            'O(log n) — much faster than SliverList\'s O(n) approach.',
        Icons.bolt,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cumulative offset table', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _veTextDark)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              color: _veSurface,
              child: Row(
                children: [
                  SizedBox(width: 40, child: Text('Index', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veTextDark))),
                  SizedBox(width: 50, child: Text('Extent', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veTextDark))),
                  Expanded(child: Text('Offset', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veTextDark))),
                ],
              ),
            ),
            ...items.map((item) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _veDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 40, child: Text('${item['index']}', style: TextStyle(fontSize: 10, color: _vePrimary, fontWeight: FontWeight.w600))),
                  SizedBox(width: 50, child: Text('${(item['extent'] as double).toInt()}px', style: TextStyle(fontSize: 10, color: _veTextMedium))),
                  Expanded(child: Text('${(item['offset'] as double).toInt()}px', style: TextStyle(fontSize: 10, color: _veAccent, fontWeight: FontWeight.w600))),
                ],
              ),
            )),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _veTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
                border: Border(left: BorderSide(color: _veTeal, width: 3)),
              ),
              child: Text(
                'Example: scroll offset = 150 → binary search → item 2 '
                    '(offset 100, extent 80, so 150 is within item 2).',
                style: TextStyle(fontSize: 10, color: _veTextMedium),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Performance Characteristics
// ---------------------------------------------------------------------------
Widget _veSection5Performance() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('5 · Performance Characteristics', Icons.speed),
      _veInfoCard(
        'Better than SliverList for known sizes',
        'When item heights are known in advance, VariedExtentList avoids '
            'the need to build and measure items just to discover their sizes. '
            'Scrollbar accuracy is also improved because total extent is always known.',
        Icons.trending_up,
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          children: [
            // Header row
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              color: _veSurface,
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('Operation', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veTextDark))),
                  Expanded(child: Text('SliverList', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veRed))),
                  Expanded(child: Text('VariedExtent', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _vePrimary))),
                  Expanded(child: Text('FixedExtent', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _veBlue))),
                ],
              ),
            ),
            ...[
              {'op': 'Find first visible', 'list': 'O(n) build', 'varied': 'O(log n)', 'fixed': 'O(1)'},
              {'op': 'Jump to index', 'list': 'O(n) build', 'varied': 'O(n) sum', 'fixed': 'O(1) multiply'},
              {'op': 'Total extent', 'list': 'Estimated', 'varied': 'O(n) sum', 'fixed': 'O(1) multiply'},
              {'op': 'Scrollbar', 'list': 'Approximate', 'varied': 'Accurate', 'fixed': 'Accurate'},
              {'op': 'Item flexibility', 'list': 'Any size', 'varied': 'Known sizes', 'fixed': 'All same size'},
            ].map((r) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: _veDivider.withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text(r['op']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _veTextDark))),
                  Expanded(child: Text(r['list']!, style: TextStyle(fontSize: 10, color: _veRed))),
                  Expanded(child: Text(r['varied']!, style: TextStyle(fontSize: 10, color: _vePrimary))),
                  Expanded(child: Text(r['fixed']!, style: TextStyle(fontSize: 10, color: _veBlue))),
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
// Section 6: Visual Demo
// ---------------------------------------------------------------------------
Widget _veSection6Demo() {
  final itemData = <Map<String, dynamic>>[
    {'height': 80.0, 'label': 'Hero Card', 'icon': Icons.star, 'color': _vePrimary},
    {'height': 50.0, 'label': 'Compact Item', 'icon': Icons.short_text, 'color': _veBlue},
    {'height': 100.0, 'label': 'Feature Highlight', 'icon': Icons.lightbulb, 'color': _veOrange},
    {'height': 40.0, 'label': 'Tag Bar', 'icon': Icons.label, 'color': _veTeal},
    {'height': 70.0, 'label': 'Description', 'icon': Icons.description, 'color': _vePurple},
    {'height': 55.0, 'label': 'Action Row', 'icon': Icons.touch_app, 'color': _veAccent},
    {'height': 90.0, 'label': 'Image Preview', 'icon': Icons.image, 'color': _veAmber},
    {'height': 45.0, 'label': 'Meta Info', 'icon': Icons.info, 'color': _veIndigo},
    {'height': 65.0, 'label': 'Comments', 'icon': Icons.chat, 'color': _veBrown},
    {'height': 55.0, 'label': 'Related Items', 'icon': Icons.link, 'color': _veRed},
    {'height': 75.0, 'label': 'Statistics', 'icon': Icons.bar_chart, 'color': _vePrimary},
    {'height': 50.0, 'label': 'Footer Note', 'icon': Icons.note, 'color': _veGrey},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('6 · Visual Demo – Varied Heights', Icons.preview),
      _veInfoCard(
        'Each item has a different height',
        'This demo shows a CustomScrollView with SliverVariedExtentList. '
            'The extents are provided by itemExtentBuilder, each item rendering '
            'at a unique height. Scroll to see the varied sizing in action.',
        Icons.play_circle,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _veSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 4),
              child: Row(
                children: [
                  Text('SliverVariedExtentList', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _veTextDark)),
                  SizedBox(width: 6),
                  _veBadge('12 items, varied heights', _vePrimary, _veOnPrimary),
                ],
              ),
            ),
            SizedBox(
              height: 360,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomScrollView(
                  slivers: [
                    SliverVariedExtentList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) {
                          if (i >= itemData.length) return null;
                          final item = itemData[i];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: (item['color'] as Color).withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Icon(item['icon'] as IconData, size: 20, color: item['color'] as Color),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['label'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: item['color'] as Color)),
                                      Text('Height: ${(item['height'] as double).toInt()}px · Index: $i', style: TextStyle(fontSize: 9, color: _veTextMedium)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: _veBadge('${(item['height'] as double).toInt()}px', (item['color'] as Color).withValues(alpha: 0.2), item['color'] as Color),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: itemData.length,
                      ),
                      itemExtentBuilder: (i, _) {
                        if (i >= itemData.length) return null;
                        return itemData[i]['height'] as double;
                      },
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
// Section 7: Use-Cases
// ---------------------------------------------------------------------------
Widget _veSection7UseCases() {
  final cases = <Map<String, dynamic>>[
    {'title': 'Chat / messaging', 'desc': 'Messages vary in length — pre-compute heights from text measurement', 'icon': Icons.chat, 'color': _vePrimary},
    {'title': 'Social feed', 'desc': 'Feed cards with images have different heights based on content type', 'icon': Icons.dynamic_feed, 'color': _veBlue},
    {'title': 'Product catalog', 'desc': 'Products with different description lengths need variable card heights', 'icon': Icons.shopping_bag, 'color': _veOrange},
    {'title': 'Mixed-type content', 'desc': 'Headers (60px), regular items (48px), and spacers (24px) in one list', 'icon': Icons.view_stream, 'color': _veTeal},
    {'title': 'Calendar timeline', 'desc': 'Events with varying durations mapped to pixel heights', 'icon': Icons.calendar_today, 'color': _vePurple},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('7 · Use-Cases', Icons.apps),
      _veInfoCard(
        'When to reach for VariedExtentList',
        'Any time you know item heights in advance but they differ per item, '
            'VariedExtentList gives you the performance of FixedExtentList '
            'with the flexibility of SliverList.',
        Icons.tips_and_updates,
      ),
      ...cases.map((c) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: c['color'] as Color, width: 3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(c['icon'] as IconData, size: 18, color: c['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _veTextDark)),
                  SizedBox(height: 2),
                  Text(c['desc'] as String, style: TextStyle(fontSize: 11, color: _veTextMedium)),
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
// Section 8: Comparison Table
// ---------------------------------------------------------------------------
Widget _veSection8Comparison() {
  final rows = <Map<String, String>>[
    {'aspect': 'Class', 'fixed': 'SliverFixedExtentList', 'varied': 'SliverVariedExtentList', 'sliver': 'SliverList'},
    {'aspect': 'Extent source', 'fixed': 'itemExtent (double)', 'varied': 'itemExtentBuilder', 'sliver': 'Child layout'},
    {'aspect': 'All same size?', 'fixed': 'Yes (required)', 'varied': 'No (each unique)', 'sliver': 'No'},
    {'aspect': 'Pre-known sizes?', 'fixed': 'Yes', 'varied': 'Yes', 'sliver': 'No'},
    {'aspect': 'Jump to index', 'fixed': 'O(1)', 'varied': 'O(n) sum', 'sliver': 'O(n) build'},
    {'aspect': 'Scrollbar', 'fixed': 'Exact', 'varied': 'Exact', 'sliver': 'Estimated'},
    {'aspect': 'Best for', 'fixed': 'Uniform lists', 'varied': 'Heterogeneous known', 'sliver': 'Unknown sizes'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('8 · Comparison Table', Icons.compare),
      _veInfoCard(
        'Three sliver list types side by side',
        'Fixed, varied, and standard SliverList each have different '
            'trade-offs. Choose based on whether you know extents and '
            'whether they are uniform.',
        Icons.table_chart,
      ),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _veDivider),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              color: _veSurface,
              child: Row(
                children: [
                  SizedBox(width: 70, child: Text('Aspect', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _veTextDark))),
                  Expanded(child: Text('FixedExtent', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _veBlue))),
                  Expanded(child: Text('VariedExtent', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _vePrimary))),
                  Expanded(child: Text('SliverList', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _veOrange))),
                ],
              ),
            ),
            ...rows.map((r) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _veDivider.withValues(alpha: 0.3)))),
              child: Row(
                children: [
                  SizedBox(width: 70, child: Text(r['aspect']!, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: _veTextDark))),
                  Expanded(child: Text(r['fixed']!, style: TextStyle(fontSize: 9, color: _veBlue))),
                  Expanded(child: Text(r['varied']!, style: TextStyle(fontSize: 9, color: _vePrimary))),
                  Expanded(child: Text(r['sliver']!, style: TextStyle(fontSize: 9, color: _veOrange))),
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
// Section 9: Best Practices
// ---------------------------------------------------------------------------
Widget _veSection9Practices() {
  final tips = <Map<String, dynamic>>[
    {'text': 'Pre-compute extents from data — avoid complex calculations in the builder callback', 'color': _vePrimary},
    {'text': 'Cache cumulative offsets if you need scrollTo(index) — avoid O(n) on every jump', 'color': _veTeal},
    {'text': 'Use FixedExtentList when all items truly have the same size — simpler and faster', 'color': _veBlue},
    {'text': 'Return null from the builder at the correct count to signal end of list', 'color': _veOrange},
    {'text': 'Consider VariedExtentList when scrollbar accuracy matters and items differ in size', 'color': _vePurple},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _veSectionTitle('9 · Best Practices', Icons.star),
      _veInfoCard(
        'Getting the most from VariedExtentList',
        'The key advantage is knowing sizes up front. Make sure the '
            'itemExtentBuilder is fast and deterministic.',
        Icons.tips_and_updates,
      ),
      ...tips.asMap().entries.map((e) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: e.value['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, size: 16, color: e.value['color'] as Color),
            SizedBox(width: 8),
            Expanded(child: Text(e.value['text'] as String, style: TextStyle(fontSize: 11, color: _veTextMedium))),
          ],
        ),
      )),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_vePrimary.withValues(alpha: 0.08), _veAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _vePrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.view_list, size: 32, color: _vePrimary),
            SizedBox(height: 8),
            Text(
              'RenderSliverVariedExtentList',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _veTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Per-item extents with up-front knowledge — bridging the gap '
              'between fixed and dynamic sliver lists.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _veTextMedium, height: 1.4),
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
              colors: [_vePrimary, _veAccent],
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
                  Icon(Icons.view_list, color: _veOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderSliverVariedExtentList',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _veOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Sliver lists where each item has a different extent',
                style: TextStyle(fontSize: 12, color: _veOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _veSection1Overview(),
        _veSection2Builder(),
        _veSection3Layout(),
        _veSection4ScrollMapping(),
        _veSection5Performance(),
        _veSection6Demo(),
        _veSection7UseCases(),
        _veSection8Comparison(),
        _veSection9Practices(),

        SizedBox(height: 24),
      ],
    ),
  );
}
