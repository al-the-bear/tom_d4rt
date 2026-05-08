// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unnecessary_this, avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                  PLASTER CARMINE  ---  Decoration (abstract)
// =============================================================================
//
//  TARGET WIDGET .... Decoration  (package:flutter/painting.dart)
//
//                     Decoration is the ABSTRACT base class that sits at the
//                     top of Flutter's painting-recipe taxonomy.  Concrete
//                     subclasses are:
//
//                        - BoxDecoration            (rectangle / circle box)
//                        - ShapeDecoration          (any OutlinedBorder shape)
//                        - FlutterLogoDecoration    (the Flutter logo)
//                        - UnderlineTabIndicator    (tab-bar underline)
//
//                     The abstract API itself is small but every concrete
//                     subclass must answer the same five questions:
//
//                        - what is your `padding`?
//                        - is your painting `isComplex`?
//                        - how do you `lerp` to / from another Decoration?
//                        - how do you `hitTest` a point?
//                        - what `Path` do you give back from `getClipPath`?
//                        - what `BoxPainter` do you produce in
//                          `createBoxPainter`?
//
//                     This demo walks through each of those questions, and
//                     uses the answers to produce a fresco-painter's
//                     workshop --- a wall of plaster studies, pigment
//                     swatches, transfers and shadow studies.
//
//  THEME ............ PLASTER CARMINE
//
//                     We are stepping into a 16th-century Florentine fresco
//                     studio, the morning the master is preparing pigments.
//                     The light is warm; the walls are washed with plaster
//                     cream; the assistants are grinding terracotta and
//                     carmine reds; charcoal lineart marks out the shapes
//                     of next week's wall.  Every section of this file is
//                     a station in that workshop.
//
//                     Palette:
//                       cinnabar      #8E2030   carmine red
//                       terracotta    #C0463C   warm earthen red
//                       ochre         #E58B6E   toasted ochre
//                       plaster       #F2E4CC   plaster cream wall
//                       charcoal      #332620   charred lineart
//
//  SHAPE OF THIS FILE
//
//      Section  1 .... Title hero with abstract Decoration signature.
//      Section  2 .... Subtype taxonomy diagram (CustomPainter).
//      Section  3 .... BoxDecoration anatomy --- exploded view.
//      Section  4 .... Twelve fresco swatches (progressive ornament).
//      Section  5 .... Lerp gallery --- BoxDecoration.lerp(a,b,t) at five t.
//      Section  6 .... ShapeDecoration showcase --- six OutlinedBorders.
//      Section  7 .... Border / BorderRadius matrix --- 4x4 grid.
//      Section  8 .... Gradient anatomy --- linear, radial, sweep.
//      Section  9 .... Shadow anatomy --- six BoxShadow studies.
//      Section 10 .... Hit-testing demo --- circle vs grid.
//      Section 11 .... Subtype property table --- padding/isComplex/etc.
//      Section 12 .... Recipe card grid --- six named recipes.
//      Section 13 .... Closing fresco essay --- 200-word prose.
//
//  D4RT CONSTRAINTS
//
//      * build() is called exactly ONCE; we return a snapshot.
//      * No StatefulWidget, no setState, no controllers, no timers, no
//        futures, no streams.
//      * No `for-in` over BridgedInstance --- indexed loops only.
//      * No collection-for ([for (X in Y) ...]).
//      * No `.value` on Tween.animate; we don't animate.
//      * Use `.withValues(alpha:...)`, never `.withOpacity(...)`.
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Plaster Carmine
// ---------------------------------------------------------------------------

const Color cCinnabar = Color(0xFF8E2030); // carmine red, the master's pigment
const Color cTerracotta = Color(0xFFC0463C); // warm terracotta brick
const Color cOchre = Color(0xFFE58B6E); // toasted ochre
const Color cPlaster = Color(0xFFF2E4CC); // plaster cream wall
const Color cCharcoal = Color(0xFF332620); // charred lineart
const Color cBone = Color(0xFFEFE7D2); // bleached bone tone
const Color cClay = Color(0xFFB37760); // raw clay
const Color cVerdigris = Color(0xFF6E8B6F); // copper green workshop bowl
const Color cIndigoWash = Color(0xFF3B4B6B); // dilute indigo cartoon
const Color cEgg = Color(0xFFE9C77F); // egg-yolk binder
const Color cRust = Color(0xFF8C4530); // dried rust pigment
const Color cAsh = Color(0xFF6B5E50); // ash from the brazier
const Color cSinopia = Color(0xFF9B3C2A); // sinopia underdrawing
const Color cVerona = Color(0xFF74553A); // verona green-earth
const Color cLime = Color(0xFFE6D9B8); // lime mortar
const Color cSmoke = Color(0xFF584C40); // smoked walnut frame

// A list of palette swatches we render in the title banner.
const List<Map<String, Object>> kPalette = <Map<String, Object>>[
  {'name': 'cinnabar', 'color': cCinnabar},
  {'name': 'terracotta', 'color': cTerracotta},
  {'name': 'ochre', 'color': cOchre},
  {'name': 'plaster', 'color': cPlaster},
  {'name': 'charcoal', 'color': cCharcoal},
  {'name': 'bone', 'color': cBone},
  {'name': 'clay', 'color': cClay},
  {'name': 'verdigris', 'color': cVerdigris},
  {'name': 'indigoWash', 'color': cIndigoWash},
  {'name': 'egg', 'color': cEgg},
  {'name': 'rust', 'color': cRust},
  {'name': 'ash', 'color': cAsh},
  {'name': 'sinopia', 'color': cSinopia},
  {'name': 'verona', 'color': cVerona},
  {'name': 'lime', 'color': cLime},
  {'name': 'smoke', 'color': cSmoke},
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cPlaster,
  letterSpacing: 1.6,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: cPlaster,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cCharcoal,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.4,
  color: cCharcoal,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cCharcoal,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11,
  color: cAsh,
  fontWeight: FontWeight.w600,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cPlaster,
);

