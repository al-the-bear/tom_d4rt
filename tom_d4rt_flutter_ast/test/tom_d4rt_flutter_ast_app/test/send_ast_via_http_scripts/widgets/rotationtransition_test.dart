// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Flutter rotation family.
//
// This file is part of the D4rt flutter-test corpus. It is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exposes exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the host
// invokes once and which returns a Widget tree.
//
// The rendered output is a long static gallery focused on `RotationTransition`
// and its closest cousins in the Flutter rotation toolbox:
//
//   * RotationTransition(turns: Animation<double>, child: ...)
//   * Transform.rotate(angle: <radians>, child: ...)
//   * AnimatedRotation(turns: <double>, duration: ..., child: ...)
//   * Tween<double> + CurvedAnimation snapshotted onto a RotationTransition
//   * RotatedBox(quarterTurns: int, child: ...)
//
// Because the script lives in a static, no-interaction environment, every
// would-be-animated rotation is snapshotted with `AlwaysStoppedAnimation<double>`
// so the demo can be rendered without an `AnimationController`, a `Ticker` or
// a `setState`. The result is a long static page of pinwheels, dials and
// alignment overlays that the eye can follow at a glance.
//
// Sections (11 total):
//   1.  Hero intro - "turns" vs "radians"
//   2.  RotationTransition API reference table
//   3.  Reel of 12 rotation snapshots in a 4x3 grid
//   4.  Alignment showcase (5 pivots, painter overlay)
//   5.  AnimatedRotation vs Transform.rotate side-by-side
//   6.  Tween<double> + CurvedAnimation -> RotationTransition
//   7.  CustomPainter rotation diagram (2D rotation matrix)
//   8.  Six code-block cards (idiomatic snippets)
//   9.  Comparison table - RT / Transform.rotate / AnimatedRotation / RotatedBox
//   10. Pitfalls (6 callouts)
//   11. Footer cheat-sheet
//
// No `setState`, `Timer`, `Future` or `AnimationController` is used anywhere
// in this file. All helpers are private (`_camelCase`). Const-discipline is
// enforced where the constructor allows it.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Literal ARGB colours are used instead of theme-resolved colours so the
// gallery renders consistently whether or not a MaterialTheme is wired up.
// The palette deliberately echoes the iOS-ish look of the sibling demos in
// this corpus so the whole test family feels visually coherent.
const Color _kCanvas = Color(0xFFF5F6FA);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1B1D24);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF111827);
const Color _kInkSecondary = Color(0xFF374151);
const Color _kInkTertiary = Color(0xFF6B7280);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF2563EB); // indigo-blue
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentOrange = Color(0xFFEA580C);
const Color _kAccentRed = Color(0xFFDC2626);
const Color _kAccentPurple = Color(0xFF7C3AED);
const Color _kAccentPink = Color(0xFFDB2777);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentGreen = Color(0xFF16A34A);
const Color _kAccentCyan = Color(0xFF0891B2);
const Color _kPivot = Color(0xFFEF4444);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

const TextStyle _kHeroTitleStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w800,
  color: Color(0xFFFFFFFF),
  letterSpacing: -0.8,
);
const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoLabelStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  fontWeight: FontWeight.w600,
  color: _kInkSecondary,
);
const TextStyle _kCellStyle = TextStyle(
  fontSize: 12.5,
  color: _kInk,
  height: 1.35,
);
const TextStyle _kCellHeaderStyle = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.35,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kCardMargin = EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0);

// ---------------------------------------------------------------------------
// MATH HELPERS
// ---------------------------------------------------------------------------
// A turn is a full revolution, i.e. 2*pi radians. Flutter's RotationTransition
// takes "turns" so a value of 0.25 means a quarter rotation (90 degrees).
// Transform.rotate, by contrast, takes raw radians. The helpers below convert
// between the two so the code in this file can talk in either unit naturally.
double _turnsToRadians(double turns) => turns * 2.0 * math.pi;
double _radiansToTurns(double radians) => radians / (2.0 * math.pi);
double _turnsToDegrees(double turns) => turns * 360.0;

// ---------------------------------------------------------------------------
// SHARED LAYOUT HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level functions returning Widgets. They are kept in
// small, self-contained units so that the build entry point reads as a tour
// through the demo rather than a wall of nested constructors.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = _kCardMargin,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _whitePill(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: const Color(0x55FFFFFF)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _variantLabel(String label, {Color colour = _kInkSecondary}) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        color: colour,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

