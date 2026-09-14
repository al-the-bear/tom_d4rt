// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
// LongPressDownDetails - Deep Visual Demo
// -----------------------------------------------------------------------------
// LongPressDownDetails is the immutable record handed to a
// GestureLongPressDownCallback - i.e. the onLongPressDown,
// onSecondaryLongPressDown and onTertiaryLongPressDown callbacks of a
// GestureDetector / LongPressGestureRecognizer. It is the "finger has just
// landed and a long-press recognizer has provisionally claimed the pointer"
// snapshot. It carries:
//
//   * globalPosition : Offset             - where the pointer touched, in
//                                           screen coordinates. Defaults to
//                                           Offset.zero when omitted.
//   * localPosition  : Offset             - where the pointer touched, in
//                                           the receiving widget's coordinate
//                                           space. Defaults to globalPosition
//                                           when omitted (NOT to Offset.zero).
//   * kind           : PointerDeviceKind? - the physical device kind that
//                                           produced the pointer (touch, mouse,
//                                           stylus, ...). Nullable - it may be
//                                           absent when the recognizer is
//                                           constructed synthetically.
//
// Constructor signature (verified against gestures_bridges.b.dart):
//
//   const LongPressDownDetails({
//     Offset globalPosition = Offset.zero,
//     Offset? localPosition,
//     PointerDeviceKind? kind,
//   })
//
// Lifecycle context: the long-press chain in a GestureDetector is
//
//   pointerDown
//     -> onLongPressDown          (LongPressDownDetails fires HERE)
//        ... timer running ...
//     -> onLongPressCancel        (if pointer moves/lifts before timeout)
//     OR
//     -> onLongPressStart         (LongPressStartDetails)
//     -> onLongPressMoveUpdate*   (LongPressMoveUpdateDetails)
//     -> onLongPressEnd           (LongPressEndDetails)
//     -> onLongPressUp            (no details)
//
// A note on the sibling types: DragDownDetails (the closest peer in
// gestures/drag_down_details_test.dart) does NOT carry `kind`; pointer kind
// surfaces on DragStartDetails for drags. LongPressDownDetails DOES carry kind
// because long-press recognizers often want to behave differently for stylus
// vs. touch vs. mouse already at the "landed" phase (e.g. mouse long-press is
// frequently treated as right-click on desktop platforms).
// =============================================================================

// A const sample record for the finger-canvas grid. Pure data, zero behaviour.
class _Finger {
  final String label;
  final String story;
  final Offset global;
  final Offset? local;
  final PointerDeviceKind? kind;
  final Color hue;
  final IconData icon;
  const _Finger({
    required this.label,
    required this.story,
    required this.global,
    required this.local,
    required this.kind,
    required this.hue,
    required this.icon,
  });
}

// A const data record for the gesture-chain flow boxes.
class _ChainBox {
  final String callback;
  final String detailsType;
  final String summary;
  final Color color;
  final bool highlighted;
  const _ChainBox({
    required this.callback,
    required this.detailsType,
    required this.summary,
    required this.color,
    this.highlighted = false,
  });
}

// A const data record for sibling-types comparison.
class _SiblingCard {
  final String type;
  final List<String> fields;
  final String unique;
  final Color tint;
  final IconData icon;
  const _SiblingCard({
    required this.type,
    required this.fields,
    required this.unique,
    required this.tint,
    required this.icon,
  });
}

// A const record for the kind-channel column in the kind cheat-sheet.
class _KindRow {
  final PointerDeviceKind? kind;
  final String label;
  final String typicalUse;
  final IconData icon;
  final Color tint;
  const _KindRow({
    required this.kind,
    required this.label,
    required this.typicalUse,
    required this.icon,
    required this.tint,
  });
}