const TextStyle kHeroSignatureStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cEgg,
  height: 1.45,
);

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Plaster Carmine --- Decoration deep demo');
  print('===============================================================');
  print(' Building ONE snapshot widget tree.');
  print(' We will construct >= 30 real Decoration instances:');
  print('   - BoxDecoration');
  print('   - ShapeDecoration');
  print('   - FlutterLogoDecoration');
  print('   - UnderlineTabIndicator');
  print(' and exercise the abstract Decoration API:');
  print('   - .padding');
  print('   - .isComplex');
  print('   - .lerp / .lerpFrom / .lerpTo');
  print('   - .hitTest');
  print('   - .createBoxPainter');
  print('   - .getClipPath');

  // Demonstrate the abstract API on a fresh BoxDecoration up front so the
  // returned widget tree (which itself builds many decorations) is paired
  // with hard evidence in stdout that we touched every abstract method.
  final BoxDecoration apiDemo = BoxDecoration(
    color: cCinnabar,
    border: Border.all(color: cCharcoal, width: 2),
    borderRadius: BorderRadius.circular(12),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.4),
        blurRadius: 6,
        offset: const Offset(0, 4),
      ),
    ],
    gradient: LinearGradient(
      colors: <Color>[cCinnabar, cTerracotta, cOchre],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  print(' apiDemo.padding         = ${apiDemo.padding}');
  print(' apiDemo.isComplex       = ${apiDemo.isComplex}');
  final Path clipPath = apiDemo.getClipPath(
    const Rect.fromLTWH(0, 0, 100, 60),
    TextDirection.ltr,
  );
  print(' apiDemo.getClipPath ->  ${clipPath.runtimeType}');

  final BoxDecoration apiDemoB = BoxDecoration(
    color: cVerdigris,
    borderRadius: BorderRadius.circular(40),
  );
  final Decoration? mid = Decoration.lerp(apiDemo, apiDemoB, 0.5);
  print(' Decoration.lerp(apiDemo, apiDemoB, 0.5) -> ${mid.runtimeType}');

  // hitTest needs a Size and a position.
  final bool hit = apiDemo.hitTest(
    const Size(100, 60),
    const Offset(50, 30),
    textDirection: TextDirection.ltr,
  );
  print(' apiDemo.hitTest((100,60), (50,30)) = $hit');

  // createBoxPainter returns a BoxPainter we never use here; we just verify
  // we can ask for one.
  final BoxPainter painter = apiDemo.createBoxPainter(() {});
  print(' apiDemo.createBoxPainter -> ${painter.runtimeType}');

  // Now build the actual demo tree.
  final List<Widget> sections = <Widget>[
    _buildTitleHero(),
    _spacer(20),
    _buildSubtypeTaxonomy(),
    _spacer(20),
    _buildBoxDecorationAnatomy(),
    _spacer(20),
    _buildSectionHeader('4. Twelve fresco swatches'),
    _buildTwelveSwatches(),
    _spacer(20),
    _buildSectionHeader('5. Lerp gallery --- BoxDecoration.lerp(a,b,t)'),
    _buildLerpGallery(),
    _spacer(20),
    _buildSectionHeader('6. ShapeDecoration showcase --- six OutlinedBorders'),
    _buildShapeDecorationShowcase(),
    _spacer(20),
    _buildSectionHeader('7. Border / BorderRadius matrix --- 4x4'),
    _buildBorderRadiusMatrix(),
    _spacer(20),
    _buildSectionHeader('8. Gradient anatomy --- linear, radial, sweep'),
    _buildGradientAnatomy(),
    _spacer(20),
    _buildSectionHeader('9. Shadow anatomy --- six BoxShadow studies'),
    _buildShadowAnatomy(),
    _spacer(20),
    _buildSectionHeader('10. Hit-testing demo --- circle vs grid'),
    _buildHitTestingDemo(),
    _spacer(20),
    _buildSectionHeader('11. Subtype property table'),
    _buildSubtypeTable(),
    _spacer(20),
    _buildSectionHeader('12. Recipe card grid --- six named recipes'),
    _buildRecipeCards(),
    _spacer(20),
    _buildClosingEssay(),
    _spacer(40),
  ];

  print(' Assembled ${sections.length} top-level section blocks.');

  return Scaffold(
    backgroundColor: cPlaster,
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  Tiny helpers
// ---------------------------------------------------------------------------

Widget _spacer(double h) => SizedBox(height: h);

Widget _buildSectionHeader(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cBone,
        border: Border(
          left: BorderSide(color: cCinnabar, width: 6),
          bottom: BorderSide(color: cCharcoal, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

// ===========================================================================
//  SECTION 1  ---  Title hero with abstract Decoration signature
// ===========================================================================
//
//  The title is a banner Container with a real BoxDecoration that uses every
//  major BoxDecoration field except `image`.  We also drop the abstract
//  Decoration class signature in monospace so the user can SEE what they
//  are about to study.
//
// ---------------------------------------------------------------------------

Widget _buildTitleHero() {
  print(' Building Section 1: title hero.');
  // Banner BoxDecoration #1.
  final BoxDecoration bannerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cCharcoal, cSinopia, cCinnabar],
      stops: <double>[0.0, 0.6, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: cEgg, width: 2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.55),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // A horizontal palette swatch strip.  Each swatch is its own real
  // BoxDecoration (16 swatches => 16 decorations).
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final Map<String, Object> entry = kPalette[i];
    final Color c = entry['color'] as Color;
    final String n = entry['name'] as String;
    final BoxDecoration swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cPlaster.withValues(alpha: 0.7), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.35),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    );
    swatches.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: <Widget>[
            Container(width: 36, height: 36, decoration: swatchDeco),
            const SizedBox(height: 2),
            SizedBox(
              width: 60,
              child: Text(
                n,
                style: const TextStyle(fontSize: 9, color: cPlaster),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The abstract class signature card --- a separate decoration over the
  // banner gradient so the type signature feels like a chiseled inscription.
  final BoxDecoration sigDeco = BoxDecoration(
    color: cCharcoal.withValues(alpha: 0.55),
    border: Border.all(color: cEgg.withValues(alpha: 0.5), width: 1),
    borderRadius: BorderRadius.circular(8),
  );

  return Container(
    decoration: bannerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('PLASTER CARMINE', style: kTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'A deep walkthrough of Decoration, the abstract painting recipe '
          'behind every box, badge and underline in Flutter.  We treat '
          'the studio of a Florentine fresco painter as our metaphor: '
          'plaster walls, ground pigments, sinopia underdrawings.',
          style: kSubtitleStyle,
        ),
        const SizedBox(height: 14),
        Container(
          decoration: sigDeco,
          padding: const EdgeInsets.all(12),
          child: const Text(
            'abstract class Decoration with Diagnosticable {\n'
            '  const Decoration();\n'
            '\n'
            '  EdgeInsetsGeometry  get padding;\n'
            '  bool                get isComplex;\n'
            '\n'
            '  Decoration?  lerpFrom(Decoration? a, double t);\n'
            '  Decoration?  lerpTo  (Decoration? b, double t);\n'
            '  static Decoration? lerp(Decoration? a,\n'
            '                          Decoration? b,\n'
            '                          double t);\n'
            '\n'
            '  bool        hitTest(Size size, Offset position,\n'
            '                      {TextDirection? textDirection});\n'
            '  Path        getClipPath(Rect rect, TextDirection t);\n'
            '\n'
            '  BoxPainter  createBoxPainter([VoidCallback? onChanged]);\n'
            '}',
            style: kHeroSignatureStyle,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'PALETTE',
          style: TextStyle(
            color: cEgg,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: swatches),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 2  ---  Subtype taxonomy diagram
// ===========================================================================
//
//  A small CustomPainter draws the inheritance tree:
//
//                     [Decoration]   <- abstract
//                    /     |     |    \
//          [BoxDecoration] |     |  [UnderlineTabIndicator]
//                          |     [FlutterLogoDecoration]
//                          [ShapeDecoration]
//
//  We surround it with prose and use real BoxDecoration tiles for each leaf.
//
// ---------------------------------------------------------------------------

class _TaxonomyPainter extends CustomPainter {
  const _TaxonomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = cCharcoal
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Coordinates of the five node centres (parent + four children).
    final Offset parent = Offset(size.width / 2, 18);
    final List<Offset> children = <Offset>[
      Offset(size.width * 0.10, size.height - 24),
      Offset(size.width * 0.37, size.height - 24),
      Offset(size.width * 0.63, size.height - 24),
      Offset(size.width * 0.90, size.height - 24),
    ];

    // Draw lines from parent to children using an indexed loop --- never
    // for-in.
    for (int i = 0; i < children.length; i++) {
      final Offset c = children[i];
      final Path p = Path();
      p.moveTo(parent.dx, parent.dy + 4);
      p.lineTo(parent.dx, parent.dy + 22);
      p.lineTo(c.dx, parent.dy + 22);
      p.lineTo(c.dx, c.dy - 14);
      canvas.drawPath(p, linePaint);
    }

    // Parent node bubble.
    final Paint parentFill = Paint()..color = cCinnabar;
    final Paint parentStroke = Paint()
      ..color = cCharcoal
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final Rect parentRect = Rect.fromCenter(
      center: parent,
      width: 140,
      height: 28,
    );
    final RRect parentRR = RRect.fromRectAndRadius(
      parentRect,
      const Radius.circular(8),
    );
    canvas.drawRRect(parentRR, parentFill);
    canvas.drawRRect(parentRR, parentStroke);
  }

  @override
  bool shouldRepaint(covariant _TaxonomyPainter oldDelegate) => false;
}

Widget _buildSubtypeTaxonomy() {
  print(' Building Section 2: subtype taxonomy.');
  // Wrapper card BoxDecoration.
  final BoxDecoration wrapDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.2),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  // Leaf labels each backed by a small BoxDecoration tile.
  final List<Map<String, Object>> leaves = <Map<String, Object>>[
    {
      'label': 'BoxDecoration',
      'color': cTerracotta,
      'note': 'rectangle / circle box',
    },
    {
      'label': 'ShapeDecoration',
      'color': cVerdigris,
      'note': 'any OutlinedBorder',
    },
    {
      'label': 'FlutterLogoDecoration',
      'color': cIndigoWash,
      'note': 'the Flutter logo',
    },
    {
      'label': 'UnderlineTabIndicator',
      'color': cEgg,
      'note': 'tab-bar underline',
    },
  ];

  final List<Widget> leafTiles = <Widget>[];
  for (int i = 0; i < leaves.length; i++) {
    final Map<String, Object> leaf = leaves[i];
    final Color c = leaf['color'] as Color;
    final BoxDecoration leafDeco = BoxDecoration(
      color: c,
      border: Border.all(color: cCharcoal, width: 1),
      borderRadius: BorderRadius.circular(6),
    );
    leafTiles.add(
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: <Widget>[
              Container(
                height: 28,
                decoration: leafDeco,
                alignment: Alignment.center,
                child: Text(
                  leaf['label'] as String,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: cCharcoal,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                leaf['note'] as String,
                style: const TextStyle(fontSize: 9, color: cAsh),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    decoration: wrapDeco,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('2. SUBTYPE TAXONOMY', style: kSectionHeaderStyle),
        const SizedBox(height: 8),
        const Text(
          'Decoration is abstract.  Flutter ships four concrete subclasses: '
          'BoxDecoration (the workhorse), ShapeDecoration (for arbitrary '
          'OutlinedBorders), FlutterLogoDecoration (yes, just for the logo), '
          'and UnderlineTabIndicator (used by TabBar).  The diagram below '
          'shows the inheritance hierarchy.  Below the diagram is a row of '
          'leaf tiles, each painted by a real BoxDecoration carrying the '
          'pigment we associate with that subtype.',
          style: kSectionLeadStyle,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: CustomPaint(
            painter: const _TaxonomyPainter(),
            size: const Size.fromHeight(120),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: leafTiles),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 3  ---  BoxDecoration anatomy --- exploded view
// ===========================================================================
//
//  We render a sample Container in the middle, surrounded by labelled
//  callouts pointing at each of BoxDecoration's eight fields:
//
//      color, image, border, borderRadius, boxShadow,
//      gradient, backgroundBlendMode, shape
//
//  Each callout is its own real BoxDecoration tile.
//
// ---------------------------------------------------------------------------

Widget _buildBoxDecorationAnatomy() {
  print(' Building Section 3: BoxDecoration anatomy.');
  // The sample box BoxDecoration --- shows ALL eight fields except image.
  final BoxDecoration sampleDeco = BoxDecoration(
    color: cTerracotta,
    border: Border.all(color: cCharcoal, width: 2),
    borderRadius: BorderRadius.circular(14),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cCinnabar, cTerracotta, cOchre],
      stops: const <double>[0.0, 0.5, 1.0],
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.45),
        blurRadius: 10,
        offset: const Offset(0, 6),
      ),
    ],
  );

  final List<Map<String, Object>> fields = <Map<String, Object>>[
    {'name': 'color', 'pigment': cCinnabar, 'role': 'flat fill, painted first.'},
    {'name': 'image', 'pigment': cClay, 'role': 'DecorationImage over fill.'},
    {'name': 'border', 'pigment': cCharcoal, 'role': 'outline, painted last.'},
    {
      'name': 'borderRadius',
      'pigment': cIndigoWash,
      'role': 'rounds rectangles only.'
    },
    {
      'name': 'boxShadow',
      'pigment': cAsh,
      'role': 'list of shadows under box.'
    },
    {
      'name': 'gradient',
      'pigment': cOchre,
      'role': 'linear / radial / sweep.'
    },
    {
      'name': 'backgroundBlendMode',
      'pigment': cVerdigris,
      'role': 'BlendMode for fill layer.'
    },
    {
      'name': 'shape',
      'pigment': cSinopia,
      'role': 'rectangle vs circle.'
    },
  ];

  // Build the eight callout tiles.
  final List<Widget> calloutTiles = <Widget>[];
  for (int i = 0; i < fields.length; i++) {
    final Map<String, Object> f = fields[i];
    final Color pig = f['pigment'] as Color;
    final BoxDecoration dotDeco = BoxDecoration(
      color: pig,
      shape: BoxShape.circle,
      border: Border.all(color: cCharcoal, width: 1),
    );
    final BoxDecoration tileDeco = BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal.withValues(alpha: 0.3)),
    );
    calloutTiles.add(
      SizedBox(
        width: 220,
        child: Container(
          decoration: tileDeco,
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 18, height: 18, decoration: dotDeco),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      f['name'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: cCinnabar,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(f['role'] as String, style: kBodyStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Outer wrapper.
  final BoxDecoration wrapDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: wrapDeco,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('3. BoxDecoration ANATOMY', style: kSectionHeaderStyle),
        const SizedBox(height: 6),
        const Text(
          'BoxDecoration carries eight fields.  Every Container.decoration '
          'in idiomatic Flutter touches some subset of them.  The sample '
          'panel below is a single Container whose BoxDecoration uses six '
          'of those fields at once; the legend on the right enumerates the '
          'remaining two.',
          style: kSectionLeadStyle,
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Sample box.
            Container(
              width: 200,
              height: 130,
              decoration: sampleDeco,
              alignment: Alignment.center,
              child: const Text(
                'sample\nBoxDecoration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: cPlaster,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: calloutTiles,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 4  ---  Twelve fresco swatches
// ===========================================================================
//
//  Twelve hand-built containers showing progressive ornament, from a flat
//  fill to a fully decorated sample.  Each one is its own BoxDecoration.
//
// ---------------------------------------------------------------------------

Widget _buildTwelveSwatches() {
  print(' Building Section 4: twelve fresco swatches.');
  final List<Widget> tiles = <Widget>[];

  // 1. Solid color.
  tiles.add(_swatchTile(
    '01 solid color',
    BoxDecoration(color: cCinnabar),
  ));
  // 2. Color + border.
  tiles.add(_swatchTile(
    '02 color + border',
    BoxDecoration(
      color: cCinnabar,
      border: Border.all(color: cCharcoal, width: 2),
    ),
  ));
  // 3. Rounded corners.
  tiles.add(_swatchTile(
    '03 rounded',
    BoxDecoration(
      color: cTerracotta,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cCharcoal, width: 1),
    ),
  ));
  // 4. Image.  We use an AssetImage placeholder string; AssetImage cannot
  //    resolve at frozen-frame time but the painting recipe is still valid.
  tiles.add(_swatchTile(
    '04 image (asset)',
    BoxDecoration(
      color: cClay,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal),
      image: const DecorationImage(
        image: AssetImage('plaster.png'),
        fit: BoxFit.cover,
        opacity: 0.0,
      ),
    ),
  ));
  // 5. Linear gradient.
  tiles.add(_swatchTile(
    '05 linear gradient',
    BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[cCinnabar, cOchre],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal),
    ),
  ));
  // 6. Radial gradient.
  tiles.add(_swatchTile(
    '06 radial gradient',
    BoxDecoration(
      gradient: const RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: <Color>[cEgg, cTerracotta, cCinnabar],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal),
    ),
  ));
  // 7. Sweep gradient.
  tiles.add(_swatchTile(
    '07 sweep gradient',
    BoxDecoration(
      gradient: const SweepGradient(
        colors: <Color>[
          cCinnabar,
          cOchre,
          cEgg,
          cVerdigris,
          cIndigoWash,
          cCinnabar,
        ],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal),
    ),
  ));
  // 8. Shadow ring (single pulsing shadow).
  tiles.add(_swatchTile(
    '08 shadow ring',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cCharcoal),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCinnabar.withValues(alpha: 0.55),
          blurRadius: 12,
          spreadRadius: 4,
          offset: const Offset(0, 0),
        ),
      ],
    ),
  ));
  // 9. Multiple shadows.
  tiles.add(_swatchTile(
    '09 multi shadow',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCinnabar.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(-4, 4),
        ),
        BoxShadow(
          color: cVerdigris.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(4, 4),
        ),
      ],
    ),
  ));
  // 10. Bordered + gradient + shadow.
  tiles.add(_swatchTile(
    '10 border+grad+shadow',
    BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[cOchre, cTerracotta],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cCharcoal, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.4),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
  ));
  // 11. backgroundBlendMode + image.
  tiles.add(_swatchTile(
    '11 blendMode + image',
    BoxDecoration(
      color: cTerracotta,
      backgroundBlendMode: BlendMode.multiply,
      borderRadius: BorderRadius.circular(8),
      image: const DecorationImage(
        image: AssetImage('cartoon.png'),
        fit: BoxFit.cover,
        opacity: 0.0,
      ),
      border: Border.all(color: cCharcoal),
    ),
  ));
  // 12. Fully ornamented.
  tiles.add(_swatchTile(
    '12 fully ornamented',
    BoxDecoration(
      gradient: const RadialGradient(
        colors: <Color>[cEgg, cTerracotta, cCinnabar],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cCharcoal, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCinnabar.withValues(alpha: 0.5),
          blurRadius: 14,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    ),
  ));

  return Wrap(spacing: 12, runSpacing: 14, children: tiles);
}

Widget _swatchTile(String label, BoxDecoration deco) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(width: 130, height: 80, decoration: deco),
      const SizedBox(height: 4),
      SizedBox(
        width: 130,
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: cCharcoal),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 5  ---  Lerp gallery --- BoxDecoration.lerp(a, b, t)
// ===========================================================================
//
//  Two contrasting BoxDecorations and their lerps at t = 0.0, 0.25, 0.5,
//  0.75, 1.0.  Each result is a real BoxDecoration we render to a Container.
//
// ---------------------------------------------------------------------------

Widget _buildLerpGallery() {
  print(' Building Section 5: lerp gallery.');

  // Endpoint A --- charcoal sharp rectangle with a quiet shadow.
  final BoxDecoration a = BoxDecoration(
    color: cCharcoal,
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: cAsh, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.2),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  // Endpoint B --- ochre rounded with a heavy red drop shadow.
  final BoxDecoration b = BoxDecoration(
    color: cOchre,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(color: cCinnabar, width: 4),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCinnabar.withValues(alpha: 0.6),
        blurRadius: 14,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ],
  );

  final List<double> ts = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

  // Compute the lerps up front; lerp returns Decoration?, downcast to
  // BoxDecoration when both inputs are BoxDecoration.  The Flutter
  // framework guarantees this.
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < ts.length; i++) {
    final double t = ts[i];
    final Decoration? mid = BoxDecoration.lerp(a, b, t);
    final BoxDecoration deco =
        (mid is BoxDecoration) ? mid : BoxDecoration(color: cAsh);
    print(' lerp(a, b, $t) -> ${deco.runtimeType}; '
        'color=${deco.color}, '
        'borderRadius=${deco.borderRadius}');
    tiles.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 130, height: 80, decoration: deco),
          const SizedBox(height: 4),
          SizedBox(
            width: 130,
            child: Text(
              't = $t',
              style: const TextStyle(fontSize: 10, color: cCharcoal),
            ),
          ),
        ],
      ),
    );
  }

  // Wrap in a card.
  final BoxDecoration cardDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: cardDeco,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BoxDecoration.lerp(a, b, t) tweens color, border, radius, gradient, '
          'image, shadows, and blendMode piecewise.  The framework handles '
          'each property type with its own lerp routine.  When both inputs '
          'have the same property type (e.g. both LinearGradient) the result '
          'is the obvious tween; when they differ, the framework switches '
          'between them at t = 0.5.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 14, children: tiles),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 6  ---  ShapeDecoration showcase --- six OutlinedBorders
