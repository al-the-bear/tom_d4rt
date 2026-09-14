// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EdgeInsets, EdgeInsetsDirectional from painting
// Deep Demo: Visual demonstration of EdgeInsets constructors, operators, methods
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EdgeInsets Deep Demo executing');

  // ============================================================
  // SECTION 1: Constructor Overview Cards
  // ============================================================
  print('=== Section 1: Constructor Overview ===');

  final constructorCards = <Widget>[];

  final ctorAll = EdgeInsets.all(16.0);
  print('EdgeInsets.all(16.0) -> $ctorAll');
  constructorCards.add(
    _buildCtorCard(
      Icons.crop_square,
      '.all(16)',
      'Uniform on all sides',
      'L:${ctorAll.left} T:${ctorAll.top} R:${ctorAll.right} B:${ctorAll.bottom}',
      Colors.blue,
    ),
  );

  final ctorSym = EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0);
  print('EdgeInsets.symmetric(h:24,v:8) -> $ctorSym');
  constructorCards.add(
    _buildCtorCard(
      Icons.swap_horiz,
      '.symmetric(h:24,v:8)',
      'Horizontal and vertical pairs',
      'L:${ctorSym.left} T:${ctorSym.top} R:${ctorSym.right} B:${ctorSym.bottom}',
      Colors.teal,
    ),
  );

  final ctorOnly = EdgeInsets.only(left: 12.0, top: 4.0, bottom: 20.0);
  print('EdgeInsets.only(l:12,t:4,b:20) -> $ctorOnly');
  constructorCards.add(
    _buildCtorCard(
      Icons.tune,
      '.only(l:12,t:4,b:20)',
      'Pick individual sides',
      'L:${ctorOnly.left} T:${ctorOnly.top} R:${ctorOnly.right} B:${ctorOnly.bottom}',
      Colors.orange,
    ),
  );

  final ctorLTRB = EdgeInsets.fromLTRB(2.0, 6.0, 18.0, 30.0);
  print('EdgeInsets.fromLTRB(2,6,18,30) -> $ctorLTRB');
  constructorCards.add(
    _buildCtorCard(
      Icons.format_align_left,
      '.fromLTRB(2,6,18,30)',
      'All four sides positional',
      'L:${ctorLTRB.left} T:${ctorLTRB.top} R:${ctorLTRB.right} B:${ctorLTRB.bottom}',
      Colors.purple,
    ),
  );

  final ctorZero = EdgeInsets.zero;
  print('EdgeInsets.zero -> $ctorZero');
  constructorCards.add(
    _buildCtorCard(
      Icons.circle_outlined,
      '.zero',
      'A no-op constant',
      'L:${ctorZero.left} T:${ctorZero.top} R:${ctorZero.right} B:${ctorZero.bottom}',
      Colors.grey,
    ),
  );

  print('Created ${constructorCards.length} constructor cards');

  // ============================================================
  // SECTION 2: Visual Padding Gallery (the recurring idiom)
  // ============================================================
  print('=== Section 2: Visual Padding Gallery ===');

  final galleryItems = <Widget>[];

  final galleryEntries = <Map<String, dynamic>>[
    {
      'label': 'EdgeInsets.all(20)',
      'insets': EdgeInsets.all(20.0),
      'color': Colors.indigo,
    },
    {
      'label': 'EdgeInsets.symmetric(h:32,v:8)',
      'insets': EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      'color': Colors.teal,
    },
    {
      'label': 'EdgeInsets.only(left:40)',
      'insets': EdgeInsets.only(left: 40.0),
      'color': Colors.orange,
    },
    {
      'label': 'EdgeInsets.fromLTRB(8,24,40,4)',
      'insets': EdgeInsets.fromLTRB(8.0, 24.0, 40.0, 4.0),
      'color': Colors.purple,
    },
    {
      'label': 'EdgeInsets.zero',
      'insets': EdgeInsets.zero,
      'color': Colors.blueGrey,
    },
  ];

  for (final entry in galleryEntries) {
    final insets = entry['insets'] as EdgeInsets;
    final color = entry['color'] as Color;
    final label = entry['label'] as String;
    print(
      '  Gallery $label: collapsedSize=${insets.collapsedSize} h=${insets.horizontal} v=${insets.vertical}',
    );
    galleryItems.add(_buildInsetRing(label, insets, color));
  }

  print('Created ${galleryItems.length} gallery items');

  // ============================================================
  // SECTION 3: Arithmetic Operators
  // ============================================================
  print('=== Section 3: Arithmetic Operators ===');

  final base = EdgeInsets.all(12.0);
  final other = EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0);
  print('base = $base');
  print('other = $other');

  final sum = base + other;
  final diff = base - other;
  final negated = -base;
  final scaled = base * 2.0;
  final divided = base / 2.0;
  final intDiv = base ~/ 5;
  final mod = base % 5.0;

  print('base + other = $sum');
  print('base - other = $diff');
  print('-base = $negated');
  print('base * 2.0 = $scaled');
  print('base / 2.0 = $divided');
  print('base ~/ 5 = $intDiv');
  print('base % 5.0 = $mod');

  final operatorRows = <Widget>[];
  operatorRows.add(
    _buildOperatorPair('+', 'addition', base, other, sum, Colors.green),
  );
  operatorRows.add(
    _buildOperatorPair('-', 'subtraction', base, other, diff, Colors.orange),
  );
  operatorRows.add(
    _buildOperatorPair(
      '*',
      'scale by 2.0',
      base,
      EdgeInsets.all(2.0),
      scaled,
      Colors.blue,
    ),
  );
  operatorRows.add(
    _buildOperatorPair(
      '/',
      'divide by 2.0',
      base,
      EdgeInsets.all(2.0),
      divided,
      Colors.purple,
    ),
  );
  operatorRows.add(
    _buildOperatorPair(
      '~/',
      'int divide by 5',
      base,
      EdgeInsets.all(5.0),
      intDiv,
      Colors.indigo,
    ),
  );
  operatorRows.add(
    _buildOperatorPair(
      '%',
      'modulo 5.0',
      base,
      EdgeInsets.all(5.0),
      mod,
      Colors.brown,
    ),
  );
  print('Created ${operatorRows.length} operator demonstrations (negated=$negated)');

  // ============================================================
  // SECTION 4: Methods & Properties Showcase
  // ============================================================
  print('=== Section 4: Methods & Properties ===');

  final fromLTRB = EdgeInsets.fromLTRB(4.0, 8.0, 16.0, 32.0);
  final copied = fromLTRB.copyWith(left: 40.0);
  final flipped = fromLTRB.flipped;
  print('original = $fromLTRB');
  print('copyWith(left:40) = $copied');
  print('flipped = $flipped');
  print('horizontal = ${fromLTRB.horizontal}');
  print('vertical = ${fromLTRB.vertical}');
  print('collapsedSize = ${fromLTRB.collapsedSize}');

  final baseRect = Rect.fromLTWH(0.0, 0.0, 100.0, 100.0);
  final baseSize = Size(100.0, 100.0);
  final inflRect = fromLTRB.inflateRect(baseRect);
  final deflRect = fromLTRB.deflateRect(baseRect);
  final inflSize = fromLTRB.inflateSize(baseSize);
  final deflSize = fromLTRB.deflateSize(baseSize);
  print('inflateRect(100x100) = $inflRect');
  print('deflateRect(100x100) = $deflRect');
  print('inflateSize(100x100) = $inflSize');
  print('deflateSize(100x100) = $deflSize');

  final methodCards = <Widget>[];
  methodCards.add(
    _buildMethodCard(
      Icons.content_copy,
      'copyWith',
      'fromLTRB(4,8,16,32).copyWith(left:40)',
      'left=${copied.left} top=${copied.top} right=${copied.right} bottom=${copied.bottom}',
      Colors.blue,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.flip,
      'flipped',
      'left<->right, top<->bottom',
      'left=${flipped.left} top=${flipped.top} right=${flipped.right} bottom=${flipped.bottom}',
      Colors.cyan,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.straighten,
      'horizontal/vertical',
      'sum of L+R and T+B',
      'horizontal=${fromLTRB.horizontal} vertical=${fromLTRB.vertical}',
      Colors.teal,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.crop_free,
      'collapsedSize',
      'total padding consumed',
      'Size(${fromLTRB.collapsedSize.width}, ${fromLTRB.collapsedSize.height})',
      Colors.green,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.zoom_out_map,
      'inflateSize(100x100)',
      'grow Size by insets',
      'Size(${inflSize.width}, ${inflSize.height})',
      Colors.orange,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.zoom_in_map,
      'deflateSize(100x100)',
      'shrink Size by insets',
      'Size(${deflSize.width}, ${deflSize.height})',
      Colors.deepOrange,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.open_in_full,
      'inflateRect(100x100)',
      'expand Rect by insets',
      'Rect(${inflRect.left}, ${inflRect.top}, ${inflRect.right}, ${inflRect.bottom})',
      Colors.purple,
    ),
  );
  methodCards.add(
    _buildMethodCard(
      Icons.close_fullscreen,
      'deflateRect(100x100)',
      'shrink Rect by insets',
      'Rect(${deflRect.left}, ${deflRect.top}, ${deflRect.right}, ${deflRect.bottom})',
      Colors.deepPurple,
    ),
  );

  print('Created ${methodCards.length} method cards');

  // ============================================================
  // SECTION 5: EdgeInsets.lerp Animation Strip
  // ============================================================
  print('=== Section 5: EdgeInsets.lerp animation strip ===');

  final lerpStart = EdgeInsets.all(0.0);
  final lerpEnd = EdgeInsets.all(40.0);
  final lerpStrip = <Widget>[];
  final stops = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  for (final t in stops) {
    final lerped = EdgeInsets.lerp(lerpStart, lerpEnd, t)!;
    print('EdgeInsets.lerp(0, 40, $t) = $lerped');
    lerpStrip.add(
      Container(
        width: 100.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          border: Border.all(color: Colors.cyan.shade400, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              ),
              child: Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Colors.cyan.shade900,
                ),
              ),
            ),
            Container(
              padding: lerped,
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade700,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Text(
                '${lerped.left.toStringAsFixed(0)}px',
                style: TextStyle(fontSize: 10.0, color: Colors.cyan.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${lerpStrip.length} lerp frames');

  // ============================================================
  // SECTION 6: EdgeInsetsDirectional LTR vs RTL
  // ============================================================
  print('=== Section 6: EdgeInsetsDirectional ===');

  final dirInsets = EdgeInsetsDirectional.fromSTEB(40.0, 8.0, 4.0, 8.0);
  final resolvedLTR = dirInsets.resolve(TextDirection.ltr);
  final resolvedRTL = dirInsets.resolve(TextDirection.rtl);
  print('EdgeInsetsDirectional.fromSTEB(40,8,4,8) = $dirInsets');
  print('resolve(ltr) = $resolvedLTR');
  print('resolve(rtl) = $resolvedRTL');

  final dirAll = EdgeInsetsDirectional.all(12.0);
  final dirOnly = EdgeInsetsDirectional.only(start: 24.0, end: 4.0);
  final dirSym = EdgeInsetsDirectional.symmetric(
    horizontal: 16.0,
    vertical: 6.0,
  );
  print('EdgeInsetsDirectional.all(12) = $dirAll');
  print('EdgeInsetsDirectional.only(s:24,e:4) = $dirOnly');
  print('EdgeInsetsDirectional.symmetric(h:16,v:6) = $dirSym');

  Widget buildDirSample(TextDirection dir, String label, Color color) {
    return Expanded(
      child: Directionality(
        textDirection: dir,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    dir == TextDirection.ltr
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    color: color,
                    size: 18.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                color: color.withValues(alpha: 0.15),
                child: Padding(
                  padding: dirInsets,
                  child: Container(
                    height: 24.0,
                    color: color,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'start:40 top:8 end:4 bottom:8',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final dirRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildDirSample(TextDirection.ltr, 'LTR', Colors.indigo),
      buildDirSample(TextDirection.rtl, 'RTL', Colors.pink),
    ],
  );

  print('Built directional row');

  // ============================================================
  // SECTION 7: Real-World Component Cards
  // ============================================================
  print('=== Section 7: Real-World Cards ===');

  final profileCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade400,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, size: 32.0, color: Colors.white),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile card',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'padding: EdgeInsets.fromLTRB(16, 20, 16, 16)',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.indigo.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final notificationCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: Colors.amber.shade700, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: Colors.amber.shade800, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification banner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
              Text(
                'padding: EdgeInsets.all(14)',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final buttonRow = Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade600,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'symmetric(h:20,v:10)',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
        SizedBox(width: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'all(10)',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
        SizedBox(width: 12.0),
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 8.0, 12.0, 8.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade600,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'fromLTRB(20,8,12,8)',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ],
    ),
  );

  final realWorldList = <Widget>[profileCard, notificationCard, buttonRow];
  print('Created ${realWorldList.length} real-world widgets');

  // ============================================================
  // SECTION 8: Use-Case Timeline
  // ============================================================
  print('=== Section 8: Use-Case Timeline ===');

  final timelineSteps = <Map<String, dynamic>>[
    {
      'title': 'Page-level padding',
      'desc': 'Wrap SingleChildScrollView in EdgeInsets.all(16) for breathing room',
      'icon': Icons.crop_din,
      'color': Colors.blue,
    },
    {
      'title': 'Symmetric chip padding',
      'desc': 'Chips and buttons read best with symmetric(h:16,v:8)',
      'icon': Icons.swap_horiz,
      'color': Colors.teal,
    },
    {
      'title': 'List item separator',
      'desc': 'EdgeInsets.only(bottom:8) between cards keeps the rhythm',
      'icon': Icons.format_line_spacing,
      'color': Colors.orange,
    },
    {
      'title': 'Form field offset',
      'desc': 'fromLTRB compensates for asymmetric icon decorations',
      'icon': Icons.text_fields,
      'color': Colors.purple,
    },
    {
      'title': 'RTL-aware layout',
      'desc': 'Switch to EdgeInsetsDirectional when supporting bidi text',
      'icon': Icons.translate,
      'color': Colors.pink,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineSteps.length; i++) {
    final step = timelineSteps[i];
    final color = step['color'] as Color;
    final isLast = i == timelineSteps.length - 1;

    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 36.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0.0 : 12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${timelineWidgets.length} timeline widgets');

  // ============================================================
  // SECTION 9: Code Examples
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'EdgeInsets cheat sheet',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Constructors\n'
            'EdgeInsets.all(16);\n'
            'EdgeInsets.symmetric(horizontal: 24, vertical: 8);\n'
            'EdgeInsets.only(left: 12, top: 4, bottom: 20);\n'
            'EdgeInsets.fromLTRB(2, 6, 18, 30);\n'
            'EdgeInsets.zero;',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Operators\n'
            'final a = EdgeInsets.all(12);\n'
            'final b = EdgeInsets.symmetric(horizontal: 6, vertical: 4);\n'
            'a + b;   // combine\n'
            'a - b;   // subtract\n'
            '-a;      // negate\n'
            'a * 2;   // scale\n'
            'a / 2;   // shrink\n'
            'a ~/ 5;  // integer divide\n'
            'a % 5;   // modulo',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Methods\n'
            'final i = EdgeInsets.fromLTRB(4, 8, 16, 32);\n'
            'i.copyWith(left: 40);     // override one side\n'
            'i.flipped;                // mirror L<->R, T<->B\n'
            'i.horizontal;  i.vertical;  i.collapsedSize;\n'
            'i.inflateRect(rect);  i.deflateRect(rect);\n'
            'i.inflateSize(size);  i.deflateSize(size);\n'
            'EdgeInsets.lerp(a, b, t); // interpolate\n'
            '\n'
            '// Directional variant\n'
            'final d = EdgeInsetsDirectional.fromSTEB(40, 8, 4, 8);\n'
            'd.resolve(TextDirection.ltr); // -> EdgeInsets\n'
            'd.resolve(TextDirection.rtl); // mirrors start/end',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  print('Created code examples widget');

  // ============================================================
  // SECTION 10: Summary Panel
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.crop_square,
          'Four constructors cover most cases',
          'all / symmetric / only / fromLTRB compose every padding shape',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.calculate,
          'EdgeInsets is fully arithmetic',
          'Combine with +, -, *, /, ~/, %, unary - for derived insets',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.transform,
          'Use copyWith and flipped sparingly',
          'They are great for variants of an existing constant',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.translate,
          'Pick Directional for RTL support',
          'fromSTEB + resolve(TextDirection) keeps layouts bidi-safe',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.animation,
          'EdgeInsets.lerp animates padding',
          'AnimatedPadding and TweenAnimationBuilder use it under the hood',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.straighten,
          'horizontal/vertical/collapsedSize',
          'Quickly know how much space the inset consumes',
          Colors.teal,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('EdgeInsets Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.crop_square, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'EdgeInsets',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Padding & margin geometry — every constructor, operator & helper',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Constructor cards
        _sectionTitle('1. Constructor Overview'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: constructorCards),
        SizedBox(height: 32.0),

        // Section 2: Padding gallery
        _sectionTitle('2. Visual Padding Gallery'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: galleryItems),
        SizedBox(height: 32.0),

        // Section 3: Operators
        _sectionTitle('3. Arithmetic Operators'),
        SizedBox(height: 12.0),
        Column(children: operatorRows),
        SizedBox(height: 32.0),

        // Section 4: Methods
        _sectionTitle('4. Methods & Properties'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: methodCards),
        SizedBox(height: 32.0),

        // Section 5: lerp strip
        _sectionTitle('5. EdgeInsets.lerp Strip'),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: lerpStrip),
        ),
        SizedBox(height: 32.0),

        // Section 6: Directional
        _sectionTitle('6. EdgeInsetsDirectional (LTR vs RTL)'),
        SizedBox(height: 12.0),
        dirRow,
        SizedBox(height: 32.0),

        // Section 7: Real world
        _sectionTitle('7. Real-World Patterns'),
        SizedBox(height: 12.0),
        Column(children: realWorldList),
        SizedBox(height: 32.0),

        // Section 8: Timeline
        _sectionTitle('8. Use-Case Timeline'),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 32.0),

        // Section 9: Code examples
        _sectionTitle('9. Code Examples'),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 10: Summary
        _sectionTitle('10. Summary'),
        summaryPanel,
      ],
    ),
  );
}

