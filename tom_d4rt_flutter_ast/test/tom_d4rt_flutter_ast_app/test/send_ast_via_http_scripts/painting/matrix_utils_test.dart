// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// MatrixUtils — Deep Demo (D4rt-AST sandbox renderer test script)
// ----------------------------------------------------------------------------
// Subject: package:flutter/painting.dart -> MatrixUtils
//
// MatrixUtils is the unsung hero behind Flutter's hit-testing, layer
// composition, RepaintBoundary clipping, and Transform widget rendering.
// It packs a handful of static helpers that operate on dart:ui's Matrix4
// (a column-major 4x4 affine/perspective transform).
//
// This script paints a "math/transform-grid" themed dashboard that walks
// through the public surface of MatrixUtils:
//
//   - transformPoint(matrix, point)        // map a single Offset
//   - transformRect(matrix, rect)          // bounding box of mapped corners
//   - inverseTransformRect(matrix, rect)   // inverse of the above
//   - getAsTranslation(matrix)             // Offset? if pure translation
//   - getAsScale(matrix)                   // double? if pure scale
//   - matrixEquals(a, b)                   // structural equality
//   - isIdentity(matrix)                   // identity probe
//   - forceToPoint(matrix, offset)         // collapse to translation-to-pt
//   - cylindricalProjectionTransform(...)  // 3D ListWheel-style projection
//   - createCylindricalProjectionTransform // factory variant
//
// Every section prints diagnostics (=4 prints minimum) and renders a
// chunk of UI that visualises the math.
//
// Constraints honored for the D4rt-AST sandbox:
//   * No setState / StatefulWidget / animations / timers / futures.
//   * Static snapshots only.
//   * Indexed loops over collections only — never `for-in` over a bridged
//     Flutter list.
//   * Single top-level build(BuildContext) entry point.
// ============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color palette — "math/transform-grid" theme.
// Ten distinct anchor colours used across all sections.
// ---------------------------------------------------------------------------
const Color kCobalt = Color(0xFF1E3A8A);
const Color kMagenta = Color(0xFFD946EF);
const Color kCyan = Color(0xFF06B6D4);
const Color kSlate = Color(0xFF334155);
const Color kCharcoal = Color(0xFF111827);
const Color kLemon = Color(0xFFFDE047);
const Color kAmber = Color(0xFFF59E0B);
const Color kEmerald = Color(0xFF10B981);
const Color kRose = Color(0xFFF43F5E);
const Color kIndigo = Color(0xFF6366F1);
const Color kPaper = Color(0xFFF8FAFC);
const Color kInk = Color(0xFF0B1220);
const Color kGridLine = Color(0xFF94A3B8);
const Color kGridLineSoft = Color(0xFFCBD5E1);

// ---------------------------------------------------------------------------
// Top-level helpers (no class subclasses, only free functions).
// ---------------------------------------------------------------------------

TextStyle headingStyle({double size = 22, Color color = kCharcoal}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: 0.6,
  );
}

TextStyle subStyle({double size = 13, Color color = kSlate}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.2,
  );
}

TextStyle monoStyle({double size = 12, Color color = kInk}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    fontFamily: 'monospace',
    color: color,
  );
}

BoxShadow softShadow({Color color = kCobalt, double blur = 18, double dy = 6}) {
  return BoxShadow(
    color: color.withOpacity(0.22),
    blurRadius: blur,
    offset: Offset(0, dy),
  );
}

BoxShadow hardShadow({Color color = kCharcoal, double blur = 4, double dy = 2}) {
  return BoxShadow(
    color: color.withOpacity(0.35),
    blurRadius: blur,
    offset: Offset(0, dy),
  );
}

LinearGradient paperGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPaper, Color(0xFFE2E8F0), kPaper],
    stops: [0.0, 0.5, 1.0],
  );
}

LinearGradient cobaltGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kCobalt, kIndigo, kMagenta],
  );
}

LinearGradient cyanGradient() {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [kCyan, kEmerald],
  );
}

LinearGradient lemonGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kLemon, kAmber],
  );
}

LinearGradient roseGradient() {
  return LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [kRose, kMagenta, kIndigo],
  );
}

LinearGradient slateGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kCharcoal, kSlate, kCobalt],
  );
}

RadialGradient halo({Color color = kCyan}) {
  return RadialGradient(
    radius: 0.95,
    colors: [color.withOpacity(0.55), color.withOpacity(0.0)],
  );
}

RadialGradient gridSpot() {
  return RadialGradient(
    radius: 0.7,
    colors: [kPaper, Color(0xFFE5E7EB)],
  );
}

// Format a Matrix4 storage row in fixed-width text.
String fmtRow(double a, double b, double c, double d) {
  String f(double v) {
    final s = v.toStringAsFixed(2);
    final pad = 7 - s.length;
    String out = s;
    for (int i = 0; i < pad; i = i + 1) {
      out = ' $out';
    }
    return out;
  }

  return '[${f(a)} ${f(b)} ${f(c)} ${f(d)}]';
}

String fmtOffset(Offset? o) {
  if (o == null) {
    return 'null';
  }
  return '(${o.dx.toStringAsFixed(2)}, ${o.dy.toStringAsFixed(2)})';
}