// ===========================================================================
//
//  ShapeDecoration takes a `shape: OutlinedBorder` (or any ShapeBorder).
//  We render six of them: CircleBorder, StadiumBorder,
//  RoundedRectangleBorder, BeveledRectangleBorder,
//  ContinuousRectangleBorder, StarBorder.
//
// ---------------------------------------------------------------------------

Widget _buildShapeDecorationShowcase() {
  print(' Building Section 6: ShapeDecoration showcase.');
  final List<Widget> tiles = <Widget>[];

  final List<Map<String, Object>> entries = <Map<String, Object>>[
    {
      'label': 'CircleBorder',
      'shape': const CircleBorder(side: BorderSide(color: cCharcoal, width: 2)),
      'color': cCinnabar,
    },
    {
      'label': 'StadiumBorder',
      'shape':
          const StadiumBorder(side: BorderSide(color: cCharcoal, width: 2)),
      'color': cTerracotta,
    },
    {
      'label': 'RoundedRectangle',
      'shape': RoundedRectangleBorder(
        side: const BorderSide(color: cCharcoal, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      'color': cOchre,
    },
    {
      'label': 'BeveledRectangle',
      'shape': BeveledRectangleBorder(
        side: const BorderSide(color: cCharcoal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      'color': cVerdigris,
    },
    {
      'label': 'ContinuousRectangle',
      'shape': ContinuousRectangleBorder(
        side: const BorderSide(color: cCharcoal, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      'color': cIndigoWash,
    },
    {
      'label': 'StarBorder',
      'shape': const StarBorder(
        side: BorderSide(color: cCharcoal, width: 2),
        points: 6,
        innerRadiusRatio: 0.55,
      ),
      'color': cEgg,
    },
  ];

  for (int i = 0; i < entries.length; i++) {
    final Map<String, Object> e = entries[i];
    final ShapeBorder shape = e['shape'] as ShapeBorder;
    final Color c = e['color'] as Color;
    // Real ShapeDecoration.
    final ShapeDecoration deco = ShapeDecoration(
      shape: shape,
      color: c,
      shadows: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.4),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    );
    print(' ShapeDecoration[$i] shape=${shape.runtimeType}, '
        'isComplex=${deco.isComplex}, '
        'padding=${deco.padding}');
    tiles.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 110,
            height: 80,
            decoration: deco,
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 120,
            child: Text(
              e['label'] as String,
              style: const TextStyle(fontSize: 10, color: cCharcoal),
            ),
          ),
        ],
      ),
    );
  }

  // Also throw in one ShapeDecoration with a gradient instead of a flat
  // color, for variety.
  final ShapeDecoration gradientShape = ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: cCharcoal, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cCinnabar, cOchre, cEgg],
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.5),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
  tiles.add(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: 110, height: 80, decoration: gradientShape),
        const SizedBox(height: 4),
        const SizedBox(
          width: 120,
          child: Text(
            'gradient + shape',
            style: TextStyle(fontSize: 10, color: cCharcoal),
          ),
        ),
      ],
    ),
  );

  // Outer card.
  final BoxDecoration wrapDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: wrapDeco,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ShapeDecoration trades BoxDecoration\'s rectangle/circle '
          'opinionation for a fully open-ended OutlinedBorder.  Whatever '
          'ShapeBorder you give it (rounded, stadium, beveled, star, or a '
          'custom one) is the painted outline AND the clip path AND the '
          'hit-test region.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 14, children: tiles),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 7  ---  Border / BorderRadius matrix --- 4x4 grid
