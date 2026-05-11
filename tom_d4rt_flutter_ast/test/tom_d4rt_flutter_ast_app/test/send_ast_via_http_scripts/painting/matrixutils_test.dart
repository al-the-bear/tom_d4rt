// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// =====================================================================
// MatrixUtils Visual Deep Demo
// =====================================================================
// A long, hand-authored reference catalogue for the MatrixUtils static
// helper class from package:flutter/rendering.dart. Every section is a
// rendered tableau — there is no main(), no runApp(), no test imports,
// and no StatefulWidget anywhere. The entry point is a single
// dynamic build(BuildContext context) function that returns a Widget.
// Everything is computed at build time and visualised through Stack +
// Positioned + CustomPaint primitives. The matrices themselves are
// shown as colour-coded 4x4 numerical grids so the reader can see the
// exact bytes that flow into each MatrixUtils call.
//
// MatrixUtils API surface (Flutter rendering library):
//   - MatrixUtils.transformPoint(Matrix4, Offset) -> Offset
//   - MatrixUtils.transformRect(Matrix4, Rect)    -> Rect
//   - MatrixUtils.inverseTransformRect(Matrix4, Rect) -> Rect
//   - MatrixUtils.getAsTranslation(Matrix4)       -> Offset?
//   - MatrixUtils.getAsScale(Matrix4)             -> double?
//   - MatrixUtils.matrixEquals(Matrix4?, Matrix4?) -> bool
//   - MatrixUtils.isIdentity(Matrix4)             -> bool
//   - MatrixUtils.cylindricalProjectionTransform(...) -> Matrix4
//   - MatrixUtils.forceToPoint(Offset)            -> Matrix4
//
// Theme: "Indigo Lattice" — deep indigo + lavender + carbon, with
// teal, mint, amber, and rose accents. The palette intentionally uses
// const Color literals so that the demo remains deterministic and
// safe to feed into the d4rt interpreter.
// =====================================================================
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

// =====================================================================
// Palette / typography constants
// =====================================================================
const Color _paperVoid = Color(0xFF0A0C18);
const Color _paperDeep = Color(0xFF11132A);
const Color _paperMid = Color(0xFF181B3C);
const Color _paperRise = Color(0xFF22265A);
const Color _paperFog = Color(0xFFE6E8F4);
const Color _paperBone = Color(0xFFF5F6FB);

const Color _inkBright = Color(0xFFF1F2FB);
const Color _inkMuted = Color(0xFFB1B6D6);
const Color _inkDim = Color(0xFF7B82AE);
const Color _inkFaint = Color(0xFF4A5085);

const Color _accIndigo = Color(0xFF6B5CF0);
const Color _accLavender = Color(0xFFAE99FF);
const Color _accSky = Color(0xFF6FB1FC);
const Color _accTeal = Color(0xFF3FCBC0);
const Color _accMint = Color(0xFF6FE0A9);
const Color _accAmber = Color(0xFFFFC36A);
const Color _accRose = Color(0xFFFF7AA2);
const Color _accMagenta = Color(0xFFC56CF0);

const Color _gridDim = Color(0xFF1F2244);
const Color _gridBright = Color(0xFF353A78);
const Color _borderDim = Color(0xFF272B58);
const Color _borderBright = Color(0xFF3D4490);

const Color _cellPositive = Color(0xFF1F4D3C);
const Color _cellNegative = Color(0xFF5C1F33);
const Color _cellZero = Color(0xFF22265A);
const Color _cellOne = Color(0xFF2D3C6B);

const TextStyle _tsTitle = TextStyle(
  color: _inkBright,
  fontSize: 22,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
);
const TextStyle _tsHeading = TextStyle(
  color: _inkBright,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.4,
);
const TextStyle _tsBody = TextStyle(
  color: _inkMuted,
  fontSize: 12,
  height: 1.35,
);
const TextStyle _tsMono = TextStyle(
  color: _inkBright,
  fontSize: 11,
  fontFamily: 'monospace',
  height: 1.3,
);
const TextStyle _tsMonoDim = TextStyle(
  color: _inkDim,
  fontSize: 10,
  fontFamily: 'monospace',
  height: 1.3,
);
const TextStyle _tsLabel = TextStyle(
  color: _inkMuted,
  fontSize: 10,
  letterSpacing: 1.4,
  fontWeight: FontWeight.w600,
);
const TextStyle _tsTiny = TextStyle(
  color: _inkDim,
  fontSize: 9,
  fontFamily: 'monospace',
);

// =====================================================================
// Local helpers (deterministic, build-time only)
// =====================================================================

// Reference a foundation.dart symbol so the import is actually used.
// kDebugMode is a compile-time constant and contributes no runtime cost.
const bool _kDemoDebug = kDebugMode;

String _fmt(double v) {
  if (v.isNaN) {
    return 'NaN';
  }
  if (v.isInfinite) {
    return v.isNegative ? '-Inf' : '+Inf';
  }
  if (v.abs() < 0.000001) {
    return '0.00';
  }
  return v.toStringAsFixed(2);
}

String _fmtOffset(Offset o) => '(${_fmt(o.dx)}, ${_fmt(o.dy)})';

String _fmtRect(Rect r) =>
    'LTRB(${_fmt(r.left)}, ${_fmt(r.top)}, ${_fmt(r.right)}, ${_fmt(r.bottom)})';

Color _cellColor(double v) {
  if (v.abs() < 0.000001) {
    return _cellZero;
  }
  if ((v - 1.0).abs() < 0.000001) {
    return _cellOne;
  }
  if (v < 0) {
    return _cellNegative;
  }
  return _cellPositive;
}

// A Matrix4 is stored column-major in package:vector_math. The
// MatrixUtils helpers honour that convention. We expose entries through
// the standard storage accessor.
double _m(Matrix4 m, int row, int col) {
  return m.storage[col * 4 + row];
}

// =====================================================================
// Reusable visual primitives
// =====================================================================

Widget _section({
  required String label,
  required String title,
  required String blurb,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
    decoration: BoxDecoration(
      color: _paperDeep,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _borderDim, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 22,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Text(label, style: _tsLabel.copyWith(color: accent)),
          ],
        ),
        const SizedBox(height: 8),
        Text(title, style: _tsTitle),
        const SizedBox(height: 6),
        Text(blurb, style: _tsBody),
        const SizedBox(height: 16),
        ...children,
      ],
    ),
  );
}

Widget _kvRow(String key, String value, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: Text(key, style: _tsMonoDim),
        ),
        Expanded(
          child: Text(
            value,
            style: _tsMono.copyWith(color: accent ?? _inkBright),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String text, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.18),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.6), width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: accent,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _identityRow(String label, bool isIdentity, Matrix4 m) {
  final Color tone = isIdentity ? _accMint : _accRose;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: tone.withOpacity(0.25),
            border: Border.all(color: tone, width: 1.0),
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.center,
          child: Text(
            isIdentity ? 'I' : 'x',
            style: TextStyle(
              color: tone,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(label, style: _tsMono),
        ),
        Text(isIdentity ? 'identity' : 'NOT identity',
            style: _tsMono.copyWith(color: tone)),
      ],
    ),
  );
}

