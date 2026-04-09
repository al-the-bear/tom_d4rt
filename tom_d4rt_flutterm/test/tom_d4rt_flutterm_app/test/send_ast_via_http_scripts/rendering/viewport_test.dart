// ignore_for_file: avoid_print
// D4rt deep-demo: Viewport & Scroll Rendering — Pine / Cedar theme, prefix vp
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget vpSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF2E7D32), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFF1B5E20))),
        ),
      ],
    ),
  );
}

Widget vpChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12.0)),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget vpInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140.0,
          child: Text(label, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF1B5E20)))),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 12.0, color: Color(0xFF4E6B4E)))),
      ],
    ),
  );
}

Widget vpCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(color: Color(0xFFF1F8E9), borderRadius: BorderRadius.circular(6.0)),
    child: Text(code, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF1B5E20))),
  );
}

Widget vpScrollBar(double fraction, Color accent) {
  return Container(
    width: 8.0, height: 80.0,
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Align(
      alignment: Alignment(0.0, -1.0 + fraction * 2.0),
      child: Container(
        width: 8.0, height: 24.0,
        decoration: BoxDecoration(
          color: accent, borderRadius: BorderRadius.circular(4.0)),
      ),
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] Viewport & Scroll Rendering');
  print('  ViewportOffset,ScrollDirection, BoxParentData');
  print('  Scroll mechanics at the rendering layer');

  final vpTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_vert, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('Viewport & Scroll Rendering',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Low-level scroll position, direction, and viewport rendering',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFC8E6C9))),
        SizedBox(height: 8.0),
        Wrap(children: [
          vpChip('ViewportOffset', Color(0xFF43A047)),
          vpChip('ScrollDirection', Color(0xFF388E3C)),
          vpChip('BoxParentData', Color(0xFF2E7D32)),
          vpChip('Slivers', Color(0xFF1B5E20)),
        ]),
      ],
    ),
  );

  // ── Section 2: ViewportOffset ────────────────────────────────
  print('\n[2] ViewportOffset');
  final fixedOffset = ViewportOffset.fixed(100.0);
  final zeroOffset = ViewportOffset.zero();
  print('  fixed(100): pixels=${fixedOffset.pixels}');
  print('  zero(): pixels=${zeroOffset.pixels}');
  print('  hasPixels: ${fixedOffset.hasPixels}');

  final vpOffsetSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Abstract base class for scroll positions in viewports',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Icon(Icons.looks_one, color: Color(0xFF2E7D32), size: 24.0),
                    SizedBox(height: 4.0),
                    Text('fixed(100.0)', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF1B5E20))),
                    Text('pixels: ${fixedOffset.pixels}', style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                    Text('hasPixels: ${fixedOffset.hasPixels}', style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Icon(Icons.exposure_zero, color: Color(0xFF2E7D32), size: 24.0),
                    SizedBox(height: 4.0),
                    Text('zero()', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF1B5E20))),
                    Text('pixels: ${zeroOffset.pixels}', style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                    Text('hasPixels: ${zeroOffset.hasPixels}', style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        vpCodeBlock('final offset = ViewportOffset.fixed(100.0);\nprint(offset.pixels); // 100.0'),
      ],
    ),
  );

  // ── Section 3: ViewportOffset Properties ─────────────────────
  print('\n[3] ViewportOffset Properties & Methods');
  print('  pixels: current scroll position');
  print('  hasPixels: whether pixels value available');
  print('  userScrollDirection: ${fixedOffset.userScrollDirection}');
  print('  allowImplicitScrolling: ${fixedOffset.allowImplicitScrolling}');

  final offsetProps = <Map<String, dynamic>>[
    {'prop': 'pixels', 'type': 'double', 'color': Color(0xFF43A047),
     'desc': 'Current scroll offset in logical pixels'},
    {'prop': 'hasPixels', 'type': 'bool', 'color': Color(0xFF388E3C),
     'desc': 'Whether the pixels value is available yet'},
    {'prop': 'userScrollDirection', 'type': 'ScrollDirection', 'color': Color(0xFF2E7D32),
     'desc': 'Direction user is scrolling (idle/forward/reverse)'},
    {'prop': 'allowImplicitScrolling', 'type': 'bool', 'color': Color(0xFF1B5E20),
     'desc': 'Whether accessibility tools can trigger scrolling'},
  ];

  final vpPropsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: offsetProps.map((op) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border(left: BorderSide(color: op['color'] as Color, width: 3.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(op['prop'] as String,
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: op['color'] as Color)),
                SizedBox(width: 6.0),
                vpChip(op['type'] as String, (op['color'] as Color).withValues(alpha: 0.7)),
              ]),
              Text(op['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 4: ViewportOffset Methods ────────────────────────
  print('\n[4] ViewportOffset Methods');
  final applyResult = fixedOffset.applyViewportDimension(200.0);
  final contentResult = fixedOffset.applyContentDimensions(0.0, 500.0);
  print('  applyViewportDimension(200): $applyResult');
  print('  applyContentDimensions(0, 500): $contentResult');

  final offsetMethods = <Map<String, dynamic>>[
    {'method': 'applyViewportDimension()', 'color': Color(0xFF43A047),
     'sig': 'bool applyViewportDimension(double viewportDimension)',
     'desc': 'Called when viewport size changes; returns whether layout is needed'},
    {'method': 'applyContentDimensions()', 'color': Color(0xFF388E3C),
     'sig': 'bool applyContentDimensions(double minScrollExtent, double maxScrollExtent)',
     'desc': 'Called when content extent changes; returns whether scroll is valid'},
    {'method': 'correctBy()', 'color': Color(0xFF2E7D32),
     'sig': 'void correctBy(double correction)',
     'desc': 'Adjust scroll position without triggering notification'},
    {'method': 'jumpTo()', 'color': Color(0xFF1B5E20),
     'sig': 'void jumpTo(double pixels)',
     'desc': 'Jump to position without animation'},
  ];

  final vpMethodsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: offsetMethods.map((om) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(om['method'] as String,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: om['color'] as Color)),
              SizedBox(height: 2.0),
              Text(om['sig'] as String,
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF1B5E20))),
              SizedBox(height: 4.0),
              Text(om['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 5: ScrollDirection ───────────────────────────────
  print('\n[5] ScrollDirection Enum');
  for (final dir in ScrollDirection.values) {
    print('  ${dir.name}: index=${dir.index}');
  }

  final directions = <Map<String, dynamic>>[
    {'value': ScrollDirection.idle, 'icon': Icons.pause_circle_outline,
     'color': Color(0xFF43A047), 'desc': 'User is not scrolling'},
    {'value': ScrollDirection.forward, 'icon': Icons.arrow_upward,
     'color': Color(0xFF2E7D32), 'desc': 'Content moving down (finger up)'},
    {'value': ScrollDirection.reverse, 'icon': Icons.arrow_downward,
     'color': Color(0xFF1B5E20), 'desc': 'Content moving up (finger down)'},
  ];

  final vpDirectionSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Direction of user scroll gesture',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: directions.map((d) {
            final dir = d['value'] as ScrollDirection;
            return Container(
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: (d['color'] as Color).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(d['icon'] as IconData, color: d['color'] as Color, size: 28.0),
                  SizedBox(height: 4.0),
                  Text(dir.name, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: d['color'] as Color)),
                  Text('index: ${dir.index}', style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF4E6B4E))),
                  SizedBox(height: 2.0),
                  Text(d['desc'] as String, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.0, color: Color(0xFF4E6B4E))),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ── Section 6: BoxParentData ─────────────────────────────────
  print('\n[6] BoxParentData');
  final parentData = BoxParentData();
  print('  Default offset: ${parentData.offset}');

  final vpParentDataSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Parent-owned data for positioning child RenderBoxes',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        vpInfoRow('offset:', parentData.offset.toString()),
        vpInfoRow('Type:', 'Extends ParentData'),
        vpInfoRow('Used by:', 'RenderBox children'),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFC8E6C9)),
          ),
          child: Stack(
            children: [
              Positioned(left: 8.0, top: 8.0,
                child: Text('Parent RenderBox', style: TextStyle(fontSize: 9.0, color: Color(0xFF4E6B4E)))),
              Positioned(left: 30.0, top: 30.0,
                child: Container(
                  width: 80.0, height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.15),
                    border: Border.all(color: Color(0xFF2E7D32), width: 1.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(child: Text('Child\noffset: (30,30)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Color(0xFF1B5E20)))),
                ),
              ),
              Positioned(left: 160.0, top: 20.0,
                child: Container(
                  width: 80.0, height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF43A047).withValues(alpha: 0.15),
                    border: Border.all(color: Color(0xFF43A047), width: 1.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(child: Text('Child\noffset: (160,20)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Color(0xFF2E7D32)))),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        vpCodeBlock('final data = BoxParentData();\ndata.offset = Offset(30.0, 30.0);'),
      ],
    ),
  );

  // ── Section 7: Viewport Architecture ─────────────────────────
  print('\n[7] Viewport Architecture');
  print('  RenderViewport → RenderSliverList');
  print('  Manages visible portion of scrollable content');

  final archLayers = <Map<String, dynamic>>[
    {'name': 'ScrollView', 'level': 'Widget', 'color': Color(0xFF43A047),
     'desc': 'High-level scrollable widget API'},
    {'name': 'Scrollable', 'level': 'Widget', 'color': Color(0xFF388E3C),
     'desc': 'Manages scroll gestures and notifications'},
    {'name': 'Viewport', 'level': 'Widget', 'color': Color(0xFF2E7D32),
     'desc': 'Creates RenderViewport with slivers'},
    {'name': 'RenderViewport', 'level': 'RenderObject', 'color': Color(0xFF1B5E20),
     'desc': 'Layout engine for scrollable content'},
  ];

  final vpArchSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: archLayers.map((al) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Container(
                width: 4.0, height: 40.0,
                color: al['color'] as Color,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(al['name'] as String,
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace', color: al['color'] as Color)),
                            Text(al['desc'] as String,
                                style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                          ],
                        ),
                      ),
                      vpChip(al['level'] as String, (al['color'] as Color).withValues(alpha: 0.7)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: Sliver Layout Protocol ────────────────────────
  print('\n[8] Sliver Layout Protocol');
  print('  SliverConstraints → performLayout → SliverGeometry');
  print('  Viewport asks slivers how much space they need');

  final sliverSteps = <Map<String, dynamic>>[
    {'step': '1', 'title': 'Viewport sends SliverConstraints', 'icon': Icons.arrow_downward,
     'desc': 'scrollOffset, remainingPaintExtent, crossAxisExtent'},
    {'step': '2', 'title': 'Sliver performs layout', 'icon': Icons.straighten,
     'desc': 'Computes visible children, sizes, offsets'},
    {'step': '3', 'title': 'Sliver returns SliverGeometry', 'icon': Icons.arrow_upward,
     'desc': 'scrollExtent, paintExtent, maxPaintExtent, layoutExtent'},
    {'step': '4', 'title': 'Viewport positions sliver', 'icon': Icons.open_with,
     'desc': 'Places sliver in viewport using paintOffset'},
  ];

  final vpSliverSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: sliverSteps.map((ss) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 32.0, height: 32.0,
                decoration: BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                child: Center(child: Text(ss['step'] as String,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0))),
              ),
              SizedBox(width: 10.0),
              Icon(ss['icon'] as IconData, color: Color(0xFF2E7D32), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ss['title'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFF1B5E20))),
                    Text(ss['desc'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 9: SliverConstraints ─────────────────────────────
  print('\n[9] SliverConstraints Key Properties');

  final constraintProps = <Map<String, dynamic>>[
    {'prop': 'scrollOffset', 'desc': 'How far content has scrolled past this sliver'},
    {'prop': 'remainingPaintExtent', 'desc': 'Visible space remaining in viewport'},
    {'prop': 'crossAxisExtent', 'desc': 'Width (vertical scroll) or height'},
    {'prop': 'overlap', 'desc': 'Overlap from previous sliver (for app bars)'},
    {'prop': 'cacheOrigin', 'desc': 'Start of cache area relative to sliver'},
    {'prop': 'remainingCacheExtent', 'desc': 'Total cache area remaining'},
  ];

  final vpConstraintSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: constraintProps.asMap().entries.map((entry) {
        final cp = entry.value;
        final shade = Color.lerp(Color(0xFF43A047), Color(0xFF1B5E20), entry.key / constraintProps.length)!;
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Container(width: 8.0, height: 8.0,
                decoration: BoxDecoration(color: shade, shape: BoxShape.circle)),
              SizedBox(width: 8.0),
              SizedBox(width: 130.0,
                child: Text(cp['prop'] as String,
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, fontFamily: 'monospace', color: shade))),
              Expanded(child: Text(cp['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E)))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 10: SliverGeometry ───────────────────────────────
  print('\n[10] SliverGeometry — Sliver Layout Result');

  final geomProps = <Map<String, dynamic>>[
    {'prop': 'scrollExtent', 'desc': 'Total extent of sliver content'},
    {'prop': 'paintExtent', 'desc': 'Amount currently visible'},
    {'prop': 'maxPaintExtent', 'desc': 'Maximum the sliver could paint'},
    {'prop': 'layoutExtent', 'desc': 'How much space consumed in viewport'},
    {'prop': 'hitTestExtent', 'desc': 'Area participating in hit testing'},
    {'prop': 'visible', 'desc': 'Whether any part is currently visible'},
  ];

  final vpGeomSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What the sliver reports back after layout',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        ...geomProps.asMap().entries.map((entry) {
          final gp = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: vpInfoRow('${gp['prop']}:', gp['desc'] as String),
          );
        }),
        SizedBox(height: 8.0),
        vpCodeBlock('SliverGeometry(\n  scrollExtent: 1000.0,\n  paintExtent: 400.0,\n  maxPaintExtent: 1000.0,\n)'),
      ],
    ),
  );

  // ── Section 11: Viewport Visual ──────────────────────────────
  print('\n[11] Viewport Visual — Scroll Window');

  final vpVisualSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Viewport shows a window into content',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 160.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(0xFFC8E6C9)),
                ),
                child: Stack(
                  children: [
                    // Full content area
                    Positioned(left: 8.0, top: 8.0, right: 20.0, bottom: 8.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF2E7D32).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 20.0, width: double.infinity,
                              color: Color(0xFF2E7D32).withValues(alpha: 0.05),
                              child: Center(child: Text('..above..', style: TextStyle(fontSize: 8.0, color: Color(0xFF4E6B4E)))),
                            ),
                            Container(
                              height: 60.0, width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF2E7D32).withValues(alpha: 0.15),
                                border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
                              ),
                              child: Center(child: Text('VISIBLE\nVIEWPORT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)))),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: Color(0xFF2E7D32).withValues(alpha: 0.05),
                                child: Center(child: Text('..below..', style: TextStyle(fontSize: 8.0, color: Color(0xFF4E6B4E)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Scroll indicator
                    Positioned(right: 4.0, top: 8.0,
                      child: vpScrollBar(0.3, Color(0xFF2E7D32))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            SizedBox(
              width: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vpInfoRow('Content:', '1000px'),
                  vpInfoRow('Viewport:', '400px'),
                  vpInfoRow('Scroll pos:', '100px'),
                  vpInfoRow('Visible:', '100-500'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ── Section 12: Scroll Position Lifecycle ────────────────────
  print('\n[12] Scroll Position Lifecycle');

  final lifecycle = <Map<String, dynamic>>[
    {'event': 'attach()', 'phase': 'Mount', 'color': Color(0xFF43A047),
     'desc': 'Position attached to viewport'},
    {'event': 'applyViewportDimension()', 'phase': 'Size', 'color': Color(0xFF388E3C),
     'desc': 'Viewport tells position its size'},
    {'event': 'applyContentDimensions()', 'phase': 'Content', 'color': Color(0xFF2E7D32),
     'desc': 'Content extent becomes known'},
    {'event': 'jumpTo() / animateTo()', 'phase': 'Scroll', 'color': Color(0xFF1B5E20),
     'desc': 'User or code changes position'},
    {'event': 'correctBy()', 'phase': 'Adjust', 'color': Color(0xFF33691E),
     'desc': 'Silent correction during layout'},
    {'event': 'detach()', 'phase': 'Unmount', 'color': Color(0xFF1B5E20),
     'desc': 'Position detached from viewport'},
  ];

  final vpLifecycleSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: lifecycle.map((lc) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Container(width: 8.0, height: 8.0,
                decoration: BoxDecoration(color: lc['color'] as Color, shape: BoxShape.circle)),
              SizedBox(width: 8.0),
              SizedBox(width: 55.0,
                child: Text(lc['phase'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E)))),
              SizedBox(width: 110.0,
                child: Text(lc['event'] as String,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, fontFamily: 'monospace', color: lc['color'] as Color))),
              Expanded(child: Text(lc['desc'] as String,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E)))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 13: Common Sliver Types ──────────────────────────
  print('\n[13] Common Sliver Types');

  final sliverTypes = <Map<String, dynamic>>[
    {'name': 'SliverList', 'icon': Icons.view_list, 'color': Color(0xFF43A047),
     'desc': 'Linear list of children on main axis'},
    {'name': 'SliverGrid', 'icon': Icons.grid_view, 'color': Color(0xFF388E3C),
     'desc': '2D grid layout of children'},
    {'name': 'SliverAppBar', 'icon': Icons.web_asset, 'color': Color(0xFF2E7D32),
     'desc': 'Collapsing/floating app bar in scroll'},
    {'name': 'SliverToBoxAdapter', 'icon': Icons.crop_square, 'color': Color(0xFF1B5E20),
     'desc': 'Wraps a regular box widget as sliver'},
    {'name': 'SliverPersistentHeader', 'icon': Icons.push_pin, 'color': Color(0xFF33691E),
     'desc': 'Pinned or floating header in scroll'},
  ];

  final vpSliverTypesSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      children: sliverTypes.map((st) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 6.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              Icon(st['icon'] as IconData, color: st['color'] as Color, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(st['name'] as String,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: st['color'] as Color)),
                    Text(st['desc'] as String, style: TextStyle(fontSize: 10.0, color: Color(0xFF4E6B4E))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 14: Caching & Performance ────────────────────────
  print('\n[14] Caching & Performance');
  print('  cacheExtent: area beyond viewport for prebuilding');
  print('  Lazy loading: only visible + cached items built');

  final vpCachingSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pre-build items outside viewport for smooth scrolling',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Stack(
            children: [
              // Cache above
              Positioned(left: 20.0, top: 5.0,
                child: Container(
                  width: 200.0, height: 25.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.08),
                    border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.3), style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Center(child: Text('Cache (above)', style: TextStyle(fontSize: 8.0, color: Color(0xFF4E6B4E)))),
                ),
              ),
              // Visible viewport
              Positioned(left: 20.0, top: 32.0,
                child: Container(
                  width: 200.0, height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.15),
                    border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Center(child: Text('VISIBLE VIEWPORT',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)))),
                ),
              ),
              // Cache below
              Positioned(left: 20.0, top: 89.0,
                child: Container(
                  width: 200.0, height: 25.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withValues(alpha: 0.08),
                    border: Border.all(color: Color(0xFF2E7D32).withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Center(child: Text('Cache (below)', style: TextStyle(fontSize: 8.0, color: Color(0xFF4E6B4E)))),
                ),
              ),
              // Label
              Positioned(right: 10.0, top: 50.0,
                child: Text('cacheExtent\n= 250px', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF1B5E20)))),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        vpCodeBlock('ListView(\n  cacheExtent: 250.0,\n  // Items built for visible + 250px above/below\n)'),
      ],
    ),
  );

  // ── Section 15: GrowthDirection ──────────────────────────────
  print('\n[15] GrowthDirection');
  for (final gd in GrowthDirection.values) {
    print('  ${gd.name}: index=${gd.index}');
  }

  final vpGrowthSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC8E6C9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Direction slivers grow relative to scroll offset',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: GrowthDirection.values.map((gd) {
            final isForward = gd == GrowthDirection.forward;
            return Container(
              width: 130.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: isForward ? Color(0xFF43A047) : Color(0xFF1B5E20)),
              ),
              child: Column(
                children: [
                  Icon(isForward ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isForward ? Color(0xFF43A047) : Color(0xFF1B5E20), size: 28.0),
                  SizedBox(height: 4.0),
                  Text(gd.name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                      color: isForward ? Color(0xFF43A047) : Color(0xFF1B5E20))),
                  Text('index: ${gd.index}', style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF4E6B4E))),
                  SizedBox(height: 4.0),
                  Text(isForward ? 'Slivers grow toward\nscroll direction' : 'Slivers grow against\nscroll direction',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.0, color: Color(0xFF4E6B4E))),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  ViewportOffset: scroll position abstraction');
  print('  ScrollDirection: idle/forward/reverse');
  print('  Slivers: lazy layout protocol');

  final vpSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('Viewport & Scroll Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Icon(Icons.swap_vert, color: Color(0xFFC8E6C9), size: 28.0),
              Text('Offset', style: TextStyle(fontSize: 11.0, color: Color(0xFFC8E6C9))),
            ]),
            Column(children: [
              Icon(Icons.arrow_downward, color: Color(0xFFC8E6C9), size: 28.0),
              Text('Direction', style: TextStyle(fontSize: 11.0, color: Color(0xFFC8E6C9))),
            ]),
            Column(children: [
              Icon(Icons.view_list, color: Color(0xFFC8E6C9), size: 28.0),
              Text('Slivers', style: TextStyle(fontSize: 11.0, color: Color(0xFFC8E6C9))),
            ]),
            Column(children: [
              Icon(Icons.cached, color: Color(0xFFC8E6C9), size: 28.0),
              Text('Cache', style: TextStyle(fontSize: 11.0, color: Color(0xFFC8E6C9))),
            ]),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0, runSpacing: 4.0, alignment: WrapAlignment.center,
          children: [
            vpChip('ViewportOffset', Color(0xFF43A047)),
            vpChip('ScrollDirection', Color(0xFF388E3C)),
            vpChip('SliverConstraints', Color(0xFF2E7D32)),
            vpChip('SliverGeometry', Color(0xFF1B5E20)),
            vpChip('GrowthDirection', Color(0xFF33691E)),
          ],
        ),
      ],
    ),
  );

  print('\nViewport & Scroll Rendering Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vpTitleSection,
        vpSectionHeader('ViewportOffset', Icons.swap_vert),
        vpOffsetSection,
        vpSectionHeader('Properties', Icons.list),
        vpPropsSection,
        vpSectionHeader('Methods', Icons.functions),
        vpMethodsSection,
        vpSectionHeader('ScrollDirection', Icons.compare_arrows),
        vpDirectionSection,
        vpSectionHeader('BoxParentData', Icons.crop_free),
        vpParentDataSection,
        vpSectionHeader('Viewport Architecture', Icons.architecture),
        vpArchSection,
        vpSectionHeader('Sliver Layout Protocol', Icons.swap_vert_circle),
        vpSliverSection,
        vpSectionHeader('SliverConstraints', Icons.tune),
        vpConstraintSection,
        vpSectionHeader('SliverGeometry', Icons.square_foot),
        vpGeomSection,
        vpSectionHeader('Viewport Visual', Icons.visibility),
        vpVisualSection,
        vpSectionHeader('Scroll Position Lifecycle', Icons.loop),
        vpLifecycleSection,
        vpSectionHeader('Common Sliver Types', Icons.view_list),
        vpSliverTypesSection,
        vpSectionHeader('Caching & Performance', Icons.speed),
        vpCachingSection,
        vpSectionHeader('GrowthDirection', Icons.trending_up),
        vpGrowthSection,
        SizedBox(height: 8.0),
        vpSummarySection,
      ],
    ),
  );
}
