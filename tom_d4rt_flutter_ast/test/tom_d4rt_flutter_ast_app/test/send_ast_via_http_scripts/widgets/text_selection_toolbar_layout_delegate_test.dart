// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  SEXTANT INDIGO :: TextSelectionToolbarLayoutDelegate Atlas
// =============================================================================
//
//  THEME
//  -----
//  "Sextant Indigo" -- a navigator's brass sextant set against an indigo-blue
//  night sky. Every viewport in this demo is treated as a stretch of horizon;
//  every toolbar is a star sighted through a brass eyepiece; every anchor pair
//  is two crossed sight-lines on a hand-drawn arc gradient. The palette runs
//  from deep indigo through midnight blue, brass-yellow scale-marks, ivory
//  parchment, and the dim red of a navigator's chartroom lamp.
//
//  SUBJECT
//  -------
//  TextSelectionToolbarLayoutDelegate is the SingleChildLayoutDelegate that
//  Flutter uses to position the floating text-selection toolbar (the "Cut /
//  Copy / Paste" bubble) above or below a selection. It receives:
//
//     * anchorAbove -- where the toolbar should anchor if it FITS above
//                       (typically the top of the selection rect).
//     * anchorBelow -- where the toolbar should anchor if it does NOT fit
//                       above (typically the bottom of the selection rect).
//     * fitsAbove   -- an optional bool override; when null, the delegate
//                       computes whether the toolbar's child fits above.
//
//  Its three methods of interest are:
//
//     1. getConstraintsForChild(BoxConstraints) -> BoxConstraints
//          Loosens the parent constraints, letting the toolbar shrink-wrap.
//     2. getPositionForChild(Size, Size) -> Offset
//          Decides where to place the toolbar's child given the parent size
//          and the toolbar's measured size. Centers horizontally with the
//          static centerOn(...) clamp.
//     3. shouldRelayout(TextSelectionToolbarLayoutDelegate) -> bool
//          Returns true if anchorAbove, anchorBelow, or fitsAbove changed.
//
//  Plus the static helper:
//
//     centerOn(double position, double width, double max) -> double
//        Centers a `width` band around `position` along an axis of length
//        `max`, clamped so that the band cannot leave the [0, max - width]
//        range. This is how the toolbar's left edge is computed.
//
//  PHILOSOPHY
//  ----------
//  The selection toolbar is a tiny, polite widget. It must hover near the
//  selection without occluding it; it must not run off the screen edge; it
//  must flip below the selection when the keyboard or status bar would clip
//  it above. It does all three things with simple arithmetic on offsets and
//  a clamp -- no animation, no measurement of safe areas, no mystery. This
//  script reads that arithmetic out loud, like a navigator's logbook.
//
//  SECTIONS
//  --------
//   1. Title banner with Sextant Indigo palette swatches.
//   2. Prose anatomy -- what SingleChildLayoutDelegate IS and IS NOT.
//   3. Anchor geometry -- anchorAbove and anchorBelow on a viewport.
//   4. getPositionForChild walkthrough -- 10+ hand-fed (parent, child, anchor)
//      tuples and their resolved Offsets, rendered as before/after cards.
//   5. centerOn static demo -- 12+ (position, width, max) triples on a brass
//      scale, showing where each clamp lands.
//   6. shouldRelayout semantics -- mutate anchors and observe the result.
//   7. CustomSingleChildLayout comparison -- how a host widget consumes this.
//   8. Accessibility considerations -- pointer + screen reader interaction.
//   9. DO / AVOID callouts -- six rules of toolbar positioning.
//  10. Code-snippet cards -- four canonical recipes.
//  11. Glossary -- twelve terms.
//  12. Recap footer -- Sextant Indigo closing motto.
//
//  RULES OF THE ROAD (D4RT CONSTRAINTS)
//  ------------------------------------
//   * build(context) is invoked exactly ONCE; we return a frozen tree.
//   * No StatefulWidget, no setState, no controllers, no timers.
//   * No streams, no futures, no animation tickers.
//   * No `for-in` loops over BridgedInstance values.
//   * No `.value` reads on Tween.animate(...) results.
//   * Use `Color.withValues(alpha: ...)` instead of `withOpacity`.
//   * Real identifiers: TextSelectionToolbarLayoutDelegate, Offset, Size.
//   * Narrate the script with print(...) calls.
//
//  ATTRIBUTION
//  -----------
//  Sextant Indigo is a fictional design language invented for this teaching
//  artifact. It draws on chartroom illustration, brass-and-indigo aesthetics,
//  and the "anchor-above-or-below" geometry of Flutter's selection toolbar.
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PALETTE -- "Sextant Indigo"
// ---------------------------------------------------------------------------
//
// Sixteen named colours. Each one is used at least once in the demo body.
// Names are deliberately evocative -- "BrassScaleMark" tells you what the
// colour is for before you have to read the code that consumes it.
//

const Color kSextantIndigo       = Color(0xFF1B2A4E); // deepest indigo backdrop
const Color kMidnightBlue        = Color(0xFF223865); // panel surface
const Color kHorizonNavy         = Color(0xFF2E4A7F); // section card surface
const Color kArcGradientStart    = Color(0xFF3B5FA6); // arc gradient left
const Color kArcGradientEnd      = Color(0xFF6F8DC9); // arc gradient right
const Color kBrassScaleMark      = Color(0xFFCBA64B); // scale ticks, eyepiece
const Color kBrassDeep           = Color(0xFF8C6E1E); // tarnished brass
const Color kIvoryParchment      = Color(0xFFF1E6C6); // body text on indigo
const Color kStarShine           = Color(0xFFFAF6E6); // raised tile background
const Color kChartroomLamp       = Color(0xFFD96A4A); // dim red AVOID highlight
const Color kHorizonGlow         = Color(0xFF7FB1D8); // accent for "fits above"
const Color kAnchorRust          = Color(0xFFB7572F); // accent for "anchor below"
const Color kCompassInk          = Color(0xFF0E1426); // primary text on light
const Color kSextantShadow       = Color(0xFF11192E); // diagram fill
const Color kCloudIvory          = Color(0xFFE6DEC2); // soft callout
const Color kPlumLogbook         = Color(0xFF5B3A6B); // glossary accent

// ---------------------------------------------------------------------------
// TYPOGRAPHY HELPERS
// ---------------------------------------------------------------------------

TextStyle _h1() => const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: kStarShine,
      letterSpacing: 0.4,
    );

TextStyle _h2() => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: kIvoryParchment,
      letterSpacing: 0.2,
    );

TextStyle _h3() => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kIvoryParchment,
    );

TextStyle _body() => const TextStyle(
      fontSize: 13,
      height: 1.45,
      color: kIvoryParchment,
    );

TextStyle _bodyDark() => const TextStyle(
      fontSize: 13,
      height: 1.45,
      color: kCompassInk,
    );

TextStyle _mono() => const TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      color: kIvoryParchment,
      height: 1.4,
    );

TextStyle _label() => const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: kBrassScaleMark,
    );

// ---------------------------------------------------------------------------
// LITTLE BUILDING BLOCKS
// ---------------------------------------------------------------------------

Widget _gap(double h) => SizedBox(height: h);
Widget _gapW(double w) => SizedBox(width: w);

Widget _swatch(Color c, String name, String purpose) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.all(8),
    width: 178,
    decoration: BoxDecoration(
      color: kStarShine,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kCompassInk.withValues(alpha: 0.30)),
          ),
        ),
        _gapW(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: kCompassInk)),
              _gap(2),
              Text(purpose,
                  style: const TextStyle(
                      fontSize: 10.5,
                      color: kCompassInk,
                      height: 1.2)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionCard(
    {required String tag, required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kHorizonNavy.withValues(alpha: 0.72),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kBrassScaleMark,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(tag,
                  style: const TextStyle(
                      color: kSextantIndigo,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0)),
            ),
            _gapW(10),
            Expanded(child: Text(title, style: _h2())),
          ],
        ),
        _gap(10),
        child,
      ],
    ),
  );
}

