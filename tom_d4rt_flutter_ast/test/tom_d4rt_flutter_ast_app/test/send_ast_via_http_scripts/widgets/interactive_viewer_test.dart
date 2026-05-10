// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
// InteractiveViewer — Visual Deep Demo
// =============================================================================
//
// This file is a long-form, hand-written visual study of Flutter's
// `InteractiveViewer` widget — the pan, zoom and scale wrapper that lets users
// drag and pinch arbitrary subtrees. It walks through every constructor
// parameter, the role of `Matrix4`, the live `TransformationController`, the
// `InteractiveViewer.builder` lazy variant, edge-cases around `constrained`,
// `boundaryMargin` and `panAxis`, and finishes with a sober list of pitfalls
// you only learn the hard way.
//
// All cards on this page are STATIC: pan/zoom is conceptually demonstrated via
// labels, frames and `Matrix4.identity()` — the actual gesture loop would
// require a `TransformationController` and stateful rebuilds, both of which
// are explicitly out of scope here. Treat this as "the manual you wish was
// printed on the back of every Flutter desk".
//
// Sections:
//   1.  Hero banner with stylised "magnifying glass over content"
//   2.  Anatomy of the InteractiveViewer constructor
//   3.  Live demo strip — four real `InteractiveViewer` widgets with different
//       children (grid, fake city map, image-like, long text)
//   4.  panAxis enum cards (free, horizontal, vertical, aligned)
//   5.  clipBehavior enum panel
//   6.  panEnabled / scaleEnabled matrix
//   7.  boundaryMargin panel (zero, default, infinite)
//   8.  minScale / maxScale panel
//   9.  Matrix4 explainer with 4x4 grid
//   10. InteractiveViewer.builder recipe
//   11. trackpadScrollCausesScale callout
//   12. Pitfalls
//   13. Footer
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — soft, paper-like tones with a single accent for highlights.
// ---------------------------------------------------------------------------

const Color paletteInk = Color(0xFF1F2933);
const Color paletteInkSoft = Color(0xFF52606D);
const Color paletteInkFaint = Color(0xFF7B8794);
const Color paletteParchment = Color(0xFFFAF6EE);
const Color paletteParchmentDeep = Color(0xFFF1EADB);
const Color paletteRule = Color(0xFFD8CFB8);
const Color paletteAccent = Color(0xFF2B6CB0);
const Color paletteAccentSoft = Color(0xFFBEE3F8);
const Color paletteAccentDeep = Color(0xFF1A4F84);
const Color paletteWarn = Color(0xFFB7791F);
const Color paletteWarnSoft = Color(0xFFFAF089);
const Color paletteOk = Color(0xFF2F855A);
const Color paletteOkSoft = Color(0xFFC6F6D5);
const Color paletteBad = Color(0xFFC53030);
const Color paletteBadSoft = Color(0xFFFED7D7);
const Color paletteMap1 = Color(0xFFE9DFC7);
const Color paletteMap2 = Color(0xFFB7C6A8);
const Color paletteMap3 = Color(0xFF6E8B6B);
const Color paletteMap4 = Color(0xFF8E96A8);

// ---------------------------------------------------------------------------
// Typography helpers — small, deliberate set, no theme magic.
// ---------------------------------------------------------------------------

const TextStyle styleHeroTitle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w800,
  color: paletteInk,
  letterSpacing: -0.6,
  height: 1.05,
);

const TextStyle styleHeroSubtitle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: paletteInkSoft,
  height: 1.4,
);

const TextStyle styleSectionTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: paletteInk,
  letterSpacing: -0.3,
);

const TextStyle styleSectionLead = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: paletteInkSoft,
  height: 1.5,
);

const TextStyle styleBody = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: paletteInk,
  height: 1.45,
);

const TextStyle styleBodySoft = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w400,
  color: paletteInkSoft,
  height: 1.45,
);

const TextStyle styleCode = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: paletteInk,
  height: 1.4,
);

const TextStyle styleCodeFaint = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  color: paletteInkSoft,
  height: 1.4,
);

const TextStyle styleCardTitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: paletteInk,
);

const TextStyle styleCardLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: paletteAccentDeep,
  letterSpacing: 1.2,
);

const TextStyle styleTag = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 0.8,
);

