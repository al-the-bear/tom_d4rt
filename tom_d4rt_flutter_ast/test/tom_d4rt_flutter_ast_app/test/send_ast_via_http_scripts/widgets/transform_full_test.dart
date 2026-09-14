// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// Transform — Deep Demo (D4rt-AST sandbox renderer test script)
// ----------------------------------------------------------------------------
// Subject: package:flutter/widgets.dart -> Transform (and named ctors)
//
// The Transform widget family wraps a child with a 4x4 affine/perspective
// matrix. It is the single foundation for every visual gymnastic in
// Flutter — RotatedBox, scale animations, ListWheelScrollView's cylinder,
// hero flights, and shader perspectives all sit on top of Matrix4.
//
// This script paints a "plum + mustard + ivory" themed dashboard that
// walks every public ctor and key parameter:
//
//   - Transform(transform: Matrix4...)        // raw matrix
//   - Transform.rotate(angle: ...)            // 2D rotation
//   - Transform.scale(scale, scaleX, scaleY)  // uniform & asymmetric
//   - Transform.translate(offset: ...)        // pure translation
//   - Transform.flip(flipX, flipY)            // mirror flips
//   - alignment / origin                      // pivot control
//   - Matrix4.skewX / skewY                   // shears
//   - 3D perspective via setEntry(3,2,...)    // cylinder / card-flip
//
// SendTestRunner constraints honored:
//   * NO StatefulWidget / setState / animations / timers / futures.
//   * NO MaterialApp / Scaffold (single SingleChildScrollView root).
//   * Container uses BoxDecoration(color: ...) — never the `color:` shortcut
//     when `decoration:` is also present.
//   * Color.withValues(alpha: ...) for translucency.
//   * Indexed loops only (no for-in over bridged Flutter lists).
//   * Single top-level dynamic build(BuildContext) entry point.
// ============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PALETTE — "plum + mustard + ivory" theme.
// Hand-picked anchor colours used everywhere below.
// ---------------------------------------------------------------------------
const Color kPlumDeep = Color(0xFF4A1942);
const Color kPlumMid = Color(0xFF7B2A6B);
const Color kPlumSoft = Color(0xFFB667A6);
const Color kPlumWash = Color(0xFFE9D4E2);
const Color kMustard = Color(0xFFE2A93C);
const Color kMustardSoft = Color(0xFFF6D27A);
const Color kMustardWash = Color(0xFFFAEBC2);
const Color kIvory = Color(0xFFFAF6EC);
const Color kIvoryWarm = Color(0xFFF1E9D2);
const Color kInk = Color(0xFF1B1320);
const Color kInkSoft = Color(0xFF463A4D);
const Color kSlate = Color(0xFF6F6478);
const Color kAccentRose = Color(0xFFD96A8E);
const Color kAccentTeal = Color(0xFF3F8E8B);
const Color kAccentOlive = Color(0xFF6B8E3F);
const Color kAccentSky = Color(0xFF6FA3C7);
const Color kGridLine = Color(0xFFC9BFB4);
const Color kGridLineSoft = Color(0xFFE7DFD2);
const Color kDanger = Color(0xFFB23B3B);

// ---------------------------------------------------------------------------
// TEXT-STYLE HELPERS
// ---------------------------------------------------------------------------
TextStyle titleStyle({double size = 26, Color color = kIvory}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w900,
    color: color,
    letterSpacing: 0.8,
    height: 1.15,
  );
}

TextStyle headingStyle({double size = 20, Color color = kPlumDeep}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: 0.5,
  );
}

TextStyle subStyle({double size = 13, Color color = kInkSoft}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.2,
    height: 1.35,
  );
}

TextStyle bodyStyle({double size = 12, Color color = kInk}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
    height: 1.4,
  );
}

TextStyle monoStyle({double size = 11, Color color = kInk}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    fontFamily: 'monospace',
    color: color,
    letterSpacing: 0.0,
  );
}

TextStyle pillStyle({double size = 11, Color color = kIvory}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: 0.6,
  );
}

TextStyle captionStyle({double size = 10, Color color = kSlate}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.4,
  );
}

// ---------------------------------------------------------------------------
// DECORATION HELPERS
// ---------------------------------------------------------------------------
BoxShadow softPlumShadow() {
  return BoxShadow(
    color: kPlumDeep.withValues(alpha: 0.22),
    blurRadius: 18.0,
    offset: Offset(0.0, 8.0),
  );
}

BoxShadow softMustardShadow() {
  return BoxShadow(
    color: kMustard.withValues(alpha: 0.30),
    blurRadius: 14.0,
    offset: Offset(0.0, 6.0),
  );
}

BoxShadow tightShadow() {
  return BoxShadow(
    color: kInk.withValues(alpha: 0.18),
    blurRadius: 6.0,
    offset: Offset(0.0, 2.0),
  );
}

