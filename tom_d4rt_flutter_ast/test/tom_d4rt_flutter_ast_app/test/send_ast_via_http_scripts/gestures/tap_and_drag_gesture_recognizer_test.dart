// =====================================================================
// TapAndDragGestureRecognizer — Deep Demo (Cobalt Edition)
// =====================================================================
//
// TapAndDragGestureRecognizer is the gesture recognizer used by Flutter's
// selectable text infrastructure. It is the most general member of the
// "Base tap-and-drag" family — sister to TapAndHorizontalDragGesture-
// Recognizer (axis-locked horizontal drag) and TapAndPanGestureRecognizer
// (free-direction pan with similar tap-counting). The recognizer fuses
// two normally-conflicting recognizers into a single state machine:
//
//   * a tap recognizer that latches consecutive taps inside a deadband
//     window, so it can announce double-, triple-, and N-tap events;
//   * a drag recognizer that, after any tap, will start producing
//     drag-update events as soon as the pointer crosses kTouchSlop.
//
// The combination is what makes selectable text feel right: tap to place
// the caret, double-tap-and-drag to extend the selection word-by-word,
// triple-tap-and-drag to extend it paragraph-by-paragraph, and so on.
// Each callback receives a TapDrag*Details payload that carries the
// pointer geometry plus a `consecutiveTapCount` so handlers can branch
// on how many taps preceded the current one.
//
// Constructor parameters (all optional):
//   * debugOwner          — opaque owner used in debug output;
//   * supportedDevices    — Set<PointerDeviceKind>? whitelist of inputs;
//   * eagerVictoryOnDrag  — bool, defaults to true. When true the
//                           recognizer claims the gesture arena the
//                           moment it sees a drag exceed slop. When
//                           false it waits until pointer-up to resolve.
//
// Callbacks:
//   * onTapDown    : GestureTapDragDownCallback?     (TapDragDownDetails)
//   * onTapUp      : GestureTapDragUpCallback?       (TapDragUpDetails)
//   * onTapCancel  : GestureTapDragCancelCallback?   (no payload)
//   * onDragStart  : GestureTapDragStartCallback?    (TapDragStartDetails)
//   * onDragUpdate : GestureTapDragUpdateCallback?   (TapDragUpdateDetails)
//   * onDragEnd    : GestureTapDragEndCallback?      (TapDragEndDetails)
//   * onCancel     : GestureCancelCallback?
//
// This file is a hand-authored visual demo. It does not instantiate the
// recognizer or attach it to a hit-testable surface; instead it lays out
// a static catalogue of the API surface, the state machine, the use
// cases, the consecutiveTapCount semantics, and the constructor knobs.
// The intent is twofold: serve as a smoke-test fixture for the D4rt-AST
// interpreter (the script must build cleanly under d4rt) and double as
// a printable reference card for engineers wiring up text selection or
// other tap-then-drag widgets.
//
// Theme: deep blue / cobalt / steel, with coral accents for the
// tap-counter highlights and a soft cream backdrop for paper-like
// surfaces. The visual metaphor is a precision blueprint of the
// recognizer drawn on cobalt drafting paper.
// =====================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// A typed reference into package:flutter/gestures.dart so that the
// import is not flagged as unnecessary by the analyzer. The list shows
// every PointerDeviceKind a TapAndDragGestureRecognizer can route at
// runtime, with the convenient touch / mouse / stylus trio surfaced
// first since they are by far the most common in app code.
const List<PointerDeviceKind> kSupportedKindsForDemo = <PointerDeviceKind>[
  PointerDeviceKind.touch,
  PointerDeviceKind.mouse,
  PointerDeviceKind.stylus,
  PointerDeviceKind.invertedStylus,
  PointerDeviceKind.trackpad,
  PointerDeviceKind.unknown,
];

