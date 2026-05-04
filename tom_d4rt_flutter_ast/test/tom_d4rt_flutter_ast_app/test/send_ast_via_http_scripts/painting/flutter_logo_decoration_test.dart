// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlutterLogoDecoration from painting
// Deep Demo: Visual demonstration of FlutterLogoDecoration painting all
// three FlutterLogoStyle variants, color palettes, margin behaviors,
// container sizes, lerp morphs, anatomy diagrams, use cases, and
// comparisons with the higher-level FlutterLogo widget.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoDecoration Deep Demo executing');

  // ============================================================
  // SECTION 1: Style Variants (markOnly / horizontal / stacked)
  // ============================================================
  print('=== Section 1: FlutterLogoStyle variants ===');

  final markOnlyDeco = FlutterLogoDecoration(
    textColor: Color(0xFF42A5F5),
    style: FlutterLogoStyle.markOnly,
  );
  final horizontalDeco = FlutterLogoDecoration(
    textColor: Color(0xFF42A5F5),
    style: FlutterLogoStyle.horizontal,
  );
  final stackedDeco = FlutterLogoDecoration(
    textColor: Color(0xFF42A5F5),
    style: FlutterLogoStyle.stacked,
  );

  print('markOnly.style    = ${markOnlyDeco.style}');
  print('horizontal.style  = ${horizontalDeco.style}');
  print('stacked.style     = ${stackedDeco.style}');
  print('markOnly.margin   = ${markOnlyDeco.margin}');
  print('default textColor = ${markOnlyDeco.textColor}');

  final styleVariants = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF42A5F5), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x3342A5F5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FlutterLogoStyle Variants',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'The same FlutterLogoDecoration paints differently based on style.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildStyleCard('markOnly', markOnlyDeco, 96.0, 96.0),
            _buildStyleCard('horizontal', horizontalDeco, 200.0, 80.0),
            _buildStyleCard('stacked', stackedDeco, 140.0, 140.0),
          ],
        ),
      ],
    ),
  );
  print('Created style variants card');

  // ============================================================
  // SECTION 2: Anatomy Diagram (textColor / style / margin)
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFB8C00), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x33FB8C00),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of FlutterLogoDecoration',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'FlutterLogoDecoration({textColor, style, margin})',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Color(0xFFBF360C),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Diagram column
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Color(0xFFFFB74D), width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    width: 200.0,
                    height: 80.0,
                    decoration: FlutterLogoDecoration(
                      textColor: Color(0xFF1976D2),
                      style: FlutterLogoStyle.horizontal,
                      margin: EdgeInsets.all(6.0),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'horizontal + textColor + margin',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Color(0xFFBF360C),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            // Labels column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnatomyLabel(
                    'textColor',
                    'Color of the wordmark text (only for horizontal/stacked).',
                    Color(0xFF1976D2),
                  ),
                  SizedBox(height: 8.0),
                  _buildAnatomyLabel(
                    'style',
                    'markOnly / horizontal / stacked — controls the layout.',
                    Color(0xFF6A1B9A),
                  ),
                  SizedBox(height: 8.0),
                  _buildAnatomyLabel(
                    'margin',
                    'EdgeInsets reducing the painted region inside the box.',
                    Color(0xFFE65100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: textColor Palette
  // ============================================================
  print('=== Section 3: textColor palette ===');

  final colorPalette = <Map<String, dynamic>>[
    {'label': 'default blue', 'color': Color(0xFF42A5F5)},
    {'label': 'dark blue', 'color': Color(0xFF0D47A1)},
    {'label': 'custom hex', 'color': Color(0xFF8E24AA)},
    {'label': 'accent', 'color': Color(0xFFFF4081)},
    {'label': 'monochrome black', 'color': Color(0xFF000000)},
    {'label': 'monochrome white', 'color': Color(0xFFFFFFFF)},
  ];

  final colorCards = <Widget>[];
  for (var i = 0; i < colorPalette.length; i++) {
    final entry = colorPalette[i];
    final color = entry['color'] as Color;
    final label = entry['label'] as String;
    final deco = FlutterLogoDecoration(
      textColor: color,
      style: FlutterLogoStyle.horizontal,
    );
    print('color[$i] $label = $color');

    final isWhiteSwatch = label.contains('white');
    colorCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isWhiteSwatch ? Color(0xFF263238) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 180.0,
              height: 60.0,
              decoration: deco,
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: _readableTextOn(color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${colorCards.length} color cards');

  // ============================================================
  // SECTION 4: margin Behavior
  // ============================================================
  print('=== Section 4: margin behavior ===');

  final marginVariants = <Map<String, dynamic>>[
    {'label': 'EdgeInsets.zero', 'margin': EdgeInsets.zero},
    {'label': 'EdgeInsets.all(8)', 'margin': EdgeInsets.all(8.0)},
    {
      'label': 'symmetric(h:16,v:4)',
      'margin': EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    },
    {
      'label': 'only(left:24,top:8)',
      'margin': EdgeInsets.only(left: 24.0, top: 8.0),
    },
  ];

  final marginCards = <Widget>[];
  for (var i = 0; i < marginVariants.length; i++) {
    final entry = marginVariants[i];
    final margin = entry['margin'] as EdgeInsets;
    final label = entry['label'] as String;
    final deco = FlutterLogoDecoration(
      textColor: Color(0xFF1976D2),
      style: FlutterLogoStyle.horizontal,
      margin: margin,
    );
    print('margin[$i] $label = $margin');

    marginCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Color(0xFF66BB6A), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(0x3366BB6A),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Outer "box" so the margin reduction is visible
            Container(
              width: 200.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFF66BB6A), width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Container(decoration: deco),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${marginCards.length} margin cards');

  // ============================================================
  // SECTION 5: Size Showcase (32 / 64 / 128 / 256)
  // ============================================================
  print('=== Section 5: size showcase ===');

  final sizes = [32.0, 64.0, 128.0, 256.0];
  final sizeCards = <Widget>[];
  for (var i = 0; i < sizes.length; i++) {
    final size = sizes[i];
    final deco = FlutterLogoDecoration(
      textColor: Color(0xFF42A5F5),
      style: FlutterLogoStyle.markOnly,
    );
    print('size[$i] = ${size}px');

    sizeCards.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Color(0xFF90CAF9), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(0x2242A5F5),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: size,
              height: size,
              decoration: deco,
            ),
            SizedBox(height: 8.0),
            Text(
              '${size.toInt()} px',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${sizeCards.length} size cards');

  // ============================================================
  // SECTION 6: lerp Morph (markOnly+blue → horizontal+red)
  // ============================================================
  print('=== Section 6: lerp morph ===');

  final lerpA = FlutterLogoDecoration(
    textColor: Color(0xFF42A5F5),
    style: FlutterLogoStyle.markOnly,
  );
  final lerpB = FlutterLogoDecoration(
    textColor: Color(0xFFE53935),
    style: FlutterLogoStyle.horizontal,
  );

  final lerpStops = [0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpCards = <Widget>[];
  for (var i = 0; i < lerpStops.length; i++) {
    final t = lerpStops[i];
    final lerped = FlutterLogoDecoration.lerp(lerpA, lerpB, t);
    print('lerp t=$t => ${lerped?.runtimeType}');

    lerpCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.lerp(Color(0xFFE3F2FD), Color(0xFFFFEBEE), t) ??
                  Color(0xFFE3F2FD),
              Color.lerp(Color(0xFFBBDEFB), Color(0xFFFFCDD2), t) ??
                  Color(0xFFBBDEFB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Color.lerp(
                  Color(0xFF42A5F5),
                  Color(0xFFE53935),
                  t,
                ) ??
                Color(0xFF42A5F5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 110.0,
              height: 70.0,
              decoration: lerped ?? lerpA,
            ),
            SizedBox(height: 8.0),
            Text(
              't = ${t.toStringAsFixed(2)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${lerpCards.length} lerp cards');

  // ============================================================
  // SECTION 7: 3 styles x 4 colors variant grid
  // ============================================================
  print('=== Section 7: 3x4 variant grid ===');

  final gridStyles = [
    FlutterLogoStyle.markOnly,
    FlutterLogoStyle.horizontal,
    FlutterLogoStyle.stacked,
  ];
  final gridColors = [
    Color(0xFF42A5F5),
    Color(0xFFEF5350),
    Color(0xFF66BB6A),
    Color(0xFFAB47BC),
  ];

  final gridRows = <Widget>[];
  for (var s = 0; s < gridStyles.length; s++) {
    final style = gridStyles[s];
    final cells = <Widget>[];
    for (var c = 0; c < gridColors.length; c++) {
      final color = gridColors[c];
      final deco = FlutterLogoDecoration(textColor: color, style: style);
      print('grid[$s][$c] style=$style color=$color');

      // Pick container size per style for sensible aspect ratio.
      double cellW;
      double cellH;
      if (style == FlutterLogoStyle.markOnly) {
        cellW = 70.0;
        cellH = 70.0;
      } else if (style == FlutterLogoStyle.horizontal) {
        cellW = 130.0;
        cellH = 60.0;
      } else {
        cellW = 90.0;
        cellH = 100.0;
      }

      cells.add(
        Container(
          margin: EdgeInsets.all(6.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(width: cellW, height: cellH, decoration: deco),
              SizedBox(height: 6.0),
              Text(
                '${_styleName(style)} / 0x${_hex(color)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.0,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
    }
    gridRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'style: ${_styleName(style)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFF424242),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: cells,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${gridRows.length} grid rows');

  // ============================================================
  // SECTION 8: Use Cases
  // ============================================================
  print('=== Section 8: use cases ===');

  // Splash screen mock.
  final splashMock = Container(
    width: double.infinity,
    height: 220.0,
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x550D47A1),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Center(
      child: Container(
        width: 180.0,
        height: 180.0,
        decoration: FlutterLogoDecoration(
          textColor: Color(0xFFFFFFFF),
          style: FlutterLogoStyle.stacked,
        ),
      ),
    ),
  );

  // "Powered by Flutter" badge.
  final poweredBadge = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: Color(0xFF90CAF9), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0x2242A5F5),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Powered by',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          width: 110.0,
          height: 30.0,
          decoration: FlutterLogoDecoration(
            textColor: Color(0xFF1976D2),
            style: FlutterLogoStyle.horizontal,
          ),
        ),
      ],
    ),
  );

  // App launch graphic mock.
  final launchGraphic = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFAB47BC), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0x33AB47BC),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 96.0,
          height: 96.0,
          decoration: FlutterLogoDecoration(
            textColor: Color(0xFF6A1B9A),
            style: FlutterLogoStyle.markOnly,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'My Awesome App',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Launching...',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF6A1B9A)),
        ),
      ],
    ),
  );

  // Brand strip.
  final brandStrip = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x66263238),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90.0,
          height: 26.0,
          decoration: FlutterLogoDecoration(
            textColor: Color(0xFFFFFFFF),
            style: FlutterLogoStyle.horizontal,
          ),
        ),
        Text(
          'BUILT WITH FLUTTER',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB0BEC5),
            letterSpacing: 1.5,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: FlutterLogo Widget vs FlutterLogoDecoration
  // ============================================================
  print('=== Section 9: widget vs decoration ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF7E57C2), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x447E57C2),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FlutterLogo widget vs FlutterLogoDecoration',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildCompareCol(
                'FlutterLogo widget',
                'High-level wrapper widget. Handles its own size with `size:` and provides built-in animation hooks (duration/curve). Use it when you want a logo as a widget in a tree.',
                FlutterLogo(
                  size: 96.0,
                  textColor: Color(0xFF1976D2),
                  style: FlutterLogoStyle.horizontal,
                ),
                Color(0xFF1976D2),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: _buildCompareCol(
                'FlutterLogoDecoration',
                'Low-level Decoration. Plug into any DecoratedBox/Container.decoration. Use it when you need fine control over the painted region or to compose with other decorations.',
                Container(
                  width: 130.0,
                  height: 60.0,
                  decoration: FlutterLogoDecoration(
                    textColor: Color(0xFF7E57C2),
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
                Color(0xFF7E57C2),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created comparison section');

  // ============================================================
  // SECTION 10: Footguns / Caveats
  // ============================================================
  print('=== Section 10: footguns ===');

  final footgunSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE53935), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x33E53935),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Color(0xFFB71C1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns and Caveats',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildFootgun(
          'margin shrinks the painted area',
          'A non-zero margin reduces the rendered logo. Set explicit width/height on the surrounding container so the result is still visible at the intended size.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'markOnly is square',
          'The markOnly style keeps a 1:1 aspect ratio. Use a square container; non-square boxes leave whitespace on one axis.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'textColor only applies to wordmark',
          'The textColor argument controls the wordmark text color in horizontal and stacked styles. It has no visible effect with markOnly.',
        ),
        SizedBox(height: 8.0),
        _buildFootgun(
          'No background',
          'FlutterLogoDecoration paints only the logo. To add a background color or shadow, wrap in a BoxDecoration container or compose externally.',
        ),
      ],
    ),
  );
  print('Created footgun section');

  // ============================================================
  // SECTION 11: Code Snippets
  // ============================================================
  print('=== Section 11: code snippets ===');

  final codeSnippets = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF212121),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF80DEEA), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Code Snippets',
              style: TextStyle(
                color: Color(0xFF80DEEA),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Plain mark, default blue\n'
          'Container(\n'
          '  width: 96, height: 96,\n'
          '  decoration: FlutterLogoDecoration(),\n'
          ');',
          Color(0xFF90CAF9),
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Wordmark with custom color\n'
          'FlutterLogoDecoration(\n'
          '  textColor: Color(0xFF6A1B9A),\n'
          '  style: FlutterLogoStyle.horizontal,\n'
          ');',
          Color(0xFFCE93D8),
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Animated style/color morph\n'
          'final lerped = FlutterLogoDecoration.lerp(\n'
          '  a, b, t,\n'
          ');',
          Color(0xFF80CBC4),
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// Use as Container.decoration\n'
          'Container(\n'
          '  width: 200, height: 80,\n'
          '  decoration: FlutterLogoDecoration(\n'
          '    style: FlutterLogoStyle.stacked,\n'
          '    margin: EdgeInsets.all(8),\n'
          '  ),\n'
          ');',
          Color(0xFFFFAB91),
        ),
      ],
    ),
  );
  print('Created code snippets card');

  // ============================================================
  // SECTION 12: Property Matrix
  // ============================================================
  print('=== Section 12: property matrix ===');

  final propertyMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Reference',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Property', 110.0),
              _buildHeaderCell('Type', 110.0),
              _buildHeaderCell('Default', 130.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildMatrixRow('textColor', 'Color', '0xFF42A5F5'),
        _buildMatrixRow('style', 'FlutterLogoStyle', 'markOnly'),
        _buildMatrixRow('margin', 'EdgeInsets', 'EdgeInsets.zero'),
      ],
    ),
  );
  print('Created property matrix');

  print('FlutterLogoDecoration Deep Demo completed successfully');

  // ============================================================
  // Final Layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFFAFAFA),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0x550D47A1),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 8.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 120.0,
                  height: 90.0,
                  decoration: FlutterLogoDecoration(
                    textColor: Color(0xFFFFFFFF),
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'FlutterLogoDecoration',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Deep Visual Demo',
                  style: TextStyle(fontSize: 14.0, color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          _buildSectionTitle('1. FlutterLogoStyle Variants'),
          styleVariants,
          SizedBox(height: 16.0),

          _buildSectionTitle('2. Anatomy'),
          anatomyDiagram,
          SizedBox(height: 16.0),

          _buildSectionTitle('3. textColor Palette'),
          Wrap(alignment: WrapAlignment.center, children: colorCards),
          SizedBox(height: 16.0),

          _buildSectionTitle('4. margin Behavior'),
          Wrap(alignment: WrapAlignment.center, children: marginCards),
          SizedBox(height: 16.0),

          _buildSectionTitle('5. Container Sizes'),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: sizeCards,
          ),
          SizedBox(height: 16.0),

          _buildSectionTitle('6. lerp Morph'),
          Wrap(alignment: WrapAlignment.center, children: lerpCards),
          SizedBox(height: 16.0),

          _buildSectionTitle('7. 3 Styles x 4 Colors Grid'),
          ...gridRows,
          SizedBox(height: 16.0),

          _buildSectionTitle('8. Use Cases'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'Splash screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color(0xFF424242),
              ),
            ),
          ),
          splashMock,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              '"Powered by Flutter" badge',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color(0xFF424242),
              ),
            ),
          ),
          poweredBadge,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'App launch graphic',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color(0xFF424242),
              ),
            ),
          ),
          launchGraphic,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'Brand strip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color(0xFF424242),
              ),
            ),
          ),
          brandStrip,
          SizedBox(height: 16.0),

          _buildSectionTitle('9. Widget vs Decoration'),
          comparisonSection,
          SizedBox(height: 16.0),

          _buildSectionTitle('10. Footguns'),
          footgunSection,
          SizedBox(height: 16.0),

          _buildSectionTitle('11. Code Snippets'),
          codeSnippets,
          SizedBox(height: 16.0),

          _buildSectionTitle('12. Property Reference'),
          propertyMatrix,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF263238),
      ),
    ),
  );
}

