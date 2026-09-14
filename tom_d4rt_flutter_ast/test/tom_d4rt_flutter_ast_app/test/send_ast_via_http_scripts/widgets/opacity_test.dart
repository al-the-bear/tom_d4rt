// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, unused_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the flutter/widgets Opacity family.
//
// This file is part of the D4rt flutter-test corpus. It is executed by a
// sandboxed Dart interpreter that calls a single top-level entry point -
// `dynamic build(BuildContext)` - and renders whatever Widget is returned.
//
// The rendered output is a long static gallery that explores the four
// canonical "fade" widgets in the flutter/widgets layer and the render
// object that powers them:
//
//   * Opacity              - the eager, always-saveLayer widget.
//   * AnimatedOpacity      - implicitly animated wrapper (no controller).
//   * FadeTransition       - explicit animation driver (Animation<double>).
//   * SliverOpacity        - the sliver-flavoured sibling for slivers.
//   * RenderOpacity        - the render object that performs the compositing.
//   * alwaysIncludeSemantics - the accessibility escape hatch on every one.
//
// Each section is followed by a code block illustrating idiomatic usage,
// a comparison table that pairs the opacity widgets, a pitfalls panel with
// six callouts and finally a chip-group cheat-sheet footer. Because the
// script runs in a static, no-interaction environment, every animation is
// snapshotted with `AlwaysStoppedAnimation<double>(t)`. No `setState`,
// `Timer`, `Future` or `AnimationController` are used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The demo uses literal ARGB colours rather than theme-resolved tokens so
// the rendered output is stable across light/dark/no-theme runs. The values
// loosely follow the Material 3 palette so cards still feel native when
// rendered inside a MaterialApp.
const Color _kCanvas = Color(0xFFF4F4F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1B1F);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1B1F);
const Color _kInkSecondary = Color(0xFF49454F);
const Color _kInkTertiary = Color(0xFF79747E);
const Color _kInkOnDark = Color(0xFFE6E1E5);
const Color _kInkOnDarkSecondary = Color(0xFFCAC4D0);
const Color _kAccent = Color(0xFF6750A4);
const Color _kAccentSecondary = Color(0xFF7D5260);
const Color _kAccentBlue = Color(0xFF1976D2);
const Color _kAccentGreen = Color(0xFF2E7D32);
const Color _kAccentOrange = Color(0xFFE65100);
const Color _kAccentRed = Color(0xFFB3261E);
const Color _kAccentTeal = Color(0xFF00796B);
const Color _kAccentIndigo = Color(0xFF303F9F);
const Color _kAccentAmber = Color(0xFFF9A825);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
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
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s. They
// are intentionally not made into StatelessWidget subclasses to keep the
// file approachable to anyone reading top-to-bottom.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 28.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
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
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
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

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
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
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.5, color: subtitleColor),
        ),
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

Widget _chip(String label, IconData icon, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.30)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 13.0, color: colour),
        const SizedBox(width: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: colour,
          ),
        ),
      ],
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

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

// A checkerboard panel used as a backdrop for the opacity samples so the
// alpha channel is obvious - if a card is half-transparent, the chequer
// shows through.
Widget _checkerboard({
  required Widget child,
  double tile = 12.0,
  Color a = const Color(0xFFE0E0E0),
  Color b = const Color(0xFFF7F7F7),
  double height = 88.0,
  double width = double.infinity,
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
}) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _CheckerPainter(tile: tile, a: a, b: b)),
          Positioned.fill(child: child),
        ],
      ),
    ),
  );
}

// Painter for the chequer board backdrop.
class _CheckerPainter extends CustomPainter {
  const _CheckerPainter({
    required this.tile,
    required this.a,
    required this.b,
  });

  final double tile;
  final Color a;
  final Color b;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint pa = Paint()..color = a;
    final Paint pb = Paint()..color = b;
    canvas.drawRect(Offset.zero & size, pa);
    final int cols = (size.width / tile).ceil();
    final int rows = (size.height / tile).ceil();
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if ((x + y) % 2 == 0) {
          continue;
        }
        canvas.drawRect(
          Rect.fromLTWH(x * tile, y * tile, tile, tile),
          pb,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CheckerPainter oldDelegate) {
    return oldDelegate.tile != tile ||
        oldDelegate.a != a ||
        oldDelegate.b != b;
  }
}

