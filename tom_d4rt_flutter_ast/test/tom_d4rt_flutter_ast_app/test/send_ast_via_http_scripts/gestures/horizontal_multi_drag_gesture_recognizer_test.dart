// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: HorizontalMultiDragGestureRecognizer.
//
// HorizontalMultiDragGestureRecognizer recognises horizontal drag gestures from
// multiple simultaneous pointers. Each accepted pointer produces its own Drag
// instance via the onStart callback, and each Drag receives independent
// update/end/cancel notifications. This file is a long-form, deeply visual
// reference: timelines, arena schematics, code cards, real-world mock UIs,
// comparison tables, velocity diagrams, and edge case galleries.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Palette: "lagoon at dusk" — teal seaglass on warm ink.
  // ============================================================
  const Color cInk = Color(0xFF12181F);
  const Color cInkSoft = Color(0xFF1B232C);
  const Color cInkLine = Color(0xFF2C3742);
  const Color cParchment = Color(0xFFEFE7D6);
  const Color cParchmentDim = Color(0xFFC9C0AE);
  const Color cTeal = Color(0xFF34B3A0);
  const Color cTealDeep = Color(0xFF1F7A6B);
  const Color cCoral = Color(0xFFE3735E);
  const Color cAmber = Color(0xFFE8B445);
  const Color cIris = Color(0xFF7C6FE0);
  const Color cMint = Color(0xFFB7E3CC);

  // ------------------------------------------------------------
  // Diagnostics: try to construct the recognizer. The bridged
  // Drag interface can be unstable depending on host runtime, so
  // we wrap construction in try/catch as instructed.
  // ------------------------------------------------------------
  String recognizerStatus = 'unknown';
  String recognizerType = 'HorizontalMultiDragGestureRecognizer';
  String recognizerOwner = '(none)';
  bool startCallbackAttached = false;
  try {
    final recognizer = HorizontalMultiDragGestureRecognizer(
      debugOwner: 'horizontal_multi_drag_demo',
    );
    recognizerType = recognizer.runtimeType.toString();
    recognizerOwner = recognizer.debugOwner.toString();
    try {
      recognizer.onStart = (Offset position) {
        print('onStart pointer at $position');
        return null;
      };
      startCallbackAttached = true;
    } catch (eCb) {
      print('onStart assignment failed: $eCb');
    }
    recognizer.dispose();
    recognizerStatus = 'ok';
  } catch (e) {
    recognizerStatus = 'construct-failed: $e';
    print('HorizontalMultiDragGestureRecognizer construction failed: $e');
  }

  print('=== HorizontalMultiDragGestureRecognizer demo ===');
  print('status: $recognizerStatus');
  print('type:   $recognizerType');
  print('owner:  $recognizerOwner');
  print('onStart attached: $startCallbackAttached');

  // ------------------------------------------------------------
  // Helpers (closures, no widget subclassing).
  // ------------------------------------------------------------
  TextStyle ts({
    double size = 12,
    FontWeight weight = FontWeight.w400,
    Color color = cParchment,
    double height = 1.32,
    double letterSpacing = 0.0,
    String? family,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: family,
    );
  }

  Widget chipTag(String label, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.18),
        border: Border.all(color: tone.withValues(alpha: 0.55), width: 1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        label,
        style: ts(
          size: 10,
          weight: FontWeight.w700,
          color: tone,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget sectionTitle(String index, String title, String subtitle, Color tone) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 22, 2, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.18),
              border: Border.all(color: tone, width: 1.4),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              index,
              style: ts(
                size: 12,
                weight: FontWeight.w800,
                color: tone,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ts(
                    size: 16,
                    weight: FontWeight.w800,
                    color: cParchment,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: ts(
                    size: 11,
                    color: cParchmentDim,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget panel({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(14),
    Color border = cInkLine,
    Color fill = cInkSoft,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(color: border, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget kvRow(String key, String value, Color valueTone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 152,
            child: Text(
              key,
              style: ts(size: 11, color: cParchmentDim),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: ts(
                size: 11,
                weight: FontWeight.w600,
                color: valueTone,
                family: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 1. HERO HEADER
  // ============================================================
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cTealDeep.withValues(alpha: 0.55),
          cInk,
          cIris.withValues(alpha: 0.35),
        ],
      ),
      border: Border.all(color: cTeal.withValues(alpha: 0.5), width: 1.3),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            chipTag('GESTURE', cTeal),
            const SizedBox(width: 6),
            chipTag('MULTI-POINTER', cAmber),
            const SizedBox(width: 6),
            chipTag('HORIZONTAL', cCoral),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'HorizontalMultiDragGestureRecognizer',
          style: ts(
            size: 22,
            weight: FontWeight.w800,
            color: cParchment,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A horizontal drag recognizer that accepts every pointer that '
          'starts moving sideways. Each pointer becomes an independent Drag, '
          'with its own update/end/cancel lifecycle. Vertical motion makes '
          'a pointer lose the arena; horizontal motion in any direction is '
          'fair game.',
          style: ts(size: 12, color: cParchmentDim, height: 1.45),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: panel(
                fill: cInk.withValues(alpha: 0.55),
                border: cInkLine.withValues(alpha: 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'recognizer',
                      style: ts(
                        size: 9,
                        color: cParchmentDim,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      recognizerStatus,
                      style: ts(
                        size: 13,
                        weight: FontWeight.w700,
                        color: recognizerStatus == 'ok' ? cMint : cCoral,
                        family: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: panel(
                fill: cInk.withValues(alpha: 0.55),
                border: cInkLine.withValues(alpha: 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drag per pointer',
                      style: ts(
                        size: 9,
                        color: cParchmentDim,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'onStart: (Offset) => Drag?',
                      style: ts(
                        size: 11,
                        weight: FontWeight.w700,
                        color: cTeal,
                        family: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: panel(
                fill: cInk.withValues(alpha: 0.55),
                border: cInkLine.withValues(alpha: 0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'parent',
                      style: ts(
                        size: 9,
                        color: cParchmentDim,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'MultiDragGestureRecognizer<_HorizontalPointerState>',
                      style: ts(
                        size: 10,
                        weight: FontWeight.w700,
                        color: cIris,
                        family: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // 2. POINTER TIMELINE — three pointers dragging horizontally
  // ============================================================
  // Each pointer has a starting x, a colored trail, and a moving "head".
  // We render the trail as crosshair markers along the row.
  Widget pointerRow({
    required String label,
    required double startFrac,
    required double endFrac,
    required double yLabel,
    required Color tone,
    required double width,
  }) {
    final double x0 = startFrac * width;
    final double x1 = endFrac * width;
    final double dx = x1 - x0;
    final int markers = 9;
    final List<Widget> trail = <Widget>[];
    for (int i = 0; i < markers; i++) {
      final double t = markers <= 1 ? 0.0 : i / (markers - 1);
      final double x = x0 + dx * t;
      final double a = 0.25 + 0.65 * t;
      trail.add(Positioned(
        left: x - 5,
        top: 22,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: tone.withValues(alpha: a),
            border: Border.all(color: tone, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ));
    }
    // Head (current finger).
    trail.add(Positioned(
      left: x1 - 9,
      top: 18,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: tone,
          border: Border.all(color: cParchment, width: 1.5),
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: tone.withValues(alpha: 0.6),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    ));
    // Track line.
    trail.add(Positioned(
      left: 0,
      right: 0,
      top: 26,
      child: Container(
        height: 1,
        color: cInkLine.withValues(alpha: 0.7),
      ),
    ));
    // Direction arrow text.
    trail.add(Positioned(
      left: x1 + 14,
      top: yLabel,
      child: Text(
        dx >= 0 ? '→' : '←',
        style: ts(
          size: 18,
          weight: FontWeight.w800,
          color: tone,
        ),
      ),
    ));
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: cInk.withValues(alpha: 0.4),
              border: Border.all(
                color: tone.withValues(alpha: 0.4),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Positioned(
            left: 8,
            top: 4,
            child: Text(
              label,
              style: ts(
                size: 10,
                weight: FontWeight.w700,
                color: tone,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...trail,
        ],
      ),
    );
  }

  final Widget pointerTimeline = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Three pointers, three Drag instances, one recognizer',
          style: ts(size: 13, weight: FontWeight.w800, color: cTeal),
        ),
        const SizedBox(height: 4),
        Text(
          'A single HorizontalMultiDragGestureRecognizer accepts each new '
          'pointer that crosses the horizontal hit-slop. Vertical movement '
          'is rejected per-pointer; horizontal movement (left or right) is '
          'accepted independently.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (BuildContext c, BoxConstraints cs) {
            final double w = cs.maxWidth - 24;
            return Column(
              children: [
                pointerRow(
                  label: 'P1',
                  startFrac: 0.05,
                  endFrac: 0.55,
                  yLabel: 18,
                  tone: cTeal,
                  width: w,
                ),
                pointerRow(
                  label: 'P2',
                  startFrac: 0.70,
                  endFrac: 0.18,
                  yLabel: 18,
                  tone: cAmber,
                  width: w,
                ),
                pointerRow(
                  label: 'P3',
                  startFrac: 0.30,
                  endFrac: 0.90,
                  yLabel: 18,
                  tone: cCoral,
                  width: w,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            chipTag('P1 → right', cTeal),
            chipTag('P2 ← left', cAmber),
            chipTag('P3 → right', cCoral),
            chipTag('all simultaneous', cParchmentDim),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // 3. ARENA SCHEMATIC
  // ============================================================
  Widget arenaCell(String name, Color tone, {bool wins = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: wins ? 0.32 : 0.12),
        border: Border.all(
          color: tone.withValues(alpha: wins ? 1.0 : 0.4),
          width: wins ? 1.6 : 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        name,
        style: ts(
          size: 10,
          weight: wins ? FontWeight.w800 : FontWeight.w600,
          color: tone,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget arenaPointerLane(String pointerLabel, Color tone, String winner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 38,
            child: Text(
              pointerLabel,
              style: ts(
                size: 11,
                weight: FontWeight.w800,
                color: tone,
                family: 'monospace',
              ),
            ),
          ),
          arenaCell('HorizMulti', cTeal, wins: winner == 'HorizMulti'),
          const SizedBox(width: 6),
          Text('vs', style: ts(size: 9, color: cParchmentDim)),
          const SizedBox(width: 6),
          arenaCell('VerticalDrag', cIris, wins: winner == 'Vertical'),
          const SizedBox(width: 6),
          Text('vs', style: ts(size: 9, color: cParchmentDim)),
          const SizedBox(width: 6),
          arenaCell('Tap', cAmber, wins: winner == 'Tap'),
          const SizedBox(width: 10),
          Text('→ winner: $winner',
              style: ts(
                size: 10,
                weight: FontWeight.w700,
                color: cParchment,
              )),
        ],
      ),
    );
  }

  final Widget arenaSchematic = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gesture arena — per pointer, not per recognizer',
          style: ts(size: 13, weight: FontWeight.w800, color: cIris),
        ),
        const SizedBox(height: 4),
        Text(
          'Each pointer has its own arena. HorizontalMultiDrag never competes '
          'against itself across pointers — only against vertical and tap '
          'recognizers within the same pointer\'s arena.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 10),
        arenaPointerLane('P1', cTeal, 'HorizMulti'),
        arenaPointerLane('P2', cAmber, 'HorizMulti'),
        arenaPointerLane('P3', cCoral, 'Vertical'),
        arenaPointerLane('P4', cMint, 'Tap'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cInk.withValues(alpha: 0.6),
            border: Border.all(color: cInkLine),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Note: P3 moved more vertically than horizontally — '
            'HorizontalMultiDrag rejected that pointer; the VerticalDrag '
            'recognizer in the arena claimed it. P4 never moved enough — '
            'Tap claimed it.',
            style: ts(size: 10, color: cParchmentDim, height: 1.45),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // 4. CODE CARD: registering the recognizer
  // ============================================================
  Widget codeLine(String text, {Color tone = cParchment}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: ts(
          size: 11,
          weight: FontWeight.w500,
          color: tone,
          family: 'monospace',
          height: 1.45,
        ),
      ),
    );
  }

  final Widget codeCard = panel(
    fill: const Color(0xFF0B0F14),
    border: cTealDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            chipTag('SNIPPET', cTeal),
            const SizedBox(width: 8),
            Text(
              'RawGestureDetector registration',
              style: ts(
                size: 12,
                weight: FontWeight.w800,
                color: cParchment,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        codeLine('RawGestureDetector(', tone: cParchmentDim),
        codeLine('  gestures: <Type, GestureRecognizerFactory>{',
            tone: cParchmentDim),
        codeLine(
            '    HorizontalMultiDragGestureRecognizer:',
            tone: cTeal),
        codeLine(
            '      GestureRecognizerFactoryWithHandlers<',
            tone: cTeal),
        codeLine(
            '        HorizontalMultiDragGestureRecognizer>(',
            tone: cTeal),
        codeLine('        () => HorizontalMultiDragGestureRecognizer(),',
            tone: cAmber),
        codeLine('        (HorizontalMultiDragGestureRecognizer r) {',
            tone: cAmber),
        codeLine('          r.onStart = (Offset p) => MyDrag(p);',
            tone: cMint),
        codeLine('        },', tone: cAmber),
        codeLine('      ),', tone: cTeal),
        codeLine('  },', tone: cParchmentDim),
        codeLine('  child: child,', tone: cParchmentDim),
        codeLine(')', tone: cParchmentDim),
        const SizedBox(height: 10),
        Text(
          'onStart returns a Drag (or null to refuse). Returning null lets '
          'another recognizer in the arena win this pointer.',
          style: ts(size: 10, color: cParchmentDim, height: 1.45),
        ),
      ],
    ),
  );

  // ============================================================
  // 5. DRAG INTERFACE CARD
  // ============================================================
  Widget dragMethodRow(
      String name, String signature, String description, Color tone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 78,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              border: Border.all(color: tone, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: ts(
                size: 11,
                weight: FontWeight.w800,
                color: tone,
                family: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signature,
                  style: ts(
                    size: 10,
                    color: cAmber,
                    family: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: ts(size: 11, color: cParchmentDim, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget dragInterface = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Drag interface — what onStart must return',
          style: ts(size: 13, weight: FontWeight.w800, color: cAmber),
        ),
        const SizedBox(height: 4),
        Text(
          'Implement these three methods. The recognizer routes pointer '
          'updates to the matching Drag instance.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 10),
        dragMethodRow(
          'update',
          'void update(DragUpdateDetails details)',
          'Pointer moved. Use details.delta and details.primaryDelta '
              '(horizontal axis) to translate UI; details.globalPosition for '
              'absolute placement.',
          cTeal,
        ),
        dragMethodRow(
          'end',
          'void end(DragEndDetails details)',
          'Pointer was lifted. details.velocity carries the per-pointer '
              'fling vector; details.primaryVelocity is the horizontal '
              'component used for momentum.',
          cMint,
        ),
        dragMethodRow(
          'cancel',
          'void cancel()',
          'Pointer was lost (system interruption, recognizer rejected mid '
              'gesture, framework unmount). Restore state — there will be '
              'no end.',
          cCoral,
        ),
      ],
    ),
  );

  // ============================================================
  // 6. REAL-WORLD MOCK GALLERY
  // ============================================================
  Widget mockMultiPan() {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: cInk,
        border: Border.all(color: cTeal),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            top: 18,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: cTeal,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 50,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: cAmber,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 36,
            top: 36,
            child: Text(
              '→  →',
              style: ts(
                size: 14,
                color: cParchment,
                weight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 6,
            child: Text(
              'two-finger pan',
              style: ts(size: 9, color: cParchmentDim, letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget mockPip() {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: cInk,
        border: Border.all(color: cIris),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: cIris.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 40,
              height: 24,
              decoration: BoxDecoration(
                color: cIris,
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text(
                'PiP',
                style: ts(size: 10, weight: FontWeight.w800, color: cInk),
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 24,
            child: Text('finger A drags PiP →',
                style: ts(size: 9, color: cParchment)),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Text('finger B scrolls feed →',
                style: ts(size: 9, color: cMint)),
          ),
        ],
      ),
    );
  }

  Widget mockMultiReorder() {
    final List<Color> rows = <Color>[cTeal, cAmber, cCoral, cMint];
    final List<Widget> rowWidgets = <Widget>[];
    for (int i = 0; i < rows.length; i++) {
      rowWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: Container(
          height: 12,
          decoration: BoxDecoration(
            color: rows[i].withValues(alpha: 0.3),
            border: Border.all(color: rows[i], width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            i.isEven ? '→' : '←',
            style: ts(
              size: 10,
              weight: FontWeight.w800,
              color: rows[i],
              height: 1.0,
            ),
          ),
        ),
      ));
    }
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: cInk,
        border: Border.all(color: cCoral),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('multi-row reorder',
              style: ts(
                size: 9,
                weight: FontWeight.w700,
                color: cCoral,
                letterSpacing: 0.5,
              )),
          const SizedBox(height: 4),
          ...rowWidgets,
        ],
      ),
    );
  }

  final Widget gallery = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-world use cases',
          style: ts(size: 13, weight: FontWeight.w800, color: cMint),
        ),
        const SizedBox(height: 4),
        Text(
          'Anywhere multiple horizontal drags need to coexist on the same '
          'screen at the same time.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (BuildContext c, BoxConstraints cs) {
            final double colW = (cs.maxWidth - 24) / 3;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(width: colW, child: mockMultiPan()),
                SizedBox(width: colW, child: mockPip()),
                SizedBox(width: colW, child: mockMultiReorder()),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: [
            Text('• two-finger horizontal pan map',
                style: ts(size: 10, color: cParchmentDim)),
            Text('• picture-in-picture w/ scrolling content',
                style: ts(size: 10, color: cParchmentDim)),
            Text('• per-row swipe-to-action lists',
                style: ts(size: 10, color: cParchmentDim)),
            Text('• sortable chip cloud',
                style: ts(size: 10, color: cParchmentDim)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // 7. COMPARISON TABLE
  // ============================================================
  Widget cmpHeader(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: cTealDeep.withValues(alpha: 0.45),
        border: Border(
          bottom: BorderSide(color: cTeal, width: 1.5),
        ),
      ),
      child: Text(
        text,
        style: ts(
          size: 10,
          weight: FontWeight.w800,
          color: cParchment,
          letterSpacing: 0.7,
        ),
      ),
    );
  }

  Widget cmpCell(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: cInkLine.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Text(
        text,
        style: ts(size: 10, color: tone, family: 'monospace', height: 1.35),
      ),
    );
  }

  Widget cmpRow(List<String> cells, List<Color> tones) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < cells.length; i++) {
      kids.add(Expanded(
        flex: i == 0 ? 3 : 2,
        child: cmpCell(cells[i], tones[i]),
      ));
    }
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #22, P1):
    // stretch-Row inside the unbounded SingleChildScrollView propagated
    // infinite height to its Expanded children. Bound via IntrinsicHeight.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: kids,
      ),
    );
  }

  final Widget comparison = panel(
    padding: const EdgeInsets.all(0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          decoration: BoxDecoration(
            color: cInk.withValues(alpha: 0.5),
            border: Border(
              bottom: BorderSide(color: cInkLine, width: 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recognizer comparison',
                style:
                    ts(size: 13, weight: FontWeight.w800, color: cParchment),
              ),
              const SizedBox(height: 2),
              Text(
                'Where HorizontalMultiDrag fits among the drag/pan family.',
                style: ts(size: 11, color: cParchmentDim),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(flex: 3, child: cmpHeader('Recognizer')),
            Expanded(flex: 2, child: cmpHeader('Axis')),
            Expanded(flex: 2, child: cmpHeader('Pointers')),
            Expanded(flex: 2, child: cmpHeader('Per-pointer state')),
          ],
        ),
        cmpRow(
          [
            'HorizontalDragGestureRecognizer',
            'horizontal',
            '1 (single)',
            'no — single Drag',
          ],
          [cParchment, cTeal, cAmber, cParchmentDim],
        ),
        cmpRow(
          [
            'HorizontalMultiDragGestureRecognizer',
            'horizontal',
            'N (multi)',
            'yes — Drag per pointer',
          ],
          [cTeal, cTeal, cMint, cMint],
        ),
        cmpRow(
          [
            'VerticalDragGestureRecognizer',
            'vertical',
            '1 (single)',
            'no — single Drag',
          ],
          [cParchment, cIris, cAmber, cParchmentDim],
        ),
        cmpRow(
          [
            'VerticalMultiDragGestureRecognizer',
            'vertical',
            'N (multi)',
            'yes — Drag per pointer',
          ],
          [cParchment, cIris, cMint, cMint],
        ),
        cmpRow(
          [
            'PanGestureRecognizer',
            'free (h+v)',
            '1 (single)',
            'no — single Drag',
          ],
          [cParchment, cAmber, cAmber, cParchmentDim],
        ),
        cmpRow(
          [
            'ImmediateMultiDragGestureRecognizer',
            'free',
            'N (multi)',
            'yes — accepts immediately',
          ],
          [cParchment, cAmber, cMint, cMint],
        ),
        cmpRow(
          [
            'DelayedMultiDragGestureRecognizer',
            'free',
            'N (multi)',
            'yes — after long-press delay',
          ],
          [cParchment, cAmber, cMint, cMint],
        ),
        cmpRow(
          [
            'ScaleGestureRecognizer',
            'free',
            '2+ (pinch)',
            'aggregated, not per-pointer',
          ],
          [cParchment, cCoral, cCoral, cParchmentDim],
        ),
      ],
    ),
  );

  // ============================================================
  // 8. VELOCITY DIAGRAM
  // ============================================================
  Widget velocityArrow({
    required String label,
    required double magnitude,
    required Color tone,
    required bool toRight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              label,
              style: ts(
                size: 11,
                weight: FontWeight.w800,
                color: tone,
                family: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext c, BoxConstraints cs) {
                final double w =
                    cs.maxWidth.clamp(0.0, double.infinity).toDouble();
                final double bar = w * magnitude.clamp(0.0, 1.0);
                final List<Widget> arrow = <Widget>[];
                final int notches = math.max(3, (bar / 18).round());
                for (int i = 0; i < notches; i++) {
                  arrow.add(Container(
                    width: 14,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: tone.withValues(alpha: 0.3 + 0.6 * (i / notches)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ));
                }
                return Row(
                  mainAxisAlignment: toRight
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    if (!toRight)
                      Text('◀',
                          style: ts(size: 14, weight: FontWeight.w800,
                              color: tone)),
                    if (!toRight) const SizedBox(width: 4),
                    ...arrow,
                    if (toRight) const SizedBox(width: 4),
                    if (toRight)
                      Text('▶',
                          style: ts(size: 14, weight: FontWeight.w800,
                              color: tone)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 96,
            child: Text(
              '${(magnitude * 1800).round()} px/s',
              style: ts(
                size: 10,
                color: cParchmentDim,
                family: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget velocityCard = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Per-pointer velocity at end()',
          style: ts(size: 13, weight: FontWeight.w800, color: cAmber),
        ),
        const SizedBox(height: 4),
        Text(
          'DragEndDetails.velocity is reported separately to each Drag '
          'instance. Use details.primaryVelocity for momentum.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 10),
        velocityArrow(
            label: 'P1',
            magnitude: 0.45,
            tone: cTeal,
            toRight: true),
        velocityArrow(
            label: 'P2',
            magnitude: 0.78,
            tone: cAmber,
            toRight: false),
        velocityArrow(
            label: 'P3',
            magnitude: 0.22,
            tone: cCoral,
            toRight: true),
        velocityArrow(
            label: 'P4',
            magnitude: 0.95,
            tone: cIris,
            toRight: true),
      ],
    ),
  );

  // ============================================================
  // 9. EDGE CASES
  // ============================================================
  Widget edgeCard(String title, String body, Color tone, String tag) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.07),
        border: Border.all(color: tone.withValues(alpha: 0.6), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              chipTag(tag, tone),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: ts(
                    size: 12,
                    weight: FontWeight.w800,
                    color: cParchment,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: ts(size: 11, color: cParchmentDim, height: 1.45),
          ),
        ],
      ),
    );
  }

  final Widget edgeCases = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edge cases',
          style: ts(size: 13, weight: FontWeight.w800, color: cCoral),
        ),
        const SizedBox(height: 4),
        Text(
          'Quirks that surprise people the first time they wire this up.',
          style: ts(size: 11, color: cParchmentDim),
        ),
        const SizedBox(height: 10),
        edgeCard(
          'Pointer drifts vertical mid-gesture',
          'Once HorizontalMultiDrag has accepted the pointer, vertical drift '
              'does NOT cancel the drag — the pointer stays bound to its '
              'Drag. Rejection only happens before acceptance.',
          cAmber,
          'A',
        ),
        const SizedBox(height: 8),
        edgeCard(
          'Two pointers go in opposite directions',
          'Both pointers are accepted independently. Each Drag gets its own '
              'positive or negative primaryDelta. Build the UI so left+right '
              'simultaneously is meaningful.',
          cTeal,
          'B',
        ),
        const SizedBox(height: 8),
        edgeCard(
          'Pointer down with zero motion',
          'A pointer that never moves enough horizontally never triggers '
              'onStart. The pointer simply ages out into the arena and is '
              'claimed by Tap, LongPress, or another recognizer.',
          cIris,
          'C',
        ),
        const SizedBox(height: 8),
        edgeCard(
          'onStart returns null',
          'Returning null tells the recognizer to refuse this pointer in '
              'this arena. Useful for conditional acceptance based on hit '
              'position (e.g., only accept drags inside a child rect).',
          cMint,
          'D',
        ),
      ],
    ),
  );

  // ============================================================
  // 10. DIAGNOSTIC PANEL — runtime info from try/catch above
  // ============================================================
  final Widget diagnostics = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Runtime diagnostics',
          style: ts(size: 13, weight: FontWeight.w800, color: cTeal),
        ),
        const SizedBox(height: 8),
        kvRow('construction', recognizerStatus,
            recognizerStatus == 'ok' ? cMint : cCoral),
        kvRow('runtime type', recognizerType, cParchment),
        kvRow('debug owner', recognizerOwner, cAmber),
        kvRow('onStart attached',
            startCallbackAttached.toString(),
            startCallbackAttached ? cMint : cCoral),
        kvRow('parent abstract',
            'MultiDragGestureRecognizer<MultiDragPointerState>', cIris),
        kvRow('axis lock', 'horizontal (left or right)', cTeal),
        kvRow('max simultaneous', 'unbounded', cParchment),
        kvRow('returns', 'Drag? per pointer (null = refuse)', cAmber),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cInk.withValues(alpha: 0.6),
            border: Border.all(color: cInkLine),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'ui.PointerDeviceKind values that this recognizer participates '
            'in: ${ui.PointerDeviceKind.values.length} total — touch, mouse, '
            'stylus, invertedStylus, trackpad, unknown.',
            style: ts(size: 10, color: cParchmentDim, height: 1.45),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // 11. FOOTER
  // ============================================================
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
    decoration: BoxDecoration(
      color: cInkSoft,
      border: Border.all(color: cInkLine),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            chipTag('REFERENCE', cTealDeep),
            const SizedBox(width: 6),
            chipTag('FLUTTER GESTURES', cIris),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'HorizontalMultiDragGestureRecognizer is the right tool when each '
          'finger should drive its own UI element horizontally. For a single '
          'global drag, use HorizontalDragGestureRecognizer; for free-axis '
          'multi-drag, use ImmediateMultiDragGestureRecognizer; for vertical '
          'analog, use VerticalMultiDragGestureRecognizer.',
          style: ts(size: 11, color: cParchmentDim, height: 1.5),
        ),
        const SizedBox(height: 6),
        Text(
          'Construction is cheap; the cost is in the per-pointer Drag '
          'objects you allocate. Keep them light, idempotent on cancel, and '
          'clean up any RAF/timer-style helpers in cancel as well as end.',
          style: ts(size: 11, color: cParchmentDim, height: 1.5),
        ),
        const SizedBox(height: 10),
        Text(
          'demo • horizontal_multi_drag_gesture_recognizer_test.dart',
          style: ts(
            size: 10,
            color: cTeal,
            letterSpacing: 1.2,
            family: 'monospace',
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // BUILD
  // ============================================================
  return Scaffold(
    backgroundColor: cInk,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            sectionTitle('1', 'Pointer timeline',
                'Three pointers, three Drag instances.', cTeal),
            pointerTimeline,
            sectionTitle('2', 'Gesture arena',
                'Per-pointer competition with vertical & tap.', cIris),
            arenaSchematic,
            sectionTitle('3', 'Registration code',
                'Wiring the recognizer in RawGestureDetector.', cTeal),
            codeCard,
            sectionTitle('4', 'The Drag interface',
                'update / end / cancel — the three callbacks.', cAmber),
            dragInterface,
            sectionTitle('5', 'Real-world examples',
                'Where multi-pointer horizontal dragging lives.', cMint),
            gallery,
            sectionTitle('6', 'Recognizer comparison',
                'Single vs multi, horizontal vs vertical vs pan.', cParchment),
            comparison,
            sectionTitle('7', 'Velocity at end',
                'Per-pointer fling vectors.', cAmber),
            velocityCard,
            sectionTitle('8', 'Edge cases',
                'Behaviors that surprise newcomers.', cCoral),
            edgeCases,
            sectionTitle('9', 'Diagnostics',
                'Runtime values harvested from a real instance.', cTeal),
            diagnostics,
            const SizedBox(height: 20),
            footer,
          ],
        ),
      ),
    ),
  );
}