// ===========================================================================
//
//  We render a 4x4 grid: rows are border widths (0, 1, 3, 6), cols are
//  border radii (0, 6, 16, 32).  Each cell is its own BoxDecoration.
//
// ---------------------------------------------------------------------------

Widget _buildBorderRadiusMatrix() {
  print(' Building Section 7: border / borderRadius matrix.');
  final List<double> widths = <double>[0.0, 1.0, 3.0, 6.0];
  final List<double> radii = <double>[0.0, 6.0, 16.0, 32.0];

  // Build all cells into a flat list, then split into rows of 4.
  final List<Widget> cells = <Widget>[];
  for (int wi = 0; wi < widths.length; wi++) {
    final double w = widths[wi];
    for (int ri = 0; ri < radii.length; ri++) {
      final double r = radii[ri];
      final BoxDecoration deco = BoxDecoration(
        color: cTerracotta,
        border: w == 0
            ? null
            : Border.all(color: cCharcoal, width: w),
        borderRadius: BorderRadius.circular(r),
      );
      cells.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(width: 78, height: 50, decoration: deco),
            const SizedBox(height: 3),
            Text(
              'w=$w r=$r',
              style: const TextStyle(fontSize: 9, color: cCharcoal),
            ),
          ],
        ),
      );
    }
  }

  // Convert flat list of 16 cells into 4 Rows.  We avoid for-in over
  // BridgedInstance: indexed loops only.
  final List<Widget> rows = <Widget>[];
  int idx = 0;
  for (int r = 0; r < 4; r++) {
    final List<Widget> rowCells = <Widget>[];
    for (int c = 0; c < 4; c++) {
      rowCells.add(
        Padding(
          padding: const EdgeInsets.all(4),
          child: cells[idx],
        ),
      );
      idx++;
    }
    rows.add(Row(children: rowCells));
  }

  final BoxDecoration wrapDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: wrapDeco,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Borders interact with borderRadius in a way that is intuitive '
          'once you stop thinking of them as separate fields.  The border '
          'is drawn *on top of* the rounded corner, and the radius applies '
          'to BOTH the fill clip AND the border path.  Here is the full '
          'cross product of width in {0, 1, 3, 6} px and radius in '
          '{0, 6, 16, 32} px.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 10),
        Column(children: rows),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 8  ---  Gradient anatomy --- linear, radial, sweep
