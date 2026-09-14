// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OutlinedBorder abstract class from painting library
// Deep Demo: Visual demonstration of OutlinedBorder subclasses, BorderSide
// configuration, copyWith, Material integration, and real-world patterns
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OutlinedBorder Deep Demo executing');

  // Palette
  const Color tealCore = Color(0xFF00897B);
  const Color tealDark = Color(0xFF004D40);
  const Color tealLight = Color(0xFF80CBC4);
  const Color amberCore = Color(0xFFFFB300);
  const Color amberDark = Color(0xFFFF6F00);
  const Color amberLight = Color(0xFFFFE082);
  const Color indigoCore = Color(0xFF3949AB);
  const Color indigoDark = Color(0xFF1A237E);
  const Color indigoLight = Color(0xFF9FA8DA);

  // Standard side used across the gallery
  const BorderSide standardSide = BorderSide(color: tealCore, width: 2.0);

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDark, indigoCore, amberDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: indigoDark.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: tealCore.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 20.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square, size: 56.0, color: Colors.white),
            SizedBox(width: 12.0),
            Icon(Icons.circle_outlined, size: 56.0, color: amberLight),
            SizedBox(width: 12.0),
            Icon(Icons.star_border, size: 56.0, color: tealLight),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'OutlinedBorder',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'abstract class extends ShapeBorder',
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'monospace',
            color: amberLight,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Base class for shape borders that have an explicit outline.\n'
          'Subclasses: RoundedRectangleBorder, BeveledRectangleBorder,\n'
          'ContinuousRectangleBorder, RoundedSuperellipseBorder,\n'
          'StadiumBorder, CircleBorder, LinearBorder, StarBorder.',
          style: TextStyle(fontSize: 13.0, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _chip('package:flutter/painting.dart', tealLight),
            _chip('side: BorderSide', amberLight),
            _chip('copyWith(side:)', indigoLight),
            _chip('Material 3 shapes', tealLight),
          ],
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram of BorderSide
  // ============================================================
  print('=== Section 2: BorderSide anatomy ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, tealLight.withValues(alpha: 0.25)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealCore, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: tealCore.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: tealDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'BorderSide anatomy on an OutlinedBorder',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: tealDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The labelled shape
            Container(
              width: 220.0,
              height: 180.0,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: indigoCore,
                    width: 6.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadows: [
                  BoxShadow(
                    color: indigoDark.withValues(alpha: 0.25),
                    blurRadius: 14.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'shape',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: indigoDark,
                ),
              ),
            ),
            SizedBox(width: 24.0),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _anatomyLabel('color', 'BorderSide.color', indigoCore),
                  _anatomyLabel(
                    'width',
                    '6.0 logical px',
                    amberDark,
                  ),
                  _anatomyLabel(
                    'style',
                    'BorderStyle.solid',
                    tealCore,
                  ),
                  _anatomyLabel(
                    'strokeAlign',
                    'inside / center / outside',
                    indigoDark,
                  ),
                  _anatomyLabel(
                    'side',
                    'final BorderSide on every subclass',
                    tealDark,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: indigoDark,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'RoundedRectangleBorder(\n'
            '  side: BorderSide(color: indigo, width: 6, style: solid),\n'
            '  borderRadius: BorderRadius.circular(20),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: amberLight,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created BorderSide anatomy diagram');

  // ============================================================
  // SECTION 3: Concrete shape gallery (9 cards)
  // ============================================================
  print('=== Section 3: Shape gallery ===');

  final List<_ShapeEntry> galleryEntries = <_ShapeEntry>[
    _ShapeEntry(
      label: 'RoundedRectangleBorder',
      shape: RoundedRectangleBorder(
        side: standardSide,
        borderRadius: BorderRadius.circular(14.0),
      ),
      formula: 'borderRadius: 14',
    ),
    _ShapeEntry(
      label: 'BeveledRectangleBorder',
      shape: BeveledRectangleBorder(
        side: standardSide,
        borderRadius: BorderRadius.circular(14.0),
      ),
      formula: 'beveled corners',
    ),
    _ShapeEntry(
      label: 'ContinuousRectangleBorder',
      shape: ContinuousRectangleBorder(
        side: standardSide,
        borderRadius: BorderRadius.circular(20.0),
      ),
      formula: 'squircle corners',
    ),
    _ShapeEntry(
      label: 'RoundedSuperellipseBorder',
      shape: RoundedSuperellipseBorder(
        side: standardSide,
        borderRadius: BorderRadius.circular(22.0),
      ),
      formula: 'iOS-style squircle',
    ),
    _ShapeEntry(
      label: 'StadiumBorder',
      shape: StadiumBorder(side: standardSide),
      formula: 'pill ends',
    ),
    _ShapeEntry(
      label: 'CircleBorder',
      shape: CircleBorder(side: standardSide),
      formula: 'circle / oval',
    ),
    _ShapeEntry(
      label: 'LinearBorder.bottom',
      shape: LinearBorder.bottom(side: standardSide),
      formula: 'single edge',
    ),
    _ShapeEntry(
      label: 'StarBorder()',
      shape: StarBorder(side: standardSide),
      formula: '5-point star',
    ),
    _ShapeEntry(
      label: 'StarBorder.polygon',
      shape: StarBorder.polygon(side: standardSide, sides: 6.0),
      formula: 'sides: 6',
    ),
  ];
  print('Built ${galleryEntries.length} gallery entries');

  final List<Widget> galleryCards = <Widget>[];
  for (final _ShapeEntry e in galleryEntries) {
    galleryCards.add(_galleryCard(e, tealCore, tealDark, tealLight));
  }

  final shapeGallery = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealLight.withValues(alpha: 0.18), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealLight, width: 1.5),
    ),
    child: Wrap(
      alignment: WrapAlignment.start,
      children: galleryCards,
    ),
  );
  print('Created shape gallery wrap');

  // ============================================================
  // SECTION 4: BorderSide width sweep
  // ============================================================
  print('=== Section 4: width sweep ===');

  final List<double> widths = <double>[0.5, 1.0, 2.0, 4.0, 8.0, 16.0];
  final List<Widget> widthCards = <Widget>[];
  for (final double w in widths) {
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      side: BorderSide(color: amberDark, width: w),
      borderRadius: BorderRadius.circular(12.0),
    );
    widthCards.add(_widthCard(w, shape, amberCore, amberDark, amberLight));
  }

  final widthSweep = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amberLight.withValues(alpha: 0.25), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberCore, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberCore.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Wrap(children: widthCards),
  );
  print('Created width sweep with ${widthCards.length} cards');

  // ============================================================
  // SECTION 5: BorderSide.style — solid vs none
  // ============================================================
  print('=== Section 5: style (solid vs none) ===');

  final RoundedRectangleBorder solidShape = RoundedRectangleBorder(
    side: BorderSide(color: indigoCore, width: 4.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(14.0),
  );
  final RoundedRectangleBorder noneShape = RoundedRectangleBorder(
    side: BorderSide(color: indigoCore, width: 4.0, style: BorderStyle.none),
    borderRadius: BorderRadius.circular(14.0),
  );

  final styleCards = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _styleCard(
        'BorderStyle.solid',
        'Outline drawn at width 4',
        solidShape,
        indigoCore,
        indigoDark,
        indigoLight,
      ),
      _styleCard(
        'BorderStyle.none',
        'Width is honoured for layout but nothing is drawn',
        noneShape,
        indigoLight,
        indigoDark,
        indigoLight,
      ),
    ],
  );
  print('Created style comparison');

  // ============================================================
  // SECTION 6: strokeAlign — inside / center / outside
  // ============================================================
  print('=== Section 6: strokeAlign ===');

  final RoundedRectangleBorder insideShape = RoundedRectangleBorder(
    side: BorderSide(
      color: tealCore,
      width: 8.0,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
    borderRadius: BorderRadius.circular(16.0),
  );
  final RoundedRectangleBorder centerShape = RoundedRectangleBorder(
    side: BorderSide(
      color: tealCore,
      width: 8.0,
      strokeAlign: BorderSide.strokeAlignCenter,
    ),
    borderRadius: BorderRadius.circular(16.0),
  );
  final RoundedRectangleBorder outsideShape = RoundedRectangleBorder(
    side: BorderSide(
      color: tealCore,
      width: 8.0,
      strokeAlign: BorderSide.strokeAlignOutside,
    ),
    borderRadius: BorderRadius.circular(16.0),
  );

  final strokeAlignRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _strokeAlignCard('strokeAlignInside', '-1.0', insideShape, tealCore),
      _strokeAlignCard('strokeAlignCenter', '0.0', centerShape, tealDark),
      _strokeAlignCard('strokeAlignOutside', '1.0', outsideShape, amberDark),
    ],
  );
  print('Created strokeAlign row');

  // ============================================================
  // SECTION 7: copyWith showcase
  // ============================================================
  print('=== Section 7: copyWith ===');

  final StadiumBorder original = StadiumBorder(
    side: BorderSide(color: indigoCore, width: 2.0),
  );
  final OutlinedBorder thickened = original.copyWith(
    side: BorderSide(color: amberDark, width: 6.0),
  );
  print('Original side: ${original.side}');
  print('Thickened side: ${thickened.side}');

  final copyWithRow = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigoLight.withValues(alpha: 0.3), amberLight.withValues(alpha: 0.3)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoCore, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoCore.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.content_copy, color: indigoDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'copyWith(side:) — derive a thicker variant',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: indigoDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _copyWithSample('original', original, indigoCore, indigoDark),
            Icon(Icons.arrow_forward, size: 32.0, color: indigoDark),
            _copyWithSample('thickened', thickened, amberDark, amberDark),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: indigoDark,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'final original = StadiumBorder(\n'
            '  side: BorderSide(color: indigo, width: 2),\n'
            ');\n'
            'final thickened = original.copyWith(\n'
            '  side: BorderSide(color: amber, width: 6),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: amberLight,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created copyWith showcase');

  // ============================================================
  // SECTION 8: Material integration
  // ============================================================
  print('=== Section 8: Material integration ===');

  final OutlinedBorder buttonShape = StadiumBorder(
    side: BorderSide(color: tealCore, width: 2.0),
  );
  final OutlinedBorder cardShape = RoundedRectangleBorder(
    side: BorderSide(color: indigoCore, width: 1.5),
    borderRadius: BorderRadius.circular(18.0),
  );
  final OutlinedBorder chipShape = StadiumBorder(
    side: BorderSide(color: amberDark, width: 1.5),
  );

  final materialIntegration = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, tealLight.withValues(alpha: 0.2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealLight, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.widgets, color: tealDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Material widgets that consume OutlinedBorder',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: tealDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        // OutlinedButton
        _materialRow(
          'OutlinedButton.styleFrom(shape: StadiumBorder(...))',
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: buttonShape,
              side: BorderSide(color: tealCore, width: 2.0),
              foregroundColor: tealDark,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
            child: Text('Outlined'),
          ),
          tealCore,
        ),
        SizedBox(height: 12.0),
        // Card
        _materialRow(
          'Card(shape: RoundedRectangleBorder(...))',
          SizedBox(
            width: 220.0,
            child: Card(
              shape: cardShape,
              elevation: 3.0,
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Card with custom shape',
                  style: TextStyle(color: indigoDark),
                ),
              ),
            ),
          ),
          indigoCore,
        ),
        SizedBox(height: 12.0),
        // Chip
        _materialRow(
          'Chip(shape: StadiumBorder(...))',
          Chip(
            shape: chipShape,
            avatar: Icon(Icons.label, color: amberDark, size: 18.0),
            label: Text('Chip'),
            backgroundColor: amberLight.withValues(alpha: 0.4),
            side: BorderSide(color: amberDark, width: 1.5),
          ),
          amberDark,
        ),
      ],
    ),
  );
  print('Created Material integration');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  // Pill chip
  final OutlinedBorder pillShape = StadiumBorder(
    side: BorderSide(color: tealCore, width: 1.5),
  );
  // M3 outlined button
  final OutlinedBorder m3ButtonShape = StadiumBorder(
    side: BorderSide(color: indigoCore, width: 1.0),
  );
  // Dashed approximation (solid + comments — no DashedBorder in OutlinedBorder)
  final OutlinedBorder dashedApproxShape = RoundedRectangleBorder(
    // OutlinedBorder has no native dashed style; we approximate with solid +
    // a low-opacity colour to suggest a dashed look. True dashes need a
    // CustomPainter or a third-party DottedBorder package.
    side: BorderSide(
      color: amberDark.withValues(alpha: 0.6),
      width: 2.0,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(12.0),
  );
  // Avatar ring
  final OutlinedBorder avatarShape = CircleBorder(
    side: BorderSide(color: amberDark, width: 3.0),
  );
  // Badge
  final OutlinedBorder badgeShape = StadiumBorder(
    side: BorderSide(color: indigoDark, width: 1.0),
  );

  final realWorldMocks = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          indigoLight.withValues(alpha: 0.18),
          tealLight.withValues(alpha: 0.18),
          amberLight.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoCore, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: indigoCore.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: indigoDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Real-world mocks built from OutlinedBorder',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: indigoDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            // Pill chip
            _mockTile(
              'Pill chip',
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                decoration: ShapeDecoration(
                  color: tealLight.withValues(alpha: 0.3),
                  shape: pillShape,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 16.0, color: tealDark),
                    SizedBox(width: 6.0),
                    Text(
                      'Active',
                      style: TextStyle(color: tealDark, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              tealCore,
            ),
            // M3 outlined button
            _mockTile(
              'M3 OutlinedButton',
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: m3ButtonShape,
                  side: BorderSide(color: indigoCore, width: 1.0),
                  foregroundColor: indigoDark,
                ),
                icon: Icon(Icons.download, size: 16.0),
                label: Text('Download'),
              ),
              indigoCore,
            ),
            // Dashed approximation
            _mockTile(
              'Dashed approximation',
              Container(
                width: 130.0,
                height: 60.0,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: dashedApproxShape,
                ),
                alignment: Alignment.center,
                child: Text(
                  'drop zone',
                  style: TextStyle(color: amberDark, fontSize: 12.0),
                ),
              ),
              amberDark,
            ),
            // Avatar ring
            _mockTile(
              'Avatar ring',
              Container(
                width: 70.0,
                height: 70.0,
                decoration: ShapeDecoration(
                  shape: avatarShape,
                  gradient: LinearGradient(
                    colors: [amberCore, amberDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'AB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              amberCore,
            ),
            // Badge
            _mockTile(
              'Badge',
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: ShapeDecoration(
                  color: indigoDark,
                  shape: badgeShape,
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    color: amberLight,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              indigoDark,
            ),
          ],
        ),
      ],
    ),
  );
  print('Created real-world mocks');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final List<_FootgunEntry> footguns = <_FootgunEntry>[
    _FootgunEntry(
      title: 'BorderStyle.none renders nothing',
      detail:
          'Even at width: 16, BorderSide(style: BorderStyle.none) draws no '
          'pixels. The width still affects layout in some shapes.',
      icon: Icons.visibility_off,
    ),
    _FootgunEntry(
      title: 'strokeAlign affects layout',
      detail:
          'strokeAlignOutside grows the painted bounds beyond the shape; '
          'strokeAlignInside keeps painting inside. This can change hit-test '
          'and clipping behaviour in some shapes.',
      icon: Icons.linear_scale,
    ),
    _FootgunEntry(
      title: 'lerp between dissimilar shapes',
      detail:
          'ShapeBorder.lerp between e.g. CircleBorder and StarBorder cannot '
          'always interpolate cleanly; it falls back to a snap-style result '
          'or a generic _MixedBorder.',
      icon: Icons.swap_horiz,
    ),
    _FootgunEntry(
      title: 'All subclasses are const-constructible',
      detail:
          'Use const StadiumBorder() / const CircleBorder() in widget trees '
          'to avoid rebuilding the shape on every frame.',
      icon: Icons.bolt,
    ),
    _FootgunEntry(
      title: 'CircleBorder ignores eccentric radii',
      detail:
          'CircleBorder always paints a circle (or oval via eccentricity); '
          'it does not accept BorderRadius. Use RoundedRectangleBorder for '
          'rounded rectangles.',
      icon: Icons.circle_outlined,
    ),
  ];

  final List<Widget> footgunCards = <Widget>[];
  for (final _FootgunEntry f in footguns) {
    footgunCards.add(_footgunCard(f, amberDark, amberLight));
  }

  final footgunSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amberLight.withValues(alpha: 0.4), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberDark, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberDark.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: amberDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns and edge cases',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: amberDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...footgunCards,
      ],
    ),
  );
  print('Created footgun section with ${footgunCards.length} entries');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDark, indigoDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: tealDark.withValues(alpha: 0.5),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: amberLight, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapBullet(
          'OutlinedBorder is an abstract ShapeBorder with a single field:',
          'final BorderSide side',
          amberLight,
        ),
        _recapBullet(
          'Concrete subclasses cover rectangles, pills, circles, lines and stars:',
          'RoundedRectangleBorder, BeveledRectangleBorder, '
              'ContinuousRectangleBorder, RoundedSuperellipseBorder, '
              'StadiumBorder, CircleBorder, LinearBorder, StarBorder.',
          amberLight,
        ),
        _recapBullet(
          'BorderSide carries:',
          'color, width, style, strokeAlign',
          amberLight,
        ),
        _recapBullet(
          'copyWith(side:) returns a new OutlinedBorder of the same subclass:',
          'StadiumBorder(...).copyWith(side: ...) -> StadiumBorder',
          amberLight,
        ),
        _recapBullet(
          'Consumed by Material widgets:',
          'OutlinedButton.shape, Card.shape, Chip.shape, ShapeDecoration.shape',
          amberLight,
        ),
        _recapBullet(
          'Prefer const instances and watch out for BorderStyle.none + strokeAlign.',
          'const StadiumBorder()',
          amberLight,
        ),
      ],
    ),
  );
  print('Created recap card');

  print('OutlinedBorder Deep Demo completed successfully');

  // ============================================================
  // Compose final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF5F7FA),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. BorderSide anatomy', tealDark),
          anatomyDiagram,
          SizedBox(height: 28.0),
          _sectionHeader('2. Concrete OutlinedBorder gallery', tealDark),
          shapeGallery,
          SizedBox(height: 28.0),
          _sectionHeader('3. BorderSide width sweep', amberDark),
          widthSweep,
          SizedBox(height: 28.0),
          _sectionHeader('4. BorderSide.style', indigoDark),
          styleCards,
          SizedBox(height: 28.0),
          _sectionHeader('5. strokeAlign', tealDark),
          strokeAlignRow,
          SizedBox(height: 28.0),
          _sectionHeader('6. copyWith showcase', indigoDark),
          copyWithRow,
          SizedBox(height: 28.0),
          _sectionHeader('7. Material integration', tealDark),
          materialIntegration,
          SizedBox(height: 28.0),
          _sectionHeader('8. Real-world mocks', indigoDark),
          realWorldMocks,
          SizedBox(height: 28.0),
          _sectionHeader('9. Footguns', amberDark),
          footgunSection,
          SizedBox(height: 28.0),
          _sectionHeader('10. Recap', tealDark),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Top-level helper widgets / data carriers
