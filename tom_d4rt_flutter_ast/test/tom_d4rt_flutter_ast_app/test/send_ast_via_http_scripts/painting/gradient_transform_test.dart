// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ============================================================================
// gradient_transform_test.dart
// ----------------------------------------------------------------------------
// A hand-authored visual deep demo for `GradientTransform` and its concrete
// subclass `GradientRotation`. We will also define our own subclasses of
// `GradientTransform` (Skew, Translate, Scale) and apply them to all three
// flavors of `Gradient` (LinearGradient, RadialGradient, SweepGradient).
//
// The goal of this file is purely educational: read top to bottom and you will
// have a strong intuition for what a gradient transform actually does, why it
// exists, what its constraints are, and how to author your own. The file is
// long on purpose -- we want a generous sandbox of variations rather than a
// terse demonstration.
//
// Run-time note: this file is meant to be picked up by the d4rt + flutter
// pipeline that sends ASTs over HTTP. There is no `main()`, no test imports,
// no StatefulWidget. The entry point is a top-level function:
//
//   dynamic build(BuildContext context) { return <a Widget>; }
//
// All the helpers below are pure functions that produce widgets.
// ============================================================================

// ============================================================================
// SECTION 1 -- DOSSIER
// ----------------------------------------------------------------------------
// What is a GradientTransform?
//
//   A `GradientTransform` is an abstract description of a 4x4 affine matrix
//   that is applied to the *gradient mapping*, not to the painted widget.
//   In other words, the geometry of the box stays the same -- but the
//   coordinate system used to evaluate the gradient color stops is rotated,
//   scaled, sheared, or translated.
//
//   The contract has exactly one method:
//
//       Matrix4? transform(Rect bounds, {TextDirection? textDirection});
//
//   - `bounds` is the rectangle the gradient is being painted into.
//   - `textDirection` is provided so a transform can be flipped for RTL.
//   - Returning `null` means "no transform" (identity is implied).
//
// The only concrete subclass shipped with Flutter is `GradientRotation`, which
// rotates the gradient mapping by a given number of radians, around the center
// of the bounds rectangle. Everything else you do yourself.
//
// Why does this matter?
//
//   Without `GradientTransform`, a `LinearGradient` is defined by `begin` and
//   `end` alignments and a `RadialGradient` by a `center`/`radius`/`focal`.
//   These are powerful but coarse: rotating a linear gradient by 13.7 degrees
//   would otherwise require trigonometry on `begin`/`end` and is fiddly.
//   `GradientTransform` does it for you, declaratively.
//
// Common pitfalls -- a preview:
//
//   1. The transform is applied per-paint, so it does NOT animate by itself.
//      To animate a transform you must rebuild the gradient or wrap it in an
//      AnimatedBuilder.
//   2. Translation in absolute pixels means the gradient *slides* underneath
//      the box. Often you want to translate in fractions of bounds.
//   3. A scale that goes through (0,0) anchors the gradient at the top-left.
//      To scale around the center, pre/post translate by half the bounds.
//   4. Skew + RadialGradient is visually surprising: the radius is still
//      measured in untransformed space, but the shape stretches.
// ============================================================================

// ============================================================================
// SECTION 2 -- ANATOMY
// ----------------------------------------------------------------------------
// The transform() method, dissected.
//
//   Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
//     // bounds.center is the natural pivot for "rotate around the middle".
//     // Build a 4x4 affine matrix in column-major order.
//     // Return null if you mean identity.
//   }
//
// The matrix you return is concatenated with whatever transform Flutter
// already uses to map the gradient's begin/end into the shader. The result is
// fed to the underlying SkSL gradient shader.
//
// `GradientRotation.transform` does exactly:
//   final double sinRadians = math.sin(radians);
//   final double cosRadians = math.cos(radians);
//   final double originX = bounds.center.dx;
//   final double originY = bounds.center.dy;
//   return Matrix4.identity()
//     ..translate(originX, originY)
//     ..multiply(Matrix4.rotationZ(radians))
//     ..translate(-originX, -originY);
//
// That is the canonical pattern: translate to pivot, do the thing, translate
// back. All of our custom subclasses below follow the same recipe.
// ============================================================================

// A re-usable color palette used throughout the demos.
const List<Color> kSunset = <Color>[
  Color(0xFF0D1B2A),
  Color(0xFF1B263B),
  Color(0xFF415A77),
  Color(0xFFE0E1DD),
  Color(0xFFFFB703),
  Color(0xFFFB8500),
  Color(0xFFD62828),
];

const List<Color> kRainbow = <Color>[
  Color(0xFFE53935),
  Color(0xFFFB8C00),
  Color(0xFFFDD835),
  Color(0xFF43A047),
  Color(0xFF1E88E5),
  Color(0xFF3949AB),
  Color(0xFF8E24AA),
];