// ---------------------------------------------------------------------------
// MAIN ENTRY
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'InteractiveViewer — Deep Demo',
    home: Scaffold(
      backgroundColor: paletteParchment,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroBanner(),
              SizedBox(height: 28),
              anatomySection(),
              SizedBox(height: 28),
              liveDemoStrip(),
              SizedBox(height: 28),
              panAxisSection(),
              SizedBox(height: 28),
              clipBehaviorSection(),
              SizedBox(height: 28),
              enableMatrixSection(),
              SizedBox(height: 28),
              boundaryMarginSection(),
              SizedBox(height: 28),
              scaleRangeSection(),
              SizedBox(height: 28),
              matrixExplainerSection(),
              SizedBox(height: 28),
              builderRecipeSection(),
              SizedBox(height: 28),
              trackpadCallout(),
              SizedBox(height: 28),
              pitfallsSection(),
              SizedBox(height: 28),
              footerSection(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — HERO
// ===========================================================================

Widget heroBanner() {
  return Container(
    padding: EdgeInsets.fromLTRB(32, 30, 32, 30),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: paletteRule, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 28,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: paletteAccentSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'WIDGET STUDY  ·  PAN & ZOOM',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: paletteAccentDeep,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Text('InteractiveViewer', style: styleHeroTitle),
              SizedBox(height: 8),
              Text(
                'A drop-in wrapper that turns any subtree into a pannable,'
                ' zoomable surface. Drag with one finger to pan, pinch with two'
                ' to scale; on desktop a trackpad scroll moves the child by'
                ' default — opt into pinch-to-scale via trackpadScrollCausesScale.',
                style: styleHeroSubtitle,
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  heroChip('child'),
                  heroChip('transformationController'),
                  heroChip('panAxis'),
                  heroChip('boundaryMargin'),
                  heroChip('clipBehavior'),
                  heroChip('constrained'),
                  heroChip('minScale / maxScale'),
                  heroChip('panEnabled / scaleEnabled'),
                  heroChip('scaleFactor'),
                  heroChip('trackpadScrollCausesScale'),
                  heroChip('alignment'),
                  heroChip('onInteractionStart / Update / End'),
                  heroChip('interactionEndFrictionCoefficient'),
                  heroChip('.builder'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: AspectRatio(
            aspectRatio: 1.25,
            child: heroMagnifyingGlass(),
          ),
        ),
      ],
    ),
  );
}

Widget heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: paletteParchmentDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: paletteRule, width: 0.8),
    ),
    child: Text(label, style: styleCodeFaint),
  );
}

Widget heroMagnifyingGlass() {
  return Container(
    decoration: BoxDecoration(
      color: paletteParchmentDeep,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: heroBackgroundContent(),
          ),
        ),
        Positioned(
          left: 30,
          top: 28,
          child: Transform.rotate(
            angle: -0.3,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x33FFFFFF),
                border: Border.all(color: paletteAccentDeep, width: 6),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 20,
                    offset: Offset(4, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '2.4x',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: paletteAccentDeep,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 196,
          top: 196,
          child: Transform.rotate(
            angle: 0.78,
            child: Container(
              width: 84,
              height: 18,
              decoration: BoxDecoration(
                color: paletteAccentDeep,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget heroBackgroundContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Row(
        children: <Widget>[
          heroDot(paletteAccent),
          heroDot(paletteWarn),
          heroDot(paletteOk),
          heroDot(paletteBad),
          heroDot(paletteAccentDeep),
          heroDot(paletteMap3),
        ],
      ),
      Container(height: 8, color: paletteRule),
      Container(height: 8, color: paletteAccentSoft, width: 180),
      Container(height: 8, color: paletteRule, width: 220),
      Container(height: 8, color: paletteRule, width: 90),
      Row(
        children: <Widget>[
          Expanded(child: Container(height: 32, color: paletteAccent)),
          SizedBox(width: 6),
          Expanded(child: Container(height: 32, color: paletteWarn)),
          SizedBox(width: 6),
          Expanded(child: Container(height: 32, color: paletteOk)),
        ],
      ),
    ],
  );
}

Widget heroDot(Color c) {
  return Container(
    margin: EdgeInsets.only(right: 8),
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      color: c,
      shape: BoxShape.circle,
    ),
  );
}

// ===========================================================================
// SECTION 2 — ANATOMY
// ===========================================================================

Widget anatomySection() {
  return sectionContainer(
    label: 'ANATOMY',
    title: 'The InteractiveViewer constructor',
    lead: 'A single child plus a fistful of behavioural knobs. The child is laid out'
        ' once, then the InteractiveViewer applies a Matrix4 transform on top of it'
        ' for pan and scale. Memorise this signature and you have memorised the widget.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeBlock(<String>[
          'InteractiveViewer(',
          '  // ---- required ----',
          '  child: <Widget>,',
          '',
          '  // ---- transform plumbing ----',
          '  transformationController: TransformationController?,',
          '  alignment: Alignment?,                     // null = align child top-left',
          '',
          '  // ---- pan ----',
          '  panEnabled: true,',
          '  panAxis: PanAxis.free,                     // free | horizontal | vertical | aligned',
          '  boundaryMargin: EdgeInsets.zero,           // how far the child can be panned out',
          '',
          '  // ---- scale ----',
          '  scaleEnabled: true,',
          '  minScale: 0.8,',
          '  maxScale: 2.5,',
          '  scaleFactor: 200.0,                        // pixels per scroll-tick on desktop',
          '  trackpadScrollCausesScale: false,          // true = pinch-like trackpad zoom',
          '',
          '  // ---- physics & layout ----',
          '  interactionEndFrictionCoefficient: 0.0000135,',
          '  constrained: true,                          // false = child can be larger than viewport',
          '  clipBehavior: Clip.hardEdge,',
          '',
          '  // ---- callbacks ----',
          '  onInteractionStart: (ScaleStartDetails)?,',
          '  onInteractionUpdate: (ScaleUpdateDetails)?,',
          '  onInteractionEnd: (ScaleEndDetails)?,',
          ')',
        ]),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: anatomyBullet('child', 'The thing you want pannable. Anything: a Container, an Image, a custom CustomPaint, a long Text — anything.')),
            SizedBox(width: 12),
            Expanded(child: anatomyBullet('Matrix4', 'Internally InteractiveViewer maintains a 4x4 affine transform: translation columns 3, scale on the diagonal, no rotation.')),
            SizedBox(width: 12),
            Expanded(child: anatomyBullet('controller', 'A TransformationController is a ValueNotifier<Matrix4>. Read .value to know "where" the user is.')),
          ],
        ),
      ],
    ),
  );
}