// ---------------------------------------------------------------------
// Color palette — cobalt / steel / coral / cream
// ---------------------------------------------------------------------
const Color kCobalt = Color(0xFF1F4FA8);
const Color kCobaltDeep = Color(0xFF0F2A5F);
const Color kCobaltDeeper = Color(0xFF071833);
const Color kCobaltSoft = Color(0xFF6E91D4);
const Color kCobaltMist = Color(0xFFB7CCEC);
const Color kSteel = Color(0xFF334155);
const Color kSteelSoft = Color(0xFF64748B);
const Color kSteelLight = Color(0xFF94A3B8);
const Color kCream = Color(0xFFF6F1E4);
const Color kCreamDeep = Color(0xFFE8E0CC);
const Color kCoral = Color(0xFFFF6F61);
const Color kCoralDeep = Color(0xFFB23A2D);
const Color kCoralSoft = Color(0xFFFFB1A8);
const Color kAmber = Color(0xFFFFB347);
const Color kSage = Color(0xFF8BAA80);
const Color kViolet = Color(0xFF7E5BB0);
const Color kTeal = Color(0xFF1F8E8E);
const Color kInk = Color(0xFF0B1220);
const Color kShadow = Color(0xFF0A0F1C);
const Color kPaper = Color(0xFFFCFAF3);
const Color kHighlight = Color(0xFFFFE08A);

