// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
// =============================================================================
// shape_border_test.dart
// -----------------------------------------------------------------------------
// Deep demo for `ShapeBorder` from package:flutter/painting.dart.
//
// `ShapeBorder` is the abstract base class for the outline of a 2D shape.
// It is the contract that every "shape decoration" border in Flutter speaks:
// from the rounded rectangles wrapping every Material card, to the perfect
// circles framing every avatar, to the stadium pills that hold floating
// action button labels, all the way out to bevelled, continuous, oval,
// linear, and star borders.
//
// Concrete subclasses demonstrated here:
//   - RoundedRectangleBorder
//   - CircleBorder
//   - StadiumBorder
//   - BeveledRectangleBorder
//   - ContinuousRectangleBorder
//   - OvalBorder
//   - LinearBorder         (with LinearBorderEdge)
//   - StarBorder           (with StarBorder.polygon)
//   - RoundedSuperellipseBorder
//
// Every `ShapeBorder` exposes:
//   - dimensions             : EdgeInsetsGeometry of the stroke
//   - preferPaintInterior    : whether paintInterior fast-path is preferred
//   - getOuterPath(rect)     : Path of the outer outline
//   - getInnerPath(rect)     : Path of the inner outline (where children clip)
//   - paint(canvas, rect)    : draws the stroke onto a Canvas
//   - scale(t)               : returns a uniformly scaled copy
//   - operator+(other)       : composes two borders into one
//
// The visual theme of this demo is "GEOMETRIC ORIGAMI":
// paper-white surfaces, soft fold-shadows, magenta accent ink, and a thread of
// edge-gold that lights up the corners.  Every section paints a different
// `ShapeBorder` recipe onto a `Container` via `ShapeDecoration` so the eye
// can compare them side by side.
//
// Constraints (D4rt sandbox):
//   - No setState, no StatefulWidget, no AnimationController.
//   - No Timer, Future, streams.
//   - Static widget snapshots only.
//   - Indexed loops, never for-in over bridged instances.
//   - One top-level `dynamic build(BuildContext)` returns the root widget.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// ---------------------------------------------------------------------------
// Origami color palette (≥10 const Colors).
// ---------------------------------------------------------------------------
const Color kPaperWhite = Color(0xFFF7F4EE);
const Color kPaperCream = Color(0xFFEDE7DA);
const Color kFoldShadow = Color(0xFFB6AC94);
const Color kFoldDeep = Color(0xFF6E6552);
const Color kInkBlack = Color(0xFF1B1A17);
const Color kAccentMagenta = Color(0xFFD81E80);
const Color kAccentMagentaDeep = Color(0xFF8E0E55);
const Color kEdgeGold = Color(0xFFD9A441);
const Color kEdgeGoldDeep = Color(0xFF8E6713);
const Color kCoolMint = Color(0xFF6FB7A2);
const Color kCoolBlue = Color(0xFF3B5F8A);
const Color kSoftLilac = Color(0xFFB8A7CB);
const Color kRoseDust = Color(0xFFE5B5B6);
const Color kSeaSalt = Color(0xFFE9F1EC);

// ---------------------------------------------------------------------------
// Small helpers (top-level only, no class subclasses).
// ---------------------------------------------------------------------------
Widget _hSpace(double w) => SizedBox(width: w);
Widget _vSpace(double h) => SizedBox(height: h);

Widget _divider(Color color) {
  return Container(height: 1, color: color);
}

Widget _sectionTitle(String index, String title, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: kFoldShadow,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            index,
            style: TextStyle(
              color: kPaperWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        _hSpace(12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kInkBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _captionLine(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: kFoldDeep,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: kInkBlack,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swatch(String name, ShapeBorder shape, Color fill, double w, double h) {
  return Container(
    width: w,
    height: h,
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      shape: shape,
      color: fill,
      shadows: [
        BoxShadow(
          color: kFoldShadow,
          blurRadius: 6,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: kInkBlack,
      ),
    ),
  );
}

Widget _gallerySwatch(String name, ShapeBorder shape, Gradient gradient) {
  return Container(
    width: 150,
    height: 110,
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      shape: shape,
      gradient: gradient,
      shadows: [
        BoxShadow(
          color: kFoldShadow,
          blurRadius: 8,
          offset: Offset(2, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: kInkBlack,
        ),
      ),
    ),
  );
}

Widget _paperCard(Widget child) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaperWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kFoldShadow, width: 1),
      boxShadow: [
        BoxShadow(
          color: kFoldShadow,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );
}

Widget _legendDot(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.only(right: 12, top: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: kInkBlack, width: 1),
          ),
        ),
        _hSpace(6),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: kInkBlack),
        ),
      ],
    ),
  );
}