Widget anatomyBullet(String title, String body) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: paletteParchmentDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: styleCardLabel),
        SizedBox(height: 4),
        Text(body, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 — LIVE DEMO STRIP
// ===========================================================================

Widget liveDemoStrip() {
  return sectionContainer(
    label: 'LIVE STRIP',
    title: 'Four real InteractiveViewer widgets',
    lead: 'Each card below is a real InteractiveViewer wrapping a different kind of'
        ' child. We pass Matrix4.identity() as a frozen viewpoint so the page is'
        ' deterministic — in a real app you would hand it a TransformationController.',
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: demoCardGrid()),
            SizedBox(width: 14),
            Expanded(child: demoCardCityMap()),
          ],
        ),
        SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: demoCardImageLike()),
            SizedBox(width: 14),
            Expanded(child: demoCardLongText()),
          ],
        ),
      ],
    ),
  );
}

Widget demoCardShell({
  required String label,
  required String title,
  required String snippet,
  required Widget viewer,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(14, 12, 14, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: styleCardLabel),
              SizedBox(height: 2),
              Text(title, style: styleCardTitle),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Container(
              color: paletteParchment,
              child: viewer,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(14, 10, 14, 14),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: paletteParchmentDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(snippet, style: styleCode),
          ),
        ),
      ],
    ),
  );
}

Widget demoCardGrid() {
  return demoCardShell(
    label: 'CHILD: 600x600 GRID',
    title: 'Coloured paint-by-numbers grid',
    snippet: 'InteractiveViewer(\n'
        '  minScale: 0.5, maxScale: 4,\n'
        '  boundaryMargin: EdgeInsets.all(40),\n'
        '  child: SizedBox(width: 600, height: 600, child: gridChild()),\n'
        ')',
    viewer: InteractiveViewer(
      minScale: 0.5,
      maxScale: 4,
      boundaryMargin: EdgeInsets.all(40),
      panAxis: PanAxis.free,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(width: 600, height: 600, child: gridChild()),
    ),
  );
}

Widget gridChild() {
  return GridView.count(
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 12,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
    padding: EdgeInsets.all(2),
    children: List<Widget>.generate(144, (int i) {
      final int row = i ~/ 12;
      final int col = i % 12;
      final List<Color> palette = <Color>[
        paletteAccent,
        paletteAccentSoft,
        paletteWarn,
        paletteWarnSoft,
        paletteOk,
        paletteOkSoft,
        paletteBad,
        paletteBadSoft,
        paletteMap1,
        paletteMap2,
        paletteMap3,
        paletteMap4,
      ];
      return Container(
        decoration: BoxDecoration(
          color: palette[(row + col) % palette.length],
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.center,
        child: Text(
          '${row}_$col',
          style: TextStyle(fontSize: 8, color: paletteInk),
        ),
      );
    }),
  );
}

Widget demoCardCityMap() {
  return demoCardShell(
    label: 'CHILD: VECTOR MAP',
    title: 'Fake "city map" using shapes',
    snippet: 'InteractiveViewer(\n'
        '  constrained: false,\n'
        '  panAxis: PanAxis.free,\n'
        '  child: SizedBox(width: 720, height: 460, child: cityMapChild()),\n'
        ')',
    viewer: InteractiveViewer(
      constrained: false,
      panAxis: PanAxis.free,
      minScale: 0.4,
      maxScale: 6,
      boundaryMargin: EdgeInsets.all(80),
      child: SizedBox(width: 720, height: 460, child: cityMapChild()),
    ),
  );
}

Widget cityMapChild() {
  return Container(
    color: paletteMap1,
    child: Stack(
      children: <Widget>[
        Positioned(left: 40, top: 30, child: mapBlock(120, 80, paletteMap2)),
        Positioned(left: 180, top: 50, child: mapBlock(90, 60, paletteMap2)),
        Positioned(left: 300, top: 30, child: mapBlock(140, 100, paletteMap2)),
        Positioned(left: 480, top: 60, child: mapBlock(100, 70, paletteMap2)),
        Positioned(left: 60, top: 160, child: mapBlock(180, 90, paletteMap3)),
        Positioned(left: 280, top: 160, child: mapBlock(120, 90, paletteMap3)),
        Positioned(left: 440, top: 180, child: mapBlock(180, 70, paletteMap3)),
        Positioned(left: 80, top: 280, child: mapBlock(220, 110, paletteMap2)),
        Positioned(left: 340, top: 280, child: mapBlock(160, 100, paletteMap4)),
        Positioned(left: 540, top: 300, child: mapBlock(140, 80, paletteMap2)),
        Positioned(left: 0, top: 130, child: Container(width: 720, height: 14, color: paletteInkSoft)),
        Positioned(left: 0, top: 260, child: Container(width: 720, height: 14, color: paletteInkSoft)),
        Positioned(left: 250, top: 0, child: Container(width: 14, height: 460, color: paletteInkSoft)),
        Positioned(left: 460, top: 0, child: Container(width: 14, height: 460, color: paletteInkSoft)),
        Positioned(left: 360, top: 200, child: mapPin()),
      ],
    ),
  );
}

Widget mapBlock(double w, double h, Color c) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: paletteInk, width: 0.6),
    ),
  );
}

