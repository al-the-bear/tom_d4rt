// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
//
// =====================================================================
// TapDragDownDetails — Deep Demo (Cobalt-and-Coral / Trackpad Edition)
// =====================================================================
//
// TapDragDownDetails is the payload delivered to the
//   GestureTapDragDownCallback typedef
// as the `onTapDown` argument of TapAndDragGestureRecognizer (and its
// subclass family — BaseTapAndDragGestureRecognizer,
// TapAndPanGestureRecognizer, TapAndHorizontalDragGestureRecognizer).
// It is fired the very first instant the recognizer wins the down-phase
// arena: the user has just put a finger / mouse / stylus down, but the
// recognizer has not yet decided whether the gesture will become a
// pure tap, a tap-then-drag, or a multi-tap-then-drag (e.g. selection-
// drag in a text editor).
//
// Why does it exist as its own type instead of reusing TapDownDetails?
// Because the tap-and-drag combo cares about *how many taps in a row*
// have already fired before this latest one. That number is exposed on
// `consecutiveTapCount`, and it is what lets editors implement word-
// drag on the second tap, paragraph-drag on the third tap, and so on.
//
// Fields reviewed in this demo:
//   * globalPosition       : Offset             — screen-frame coords.
//   * localPosition        : Offset             — local-box coords.
//   * kind                 : PointerDeviceKind? — touch/mouse/stylus/…
//   * consecutiveTapCount  : int                — 1=solo, 2=double, 3=…
//
// Theme: cobalt + coral + slate. Cobalt for the "down" event itself,
// coral for the tap-counter highlight, slate for the chassis/structure,
// teal for the drag-direction hint, and a soft cream for paper-like
// surfaces. The visual metaphor is a precision trackpad on a slate
// laptop — every tap registers a small coral pulse, and a cobalt arrow
// hints at the drag that is about to begin.
// =====================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------
// Color palette — cobalt / coral / slate
// ---------------------------------------------------------------------
const Color kCobalt = Color(0xFF1F4FA8);
const Color kCobaltDeep = Color(0xFF12326B);
const Color kCobaltSoft = Color(0xFF6E91D4);
const Color kCoral = Color(0xFFFF6F61);
const Color kCoralDeep = Color(0xFFC23A2E);
const Color kCoralSoft = Color(0xFFFFB1A8);
const Color kSlate = Color(0xFF2E3440);
const Color kSlateSoft = Color(0xFF4C566A);
const Color kSlateLight = Color(0xFF8A93A4);
const Color kCream = Color(0xFFF5F1E8);
const Color kCreamDeep = Color(0xFFE6DEC8);
const Color kTeal = Color(0xFF1F8E8E);
const Color kTealSoft = Color(0xFF7FB7B7);
const Color kAmber = Color(0xFFFFB347);
const Color kViolet = Color(0xFF7E5BB0);
const Color kSage = Color(0xFF8BAA80);
const Color kShadow = Color(0xFF111114);

// ---------------------------------------------------------------------
// Helper: pretty-print a TapDragDownDetails to the console.
// ---------------------------------------------------------------------
void _dumpDetails(String label, TapDragDownDetails d) {
  print('--- $label ---');
  print('  runtimeType        : ${d.runtimeType}');
  print('  globalPosition     : ${d.globalPosition}');
  print('  localPosition      : ${d.localPosition}');
  print('  kind               : ${d.kind}');
  print('  consecutiveTapCount: ${d.consecutiveTapCount}');
}