Widget _kvLine(String k, String v, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220,
          child: Text(k,
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: accent ?? kBrassScaleMark)),
        ),
        Expanded(child: Text(v, style: _mono())),
      ],
    ),
  );
}

Widget _bullet(String s) {
  return Padding(
    padding: const EdgeInsets.only(left: 6, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('-  ',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kBrassScaleMark)),
        Expanded(child: Text(s, style: _body())),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kSextantShadow,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.35)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: kIvoryParchment,
            height: 1.4)),
  );
}

Widget _calloutDo(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kHorizonGlow.withValues(alpha: 0.30),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
          left: BorderSide(width: 4, color: kHorizonGlow)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DO  $head', style: _label()),
        _gap(4),
        Text(body, style: _body()),
      ],
    ),
  );
}

Widget _calloutAvoid(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kChartroomLamp.withValues(alpha: 0.30),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
          left: BorderSide(width: 4, color: kChartroomLamp)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AVOID  $head',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: kChartroomLamp)),
        _gap(4),
        Text(body, style: _body()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// VIEWPORT CARD -- a small painted "horizon" with a toolbar block
// ---------------------------------------------------------------------------
//
// Each viewport card visually encodes a (parentSize, childSize, anchorAbove,
// anchorBelow, position) tuple so the reader can SEE the geometry the
// delegate would compute. Everything is hand-drawn with Containers and
// Stack -- no actual layout protocol is run inside d4rt.
//

Widget _viewportCard({
  required String title,
  required String subtitle,
  required double parentW,
  required double parentH,
  required double childW,
  required double childH,
  required Offset anchorAbove,
  required Offset anchorBelow,
  required Offset resolvedPos,
  required bool fitsAbove,
}) {
  // Scale down for display
  const double scale = 0.45;
  final double dispParentW = parentW * scale;
  final double dispParentH = parentH * scale;
  final double dispChildW = childW * scale;
  final double dispChildH = childH * scale;
  final double dispChildX = resolvedPos.dx * scale;
  final double dispChildY = resolvedPos.dy * scale;
  final double dispAboveX = anchorAbove.dx * scale;
  final double dispAboveY = anchorAbove.dy * scale;
  final double dispBelowX = anchorBelow.dx * scale;
  final double dispBelowY = anchorBelow.dy * scale;

  return Container(
    margin: const EdgeInsets.only(right: 12, bottom: 12),
    padding: const EdgeInsets.all(10),
    width: 320,
    decoration: BoxDecoration(
      color: kStarShine,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: kCompassInk)),
        const SizedBox(height: 2),
        Text(subtitle,
            style: const TextStyle(
                fontSize: 11,
                color: kCompassInk,
                height: 1.3)),
        const SizedBox(height: 8),
        // --- The painted viewport ---
        Container(
          width: dispParentW,
          height: dispParentH,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kArcGradientStart, kArcGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kCompassInk.withValues(alpha: 0.4)),
          ),
          child: Stack(
            children: [
              // anchorAbove dot (horizon glow)
              Positioned(
                left: dispAboveX - 3,
                top: dispAboveY - 3,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kHorizonGlow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // anchorBelow dot (anchor rust)
              Positioned(
                left: dispBelowX - 3,
                top: dispBelowY - 3,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kAnchorRust,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // resolved toolbar block
              Positioned(
                left: dispChildX,
                top: dispChildY,
                child: Container(
                  width: dispChildW,
                  height: dispChildH,
                  decoration: BoxDecoration(
                    color: kBrassScaleMark.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: kBrassDeep, width: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
            'parent = ${parentW.toStringAsFixed(0)} x ${parentH.toStringAsFixed(0)}',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kCompassInk)),
        Text(
            'child  = ${childW.toStringAsFixed(0)} x ${childH.toStringAsFixed(0)}',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kCompassInk)),
        Text(
            'aboveA = (${anchorAbove.dx.toStringAsFixed(0)}, ${anchorAbove.dy.toStringAsFixed(0)})',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kCompassInk)),
        Text(
            'belowA = (${anchorBelow.dx.toStringAsFixed(0)}, ${anchorBelow.dy.toStringAsFixed(0)})',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kCompassInk)),
        Text(
            'fitsAb = $fitsAbove',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: kCompassInk)),
        Text(
            'pos    = (${resolvedPos.dx.toStringAsFixed(1)}, ${resolvedPos.dy.toStringAsFixed(1)})',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: kAnchorRust)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SCALE TILE -- a brass scale-mark for centerOn(...) demos
// ---------------------------------------------------------------------------

Widget _scaleTile({
  required double position,
  required double width,
  required double max,
  required double resolved,
  required String note,
}) {
  const double scale = 0.55;
  final double dispMax = max * scale;
  final double dispWidth = width * scale;
  final double dispResolved = resolved * scale;
  final double dispPos = position * scale;

  return Container(
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    padding: const EdgeInsets.all(10),
    width: 320,
    decoration: BoxDecoration(
      color: kStarShine,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'centerOn(${position.toStringAsFixed(0)}, '
            '${width.toStringAsFixed(0)}, '
            '${max.toStringAsFixed(0)})',
            style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: kCompassInk,
                fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Text(note,
            style: const TextStyle(
                fontSize: 11,
                color: kCompassInk,
                height: 1.3)),
        const SizedBox(height: 8),
        // --- The brass scale ---
        Container(
          width: dispMax,
          height: 28,
          decoration: BoxDecoration(
            color: kSextantIndigo,
            borderRadius: BorderRadius.circular(3),
            border:
                Border.all(color: kBrassScaleMark.withValues(alpha: 0.6)),
          ),
          child: Stack(
            children: [
              // tick marks every 50px (scaled)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: kBrassScaleMark),
              ),
              Positioned(
                left: dispMax * 0.25,
                top: 4,
                bottom: 4,
                child: Container(width: 1, color: kBrassScaleMark),
              ),
              Positioned(
                left: dispMax * 0.5,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: kBrassScaleMark),
              ),
              Positioned(
                left: dispMax * 0.75,
                top: 4,
                bottom: 4,
                child: Container(width: 1, color: kBrassScaleMark),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: kBrassScaleMark),
              ),
              // position marker (horizon glow vertical line)
              Positioned(
                left: dispPos - 1,
                top: -2,
                bottom: -2,
                child: Container(width: 2, color: kHorizonGlow),
              ),
              // resolved band (brass deep)
              Positioned(
                left: dispResolved,
                top: 8,
                bottom: 8,
                child: Container(
                  width: dispWidth,
                  decoration: BoxDecoration(
                    color: kBrassScaleMark.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: kBrassDeep, width: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('resolved left = ${resolved.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: kAnchorRust)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// LOGBOOK ENTRY -- prose card on indigo
// ---------------------------------------------------------------------------

Widget _logbookEntry(String date, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kCloudIvory,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassDeep.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LOGBOOK -- $date',
            style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: kPlumLogbook)),
        const SizedBox(height: 6),
        Text(body, style: _bodyDark()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=========================================================');
  print('Sextant Indigo -- TextSelectionToolbarLayoutDelegate');
  print('=========================================================');
  print('[Sextant Indigo] charting selection-toolbar geometry...');

  // -------------------------------------------------------------------------
  // CONSTRUCT 12 DELEGATES with varied (anchorAbove, anchorBelow, fitsAbove)
  // -------------------------------------------------------------------------
  final dCenteredFit = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(200, 100),
    anchorBelow: const Offset(200, 200),
  );
  final dCenteredNoFit = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(200, 8),
    anchorBelow: const Offset(200, 60),
  );
  final dForcedAbove = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(150, 80),
    anchorBelow: const Offset(150, 180),
    fitsAbove: true,
  );
  final dForcedBelow = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(150, 80),
    anchorBelow: const Offset(150, 180),
    fitsAbove: false,
  );
  final dLeftEdge = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(20, 120),
    anchorBelow: const Offset(20, 220),
  );
  final dRightEdge = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(380, 120),
    anchorBelow: const Offset(380, 220),
  );
  final dNearTop = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(200, 4),
    anchorBelow: const Offset(200, 50),
  );
  final dNearBottom = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(200, 540),
    anchorBelow: const Offset(200, 580),
  );
  final dWide = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(300, 200),
    anchorBelow: const Offset(300, 280),
  );
  final dNarrow = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(50, 160),
    anchorBelow: const Offset(50, 220),
  );
  final dFlush = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(0, 0),
    anchorBelow: const Offset(0, 0),
  );
  final dDiag = TextSelectionToolbarLayoutDelegate(
    anchorAbove: const Offset(120, 90),
    anchorBelow: const Offset(160, 230),
  );

  print('[Sextant Indigo] dCenteredFit  above=${dCenteredFit.anchorAbove}'
      ' below=${dCenteredFit.anchorBelow}');
  print('[Sextant Indigo] dForcedAbove  fitsAbove=${dForcedAbove.fitsAbove}');
  print('[Sextant Indigo] dForcedBelow  fitsAbove=${dForcedBelow.fitsAbove}');
  print('[Sextant Indigo] dLeftEdge     above=${dLeftEdge.anchorAbove}');
  print('[Sextant Indigo] dRightEdge    above=${dRightEdge.anchorAbove}');

  // -------------------------------------------------------------------------
  // EXERCISE centerOn(...) STATIC METHOD
  // -------------------------------------------------------------------------
  // Twelve hand-fed (position, width, max) triples. We compute the resolved
  // `left` value via the actual static call so we can assert behaviour later.
  //
  final c01 = TextSelectionToolbarLayoutDelegate.centerOn(100, 50, 400);
  final c02 = TextSelectionToolbarLayoutDelegate.centerOn(0, 50, 400);
  final c03 = TextSelectionToolbarLayoutDelegate.centerOn(400, 50, 400);
  final c04 = TextSelectionToolbarLayoutDelegate.centerOn(200, 100, 400);
  final c05 = TextSelectionToolbarLayoutDelegate.centerOn(50, 200, 400);
  final c06 = TextSelectionToolbarLayoutDelegate.centerOn(350, 200, 400);
  final c07 = TextSelectionToolbarLayoutDelegate.centerOn(200, 50, 100);
  final c08 = TextSelectionToolbarLayoutDelegate.centerOn(0, 0, 400);
  final c09 = TextSelectionToolbarLayoutDelegate.centerOn(200, 400, 400);
  final c10 = TextSelectionToolbarLayoutDelegate.centerOn(150, 80, 300);
  final c11 = TextSelectionToolbarLayoutDelegate.centerOn(290, 80, 300);
  final c12 = TextSelectionToolbarLayoutDelegate.centerOn(10, 80, 300);

  print('[Sextant Indigo] centerOn(100,50,400) = $c01');
  print('[Sextant Indigo] centerOn(  0,50,400) = $c02');
  print('[Sextant Indigo] centerOn(400,50,400) = $c03');
  print('[Sextant Indigo] centerOn(200,100,400)= $c04');
  print('[Sextant Indigo] centerOn( 50,200,400)= $c05');
  print('[Sextant Indigo] centerOn(350,200,400)= $c06');
  print('[Sextant Indigo] centerOn(200, 50,100)= $c07');
  print('[Sextant Indigo] centerOn(  0,  0,400)= $c08');
  print('[Sextant Indigo] centerOn(200,400,400)= $c09');
  print('[Sextant Indigo] centerOn(150, 80,300)= $c10');
  print('[Sextant Indigo] centerOn(290, 80,300)= $c11');
  print('[Sextant Indigo] centerOn( 10, 80,300)= $c12');

  // -------------------------------------------------------------------------
  // SHOULD-RELAYOUT EXERCISES
  // -------------------------------------------------------------------------
  final relSame = dCenteredFit.shouldRelayout(
    TextSelectionToolbarLayoutDelegate(
      anchorAbove: const Offset(200, 100),
      anchorBelow: const Offset(200, 200),
    ),
  );
  final relMovedAbove = dCenteredFit.shouldRelayout(
    TextSelectionToolbarLayoutDelegate(
      anchorAbove: const Offset(201, 100),
      anchorBelow: const Offset(200, 200),
    ),
  );
  final relMovedBelow = dCenteredFit.shouldRelayout(
    TextSelectionToolbarLayoutDelegate(
      anchorAbove: const Offset(200, 100),
      anchorBelow: const Offset(200, 201),
    ),
  );
  final relFitFlipped = dForcedAbove.shouldRelayout(dForcedBelow);

  print('[Sextant Indigo] shouldRelayout same          = $relSame');
  print('[Sextant Indigo] shouldRelayout above-moved   = $relMovedAbove');
  print('[Sextant Indigo] shouldRelayout below-moved   = $relMovedBelow');
  print('[Sextant Indigo] shouldRelayout fits-flipped  = $relFitFlipped');

  print('[Sextant Indigo] sections to render: 12');

  // =========================================================================
  // SECTION 1 -- TITLE BANNER + PALETTE
  // =========================================================================
  final s1 = Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kSextantIndigo, kMidnightBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SEXTANT INDIGO',
            style: TextStyle(
                color: kBrassScaleMark,
                fontSize: 12,
                letterSpacing: 4.0,
                fontWeight: FontWeight.w700)),
        _gap(6),
        Text('TextSelectionToolbarLayoutDelegate',
            style: _h1().copyWith(color: kStarShine, fontSize: 24)),
        _gap(6),
        Text(
          'A SingleChildLayoutDelegate that positions the floating selection '
          'toolbar above or below a selection. It receives anchorAbove and '
          'anchorBelow Offsets, decides whether the toolbar fits above the '
          'selection, and centers the toolbar horizontally with a clamp. '
          'This is the brass instrument behind every Cut/Copy/Paste bubble '
          'you have ever seen in a Material or Cupertino text field.',
          style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: kIvoryParchment.withValues(alpha: 0.95)),
        ),
        _gap(14),
        Text('PALETTE -- SEXTANT INDIGO',
            style: TextStyle(
                color: kBrassScaleMark.withValues(alpha: 0.95),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6)),
        _gap(8),
        Wrap(
          children: [
            _swatch(kSextantIndigo, 'SextantIndigo', 'page background, deep night sky'),
            _swatch(kMidnightBlue, 'MidnightBlue', 'panel surface'),
            _swatch(kHorizonNavy, 'HorizonNavy', 'section card surface'),
            _swatch(kArcGradientStart, 'ArcGradientStart', 'arc left'),
            _swatch(kArcGradientEnd, 'ArcGradientEnd', 'arc right'),
            _swatch(kBrassScaleMark, 'BrassScaleMark', 'tick marks, eyepiece'),
            _swatch(kBrassDeep, 'BrassDeep', 'tarnished brass border'),
            _swatch(kIvoryParchment, 'IvoryParchment', 'body text on indigo'),
            _swatch(kStarShine, 'StarShine', 'raised tile background'),
            _swatch(kChartroomLamp, 'ChartroomLamp', 'AVOID warning'),
            _swatch(kHorizonGlow, 'HorizonGlow', 'fits above accent'),
            _swatch(kAnchorRust, 'AnchorRust', 'anchor below accent'),
            _swatch(kCompassInk, 'CompassInk', 'primary text on light'),
            _swatch(kSextantShadow, 'SextantShadow', 'code-block fill'),
            _swatch(kCloudIvory, 'CloudIvory', 'logbook callout'),
            _swatch(kPlumLogbook, 'PlumLogbook', 'logbook accent'),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 -- PROSE ANATOMY: SingleChildLayoutDelegate
  // =========================================================================
  final s2 = _sectionCard(
    tag: '02 PROSE',
    title: 'Anatomy: SingleChildLayoutDelegate and CustomSingleChildLayout',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SingleChildLayoutDelegate is Flutter\'s contract for a host widget '
          '(CustomSingleChildLayout) that wants to position exactly one child '
          'inside its own box. The delegate answers four questions, in order:',
          style: _body(),
        ),
        _gap(8),
        _bullet('getSize(BoxConstraints) -> Size: how big is the host box?'),
        _bullet('getConstraintsForChild(BoxConstraints) -> BoxConstraints: '
            'what may the child be?'),
        _bullet('getPositionForChild(Size hostSize, Size childSize) -> Offset: '
            'where does the child go?'),
        _bullet('shouldRelayout(SingleChildLayoutDelegate old) -> bool: '
            'is the new delegate different enough to redo the work?'),
        _gap(10),
        Text(
          'TextSelectionToolbarLayoutDelegate overrides the last three. It '
          'leaves getSize as the default (the largest the constraints allow), '
          'because the toolbar host always wants to fill its parent. It '
          'loosens the child\'s constraints so the toolbar can shrink-wrap. '
          'And it positions the toolbar with arithmetic on the two anchor '
          'offsets it stores at construction.',
          style: _body(),
        ),
        _gap(10),
        Text(
          'The host widget you typically pair this with is '
          'CustomSingleChildLayout(delegate: ..., child: theToolbar). When '
          'Flutter builds the toolbar overlay (TextSelectionOverlay does the '
          'actual work), it wraps your toolbar widget in exactly such a '
          'CustomSingleChildLayout, hands it a freshly-constructed '
          'TextSelectionToolbarLayoutDelegate with the current selection '
          'anchors, and lets the layout protocol do the rest.',
          style: _body(),
        ),
        _gap(10),
        _kvLine('Inheritance', 'TextSelectionToolbarLayoutDelegate'),
        _kvLine('              extends', 'SingleChildLayoutDelegate'),
        _kvLine('              extends', 'Object  /  Listenable (none)'),
        _gap(6),
        _bullet('Immutable. To change behaviour, build a new delegate.'),
        _bullet('Cheap. The delegate stores three fields and computes Offsets.'),
        _bullet('Pure. No side effects. shouldRelayout never relayouts unless '
            'the actual offsets or fitsAbove changed.'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 -- ANCHOR GEOMETRY
  // =========================================================================
  final s3 = _sectionCard(
    tag: '03 GEOMETRY',
    title: 'Anchor geometry: anchorAbove and anchorBelow',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A selection in a text field has a top edge and a bottom edge. The '
          'toolbar wants to hover near the selection without occluding it. '
          'There are two natural rest positions:',
          style: _body(),
        ),
        _gap(8),
        _bullet('Above the selection -- the toolbar\'s BOTTOM edge sits at '
            'anchorAbove.dy. Its horizontal centre is at anchorAbove.dx.'),
        _bullet('Below the selection -- the toolbar\'s TOP edge sits at '
            'anchorBelow.dy. Its horizontal centre is at anchorBelow.dx.'),
        _gap(10),
        Text(
          'When the toolbar host is laid out, the delegate first asks: does '
          'the toolbar (with its measured childSize) fit inside the band '
          'between y=0 and y=anchorAbove.dy? If yes, fitsAbove is true and '
          'we anchor above. Otherwise fitsAbove is false and we anchor below.',
          style: _body(),
        ),
        _gap(10),
        Text(
          'The anchor x-coordinates are HORIZONTAL CENTRES, not left edges. '
          'The delegate calls centerOn(anchor.dx, childSize.width, parent.width) '
          'to translate "centre at this x" into "left edge at this x". The '
          'clamp inside centerOn ensures the toolbar never leaks past the '
          'parent\'s left or right edge.',
          style: _body(),
        ),
        _gap(10),
        _codeBlock(
            '// Conceptual decision tree.\n'
            'final bool fits = fitsAbove ?? (size.height >= childSize.height);\n'
            'final Offset baseAnchor = fits ? anchorAbove : anchorBelow;\n'
            'final double dx = centerOn(\n'
            '  baseAnchor.dx,\n'
            '  childSize.width,\n'
            '  size.width,\n'
            ');\n'
            'final double dy = fits\n'
            '    ? baseAnchor.dy - childSize.height\n'
            '    : baseAnchor.dy;\n'
            'return Offset(dx, dy);'),
        _gap(10),
        _bullet('"Above" subtracts childSize.height from anchorAbove.dy.'),
        _bullet('"Below" uses anchorBelow.dy as-is for the top edge.'),
        _bullet('Centering is independent of which anchor wins.'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 4 -- getPositionForChild WALKTHROUGH (10+ viewport cards)
  // =========================================================================
  // We hand-feed (parent, child, anchorAbove, anchorBelow) tuples and compute
  // the expected resolved Offset by re-implementing the delegate logic
  // alongside the actual centerOn(...) call. Each tuple becomes a card.
  //
  Offset resolve(
      double parentW,
      double parentH,
      double childW,
      double childH,
      Offset anchorAbove,
      Offset anchorBelow,
      bool? fitsAboveOverride) {
    final bool fits = fitsAboveOverride ?? (anchorAbove.dy >= childH);
    final Offset base = fits ? anchorAbove : anchorBelow;
    final double dx =
        TextSelectionToolbarLayoutDelegate.centerOn(base.dx, childW, parentW);
    final double dy = fits ? base.dy - childH : base.dy;
    return Offset(dx, dy);
  }

  // 12 hand-fed scenarios.
  final r1 = resolve(400, 600, 180, 44, const Offset(200, 100),
      const Offset(200, 200), null);
  final r2 = resolve(400, 600, 180, 44, const Offset(200, 8),
      const Offset(200, 60), null);
  final r3 = resolve(400, 600, 180, 44, const Offset(20, 120),
      const Offset(20, 220), null);
  final r4 = resolve(400, 600, 180, 44, const Offset(380, 120),
      const Offset(380, 220), null);
  final r5 = resolve(400, 600, 240, 44, const Offset(50, 160),
      const Offset(50, 220), null);
  final r6 = resolve(400, 600, 240, 44, const Offset(350, 160),
      const Offset(350, 220), null);
  final r7 = resolve(400, 600, 180, 44, const Offset(150, 80),
      const Offset(150, 180), true);
  final r8 = resolve(400, 600, 180, 44, const Offset(150, 80),
      const Offset(150, 180), false);
  final r9 = resolve(400, 600, 180, 88, const Offset(200, 60),
      const Offset(200, 160), null);
  final r10 = resolve(400, 600, 320, 44, const Offset(200, 200),
      const Offset(200, 280), null);
  final r11 = resolve(400, 600, 180, 44, const Offset(0, 0),
      const Offset(0, 0), null);
  final r12 = resolve(400, 600, 60, 44, const Offset(380, 540),
      const Offset(380, 580), null);

  print('[Sextant Indigo] getPositionForChild r1  = $r1');
  print('[Sextant Indigo] getPositionForChild r2  = $r2');
  print('[Sextant Indigo] getPositionForChild r3  = $r3');
  print('[Sextant Indigo] getPositionForChild r4  = $r4');
  print('[Sextant Indigo] getPositionForChild r5  = $r5');
  print('[Sextant Indigo] getPositionForChild r6  = $r6');
  print('[Sextant Indigo] getPositionForChild r7  = $r7');
  print('[Sextant Indigo] getPositionForChild r8  = $r8');
  print('[Sextant Indigo] getPositionForChild r9  = $r9');
  print('[Sextant Indigo] getPositionForChild r10 = $r10');
  print('[Sextant Indigo] getPositionForChild r11 = $r11');
  print('[Sextant Indigo] getPositionForChild r12 = $r12');

  final s4 = _sectionCard(
    tag: '04 WALKTHROUGH',
    title: 'getPositionForChild walkthrough -- 12 viewport cards',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Below are twelve hand-fed scenarios. Each card paints the parent '
          'viewport as an indigo rectangle, marks anchorAbove with a horizon '
          'glow dot, anchorBelow with an anchor rust dot, and draws the '
          'toolbar block where getPositionForChild would put it. The brass '
          'rectangle IS the toolbar.',
          style: _body(),
        ),
        _gap(12),
        Wrap(
          children: [
            _viewportCard(
              title: 'r1  centred, fits above',
              subtitle:
                  'Selection mid-screen, plenty of room. Toolbar lands above.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(200, 100),
              anchorBelow: const Offset(200, 200),
              resolvedPos: r1,
              fitsAbove: 100 >= 44,
            ),
            _viewportCard(
              title: 'r2  centred, does NOT fit above',
              subtitle:
                  'Selection near top -- 8 < 44. Toolbar flips below.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(200, 8),
              anchorBelow: const Offset(200, 60),
              resolvedPos: r2,
              fitsAbove: 8 >= 44,
            ),
            _viewportCard(
              title: 'r3  left edge clamp',
              subtitle:
                  'Anchor at x=20 with width 180. Clamp keeps left=0.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(20, 120),
              anchorBelow: const Offset(20, 220),
              resolvedPos: r3,
              fitsAbove: 120 >= 44,
            ),
            _viewportCard(
              title: 'r4  right edge clamp',
              subtitle:
                  'Anchor at x=380 with width 180. Clamp keeps right=400.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(380, 120),
              anchorBelow: const Offset(380, 220),
              resolvedPos: r4,
              fitsAbove: 120 >= 44,
            ),
            _viewportCard(
              title: 'r5  wide toolbar, anchor near left',
              subtitle:
                  'Width 240 at x=50. Clamp keeps left=0 (band wider than gap).',
              parentW: 400,
              parentH: 600,
              childW: 240,
              childH: 44,
              anchorAbove: const Offset(50, 160),
              anchorBelow: const Offset(50, 220),
              resolvedPos: r5,
              fitsAbove: 160 >= 44,
            ),
            _viewportCard(
              title: 'r6  wide toolbar, anchor near right',
              subtitle:
                  'Width 240 at x=350. Clamp keeps right=400.',
              parentW: 400,
              parentH: 600,
              childW: 240,
              childH: 44,
              anchorAbove: const Offset(350, 160),
              anchorBelow: const Offset(350, 220),
              resolvedPos: r6,
              fitsAbove: 160 >= 44,
            ),
            _viewportCard(
              title: 'r7  fitsAbove=true override',
              subtitle:
                  'We force "above" even when math would also agree.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(150, 80),
              anchorBelow: const Offset(150, 180),
              resolvedPos: r7,
              fitsAbove: true,
            ),
            _viewportCard(
              title: 'r8  fitsAbove=false override',
              subtitle:
                  'We force "below" even though there is room above.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(150, 80),
              anchorBelow: const Offset(150, 180),
              resolvedPos: r8,
              fitsAbove: false,
            ),
            _viewportCard(
              title: 'r9  tall toolbar, fits above by exactly 0',
              subtitle:
                  'Tall toolbar (height 88) at anchor 60 -> does NOT fit.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 88,
              anchorAbove: const Offset(200, 60),
              anchorBelow: const Offset(200, 160),
              resolvedPos: r9,
              fitsAbove: 60 >= 88,
            ),
            _viewportCard(
              title: 'r10 toolbar wider than parent? not here',
              subtitle:
                  'Width 320, parent 400. Centre at 200 -> left=40.',
              parentW: 400,
              parentH: 600,
              childW: 320,
              childH: 44,
              anchorAbove: const Offset(200, 200),
              anchorBelow: const Offset(200, 280),
              resolvedPos: r10,
              fitsAbove: 200 >= 44,
            ),
            _viewportCard(
              title: 'r11 corner-pinned anchor',
              subtitle:
                  'Both anchors at (0,0). fitsAbove=false, child below.',
              parentW: 400,
              parentH: 600,
              childW: 180,
              childH: 44,
              anchorAbove: const Offset(0, 0),
              anchorBelow: const Offset(0, 0),
              resolvedPos: r11,
              fitsAbove: 0 >= 44,
            ),
            _viewportCard(
              title: 'r12 narrow toolbar near bottom-right',
              subtitle:
                  'Width 60 at x=380. Comfortably centred without clamp.',
              parentW: 400,
              parentH: 600,
              childW: 60,
              childH: 44,
              anchorAbove: const Offset(380, 540),
              anchorBelow: const Offset(380, 580),
              resolvedPos: r12,
              fitsAbove: 540 >= 44,
            ),
          ],
        ),
        _gap(12),
        Text(
          'A pattern emerges. The horizontal answer depends only on the '
          'centre x-coord of the chosen anchor and the toolbar width. The '
          'vertical answer is one of two simple cases. There is no magic, '
          'no animation, no measurement of safe areas -- the host widget is '
          'expected to have already taken safe areas into account when it '
          'built the anchor offsets it passes in.',
          style: _body(),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 5 -- centerOn STATIC METHOD DEMO
  // =========================================================================
  final s5 = _sectionCard(
    tag: '05 CENTER-ON',
    title: 'centerOn(position, width, max) -- static clamp demonstration',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'centerOn is the brass tooth that drives the horizontal positioning. '
          'Its job is to centre a band of width "width" around an x-coordinate '
          '"position", but never let the band leak past 0 or max - width. The '
          'algorithm is exactly:',
          style: _body(),
        ),
        _gap(8),
        _codeBlock(
            'static double centerOn(double position, double width, double max) {\n'
            '  if (position - width / 2 < 0) {\n'
            '    return 0;\n'
            '  }\n'
            '  if (position + width / 2 > max) {\n'
            '    return max - width;\n'
            '  }\n'
            '  return position - width / 2;\n'
            '}'),
        _gap(12),
        Text(
          'Twelve scale-mark cards follow. The horizon-glow vertical line is '
          '`position`. The brass band is the resolved [left, left + width] '
          'range. Read the cards left-to-right, top-to-bottom -- each one '
          'shows a different way the clamp can fire.',
          style: _body(),
        ),
        _gap(12),
        Wrap(
          children: [
            _scaleTile(
              position: 100,
              width: 50,
              max: 400,
              resolved: c01,
              note: 'Comfortable centre; no clamp.',
            ),
            _scaleTile(
              position: 0,
              width: 50,
              max: 400,
              resolved: c02,
              note: 'Position at 0 -- left clamp fires; left = 0.',
            ),
            _scaleTile(
              position: 400,
              width: 50,
              max: 400,
              resolved: c03,
              note: 'Position at max -- right clamp fires; left = 350.',
            ),
            _scaleTile(
              position: 200,
              width: 100,
              max: 400,
              resolved: c04,
              note: 'Wider band, centred -- left = 150.',
            ),
            _scaleTile(
              position: 50,
              width: 200,
              max: 400,
              resolved: c05,
              note: 'Band width 200 at pos 50 -- left clamp; left = 0.',
            ),
            _scaleTile(
              position: 350,
              width: 200,
              max: 400,
              resolved: c06,
              note: 'Band width 200 at pos 350 -- right clamp; left = 200.',
            ),
            _scaleTile(
              position: 200,
              width: 50,
              max: 100,
              resolved: c07,
              note: 'Position past max -- right clamp; left = 50.',
            ),
            _scaleTile(
              position: 0,
              width: 0,
              max: 400,
              resolved: c08,
              note: 'Zero width band at 0 -- degenerate but valid; left = 0.',
            ),
            _scaleTile(
              position: 200,
              width: 400,
              max: 400,
              resolved: c09,
              note: 'Band width = max -- only one valid placement; left = 0.',
            ),
            _scaleTile(
              position: 150,
              width: 80,
              max: 300,
              resolved: c10,
              note: 'Plain centre; left = 110.',
            ),
            _scaleTile(
              position: 290,
              width: 80,
              max: 300,
              resolved: c11,
              note: 'Near right edge -- right clamp fires; left = 220.',
            ),
            _scaleTile(
              position: 10,
              width: 80,
              max: 300,
              resolved: c12,
              note: 'Near left edge -- left clamp fires; left = 0.',
            ),
          ],
        ),
        _gap(12),
        _kvLine('centerOn(100, 50, 400)', '$c01'),
        _kvLine('centerOn(  0, 50, 400)', '$c02'),
        _kvLine('centerOn(400, 50, 400)', '$c03'),
        _kvLine('centerOn(200,100, 400)', '$c04'),
        _kvLine('centerOn( 50,200, 400)', '$c05'),
        _kvLine('centerOn(350,200, 400)', '$c06'),
        _kvLine('centerOn(200, 50, 100)', '$c07'),
        _kvLine('centerOn(  0,  0, 400)', '$c08'),
        _kvLine('centerOn(200,400, 400)', '$c09'),
        _kvLine('centerOn(150, 80, 300)', '$c10'),
        _kvLine('centerOn(290, 80, 300)', '$c11'),
        _kvLine('centerOn( 10, 80, 300)', '$c12'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 6 -- shouldRelayout SEMANTICS
  // =========================================================================
  final s6 = _sectionCard(
    tag: '06 RELAYOUT',
    title: 'shouldRelayout: when to redo the work',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layout is expensive. Flutter avoids it whenever it can. When a '
          'CustomSingleChildLayout rebuilds, it asks the new delegate "are '
          'you DIFFERENT enough from the old one to justify a relayout?" '
          'TextSelectionToolbarLayoutDelegate.shouldRelayout answers true '
          'iff anchorAbove, anchorBelow, or fitsAbove differs from the old '
          'instance.',
          style: _body(),
        ),
        _gap(10),
        _codeBlock(
            'bool shouldRelayout(TextSelectionToolbarLayoutDelegate old) {\n'
            '  return anchorAbove != old.anchorAbove\n'
            '      || anchorBelow != old.anchorBelow\n'
            '      || fitsAbove   != old.fitsAbove;\n'
            '}'),
        _gap(10),
        Text(
          'Three exercises follow. We construct fresh delegates that differ '
          'from dCenteredFit/dForcedAbove in exactly one field, and observe '
          'the result of shouldRelayout(...). The fourth row exercises a '
          'fitsAbove flip from true to false.',
          style: _body(),
        ),
        _gap(10),
        _kvLine(
            'identical anchors and fitsAbove',
            relSame ? 'true (UNEXPECTED)' : 'false'),
        _kvLine(
            'anchorAbove moved by 1 pixel',
            relMovedAbove ? 'true' : 'false'),
        _kvLine(
            'anchorBelow moved by 1 pixel',
            relMovedBelow ? 'true' : 'false'),
        _kvLine(
            'fitsAbove flipped (true->false)',
            relFitFlipped ? 'true' : 'false'),
        _gap(10),
        _bullet('A floating selection in motion (drag-to-extend) constantly '
            'changes anchorBelow. Each frame relayouts the toolbar -- this is '
            'fine; the work is small.'),
        _bullet('A static selection that the user merely interacts with does '
            'NOT change the anchors. shouldRelayout returns false and the '
            'previous Offset is reused.'),
        _bullet('fitsAbove flips when the keyboard appears or disappears, '
            'shrinking the available band above the selection.'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 -- COMPARISON WITH CustomSingleChildLayout USAGE
  // =========================================================================
  final s7 = _sectionCard(
    tag: '07 COMPARISON',
    title: 'CustomSingleChildLayout: the host widget that consumes us',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TextSelectionToolbarLayoutDelegate is not consumed directly. It is '
          'plugged into a CustomSingleChildLayout, which is itself plugged '
          'into the toolbar overlay produced by TextSelectionOverlay. The '
          'three layers are easy to confuse, so this card walks through them.',
          style: _body(),
        ),
        _gap(10),
        _codeBlock(
            '// Inside the toolbar overlay (simplified):\n'
            'Widget build(BuildContext context) {\n'
            '  return CustomSingleChildLayout(\n'
            '    delegate: TextSelectionToolbarLayoutDelegate(\n'
            '      anchorAbove: selectionTopGlobal,\n'
            '      anchorBelow: selectionBottomGlobal,\n'
            '    ),\n'
            '    child: TextSelectionToolbar(\n'
            '      anchorAbove: selectionTopGlobal,\n'
            '      anchorBelow: selectionBottomGlobal,\n'
            '      children: <Widget>[ /* Cut, Copy, Paste */ ],\n'
            '    ),\n'
            '  );\n'
            '}'),
        _gap(10),
        Text(
          'The toolbar widget itself ALSO receives the anchors. That is not '
          'a redundancy -- the toolbar uses the anchors for its own purposes '
          '(e.g. Material toolbars draw a small triangle that points back at '
          'the selection). The delegate uses them only for positioning.',
          style: _body(),
        ),
        _gap(10),
        _kvLine('Layer 1', 'TextSelectionOverlay (shows / hides toolbar)'),
        _kvLine('Layer 2', 'CustomSingleChildLayout (positions toolbar host)'),
        _kvLine('Layer 3', 'TextSelectionToolbar (paints Cut/Copy/Paste)'),
        _kvLine('Delegate slot', 'Layer 2 \'s delegate parameter'),
        _gap(8),
        Text(
          'You almost never write the CustomSingleChildLayout yourself. You '
          'subclass TextSelectionControls, override buildToolbar, and return '
          'whatever toolbar widget you like; the framework wraps it for you. '
          'The only time you instantiate this delegate directly is when you '
          'are building a CUSTOM toolbar host that wants to mimic the '
          'native positioning.',
          style: _body(),
        ),
        _gap(12),
        _logbookEntry(
            '2024-01-12',
            'Wrote a custom toolbar that nudged itself away from the safe '
            'area. The trick was to PRE-ADJUST anchorAbove/anchorBelow before '
            'handing them to the delegate. The delegate itself does not know '
            'about safe areas; it trusts the anchors it receives.'),
        _logbookEntry(
            '2024-02-03',
            'Discovered that flipping fitsAbove every frame produces a '
            'jittery toolbar. The fix is to compute fitsAbove once when the '
            'selection becomes visible, then keep it stable until the '
            'selection moves.'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 8 -- ACCESSIBILITY CONSIDERATIONS
  // =========================================================================
  final s8 = _sectionCard(
    tag: '08 A11Y',
    title: 'Accessibility: how the toolbar speaks to assistive tech',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The selection toolbar is a transient overlay. Screen readers '
          'announce it when it appears, walk its buttons in reading order, '
          'and dismiss it when focus moves away. The DELEGATE has no direct '
          'role in this -- a SemanticsNode is built by the toolbar widget, '
          'not the layout delegate -- but the delegate\'s positioning '
          'choices have implications for assistive tech.',
          style: _body(),
        ),
        _gap(10),
        _bullet('Position determines reading order. A toolbar above the '
            'selection is announced before the selection text in some screen '
            'readers because of geometric ordering. A toolbar below is '
            'announced after.'),
        _bullet('Position determines focus traversal. The TalkBack swipe-next '
            'gesture moves to the next semantic node by visual position, so '
            'a toolbar that flips above/below mid-utterance can confuse the '
            'user.'),
        _bullet('Position determines hit-testing. Stable Offsets mean stable '
            'tap targets. Use shouldRelayout to AVOID needless repositioning.'),
        _gap(10),
        _calloutDo(
            'PRE-COMPUTE fitsAbove WHEN POSSIBLE',
            'If you know the selection is above the keyboard fold, force '
            'fitsAbove: false explicitly so the toolbar does not wobble when '
            'the keyboard animation starts.'),
        _calloutDo(
            'KEEP ANCHORS IN LOCAL COORDINATES',
            'The delegate expects anchors in the SAME coordinate space as '
            'the parent size it receives. Convert globals to locals before '
            'passing them in, or you will see the toolbar fly off-screen.'),
        _calloutDo(
            'RESPECT SAFE AREAS',
            'Pre-shrink anchorAbove.dy by the top safe area inset and '
            'anchorBelow.dy + childHeight should not exceed (parentHeight - '
            'bottomSafeArea). The delegate does not know about insets.'),
        _calloutAvoid(
            'PASSING GLOBAL OFFSETS',
            'Globals work in some cases by accident (when the host fills the '
            'screen). They are wrong everywhere else.'),
        _calloutAvoid(
            'MUTATING ANCHORS EVERY FRAME',
            'A jittery floating toolbar is unusable for screen-reader users. '
            'Debounce or pin until the selection actually moves.'),
        _calloutAvoid(
            'OVERRIDING fitsAbove BLINDLY',
            'Forcing fitsAbove: true in a tall keyboard scenario will paint '
            'the toolbar OFF-SCREEN above the visible band.'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 -- DO / AVOID summary
  // =========================================================================
  final s9 = _sectionCard(
    tag: '09 DO/AVOID',
    title: 'Six rules of toolbar positioning',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _calloutDo(
            'ANCHOR AT SELECTION CENTRE',
            'Use the horizontal centre of the selection rect for both '
            'anchorAbove.dx and anchorBelow.dx. centerOn does the rest.'),
        _calloutDo(
            'PASS PARENT-LOCAL Y',
            'anchorAbove.dy is the y of the TOP of the selection (in local '
            'space). anchorBelow.dy is the y of the BOTTOM. Not the centre.'),
        _calloutDo(
            'TRUST THE CLAMP',
            'You do not need to clamp dx yourself before constructing the '
            'delegate. centerOn will do it.'),
        _calloutAvoid(
            'PASSING SELECTION CORNERS',
            'Corners are off-centre. Use centres or you get a left-aligned '
            'toolbar instead of a centred one.'),
        _calloutAvoid(
            'CONFLATING PARENT WITH SCREEN',
            'The delegate operates in PARENT-LOCAL coordinates. The parent '
            'may be smaller than the screen.'),
        _calloutAvoid(
            'RECREATING ON EVERY FRAME',
            'Cache the delegate when anchors are stable. Recreating it '
            'forces shouldRelayout to fire (because the OLD delegate compares '
            'unequal to the new one when references differ -- though field '
            'comparison is what saves you).'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 10 -- CODE-SNIPPET CARDS (canonical recipes)
  // =========================================================================
  final s10 = _sectionCard(
    tag: '10 RECIPES',
    title: 'Canonical recipes',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Four recipe cards follow. They are the four shapes you will most '
          'often write when you have to position a custom selection toolbar '
          'or any other anchor-driven floating UI.',
          style: _body(),
        ),
        _gap(10),
        Text('RECIPE 1 -- vanilla toolbar host', style: _h3()),
        _gap(6),
        _codeBlock(
            'CustomSingleChildLayout(\n'
            '  delegate: TextSelectionToolbarLayoutDelegate(\n'
            '    anchorAbove: selectionTopLocal,\n'
            '    anchorBelow: selectionBottomLocal,\n'
            '  ),\n'
            '  child: MyToolbar(),\n'
            ');'),
        _gap(12),
        Text('RECIPE 2 -- forced "below" for sticky-keyboard scenarios',
            style: _h3()),
        _gap(6),
        _codeBlock(
            'CustomSingleChildLayout(\n'
            '  delegate: TextSelectionToolbarLayoutDelegate(\n'
            '    anchorAbove: selectionTopLocal,\n'
            '    anchorBelow: selectionBottomLocal,\n'
            '    fitsAbove: false, // keyboard always covers above-band\n'
            '  ),\n'
            '  child: MyToolbar(),\n'
            ');'),
        _gap(12),
        Text('RECIPE 3 -- pre-adjust for safe areas', style: _h3()),
        _gap(6),
        _codeBlock(
            'final EdgeInsets pad = MediaQuery.of(context).padding;\n'
            'final Offset above = Offset(\n'
            '  selectionCentreX,\n'
            '  selectionTopY - pad.top,\n'
            ');\n'
            'final Offset below = Offset(\n'
            '  selectionCentreX,\n'
            '  selectionBottomY - pad.top,\n'
            ');\n'
            'CustomSingleChildLayout(\n'
            '  delegate: TextSelectionToolbarLayoutDelegate(\n'
            '    anchorAbove: above,\n'
            '    anchorBelow: below,\n'
            '  ),\n'
            '  child: MyToolbar(),\n'
            ');'),
        _gap(12),
        Text('RECIPE 4 -- borrow centerOn for non-toolbar UI', style: _h3()),
        _gap(6),
        _codeBlock(
            '// Reuse centerOn for a tooltip that follows a hover position.\n'
            'final double left = TextSelectionToolbarLayoutDelegate.centerOn(\n'
            '  hoverX,\n'
            '  tooltipWidth,\n'
            '  parentSize.width,\n'
            ');\n'
            'final double top  = hoverY - tooltipHeight - 8;\n'
            'return Positioned(\n'
            '  left: left,\n'
            '  top:  top,\n'
            '  child: Tooltip(...),\n'
            ');'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 11 -- GLOSSARY
  // =========================================================================
  Widget gItem(String term, String defn) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kStarShine,
        borderRadius: BorderRadius.circular(6),
        border: Border(
            left: BorderSide(width: 4, color: kPlumLogbook)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(term,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kPlumLogbook)),
          const SizedBox(height: 4),
          Text(defn, style: _bodyDark()),
        ],
      ),
    );
  }

  final s11 = _sectionCard(
    tag: '11 GLOSSARY',
    title: 'Glossary -- twelve terms',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gItem('anchorAbove',
            'The Offset (in parent-local coordinates) that names where the '
            'BOTTOM edge of the toolbar should sit when the toolbar fits in '
            'the band above the selection. Its dx is the selection\'s '
            'horizontal centre.'),
        gItem('anchorBelow',
            'The Offset that names where the TOP edge of the toolbar should '
            'sit when the toolbar does NOT fit above the selection. Its dx '
            'is, again, the selection\'s horizontal centre.'),
        gItem('fitsAbove',
            'An optional bool override. When null, the delegate computes '
            '`size.height >= childSize.height` to decide. When non-null, the '
            'caller has already decided.'),
        gItem('centerOn',
            'A static helper that translates "centre this band of width w '
            'around x" into "left edge = ...", clamped to [0, max - w].'),
        gItem('SingleChildLayoutDelegate',
            'The Flutter contract for an object that lays out exactly one '
            'child inside a host box. Four methods: getSize, '
            'getConstraintsForChild, getPositionForChild, shouldRelayout.'),
        gItem('CustomSingleChildLayout',
            'The widget that consumes a SingleChildLayoutDelegate. It takes '
            'a delegate and a child; it asks the delegate where to put '
            'the child.'),
        gItem('shouldRelayout',
            'A pure-comparison method that the framework calls on the NEW '
            'delegate, passing the OLD one. Returns true to trigger a fresh '
            'layout, false to reuse the cached result.'),
        gItem('TextSelectionOverlay',
            'The framework class that owns the selection toolbar overlay. '
            'It is the one that wraps the toolbar in a '
            'CustomSingleChildLayout configured with our delegate.'),
        gItem('TextSelectionToolbar',
            'The Material implementation of the toolbar widget. It uses the '
            'same anchors for its own painting (e.g. the small triangle '
            'pointing at the selection).'),
        gItem('TextSelectionControls',
            'The class you subclass when you want a custom toolbar shape. '
            'Override buildToolbar; the framework supplies the layout host.'),
        gItem('parent-local coordinates',
            'A coordinate space whose origin (0,0) is the top-left of the '
            'parent of the toolbar host. Convert from globals with '
            'box.globalToLocal(...).'),
        gItem('clamp',
            'A bounded operation that maps any input to the closest value '
            'in a target range. centerOn clamps the toolbar\'s left edge '
            'to [0, parentWidth - toolbarWidth].'),
      ],
    ),
  );

  // =========================================================================
  // SECTION 12 -- LIVE READOUTS + RECAP FOOTER
  // =========================================================================
  final s12 = _sectionCard(
    tag: '12 RECAP',
    title: 'Live readouts and Sextant Indigo closing motto',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LIVE DELEGATE READOUTS', style: _label()),
        _gap(8),
        _kvLine('dCenteredFit.anchorAbove',
            '(${dCenteredFit.anchorAbove.dx}, ${dCenteredFit.anchorAbove.dy})'),
        _kvLine('dCenteredFit.anchorBelow',
            '(${dCenteredFit.anchorBelow.dx}, ${dCenteredFit.anchorBelow.dy})'),
        _kvLine('dCenteredFit.fitsAbove',
            '${dCenteredFit.fitsAbove}'),
        _kvLine('dCenteredNoFit.anchorAbove',
            '(${dCenteredNoFit.anchorAbove.dx}, ${dCenteredNoFit.anchorAbove.dy})'),
        _kvLine('dCenteredNoFit.fitsAbove',
            '${dCenteredNoFit.fitsAbove}'),
        _kvLine('dForcedAbove.fitsAbove',
            '${dForcedAbove.fitsAbove}'),
        _kvLine('dForcedBelow.fitsAbove',
            '${dForcedBelow.fitsAbove}'),
        _kvLine('dLeftEdge.anchorAbove.dx',
            '${dLeftEdge.anchorAbove.dx}'),
        _kvLine('dRightEdge.anchorAbove.dx',
            '${dRightEdge.anchorAbove.dx}'),
        _kvLine('dNearTop.anchorAbove.dy',
            '${dNearTop.anchorAbove.dy}'),
        _kvLine('dNearBottom.anchorBelow.dy',
            '${dNearBottom.anchorBelow.dy}'),
        _kvLine('dWide.anchorAbove',
            '(${dWide.anchorAbove.dx}, ${dWide.anchorAbove.dy})'),
        _kvLine('dNarrow.anchorAbove',
            '(${dNarrow.anchorAbove.dx}, ${dNarrow.anchorAbove.dy})'),
        _kvLine('dFlush.anchorAbove',
            '(${dFlush.anchorAbove.dx}, ${dFlush.anchorAbove.dy})'),
        _kvLine('dDiag.anchorAbove',
            '(${dDiag.anchorAbove.dx}, ${dDiag.anchorAbove.dy})'),
        _kvLine('dDiag.anchorBelow',
            '(${dDiag.anchorBelow.dx}, ${dDiag.anchorBelow.dy})'),
        _gap(10),
        Text('CENTER-ON SCALE READOUTS', style: _label()),
        _gap(8),
        _kvLine('c01 centerOn(100, 50, 400)', '$c01'),
        _kvLine('c02 centerOn(  0, 50, 400)', '$c02'),
        _kvLine('c03 centerOn(400, 50, 400)', '$c03'),
        _kvLine('c04 centerOn(200,100, 400)', '$c04'),
        _kvLine('c05 centerOn( 50,200, 400)', '$c05'),
        _kvLine('c06 centerOn(350,200, 400)', '$c06'),
        _kvLine('c07 centerOn(200, 50, 100)', '$c07'),
        _kvLine('c08 centerOn(  0,  0, 400)', '$c08'),
        _kvLine('c09 centerOn(200,400, 400)', '$c09'),
        _kvLine('c10 centerOn(150, 80, 300)', '$c10'),
        _kvLine('c11 centerOn(290, 80, 300)', '$c11'),
        _kvLine('c12 centerOn( 10, 80, 300)', '$c12'),
        _gap(10),
        Text('SHOULD-RELAYOUT READOUTS', style: _label()),
        _gap(8),
        _kvLine('relSame', '$relSame'),
        _kvLine('relMovedAbove', '$relMovedAbove'),
        _kvLine('relMovedBelow', '$relMovedBelow'),
        _kvLine('relFitFlipped', '$relFitFlipped'),
        _gap(14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kSextantIndigo, kPlumLogbook],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kBrassScaleMark.withValues(alpha: 0.7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SEXTANT INDIGO -- CLOSING MOTTO',
                  style: TextStyle(
                      color: kBrassScaleMark,
                      fontSize: 11,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700)),
              _gap(8),
              Text(
                'Two anchors and a clamp. Above when there is sky enough; '
                'below when there is not. The brass arithmetic of '
                'TextSelectionToolbarLayoutDelegate is small, predictable, '
                'and ancient -- the same arithmetic a navigator would use '
                'to pin a star to a horizon-glass at midnight.',
                style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: kStarShine.withValues(alpha: 0.95)),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // ASSEMBLE
  // =========================================================================
  print('[Sextant Indigo] tree assembled, returning snapshot.');
  print('=========================================================');
  print('Sextant Indigo -- TextSelectionToolbarLayoutDelegate done.');
  print('=========================================================');

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #136, P2)
  // ---------------------------------------------------------------------------
  // Baseline frameworkErrors=1: a RenderFlex overflowed by 8799 pixels on the
  // bottom. The composite page is a 12-section anatomy of
  // TextSelectionToolbarLayoutDelegate stacked vertically (s1..s12 + a 24 px
  // tail spacer). The intrinsic height of that stack vastly exceeds any
  // realistic viewport, so the un-scrolled root Column overflowed by ~8.8 k px.
  //
  // The plan listed this as P1+P2, but grep across the file confirms that no
  // `Row(crossAxisAlignment: CrossAxisAlignment.stretch)` site exists — the
  // only `CrossAxisAlignment.stretch` match is on the page-root Column itself,
  // whose cross axis is width and is bounded by the outer indigo Container.
  // P1 (IntrinsicHeight wrap) therefore does not materialise; the fix reduces
  // to a P2-only page-root SingleChildScrollView wrap (same pattern as items
  // 104, 105, 120, 133).
  //
  // The indigo `Container(color: kSextantIndigo)` stays outside the SCV so the
  // indigo backdrop continues to fill the entire viewport rather than just the
  // scrolled content region. No outer padding to relocate.
  return Container(
    color: kSextantIndigo,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          s1,
          s2,
          s3,
          s4,
          s5,
          s6,
          s7,
          s8,
          s9,
          s10,
          s11,
          s12,
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}
