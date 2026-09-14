// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demonstration of the Container widget.
// Container is the swiss-army composite widget that wraps Padding, Align,
// DecoratedBox, ConstrainedBox, and Transform. This demo walks through every
// major visual capability with twelve dedicated sections.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Container Deep Demo executing');

  // ============================================================
  // Palette - deep blue / indigo with cyan + purple accents.
  // ============================================================
  final Color deepInk = Color(0xFF0B1A4A);
  final Color deepBlue = Color(0xFF1A237E);
  final Color royalBlue = Color(0xFF283593);
  final Color indigo = Color(0xFF3949AB);
  final Color skyAccent = Color(0xFF00B0FF);
  final Color cyanAccent = Color(0xFF00E5FF);
  final Color purpleAccent = Color(0xFF7C4DFF);
  final Color magentaAccent = Color(0xFFE040FB);
  final Color softCard = Colors.grey.shade50;
  final Color softCardAlt = Colors.grey.shade100;

  print('Palette resolved: ink=$deepInk blue=$deepBlue indigo=$indigo');

  // ============================================================
  // SECTION 1: Title banner with deep-blue gradient
  // ============================================================
  print('=== Section 1: Title banner ===');

  final Widget titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deepInk, deepBlue, royalBlue, indigo],
        stops: [0.0, 0.4, 0.75, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: deepInk.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: skyAccent.withValues(alpha: 0.18),
          blurRadius: 32.0,
          spreadRadius: -2.0,
          offset: Offset(0.0, -4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [cyanAccent, skyAccent, deepBlue],
              radius: 0.85,
            ),
            boxShadow: [
              BoxShadow(
                color: cyanAccent.withValues(alpha: 0.4),
                blurRadius: 16.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Icon(Icons.crop_square, color: Colors.white, size: 38.0),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Container',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'A Deep Visual Demo - 12 Sections',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withValues(alpha: 0.85),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'wraps: Padding | Align | DecoratedBox | ConstrainedBox | Transform',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Built title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram - margin > decoration > padding > child
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  // Each layer is a Container nested inside the next, labelled with its role.
  // The outermost margin is shown as a dashed-style ring via Border.all.
  final Widget anatomyDiagram = Container(
    margin: EdgeInsets.all(24.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: indigo.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigo.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'margin (transparent space outside)',
          style: TextStyle(
            fontSize: 11.0,
            color: indigo,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: deepBlue.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: deepBlue, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: deepBlue.withValues(alpha: 0.25),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'decoration (background, border, shadow)',
                style: TextStyle(fontSize: 11.0, color: deepBlue),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: skyAccent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: skyAccent, width: 1.5),
                ),
                child: Column(
                  children: [
                    Text(
                      'padding (space inside decoration)',
                      style: TextStyle(fontSize: 11.0, color: skyAccent),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 14.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Text(
                        'child',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: deepInk,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'foregroundDecoration paints over everything above',
          style: TextStyle(
            fontSize: 11.0,
            color: purpleAccent,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Built anatomy diagram');

  // ============================================================
  // SECTION 3: Sizing variants
  // ============================================================
  print('=== Section 3: Sizing variants ===');

  // Helper inline construction: build sizing tiles as native list.
  final List<Map<String, dynamic>> sizingSpecs = [
    {
      'label': 'fixed 120 x 80',
      'width': 120.0,
      'height': 80.0,
      'note': 'both dimensions explicit',
    },
    {
      'label': 'width 160 only',
      'width': 160.0,
      'height': 0.0,
      'note': 'height shrinks to child',
    },
    {
      'label': 'height 100 only',
      'width': 0.0,
      'height': 100.0,
      'note': 'width grows / shrinks',
    },
    {
      'label': 'unconstrained',
      'width': 0.0,
      'height': 0.0,
      'note': 'wraps child tightly',
    },
  ];

  final List<Widget> sizingTiles = sizingSpecs.map((spec) {
    final String label = spec['label'] as String;
    final double w = spec['width'] as double;
    final double h = spec['height'] as double;
    final String note = spec['note'] as String;
    print('Sizing tile -> $label (w=$w, h=$h)');

    return Container(
      margin: EdgeInsets.all(8.0),
      width: w > 0.0 ? w : null,
      height: h > 0.0 ? h : null,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [skyAccent.withValues(alpha: 0.2), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: skyAccent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: skyAccent.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: deepBlue,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            note,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }).toList();
  print('Built ${sizingTiles.length} sizing tiles');

  final Widget sizingSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCard,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: sizingTiles,
    ),
  );

  // ============================================================
  // SECTION 4: Decoration gallery
  // ============================================================
  print('=== Section 4: Decoration gallery ===');

  final Widget solidDeco = Container(
    width: 130.0,
    height: 90.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: indigo,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'solid color',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );

  final Widget linearDeco = Container(
    width: 130.0,
    height: 90.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deepBlue, skyAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: skyAccent.withValues(alpha: 0.45),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'LinearGradient',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );

  final Widget radialDeco = Container(
    width: 130.0,
    height: 90.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [cyanAccent, royalBlue, deepInk],
        stops: [0.0, 0.6, 1.0],
        center: Alignment(-0.2, -0.2),
        radius: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: cyanAccent.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'RadialGradient',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );

  final Widget sweepDeco = Container(
    width: 130.0,
    height: 90.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: SweepGradient(
        colors: [
          deepBlue,
          purpleAccent,
          magentaAccent,
          skyAccent,
          cyanAccent,
          deepBlue,
        ],
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: purpleAccent.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'SweepGradient',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );

  final Widget circleDeco = Container(
    width: 90.0,
    height: 90.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [Colors.white, cyanAccent, deepBlue],
        stops: [0.0, 0.55, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: deepBlue.withValues(alpha: 0.5),
          blurRadius: 16.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'circle',
      style: TextStyle(
        color: deepInk,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    ),
  );

  final Widget decorationGallery = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCardAlt,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [solidDeco, linearDeco, radialDeco, sweepDeco, circleDeco],
    ),
  );
  print('Built decoration gallery');

  // ============================================================
  // SECTION 5: Border showcase
  // ============================================================
  print('=== Section 5: Border showcase ===');

  final Widget borderUniform = Container(
    width: 130.0,
    height: 80.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: deepBlue, width: 3.0),
    ),
    alignment: Alignment.center,
    child: Text(
      'Border.all(3px)',
      style: TextStyle(fontSize: 12.0, color: deepBlue),
    ),
  );

  final Widget borderRadiusCircular = Container(
    width: 130.0,
    height: 80.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: indigo, width: 2.0),
      borderRadius: BorderRadius.circular(20.0),
    ),
    alignment: Alignment.center,
    child: Text(
      'circular(20)',
      style: TextStyle(fontSize: 12.0, color: indigo),
    ),
  );

  final Widget borderRadiusOnly = Container(
    width: 130.0,
    height: 80.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: purpleAccent, width: 2.0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.0),
        bottomRight: Radius.circular(28.0),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'BorderRadius.only',
      style: TextStyle(fontSize: 12.0, color: purpleAccent),
    ),
  );

  final Widget borderPerSide = Container(
    width: 130.0,
    height: 80.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: deepBlue, width: 4.0),
        right: BorderSide(color: cyanAccent, width: 2.0),
        bottom: BorderSide(color: purpleAccent, width: 4.0),
        left: BorderSide(color: skyAccent, width: 2.0),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'per-side Border',
      style: TextStyle(fontSize: 12.0, color: deepInk),
    ),
  );

  final Widget borderDouble = Container(
    width: 130.0,
    height: 80.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: deepBlue, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: skyAccent, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.center,
      child: Text(
        'nested borders',
        style: TextStyle(fontSize: 12.0, color: skyAccent),
      ),
    ),
  );

  final Widget borderShowcase = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCard,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        borderUniform,
        borderRadiusCircular,
        borderRadiusOnly,
        borderPerSide,
        borderDouble,
      ],
    ),
  );
  print('Built border showcase');

  // ============================================================
  // SECTION 6: Shadow gallery
  // ============================================================
  print('=== Section 6: Shadow gallery ===');

  final Widget shadowSmall = Container(
    width: 140.0,
    height: 90.0,
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'small (blur 4)',
      style: TextStyle(fontSize: 12.0, color: deepInk),
    ),
  );

  final Widget shadowMedium = Container(
    width: 140.0,
    height: 90.0,
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: deepBlue.withValues(alpha: 0.25),
          blurRadius: 12.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'medium (blur 12)',
      style: TextStyle(fontSize: 12.0, color: deepInk),
    ),
  );

  final Widget shadowLarge = Container(
    width: 140.0,
    height: 90.0,
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: indigo.withValues(alpha: 0.45),
          blurRadius: 28.0,
          spreadRadius: 4.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'large (blur 28)',
      style: TextStyle(fontSize: 12.0, color: deepInk),
    ),
  );

  final Widget shadowMulti = Container(
    width: 140.0,
    height: 90.0,
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: cyanAccent.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(-6.0, -2.0),
        ),
        BoxShadow(
          color: purpleAccent.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(6.0, 4.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      'multi-shadow',
      style: TextStyle(fontSize: 12.0, color: deepInk),
    ),
  );

  final Widget shadowGallery = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: softCardAlt,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [shadowSmall, shadowMedium, shadowLarge, shadowMulti],
    ),
  );
  print('Built shadow gallery');

  // ============================================================
  // SECTION 7: Padding vs margin difference
  // ============================================================
  print('=== Section 7: Padding vs margin ===');

  final Widget paddingDemo = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: skyAccent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: skyAccent, width: 1.5),
    ),
    padding: EdgeInsets.all(24.0),
    child: Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Text(
        'padding=24 around child',
        style: TextStyle(fontSize: 12.0, color: deepInk),
      ),
    ),
  );

  final Widget marginDemo = Container(
    margin: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: purpleAccent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: purpleAccent, width: 1.5),
    ),
    padding: EdgeInsets.all(8.0),
    child: Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Text(
        'margin=24 around box',
        style: TextStyle(fontSize: 12.0, color: deepInk),
      ),
    ),
  );

  final Widget combinedDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigo.withValues(alpha: 0.15), Colors.white],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: indigo, width: 1.0),
    ),
    child: Text(
      'margin (outside)  decoration  padding (inside)',
      style: TextStyle(
        fontSize: 12.0,
        color: deepInk,
        fontFamily: 'monospace',
      ),
    ),
  );

  final Widget paddingMarginSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCard,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'padding lives INSIDE decoration',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: deepBlue,
          ),
        ),
        paddingDemo,
        SizedBox(height: 12.0),
        Text(
          'margin lives OUTSIDE decoration',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: purpleAccent,
          ),
        ),
        marginDemo,
        SizedBox(height: 12.0),
        Text(
          'in practice you usually combine both',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: indigo,
          ),
        ),
        combinedDemo,
      ],
    ),
  );
  print('Built padding/margin section');

  // ============================================================
  // SECTION 8: Alignment matrix - 3x3 grid
  // ============================================================
  print('=== Section 8: Alignment matrix ===');

  final List<Map<String, dynamic>> alignmentRows = [
    {
      'label': 'top',
      'cells': [
        {'a': Alignment.topLeft, 'name': 'topLeft'},
        {'a': Alignment.topCenter, 'name': 'topCenter'},
        {'a': Alignment.topRight, 'name': 'topRight'},
      ],
    },
    {
      'label': 'center',
      'cells': [
        {'a': Alignment.centerLeft, 'name': 'centerLeft'},
        {'a': Alignment.center, 'name': 'center'},
        {'a': Alignment.centerRight, 'name': 'centerRight'},
      ],
    },
    {
      'label': 'bottom',
      'cells': [
        {'a': Alignment.bottomLeft, 'name': 'bottomLeft'},
        {'a': Alignment.bottomCenter, 'name': 'bottomCenter'},
        {'a': Alignment.bottomRight, 'name': 'bottomRight'},
      ],
    },
  ];

  final List<Widget> alignmentRowWidgets = alignmentRows.map((row) {
    final List<dynamic> cells = row['cells'] as List<dynamic>;
    final List<Widget> rowCells = cells.map((c) {
      final Map<String, dynamic> cell = c as Map<String, dynamic>;
      final Alignment a = cell['a'] as Alignment;
      final String name = cell['name'] as String;
      print('Alignment cell -> $name');
      return Container(
        width: 90.0,
        height: 70.0,
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: indigo.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: indigo, width: 1.0),
        ),
        alignment: a,
        child: Container(
          width: 22.0,
          height: 22.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cyanAccent,
            boxShadow: [
              BoxShadow(
                color: cyanAccent.withValues(alpha: 0.6),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
      );
    }).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowCells,
    );
  }).toList();

  final Widget alignmentMatrix = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCardAlt,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          '3x3 child alignment matrix (cyan dot = child)',
          style: TextStyle(
            fontSize: 12.0,
            color: deepBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.0),
        ...alignmentRowWidgets,
      ],
    ),
  );
  print('Built alignment matrix with ${alignmentRowWidgets.length} rows');

  // ============================================================
  // SECTION 9: Transform demo - rotation, scale, skew
  // ============================================================
  print('=== Section 9: Transform demo ===');

  Widget buildTransformTile(String label, Matrix4 matrix, Color tint) {
    return Container(
      width: 110.0,
      height: 110.0,
      margin: EdgeInsets.all(14.0),
      alignment: Alignment.center,
      transform: matrix,
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tint.withValues(alpha: 0.25), tint],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: tint.withValues(alpha: 0.4),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }

  final Widget transformIdentity = buildTransformTile(
    'identity',
    Matrix4.identity(),
    deepBlue,
  );

  final Widget transformRotate = buildTransformTile(
    'rotateZ\n+0.25 rad',
    Matrix4.rotationZ(0.25),
    indigo,
  );

  final Widget transformScale = buildTransformTile(
    'scale\n0.85',
    Matrix4.diagonal3Values(0.85, 0.85, 1.0),
    skyAccent,
  );

  final Matrix4 skewMatrix = Matrix4.identity();
  skewMatrix.setEntry(1, 0, 0.25);
  final Widget transformSkew = buildTransformTile(
    'skew Y\n0.25',
    skewMatrix,
    purpleAccent,
  );

  final Widget transformCombo = buildTransformTile(
    'rotate +\nscale 1.1',
    Matrix4.rotationZ(-0.2)..scale(1.1, 1.1, 1.0),
    magentaAccent,
  );

  final Widget transformSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: softCard,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        transformIdentity,
        transformRotate,
        transformScale,
        transformSkew,
        transformCombo,
      ],
    ),
  );
  print('Built transform section');

  // ============================================================
  // SECTION 10: ForegroundDecoration - badge overlay
  // ============================================================
  print('=== Section 10: ForegroundDecoration ===');

  final Widget foregroundCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deepBlue, indigo, royalBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: deepBlue.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    foregroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.18),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.25),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.workspace_premium, color: cyanAccent, size: 38.0),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'foregroundDecoration paints OVER the child',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Useful for tints, gloss overlays, watermarks, focus rings.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // A second example: badge ribbon corner via a stacked Container with
  // foregroundDecoration tinting the underlying content.
  final Widget badgeOverlay = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    height: 110.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    foregroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: LinearGradient(
        colors: [
          purpleAccent.withValues(alpha: 0.0),
          purpleAccent.withValues(alpha: 0.0),
          purpleAccent.withValues(alpha: 0.25),
        ],
        stops: [0.0, 0.7, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      'content with corner-tint foregroundDecoration',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 13.0, color: deepInk),
    ),
  );
  print('Built foregroundDecoration cards');

  // ============================================================
  // SECTION 11: Footguns / common mistakes
  // ============================================================
  print('=== Section 11: Footguns ===');

  Widget buildFootgun(String title, String body, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.18),
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
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade800,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget footgunSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildFootgun(
        'color + decoration is illegal',
        'Use BoxDecoration(color:) when decoration is set; passing both throws AssertionError at runtime.',
        Icons.warning_amber_rounded,
        Colors.red.shade700,
      ),
      buildFootgun(
        'Container with no constraints',
        'Inside a Column or unbounded parent, an unsized Container shrinks to its child. Add width/height or wrap with Expanded.',
        Icons.swap_horiz,
        Colors.orange.shade700,
      ),
      buildFootgun(
        'BorderRadius needs a shape',
        'BorderRadius is ignored when shape: BoxShape.circle. Use BoxShape.rectangle (the default) with a radius.',
        Icons.crop_din,
        Colors.deepOrange,
      ),
      buildFootgun(
        'Margin is not part of the decoration',
        'Borders + shadows wrap the box, not the margin. Use padding to push content inwards.',
        Icons.format_indent_increase,
        Colors.brown,
      ),
      buildFootgun(
        'transform without transformAlignment',
        'By default Matrix4 rotates around the top-left. Set transformAlignment: Alignment.center to spin in place.',
        Icons.rotate_right,
        Colors.teal.shade700,
      ),
    ],
  );
  print('Built footgun section');

  // ============================================================
  // SECTION 12: Recap card
  // ============================================================
  print('=== Section 12: Recap card ===');

  final List<Map<String, dynamic>> recapEntries = [
    {'icon': Icons.straighten, 'text': 'sizing: width, height, constraints'},
    {'icon': Icons.brush, 'text': 'decoration: color, gradient, border, shadow'},
    {'icon': Icons.layers, 'text': 'foregroundDecoration paints over child'},
    {'icon': Icons.padding, 'text': 'padding inside, margin outside'},
    {'icon': Icons.center_focus_strong, 'text': 'alignment positions the child'},
    {'icon': Icons.transform, 'text': 'transform + transformAlignment'},
    {'icon': Icons.cut, 'text': 'clipBehavior controls overflow clipping'},
  ];

  final List<Widget> recapRows = recapEntries.map((entry) {
    final IconData icon = entry['icon'] as IconData;
    final String text = entry['text'] as String;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: cyanAccent, size: 18.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final Widget recapCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deepInk, deepBlue, royalBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: deepInk.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    foregroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: cyanAccent.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.fact_check, color: cyanAccent, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...recapRows,
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: cyanAccent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: cyanAccent.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'Container is rarely the cheapest widget, but it composes the\n'
            'six most common layout primitives into one ergonomic API.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built recap card');

  // ============================================================
  // Section header pill builder (rounded gradient pill)
  // ============================================================
  Widget sectionHeader(int n, String title, IconData icon, Color accent) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepBlue, indigo, accent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.45),
            blurRadius: 12.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.22),
            ),
            child: Text(
              '$n',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Icon(icon, color: Colors.white, size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('Container Deep Demo build complete - assembling Scaffold');

  // ============================================================
  // Final assembly: Scaffold > SingleChildScrollView > Column
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF1F3F8),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          sectionHeader(2, 'Anatomy: margin > decoration > padding > child',
              Icons.layers, skyAccent),
          anatomyDiagram,
          sectionHeader(3, 'Sizing variants', Icons.straighten, cyanAccent),
          sizingSection,
          sectionHeader(
              4, 'Decoration gallery', Icons.brush, purpleAccent),
          decorationGallery,
          sectionHeader(5, 'Border showcase', Icons.border_all, indigo),
          borderShowcase,
          sectionHeader(6, 'Shadow gallery', Icons.cloud_queue, magentaAccent),
          shadowGallery,
          sectionHeader(7, 'Padding vs margin', Icons.padding, skyAccent),
          paddingMarginSection,
          sectionHeader(
              8, 'Alignment matrix', Icons.center_focus_strong, indigo),
          alignmentMatrix,
          sectionHeader(9, 'Transform demo', Icons.transform, purpleAccent),
          transformSection,
          sectionHeader(
              10, 'foregroundDecoration', Icons.layers_outlined, cyanAccent),
          foregroundCard,
          badgeOverlay,
          sectionHeader(11, 'Footguns and gotchas',
              Icons.warning_amber_rounded, magentaAccent),
          footgunSection,
          sectionHeader(12, 'Recap', Icons.fact_check, skyAccent),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}