const List<Color> kGlass = <Color>[
  Color(0xCCFFFFFF),
  Color(0x66FFFFFF),
  Color(0x11FFFFFF),
  Color(0x66FFFFFF),
  Color(0xCCFFFFFF),
];

const List<Color> kLava = <Color>[
  Color(0xFF1A0000),
  Color(0xFF4A0E0E),
  Color(0xFFB22222),
  Color(0xFFFF4500),
  Color(0xFFFFD700),
  Color(0xFFFFF8DC),
];

const List<Color> kOcean = <Color>[
  Color(0xFF03045E),
  Color(0xFF023E8A),
  Color(0xFF0077B6),
  Color(0xFF00B4D8),
  Color(0xFF90E0EF),
  Color(0xFFCAF0F8),
];

const List<Color> kForest = <Color>[
  Color(0xFF1B4332),
  Color(0xFF2D6A4F),
  Color(0xFF40916C),
  Color(0xFF52B788),
  Color(0xFF74C69D),
  Color(0xFF95D5B2),
];

// ============================================================================
// SECTION 3 -- CUSTOM SUBCLASSES OF GradientTransform
// ----------------------------------------------------------------------------
// These are deliberately tiny so you can read each one. They live at the top
// level so that the `build` function below can reference them freely.
// ============================================================================

/// Skews the gradient mapping by (alphaX, alphaY) radians, pivoted at the
/// center of the bounds.
@immutable
class SkewGradientTransform extends GradientTransform {
  const SkewGradientTransform(this.alphaX, this.alphaY);

  final double alphaX;
  final double alphaY;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    final Matrix4 skew = Matrix4.identity()
      ..setEntry(1, 0, math.tan(alphaX))
      ..setEntry(0, 1, math.tan(alphaY));
    return Matrix4.identity()
      ..translate(cx, cy)
      ..multiply(skew)
      ..translate(-cx, -cy);
  }

  @override
  String toString() => 'SkewGradientTransform(${alphaX.toStringAsFixed(2)}, '
      '${alphaY.toStringAsFixed(2)})';
}

/// Translates the gradient mapping by an offset given as a fraction of the
/// bounds (so dx=0.5 means "slide right by half the width").
@immutable
class TranslateGradientTransform extends GradientTransform {
  const TranslateGradientTransform(this.fractionX, this.fractionY);

  final double fractionX;
  final double fractionY;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double dx = fractionX * bounds.width;
    final double dy = fractionY * bounds.height;
    return Matrix4.identity()..translate(dx, dy);
  }

  @override
  String toString() => 'TranslateGradientTransform('
      '${fractionX.toStringAsFixed(2)}, ${fractionY.toStringAsFixed(2)})';
}

/// Scales the gradient mapping around the center of the bounds.
@immutable
class ScaleGradientTransform extends GradientTransform {
  const ScaleGradientTransform(this.sx, this.sy);

  final double sx;
  final double sy;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..scale(sx, sy)
      ..translate(-cx, -cy);
  }

  @override
  String toString() =>
      'ScaleGradientTransform(${sx.toStringAsFixed(2)}, ${sy.toStringAsFixed(2)})';
}

/// Rotates, then translates -- composite transform shown to demonstrate that
/// `transform()` may return any Matrix4 you like.
@immutable
class RotateThenTranslateTransform extends GradientTransform {
  const RotateThenTranslateTransform({
    required this.radians,
    required this.fractionX,
    required this.fractionY,
  });

  final double radians;
  final double fractionX;
  final double fractionY;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    final double dx = fractionX * bounds.width;
    final double dy = fractionY * bounds.height;
    return Matrix4.identity()
      ..translate(cx + dx, cy + dy)
      ..multiply(Matrix4.rotationZ(radians))
      ..translate(-cx, -cy);
  }

  @override
  String toString() => 'RotateThenTranslate(rad=${radians.toStringAsFixed(2)},'
      ' fx=${fractionX.toStringAsFixed(2)}, fy=${fractionY.toStringAsFixed(2)})';
}

/// A direction-aware transform: in LTR it rotates one way, in RTL the other.
/// Demonstrates use of the `textDirection` parameter.
@immutable
class DirectionAwareRotation extends GradientTransform {
  const DirectionAwareRotation(this.radians);

  final double radians;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double sign = textDirection == TextDirection.rtl ? -1.0 : 1.0;
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..multiply(Matrix4.rotationZ(sign * radians))
      ..translate(-cx, -cy);
  }

  @override
  String toString() => 'DirectionAwareRotation(${radians.toStringAsFixed(2)})';
}

/// A "null" transform that always returns null. This is a perfectly legal
/// override -- it asserts identity. Useful to baseline against.
@immutable
class IdentityGradientTransform extends GradientTransform {
  const IdentityGradientTransform();

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) => null;

  @override
  String toString() => 'IdentityGradientTransform()';
}