// ===========================================================================
//
//  Three rows.  Each row shows one gradient subtype with its mathematical
//  description in monospace next to the swatch.
//
// ---------------------------------------------------------------------------

Widget _buildGradientAnatomy() {
  print(' Building Section 8: gradient anatomy.');
  final List<Widget> rows = <Widget>[];

  // Linear with custom stops.
  final BoxDecoration linearDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[cCharcoal, cCinnabar, cOchre, cEgg],
      stops: <double>[0.0, 0.3, 0.7, 1.0],
    ),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cCharcoal),
  );
  rows.add(_gradientRow(
    'LinearGradient',
    "begin: centerLeft\n"
        "end:   centerRight\n"
        "colors: [charcoal, cinnabar, ochre, egg]\n"
        "stops:  [0.0, 0.3, 0.7, 1.0]",
    linearDeco,
  ));

  // Radial with focal point.
  final BoxDecoration radialDeco = BoxDecoration(
    gradient: const RadialGradient(
      center: Alignment.center,
      radius: 0.9,
      focal: Alignment(-0.4, -0.4),
      focalRadius: 0.1,
      colors: <Color>[cEgg, cOchre, cTerracotta, cCharcoal],
      stops: <double>[0.0, 0.4, 0.75, 1.0],
    ),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cCharcoal),
  );
  rows.add(_gradientRow(
    'RadialGradient',
    "center: Alignment.center\n"
        "radius: 0.9\n"
        "focal:  Alignment(-0.4, -0.4)\n"
        "focalRadius: 0.1\n"
        "colors: [egg, ochre, terracotta, charcoal]",
    radialDeco,
  ));

  // Sweep with multiple stops.
  final BoxDecoration sweepDeco = BoxDecoration(
    gradient: const SweepGradient(
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 6.2831853,
      colors: <Color>[
        cCinnabar,
        cOchre,
        cEgg,
        cVerdigris,
        cIndigoWash,
        cCinnabar,
      ],
      stops: <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    ),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cCharcoal),
  );
  rows.add(_gradientRow(
    'SweepGradient',
    "center:   Alignment.center\n"
        "startAng: 0.0\n"
        "endAng:   2 * pi\n"
        "colors: [cin, ochre, egg, verdi, indigo, cin]\n"
        "stops:  [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]",
    sweepDeco,
  ));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
  );
}