String fmtRect(Rect r) {
  return 'Rect(L=${r.left.toStringAsFixed(1)}, '
      'T=${r.top.toStringAsFixed(1)}, '
      'W=${r.width.toStringAsFixed(1)}, '
      'H=${r.height.toStringAsFixed(1)})';
}

// Print the four storage rows (column-major Matrix4 — but we re-arrange
// into row-major visual form for human eyes).
void dumpMatrix(String label, Matrix4 m) {
  // Matrix4 storage is column-major, so storage[0..3] = column 0 (m00,m10,m20,m30)
  // For a row-major display we need m_ij = storage[j*4 + i].
  final s = m.storage;
  print('  $label');
  print('    row0: ${fmtRow(s[0], s[4], s[8], s[12])}');
  print('    row1: ${fmtRow(s[1], s[5], s[9], s[13])}');
  print('    row2: ${fmtRow(s[2], s[6], s[10], s[14])}');
  print('    row3: ${fmtRow(s[3], s[7], s[11], s[15])}');
  print('    det=${m.determinant().toStringAsFixed(3)} '
      'identity=${MatrixUtils.isIdentity(m)}');
}

// ---------------------------------------------------------------------------
// Section builders — each returns a Widget chunk.
// ---------------------------------------------------------------------------

Widget sectionFrame({
  required String index,
  required String title,
  required String tagline,
  required Widget body,
  Color accent = kCobalt,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: paperGradient(),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: accent.withOpacity(0.35), width: 1.4),
      boxShadow: [
        softShadow(color: accent, blur: 22, dy: 8),
        hardShadow(),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: cobaltGradient(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [softShadow(color: accent, blur: 10, dy: 4)],
              ),
              child: Text(
                index,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: kPaper,
                ),
              ),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: headingStyle()),
                SizedBox(height: 2),
                Text(tagline, style: subStyle()),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          height: 1,
          decoration: BoxDecoration(gradient: cobaltGradient()),
        ),
        SizedBox(height: 16),
        body,
      ],
    ),
  );
}

// =========================================================================
// SECTION 0 — Anchor Matrix4 instances + diagnostics
// =========================================================================
Widget buildSection0() {
  print('==========================================================');
  print('Section 0 — Anchor matrices');
  print('==========================================================');

  final identity = Matrix4.identity();
  final translation = Matrix4.translationValues(80.0, -30.0, 0.0);
  final rotation = Matrix4.rotationZ(math.pi / 6);
  final scale = Matrix4.diagonal3Values(1.5, 0.75, 1.0);
  final shear = Matrix4.identity();
  shear.storage[4] = 0.40; // m01 (xy shear)
  shear.storage[1] = 0.15; // m10 (yx shear)
  final perspective = Matrix4.identity();
  perspective.storage[11] = 0.0015; // perspective W component

  print('Identity:');
  dumpMatrix('Matrix4.identity()', identity);
  print('Translation (80, -30):');
  dumpMatrix('Matrix4.translationValues(80, -30, 0)', translation);
  print('Rotation (pi/6 around Z):');
  dumpMatrix('Matrix4.rotationZ(pi/6)', rotation);
  print('Scale (1.5x, 0.75y):');
  dumpMatrix('Matrix4.diagonal3Values(1.5, 0.75, 1)', scale);
  print('Shear (xy=0.40, yx=0.15):');
  dumpMatrix('shear', shear);
  print('Perspective (m32=0.0015):');
  dumpMatrix('perspective', perspective);

  final rows = <Widget>[
    _matrixCard('Identity', identity, kCyan),
    _matrixCard('Translate', translation, kCobalt),
    _matrixCard('Rotate Z', rotation, kMagenta),
    _matrixCard('Scale', scale, kEmerald),
    _matrixCard('Shear', shear, kAmber),
    _matrixCard('Perspective', perspective, kRose),
  ];

  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: rows,
  );
}

Widget _matrixCard(String label, Matrix4 m, Color accent) {
  final s = m.storage;
  return Container(
    width: 220,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent, width: 1.2),
      boxShadow: [softShadow(color: accent, blur: 12, dy: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: kCharcoal,
                  fontSize: 14,
                )),
          ],
        ),
        SizedBox(height: 8),
        Text(fmtRow(s[0], s[4], s[8], s[12]), style: monoStyle()),
        Text(fmtRow(s[1], s[5], s[9], s[13]), style: monoStyle()),
        Text(fmtRow(s[2], s[6], s[10], s[14]), style: monoStyle()),
        Text(fmtRow(s[3], s[7], s[11], s[15]), style: monoStyle()),
        SizedBox(height: 6),
        Text('det = ${m.determinant().toStringAsFixed(3)}',
            style: subStyle(size: 11)),
        Text(
          'isIdentity = ${MatrixUtils.isIdentity(m)}',
          style: subStyle(size: 11),
        ),
      ],
    ),
  );
}