// =============================================================
// Helpers
// =============================================================

Widget _sectionTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

Widget _buildCtorCard(
  IconData icon,
  String title,
  String subtitle,
  String values,
  Color color,
) {
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.05), color.withValues(alpha: 0.18)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            values,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// The recurring visual idiom: thick coloured outer ring whose `padding`
// is the EdgeInsets under demonstration, with an inner Container showing
// the inset area, and a label with the literal that produced it.
Widget _buildInsetRing(String label, EdgeInsets insets, Color color) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          // The thick outer ring representing the EdgeInsets being demoed.
          padding: insets,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            border: Border.all(color: color, width: 3.0),
          ),
          child: Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'inset area',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            'L:${insets.left} T:${insets.top} R:${insets.right} B:${insets.bottom}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOperatorPair(
  String symbol,
  String name,
  EdgeInsets left,
  EdgeInsets right,
  EdgeInsets result,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                symbol,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _miniInsetBox(left, color)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                symbol,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(child: _miniInsetBox(right, color)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                '=',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: color,
                ),
              ),
            ),
            Expanded(child: _miniInsetBox(result, color)),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'L:${result.left.toStringAsFixed(1)} T:${result.top.toStringAsFixed(1)} R:${result.right.toStringAsFixed(1)} B:${result.bottom.toStringAsFixed(1)}',
            style: TextStyle(
              color: Colors.green.shade300,
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _miniInsetBox(EdgeInsets insets, Color color) {
  // Clamp visual padding so extreme operators do not break layout.
  final clamped = EdgeInsets.fromLTRB(
    insets.left.abs().clamp(0.0, 24.0),
    insets.top.abs().clamp(0.0, 24.0),
    insets.right.abs().clamp(0.0, 24.0),
    insets.bottom.abs().clamp(0.0, 24.0),
  );
  return Container(
    height: 80.0,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 2.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Padding(
      padding: clamped,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    ),
  );
}

Widget _buildMethodCard(
  IconData icon,
  String title,
  String subtitle,
  String value,
  Color color,
) {
  return Container(
    width: 240.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.green.shade300,
              fontFamily: 'monospace',
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