// ---------------------------------------------------------------------
// Helper: framed card with a title strip and a body widget.
// ---------------------------------------------------------------------
Widget makeFrame({
  required String title,
  required Widget body,
  Color border = kCobalt,
  Color fill = kCream,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
      gradient: const LinearGradient(
        colors: [kCream, kCreamDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: border,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kCream,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 8),
        body,
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: small pill / chip with a label.
// ---------------------------------------------------------------------
Widget makePill(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
// Helper: divider styled as a cobalt-coral wire.
// ---------------------------------------------------------------------
Widget makeWire() {
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
// Helper: section header strip used by the top-level layout.
// ---------------------------------------------------------------------
Widget makeSectionHeader(int number, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.only(top: 18, bottom: 10, left: 4, right: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kCobaltDeep, kCobalt, kCobaltSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kCobaltDeeper, width: 2),
      boxShadow: const [
        BoxShadow(
          color: kShadow,
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(2, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: kCream,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kShadow,
                blurRadius: 4,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: kCobaltDeep,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: kCream,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kCobaltMist,
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
// Helper: monospace code block with cobalt syntax tint.
// ---------------------------------------------------------------------
Widget makeCodeBlock(List<String> lines) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${i + 1}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: kSteelLight,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                lines[i],
                style: const TextStyle(
                  color: kCream,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: kCobaltDeeper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kCobalt, width: 1.5),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 6, offset: Offset(1, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: rows,
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a coral-pulsed tap-counter badge sized by tap-count.
// ---------------------------------------------------------------------
Widget makeTapBadge(int count) {
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
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [cap, kSteel],
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
// Helper: a single state-node bubble for the state-machine diagram.
// ---------------------------------------------------------------------
Widget makeStateNode(String label, String hint, Color bg) {
  return Container(
    width: 130,
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kCobaltDeeper, width: 1.5),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 5, offset: Offset(1, 2)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kCream,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hint,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kCobaltMist,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: arrow used between state nodes.
// ---------------------------------------------------------------------
Widget makeArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.arrow_forward, color: kCoral, size: 18),
        Text(
          label,
          style: const TextStyle(
            color: kCoralDeep,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a callback descriptor card for the callbacks grid.
// ---------------------------------------------------------------------
Widget makeCallbackCard({
  required String name,
  required String signature,
  required String purpose,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    width: 280,
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent, width: 2),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 5, offset: Offset(1, 2)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 18),
            const SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: kCobaltDeeper,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            signature,
            style: const TextStyle(
              color: kCream,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          purpose,
          style: const TextStyle(color: kSteel, fontSize: 11, height: 1.35),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a comparison column for the recognizer comparison panel.
// ---------------------------------------------------------------------
Widget makeCompareColumn({
  required String title,
  required String tagline,
  required List<String> bullets,
  required Color border,
}) {
  final List<Widget> bulletWidgets = <Widget>[];
  for (final String b in bullets) {
    bulletWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.fiber_manual_record, color: kCoral, size: 8),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                b,
                style: const TextStyle(color: kSteel, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    width: 270,
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border, width: 2.5),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 6, offset: Offset(1, 3)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: border,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          tagline,
          style: const TextStyle(
            color: kSteelSoft,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bulletWidgets,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a textual selection visualization — words with optional
// highlights modeling tap-and-drag selection at various tap counts.
// ---------------------------------------------------------------------
Widget makeSelectionStrip({
  required List<String> words,
  required int selectStart,
  required int selectEnd,
  required Color highlight,
}) {
  final List<Widget> spans = <Widget>[];
  for (int i = 0; i < words.length; i++) {
    final bool isSel = i >= selectStart && i <= selectEnd;
    spans.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: isSel ? highlight : kPaper,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: isSel ? kCoralDeep : kSteelLight,
            width: 1,
          ),
        ),
        child: Text(
          words[i],
          style: TextStyle(
            color: isSel ? kInk : kSteel,
            fontSize: 12,
            fontWeight: isSel ? FontWeight.w700 : FontWeight.w400,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: spans,
  );
}

// ---------------------------------------------------------------------
// Helper: caveat tile for the caveats section.
// ---------------------------------------------------------------------
Widget makeCaveatTile({
  required String head,
  required String body,
  required Color tint,
  required IconData icon,
}) {
  return Container(
    width: 320,
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint, width: 2),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 4, offset: Offset(1, 2)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tint, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                head,
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            color: kSteel,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a labelled icon used in real-world example cards.
// ---------------------------------------------------------------------
Widget makeRealWorldCard({
  required String title,
  required String body,
  required IconData icon,
  required Color tint,
}) {
  return Container(
    width: 270,
    margin: const EdgeInsets.all(6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [kPaper, tint.withValues(alpha: 0.15)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint, width: 2),
      boxShadow: const [
        BoxShadow(color: kShadow, blurRadius: 5, offset: Offset(1, 2)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: kCream, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: tint,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: kSteel,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// build — top-level entry-point for d4rt
// =====================================================================
dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kCream,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===========================================================
          // SECTION 1 — Hero header
          // ===========================================================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kCobaltDeeper, kCobaltDeep, kCobalt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kCobaltDeeper, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 14,
                  spreadRadius: 1,
                  offset: Offset(3, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kCream,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: kShadow,
                        blurRadius: 8,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(
                        Icons.touch_app,
                        color: kCobaltDeep,
                        size: 38,
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(
                          Icons.swipe,
                          color: kCoral,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'TapAndDragGestureRecognizer',
                        style: TextStyle(
                          color: kCream,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'package:flutter/gestures.dart',
                        style: TextStyle(
                          color: kCobaltMist,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Combined tap + free-direction drag, with '
                        'consecutiveTapCount for selection-style '
                        'multi-tap-and-drag interactions.',
                        style: TextStyle(
                          color: kCream,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 2 — Use case explainer
          // ===========================================================
          makeSectionHeader(
            2,
            'Primary use case: text selection',
            'Why selectable text needs a fused tap-and-drag recognizer',
          ),
          makeFrame(
            title: 'Tap → caret, double-tap-and-drag → word selection',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selectable text needs a single recognizer that knows '
                  'how to count consecutive taps AND how to follow a '
                  'drag, because the drag\'s semantics depend on the tap '
                  'count: one tap places the caret and a drag from there '
                  'extends a character-level selection; a double tap '
                  'selects the word under the pointer and a drag extends '
                  'word-by-word; a triple tap selects the line/paragraph '
                  'and a drag extends paragraph-by-paragraph. Stacking a '
                  'TapGestureRecognizer next to a PanGestureRecognizer '
                  'cannot model this because the two would compete in '
                  'the gesture arena and only one would win.',
                  style: TextStyle(
                    color: kSteel,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Visualisation — drag from "fox" while in '
                  'consecutiveTapCount == 2:',
                  style: const TextStyle(
                    color: kCobaltDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                makeSelectionStrip(
                  words: const [
                    'The',
                    'quick',
                    'brown',
                    'fox',
                    'jumps',
                    'over',
                    'the',
                    'lazy',
                    'dog',
                  ],
                  selectStart: 3,
                  selectEnd: 6,
                  highlight: kHighlight,
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    makePill('tap-down', kCobalt, kCream),
                    makePill('tap-up', kCobalt, kCream),
                    makePill('drag-start', kCoral, kCream),
                    makePill('drag-update*', kCoral, kCream),
                    makePill('drag-end', kCoral, kCream),
                  ],
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 3 — State machine
          // ===========================================================
          makeSectionHeader(
            3,
            'State machine',
            'The seven-phase lifecycle, with consecutiveTapCount notes',
          ),
          makeFrame(
            title: 'idle → tap-down → tap-up → drag-start → drag-end',
            border: kCoral,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    makeStateNode('idle', 'no pointers', kSteel),
                    makeArrow('down'),
                    makeStateNode(
                      'tap-down(N)',
                      'count=N',
                      kCobalt,
                    ),
                    makeArrow('lift'),
                    makeStateNode(
                      'tap-up(N)',
                      'pure tap',
                      kCobaltDeep,
                    ),
                    makeArrow('settle'),
                    makeStateNode('idle', 'cycle done', kSteel),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    makeStateNode(
                      'tap-down(N)',
                      'count=N',
                      kCobalt,
                    ),
                    makeArrow('slop+'),
                    makeStateNode(
                      'drag-start',
                      'now panning',
                      kCoral,
                    ),
                    makeArrow('move'),
                    makeStateNode(
                      'drag-update*',
                      'fires often',
                      kCoralDeep,
                    ),
                    makeArrow('lift'),
                    makeStateNode(
                      'drag-end',
                      'velocity',
                      kCoralDeep,
                    ),
                    makeArrow('settle'),
                    makeStateNode('idle', 'reset', kSteel),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'consecutiveTapCount is reset to 1 on the first tap of '
                  'a new run, and incremented on every subsequent tap '
                  'whose down-time falls inside the recognizer\'s '
                  'consecutive-tap window. A drag inherits the count '
                  'that was current when the most recent tap-down fired '
                  '— so a triple-click-then-drag emits drag-update '
                  'events whose details.consecutiveTapCount == 3.',
                  style: TextStyle(
                    color: kSteel,
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // SECTION 4 — Callbacks grid
          // ===========================================================
          makeSectionHeader(
            4,
            'Callbacks',
            'The seven hooks: signatures and purpose',
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              makeCallbackCard(
                name: 'onTapDown',
                signature:
                    'void Function(TapDragDownDetails details)',
                purpose:
                    'Fires the moment the recognizer wins the down phase. '
                    'Carries globalPosition, localPosition, kind, and '
                    'consecutiveTapCount. Use it to place a caret or '
                    'highlight a target before any drag starts.',
                accent: kCobaltDeep,
                icon: Icons.south,
              ),
              makeCallbackCard(
                name: 'onTapUp',
                signature: 'void Function(TapDragUpDetails details)',
                purpose:
                    'Fires when the pointer is lifted WITHOUT having '
                    'crossed kTouchSlop. The recognizer treats the run '
                    'as a pure tap. consecutiveTapCount tells you '
                    'whether this was a single-, double-, or triple-tap.',
                accent: kCobalt,
                icon: Icons.north,
              ),
              makeCallbackCard(
                name: 'onTapCancel',
                signature: 'void Function()',
                purpose:
                    'Fires when a pending tap is cancelled — e.g. another '
                    'recognizer wins the arena, or the pointer leaves '
                    'the bound region. Reset any "preview" UI you put '
                    'up in onTapDown.',
                accent: kSteelSoft,
                icon: Icons.block,
              ),
              makeCallbackCard(
                name: 'onDragStart',
                signature:
                    'void Function(TapDragStartDetails details)',
                purpose:
                    'Fires when the pointer crosses kTouchSlop and the '
                    'recognizer commits to a drag. details.kind, '
                    'details.consecutiveTapCount, and the start '
                    'position are all available here.',
                accent: kCoral,
                icon: Icons.play_arrow,
              ),
              makeCallbackCard(
                name: 'onDragUpdate',
                signature:
                    'void Function(TapDragUpdateDetails details)',
                purpose:
                    'Fires repeatedly while the pointer is moving. '
                    'details.delta is the change since the last update; '
                    'details.primaryDelta is non-null only on axis-locked '
                    'subclasses (TapAndHorizontalDragGestureRecognizer).',
                accent: kCoralDeep,
                icon: Icons.repeat,
              ),
              makeCallbackCard(
                name: 'onDragEnd',
                signature:
                    'void Function(TapDragEndDetails details)',
                purpose:
                    'Fires when the pointer is lifted after a drag. '
                    'details.velocity is the final pointer velocity, '
                    'usable for fling-style follow-through (e.g. '
                    'momentum-scrolling a selection).',
                accent: kCoralDeep,
                icon: Icons.stop,
              ),
              makeCallbackCard(
                name: 'onCancel',
                signature: 'void Function()',
                purpose:
                    'Fires when the entire gesture is cancelled — for '
                    'instance the pointer was hijacked by a parent '
                    'recognizer that won the arena later in the cycle. '
                    'Tear down any drag-induced state.',
                accent: kSteel,
                icon: Icons.cancel,
              ),
            ],
          ),

          // ===========================================================
          // SECTION 5 — consecutiveTapCount showcase
          // ===========================================================
          makeSectionHeader(
            5,
            'consecutiveTapCount',
            '1 = caret, 2 = word, 3 = paragraph, 4+ = custom',
          ),
          Wrap(
            children: [
              makeFrame(
                title: 'count == 1 — single tap, character drag',
                border: kCobaltSoft,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        makeTapBadge(1),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Place caret on tap-up; drag extends '
                            'character-by-character.',
                            style: TextStyle(
                              color: kSteel,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    makeSelectionStrip(
                      words: const [
                        'The',
                        'quick',
                        'brown',
                        'f|ox',
                        'jumps',
                      ],
                      selectStart: 3,
                      selectEnd: 3,
                      highlight: kCobaltMist,
                    ),
                  ],
                ),
              ),
              makeFrame(
                title: 'count == 2 — double tap, word drag',
                border: kCoral,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        makeTapBadge(2),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Select word on second tap; drag extends '
                            'word-by-word.',
                            style: TextStyle(
                              color: kSteel,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    makeSelectionStrip(
                      words: const [
                        'The',
                        'quick',
                        'brown',
                        'fox',
                        'jumps',
                        'over',
                      ],
                      selectStart: 2,
                      selectEnd: 4,
                      highlight: kHighlight,
                    ),
                  ],
                ),
              ),
              makeFrame(
                title: 'count == 3 — triple tap, paragraph drag',
                border: kAmber,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        makeTapBadge(3),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Select line/paragraph on third tap; drag '
                            'extends paragraph-by-paragraph.',
                            style: TextStyle(
                              color: kSteel,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    makeSelectionStrip(
                      words: const [
                        'The',
                        'quick',
                        'brown',
                        'fox',
                        'jumps',
                        'over',
                        'the',
                        'lazy',
                        'dog',
                      ],
                      selectStart: 0,
                      selectEnd: 8,
                      highlight: kAmber,
                    ),
                  ],
                ),
              ),
              makeFrame(
                title: 'count == 4 — custom (e.g. select-all-and-scroll)',
                border: kSage,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        makeTapBadge(4),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'No built-in semantics — your handler decides. '
                            'A common pattern is select-all on the fourth '
                            'tap and use the drag for autoscroll.',
                            style: TextStyle(
                              color: kSteel,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    makeSelectionStrip(
                      words: const [
                        'select',
                        'all',
                        'then',
                        'autoscroll',
                        'on',
                        'drag',
                      ],
                      selectStart: 0,
                      selectEnd: 5,
                      highlight: kSage,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ===========================================================
          // SECTION 6 — eagerVictoryOnDrag
          // ===========================================================
          makeSectionHeader(
            6,
            'eagerVictoryOnDrag',
            'Arena resolution: claim now or wait',
          ),
          Wrap(
            children: [
              makeFrame(
                title: 'eagerVictoryOnDrag: true (default)',
                border: kCobaltDeep,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The recognizer claims the gesture arena the moment '
                      'the pointer crosses kTouchSlop. Any sibling '
                      'recognizer that was waiting (e.g. an ancestor '
                      'PanGestureRecognizer) is rejected immediately. '
                      'Best when the recognizer is the LEAF that should '
                      'always win once a drag starts.',
                      style: TextStyle(
                        color: kSteel,
                        fontSize: 11,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      children: [
                        makePill('claim early', kCobaltDeep, kCream),
                        makePill('block siblings', kCobalt, kCream),
                        makePill('default', kSage, kCream),
                      ],
                    ),
                  ],
                ),
              ),
              makeFrame(
                title: 'eagerVictoryOnDrag: false',
                border: kCoralDeep,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The recognizer postpones its arena claim and lets '
                      'sibling recognizers continue to compete. Useful '
                      'when an outer recognizer (e.g. a horizontal page-'
                      'view swipe) MUST be allowed to take priority for '
                      'gestures that match its axis. The trade-off is a '
                      'short delay before drag-start fires.',
                      style: TextStyle(
                        color: kSteel,
                        fontSize: 11,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      children: [
                        makePill('co-operate', kCoralDeep, kCream),
                        makePill('late commit', kCoral, kCream),
                        makePill('opt-in', kSteel, kCream),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ===========================================================
          // SECTION 7 — Constructor source
          // ===========================================================
          makeSectionHeader(
            7,
            'Constructor source',
            'How you wire up the recognizer in practice',
          ),
          makeFrame(
            title: 'Cascade-style configuration',
            border: kCobaltDeep,
            body: makeCodeBlock(const [
              'final recognizer = TapAndDragGestureRecognizer(',
              '  debugOwner: this,',
              '  supportedDevices: <PointerDeviceKind>{',
              '    PointerDeviceKind.touch,',
              '    PointerDeviceKind.mouse,',
              '    PointerDeviceKind.stylus,',
              '  },',
              '  eagerVictoryOnDrag: true,',
              ')',
              '  ..onTapDown = (TapDragDownDetails d) {',
              '    // count == d.consecutiveTapCount',
              '    // place caret / preview / latch tap-count',
              '  }',
              '  ..onTapUp = (TapDragUpDetails d) {',
              '    // pure tap path — no drag occurred',
              '  }',
              '  ..onTapCancel = () {',
              '    // tear down preview UI',
              '  }',
              '  ..onDragStart = (TapDragStartDetails d) {',
              '    // commit to drag; d.consecutiveTapCount is latched',
              '  }',
              '  ..onDragUpdate = (TapDragUpdateDetails d) {',
              '    // d.delta carries the per-frame movement',
              '  }',
              '  ..onDragEnd = (TapDragEndDetails d) {',
              '    // d.velocity available for fling follow-through',
              '  }',
              '  ..onCancel = () {',
              '    // outer recognizer hijacked the gesture',
              '  };',
            ]),
          ),

          // ===========================================================
          // SECTION 8 — Comparison panel
          // ===========================================================
          makeSectionHeader(
            8,
            'Comparison',
            'TapAndDrag vs TapAndHorizontalDrag vs TapAndPan',
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              makeCompareColumn(
                title: 'TapAndDragGestureRecognizer',
                tagline: 'The general-purpose tap-and-drag.',
                bullets: const [
                  'Free-direction drag (no axis lock)',
                  'consecutiveTapCount on every callback payload',
                  'Used by SelectableText, TextField, TextSpan',
                  'Default eagerVictoryOnDrag is true',
                ],
                border: kCobaltDeep,
              ),
              makeCompareColumn(
                title: 'TapAndHorizontalDragGestureRecognizer',
                tagline: 'Axis-locked horizontal cousin.',
                bullets: const [
                  'Drag is rejected if it goes vertical',
                  'primaryDelta is single-axis (dx)',
                  'Used for swipe-to-dismiss + tap-to-act rows',
                  'Co-operates well with VerticalDragGestureRecognizer '
                      'siblings',
                ],
                border: kCoral,
              ),
              makeCompareColumn(
                title: 'TapAndPanGestureRecognizer',
                tagline: 'Free-pan tap cousin (mostly identical API).',
                bullets: const [
                  'Functionally similar to TapAndDrag',
                  'Naming preferred for canvas-style pan use cases',
                  'Used in InteractiveViewer-adjacent widgets',
                  'Same TapDrag*Details payload family',
                ],
                border: kAmber,
              ),
            ],
          ),

          // ===========================================================
          // SECTION 9 — Real-world examples
          // ===========================================================
          makeSectionHeader(
            9,
            'Real-world examples',
            'Where TapAndDragGestureRecognizer shows up in app code',
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              makeRealWorldCard(
                title: 'Selectable text in TextField',
                body:
                    'The canonical user. Single-tap to place caret, '
                    'double-tap to select word, double-tap-and-drag to '
                    'extend by word, triple-tap-and-drag to extend by '
                    'paragraph. Flutter\'s text-editing internals build '
                    'directly on this recognizer.',
                icon: Icons.text_fields,
                tint: kCobaltDeep,
              ),
              makeRealWorldCard(
                title: 'Image cropping handle',
                body:
                    'A single tap selects a corner handle (visual feedback '
                    'in onTapDown), and the subsequent drag resizes the '
                    'crop rect. consecutiveTapCount can be used to switch '
                    'between corner-resize and free-resize modes.',
                icon: Icons.crop,
                tint: kCoral,
              ),
              makeRealWorldCard(
                title: 'Pinned-zoom recognizer',
                body:
                    'Tap to anchor a zoom origin; drag to scale. The '
                    'tap\'s globalPosition becomes the focal point and '
                    'the drag\'s delta becomes the zoom delta. Pairs '
                    'well with eagerVictoryOnDrag: false so an outer '
                    'ScaleGestureRecognizer can pre-empt for two-finger '
                    'pinches.',
                icon: Icons.zoom_in_map,
                tint: kAmber,
              ),
              makeRealWorldCard(
                title: 'List-row reorder with tap-action',
                body:
                    'A row supports a quick tap (open the row\'s detail '
                    'page) AND a press-and-drag (reorder). The combined '
                    'recognizer keeps the two unambiguous; the row '
                    'cancels any tap-induced highlight in onCancel.',
                icon: Icons.swap_vert,
                tint: kSage,
              ),
            ],
          ),

          // ===========================================================
          // SECTION 10 — Caveats
          // ===========================================================
          makeSectionHeader(
            10,
            'Caveats',
            'Pitfalls to remember when wiring this recognizer',
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              makeCaveatTile(
                head: 'Arena ordering',
                body:
                    'TapAndDragGestureRecognizer competes in the arena '
                    'against any sibling pan, scale, or vertical-drag '
                    'recognizers. Insert it deepest in the widget tree '
                    'when you want it to win first; place it shallower '
                    'when you want it to defer to inner recognizers. '
                    'Wrong ordering is the most common reason a '
                    'tap-and-drag never fires.',
                tint: kCobaltDeep,
                icon: Icons.layers,
              ),
              makeCaveatTile(
                head: 'Double-tap-drag latch',
                body:
                    'consecutiveTapCount only increments while every tap '
                    'falls inside the recognizer\'s consecutive-tap '
                    'window AND inside its slop tolerance. Move a finger '
                    'too far between taps, or wait too long, and the '
                    'count silently resets to 1 — your "double-tap-drag" '
                    'becomes a plain "tap-drag" with no warning.',
                tint: kCoral,
                icon: Icons.timer,
              ),
              makeCaveatTile(
                head: 'kind / supportedDevices filter',
                body:
                    'If you pass a non-empty supportedDevices set, the '
                    'recognizer rejects every pointer whose '
                    'PointerDeviceKind is not in the set. This is a '
                    'silent rejection (no error, no callback) — confirm '
                    'the set lists every device class your UI accepts. '
                    'Beware: PointerDeviceKind.unknown is not in the '
                    'default platform set on every embedder.',
                tint: kAmber,
                icon: Icons.devices,
              ),
              makeCaveatTile(
                head: 'debugOwner attribution',
                body:
                    'The debugOwner is opaque but lands in '
                    'GestureBinding.debugAssertGesturesNotInProgress and '
                    'in DiagnosticsNode dumps. Pass `this` (or a '
                    'descriptive String) — leaving it null makes a '
                    'broken arena much harder to diagnose because every '
                    'recognizer in the dump shows up as <null>.',
                tint: kViolet,
                icon: Icons.bug_report,
              ),
              makeCaveatTile(
                head: 'eagerVictoryOnDrag implications',
                body:
                    'The default of true is right for most leaf '
                    'recognizers, but it eagerly REJECTS sibling '
                    'recognizers the moment slop is crossed — including '
                    'ancestor scrollables. If your text-selection drag '
                    'lives inside a vertically scrolling list, set '
                    'eagerVictoryOnDrag: false (or restructure the '
                    'layout) so the scrollable can still claim '
                    'cross-axis movement.',
                tint: kCoralDeep,
                icon: Icons.warning_amber,
              ),
            ],
          ),

          // ===========================================================
          // SECTION 11 — Footer / takeaways
          // ===========================================================
          const SizedBox(height: 18),
          makeWire(),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kCobaltDeeper, kCobaltDeep],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kCobalt, width: 2),
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
                Row(
                  children: [
                    Icon(Icons.bolt, color: kCoral, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'Takeaways',
                      style: TextStyle(
                        color: kCream,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '• Use TapAndDragGestureRecognizer instead of stacking '
                  'TapGestureRecognizer + PanGestureRecognizer when you '
                  'need both behaviours from the SAME pointer down.',
                  style: TextStyle(
                    color: kCobaltMist,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '• consecutiveTapCount is the single most important '
                  'field on the TapDrag*Details payloads — branch on it '
                  'to differentiate caret vs word vs paragraph drag.',
                  style: TextStyle(
                    color: kCobaltMist,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '• Pick the subclass that matches your axis: '
                  'TapAndHorizontalDragGestureRecognizer for swipe rows, '
                  'TapAndPanGestureRecognizer for canvas-style panning, '
                  'and TapAndDragGestureRecognizer for the general case.',
                  style: TextStyle(
                    color: kCobaltMist,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '• Tune eagerVictoryOnDrag with intent: leave it true '
                  'for leaf recognizers, set it false when an ancestor '
                  'recognizer must be allowed to win the arena first.',
                  style: TextStyle(
                    color: kCobaltMist,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '• Always pass a debugOwner — the cost is a single '
                  'argument, the payoff is a navigable gesture-arena '
                  'dump when something goes wrong in production.',
                  style: TextStyle(
                    color: kCobaltMist,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kSteel,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 4),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.touch_app, color: kCoral, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'TapAndDragGestureRecognizer — fused tap + drag, '
                    'with consecutiveTapCount, the recognizer behind '
                    'every selectable-text gesture in Flutter.',
                    style: TextStyle(
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