// =========================================================================
// SECTION 1 — Title banner
// =========================================================================
Widget buildSection1() {
  print('==========================================================');
  print('Section 1 — Title banner');
  print('==========================================================');
  print('Painting hero banner for MatrixUtils dashboard.');
  print('Theme: math/transform-grid.');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 26),
    decoration: BoxDecoration(
      gradient: cobaltGradient(),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        softShadow(color: kMagenta, blur: 28, dy: 12),
        softShadow(color: kCobalt, blur: 18, dy: 4),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: -20,
          top: -20,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: halo(color: kLemon),
            ),
          ),
        ),
        Positioned(
          left: -10,
          bottom: -30,
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: halo(color: kCyan),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: kPaper.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kPaper.withOpacity(0.55)),
                  ),
                  child: Text('package:flutter/painting.dart',
                      style: monoStyle(size: 11, color: kPaper)),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: kLemon,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('static utilities',
                      style: monoStyle(size: 11, color: kCharcoal)),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('MatrixUtils',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: kPaper,
                  letterSpacing: 1.2,
                )),
            SizedBox(height: 6),
            Text(
              'Transform points, rects and projections through Matrix4.',
              style: TextStyle(
                fontSize: 15,
                color: kPaper.withOpacity(0.92),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =========================================================================
// SECTION 2 — 4x4 Anatomy diagram
// =========================================================================
Widget buildSection2() {
  print('==========================================================');
  print('Section 2 — 4x4 Matrix anatomy');
  print('==========================================================');
  print('Cells visualised in row-major form for readability.');
  print('Storage in dart:ui Matrix4 is column-major (storage[col*4 + row]).');
  print('Translation lives in column 3, scale on the diagonal,');
  print('rotation/shear in the top-left 3x3 block, perspective in row 3.');

  // Build a 16-cell grid showing what each cell represents.
  final labels = <String>[
    'Sx',   'Shy',  'R02',  'Tx',
    'Shx',  'Sy',   'R12',  'Ty',
    'R20',  'R21',  'Sz',   'Tz',
    'P0',   'P1',   'P2',   'W',
  ];
  final descriptions = <String>[
    'X scale',  'X-shear',  'rot',     'X translate',
    'Y-shear',  'Y scale',  'rot',     'Y translate',
    'rot',      'rot',      'Z scale', 'Z translate',
    'persp',    'persp',    'persp',   'w divide',
  ];
  final palette = <Color>[
    kEmerald, kAmber,   kIndigo,  kCobalt,
    kAmber,   kEmerald, kIndigo,  kCobalt,
    kIndigo,  kIndigo,  kEmerald, kCobalt,
    kRose,    kRose,    kRose,    kMagenta,
  ];

  final rows = <Widget>[];
  for (int r = 0; r < 4; r = r + 1) {
    final cells = <Widget>[];
    for (int c = 0; c < 4; c = c + 1) {
      final idx = r * 4 + c;
      cells.add(_anatomyCell(labels[idx], descriptions[idx], palette[idx]));
    }
    rows.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: cells,
      ),
    ));
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(mainAxisSize: MainAxisSize.min, children: rows),
      SizedBox(width: 22),
      _anatomyLegend(),
    ],
  );
}

Widget _anatomyCell(String label, String description, Color color) {
  return Container(
    width: 78,
    height: 64,
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.14),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.1),
      boxShadow: [hardShadow(color: color, blur: 3, dy: 1)],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: monoStyle(size: 14, color: kCharcoal)),
        SizedBox(height: 2),
        Text(description, style: subStyle(size: 9, color: kSlate)),
      ],
    ),
  );
}

Widget _anatomyLegend() {
  final items = <List<dynamic>>[
    ['Scale (Sx, Sy, Sz)', kEmerald],
    ['Translate (Tx, Ty, Tz)', kCobalt],
    ['Rotation/Shear (3x3 block)', kIndigo],
    ['Shear amounts (Shx, Shy)', kAmber],
    ['Perspective (P0, P1, P2)', kRose],
    ['W divisor', kMagenta],
  ];
  final children = <Widget>[];
  for (int i = 0; i < items.length; i = i + 1) {
    final label = items[i][0] as String;
    final color = items[i][1] as Color;
    children.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: 8),
          Text(label, style: subStyle(size: 12)),
        ],
      ),
    ));
  }
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kGridLine, width: 1),
      boxShadow: [hardShadow()],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Legend', style: headingStyle(size: 14)),
        SizedBox(height: 8),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children),
      ],
    ),
  );
}

// =========================================================================
// SECTION 3 — transformPoint gallery
// =========================================================================
Widget buildSection3() {
  print('==========================================================');
  print('Section 3 — MatrixUtils.transformPoint');
  print('==========================================================');

  final points = <Offset>[
    Offset(0, 0),
    Offset(40, 0),
    Offset(0, 40),
    Offset(40, 40),
    Offset(20, 20),
    Offset(60, 10),
  ];

  final matrices = <List<dynamic>>[
    ['Translate(+50,+10)', Matrix4.translationValues(50, 10, 0), kCobalt],
    ['Scale(1.4)', Matrix4.diagonal3Values(1.4, 1.4, 1), kEmerald],
    ['RotateZ(30deg)', Matrix4.rotationZ(math.pi / 6), kMagenta],
    [
      'Shear(xy=0.5)',
      _shearMatrix(0.5, 0.0),
      kAmber,
    ],
  ];

  print('Source points:');
  for (int i = 0; i < points.length; i = i + 1) {
    print('  p[$i] = ${fmtOffset(points[i])}');
  }

  for (int i = 0; i < matrices.length; i = i + 1) {
    final name = matrices[i][0] as String;
    final m = matrices[i][1] as Matrix4;
    print('Applying $name:');
    for (int j = 0; j < points.length; j = j + 1) {
      final mapped = MatrixUtils.transformPoint(m, points[j]);
      print('  ${fmtOffset(points[j])} -> ${fmtOffset(mapped)}');
    }
  }

  final tiles = <Widget>[];
  for (int i = 0; i < matrices.length; i = i + 1) {
    final name = matrices[i][0] as String;
    final m = matrices[i][1] as Matrix4;
    final color = matrices[i][2] as Color;
    tiles.add(_pointTile(name, m, points, color));
  }

  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: tiles,
  );
}