Widget mapPin() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: paletteBad,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
      ),
      Container(width: 2, height: 14, color: paletteBad),
    ],
  );
}

Widget demoCardImageLike() {
  return demoCardShell(
    label: 'CHILD: IMAGE-LIKE',
    title: 'Container with corners + shadow',
    snippet: 'InteractiveViewer(\n'
        '  alignment: Alignment.center,\n'
        '  scaleFactor: 200,\n'
        '  child: imageLikeChild(),\n'
        ')',
    viewer: InteractiveViewer(
      alignment: Alignment.center,
      scaleFactor: 200,
      minScale: 0.6,
      maxScale: 5,
      child: imageLikeChild(),
    ),
  );
}

Widget imageLikeChild() {
  return Center(
    child: Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[paletteAccentSoft, paletteAccent, paletteAccentDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(2, 8)),
        ],
      ),
      child: Center(
        child: Text(
          'PHOTO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
          ),
        ),
      ),
    ),
  );
}

Widget demoCardLongText() {
  return demoCardShell(
    label: 'CHILD: LONG TEXT BLOCK',
    title: 'Pannable typography sample',
    snippet: 'InteractiveViewer(\n'
        '  panAxis: PanAxis.vertical,\n'
        '  boundaryMargin: EdgeInsets.symmetric(vertical: 200),\n'
        '  child: longTextChild(),\n'
        ')',
    viewer: InteractiveViewer(
      panAxis: PanAxis.vertical,
      minScale: 1.0,
      maxScale: 2.5,
      boundaryMargin: EdgeInsets.symmetric(vertical: 200),
      child: longTextChild(),
    ),
  );
}

Widget longTextChild() {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Text(
      'InteractiveViewer is a wrapper widget that allows panning and scaling'
      ' of its child. The child is laid out exactly once, at the size it would'
      ' naturally have if it were not wrapped at all (when constrained: true).'
      ' All subsequent visual changes are achieved through a 4x4 transformation'
      ' matrix maintained internally — or, if you provide one, by the'
      ' TransformationController you pass in. The matrix is an affine transform:'
      ' three translation values, three scale values, no rotation, no skew.'
      '\n\nWhen the user pans, the matrix translation is updated. When the user'
      ' pinches, the matrix scale is updated. When constrained is set to false,'
      ' the child is laid out without size constraints from the viewport, which'
      ' is the right setting for very large content like maps or schematics.'
      '\n\nClipping is performed by the InteractiveViewer itself — there is no'
      ' need to wrap it in a ClipRect. The clipBehavior parameter governs this'
      ' clipping. Use Clip.none if you intentionally want the child to bleed'
      ' outside the viewport during overshoot, but be aware that pointer events'
      ' may still be confined to the viewport rectangle.',
      style: styleBody,
    ),
  );
}

// ===========================================================================
// SECTION 4 — panAxis
// ===========================================================================

Widget panAxisSection() {
  return sectionContainer(
    label: 'PAN AXIS',
    title: 'Restricting the direction of pan',
    lead: 'panAxis trims the degrees of freedom of a one-finger drag. It does not'
        ' affect a two-finger pinch. PanAxis.aligned is the unusual one: it locks'
        ' to whichever axis the gesture has the strongest delta on first frame.',
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        panAxisCard(
          name: 'PanAxis.free',
          summary: 'Default. Drag in any direction.',
          arrows: <PanArrow>[
            PanArrow(angle: 0),
            PanArrow(angle: 1.57),
            PanArrow(angle: 3.14),
            PanArrow(angle: -1.57),
            PanArrow(angle: 0.78),
            PanArrow(angle: -0.78),
            PanArrow(angle: 2.36),
            PanArrow(angle: -2.36),
          ],
          good: 'Maps, paintings, free-form canvases',
        ),
        panAxisCard(
          name: 'PanAxis.horizontal',
          summary: 'Only X-axis movement is delivered to the controller.',
          arrows: <PanArrow>[
            PanArrow(angle: 0),
            PanArrow(angle: 3.14),
          ],
          good: 'Filmstrips, timelines, page-by-page horizontal scrollers',
        ),
        panAxisCard(
          name: 'PanAxis.vertical',
          summary: 'Only Y-axis movement is delivered to the controller.',
          arrows: <PanArrow>[
            PanArrow(angle: 1.57),
            PanArrow(angle: -1.57),
          ],
          good: 'Long documents, vertical mood-boards',
        ),
        panAxisCard(
          name: 'PanAxis.aligned',
          summary: 'Locks to whichever axis the gesture is strongest on at start.',
          arrows: <PanArrow>[
            PanArrow(angle: 0),
            PanArrow(angle: 3.14),
            PanArrow(angle: 1.57),
            PanArrow(angle: -1.57),
          ],
          good: 'Forgiving UI for users with shaky pointers',
        ),
      ],
    ),
  );
}

class PanArrow {
  final double angle;
  const PanArrow({required this.angle});
}

