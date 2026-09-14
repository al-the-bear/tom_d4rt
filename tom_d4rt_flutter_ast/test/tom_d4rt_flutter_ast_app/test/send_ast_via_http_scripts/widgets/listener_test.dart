// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
//
// ============================================================================
// LISTENER  —  Hand-authored Visual Deep Demo
// ============================================================================
//
// This single-file demo is a complete dossier on the `Listener` widget — the
// low-level widget that surfaces RAW pointer events directly from the engine
// before any gesture arena disambiguation has occurred.
//
// `Listener` lets you tap into the pointer stream as it flows from the platform
// (touch screen, mouse, trackpad, stylus, pan-zoom gestures from a trackpad)
// through Flutter's hit-testing pipeline.  Where `GestureDetector` synthesizes
// *semantic* gestures (tap, double-tap, long-press, drag, scale), `Listener`
// gives you the raw `PointerEvent` series — every nudge, every micro-move,
// every flicker of the scroll wheel.
//
// The build() function below stitches together SEVEN didactic sections, each
// rendered as colored, labeled cards that paint static "mock event traces"
// onto Flutter canvases so you can read the geometry of a typical pointer
// interaction *visually* without having to run the app.
//
//   1. DOSSIER          — purpose, position in the input pipeline, contrast vs.
//                         GestureDetector.
//   2. ANATOMY          — each Listener callback explained, with the fields of
//                         the PointerEvent subclass it receives.
//   3. RECIPES          — five worked examples drawn from mocked event traces:
//                         drag tracker, hover heatmap, scroll wheel meter,
//                         signal log, multi-touch gallery.
//   4. HIT-TEST BEHAVIOR — opaque / translucent / deferToChild visualized.
//   5. POINTER DEVICE   — matrix of PointerDeviceKind values and which
//                         callbacks they fire.
//   6. COMPARISON       — side-by-side cheatsheet: Listener vs. GestureDetector
//                         vs. MouseRegion.
//   7. GLOSSARY + RECAP — concise key takeaways and a vocabulary cheat sheet.
//
// All event data shown in this file is STATIC and PRE-COMPUTED — these are
// "mock event traces" recorded from imaginary interactions so the reader can
// see the structure of the data Listener delivers without needing a live
// pointer source.
//
// ============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level build() — composes all sections into a single scrollable Column.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Reference symbols from package:flutter/foundation.dart and
  // package:flutter/gestures.dart so those imports are not flagged as
  // unused. These are also genuinely useful at runtime:
  //   • kIsWeb            — Listener semantics differ between web and native
  //                         (mouse-wheel signals come through differently).
  //   • PointerDeviceKind — referenced throughout the device-kind matrix.
  final bool runningOnWeb = kIsWeb;
  final List<PointerDeviceKind> documentedKinds = const <PointerDeviceKind>[
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
  ];

  // ===========================================================
  // ====================  COLOR PALETTE  ======================
  // ===========================================================
  //
  // We use a small consistent palette across the dossier so the
  // reader can visually associate concepts:
  //   indigo  -> Listener primary
  //   teal    -> hit-test behavior
  //   amber   -> event data tables
  //   crimson -> warnings / common mistakes
  //   olive   -> mock event traces
  //   slate   -> comparison panels
  //
  const Color indigo = Color(0xFF3F51B5);
  const Color teal = Color(0xFF00838F);
  const Color amber = Color(0xFFB28704);
  const Color crimson = Color(0xFFB7263A);
  const Color olive = Color(0xFF6B8E23);
  const Color slate = Color(0xFF455A64);
  const Color paperBg = Color(0xFFFAF8F2);
  const Color rule = Color(0xFFDDD6C7);

  // -------------------- helper builders (closures) -----------

  Widget sectionTitle(String number, String title, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      margin: const EdgeInsets.only(top: 28.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.10),
        border: Border(left: BorderSide(color: accent, width: 6.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subTitle(String text, Color accent) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 14.0, 4.0, 6.0),
      child: Row(
        children: [
          Container(width: 8.0, height: 8.0, color: accent),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: accent,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget body(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.45,
          color: Color(0xFF212121),
        ),
      ),
    );
  }

  Widget mono(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: Color(0xFFE0E0E0),
          height: 1.4,
        ),
      ),
    );
  }

  Widget pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget calloutBox(String title, String body, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: const TextStyle(fontSize: 12.5, height: 1.4),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // ==================== SECTION 1: DOSSIER ===================
  // ===========================================================

  final Widget dossier = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widget Dossier: Listener',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigo,
          ),
        ),
        const SizedBox(height: 6.0),
        body(
          'Listener is the LOW-LEVEL pointer-event widget in Flutter. It sits '
          'directly on the hit-testing pipeline and reports every raw '
          'PointerEvent that the engine dispatches to a region of the screen. '
          'It is the building block on top of which higher-level abstractions '
          'such as GestureDetector are built. Use Listener when you need '
          'unfiltered access to the pointer stream — for example, when '
          'implementing your own gesture recognizer, when integrating with '
          'a physics engine, when drawing live path traces, or when reacting '
          'to events that GestureDetector does not expose (scroll-wheel '
          'signals, stylus pressure curves, pan-zoom gestures from a touchpad).',
        ),
        const SizedBox(height: 10.0),
        subTitle('Position in the input pipeline', indigo),
        mono(
          '  platform raw input\n'
          '         |\n'
          '         v\n'
          '  [ FlutterEngine ] -- PointerDataPacket\n'
          '         |\n'
          '         v\n'
          '  GestureBinding._handlePointerEvent\n'
          '         |\n'
          '         v\n'
          '  HitTest (root -> leaf) ----->  RenderPointerListener  <-- Listener widget hooks in here\n'
          '         |\n'
          '         v\n'
          '  PointerRouter / GestureArena <-- GestureDetector hooks in here\n'
          '         |\n'
          '         v\n'
          '  recognized semantic gestures (tap, drag, scale, ...)',
        ),
        body(
          'Listener fires BEFORE the gesture arena resolves which recognizer '
          'wins, so every Listener in the hit-test path will always receive '
          'the event regardless of any competing gesture.  This is in stark '
          'contrast to GestureDetector, where the arena may "reject" one '
          'recognizer in favor of another, and the loser will silently not '
          'fire its callback.',
        ),
        const SizedBox(height: 10.0),
        subTitle('Listener vs. GestureDetector — a one-line summary', indigo),
        calloutBox(
          'Listener = "what the pointer DID"  /  GestureDetector = "what the user MEANT"',
          'Listener tells you "the finger went down at (210, 87), it moved '
          '3px right then 1px up, then it came back up". GestureDetector '
          'tells you "the user TAPPED" or "the user DRAGGED to (213, 88)". '
          'You almost always want the latter for UI work — reach for '
          'Listener only when GestureDetector cannot express your need.',
          crimson,
        ),
        const SizedBox(height: 6.0),
        subTitle('Constructor signature (paraphrased)', indigo),
        mono(
          'const Listener({\n'
          '  Key? key,\n'
          '  PointerDownEventListener?           onPointerDown,\n'
          '  PointerMoveEventListener?           onPointerMove,\n'
          '  PointerUpEventListener?             onPointerUp,\n'
          '  PointerHoverEventListener?          onPointerHover,\n'
          '  PointerCancelEventListener?         onPointerCancel,\n'
          '  PointerPanZoomStartEventListener?   onPointerPanZoomStart,\n'
          '  PointerPanZoomUpdateEventListener?  onPointerPanZoomUpdate,\n'
          '  PointerPanZoomEndEventListener?     onPointerPanZoomEnd,\n'
          '  PointerSignalEventListener?         onPointerSignal,\n'
          '  HitTestBehavior behavior = HitTestBehavior.deferToChild,\n'
          '  Widget? child,\n'
          '});',
        ),
        body(
          'Notes: every callback is nullable; if you pass null Listener does '
          'not hit-test for that event kind.  `behavior` controls how the '
          'underlying RenderPointerListener participates in hit testing — '
          'see Section 4. `child` may be null; in that case Listener still '
          'occupies the layout slot of its parent.',
        ),
      ],
    ),
  );

  // ===========================================================
  // ==================== SECTION 2: ANATOMY ===================
  // ===========================================================

  Widget anatomyRow(
    String callback,
    String eventType,
    String fires,
    String fields,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: rule),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: amber.withOpacity(0.12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: amber,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    callback,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  '→ ',
                  style: TextStyle(color: amber.withOpacity(0.8)),
                ),
                Text(
                  eventType,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 4.0),
            child: Text(
              'Fires when: $fires',
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Text(
              'Key fields: $fields',
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                height: 1.5,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget anatomy = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Callback Anatomy — each Listener event explained',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: amber,
          ),
        ),
        const SizedBox(height: 6.0),
        body(
          'Every Listener callback receives a subclass of PointerEvent.  All '
          'PointerEvent subclasses share a common base of fields (timestamp, '
          'position, delta, pressure, kind, buttons, device id, embedderId, '
          'pointer id) and then add a few specific to their phase.  The table '
          'below describes the conditions under which each callback fires and '
          'which fields are most useful.',
        ),
        const SizedBox(height: 6.0),
        anatomyRow(
          'onPointerDown',
          'PointerDownEvent',
          'a NEW pointer makes contact (finger touches, mouse-button is pressed, '
              'stylus tip touches). One event per (pointer, device) pair.',
          'position, localPosition, pressure, buttons, kind, pointer, device, '
              'timeStamp, embedderId, obscured, orientation, tilt',
        ),
        anatomyRow(
          'onPointerMove',
          'PointerMoveEvent',
          'an ALREADY-DOWN pointer changes position. Delivered as a continuous '
              'stream while the pointer is moving while in contact.',
          'position, localPosition, delta, localDelta, pressure, pressureMin, '
              'pressureMax, buttons, kind, pointer, distance, timeStamp',
        ),
        anatomyRow(
          'onPointerUp',
          'PointerUpEvent',
          'a pointer LEAVES contact gracefully (finger lifts, mouse-button is '
              'released, stylus lifts). One per matching down.',
          'position, localPosition, pressure (often 0.0), buttons (often 0), '
              'kind, pointer, timeStamp',
        ),
        anatomyRow(
          'onPointerCancel',
          'PointerCancelEvent',
          'a pointer is INTERRUPTED — the OS withdraws it (notification '
              'shade pulled down, app loses focus, gesture is cancelled by '
              'the platform). NEVER followed by an up — treat as abort.',
          'position, kind, pointer, timeStamp',
        ),
        anatomyRow(
          'onPointerHover',
          'PointerHoverEvent',
          'a pointer that supports hovering (mouse, certain stylus) moves '
              'WITHOUT contact.  Touch devices NEVER hover.',
          'position, localPosition, delta, localDelta, kind, pointer, '
              'timeStamp, distance, distanceMax',
        ),
        anatomyRow(
          'onPointerSignal',
          'PointerSignalEvent (PointerScrollEvent, PointerScrollInertiaCancelEvent, PointerStylusAuxiliaryButtonEvent...)',
          'a non-positional input arrives — most commonly the mouse-wheel '
              '(PointerScrollEvent.scrollDelta).',
          'kind, position, scrollDelta (PointerScrollEvent), pointer',
        ),
        anatomyRow(
          'onPointerPanZoomStart',
          'PointerPanZoomStartEvent',
          'a multi-finger trackpad gesture begins (macOS / Wayland / iPad '
              'pointer trackpads). Reported as a SYNTHETIC pointer rather than '
              'individual fingers.',
          'position, kind=trackpad, pointer, timeStamp',
        ),
        anatomyRow(
          'onPointerPanZoomUpdate',
          'PointerPanZoomUpdateEvent',
          'the in-progress trackpad gesture changes — receives pan offset, '
              'scale ratio, rotation in radians.',
          'pan, panDelta, scale, rotation, localPan, localPanDelta',
        ),
        anatomyRow(
          'onPointerPanZoomEnd',
          'PointerPanZoomEndEvent',
          'the trackpad gesture completes. One per matching start.',
          'position, kind=trackpad, pointer, timeStamp',
        ),
        const SizedBox(height: 8.0),
        subTitle('Shared PointerEvent fields — universal cheat-sheet', amber),
        mono(
          'position       Offset    -- global coordinate (screen)\n'
          'localPosition  Offset    -- local coordinate (within RenderPointerListener)\n'
          'delta          Offset    -- change since the previous event for this pointer\n'
          'localDelta     Offset    -- delta in local coordinates\n'
          'pressure       double    -- 0.0..1.0, 1.0 if device has no pressure\n'
          'buttons        int       -- bitmask: kPrimaryButton | kSecondaryButton | ...\n'
          'kind           PointerDeviceKind  (touch, mouse, stylus, invertedStylus, trackpad, unknown)\n'
          'pointer        int       -- unique pointer id assigned by the framework\n'
          'device         int       -- platform-given device id\n'
          'timeStamp      Duration  -- since engine start\n'
          'embedderId     int       -- raw embedder-assigned id\n'
          'obscured       bool      -- engine knows window was obscured at this event\n'
          'orientation    double    -- stylus tilt direction\n'
          'tilt           double    -- stylus tilt magnitude (radians)',
        ),
      ],
    ),
  );

  // ===========================================================
  // ============== Mock canvas painter helpers ================
  // ===========================================================
  //
  // To avoid the demo needing any real interaction we render
  // pre-computed "mock event traces" using CustomPaint with a
  // _PainterFn (defined at the bottom of the file). The traces
  // are encoded as plain lists of Offsets, with parallel lists
  // of pressure / kind / etc.

  // ===========================================================
  // ==================== SECTION 3: RECIPES ===================
  // ===========================================================

  // ---- Recipe 3.1 : drag tracker with a mock-recorded path ----

  final List<Offset> dragPath = const <Offset>[
    Offset(10, 90), Offset(18, 88), Offset(28, 85), Offset(40, 82),
    Offset(53, 80), Offset(68, 79), Offset(82, 80), Offset(94, 84),
    Offset(104, 89), Offset(112, 96), Offset(118, 105), Offset(123, 116),
    Offset(127, 128), Offset(131, 140), Offset(137, 151), Offset(146, 159),
    Offset(157, 164), Offset(170, 165), Offset(184, 162), Offset(196, 157),
    Offset(207, 150), Offset(216, 141), Offset(223, 130), Offset(228, 118),
    Offset(232, 105), Offset(235, 92), Offset(238, 80), Offset(243, 70),
    Offset(252, 64), Offset(263, 62), Offset(275, 64), Offset(287, 71),
    Offset(298, 81), Offset(308, 94), Offset(316, 109), Offset(322, 124),
    Offset(326, 138), Offset(330, 150), Offset(334, 159), Offset(340, 164),
  ];

  final List<double> dragPressure = const <double>[
    0.10, 0.20, 0.32, 0.42, 0.52, 0.60, 0.65, 0.68,
    0.70, 0.72, 0.74, 0.76, 0.78, 0.80, 0.82, 0.84,
    0.85, 0.85, 0.84, 0.83, 0.81, 0.78, 0.75, 0.71,
    0.68, 0.65, 0.62, 0.58, 0.54, 0.50, 0.46, 0.42,
    0.38, 0.34, 0.30, 0.26, 0.22, 0.18, 0.14, 0.10,
  ];

  final Widget recipeDrag = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe 3.1 — Drag Path Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: olive,
          ),
        ),
        const SizedBox(height: 4.0),
        body(
          'Hook into onPointerDown to start a new path, onPointerMove to '
          'append a point, and onPointerUp / onPointerCancel to close it.  '
          'The mock trace below is a 40-event stream recorded as a single '
          'finger drew a wavy "M" shape across a 360x220 region. Color is '
          'mapped to PRESSURE so you can see how a stylus would deliver '
          'tip-pressure data through every PointerMoveEvent.',
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4E8),
            border: Border.all(color: rule),
          ),
          child: CustomPaint(
            painter: _PainterFn((Canvas canvas, Size size) {
              // Grid background
              final Paint grid = Paint()
                ..color = const Color(0xFFE0DAC6)
                ..strokeWidth = 0.5;
              for (double x = 0; x < size.width; x += 20) {
                canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
              }
              for (double y = 0; y < size.height; y += 20) {
                canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
              }

              // Path segments tinted by pressure.
              for (int i = 1; i < dragPath.length; i++) {
                final double p = dragPressure[i];
                final Color tint = Color.lerp(
                  const Color(0xFF6B8E23),
                  const Color(0xFFB7263A),
                  p,
                )!;
                final Paint seg = Paint()
                  ..color = tint
                  ..strokeWidth = 2.0 + (p * 4.0)
                  ..strokeCap = StrokeCap.round;
                canvas.drawLine(dragPath[i - 1], dragPath[i], seg);
              }

              // Down marker (green)
              final Paint down = Paint()..color = const Color(0xFF2E7D32);
              canvas.drawCircle(dragPath.first, 6.0, down);
              // Up marker (blue)
              final Paint up = Paint()..color = const Color(0xFF1565C0);
              canvas.drawCircle(dragPath.last, 6.0, up);

              // Index labels every 10 events.
              final TextPainter tp = TextPainter(
                textDirection: TextDirection.ltr,
              );
              for (int i = 0; i < dragPath.length; i += 10) {
                tp.text = TextSpan(
                  text: '$i',
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
                tp.layout();
                tp.paint(canvas, dragPath[i] + const Offset(4, -10));
              }
            }),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            pill('PointerDownEvent  -- pos=(10,90)', olive),
            pill('PointerMoveEvent  x38', amber),
            pill('PointerUpEvent  -- pos=(340,164)', olive),
            pill('total Δt ≈ 720ms', slate),
          ],
        ),
        mono(
          'Listener(\n'
          '  onPointerDown: (e) => points = <Offset>[e.localPosition],\n'
          '  onPointerMove: (e) => points.add(e.localPosition),\n'
          '  onPointerUp:   (e) => persistTrace(points),\n'
          '  onPointerCancel:(e) => points.clear(),\n'
          '  child: CustomPaint(painter: _StrokePainter(points)),\n'
          ');',
        ),
      ],
    ),
  );

  // ---- Recipe 3.2 : hover heatmap ----

  final List<Offset> hoverPoints = const <Offset>[
    Offset(40, 30), Offset(58, 32), Offset(72, 36), Offset(80, 45),
    Offset(82, 60), Offset(85, 76), Offset(96, 89), Offset(118, 94),
    Offset(140, 92), Offset(158, 82), Offset(166, 65), Offset(165, 48),
    Offset(160, 32), Offset(170, 22), Offset(195, 20), Offset(220, 30),
    Offset(235, 50), Offset(240, 75), Offset(225, 95), Offset(204, 110),
    Offset(180, 118), Offset(155, 120), Offset(132, 116), Offset(110, 110),
    Offset(98, 104), Offset(92, 98), Offset(88, 90), Offset(86, 80),
    Offset(86, 70), Offset(90, 60), Offset(100, 52), Offset(115, 48),
    Offset(135, 50), Offset(155, 60), Offset(170, 75), Offset(178, 92),
    Offset(180, 110), Offset(170, 124), Offset(155, 132), Offset(135, 134),
    Offset(115, 132), Offset(100, 126), Offset(90, 118), Offset(85, 106),
    Offset(86, 90), Offset(95, 78), Offset(112, 70), Offset(132, 68),
    Offset(152, 72), Offset(168, 82), Offset(178, 96), Offset(180, 110),
    Offset(180, 122), Offset(174, 132), Offset(162, 138), Offset(146, 140),
    Offset(130, 138), Offset(118, 132), Offset(110, 124), Offset(108, 114),
    Offset(258, 60), Offset(270, 62), Offset(285, 66), Offset(300, 74),
    Offset(310, 86), Offset(312, 100), Offset(308, 114), Offset(300, 126),
    Offset(286, 132), Offset(270, 132), Offset(258, 128), Offset(250, 120),
    Offset(248, 108), Offset(252, 96), Offset(260, 86), Offset(272, 80),
  ];

  final Widget recipeHover = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe 3.2 — Hover Heatmap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: olive,
          ),
        ),
        const SizedBox(height: 4.0),
        body(
          'PointerHoverEvent fires for mouse / stylus pointers when they are '
          'NOT in contact.  Accumulating each onPointerHover.localPosition '
          'into a 2-D bucket grid produces a heatmap of where the cursor '
          'spent its time. Below is a static heatmap derived from 76 mock '
          'hover events that wandered into three orbits around an unseen '
          'tooltip target.',
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 180.0,
          decoration: BoxDecoration(
            color: const Color(0xFF111522),
            border: Border.all(color: rule),
          ),
          child: CustomPaint(
            painter: _PainterFn((Canvas canvas, Size size) {
              // Build a 2-D bucket grid 360x160 / cell=15.
              const double cell = 15.0;
              final int cols = (size.width / cell).ceil();
              final int rows = (size.height / cell).ceil();
              final List<List<int>> buckets =
                  List<List<int>>.generate(rows, (int r) {
                return List<int>.filled(cols, 0);
              });
              for (final Offset p in hoverPoints) {
                final int c = (p.dx / cell).floor().clamp(0, cols - 1);
                final int r = (p.dy / cell).floor().clamp(0, rows - 1);
                buckets[r][c] += 1;
              }
              int peak = 1;
              for (final List<int> row in buckets) {
                for (final int v in row) {
                  if (v > peak) peak = v;
                }
              }
              for (int r = 0; r < rows; r++) {
                for (int c = 0; c < cols; c++) {
                  final int v = buckets[r][c];
                  if (v == 0) continue;
                  final double t = v / peak;
                  final Color tint = Color.lerp(
                    const Color(0xFF2244AA),
                    const Color(0xFFFFE082),
                    t,
                  )!
                      .withOpacity(0.30 + (t * 0.6));
                  final Paint p = Paint()..color = tint;
                  canvas.drawRect(
                    Rect.fromLTWH(c * cell, r * cell, cell, cell),
                    p,
                  );
                }
              }
              // overlay the path as a faint white line
              final Paint pp = Paint()
                ..color = Colors.white.withOpacity(0.18)
                ..strokeWidth = 1.0
                ..style = PaintingStyle.stroke;
              final Path path = Path()
                ..moveTo(hoverPoints.first.dx, hoverPoints.first.dy);
              for (int i = 1; i < hoverPoints.length; i++) {
                path.lineTo(hoverPoints[i].dx, hoverPoints[i].dy);
              }
              canvas.drawPath(path, pp);
            }),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            pill('cell=15px', slate),
            pill('peak=8', amber),
            pill('hover events: 76', olive),
            pill('touch devices: no hover ever', crimson),
          ],
        ),
        mono(
          'Listener(\n'
          '  onPointerHover: (PointerHoverEvent e) {\n'
          '    final int c = (e.localPosition.dx / 15).floor();\n'
          '    final int r = (e.localPosition.dy / 15).floor();\n'
          '    buckets[r][c] += 1;\n'
          '    setState((){});\n'
          '  },\n'
          '  child: CustomPaint(painter: HeatmapPainter(buckets)),\n'
          ');',
        ),
      ],
    ),
  );

  // ---- Recipe 3.3 : scroll wheel meter ----

  // Mock log of PointerScrollEvent.scrollDelta.dy entries over time.
  final List<double> scrollDeltas = const <double>[
    0, 0, 0, 0, 4, 16, 38, 52, 70, 84, 96, 102, 108, 110, 105, 96,
    82, 64, 44, 28, 16, 8, 4, 2, 0, 0, 0, -6, -22, -48, -82, -106,
    -120, -118, -104, -82, -56, -34, -18, -8, -4, -2, 0, 0,
  ];

  final Widget recipeScroll = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe 3.3 — Scroll-Wheel Meter (PointerSignal)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: olive,
          ),
        ),
        const SizedBox(height: 4.0),
        body(
          'PointerScrollEvent arrives as a PointerSignalEvent — never as a '
          'PointerMoveEvent.  Mouse wheels and trackpad two-finger scrolls '
          'are reported here.  scrollDelta is in PHYSICAL pixels; the sign '
          'follows screen convention (positive = down/right).  The waveform '
          'below traces 44 consecutive scroll events as the user wheeled '
          'down, paused, then wheeled back up faster.',
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 160.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3EA),
            border: Border.all(color: rule),
          ),
          child: CustomPaint(
            painter: _PainterFn((Canvas canvas, Size size) {
              final double w = size.width;
              final double h = size.height;
              final double midY = h / 2;
              // grid + zero line
              final Paint grid = Paint()
                ..color = const Color(0xFFDDD0AA)
                ..strokeWidth = 0.5;
              for (double y = 20; y < h; y += 20) {
                canvas.drawLine(Offset(0, y), Offset(w, y), grid);
              }
              final Paint zero = Paint()
                ..color = const Color(0xFF777777)
                ..strokeWidth = 1.0;
              canvas.drawLine(Offset(0, midY), Offset(w, midY), zero);
              // bars
              final double stride = w / scrollDeltas.length;
              for (int i = 0; i < scrollDeltas.length; i++) {
                final double v = scrollDeltas[i];
                final double bh = (v / 120.0) * (h / 2 - 10);
                final Color c = v >= 0
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828);
                final Paint bar = Paint()..color = c.withOpacity(0.85);
                canvas.drawRect(
                  Rect.fromLTWH(
                    i * stride + 2,
                    bh >= 0 ? midY - bh : midY,
                    stride - 4,
                    bh.abs(),
                  ),
                  bar,
                );
              }
              // legend
              final TextPainter tp = TextPainter(
                textDirection: TextDirection.ltr,
              );
              tp.text = const TextSpan(
                text: '+120',
                style: TextStyle(fontSize: 9, color: Color(0xFF333333)),
              );
              tp.layout();
              tp.paint(canvas, const Offset(2, 4));
              tp.text = const TextSpan(
                text: '-120',
                style: TextStyle(fontSize: 9, color: Color(0xFF333333)),
              );
              tp.layout();
              tp.paint(canvas, Offset(2, h - 14));
            }),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            pill('PointerSignalEvent', olive),
            pill('PointerScrollEvent', amber),
            pill('44 ticks ≈ 0.7s', slate),
            pill('peak +110 / -120 px', crimson),
          ],
        ),
        mono(
          'Listener(\n'
          '  onPointerSignal: (PointerSignalEvent e) {\n'
          '    if (e is PointerScrollEvent) {\n'
          '      log.add(e.scrollDelta.dy);\n'
          '      if (e.scrollDelta.dy.abs() > 60) {\n'
          '        // intercept the scroll - call:\n'
          '        GestureBinding.instance.pointerSignalResolver.register(\n'
          '          e, (PointerSignalEvent ev) { /*handle*/ });\n'
          '      }\n'
          '    }\n'
          '  },\n'
          '  child: child,\n'
          ');',
        ),
      ],
    ),
  );

  // ---- Recipe 3.4 : signal events log (mock event-stream table) ----

  final List<List<String>> signalLog = const <List<String>>[
    <String>['t+000ms', 'PointerHoverEvent', 'mouse', '(120, 88)', '—'],
    <String>['t+032ms', 'PointerHoverEvent', 'mouse', '(122, 86)', '—'],
    <String>['t+064ms', 'PointerSignalEvent', 'mouse', '(122, 86)', 'scrollDelta=(0,+40)'],
    <String>['t+080ms', 'PointerSignalEvent', 'mouse', '(122, 86)', 'scrollDelta=(0,+80)'],
    <String>['t+112ms', 'PointerSignalEvent', 'mouse', '(122, 86)', 'scrollDelta=(0,+96)'],
    <String>['t+148ms', 'PointerHoverEvent', 'mouse', '(125, 88)', '—'],
    <String>['t+180ms', 'PointerDownEvent', 'mouse', '(125, 88)', 'buttons=0x1 primary'],
    <String>['t+212ms', 'PointerMoveEvent', 'mouse', '(128, 90)', 'delta=(3,2)'],
    <String>['t+228ms', 'PointerMoveEvent', 'mouse', '(133, 92)', 'delta=(5,2)'],
    <String>['t+244ms', 'PointerMoveEvent', 'mouse', '(141, 94)', 'delta=(8,2)'],
    <String>['t+260ms', 'PointerUpEvent', 'mouse', '(141, 94)', 'buttons=0'],
    <String>['t+292ms', 'PointerPanZoomStartEvent', 'trackpad', '(141, 94)', '—'],
    <String>['t+308ms', 'PointerPanZoomUpdateEvent', 'trackpad', '(141, 94)', 'pan=(20,0) scale=1.04'],
    <String>['t+324ms', 'PointerPanZoomUpdateEvent', 'trackpad', '(141, 94)', 'pan=(46,2) scale=1.12'],
    <String>['t+340ms', 'PointerPanZoomUpdateEvent', 'trackpad', '(141, 94)', 'pan=(72,2) scale=1.20'],
    <String>['t+356ms', 'PointerPanZoomEndEvent', 'trackpad', '(141, 94)', '—'],
    <String>['t+402ms', 'PointerDownEvent', 'touch#1', '(80, 200)', 'pressure=0.45'],
    <String>['t+434ms', 'PointerDownEvent', 'touch#2', '(220, 198)', 'pressure=0.50'],
    <String>['t+466ms', 'PointerMoveEvent', 'touch#1', '(82, 202)', 'delta=(2,2)'],
    <String>['t+466ms', 'PointerMoveEvent', 'touch#2', '(218, 196)', 'delta=(-2,-2)'],
    <String>['t+498ms', 'PointerCancelEvent', 'touch#1', '(82, 202)', 'app backgrounded'],
    <String>['t+498ms', 'PointerCancelEvent', 'touch#2', '(218, 196)', 'app backgrounded'],
  ];

  Widget logTable(List<List<String>> rows, List<String> headers, Color accent) {
    Widget cell(String text, {bool head = false, double flex = 1}) {
      return Expanded(
        flex: (flex * 10).toInt(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: head ? accent.withOpacity(0.18) : Colors.transparent,
            border: Border(
              right: BorderSide(color: rule),
              bottom: BorderSide(color: rule),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: head ? FontWeight.bold : FontWeight.normal,
              color: head ? accent : const Color(0xFF222222),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: rule),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              cell(headers[0], head: true, flex: 1.0),
              cell(headers[1], head: true, flex: 2.2),
              cell(headers[2], head: true, flex: 1.0),
              cell(headers[3], head: true, flex: 1.2),
              cell(headers[4], head: true, flex: 2.4),
            ],
          ),
          for (final List<String> r in rows)
            Row(
              children: <Widget>[
                cell(r[0], flex: 1.0),
                cell(r[1], flex: 2.2),
                cell(r[2], flex: 1.0),
                cell(r[3], flex: 1.2),
                cell(r[4], flex: 2.4),
              ],
            ),
        ],
      ),
    );
  }

  final Widget recipeSignalLog = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe 3.4 — Mixed-Source Pointer Stream Log',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: olive,
          ),
        ),
        const SizedBox(height: 4.0),
        body(
          'Listener serializes the engine pointer stream EXACTLY as it arrives. '
          'The pre-recorded log below shows a hypothetical 500ms session in '
          'which the user (a) wheel-scrolled, (b) primary-clicked and dragged '
          'a few pixels, (c) two-finger trackpad-pinched outward, (d) two-'
          'finger touched the screen, then (e) the OS cancelled the touch '
          'because the app was backgrounded.',
        ),
        const SizedBox(height: 8.0),
        logTable(
          signalLog,
          const <String>['time', 'event', 'kind', 'position', 'extra'],
          olive,
        ),
        const SizedBox(height: 8.0),
        calloutBox(
          'Pointer-ID semantics',
          'Each physical pointer (each finger, each mouse, each stylus tip) '
          'gets a STABLE int "pointer" id assigned by GestureBinding at the '
          'down event.  All move/up/cancel events for that physical pointer '
          'will carry the same id until up/cancel — then the id is retired. '
          'When the next pointer hits the screen a NEW id is minted.',
          slate,
        ),
      ],
    ),
  );

  // ---- Recipe 3.5 : multi-touch gallery (mock simultaneous fingers) ----

  // Five finger paths simulating a multi-touch chord.
  final List<List<Offset>> multiTouch = const <List<Offset>>[
    <Offset>[Offset(60, 60), Offset(62, 64), Offset(66, 70), Offset(72, 78), Offset(80, 86), Offset(88, 92)],
    <Offset>[Offset(120, 50), Offset(118, 54), Offset(116, 60), Offset(116, 70), Offset(120, 80), Offset(126, 90)],
    <Offset>[Offset(180, 60), Offset(178, 64), Offset(180, 72), Offset(184, 82), Offset(192, 90), Offset(202, 96)],
    <Offset>[Offset(240, 70), Offset(244, 74), Offset(252, 80), Offset(260, 88), Offset(266, 96), Offset(270, 104)],
    <Offset>[Offset(300, 80), Offset(302, 86), Offset(306, 94), Offset(310, 102), Offset(312, 110), Offset(310, 118)],
  ];

  final List<Color> fingerColors = const <Color>[
    Color(0xFFD32F2F),
    Color(0xFF1976D2),
    Color(0xFF388E3C),
    Color(0xFFFB8C00),
    Color(0xFF7B1FA2),
  ];

  final Widget recipeMultiTouch = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe 3.5 — Multi-Touch Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: olive,
          ),
        ),
        const SizedBox(height: 4.0),
        body(
          'Listener handles multiple simultaneous pointers natively — every '
          'PointerEvent carries a unique `pointer` id, so all you need is a '
          'Map<int, List<Offset>> keyed by event.pointer to track each '
          'finger independently. The mock below shows five fingers landing '
          'in a near-simultaneous chord, each drawing its own path.',
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 170.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F4E8),
            border: Border.all(color: rule),
          ),
          child: CustomPaint(
            painter: _PainterFn((Canvas canvas, Size size) {
              final Paint grid = Paint()
                ..color = const Color(0xFFE0DAC6)
                ..strokeWidth = 0.5;
              for (double x = 0; x < size.width; x += 20) {
                canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
              }
              for (double y = 0; y < size.height; y += 20) {
                canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
              }
              for (int f = 0; f < multiTouch.length; f++) {
                final List<Offset> path = multiTouch[f];
                final Color c = fingerColors[f];
                final Paint lp = Paint()
                  ..color = c
                  ..strokeWidth = 3.0
                  ..strokeCap = StrokeCap.round;
                for (int i = 1; i < path.length; i++) {
                  canvas.drawLine(path[i - 1], path[i], lp);
                }
                // down dot
                final Paint dot = Paint()..color = c;
                canvas.drawCircle(path.first, 8.0, dot);
                final TextPainter tp = TextPainter(
                  textDirection: TextDirection.ltr,
                );
                tp.text = TextSpan(
                  text: 'p${f + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                );
                tp.layout();
                tp.paint(canvas, path.first + const Offset(-7, -5));
                // up dot
                final Paint upDot = Paint()
                  ..color = Colors.white
                  ..style = PaintingStyle.fill;
                canvas.drawCircle(path.last, 5.0, upDot);
                final Paint upRing = Paint()
                  ..color = c
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2.0;
                canvas.drawCircle(path.last, 5.0, upRing);
              }
            }),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: [
            for (int i = 0; i < fingerColors.length; i++)
              pill('pointer#${i + 1}', fingerColors[i]),
          ],
        ),
        mono(
          'final Map<int, List<Offset>> paths = <int, List<Offset>>{};\n'
          'Listener(\n'
          '  onPointerDown:  (e) => paths[e.pointer] = <Offset>[e.localPosition],\n'
          '  onPointerMove:  (e) => paths[e.pointer]!.add(e.localPosition),\n'
          '  onPointerUp:    (e) => finalize(paths.remove(e.pointer)),\n'
          '  onPointerCancel:(e) => paths.remove(e.pointer),\n'
          '  child: CustomPaint(painter: ChordPainter(paths)),\n'
          ');',
        ),
      ],
    ),
  );

  // ===========================================================
  // ============== SECTION 4: HitTestBehavior =================
  // ===========================================================

  Widget hitBehaviorBox(
    String title,
    Color color,
    String description,
    bool selfHits,
    bool childrenHit,
    bool siblingsBelowHit,
  ) {
    Widget hitRow(String label, bool hits) {
      return Row(
        children: [
          Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: hits ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Center(
              child: Text(
                hits ? '✓' : '✕',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(label, style: const TextStyle(fontSize: 12.0)),
        ],
      );
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(description, style: const TextStyle(fontSize: 12.0, height: 1.4)),
            const SizedBox(height: 8.0),
            hitRow('itself receives events', selfHits),
            const SizedBox(height: 2.0),
            hitRow('children receive events', childrenHit),
            const SizedBox(height: 2.0),
            hitRow('siblings BELOW receive events', siblingsBelowHit),
          ],
        ),
      ),
    );
  }

  final Widget hitBehavior = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HitTestBehavior — how Listener interacts with the hit-test tree',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: teal,
          ),
        ),
        const SizedBox(height: 6.0),
        body(
          'HitTestBehavior is the parameter that decides whether a Listener '
          'is "visible" to the hit-test pass.  There are three values, each '
          'modeling a different mental picture of what a pointer-listener '
          'overlay looks like.',
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hitBehaviorBox(
              'deferToChild',
              const Color(0xFF1565C0),
              'Default.  Listener only catches pointers that actually land on '
                  'a NON-TRANSPARENT child.  If the child is null or sized to '
                  'zero, the Listener is effectively invisible to hit-testing.',
              true,
              true,
              false,
            ),
            hitBehaviorBox(
              'opaque',
              const Color(0xFFB28704),
              'Listener becomes a solid hit-target the size of its layout '
                  'box, regardless of what its child paints.  Always wins; '
                  'siblings drawn BELOW it cannot receive events in that area.',
              true,
              true,
              false,
            ),
            hitBehaviorBox(
              'translucent',
              const Color(0xFF6B8E23),
              'Listener catches events for its entire layout box AND lets '
                  'them pass through to siblings/parents underneath. Use this '
                  'for "passive" overlays such as analytics tracking.',
              true,
              true,
              true,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        subTitle('Visualizing the difference (mock hit-test trace)', teal),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3EA),
            border: Border.all(color: rule),
          ),
          child: CustomPaint(
            painter: _PainterFn((Canvas canvas, Size size) {
              // Lay out 3 stacks side-by-side, each with a labeled
              // bottom button (red) and a top Listener (blue) on top
              // of it, illustrating the resulting hit area.
              final double colW = size.width / 3;
              final List<String> labels = <String>[
                'deferToChild',
                'opaque',
                'translucent',
              ];
              final List<Color> accent = <Color>[
                const Color(0xFF1565C0),
                const Color(0xFFB28704),
                const Color(0xFF6B8E23),
              ];
              for (int i = 0; i < 3; i++) {
                final double cx = colW * i + colW / 2;
                // Bottom button - red rectangle.
                final Paint redFill = Paint()
                  ..color = const Color(0xFFE53935).withOpacity(0.8);
                final Rect btmRect =
                    Rect.fromCenter(center: Offset(cx, 140), width: 130, height: 60);
                canvas.drawRect(btmRect, redFill);
                final TextPainter tp = TextPainter(
                  textDirection: TextDirection.ltr,
                );
                tp.text = const TextSpan(
                  text: 'button below',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                );
                tp.layout();
                tp.paint(canvas, Offset(cx - tp.width / 2, 134));

                // Top Listener — only outlined for "deferToChild",
                // solid translucent box for "opaque", solid striped for
                // "translucent".
                final Rect topRect =
                    Rect.fromCenter(center: Offset(cx, 80), width: 150, height: 80);
                if (i == 0) {
                  // deferToChild — child here is just text; we draw a
                  // small inner solid child and surround it with dashed
                  // outline showing the listener box.
                  final Paint outline = Paint()
                    ..color = accent[0]
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.5;
                  // dashes
                  const double dash = 6, gap = 4;
                  for (double x = topRect.left; x < topRect.right; x += dash + gap) {
                    canvas.drawLine(
                      Offset(x, topRect.top),
                      Offset(x + dash, topRect.top),
                      outline,
                    );
                    canvas.drawLine(
                      Offset(x, topRect.bottom),
                      Offset(x + dash, topRect.bottom),
                      outline,
                    );
                  }
                  for (double y = topRect.top; y < topRect.bottom; y += dash + gap) {
                    canvas.drawLine(
                      Offset(topRect.left, y),
                      Offset(topRect.left, y + dash),
                      outline,
                    );
                    canvas.drawLine(
                      Offset(topRect.right, y),
                      Offset(topRect.right, y + dash),
                      outline,
                    );
                  }
                  // small solid child
                  final Paint child = Paint()..color = accent[0];
                  canvas.drawRect(
                    Rect.fromCenter(
                      center: Offset(cx, 80),
                      width: 80,
                      height: 32,
                    ),
                    child,
                  );
                  tp.text = const TextSpan(
                    text: 'child',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  tp.layout();
                  tp.paint(canvas, Offset(cx - tp.width / 2, 72));
                } else if (i == 1) {
                  // opaque — solid amber fill
                  final Paint solid = Paint()..color = accent[1].withOpacity(0.85);
                  canvas.drawRect(topRect, solid);
                  tp.text = const TextSpan(
                    text: 'OPAQUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  tp.layout();
                  tp.paint(canvas, Offset(cx - tp.width / 2, 72));
                } else {
                  // translucent — striped overlay
                  final Paint stripe = Paint()
                    ..color = accent[2].withOpacity(0.75)
                    ..strokeWidth = 4.0;
                  // background tint
                  final Paint bg = Paint()..color = accent[2].withOpacity(0.15);
                  canvas.drawRect(topRect, bg);
                  for (double xx = topRect.left - topRect.height;
                      xx < topRect.right;
                      xx += 12) {
                    canvas.drawLine(
                      Offset(xx, topRect.bottom),
                      Offset(xx + topRect.height, topRect.top),
                      stripe,
                    );
                  }
                  canvas.drawRect(
                    topRect,
                    Paint()
                      ..color = accent[2]
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.5,
                  );
                  tp.text = const TextSpan(
                    text: 'TRANSLUCENT',
                    style: TextStyle(
                      color: Color(0xFF2E2E2E),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  tp.layout();
                  tp.paint(canvas, Offset(cx - tp.width / 2, 72));
                }
                // Label
                tp.text = TextSpan(
                  text: labels[i],
                  style: TextStyle(
                    color: accent[i],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                );
                tp.layout();
                tp.paint(canvas, Offset(cx - tp.width / 2, 12));

                // Hit-test verdict
                final String verdict;
                final Color vColor;
                if (i == 0) {
                  verdict = 'Top hits only on CHILD pixels';
                  vColor = accent[0];
                } else if (i == 1) {
                  verdict = 'Top swallows ALL hits in box';
                  vColor = accent[1];
                } else {
                  verdict = 'Top sees hits AND button below too';
                  vColor = accent[2];
                }
                tp.text = TextSpan(
                  text: verdict,
                  style: TextStyle(
                    color: vColor,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                );
                tp.layout(maxWidth: colW - 16);
                tp.paint(canvas, Offset(cx - tp.width / 2, 188));
              }
            }),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        calloutBox(
          'Practical rule of thumb',
          '• Use deferToChild (default) when wrapping a positively-painted '
          'widget tree such as Container/Image/Text.\n'
          '• Use opaque when the Listener has no visible child but should '
          'still catch the full box (e.g. an invisible overlay covering an '
          'image to track pointer-down anywhere on it).\n'
          '• Use translucent only for PASSIVE observers (analytics, '
          'telemetry, ambient hover tracking). It is the most surprising '
          'option because both layers receive the event.',
          teal,
        ),
      ],
    ),
  );

  // ===========================================================
  // ============ SECTION 5: PointerDeviceKind matrix ==========
  // ===========================================================

  Widget kindMatrix() {
    Widget header(String t) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          color: slate.withOpacity(0.20),
          child: Text(
            t,
            style: TextStyle(
              color: slate,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }

    Widget cell(String t, {Color? color, bool mono = false}) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            border: Border(
              right: BorderSide(color: rule),
              bottom: BorderSide(color: rule),
            ),
          ),
          child: Text(
            t,
            style: TextStyle(
              fontFamily: mono ? 'monospace' : null,
              fontSize: 11.5,
              color: const Color(0xFF222222),
            ),
          ),
        ),
      );
    }

    Color yesBg = const Color(0xFFC8E6C9);
    Color noBg = const Color(0xFFFFCDD2);
    Color sometimesBg = const Color(0xFFFFF9C4);

    Widget row(
      String kind,
      List<String> support,
      String notes,
    ) {
      Color bg(String s) {
        if (s == '✓') return yesBg;
        if (s == '✕') return noBg;
        return sometimesBg;
      }

      return Row(
        children: [
          cell(kind, mono: true),
          cell(support[0], color: bg(support[0])),
          cell(support[1], color: bg(support[1])),
          cell(support[2], color: bg(support[2])),
          cell(support[3], color: bg(support[3])),
          cell(support[4], color: bg(support[4])),
          cell(notes),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: rule),
      ),
      child: Column(
        children: [
          Row(
            children: [
              header('PointerDeviceKind'),
              header('down/up'),
              header('move'),
              header('hover'),
              header('signal'),
              header('panZoom'),
              header('notes'),
            ],
          ),
          row('touch', <String>['✓', '✓', '✕', '✕', '✕'],
              'finger / capacitive screens'),
          row('mouse', <String>['✓', '✓', '✓', '✓', '✕'],
              'wheel ticks arrive as signal'),
          row('stylus', <String>['✓', '✓', '~', '~', '✕'],
              'hover only when stylus supports it'),
          row('invertedStylus', <String>['✓', '✓', '~', '✕', '✕'],
              'stylus held eraser-end down'),
          row('trackpad', <String>['~', '~', '✓', '✓', '✓'],
              'down/up only when click-tap or click-down'),
          row('unknown', <String>['~', '~', '~', '~', '~'],
              'reported when engine cannot classify'),
        ],
      ),
    );
  }

  final Widget kindSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerDeviceKind — which callbacks fire for which device',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: slate,
          ),
        ),
        const SizedBox(height: 6.0),
        body(
          'Not every callback fires for every device kind.  The matrix below '
          'is a reference cheat-sheet — ✓ means "always", ✕ means "never", '
          '~ means "sometimes, depending on hardware or OS".  Use '
          'event.kind to discriminate behavior at runtime.',
        ),
        const SizedBox(height: 8.0),
        kindMatrix(),
        const SizedBox(height: 12.0),
        subTitle('When PointerDeviceKind matters', slate),
        body(
          '• Designs that REQUIRE hover (tooltips, contextual highlights) '
          'must DEGRADE gracefully on touch devices — touch never hovers.\n'
          '• A scroll-driven feature must check event.kind != touch for '
          'PointerSignalEvent to avoid double-counting trackpad-pan-zoom '
          'as wheel scroll.\n'
          '• Pressure-sensitive UI should explicitly check '
          'event.kind == PointerDeviceKind.stylus AND event.pressure != 1.0 '
          'because non-pressure devices report pressure as 1.0.\n'
          '• Trackpad pan-zoom events arrive as a SINGLE synthetic pointer '
          'with kind=trackpad — never as multiple touch pointers.',
        ),
      ],
    ),
  );

  // ===========================================================
  // ============ SECTION 6: Comparison panels =================
  // ===========================================================

  Widget compareCard(
    String title,
    Color color,
    List<List<String>> rows,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              color: color.withOpacity(0.18),
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            for (final List<String> r in rows)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 96.0,
                      child: Text(
                        r[0],
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        r[1],
                        style: const TextStyle(fontSize: 12.0, height: 1.35),
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

  final Widget comparison = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listener vs. GestureDetector vs. MouseRegion',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: slate,
          ),
        ),
        const SizedBox(height: 6.0),
        body(
          'These three widgets sit at increasing levels of abstraction over '
          'the same underlying pointer stream. Pick the LOWEST-abstraction '
          'tool that still solves your problem; higher tools are more '
          'expressive but less powerful.',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            compareCard(
              'Listener (low level)',
              indigo,
              const <List<String>>[
                <String>['layer', 'raw PointerEvent'],
                <String>['arena?', 'no — always fires'],
                <String>['pre-empts?', 'cannot be pre-empted'],
                <String>['can be pre-empted?', 'yes by AbsorbPointer/IgnorePointer above'],
                <String>['hover?', 'yes via onPointerHover'],
                <String>['scroll?', 'yes via onPointerSignal'],
                <String>['trackpad pan-zoom?', 'yes via onPointerPanZoom*'],
                <String>['multi-touch?', 'yes natively via pointer id'],
                <String>['velocity?', 'no — you compute it'],
                <String>['use when', 'building a recognizer, drawing paths, capturing wheel'],
              ],
            ),
            compareCard(
              'GestureDetector (mid level)',
              const Color(0xFF2E7D32),
              const <List<String>>[
                <String>['layer', 'semantic gesture'],
                <String>['arena?', 'yes — may lose'],
                <String>['pre-empts?', 'competes via arena'],
                <String>['can be pre-empted?', 'yes by winning recognizer'],
                <String>['hover?', 'no (use MouseRegion)'],
                <String>['scroll?', 'no'],
                <String>['trackpad pan-zoom?', 'partially via onScale*'],
                <String>['multi-touch?', 'via onScale* (synthesized)'],
                <String>['velocity?', 'yes (DragEndDetails.velocity)'],
                <String>['use when', 'wiring buttons, drag handles, scale gestures'],
              ],
            ),
            compareCard(
              'MouseRegion (cursor level)',
              const Color(0xFFB7263A),
              const <List<String>>[
                <String>['layer', 'cursor + enter/exit'],
                <String>['arena?', 'n/a'],
                <String>['pre-empts?', 'no — orthogonal'],
                <String>['can be pre-empted?', 'no'],
                <String>['hover?', 'yes via onHover'],
                <String>['scroll?', 'no'],
                <String>['trackpad pan-zoom?', 'no'],
                <String>['multi-touch?', 'n/a — cursor only'],
                <String>['velocity?', 'no'],
                <String>['use when', 'changing cursor shape, computing hover boundaries'],
              ],
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        calloutBox(
          'Stacking them',
          'Listener, GestureDetector and MouseRegion frequently appear in '
          'the same widget tree.  A common pattern: outer MouseRegion sets '
          'the cursor, middle Listener tracks raw drag for analytics, inner '
          'GestureDetector translates user intent into onTap/onDoubleTap.  '
          'Because Listener fires BEFORE the gesture arena, it can observe '
          'events even when the inner GestureDetector loses its competition.',
          slate,
        ),
      ],
    ),
  );

  // ===========================================================
  // ============ SECTION 7: Glossary + recap ==================
  // ===========================================================

  Widget glossaryRow(String term, String def) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170.0,
            child: Text(
              term,
              style: TextStyle(
                color: indigo,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              def,
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  final Widget glossary = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: rule),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glossary',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigo,
          ),
        ),
        const SizedBox(height: 8.0),
        glossaryRow('PointerEvent',
            'Base class for every raw pointer signal in Flutter.'),
        glossaryRow('PointerDownEvent',
            'A new pointer has made contact.  pointer id is now active.'),
        glossaryRow('PointerMoveEvent',
            'An active (down) pointer has moved.  delta is non-zero.'),
        glossaryRow('PointerUpEvent',
            'A pointer has lifted gracefully.  pointer id retired.'),
        glossaryRow('PointerCancelEvent',
            'A pointer was aborted by the OS — there will be no Up.'),
        glossaryRow('PointerHoverEvent',
            'A pointer that is NOT in contact moved (mouse / hover stylus).'),
        glossaryRow('PointerSignalEvent',
            'A non-positional input — most commonly the mouse wheel.'),
        glossaryRow('PointerScrollEvent',
            'Subclass of PointerSignalEvent for wheel ticks; carries scrollDelta.'),
        glossaryRow('PointerPanZoom*Event',
            'Trackpad-style pan/zoom/rotate gesture, reported as a single synthetic pointer.'),
        glossaryRow('PointerDeviceKind',
            'Enum: touch, mouse, stylus, invertedStylus, trackpad, unknown.'),
        glossaryRow('pointer (id)',
            'Stable int identifier for one physical pointer between down and up/cancel.'),
        glossaryRow('buttons',
            'Bitmask: kPrimaryButton (0x1), kSecondaryButton (0x2), kMiddleMouseButton (0x4)...'),
        glossaryRow('pressure',
            '0.0..1.0; reports 1.0 on devices without pressure sensors.'),
        glossaryRow('delta vs localDelta',
            'delta is in screen coordinates; localDelta in the listener\'s '
                'transformed coordinate space.'),
        glossaryRow('HitTestBehavior',
            'How the underlying RenderPointerListener participates in hit testing.'),
        glossaryRow('GestureBinding',
            'The framework binding that owns the pointer router.'),
        glossaryRow('pointerSignalResolver',
            'Singleton used to disambiguate scroll signals between '
                'nested listeners — see GestureBinding.instance.pointerSignalResolver.'),
        glossaryRow('arena',
            'The gesture arena where competing recognizers vie for a stream.  '
                'Listener does NOT participate in the arena.'),
        glossaryRow('RenderPointerListener',
            'RenderObject backing Listener — exposes a "trampoline" method '
                'for each callback.'),
      ],
    ),
  );

  // Recap section.

  final Widget recap = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: indigo.withOpacity(0.08),
      border: Border.all(color: indigo, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recap — when (and when NOT) to reach for Listener',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: indigo,
          ),
        ),
        const SizedBox(height: 8.0),
        body(
          'REACH FOR LISTENER WHEN:\n'
          '  • you need scroll-wheel signals (PointerSignal / PointerScroll).\n'
          '  • you need trackpad pan-zoom (PointerPanZoom*).\n'
          '  • you need stylus pressure / tilt / orientation in raw form.\n'
          '  • you are implementing a custom gesture recognizer or '
          'physics-based drag.\n'
          '  • you need to OBSERVE pointer activity even when another '
          'recognizer wins the arena.\n'
          '  • you need per-pointer state with multiple simultaneous '
          'pointers using event.pointer as a key.',
        ),
        const SizedBox(height: 8.0),
        body(
          'DO NOT REACH FOR LISTENER WHEN:\n'
          '  • a button just needs a tap — use GestureDetector or InkWell.\n'
          '  • you need drag velocity — GestureDetector.onPanEnd already '
          'computes it for you.\n'
          '  • you only need cursor changes — use MouseRegion.cursor.\n'
          '  • you are tempted to manually disambiguate tap vs. drag — '
          'GestureDetector and the arena exist precisely for that.\n'
          '  • the event you need is already exposed by InteractiveViewer / '
          'Draggable / Scrollable.',
        ),
        const SizedBox(height: 8.0),
        body(
          'COMMON MISTAKES:\n'
          '  • Updating setState() from onPointerMove without throttling — '
          'this rebuilds the subtree on every frame of the drag.\n'
          '  • Putting expensive work in onPointerHover — fires on EVERY '
          'mouse motion, which can be 120Hz+.\n'
          '  • Forgetting onPointerCancel — without it, you may leak state '
          'when the OS interrupts the gesture.\n'
          '  • Using HitTestBehavior.opaque on a Listener that is the '
          'visible child of a Container that already has its own '
          'GestureDetector — you may block the GestureDetector\'s '
          'hit-test from sibling children.\n'
          '  • Assuming touch devices send onPointerHover — they never do.',
        ),
      ],
    ),
  );

  // ===========================================================
  // ====================  ASSEMBLY  ===========================
  // ===========================================================

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #120, P2):
  // The page root packs a Banner + seven dossier sections (anatomy,
  // recipes ×5, hit-test demo, kind matrix, comparison, glossary, recap)
  // into a `Column(stretch, mainAxisSize.min)` with no scroll ancestor;
  // combined height ≈ 8331 px greater than the desktop test viewport →
  // "A RenderFlex overflowed by 8331 pixels on the bottom." Wrap the
  // Column in `SingleChildScrollView`. The parchment-coloured outer
  // Container stays *outside* the SCV so the `0xFFEFEAD8` backdrop fills
  // the whole viewport, not just the scrolled content; the 14 px padding
  // moves onto the SCV so the inner Column still gets the same gutter.
  // Plan listed P1+P2, but the file has no `Row(crossAxisAlignment.
  // stretch)` site, so P2 alone is sufficient.
  return Container(
    color: const Color(0xFFEFEAD8),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(14.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Banner.
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF1A237E),
                Color(0xFF3F51B5),
                Color(0xFF5C6BC0),
              ],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'LISTENER — Visual Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'A hand-authored dossier on Flutter\'s lowest-level pointer-event widget. '
                'Includes mock-recorded event traces rendered statically on canvas — no real '
                'interaction needed.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),

        sectionTitle('1', 'Dossier — purpose and pipeline position', indigo),
        dossier,

        sectionTitle('2', 'Anatomy — every callback dissected', amber),
        anatomy,

        sectionTitle('3', 'Recipes — five worked patterns', olive),
        recipeDrag,
        const SizedBox(height: 10.0),
        recipeHover,
        const SizedBox(height: 10.0),
        recipeScroll,
        const SizedBox(height: 10.0),
        recipeSignalLog,
        const SizedBox(height: 10.0),
        recipeMultiTouch,

        sectionTitle('4', 'HitTestBehavior — visualizing each value', teal),
        hitBehavior,

        sectionTitle('5', 'PointerDeviceKind matrix', slate),
        kindSection,

        sectionTitle('6', 'Comparison: Listener vs. GestureDetector vs. MouseRegion',
            slate),
        comparison,

        sectionTitle('7', 'Glossary + recap', indigo),
        glossary,
        const SizedBox(height: 10.0),
        recap,

        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: rule),
          ),
          child: const Text(
            'End of dossier.  Listener is the raw pointer-event surface — '
            'reach for it deliberately, prefer GestureDetector or MouseRegion '
            'where they suffice.',
            style: TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              color: Color(0xFF555555),
            ),
          ),
        ),
      ],
    ),
    ),
  );
}

// ---------------------------------------------------------------------------
// _PainterFn — a tiny CustomPainter that delegates to an inline closure so we
// can avoid declaring a StatefulWidget or top-level class proliferation.
// ---------------------------------------------------------------------------

class _PainterFn extends CustomPainter {
  _PainterFn(this._paintFn);

  final void Function(Canvas canvas, Size size) _paintFn;

  @override
  void paint(Canvas canvas, Size size) => _paintFn(canvas, size);

  @override
  bool shouldRepaint(covariant _PainterFn oldDelegate) => true;
}