Matrix4 _shearMatrix(double xy, double yx) {
  final m = Matrix4.identity();
  m.storage[4] = xy;
  m.storage[1] = yx;
  return m;
}

Widget _pointTile(String label, Matrix4 m, List<Offset> points, Color accent) {
  // Render a tile with a grid + dots before / after.
  final beforeDots = <Widget>[];
  final afterDots = <Widget>[];
  final lines = <Widget>[];
  for (int i = 0; i < points.length; i = i + 1) {
    final p = points[i];
    final t = MatrixUtils.transformPoint(m, p);
    beforeDots.add(Positioned(
      left: 16 + p.dx * 1.4,
      top: 16 + p.dy * 1.4,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: kSlate,
          shape: BoxShape.circle,
        ),
      ),
    ));
    afterDots.add(Positioned(
      left: 16 + t.dx * 1.4,
      top: 16 + t.dy * 1.4,
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: accent,
          shape: BoxShape.circle,
          boxShadow: [hardShadow(color: accent, blur: 4, dy: 1)],
        ),
      ),
    ));
    // Draw an arrow with a thin gradient container as the "line".
    final dx = (t.dx - p.dx) * 1.4;
    final dy = (t.dy - p.dy) * 1.4;
    final length = math.sqrt(dx * dx + dy * dy);
    final angle = math.atan2(dy, dx);
    if (length > 0.5) {
      lines.add(Positioned(
        left: 16 + p.dx * 1.4 + 4,
        top: 16 + p.dy * 1.4 + 4,
        child: Transform.rotate(
          alignment: Alignment.centerLeft,
          angle: angle,
          child: Container(
            width: length,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kSlate.withOpacity(0.7), accent],
              ),
            ),
          ),
        ),
      ));
    }
  }

  final stackChildren = <Widget>[];
  stackChildren.add(_grid(180, 140));
  for (int i = 0; i < lines.length; i = i + 1) {
    stackChildren.add(lines[i]);
  }
  for (int i = 0; i < beforeDots.length; i = i + 1) {
    stackChildren.add(beforeDots[i]);
  }
  for (int i = 0; i < afterDots.length; i = i + 1) {
    stackChildren.add(afterDots[i]);
  }

  return Container(
    width: 220,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: [softShadow(color: accent, blur: 14, dy: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: monoStyle(size: 12)),
        SizedBox(height: 6),
        Container(
          width: 200,
          height: 160,
          decoration: BoxDecoration(
            color: Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(children: stackChildren),
        ),
      ],
    ),
  );
}

Widget _grid(double width, double height) {
  // Draw a static reference grid via stacked thin containers.
  final lines = <Widget>[];
  for (int i = 0; i <= 8; i = i + 1) {
    final x = (width / 8) * i;
    lines.add(Positioned(
      left: x,
      top: 0,
      child: Container(
          width: 1, height: height, color: kGridLineSoft.withOpacity(0.7)),
    ));
  }
  for (int i = 0; i <= 6; i = i + 1) {
    final y = (height / 6) * i;
    lines.add(Positioned(
      left: 0,
      top: y,
      child: Container(
          width: width, height: 1, color: kGridLineSoft.withOpacity(0.7)),
    ));
  }
  return Stack(children: lines);
}

// =========================================================================
// SECTION 4 — transformRect (translate, scale, rotate, shear)
// =========================================================================
Widget buildSection4() {
  print('==========================================================');
  print('Section 4 — MatrixUtils.transformRect');
  print('==========================================================');

  final base = Rect.fromLTWH(20, 20, 80, 50);
  final cases = <List<dynamic>>[
    ['Translate', Matrix4.translationValues(40, 20, 0), kCobalt],
    ['Scale 1.5x', Matrix4.diagonal3Values(1.5, 1.5, 1), kEmerald],
    ['RotateZ 25deg', Matrix4.rotationZ(math.pi / 7.2), kMagenta],
    ['Shear', _shearMatrix(0.4, 0.1), kAmber],
  ];

  print('Base rect: ${fmtRect(base)}');
  for (int i = 0; i < cases.length; i = i + 1) {
    final name = cases[i][0] as String;
    final m = cases[i][1] as Matrix4;
    final out = MatrixUtils.transformRect(m, base);
    print('  $name -> ${fmtRect(out)}');
  }

  // Also demonstrate inverseTransformRect for the rotate case.
  final rotation = Matrix4.rotationZ(math.pi / 7.2);
  final rotated = MatrixUtils.transformRect(rotation, base);
  final inverse = Matrix4.inverted(rotation);
  final back = MatrixUtils.transformRect(inverse, rotated);
  print('Inverse transform demo:');
  print('  base=${fmtRect(base)}');
  print('  rotated bounds=${fmtRect(rotated)}');
  print('  rotated bounds run back through inverse=${fmtRect(back)}');

  final tiles = <Widget>[];
  for (int i = 0; i < cases.length; i = i + 1) {
    final name = cases[i][0] as String;
    final m = cases[i][1] as Matrix4;
    final accent = cases[i][2] as Color;
    final out = MatrixUtils.transformRect(m, base);
    tiles.add(_rectTile(name, base, out, accent));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(spacing: 14, runSpacing: 14, children: tiles),
      SizedBox(height: 14),
      _inverseRectExplainer(base, rotated, back),
    ],
  );
}