// ============================================================================
// SECTION 4 -- TILE BUILDERS
// ----------------------------------------------------------------------------
// Each tile is a small labeled square with a gradient inside. We define helper
// builders for the three gradient flavors so the gallery code below stays
// readable.
// ============================================================================

const double kTileSize = 168.0;
const double kTileMargin = 6.0;
const double kCardRadius = 14.0;

Widget _tileFrame({
  required String label,
  required Widget body,
  Color accent = const Color(0xFF222831),
}) {
  return Container(
    width: kTileSize,
    height: kTileSize + 40.0,
    margin: const EdgeInsets.all(kTileMargin),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FB),
      borderRadius: BorderRadius.circular(kCardRadius),
      border: Border.all(color: accent.withOpacity(0.2), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kCardRadius - 4),
            child: body,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: accent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _linearTile({
  required String label,
  GradientTransform? transform,
  List<Color> colors = kRainbow,
  AlignmentGeometry begin = Alignment.centerLeft,
  AlignmentGeometry end = Alignment.centerRight,
}) {
  return _tileFrame(
    label: label,
    body: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
          transform: transform,
        ),
      ),
    ),
  );
}

Widget _radialTile({
  required String label,
  GradientTransform? transform,
  List<Color> colors = kSunset,
  AlignmentGeometry center = Alignment.center,
  double radius = 0.7,
}) {
  return _tileFrame(
    label: label,
    body: DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: colors,
          center: center,
          radius: radius,
          transform: transform,
        ),
      ),
    ),
  );
}

Widget _sweepTile({
  required String label,
  GradientTransform? transform,
  List<Color> colors = kRainbow,
  AlignmentGeometry center = Alignment.center,
  double startAngle = 0.0,
  double endAngle = math.pi * 2,
}) {
  final List<Color> looped = <Color>[...colors, colors.first];
  return _tileFrame(
    label: label,
    body: DecoratedBox(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: looped,
          center: center,
          startAngle: startAngle,
          endAngle: endAngle,
          transform: transform,
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 5 -- LAYOUT HELPERS
// ----------------------------------------------------------------------------
// Group tiles into rows / pages so the gallery scrolls.
// ============================================================================

Widget _sectionHeader(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B1B2F),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4F4F66),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _paragraph(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF2C2C3A),
        height: 1.5,
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(28, 2, 16, 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 7, right: 8),
          child: Icon(Icons.circle, size: 6, color: Color(0xFF4F4F66)),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C2C3A),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _wrap(List<Widget> tiles) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: tiles,
    ),
  );
}

// ============================================================================
// SECTION 6 -- TILE FACTORIES
// ----------------------------------------------------------------------------
// These return lists of widgets used by the build() function.
// ============================================================================

List<Widget> _rotationGridForLinear() {
  final List<Widget> tiles = <Widget>[];
  // 0..360 in 15-degree steps, so 25 tiles -- the last one mirrors the first.
  for (int deg = 0; deg <= 360; deg += 15) {
    final double rad = deg * math.pi / 180.0;
    tiles.add(_linearTile(
      label: 'Linear @ $deg°  (${rad.toStringAsFixed(2)} rad)',
      transform: GradientRotation(rad),
      colors: kRainbow,
    ));
  }
  return tiles;
}

List<Widget> _rotationGridForRadial() {
  final List<Widget> tiles = <Widget>[];
  for (int deg = 0; deg <= 360; deg += 30) {
    final double rad = deg * math.pi / 180.0;
    tiles.add(_radialTile(
      label: 'Radial @ $deg°',
      transform: GradientRotation(rad),
      colors: kSunset,
      center: const Alignment(-0.6, -0.3),
      radius: 0.9,
    ));
  }
  return tiles;
}

List<Widget> _rotationGridForSweep() {
  final List<Widget> tiles = <Widget>[];
  for (int deg = 0; deg <= 360; deg += 30) {
    final double rad = deg * math.pi / 180.0;
    tiles.add(_sweepTile(
      label: 'Sweep @ $deg°',
      transform: GradientRotation(rad),
      colors: kRainbow,
    ));
  }
  return tiles;
}

List<Widget> _skewGrid() {
  final List<Widget> tiles = <Widget>[];
  final List<double> xs = <double>[-0.6, -0.3, 0.0, 0.3, 0.6];
  final List<double> ys = <double>[-0.4, -0.2, 0.0, 0.2, 0.4];
  for (final double ax in xs) {
    for (final double ay in ys) {
      tiles.add(_linearTile(
        label: 'Skew(${ax.toStringAsFixed(2)},${ay.toStringAsFixed(2)})',
        transform: SkewGradientTransform(ax, ay),
        colors: kOcean,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ));
    }
  }
  return tiles;
}