Widget _gradientRow(String title, String math, BoxDecoration deco) {
  final BoxDecoration cardDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.3)),
  );
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      decoration: cardDeco,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 160, height: 100, decoration: deco),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: cCinnabar,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  math,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.4,
                    color: cCharcoal,
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

// ===========================================================================
//  SECTION 9  ---  Shadow anatomy --- six BoxShadow studies
// ===========================================================================
//
//  Six BoxShadow variants showing what each parameter contributes:
//      offset, blurRadius, spreadRadius, color, blurStyle.outer,
//      blurStyle.normal, multiple-shadow stacking.
//
// ---------------------------------------------------------------------------

Widget _buildShadowAnatomy() {
  print(' Building Section 9: shadow anatomy.');
  final List<Widget> tiles = <Widget>[];

  // 1. offset only.
  tiles.add(_shadowTile(
    '01 offset (4, 4)',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: cCharcoal,
          offset: Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    ),
  ));
  // 2. blur only.
  tiles.add(_shadowTile(
    '02 blur 12, offset 0',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.7),
          blurRadius: 12,
          offset: const Offset(0, 0),
        ),
      ],
    ),
  ));
  // 3. spreadRadius positive.
  tiles.add(_shadowTile(
    '03 spread +6',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCinnabar.withValues(alpha: 0.6),
          spreadRadius: 6,
          blurRadius: 4,
          offset: const Offset(0, 0),
        ),
      ],
    ),
  ));
  // 4. spreadRadius negative.
  tiles.add(_shadowTile(
    '04 spread -3 (tight)',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.7),
          spreadRadius: -3,
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
  ));
  // 5. coloured glow.
  tiles.add(_shadowTile(
    '05 colored glow',
    BoxDecoration(
      color: cIndigoWash,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cEgg.withValues(alpha: 0.7),
          spreadRadius: 2,
          blurRadius: 14,
          offset: const Offset(0, 0),
        ),
      ],
    ),
  ));
  // 6. stacked shadows (front+back).
  tiles.add(_shadowTile(
    '06 stacked shadows',
    BoxDecoration(
      color: cBone,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCinnabar.withValues(alpha: 0.55),
          offset: const Offset(-4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: cVerdigris.withValues(alpha: 0.55),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
      ],
    ),
  ));

  return Wrap(spacing: 18, runSpacing: 24, children: tiles);
}

Widget _shadowTile(String label, BoxDecoration deco) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: 110, height: 70, decoration: deco),
        const SizedBox(height: 6),
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: cCharcoal),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 10  ---  Hit-testing demo --- circle vs grid
// ===========================================================================
//
//  We build a 6x6 grid of cells overlaid with a circle BoxDecoration
//  (shape: BoxShape.circle).  We use Decoration.hitTest to colour each
//  cell green if its centre falls inside the circle, red if it falls
//  outside.  Everything is computed at build time.
//
// ---------------------------------------------------------------------------

