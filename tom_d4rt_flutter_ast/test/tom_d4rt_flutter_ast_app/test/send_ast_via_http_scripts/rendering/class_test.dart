// ignore_for_file: avoid_print
// D4rt deep-demo: Rendering Package Classes — Ember / Ash theme, prefix rn
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget rnSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFD4520A), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8C3503),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget rnChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget rnInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8C3503))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF5A504A))),
        ),
      ],
    ),
  );
}

Widget rnCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3EB),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(code,
        style: TextStyle(
            fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF8C3503))),
  );
}

Widget rnSizeBox(double w, double h, String label, Color accent) {
  return Column(
    children: [
      Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.15),
          border: Border.all(color: accent, width: 2.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text('${w.toInt()}x${h.toInt()}',
              style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600,
                  color: accent)),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label,
          style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
    ],
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] Rendering Package Overview');
  print('  Core: Size, Offset, BoxConstraints, RenderObject');
  print('  Pipeline: Layout → Paint → Composite → Hit-test');
  print('  Key classes: RenderBox, RenderFlex, RenderStack');

  final rnTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFD4520A), Color(0xFF8C3503)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('Rendering Package',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Low-level rendering pipeline: layout, paint, compositing, hit-testing',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFD6BE))),
        SizedBox(height: 8.0),
        Wrap(
          children: [
            rnChip('Size', Color(0xFFE86B20)),
            rnChip('Offset', Color(0xFFC75A15)),
            rnChip('BoxConstraints', Color(0xFFAB4A0E)),
            rnChip('RenderObject', Color(0xFF8C3503)),
            rnChip('RenderBox', Color(0xFF6B2A05)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Size ──────────────────────────────────────────
  print('\n[2] Size — 2D Dimensions');
  final s1 = Size(120.0, 80.0);
  final s2 = Size.square(60.0);
  final s3 = Size.fromRadius(30.0);
  print('  Size(120,80): width=${s1.width}, height=${s1.height}');
  print('  Square(60): $s2');
  print('  FromRadius(30): $s3');
  print('  Aspect ratio: ${s1.aspectRatio}');
  print('  isEmpty: ${Size.zero.isEmpty}');
  print('  isInfinite: ${Size.infinite.isInfinite}');

  final rnSizeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size represents width and height dimensions',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            rnSizeBox(80.0, 50.0, 'Size(80,50)', Color(0xFFE86B20)),
            rnSizeBox(50.0, 50.0, 'square(50)', Color(0xFFC75A15)),
            rnSizeBox(60.0, 60.0, 'fromRadius(30)', Color(0xFFAB4A0E)),
            rnSizeBox(40.0, 70.0, 'Size(40,70)', Color(0xFF8C3503)),
          ],
        ),
        SizedBox(height: 12.0),
        rnInfoRow('Width:', '${s1.width}'),
        rnInfoRow('Height:', '${s1.height}'),
        rnInfoRow('Aspect ratio:', s1.aspectRatio.toStringAsFixed(2)),
        rnInfoRow('Flipped:', s1.flipped.toString()),
        rnInfoRow('Shortest side:', '${s1.shortestSide}'),
        rnInfoRow('Longest side:', '${s1.longestSide}'),
        SizedBox(height: 8.0),
        rnCodeBlock('Size(120.0, 80.0)\nSize.square(60.0)\nSize.fromRadius(30.0)'),
      ],
    ),
  );

  // ── Section 3: Offset ────────────────────────────────────────
  print('\n[3] Offset — 2D Point / Vector');
  final o1 = Offset(30.0, 40.0);
  final o2 = Offset(10.0, 20.0);
  print('  Offset(30,40): dx=${o1.dx}, dy=${o1.dy}');
  print('  Distance: ${o1.distance}');
  print('  Direction: ${o1.direction}');
  print('  Addition: ${o1 + o2}');
  print('  Scale: ${o1 * 2.0}');
  print('  Offset.zero: ${Offset.zero}');

  final rnOffsetSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Offset represents a point or displacement vector',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE8C4AC)),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10.0, top: 10.0,
                child: Container(
                  width: 8.0, height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFD4520A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 14.0, top: 4.0,
                child: Text('Origin(0,0)',
                    style: TextStyle(fontSize: 8.0, color: Color(0xFF8C3503))),
              ),
              Positioned(
                left: 40.0, top: 50.0,
                child: Container(
                  width: 8.0, height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE86B20),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 50.0, top: 47.0,
                child: Text('Offset(30,40)',
                    style: TextStyle(fontSize: 8.0, color: Color(0xFFC75A15))),
              ),
              Positioned(
                left: 50.0, top: 70.0,
                child: Container(
                  width: 8.0, height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFAB4A0E),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 60.0, top: 67.0,
                child: Text('+ Offset(10,20) = (40,60)',
                    style: TextStyle(fontSize: 8.0, color: Color(0xFFAB4A0E))),
              ),
              Positioned(
                left: 70.0, top: 90.0,
                child: Container(
                  width: 8.0, height: 8.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF8C3503),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 80.0, top: 87.0,
                child: Text('* 2.0 = (60,80)',
                    style: TextStyle(fontSize: 8.0, color: Color(0xFF8C3503))),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        rnInfoRow('dx, dy:', '${o1.dx}, ${o1.dy}'),
        rnInfoRow('Distance:', o1.distance.toStringAsFixed(2)),
        rnInfoRow('Direction (rad):', o1.direction.toStringAsFixed(4)),
        rnInfoRow('o1 + o2:', (o1 + o2).toString()),
        rnInfoRow('o1 * 2:', (o1 * 2.0).toString()),
        rnInfoRow('o1 - o2:', (o1 - o2).toString()),
      ],
    ),
  );

  // ── Section 4: BoxConstraints ────────────────────────────────
  print('\n[4] BoxConstraints');
  final cLoose = BoxConstraints.loose(Size(200.0, 150.0));
  final cTight = BoxConstraints.tight(Size(100.0, 80.0));
  final cExpand = BoxConstraints.expand(width: 300.0, height: 200.0);
  print('  Loose: $cLoose');
  print('  Tight: $cTight');
  print('  Expand: $cExpand');
  print('  isTight(tight): ${cTight.isTight}');
  print('  Constrain(500,500): ${cLoose.constrain(Size(500.0, 500.0))}');

  final constraintData = <Map<String, dynamic>>[
    {'label': 'Loose', 'constraint': cLoose, 'color': Color(0xFFE86B20),
     'desc': 'min=0, max=given — child picks any size up to max',
     'min': 'minW:${cLoose.minWidth.toInt()}, minH:${cLoose.minHeight.toInt()}',
     'max': 'maxW:${cLoose.maxWidth.toInt()}, maxH:${cLoose.maxHeight.toInt()}'},
    {'label': 'Tight', 'constraint': cTight, 'color': Color(0xFFC75A15),
     'desc': 'min=max=given — child forced to exact size',
     'min': 'minW:${cTight.minWidth.toInt()}, minH:${cTight.minHeight.toInt()}',
     'max': 'maxW:${cTight.maxWidth.toInt()}, maxH:${cTight.maxHeight.toInt()}'},
    {'label': 'Expand', 'constraint': cExpand, 'color': Color(0xFFAB4A0E),
     'desc': 'min=max=fill — child fills all available space',
     'min': 'minW:${cExpand.minWidth.toInt()}, minH:${cExpand.minHeight.toInt()}',
     'max': 'maxW:${cExpand.maxWidth.toInt()}, maxH:${cExpand.maxHeight.toInt()}'},
  ];

  final rnConstraintsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: constraintData.map((cd) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(
              left: BorderSide(color: cd['color'] as Color, width: 4.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  rnChip(cd['label'] as String, cd['color'] as Color),
                  Expanded(child: Text('isTight: ${(cd['constraint'] as BoxConstraints).isTight}',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF999999)))),
                ],
              ),
              SizedBox(height: 4.0),
              Text(cd['desc'] as String,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF5A504A))),
              SizedBox(height: 4.0),
              Text('min: ${cd['min']}',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Color(0xFF8C3503))),
              Text('max: ${cd['max']}',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Color(0xFF8C3503))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 5: Constraints Flow ──────────────────────────────
  print('\n[5] Constraints Flow');
  print('  Parent passes constraints DOWN');
  print('  Child determines size within constraints');
  print('  Child reports size UP');
  print('  Parent positions child using offset');

  final flowSteps = <Map<String, dynamic>>[
    {'step': '1', 'title': 'Parent → Child', 'icon': Icons.arrow_downward,
     'desc': 'Parent passes BoxConstraints (min/max width/height)'},
    {'step': '2', 'title': 'Child determines size', 'icon': Icons.straighten,
     'desc': 'Child picks a Size within the constraint bounds'},
    {'step': '3', 'title': 'Child → Parent', 'icon': Icons.arrow_upward,
     'desc': 'Child reports its chosen Size back to parent'},
    {'step': '4', 'title': 'Parent positions', 'icon': Icons.open_with,
     'desc': 'Parent sets child Offset via parentData'},
  ];

  final rnFlowSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: flowSteps.map((fs) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: Color(0xFFD4520A),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(fs['step'] as String,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 14.0))),
              ),
              SizedBox(width: 10.0),
              Icon(fs['icon'] as IconData, color: Color(0xFFD4520A), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fs['title'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                            color: Color(0xFF8C3503))),
                    Text(fs['desc'] as String,
                        style: TextStyle(fontSize: 11.0, color: Color(0xFF5A504A))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 6: RenderObject Hierarchy ────────────────────────
  print('\n[6] RenderObject Hierarchy');
  print('  RenderObject (abstract)');
  print('    ├── RenderBox (cartesian layout)');
  print('    │   ├── RenderFlex (Column/Row)');
  print('    │   ├── RenderStack');
  print('    │   ├── RenderDecoratedBox');
  print('    │   └── RenderParagraph');
  print('    └── RenderSliver (scrolling)');

  final treeNodes = <Map<String, dynamic>>[
    {'name': 'RenderObject', 'depth': 0, 'color': Color(0xFFD4520A),
     'desc': 'Base class for all render objects'},
    {'name': 'RenderBox', 'depth': 1, 'color': Color(0xFFE86B20),
     'desc': '2D cartesian layout with BoxConstraints'},
    {'name': 'RenderFlex', 'depth': 2, 'color': Color(0xFFC75A15),
     'desc': 'Flexible layout (Row/Column)'},
    {'name': 'RenderStack', 'depth': 2, 'color': Color(0xFFC75A15),
     'desc': 'Overlay layout (Stack)'},
    {'name': 'RenderDecoratedBox', 'depth': 2, 'color': Color(0xFFC75A15),
     'desc': 'Box with decoration (Container)'},
    {'name': 'RenderParagraph', 'depth': 2, 'color': Color(0xFFC75A15),
     'desc': 'Text rendering (Text widget)'},
    {'name': 'RenderSliver', 'depth': 1, 'color': Color(0xFFAB4A0E),
     'desc': 'Scrollable content layout'},
  ];

  final rnHierarchySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RenderObject class hierarchy',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
        SizedBox(height: 8.0),
        ...treeNodes.map((node) {
          return Padding(
            padding: EdgeInsets.only(
                left: (node['depth'] as int) * 24.0, bottom: 6.0),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: node['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(node['name'] as String,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                              fontFamily: 'monospace', color: node['color'] as Color)),
                      Text(node['desc'] as String,
                          style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 7: Layout Pipeline ───────────────────────────────
  print('\n[7] Layout Pipeline');
  print('  Step 1: markNeedsLayout()');
  print('  Step 2: Relayout boundary walks up');
  print('  Step 3: performLayout() on dirty subtree');
  print('  Step 4: Size is determined');

  final pipelineStages = <Map<String, dynamic>>[
    {'stage': 'Layout', 'icon': Icons.straighten, 'color': Color(0xFFD4520A),
     'method': 'performLayout()',
     'desc': 'Receive constraints, compute size, layout children'},
    {'stage': 'Paint', 'icon': Icons.brush, 'color': Color(0xFFE86B20),
     'method': 'paint(context, offset)',
     'desc': 'Draw visual content to the canvas at given offset'},
    {'stage': 'Composite', 'icon': Icons.layers, 'color': Color(0xFFC75A15),
     'method': 'compositeFrame()',
     'desc': 'Merge paint layers into final scene for display'},
    {'stage': 'Hit Test', 'icon': Icons.touch_app, 'color': Color(0xFFAB4A0E),
     'method': 'hitTest(result, position)',
     'desc': 'Determine which render object receives pointer events'},
  ];

  final rnPipelineSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: pipelineStages.map((ps) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: (ps['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: (ps['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(ps['icon'] as IconData, color: ps['color'] as Color, size: 24.0),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ps['stage'] as String,
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: ps['color'] as Color)),
                    Text(ps['method'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Color(0xFF8C3503))),
                    Text(ps['desc'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 8: Rect ──────────────────────────────────────────
  print('\n[8] Rect — Axis-Aligned Rectangle');
  final r1 = Rect.fromLTWH(10.0, 20.0, 100.0, 60.0);
  final r2 = Rect.fromCenter(center: Offset(100.0, 60.0), width: 80.0, height: 40.0);
  final r3 = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 30.0);
  print('  fromLTWH(10,20,100,60): $r1');
  print('  fromCenter(100,60): $r2');
  print('  fromCircle(50,50,r=30): $r3');
  print('  Contains(50,40): ${r1.contains(Offset(50.0, 40.0))}');
  print('  Intersects: ${r1.overlaps(r2)}');

  final rnRectSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rect creation methods and operations',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 130.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10.0, top: 20.0,
                child: Container(
                  width: 100.0, height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFD4520A).withValues(alpha: 0.2),
                    border: Border.all(color: Color(0xFFD4520A), width: 2.0),
                  ),
                  child: Center(child: Text('fromLTWH',
                      style: TextStyle(fontSize: 8.0, color: Color(0xFFD4520A)))),
                ),
              ),
              Positioned(
                left: 60.0, top: 40.0,
                child: Container(
                  width: 80.0, height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE86B20).withValues(alpha: 0.2),
                    border: Border.all(color: Color(0xFFE86B20), width: 2.0),
                  ),
                  child: Center(child: Text('fromCenter',
                      style: TextStyle(fontSize: 8.0, color: Color(0xFFE86B20)))),
                ),
              ),
              Positioned(
                left: 150.0, top: 20.0,
                child: Container(
                  width: 60.0, height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFC75A15).withValues(alpha: 0.2),
                    border: Border.all(color: Color(0xFFC75A15), width: 2.0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('fromCircle',
                      style: TextStyle(fontSize: 7.0, color: Color(0xFFC75A15)))),
                ),
              ),
              Positioned(
                left: 230.0, top: 10.0,
                child: Container(
                  width: 70.0, height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFAB4A0E).withValues(alpha: 0.2),
                    border: Border.all(color: Color(0xFFAB4A0E), width: 2.0),
                  ),
                  child: Center(child: Text('fromPoints',
                      style: TextStyle(fontSize: 8.0, color: Color(0xFFAB4A0E)))),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        rnInfoRow('r1 center:', '${r1.center}'),
        rnInfoRow('r1 size:', '${r1.size}'),
        rnInfoRow('r1.contains:', '${r1.contains(Offset(50.0, 40.0))}'),
        rnInfoRow('r1 overlaps r2:', '${r1.overlaps(r2)}'),
        rnInfoRow('Inflate(5):', '${r1.inflate(5.0)}'),
      ],
    ),
  );

  // ── Section 9: EdgeInsets ────────────────────────────────────
  print('\n[9] EdgeInsets — Directional Spacing');
  final e1 = EdgeInsets.all(16.0);
  final e2 = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  final e3 = EdgeInsets.only(left: 8.0, top: 4.0, right: 16.0, bottom: 12.0);
  print('  all(16): $e1');
  print('  symmetric(h:20,v:10): $e2');
  print('  only(l:8,t:4,r:16,b:12): $e3');
  print('  collapsedSize: ${e3.collapsedSize}');

  final edgeData = <Map<String, dynamic>>[
    {'label': 'all(16)', 'insets': e1, 'color': Color(0xFFD4520A)},
    {'label': 'sym(h:20,v:10)', 'insets': e2, 'color': Color(0xFFE86B20)},
    {'label': 'only(8,4,16,12)', 'insets': e3, 'color': Color(0xFFC75A15)},
  ];

  final rnEdgeSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: edgeData.map((ed) {
        final ins = ed['insets'] as EdgeInsets;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rnChip(ed['label'] as String, ed['color'] as Color),
              SizedBox(height: 4.0),
              Container(
                padding: ins,
                decoration: BoxDecoration(
                  color: (ed['color'] as Color).withValues(alpha: 0.1),
                  border: Border.all(color: ed['color'] as Color),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Text('Content inside padding',
                      style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                ),
              ),
              SizedBox(height: 2.0),
              Text('L:${ins.left} T:${ins.top} R:${ins.right} B:${ins.bottom}',
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace',
                      color: Color(0xFF8C3503))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 10: BoxDecoration Visual Gallery ─────────────────
  print('\n[10] BoxDecoration — Visual Decoration Gallery');
  print('  Color, gradient, border, borderRadius, boxShadow, shape');

  final decorations = <Map<String, dynamic>>[
    {'label': 'Solid Color + Radius',
     'deco': BoxDecoration(
       color: Color(0xFFD4520A).withValues(alpha: 0.15),
       borderRadius: BorderRadius.circular(12.0),
       border: Border.all(color: Color(0xFFD4520A), width: 2.0),
     )},
    {'label': 'Gradient + Shadow',
     'deco': BoxDecoration(
       gradient: LinearGradient(
           colors: [Color(0xFFD4520A), Color(0xFFE86B20)]),
       borderRadius: BorderRadius.circular(8.0),
       boxShadow: [
         BoxShadow(color: Color(0x44D4520A), blurRadius: 8.0, offset: Offset(0, 4)),
       ],
     )},
    {'label': 'Circle Shape',
     'deco': BoxDecoration(
       color: Color(0xFFAB4A0E).withValues(alpha: 0.2),
       shape: BoxShape.circle,
       border: Border.all(color: Color(0xFFAB4A0E), width: 2.0),
     )},
    {'label': 'Thick Border + Color',
     'deco': BoxDecoration(
       color: Color(0xFFFFF3EB),
       border: Border(
         left: BorderSide(color: Color(0xFFD4520A), width: 6.0),
         top: BorderSide(color: Color(0xFFE86B20), width: 2.0),
         right: BorderSide(color: Color(0xFFC75A15), width: 6.0),
         bottom: BorderSide(color: Color(0xFFAB4A0E), width: 2.0),
       ),
     )},
  ];

  final rnDecorationSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: decorations.map((d) {
        return SizedBox(
          width: 140.0,
          child: Column(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: d['deco'] as BoxDecoration,
              ),
              SizedBox(height: 4.0),
              Text(d['label'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 11: Hit Testing ──────────────────────────────────
  print('\n[11] Hit Testing Concepts');
  print('  HitTestResult collects entries down the tree');
  print('  Each RenderBox tests if point is within bounds');
  print('  First responder in result list handles event');
  print('  Transforms applied for rotated/scaled boxes');

  final hitZones = <Map<String, dynamic>>[
    {'label': 'Zone A\n(Parent)', 'x': 10.0, 'y': 10.0, 'w': 280.0, 'h': 80.0,
     'color': Color(0xFFD4520A), 'opacity': 0.1},
    {'label': 'Zone B\n(Child 1)', 'x': 20.0, 'y': 20.0, 'w': 120.0, 'h': 50.0,
     'color': Color(0xFFE86B20), 'opacity': 0.2},
    {'label': 'Zone C\n(Child 2)', 'x': 160.0, 'y': 20.0, 'w': 120.0, 'h': 50.0,
     'color': Color(0xFFC75A15), 'opacity': 0.2},
  ];

  final rnHitTestSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Touch events dispatched via hit-testing',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: hitZones.map((hz) {
              return Positioned(
                left: hz['x'] as double,
                top: hz['y'] as double,
                child: Container(
                  width: hz['w'] as double,
                  height: hz['h'] as double,
                  decoration: BoxDecoration(
                    color: (hz['color'] as Color).withValues(
                        alpha: hz['opacity'] as double),
                    border: Border.all(color: hz['color'] as Color, width: 1.5),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(child: Text(hz['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.0, color: hz['color'] as Color))),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8.0),
        rnInfoRow('Method:', 'hitTest(result, position)'),
        rnInfoRow('Result:', 'HitTestResult with ordered entries'),
        rnInfoRow('Dispatch:', 'First entry handles GestureEvent'),
      ],
    ),
  );

  // ── Section 12: ParentData ───────────────────────────────────
  print('\n[12] ParentData');
  print('  ParentData: base class for parent-owned child data');
  print('  BoxParentData: offset property for positioning');
  print('  FlexParentData: flex, fit for Row/Column');
  print('  StackParentData: top, right, bottom, left for Stack');

  final parentDataTypes = <Map<String, dynamic>>[
    {'name': 'ParentData', 'icon': Icons.account_tree,
     'color': Color(0xFFD4520A),
     'props': 'Base class — no properties',
     'used': 'RenderObject'},
    {'name': 'BoxParentData', 'icon': Icons.crop_free,
     'color': Color(0xFFE86B20),
     'props': 'offset: Offset',
     'used': 'RenderBox children'},
    {'name': 'FlexParentData', 'icon': Icons.view_column,
     'color': Color(0xFFC75A15),
     'props': 'flex: int?, fit: FlexFit?',
     'used': 'Row, Column, Flex'},
    {'name': 'StackParentData', 'icon': Icons.layers,
     'color': Color(0xFFAB4A0E),
     'props': 'top, right, bottom, left, width, height',
     'used': 'Stack, Positioned'},
  ];

  final rnParentDataSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: parentDataTypes.map((pd) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(pd['icon'] as IconData, color: pd['color'] as Color, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pd['name'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                            fontFamily: 'monospace', color: pd['color'] as Color)),
                    Text('Properties: ${pd['props']}',
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                    Text('Used by: ${pd['used']}',
                        style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                            color: Color(0xFF8C3503))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 13: Matrix4 Transforms ───────────────────────────
  print('\n[13] Matrix4 Transforms');
  print('  Translation: move position');
  print('  Rotation: spin around axis');
  print('  Scale: resize larger/smaller');
  print('  Perspective: 3D depth effect');

  final transforms = <Map<String, dynamic>>[
    {'label': 'Identity', 'color': Color(0xFFD4520A),
     'desc': 'No transform applied'},
    {'label': 'Translate', 'color': Color(0xFFE86B20),
     'desc': 'Move by (dx, dy, dz)'},
    {'label': 'Scale', 'color': Color(0xFFC75A15),
     'desc': 'Resize larger or smaller'},
    {'label': 'Rotate', 'color': Color(0xFFAB4A0E),
     'desc': 'Spin around an axis'},
    {'label': 'Skew', 'color': Color(0xFF8C3503),
     'desc': 'Shear along X or Y axis'},
  ];

  final rnTransformSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: transforms.map((t) {
            return Column(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: (t['color'] as Color).withValues(alpha: 0.15),
                    border: Border.all(color: t['color'] as Color, width: 2.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Icon(Icons.transform, color: t['color'] as Color, size: 20.0),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(t['label'] as String,
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600,
                        color: t['color'] as Color)),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        rnCodeBlock(
            'Matrix4.identity()\n'
            'Matrix4.translationValues(10, 20, 0)\n'
            'Matrix4.diagonal3Values(2, 2, 1)\n'
            'Matrix4.rotationZ(0.5)',
        ),
      ],
    ),
  );

  // ── Section 14: Paint Concepts ───────────────────────────────
  print('\n[14] Paint Concepts');
  print('  PaintingStyle.fill vs PaintingStyle.stroke');
  print('  Paint object controls: color, style, strokeWidth');
  print('  Canvas draws: rect, circle, line, path, text');

  final paintModes = <Map<String, dynamic>>[
    {'label': 'Fill', 'style': 'PaintingStyle.fill',
     'color': Color(0xFFD4520A),
     'desc': 'Interior is completely filled with color'},
    {'label': 'Stroke', 'style': 'PaintingStyle.stroke',
     'color': Color(0xFFE86B20),
     'desc': 'Only the outline border is drawn'},
  ];

  final rnPaintSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: [
        Row(
          children: paintModes.map((pm) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: pm['label'] == 'Fill'
                            ? (pm['color'] as Color).withValues(alpha: 0.3)
                            : Colors.transparent,
                        border: Border.all(
                            color: pm['color'] as Color,
                            width: pm['label'] == 'Stroke' ? 3.0 : 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(pm['label'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                            color: pm['color'] as Color)),
                    Text(pm['desc'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        Text('Canvas operations: drawRect, drawCircle, drawLine, drawPath, drawParagraph',
            style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8C3503))),
      ],
    ),
  );

  // ── Section 15: RenderObject Lifecycle ───────────────────────
  print('\n[15] RenderObject Lifecycle');
  print('  attach() → markNeedsLayout() → performLayout()');
  print('  markNeedsPaint() → paint() → composite');
  print('  detach() → dispose()');
  print('  sizedByParent: child size determined only by constraints');

  final lifecycleEvents = <Map<String, dynamic>>[
    {'event': 'attach()', 'phase': 'Mounting', 'color': Color(0xFFD4520A),
     'desc': 'RenderObject added to the render tree'},
    {'event': 'markNeedsLayout()', 'phase': 'Dirty', 'color': Color(0xFFE86B20),
     'desc': 'Schedule layout pass for this node'},
    {'event': 'performLayout()', 'phase': 'Layout', 'color': Color(0xFFC75A15),
     'desc': 'Compute size based on constraints'},
    {'event': 'markNeedsPaint()', 'phase': 'Dirty', 'color': Color(0xFFAB4A0E),
     'desc': 'Schedule repaint for this node'},
    {'event': 'paint()', 'phase': 'Paint', 'color': Color(0xFF8C3503),
     'desc': 'Draw visual representation to canvas'},
    {'event': 'detach()', 'phase': 'Unmount', 'color': Color(0xFF6B2A05),
     'desc': 'RenderObject removed from the tree'},
  ];

  final rnLifecycleSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE3),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8C4AC)),
    ),
    child: Column(
      children: lifecycleEvents.map((le) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: le['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.0),
              SizedBox(
                width: 60.0,
                child: Text(le['phase'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF999999))),
              ),
              SizedBox(
                width: 100.0,
                child: Text(le['event'] as String,
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                        fontFamily: 'monospace', color: le['color'] as Color)),
              ),
              Expanded(
                child: Text(le['desc'] as String,
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Key types: ${['Size', 'Offset', 'Rect', 'BoxConstraints'].join(', ')}');
  print('  Pipeline: Layout → Paint → Composite → Hit');
  print('  Tree: RenderObject → RenderBox → Specific renders');

  final rnSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF8C3503), Color(0xFFD4520A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('Rendering Package Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.straighten, color: Color(0xFFFFD6BE), size: 28.0),
                Text('Size', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD6BE))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.crop_free, color: Color(0xFFFFD6BE), size: 28.0),
                Text('Constraints', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD6BE))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.brush, color: Color(0xFFFFD6BE), size: 28.0),
                Text('Paint', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD6BE))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.touch_app, color: Color(0xFFFFD6BE), size: 28.0),
                Text('Hit Test', style: TextStyle(fontSize: 11.0, color: Color(0xFFFFD6BE))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.center,
          children: [
            rnChip('RenderObject', Color(0xFFE86B20)),
            rnChip('RenderBox', Color(0xFFC75A15)),
            rnChip('BoxConstraints', Color(0xFFAB4A0E)),
            rnChip('EdgeInsets', Color(0xFF8C3503)),
            rnChip('BoxDecoration', Color(0xFF6B2A05)),
          ],
        ),
      ],
    ),
  );

  print('\nRendering Package Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        rnTitleSection,
        SizedBox(height: 16.0),
        // 2 Size
        rnSectionHeader('Size — 2D Dimensions', Icons.straighten),
        rnSizeSection,
        // 3 Offset
        rnSectionHeader('Offset — Point & Vector', Icons.my_location),
        rnOffsetSection,
        // 4 BoxConstraints
        rnSectionHeader('BoxConstraints', Icons.crop_free),
        rnConstraintsSection,
        // 5 Constraints Flow
        rnSectionHeader('Constraints Flow', Icons.swap_vert),
        rnFlowSection,
        // 6 Hierarchy
        rnSectionHeader('RenderObject Hierarchy', Icons.account_tree),
        rnHierarchySection,
        // 7 Pipeline
        rnSectionHeader('Rendering Pipeline', Icons.linear_scale),
        rnPipelineSection,
        // 8 Rect
        rnSectionHeader('Rect — Axis-Aligned Rectangle', Icons.crop_square),
        rnRectSection,
        // 9 EdgeInsets
        rnSectionHeader('EdgeInsets — Spacing', Icons.padding),
        rnEdgeSection,
        // 10 BoxDecoration
        rnSectionHeader('BoxDecoration Gallery', Icons.palette),
        rnDecorationSection,
        // 11 Hit Testing
        rnSectionHeader('Hit Testing', Icons.touch_app),
        rnHitTestSection,
        // 12 ParentData
        rnSectionHeader('ParentData Types', Icons.account_tree),
        rnParentDataSection,
        // 13 Transforms
        rnSectionHeader('Matrix4 Transforms', Icons.transform),
        rnTransformSection,
        // 14 Paint
        rnSectionHeader('Paint Concepts', Icons.brush),
        rnPaintSection,
        // 15 Lifecycle
        rnSectionHeader('RenderObject Lifecycle', Icons.loop),
        rnLifecycleSection,
        // 16 Summary
        SizedBox(height: 8.0),
        rnSummarySection,
      ],
    ),
  );
}