List<Widget> _translateGrid() {
  final List<Widget> tiles = <Widget>[];
  final List<double> fxs = <double>[-0.5, -0.25, 0.0, 0.25, 0.5];
  final List<double> fys = <double>[-0.5, -0.25, 0.0, 0.25, 0.5];
  for (final double fx in fxs) {
    for (final double fy in fys) {
      tiles.add(_radialTile(
        label: 'Translate(${fx.toStringAsFixed(2)},${fy.toStringAsFixed(2)})',
        transform: TranslateGradientTransform(fx, fy),
        colors: kLava,
        center: Alignment.center,
        radius: 0.6,
      ));
    }
  }
  return tiles;
}

List<Widget> _scaleGrid() {
  final List<Widget> tiles = <Widget>[];
  final List<double> sxs = <double>[0.5, 0.75, 1.0, 1.5, 2.0];
  final List<double> sys = <double>[0.5, 0.75, 1.0, 1.5, 2.0];
  for (final double sx in sxs) {
    for (final double sy in sys) {
      tiles.add(_sweepTile(
        label: 'Scale(${sx.toStringAsFixed(2)},${sy.toStringAsFixed(2)})',
        transform: ScaleGradientTransform(sx, sy),
        colors: kForest,
      ));
    }
  }
  return tiles;
}

List<Widget> _compositeGrid() {
  final List<Widget> tiles = <Widget>[];
  final List<double> degs = <double>[0, 30, 60, 90, 120, 150, 180];
  final List<double> fxs = <double>[-0.3, 0.0, 0.3];
  for (final double deg in degs) {
    for (final double fx in fxs) {
      final double rad = deg * math.pi / 180.0;
      tiles.add(_linearTile(
        label: 'Rot ${deg.toInt()}° + tx=${fx.toStringAsFixed(2)}',
        transform: RotateThenTranslateTransform(
          radians: rad,
          fractionX: fx,
          fractionY: 0.0,
        ),
        colors: kRainbow,
      ));
    }
  }
  return tiles;
}

List<Widget> _directionalGrid() {
  final List<Widget> tiles = <Widget>[];
  final List<double> degs = <double>[15, 30, 45, 60, 75, 90];
  for (final double deg in degs) {
    final double rad = deg * math.pi / 180.0;
    tiles.add(Directionality(
      textDirection: TextDirection.ltr,
      child: _linearTile(
        label: 'LTR ${deg.toInt()}°',
        transform: DirectionAwareRotation(rad),
        colors: kSunset,
      ),
    ));
    tiles.add(Directionality(
      textDirection: TextDirection.rtl,
      child: _linearTile(
        label: 'RTL ${deg.toInt()}°',
        transform: DirectionAwareRotation(rad),
        colors: kSunset,
      ),
    ));
  }
  return tiles;
}

// ============================================================================
// SECTION 7 -- RECIPES
// ----------------------------------------------------------------------------
// Hand-tuned tile compositions illustrating real-world looks. Each is a
// single tile or a small composition.
// ============================================================================

Widget _recipeRotatedRainbowBanner() {
  return Container(
    height: 140,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: kRainbow,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(12 * math.pi / 180),
      ),
    ),
    alignment: Alignment.center,
    child: const Text(
      'Rotated Rainbow Banner -- GradientRotation(12°)',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        shadows: <Shadow>[
          Shadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 1)),
        ],
      ),
    ),
  );
}