// =============================================================================
// build()
// =============================================================================
dynamic build(BuildContext context) {
  print('============================================================');
  print('shape_border_test :: ShapeBorder deep demo (origami theme)');
  print('============================================================');

  // ---------------------------------------------------------------------
  // Section 0: anchor ShapeBorder instances.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 0] Anchor ShapeBorder instances');
  print('-- constructing the three canonical OutlinedBorders --');

  final RoundedRectangleBorder anchorRounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(width: 2, color: kAccentMagenta),
  );
  print('anchorRounded.runtimeType         = ${anchorRounded.runtimeType}');
  print('anchorRounded.borderRadius        = ${anchorRounded.borderRadius}');
  print('anchorRounded.side                = ${anchorRounded.side}');
  print('anchorRounded.dimensions          = ${anchorRounded.dimensions}');
  print('anchorRounded.preferPaintInterior = ${anchorRounded.preferPaintInterior}');

  final CircleBorder anchorCircle = CircleBorder(
    side: BorderSide(width: 2, color: kEdgeGold),
  );
  print('anchorCircle.runtimeType          = ${anchorCircle.runtimeType}');
  print('anchorCircle.side                 = ${anchorCircle.side}');
  print('anchorCircle.dimensions           = ${anchorCircle.dimensions}');
  print('anchorCircle.preferPaintInterior  = ${anchorCircle.preferPaintInterior}');

  final StadiumBorder anchorStadium = StadiumBorder(
    side: BorderSide(width: 2, color: kCoolMint),
  );
  print('anchorStadium.runtimeType         = ${anchorStadium.runtimeType}');
  print('anchorStadium.side                = ${anchorStadium.side}');
  print('anchorStadium.dimensions          = ${anchorStadium.dimensions}');

  // Demonstrate .scale(t)
  final ShapeBorder roundedScaled = anchorRounded.scale(2.0);
  final ShapeBorder circleScaled = anchorCircle.scale(2.0);
  final ShapeBorder stadiumScaled = anchorStadium.scale(0.5);
  print('roundedScaled.runtimeType         = ${roundedScaled.runtimeType}');
  print('circleScaled.runtimeType          = ${circleScaled.runtimeType}');
  print('stadiumScaled.runtimeType         = ${stadiumScaled.runtimeType}');

  // ---------------------------------------------------------------------
  // Section 1: title banner widgets.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 1] Building title banner');
  print('-- weaving accent magenta with edge gold --');
  print('-- adding fold-shadow drop and paper-white face --');
  print('-- caption: a museum label in tiny serif vibes --');

  final Widget titleBanner = Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: kEdgeGold, width: 2),
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPaperWhite, kPaperCream, kSeaSalt],
        stops: [0.0, 0.6, 1.0],
      ),
      shadows: [
        BoxShadow(
          color: kFoldShadow,
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 5,
              innerRadiusRatio: 0.45,
              pointRounding: 0.2,
              valleyRounding: 0.1,
              rotation: 0,
              side: BorderSide(color: kInkBlack, width: 1.5),
            ),
            color: kAccentMagenta,
          ),
          child: Text(
            'SB',
            style: TextStyle(
              color: kPaperWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        _hSpace(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ShapeBorder',
                style: TextStyle(
                  color: kInkBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
              _vSpace(2),
              Text(
                'the outline contract every Flutter shape speaks',
                style: TextStyle(
                  color: kFoldDeep,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              _vSpace(4),
              Row(
                children: [
                  _legendDot(kAccentMagenta, 'magenta ink'),
                  _legendDot(kEdgeGold, 'edge gold'),
                  _legendDot(kFoldShadow, 'fold shadow'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 2: anatomy diagram of a shape border.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 2] Anatomy diagram of a ShapeBorder');
  print('-- outer path = outline visible to the painter --');
  print('-- inner path = where ShapeDecoration clips children --');
  print('-- the gap between them is the BorderSide stripe --');
  print('-- side.strokeAlign decides how the stroke straddles the path --');

  final Widget anatomyDiagram = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a ShapeBorder',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stack the three concentric rectangles to show outer/inner path.
            Container(
              width: 200,
              height: 140,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: kFoldShadow, width: 1),
                ),
                color: kPaperCream,
              ),
              child: Container(
                width: 170,
                height: 110,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: kAccentMagenta, width: 4),
                  ),
                  color: kPaperWhite,
                ),
                child: Container(
                  width: 138,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: kEdgeGold, width: 2),
                    ),
                    color: kSeaSalt,
                  ),
                  child: Text(
                    'inner path\n(child clip)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: kInkBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            _hSpace(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _captionLine('outer path', 'the stroke outline'),
                  _captionLine('side', 'BorderSide stripe (magenta)'),
                  _captionLine('inner path', 'children clip to this'),
                  _captionLine('dimensions', 'EdgeInsets equal to width'),
                  _captionLine('paint', 'draws stroke on Canvas'),
                  _captionLine('scale', 'returns a copy * t'),
                  _captionLine('+', 'compose with another border'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 3: 9-card gallery.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 3] Nine-card gallery of ShapeBorder subclasses');
  print('-- one ShapeBorder per card, with gradient fill --');
  print('-- showing the natural footprint of each shape --');
  print('-- arranged in a 3x3 grid via Wrap --');

  final Gradient gPaper1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPaperWhite, kRoseDust],
  );
  final Gradient gPaper2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kSeaSalt, kCoolMint],
  );
  final Gradient gPaper3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPaperCream, kEdgeGold],
  );
  final Gradient gPaper4 = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [kSoftLilac, kPaperWhite],
  );
  final Gradient gPaper5 = RadialGradient(
    center: Alignment.center,
    radius: 0.9,
    colors: [kPaperWhite, kAccentMagenta],
  );
  final Gradient gPaper6 = RadialGradient(
    center: Alignment.topLeft,
    radius: 1.1,
    colors: [kPaperCream, kCoolBlue],
  );
  final Gradient gPaper7 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [kSeaSalt, kSoftLilac, kPaperWhite],
    stops: [0.0, 0.5, 1.0],
  );
  final Gradient gPaper8 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kPaperWhite, kEdgeGold, kAccentMagenta],
    stops: [0.0, 0.6, 1.0],
  );
  final Gradient gPaper9 = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [kPaperWhite, kCoolMint, kCoolBlue],
    stops: [0.0, 0.6, 1.0],
  );

  final Widget galleryCards = Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      _gallerySwatch(
        'RoundedRectangleBorder',
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: kInkBlack, width: 1.5),
        ),
        gPaper1,
      ),
      _gallerySwatch(
        'CircleBorder',
        CircleBorder(side: BorderSide(color: kInkBlack, width: 1.5)),
        gPaper2,
      ),
      _gallerySwatch(
        'StadiumBorder',
        StadiumBorder(side: BorderSide(color: kInkBlack, width: 1.5)),
        gPaper3,
      ),
      _gallerySwatch(
        'BeveledRectangleBorder',
        BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: kInkBlack, width: 1.5),
        ),
        gPaper4,
      ),
      _gallerySwatch(
        'ContinuousRectangleBorder',
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: kInkBlack, width: 1.5),
        ),
        gPaper5,
      ),
      _gallerySwatch(
        'OvalBorder',
        OvalBorder(side: BorderSide(color: kInkBlack, width: 1.5)),
        gPaper6,
      ),
      _gallerySwatch(
        'LinearBorder.top',
        LinearBorder(
          top: LinearBorderEdge(size: 1.0),
          side: BorderSide(color: kAccentMagenta, width: 3),
        ),
        gPaper7,
      ),
      _gallerySwatch(
        'StarBorder',
        StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          pointRounding: 0.0,
          valleyRounding: 0.0,
          side: BorderSide(color: kInkBlack, width: 1.2),
        ),
        gPaper8,
      ),
      _gallerySwatch(
        'RoundedSuperellipseBorder',
        RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: kInkBlack, width: 1.5),
        ),
        gPaper9,
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // Section 4: RoundedRectangleBorder with various BorderRadius values.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 4] RoundedRectangleBorder x BorderRadius variations');
  print('-- BorderRadius.zero is just a Rectangle --');
  print('-- circular(r) is symmetric on all four corners --');
  print('-- vertical/horizontal-only flips two corners --');
  print('-- only(...) sets each corner independently --');

  final List<RoundedRectangleBorder> radiusVariants = [
    RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      side: BorderSide(color: kInkBlack, width: 1.5),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      side: BorderSide(color: kAccentMagenta, width: 2),
    ),
    RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(28),
        bottomLeft: Radius.circular(28),
      ),
      side: BorderSide(color: kEdgeGold, width: 2),
    ),
  ];
  final List<String> radiusLabels = [
    'zero',
    'circ 4',
    'circ 12',
    'circ 28',
    'vert top',
    'vert bot',
    'horiz L',
    'horiz R',
    'TL+BR',
    'TR+BL',
  ];
  final List<Widget> radiusCards = [];
  for (int i = 0; i < radiusVariants.length; i++) {
    radiusCards.add(_swatch(radiusLabels[i], radiusVariants[i],
        i.isEven ? kPaperCream : kSeaSalt, 110, 70));
  }

  final Widget radiusBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RoundedRectangleBorder x BorderRadius variants',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(10),
        Wrap(spacing: 10, runSpacing: 10, children: radiusCards),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 5: BeveledRectangleBorder vs ContinuousRectangleBorder.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 5] Beveled vs Continuous rectangle borders');
  print('-- BeveledRectangleBorder: corners are straight diagonal cuts --');
  print('-- ContinuousRectangleBorder: corners blend smoothly (squircle-ish) --');
  print('-- both share borderRadius and side properties --');
  print('-- continuous uses a fancier path math under the hood --');

  final List<Widget> bcRow = [];
  for (int i = 0; i < 4; i++) {
    final double r = 6.0 + i * 8.0;
    bcRow.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _swatch(
            'beveled r=${r.toInt()}',
            BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(r),
              side: BorderSide(color: kAccentMagenta, width: 2),
            ),
            kPaperCream,
            110,
            72,
          ),
          _vSpace(8),
          _swatch(
            'continuous r=${r.toInt()}',
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(r),
              side: BorderSide(color: kCoolBlue, width: 2),
            ),
            kSeaSalt,
            110,
            72,
          ),
        ],
      ),
    );
  }

  final Widget bcBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beveled vs Continuous',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(4),
        Text(
          'top row: BeveledRectangleBorder    bottom row: ContinuousRectangleBorder',
          style: TextStyle(fontSize: 11, color: kFoldDeep),
        ),
        _vSpace(10),
        Wrap(spacing: 10, runSpacing: 10, children: bcRow),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 6: BorderSide deep dive.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 6] BorderSide deep dive');
  print('-- BorderSide.width sets stroke thickness --');
  print('-- BorderSide.color sets stroke color --');
  print('-- BorderSide.style toggles solid vs none --');
  print('-- BorderSide.strokeAlign aligns stroke to inside/center/outside --');

  final List<Widget> sideCards = [
    _swatch(
      'width 1',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: kInkBlack, width: 1),
      ),
      kPaperCream,
      110,
      70,
    ),
    _swatch(
      'width 4',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: kInkBlack, width: 4),
      ),
      kPaperCream,
      110,
      70,
    ),
    _swatch(
      'magenta',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: kAccentMagenta, width: 3),
      ),
      kSeaSalt,
      110,
      70,
    ),
    _swatch(
      'style.none',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: kInkBlack, width: 3, style: BorderStyle.none),
      ),
      kRoseDust,
      110,
      70,
    ),
    _swatch(
      'align inside',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: kCoolBlue,
          width: 4,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      kSeaSalt,
      110,
      70,
    ),
    _swatch(
      'align center',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: kCoolBlue,
          width: 4,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
      kSeaSalt,
      110,
      70,
    ),
    _swatch(
      'align outside',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: kCoolBlue,
          width: 4,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      kSeaSalt,
      110,
      70,
    ),
    _swatch(
      'gold thick',
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: kEdgeGold, width: 6),
      ),
      kPaperCream,
      110,
      70,
    ),
  ];

  final Widget sideBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BorderSide variations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(10),
        Wrap(spacing: 10, runSpacing: 10, children: sideCards),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 7: LinearBorder edges.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 7] LinearBorder with LinearBorderEdge');
  print('-- LinearBorder draws straight line segments on selected sides --');
  print('-- LinearBorderEdge.size is fraction of the side painted (0..1) --');
  print('-- LinearBorderEdge.alignment shifts the painted segment --');
  print('-- composes nicely as bottom-only underline borders --');

  final List<Widget> linearCards = [
    _swatch(
      'top only',
      LinearBorder(
        top: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kAccentMagenta, width: 3),
      ),
      kPaperCream,
      130,
      70,
    ),
    _swatch(
      'bottom only',
      LinearBorder(
        bottom: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kCoolBlue, width: 3),
      ),
      kPaperCream,
      130,
      70,
    ),
    _swatch(
      'left only',
      LinearBorder(
        start: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kEdgeGold, width: 3),
      ),
      kPaperCream,
      130,
      70,
    ),
    _swatch(
      'right only',
      LinearBorder(
        end: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kCoolMint, width: 3),
      ),
      kPaperCream,
      130,
      70,
    ),
    _swatch(
      'top + bottom',
      LinearBorder(
        top: LinearBorderEdge(size: 1.0),
        bottom: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kInkBlack, width: 2),
      ),
      kSeaSalt,
      130,
      70,
    ),
    _swatch(
      'half top centered',
      LinearBorder(
        top: LinearBorderEdge(size: 0.5, alignment: 0.0),
        side: BorderSide(color: kAccentMagenta, width: 4),
      ),
      kSeaSalt,
      130,
      70,
    ),
    _swatch(
      'all four',
      LinearBorder(
        top: LinearBorderEdge(size: 1.0),
        bottom: LinearBorderEdge(size: 1.0),
        start: LinearBorderEdge(size: 1.0),
        end: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kInkBlack, width: 2),
      ),
      kRoseDust,
      130,
      70,
    ),
    _swatch(
      'underline thick',
      LinearBorder(
        bottom: LinearBorderEdge(size: 1.0),
        side: BorderSide(color: kAccentMagentaDeep, width: 5),
      ),
      kPaperWhite,
      130,
      70,
    ),
  ];

  final Widget linearBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LinearBorder + LinearBorderEdge',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(10),
        Wrap(spacing: 10, runSpacing: 10, children: linearCards),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 8: StarBorder explorations.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 8] StarBorder + StarBorder.polygon');
  print('-- points: integer count of star tips (>=3) --');
  print('-- innerRadiusRatio: how deep the valleys cut in (0..1) --');
  print('-- pointRounding: softens the tips (0=sharp, 1=round) --');
  print('-- valleyRounding: softens the valleys --');
  print('-- rotation: degrees clockwise --');
  print('-- StarBorder.polygon: convex polygon with sides=points --');

  final List<Widget> starCards = [
    _swatch(
      '5 sharp',
      StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.0,
        valleyRounding: 0.0,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kPaperCream,
      120,
      120,
    ),
    _swatch(
      '5 rounded',
      StarBorder(
        points: 5,
        innerRadiusRatio: 0.5,
        pointRounding: 0.6,
        valleyRounding: 0.4,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kPaperCream,
      120,
      120,
    ),
    _swatch(
      '6 deep',
      StarBorder(
        points: 6,
        innerRadiusRatio: 0.3,
        pointRounding: 0.1,
        valleyRounding: 0.1,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kSeaSalt,
      120,
      120,
    ),
    _swatch(
      '8 shallow',
      StarBorder(
        points: 8,
        innerRadiusRatio: 0.7,
        pointRounding: 0.3,
        valleyRounding: 0.3,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kSeaSalt,
      120,
      120,
    ),
    _swatch(
      '12 sun',
      StarBorder(
        points: 12,
        innerRadiusRatio: 0.65,
        pointRounding: 0.2,
        valleyRounding: 0.2,
        side: BorderSide(color: kEdgeGold, width: 1.5),
      ),
      kPaperWhite,
      120,
      120,
    ),
    _swatch(
      '5 rotated 36',
      StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.1,
        valleyRounding: 0.1,
        rotation: 36,
        side: BorderSide(color: kAccentMagenta, width: 1.5),
      ),
      kRoseDust,
      120,
      120,
    ),
    _swatch(
      'poly tri',
      StarBorder.polygon(
        sides: 3,
        pointRounding: 0.0,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kPaperCream,
      120,
      120,
    ),
    _swatch(
      'poly hex',
      StarBorder.polygon(
        sides: 6,
        pointRounding: 0.0,
        side: BorderSide(color: kInkBlack, width: 1.4),
      ),
      kSeaSalt,
      120,
      120,
    ),
    _swatch(
      'poly oct round',
      StarBorder.polygon(
        sides: 8,
        pointRounding: 0.4,
        side: BorderSide(color: kCoolBlue, width: 1.4),
      ),
      kPaperWhite,
      120,
      120,
    ),
  ];

  final Widget starBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'StarBorder explorations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(10),
        Wrap(spacing: 10, runSpacing: 10, children: starCards),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Section 9: cheat sheet.
  // ---------------------------------------------------------------------
  print('');
  print('[Section 9] Cheat sheet for picking the right ShapeBorder');
  print('-- buttons: StadiumBorder or RoundedRectangleBorder ---');
  print('-- avatars: CircleBorder ---');
  print('-- cards: RoundedRectangleBorder with circular(8..16) ---');
  print('-- badges: StarBorder or StarBorder.polygon ---');

  final List<List<String>> cheatRows = [
    ['Material card', 'RoundedRectangleBorder(circular(12))'],
    ['FAB', 'CircleBorder() or StadiumBorder()'],
    ['Avatar', 'CircleBorder(side: 1px)'],
    ['Pill button', 'StadiumBorder()'],
    ['Sharp tile', 'BeveledRectangleBorder(circular(8))'],
    ['Soft modal', 'ContinuousRectangleBorder(circular(24))'],
    ['Squircle iOS', 'RoundedSuperellipseBorder(circular(20))'],
    ['Underline TextField', 'LinearBorder.bottom'],
    ['Achievement badge', 'StarBorder(points: 5)'],
    ['Compose two', 'borderA + borderB'],
  ];

  final List<Widget> cheatRowWidgets = [];
  for (int i = 0; i < cheatRows.length; i++) {
    final List<String> row = cheatRows[i];
    cheatRowWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: i.isEven ? kPaperWhite : kSeaSalt,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: Text(
                row[0],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kInkBlack,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(
                  fontSize: 12,
                  color: kFoldDeep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    cheatRowWidgets.add(_vSpace(2));
  }

  final Widget cheatBlock = _paperCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ShapeBorder cheat sheet',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kInkBlack,
          ),
        ),
        _vSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cheatRowWidgets,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------
  // Final wiring.
  // ---------------------------------------------------------------------
  print('');
  print('[finalize] Composing the full page tree');
  print('-- 9 sections + title banner under one Column --');
  print('-- the page is a static snapshot, no state, no timers --');
  print('-- ready to be sent over HTTP to the D4rt-AST sandbox --');

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #67, P2): the
  // composed page (title banner + 9 sections + closing badge) is
  // ~2463 logical pixels tall and overflows the 800x600 test viewport
  // by 1863 px on the bottom. Wrap root in Scaffold > SafeArea >
  // SingleChildScrollView so the demo scrolls inside a bounded viewport.
  // Both CrossAxisAlignment.stretch sites in this script are Columns
  // (cheatBlock inner Column and the root Column) — their cross axis is
  // horizontal, so the now-unbounded vertical context does not propagate
  // to a stretch-Row. No P1 follow-up required.
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: kPaperCream,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleBanner,
        _vSpace(14),
        _sectionTitle('1', 'Title banner', kAccentMagenta),
        _divider(kFoldShadow),
        _sectionTitle('2', 'Anatomy of a ShapeBorder', kAccentMagenta),
        anatomyDiagram,
        _vSpace(14),
        _sectionTitle('3', 'Nine-card gallery', kEdgeGold),
        _paperCard(galleryCards),
        _vSpace(14),
        _sectionTitle('4', 'RoundedRectangleBorder x BorderRadius', kCoolBlue),
        radiusBlock,
        _vSpace(14),
        _sectionTitle('5', 'Beveled vs Continuous', kCoolMint),
        bcBlock,
        _vSpace(14),
        _sectionTitle('6', 'BorderSide variations', kAccentMagentaDeep),
        sideBlock,
        _vSpace(14),
        _sectionTitle('7', 'LinearBorder + LinearBorderEdge', kEdgeGoldDeep),
        linearBlock,
        _vSpace(14),
        _sectionTitle('8', 'StarBorder explorations', kAccentMagenta),
        starBlock,
        _vSpace(14),
        _sectionTitle('9', 'Cheat sheet', kInkBlack),
        cheatBlock,
        _vSpace(20),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kPaperWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kFoldShadow, width: 1),
          ),
          child: Text(
            'shape_border_test :: end of demo',
            style: TextStyle(
              fontSize: 12,
              color: kFoldDeep,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
        ),
      ),
    ),
  );
}