Widget panAxisCard({
  required String name,
  required String summary,
  required List<PanArrow> arrows,
  required String good,
}) {
  return SizedBox(
    width: 230,
    child: Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paletteRule, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: styleCardTitle),
          SizedBox(height: 4),
          Text(summary, style: styleBodySoft),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: paletteParchmentDeep,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: paletteAccentDeep,
                      shape: BoxShape.circle,
                    ),
                  ),
                  for (final PanArrow a in arrows)
                    Transform.rotate(
                      angle: a.angle,
                      child: Container(
                        width: 90,
                        height: 4,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0x002B6CB0),
                              paletteAccent,
                            ],
                          ),
                        ),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: paletteAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('GOOD FOR', style: styleCardLabel),
          SizedBox(height: 2),
          Text(good, style: styleBodySoft),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 5 — clipBehavior
// ===========================================================================

Widget clipBehaviorSection() {
  return sectionContainer(
    label: 'CLIP BEHAVIOR',
    title: 'Where does the child stop existing?',
    lead: 'InteractiveViewer creates a clip rectangle equal to its own layout size.'
        ' clipBehavior governs how the GPU treats anything that bleeds outside.'
        ' Clip.none turns off the clip entirely — the child can paint outside,'
        ' but pointer hit-testing is still restricted to the InteractiveViewer rect.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: clipCard(
          name: 'Clip.none',
          subtitle: 'No clip.',
          body: 'Cheapest. Child can paint outside the InteractiveViewer rect — useful for'
              ' shadows that should extend past the boundary. Beware: pointer events do not'
              ' extend past the boundary even if pixels do.',
          tone: paletteWarnSoft,
          tag: 'CHEAPEST',
          tagColor: paletteWarn,
        )),
        SizedBox(width: 12),
        Expanded(child: clipCard(
          name: 'Clip.hardEdge',
          subtitle: 'Default. Pixel-aligned scissor clip.',
          body: 'Pixel-perfect rectangular clipping. No anti-aliasing on the clip edge.'
              ' This is what you want unless you have a specific reason to deviate.',
          tone: paletteAccentSoft,
          tag: 'DEFAULT',
          tagColor: paletteAccent,
        )),
        SizedBox(width: 12),
        Expanded(child: clipCard(
          name: 'Clip.antiAlias',
          subtitle: 'Smooth-edged clip.',
          body: 'Same as hardEdge but anti-aliased on the edges. Slightly more expensive,'
              ' rarely visible — InteractiveViewer is a rectangle, so anti-aliasing buys'
              ' you nothing here.',
          tone: paletteOkSoft,
          tag: 'OK',
          tagColor: paletteOk,
        )),
        SizedBox(width: 12),
        Expanded(child: clipCard(
          name: 'Clip.antiAliasWithSaveLayer',
          subtitle: 'Off-screen layer + AA.',
          body: 'Heaviest option. Renders the child to an offscreen layer first, then'
              ' composites it. Avoid unless you actually need the layer.',
          tone: paletteBadSoft,
          tag: 'EXPENSIVE',
          tagColor: paletteBad,
        )),
      ],
    ),
  );
}

Widget clipCard({
  required String name,
  required String subtitle,
  required String body,
  required Color tone,
  required String tag,
  required Color tagColor,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(tag, style: styleTag),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(name, style: styleCode),
        SizedBox(height: 4),
        Text(subtitle, style: styleCardLabel),
        SizedBox(height: 6),
        Text(body, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 — panEnabled / scaleEnabled
// ===========================================================================

Widget enableMatrixSection() {
  return sectionContainer(
    label: 'GESTURE TOGGLES',
    title: 'panEnabled  x  scaleEnabled',
    lead: 'Both default to true. Switching them off disables the corresponding gesture'
        ' but does not freeze the controller — you can still drive the transform'
        ' programmatically by writing to TransformationController.value.',
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: enableCell(true, true,
                'pan + zoom', 'Default. Free 2-DoF interaction.', paletteOkSoft)),
            SizedBox(width: 10),
            Expanded(child: enableCell(true, false,
                'pan only', 'Page-flick UIs, finite content.', paletteAccentSoft)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(child: enableCell(false, true,
                'zoom only', 'Centered-zoom on a static photo.', paletteWarnSoft)),
            SizedBox(width: 10),
            Expanded(child: enableCell(false, false,
                'frozen', 'Useful as a clip + transform sink driven externally.', paletteBadSoft)),
          ],
        ),
      ],
    ),
  );
}