Widget _buildHitTestingDemo() {
  print(' Building Section 10: hit-testing demo.');

  // Imagined size of the painted circle.
  const double regionSize = 240.0;
  const Size region = Size(regionSize, regionSize);

  // The circle decoration.
  final BoxDecoration circleDeco = BoxDecoration(
    color: cCinnabar.withValues(alpha: 0.35),
    shape: BoxShape.circle,
    border: Border.all(color: cCharcoal, width: 2),
  );

  // Pre-compute hit results for a 6x6 grid of points.
  const int gridN = 6;
  const double cellSize = regionSize / gridN;

  // Build the grid as Stack children.
  final List<Widget> stackChildren = <Widget>[];
  // Backdrop.
  stackChildren.add(
    Container(
      width: regionSize,
      height: regionSize,
      decoration: BoxDecoration(
        color: cBone,
        border: Border.all(color: cCharcoal),
      ),
    ),
  );
  // The circle itself.
  stackChildren.add(
    Container(
      width: regionSize,
      height: regionSize,
      decoration: circleDeco,
    ),
  );
  // The 36 grid cells, each a small square coloured by hit/miss.
  for (int r = 0; r < gridN; r++) {
    for (int c = 0; c < gridN; c++) {
      final Offset point = Offset(
        c * cellSize + cellSize / 2,
        r * cellSize + cellSize / 2,
      );
      final bool hit = circleDeco.hitTest(
        region,
        point,
        textDirection: TextDirection.ltr,
      );
      final Color cellColor = hit
          ? cVerdigris.withValues(alpha: 0.65)
          : cCinnabar.withValues(alpha: 0.4);
      final BoxDecoration cellDeco = BoxDecoration(
        color: cellColor,
        border: Border.all(color: cCharcoal.withValues(alpha: 0.4), width: 0.5),
      );
      stackChildren.add(
        Positioned(
          left: c * cellSize,
          top: r * cellSize,
          width: cellSize,
          height: cellSize,
          child: Container(
            decoration: cellDeco,
            alignment: Alignment.center,
            child: Text(
              hit ? '1' : '0',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: cCharcoal,
              ),
            ),
          ),
        ),
      );
    }
  }

  // Outer wrapper card.
  final BoxDecoration cardDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: cardDeco,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Decoration.hitTest(size, position) is the predicate Flutter uses '
          'to decide whether a touch on a Container with a circular '
          'BoxDecoration should be considered "inside the painted region".  '
          'Below, every grid cell\'s centre is fed to hitTest; cells where '
          'hitTest returns true are coloured verdigris, the rest cinnabar.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: regionSize,
          height: regionSize,
          child: Stack(children: stackChildren),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 11  ---  Subtype property table
// ===========================================================================
//
//  A row-per-subtype table listing padding, isComplex, supports-image,
//  hit-test rule.  We construct a real instance of each subtype so we can
//  print() its values.
//
// ---------------------------------------------------------------------------

Widget _buildSubtypeTable() {
  print(' Building Section 11: subtype property table.');

  final BoxDecoration sampleBox = BoxDecoration(
    color: cTerracotta,
    border: Border.all(color: cCharcoal, width: 2),
  );
  final ShapeDecoration sampleShape = ShapeDecoration(
    color: cVerdigris,
    shape: const StadiumBorder(side: BorderSide(color: cCharcoal, width: 2)),
  );
  final FlutterLogoDecoration sampleLogo = FlutterLogoDecoration(
    style: FlutterLogoStyle.markOnly,
    textColor: cCharcoal,
  );
  final UnderlineTabIndicator sampleUnderline = UnderlineTabIndicator(
    borderSide: BorderSide(color: cCinnabar, width: 3),
    insets: const EdgeInsets.symmetric(horizontal: 8),
  );

  print(' BoxDecoration.padding         = ${sampleBox.padding}');
  print(' BoxDecoration.isComplex       = ${sampleBox.isComplex}');
  print(' ShapeDecoration.padding       = ${sampleShape.padding}');
  print(' ShapeDecoration.isComplex     = ${sampleShape.isComplex}');
  print(' FlutterLogoDecoration.padding = ${sampleLogo.padding}');
  print(' UnderlineTabIndicator.padding = ${sampleUnderline.padding}');

  final List<List<String>> rows = <List<String>>[
    <String>['subtype', 'padding', 'isComplex', 'image?', 'hitTest rule'],
    <String>[
      'BoxDecoration',
      '${sampleBox.padding}',
      '${sampleBox.isComplex}',
      'yes',
      'rect or inscribed circle',
    ],
    <String>[
      'ShapeDecoration',
      '${sampleShape.padding}',
      '${sampleShape.isComplex}',
      'yes',
      'inside ShapeBorder.getOuterPath',
    ],
    <String>[
      'FlutterLogoDecoration',
      '${sampleLogo.padding}',
      '${sampleLogo.isComplex}',
      'no',
      'rect',
    ],
    <String>[
      'UnderlineTabIndicator',
      '${sampleUnderline.padding}',
      '${sampleUnderline.isComplex}',
      'no',
      'underline rect',
    ],
  ];

  // Build the table widgets manually.  No collection-fors.
  final List<Widget> tableRows = <Widget>[];
  for (int ri = 0; ri < rows.length; ri++) {
    final List<String> row = rows[ri];
    final bool header = ri == 0;
    final List<Widget> cells = <Widget>[];
    for (int ci = 0; ci < row.length; ci++) {
      final String text = row[ci];
      final TextStyle style = header
          ? const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: cPlaster,
            )
          : const TextStyle(
              fontSize: 11,
              color: cCharcoal,
            );
      // Use real BoxDecorations on the cells too, so we keep counting.
      final BoxDecoration cellDeco = BoxDecoration(
        color: header ? cCinnabar : cBone,
        border: Border(
          right: BorderSide(color: cCharcoal.withValues(alpha: 0.3)),
          bottom: BorderSide(color: cCharcoal.withValues(alpha: 0.3)),
        ),
      );
      cells.add(
        Container(
          width: ci == 0 ? 160 : (ci == 4 ? 200 : 100),
          decoration: cellDeco,
          padding: const EdgeInsets.all(8),
          child: Text(text, style: style),
        ),
      );
    }
    tableRows.add(Row(children: cells));
  }

  final BoxDecoration wrapDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cCharcoal.withValues(alpha: 0.4)),
  );

  return Container(
    decoration: wrapDeco,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A summary of the abstract Decoration API as implemented by each '
          'concrete subtype.  Note that BoxDecoration and ShapeDecoration '
          'share most behaviour but differ in clip path: BoxDecoration is '
          'clipped to a rectangle (or circle), ShapeDecoration is clipped '
          'to whatever path the ShapeBorder draws.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableRows,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 12  ---  Recipe card grid --- six named recipes
// ===========================================================================
//
//  Six recipe cards, each pairing a code snippet with the rendered visual.
//  The recipes all use BoxDecoration so the user can see source <-> output.
//
// ---------------------------------------------------------------------------

Widget _buildRecipeCards() {
  print(' Building Section 12: recipe cards.');

  // Recipe 1: Sunset gradient.
  final BoxDecoration sunsetDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[cIndigoWash, cCinnabar, cOchre, cEgg],
      stops: <double>[0.0, 0.4, 0.75, 1.0],
    ),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cCharcoal),
  );
  final String sunsetCode = '''BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      indigoWash, cinnabar, ochre, egg,
    ],
    stops: [0.0, 0.4, 0.75, 1.0],
  ),
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: charcoal),
)''';

  // Recipe 2: Embossed plaster.
  final BoxDecoration embossedDeco = BoxDecoration(
    color: cPlaster,
    borderRadius: BorderRadius.circular(8),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.45),
        offset: const Offset(2, 2),
        blurRadius: 4,
      ),
      BoxShadow(
        color: cBone,
        offset: const Offset(-2, -2),
        blurRadius: 4,
      ),
    ],
  );
  final String embossedCode = '''BoxDecoration(
  color: plaster,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(color: charcoal38,
        offset: Offset(2, 2),
        blurRadius: 4),
    BoxShadow(color: bone,
        offset: Offset(-2, -2),
        blurRadius: 4),
  ],
)''';

  // Recipe 3: Vellum sheen.
  final BoxDecoration vellumDeco = BoxDecoration(
    color: cBone,
    borderRadius: BorderRadius.circular(8),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        cPlaster.withValues(alpha: 0.0),
        cPlaster.withValues(alpha: 0.7),
        cBone.withValues(alpha: 0.0),
      ],
      stops: const <double>[0.0, 0.5, 1.0],
    ),
    border: Border.all(color: cAsh),
  );
  final String vellumCode = '''BoxDecoration(
  color: bone,
  borderRadius: BorderRadius.circular(8),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      transparent, plaster70, transparent,
    ],
  ),
  border: Border.all(color: ash),
)''';

  // Recipe 4: Brick course.
  final BoxDecoration brickDeco = BoxDecoration(
    color: cTerracotta,
    border: const Border(
      top: BorderSide(color: cBone, width: 1),
      bottom: BorderSide(color: cCharcoal, width: 2),
      left: BorderSide(color: cCharcoal, width: 1),
      right: BorderSide(color: cCharcoal, width: 1),
    ),
  );
  final String brickCode = '''BoxDecoration(
  color: terracotta,
  border: Border(
    top:    BorderSide(bone, 1),
    bottom: BorderSide(charcoal, 2),
    left:   BorderSide(charcoal, 1),
    right:  BorderSide(charcoal, 1),
  ),
)''';

  // Recipe 5: Stained glass.
  final BoxDecoration stainedDeco = BoxDecoration(
    gradient: const RadialGradient(
      colors: <Color>[cEgg, cCinnabar, cIndigoWash],
      stops: <double>[0.0, 0.55, 1.0],
    ),
    border: Border.all(color: cCharcoal, width: 3),
    borderRadius: BorderRadius.circular(6),
  );
  final String stainedCode = '''BoxDecoration(
  gradient: RadialGradient(
    colors: [egg, cinnabar, indigoWash],
    stops: [0.0, 0.55, 1.0],
  ),
  border: Border.all(charcoal, 3),
  borderRadius: BorderRadius.circular(6),
)''';

  // Recipe 6: Patina copper.
  final BoxDecoration patinaDeco = BoxDecoration(
    color: cVerdigris,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cAsh, width: 2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cVerdigris.withValues(alpha: 0.5),
        blurRadius: 16,
        spreadRadius: 1,
        offset: const Offset(0, 4),
      ),
    ],
    backgroundBlendMode: BlendMode.multiply,
  );
  final String patinaCode = '''BoxDecoration(
  color: verdigris,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(ash, 2),
  boxShadow: [BoxShadow(
    color: verdigris50,
    blurRadius: 16,
    spreadRadius: 1,
    offset: Offset(0, 4),
  )],
  backgroundBlendMode: BlendMode.multiply,
)''';

  final List<Map<String, Object>> recipes = <Map<String, Object>>[
    {'title': 'Sunset gradient', 'deco': sunsetDeco, 'code': sunsetCode},
    {'title': 'Embossed plaster', 'deco': embossedDeco, 'code': embossedCode},
    {'title': 'Vellum sheen', 'deco': vellumDeco, 'code': vellumCode},
    {'title': 'Brick course', 'deco': brickDeco, 'code': brickCode},
    {'title': 'Stained glass', 'deco': stainedDeco, 'code': stainedCode},
    {'title': 'Patina copper', 'deco': patinaDeco, 'code': patinaCode},
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final Map<String, Object> r = recipes[i];
    final BoxDecoration sample = r['deco'] as BoxDecoration;
    final BoxDecoration cardDeco = BoxDecoration(
      color: cCharcoal,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cEgg.withValues(alpha: 0.5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCharcoal.withValues(alpha: 0.3),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    );
    cards.add(
      SizedBox(
        width: 380,
        child: Container(
          decoration: cardDeco,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                r['title'] as String,
                style: const TextStyle(
                  color: cEgg,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Container(width: 360, height: 60, decoration: sample),
              const SizedBox(height: 8),
              Text(r['code'] as String, style: kCodeStyle),
            ],
          ),
        ),
      ),
    );
  }

  return Wrap(spacing: 10, runSpacing: 10, children: cards);
}