Widget _buildStyleCard(
  String label,
  FlutterLogoDecoration deco,
  double width,
  double height,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFF1976D2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(0x331976D2),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Container(width: width, height: height, decoration: deco),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
          color: Color(0xFF0D47A1),
        ),
      ),
    ],
  );
}

Widget _buildAnatomyLabel(String name, String description, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 14.0,
        height: 14.0,
        margin: EdgeInsets.only(top: 2.0, right: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF5D4037)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCompareCol(
  String title,
  String description,
  Widget showcase,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: color,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(fontSize: 10.5, color: Color(0xFF424242)),
        ),
        SizedBox(height: 12.0),
        Center(child: showcase),
      ],
    ),
  );
}

Widget _buildFootgun(String title, String body) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFEF9A9A), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline, color: Color(0xFFC62828), size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Color(0xFFC62828),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(fontSize: 10.5, color: Color(0xFF424242)),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
      ),
    ),
  );
}

Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Color(0xFF212121),
      ),
    ),
  );
}

Widget _buildMatrixRow(String prop, String type, String defaultValue) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            prop,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF1565C0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          child: Text(
            type,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF6A1B9A),
            ),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            defaultValue,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF424242),
            ),
          ),
        ),
      ],
    ),
  );
}

String _styleName(FlutterLogoStyle style) {
  if (style == FlutterLogoStyle.markOnly) return 'markOnly';
  if (style == FlutterLogoStyle.horizontal) return 'horizontal';
  if (style == FlutterLogoStyle.stacked) return 'stacked';
  return 'unknown';
}

String _hex(Color c) {
  final v = c.value;
  final s = v.toRadixString(16).toUpperCase();
  // Pad to 8 chars (ARGB).
  if (s.length >= 8) return s.substring(0, 8);
  return s.padLeft(8, '0');
}

Color _readableTextOn(Color background) {
  // Cheap luminance check for white-or-black text.
  final r = (background.value >> 16) & 0xFF;
  final g = (background.value >> 8) & 0xFF;
  final b = background.value & 0xFF;
  final luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255.0;
  return luminance > 0.6 ? Color(0xFF000000) : Color(0xFFFFFFFF);
}