// A small "key/value" row used in the API reference table.
Widget _apiRow(String name, String type, String description, {Color accent = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(description, style: _kBodyStyle),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// THE ARROW WIDGET
// ---------------------------------------------------------------------------
// The reel of rotation snapshots needs a directional child that makes the
// rotation visually unambiguous - an arrow pointing "up" at t=0. A simple
// CustomPainter draws the arrow inside its bounds. The arrow head is a small
// triangle; the shaft is a wide rectangle. The arrow is given a fixed colour
// per tile so the eye can tell snapshots apart at a glance.
class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({required this.colour, this.stroke = 4.0});
  final Color colour;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shaftPaint = Paint()
      ..color = colour
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final Paint headPaint = Paint()
      ..color = colour
      ..style = PaintingStyle.fill;

    final double cx = size.width / 2.0;
    final double top = size.height * 0.12;
    final double bottom = size.height * 0.88;

    // Shaft: from bottom centre to top centre.
    canvas.drawLine(Offset(cx, bottom), Offset(cx, top + 8.0), shaftPaint);

    // Head: equilateral-ish triangle whose tip is the top of the shaft.
    final double headHalf = size.width * 0.22;
    final Path head = Path()
      ..moveTo(cx, top)
      ..lineTo(cx - headHalf, top + 16.0)
      ..lineTo(cx + headHalf, top + 16.0)
      ..close();
    canvas.drawPath(head, headPaint);

    // Tail dot to anchor the visual baseline.
    canvas.drawCircle(Offset(cx, bottom), stroke * 0.9, headPaint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.colour != colour || oldDelegate.stroke != stroke;
  }
}

Widget _arrow(Color colour, {double size = 64.0}) {
  return SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _ArrowPainter(colour: colour)),
  );
}

// ---------------------------------------------------------------------------
// THE PIVOT-OVERLAY PAINTER
// ---------------------------------------------------------------------------
// Used in the alignment showcase: takes an Alignment (-1..1 on each axis),
// resolves it inside the painter bounds and draws a small red dot at that
// pivot point, plus crosshair guides. This makes RotationTransition's
// `alignment` property visually concrete.
class _PivotPainter extends CustomPainter {
  const _PivotPainter({required this.alignment});
  final Alignment alignment;

  @override
  void paint(Canvas canvas, Size size) {
    // Resolve alignment (-1..1) into pixel coordinates.
    final double px = (alignment.x + 1.0) * size.width / 2.0;
    final double py = (alignment.y + 1.0) * size.height / 2.0;

    final Paint guidePaint = Paint()
      ..color = _kPivot.withOpacity(0.4)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    // Crosshair guides spanning the whole tile.
    canvas.drawLine(Offset(0.0, py), Offset(size.width, py), guidePaint);
    canvas.drawLine(Offset(px, 0.0), Offset(px, size.height), guidePaint);

    // Outer ring.
    final Paint ring = Paint()
      ..color = _kPivot
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(px, py), 7.0, ring);

    // Inner dot.
    final Paint dot = Paint()
      ..color = _kPivot
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(px, py), 3.0, dot);
  }

  @override
  bool shouldRepaint(covariant _PivotPainter oldDelegate) {
    return oldDelegate.alignment != alignment;
  }
}

// ---------------------------------------------------------------------------
// ROTATION MATRIX DIAGRAM PAINTER (used in section 7)
// ---------------------------------------------------------------------------
// This painter draws two coordinate frames: a baseline (light grey) and the
// rotated frame (coloured). It also writes the literal rotation-matrix
// formula next to the diagram. The painter is purely educational and is fed
// a single `angleRadians` parameter.
class _RotationMatrixPainter extends CustomPainter {
  const _RotationMatrixPainter({
    required this.angleRadians,
    this.frameColor = _kAccent,
    this.baselineColor = const Color(0xFFB3B7BF),
  });

  final double angleRadians;
  final Color frameColor;
  final Color baselineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset origin = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = math.min(size.width, size.height) * 0.4;

    // Faint guide circle to show the unit circle.
    final Paint circle = Paint()
      ..color = baselineColor.withOpacity(0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(origin, radius, circle);

    // Baseline axes (x-right, y-down because Flutter's canvas uses y-down).
    final Paint baselinePaint = Paint()
      ..color = baselineColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, origin + Offset(radius, 0.0), baselinePaint);
    canvas.drawLine(origin, origin + Offset(0.0, radius), baselinePaint);

    // Rotated frame: apply the rotation matrix to each unit vector.
    final double c = math.cos(angleRadians);
    final double s = math.sin(angleRadians);
    final Offset rotatedX = Offset(c * radius, s * radius);
    final Offset rotatedY = Offset(-s * radius, c * radius);

    final Paint framePaint = Paint()
      ..color = frameColor
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, origin + rotatedX, framePaint);
    canvas.drawLine(origin, origin + rotatedY, framePaint);

    // Origin marker.
    final Paint dot = Paint()
      ..color = frameColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(origin, 3.5, dot);

    // Tip arrowheads on the rotated frame (small filled triangles).
    void _arrowhead(Offset tip, Offset direction) {
      final double len = direction.distance;
      if (len == 0.0) return;
      final Offset unit = Offset(direction.dx / len, direction.dy / len);
      final Offset perp = Offset(-unit.dy, unit.dx);
      final Offset base = tip - unit * 8.0;
      final Path head = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(base.dx + perp.dx * 4.0, base.dy + perp.dy * 4.0)
        ..lineTo(base.dx - perp.dx * 4.0, base.dy - perp.dy * 4.0)
        ..close();
      canvas.drawPath(head, dot);
    }

    _arrowhead(origin + rotatedX, rotatedX);
    _arrowhead(origin + rotatedY, rotatedY);
  }

  @override
  bool shouldRepaint(covariant _RotationMatrixPainter oldDelegate) {
    return oldDelegate.angleRadians != angleRadians ||
        oldDelegate.frameColor != frameColor ||
        oldDelegate.baselineColor != baselineColor;
  }
}