// ============================================================

class _ShapeEntry {
  _ShapeEntry({
    required this.label,
    required this.shape,
    required this.formula,
  });
  final String label;
  final OutlinedBorder shape;
  final String formula;
}

class _FootgunEntry {
  _FootgunEntry({
    required this.title,
    required this.detail,
    required this.icon,
  });
  final String title;
  final String detail;
  final IconData icon;
}

Widget _chip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
      ),
    ),
  );
}

Widget _sectionHeader(String label, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0, left: 4.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyLabel(String name, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          margin: EdgeInsets.only(top: 4.0, right: 8.0),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$name  ',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
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

Widget _galleryCard(
  _ShapeEntry e,
  Color accent,
  Color accentDark,
  Color accentLight,
) {
  return Container(
    width: 170.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accentLight, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110.0,
          height: 80.0,
          decoration: ShapeDecoration(
            color: accentLight.withValues(alpha: 0.25),
            shape: e.shape,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          e.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: accentDark,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          e.formula,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _widthCard(
  double width,
  RoundedRectangleBorder shape,
  Color accent,
  Color accentDark,
  Color accentLight,
) {
  return Container(
    width: 130.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accentLight, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 90.0,
          height: 60.0,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shape,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'width: $width',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: accentDark,
          ),
        ),
      ],
    ),
  );
}

Widget _styleCard(
  String title,
  String detail,
  RoundedRectangleBorder shape,
  Color accent,
  Color accentDark,
  Color accentLight,
) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accentLight, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 160.0,
          height: 80.0,
          decoration: ShapeDecoration(
            color: accentLight.withValues(alpha: 0.3),
            shape: shape,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: accentDark,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _strokeAlignCard(
  String label,
  String numeric,
  RoundedRectangleBorder shape,
  Color accent,
) {
  return Container(
    width: 150.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 100.0,
          height: 70.0,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: shape,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'value: $numeric',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: accent,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _copyWithSample(
  String label,
  OutlinedBorder shape,
  Color accent,
  Color accentDark,
) {
  return Column(
    children: [
      Container(
        width: 160.0,
        height: 60.0,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: shape,
          shadows: [
            BoxShadow(
              color: accent.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: accentDark,
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        '${shape.runtimeType}',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: accentDark,
        ),
      ),
    ],
  );
}

Widget _materialRow(String code, Widget sample, Color accent) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: accent,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(flex: 2, child: Center(child: sample)),
      ],
    ),
  );
}

Widget _mockTile(String label, Widget child, Color accent) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        SizedBox(
          width: 140.0,
          height: 80.0,
          child: Center(child: child),
        ),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
      ],
    ),
  );
}

Widget _footgunCard(_FootgunEntry f, Color accent, Color accentLight) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accentLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(f.icon, color: accent, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                f.title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                f.detail,
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

Widget _recapBullet(String headline, String code, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: accent, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: accent,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