Widget _rectTile(String name, Rect base, Rect out, Color accent) {
  // Compute bounds covering both rects so we can place them in the same
  // visual frame (used to compute the offsets below).
  final minLeft = math.min(base.left, out.left);
  final minTop = math.min(base.top, out.top);
  return Container(
    width: 240,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: [softShadow(color: accent, blur: 14, dy: 5)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: monoStyle()),
        SizedBox(height: 6),
        Container(
          width: 220,
          height: 160,
          decoration: BoxDecoration(
            gradient: gridSpot(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              _grid(220, 160),
              Positioned(
                left: 10 + (base.left - minLeft),
                top: 10 + (base.top - minTop),
                child: Container(
                  width: base.width,
                  height: base.height,
                  decoration: BoxDecoration(
                    color: kSlate.withOpacity(0.20),
                    border: Border.all(color: kSlate, width: 1.2),
                  ),
                ),
              ),
              Positioned(
                left: 10 + (out.left - minLeft),
                top: 10 + (out.top - minTop),
                child: Container(
                  width: out.width,
                  height: out.height,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.25),
                    border: Border.all(color: accent, width: 1.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text('base : ${fmtRect(base)}', style: subStyle(size: 10)),
        Text('out  : ${fmtRect(out)}', style: subStyle(size: 10)),
      ],
    ),
  );
}

Widget _inverseRectExplainer(Rect base, Rect rotated, Rect back) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: cyanGradient(),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [softShadow(color: kCyan, blur: 14, dy: 4)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('inverseTransformRect(matrix, rect)',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: kPaper,
              fontSize: 16,
            )),
        SizedBox(height: 4),
        Text(
          'Equivalent to transformRect(matrix.inverted(), rect). Useful when '
          'translating between local and ancestor coordinate spaces during '
          'hit testing.',
          style: TextStyle(color: kPaper.withOpacity(0.95), fontSize: 12),
        ),
        SizedBox(height: 6),
        Text('base    : ${fmtRect(base)}',
            style: monoStyle(size: 11, color: kPaper)),
        Text('rotated : ${fmtRect(rotated)}',
            style: monoStyle(size: 11, color: kPaper)),
        Text('inverse : ${fmtRect(back)}',
            style: monoStyle(size: 11, color: kPaper)),
      ],
    ),
  );
}

// =========================================================================
// SECTION 5 — getAsTranslation / getAsScale diagnostics
// =========================================================================
Widget buildSection5() {
  print('==========================================================');
  print('Section 5 — getAsTranslation / getAsScale');
  print('==========================================================');

  final pureTranslate = Matrix4.translationValues(33, -17, 0);
  final pureScale = Matrix4.diagonal3Values(2, 2, 1);
  final mixed = Matrix4.identity();
  mixed.translateByDouble(10, 10, 0, 1);
  mixed.rotateZ(math.pi / 4);
  final scaleNonUniform = Matrix4.diagonal3Values(2, 3, 1);

  final samples = <List<dynamic>>[
    ['pure translate (33,-17)', pureTranslate],
    ['pure scale (2x2)', pureScale],
    ['translate + rotate', mixed],
    ['non-uniform scale (2,3)', scaleNonUniform],
  ];

  for (int i = 0; i < samples.length; i = i + 1) {
    final name = samples[i][0] as String;
    final m = samples[i][1] as Matrix4;
    final t = MatrixUtils.getAsTranslation(m);
    final s = MatrixUtils.getAsScale(m);
    print('Matrix: $name');
    print('  getAsTranslation -> ${fmtOffset(t)}');
    print('  getAsScale       -> $s');
    print('  isIdentity       -> ${MatrixUtils.isIdentity(m)}');
  }

  final cards = <Widget>[];
  for (int i = 0; i < samples.length; i = i + 1) {
    final name = samples[i][0] as String;
    final m = samples[i][1] as Matrix4;
    final t = MatrixUtils.getAsTranslation(m);
    final s = MatrixUtils.getAsScale(m);
    cards.add(_diagnosticCard(name, m, t, s));
  }
  return Wrap(spacing: 14, runSpacing: 14, children: cards);
}