Widget _recipeTiltedSun() {
  return Container(
    height: 200,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: RadialGradient(
        colors: const <Color>[
          Color(0xFFFFF59D),
          Color(0xFFFFCA28),
          Color(0xFFFF8F00),
          Color(0xFF3E2723),
        ],
        center: const Alignment(-0.4, -0.3),
        radius: 0.8,
        transform: const ScaleGradientTransform(1.6, 0.7),
      ),
    ),
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.all(12),
    child: const Text(
      'Tilted Sun -- ScaleGradientTransform(1.6, 0.7)',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _recipeTwistedRibbon() {
  return Container(
    height: 140,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: SweepGradient(
        colors: const <Color>[
          Color(0xFFE91E63),
          Color(0xFF9C27B0),
          Color(0xFF3F51B5),
          Color(0xFF03A9F4),
          Color(0xFF4CAF50),
          Color(0xFFFFEB3B),
          Color(0xFFFF5722),
          Color(0xFFE91E63),
        ],
        center: Alignment.center,
        transform: const SkewGradientTransform(0.4, 0.0),
      ),
    ),
    alignment: Alignment.center,
    child: const Text(
      'Twisted Ribbon -- SkewGradientTransform(0.4, 0.0)',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _recipeGlassRefraction() {
  return Container(
    height: 140,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: kGlass,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(35 * math.pi / 180),
      ),
    ),
    alignment: Alignment.center,
    child: const Text(
      'Glass Refraction -- rotated translucent sheen',
      style: TextStyle(color: Colors.white70, fontSize: 14),
    ),
  );
}

Widget _recipeLavaLampTile() {
  return Container(
    height: 220,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: RadialGradient(
        colors: kLava,
        center: const Alignment(0.0, 0.4),
        radius: 0.9,
        transform: const SkewGradientTransform(0.0, 0.2),
      ),
    ),
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.all(16),
    child: const Text(
      'Lava Lamp -- RadialGradient + SkewGradientTransform(0, 0.2)',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _recipeSunsetGallery() {
  final List<double> degs = <double>[-15, -10, -5, 0, 5, 10, 15];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Wrap(
      children: <Widget>[
        for (final double deg in degs)
          Container(
            width: 160,
            height: 90,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: kSunset,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(deg * math.pi / 180),
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8),
            child: Text(
              'sunset @ ${deg.toInt()}°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 -- COMPARISON: NO TRANSFORM vs SAME WITH ROTATION
// ----------------------------------------------------------------------------
// A small "before / after" strip so the eye can isolate exactly what the
// transform does.
// ============================================================================

Widget _comparisonRow({
  required String title,
  required Gradient before,
  required Gradient after,
  required String afterLabel,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B1B2F),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: before,
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'baseline (no transform)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: after,
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                child: Text(
                  afterLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

List<Widget> _comparisonStrip() {
  return <Widget>[
    _comparisonRow(
      title: 'LinearGradient: identity vs GradientRotation(45°)',
      before: const LinearGradient(colors: kRainbow),
      after: LinearGradient(
        colors: kRainbow,
        transform: GradientRotation(math.pi / 4),
      ),
      afterLabel: 'rotation 45°',
    ),
    _comparisonRow(
      title: 'RadialGradient: identity vs ScaleGradientTransform(2.0, 0.5)',
      before: const RadialGradient(colors: kSunset, radius: 0.7),
      after: const RadialGradient(
        colors: kSunset,
        radius: 0.7,
        transform: ScaleGradientTransform(2.0, 0.5),
      ),
      afterLabel: 'scale (2.0, 0.5)',
    ),
    _comparisonRow(
      title: 'SweepGradient: identity vs SkewGradientTransform(0.3, 0.0)',
      before: const SweepGradient(colors: <Color>[...kRainbow, kRainbowFirst]),
      after: const SweepGradient(
        colors: <Color>[...kRainbow, kRainbowFirst],
        transform: SkewGradientTransform(0.3, 0.0),
      ),
      afterLabel: 'skew (0.3, 0.0)',
    ),
    _comparisonRow(
      title: 'LinearGradient: identity vs TranslateGradientTransform(0.3, 0)',
      before: const LinearGradient(colors: kOcean),
      after: const LinearGradient(
        colors: kOcean,
        transform: TranslateGradientTransform(0.3, 0.0),
      ),
      afterLabel: 'translate +30% X',
    ),
    _comparisonRow(
      title: 'RadialGradient: identity vs GradientRotation(90°)',
      before: const RadialGradient(colors: kForest, radius: 0.6),
      after: RadialGradient(
        colors: kForest,
        radius: 0.6,
        transform: GradientRotation(math.pi / 2),
      ),
      afterLabel: 'rotation 90°',
    ),
  ];
}

// SweepGradient.colors must wrap, so we precompute the trailing element as a
// top-level constant to keep the const-context happy.
const Color kRainbowFirst = Color(0xFFE53935);

// ============================================================================
// SECTION 9 -- PITFALLS, GLOSSARY, RECAP
// ============================================================================

Widget _pitfalls() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        'Common pitfalls',
        'Things that bite when you start using GradientTransform.',
      ),
      _bullet(
        'A GradientTransform is NOT animated by itself. To animate it, '
        'rebuild the gradient inside an AnimatedBuilder/TweenAnimationBuilder.',
      ),
      _bullet(
        'GradientRotation rotates around the CENTER of the bounds, not the '
        'top-left corner. If you want a different pivot, write your own '
        'GradientTransform with translate-rotate-translate.',
      ),
      _bullet(
        'TranslateGradientTransform expressed in absolute pixels behaves '
        'differently across layouts. Prefer fractions of bounds.',
      ),
      _bullet(
        'ScaleGradientTransform with sx != sy turns a RadialGradient circle '
        'into an ellipse. This is often what you want for "tilted sun" or '
        '"horizon glow" effects.',
      ),
      _bullet(
        'SkewGradientTransform on a SweepGradient produces a visually '
        'beautiful but mathematically aliased result -- use moderate values.',
      ),
      _bullet(
        'On RTL layouts, prefer transforms that consult `textDirection` so '
        'that visual asymmetries flip correctly.',
      ),
      _bullet(
        'Returning null from transform() is semantically identical to '
        'returning Matrix4.identity(). Returning null is slightly more '
        'efficient because Flutter can short-circuit.',
      ),
    ],
  );
}

Widget _glossary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        'Glossary',
        'The vocabulary you will use when talking about gradient transforms.',
      ),
      _bullet('bounds -- the Rect that the gradient is being painted into.'),
      _bullet('mapping -- the coordinate system used to sample color stops.'),
      _bullet('pivot -- the point that stays fixed during a rotation/scale.'),
      _bullet('radians -- the unit GradientRotation expects (math.pi == 180°).'),
      _bullet('shader -- the underlying Skia object that paints the gradient.'),
      _bullet('affine -- a transformation that preserves straight lines.'),
      _bullet('column-major -- the memory layout Matrix4 uses internally.'),
      _bullet('identity -- the transform that does nothing; the null transform.'),
    ],
  );
}

Widget _recap() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(
        'Recap',
        'If you remember three things from this dossier, remember these.',
      ),
      _bullet(
        '1. GradientTransform is a Matrix4 applied to the gradient mapping, '
        'not to the widget. Geometry of your box never changes.',
      ),
      _bullet(
        '2. GradientRotation is the only built-in subclass. Anything else -- '
        'skew, translate, scale, composite -- you write yourself by extending '
        'GradientTransform and overriding transform(bounds, textDirection).',
      ),
      _bullet(
        '3. For animation, rebuild the gradient with a new transform inside '
        'an AnimatedBuilder. The transform itself is a value object.',
      ),
    ],
  );
}