Widget _divider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 14),
    height: 1,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0x00000000),
          _borderBright,
          Color(0x00000000),
        ],
      ),
    ),
  );
}

// =====================================================================
// Matrix4 grid renderer — colour-coded 4x4 numerical view
// =====================================================================
Widget _matrixGrid(Matrix4 m, {String? caption, Color? accent}) {
  final Color a = accent ?? _accIndigo;
  const double cell = 46.0;
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _paperMid,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _borderDim, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (caption != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(caption, style: _tsLabel.copyWith(color: a)),
          ),
        Column(
          children: List<Widget>.generate(4, (int row) {
            return Row(
              children: List<Widget>.generate(4, (int col) {
                final double v = _m(m, row, col);
                return Container(
                  width: cell,
                  height: cell,
                  margin: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _cellColor(v),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _borderDim,
                      width: 0.6,
                    ),
                  ),
                  child: Text(_fmt(v), style: _tsTiny),
                );
              }),
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            _chip('column-major', _accLavender),
            _chip('row 0..3', _accSky),
          ],
        ),
      ],
    ),
  );
}

// =====================================================================
// Coordinate grid painter — draws a 2D Cartesian grid with optional
// before/after sample points and a transformed quad.
// =====================================================================
class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.spacing,
    required this.beforePoints,
    required this.afterPoints,
    required this.beforeRect,
    required this.afterRect,
    required this.beforeColor,
    required this.afterColor,
    this.showAxes = true,
    this.beforeQuad,
    this.afterQuad,
  });

  final double spacing;
  final List<Offset> beforePoints;
  final List<Offset> afterPoints;
  final Rect? beforeRect;
  final Rect? afterRect;
  final Color beforeColor;
  final Color afterColor;
  final bool showAxes;
  final List<Offset>? beforeQuad;
  final List<Offset>? afterQuad;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _paperVoid;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint minor = Paint()
      ..color = _gridDim
      ..strokeWidth = 0.5;
    final Paint major = Paint()
      ..color = _gridBright
      ..strokeWidth = 0.8;

    final Offset origin = Offset(size.width / 2, size.height / 2);

    for (double x = origin.dx; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minor);
    }
    for (double x = origin.dx; x >= 0; x -= spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minor);
    }
    for (double y = origin.dy; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }
    for (double y = origin.dy; y >= 0; y -= spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }

    if (showAxes) {
      canvas.drawLine(
        Offset(0, origin.dy),
        Offset(size.width, origin.dy),
        major,
      );
      canvas.drawLine(
        Offset(origin.dx, 0),
        Offset(origin.dx, size.height),
        major,
      );
    }

    Offset toCanvas(Offset p) => Offset(origin.dx + p.dx, origin.dy + p.dy);

    if (beforeRect != null) {
      final Rect r = beforeRect!;
      final Paint rp = Paint()
        ..color = beforeColor.withOpacity(0.18)
        ..style = PaintingStyle.fill;
      final Paint rs = Paint()
        ..color = beforeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      final Rect canvasRect = Rect.fromLTRB(
        toCanvas(r.topLeft).dx,
        toCanvas(r.topLeft).dy,
        toCanvas(r.bottomRight).dx,
        toCanvas(r.bottomRight).dy,
      );
      canvas.drawRect(canvasRect, rp);
      canvas.drawRect(canvasRect, rs);
    }

    if (afterRect != null) {
      final Rect r = afterRect!;
      final Paint rp = Paint()
        ..color = afterColor.withOpacity(0.22)
        ..style = PaintingStyle.fill;
      final Paint rs = Paint()
        ..color = afterColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;
      final Rect canvasRect = Rect.fromLTRB(
        toCanvas(r.topLeft).dx,
        toCanvas(r.topLeft).dy,
        toCanvas(r.bottomRight).dx,
        toCanvas(r.bottomRight).dy,
      );
      canvas.drawRect(canvasRect, rp);
      canvas.drawRect(canvasRect, rs);
    }

    if (beforeQuad != null && beforeQuad!.length == 4) {
      final Path p = Path()..moveTo(
        toCanvas(beforeQuad![0]).dx,
        toCanvas(beforeQuad![0]).dy,
      );
      for (int i = 1; i < 4; i++) {
        p.lineTo(
          toCanvas(beforeQuad![i]).dx,
          toCanvas(beforeQuad![i]).dy,
        );
      }
      p.close();
      final Paint sp = Paint()
        ..color = beforeColor.withOpacity(0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawPath(p, sp);
    }

    if (afterQuad != null && afterQuad!.length == 4) {
      final Path p = Path()..moveTo(
        toCanvas(afterQuad![0]).dx,
        toCanvas(afterQuad![0]).dy,
      );
      for (int i = 1; i < 4; i++) {
        p.lineTo(
          toCanvas(afterQuad![i]).dx,
          toCanvas(afterQuad![i]).dy,
        );
      }
      p.close();
      final Paint sp = Paint()
        ..color = afterColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;
      canvas.drawPath(p, sp);
    }

    final Paint bpP = Paint()..color = beforeColor;
    for (final Offset p in beforePoints) {
      canvas.drawCircle(toCanvas(p), 3.4, bpP);
    }
    final Paint apP = Paint()..color = afterColor;
    for (final Offset p in afterPoints) {
      canvas.drawCircle(toCanvas(p), 4.0, apP);
    }

    final int n = beforePoints.length < afterPoints.length
        ? beforePoints.length
        : afterPoints.length;
    final Paint arrow = Paint()
      ..color = _accLavender.withOpacity(0.55)
      ..strokeWidth = 1.0;
    for (int i = 0; i < n; i++) {
      canvas.drawLine(
        toCanvas(beforePoints[i]),
        toCanvas(afterPoints[i]),
        arrow,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => true;
}

// =====================================================================
// Cylindrical card painter — renders a row of cards each transformed by
// MatrixUtils.cylindricalProjectionTransform to produce a CoverFlow-like
// effect. The matrices are computed at build time.
// =====================================================================
class _CardRowPainter extends CustomPainter {
  _CardRowPainter({
    required this.matrices,
    required this.labels,
    required this.accents,
  });

  final List<Matrix4> matrices;
  final List<String> labels;
  final List<Color> accents;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _paperVoid;
    canvas.drawRect(Offset.zero & size, bg);

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double cardW = size.width / (matrices.length.toDouble() + 1.0);
    final double cardH = cardW * 1.25;

    for (int i = 0; i < matrices.length; i++) {
      final Matrix4 m = matrices[i];
      final Color accent = accents[i % accents.length];
      final double offsetX = (i - (matrices.length - 1) / 2.0) * (cardW * 0.9);

      final Rect baseRect = Rect.fromCenter(
        center: Offset(center.dx + offsetX, center.dy),
        width: cardW,
        height: cardH,
      );

      final Rect projected = MatrixUtils.transformRect(m, baseRect);

      final Paint fill = Paint()
        ..color = accent.withOpacity(0.18)
        ..style = PaintingStyle.fill;
      final Paint stroke = Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;

      canvas.drawRRect(
        RRect.fromRectAndRadius(projected, const Radius.circular(8)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(projected, const Radius.circular(8)),
        stroke,
      );

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i % labels.length],
          style: TextStyle(
            color: accent,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          projected.center.dx - tp.width / 2,
          projected.center.dy - tp.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CardRowPainter old) => true;
}

// =====================================================================
// Build entry point
// =====================================================================
dynamic build(BuildContext context) {
  // ===================================================================
  // SECTION 0 — Dossier
  // ===================================================================
  // Construct the matrices we will reuse across the demo. Everything is
  // computed up-front so the rendering tree is pure layout afterwards.
  // ===================================================================

  final Matrix4 mIdentity = Matrix4.identity();
  final Matrix4 mTranslate = Matrix4.translationValues(60.0, -30.0, 0.0);
  final Matrix4 mTranslateZ = Matrix4.translationValues(60.0, -30.0, 25.0);
  final Matrix4 mScaleUniform = Matrix4.diagonal3Values(1.5, 1.5, 1.0);
  final Matrix4 mScaleNonUniform = Matrix4.diagonal3Values(2.0, 0.6, 1.0);
  final Matrix4 mScaleNegative = Matrix4.diagonal3Values(-1.0, 1.0, 1.0);
  final Matrix4 mRotate30 = Matrix4.rotationZ(pi / 6.0);
  final Matrix4 mRotate45 = Matrix4.rotationZ(pi / 4.0);
  final Matrix4 mRotate90 = Matrix4.rotationZ(pi / 2.0);
  final Matrix4 mRotateNeg30 = Matrix4.rotationZ(-pi / 6.0);
  final Matrix4 mShearX = Matrix4.identity()..setEntry(0, 1, 0.5);
  final Matrix4 mShearY = Matrix4.identity()..setEntry(1, 0, 0.5);
  final Matrix4 mShearXY = Matrix4.identity()
    ..setEntry(0, 1, 0.3)
    ..setEntry(1, 0, 0.3);

  // Composite: translate then rotate then scale.
  final Matrix4 mCompositeTRS = Matrix4.identity()
    ..translate(40.0, 20.0)
    ..rotateZ(pi / 8.0)
    ..scale(1.3, 1.3);

  // Composite in the opposite order — different visual outcome.
  final Matrix4 mCompositeSRT = Matrix4.identity()
    ..scale(1.3, 1.3)
    ..rotateZ(pi / 8.0)
    ..translate(40.0, 20.0);

  // Perspective matrix — small w-component coupling.
  final Matrix4 mPerspective = Matrix4.identity()..setEntry(3, 2, 0.0015);

  // Cylindrical projection samples for a card row.
  final List<double> cylAngles = <double>[
    -0.6,
    -0.3,
    0.0,
    0.3,
    0.6,
  ];
  final List<Matrix4> cylMatrices = <Matrix4>[
    for (final double a in cylAngles)
      MatrixUtils.createCylindricalProjectionTransform(
        radius: 120.0,
        angle: a,
        perspective: 0.0015,
      ),
  ];

  // forceToPoint — collapses everything to a single Offset.
  final Matrix4 mForce = MatrixUtils.forceToPoint(const Offset(40.0, 80.0));

  // ===================================================================
  // Sample geometry
  // ===================================================================
  final List<Offset> samplePoints = const <Offset>[
    Offset(40, 0),
    Offset(0, 40),
    Offset(-40, 0),
    Offset(0, -40),
    Offset(60, 60),
    Offset(-60, 60),
    Offset(-60, -60),
    Offset(60, -60),
  ];

  final Rect sampleRect = const Rect.fromLTWH(-40, -25, 80, 50);

  // ===================================================================
  // Pre-compute transformed points/rects for the visualisations.
  // ===================================================================

  List<Offset> applyAll(Matrix4 m, List<Offset> pts) =>
      <Offset>[for (final Offset p in pts) MatrixUtils.transformPoint(m, p)];

  final List<Offset> pTranslate = applyAll(mTranslate, samplePoints);
  final List<Offset> pScaleUni = applyAll(mScaleUniform, samplePoints);
  final List<Offset> pScaleNon = applyAll(mScaleNonUniform, samplePoints);
  final List<Offset> pScaleNeg = applyAll(mScaleNegative, samplePoints);
  final List<Offset> pRotate30 = applyAll(mRotate30, samplePoints);
  final List<Offset> pRotate45 = applyAll(mRotate45, samplePoints);
  final List<Offset> pRotate90 = applyAll(mRotate90, samplePoints);
  final List<Offset> pShearX = applyAll(mShearX, samplePoints);
  final List<Offset> pShearY = applyAll(mShearY, samplePoints);
  final List<Offset> pShearXY = applyAll(mShearXY, samplePoints);
  final List<Offset> pCompTRS = applyAll(mCompositeTRS, samplePoints);
  final List<Offset> pCompSRT = applyAll(mCompositeSRT, samplePoints);

  final Rect rTranslate = MatrixUtils.transformRect(mTranslate, sampleRect);
  final Rect rScaleUni = MatrixUtils.transformRect(mScaleUniform, sampleRect);
  final Rect rScaleNon =
      MatrixUtils.transformRect(mScaleNonUniform, sampleRect);
  final Rect rRotate30 = MatrixUtils.transformRect(mRotate30, sampleRect);
  final Rect rRotate45 = MatrixUtils.transformRect(mRotate45, sampleRect);
  final Rect rCompTRS = MatrixUtils.transformRect(mCompositeTRS, sampleRect);
  final Rect rCompSRT = MatrixUtils.transformRect(mCompositeSRT, sampleRect);

  // Rotated rect corners (for the "axis-aligned vs rotated AABB" demo)
  List<Offset> rectCorners(Rect r) => <Offset>[
        r.topLeft,
        r.topRight,
        r.bottomRight,
        r.bottomLeft,
      ];

  final List<Offset> rectCornersBefore = rectCorners(sampleRect);
  final List<Offset> rectCornersRot45 =
      applyAll(mRotate45, rectCornersBefore);

  // Inverse transform demonstration.
  final Rect inverseRect =
      MatrixUtils.inverseTransformRect(mCompositeTRS, rCompTRS);

  // getAsTranslation / getAsScale extraction probes.
  final Offset? extTransPure = MatrixUtils.getAsTranslation(mTranslate);
  final Offset? extTransRot = MatrixUtils.getAsTranslation(mRotate30);
  final Offset? extTransComp = MatrixUtils.getAsTranslation(mCompositeTRS);

  final double? extScaleId = MatrixUtils.getAsScale(mIdentity);
  final double? extScaleUni = MatrixUtils.getAsScale(mScaleUniform);
  final double? extScaleNon = MatrixUtils.getAsScale(mScaleNonUniform);
  final double? extScaleRot = MatrixUtils.getAsScale(mRotate30);
  final double? extScaleComp = MatrixUtils.getAsScale(mCompositeTRS);

  // isIdentity probes.
  final bool idId = MatrixUtils.isIdentity(mIdentity);
  final bool idTrans = MatrixUtils.isIdentity(mTranslate);
  final bool idRot = MatrixUtils.isIdentity(mRotate30);
  final bool idScale = MatrixUtils.isIdentity(mScaleUniform);
  final bool idForce = MatrixUtils.isIdentity(mForce);

  // matrixEquals probes.
  final bool eqSelf = MatrixUtils.matrixEquals(mTranslate, mTranslate);
  final bool eqClone = MatrixUtils.matrixEquals(
    mTranslate,
    Matrix4.translationValues(60.0, -30.0, 0.0),
  );
  final bool eqDiff = MatrixUtils.matrixEquals(mTranslate, mRotate30);
  final bool eqNull = MatrixUtils.matrixEquals(null, null);
  final bool eqNullLeft = MatrixUtils.matrixEquals(null, mIdentity);
  final bool eqNullRight = MatrixUtils.matrixEquals(mIdentity, null);

  // Raw Matrix4.transform3 vs MatrixUtils.transformPoint comparison.
  final Vector3 rawV = Vector3(40.0, 0.0, 0.0);
  final Vector3 rawTransformed = mCompositeTRS.transform3(rawV.clone());
  final Offset rawAsOffset = Offset(rawTransformed.x, rawTransformed.y);
  final Offset utilsAsOffset =
      MatrixUtils.transformPoint(mCompositeTRS, const Offset(40.0, 0.0));

  // ===================================================================
  // Build the widget tree.
  // ===================================================================
  return Directionality(
    textDirection: TextDirection.ltr,
    child: ColoredBox(
      color: _paperVoid,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // -----------------------------------------------------------
            // Banner
            // -----------------------------------------------------------
            Container(
              margin: const EdgeInsets.fromLTRB(24, 28, 24, 12),
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 26),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[_paperDeep, _paperMid, _paperRise],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _borderBright, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('MATRIXUTILS // INDIGO LATTICE',
                      style: _tsLabel.copyWith(color: _accLavender)),
                  const SizedBox(height: 6),
                  const Text(
                    'Visual Deep Demo for package:flutter/rendering.dart',
                    style: TextStyle(
                      color: _inkBright,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A hand-authored, build-time catalogue of the nine '
                    'static helpers exposed by MatrixUtils. Every '
                    'transformation is rendered as a coordinate-grid '
                    'before/after diagram alongside the colour-coded '
                    '4x4 numerical matrix that produced it. There is no '
                    'animation state, no test harness, and no main() — '
                    'just one build() function that returns a Widget.',
                    style: _tsBody,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    children: <Widget>[
                      _chip('transformPoint', _accIndigo),
                      _chip('transformRect', _accSky),
                      _chip('inverseTransformRect', _accTeal),
                      _chip('getAsScale', _accMint),
                      _chip('getAsTranslation', _accAmber),
                      _chip('isIdentity', _accLavender),
                      _chip('matrixEquals', _accRose),
                      _chip('cylindricalProjectionTransform', _accMagenta),
                      _chip('forceToPoint', _accSky),
                    ],
                  ),
                ],
              ),
            ),


            // ===========================================================
            // SECTION 1 — Dossier of MatrixUtils
            // ===========================================================
            _section(
              label: 'SECTION 01 // DOSSIER',
              title: 'What MatrixUtils Is and Why It Exists',
              blurb:
                  'MatrixUtils is a collection of free static helpers that '
                  'wraps the lower-level Matrix4 API from vector_math_64. '
                  'Its responsibility is to give the Flutter rendering '
                  'pipeline a single, fast, allocation-light surface for '
                  'point and rectangle transformation under 2D affine and '
                  '3D projective matrices, plus a handful of cheap probes '
                  '(isIdentity, matrixEquals, getAsScale, '
                  'getAsTranslation) that the layer compositor uses to '
                  'avoid unnecessary work.',
              accent: _accLavender,
              children: <Widget>[
                _kvRow('library', 'package:flutter/rendering.dart'),
                _kvRow('class', 'MatrixUtils (final, only static members)'),
                _kvRow('immutable', 'yes — no instance state'),
                _kvRow('alloc-heavy', 'no — Offset / Rect are value types'),
                _kvRow('used by',
                    'RenderObject.applyPaintTransform, Layer, '
                    'TransformLayer, hit-testing'),
                _divider(),
                Wrap(
                  children: <Widget>[
                    _chip('static-only', _accIndigo),
                    _chip('rendering-layer', _accSky),
                    _chip('hit-test friendly', _accMint),
                    _chip('column-major Matrix4', _accLavender),
                    _chip('2D-projected', _accAmber),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Mental model: MatrixUtils is the bridge between the '
                  '3D Matrix4 world (used by the rendering layers under '
                  'the hood) and the 2D Offset/Rect world that Flutter '
                  'widgets actually talk in. When a method takes an '
                  'Offset and returns an Offset, MatrixUtils silently '
                  'promotes the input to a 3D point with z = 0, runs '
                  'it through the matrix, performs the perspective '
                  'divide if the w-component changed, and demotes the '
                  'result back to 2D.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 2 — Anatomy of each method
            // ===========================================================
            _section(
              label: 'SECTION 02 // ANATOMY',
              title: 'Method Anatomy and Signatures',
              blurb:
                  'A reference card for every public method on '
                  'MatrixUtils, including what each one returns and the '
                  'shortcuts they take internally.',
              accent: _accIndigo,
              children: <Widget>[
                _kvRow(
                  'transformPoint',
                  'Matrix4 t, Offset p -> Offset (with /w divide)',
                  accent: _accIndigo,
                ),
                _kvRow(
                  'transformRect',
                  'Matrix4 t, Rect r -> Rect (axis-aligned bounding box)',
                  accent: _accSky,
                ),
                _kvRow(
                  'inverseTransformRect',
                  'Matrix4 t, Rect r -> Rect (uses t.copy()..invert())',
                  accent: _accTeal,
                ),
                _kvRow(
                  'getAsScale',
                  'Matrix4 t -> double? (only when uniform 2D scale)',
                  accent: _accMint,
                ),
                _kvRow(
                  'getAsTranslation',
                  'Matrix4 t -> Offset? (only when pure translation)',
                  accent: _accAmber,
                ),
                _kvRow(
                  'isIdentity',
                  'Matrix4 t -> bool (exact identity, no epsilon)',
                  accent: _accLavender,
                ),
                _kvRow(
                  'matrixEquals',
                  'Matrix4? a, Matrix4? b -> bool (null-safe equality)',
                  accent: _accRose,
                ),
                _kvRow(
                  'createCylindricalProjectionTransform',
                  '{radius, angle, perspective, orientation} -> Matrix4',
                  accent: _accMagenta,
                ),
                _kvRow(
                  'forceToPoint',
                  'Offset p -> Matrix4 (collapses everything to p)',
                  accent: _accSky,
                ),
                _divider(),
                const Text(
                  'Each helper has a fast-path optimisation. transformPoint '
                  'skips the /w divide when w == 1.0. transformRect '
                  'recognises pure translations and axis-aligned scales '
                  'so it can avoid transforming all four corners. '
                  'getAsScale and getAsTranslation return null on the '
                  'first sign of structure they cannot cheaply decompose, '
                  'which lets the caller fall back to a full matrix '
                  'product.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 3 — transformPoint demo (rotation / scale /
            // translation / shear)
            // ===========================================================
            _section(
              label: 'SECTION 03 // TRANSFORM POINT',
              title: 'transformPoint: 2D Affines as Point Mappings',
              blurb:
                  'MatrixUtils.transformPoint takes a Matrix4 and an '
                  'Offset, and returns the Offset that the matrix '
                  'produces when applied to the input (with z = 0). The '
                  'demos below visualise the original sample points '
                  'against their images under translation, uniform '
                  'scaling, non-uniform scaling, negative scaling '
                  '(reflection), four rotations, and three shears.',
              accent: _accIndigo,
              children: <Widget>[
                // Translation
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pTranslate,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accIndigo,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mTranslate,
                      caption: 'translate (60, -30)',
                      accent: _accIndigo,
                    ),
                  ],
                ),
                _divider(),
                // Uniform scale
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pScaleUni,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accMint,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mScaleUniform,
                      caption: 'scale (1.5, 1.5)',
                      accent: _accMint,
                    ),
                  ],
                ),
                _divider(),
                // Non-uniform scale
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pScaleNon,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accTeal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mScaleNonUniform,
                      caption: 'scale (2.0, 0.6)',
                      accent: _accTeal,
                    ),
                  ],
                ),
                _divider(),
                // Negative scale (reflection)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pScaleNeg,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accRose,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mScaleNegative,
                      caption: 'scale (-1.0, 1.0) reflection',
                      accent: _accRose,
                    ),
                  ],
                ),
                _divider(),
                // Rotation 30
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pRotate30,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accAmber,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mRotate30,
                      caption: 'rotateZ pi/6',
                      accent: _accAmber,
                    ),
                  ],
                ),
                _divider(),
                // Rotation 45
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pRotate45,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accSky,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mRotate45,
                      caption: 'rotateZ pi/4',
                      accent: _accSky,
                    ),
                  ],
                ),
                _divider(),
                // Rotation 90
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pRotate90,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accMagenta,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mRotate90,
                      caption: 'rotateZ pi/2',
                      accent: _accMagenta,
                    ),
                  ],
                ),
                _divider(),
                // Shear X
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pShearX,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accLavender,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mShearX,
                      caption: 'shear X (m01 = 0.5)',
                      accent: _accLavender,
                    ),
                  ],
                ),
                _divider(),
                // Shear Y
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pShearY,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accTeal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mShearY,
                      caption: 'shear Y (m10 = 0.5)',
                      accent: _accTeal,
                    ),
                  ],
                ),
                _divider(),
                // Shear XY
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pShearXY,
                            beforeRect: null,
                            afterRect: null,
                            beforeColor: _inkDim,
                            afterColor: _accAmber,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mShearXY,
                      caption: 'shear XY (m01=m10=0.3)',
                      accent: _accAmber,
                    ),
                  ],
                ),
                _divider(),
                const Text(
                  'Reading the diagrams: the dim grey dots are the input '
                  'sample points (an "asterisk" of eight outward '
                  'vectors). The coloured dots are the result of '
                  'transformPoint, drawn against the same coordinate '
                  'grid so you can compare distances and directions. The '
                  'lavender hairlines join each input to its image — '
                  'short hairlines mean the matrix barely moves that '
                  'point, long hairlines mean it moves a lot.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 4 — transformRect demo (axis-aligned vs rotated)
            // ===========================================================
            _section(
              label: 'SECTION 04 // TRANSFORM RECT',
              title: 'transformRect: Axis-Aligned vs Rotated Bounding Box',
              blurb:
                  'transformRect always returns an axis-aligned '
                  'rectangle. For pure translations and axis-aligned '
                  'scales this is exactly the image of the input rect. '
                  'For rotations and shears it is the *bounding box of '
                  'the image* — that is, the smallest axis-aligned rect '
                  'that contains all four transformed corners. The demos '
                  'below show both the bounding rect (filled) and the '
                  'rotated quad (outlined) so you can see how much '
                  'transformRect "overshoots" when the matrix is not '
                  'axis-aligned.',
              accent: _accSky,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 240,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: const <Offset>[],
                            afterPoints: const <Offset>[],
                            beforeRect: sampleRect,
                            afterRect: rTranslate,
                            beforeColor: _inkDim,
                            afterColor: _accIndigo,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: <Widget>[
                        _matrixGrid(
                          mTranslate,
                          caption: 'translate (60, -30)',
                          accent: _accIndigo,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _paperMid,
                            border: Border.all(color: _borderDim),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('in:  ${_fmtRect(sampleRect)}',
                                  style: _tsMono),
                              Text('out: ${_fmtRect(rTranslate)}',
                                  style: _tsMono.copyWith(color: _accIndigo)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 240,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: const <Offset>[],
                            afterPoints: const <Offset>[],
                            beforeRect: sampleRect,
                            afterRect: rScaleNon,
                            beforeColor: _inkDim,
                            afterColor: _accTeal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: <Widget>[
                        _matrixGrid(
                          mScaleNonUniform,
                          caption: 'scale (2.0, 0.6)',
                          accent: _accTeal,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _paperMid,
                            border: Border.all(color: _borderDim),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('in:  ${_fmtRect(sampleRect)}',
                                  style: _tsMono),
                              Text('out: ${_fmtRect(rScaleNon)}',
                                  style: _tsMono.copyWith(color: _accTeal)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _divider(),
                // Rotation 45 — show both AABB and rotated quad
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 260,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: const <Offset>[],
                            afterPoints: const <Offset>[],
                            beforeRect: sampleRect,
                            afterRect: rRotate45,
                            beforeColor: _inkDim,
                            afterColor: _accSky,
                            beforeQuad: rectCornersBefore,
                            afterQuad: rectCornersRot45,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: <Widget>[
                        _matrixGrid(
                          mRotate45,
                          caption: 'rotateZ pi/4',
                          accent: _accSky,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _paperMid,
                            border: Border.all(color: _borderDim),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('rotated quad outlines the real '
                                  'image of the rect.', style: _tsMonoDim),
                              const SizedBox(height: 4),
                              Text('AABB: ${_fmtRect(rRotate45)}',
                                  style: _tsMono.copyWith(color: _accSky)),
                              Text(
                                'corners[0]: '
                                '${_fmtOffset(rectCornersRot45[0])}',
                                style: _tsMono,
                              ),
                              Text(
                                'corners[1]: '
                                '${_fmtOffset(rectCornersRot45[1])}',
                                style: _tsMono,
                              ),
                              Text(
                                'corners[2]: '
                                '${_fmtOffset(rectCornersRot45[2])}',
                                style: _tsMono,
                              ),
                              Text(
                                'corners[3]: '
                                '${_fmtOffset(rectCornersRot45[3])}',
                                style: _tsMono,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _divider(),
                // Composite TRS vs SRT — order matters
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 240,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pCompTRS,
                            beforeRect: sampleRect,
                            afterRect: rCompTRS,
                            beforeColor: _inkDim,
                            afterColor: _accMint,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mCompositeTRS,
                      caption: 'T then R then S',
                      accent: _accMint,
                    ),
                  ],
                ),
                _divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 240,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: pCompSRT,
                            beforeRect: sampleRect,
                            afterRect: rCompSRT,
                            beforeColor: _inkDim,
                            afterColor: _accAmber,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mCompositeSRT,
                      caption: 'S then R then T',
                      accent: _accAmber,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Notice that the TRS and SRT composites are *not* the '
                  'same matrix: matrix multiplication is non-commutative, '
                  'and that asymmetry is one of the most common sources '
                  'of bugs in custom Flutter painting code. The two grids '
                  'differ in their last column (translation) precisely '
                  'because the translation is being scaled in SRT but '
                  'not in TRS.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 5 — getAsScale / getAsTranslation extraction
            // ===========================================================
            _section(
              label: 'SECTION 05 // EXTRACTION',
              title: 'getAsScale and getAsTranslation: Cheap Decomposition',
              blurb:
                  'These two helpers return null for any matrix they '
                  'cannot quickly classify. getAsTranslation only '
                  'succeeds when the matrix is *exactly* a 2D '
                  'translation — its rotational and scale entries must '
                  'be identity. getAsScale only succeeds when the matrix '
                  'is *exactly* a uniform 2D scale (sx == sy, no '
                  'rotation, no translation, no perspective). These '
                  'shortcuts let the rendering pipeline avoid building '
                  'a full transform layer for the common cases.',
              accent: _accAmber,
              children: <Widget>[
                _kvRow('getAsTranslation(identity)',
                    '${MatrixUtils.getAsTranslation(mIdentity)}',
                    accent: _accLavender),
                _kvRow('getAsTranslation(translate(60,-30))',
                    '$extTransPure', accent: _accIndigo),
                _kvRow('getAsTranslation(translate w/ z=25)',
                    '${MatrixUtils.getAsTranslation(mTranslateZ)}',
                    accent: _inkDim),
                _kvRow('getAsTranslation(rotateZ 30°)',
                    '$extTransRot', accent: _accRose),
                _kvRow('getAsTranslation(TRS composite)',
                    '$extTransComp', accent: _accRose),
                _divider(),
                _kvRow('getAsScale(identity)', '$extScaleId',
                    accent: _accMint),
                _kvRow('getAsScale(scale 1.5)', '$extScaleUni',
                    accent: _accMint),
                _kvRow('getAsScale(scale 2.0, 0.6)', '$extScaleNon',
                    accent: _accRose),
                _kvRow('getAsScale(rotateZ 30°)', '$extScaleRot',
                    accent: _accRose),
                _kvRow('getAsScale(TRS composite)', '$extScaleComp',
                    accent: _accRose),
                _divider(),
                const Text(
                  'Rule of thumb: if your downstream code needs to know '
                  '"is this just a translation?" or "is this just a '
                  'uniform zoom?", check these helpers first. Both '
                  'return null in roughly O(1) cell comparisons. A null '
                  'result is *not* an error — it just means the matrix '
                  'has more structure than the helper can summarise as '
                  'a single Offset or scalar.',
                  style: _tsBody,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _matrixGrid(
                      mTranslate,
                      caption: 'translation-only',
                      accent: _accIndigo,
                    ),
                    const SizedBox(width: 10),
                    _matrixGrid(
                      mScaleUniform,
                      caption: 'uniform-scale',
                      accent: _accMint,
                    ),
                    const SizedBox(width: 10),
                    _matrixGrid(
                      mCompositeTRS,
                      caption: 'TRS composite',
                      accent: _accAmber,
                    ),
                  ],
                ),
              ],
            ),

            // ===========================================================
            // SECTION 6 — isIdentity check matrix
            // ===========================================================
            _section(
              label: 'SECTION 06 // IDENTITY',
              title: 'isIdentity: The Cheapest Probe in the Toolbox',
              blurb:
                  'MatrixUtils.isIdentity walks the 16 cells and '
                  'returns true if and only if every cell matches the '
                  'corresponding cell of Matrix4.identity. There is no '
                  'epsilon — even a 0.0001 perturbation will fail the '
                  'check. The rendering layer uses this method to skip '
                  'work entirely (no transform layer, no clip layer, '
                  'no extra bookkeeping) when a matrix is "morally '
                  'absent".',
              accent: _accLavender,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _paperMid,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderDim),
                  ),
                  child: Column(
                    children: <Widget>[
                      _identityRow('Matrix4.identity()', idId, mIdentity),
                      _identityRow('translate(60,-30)', idTrans,
                          mTranslate),
                      _identityRow('rotateZ(pi/6)', idRot, mRotate30),
                      _identityRow('scale(1.5,1.5)', idScale,
                          mScaleUniform),
                      _identityRow('forceToPoint(40,80)', idForce, mForce),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Even an "all zeros" matrix is not the identity — the '
                  'identity has 1.0 on the diagonal. forceToPoint is a '
                  'particularly informative non-identity: it has a row '
                  'of zeros, which is a strong signal that the matrix '
                  'collapses dimensionality.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 7 — matrixEquals null-safe comparison matrix
            // ===========================================================
            _section(
              label: 'SECTION 07 // EQUALS',
              title: 'matrixEquals: Null-Safe Structural Comparison',
              blurb:
                  'matrixEquals(a, b) returns true if a and b are both '
                  'null, both the same reference, or if every one of the '
                  'sixteen cells in a equals the corresponding cell in '
                  'b. Two distinct Matrix4 instances with identical '
                  'storage compare equal, which makes this the right '
                  'method to use when caching transforms across paint '
                  'cycles.',
              accent: _accRose,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _paperMid,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderDim),
                  ),
                  child: Column(
                    children: <Widget>[
                      _kvRow('equals(self, self)', '$eqSelf',
                          accent: eqSelf ? _accMint : _accRose),
                      _kvRow('equals(translate, clone(translate))',
                          '$eqClone',
                          accent: eqClone ? _accMint : _accRose),
                      _kvRow('equals(translate, rotate)', '$eqDiff',
                          accent: eqDiff ? _accMint : _accRose),
                      _kvRow('equals(null, null)', '$eqNull',
                          accent: eqNull ? _accMint : _accRose),
                      _kvRow('equals(null, identity)', '$eqNullLeft',
                          accent: eqNullLeft ? _accRose : _accMint),
                      _kvRow('equals(identity, null)', '$eqNullRight',
                          accent: eqNullRight ? _accRose : _accMint),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'matrixEquals does not use == on the Matrix4 objects '
                  'themselves — vector_math does not override equality '
                  'in a way that would make two structurally equal but '
                  'distinct matrices compare equal. That is why this '
                  'helper exists: it does the cell-by-cell comparison '
                  'so the rendering layer can reliably compare cached '
                  'and fresh matrices.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 8 — cylindricalProjectionTransform CoverFlow recipe
            // ===========================================================
            _section(
              label: 'SECTION 08 // CYLINDRICAL',
              title: 'createCylindricalProjectionTransform: CoverFlow Row',
              blurb:
                  'createCylindricalProjectionTransform builds a 3D '
                  'projection matrix as if the target rectangle was '
                  'glued to a cylinder of the given radius, rotated by '
                  'the given angle about either the vertical or '
                  'horizontal axis, and then projected through a small '
                  'perspective factor. The result is the matrix you '
                  'pass to Transform.byMatrix to get the classic '
                  'iTunes-style "CoverFlow" tilt. The row below applies '
                  'five different angles to the same card rectangle and '
                  'renders the projected results side by side.',
              accent: _accMagenta,
              children: <Widget>[
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: _paperVoid,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderDim),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomPaint(
                      painter: _CardRowPainter(
                        matrices: cylMatrices,
                        labels: const <String>[
                          '-0.6 rad',
                          '-0.3 rad',
                          '0.0 rad',
                          '+0.3 rad',
                          '+0.6 rad',
                        ],
                        accents: const <Color>[
                          _accRose,
                          _accAmber,
                          _accMint,
                          _accSky,
                          _accMagenta,
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    for (int i = 0; i < cylMatrices.length; i++)
                      _matrixGrid(
                        cylMatrices[i],
                        caption: 'angle ${cylAngles[i].toStringAsFixed(2)} rad',
                        accent: <Color>[
                          _accRose,
                          _accAmber,
                          _accMint,
                          _accSky,
                          _accMagenta,
                        ][i],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Notice how the centre matrix (angle 0) is the '
                  'identity-with-perspective-row: it puts the card flat. '
                  'As the angle grows, two cells of the matrix swing in '
                  'sympathy — the (0,0) cell starts to shrink (cosine) '
                  'and the (2,0) cell turns on (sine), bending the card '
                  'into 3D before the perspective row collapses the '
                  'result back into screen space.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 9 — inverseTransformRect
            // ===========================================================
            _section(
              label: 'SECTION 09 // INVERSE',
              title: 'inverseTransformRect: Going Backwards Safely',
              blurb:
                  'inverseTransformRect inverts the matrix internally '
                  '(making a copy first, so the original is untouched) '
                  'and runs transformRect on the result. This is the '
                  'method to use when you have a rectangle in screen '
                  'coordinates and need to convert it back into the '
                  'untransformed local space — for example to hit-test '
                  'against the un-rotated child layout. If the matrix '
                  'is singular, the helper returns an infinite-area '
                  'rect, which is a signal that the inverse does not '
                  'exist.',
              accent: _accTeal,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 240,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: const <Offset>[],
                            afterPoints: const <Offset>[],
                            beforeRect: rCompTRS,
                            afterRect: inverseRect,
                            beforeColor: _accMint,
                            afterColor: _accTeal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: <Widget>[
                        _matrixGrid(
                          mCompositeTRS,
                          caption: 'TRS composite (used for inverse)',
                          accent: _accTeal,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _paperMid,
                            border: Border.all(color: _borderDim),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'forward TRS(sampleRect): '
                                '${_fmtRect(rCompTRS)}',
                                style: _tsMono.copyWith(color: _accMint),
                              ),
                              Text(
                                'inverseTRS(TRS(sampleRect)): '
                                '${_fmtRect(inverseRect)}',
                                style: _tsMono.copyWith(color: _accTeal),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'original sampleRect: '
                                '${_fmtRect(sampleRect)}',
                                style: _tsMonoDim,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'For affine matrices, inverseTransformRect of '
                  'transformRect should round-trip cleanly. For matrices '
                  'with rotation the bounding-box inflation visible in '
                  'transformRect means the round-trip can grow the rect '
                  '— which is why the diagram above shows the recovered '
                  'rect a bit larger than the original.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 10 — forceToPoint
            // ===========================================================
            _section(
              label: 'SECTION 10 // FORCE TO POINT',
              title: 'forceToPoint: Collapsing All Inputs to a Single Offset',
              blurb:
                  'MatrixUtils.forceToPoint builds a singular matrix that '
                  'sends every input Offset to the same fixed Offset. '
                  'It is used by Flutter when a child has zero painting '
                  'extent but a hit-test should still resolve to a '
                  'sensible location (for example, to keep '
                  'GlobalKey-tracked subtrees from disappearing during '
                  'tear-down animations).',
              accent: _accSky,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _GridPainter(
                            spacing: 20,
                            beforePoints: samplePoints,
                            afterPoints: applyAll(mForce, samplePoints),
                            beforeRect: sampleRect,
                            afterRect: MatrixUtils.transformRect(
                              mForce,
                              sampleRect,
                            ),
                            beforeColor: _inkDim,
                            afterColor: _accSky,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _matrixGrid(
                      mForce,
                      caption: 'forceToPoint(40, 80)',
                      accent: _accSky,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _kvRow('isIdentity(force)', '$idForce',
                    accent: _accRose),
                _kvRow('getAsTranslation(force)',
                    '${MatrixUtils.getAsTranslation(mForce)}',
                    accent: _accRose),
                _kvRow('getAsScale(force)',
                    '${MatrixUtils.getAsScale(mForce)}', accent: _accRose),
                const SizedBox(height: 6),
                const Text(
                  'All eight sample points collapse onto the single '
                  'point (40, 80) — they overlap visually in the diagram '
                  'and the sample rect becomes a zero-extent rect at '
                  'the same location. Because this matrix has a row of '
                  'zeros, getAsScale and getAsTranslation correctly '
                  'return null: there is no meaningful 1D summary to '
                  'extract from a rank-deficient transform.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 11 — Common pitfalls
            // ===========================================================
            _section(
              label: 'SECTION 11 // PITFALLS',
              title: 'Common Pitfalls When Using MatrixUtils',
              blurb:
                  'A short field guide to the failure modes that show '
                  'up in production Flutter code. Each example pairs the '
                  '"smell" with the right fix.',
              accent: _accRose,
              children: <Widget>[
                _kvRow('Pitfall 01', 'Forgetting that transformRect '
                    'returns an AABB, not a rotated quad.',
                    accent: _accRose),
                _kvRow('Fix',
                    'Transform the four corners with transformPoint '
                    'and draw a quad if you need pixel-accurate edges.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 02', 'Building matrices in the wrong '
                    'order (TRS vs SRT).', accent: _accRose),
                _kvRow('Fix',
                    'Remember: a..translate(t)..rotate(r)..scale(s) '
                    'applies S first, then R, then T to a point '
                    '(left-multiplication semantics).',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 03',
                    'A small perspective entry (m32) silently '
                    'collapses points behind the camera.',
                    accent: _accRose),
                _kvRow('Fix',
                    'Clip your projected geometry to a safe z-range or '
                    'clamp the w-divide manually if you cannot trust '
                    'the inputs.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 04',
                    'Mutating an "identity" matrix with translate, then '
                    'reusing the same Matrix4.identity() instance.',
                    accent: _accRose),
                _kvRow('Fix',
                    'Always create a fresh Matrix4.identity() inside '
                    'each build call — Matrix4 is mutable.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 05',
                    'Comparing two Matrix4 instances with == and '
                    'expecting cell equality.',
                    accent: _accRose),
                _kvRow('Fix',
                    'Use MatrixUtils.matrixEquals — it is null-safe and '
                    'does the right structural comparison.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 06',
                    'Calling transformRect on a singular matrix and '
                    'expecting a finite rect back.',
                    accent: _accRose),
                _kvRow('Fix',
                    'Probe with isIdentity / getAsScale first, and '
                    'fall back to a special path for collapsed cases.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 07',
                    'Trying to inverseTransformRect a matrix that has '
                    'no inverse (det == 0).', accent: _accRose),
                _kvRow('Fix',
                    'inverseTransformRect returns a rect with infinite '
                    'extent — treat that as a "skip this hit-test" '
                    'sentinel.',
                    accent: _accMint),
                _divider(),
                _kvRow('Pitfall 08',
                    'Assuming getAsScale returns 1.0 for the identity '
                    'matrix — but you forgot a setEntry mutation '
                    'somewhere.', accent: _accRose),
                _kvRow('Fix',
                    'isIdentity + getAsScale together pinpoint the '
                    'mutation source.', accent: _accMint),
              ],
            ),

            // ===========================================================
            // SECTION 12 — Raw Matrix4.transform3 vs MatrixUtils
            // ===========================================================
            _section(
              label: 'SECTION 12 // COMPARISON',
              title: 'Raw Matrix4.transform3 vs MatrixUtils.transformPoint',
              blurb:
                  'When the matrix is purely 2D affine, the two routes '
                  'agree to within floating-point error. When the '
                  'matrix has perspective, MatrixUtils.transformPoint '
                  'performs the /w divide for you, while '
                  'Matrix4.transform3 does not — so you would have to '
                  'do it yourself if you went the raw route.',
              accent: _accIndigo,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _paperMid,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _borderDim),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('input Offset: (40, 0)', style: _tsMonoDim),
                      Text(
                        'Matrix4.transform3 -> Vector3'
                        '(${_fmt(rawTransformed.x)}, '
                        '${_fmt(rawTransformed.y)}, '
                        '${_fmt(rawTransformed.z)})',
                        style: _tsMono.copyWith(color: _accIndigo),
                      ),
                      Text(
                        'reduced as Offset(x, y): '
                        '${_fmtOffset(rawAsOffset)}',
                        style: _tsMono,
                      ),
                      Text(
                        'MatrixUtils.transformPoint result: '
                        '${_fmtOffset(utilsAsOffset)}',
                        style: _tsMono.copyWith(color: _accMint),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'delta: (${_fmt((rawAsOffset.dx - utilsAsOffset.dx))}, '
                        '${_fmt((rawAsOffset.dy - utilsAsOffset.dy))})',
                        style: _tsMonoDim,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'For pure affine matrices the delta is effectively '
                  'zero. Where they diverge is when the matrix has a '
                  'non-zero perspective row: then '
                  'MatrixUtils.transformPoint divides through by w, '
                  'while transform3 just returns the unscaled Vector3. '
                  'In short: if you are working in screen-space 2D, '
                  'always prefer MatrixUtils.',
                  style: _tsBody,
                ),
              ],
            ),

            // ===========================================================
            // SECTION 13 — Glossary
            // ===========================================================
            _section(
              label: 'SECTION 13 // GLOSSARY',
              title: 'Glossary of Terms',
              blurb:
                  'Short definitions for the vocabulary used throughout '
                  'this demo.',
              accent: _accLavender,
              children: <Widget>[
                _kvRow('Affine', 'A linear transform plus a translation; '
                    'preserves parallelism.'),
                _kvRow('AABB',
                    'Axis-Aligned Bounding Box — the smallest rect '
                    'containing a shape, with sides parallel to the '
                    'X and Y axes.'),
                _kvRow('Column-major',
                    'Storage order where m[col*4 + row] gives the cell '
                    'at (row, col); vector_math uses this.'),
                _kvRow('Determinant',
                    'A scalar derived from a matrix; non-zero means '
                    'invertible.'),
                _kvRow('Homogeneous',
                    'Promotes 3D points to 4D by appending w=1; lets '
                    'translation and projection ride in one matrix.'),
                _kvRow('Identity',
                    'The matrix that leaves all inputs unchanged: 1.0 '
                    'on the diagonal, 0.0 elsewhere.'),
                _kvRow('Perspective',
                    'A non-zero entry in the bottom row of the matrix; '
                    'forces the /w divide on output.'),
                _kvRow('Projective',
                    'Any matrix that is not purely affine — usually '
                    'one with perspective.'),
                _kvRow('Rank-deficient',
                    'A matrix whose rows or columns are linearly '
                    'dependent; cannot be inverted.'),
                _kvRow('Round-trip',
                    'Applying a transform and then its inverse; for '
                    'AABB-only Rects this is generally lossy under '
                    'rotation.'),
                _kvRow('Shear',
                    'A transform that slants the coordinate grid '
                    'without rotating axes.'),
                _kvRow('Singular',
                    'Same as "rank-deficient" — no inverse exists.'),
                _kvRow('Storage',
                    'The Float64List backing a Matrix4; 16 entries '
                    'laid out column-major.'),
              ],
            ),

            // ===========================================================
            // SECTION 14 — Recap
            // ===========================================================
            _section(
              label: 'SECTION 14 // RECAP',
              title: 'Recap and Recommended Patterns',
              blurb:
                  'A condensed checklist of "what to reach for, when".',
              accent: _accMint,
              children: <Widget>[
                _kvRow('Need a single transformed point?',
                    'MatrixUtils.transformPoint(matrix, offset)',
                    accent: _accIndigo),
                _kvRow('Need a transformed rect (AABB)?',
                    'MatrixUtils.transformRect(matrix, rect)',
                    accent: _accSky),
                _kvRow('Need to go back from screen-space to local?',
                    'MatrixUtils.inverseTransformRect(matrix, rect)',
                    accent: _accTeal),
                _kvRow('Need to know "is this just a zoom?"',
                    'MatrixUtils.getAsScale(matrix) != null '
                    '&& result is finite',
                    accent: _accMint),
                _kvRow('Need to know "is this just a slide?"',
                    'MatrixUtils.getAsTranslation(matrix) != null',
                    accent: _accAmber),
                _kvRow('Need to skip work when nothing happens?',
                    'MatrixUtils.isIdentity(matrix)',
                    accent: _accLavender),
                _kvRow('Need to compare two cached matrices?',
                    'MatrixUtils.matrixEquals(a, b)',
                    accent: _accRose),
                _kvRow('Need a CoverFlow-style 3D tilt?',
                    'MatrixUtils.createCylindricalProjectionTransform(...)',
                    accent: _accMagenta),
                _kvRow('Need to collapse a child to a single Offset?',
                    'MatrixUtils.forceToPoint(offset)',
                    accent: _accSky),
                const SizedBox(height: 10),
                const Text(
                  'Every MatrixUtils call is allocation-light and pure. '
                  'Use them as the first port of call inside any custom '
                  'RenderObject, CustomPainter, or hit-test routine.',
                  style: _tsBody,
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[_paperMid, _paperRise],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _borderBright, width: 1),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.bookmark_added,
                          color: _accLavender, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'End of MatrixUtils Indigo Lattice catalogue. '
                          'This document is hand-authored and rendered '
                          'entirely from a single build(context) entry '
                          'point — no main, no runApp, no animations, '
                          'no state.',
                          style: _tsBody.copyWith(color: _inkBright),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    ),
  );
}