Widget _diagnosticCard(String label, Matrix4 m, Offset? t, double? s) {
  final tColor = t == null ? kRose : kEmerald;
  final sColor = s == null ? kRose : kEmerald;
  return Container(
    width: 260,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: paperGradient(),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kCobalt.withOpacity(0.5), width: 1.2),
      boxShadow: [softShadow(color: kCobalt, blur: 14, dy: 5)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: headingStyle(size: 13)),
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _pill(
                'getAsTranslation',
                t == null ? 'null' : fmtOffset(t),
                tColor,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: _pill(
                'getAsScale',
                s == null ? 'null' : s.toStringAsFixed(2),
                sColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(fmtRow(m.storage[0], m.storage[4], m.storage[8], m.storage[12]),
            style: monoStyle(size: 11)),
        Text(fmtRow(m.storage[1], m.storage[5], m.storage[9], m.storage[13]),
            style: monoStyle(size: 11)),
        Text(fmtRow(m.storage[2], m.storage[6], m.storage[10], m.storage[14]),
            style: monoStyle(size: 11)),
        Text(fmtRow(m.storage[3], m.storage[7], m.storage[11], m.storage[15]),
            style: monoStyle(size: 11)),
      ],
    ),
  );
}

Widget _pill(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10, color: color, fontWeight: FontWeight.w800)),
        SizedBox(height: 3),
        Text(value, style: monoStyle(size: 12)),
      ],
    ),
  );
}

// =========================================================================
// SECTION 6 — matrixEquals (strict and tolerant via near-equal storage)
// =========================================================================
Widget buildSection6() {
  print('==========================================================');
  print('Section 6 — MatrixUtils.matrixEquals');
  print('==========================================================');

  final a = Matrix4.translationValues(10, 20, 0);
  final b = Matrix4.translationValues(10, 20, 0);
  final c = Matrix4.translationValues(10.0000001, 20, 0);
  final d = Matrix4.translationValues(11, 20, 0);

  final pairs = <List<dynamic>>[
    ['a vs b (identical)', a, b],
    ['a vs c (within fp epsilon)', a, c],
    ['a vs d (clearly different)', a, d],
    ['null vs b', null, b],
    ['null vs null', null, null],
  ];

  for (int i = 0; i < pairs.length; i = i + 1) {
    final label = pairs[i][0] as String;
    final ma = pairs[i][1] as Matrix4?;
    final mb = pairs[i][2] as Matrix4?;
    final eq = MatrixUtils.matrixEquals(ma, mb);
    print('  $label -> matrixEquals = $eq');
  }

  final rows = <Widget>[];
  for (int i = 0; i < pairs.length; i = i + 1) {
    final label = pairs[i][0] as String;
    final ma = pairs[i][1] as Matrix4?;
    final mb = pairs[i][2] as Matrix4?;
    final eq = MatrixUtils.matrixEquals(ma, mb);
    rows.add(_eqRow(label, ma, mb, eq));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: rows,
  );
}

Widget _eqRow(String label, Matrix4? a, Matrix4? b, bool eq) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaper,
      border: Border.all(color: eq ? kEmerald : kRose, width: 1.2),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        hardShadow(color: eq ? kEmerald : kRose, blur: 4, dy: 2),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: eq ? kEmerald : kRose,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: kCharcoal)),
              SizedBox(height: 4),
              Text('a = ${_summary(a)}', style: monoStyle(size: 11)),
              Text('b = ${_summary(b)}', style: monoStyle(size: 11)),
            ],
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: eq ? cyanGradient() : roseGradient(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(eq ? 'equal' : 'differ',
              style: TextStyle(
                  color: kPaper, fontWeight: FontWeight.w800, fontSize: 12)),
        ),
      ],
    ),
  );
}

String _summary(Matrix4? m) {
  if (m == null) {
    return 'null';
  }
  final t = MatrixUtils.getAsTranslation(m);
  final s = MatrixUtils.getAsScale(m);
  return 'tx=${fmtOffset(t)} sx=${s == null ? 'mixed' : s.toStringAsFixed(2)}';
}

// =========================================================================
// SECTION 7 — cylindricalProjectionTransform
// =========================================================================
Widget buildSection7() {
  print('==========================================================');
  print('Section 7 — MatrixUtils.createCylindricalProjectionTransform');
  print('==========================================================');

  final radius = 220.0;
  final perspective = 0.003;
  final positions = <double>[
    -1.0, -0.6, -0.3, 0.0, 0.3, 0.6, 1.0,
  ];

  print('radius=${radius.toStringAsFixed(1)} '
      'perspective=${perspective.toStringAsFixed(4)}');
  for (int i = 0; i < positions.length; i = i + 1) {
    final m = MatrixUtils.createCylindricalProjectionTransform(
      radius: radius,
      angle: positions[i],
      perspective: perspective,
    );
    print('  angle=${positions[i].toStringAsFixed(2)} det=${m.determinant().toStringAsFixed(3)}');
  }

  final cards = <Widget>[];
  for (int i = 0; i < positions.length; i = i + 1) {
    final angle = positions[i];
    final m = MatrixUtils.createCylindricalProjectionTransform(
      radius: radius,
      angle: angle,
      perspective: perspective,
    );
    final hue = i / positions.length;
    final tint = Color.lerp(kCobalt, kMagenta, hue)!;
    cards.add(Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Transform(
        alignment: Alignment.center,
        transform: m,
        child: Container(
          width: 70,
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [tint, tint.withOpacity(0.6)],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPaper, width: 2),
            boxShadow: [softShadow(color: tint, blur: 12, dy: 4)],
          ),
          alignment: Alignment.center,
          child: Text(angle.toStringAsFixed(1),
              style: TextStyle(
                  color: kPaper, fontWeight: FontWeight.w800, fontSize: 13)),
        ),
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 6),
    decoration: BoxDecoration(
      gradient: slateGradient(),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [softShadow(color: kCharcoal, blur: 16, dy: 6)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Row of cards through cylindricalProjectionTransform',
            style: TextStyle(
                color: kPaper, fontWeight: FontWeight.w800, fontSize: 14)),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: cards,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: kPaper.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kPaper.withOpacity(0.4)),
          ),
          child: Text(
            'radius=${radius.toStringAsFixed(0)}  '
            'perspective=${perspective.toStringAsFixed(4)}  '
            'angles=${positions.length}',
            style: monoStyle(size: 11, color: kPaper),
          ),
        ),
      ],
    ),
  );
}