Widget enableCell(bool pan, bool scale, String label, String body, Color tone) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            enableIcon(pan, 'pan'),
            SizedBox(height: 6),
            enableIcon(scale, 'zoom'),
          ],
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label.toUpperCase(), style: styleCardLabel),
              SizedBox(height: 4),
              Text(body, style: styleBodySoft),
              SizedBox(height: 6),
              Text(
                'panEnabled: $pan, scaleEnabled: $scale',
                style: styleCode,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget enableIcon(bool on, String label) {
  return Container(
    width: 56,
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: BoxDecoration(
      color: on ? paletteOk : paletteInkFaint,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(on ? Icons.check : Icons.close, size: 12, color: Colors.white),
        SizedBox(width: 4),
        Text(label, style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        )),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 — boundaryMargin
// ===========================================================================

Widget boundaryMarginSection() {
  return sectionContainer(
    label: 'BOUNDARY MARGIN',
    title: 'How far past the child the user can pan',
    lead: 'EdgeInsets that extend the legal pan area beyond the child rect. Negative'
        ' insets shrink the area. EdgeInsets.all(double.infinity) lifts the limit'
        ' completely — required if you do not want pan to clamp at all.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: boundaryCard(
          title: 'EdgeInsets.zero',
          desc: 'Default. The child cannot be panned past its own bounding rect.'
              ' At 1.0x scale you cannot pan at all unless the child is larger than the viewport.',
          inner: 0,
          accent: paletteAccent,
        )),
        SizedBox(width: 12),
        Expanded(child: boundaryCard(
          title: 'EdgeInsets.all(80)',
          desc: 'A hand-tuned amount of overdrag. Use this for "rubber-band" feel'
              ' or when a small amount of slack is acceptable in your design.',
          inner: 24,
          accent: paletteWarn,
        )),
        SizedBox(width: 12),
        Expanded(child: boundaryCard(
          title: 'EdgeInsets.all(double.infinity)',
          desc: 'No clamp. Right answer for pan-around-forever surfaces — endless'
              ' canvases, infinite mind-maps, schematics with off-screen detail.',
          inner: 60,
          accent: paletteOk,
          showInfinity: true,
        )),
      ],
    ),
  );
}

Widget boundaryCard({
  required String title,
  required String desc,
  required double inner,
  required Color accent,
  bool showInfinity = false,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: styleCode),
        SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 1.6,
          child: Container(
            decoration: BoxDecoration(
              color: paletteParchmentDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(showInfinity ? 6 : (40 - inner / 2)),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: accent, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  margin: EdgeInsets.all(showInfinity ? 60 : 16),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    showInfinity ? 'inf everywhere' : 'child',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(desc, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — minScale / maxScale
// ===========================================================================

Widget scaleRangeSection() {
  return sectionContainer(
    label: 'SCALE RANGE',
    title: 'minScale, maxScale and scaleFactor',
    lead: 'minScale and maxScale clamp the diagonal of the matrix. scaleFactor controls'
        ' the desktop scroll-wheel sensitivity (pixels per scale-tick). The defaults are'
        ' 0.8/2.5/200 — enough for "subtle zoom in a card", inadequate for maps.',
    child: Column(
      children: <Widget>[
        scaleRulerRow(0.5, 1.0, 4.0, 'maps & schematics'),
        SizedBox(height: 8),
        scaleRulerRow(0.8, 1.0, 2.5, 'default'),
        SizedBox(height: 8),
        scaleRulerRow(1.0, 1.0, 8.0, 'photo viewer'),
        SizedBox(height: 8),
        scaleRulerRow(0.25, 1.0, 16.0, 'infinite canvas'),
        SizedBox(height: 16),
        codeBlock(<String>[
          '// scaleFactor controls how aggressive the scroll-wheel zoom is',
          'InteractiveViewer(',
          '  minScale: 0.5,',
          '  maxScale: 8,',
          '  scaleFactor: 80,    // smaller = bigger zoom per scroll tick',
          '  child: child,',
          ')',
        ]),
      ],
    ),
  );
}

Widget scaleRulerRow(double min, double rest, double max, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'min ${min.toStringAsFixed(2)}  .  rest ${rest.toStringAsFixed(2)}'
              '  .  max ${max.toStringAsFixed(2)}',
              style: styleCode,
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: paletteAccentSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(label.toUpperCase(),
                  style: TextStyle(
                      fontSize: 9,
                      color: paletteAccentDeep,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8)),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 22,
          decoration: BoxDecoration(
            color: paletteParchmentDeep,
            borderRadius: BorderRadius.circular(11),
          ),
          child: LayoutBuilder(builder: (BuildContext c, BoxConstraints b) {
            const double logLo = -4;
            const double logHi = 5;
            double mapValue(double v) {
              final double l = (logBase2(v) - logLo) / (logHi - logLo);
              return l.clamp(0.0, 1.0) * b.maxWidth;
            }

            final double xMin = mapValue(min);
            final double xRest = mapValue(rest);
            final double xMax = mapValue(max);

            return Stack(
              children: <Widget>[
                Positioned(
                  left: xMin,
                  right: b.maxWidth - xMax,
                  top: 9,
                  child: Container(
                    height: 4,
                    color: paletteAccentSoft,
                  ),
                ),
                Positioned(left: xMin - 5, top: 4, child: rulerTick(paletteAccent, 'min')),
                Positioned(left: xRest - 5, top: 4, child: rulerTick(paletteInk, '1x')),
                Positioned(left: xMax - 5, top: 4, child: rulerTick(paletteAccent, 'max')),
              ],
            );
          }),
        ),
      ],
    ),
  );
}

double logBase2(double v) {
  if (v <= 0) return -10;
  double x = v;
  double e = 0;
  while (x >= 2) {
    x /= 2;
    e += 1;
  }
  while (x < 1) {
    x *= 2;
    e -= 1;
  }
  final double y = x - 1;
  final double frac = y - (y * y) / 2 + (y * y * y) / 3 - (y * y * y * y) / 4;
  return e + frac * 1.4426950408889634;
}

Widget rulerTick(Color color, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(width: 10, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
      SizedBox(height: 2),
      Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w700)),
    ],
  );
}

// ===========================================================================
// SECTION 9 — Matrix4 explainer
// ===========================================================================