dynamic build(BuildContext context) {
  print('================================================================');
  print('=== LongPressDownDetails: deep visual demo - build() executing =');
  print('================================================================');

  // Three reference instances we will use throughout the demo. These are the
  // canonical examples we print and visualise repeatedly.
  final dTouch = LongPressDownDetails(
    globalPosition: const Offset(150.0, 300.0),
    kind: PointerDeviceKind.touch,
  );
  final dMouse = LongPressDownDetails(
    globalPosition: const Offset(640.0, 220.0),
    localPosition: const Offset(40.0, 20.0),
    kind: PointerDeviceKind.mouse,
  );
  final dStylus = LongPressDownDetails(
    globalPosition: const Offset(420.0, 510.0),
    localPosition: const Offset(120.0, 110.0),
    kind: PointerDeviceKind.stylus,
  );
  final dDefault = LongPressDownDetails(
    globalPosition: const Offset(0.0, 0.0),
    localPosition: const Offset(0.0, 0.0),
  );

  print('dTouch  global=${dTouch.globalPosition}  local=${dTouch.localPosition}  kind=${dTouch.kind}');
  print('dMouse  global=${dMouse.globalPosition}  local=${dMouse.localPosition}  kind=${dMouse.kind}');
  print('dStylus global=${dStylus.globalPosition} local=${dStylus.localPosition} kind=${dStylus.kind}');
  print('dDefault global=${dDefault.globalPosition} local=${dDefault.localPosition} kind=${dDefault.kind}');
  print('Note: dDefault.kind is null - kind is a nullable PointerDeviceKind.');
  print('Note: when localPosition is omitted it DEFAULTS TO globalPosition,');
  print('      not to Offset.zero. This is a frequent source of confusion.');

  // ---------------------------------------------------------------------------
  // SECTION 1 - HERO HEADER
  // ---------------------------------------------------------------------------
  // The hero is the canonical "title card" of the demo. It announces the type
  // under inspection and gives a one-line tagline. Visually it is a wide bar
  // with a multi-stop gradient and a subtle inner highlight.
  // ---------------------------------------------------------------------------
  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF311B92), // deep purple
          Color(0xFF512DA8),
          Color(0xFF7E57C2),
          Color(0xFFB39DDB),
        ],
        stops: <double>[0.0, 0.45, 0.8, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55311B92),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33FFFFFF),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'LongPressDownDetails',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Where the finger first lands when a long-press recognizer wakes up.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroBadge('package:flutter/gestures.dart', Colors.white),
            _heroBadge('immutable', const Color(0xFFE1BEE7)),
            _heroBadge('GestureLongPressDownCallback', const Color(0xFFCE93D8)),
            _heroBadge('phase: pointer-down', const Color(0xFFB39DDB)),
            _heroBadge('kind: nullable', const Color(0xFFFFAB91)),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2 - ANATOMY DIAGRAM
  // ---------------------------------------------------------------------------
  // The anatomy is a row of three "field boxes", each annotated with the type,
  // the default behaviour, and a one-line story. This is the part of the demo
  // a reader should stare at when they want to *understand* the type.
  // ---------------------------------------------------------------------------
  final Widget anatomy = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF3E5F5)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFCE93D8), width: 1.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 2 - Anatomy',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The three immutable fields carried by every LongPressDownDetails instance.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyField(
                name: 'globalPosition',
                type: 'Offset',
                defaultText: 'Offset.zero',
                story:
                    'Where the pointer touched, in SCREEN coordinates. This is what you would feed to `Overlay`/`showMenu` to position UI relative to the device window.',
                color: const Color(0xFF7E57C2),
                icon: Icons.public,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _anatomyField(
                name: 'localPosition',
                type: 'Offset',
                defaultText: 'globalPosition',
                story:
                    'Where the pointer touched, in the RECEIVING widget`s coordinate space. Defaults to globalPosition (NOT zero) when omitted - a constructor-level fallback.',
                color: const Color(0xFF26A69A),
                icon: Icons.crop_free,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _anatomyField(
                name: 'kind',
                type: 'PointerDeviceKind?',
                defaultText: 'null',
                story:
                    'The physical device kind: touch, mouse, stylus, trackpad, invertedStylus, unknown. Nullable - synthetic recognisers and tests may omit it.',
                color: const Color(0xFFEF6C00),
                icon: Icons.devices_other,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3 - CONSTRUCTOR SIGNATURE CARD
  // ---------------------------------------------------------------------------
  final Widget signatureCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF263238), Color(0xFF37474F), Color(0xFF455A64)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x44000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: Color(0x22FFFFFF),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.code, color: Color(0xFFFFD54F), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Section 3 - Constructor Signature',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFF455A64)),
          ),
          child: const Text(
            'const LongPressDownDetails({\n'
            '  Offset globalPosition = Offset.zero,\n'
            '  Offset? localPosition,\n'
            '  PointerDeviceKind? kind,\n'
            '})',
            style: TextStyle(
              color: Color(0xFFB2EBF2),
              fontFamily: 'monospace',
              fontSize: 14.0,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Verified against gestures_bridges.b.dart - constructorSignatures map.',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4 - SAMPLE GRID (faux finger/cursor on a coordinate canvas)
  // ---------------------------------------------------------------------------
  // We construct a list of >= 6 LongPressDownDetails samples and draw each one
  // as a coloured "finger dot" on a miniature 320x180 canvas, with axis ticks
  // and a coordinate label.
  // ---------------------------------------------------------------------------
  const List<_Finger> fingers = <_Finger>[
    _Finger(
      label: 'Touch / centre',
      story: 'Phone, finger landed near the middle of the screen.',
      global: Offset(160.0, 90.0),
      local: Offset(160.0, 90.0),
      kind: PointerDeviceKind.touch,
      hue: Color(0xFF7E57C2),
      icon: Icons.fingerprint,
    ),
    _Finger(
      label: 'Mouse / desktop',
      story: 'Right-click pending: long mouse press over a list row.',
      global: Offset(280.0, 30.0),
      local: Offset(40.0, 12.0),
      kind: PointerDeviceKind.mouse,
      hue: Color(0xFF1E88E5),
      icon: Icons.mouse,
    ),
    _Finger(
      label: 'Stylus / artboard',
      story: 'Pen tip touched the canvas; about to begin a draw stroke.',
      global: Offset(60.0, 140.0),
      local: Offset(60.0, 60.0),
      kind: PointerDeviceKind.stylus,
      hue: Color(0xFFEF6C00),
      icon: Icons.edit,
    ),
    _Finger(
      label: 'Touch / corner',
      story: 'Reachable-thumb landing zone, bottom-right corner.',
      global: Offset(305.0, 165.0),
      local: Offset(45.0, 25.0),
      kind: PointerDeviceKind.touch,
      hue: Color(0xFF26A69A),
      icon: Icons.touch_app,
    ),
    _Finger(
      label: 'Trackpad / scroll',
      story: 'Trackpad force-press; rare but valid.',
      global: Offset(120.0, 60.0),
      local: Offset(120.0, 60.0),
      kind: PointerDeviceKind.trackpad,
      hue: Color(0xFFC2185B),
      icon: Icons.swipe,
    ),
    _Finger(
      label: 'Unknown kind (null)',
      story: 'Synthetic recogniser - kind is null. Defensive code required.',
      global: Offset(220.0, 120.0),
      local: Offset(80.0, 40.0),
      kind: null,
      hue: Color(0xFF6D4C41),
      icon: Icons.help_outline,
    ),
    _Finger(
      label: 'Inverted stylus',
      story: 'Eraser-end of a stylus - PointerDeviceKind.invertedStylus.',
      global: Offset(40.0, 30.0),
      local: Offset(40.0, 30.0),
      kind: PointerDeviceKind.invertedStylus,
      hue: Color(0xFF8E24AA),
      icon: Icons.auto_fix_off,
    ),
    _Finger(
      label: 'Touch / origin default',
      story: 'No args - globalPosition defaults to Offset.zero.',
      global: Offset(0.0, 0.0),
      local: Offset(0.0, 0.0),
      kind: null,
      hue: Color(0xFF455A64),
      icon: Icons.adjust,
    ),
  ];

  final List<Widget> fingerCards = <Widget>[];
  for (final _Finger f in fingers) {
    final LongPressDownDetails sample = LongPressDownDetails(
      globalPosition: f.global,
      localPosition: f.local,
      kind: f.kind,
    );
    print(
      'Sample "${f.label}": global=${sample.globalPosition} '
      'local=${sample.localPosition} kind=${sample.kind}',
    );
    fingerCards.add(_fingerCard(f, sample));
  }
  print('Built ${fingerCards.length} sample finger cards.');

  final Widget sampleGridSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 4 - Sample Grid',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Eight LongPressDownDetails instances rendered on a faux coordinate canvas.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: fingerCards,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5 - LIFECYCLE FLOW (LongPressGestureRecognizer)
  // ---------------------------------------------------------------------------
  // We highlight the box where LongPressDownDetails fires.
  // ---------------------------------------------------------------------------
  const List<_ChainBox> chain = <_ChainBox>[
    _ChainBox(
      callback: 'pointerDown',
      detailsType: 'PointerDownEvent',
      summary: 'Raw pointer phase. Recognisers receive the event and decide whether to claim the arena.',
      color: Color(0xFF90A4AE),
    ),
    _ChainBox(
      callback: 'onLongPressDown',
      detailsType: 'LongPressDownDetails',
      summary: 'Long-press recogniser provisionally accepted the pointer. THIS is where LongPressDownDetails fires.',
      color: Color(0xFF7E57C2),
      highlighted: true,
    ),
    _ChainBox(
      callback: 'onLongPressCancel',
      detailsType: '(no details)',
      summary: 'Pointer moved too far OR lifted before the long-press timeout - the recogniser bails.',
      color: Color(0xFFE57373),
    ),
    _ChainBox(
      callback: 'onLongPressStart',
      detailsType: 'LongPressStartDetails',
      summary: 'Timeout elapsed; the long-press is now FORMALLY recognised. carries globalPosition + localPosition.',
      color: Color(0xFF66BB6A),
    ),
    _ChainBox(
      callback: 'onLongPressMoveUpdate',
      detailsType: 'LongPressMoveUpdateDetails',
      summary: 'Pointer moves WHILE the long-press is held - drag-after-hold patterns live here.',
      color: Color(0xFF26A69A),
    ),
    _ChainBox(
      callback: 'onLongPressEnd',
      detailsType: 'LongPressEndDetails',
      summary: 'Pointer lifted; carries velocity for fling-after-hold gestures.',
      color: Color(0xFF42A5F5),
    ),
    _ChainBox(
      callback: 'onLongPressUp',
      detailsType: '(no details)',
      summary: 'Companion to onLongPressEnd, kept for backwards-compatibility. Fires AFTER onLongPressEnd.',
      color: Color(0xFF9575CD),
    ),
  ];

  final Widget lifecycleSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFE0B2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFFB74D), width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33FFB74D),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 5 - LongPressGestureRecognizer Lifecycle',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The horizontal flow below highlights the exact moment LongPressDownDetails surfaces.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < chain.length; i++) ...<Widget>[
                _chainBoxWidget(chain[i]),
                if (i < chain.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 60.0),
                    child: Icon(Icons.arrow_forward, color: Color(0xFFE65100)),
                  ),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6 - SIBLING COMPARISON TABLE
  // ---------------------------------------------------------------------------
  const List<_SiblingCard> siblings = <_SiblingCard>[
    _SiblingCard(
      type: 'LongPressDownDetails',
      fields: <String>['globalPosition', 'localPosition', 'kind'],
      unique: 'Carries `kind` already at down-phase. localPosition defaults to globalPosition.',
      tint: Color(0xFF7E57C2),
      icon: Icons.touch_app,
    ),
    _SiblingCard(
      type: 'DragDownDetails',
      fields: <String>['globalPosition', 'localPosition'],
      unique: 'No `kind`. Pointer kind is reported on DragStartDetails instead.',
      tint: Color(0xFF26A69A),
      icon: Icons.pan_tool,
    ),
    _SiblingCard(
      type: 'TapDownDetails',
      fields: <String>['globalPosition', 'localPosition', 'kind'],
      unique: 'Same shape as LongPressDownDetails - kind is also a PointerDeviceKind (NON-nullable since 3.x).',
      tint: Color(0xFF1E88E5),
      icon: Icons.touch_app,
    ),
    _SiblingCard(
      type: 'LongPressStartDetails',
      fields: <String>['globalPosition', 'localPosition'],
      unique: 'Fires AFTER the timeout. No `kind` field - by then the recogniser has accepted the arena.',
      tint: Color(0xFF66BB6A),
      icon: Icons.start,
    ),
  ];

  final List<Widget> siblingCards = siblings.map(_siblingCardWidget).toList();

  final Widget comparisonSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF64B5F6)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x3364B5F6),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 6 - Sibling Comparison',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'How LongPressDownDetails compares to its closest details siblings.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: siblingCards,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7 - REAL-WORLD RECIPES (3 mini scenarios)
  // ---------------------------------------------------------------------------
  final Widget recipeContextMenu = _recipeCard(
    title: 'Recipe 1 - Context Menu at the Finger',
    intro:
        'Use globalPosition from LongPressDownDetails to anchor a context menu next to the finger. localPosition is irrelevant here because the menu lives in the Overlay, which uses screen coordinates.',
    code:
        'onLongPressDown: (LongPressDownDetails d) {\n'
        '  showMenu(\n'
        '    context: context,\n'
        '    position: RelativeRect.fromLTRB(\n'
        '      d.globalPosition.dx,\n'
        '      d.globalPosition.dy,\n'
        '      d.globalPosition.dx,\n'
        '      d.globalPosition.dy,\n'
        '    ),\n'
        '    items: <PopupMenuEntry<String>>[\n'
        '      PopupMenuItem(value: "copy", child: Text("Copy")),\n'
        '      PopupMenuItem(value: "delete", child: Text("Delete")),\n'
        '    ],\n'
        '  );\n'
        '},',
    accent: const Color(0xFF7E57C2),
    icon: Icons.menu_open,
    mock: _mockContextMenu(dTouch),
  );

  final Widget recipeReorder = _recipeCard(
    title: 'Recipe 2 - Drag-to-Reorder Begin',
    intro:
        'In a ReorderableListView the long-press is the gateway to reorder. Use onLongPressDown to capture the START tile (and lift it visually), then onLongPressMoveUpdate to drag it.',
    code:
        'onLongPressDown: (LongPressDownDetails d) {\n'
        '  // Convert localPosition to a row index in the list.\n'
        '  final int row = (d.localPosition.dy / kRowHeight).floor();\n'
        '  reorderController.beginReorder(row);\n'
        '  print("Begin reorder at row=" + row.toString());\n'
        '},',
    accent: const Color(0xFF26A69A),
    icon: Icons.drag_indicator,
    mock: _mockReorderTiles(dStylus),
  );

  final Widget recipeImagePreview = _recipeCard(
    title: 'Recipe 3 - Image Preview Pop-up',
    intro:
        'Pinterest-style preview: long-press an image thumbnail to reveal an enlarged version. Use globalPosition to centre the preview, and inspect kind so that mouse long-press can fall back to right-click semantics.',
    code:
        'onLongPressDown: (LongPressDownDetails d) {\n'
        '  if (d.kind == PointerDeviceKind.mouse) {\n'
        '    // mouse: defer to right-click handler instead.\n'
        '    return;\n'
        '  }\n'
        '  imagePreviewController.showAt(d.globalPosition);\n'
        '},',
    accent: const Color(0xFFEF6C00),
    icon: Icons.image_search,
    mock: _mockImagePreview(dMouse),
  );

  final Widget recipesSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFFF3E0)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFFCC80)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33FFCC80),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 7 - Real-world Recipes',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Three concrete patterns where LongPressDownDetails is the load-bearing argument.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        recipeContextMenu,
        const SizedBox(height: 14.0),
        recipeReorder,
        const SizedBox(height: 14.0),
        recipeImagePreview,
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8 - COORDINATE CHEAT-SHEET (global vs local) & KIND CHANNEL
  // ---------------------------------------------------------------------------
  const List<_KindRow> kindRows = <_KindRow>[
    _KindRow(
      kind: PointerDeviceKind.touch,
      label: 'touch',
      typicalUse: 'Phone / tablet finger. Default on mobile.',
      icon: Icons.fingerprint,
      tint: Color(0xFF7E57C2),
    ),
    _KindRow(
      kind: PointerDeviceKind.mouse,
      label: 'mouse',
      typicalUse: 'Desktop / web. Long-press here often == right-click.',
      icon: Icons.mouse,
      tint: Color(0xFF1E88E5),
    ),
    _KindRow(
      kind: PointerDeviceKind.stylus,
      label: 'stylus',
      typicalUse: 'Pen tip. Pressure-sensitive drawing flows.',
      icon: Icons.edit,
      tint: Color(0xFFEF6C00),
    ),
    _KindRow(
      kind: PointerDeviceKind.invertedStylus,
      label: 'invertedStylus',
      typicalUse: 'Eraser-end of a stylus.',
      icon: Icons.auto_fix_off,
      tint: Color(0xFF8E24AA),
    ),
    _KindRow(
      kind: PointerDeviceKind.trackpad,
      label: 'trackpad',
      typicalUse: 'Multi-finger trackpad gesture (rare for long-press).',
      icon: Icons.swipe,
      tint: Color(0xFFC2185B),
    ),
    _KindRow(
      kind: PointerDeviceKind.unknown,
      label: 'unknown',
      typicalUse: 'Pointer kind could not be determined.',
      icon: Icons.help_outline,
      tint: Color(0xFF6D4C41),
    ),
    _KindRow(
      kind: null,
      label: 'null',
      typicalUse: 'Field omitted - synthetic recognisers and tests.',
      icon: Icons.block,
      tint: Color(0xFF455A64),
    ),
  ];

  final Widget cheatSheetSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF4DD0E1)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x334DD0E1),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 8 - Coordinate Cheat-sheet & Kind Channel',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Global vs Local coordinates and a one-line guide for every PointerDeviceKind value.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _coordinateCard(
                title: 'globalPosition',
                subtitle: 'Screen coordinates',
                bullets: const <String>[
                  'Origin: top-left of the device window.',
                  'Independent of where in the widget tree the recogniser lives.',
                  'Use for Overlay positioning, showMenu, full-screen ripples.',
                ],
                accent: const Color(0xFF00838F),
                icon: Icons.public,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _coordinateCard(
                title: 'localPosition',
                subtitle: 'Receiving widget`s coords',
                bullets: const <String>[
                  'Origin: top-left of the RenderBox attached to the recogniser.',
                  'Defaults to globalPosition (NOT zero) when not provided.',
                  'Use for hit-testing inside the widget, tile-index math.',
                ],
                accent: const Color(0xFF00695C),
                icon: Icons.crop_free,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFF80DEEA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'PointerDeviceKind channel',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF006064),
                ),
              ),
              const SizedBox(height: 8.0),
              for (final _KindRow row in kindRows) _kindRowWidget(row),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9 - PITFALLS & GOTCHAS
  // ---------------------------------------------------------------------------
  final Widget pitfallsSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFEF9A9A)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33EF9A9A),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Section 9 - Pitfalls',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Common mistakes when consuming a LongPressDownDetails value.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        _pitfall(
          number: 1,
          headline: 'kind is NULLABLE',
          body:
              'Always handle the null branch. Code like `details.kind == PointerDeviceKind.mouse` is fine, but `switch (details.kind!)` will explode for synthetic recognisers and integration tests.',
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          number: 2,
          headline: 'localPosition without a RenderBox',
          body:
              'localPosition is meaningful relative to the RenderBox of the widget that owns the recogniser. If you reach into a globally-positioned overlay, prefer globalPosition - localPosition will be misleading.',
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          number: 3,
          headline: 'Down does NOT mean recognised',
          body:
              'onLongPressDown fires when the recogniser PROVISIONALLY accepts the pointer. The press may still be cancelled (onLongPressCancel) before onLongPressStart. Don`t commit destructive UI here.',
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          number: 4,
          headline: 'localPosition default is NOT Offset.zero',
          body:
              'Omitting localPosition makes it equal to globalPosition - this differs from "default constructor zero" and is easy to miss when you build details by hand for a unit test.',
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          number: 5,
          headline: 'Don`t confuse with TapDownDetails',
          body:
              'Tap and long-press both have a `kind`, but TapDownDetails.kind is non-nullable in modern Flutter while LongPressDownDetails.kind remains nullable. Don`t copy-paste callbacks blindly.',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10 - FOOTER (file path + ASCII box)
  // ---------------------------------------------------------------------------
  const String footerAscii =
      '+--------------------------------------------------------------+\n'
      '|  LongPressDownDetails - hand-authored deep visual demo       |\n'
      '|  Constructor: LongPressDownDetails(                          |\n'
      '|    {Offset globalPosition = Offset.zero,                     |\n'
      '|     Offset? localPosition,                                   |\n'
      '|     PointerDeviceKind? kind})                                |\n'
      '|  package: package:flutter/gestures.dart                      |\n'
      '|  callback: GestureLongPressDownCallback                      |\n'
      '+--------------------------------------------------------------+';

  final Widget footer = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1B1B1B), Color(0xFF2E2E2E), Color(0xFF424242)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'File',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 12.0,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 4.0),
        SelectableText(
          'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
          'send_ast_via_http_scripts/gestures/long_press_down_details_test.dart',
          style: TextStyle(
            color: Color(0xFFFFD54F),
            fontSize: 13.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          footerAscii,
          style: TextStyle(
            color: Color(0xFFB2EBF2),
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  print('=== LongPressDownDetails deep demo build complete ===');

  return SingleChildScrollView(
    child: Container(
      color: const Color(0xFFFAFAFA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          anatomy,
          signatureCard,
          sampleGridSection,
          lifecycleSection,
          comparisonSection,
          recipesSection,
          cheatSheetSection,
          pitfallsSection,
          footer,
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// =============================================================================
// HELPERS - small widget-builder functions used by build().
// They live at file scope so the build() function stays readable.
// =============================================================================

Widget _heroBadge(String text, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: tint.withOpacity(0.6)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withOpacity(0.25),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        color: tint,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _anatomyField({
  required String name,
  required String type,
  required String defaultText,
  required String story,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          color.withOpacity(0.08),
          color.withOpacity(0.18),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.25),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'type: $type',
            style: TextStyle(
              fontSize: 11.0,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'default: $defaultText',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.black54,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          story,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _fingerCard(_Finger f, LongPressDownDetails sample) {
  // The mini canvas is a 320x180 box; we map the global Offset onto the canvas
  // using simple clamping. The faux finger is a coloured circle with shadow.
  const double canvasW = 320.0;
  const double canvasH = 180.0;
  final double dotX = sample.globalPosition.dx.clamp(0.0, canvasW - 24.0).toDouble();
  final double dotY = sample.globalPosition.dy.clamp(0.0, canvasH - 24.0).toDouble();

  return Container(
    width: 340.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          f.hue.withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: f.hue, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: f.hue.withOpacity(0.22),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(f.icon, color: f.hue, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                f.label,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: f.hue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          f.story,
          style: const TextStyle(fontSize: 11.5, color: Colors.black87, height: 1.3),
        ),
        const SizedBox(height: 10.0),
        // Canvas
        Container(
          width: canvasW,
          height: canvasH,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: Stack(
            children: <Widget>[
              // Grid lines (every 40px horizontally / 30px vertically).
              for (int gx = 40; gx < canvasW.toInt(); gx += 40)
                Positioned(
                  left: gx.toDouble(),
                  top: 0.0,
                  bottom: 0.0,
                  child: Container(width: 1.0, color: Colors.black.withOpacity(0.05)),
                ),
              for (int gy = 30; gy < canvasH.toInt(); gy += 30)
                Positioned(
                  top: gy.toDouble(),
                  left: 0.0,
                  right: 0.0,
                  child: Container(height: 1.0, color: Colors.black.withOpacity(0.05)),
                ),
              // Origin marker
              Positioned(
                left: 0.0,
                top: 0.0,
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Finger dot
              Positioned(
                left: dotX,
                top: dotY,
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: f.hue,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: f.hue.withOpacity(0.55),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Icon(f.icon, color: Colors.white, size: 14.0),
                ),
              ),
              // Coordinate label
              Positioned(
                right: 6.0,
                bottom: 6.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'g=(${sample.globalPosition.dx.toStringAsFixed(0)},${sample.globalPosition.dy.toStringAsFixed(0)})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 4.0,
          children: <Widget>[
            _miniChip('global=${sample.globalPosition}', f.hue),
            _miniChip('local=${sample.localPosition}', f.hue),
            _miniChip('kind=${sample.kind ?? 'null'}', f.hue),
          ],
        ),
      ],
    ),
  );
}

Widget _miniChip(String text, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.15),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: tint.withOpacity(0.6)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        color: tint,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _chainBoxWidget(_ChainBox c) {
  return Container(
    width: 200.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          c.color.withOpacity(c.highlighted ? 0.55 : 0.25),
          c.color.withOpacity(c.highlighted ? 0.85 : 0.45),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: c.color,
        width: c.highlighted ? 3.0 : 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: c.color.withOpacity(c.highlighted ? 0.65 : 0.25),
          blurRadius: c.highlighted ? 18.0 : 6.0,
          spreadRadius: c.highlighted ? 1.0 : 0.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (c.highlighted)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: c.color),
            ),
            child: Text(
              'YOU ARE HERE',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: c.color,
                letterSpacing: 1.2,
              ),
            ),
          ),
        if (c.highlighted) const SizedBox(height: 6.0),
        Text(
          c.callback,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: c.highlighted ? Colors.white : Colors.black87,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          c.detailsType,
          style: TextStyle(
            fontSize: 11.0,
            color: c.highlighted ? Colors.white70 : Colors.black54,
            fontFamily: 'monospace',
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          c.summary,
          style: TextStyle(
            fontSize: 11.0,
            color: c.highlighted ? Colors.white : Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _siblingCardWidget(_SiblingCard s) {
  return Container(
    width: 280.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          s.tint.withOpacity(0.15),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: s.tint, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: s.tint.withOpacity(0.25),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(s.icon, color: s.tint, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                s.type,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: s.tint,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'fields:',
          style: TextStyle(
            fontSize: 11.0,
            color: s.tint,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: s.fields.map((String f) => _miniChip(f, s.tint)).toList(),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: s.tint.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            s.unique,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required String intro,
  required String code,
  required Color accent,
  required IconData icon,
  required Widget mock,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          accent.withOpacity(0.12),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.6)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.22),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          intro,
          style: const TextStyle(
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1B1B),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFF455A64)),
                ),
                child: Text(
                  code,
                  style: const TextStyle(
                    color: Color(0xFFB2EBF2),
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    height: 1.45,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              flex: 2,
              child: mock,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _mockContextMenu(LongPressDownDetails d) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFF7E57C2)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x447E57C2),
          blurRadius: 10.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xFFEDE7F6),
          child: Text(
            'Anchor: ${d.globalPosition}',
            style: const TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
          ),
        ),
        const SizedBox(height: 6.0),
        _menuItem(Icons.content_copy, 'Copy'),
        _menuItem(Icons.share, 'Share'),
        _menuItem(Icons.delete_outline, 'Delete'),
      ],
    ),
  );
}

Widget _menuItem(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 16.0, color: const Color(0xFF7E57C2)),
        const SizedBox(width: 8.0),
        Text(label, style: const TextStyle(fontSize: 12.0)),
      ],
    ),
  );
}