// ============================================================================
// SECTION 10 -- TOP-LEVEL build() ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  if (kDebugMode) {
    debugPrint('gradient_transform_test: building visual gallery');
  }

  final List<Widget> linearRotationTiles = _rotationGridForLinear();
  final List<Widget> radialRotationTiles = _rotationGridForRadial();
  final List<Widget> sweepRotationTiles = _rotationGridForSweep();
  final List<Widget> skewTiles = _skewGrid();
  final List<Widget> translateTiles = _translateGrid();
  final List<Widget> scaleTiles = _scaleGrid();
  final List<Widget> compositeTiles = _compositeGrid();
  final List<Widget> directionalTiles = _directionalGrid();
  final List<Widget> comparisonTiles = _comparisonStrip();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFEFEFF5),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFF1B1B2F)),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B2F),
        foregroundColor: Colors.white,
        title: const Text('GradientTransform deep demo'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Dossier
            _sectionHeader(
              'Dossier',
              'GradientTransform applies a Matrix4 to the gradient mapping. '
                  'The widget geometry is unchanged; only the way colors are '
                  'sampled across the shape changes.',
            ),
            _paragraph(
              'A GradientTransform is the painting-side analogue of a '
              'Transform widget: instead of moving pixels, it moves the '
              'mapping that the shader uses to evaluate color stops. This '
              'distinction matters -- a transformed gradient still respects '
              'the box layout, clip, and pointer-hit area of its parent.',
            ),
            _paragraph(
              'The only concrete subclass in Flutter is GradientRotation, '
              'which rotates the mapping around the center of the bounds. '
              'Everything else -- skew, translate, scale, composite -- is up '
              'to you, by extending GradientTransform and overriding the '
              'single method transform(Rect bounds, {TextDirection? td}).',
            ),

            // Anatomy
            _sectionHeader(
              'Anatomy',
              'The single method that defines a GradientTransform.',
            ),
            _paragraph(
              'Signature: Matrix4? transform(Rect bounds, '
              '{TextDirection? textDirection}). Returning null is equivalent '
              'to identity. The canonical pattern is translate-to-pivot, '
              'apply, translate-back -- which is exactly what '
              'GradientRotation does internally.',
            ),
            _bullet('Input: bounds rect (where the gradient will be painted).'),
            _bullet('Input: textDirection (so RTL layouts can be flipped).'),
            _bullet('Output: a Matrix4? -- null means identity.'),
            _bullet('The matrix is concatenated, not replaced.'),

            // GradientRotation grid for LinearGradient
            _sectionHeader(
              'GradientRotation on LinearGradient',
              'Every 15° from 0° to 360°. Notice the rainbow direction '
                  'rotates smoothly through a full revolution.',
            ),
            _wrap(linearRotationTiles),

            // GradientRotation grid for RadialGradient
            _sectionHeader(
              'GradientRotation on RadialGradient',
              'For a centered radial gradient the rotation is invisible. We '
                  'offset the center so the rotation effect becomes obvious.',
            ),
            _wrap(radialRotationTiles),

            // GradientRotation grid for SweepGradient
            _sectionHeader(
              'GradientRotation on SweepGradient',
              'For a sweep gradient, rotation simply shifts the starting '
                  'angle of the sweep.',
            ),
            _wrap(sweepRotationTiles),

            // Skew
            _sectionHeader(
              'SkewGradientTransform (custom)',
              'A 5x5 grid sampling (alphaX, alphaY). Skew shears the mapping '
                  'so that diagonals stretch. Try the extremes to see how the '
                  'rainbow flattens out.',
            ),
            _wrap(skewTiles),

            // Translate
            _sectionHeader(
              'TranslateGradientTransform (custom)',
              'A 5x5 grid sampling (fractionX, fractionY). Translation in '
                  'fractions of bounds keeps the effect layout-independent.',
            ),
            _wrap(translateTiles),

            // Scale
            _sectionHeader(
              'ScaleGradientTransform (custom)',
              'A 5x5 grid sampling (sx, sy). Asymmetric scales turn radial '
                  'circles into ellipses -- a great trick for horizon glows.',
            ),
            _wrap(scaleTiles),

            // Composite
            _sectionHeader(
              'RotateThenTranslateTransform (custom composite)',
              'Demonstrates that transform() may return any Matrix4 -- '
                  'including composites of rotation and translation.',
            ),
            _wrap(compositeTiles),

            // Direction-aware
            _sectionHeader(
              'DirectionAwareRotation (custom, uses textDirection)',
              'The transform inverts its rotation in RTL layouts. Useful for '
                  'asymmetric flourishes.',
            ),
            _wrap(directionalTiles),

            // Recipes
            _sectionHeader(
              'Recipes',
              'Hand-tuned compositions that look pretty.',
            ),
            _recipeRotatedRainbowBanner(),
            _recipeTiltedSun(),
            _recipeTwistedRibbon(),
            _recipeGlassRefraction(),
            _recipeLavaLampTile(),
            _sectionHeader(
              'Sunset banner gallery',
              'Same LinearGradient rotated through a fan of small angles.',
            ),
            _recipeSunsetGallery(),

            // Comparison
            _sectionHeader(
              'Comparison: no transform vs same with transform',
              'Side-by-side baselines to isolate exactly what each transform '
                  'does.',
            ),
            ...comparisonTiles,

            // Pitfalls / Glossary / Recap
            _pitfalls(),
            _glossary(),
            _recap(),

            const SizedBox(height: 24),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  'End of GradientTransform dossier.',
                  style: TextStyle(
                    color: Color(0xFF1B1B2F),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 11 -- APPENDIX: EXTRA CUSTOM TRANSFORMS
// ----------------------------------------------------------------------------
// These are not wired into the gallery above; they exist as additional
// reading material that demonstrates the API surface. Each follows the same
// translate-to-pivot pattern.
// ============================================================================

/// Mirrors the gradient horizontally around the center of the bounds.
@immutable
class MirrorXGradientTransform extends GradientTransform {
  const MirrorXGradientTransform();

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..scale(-1.0, 1.0)
      ..translate(-cx, -cy);
  }
}

/// Mirrors the gradient vertically around the center of the bounds.
@immutable
class MirrorYGradientTransform extends GradientTransform {
  const MirrorYGradientTransform();

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..scale(1.0, -1.0)
      ..translate(-cx, -cy);
  }
}