Widget matrixExplainerSection() {
  return sectionContainer(
    label: 'MATRIX4',
    title: 'The 4x4 affine transform under the hood',
    lead: 'TransformationController.value is a Matrix4 — column-major, 16 doubles. For'
        ' InteractiveViewer the only entries that change are the diagonal scale'
        ' (m00, m11) and the translation column (m03, m13). Everything else stays'
        ' at identity values.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 5, child: matrixGrid()),
        SizedBox(width: 18),
        Expanded(flex: 6, child: matrixNotes()),
      ],
    ),
  );
}

Widget matrixGrid() {
  final List<List<String>> cells = <List<String>>[
    <String>['s', '0', '0', 'tx'],
    <String>['0', 's', '0', 'ty'],
    <String>['0', '0', '1', '0'],
    <String>['0', '0', '0', '1'],
  ];
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      children: <Widget>[
        Text('Matrix4 (uniform scale, translate-only)',
            style: styleCardTitle),
        SizedBox(height: 12),
        Column(
          children: List<Widget>.generate(4, (int row) {
            return Row(
              children: List<Widget>.generate(4, (int col) {
                final String v = cells[row][col];
                final bool isActive = v == 's' || v == 'tx' || v == 'ty';
                return Container(
                  width: 56,
                  height: 56,
                  margin: EdgeInsets.all(3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? paletteAccent : paletteParchmentDeep,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: paletteRule, width: 0.5),
                  ),
                  child: Text(
                    v,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w800 : FontWeight.w400,
                      color: isActive ? Colors.white : paletteInkFaint,
                    ),
                  ),
                );
              }),
            );
          }),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            matrixLegend(paletteAccent, 'live'),
            SizedBox(width: 10),
            matrixLegend(paletteParchmentDeep, 'identity'),
          ],
        ),
      ],
    ),
  );
}

Widget matrixLegend(Color c, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(width: 12, height: 12, color: c),
      SizedBox(width: 4),
      Text(label, style: styleBodySoft),
    ],
  );
}

Widget matrixNotes() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paletteParchmentDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('READING THE MATRIX', style: styleCardLabel),
        SizedBox(height: 6),
        Text(
          'controller.value.getMaxScaleOnAxis()  -> the live scale s.\n'
          'controller.value.getTranslation()      -> Vector3 (tx, ty, 0).\n'
          'controller.value.storage[0]            -> m00, equal to s.\n'
          'controller.value.storage[12]           -> m03, equal to tx.\n'
          'controller.value = Matrix4.identity()  -> resets the view.\n',
          style: styleCode,
        ),
        SizedBox(height: 10),
        Text('SETTING THE MATRIX', style: styleCardLabel),
        SizedBox(height: 6),
        Text(
          'final m = Matrix4.identity()\n'
          '    ..translate(-200.0, -120.0)\n'
          '    ..scale(2.5);\n'
          'controller.value = m;        // jump to a specific viewpoint',
          style: styleCode,
        ),
        SizedBox(height: 10),
        Text(
          'Note: translate is applied in the *child* coordinate system. To centre on a'
          ' point p in child-space at scale s, set tx = -p.dx * s + viewportWidth/2 and'
          ' ty = -p.dy * s + viewportHeight/2.',
          style: styleBodySoft,
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — InteractiveViewer.builder
// ===========================================================================

Widget builderRecipeSection() {
  return sectionContainer(
    label: 'INTERACTIVE VIEWER . BUILDER',
    title: 'Lazy children with .builder',
    lead: 'When the child is too large to materialise eagerly — e.g. a tile pyramid,'
        ' a paged map, an infinite document — use InteractiveViewer.builder. It hands'
        ' you the viewport rect in *child* coordinates and lets you build only the part'
        ' of the child currently visible.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 6, child: codeBlock(<String>[
          'InteractiveViewer.builder(',
          '  minScale: 0.25,',
          '  maxScale: 8.0,',
          '  boundaryMargin: const EdgeInsets.all(double.infinity),',
          '  builder: (BuildContext context, Quad viewport) {',
          '    // viewport is a 3D Quad in child coordinates;',
          '    // its .point0..point3 give the 4 corners.',
          '    final Rect r = axisAlignedBoundingBox(viewport);',
          '    return TilePyramid(',
          '      visibleRect: r,',
          '      tileSize: 256,',
          '    );',
          '  },',
          ')',
        ])),
        SizedBox(width: 14),
        Expanded(flex: 5, child: builderTips()),
      ],
    ),
  );
}