Widget _mockReorderTiles(LongPressDownDetails d) {
  const double rowHeight = 24.0;
  final int liftedRow = (d.localPosition.dy / rowHeight).floor().clamp(0, 4);
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFF26A69A)),
    ),
    child: Column(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          Container(
            height: rowHeight,
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              color: i == liftedRow
                  ? const Color(0xFFB2DFDB)
                  : const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: i == liftedRow
                    ? const Color(0xFF00796B)
                    : Colors.transparent,
                width: i == liftedRow ? 2.0 : 1.0,
              ),
              boxShadow: i == liftedRow
                  ? const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x4400796B),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.drag_handle, size: 14.0, color: Color(0xFF00695C)),
                const SizedBox(width: 6.0),
                Text(
                  'Item ${i + 1}',
                  style: const TextStyle(fontSize: 11.0),
                ),
                if (i == liftedRow) ...<Widget>[
                  const Spacer(),
                  const Text(
                    'lifted',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _mockImagePreview(LongPressDownDetails d) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFEF6C00)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFFB74D), Color(0xFFE65100)],
            ),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66E65100),
                blurRadius: 12.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.image, size: 36.0, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'kind=${d.kind ?? 'null'}',
          style: const TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
        ),
        Text(
          d.kind == PointerDeviceKind.mouse ? 'Will defer to right-click' : 'Will preview at ${d.globalPosition}',
          style: const TextStyle(fontSize: 10.0, color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _coordinateCard({
  required String title,
  required String subtitle,
  required List<String> bullets,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          accent.withOpacity(0.10),
        ],
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11.0, color: Colors.black54, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8.0),
        for (final String b in bullets)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.chevron_right, size: 14.0, color: accent),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(fontSize: 11.5, color: Colors.black87, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _kindRowWidget(_KindRow row) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: row.tint.withOpacity(0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: row.tint.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(row.icon, color: row.tint, size: 16.0),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 110.0,
          child: Text(
            row.label,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: row.tint,
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.typicalUse,
            style: const TextStyle(fontSize: 11.5, color: Colors.black87, height: 1.3),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required int number,
  required String headline,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFEF9A9A)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33EF9A9A),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          decoration: const BoxDecoration(
            color: Color(0xFFB71C1C),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