LinearGradient plumGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPlumDeep, kPlumMid, kPlumSoft],
  );
}

LinearGradient mustardGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kMustard, kMustardSoft],
  );
}

LinearGradient ivoryGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kIvory, kIvoryWarm],
  );
}

LinearGradient duoGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPlumMid, kMustard],
  );
}

LinearGradient roseGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kAccentRose, kPlumSoft],
  );
}

LinearGradient tealGradient() {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [kAccentTeal, kAccentSky],
  );
}

LinearGradient oliveGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kAccentOlive, kMustard],
  );
}

LinearGradient inkGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kInk, kInkSoft, kPlumDeep],
  );
}

// Format a Matrix4 cell for the anatomy grid.
String fmtCell(double v) {
  final s = v.toStringAsFixed(2);
  return s;
}

// Build a small "label pill" for tag-style annotations.
Widget pill(String text, Color bg, {Color fg = kIvory}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(text, style: pillStyle(color: fg)),
  );
}

// Build a small "code chip" for code-style annotations.
Widget codeChip(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: kInk.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: kPlumSoft, width: 1.0),
    ),
    child: Text(text, style: monoStyle(color: kMustardSoft)),
  );
}

// Build a checkered backdrop using nested Containers — useful so the eye
// can see exactly where a transformed child lands relative to the box.
Widget checkerBackdrop({
  required double width,
  required double height,
  required Widget child,
  Color a = kIvory,
  Color b = kIvoryWarm,
  int cols = 6,
  int rows = 6,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #137, P-math)
  // -------------------------------------------------------------------------
  // Baseline frameworkErrors=413: 354 × "A RenderFlex overflowed by 2.0
  // pixels on the right" + 59 × "A RenderFlex overflowed by 2.0 pixels on
  // the bottom" — exactly 7 asserts per checkerBackdrop call site × 59 call
  // sites (6 Row-right + 1 Column-bottom each).
  //
  // The outer Container declares `border: Border.all(width: 1.0)` which
  // consumes 2.0 px of inner content area (1 px on each side), but the
  // cell sizing computed `cellW = width / cols` and `cellH = height / rows`
  // — so the cumulative Row/Column dimensions equal the full outer width
  // and height. The Container's `clipBehavior: Clip.hardEdge` clipped the
  // painted pixels, but Flutter still asserted on the RenderFlex overflow
  // before clipping.
  //
  // The plan recipe label was P3 (OverflowBox), but the structural bug
  // here is a missed border-width subtraction in the math, not a
  // deliberately-overflowing pedagogical Row. Subtracting the 2.0 px
  // border (1 px per side) from both dimensions clears all 413 asserts
  // at once and gives the cells exactly the interior area they were
  // visually intended to fill.
  final cellW = (width - 2.0) / cols;
  final cellH = (height - 2.0) / rows;
  final List<Widget> rowsList = <Widget>[];
  for (int r = 0; r < rows; r = r + 1) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < cols; c = c + 1) {
      final bool even = ((r + c) % 2) == 0;
      cells.add(Container(
        width: cellW,
        height: cellH,
        decoration: BoxDecoration(color: even ? a : b),
      ));
    }
    rowsList.add(Row(mainAxisSize: MainAxisSize.min, children: cells));
  }
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: a,
      border: Border.all(color: kGridLine, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(mainAxisSize: MainAxisSize.min, children: rowsList),
        Center(child: child),
      ],
    ),
  );
}