Widget builderTips() {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: paletteParchmentDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('WHY .builder?', style: styleCardLabel),
        SizedBox(height: 6),
        Text('You never lay out content the user cannot see. For a 100k x 100k canvas the'
            ' default constructor would crash; the builder version stays cheap.', style: styleBodySoft),
        SizedBox(height: 10),
        Text('CONSTRAINTS', style: styleCardLabel),
        SizedBox(height: 6),
        Text('-  constrained must be false (it is forced internally).\n'
            '-  alignment must be null.\n'
            '-  panAxis must be PanAxis.free.', style: styleBodySoft),
        SizedBox(height: 10),
        Text('PAIR WITH', style: styleCardLabel),
        SizedBox(height: 6),
        Text('A custom child that takes a Rect, e.g. a tile-based map widget, a CustomPaint'
            ' that culls off-screen geometry, or a SliverList variant for very long text.',
            style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — trackpadScrollCausesScale callout
// ===========================================================================

Widget trackpadCallout() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: paletteWarnSoft,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: paletteWarn, width: 1.4),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: paletteWarn,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.priority_high, color: Colors.white, size: 26),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('trackpadScrollCausesScale: a desktop-shaped landmine',
                  style: styleCardTitle),
              SizedBox(height: 4),
              Text(
                'On a desktop, a trackpad two-finger scroll *pans* by default. If your'
                ' app has its own scrollable parent, this is usually what you want.'
                ' But if your InteractiveViewer wraps a single image and users expect'
                ' the trackpad to zoom (think Photoshop), set this flag to true. The'
                ' rule of thumb: turn it on for media viewers, leave it off for maps.',
                style: styleBody,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paletteRule, width: 1),
                ),
                child: Text(
                  'InteractiveViewer(\n'
                  '  trackpadScrollCausesScale: true,\n'
                  '  scaleFactor: 80,        // also lower this for snappier zoom\n'
                  '  child: photo,\n'
                  ')',
                  style: styleCode,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 — Pitfalls
// ===========================================================================

Widget pitfallsSection() {
  return sectionContainer(
    label: 'PITFALLS',
    title: 'Things people learn the hard way',
    lead: 'Half the bugs filed against InteractiveViewer are not bugs. Read these'
        ' before opening one.',
    child: Column(
      children: <Widget>[
        pitfall(
          title: 'constrained: true silently shrinks your child',
          body: 'When constrained is true (the default), the child is force-fit to the'
              ' viewport size. A 4000-wide map ends up at 600 wide. Set constrained to'
              ' false whenever your child has a natural size you want to honour.',
          tone: paletteBadSoft,
        ),
        pitfall(
          title: 'transformationController.value is the live Matrix4',
          body: 'There is no separate "current scale" double. Read it from the matrix:'
              ' controller.value.getMaxScaleOnAxis(). Beware: storing the value in a'
              ' final does not snapshot it — Matrix4 is mutable.',
          tone: paletteWarnSoft,
        ),
        pitfall(
          title: 'boundaryMargin is in *unscaled child coordinates*',
          body: 'EdgeInsets.all(40) at scale 4 looks like 160 pixels of overdrag. Always'
              ' think in child-pixels, not viewport-pixels.',
          tone: paletteAccentSoft,
        ),
        pitfall(
          title: 'minScale > maxScale is a crash',
          body: 'Asserts in debug, throws in release. Always verify the relationship'
              ' before passing values that came from configuration.',
          tone: paletteBadSoft,
        ),
        pitfall(
          title: 'GestureDetectors inside the child still receive events',
          body: 'InteractiveViewer participates in the gesture arena, so a tap on a child'
              ' button still fires. But if your child uses a Drag gesture, it will fight'
              ' InteractiveViewer for the pan — and InteractiveViewer usually wins.',
          tone: paletteWarnSoft,
        ),
        pitfall(
          title: 'panAxis only restricts one-finger drags',
          body: 'Pinch-to-zoom always allows movement on both axes during the pinch.'
              ' If you want to lock translation in one axis even during a pinch, you'
              ' need to project the matrix yourself in onInteractionUpdate.',
          tone: paletteAccentSoft,
        ),
        pitfall(
          title: 'interactionEndFrictionCoefficient is a tiny number',
          body: 'Defaults to 0.0000135. Treat it as "stiffness of the post-fling spring".'
              ' Increase it (e.g. 0.0001) to make the inertia stop sooner; decrease it'
              ' for slick, glide-y feel. Setting it to 0 makes the fling never stop.',
          tone: paletteOkSoft,
        ),
        pitfall(
          title: 'onInteractionUpdate fires on every frame of the gesture',
          body: 'Do not synchronously rebuild expensive widgets inside it. If you must'
              ' react, schedule the work post-frame or batch it via a ValueNotifier.',
          tone: paletteWarnSoft,
        ),
      ],
    ),
  );
}

Widget pitfall({required String title, required String body, required Color tone}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.warning_amber_rounded, size: 20, color: paletteInk),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: styleCardTitle),
              SizedBox(height: 4),
              Text(body, style: styleBodySoft),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 13 — Footer
// ===========================================================================

Widget footerSection() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    decoration: BoxDecoration(
      color: paletteInk,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: paletteAccent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.zoom_out_map, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'InteractiveViewer — wraps any child for pan, scale and a controllable Matrix4 viewpoint.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                'Pair with a TransformationController to drive the view from code; switch to .builder for tile-pyramid content.',
                style: TextStyle(color: Color(0xFFB6BFCB), fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('flutter / widgets', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SHARED PRIMITIVES
// ===========================================================================

Widget sectionContainer({
  required String label,
  required String title,
  required String lead,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: paletteRule, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: paletteAccentSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: paletteAccentDeep,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(height: 1, width: 40, color: paletteRule),
          ],
        ),
        SizedBox(height: 10),
        Text(title, style: styleSectionTitle),
        SizedBox(height: 6),
        Text(lead, style: styleSectionLead),
        SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFBF8F0),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: paletteRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String l in lines)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              l.isEmpty ? ' ' : l,
              style: l.startsWith('//') ? styleCodeFaint : styleCode,
            ),
          ),
      ],
    ),
  );
}
