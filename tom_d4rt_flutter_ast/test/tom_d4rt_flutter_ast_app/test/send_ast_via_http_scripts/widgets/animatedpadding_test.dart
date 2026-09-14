// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demonstration of AnimatedPadding from Flutter
// widgets. AnimatedPadding is an ImplicitlyAnimatedWidget that smoothly tweens
// its `padding` whenever the value changes.
//
// Constructor:
//   AnimatedPadding({
//     required EdgeInsetsGeometry padding,
//     required Duration duration,
//     Curve curve = Curves.linear,
//     VoidCallback? onEnd,
//     Widget? child,
//   })
//
// This script renders AnimatedPadding instances at static padding values
// (since the D4rt host cannot drive setState). The mint/turquoise palette is
// used throughout to give a single coherent visual identity.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedPadding Deep Demo executing');

  // ============================================================
  // PALETTE
  // ============================================================
  final Color mint50 = Color(0xFFE0F7F2);
  final Color mint100 = Color(0xFFB2EBE0);
  final Color mint200 = Color(0xFF80DECC);
  final Color mint300 = Color(0xFF4DD0B5);
  final Color mint400 = Color(0xFF26C2A0);
  final Color mint500 = Color(0xFF00B48A);
  final Color mint600 = Color(0xFF009A77);
  final Color mint700 = Color(0xFF00805F);
  final Color mint800 = Color(0xFF006649);
  final Color mint900 = Color(0xFF004D36);
  final Color teal50 = Color(0xFFE0F2F1);
  final Color teal200 = Color(0xFF80CBC4);
  final Color teal400 = Color(0xFF26A69A);
  final Color teal700 = Color(0xFF00796B);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [mint700, mint400, teal400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: mint700.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: teal400.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.format_indent_increase,
              size: 56.0,
              color: Colors.white,
            ),
            SizedBox(width: 12.0),
            Icon(Icons.timelapse, size: 56.0, color: Colors.white),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'AnimatedPadding',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Implicitly animated EdgeInsets transitions',
          style: TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'package:flutter/material.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [mint50, teal50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: mint300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: mint300.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy: padding rectangle',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: mint900,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'AnimatedPadding inserts a transparent border around its child. '
          'The four edge-values (left/top/right/bottom) are tweened.',
          style: TextStyle(fontSize: 12.0, color: mint800),
        ),
        SizedBox(height: 16.0),
        // Outer "padding rectangle" (mint border) with inner child
        Center(
          child: Container(
            width: 280.0,
            decoration: BoxDecoration(
              color: mint100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: mint500, width: 2.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(48.0, 32.0, 48.0, 32.0),
                  child: Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: mint600,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'child',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 6.0,
                  top: 4.0,
                  child: Text(
                    'top: 32',
                    style: TextStyle(fontSize: 10.0, color: mint800),
                  ),
                ),
                Positioned(
                  right: 6.0,
                  bottom: 4.0,
                  child: Text(
                    'bottom: 32',
                    style: TextStyle(fontSize: 10.0, color: mint800),
                  ),
                ),
                Positioned(
                  left: 4.0,
                  top: 50.0,
                  child: Text(
                    'left: 48',
                    style: TextStyle(fontSize: 10.0, color: mint800),
                  ),
                ),
                Positioned(
                  right: 4.0,
                  top: 50.0,
                  child: Text(
                    'right: 48',
                    style: TextStyle(fontSize: 10.0, color: mint800),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: mint200.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'EdgeInsets.fromLTRB(48, 32, 48, 32)  ===  EdgeInsets.symmetric('
            'horizontal: 48, vertical: 32)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: mint900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: Real AnimatedPadding instances at different paddings
  // ============================================================
  print('=== Section 3: AnimatedPadding instances at varying padding ===');

  final paddingValues = [4.0, 8.0, 16.0, 24.0, 32.0, 48.0];
  final paddingCards = <Widget>[];
  for (final p in paddingValues) {
    final ap = AnimatedPadding(
      padding: EdgeInsets.all(p),
      duration: Duration(milliseconds: 300),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: mint500,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: mint700.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '${p.toInt()}px',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ),
    );
    print('AnimatedPadding(EdgeInsets.all($p)) created');

    paddingCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: mint50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: mint300, width: 1.5),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: mint200.withValues(alpha: 0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                'EdgeInsets.all(${p.toInt()})',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: mint900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 130.0,
              decoration: BoxDecoration(
                color: mint100.withValues(alpha: 0.3),
              ),
              child: ap,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${paddingCards.length} padding cards');

  // ============================================================
  // SECTION 4: EdgeInsets variants
  // ============================================================
  print('=== Section 4: EdgeInsets variants ===');

  final variantSpecs = [
    {
      'label': 'EdgeInsets.only(left: 24)',
      'padding': EdgeInsets.only(left: 24.0),
    },
    {
      'label': 'EdgeInsets.only(top: 24)',
      'padding': EdgeInsets.only(top: 24.0),
    },
    {
      'label': 'fromLTRB(8,32,40,4)',
      'padding': EdgeInsets.fromLTRB(8.0, 32.0, 40.0, 4.0),
    },
    {
      'label': 'symmetric(h:24, v:8)',
      'padding': EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    },
  ];

  final variantCards = <Widget>[];
  for (final spec in variantSpecs) {
    final padding = spec['padding'] as EdgeInsets;
    final label = spec['label'] as String;
    final variant = AnimatedPadding(
      padding: padding,
      duration: Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [teal400, mint500],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
    print('AnimatedPadding variant: $label');

    variantCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: mint400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: mint400.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: mint800,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 90.0,
              decoration: BoxDecoration(
                color: mint50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: mint200,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: variant,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${variantCards.length} variant cards');

  // ============================================================
  // SECTION 5: Curve showcase
  // ============================================================
  print('=== Section 5: Curve showcase ===');

  final curveSpecs = [
    {'label': 'linear', 'curve': Curves.linear, 'color': mint300},
    {'label': 'easeIn', 'curve': Curves.easeIn, 'color': mint400},
    {'label': 'easeOut', 'curve': Curves.easeOut, 'color': mint500},
    {'label': 'easeInOut', 'curve': Curves.easeInOut, 'color': mint600},
    {'label': 'bounceIn', 'curve': Curves.bounceIn, 'color': teal400},
    {'label': 'elasticOut', 'curve': Curves.elasticOut, 'color': teal700},
  ];

  final curveCards = <Widget>[];
  for (final spec in curveSpecs) {
    final curve = spec['curve'] as Curve;
    final label = spec['label'] as String;
    final color = spec['color'] as Color;
    final cw = AnimatedPadding(
      padding: EdgeInsets.all(24.0),
      duration: Duration(milliseconds: 600),
      curve: curve,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
      ),
    );
    print('AnimatedPadding(curve: $label) created');

    curveCards.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, mint50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                'Curves.$label',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 110.0, child: cw),
          ],
        ),
      ),
    );
  }
  print('Created ${curveCards.length} curve cards');

  // ============================================================
  // SECTION 6: Duration spectrum
  // ============================================================
  print('=== Section 6: Duration spectrum ===');

  final durationSpecs = [
    {
      'label': '100ms',
      'duration': Duration(milliseconds: 100),
      'note': 'micro feedback',
    },
    {
      'label': '300ms',
      'duration': Duration(milliseconds: 300),
      'note': 'standard UI',
    },
    {
      'label': '600ms',
      'duration': Duration(milliseconds: 600),
      'note': 'noticeable change',
    },
    {
      'label': '1200ms',
      'duration': Duration(milliseconds: 1200),
      'note': 'dramatic / hero',
    },
  ];

  final durationCards = <Widget>[];
  for (final spec in durationSpecs) {
    final duration = spec['duration'] as Duration;
    final label = spec['label'] as String;
    final note = spec['note'] as String;
    final dw = AnimatedPadding(
      padding: EdgeInsets.all(20.0),
      duration: duration,
      curve: Curves.easeInOut,
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [mint400, teal400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
    print('AnimatedPadding(duration: $label) created');

    durationCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: mint300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: mint200.withValues(alpha: 0.5),
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
                Icon(Icons.timer, size: 16.0, color: mint700),
                SizedBox(width: 6.0),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: mint900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              note,
              style: TextStyle(
                fontSize: 10.0,
                color: mint700,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 80.0, child: dw),
          ],
        ),
      ),
    );
  }
  print('Created ${durationCards.length} duration cards');

  // ============================================================
  // SECTION 7: AnimatedPadding vs Padding
  // ============================================================
  print('=== Section 7: AnimatedPadding vs Padding ===');

  final vsPaddingCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [mint50, mint100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: mint400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: mint500.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AnimatedPadding vs Padding',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: mint900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: mint300, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.crop_square, size: 16.0, color: mint700),
                        SizedBox(width: 4.0),
                        Text(
                          'Padding',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: mint900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '- Static spacing',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                    Text(
                      '- Snap to new value',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                    Text(
                      '- No tween, no curve',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: mint600, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timelapse, size: 16.0, color: mint700),
                        SizedBox(width: 4.0),
                        Text(
                          'AnimatedPadding',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: mint900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '- Implicit animation',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                    Text(
                      '- Tweens between values',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                    Text(
                      '- Curve & duration aware',
                      style: TextStyle(fontSize: 11.0, color: mint800),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: mint700,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Use Padding for static layouts. Use AnimatedPadding when the '
            'EdgeInsets value changes over time and you want a smooth '
            'transition without managing an AnimationController.',
            style: TextStyle(fontSize: 11.0, color: Colors.white),
          ),
        ),
      ],
    ),
  );
  print('vs Padding card created');

  // ============================================================
  // SECTION 8: AnimatedPadding vs AnimatedContainer (table)
  // ============================================================
  print('=== Section 8: AnimatedPadding vs AnimatedContainer ===');

  final vsContainerTable = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [teal50, mint50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: teal200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: teal400.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AnimatedPadding vs AnimatedContainer',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: mint900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: mint600,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _hcell('Aspect', 110.0),
              _hcell('AnimatedPadding', 130.0),
              _hcell('AnimatedContainer', 130.0),
            ],
          ),
        ),
        _trow('Cost', 'Cheap (1 prop)', 'Heavier (many props)', mint50),
        _trow('Color tween', 'No', 'Yes', Colors.white),
        _trow('Size tween', 'Indirect', 'Yes (width/height)', mint50),
        _trow('Decoration', 'No', 'Yes', Colors.white),
        _trow('Padding tween', 'Yes', 'Yes', mint50),
        _trow('Single concern', 'Yes', 'No', Colors.white),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: mint200.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Prefer AnimatedPadding when only the spacing changes — it keeps '
            'the widget tree shallow and the intent obvious.',
            style: TextStyle(fontSize: 11.0, color: mint900),
          ),
        ),
      ],
    ),
  );
  print('vs Container table created');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  // Mock 1: search-bar focus expand
  final searchBarMock = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: mint300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: mint300.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search-bar focus expand',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mint900,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 8.0),
        AnimatedPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          duration: Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: mint50,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: mint400, width: 1.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.search, size: 16.0, color: mint700),
                SizedBox(width: 8.0),
                Text(
                  'Search…',
                  style: TextStyle(color: mint700, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'On focus, padding shrinks (8→2 horizontal) so the bar appears to '
          'stretch.',
          style: TextStyle(fontSize: 10.0, color: mint700),
        ),
      ],
    ),
  );
  print('Mock 1 (search bar) created');

  // Mock 2: pull-to-refresh banner reveal
  final pullToRefreshMock = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: mint300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: teal200.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pull-to-refresh banner reveal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mint900,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 8.0),
        AnimatedPadding(
          padding: EdgeInsets.only(top: 28.0),
          duration: Duration(milliseconds: 320),
          curve: Curves.easeInOut,
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mint500, teal400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text(
              'Refreshing…',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Top padding grows from 0→28 to push content below the banner.',
          style: TextStyle(fontSize: 10.0, color: mint700),
        ),
      ],
    ),
  );
  print('Mock 2 (pull-to-refresh) created');

  // Mock 3: snackbar slide-up
  final snackbarMock = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: mint300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: mint500.withValues(alpha: 0.35),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Snackbar slide-up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mint900,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 8.0),
        AnimatedPadding(
          padding: EdgeInsets.only(bottom: 12.0),
          duration: Duration(milliseconds: 260),
          curve: Curves.easeOut,
          child: Container(
            height: 36.0,
            decoration: BoxDecoration(
              color: mint800,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16.0,
                  color: mint200,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Saved',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Bottom padding tweens from 60→12; snackbar appears to slide up '
          'into the chrome.',
          style: TextStyle(fontSize: 10.0, color: mint700),
        ),
      ],
    ),
  );
  print('Mock 3 (snackbar) created');

  final realWorldRow = Column(
    children: [searchBarMock, pullToRefreshMock, snackbarMock],
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footgunCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), mint50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.3),
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
            Icon(Icons.warning_amber, color: Colors.orange.shade700),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _footgun(
          'Parent constraints + asymmetric padding',
          'If the parent is tightly constrained (e.g. SizedBox), large or '
              'asymmetric padding can squeeze the child below its minimum '
              'size or trigger overflow paint flicker mid-tween.',
          mint700,
        ),
        SizedBox(height: 8.0),
        _footgun(
          'Child must keep widget identity',
          'AnimatedPadding tweens by holding the same child element. '
              'Returning a fresh child Key on every build kills the tween '
              'and the padding will snap.',
          mint700,
        ),
        SizedBox(height: 8.0),
        _footgun(
          'onEnd fires per tween, not per logical state',
          'Each padding change schedules a tween, and onEnd fires when '
              'that tween completes. If you change the value again before '
              'the previous tween ends, you may see fewer onEnd callbacks '
              'than value changes.',
          mint700,
        ),
        SizedBox(height: 8.0),
        _footgun(
          'EdgeInsetsDirectional vs EdgeInsets',
          'AnimatedPadding accepts EdgeInsetsGeometry, so directional and '
              'absolute insets both work — but mixing them across rebuilds '
              'forces a resolve and may produce a non-smooth tween.',
          mint700,
        ),
      ],
    ),
  );
  print('Footgun card created');

  print('AnimatedPadding Deep Demo completed successfully');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return Scaffold(
    backgroundColor: mint50,
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          _sectionHeader('1. Anatomy', mint900),
          anatomyDiagram,
          SizedBox(height: 16.0),
          _sectionHeader('2. Real AnimatedPadding (varying padding)', mint900),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: paddingCards,
            ),
          ),
          SizedBox(height: 16.0),
          _sectionHeader('3. EdgeInsets variants', mint900),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: variantCards,
            ),
          ),
          SizedBox(height: 16.0),
          _sectionHeader('4. Curve showcase', mint900),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: curveCards,
            ),
          ),
          SizedBox(height: 16.0),
          _sectionHeader('5. Duration spectrum', mint900),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: durationCards,
            ),
          ),
          SizedBox(height: 16.0),
          _sectionHeader('6. AnimatedPadding vs Padding', mint900),
          vsPaddingCard,
          SizedBox(height: 8.0),
          _sectionHeader('7. AnimatedPadding vs AnimatedContainer', mint900),
          vsContainerTable,
          SizedBox(height: 8.0),
          _sectionHeader('8. Real-world mocks', mint900),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: realWorldRow,
          ),
          SizedBox(height: 8.0),
          _sectionHeader('9. Footguns', mint900),
          footgunCard,
          SizedBox(height: 24.0),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: mint700,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'End of AnimatedPadding deep demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _sectionHeader(String text, Color color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _hcell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
    ),
  );
}

Widget _trow(String aspect, String left, String right, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    decoration: BoxDecoration(color: bg),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            aspect,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D36),
            ),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            left,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF006649)),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            right,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF006649)),
          ),
        ),
      ],
    ),
  );
}

Widget _footgun(String title, String body, Color accent) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: accent,
          ),
        ),
        SizedBox(height: 4.0),
        Text(body, style: TextStyle(fontSize: 11.0, color: Color(0xFF004D36))),
      ],
    ),
  );
}