// =========================================================================
// SECTION 8 — forceToPoint
// =========================================================================
Widget buildSection8() {
  print('==========================================================');
  print('Section 8 — MatrixUtils.forceToPoint');
  print('==========================================================');

  final probes = <Offset>[
    Offset(0, 0),
    Offset(50, 0),
    Offset(0, 80),
    Offset(120, 60),
  ];
  final target = Offset(140, 90);

  // Build a forced matrix that collapses every point onto target.
  // forceToPoint(offset) returns a fresh Matrix4 — it does not mutate.
  final m = MatrixUtils.forceToPoint(target);

  print('Target offset: ${fmtOffset(target)}');
  print('Matrix after forceToPoint:');
  dumpMatrix('  m', m);
  for (int i = 0; i < probes.length; i = i + 1) {
    final mapped = MatrixUtils.transformPoint(m, probes[i]);
    print('  ${fmtOffset(probes[i])} -> ${fmtOffset(mapped)}');
  }

  final dots = <Widget>[];
  for (int i = 0; i < probes.length; i = i + 1) {
    final p = probes[i];
    dots.add(Positioned(
      left: 20 + p.dx,
      top: 20 + p.dy,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: kSlate,
          shape: BoxShape.circle,
          border: Border.all(color: kPaper, width: 1.5),
        ),
      ),
    ));
  }
  // Lines from each probe to target.
  final lines = <Widget>[];
  for (int i = 0; i < probes.length; i = i + 1) {
    final p = probes[i];
    final dx = target.dx - p.dx;
    final dy = target.dy - p.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    final angle = math.atan2(dy, dx);
    lines.add(Positioned(
      left: 26 + p.dx,
      top: 26 + p.dy,
      child: Transform.rotate(
        alignment: Alignment.centerLeft,
        angle: angle,
        child: Container(
          width: length,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kRose.withOpacity(0.85), kMagenta],
            ),
          ),
        ),
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kRose, width: 1.4),
      boxShadow: [softShadow(color: kRose, blur: 14, dy: 5)],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 280,
          height: 220,
          decoration: BoxDecoration(
            gradient: lemonGradient(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [softShadow(color: kAmber, blur: 10, dy: 4)],
          ),
          child: Stack(
            children: [
              _grid(280, 220),
              ...lines,
              ...dots,
              Positioned(
                left: 14 + target.dx,
                top: 14 + target.dy,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: kRose,
                    shape: BoxShape.circle,
                    border: Border.all(color: kPaper, width: 3),
                    boxShadow: [softShadow(color: kRose, blur: 12, dy: 4)],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 18),
        SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('forceToPoint(matrix, offset)', style: headingStyle(size: 16)),
              SizedBox(height: 6),
              Text(
                'Mutates the supplied matrix in-place so that any point '
                'transformed through it ends up at the supplied offset. '
                'Used internally by Flutter to force collapse degenerate '
                'transforms (e.g. an off-screen RenderObject) to a known '
                'safe location while keeping a valid Matrix4.',
                style: subStyle(size: 12),
              ),
              SizedBox(height: 10),
              Text('Probes:', style: headingStyle(size: 12)),
              for (int i = 0; i < probes.length; i = i + 1)
                Text(
                    '  ${fmtOffset(probes[i])} -> '
                    '${fmtOffset(MatrixUtils.transformPoint(m, probes[i]))}',
                    style: monoStyle(size: 11)),
              SizedBox(height: 8),
              Text('Target: ${fmtOffset(target)}',
                  style: monoStyle(size: 12, color: kRose)),
            ],
          ),
        ),
      ],
    ),
  );
}