// ---------------------------------------------------------------------
// Helper: framed card with a title and a body widget.
// ---------------------------------------------------------------------
Widget _frame({
  required String title,
  required Widget body,
  Color border = kCobalt,
  Color fill = kCream,
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: fill,
      border: Border.all(color: border, width: 2),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: kShadow,
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(2, 4),
        ),
      ],
      gradient: LinearGradient(
        colors: [fill, kCreamDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kSlate,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        body,
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: small pill / chip with a label.
// ---------------------------------------------------------------------
Widget _pill(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 3, offset: Offset(1, 1)),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: divider styled as a subtle cobalt-coral wire.
// ---------------------------------------------------------------------
Widget _wire() {
  return Container(
    height: 2,
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [kCobaltDeep, kCobalt, kCoral, kCobalt, kCobaltDeep],
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a coral-pulsed tap badge, sized by tap-count.
// ---------------------------------------------------------------------
Widget _tapBadge(int count) {
  final Color cap;
  if (count == 1) {
    cap = kCobaltSoft;
  } else if (count == 2) {
    cap = kCoral;
  } else if (count == 3) {
    cap = kAmber;
  } else if (count == 4) {
    cap = kSage;
  } else {
    cap = kViolet;
  }
  return Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [cap, kSlate],
        center: const Alignment(-0.3, -0.3),
        radius: 0.95,
      ),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 8, offset: Offset(2, 3)),
      ],
    ),
    child: Center(
      child: Text(
        '$count',
        style: const TextStyle(
          color: kCream,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a labeled "field : value" row with monospace value.
// ---------------------------------------------------------------------
Widget _field(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: const TextStyle(
              color: kSlateSoft,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kSlate,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a small section header banner.
// ---------------------------------------------------------------------
Widget _sectionHeader(int n, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kSlate, kSlateSoft],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 6, offset: Offset(1, 2)),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: kCoral,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$n',
            style: const TextStyle(
              color: kCream,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: kCream,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kCoralSoft,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a "dotted-border" anatomy box. Built as a stack of dashes
// drawn with small Container squares, since the runner forbids custom
// painters / animation; this is purely a static visual flourish.
// ---------------------------------------------------------------------
Widget _dottedBorderBox({
  required Widget child,
  Color color = kCobalt,
  Color fill = kCream,
}) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: child,
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a small directional arrow chip (used in lifecycle).
// ---------------------------------------------------------------------
Widget _arrow(String label, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: kSlate, width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontStyle: FontStyle.italic,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =====================================================================
// build()
// =====================================================================
dynamic build(BuildContext context) {
  print('=====================================================');
  print(' TapDragDownDetails — DEEP DEMO (cobalt+coral edition)');
  print('=====================================================');

  // -------------------------------------------------------------------
  // SECTION 0 — Anchor instance
  // -------------------------------------------------------------------
  print('\n=== Section 0: Anchor instance ===');
  print('Constructing the canonical TapDragDownDetails…');
  final TapDragDownDetails anchor = TapDragDownDetails(
    globalPosition: const Offset(140, 95),
    localPosition: const Offset(40, 25),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  _dumpDetails('anchor', anchor);

  // Identical-args twin to discuss equality semantics.
  final TapDragDownDetails anchorTwin = TapDragDownDetails(
    globalPosition: const Offset(140, 95),
    localPosition: const Offset(40, 25),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  print('anchor == anchorTwin (identity)   : '
      '${identical(anchor, anchorTwin)}');
  print('anchor == anchorTwin (== operator): ${anchor == anchorTwin}');
  print('anchor.runtimeType == twin.runtime: '
      '${anchor.runtimeType == anchorTwin.runtimeType}');
  print('Note: TapDragDownDetails does not override == — two instances');
  print('      with identical fields are still distinct Dart objects.');

  // -------------------------------------------------------------------
  // SECTION 1 — Field-by-field exploration
  // -------------------------------------------------------------------
  print('\n=== Section 1: Field-by-field ===');
  print('globalPosition is in the device coordinate space (origin top-');
  print('left of the screen / window). It is what you compare against');
  print('a hit-test result, what you log to telemetry, and what you');
  print('forward to a drag-handler that wants absolute coordinates.');
  print('');
  print('localPosition is in the coordinate space of the box that');
  print('received the hit. If you put a TapAndDragGestureRecognizer on');
  print('a 200x100 panel, localPosition is the offset *inside* that');
  print('panel — so (0,0) is the top-left of the panel, not of the');
  print('screen. This is what you usually want to drive a custom paint');
  print('or to compute a drag-relative selection.');
  print('');
  print('kind is the PointerDeviceKind that started the gesture. It is');
  print('NULLABLE on TapDragDownDetails (unlike SerialTapDownDetails');
  print('where it is required). null means "unknown / unspecified", a');
  print('legitimate state for synthesised events such as those produced');
  print('by tests or accessibility forwarding.');
  print('');
  print('consecutiveTapCount is the discriminator. 1 = first tap of a');
  print('sequence, 2 = the second within kDoubleTapTimeout *and* within');
  print('kDoubleTapSlop of the previous tap, 3 = the third, …. When the');
  print('user dwells too long or drifts too far, the count resets.');

  // -------------------------------------------------------------------
  // SECTION 2 — Gallery: consecutiveTapCount = 1..5
  // -------------------------------------------------------------------
  print('\n=== Section 2: Gallery (consecutiveTapCount = 1..5) ===');
  final List<TapDragDownDetails> gallery = <TapDragDownDetails>[
    TapDragDownDetails(
      globalPosition: const Offset(40, 60),
      localPosition: const Offset(10, 12),
      kind: PointerDeviceKind.touch,
      consecutiveTapCount: 1,
    ),
    TapDragDownDetails(
      globalPosition: const Offset(82, 92),
      localPosition: const Offset(14, 18),
      kind: PointerDeviceKind.touch,
      consecutiveTapCount: 2,
    ),
    TapDragDownDetails(
      globalPosition: const Offset(140, 130),
      localPosition: const Offset(20, 22),
      kind: PointerDeviceKind.mouse,
      consecutiveTapCount: 3,
    ),
    TapDragDownDetails(
      globalPosition: const Offset(210, 170),
      localPosition: const Offset(28, 30),
      kind: PointerDeviceKind.mouse,
      consecutiveTapCount: 4,
    ),
    TapDragDownDetails(
      globalPosition: const Offset(280, 220),
      localPosition: const Offset(34, 36),
      kind: PointerDeviceKind.stylus,
      consecutiveTapCount: 5,
    ),
  ];
  for (int i = 0; i < gallery.length; i++) {
    _dumpDetails('gallery[$i]', gallery[i]);
  }
  print('Gallery shows escalation: consecutiveTapCount climbs while');
  print('position drifts a few pixels — exactly what you observe from');
  print('a real user repeatedly tapping at "the same place" on a');
  print('trackpad to expand a text-selection.');

  // -------------------------------------------------------------------
  // SECTION 3 — PointerDeviceKind variations
  // -------------------------------------------------------------------
  print('\n=== Section 3: PointerDeviceKind variations ===');
  final TapDragDownDetails kindTouch = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  final TapDragDownDetails kindMouse = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 2,
  );
  final TapDragDownDetails kindStylus = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 1,
  );
  final TapDragDownDetails kindInverted = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.invertedStylus,
    consecutiveTapCount: 1,
  );
  final TapDragDownDetails kindTrackpad = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.trackpad,
    consecutiveTapCount: 2,
  );
  final TapDragDownDetails kindUnknown = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.unknown,
    consecutiveTapCount: 1,
  );
  final TapDragDownDetails kindNull = TapDragDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    consecutiveTapCount: 1,
  );
  _dumpDetails('kindTouch', kindTouch);
  _dumpDetails('kindMouse', kindMouse);
  _dumpDetails('kindStylus', kindStylus);
  _dumpDetails('kindInverted', kindInverted);
  _dumpDetails('kindTrackpad', kindTrackpad);
  _dumpDetails('kindUnknown', kindUnknown);
  _dumpDetails('kindNull (no kind specified)', kindNull);

  // -------------------------------------------------------------------
  // SECTION 4 — Lifecycle storyboard data
  // -------------------------------------------------------------------
  print('\n=== Section 4: Lifecycle (tap1 → tap2 + drag) ===');
  final TapDragDownDetails lifeT1Down = TapDragDownDetails(
    globalPosition: const Offset(100, 100),
    localPosition: const Offset(10, 10),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );
  final TapDragDownDetails lifeT2Down = TapDragDownDetails(
    globalPosition: const Offset(102, 101),
    localPosition: const Offset(12, 11),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 2,
  );
  final TapDragDownDetails lifeT3Down = TapDragDownDetails(
    globalPosition: const Offset(105, 103),
    localPosition: const Offset(15, 13),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 3,
  );
  _dumpDetails('lifeT1Down', lifeT1Down);
  _dumpDetails('lifeT2Down', lifeT2Down);
  _dumpDetails('lifeT3Down', lifeT3Down);
  print('Each subsequent TapDragDownDetails arrives within the');
  print('recognizer timeout (kDoubleTapTimeout, ~300 ms by default) and');
  print('within kDoubleTapSlop (~18 px) of the prior tap. If either of');
  print('those budgets is violated, consecutiveTapCount resets to 1.');
  print('After consecutiveTapCount reaches its target, the user can');
  print('move the pointer past kPrecisePointerHitSlop to escalate the');
  print('gesture into a drag — which is the moment onDragStart fires.');

  // -------------------------------------------------------------------
  // SECTION 5 — Detection flow narration
  // -------------------------------------------------------------------
  print('\n=== Section 5: Detection flow ===');
  print('  PointerDownEvent  ──► PointerRouter');
  print('  PointerRouter     ──► TapAndDragGestureRecognizer');
  print('  Recognizer wins   ──► onTapDown(TapDragDownDetails)  ★');
  print('       (this demo)');
  print('  pointer moves     ──► onDragStart(TapDragStartDetails)');
  print('  pointer moves     ──► onDragUpdate(TapDragUpdateDetails)');
  print('  PointerUpEvent    ──► onDragEnd(TapDragEndDetails)');
  print('                     OR onTapUp(TapDragUpDetails) (no drag)');

  // -------------------------------------------------------------------
  // SECTION 6 — Cousin types comparison
  // -------------------------------------------------------------------
  print('\n=== Section 6: Cousin types ===');
  print('  TapDownDetails        — plain tap; no consecutiveTapCount');
  print('  DragDownDetails       — plain drag; no consecutiveTapCount');
  print('  TapDragDownDetails ★  — tap+drag combo; HAS the count');
  print('  TapDragStartDetails   — drag has just started (after taps)');
  print('  TapDragUpdateDetails  — drag is moving');
  print('  TapDragUpDetails      — finger lifted; tap completed');
  print('  TapDragEndDetails     — drag finished');
  print('  SerialTapDownDetails  — pure-tap counter (no drag escalate)');

  // -------------------------------------------------------------------
  // SECTION 7 — Cheat-sheet log
  // -------------------------------------------------------------------
  print('\n=== Section 7: Where TapAndDragGestureRecognizer earns its keep ===');
  print('  * Text editors  : drag-select word on count=2, paragraph=3');
  print('  * Map / images  : double-tap-and-drag to zoom-pan');
  print('  * Sliders       : double-tap to fine-tune, then drag');
  print('  * File managers : tap-then-drag to box-select files');
  print('  * Drawing apps  : double-tap pen for "smoothed" stroke mode');
  print('  * Replaces ad-hoc TapGestureRecognizer + DragGestureRecognizer');
  print('    pairs that fight each other in the gesture arena.');

  // ===================================================================
  // Build the visual root.
  // ===================================================================
  return SingleChildScrollView(
    child: Container(
      color: kCream,
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ===========================================================
          // SECTION 1 — Title banner
          // ===========================================================
          _sectionHeader(
            1,
            'TapDragDownDetails',
            'The down-event of a tap that may yet escalate into a drag',
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [kSlate, kCobaltDeep, kSlate],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 12,
                  offset: Offset(2, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                _tapBadge(1),
                const SizedBox(width: 8),
                _tapBadge(2),
                const SizedBox(width: 8),
                _tapBadge(3),
                const SizedBox(width: 8),
                _tapBadge(4),
                const SizedBox(width: 8),
                _tapBadge(5),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A tap-then-drag, decoded.',
                        style: TextStyle(
                          color: kCream,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'globalPosition · localPosition · kind · '
                        'consecutiveTapCount',
                        style: TextStyle(
                          color: kCoralSoft,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 2 — Anatomy diagram (with dotted-border boxes)
          // ===========================================================
          _sectionHeader(
            2,
            'Anatomy of TapDragDownDetails',
            'Each field, what it carries, and how it is used downstream',
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kCream,
              border: Border.all(color: kCobaltDeep, width: 2),
              borderRadius: BorderRadius.circular(10),
              gradient: const RadialGradient(
                colors: [kCream, kCreamDeep],
                center: Alignment.center,
                radius: 1.2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kSlate,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'TapDragDownDetails',
                        style: TextStyle(
                          color: kCream,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field(
                            'globalPosition',
                            '${anchor.globalPosition}',
                          ),
                          _field(
                            'localPosition',
                            '${anchor.localPosition}',
                          ),
                          _field('kind', '${anchor.kind}'),
                          _field(
                            'consecutiveTapCount',
                            '${anchor.consecutiveTapCount}  ← discriminator',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _wire(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _dottedBorderBox(
                        color: kCobalt,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'globalPosition',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kCobaltDeep,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Offset in the device / screen frame. '
                              'Suitable for hit-testing arbitrary widgets, '
                              'logging telemetry, or feeding into an '
                              'overlay positioned outside the receiving '
                              'box.',
                              style: TextStyle(
                                color: kSlate,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _dottedBorderBox(
                        color: kCoral,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'localPosition',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kCoralDeep,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Offset inside the receiving box. (0,0) is '
                              'the top-left corner of *that* widget. Use '
                              'this when you compute selection ranges, '
                              'paint custom highlights, or animate the '
                              'finger crosshair.',
                              style: TextStyle(
                                color: kSlate,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _dottedBorderBox(
                        color: kTeal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'kind  (nullable!)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTeal,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'PointerDeviceKind? — touch, mouse, stylus, '
                              'invertedStylus, trackpad, unknown, or null. '
                              'Branch on this to gate features that only '
                              'make sense for a real input device (e.g. '
                              'right-click context menus on mouse).',
                              style: TextStyle(
                                color: kSlate,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _dottedBorderBox(
                        color: kViolet,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'consecutiveTapCount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kViolet,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Integer ≥ 1. The discriminator. 1 for a '
                              'fresh tap, 2 for a double-tap, 3 for a '
                              'triple-tap, etc. The recognizer maintains '
                              'this for you — no manual timer needed.',
                              style: TextStyle(
                                color: kSlate,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                _wire(),
                Wrap(
                  children: [
                    _pill('count = 1  → solo tap', kCobaltSoft, kCream),
                    _pill('count = 2  → double tap', kCoral, kCream),
                    _pill('count = 3  → triple tap', kAmber, kSlate),
                    _pill('count = 4  → quad tap', kSage, kCream),
                    _pill('count ≥ 5  → keep counting', kViolet, kCream),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'globalPosition is in the device\'s coordinate space; '
                  'localPosition is relative to the box that received the '
                  'hit; consecutiveTapCount is the recognizer\'s running '
                  'count of consecutive taps.',
                  style: TextStyle(
                    color: kSlateSoft,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 3 — Visual representation of consecutive tapping
          // ===========================================================
          _sectionHeader(
            3,
            'Visual: consecutive tap counting',
            'Single → double → triple → quad → penta — each a coral pulse',
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [kCobaltDeep, kCobalt, kSlate],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 10,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tapBadge(1),
                        const SizedBox(height: 6),
                        const Text(
                          'count = 1\nsolo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,
                        color: kCoralSoft, size: 28),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tapBadge(2),
                        const SizedBox(height: 6),
                        const Text(
                          'count = 2\ndouble',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,
                        color: kCoralSoft, size: 28),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tapBadge(3),
                        const SizedBox(height: 6),
                        const Text(
                          'count = 3\ntriple',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,
                        color: kCoralSoft, size: 28),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tapBadge(4),
                        const SizedBox(height: 6),
                        const Text(
                          'count = 4\nquad',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,
                        color: kCoralSoft, size: 28),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tapBadge(5),
                        const SizedBox(height: 6),
                        const Text(
                          'count = 5\npenta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kSlate.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Each subsequent tap must arrive within '
                    'kDoubleTapTimeout (~300 ms) AND within kDoubleTapSlop '
                    '(~18 px) of the previous one. Otherwise the count '
                    'resets to 1 and we start a fresh sequence.',
                    style: TextStyle(
                      color: kCream,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 4 — Gallery of TapDragDownDetails values
          // ===========================================================
          _sectionHeader(
            4,
            'Gallery — consecutiveTapCount = 1..5',
            'Six framed cards showing escalating taps and devices',
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              _frame(
                title: 'count = 1 (solo · touch)',
                border: kCobaltSoft,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(1),
                    const SizedBox(height: 4),
                    _field('global', '${gallery[0].globalPosition}'),
                    _field('local', '${gallery[0].localPosition}'),
                    _field('kind', '${gallery[0].kind}'),
                    _field('count', '${gallery[0].consecutiveTapCount}'),
                  ],
                ),
              ),
              _frame(
                title: 'count = 2 (double · touch)',
                border: kCoral,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(2),
                    const SizedBox(height: 4),
                    _field('global', '${gallery[1].globalPosition}'),
                    _field('local', '${gallery[1].localPosition}'),
                    _field('kind', '${gallery[1].kind}'),
                    _field('count', '${gallery[1].consecutiveTapCount}'),
                  ],
                ),
              ),
              _frame(
                title: 'count = 3 (triple · mouse)',
                border: kAmber,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(3),
                    const SizedBox(height: 4),
                    _field('global', '${gallery[2].globalPosition}'),
                    _field('local', '${gallery[2].localPosition}'),
                    _field('kind', '${gallery[2].kind}'),
                    _field('count', '${gallery[2].consecutiveTapCount}'),
                  ],
                ),
              ),
              _frame(
                title: 'count = 4 (quad · mouse)',
                border: kSage,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(4),
                    const SizedBox(height: 4),
                    _field('global', '${gallery[3].globalPosition}'),
                    _field('local', '${gallery[3].localPosition}'),
                    _field('kind', '${gallery[3].kind}'),
                    _field('count', '${gallery[3].consecutiveTapCount}'),
                  ],
                ),
              ),
              _frame(
                title: 'count = 5 (penta · stylus)',
                border: kViolet,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(5),
                    const SizedBox(height: 4),
                    _field('global', '${gallery[4].globalPosition}'),
                    _field('local', '${gallery[4].localPosition}'),
                    _field('kind', '${gallery[4].kind}'),
                    _field('count', '${gallery[4].consecutiveTapCount}'),
                  ],
                ),
              ),
              _frame(
                title: 'anchor (count = 1 · touch)',
                border: kTeal,
                fill: kCreamDeep,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tapBadge(1),
                    const SizedBox(height: 4),
                    _field('global', '${anchor.globalPosition}'),
                    _field('local', '${anchor.localPosition}'),
                    _field('kind', '${anchor.kind}'),
                    _field('count', '${anchor.consecutiveTapCount}'),
                  ],
                ),
              ),
            ],
          ),

          // ===========================================================
          // SECTION 5 — PointerDeviceKind matrix
          // ===========================================================
          _sectionHeader(
            5,
            'PointerDeviceKind variations',
            'TapDragDownDetails works with any device kind, including null',
          ),
          Container(
            decoration: BoxDecoration(
              color: kCream,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kSlate, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 6,
                  offset: Offset(1, 2),
                ),
              ],
              gradient: const LinearGradient(
                colors: [kCream, kCreamDeep],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _frame(
                        title: 'touch',
                        border: kSage,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kind', '${kindTouch.kind}'),
                            _field('count',
                                '${kindTouch.consecutiveTapCount}'),
                            _pill('finger contact', kSage, kCream),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _frame(
                        title: 'mouse',
                        border: kCobalt,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kind', '${kindMouse.kind}'),
                            _field('count',
                                '${kindMouse.consecutiveTapCount}'),
                            _pill('mouse pointer', kCobalt, kCream),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _frame(
                        title: 'stylus',
                        border: kAmber,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kind', '${kindStylus.kind}'),
                            _field('count',
                                '${kindStylus.consecutiveTapCount}'),
                            _pill('pen tip', kAmber, kSlate),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _frame(
                        title: 'invertedStylus',
                        border: kSlate,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kind', '${kindInverted.kind}'),
                            _field('count',
                                '${kindInverted.consecutiveTapCount}'),
                            _pill('eraser end', kSlate, kCream),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _frame(
                        title: 'trackpad',
                        border: kTeal,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kind', '${kindTrackpad.kind}'),
                            _field('count',
                                '${kindTrackpad.consecutiveTapCount}'),
                            _pill('multi-touch surface', kTeal, kCream),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _frame(
                        title: 'unknown / null',
                        border: kSlateLight,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _field('kindUnknown', '${kindUnknown.kind}'),
                            _field('kindNull', '${kindNull.kind}'),
                            _pill(
                                'kind is nullable', kSlateLight, kCream),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 6 — Comparison: TapDragDown vs TapDown vs DragDown
          // ===========================================================
          _sectionHeader(
            6,
            'Cousins: TapDragDownDetails vs TapDownDetails vs DragDownDetails',
            'Same down-event, three different worldviews',
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kCream,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kSlate, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 6,
                  offset: Offset(1, 3),
                ),
              ],
              gradient: const LinearGradient(
                colors: [kCreamDeep, kCream],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header row
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(color: kSlate),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'Type',
                          style: TextStyle(
                            color: kCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(color: kSlate),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'global/local',
                          style: TextStyle(
                            color: kCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(color: kSlate),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'kind?',
                          style: TextStyle(
                            color: kCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(color: kSlate),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'tap-count?',
                          style: TextStyle(
                            color: kCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(color: kSlate),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'Used by',
                          style: TextStyle(
                            color: kCream,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row: TapDownDetails
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'TapDownDetails',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'YES',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'YES (req.)',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'no',
                          style: TextStyle(fontSize: 11, color: kCoralDeep),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'TapGestureRecognizer.onTapDown',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row: TapDragDownDetails ★
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'TapDragDownDetails ★',
                          style: TextStyle(
                            fontSize: 11,
                            color: kCobaltDeep,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES (null-able)',
                          style:
                              TextStyle(fontSize: 11, color: kAmber),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES — consecutiveTapCount',
                          style: TextStyle(
                            fontSize: 11,
                            color: kSage,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'TapAndDragGestureRecognizer.onTapDown',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row: DragDownDetails
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'DragDownDetails',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'YES',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'no',
                          style: TextStyle(fontSize: 11, color: kCoralDeep),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'no',
                          style: TextStyle(fontSize: 11, color: kCoralDeep),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCreamDeep),
                        child: const Text(
                          'PanGestureRecognizer.onDown (and friends)',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row: SerialTapDownDetails (closely related)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'SerialTapDownDetails',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES (req.)',
                          style:
                              TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'YES — count (no drag)',
                          style: TextStyle(fontSize: 11, color: kSage),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: kCream),
                        child: const Text(
                          'SerialTapGestureRecognizer.onSerialTapDown',
                          style: TextStyle(fontSize: 11, color: kSlate),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 7 — Lifecycle storyboard
          // ===========================================================
          _sectionHeader(
            7,
            'Lifecycle: tap-then-drag in motion',
            'Down → (maybe more taps) → DragStart → DragUpdate → DragEnd',
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [kSlateSoft, kSlate],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 8,
                  offset: Offset(1, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _tapBadge(1),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                't = 0 ms — onTapDown(TapDragDownDetails) '
                                'count=1',
                                style: TextStyle(
                                  color: kCream,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              _field('global',
                                  '${lifeT1Down.globalPosition}'),
                              _field('local',
                                  '${lifeT1Down.localPosition}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _wire(),
                    _arrow('↓ within kDoubleTapTimeout (~300 ms)',
                        kAmber, kSlate),
                    _wire(),
                    Row(
                      children: [
                        _tapBadge(2),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                't = ~150 ms — onTapDown(TapDragDownDetails) '
                                'count=2',
                                style: TextStyle(
                                  color: kCream,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              _field('global',
                                  '${lifeT2Down.globalPosition}'),
                              _field('local',
                                  '${lifeT2Down.localPosition}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _wire(),
                    _arrow('↓ within kDoubleTapSlop (~18 px)',
                        kAmber, kSlate),
                    _wire(),
                    Row(
                      children: [
                        _tapBadge(3),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                't = ~280 ms — onTapDown(TapDragDownDetails) '
                                'count=3',
                                style: TextStyle(
                                  color: kCream,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              _field('global',
                                  '${lifeT3Down.globalPosition}'),
                              _field('local',
                                  '${lifeT3Down.localPosition}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _wire(),
                    _arrow('↓ pointer moves > kPrecisePointerHitSlop',
                        kCoral, kCream),
                    _wire(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kCobalt, kCobaltDeep],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.swipe, color: kCream, size: 18),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'onDragStart(TapDragStartDetails) '
                                '— consecutiveTapCount carries over from '
                                'the most-recent down. count=3 means a '
                                'paragraph-drag in a text editor.',
                                style: TextStyle(
                                  color: kCream,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kTeal, kCobaltDeep],
                          ),
                        ),
                        child: const Text(
                          'onDragUpdate(TapDragUpdateDetails) — fires '
                          'repeatedly as the pointer moves; the same '
                          'consecutiveTapCount stays attached so you '
                          'know what kind of drag this is.',
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kCoralDeep, kCoral],
                          ),
                        ),
                        child: const Text(
                          'onDragEnd(TapDragEndDetails) — pointer '
                          'released. If the user never moved past the '
                          'slop, you get onTapUp(TapDragUpDetails) '
                          'instead.',
                          style: TextStyle(
                            color: kCream,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: kSage,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: kCream,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 8 — Detection flow narrative
          // ===========================================================
          _sectionHeader(
            8,
            'How TapAndDragGestureRecognizer wires it up',
            'From PointerDownEvent through the gesture arena to your callback',
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kCream,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kCobaltDeep, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 6,
                  offset: Offset(1, 3),
                ),
              ],
              gradient: const RadialGradient(
                colors: [kCream, kCreamDeep],
                center: Alignment.topLeft,
                radius: 1.4,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Event journey',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSlate,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                _arrow('PointerDownEvent', kCobaltSoft, kCream),
                _arrow(
                    'GestureBinding.handlePointerEvent', kCobalt, kCream),
                _arrow('PointerRouter.route', kCobalt, kCream),
                _arrow('GestureArenaManager.add()', kSlateSoft, kCream),
                _arrow('TapAndDragGestureRecognizer.addPointer()',
                    kCobaltDeep, kCream),
                _arrow(
                    'recognizer wins arena ⟶ accept', kSage, kCream),
                _arrow('★ onTapDown(TapDragDownDetails) ★',
                    kCoral, kCream),
                _arrow('… pointer moves > slop …', kAmber, kSlate),
                _arrow(
                    'onDragStart(TapDragStartDetails)', kCobalt, kCream),
                _arrow('onDragUpdate(...) repeatedly', kTeal, kCream),
                _arrow('onDragEnd(TapDragEndDetails)', kCoralDeep, kCream),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kSlate,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'TapAndDragGestureRecognizer is the abstract base; '
                    'TapAndPanGestureRecognizer (panning in any '
                    'direction) and TapAndHorizontalDragGestureRecognizer '
                    '(constrained to the X axis) are the two concrete '
                    'subclasses that ship with Flutter. All three deliver '
                    'TapDragDownDetails to onTapDown.',
                    style: TextStyle(
                      color: kCream,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 9 — Anchor field-by-field call-out
          // ===========================================================
          _sectionHeader(
            9,
            'Anchor instance — field-by-field',
            'A close-up read-out of the canonical example',
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [kCream, kCreamDeep, kCream],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: kCobaltDeep, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 10,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _tapBadge(anchor.consecutiveTapCount),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Anchor — what an onTapDown callback would see',
                        style: TextStyle(
                          color: kSlate,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _field('runtimeType', '${anchor.runtimeType}'),
                _field('globalPosition', '${anchor.globalPosition}'),
                _field('localPosition', '${anchor.localPosition}'),
                _field('kind', '${anchor.kind}'),
                _field('consecutiveTapCount',
                    '${anchor.consecutiveTapCount}'),
                _wire(),
                Wrap(
                  children: [
                    _pill('hashCode',
                        kSlateSoft, kCream),
                    _pill('!= operator (default Object identity)',
                        kSlateSoft, kCream),
                    _pill('toString → DiagnosticableTreeMixin',
                        kSlateSoft, kCream),
                    _pill('debugFillProperties (overridden)',
                        kCobalt, kCream),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'TapDragDownDetails mixes in Diagnosticable, so it '
                  'integrates with the Flutter inspector and prints a '
                  'rich, structured representation when used in a '
                  'DiagnosticPropertiesBuilder. It does NOT override == '
                  'or hashCode, so equality is reference-based.',
                  style: TextStyle(
                    color: kSlateSoft,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 10 — Cheat-sheet
          // ===========================================================
          _sectionHeader(
            10,
            'Cheat-sheet',
            'Where TapAndDragGestureRecognizer (and TapDragDownDetails) shine',
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [kCream, kCreamDeep, kCream],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: kSlate, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 10,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '✓ count == 1   tap → place caret; drag → range select',
                  style: TextStyle(color: kSlate, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '✓ count == 2   double-tap → select word; drag → '
                  'extend by word',
                  style: TextStyle(color: kSlate, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '✓ count == 3   triple-tap → select line/paragraph; '
                  'drag → extend by paragraph',
                  style: TextStyle(color: kSlate, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '✓ count == 4   quad-tap → custom (e.g. select all + '
                  'drag to scroll)',
                  style: TextStyle(color: kSlate, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '✓ count >= 5   penta+ → free for app-specific tricks',
                  style: TextStyle(color: kSlate, fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  'Use TapAndDragGestureRecognizer (or its '
                  'TapAndPanGestureRecognizer / '
                  'TapAndHorizontalDragGestureRecognizer subclasses) '
                  'instead of stacking TapGestureRecognizer + '
                  'PanGestureRecognizer; the combined recognizer keeps '
                  'consecutiveTapCount for you and routes tap-then-drag '
                  'callbacks consistently. The TapDragDownDetails payload '
                  'is the very first signal that a tap-then-drag gesture '
                  'has begun.',
                  style: TextStyle(
                    color: kSlateSoft,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // Footer
          // ===========================================================
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kSlate,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 4),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: kCoral, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'TapDragDownDetails — count='
                    '${anchor.consecutiveTapCount}, '
                    'kind=${anchor.kind}, '
                    'global=${anchor.globalPosition}',
                    style: const TextStyle(
                      color: kCream,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
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