// A vivid "tile" that we transform — it has a body and an arrow inside so
// rotations/flips are immediately legible.
Widget visTile({
  double width = 64.0,
  double height = 64.0,
  Color color = kPlumMid,
  String label = 'A',
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withValues(alpha: 0.65)],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: kIvory, width: 1.5),
      boxShadow: [tightShadow()],
    ),
    alignment: Alignment.topLeft,
    padding: EdgeInsets.all(6.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Arrow pointing up-right so rotations are visible.
        Positioned(
          left: 4.0,
          top: 4.0,
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: kIvory,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 4.0,
          bottom: 4.0,
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: kMustardSoft,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            color: kIvory,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CARD WRAPPER — every section sits inside one of these.
// ---------------------------------------------------------------------------
Widget sectionCard({
  required String number,
  required String title,
  required String subtitle,
  required Widget body,
  Color tag = kPlumMid,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    padding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 22.0),
    decoration: BoxDecoration(
      gradient: ivoryGradient(),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: kPlumSoft.withValues(alpha: 0.45), width: 1.0),
      boxShadow: [softPlumShadow()],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pill(number, tag),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(title, style: headingStyle()),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(subtitle, style: subStyle()),
        SizedBox(height: 16.0),
        body,
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  print('=== Transform Deep Demo executing ===');
  print('Sections: 10  | Constructors: 5  | Constraints: SendTestRunner-safe');

  // --------------------------------------------------------------------------
  // SECTION 1 — TITLE BANNER
  // --------------------------------------------------------------------------
  print('--- Section 1: Title banner ---');

  final titleBanner = Container(
    margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 6.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: plumGradient(),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: [softPlumShadow()],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative spinning glyphs as a visual hint at "transformation".
            Transform.rotate(
              angle: -0.35,
              child: Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: kMustard,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [softMustardShadow()],
                ),
                alignment: Alignment.center,
                child: Text('T',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: kPlumDeep,
                    )),
              ),
            ),
            SizedBox(width: 10.0),
            Transform.scale(
              scale: 1.15,
              child: Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: kAccentRose,
                  shape: BoxShape.circle,
                  boxShadow: [tightShadow()],
                ),
                alignment: Alignment.center,
                child: Text('R',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      color: kIvory,
                    )),
              ),
            ),
            SizedBox(width: 10.0),
            Transform(
              transform: Matrix4.skewX(-0.35),
              alignment: Alignment.center,
              child: Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: kAccentTeal,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [tightShadow()],
                ),
                alignment: Alignment.center,
                child: Text('S',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      color: kIvory,
                    )),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text('Transform — Deep Demo', style: titleStyle(size: 28.0)),
        SizedBox(height: 6.0),
        Text(
          'Every constructor, every parameter, every Matrix4 trick.',
          style: subStyle(color: kPlumWash, size: 14.0),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            pill('Transform()', kMustard, fg: kPlumDeep),
            pill('.rotate', kAccentRose),
            pill('.scale', kAccentTeal),
            pill('.translate', kAccentOlive),
            pill('.flip', kAccentSky, fg: kInk),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kIvory.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: kPlumWash.withValues(alpha: 0.5), width: 1.0),
          ),
          child: Text(
            'Transform wraps a child with a 4x4 matrix. The widget never '
            'changes layout — only the painted pixels move. Matrix4 stores '
            '16 doubles in column-major order; this demo tours each variant '
            'in 10 hand-crafted sections.',
            style: bodyStyle(color: kIvory, size: 12.5),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 2 — MATRIX4 ANATOMY (4x4 grid as a labeled diagram)
  // --------------------------------------------------------------------------
  print('--- Section 2: Matrix4 anatomy ---');

  // Build a sample Matrix4 that composes translate * rotate * scale.
  final Matrix4 anatomyMatrix = Matrix4.identity()
    ..translate(40.0, 20.0, 0.0)
    ..rotateZ(0.3)
    ..scale(1.4, 0.9, 1.0);

  final List<List<double>> rows4x4 = <List<double>>[];
  for (int r = 0; r < 4; r = r + 1) {
    final List<double> row = <double>[];
    for (int c = 0; c < 4; c = c + 1) {
      // Storage is column-major: storage[col*4 + row]
      row.add(anatomyMatrix.storage[c * 4 + r]);
    }
    rows4x4.add(row);
  }

  // Map every cell to a label describing its semantic role.
  final List<List<String>> roles = <List<String>>[
    <String>['Sx*cosθ', '-sinθ', 'persp.', 'Tx'],
    <String>['sinθ', 'Sy*cosθ', 'persp.', 'Ty'],
    <String>['skew', 'skew', 'Sz', 'Tz'],
    <String>['p0', 'p1', 'p2', 'w'],
  ];

  Widget anatomyCell(int r, int c) {
    final double v = rows4x4[r][c];
    final String role = roles[r][c];
    final bool diag = (r == c);
    final Color bg = diag ? kMustardWash : kIvory;
    final Color border = diag ? kMustard : kGridLine;
    return Container(
      width: 78.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(role, style: captionStyle(color: kPlumMid, size: 9.0)),
          SizedBox(height: 2.0),
          Center(child: Text(fmtCell(v), style: monoStyle(size: 12.0))),
        ],
      ),
    );
  }

  final List<Widget> matrixRows = <Widget>[];
  for (int r = 0; r < 4; r = r + 1) {
    final List<Widget> rowCells = <Widget>[];
    for (int c = 0; c < 4; c = c + 1) {
      rowCells.add(anatomyCell(r, c));
      if (c < 3) rowCells.add(SizedBox(width: 6.0));
    }
    matrixRows.add(Row(mainAxisSize: MainAxisSize.min, children: rowCells));
    if (r < 3) matrixRows.add(SizedBox(height: 6.0));
  }

  final anatomyBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: kPlumWash.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: matrixRows,
        ),
      ),
      SizedBox(height: 12.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 6.0,
        children: [
          pill('diag = scale', kMustard, fg: kPlumDeep),
          pill('col 4 = translate', kAccentTeal),
          pill('row 4 = perspective', kAccentRose),
          codeChip('Matrix4(...)..translate..rotateZ..scale'),
        ],
      ),
      SizedBox(height: 10.0),
      Text(
        'Storage is column-major — storage[c*4+r]. The Transform widget calls '
        'this matrix once per paint and feeds it to the layer tree.',
        style: subStyle(),
      ),
    ],
  );

  final section2 = sectionCard(
    number: '02',
    title: 'Matrix4 anatomy',
    subtitle: 'Sixteen doubles describing scale, rotation, translation '
        'and perspective.',
    tag: kPlumMid,
    body: anatomyBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 3 — ROTATION GALLERY (8 angles)
  // --------------------------------------------------------------------------
  print('--- Section 3: Rotation gallery ---');

  final List<double> rotAngles = <double>[
    0.0,
    math.pi / 8.0,
    math.pi / 4.0,
    math.pi / 3.0,
    math.pi / 2.0,
    2.0 * math.pi / 3.0,
    math.pi,
    -math.pi / 4.0,
  ];
  final List<String> rotLabels = <String>[
    '0',
    'π/8',
    'π/4',
    'π/3',
    'π/2',
    '2π/3',
    'π',
    '-π/4',
  ];
  final List<Color> rotColors = <Color>[
    kPlumDeep,
    kPlumMid,
    kAccentRose,
    kMustard,
    kAccentTeal,
    kAccentOlive,
    kAccentSky,
    kPlumSoft,
  ];

  final List<Widget> rotItems = <Widget>[];
  for (int i = 0; i < rotAngles.length; i = i + 1) {
    rotItems.add(Container(
      width: 110.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkerBackdrop(
            width: 92.0,
            height: 92.0,
            child: Transform.rotate(
              angle: rotAngles[i],
              child: visTile(
                width: 56.0,
                height: 56.0,
                color: rotColors[i],
                label: rotLabels[i],
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text('angle: ${rotLabels[i]}', style: monoStyle()),
          Text('${rotAngles[i].toStringAsFixed(3)} rad',
              style: captionStyle()),
        ],
      ),
    ));
  }

  final rotationBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: rotItems,
      ),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kMustardWash,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kMustard, width: 1.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pill('TIP', kPlumDeep),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Transform.rotate uses the Z axis. Multiply by π/180 to '
                'convert degrees. The pivot defaults to widget center.',
                style: subStyle(),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  final section3 = sectionCard(
    number: '03',
    title: 'Rotation gallery',
    subtitle: 'Eight angles around the Z axis — radians not degrees.',
    tag: kAccentRose,
    body: rotationBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 4 — SCALE GALLERY (uniform / asymmetric / negative)
  // --------------------------------------------------------------------------
  print('--- Section 4: Scale gallery ---');

  Widget scaleCell({
    required String label,
    required String code,
    required Widget transformed,
    Color accent = kAccentTeal,
  }) {
    return Container(
      width: 150.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, accent),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 120.0,
              height: 120.0,
              child: transformed,
            ),
          ),
          SizedBox(height: 8.0),
          codeChip(code),
        ],
      ),
    );
  }

  final List<Widget> scaleCells = <Widget>[
    scaleCell(
      label: 'UNIFORM 0.6',
      code: 'Transform.scale(scale: 0.6)',
      transformed: Transform.scale(
        scale: 0.6,
        child: visTile(color: kAccentTeal, label: '0.6'),
      ),
    ),
    scaleCell(
      label: 'UNIFORM 1.0',
      code: 'Transform.scale(scale: 1.0)',
      accent: kSlate,
      transformed: Transform.scale(
        scale: 1.0,
        child: visTile(color: kSlate, label: '1.0'),
      ),
    ),
    scaleCell(
      label: 'UNIFORM 1.4',
      code: 'Transform.scale(scale: 1.4)',
      accent: kAccentOlive,
      transformed: Transform.scale(
        scale: 1.4,
        child: visTile(color: kAccentOlive, label: '1.4'),
      ),
    ),
    scaleCell(
      label: 'WIDE',
      code: 'scaleX: 1.6, scaleY: 0.7',
      accent: kMustard,
      transformed: Transform.scale(
        scaleX: 1.6,
        scaleY: 0.7,
        child: visTile(color: kMustard, label: 'WX'),
      ),
    ),
    scaleCell(
      label: 'TALL',
      code: 'scaleX: 0.6, scaleY: 1.5',
      accent: kPlumMid,
      transformed: Transform.scale(
        scaleX: 0.6,
        scaleY: 1.5,
        child: visTile(color: kPlumMid, label: 'TY'),
      ),
    ),
    scaleCell(
      label: 'NEG X (mirror)',
      code: 'scaleX: -1.0',
      accent: kAccentRose,
      transformed: Transform.scale(
        scaleX: -1.0,
        scaleY: 1.0,
        child: visTile(color: kAccentRose, label: '←X'),
      ),
    ),
    scaleCell(
      label: 'NEG Y (flip)',
      code: 'scaleY: -1.0',
      accent: kAccentSky,
      transformed: Transform.scale(
        scaleX: 1.0,
        scaleY: -1.0,
        child: visTile(color: kAccentSky, label: '↑Y'),
      ),
    ),
    scaleCell(
      label: 'NEG BOTH (180°)',
      code: 'scale: -1.0',
      accent: kPlumDeep,
      transformed: Transform.scale(
        scale: -1.0,
        child: visTile(color: kPlumDeep, label: '180'),
      ),
    ),
  ];

  final scaleBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(spacing: 10.0, runSpacing: 10.0, children: scaleCells),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kPlumWash.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Negative scale on a single axis is a mirror; negative on both '
          'axes is mathematically equal to a 180° rotation. Use Transform.flip '
          'when intent is "mirror the artwork".',
          style: subStyle(),
        ),
      ),
    ],
  );

  final section4 = sectionCard(
    number: '04',
    title: 'Scale gallery',
    subtitle: 'Uniform, asymmetric, and negative scales — eight cases.',
    tag: kAccentTeal,
    body: scaleBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 5 — TRANSLATION GALLERY
  // --------------------------------------------------------------------------
  print('--- Section 5: Translation gallery ---');

  Widget translateCell({
    required Offset off,
    required Color color,
    required String label,
  }) {
    return Container(
      width: 160.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 130.0,
              height: 130.0,
              child: Transform.translate(
                offset: off,
                child: visTile(color: color, label: 'T'),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip('Offset(${off.dx.toStringAsFixed(0)}, '
              '${off.dy.toStringAsFixed(0)})'),
        ],
      ),
    );
  }

  final List<Widget> translateCells = <Widget>[
    translateCell(
        off: Offset(0.0, 0.0), color: kSlate, label: 'NO MOVE'),
    translateCell(
        off: Offset(20.0, 0.0), color: kAccentTeal, label: 'EAST'),
    translateCell(
        off: Offset(-20.0, 0.0), color: kAccentRose, label: 'WEST'),
    translateCell(
        off: Offset(0.0, -20.0), color: kAccentOlive, label: 'NORTH'),
    translateCell(
        off: Offset(0.0, 20.0), color: kPlumMid, label: 'SOUTH'),
    translateCell(
        off: Offset(15.0, 15.0), color: kMustard, label: 'SE'),
    translateCell(
        off: Offset(-15.0, 15.0), color: kAccentSky, label: 'SW'),
    translateCell(
        off: Offset(-25.0, -25.0), color: kPlumDeep, label: 'NW'),
  ];

  // A "before/after" composition: same tile, with and without translate.
  final beforeAfter = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: ivoryGradient(),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kGridLine, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('source', style: captionStyle()),
            SizedBox(height: 4.0),
            checkerBackdrop(
              width: 120.0,
              height: 120.0,
              child: visTile(color: kPlumMid, label: 'A'),
            ),
          ],
        ),
        SizedBox(width: 18.0),
        Container(
          width: 1.0,
          height: 130.0,
          color: kGridLine,
        ),
        SizedBox(width: 18.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('+ Offset(24, 12)', style: captionStyle()),
            SizedBox(height: 4.0),
            checkerBackdrop(
              width: 120.0,
              height: 120.0,
              child: Transform.translate(
                offset: Offset(24.0, 12.0),
                child: visTile(color: kPlumMid, label: 'A'),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final translationBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(spacing: 10.0, runSpacing: 10.0, children: translateCells),
      SizedBox(height: 14.0),
      beforeAfter,
      SizedBox(height: 10.0),
      Text(
        'Transform.translate moves only the painted layer — layout slot stays '
        'put. Wrap with Padding or Positioned if you want layout to follow.',
        style: subStyle(),
      ),
    ],
  );

  final section5 = sectionCard(
    number: '05',
    title: 'Translation gallery',
    subtitle: 'Pixel-shift the painted layer without disturbing layout.',
    tag: kAccentOlive,
    body: translationBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 6 — FLIP GALLERY (4 combos)
  // --------------------------------------------------------------------------
  print('--- Section 6: Flip gallery ---');

  Widget flipCell({
    required bool flipX,
    required bool flipY,
    required Color color,
  }) {
    final String label = 'X=$flipX  Y=$flipY';
    return Container(
      width: 160.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 130.0,
              height: 130.0,
              child: Transform.flip(
                flipX: flipX,
                flipY: flipY,
                child: Container(
                  width: 84.0,
                  height: 84.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: kIvory, width: 1.5),
                    boxShadow: [tightShadow()],
                  ),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(6.0),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.0,
                        top: 0.0,
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: kIvory,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: kMustardSoft,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'F',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w900,
                            color: kIvory,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip('Transform.flip(flipX: $flipX, flipY: $flipY)'),
        ],
      ),
    );
  }

  final List<Widget> flipCells = <Widget>[
    flipCell(flipX: false, flipY: false, color: kPlumMid),
    flipCell(flipX: true, flipY: false, color: kAccentTeal),
    flipCell(flipX: false, flipY: true, color: kAccentRose),
    flipCell(flipX: true, flipY: true, color: kPlumDeep),
  ];

  final flipBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(spacing: 10.0, runSpacing: 10.0, children: flipCells),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kMustardWash,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kMustard, width: 1.0),
        ),
        child: Text(
          'Transform.flip(flipX: true, flipY: true) is identical to a 180° '
          'rotation but reads more clearly as "mirror in both axes". The '
          'F glyph and corner dots make the orientation obvious.',
          style: subStyle(),
        ),
      ),
    ],
  );

  final section6 = sectionCard(
    number: '06',
    title: 'Flip gallery',
    subtitle: 'All four flipX/flipY combinations side-by-side.',
    tag: kAccentSky,
    body: flipBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 7 — SKEW GALLERY
  // --------------------------------------------------------------------------
  print('--- Section 7: Skew gallery ---');

  Widget skewCell({
    required String label,
    required Matrix4 matrix,
    required Color color,
    required String code,
  }) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 140.0,
              height: 130.0,
              child: Transform(
                transform: matrix,
                alignment: Alignment.center,
                child: visTile(color: color, label: 'Sk'),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip(code),
        ],
      ),
    );
  }

  final List<Widget> skewCells = <Widget>[
    skewCell(
      label: 'skewX +0.3',
      matrix: Matrix4.skewX(0.3),
      color: kPlumMid,
      code: 'Matrix4.skewX(0.3)',
    ),
    skewCell(
      label: 'skewX -0.3',
      matrix: Matrix4.skewX(-0.3),
      color: kAccentTeal,
      code: 'Matrix4.skewX(-0.3)',
    ),
    skewCell(
      label: 'skewY +0.3',
      matrix: Matrix4.skewY(0.3),
      color: kAccentRose,
      code: 'Matrix4.skewY(0.3)',
    ),
    skewCell(
      label: 'skewY -0.3',
      matrix: Matrix4.skewY(-0.3),
      color: kAccentOlive,
      code: 'Matrix4.skewY(-0.3)',
    ),
    skewCell(
      label: 'skew BOTH',
      matrix: Matrix4.skew(0.25, 0.18),
      color: kMustard,
      code: 'Matrix4.skew(0.25, 0.18)',
    ),
    skewCell(
      label: 'skewX EXTREME',
      matrix: Matrix4.skewX(0.55),
      color: kPlumDeep,
      code: 'Matrix4.skewX(0.55)',
    ),
  ];

  final skewBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(spacing: 10.0, runSpacing: 10.0, children: skewCells),
      SizedBox(height: 12.0),
      Text(
        'Skew is a shear — Matrix4.skewX(α) puts tan(α) into the (0,1) cell. '
        'Useful for italics emulation, parallelogram cards, and faux 3D '
        'when you do not want true perspective.',
        style: subStyle(),
      ),
    ],
  );

  final section7 = sectionCard(
    number: '07',
    title: 'Skew gallery',
    subtitle: 'Matrix4.skewX, skewY, and combined skews.',
    tag: kMustard,
    body: skewBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 8 — 3D PERSPECTIVE EXAMPLES
  // --------------------------------------------------------------------------
  print('--- Section 8: 3D perspective examples ---');

  Matrix4 perspective(double angleX, double angleY, double angleZ) {
    final Matrix4 m = Matrix4.identity()..setEntry(3, 2, 0.0015);
    if (angleX != 0.0) m.rotateX(angleX);
    if (angleY != 0.0) m.rotateY(angleY);
    if (angleZ != 0.0) m.rotateZ(angleZ);
    return m;
  }

  Widget perspectiveCell({
    required String label,
    required Matrix4 matrix,
    required Color color,
    required String code,
  }) {
    return Container(
      width: 180.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kIvory, kIvoryWarm],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 150.0,
              height: 150.0,
              child: Transform(
                transform: matrix,
                alignment: Alignment.center,
                child: Container(
                  width: 96.0,
                  height: 96.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, color.withValues(alpha: 0.55)],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kIvory, width: 2.0),
                    boxShadow: [tightShadow()],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '3D',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      color: kIvory,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip(code),
        ],
      ),
    );
  }

  final List<Widget> perspectiveCells = <Widget>[
    perspectiveCell(
      label: 'rotateX(0.4)',
      matrix: perspective(0.4, 0.0, 0.0),
      color: kPlumMid,
      code: '..setEntry(3,2,.0015)..rotateX(0.4)',
    ),
    perspectiveCell(
      label: 'rotateY(0.4)',
      matrix: perspective(0.0, 0.4, 0.0),
      color: kAccentTeal,
      code: '..setEntry(3,2,.0015)..rotateY(0.4)',
    ),
    perspectiveCell(
      label: 'rotateZ(0.4)',
      matrix: perspective(0.0, 0.0, 0.4),
      color: kAccentRose,
      code: '..setEntry(3,2,.0015)..rotateZ(0.4)',
    ),
    perspectiveCell(
      label: 'X+Y combo',
      matrix: perspective(0.35, 0.35, 0.0),
      color: kMustard,
      code: 'X(0.35) Y(0.35)',
    ),
    perspectiveCell(
      label: 'Y+Z combo',
      matrix: perspective(0.0, 0.45, 0.25),
      color: kAccentOlive,
      code: 'Y(0.45) Z(0.25)',
    ),
    perspectiveCell(
      label: 'X tilt strong',
      matrix: perspective(0.7, 0.0, 0.0),
      color: kAccentSky,
      code: 'rotateX(0.7)',
    ),
    perspectiveCell(
      label: 'Y flip half',
      matrix: perspective(0.0, math.pi / 2.5, 0.0),
      color: kPlumDeep,
      code: 'rotateY(π/2.5)',
    ),
    perspectiveCell(
      label: 'TRIPLE',
      matrix: perspective(0.25, 0.4, 0.2),
      color: kAccentRose,
      code: 'X(0.25) Y(0.4) Z(0.2)',
    ),
  ];

  final perspectiveBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: tealGradient(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pill('FORMULA', kIvory, fg: kAccentTeal),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Matrix4.identity()..setEntry(3, 2, 0.001..0.002)..rotateX/Y/Z'
                ' — the (3,2) entry adds w-divide perspective.',
                style: bodyStyle(color: kIvory),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.0),
      Wrap(spacing: 10.0, runSpacing: 10.0, children: perspectiveCells),
      SizedBox(height: 10.0),
      Text(
        'Larger setEntry values exaggerate the perspective. Card-flip widgets '
        'and ListWheelScrollView use the same trick under the hood.',
        style: subStyle(),
      ),
    ],
  );

  final section8 = sectionCard(
    number: '08',
    title: '3D perspective examples',
    subtitle: 'rotateX / rotateY / rotateZ on a perspective-enabled matrix.',
    tag: kAccentTeal,
    body: perspectiveBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 9 — ORIGIN AND ALIGNMENT EXPLORATION
  // --------------------------------------------------------------------------
  print('--- Section 9: Origin and alignment exploration ---');

  Widget alignCell({
    required String label,
    required Alignment alignment,
    required Color color,
  }) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 140.0,
              height: 140.0,
              child: Transform.rotate(
                angle: math.pi / 4.0,
                alignment: alignment,
                child: visTile(color: color, label: '↻'),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip('alignment: $label'),
        ],
      ),
    );
  }

  Widget originCell({
    required String label,
    required Offset origin,
    required Color color,
  }) {
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: kGridLineSoft, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(label, color),
          SizedBox(height: 8.0),
          Center(
            child: checkerBackdrop(
              width: 140.0,
              height: 140.0,
              child: Transform.rotate(
                angle: math.pi / 4.0,
                origin: origin,
                child: visTile(color: color, label: '↻'),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          codeChip('origin: Offset(${origin.dx.toStringAsFixed(0)}, '
              '${origin.dy.toStringAsFixed(0)})'),
        ],
      ),
    );
  }

  final List<Widget> alignmentCells = <Widget>[
    alignCell(
        label: 'topLeft', alignment: Alignment.topLeft, color: kPlumDeep),
    alignCell(
        label: 'topCenter',
        alignment: Alignment.topCenter,
        color: kPlumMid),
    alignCell(
        label: 'topRight',
        alignment: Alignment.topRight,
        color: kAccentRose),
    alignCell(
        label: 'centerLeft',
        alignment: Alignment.centerLeft,
        color: kAccentTeal),
    alignCell(
        label: 'center',
        alignment: Alignment.center,
        color: kMustard),
    alignCell(
        label: 'centerRight',
        alignment: Alignment.centerRight,
        color: kAccentOlive),
    alignCell(
        label: 'bottomLeft',
        alignment: Alignment.bottomLeft,
        color: kAccentSky),
    alignCell(
        label: 'bottomCenter',
        alignment: Alignment.bottomCenter,
        color: kPlumSoft),
    alignCell(
        label: 'bottomRight',
        alignment: Alignment.bottomRight,
        color: kPlumDeep),
  ];

  final List<Widget> originCells = <Widget>[
    originCell(
        label: 'origin (0,0)',
        origin: Offset(0.0, 0.0),
        color: kPlumMid),
    originCell(
        label: 'origin (32,0)',
        origin: Offset(32.0, 0.0),
        color: kAccentRose),
    originCell(
        label: 'origin (0,32)',
        origin: Offset(0.0, 32.0),
        color: kAccentTeal),
    originCell(
        label: 'origin (32,32)',
        origin: Offset(32.0, 32.0),
        color: kMustard),
    originCell(
        label: 'origin (-16,-16)',
        origin: Offset(-16.0, -16.0),
        color: kAccentOlive),
  ];

  final originBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kPlumWash.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'alignment chooses the pivot relative to the child bounds. '
          'origin chooses an absolute pixel pivot. If both are passed, '
          'origin is applied first, then alignment.',
          style: subStyle(),
        ),
      ),
      SizedBox(height: 12.0),
      Text('alignment ∈ Alignment.{top,center,bottom}{Left,Center,Right}',
          style: monoStyle(size: 12.0, color: kPlumDeep)),
      SizedBox(height: 8.0),
      Wrap(spacing: 10.0, runSpacing: 10.0, children: alignmentCells),
      SizedBox(height: 16.0),
      Text('origin ∈ Offset(...) — measured from the child top-left',
          style: monoStyle(size: 12.0, color: kPlumDeep)),
      SizedBox(height: 8.0),
      Wrap(spacing: 10.0, runSpacing: 10.0, children: originCells),
      SizedBox(height: 12.0),
      // Combined demonstration: alignment + origin together.
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: ivoryGradient(),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kGridLine, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Combined: alignment.center + origin Offset(20, 0)',
                style: monoStyle(size: 12.0)),
            SizedBox(height: 8.0),
            Center(
              child: checkerBackdrop(
                width: 180.0,
                height: 180.0,
                child: Transform.rotate(
                  angle: math.pi / 5.0,
                  alignment: Alignment.center,
                  origin: Offset(20.0, 0.0),
                  child: visTile(color: kPlumDeep, label: 'C+O'),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  final section9 = sectionCard(
    number: '09',
    title: 'Origin & alignment exploration',
    subtitle: 'How the pivot point reshapes a rotation.',
    tag: kPlumDeep,
    body: originBody,
  );

  // --------------------------------------------------------------------------
  // SECTION 10 — RECAP CARD
  // --------------------------------------------------------------------------
  print('--- Section 10: Recap card ---');

  Widget recapRow(String ctor, String purpose, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kIvory,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ctor, style: monoStyle(size: 13.0, color: kPlumDeep)),
                SizedBox(height: 2.0),
                Text(purpose, style: subStyle(size: 12.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final recapBody = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      recapRow('Transform(transform: Matrix4)',
          'Generic — accepts any 4x4 matrix.', kPlumDeep),
      recapRow('Transform.rotate(angle: ...)',
          'Single-axis Z rotation. Radians, not degrees.', kAccentRose),
      recapRow('Transform.scale(scale | scaleX, scaleY)',
          'Uniform or asymmetric scale around alignment.', kAccentTeal),
      recapRow('Transform.translate(offset: ...)',
          'Pure paint-only pixel shift.', kAccentOlive),
      recapRow('Transform.flip(flipX, flipY)',
          'Mirror across one or both axes.', kAccentSky),
      SizedBox(height: 8.0),
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: duoGradient(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('CHEAT SHEET',
                style: pillStyle(color: kIvory, size: 12.0)),
            SizedBox(height: 6.0),
            Text(
              '• Matrix4.identity() then mutate via cascade.\n'
              '• alignment is fractional; origin is absolute pixels.\n'
              '• setEntry(3, 2, 0.001) enables w-divide perspective.\n'
              '• Negative scale is mirror; double-negative is 180°.\n'
              '• Layout never changes — only painted output.',
              style: bodyStyle(color: kIvory, size: 12.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          pill('5 ctors', kPlumDeep),
          pill('10 sections', kAccentTeal),
          pill('plum + mustard + ivory', kMustard, fg: kPlumDeep),
          pill('SendTestRunner-safe', kAccentOlive),
          codeChip('Matrix4 == column-major'),
        ],
      ),
    ],
  );

  final section10 = sectionCard(
    number: '10',
    title: 'Recap',
    subtitle: 'Five constructors, one shared mental model — Matrix4.',
    tag: kMustard,
    body: recapBody,
  );

  // --------------------------------------------------------------------------
  // FINAL FOOTER STRIP
  // --------------------------------------------------------------------------
  final footer = Container(
    margin: EdgeInsets.fromLTRB(14.0, 6.0, 14.0, 18.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: inkGradient(),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [softPlumShadow()],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: math.pi / 6.0,
          child: Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: kMustard,
              borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.center,
            child: Text('✓',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: kPlumDeep,
                )),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            'End of Transform deep demo. Every visible box you saw above '
            'was a Container wrapped in a Transform — no animation, just '
            'static Matrix4 math.',
            style: bodyStyle(color: kIvory),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // ROOT — SingleChildScrollView -> Column with all sections.
  // --------------------------------------------------------------------------
  print('=== Transform Deep Demo build complete ===');

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(color: kIvoryWarm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          titleBanner,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
          footer,
        ],
      ),
    ),
  );
}
