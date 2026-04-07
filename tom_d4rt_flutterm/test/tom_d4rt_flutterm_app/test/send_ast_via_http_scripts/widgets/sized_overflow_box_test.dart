// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SizedOverflowBox
// Demonstrates SizedOverflowBox — a widget that is a specific size for layout
// purposes but passes its original constraints to its child, which may then
// overflow the box's area. Combines the layout footprint of SizedBox with
// the freedom of unconstrained child painting.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SizedOverflowBox Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_square,
      'title': 'Fixed Layout Footprint',
      'body': 'SizedOverflowBox occupies a specific size in the parent\'s '
          'layout, defined by the "size" parameter. The parent sees only '
          'this declared size, regardless of the child\'s actual extent. '
          'This is the layout size — the space reserved in the widget tree.',
    },
    {
      'icon': Icons.open_with,
      'title': 'Unconstrained Child',
      'body': 'Unlike SizedBox which constrains its child to fit, '
          'SizedOverflowBox passes the parent\'s original constraints '
          'through to its child. The child can potentially be much larger '
          '(or smaller) than the declared layout size.',
    },
    {
      'icon': Icons.format_paint,
      'title': 'Paint Outside Bounds',
      'body': 'When the child is larger than the declared size, it paints '
          'outside the SizedOverflowBox\'s layout boundaries. This is not '
          'clipping — the child\'s pixels are actually rendered beyond the '
          'layout rectangle. Use ClipRect if you need to clip.',
    },
    {
      'icon': Icons.architecture,
      'title': 'Alignment Control',
      'body': 'The alignment parameter controls where the child is positioned '
          'relative to the layout rectangle. This determines which edges '
          'overflow and by how much. Common for decorative elements that '
          'extend beyond a reserving area.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.deepPurple.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                p['icon'] as IconData,
                color: Colors.deepPurple,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final conceptTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.withValues(alpha: 0.08),
                Colors.deepPurple.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              const Icon(Icons.crop_square, size: 48.0, color: Colors.deepPurple),
              const SizedBox(height: 8.0),
              const Text(
                'SizedOverflowBox',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A widget that has a fixed size for layout but lets its '
                'child overflow those bounds freely.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...conceptCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParams = <Map<String, String>>[
    {
      'name': 'size',
      'type': 'Size',
      'required': 'Yes',
      'desc': 'The layout size of this widget. The parent will allocate '
          'this much space. The child may paint outside this rectangle.',
    },
    {
      'name': 'alignment',
      'type': 'AlignmentGeometry',
      'required': 'No',
      'desc': 'How to position the child inside the layout rectangle. '
          'Defaults to Alignment.center. Controls which direction(s) '
          'the child overflows toward.',
    },
    {
      'name': 'child',
      'type': 'Widget?',
      'required': 'No',
      'desc': 'The child widget. It receives the parent\'s constraints, '
          'not constraints derived from the size parameter. May overflow.',
    },
  ];

  final paramRows = <Widget>[];
  for (final param in constructorParams) {
    print('  Constructor param: ${param['name']} (${param['type']})');
    paramRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Colors.deepPurple,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['type']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: param['required'] == 'Yes'
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['required'] == 'Yes' ? 'REQUIRED' : 'optional',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: param['required'] == 'Yes'
                          ? Colors.red[700]
                          : Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              param['desc']!,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final constructorTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSOBSectionHeader('Constructor Parameters', Icons.code),
        const SizedBox(height: 12.0),
        ...paramRows,
        const SizedBox(height: 16.0),
        buildSOBSectionHeader('Constructor Signature', Icons.text_snippet),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'const SizedOverflowBox({\n'
            '  Key? key,\n'
            '  required this.size,\n'
            '  this.alignment = Alignment.center,\n'
            '  Widget? child,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        buildSOBSectionHeader('Key Insight', Icons.lightbulb_outline),
        const SizedBox(height: 8.0),
        buildSOBBullet(
          'The size parameter defines the LAYOUT size — the space this '
          'widget occupies in Column, Row, Flex, etc.',
        ),
        buildSOBBullet(
          'The child receives the parent\'s constraints, NOT the size. '
          'If the parent says "you can be 400px wide", the child gets that, '
          'regardless of what size says.',
        ),
        buildSOBBullet(
          'The child is positioned within the layout rect using alignment. '
          'If the child is bigger, parts will visually overflow.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Size vs Child (Visual Comparison)
  // ============================================================
  print('=== Section 3: Size vs Child ===');

  final sizeVsChildScenarios = <Map<String, dynamic>>[
    {
      'label': 'Child Larger Than Size',
      'layoutW': 100.0,
      'layoutH': 60.0,
      'childW': 180.0,
      'childH': 100.0,
      'desc': 'The SizedOverflowBox is 100×60 in layout, but the child '
          'is 180×100. The child overflows on all sides (centered).',
      'color': Colors.orange,
    },
    {
      'label': 'Child Same As Size',
      'layoutW': 120.0,
      'layoutH': 80.0,
      'childW': 120.0,
      'childH': 80.0,
      'desc': 'When the child matches the declared size, there is no overflow. '
          'Behaves identically to SizedBox.',
      'color': Colors.green,
    },
    {
      'label': 'Child Smaller Than Size',
      'layoutW': 160.0,
      'layoutH': 100.0,
      'childW': 80.0,
      'childH': 50.0,
      'desc': 'The child is smaller than the declared size. The widget takes '
          'up 160×100 in layout, but only paints a small child.',
      'color': Colors.blue,
    },
    {
      'label': 'Zero Layout Size',
      'layoutW': 0.0,
      'layoutH': 0.0,
      'childW': 140.0,
      'childH': 70.0,
      'desc': 'With Size.zero, the widget takes no layout space, but the '
          'child still renders! It paints entirely outside the layout box.',
      'color': Colors.red,
    },
  ];

  final sizeVsChildCards = <Widget>[];
  for (var i = 0; i < sizeVsChildScenarios.length; i++) {
    final s = sizeVsChildScenarios[i];
    print('  Size vs Child scenario ${i + 1}: ${s['label']}');

    final layoutW = s['layoutW'] as double;
    final layoutH = s['layoutH'] as double;
    final childW = s['childW'] as double;
    final childH = s['childH'] as double;
    final clr = s['color'] as Color;

    sizeVsChildCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: clr,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    s['label'] as String,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Container(
                height: 130.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // The layout footprint rectangle
                    Container(
                      width: layoutW,
                      height: layoutH,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2.0,
                        ),
                        color: Colors.deepPurple.withValues(alpha: 0.05),
                      ),
                      child: Center(
                        child: Text(
                          '${layoutW.toInt()}×${layoutH.toInt()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // The child rectangle (overlapping)
                    Container(
                      width: childW,
                      height: childH,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: clr,
                          width: 2.0,
                        ),
                        color: clr.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          'child\n${childW.toInt()}×${childH.toInt()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: clr,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 1.5),
                    color: Colors.deepPurple.withValues(alpha: 0.05),
                  ),
                ),
                const SizedBox(width: 6.0),
                const Text(
                  'Layout footprint',
                  style: TextStyle(fontSize: 11.0),
                ),
                const SizedBox(width: 16.0),
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: clr, width: 1.5),
                    color: clr.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                const SizedBox(width: 6.0),
                const Text(
                  'Actual child',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              s['desc'] as String,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final sizeVsChildTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSOBSectionHeader('Layout Size vs Child Size', Icons.compare),
        const SizedBox(height: 8.0),
        Text(
          'SizedOverflowBox separates layout size from child size. The '
          'purple dashed box is the layout footprint; the colored box is '
          'the actual child rendering.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...sizeVsChildCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Alignment
  // ============================================================
  print('=== Section 4: Alignment ===');

  final alignments = <Map<String, dynamic>>[
    {'name': 'topLeft', 'align': Alignment.topLeft, 'desc': 'Child anchored at top-left corner. Overflow extends to the right and bottom.'},
    {'name': 'topCenter', 'align': Alignment.topCenter, 'desc': 'Child anchored at top center. Overflow extends equally left/right and bottom.'},
    {'name': 'topRight', 'align': Alignment.topRight, 'desc': 'Child anchored at top-right. Overflow extends to the left and bottom.'},
    {'name': 'centerLeft', 'align': Alignment.centerLeft, 'desc': 'Child anchored center-left. Overflow extends right and equally top/bottom.'},
    {'name': 'center', 'align': Alignment.center, 'desc': 'Default. Child centered. Overflow distributed equally on all sides.'},
    {'name': 'centerRight', 'align': Alignment.centerRight, 'desc': 'Child anchored center-right. Overflow extends left and equally top/bottom.'},
    {'name': 'bottomLeft', 'align': Alignment.bottomLeft, 'desc': 'Child anchored at bottom-left. Overflow extends right and upward.'},
    {'name': 'bottomCenter', 'align': Alignment.bottomCenter, 'desc': 'Child anchored at bottom center. Overflow extends equally left/right and upward.'},
    {'name': 'bottomRight', 'align': Alignment.bottomRight, 'desc': 'Child anchored at bottom-right. Overflow extends left and upward.'},
  ];

  final alignmentVisuals = <Widget>[];
  for (var i = 0; i < alignments.length; i++) {
    final a = alignments[i];
    final align = a['align'] as Alignment;
    print('  Alignment demo: ${a['name']}');

    alignmentVisuals.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            // Visual: small box with a larger child and alignment
            Container(
              width: 90.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Stack(
                children: [
                  // The layout box
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                  // The child positioned by alignment
                  Align(
                    alignment: align,
                    child: Container(
                      width: 36.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alignment.${a['name']}',
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    a['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final alignmentTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSOBSectionHeader('Alignment & Overflow Direction', Icons.open_with),
        const SizedBox(height: 8.0),
        Text(
          'Alignment controls where the child sits within the layout rect. '
          'When the child is larger, the alignment determines which edges '
          'the overflow extends toward.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...alignmentVisuals,
        const SizedBox(height: 16.0),
        buildSOBSectionHeader('Fractional Alignment', Icons.tune),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custom Alignment Values',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'You can use Alignment(x, y) with any values from -1.0 to 1.0 '
                '(and beyond) for fine-grained positioning. Values outside '
                '-1..1 push the child further beyond the layout rect.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live Demo (Interactive)
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveTab = _SOBLiveDemo();

  // ============================================================
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisonData = <Map<String, dynamic>>[
    {
      'widget': 'SizedBox',
      'behavior': 'Constrains child to fit within its size. '
          'Child is forced to be at most the declared size.',
      'overflow': 'No',
      'passParent': 'No',
      'icon': Icons.check_box_outline_blank,
      'color': Colors.blue,
    },
    {
      'widget': 'SizedOverflowBox',
      'behavior': 'Has a fixed layout size but passes parent\'s '
          'constraints to the child. Child may overflow.',
      'overflow': 'Yes',
      'passParent': 'Yes',
      'icon': Icons.crop_square,
      'color': Colors.deepPurple,
    },
    {
      'widget': 'OverflowBox',
      'behavior': 'Imposes its own min/max constraints on the child, '
          'which may differ from what the parent provides.',
      'overflow': 'Yes',
      'passParent': 'No (custom)',
      'icon': Icons.open_in_full,
      'color': Colors.orange,
    },
    {
      'widget': 'UnconstrainedBox',
      'behavior': 'Removes constraints entirely. Child sizes itself '
          'unconstrained, may overflow the parent.',
      'overflow': 'Yes',
      'passParent': 'No (unconstrained)',
      'icon': Icons.all_out,
      'color': Colors.teal,
    },
    {
      'widget': 'FittedBox',
      'behavior': 'Scales the child to fit within the available space. '
          'Child never overflows; it is scaled down.',
      'overflow': 'No',
      'passParent': 'No (scaled)',
      'icon': Icons.fit_screen,
      'color': Colors.green,
    },
  ];

  final comparisonCards = <Widget>[];
  for (final c in comparisonData) {
    print('  Comparison: ${c['widget']}');
    comparisonCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (c['color'] as Color).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: (c['color'] as Color).withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  c['icon'] as IconData,
                  color: c['color'] as Color,
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  c['widget'] as String,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: c['color'] as Color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              c['behavior'] as String,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                _buildSOBTag(
                  'Overflow: ${c['overflow']}',
                  c['overflow'] == 'Yes' ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 8.0),
                _buildSOBTag(
                  'Pass parent: ${c['passParent']}',
                  c['passParent'] == 'Yes' ? Colors.deepPurple : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSOBSectionHeader('Widget Comparison', Icons.compare_arrows),
        const SizedBox(height: 8.0),
        Text(
          'How SizedOverflowBox differs from similar sizing/overflow widgets.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...comparisonCards,
        const SizedBox(height: 16.0),
        buildSOBSectionHeader('Visual Comparison', Icons.visibility),
        const SizedBox(height: 12.0),
        _SOBComparisonVisual(),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Badge Positioning',
      'icon': Icons.notifications_active,
      'color': Colors.red,
      'desc': 'Place a badge that overflows its container — the layout '
          'space is zero, but the badge renders and positions itself '
          'relative to a parent Stack. The surrounding layout is unaffected.',
      'visual': _SOBBadgeDemo(),
    },
    {
      'title': 'Decorative Overlapping Elements',
      'icon': Icons.auto_awesome,
      'color': Colors.amber,
      'desc': 'Create decorative elements like highlights or glow effects '
          'that extend beyond a card\'s boundaries without disrupting '
          'the surrounding layout.',
      'visual': _SOBDecorativeDemo(),
    },
    {
      'title': 'Tooltip Anchoring',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.teal,
      'desc': 'Anchor a tooltip-like widget to a specific point. The '
          'SizedOverflowBox has zero layout size at the anchor point, '
          'and the tooltip child overflows from there.',
      'visual': _SOBTooltipDemo(),
    },
    {
      'title': 'Transition Placeholder',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo,
      'desc': 'During animations, reserve a fixed space while the animating '
          'element may temporarily be larger. The layout remains stable '
          'while the child transitions through different sizes.',
      'visual': _SOBTransitionDemo(),
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    print('  Use case ${i + 1}: ${uc['title']}');

    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (uc['color'] as Color).withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: (uc['color'] as Color).withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    uc['icon'] as IconData,
                    size: 20.0,
                    color: uc['color'] as Color,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      uc['title'] as String,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: uc['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                uc['desc'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: uc['visual'] as Widget,
            ),
          ],
        ),
      ),
    );
  }

  final useCaseTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSOBSectionHeader('Practical Use Cases', Icons.build_circle),
        const SizedBox(height: 8.0),
        Text(
          'Real-world scenarios where SizedOverflowBox is the correct choice.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...useCaseWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryItems = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_square,
      'text': 'SizedOverflowBox separates layout size from child painting — '
          'the parent sees a fixed size, but the child can extend beyond.',
    },
    {
      'icon': Icons.open_with,
      'text': 'Alignment controls where the child sits within the layout rect '
          'and which direction(s) the overflow extends.',
    },
    {
      'icon': Icons.compare_arrows,
      'text': 'Unlike SizedBox (constrains child), OverflowBox (custom constraints), '
          'or UnconstrainedBox (no constraints) — SizedOverflowBox passes through '
          'the PARENT\'s constraints.',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Overflow is not clipped by default. Wrap in ClipRect if you need '
          'to prevent painting outside the layout bounds.',
    },
    {
      'icon': Icons.build,
      'text': 'Common in custom layouts for badges, decorative elements, tooltips, '
          'and animation placeholders where layout stability matters.',
    },
    {
      'icon': Icons.speed,
      'text': 'No performance cost beyond a normal single-child widget. The '
          'RenderObject simply uses the declared size for layout and positions '
          'the child via alignment.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryItems.length; i++) {
    final item = summaryItems[i];
    summaryWidgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 18.0,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                item['text'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey[800],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final summaryTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.withValues(alpha: 0.1),
                Colors.deepPurple.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Column(
            children: [
              Icon(Icons.summarize, size: 40.0, color: Colors.deepPurple),
              SizedBox(height: 8.0),
              Text(
                'SizedOverflowBox — Key Takeaways',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...summaryWidgets,
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.deepPurple.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Mental Model',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '"I occupy THIS much space in the layout, but I let my '
                'child be whatever size the parent allows, and I position '
                'my child according to alignment."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE TABS
  // ============================================================
  print('Assembling SizedOverflowBox deep demo tabs');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey[50],
    ),
    home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SizedOverflowBox Deep Demo'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2.0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
              Tab(icon: Icon(Icons.code), text: 'Constructor'),
              Tab(icon: Icon(Icons.compare), text: 'Size vs Child'),
              Tab(icon: Icon(Icons.open_with), text: 'Alignment'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Live Demo'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Comparison'),
              Tab(icon: Icon(Icons.build_circle), text: 'Use Cases'),
              Tab(icon: Icon(Icons.summarize), text: 'Summary'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            conceptTab,
            constructorTab,
            sizeVsChildTab,
            alignmentTab,
            liveTab,
            comparisonTab,
            useCaseTab,
            summaryTab,
          ],
        ),
      ),
    ),
  );
}

// ==================================================================
// Top-level helper functions
// ==================================================================

Widget buildSOBSectionHeader(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 20.0, color: Colors.deepPurple),
      const SizedBox(width: 8.0),
      Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: Colors.deepPurple,
        ),
      ),
    ],
  );
}

Widget buildSOBBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          width: 6.0,
          height: 6.0,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSOBTag(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ==================================================================
// Live Demo — Interactive SizedOverflowBox exploration
// ==================================================================
class _SOBLiveDemo extends StatefulWidget {
  @override
  State<_SOBLiveDemo> createState() => _SOBLiveDemoState();
}

class _SOBLiveDemoState extends State<_SOBLiveDemo> {
  double _layoutWidth = 120.0;
  double _layoutHeight = 80.0;
  double _childWidth = 180.0;
  double _childHeight = 120.0;
  int _alignIndex = 4; // center
  bool _showClip = false;

  static const _alignOptions = <Map<String, dynamic>>[
    {'label': 'topLeft', 'value': Alignment.topLeft},
    {'label': 'topCenter', 'value': Alignment.topCenter},
    {'label': 'topRight', 'value': Alignment.topRight},
    {'label': 'centerLeft', 'value': Alignment.centerLeft},
    {'label': 'center', 'value': Alignment.center},
    {'label': 'centerRight', 'value': Alignment.centerRight},
    {'label': 'bottomLeft', 'value': Alignment.bottomLeft},
    {'label': 'bottomCenter', 'value': Alignment.bottomCenter},
    {'label': 'bottomRight', 'value': Alignment.bottomRight},
  ];

  @override
  Widget build(BuildContext context) {
    final currentAlign =
        _alignOptions[_alignIndex]['value'] as AlignmentGeometry;

    final sobWidget = SizedOverflowBox(
      size: Size(_layoutWidth, _layoutHeight),
      alignment: currentAlign,
      child: Container(
        width: _childWidth,
        height: _childHeight,
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.deepPurple, width: 2.0),
        ),
        child: Center(
          child: Text(
            'Child\n${_childWidth.toInt()}×${_childHeight.toInt()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSOBSectionHeader('Interactive Explorer', Icons.science),
          const SizedBox(height: 12.0),

          // Preview area
          Container(
            width: double.infinity,
            height: 220.0,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Grid background
                CustomPaint(
                  size: const Size(double.infinity, 220.0),
                  painter: _SOBGridPainter(),
                ),
                // Layout footprint indicator
                Container(
                  width: _layoutWidth,
                  height: _layoutHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.6),
                      width: 2.0,
                    ),
                    color: Colors.red.withValues(alpha: 0.05),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 1.0,
                      ),
                      color: Colors.red.withValues(alpha: 0.8),
                      child: Text(
                        'layout ${_layoutWidth.toInt()}×${_layoutHeight.toInt()}',
                        style: const TextStyle(
                          fontSize: 9.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // The actual SizedOverflowBox
                _showClip ? ClipRect(child: sobWidget) : sobWidget,
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Legend
          Row(
            children: [
              Container(
                width: 16.0,
                height: 12.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1.5),
                  color: Colors.red.withValues(alpha: 0.05),
                ),
              ),
              const SizedBox(width: 6.0),
              const Text('Layout footprint', style: TextStyle(fontSize: 11.0)),
              const SizedBox(width: 16.0),
              Container(
                width: 16.0,
                height: 12.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 1.5),
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 6.0),
              const Text('Child widget', style: TextStyle(fontSize: 11.0)),
            ],
          ),
          const SizedBox(height: 16.0),

          // Controls
          buildSOBSectionHeader('Layout Size', Icons.crop_square),
          const SizedBox(height: 8.0),
          _buildSlider('Width', _layoutWidth, 0, 250, (v) {
            setState(() => _layoutWidth = v);
          }),
          _buildSlider('Height', _layoutHeight, 0, 200, (v) {
            setState(() => _layoutHeight = v);
          }),

          const SizedBox(height: 12.0),
          buildSOBSectionHeader('Child Size', Icons.child_care),
          const SizedBox(height: 8.0),
          _buildSlider('Width', _childWidth, 20, 300, (v) {
            setState(() => _childWidth = v);
          }),
          _buildSlider('Height', _childHeight, 20, 200, (v) {
            setState(() => _childHeight = v);
          }),

          const SizedBox(height: 12.0),
          buildSOBSectionHeader('Alignment', Icons.open_with),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(_alignOptions.length, (i) {
              final isSelected = i == _alignIndex;
              return GestureDetector(
                onTap: () => setState(() => _alignIndex = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.deepPurple
                        : Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: isSelected
                          ? Colors.deepPurple
                          : Colors.deepPurple.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    _alignOptions[i]['label'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.deepPurple,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 12.0),
          // Clip toggle
          GestureDetector(
            onTap: () => setState(() => _showClip = !_showClip),
            child: Row(
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: _showClip
                        ? Colors.deepPurple
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: _showClip ? Colors.deepPurple : Colors.grey,
                    ),
                  ),
                  child: _showClip
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8.0),
                const Text(
                  'Wrap in ClipRect (clip overflow)',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),
          // Status readout
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.deepPurple.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Configuration',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Layout: ${_layoutWidth.toInt()}×${_layoutHeight.toInt()} px\n'
                  'Child:  ${_childWidth.toInt()}×${_childHeight.toInt()} px\n'
                  'Alignment: ${_alignOptions[_alignIndex]['label']}\n'
                  'Clip: ${_showClip ? "ON" : "OFF"}\n'
                  'Overflow: ${_childWidth > _layoutWidth || _childHeight > _layoutHeight ? "YES" : "No"}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 50.0,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: Colors.deepPurple,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40.0,
          child: Text(
            '${value.toInt()}',
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// Grid painter for live demo background
class _SOBGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.15)
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==================================================================
// Comparison Visual — side-by-side SizedBox vs SizedOverflowBox
// ==================================================================
class _SOBComparisonVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                'SizedBox(100×60)',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: SizedBox(
                    width: 100.0,
                    height: 60.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Center(
                        child: Text(
                          'constrained\nto 100×60',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Child is forced to fit',
                style: TextStyle(fontSize: 10.0, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: [
              const Text(
                'SizedOverflowBox(100×60)',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: SizedOverflowBox(
                    size: const Size(100.0, 60.0),
                    child: Container(
                      width: 140.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.2),
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Center(
                        child: Text(
                          'overflows\nto 140×80',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Child overflows freely',
                style: TextStyle(fontSize: 10.0, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// Use Case Demos
// ==================================================================

// Badge Demo — notification count positioned via SizedOverflowBox
class _SOBBadgeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The base icon/button
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.mail_outline, color: Colors.blue, size: 28),
          ),
          // Badge via SizedOverflowBox at top-right
          Positioned(
            right: -6,
            top: -6,
            child: SizedOverflowBox(
              size: Size.zero,
              alignment: Alignment.center,
              child: Container(
                width: 22.0,
                height: 22.0,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Decorative Demo — glow/highlight extending beyond a card
class _SOBDecorativeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow extending from a small area
            SizedOverflowBox(
              size: const Size(60.0, 60.0),
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.amber.withValues(alpha: 0.4),
                      Colors.amber.withValues(alpha: 0.0),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // The actual star icon
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}

// Tooltip Demo — anchored tooltip extending from a point
class _SOBTooltipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hover target', style: TextStyle(fontSize: 12.0)),
          const SizedBox(width: 4.0),
          const Icon(Icons.help_outline, size: 16, color: Colors.teal),
          SizedOverflowBox(
            size: Size.zero,
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'Tooltip anchored via\nSizedOverflowBox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Transition Demo — stable layout while child animates
class _SOBTransitionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 30.0,
              color: Colors.grey[300],
              child: const Center(
                child: Text('A', style: TextStyle(fontSize: 12.0)),
              ),
            ),
            // Fixed layout slot for animated element
            SizedOverflowBox(
              size: const Size(60.0, 30.0),
              child: Container(
                width: 80.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.indigo, width: 1.5),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Center(
                  child: Text(
                    'Animated',
                    style: TextStyle(fontSize: 10.0, color: Colors.indigo),
                  ),
                ),
              ),
            ),
            Container(
              width: 60.0,
              height: 30.0,
              color: Colors.grey[300],
              child: const Center(
                child: Text('B', style: TextStyle(fontSize: 12.0)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'A and B maintain stable positions\nwhile the middle element overflows',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
