// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//  GLACIAL TOPAZ — A Field Notebook on PointerPanZoomUpdateEvent
// ============================================================================
//
//  THEME
//  -----
//  "Glacial Topaz" — a palette borrowed from a sun-warmed glacier face seen
//  through gemological loupes. Cold blues and milk-whites of the ice itself
//  meet the warm yellow-orange honey of topaz crystals embedded in the moraine.
//  The palette is designed to evoke the feeling of a smooth two-finger
//  trackpad gesture — gliding, precise, occasionally rotating — while still
//  remaining warm enough that the reader does not feel they are reading a
//  cold technical reference. Every color is named, every section is themed.
//
//  SUBJECT
//  -------
//  This file is a hand-written, instruction-rich demo for the Flutter type:
//
//      PointerPanZoomUpdateEvent
//          (from package:flutter/gestures.dart)
//
//  PointerPanZoomUpdateEvent represents an in-progress trackpad pan/zoom/
//  rotation gesture. It is one of three events in a tightly choreographed
//  sequence:
//
//      1. PointerPanZoomStartEvent  — gesture begins (two fingers down)
//      2. PointerPanZoomUpdateEvent — gesture progresses (this file's subject)
//      3. PointerPanZoomEndEvent    — gesture concludes (fingers lifted)
//
//  Each update carries the cumulative pan offset, a delta since the previous
//  update, the current scale factor, and the current rotation in radians.
//  Together these three values form a tidy little affine transform you can
//  apply to a child widget to make it follow your fingers.
//
//  PHILOSOPHY
//  ----------
//  We do not animate. We do not setState. We do not subscribe to streams.
//  This file is consumed by the d4rt analyzer-free interpreter, which calls
//  build(BuildContext) exactly once and renders the resulting widget tree as
//  a single immutable snapshot. Everything you see on screen is a frozen
//  moment. The illusion of motion is constructed by rendering many frozen
//  moments side by side: a flipbook, not a film.
//
//  Instead of state, we lean on six concrete construction examples — each a
//  PointerPanZoomUpdateEvent with explicit pan, scale, and rotation values
//  — and we read those fields back into the rendered tree so the reader can
//  see exactly what the framework stored when it accepted the constructor
//  arguments. The six examples form a story: a slow drift left, a pinch-in,
//  a pinch-out, a clockwise twist, a counterclockwise twist, and a combined
//  zoom-and-rotate finale.
//
//  SECTIONS
//  --------
//   1. Title banner with palette swatches.
//   2. Prose anatomy card.
//   3. Property anatomy panel.
//   4. Construction gallery (six event instances).
//   5. Timeline diagram.
//   6. Sampling table (12 rows).
//   7. Pointer-kind comparison matrix.
//   8. Coordinate-space walk.
//   9. Pitfalls / gotchas (six callouts).
//  10. Code-snippet cards.
//  11. Glossary (12+ terms).
//  12. Recap footer.
//
//  RULES (for the d4rt interpreter)
//  --------------------------------
//   * build() is called once, returns a snapshot Scaffold.
//   * No StatefulWidget, no setState, no controllers, no animations.
//   * No for-in iteration over a BridgedInstance — explicit Lists only.
//   * No .value reads on Tween.animate — we never tween.
//   * Color alpha set via .withValues(alpha: ...) — never .withOpacity.
//   * Six or more PointerPanZoomUpdateEvent instances are constructed and
//     their fields read into the rendered tree.
//   * 5–15 print() narrative calls during build to log the journey.
//
// ============================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // PALETTE — Glacial Topaz
  // --------------------------------------------------------------------------
  // Ten-plus named colors, each chosen to occupy a specific role in the
  // composition. We declare them as final locals so each section can quote
  // them by name rather than by hex value.
  // --------------------------------------------------------------------------

  final Color glacierMilk = Color(0xFFEAF3F7); // page background, very pale blue
  final Color glacierIce = Color(0xFFBFD8E2); // cool surface, panels
  final Color glacierShadow = Color(0xFF6E94A6); // mid-blue shadow
  final Color crevasseBlue = Color(0xFF2B5A74); // deep blue ink for headings
  final Color polarNight = Color(0xFF0F2230); // near-black for body text
  final Color topazAmber = Color(0xFFE0A93B); // warm topaz primary accent
  final Color topazHoney = Color(0xFFF6CB6E); // soft topaz highlight
  final Color topazRust = Color(0xFFB37020); // dark topaz, danger / pitfall
  final Color frostGold = Color(0xFFF7E6B5); // pale topaz wash, banners
  final Color moraineGrey = Color(0xFF847469); // warm grey, secondary text
  final Color lichenGreen = Color(0xFF6E8C5A); // accent, success / OK
  final Color berryRed = Color(0xFF9C3A3A); // accent, warnings
  final Color skyTopaz = Color(0xFF7FB3CA); // mid-blue accent, links

  print('[glacial-topaz] palette initialized: 13 named colors');
  print('[glacial-topaz] subject: PointerPanZoomUpdateEvent');

  // --------------------------------------------------------------------------
  // SIX CONSTRUCTED EVENTS — the construction gallery's spine
  // --------------------------------------------------------------------------
  // Each event tells one beat of a longer trackpad gesture: a story arc told
  // through pan, scale, and rotation values. We construct them up front so
  // the property gallery and the sampling table can both refer to the same
  // underlying objects.
  // --------------------------------------------------------------------------

  final eventA = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 16),
    position: Offset(120.0, 240.0),
    pan: Offset(2.0, 0.0),
    panDelta: Offset(2.0, 0.0),
    scale: 1.0,
    rotation: 0.0,
  );
  print('[event-A] gentle drift right, scale 1.0, rotation 0.0');

  final eventB = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 32),
    position: Offset(124.0, 244.0),
    pan: Offset(8.0, 4.0),
    panDelta: Offset(6.0, 4.0),
    scale: 1.05,
    rotation: 0.02,
  );
  print('[event-B] continued drift, slight zoom-in, faint rotation');

  final eventC = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 64),
    position: Offset(140.0, 252.0),
    pan: Offset(20.0, 12.0),
    panDelta: Offset(12.0, 8.0),
    scale: 1.30,
    rotation: 0.10,
  );
  print('[event-C] bigger pan delta, clear pinch-out');

  final eventD = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 96),
    position: Offset(150.0, 260.0),
    pan: Offset(30.0, 20.0),
    panDelta: Offset(10.0, 8.0),
    scale: 0.85,
    rotation: -0.18,
  );
  print('[event-D] pinch-in, counterclockwise rotation');

  final eventE = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 128),
    position: Offset(160.0, 264.0),
    pan: Offset(40.0, 24.0),
    panDelta: Offset(10.0, 4.0),
    scale: 1.50,
    rotation: 0.45,
  );
  print('[event-E] strong zoom-out illusion via large scale + clockwise twist');

  final eventF = PointerPanZoomUpdateEvent(
    pointer: 1,
    device: 0,
    timeStamp: Duration(milliseconds: 160),
    position: Offset(172.0, 270.0),
    pan: Offset(52.0, 30.0),
    panDelta: Offset(12.0, 6.0),
    scale: 2.00,
    rotation: 0.78,
  );
  print('[event-F] finale: 2x scale, 0.78 rad (~44.6 degrees)');

  final List<PointerPanZoomUpdateEvent> gallery = [
    eventA,
    eventB,
    eventC,
    eventD,
    eventE,
    eventF,
  ];
  print('[gallery] six events constructed for the gallery section');

  // --------------------------------------------------------------------------
  // SECTION 1 — TITLE BANNER
  // --------------------------------------------------------------------------
  // A wide banner introducing the theme, the subject class, and a strip of
  // palette swatches so the reader sees the entire color vocabulary up front.
  // --------------------------------------------------------------------------

  final Widget titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          glacierIce,
          frostGold,
        ],
      ),
      border: Border(
        bottom: BorderSide(color: crevasseBlue, width: 3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GLACIAL TOPAZ',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w900,
            fontSize: 28,
            letterSpacing: 4,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'A field notebook on PointerPanZoomUpdateEvent',
          style: TextStyle(
            color: polarNight,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _swatch(glacierMilk, 'milk', polarNight),
            _swatch(glacierIce, 'ice', polarNight),
            _swatch(glacierShadow, 'shadow', glacierMilk),
            _swatch(crevasseBlue, 'crevasse', glacierMilk),
            _swatch(polarNight, 'polar', glacierMilk),
            _swatch(topazAmber, 'amber', polarNight),
            _swatch(topazHoney, 'honey', polarNight),
            _swatch(topazRust, 'rust', glacierMilk),
            _swatch(frostGold, 'frost', polarNight),
            _swatch(moraineGrey, 'moraine', glacierMilk),
            _swatch(lichenGreen, 'lichen', glacierMilk),
            _swatch(berryRed, 'berry', glacierMilk),
            _swatch(skyTopaz, 'sky', polarNight),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Trackpad gesture telemetry, frozen mid-flight.',
          style: TextStyle(
            color: crevasseBlue,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 2 — PROSE ANATOMY CARD
  // --------------------------------------------------------------------------
  // A long-form prose explanation of the trackpad gesture pipeline, the
  // start/update/end sequence, and why this whole branch of the pointer
  // taxonomy lives outside the touch/mouse story.
  // --------------------------------------------------------------------------

  final Widget anatomyCard = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2 — Anatomy of a trackpad gesture',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Modern trackpads do not behave like touchscreens. When you place '
          'two fingers on a trackpad and slide them, the operating system does '
          'not deliver two independent touch streams to the application. '
          'Instead, the OS observes both fingers, distills the motion into a '
          'single high-level gesture (pan + scale + rotation), and forwards '
          'that distilled gesture to the application as a sequence of three '
          'event types.',
          style: TextStyle(color: polarNight, fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Flutter mirrors this in its pointer event taxonomy. Touch events '
          'use PointerDown / PointerMove / PointerUp. Mouse events use the '
          'same hierarchy plus PointerHover and PointerSignal. Trackpad '
          'pan/zoom/rotation gestures use a third sibling family:',
          style: TextStyle(color: polarNight, fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 8),
        _bullet(
          'PointerPanZoomStartEvent — the user has placed two fingers on the '
          'trackpad and the OS has decided this is a pan/zoom/rotation '
          'gesture (rather than a click or scroll). No motion data yet.',
          polarNight,
          topazAmber,
        ),
        _bullet(
          'PointerPanZoomUpdateEvent — fired repeatedly while the gesture is '
          'in progress. Each event carries the current cumulative pan, the '
          'pan delta since the previous update, the current scale, and the '
          'current rotation. THIS is the file you are reading.',
          polarNight,
          topazAmber,
        ),
        _bullet(
          'PointerPanZoomEndEvent — fired once when the user lifts their '
          'fingers. No motion data; just a closing bracket so applications '
          'can stop tracking the gesture.',
          polarNight,
          topazAmber,
        ),
        SizedBox(height: 10),
        Text(
          'Why a third family? Because the OS has already done the multi-finger '
          'reduction work for us. Re-deriving pan + scale + rotation from raw '
          'touch points is hard, slow, and notoriously bad at handling palm '
          'rejection on trackpads. By accepting the OS-distilled events '
          'directly, Flutter gets correct, low-latency, OS-grade gesture '
          'recognition for free.',
          style: TextStyle(color: polarNight, fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 3 — PROPERTY ANATOMY PANEL
  // --------------------------------------------------------------------------
  // For each public field, a swatch + type + role description. We keep this
  // as a tidy column of rows rather than a full Table widget so it lays out
  // gracefully on narrow screens.
  // --------------------------------------------------------------------------

  final Widget propertyPanel = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierIce.withValues(alpha: 0.45),
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3 — Property anatomy',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Eleven public fields, each with a role in the gesture story.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        _propertyRow(topazAmber, 'pan', 'Offset',
            'Cumulative pan offset since gesture start.', polarNight),
        _propertyRow(topazHoney, 'panDelta', 'Offset',
            'Pan offset since the previous update event.', polarNight),
        _propertyRow(topazRust, 'scale', 'double',
            'Current scale factor. 1.0 means no zoom.', polarNight),
        _propertyRow(frostGold, 'rotation', 'double',
            'Current rotation in radians. 0.0 means no rotation.',
            polarNight),
        _propertyRow(skyTopaz, 'localPan', 'Offset',
            'Pan in the local coordinate space of the receiving widget.',
            polarNight),
        _propertyRow(skyTopaz, 'localPanDelta', 'Offset',
            'panDelta in the local coordinate space.', polarNight),
        _propertyRow(crevasseBlue, 'position', 'Offset',
            'Pointer position in global coordinates.', glacierMilk),
        _propertyRow(crevasseBlue, 'localPosition', 'Offset',
            'Pointer position in local coordinates.', glacierMilk),
        _propertyRow(glacierShadow, 'kind', 'PointerDeviceKind',
            'Device kind. Always trackpad for these events.', glacierMilk),
        _propertyRow(moraineGrey, 'device', 'int',
            'Device identifier so multiple trackpads can be told apart.',
            glacierMilk),
        _propertyRow(moraineGrey, 'pointer', 'int',
            'Pointer identifier; stable across the start/update/end run.',
            glacierMilk),
        _propertyRow(lichenGreen, 'timeStamp', 'Duration',
            'Time since engine start when the OS recorded the event.',
            glacierMilk),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 4 — CONSTRUCTION GALLERY
  // --------------------------------------------------------------------------
  // Six concrete event instances rendered as cards. For each card we show the
  // result of event.toString() and a tidy read-back of pan, scale, rotation.
  // --------------------------------------------------------------------------

  final List<Widget> galleryCards = [
    _galleryCard('A — gentle drift', eventA, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
    _galleryCard('B — slight zoom-in', eventB, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
    _galleryCard('C — clear pinch-out', eventC, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
    _galleryCard('D — pinch-in / CCW twist', eventD, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
    _galleryCard('E — large scale, CW twist', eventE, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
    _galleryCard('F — finale 2x + 44.6 deg', eventF, glacierMilk, glacierIce,
        crevasseBlue, polarNight, topazAmber, moraineGrey),
  ];

  final Widget constructionGallery = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4 — Construction gallery',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Six events, six beats of a story. Each card shows the constructor '
          'arguments and reads back the live field values.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Column(children: galleryCards),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 5 — TIMELINE DIAGRAM
  // --------------------------------------------------------------------------
  // A horizontal stack of small Containers representing event types in order:
  //   [down] [start] [update * 6] [end]
  // We label each block and color-code by family so the eye can sweep the
  // sequence in one glance.
  // --------------------------------------------------------------------------

  final List<Widget> timelineBlocks = [
    _timelineBlock('down', 'PointerDownEvent\n(touch only)',
        glacierShadow.withValues(alpha: 0.3), polarNight, false),
    _timelineBlock('start', 'PointerPanZoomStartEvent', topazHoney, polarNight,
        true),
    _timelineBlock('upd 1', 'A — drift', topazAmber, polarNight, true),
    _timelineBlock('upd 2', 'B — zoom', topazAmber, polarNight, true),
    _timelineBlock('upd 3', 'C — pinch+', topazAmber, polarNight, true),
    _timelineBlock('upd 4', 'D — pinch-', topazAmber, polarNight, true),
    _timelineBlock('upd 5', 'E — twist', topazAmber, polarNight, true),
    _timelineBlock('upd 6', 'F — finale', topazAmber, polarNight, true),
    _timelineBlock('end', 'PointerPanZoomEndEvent', topazHoney, polarNight,
        true),
  ];

  final Widget timelineSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: frostGold.withValues(alpha: 0.4),
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5 — Two-finger trackpad gesture timeline',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'A trackpad gesture is a tightly choreographed sequence. Events '
          'flow left to right. The grey block on the far left is the '
          'touchscreen-only PointerDown event, included for contrast.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: timelineBlocks),
        ),
        SizedBox(height: 12),
        Text(
          'Note that PointerPanZoomStartEvent and PointerPanZoomEndEvent '
          'never carry pan / scale / rotation values — only the Update '
          'events do.',
          style: TextStyle(color: polarNight, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 6 — SAMPLING TABLE
  // --------------------------------------------------------------------------
  // Twelve+ rows showing time, pan.dx, pan.dy, scale, rotation in degrees.
  // We hand-author the rows (not derived from the gallery, on purpose) so
  // the reader sees a longer, smoother gesture than the six gallery beats.
  // --------------------------------------------------------------------------

  final List<List<String>> samplingRows = [
    ['t', 'pan.dx', 'pan.dy', 'scale', 'rot deg'],
    ['16ms', '2.0', '0.0', '1.00', '0.0'],
    ['32ms', '8.0', '4.0', '1.05', '1.1'],
    ['48ms', '14.0', '8.0', '1.12', '2.9'],
    ['64ms', '20.0', '12.0', '1.30', '5.7'],
    ['80ms', '24.0', '16.0', '1.18', '-2.3'],
    ['96ms', '30.0', '20.0', '0.85', '-10.3'],
    ['112ms', '34.0', '22.0', '1.10', '4.6'],
    ['128ms', '40.0', '24.0', '1.50', '25.8'],
    ['144ms', '46.0', '27.0', '1.75', '34.4'],
    ['160ms', '52.0', '30.0', '2.00', '44.7'],
    ['176ms', '56.0', '32.0', '2.10', '49.1'],
    ['192ms', '60.0', '34.0', '2.20', '52.3'],
    ['208ms', '62.0', '35.0', '2.22', '53.0'],
  ];

  final List<Widget> samplingWidgets = [];
  for (int i = 0; i < samplingRows.length; i++) {
    final row = samplingRows[i];
    final bool isHeader = i == 0;
    samplingWidgets.add(_samplingRow(
      row,
      isHeader,
      isHeader ? crevasseBlue : (i.isOdd ? glacierMilk : glacierIce.withValues(alpha: 0.35)),
      isHeader ? glacierMilk : polarNight,
    ));
  }

  final Widget samplingTable = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6 — Sampling table',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Thirteen sampled rows from a longer trackpad gesture. Notice how '
          'pan.dx grows monotonically while scale and rotation oscillate as '
          'the user adjusts mid-gesture.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Column(children: samplingWidgets),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 7 — POINTER-KIND COMPARISON MATRIX
  // --------------------------------------------------------------------------
  // Touch / trackpad / mouse — which devices produce which event families.
  // --------------------------------------------------------------------------

  final Widget kindMatrix = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierIce.withValues(alpha: 0.55),
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7 — Pointer-kind comparison matrix',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Which device kinds emit which event families.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        _matrixRow(['kind', 'down/move/up', 'hover', 'panZoom', 'signal'],
            true, crevasseBlue, glacierMilk),
        _matrixRow(['touch', 'YES', 'no', 'no', 'no'], false, glacierMilk,
            polarNight),
        _matrixRow(['trackpad', 'click only', 'no', 'YES', 'YES (scroll)'],
            false, glacierIce.withValues(alpha: 0.35), polarNight),
        _matrixRow(['mouse', 'YES', 'YES', 'no', 'YES (scroll)'], false,
            glacierMilk, polarNight),
        _matrixRow(['stylus', 'YES', 'YES', 'no', 'no'], false,
            glacierIce.withValues(alpha: 0.35), polarNight),
        _matrixRow(['unknown', 'maybe', 'maybe', 'no', 'no'], false,
            glacierMilk, polarNight),
        SizedBox(height: 10),
        Text(
          'Only trackpads emit PointerPanZoomUpdateEvent. A two-finger drag '
          'on a touchscreen produces two parallel PointerMove streams instead.',
          style: TextStyle(color: polarNight, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 8 — COORDINATE-SPACE WALK
  // --------------------------------------------------------------------------
  // Visualizing position vs localPosition with a small diagram of two nested
  // rectangles plus a marker.
  // --------------------------------------------------------------------------

  final Widget coordinateWalk = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8 — Coordinate-space walk',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'position lives in the global coordinate system. localPosition lives '
          'in the local coordinate system of the receiving widget. They '
          'usually differ by a translation, but if the widget is rotated or '
          'scaled they differ by a full transform.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: glacierIce.withValues(alpha: 0.30),
            border: Border.all(color: crevasseBlue, width: 1.5),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 16,
                child: Text('global (0,0)',
                    style: TextStyle(
                        color: crevasseBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
              Positioned(
                left: 80,
                top: 50,
                child: Container(
                  width: 220,
                  height: 140,
                  decoration: BoxDecoration(
                    color: frostGold.withValues(alpha: 0.55),
                    border: Border.all(color: topazRust, width: 1.5),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 6,
                        top: 4,
                        child: Text('local (0,0) of receiving widget',
                            style: TextStyle(
                                color: topazRust,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      Positioned(
                        left: 110,
                        top: 70,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: berryRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 130,
                        top: 60,
                        child: Text('pointer',
                            style: TextStyle(
                                color: berryRed,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Example values for eventF (the finale):',
          style: TextStyle(
              color: polarNight, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('  position      = ${eventF.position}',
            style: TextStyle(color: polarNight, fontSize: 12)),
        Text('  localPosition = ${eventF.localPosition}',
            style: TextStyle(color: polarNight, fontSize: 12)),
        Text('  pan           = ${eventF.pan}',
            style: TextStyle(color: polarNight, fontSize: 12)),
        Text('  localPan      = ${eventF.localPan}',
            style: TextStyle(color: polarNight, fontSize: 12)),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 9 — PITFALLS / GOTCHAS
  // --------------------------------------------------------------------------
  // Six callout cards: each one a common mistake with a short prose fix.
  // --------------------------------------------------------------------------

  final List<Widget> pitfalls = [
    _pitfallCard(
      '1. mid-gesture device switch',
      'Do not assume `device` and `pointer` are constant across an entire '
          'pan/zoom run. They are constant within a start → update → end '
          'block, but a second trackpad on the same machine produces a '
          'parallel block with different identifiers.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
    _pitfallCard(
      '2. scale == 1.0 vs scale == 0',
      'A scale of 1.0 means no zoom (the identity). A scale of 0 means '
          '"the gesture has collapsed to a single point" and is rare in '
          'practice — but if you read scale and immediately divide by it '
          'to invert a zoom, you can crash on the rare 0 case. Guard with '
          'an epsilon.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
    _pitfallCard(
      '3. rotation is in radians',
      'rotation is measured in radians, not degrees. 0.5 rad ≈ 28.6 deg, '
          'NOT half a turn. To convert to degrees multiply by 180 / pi.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
    _pitfallCard(
      '4. cumulative pan, not delta',
      'pan is cumulative since the gesture start. panDelta is the change '
          'since the previous update. If you accidentally swap them you '
          'will get gestures that move many times faster than expected.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
    _pitfallCard(
      '5. local vs global confusion',
      'pan and panDelta are in the global coordinate space. localPan and '
          'localPanDelta have been transformed into the local space of the '
          'receiving widget. If your widget is rotated, applying the global '
          'pan directly will move the child in the wrong direction.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
    _pitfallCard(
      '6. no touchscreen pan-zoom',
      'A two-finger drag on a touchscreen does NOT produce '
          'PointerPanZoomUpdateEvent. It produces two simultaneous '
          'PointerMove streams. Use the gesture detector layer (e.g. '
          'ScaleGestureRecognizer) if you want a uniform abstraction across '
          'touch and trackpad.',
      topazRust,
      polarNight,
      glacierMilk,
    ),
  ];

  final Widget pitfallSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: topazRust, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9 — Pitfalls & gotchas',
          style: TextStyle(
            color: topazRust,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Six common mistakes, six short fixes. None of them require a '
          'StatefulWidget to demonstrate.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Column(children: pitfalls),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 10 — CODE-SNIPPET CARDS
  // --------------------------------------------------------------------------
  // Three canonical-usage cards. We render them as Text in a monospace-ish
  // family with a tinted background so they read as "code".
  // --------------------------------------------------------------------------

  final Widget snippetSection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierIce.withValues(alpha: 0.45),
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 10 — Canonical usage',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Three small Listener wirings that show how applications consume '
          'PointerPanZoomUpdateEvent.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        _codeCard(
          'A. Print every update',
          [
            'Listener(',
            '  onPointerPanZoomUpdate: (PointerPanZoomUpdateEvent e) {',
            '    print("pan=\${e.pan}  scale=\${e.scale}  rot=\${e.rotation}");',
            '  },',
            '  child: const SizedBox(width: 400, height: 300),',
            ')',
          ],
          polarNight,
          frostGold,
        ),
        _codeCard(
          'B. Apply transform to a child',
          [
            'final Matrix4 m = Matrix4.identity()',
            '  ..translate(e.pan.dx, e.pan.dy)',
            '  ..rotateZ(e.rotation)',
            '  ..scale(e.scale);',
            'return Transform(transform: m, child: const _MyCanvas());',
          ],
          polarNight,
          frostGold,
        ),
        _codeCard(
          'C. Distinguish from touch pinch',
          [
            'if (e.kind == PointerDeviceKind.trackpad) {',
            '  // Trackpad: pan/scale/rotation are already given.',
            '} else {',
            '  // Touch: derive from two PointerMove streams instead.',
            '}',
          ],
          polarNight,
          frostGold,
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 11 — GLOSSARY
  // --------------------------------------------------------------------------
  // Twelve+ terms, each as a row with term + definition.
  // --------------------------------------------------------------------------

  final List<List<String>> glossary = [
    ['pan',
        'Translation component of the gesture. Cumulative since gesture start.'],
    ['panDelta', 'Translation since the previous update event.'],
    ['scale',
        'Multiplicative zoom factor. 1.0 means no zoom. 2.0 means doubled.'],
    ['rotation', 'Rotation in radians since the gesture started.'],
    ['radian',
        'Angle unit equal to one arc length divided by the radius. ~57.3 deg.'],
    ['trackpad',
        'A flat surface that detects multi-finger gestures and reports them '
            'as single high-level events.'],
    ['pointer',
        'Stable identifier shared across the start/update/end sequence of a '
            'single gesture.'],
    ['device',
        'Identifier distinguishing physical devices when more than one is '
            'connected.'],
    ['kind',
        'PointerDeviceKind enum value. trackpad for these events.'],
    ['localPosition',
        'Pointer position transformed into the local coordinate space of '
            'the receiving widget.'],
    ['Listener',
        'Low-level Flutter widget that exposes raw pointer event callbacks '
            'including onPointerPanZoomUpdate.'],
    ['ScaleGestureRecognizer',
        'Higher-level gesture recognizer that produces a uniform '
            'pinch/scale/rotate stream from either touch or trackpad input.'],
    ['affine transform',
        'Translation + rotation + scale combined into a single matrix that '
            'preserves straight lines.'],
    ['epsilon',
        'A tiny positive number used to avoid divide-by-zero or false '
            'equality on floating-point values.'],
  ];

  final List<Widget> glossaryWidgets = [];
  for (int i = 0; i < glossary.length; i++) {
    final pair = glossary[i];
    glossaryWidgets.add(_glossaryRow(
      pair[0],
      pair[1],
      i.isOdd ? glacierMilk : glacierIce.withValues(alpha: 0.30),
      crevasseBlue,
      polarNight,
    ));
  }

  final Widget glossarySection = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: glacierMilk,
      border: Border.all(color: glacierShadow, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 11 — Glossary',
          style: TextStyle(
            color: crevasseBlue,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Fourteen terms covering the gesture vocabulary and its '
          'mathematical neighborhood.',
          style: TextStyle(
            color: moraineGrey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Column(children: glossaryWidgets),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 12 — RECAP FOOTER
  // --------------------------------------------------------------------------
  // A compact summary tying the whole notebook back to its theme.
  // --------------------------------------------------------------------------

  final Widget recapFooter = Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          crevasseBlue,
          polarNight,
        ],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECAP',
          style: TextStyle(
            color: topazHoney,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 4,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'PointerPanZoomUpdateEvent is the middle child of a three-event '
          'family produced exclusively by trackpads. Each instance carries '
          'a cumulative pan, a frame-local pan delta, a zoom scale, and a '
          'rotation in radians. We constructed six concrete instances, '
          'studied a longer thirteen-row sample, walked the coordinate '
          'spaces, surveyed six pitfalls, and indexed fourteen glossary '
          'terms. All without a single setState — the d4rt interpreter '
          'rendered the whole notebook from one snapshot of build().',
          style: TextStyle(color: glacierMilk, fontSize: 13, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'Glacial Topaz field notebook — end of file.',
          style: TextStyle(
            color: topazAmber,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // ASSEMBLY — pour every section into a SingleChildScrollView and ship.
  // --------------------------------------------------------------------------

  print('[assembly] composing 12 sections into the scaffold');
  print('[assembly] gallery has ${gallery.length} events');
  print('[assembly] sampling table has ${samplingRows.length - 1} data rows');
  print('[assembly] glossary has ${glossary.length} terms');

  final Widget body = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        titleBanner,
        anatomyCard,
        propertyPanel,
        constructionGallery,
        timelineSection,
        samplingTable,
        kindMatrix,
        coordinateWalk,
        pitfallSection,
        snippetSection,
        glossarySection,
        recapFooter,
      ],
    ),
  );

  print('[done] returning scaffold');

  return Scaffold(
    backgroundColor: glacierMilk,
    body: body,
  );
}

// =============================================================================
// HELPER FUNCTIONS — small, pure, self-contained.
// =============================================================================
//
// We keep these as top-level functions rather than methods because the d4rt
// interpreter prefers a flat function table, and because they are never
// reused outside this file.
//
// =============================================================================

Widget _swatch(Color color, String name, Color textColor) {
  return Container(
    width: 60,
    height: 36,
    margin: EdgeInsets.only(right: 4),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: Color(0xFF000000).withValues(alpha: 0.15)),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: textColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _bullet(String text, Color textColor, Color dotColor) {
  return Padding(
    padding: EdgeInsets.only(top: 6, bottom: 2, left: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 6, right: 8),
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 12, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _propertyRow(Color swatchColor, String name, String type,
    String description, Color textColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(top: 2, right: 10),
          decoration: BoxDecoration(
            color: swatchColor,
            border: Border.all(color: Color(0xFF000000).withValues(alpha: 0.2)),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            type,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontStyle: FontStyle.italic,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: textColor, fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _galleryCard(
    String title,
    PointerPanZoomUpdateEvent event,
    Color cardBg,
    Color border,
    Color titleColor,
    Color textColor,
    Color accent,
    Color metaColor) {
  final double rotDeg = event.rotation * 180.0 / 3.141592653589793;
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cardBg,
      border: Border.all(color: border, width: 1.0),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'event.toString():',
          style: TextStyle(
            color: metaColor,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 2),
        Text(
          event.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 8),
        Text(
          '  pan       = ${event.pan}',
          style: TextStyle(
              color: textColor, fontSize: 12, fontFamily: 'monospace'),
        ),
        Text(
          '  panDelta  = ${event.panDelta}',
          style: TextStyle(
              color: textColor, fontSize: 12, fontFamily: 'monospace'),
        ),
        Text(
          '  scale     = ${event.scale.toStringAsFixed(3)}',
          style: TextStyle(
              color: textColor, fontSize: 12, fontFamily: 'monospace'),
        ),
        Text(
          '  rotation  = ${event.rotation.toStringAsFixed(3)} rad  (${rotDeg.toStringAsFixed(1)} deg)',
          style: TextStyle(
              color: textColor, fontSize: 12, fontFamily: 'monospace'),
        ),
        Text(
          '  position  = ${event.position}',
          style: TextStyle(
              color: textColor, fontSize: 12, fontFamily: 'monospace'),
        ),
        Text(
          '  device=${event.device}  pointer=${event.pointer}  kind=${event.kind}  t=${event.timeStamp}',
          style: TextStyle(
              color: metaColor, fontSize: 11, fontFamily: 'monospace'),
        ),
      ],
    ),
  );
}

Widget _timelineBlock(
    String top, String bottom, Color color, Color textColor, bool emphasis) {
  return Container(
    width: 110,
    margin: EdgeInsets.only(right: 6),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
          color: Color(0xFF000000).withValues(alpha: 0.25),
          width: emphasis ? 1.5 : 0.8),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        Text(
          top,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          bottom,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _samplingRow(
    List<String> cells, bool isHeader, Color background, Color textColor) {
  final List<Widget> cellWidgets = [];
  for (int i = 0; i < cells.length; i++) {
    cellWidgets.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Text(
            cells[i],
            textAlign: i == 0 ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: isHeader ? FontWeight.w800 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  return Container(
    color: background,
    child: Row(children: cellWidgets),
  );
}

Widget _matrixRow(
    List<String> cells, bool isHeader, Color background, Color textColor) {
  final List<Widget> cellWidgets = [];
  for (int i = 0; i < cells.length; i++) {
    cellWidgets.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Text(
            cells[i],
            textAlign: i == 0 ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: isHeader ? FontWeight.w800 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  return Container(
    color: background,
    child: Row(children: cellWidgets),
  );
}

Widget _pitfallCard(String title, String body, Color border, Color textColor,
    Color background) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: background,
      border: Border(left: BorderSide(color: border, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: border,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(color: textColor, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _codeCard(
    String title, List<String> lines, Color textColor, Color background) {
  final List<Widget> lineWidgets = [];
  for (int i = 0; i < lines.length; i++) {
    lineWidgets.add(
      Text(
        lines[i],
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontFamily: 'monospace',
          height: 1.4,
        ),
      ),
    );
  }
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 8),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lineWidgets),
      ],
    ),
  );
}

Widget _glossaryRow(
    String term, String definition, Color background, Color termColor,
    Color defColor) {
  return Container(
    color: background,
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            term,
            style: TextStyle(
              color: termColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            definition,
            style: TextStyle(color: defColor, fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// END OF FILE — Glacial Topaz field notebook on PointerPanZoomUpdateEvent
// =============================================================================