/// Rotates by a value that depends on the bounds aspect ratio.
@immutable
class AspectAwareRotation extends GradientTransform {
  const AspectAwareRotation(this.baseRadians);

  final double baseRadians;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double aspect = bounds.width / math.max(bounds.height, 1.0);
    final double radians = baseRadians * math.atan(aspect) / (math.pi / 4);
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..multiply(Matrix4.rotationZ(radians))
      ..translate(-cx, -cy);
  }
}

/// A transform that pivots around the top-left corner instead of the center.
@immutable
class TopLeftPivotRotation extends GradientTransform {
  const TopLeftPivotRotation(this.radians);

  final double radians;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.identity()
      ..translate(bounds.left, bounds.top)
      ..multiply(Matrix4.rotationZ(radians))
      ..translate(-bounds.left, -bounds.top);
  }
}

/// A transform that combines rotation and uniform scale -- useful for a
/// "spotlight zoomed in 45°" effect.
@immutable
class SpotlightTransform extends GradientTransform {
  const SpotlightTransform({
    required this.radians,
    required this.scale,
  });

  final double radians;
  final double scale;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..scale(scale, scale)
      ..multiply(Matrix4.rotationZ(radians))
      ..translate(-cx, -cy);
  }
}

/// A transform that rotates twice as fast on the x-axis as on y -- this is
/// mathematically an anisotropic rotation, but for SweepGradient it produces
/// a really cool "twisted pinwheel" feel.
@immutable
class AnisotropicRotation extends GradientTransform {
  const AnisotropicRotation(this.radians);

  final double radians;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    final Matrix4 m = Matrix4.identity()
      ..setEntry(0, 0, math.cos(radians * 2))
      ..setEntry(0, 1, -math.sin(radians))
      ..setEntry(1, 0, math.sin(radians))
      ..setEntry(1, 1, math.cos(radians));
    return Matrix4.identity()
      ..translate(cx, cy)
      ..multiply(m)
      ..translate(-cx, -cy);
  }
}

/// A transform that "pulses" based on a phase value; this is the building
/// block you would use in an AnimatedBuilder.
@immutable
class PulseScaleTransform extends GradientTransform {
  const PulseScaleTransform(this.phase);