// ---------------------------------------------------------------------------
// REEL TILE
// ---------------------------------------------------------------------------
// One cell of the rotation reel. Renders a RotationTransition whose `turns`
// is `AlwaysStoppedAnimation(t)`, with an arrow child and a small caption
// underneath showing the turn value and equivalent degrees. The tile reserves
// a fixed size envelope so the 4x3 grid lines up cleanly.
Widget _reelTile(double t, Color arrowColor) {
  final RotationTransition rt = RotationTransition(
    turns: AlwaysStoppedAnimation<double>(t),
    alignment: Alignment.center,
    child: _arrow(arrowColor, size: 60.0),
  );
  final String degrees = _turnsToDegrees(t).toStringAsFixed(0);
  final String turnLabel = t == 0.0 ? '0' : '${(t * 12.0).round()}/12';
  return Container(
    width: 130.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: 80.0, height: 80.0, child: Center(child: rt)),
        const SizedBox(height: 6.0),
        Text(
          'turns = $turnLabel',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: _kInkSecondary,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          '$degrees°',
          style: const TextStyle(
            fontSize: 11.0,
            color: _kInkTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ALIGNMENT TILE (section 4)
// ---------------------------------------------------------------------------
// A square that contains both: the rotated arrow (turns=1/8) and a painter
// overlay that shows the pivot point. The pivot point is the same Alignment
// passed to the RotationTransition, resolved into the tile's bounds.
Widget _alignmentTile(String label, Alignment alignment) {
  const double tileSize = 104.0;
  final RotationTransition rt = RotationTransition(
    turns: const AlwaysStoppedAnimation<double>(0.125), // 1/8 = 45 degrees
    alignment: alignment,
    child: _arrow(_kAccentPurple, size: 60.0),
  );
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: tileSize,
          height: tileSize,
          child: Stack(
            children: <Widget>[
              // The bounding box of the rotation. RotationTransition spins the
              // child inside this box, around the `alignment` point.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0x14000000),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              Positioned.fill(child: rt),
              // Pivot overlay - draws a red dot at the alignment point so the
              // pivot is visible even after the rotation has been applied.
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _PivotPainter(alignment: alignment),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: _kInk,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          '(${alignment.x.toStringAsFixed(1)}, ${alignment.y.toStringAsFixed(1)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: _kInkTertiary,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// COMPARISON TABLE ROW HELPERS
// ---------------------------------------------------------------------------
Widget _tableHeader(List<String> headers) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: <Widget>[
        for (int i = 0; i < headers.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(headers[i], style: _kCellHeaderStyle),
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, {bool alt = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: alt ? const Color(0xFFFAFAFB) : _kCardBg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                cells[i],
                style: i == 0 ? _kCellHeaderStyle : _kCellStyle,
              ),
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// PITFALL CALLOUT
// ---------------------------------------------------------------------------
Widget _pitfallCallout({
  required IconData icon,
  required Color iconColour,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: iconColour.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: iconColour.withOpacity(0.18)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: iconColour, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: iconColour,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(body, style: _kBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CHEAT-SHEET ROW
// ---------------------------------------------------------------------------
Widget _cheatRow(String name, String signature) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFD60A),
            ),
          ),
        ),
        Expanded(
          child: Text(
            signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInkOnDark,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state must live in
// local variables and be passed by closure to the widgets below.
// ===========================================================================
dynamic build(BuildContext context) {
  print('RotationTransition deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains what RotationTransition is and contrasts the two
  // dominant unit systems used by Flutter to express rotation: "turns" (used
  // by RotationTransition, AnimatedRotation and RotatedBox-by-quarters) and
  // "radians" (used by Transform.rotate, Matrix4, dart:math).
  // -------------------------------------------------------------------------
  print('  building hero intro');
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF2563EB),
          Color(0xFF7C3AED),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x332563EB),
          offset: Offset(0.0, 4.0),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.rotate_right, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text('RotationTransition', style: _kHeroTitleStyle),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A static tour of Flutter\'s rotation widgets',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'RotationTransition listens to an Animation<double> measured in '
          'turns - one turn equals a full 360-degree revolution - and applies '
          'the corresponding rotation to its child. Because animations can be '
          'snapshotted with AlwaysStoppedAnimation<double>(t) we can render '
          'an entire reel of rotations side-by-side without ever spinning up '
          'an AnimationController or a Ticker. The result is a static visual '
          'reference you can scroll through to build intuition.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            _LegendChip(label: 'turns = revolutions', icon: Icons.repeat),
            _LegendChip(label: 'radians = 2pi*turns',  icon: Icons.calculate),
            _LegendChip(label: 'degrees = 360*turns',  icon: Icons.straighten),
            _LegendChip(label: 'static via AlwaysStoppedAnimation', icon: Icons.pause_circle),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.lightbulb_outline, color: Color(0xFFFFD60A), size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: const Text(
                'Mental model: turns for "explicit transition widgets" '
                '(RotationTransition, AnimatedRotation) and radians for the '
                'lower-level Transform.rotate. Pick one and convert at the '
                'boundary - mixing them inside a single component is a '
                'frequent source of off-by-90-degree bugs.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - ROTATIONTRANSITION API TABLE
  // -------------------------------------------------------------------------
  // A reference card listing each constructor parameter of RotationTransition
  // with its type and a one-line description. This is the kind of cheat we
  // wish the SDK printed next to the widget gallery.
  // -------------------------------------------------------------------------
  print('  building API reference card');
  final Widget apiTable = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.menu_book, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'RotationTransition API',
              subtitle: 'The four constructor parameters in plain language',
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(height: 1.0, color: _kHairline),
        const SizedBox(height: 6.0),
        _apiRow(
          'turns',
          'Animation<double>',
          'How many full revolutions to apply. 0.25 = 90 degrees clockwise. '
          'Wrap a static value in AlwaysStoppedAnimation<double>(t) for a '
          'frozen snapshot.',
          accent: _kAccent,
        ),
        _apiRow(
          'alignment',
          'AlignmentGeometry',
          'The pivot the rotation happens around, expressed in the child\'s '
          'box. Defaults to Alignment.center. (-1,-1) is the top-left, '
          '(1,1) is the bottom-right.',
          accent: _kAccentPurple,
        ),
        _apiRow(
          'filterQuality',
          'FilterQuality?',
          'Optional image-sampling quality applied while the transform is '
          'active. Default is null (no filtering). Use FilterQuality.low for '
          'rotated bitmaps to avoid jagged edges.',
          accent: _kAccentTeal,
        ),
        _apiRow(
          'child',
          'Widget?',
          'The thing being rotated. Kept outside the build closure of the '
          'animation so the framework can reuse it across frames.',
          accent: _kAccentOrange,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.psychology_alt, color: _kAccent, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: const Text(
                  'Internally RotationTransition wraps the child in a '
                  'Transform that uses Matrix4.rotationZ(turns * 2*pi). The '
                  'animation is listened to and the matrix is recomputed at '
                  'each tick - but the child itself is not rebuilt, so it is '
                  'cheap to animate large subtrees.',
                  style: _kBodyStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - REEL OF ROTATION SNAPSHOTS
  // -------------------------------------------------------------------------
  // 12 RotationTransition tiles arranged in a 4x3 grid. Each tile renders
  // the same arrow widget rotated to a different turn value: 0, 1/12, 2/12,
  // ... , 11/12. The arrows form a clock-face when looked at as a whole.
  // -------------------------------------------------------------------------
  print('  building 12-tile rotation reel');
  // Generate the twelve tiles with rotating colour for variety. The colours
  // are picked so adjacent tiles contrast nicely.
  final List<Color> reelColours = const <Color>[
    _kAccent,        // 0/12
    _kAccentTeal,    // 1/12
    _kAccentGreen,   // 2/12
    _kAccentAmber,   // 3/12
    _kAccentOrange,  // 4/12
    _kAccentRed,     // 5/12
    _kAccentPink,    // 6/12
    _kAccentPurple,  // 7/12
    _kAccent,        // 8/12
    _kAccentCyan,    // 9/12
    _kAccentGreen,   // 10/12
    _kAccentOrange,  // 11/12
  ];

  final List<Widget> reelTiles = <Widget>[
    for (int i = 0; i < 12; i++) _reelTile(i / 12.0, reelColours[i]),
  ];

  final Widget reelGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.donut_large, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              '12 snapshots, one widget',
              subtitle: 'Same arrow, turns ∈ {0, 1/12, ... , 11/12}, '
                  'AlwaysStoppedAnimation makes each one frozen.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // The 4x3 grid is implemented with a Wrap so it gracefully reflows
        // on narrower viewports.
        Wrap(
          alignment: WrapAlignment.start,
          children: reelTiles,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.info_outline, color: _kAccent, size: 16.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'Each arrow points "up" at turns=0. Reading the grid in '
                  'order, every tile advances by 30 degrees clockwise.',
                  style: _kBodyStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - ALIGNMENT SHOWCASE
  // -------------------------------------------------------------------------
  // Demonstrates the `alignment` parameter by rotating the same arrow by
  // 1/8 turn (45 degrees) around five different pivot points. A
  // CustomPainter overlay draws a small red dot at the pivot location so
  // the eye can follow where the rotation is anchored.
  // -------------------------------------------------------------------------
  print('  building alignment showcase');
  final Widget alignmentGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.center_focus_strong, color: _kAccentPurple, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Alignment pivots',
              subtitle: '1/8 turn (45 degrees) around five different anchor '
                  'points. Red dot = pivot.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _alignmentTile('topLeft', Alignment.topLeft),
            _alignmentTile('topRight', Alignment.topRight),
            _alignmentTile('center', Alignment.center),
            _alignmentTile('bottomLeft', Alignment.bottomLeft),
            _alignmentTile('bottomRight', Alignment.bottomRight),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Each tile shares the same source widget. Only the alignment '
          'changes. Notice how (-1,-1) anchors at the top-left corner of '
          'the box, while (1,1) anchors at the bottom-right.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - ANIMATEDROTATION VS TRANSFORM.ROTATE
  // -------------------------------------------------------------------------
  // Two cousins of RotationTransition compared side-by-side. Both produce
  // the same visual result for a static snapshot, but they live at different
  // abstraction levels.
  // -------------------------------------------------------------------------
  print('  building AnimatedRotation vs Transform.rotate panel');
  final Widget animatedRotationWidget = AnimatedRotation(
    turns: 0.25, // 90 degrees
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOut,
    child: Container(
      width: 78.0,
      height: 78.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _kAccentTeal,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF0F766E)),
      ),
      child: const Text(
        'AR',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
      ),
    ),
  );

  final Widget transformRotateWidget = Transform.rotate(
    angle: math.pi / 4.0, // 45 degrees
    child: Container(
      width: 78.0,
      height: 78.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _kAccentOrange,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFB45309)),
      ),
      child: const Text(
        'TR',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
      ),
    ),
  );

  final Widget comparePanel = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.compare_arrows, color: _kAccentTeal, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'AnimatedRotation vs Transform.rotate',
              subtitle: 'Implicit (turns + duration) vs explicit (radians).',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 120.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: _kHairline),
                    ),
                    child: animatedRotationWidget,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'AnimatedRotation(turns: 0.25)',
                    style: _kMonoLabelStyle,
                  ),
                  _variantLabel('implicit, 600ms easeInOut'),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 120.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: _kHairline),
                    ),
                    child: transformRotateWidget,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Transform.rotate(angle: pi/4)',
                    style: _kMonoLabelStyle,
                  ),
                  _variantLabel('explicit, no animation'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Choose AnimatedRotation when the host widget changes its target '
          'turn count and you want Flutter to interpolate it for you. Use '
          'Transform.rotate when you already know the exact angle and need '
          'precise low-level control - it is also the only one of the four '
          'that takes radians directly.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - TWEEN + CURVEDANIMATION SNAPSHOT
  // -------------------------------------------------------------------------
  // Demonstrates plugging a `Tween<double>(begin:, end:).animate(...)` into
  // a RotationTransition. The parent animation is an AlwaysStoppedAnimation
  // at t=0.5, which is then mapped to the tween's value space (so the final
  // rotation lands at 0.5 turns = 180 degrees).
  // -------------------------------------------------------------------------
  print('  building Tween + CurvedAnimation snapshot card');
  // Build five snapshots at parent t = 0, 0.25, 0.5, 0.75, 1.0 using a tween
  // that goes from 0 -> 1 turn. The output rotation equals the input t.
  final List<double> tweenStops = const <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Widget> tweenTiles = <Widget>[
    for (final double t in tweenStops)
      Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: _kHairline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 72.0,
              height: 72.0,
              child: RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                  AlwaysStoppedAnimation<double>(t),
                ),
                child: _arrow(_kAccent, size: 56.0),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              't = ${t.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: _kInkSecondary,
              ),
            ),
          ],
        ),
      ),
  ];

  // Also showcase a CurvedAnimation snapshot. A CurvedAnimation maps its
  // parent's t through a Curve before feeding it to listeners. Here we use
  // Curves.easeInOut at t=0.5 - the value() returns ~0.5 either way for that
  // particular curve, so this snapshot is also at 0.5 turns.
  final Widget curvedSnapshot = SizedBox(
    width: 80.0,
    height: 80.0,
    child: RotationTransition(
      turns: CurvedAnimation(
        parent: const AlwaysStoppedAnimation<double>(0.5),
        curve: Curves.easeInOut,
      ),
      child: _arrow(_kAccentPurple, size: 60.0),
    ),
  );

  final Widget tweenCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.timeline, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Tween<double> snapshots',
              subtitle: 'Tween<double>(begin: 0, end: 1).animate(AlwaysStoppedAnimation(t))',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.start, children: tweenTiles),
        const SizedBox(height: 12.0),
        const Divider(height: 1.0, color: _kHairline),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            curvedSnapshot,
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _cardTitle(
                    'CurvedAnimation at t=0.5',
                    subtitle: 'CurvedAnimation(parent: AlwaysStoppedAnimation(0.5), curve: Curves.easeInOut)',
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Curves.easeInOut maps 0.5 to ~0.5 (the curve is '
                    'symmetric about the midpoint), so this snapshot lands '
                    'at half a turn = 180 degrees. For non-symmetric curves '
                    '(e.g. Curves.easeIn) the same parent t would land on a '
                    'different turn value - which is exactly the kind of '
                    'easing RotationTransition makes possible.',
                    style: _kBodyStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - CUSTOMPAINTER ROTATION DIAGRAM
  // -------------------------------------------------------------------------
  // Three side-by-side diagrams showing the rotation matrix at three
  // canonical angles: 0, pi/6, pi/3. Each diagram draws a baseline frame
  // (grey) and the rotated frame (coloured), with a unit-circle guide. Below
  // the diagrams there is a short explanation of the 2x2 rotation matrix.
  // -------------------------------------------------------------------------
  print('  building rotation matrix diagram');
  final List<double> diagramAngles = <double>[
    0.0,
    math.pi / 6.0,
    math.pi / 3.0,
    math.pi / 2.0,
  ];
  final List<Color> diagramColours = const <Color>[
    _kAccent,
    _kAccentTeal,
    _kAccentOrange,
    _kAccentPurple,
  ];
  final List<Widget> diagramTiles = <Widget>[
    for (int i = 0; i < diagramAngles.length; i++)
      Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: _kHairline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: CustomPaint(
                painter: _RotationMatrixPainter(
                  angleRadians: diagramAngles[i],
                  frameColor: diagramColours[i],
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'θ = ${_radiansToTurns(diagramAngles[i]).toStringAsFixed(3)} turns',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _kInkSecondary,
              ),
            ),
            Text(
              '${_turnsToDegrees(_radiansToTurns(diagramAngles[i])).toStringAsFixed(0)}°',
              style: const TextStyle(
                fontSize: 11.0,
                color: _kInkTertiary,
              ),
            ),
          ],
        ),
      ),
  ];

  final Widget matrixDiagramCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.grain, color: _kAccentPurple, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'How Transform composes a 2D rotation',
              subtitle: 'Coloured frame = rotated, grey frame = baseline',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(alignment: WrapAlignment.start, children: diagramTiles),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'R(θ) = | cos θ  -sin θ |',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  color: _kInk,
                  height: 1.4,
                ),
              ),
              Text(
                '       | sin θ   cos θ |',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  color: _kInk,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Transform.rotate(angle: θ) builds a 4x4 Matrix4 with the '
                'above 2x2 block in its upper-left, and applies it during '
                'paint. The alignment parameter shifts the origin of that '
                'matrix to the requested pivot, then shifts it back, so the '
                'rotation appears to happen around the chosen point.',
                style: _kBodyStyle,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - SIX CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  // Each block is a self-contained, idiomatic example. The first three cover
  // the most common ways to express a rotation; the last three cover more
  // advanced uses (with-controller, AnimationStyle wrapping, RepaintBoundary
  // wrapping for performance).
  // -------------------------------------------------------------------------
  print('  building code-block cards');
  final Widget codeBasic = _codeBlock(
    '// 1. Static RotationTransition snapshot.\n'
    'RotationTransition(\n'
    '  turns: const AlwaysStoppedAnimation<double>(0.25), // 90°\n'
    '  alignment: Alignment.center,\n'
    '  child: Icon(Icons.refresh, size: 48.0),\n'
    ')',
    title: '1_rotation_transition_static.dart',
  );

  final Widget codeAnimated = _codeBlock(
    '// 2. Implicit AnimatedRotation - Flutter interpolates for you.\n'
    'AnimatedRotation(\n'
    '  turns: isOpen ? 0.5 : 0.0,            // 0 -> 0.5 turns\n'
    '  duration: const Duration(milliseconds: 400),\n'
    '  curve: Curves.easeInOut,\n'
    '  child: Icon(Icons.expand_more),\n'
    ')',
    title: '2_animated_rotation_implicit.dart',
  );

  final Widget codeTransform = _codeBlock(
    '// 3. Transform.rotate - explicit, in radians.\n'
    'Transform.rotate(\n'
    '  angle: math.pi / 4.0,                 // 45°\n'
    '  alignment: Alignment.center,\n'
    '  child: const Text(\'tilt\'),\n'
    ')',
    title: '3_transform_rotate_explicit.dart',
  );

  final Widget codeController = _codeBlock(
    '// 4. RotationTransition paired with a controller (commented stub).\n'
    '// AnimationController _ctrl = AnimationController(\n'
    '//   vsync: this,\n'
    '//   duration: const Duration(seconds: 2),\n'
    '// )..repeat();\n'
    '//\n'
    '// RotationTransition(\n'
    '//   turns: _ctrl,                       // implements Animation<double>\n'
    '//   child: Image.asset(\'spinner.png\'),\n'
    '// )\n'
    '// Tip: cancel _ctrl.dispose() in dispose() or the ticker leaks.',
    title: '4_with_controller_commented.dart',
  );

  final Widget codeAnimationStyle = _codeBlock(
    '// 5. AnimationStyle - tune duration/curve from above.\n'
    'AnimationStyle(\n'
    '  duration: const Duration(milliseconds: 800),\n'
    '  curve: Curves.fastOutSlowIn,\n'
    ')\n'
    '// Pass to widgets that expose `animationStyle:` (newer\n'
    '// implicit transitions and the showXxxx helpers).\n'
    '// AnimatedRotation does not consume it directly today,\n'
    '// but the surrounding scaffold can use it for paired\n'
    '// transitions (e.g. expand-and-rotate chevrons).',
    title: '5_animation_style_wrap.dart',
  );

  final Widget codeRepaintBoundary = _codeBlock(
    '// 6. RepaintBoundary - isolate the rotating subtree.\n'
    'RepaintBoundary(\n'
    '  child: RotationTransition(\n'
    '    turns: controller,\n'
    '    child: ExpensiveStaticWidget(),\n'
    '  ),\n'
    ')\n'
    '// Without the RepaintBoundary, every frame of the\n'
    '// rotation invalidates the ancestor layer too, which\n'
    '// kills performance on large subtrees.',
    title: '6_repaint_boundary_perf.dart',
  );

  final Widget codeBlocksSection = Column(
    children: <Widget>[
      codeBasic,
      codeAnimated,
      codeTransform,
      codeController,
      codeAnimationStyle,
      codeRepaintBoundary,
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Compares RotationTransition against its three closest siblings:
  // Transform.rotate, AnimatedRotation and RotatedBox.
  // -------------------------------------------------------------------------
  print('  building comparison table');
  final Widget comparisonTable = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.compare, color: _kAccentTeal, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pick the right tool',
              subtitle: 'RotationTransition vs Transform.rotate vs '
                  'AnimatedRotation vs RotatedBox',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _tableHeader(const <String>['Widget', 'Unit', 'Animated?', 'When to use']),
        const SizedBox(height: 4.0),
        _tableRow(const <String>[
          'RotationTransition',
          'turns (Animation<double>)',
          'Yes (driven)',
          'You already have an Animation<double> (e.g. from a controller or a tween chain).',
        ]),
        const SizedBox(height: 4.0),
        _tableRow(const <String>[
          'Transform.rotate',
          'radians (double)',
          'No (static)',
          'You know the exact angle and just want to bake it into the layout.',
        ], alt: true),
        const SizedBox(height: 4.0),
        _tableRow(const <String>[
          'AnimatedRotation',
          'turns (double)',
          'Implicit',
          'The angle changes over time and you want Flutter to interpolate it for you.',
        ]),
        const SizedBox(height: 4.0),
        _tableRow(const <String>[
          'RotatedBox',
          'quarterTurns (int)',
          'No (layout-level)',
          'You need a 0/90/180/270-degree rotation that also rotates the layout box (e.g. vertical text).',
        ], alt: true),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.bolt, color: Color(0xFFB45309), size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: const Text(
                  'RotatedBox is the only one that rotates the layout box '
                  'itself, not just the painted child. Use it when you need a '
                  '90-degree rotated piece of text inside a Column - both '
                  'Transform.rotate and RotationTransition leave the box '
                  'unrotated, which makes the text overflow.',
                  style: _kBodyStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  // Six callouts covering the most common mistakes when using the rotation
  // family. Each callout has an icon, a title and a short body.
  // -------------------------------------------------------------------------
  print('  building pitfalls card');
  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.warning_amber, color: _kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Six pitfalls',
              subtitle: 'Mistakes worth filing in your muscle memory',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallCallout(
          icon: Icons.swap_horiz,
          iconColour: _kAccentRed,
          title: 'Turns vs radians confusion',
          body: 'RotationTransition / AnimatedRotation take TURNS (1.0 = '
              'full revolution). Transform.rotate takes RADIANS (2*pi = '
              'full revolution). A common bug is passing math.pi/2 where '
              'turns is expected, which produces ~94 revolutions instead '
              'of a clean quarter turn.',
        ),
        _pitfallCallout(
          icon: Icons.center_focus_weak,
          iconColour: _kAccentOrange,
          title: 'Alignment is not Transform alignment',
          body: 'RotationTransition.alignment is in the child\'s local box. '
              'Transform.rotate.alignment is also local, but Transform '
              'defaults to (0, 0) instead of center. Migrating between the '
              'two without setting alignment explicitly produces a pivot '
              'shift you may not notice on a square child.',
        ),
        _pitfallCallout(
          icon: Icons.blur_on,
          iconColour: _kAccentAmber,
          title: 'filterQuality drops on Hardware',
          body: 'Setting filterQuality lets you sample the rotated child '
              'with bilinear/cubic filtering. The default null means '
              'nearest-neighbour, which is fast but produces visible '
              'aliasing on rotated bitmaps. Always set filterQuality on '
              'rotated images, never on plain text or vector icons.',
        ),
        _pitfallCallout(
          icon: Icons.broken_image,
          iconColour: _kAccentPurple,
          title: 'Missing RepaintBoundary kills perf',
          body: 'A spinning RotationTransition repaints every frame. '
              'Without a RepaintBoundary the ancestor layer is invalidated '
              'too, dragging the whole subtree into the rotation\'s frame '
              'budget. Wrap the rotation in a RepaintBoundary for any '
              'non-trivial child.',
        ),
        _pitfallCallout(
          icon: Icons.crop_square,
          iconColour: _kAccentTeal,
          title: 'RotatedBox only supports quarter turns',
          body: 'RotatedBox(quarterTurns: int) takes an integer count of '
              '90-degree steps. There is no way to rotate it by 30 degrees '
              '- the layout-box rotation only works for axis-aligned '
              'angles. Use RotationTransition for everything else.',
        ),
        _pitfallCallout(
          icon: Icons.bug_report,
          iconColour: _kAccentRed,
          title: 'Leaked AnimationController',
          body: 'When pairing RotationTransition with a controller you '
              'created in initState, call dispose() in dispose(). A leaked '
              'controller keeps the ticker registered with the SchedulerBinding '
              'forever, which on debug builds eventually trips an assertion.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // Dark card with four chip-group rows (Widgets, Math, Tweens, Render-side)
  // and a one-line tagline. This is the page-ending visual summary.
  // -------------------------------------------------------------------------
  print('  building footer cheat-sheet');
  final Widget cheatSheet = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmark, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'One-liners and chip groups you can keep in your back pocket.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        // Group: Widgets.
        const Text(
          'Widgets',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFD60A),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _DarkChip(label: 'RotationTransition'),
            _DarkChip(label: 'AnimatedRotation'),
            _DarkChip(label: 'Transform.rotate'),
            _DarkChip(label: 'RotatedBox'),
            _DarkChip(label: 'Transform(Matrix4)'),
          ],
        ),
        const SizedBox(height: 14.0),
        // Group: Math.
        const Text(
          'Math',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFD60A),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _DarkChip(label: '1 turn = 2π rad'),
            _DarkChip(label: '0.25 turns = 90°'),
            _DarkChip(label: 'rad = turns * 2π'),
            _DarkChip(label: 'deg = turns * 360'),
            _DarkChip(label: 'cw is +θ'),
          ],
        ),
        const SizedBox(height: 14.0),
        // Group: Tweens.
        const Text(
          'Tweens',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFD60A),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _DarkChip(label: 'Tween<double>'),
            _DarkChip(label: 'CurvedAnimation'),
            _DarkChip(label: 'AlwaysStoppedAnimation<double>'),
            _DarkChip(label: 'ReverseAnimation'),
            _DarkChip(label: 'ProxyAnimation'),
            _DarkChip(label: 'Tween.chain(...)'),
          ],
        ),
        const SizedBox(height: 14.0),
        // Group: Render-side.
        const Text(
          'Render side',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFD60A),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _DarkChip(label: 'RepaintBoundary'),
            _DarkChip(label: 'filterQuality'),
            _DarkChip(label: 'Matrix4.rotationZ'),
            _DarkChip(label: 'CustomPainter'),
            _DarkChip(label: 'Canvas.rotate'),
          ],
        ),
        const SizedBox(height: 14.0),
        // Cheat rows summarising each widget signature.
        DefaultTextStyle(
          style: const TextStyle(color: _kInkOnDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _cheatRow('RotationTransition', 'RotationTransition(turns:, alignment:?, filterQuality:?, child:)'),
              _cheatRow('AnimatedRotation', 'AnimatedRotation(turns:, duration:, curve:?, child:)'),
              _cheatRow('Transform.rotate', 'Transform.rotate(angle:, alignment:?, child:)'),
              _cheatRow('RotatedBox', 'RotatedBox(quarterTurns:, child:)'),
              _cheatRow('AlwaysStoppedAnimation', 'AlwaysStoppedAnimation<double>(t)'),
              _cheatRow('Tween<double>', 'Tween<double>(begin:, end:).animate(parent)'),
              _cheatRow('CurvedAnimation', 'CurvedAnimation(parent:, curve:)'),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.flag, color: Color(0xFFFFD60A), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: const Text(
                  'Tagline: think in turns, render in radians, snapshot with '
                  'AlwaysStoppedAnimation, and wrap heavy children in a '
                  'RepaintBoundary.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // ASSEMBLE THE FULL SCROLLABLE GALLERY
  // -------------------------------------------------------------------------
  // The page is a vertical stack of section headers and the previously
  // composed cards. The whole thing sits inside a Scaffold so we get an
  // appbar for free, then in a single ListView for memory efficiency.
  // -------------------------------------------------------------------------
  print('  assembling final widget tree');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'API reference', 'turns / alignment / filterQuality / child'),
    apiTable,
    _sectionHeader(3, 'Snapshot reel', '12 RotationTransition frames in a 4x3 grid'),
    reelGallery,
    _sectionHeader(4, 'Alignment', 'Five pivots, painter overlay'),
    alignmentGallery,
    _sectionHeader(5, 'Cousins', 'AnimatedRotation vs Transform.rotate'),
    comparePanel,
    _sectionHeader(6, 'Tween + Curve', 'Plug a Tween into a RotationTransition'),
    tweenCard,
    _sectionHeader(7, 'Matrix diagram', 'How a 2D rotation matrix turns a frame'),
    matrixDiagramCard,
    _sectionDivider(),
    _sectionHeader(8, 'Code', 'Six idiomatic snippets'),
    codeBlocksSection,
    _sectionHeader(9, 'Comparison', 'Pick the right rotation widget'),
    comparisonTable,
    _sectionHeader(10, 'Pitfalls', 'Six common mistakes'),
    pitfalls,
    _sectionHeader(11, 'Cheat sheet', 'Constructors and chip groups'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  // A simple, theme-light Scaffold. We deliberately avoid CupertinoApp here
  // because this demo is about widgets/, not cupertino/.
  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kCanvas,
      primaryColor: _kAccent,
      colorScheme: const ColorScheme.light(primary: _kAccent),
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kAccent,
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          'RotationTransition',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('RotationTransition deep visual demo built successfully');
  return app;
}

// ---------------------------------------------------------------------------
// PRIVATE WIDGET HELPERS (kept at file scope, after build, for readability)
// ---------------------------------------------------------------------------

/// A small chip used in the hero intro. Pure visual sugar.
class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: const Color(0x55FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: const Color(0xFFFFFFFF), size: 14.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// A small chip used in the footer cheat-sheet (dark background).
class _DarkChip extends StatelessWidget {
  const _DarkChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: _kHairlineDark),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: _kInkOnDark,
        ),
      ),
    );
  }
}