// =========================================================================
// SECTION 9 — Cheat sheet
// =========================================================================
Widget buildSection9() {
  print('==========================================================');
  print('Section 9 — Cheat sheet');
  print('==========================================================');
  print('Building cheat sheet card.');
  print('Summarises every MatrixUtils API touched in this dashboard.');
  print('Useful as a print-out next to the editor.');

  final entries = <List<String>>[
    [
      'transformPoint(matrix, point)',
      'Run an Offset through Matrix4 and return the projected Offset.',
    ],
    [
      'transformRect(matrix, rect)',
      'Bounding box of all four mapped corners. Cheap for hit-testing.',
    ],
    [
      'inverseTransformRect(matrix, rect)',
      'Equivalent to transformRect(inverted(matrix), rect).',
    ],
    [
      'getAsTranslation(matrix)',
      'Returns Offset if the matrix is a pure translation, else null.',
    ],
    [
      'getAsScale(matrix)',
      'Returns the scalar scale factor if matrix is a pure uniform scale.',
    ],
    [
      'matrixEquals(a, b)',
      'True if both matrices share the same storage (handles nulls).',
    ],
    [
      'isIdentity(matrix)',
      'Fast path check before applying a transform; quick to bail out.',
    ],
    [
      'forceToPoint(offset)',
      'Returns a fresh Matrix4 that maps every point to the offset.',
    ],
    [
      'createCylindricalProjectionTransform(radius, angle, perspective)',
      'Factory that yields the Matrix4 used by ListWheelScrollView.',
    ],
    [
      'cylindricalProjectionTransform',
      'Internal helper that builds the projection given orientation flags.',
    ],
  ];

  final rows = <Widget>[];
  for (int i = 0; i < entries.length; i = i + 1) {
    final api = entries[i][0];
    final blurb = entries[i][1];
    rows.add(Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kIndigo.withOpacity(0.4), width: 1),
        boxShadow: [hardShadow(color: kIndigo, blur: 3, dy: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(api, style: monoStyle(size: 12, color: kCobalt)),
          SizedBox(height: 2),
          Text(blurb, style: subStyle(size: 11)),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: roseGradient(),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        softShadow(color: kMagenta, blur: 18, dy: 6),
        softShadow(color: kCobalt, blur: 12, dy: 3),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPaper,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [hardShadow()],
              ),
              child: Text('M',
                  style: TextStyle(
                      color: kCobalt,
                      fontWeight: FontWeight.w900,
                      fontSize: 22)),
            ),
            SizedBox(width: 12),
            Text('MatrixUtils Cheat Sheet',
                style: TextStyle(
                    color: kPaper,
                    fontSize: 20,
                    fontWeight: FontWeight.w900)),
          ],
        ),
        SizedBox(height: 14),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: rows),
      ],
    ),
  );
}

// =========================================================================
// build() — top-level entry point for the D4rt-AST sandbox renderer.
// =========================================================================
dynamic build(BuildContext context) {
  print('############################################################');
  print('# MatrixUtils Deep Demo — script entry');
  print('############################################################');
  print('Date: 2026-05-05  theme: math/transform-grid');
  print('Sections: 0 anchor matrices, 1 banner, 2 anatomy,');
  print('          3 transformPoint, 4 transformRect,');
  print('          5 getAsTranslation/getAsScale, 6 matrixEquals,');
  print('          7 cylindricalProjection, 8 forceToPoint, 9 cheat sheet.');

  return Container(
    width: double.infinity,
    color: kPaper,
    padding: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        sectionFrame(
          index: '1',
          title: 'MatrixUtils',
          tagline: 'Static helpers for Matrix4 transformations.',
          body: buildSection1(),
          accent: kCobalt,
        ),
        sectionFrame(
          index: '0',
          title: 'Anchor matrices',
          tagline: 'Identity, translate, rotate, scale, shear, perspective.',
          body: buildSection0(),
          accent: kCyan,
        ),
        sectionFrame(
          index: '2',
          title: '4x4 anatomy',
          tagline: 'Where translation, scale, rotation and perspective live.',
          body: buildSection2(),
          accent: kIndigo,
        ),
        sectionFrame(
          index: '3',
          title: 'transformPoint(matrix, point)',
          tagline: 'Map points and visualise before/after vectors.',
          body: buildSection3(),
          accent: kMagenta,
        ),
        sectionFrame(
          index: '4',
          title: 'transformRect / inverseTransformRect',
          tagline: 'Bounding-box of mapped corners — and going back.',
          body: buildSection4(),
          accent: kEmerald,
        ),
        sectionFrame(
          index: '5',
          title: 'getAsTranslation / getAsScale',
          tagline: 'Diagnostics — return null for non-pure transforms.',
          body: buildSection5(),
          accent: kAmber,
        ),
        sectionFrame(
          index: '6',
          title: 'matrixEquals',
          tagline: 'Structural equality across nullable matrices.',
          body: buildSection6(),
          accent: kSlate,
        ),
        sectionFrame(
          index: '7',
          title: 'cylindricalProjectionTransform',
          tagline: 'The math behind ListWheelScrollView.',
          body: buildSection7(),
          accent: kCharcoal,
        ),
        sectionFrame(
          index: '8',
          title: 'forceToPoint',
          tagline: 'Collapse a matrix to translate-only-to-target.',
          body: buildSection8(),
          accent: kRose,
        ),
        sectionFrame(
          index: '9',
          title: 'Cheat sheet',
          tagline: 'Pocket reference for daily Flutter debugging.',
          body: buildSection9(),
          accent: kIndigo,
        ),
        SizedBox(height: 24),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              gradient: slateGradient(),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [softShadow(color: kCharcoal, blur: 12, dy: 4)],
            ),
            child: Text(
              'end of MatrixUtils deep demo',
              style: TextStyle(
                color: kPaper,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