  final double phase;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double s = 1.0 + 0.5 * math.sin(phase);
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    return Matrix4.identity()
      ..translate(cx, cy)
      ..scale(s, s)
      ..translate(-cx, -cy);
  }
}

/// A transform that yields a perspective-like effect by setting the
/// homogeneous w-row.
@immutable
class FakePerspectiveTransform extends GradientTransform {
  const FakePerspectiveTransform(this.amount);

  final double amount;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double cx = bounds.center.dx;
    final double cy = bounds.center.dy;
    final Matrix4 m = Matrix4.identity()..setEntry(3, 2, amount);
    return Matrix4.identity()
      ..translate(cx, cy)
      ..multiply(m)
      ..translate(-cx, -cy);
  }
}

/// A transform that pre-computes its bounds (via constructor), useful when
/// the bounds rect is known in advance and you want to allocate the matrix
/// only once.
@immutable
class PreComputedRotation extends GradientTransform {
  PreComputedRotation(this.radians, Rect bounds)
      : _matrix = Matrix4.identity()
          ..translate(bounds.center.dx, bounds.center.dy)
          ..multiply(Matrix4.rotationZ(radians))
          ..translate(-bounds.center.dx, -bounds.center.dy);

  final double radians;
  final Matrix4 _matrix;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) => _matrix;
}

// ============================================================================
// SECTION 12 -- APPENDIX: SAMPLE GRADIENTS THAT USE THE EXTRA TRANSFORMS
// ----------------------------------------------------------------------------
// These functions are not invoked by build(); they exist so a reader can
// copy-paste them into a fresh gallery section.
// ============================================================================

LinearGradient mirroredLinear() => const LinearGradient(
      colors: kRainbow,
      transform: MirrorXGradientTransform(),
    );

RadialGradient mirroredRadial() => const RadialGradient(
      colors: kSunset,
      radius: 0.8,
      center: Alignment(-0.5, 0.0),
      transform: MirrorYGradientTransform(),
    );

SweepGradient spotlightSweep() => SweepGradient(
      colors: const <Color>[...kRainbow, kRainbowFirst],
      transform: const SpotlightTransform(radians: 0.5, scale: 1.6),
    );

LinearGradient pinwheelLinear() => const LinearGradient(
      colors: kForest,
      transform: AnisotropicRotation(0.6),
    );

LinearGradient aspectAwareLinear() => const LinearGradient(
      colors: kOcean,
      transform: AspectAwareRotation(math.pi / 6),
    );

RadialGradient topLeftPivotRadial() => RadialGradient(
      colors: kLava,
      radius: 0.6,
      transform: TopLeftPivotRotation(math.pi / 6),
    );

LinearGradient pulseLinear(double phase) => LinearGradient(
      colors: kRainbow,
      transform: PulseScaleTransform(phase),
    );

LinearGradient fakePerspectiveLinear() => const LinearGradient(
      colors: kGlass,
      transform: FakePerspectiveTransform(0.002),
    );

// ============================================================================
// SECTION 13 -- APPENDIX: TEXT BANNERS THAT WRAP EACH TRANSFORM
// ----------------------------------------------------------------------------
// Inline narrative paragraphs that double as documentation when the file is
// read top-to-bottom in a code review.
// ============================================================================

// On GradientRotation:
//
//   The simplest of all GradientTransforms. It takes a number of radians and
//   constructs a 4x4 rotation matrix pivoted at the center of the bounds.
//   This is the only concrete subclass shipped with Flutter, but the moment
//   you understand it you understand the whole abstraction.
//
// On SkewGradientTransform:
//
//   Skew is a shear transform; it preserves area but distorts angles. For a
//   LinearGradient this produces a fan-shaped color sweep; for a
//   SweepGradient it generates a fascinating "spinning ribbon" effect.
//
// On TranslateGradientTransform:
//
//   Translation slides the gradient mapping. By itself it is rarely useful
//   with a LinearGradient (since you can just change begin/end), but for a
//   RadialGradient with a fixed center it produces a "panning spotlight".
//
// On ScaleGradientTransform:
//
//   Uniform scale zooms the gradient in or out around the center. Non-uniform
//   scale (sx != sy) is the trick to make radial gradients look elliptical --
//   indispensable for horizon glows, tilted suns, and slanted spotlights.
//
// On RotateThenTranslateTransform:
//
//   The point of this class is not the specific composite; it is the
//   demonstration that transform() can return literally any Matrix4. You can
//   pre-multiply, post-multiply, and compose to your heart's content.
//
// On DirectionAwareRotation:
//
//   Read the textDirection parameter. In an LTR layout, rotate one way; in
//   RTL, the other. This keeps asymmetric flourishes visually mirrored when
//   the document direction flips.

// ============================================================================
// END OF FILE
// ============================================================================