// ===========================================================================
//  SECTION 13  ---  Closing fresco essay
// ===========================================================================
//
//  A long prose paragraph (~200 words) reflecting on Decoration as the
//  digital descendant of fresco craft.
//
// ---------------------------------------------------------------------------

Widget _buildClosingEssay() {
  print(' Building Section 13: closing essay.');
  // Footer BoxDecoration --- a heavy carmine card with gold lineart border.
  final BoxDecoration cardDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cCinnabar, cSinopia, cCharcoal],
    ),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: cEgg, width: 2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCharcoal.withValues(alpha: 0.5),
        blurRadius: 14,
        offset: const Offset(0, 8),
      ),
    ],
  );

  return Container(
    decoration: cardDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'CLOSING FRESCO',
          style: TextStyle(
            color: cEgg,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'In the master\'s workshop the wall is prepared in three layers.  '
          'The arriccio is the first rough plaster --- coarse, structural, '
          'undeclared. Over it the painter draws the sinopia, a red-earth '
          'cartoon, in confident lines that will guide everything that '
          'follows. Then comes the intonaco, the fine plaster laid in the '
          'patches that the day\'s work will cover, a giornata at a time, '
          'while the surface is still wet enough to take pigment.  Each '
          'pigment is a small story: cinnabar from cinnabar ore, ochre '
          'from earth, verdigris from copper sheets corroded over wine, '
          'egg yolk to bind the colour to the wall.\n'
          '\n'
          'A Flutter Decoration is a digital fresco.  The Decoration is '
          'the cartoon: it tells the engine what the shape will be, what '
          'colour fills it, what borders trace it, what shadows pool '
          'beneath it.  BoxDecoration is the rectangle wall, ShapeDecoration '
          'is the curved apse, FlutterLogoDecoration is the master\'s '
          'signature, UnderlineTabIndicator is the chalk mark beneath a '
          'noted figure.  Lerp is the assistant who blends two colours '
          'on the slab; hitTest is the deacon\'s finger checking the '
          'wet patch is yours; getClipPath is the templated stencil; '
          'createBoxPainter is the brush itself, finally meeting the wall.',
          style: TextStyle(
            color: cPlaster,
            fontSize: 12,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// END --- Decoration deep demo, "Plaster Carmine" theme.
// =============================================================================