// Painter for the saveLayer cost diagram in section 2. Shows the GPU
// pipeline from the raster layer down to the framebuffer, highlighting the
// extra offscreen surface that `Opacity` triggers.
class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hairline = Paint()
      ..color = _kHairline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final Paint arrow = Paint()
      ..color = _kInkSecondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Three lanes - left "fast path", centre "saveLayer", right "framebuffer".
    final double laneW = size.width / 3.0;
    final double laneH = size.height;
    final List<Color> laneColours = <Color>[
      _kAccentGreen,
      _kAccentRed,
      _kAccentBlue,
    ];
    final List<String> laneLabels = <String>[
      'Color.withAlpha',
      'Opacity widget',
      'Framebuffer',
    ];
    for (int i = 0; i < 3; i++) {
      final Rect r = Rect.fromLTWH(
        i * laneW + 6.0,
        6.0,
        laneW - 12.0,
        laneH - 12.0,
      );
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(
        rr,
        Paint()..color = laneColours[i].withOpacity(0.06),
      );
      canvas.drawRRect(rr, hairline);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: laneLabels[i],
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: laneColours[i],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: r.width);
      tp.paint(canvas, Offset(r.left + 10.0, r.top + 10.0));
    }

    // Centre lane: draw a small offscreen rectangle representing saveLayer.
    final Rect saveLayerRect = Rect.fromLTWH(
      laneW + 24.0,
      40.0,
      laneW - 48.0,
      36.0,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(saveLayerRect, const Radius.circular(6.0)),
      Paint()..color = _kAccentRed.withOpacity(0.18),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(saveLayerRect, const Radius.circular(6.0)),
      Paint()
        ..color = _kAccentRed
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Connector arrows between lanes.
    final double midY = laneH / 2.0;
    canvas.drawLine(
      Offset(laneW - 6.0, midY),
      Offset(laneW + 6.0, midY),
      arrow,
    );
    canvas.drawLine(
      Offset(laneW * 2 - 6.0, midY),
      Offset(laneW * 2 + 6.0, midY),
      arrow,
    );
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) => false;
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state must live in
// local variables and be passed by closure to the widgets below.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Opacity family deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int warmup = rng.nextInt(100);
  print('  rng warm-up: $warmup');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains the Opacity family: a widget tree of compositing
  // primitives that share one numeric input - the alpha channel multiplier.
  // The gradient hero header sets the visual tone for the rest of the demo.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF6750A4),
          Color(0xFF1976D2),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x336750A4),
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
            Icon(Icons.opacity, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'Opacity Family',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Alpha compositing in flutter/widgets',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Opacity, AnimatedOpacity, FadeTransition and SliverOpacity all '
          'do the same thing: blend their child against the background by a '
          'multiplier in [0.0, 1.0]. Underneath they delegate to '
          'RenderOpacity, which calls Canvas.saveLayer with an alpha paint - '
          'a powerful but pricey operation. Reach for them when the alpha is '
          'truly dynamic; reach for Color.withValues when it is static.',
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
          children: <Widget>[
            _pill('Compositing', colour: const Color(0xFFFFFFFF)),
            _pill('saveLayer', colour: const Color(0xFFFFFFFF)),
            _pill('RenderOpacity', colour: const Color(0xFFFFFFFF)),
            _pill('Semantics-aware', colour: const Color(0xFFFFFFFF)),
            _pill('Sliver-ready', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Icon(
              Icons.lightbulb_outline,
              color: Color(0xFFFFFFFF),
              size: 18.0,
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Rule of thumb: prefer baking alpha into the colour. Only '
                'use Opacity when the child is genuinely composite (e.g. '
                'images, text + decoration, sub-trees).',
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
  // SECTION 2 - saveLayer COST DIAGRAM
  // -------------------------------------------------------------------------
  // A custom-painted three-lane diagram explaining the GPU pipeline cost of
  // Opacity versus a cheap baked-in alpha. The middle lane shows the extra
  // saveLayer surface that Opacity allocates per paint.
  // -------------------------------------------------------------------------
  final Widget pipelineDiagram = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.layers, color: _kAccentRed, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'saveLayer cost',
              subtitle:
                  'Opacity allocates an offscreen surface per paint; '
                  'Color.withValues does not',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 110.0,
          child: CustomPaint(painter: const _PipelinePainter()),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'The Opacity widget wraps every paint in canvas.saveLayer(rect, '
          'Paint()..color = Color.fromARGB(alpha,0,0,0)..blendMode = '
          'BlendMode.srcOver). The extra surface is allocated, the subtree '
          'paints into it, and the layer is then blended back with the '
          'requested alpha. That second blit is the real cost.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('saveLayer', colour: _kAccentRed),
            _pill('offscreen surface', colour: _kAccentOrange),
            _pill('extra blit', colour: _kAccentOrange),
            _pill('per-paint cost', colour: _kAccentIndigo),
            _pill('fast path: BlendMode.srcOver', colour: _kAccentGreen),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - OPACITY GALLERY (11 STEPS)
  // -------------------------------------------------------------------------
  // Eleven cards, each wrapping the same icon+text child in an Opacity
  // widget with a different opacity value (0.0 .. 1.0 step 0.1). The
  // chequerboard backdrop makes the alpha channel visible.
  // -------------------------------------------------------------------------
  Widget _opacityCell(double t) {
    final String label = t.toStringAsFixed(1);
    return SizedBox(
      width: 110.0,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _checkerboard(
              height: 80.0,
              child: Opacity(
                opacity: t,
                child: Container(
                  alignment: Alignment.center,
                  color: _kAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.brightness_5,
                        color: Color(0xFFFFFFFF),
                        size: 22.0,
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'sun',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'opacity: $label',
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> opacityCells = <Widget>[
    _opacityCell(0.0),
    _opacityCell(0.1),
    _opacityCell(0.2),
    _opacityCell(0.3),
    _opacityCell(0.4),
    _opacityCell(0.5),
    _opacityCell(0.6),
    _opacityCell(0.7),
    _opacityCell(0.8),
    _opacityCell(0.9),
    _opacityCell(1.0),
  ];

  final Widget opacityGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.gradient,
              color: _kAccent,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Opacity gallery',
              subtitle:
                  'Same child, 11 alpha multipliers from 0.0 to 1.0 in 0.1 '
                  'steps',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: opacityCells,
        ),
        const SizedBox(height: 12.0),
        const Text(
          'All eleven instances share the same widget subtree - only the '
          'opacity input changes. RenderOpacity short-circuits to identity '
          'when opacity == 1.0 and to invisible when opacity == 0.0, so '
          'those two endpoints are free.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - AnimatedOpacity SNAPSHOT
  // -------------------------------------------------------------------------
  // Three AnimatedOpacity cards rendered at fixed target opacities. Because
  // build() is called once and we don't drive any animation controller, the
  // implicit animation never tweens - the widgets reach their target value
  // immediately. The point of this section is to show the API surface.
  // -------------------------------------------------------------------------
  Widget _animatedOpacityCard(
    double target,
    String label,
    Color colour, {
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _checkerboard(
              height: 80.0,
              child: AnimatedOpacity(
                opacity: target,
                duration: duration,
                curve: curve,
                child: Container(
                  alignment: Alignment.center,
                  color: colour,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.bolt,
                        color: Color(0xFFFFFFFF),
                        size: 22.0,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'target: ${target.toStringAsFixed(1)}',
              style: const TextStyle(
                fontSize: 11.0,
                color: _kInkSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${duration.inMilliseconds}ms',
              style: const TextStyle(
                fontSize: 10.5,
                color: _kInkTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget animatedOpacityGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.animation,
              color: _kAccentBlue,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'AnimatedOpacity',
              subtitle:
                  'Implicit animation toward a target opacity - duration + '
                  'curve, no controller',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _animatedOpacityCard(0.0, 'hidden', _kAccentRed),
            _animatedOpacityCard(0.5, 'half', _kAccentOrange),
            _animatedOpacityCard(
              1.0,
              'visible',
              _kAccentGreen,
              duration: const Duration(milliseconds: 600),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'AnimatedOpacity is an ImplicitlyAnimatedWidget: when its opacity '
          'value changes, it tweens from the previous value to the new one '
          'over `duration` using `curve`. The widget owns its own '
          'AnimationController under the hood - you never see it. Because '
          'this build runs once, no transition is captured here.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - FadeTransition REEL
  // -------------------------------------------------------------------------
  // Eleven FadeTransition widgets, each driven by an
  // AlwaysStoppedAnimation<double>(t) for t in 0.0..1.0 step 0.1. This is
  // the analyzer-friendly way to render a FadeTransition statically in a
  // sandboxed environment: the animation never advances, it just reports
  // the constant value.
  // -------------------------------------------------------------------------
  Widget _fadeCell(double t) {
    final String label = t.toStringAsFixed(1);
    return SizedBox(
      width: 110.0,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _checkerboard(
              height: 80.0,
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation<double>(t),
                child: Container(
                  alignment: Alignment.center,
                  color: _kAccentTeal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.water_drop,
                        color: Color(0xFFFFFFFF),
                        size: 22.0,
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'fade',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              't = $label',
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> fadeCells = <Widget>[
    _fadeCell(0.0),
    _fadeCell(0.1),
    _fadeCell(0.2),
    _fadeCell(0.3),
    _fadeCell(0.4),
    _fadeCell(0.5),
    _fadeCell(0.6),
    _fadeCell(0.7),
    _fadeCell(0.8),
    _fadeCell(0.9),
    _fadeCell(1.0),
  ];

  final Widget fadeTransitionReel = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.movie_filter,
              color: _kAccentTeal,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'FadeTransition reel',
              subtitle:
                  'Eleven snapshots driven by AlwaysStoppedAnimation<double> '
                  '- the analyzer-safe way to capture a fade',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: fadeCells,
        ),
        const SizedBox(height: 12.0),
        const Text(
          'FadeTransition consumes an Animation<double> instead of a raw '
          'double. In a live app it usually comes from an '
          'AnimationController; here we substitute a frozen '
          'AlwaysStoppedAnimation so the build is pure and static.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - SliverOpacity DEMO
  // -------------------------------------------------------------------------
  // A CustomScrollView with a translucent SliverList nested inside a
  // SliverOpacity(opacity: 0.4) - the entire list fades together, instead
  // of every tile fading individually. The whole scroll view is capped at a
  // fixed height so it sits comfortably inside the gallery card.
  // -------------------------------------------------------------------------
  Widget _sliverTile(int i, Color colour) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0x44FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$i',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Text(
              'Sliver item inside SliverOpacity(0.4)',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Color> _sliverColours = <Color>[
    _kAccent,
    _kAccentBlue,
    _kAccentTeal,
    _kAccentOrange,
    _kAccentSecondary,
    _kAccentIndigo,
  ];

  final Widget sliverOpacityDemo = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.view_list,
              color: _kAccentIndigo,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'SliverOpacity',
              subtitle:
                  'Fade an entire sliver - the chequer below shows alpha '
                  'leaking through tiles',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _checkerboard(
          height: 220.0,
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Opaque header (not inside SliverOpacity)',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: _kInk,
                    ),
                  ),
                ),
              ),
              SliverOpacity(
                opacity: 0.4,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext ctx, int i) =>
                        _sliverTile(i, _sliverColours[i % 6]),
                    childCount: 6,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Opaque footer (outside SliverOpacity)',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: _kInk,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'SliverOpacity wraps slivers, not boxes - you cannot nest a '
          'regular Opacity around a sliver because Opacity is a RenderBox. '
          'The widget pushes a single OpacityLayer for the whole sliver '
          'subtree, so all the tiles share one saveLayer instead of each '
          'tile allocating its own.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - withOpacity vs Opacity WIDGET COMPARISON
  // -------------------------------------------------------------------------
  // Two code-block cards side by side - or stacked on narrow screens -
  // showing the slow Opacity-widget path next to the cheap baked-in-alpha
  // path. The same visual result, two very different paint costs.
  // -------------------------------------------------------------------------
  final Widget cheapAlphaPathCode = _codeBlock(
    title: 'opacity_fast.dart - bake alpha into the colour',
    '// Fast path: a single drawRect with a translucent colour. No saveLayer.\n'
    'Container(\n'
    '  height: 50.0,\n'
    '  color: Colors.blue.withValues(alpha: 0.5),\n'
    '  child: const Center(\n'
    '    child: Text(\n'
    '      \'fast - withValues(alpha:)\',\n'
    '      style: TextStyle(color: Color(0xFFFFFFFF)),\n'
    '    ),\n'
    '  ),\n'
    ')',
  );

  final Widget expensiveAlphaPathCode = _codeBlock(
    title: 'opacity_slow.dart - wrap with the Opacity widget',
    '// Slow path: Opacity allocates an offscreen surface every paint.\n'
    'Opacity(\n'
    '  opacity: 0.5,\n'
    '  child: Container(\n'
    '    height: 50.0,\n'
    '    color: Colors.blue,\n'
    '    child: const Center(\n'
    '      child: Text(\n'
    '        \'slow - Opacity widget\',\n'
    '        style: TextStyle(color: Color(0xFFFFFFFF)),\n'
    '      ),\n'
    '    ),\n'
    '  ),\n'
    ')',
  );

  final Widget cheapAlphaSample = _checkerboard(
    height: 60.0,
    child: Container(
      color: const Color(0x801976D2),
      alignment: Alignment.center,
      child: const Text(
        'fast - Colors.blue.withValues(alpha: 0.5)',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
        ),
      ),
    ),
  );

  final Widget slowAlphaSample = _checkerboard(
    height: 60.0,
    child: Opacity(
      opacity: 0.5,
      child: Container(
        color: const Color(0xFF1976D2),
        alignment: Alignment.center,
        child: const Text(
          'slow - Opacity(opacity: 0.5)',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),
        ),
      ),
    ),
  );

  final Widget comparisonCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.compare_arrows,
              color: _kAccentGreen,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Fast vs slow alpha',
              subtitle:
                  'Two identical visuals - one bakes alpha, the other '
                  'allocates a layer',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        cheapAlphaSample,
        const SizedBox(height: 8.0),
        slowAlphaSample,
        const SizedBox(height: 8.0),
        const Text(
          'Identical pixels, very different costs. The fast path bakes the '
          'alpha into the fill colour so RenderObject.paint emits a single '
          'drawRect. The slow path forces a saveLayer + drawRect + restore '
          'on every frame.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - HIT-TESTING & SEMANTICS PITFALLS
  // -------------------------------------------------------------------------
  // Opacity widgets still hit-test even at opacity 0.0 - they merely become
  // invisible, not non-existent. Six pitfall cards walk through the most
  // common consequences for accessibility and gesture handling.
  // -------------------------------------------------------------------------
  Widget _pitfallCard(
    IconData icon,
    String title,
    String body,
    Color colour,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colour.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colour.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colour, size: 16.0),
          ),
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
                    color: colour,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: _kInk,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.report_problem,
              color: _kAccentOrange,
              size: 20.0,
            ),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Hit-testing & semantics',
              subtitle:
                  'Six pitfalls that bite when alpha hides UI but not the '
                  'click target',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallCard(
          Icons.touch_app,
          'Opacity(0.0) still hit-tests',
          'A child wrapped in Opacity(opacity: 0.0) is invisible but still '
          'absorbs taps. Wrap it in IgnorePointer or use Visibility(visible: '
          'false) when you also want to remove the hit region.',
          _kAccentRed,
        ),
        _pitfallCard(
          Icons.accessibility_new,
          'alwaysIncludeSemantics: false (the default)',
          'By default an invisible Opacity drops its child\'s semantics, so '
          'screen readers won\'t announce it. Pass '
          '`alwaysIncludeSemantics: true` to keep the subtree accessible '
          'even when alpha is zero.',
          _kAccentOrange,
        ),
        _pitfallCard(
          Icons.speed,
          'AnimatedOpacity churn',
          'Wrapping a frequently-rebuilt subtree in AnimatedOpacity means '
          'the child relayouts every tick. If the child is a heavy widget, '
          'consider memoizing it via const constructors or extracting it '
          'above AnimatedOpacity.',
          _kAccentIndigo,
        ),
        _pitfallCard(
          Icons.layers,
          'Per-tile vs per-list opacity',
          'Wrapping every list item in an Opacity allocates one saveLayer '
          'per tile. Prefer a single SliverOpacity around the SliverList - '
          'or an Opacity around the parent box for a fixed list - to share '
          'one layer.',
          _kAccentTeal,
        ),
        _pitfallCard(
          Icons.image,
          'Image + Opacity = double cost',
          'An Image already has its own paint pass; wrapping it in an '
          'Opacity adds a second. For static fades, use '
          'Image(opacity: AlwaysStoppedAnimation<double>(t)) or '
          'ColorFilter.matrix to bake the alpha into the existing pass.',
          _kAccentSecondary,
        ),
        _pitfallCard(
          Icons.warning,
          'opacity must be in [0.0, 1.0]',
          'Both Opacity and FadeTransition assert their input is finite and '
          'inside [0, 1]. Clamp computed values with .clamp(0.0, 1.0) before '
          'feeding them in; NaN or Infinity will crash debug builds.',
          _kAccentRed,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // A five-row comparison table comparing each member of the Opacity family
  // along five axes: input type, animates?, allocates saveLayer?, sliver
  // support, typical use case.
  // -------------------------------------------------------------------------
  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _kAccent.withOpacity(0.10),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              'Widget',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          SizedBox(
            width: 120.0,
            child: Text(
              'Input',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              'Animates',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          SizedBox(
            width: 95.0,
            child: Text(
              'saveLayer',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Best use',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableRow(
    String widget,
    String input,
    String animates,
    String saveLayer,
    String useCase, {
    bool zebra = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: zebra ? _kCanvas : _kCardBg,
        border: const Border(
          bottom: BorderSide(color: _kHairline),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              widget,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: _kInk,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 120.0,
            child: Text(
              input,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSecondary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              animates,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSecondary,
              ),
            ),
          ),
          SizedBox(
            width: 95.0,
            child: Text(
              saveLayer,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              useCase,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSecondary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparisonTable = _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 8.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.table_chart,
                color: _kAccentBlue,
                size: 20.0,
              ),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Comparison',
                subtitle:
                    'Opacity vs Color.withValues vs AnimatedOpacity vs '
                    'FadeTransition vs SliverOpacity',
              ),
            ],
          ),
        ),
        _tableHeader(),
        _tableRow(
          'Opacity',
          'double',
          'no',
          'yes',
          'Static alpha around a small box subtree',
        ),
        _tableRow(
          'Color.withValues',
          'Color + alpha',
          'no',
          'no',
          'Bake alpha into a single fill - cheapest path',
          zebra: true,
        ),
        _tableRow(
          'AnimatedOpacity',
          'double + curve',
          'yes (implicit)',
          'yes',
          'Cross-fade between two static states with no controller',
        ),
        _tableRow(
          'FadeTransition',
          'Animation<double>',
          'yes (driven)',
          'yes',
          'Hooked to your own AnimationController / curved animation',
          zebra: true,
        ),
        _tableRow(
          'SliverOpacity',
          'double',
          'no',
          'yes (1 layer)',
          'Fade a sliver subtree with a single OpacityLayer',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - IDIOMATIC CODE BLOCKS
  // -------------------------------------------------------------------------
  // Six code-blocks demonstrating idiomatic usage of every member of the
  // Opacity family. Each block is a self-contained, copy-pasteable snippet.
  // -------------------------------------------------------------------------
  final Widget codeBasicOpacity = _codeBlock(
    title: '01_basic_opacity.dart',
    '// Static alpha around a complex subtree.\n'
    'Opacity(\n'
    '  opacity: 0.6,\n'
    '  child: const Card(\n'
    '    child: ListTile(\n'
    '      leading: Icon(Icons.bolt),\n'
    '      title: Text(\'translucent tile\'),\n'
    '    ),\n'
    '  ),\n'
    ')',
  );

  final Widget codeWithValues = _codeBlock(
    title: '02_with_values_fast_path.dart',
    '// Skip saveLayer entirely by baking alpha into the fill colour.\n'
    'Container(\n'
    '  height: 50.0,\n'
    '  color: Colors.deepPurple.withValues(alpha: 0.5),\n'
    '  alignment: Alignment.center,\n'
    '  child: const Text(\n'
    '    \'fast: no extra layer\',\n'
    '    style: TextStyle(color: Color(0xFFFFFFFF)),\n'
    '  ),\n'
    ')',
  );

  final Widget codeAnimatedOpacity = _codeBlock(
    title: '03_animated_opacity.dart',
    '// Cross-fade based on a stateful boolean - implicit animation.\n'
    'AnimatedOpacity(\n'
    '  opacity: _visible ? 1.0 : 0.0,\n'
    '  duration: const Duration(milliseconds: 240),\n'
    '  curve: Curves.easeInOut,\n'
    '  child: const Banner(),\n'
    ')',
  );

  final Widget codeFadeTransition = _codeBlock(
    title: '04_fade_transition.dart',
    '// Drive a fade from your own AnimationController.\n'
    'final CurvedAnimation _fade = CurvedAnimation(\n'
    '  parent: _controller,\n'
    '  curve: Curves.easeOut,\n'
    ');\n'
    '\n'
    'FadeTransition(\n'
    '  opacity: _fade,\n'
    '  child: const Hero(tag: \'avatar\', child: Avatar()),\n'
    ')',
  );

  final Widget codeSliverOpacity = _codeBlock(
    title: '05_sliver_opacity.dart',
    '// Fade an entire sliver with one OpacityLayer.\n'
    'CustomScrollView(\n'
    '  slivers: <Widget>[\n'
    '    const SliverAppBar(title: Text(\'Inbox\')),\n'
    '    SliverOpacity(\n'
    '      opacity: _isArchived ? 0.45 : 1.0,\n'
    '      sliver: SliverList(\n'
    '        delegate: SliverChildBuilderDelegate(\n'
    '          (BuildContext c, int i) => MessageTile(messages[i]),\n'
    '          childCount: messages.length,\n'
    '        ),\n'
    '      ),\n'
    '    ),\n'
    '  ],\n'
    ')',
  );

  final Widget codeAlwaysSemantics = _codeBlock(
    title: '06_always_include_semantics.dart',
    '// Keep a fully-faded subtree accessible to screen readers.\n'
    'Opacity(\n'
    '  opacity: 0.0,\n'
    '  alwaysIncludeSemantics: true,\n'
    '  child: const Text(\'Status: offline\'),\n'
    ')\n'
    '\n'
    '// Same flag is available on AnimatedOpacity, FadeTransition,\n'
    '// SliverOpacity and SliverFadeTransition.',
  );

  final Widget codeBlocksSection = _card(
    padding: const EdgeInsets.fromLTRB(2.0, 14.0, 2.0, 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.code,
                color: _kAccent,
                size: 20.0,
              ),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Idiomatic snippets',
                subtitle:
                    'Six copy-pasteable examples - one for each member of '
                    'the family',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        codeBasicOpacity,
        codeWithValues,
        codeAnimatedOpacity,
        codeFadeTransition,
        codeSliverOpacity,
        codeAlwaysSemantics,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // Four chip groups summarising the demo: widgets, render layer, pipeline
  // notes, performance tips. Final tagline closes the file.
  // -------------------------------------------------------------------------
  Widget _chipGroup(String title, List<Widget> chips) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: _kInkOnDarkSecondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: chips,
          ),
        ],
      ),
    );
  }

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
            Icon(Icons.menu_book, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat Sheet',
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
          'Five chip groups summarising the Opacity family.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        _chipGroup('Widgets', <Widget>[
          _chip('Opacity', Icons.opacity, _kAccent),
          _chip('AnimatedOpacity', Icons.animation, _kAccentBlue),
          _chip('FadeTransition', Icons.movie_filter, _kAccentTeal),
          _chip('SliverOpacity', Icons.view_list, _kAccentIndigo),
          _chip('SliverFadeTransition', Icons.list_alt, _kAccentSecondary),
        ]),
        _chipGroup('Render layer', <Widget>[
          _chip('RenderOpacity', Icons.layers, _kAccentRed),
          _chip('RenderAnimatedOpacity', Icons.layers_outlined, _kAccentBlue),
          _chip('OpacityLayer', Icons.filter_none, _kAccentOrange),
          _chip('SliverOpacityLayer', Icons.filter_none, _kAccentSecondary),
        ]),
        _chipGroup('Pipeline', <Widget>[
          _chip('saveLayer', Icons.layers, _kAccentRed),
          _chip('offscreen surface', Icons.filter, _kAccentOrange),
          _chip('extra blit', Icons.compare, _kAccentOrange),
          _chip('BlendMode.srcOver', Icons.blender, _kAccentTeal),
          _chip('alpha multiplier', Icons.percent, _kAccentGreen),
        ]),
        _chipGroup('Perf', <Widget>[
          _chip('opacity == 1.0: free', Icons.flash_on, _kAccentGreen),
          _chip('opacity == 0.0: skipped', Icons.fast_forward, _kAccentGreen),
          _chip('intermediate: 1 layer', Icons.layers, _kAccentOrange),
          _chip('per-tile fades: AVOID', Icons.warning, _kAccentRed),
          _chip('share with SliverOpacity', Icons.share, _kAccentBlue),
        ]),
        _chipGroup('Semantics', <Widget>[
          _chip('alwaysIncludeSemantics', Icons.accessibility, _kAccentBlue),
          _chip('IgnorePointer for alpha 0', Icons.touch_app, _kAccentRed),
          _chip('Visibility(visible: false)', Icons.visibility_off, _kAccentIndigo),
          _chip('clamp [0, 1]', Icons.code, _kAccentOrange),
        ]),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2B30),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: const <Widget>[
              Icon(
                Icons.info_outline,
                color: Color(0xFFFFD60A),
                size: 18.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tagline: alpha is not free - every Opacity is a saveLayer. '
                  'Bake it into the colour when you can, animate it through '
                  'AnimatedOpacity/FadeTransition when you must, and share '
                  'one SliverOpacity across lists.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
                    height: 1.45,
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
  // Each section is preceded by a numbered header. The whole thing lives
  // inside a MaterialApp with debug banner disabled and a single ListView
  // body for cheap, lazy section construction.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'saveLayer cost', 'Pipeline diagram with custom paint'),
    pipelineDiagram,
    _sectionHeader(3, 'Opacity gallery', '11 alpha values, identical child'),
    opacityGallery,
    _sectionHeader(4, 'AnimatedOpacity', 'Implicit animation snapshots'),
    animatedOpacityGallery,
    _sectionHeader(5, 'FadeTransition', 'Driven by AlwaysStoppedAnimation'),
    fadeTransitionReel,
    _sectionHeader(6, 'SliverOpacity', 'Fade a whole sliver subtree'),
    sliverOpacityDemo,
    _sectionDivider(),
    _sectionHeader(7, 'Fast vs slow', 'withValues vs Opacity widget'),
    comparisonCard,
    _sectionHeader(8, 'Pitfalls', 'Hit-testing and semantics traps'),
    pitfalls,
    _sectionHeader(9, 'Comparison', 'Five-row decision table'),
    comparisonTable,
    _sectionHeader(10, 'Code', 'Six idiomatic snippets'),
    codeBlocksSection,
    _sectionHeader(11, 'Cheat sheet', 'Chip groups + tagline'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Opacity Family Demo',
    theme: ThemeData(
      colorSchemeSeed: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        title: const Text('flutter/widgets - Opacity family'),
        backgroundColor: _kCardBg,
        foregroundColor: _kInk,
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

  print('Opacity family deep visual demo built successfully');
  return app;
}
