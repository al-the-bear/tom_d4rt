// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
//
// =====================================================================
// SerialTapDownDetails — Deep Demo (Morse-Tap / Telegraph Edition)
// =====================================================================
//
// SerialTapDownDetails is the payload delivered to
// SerialTapGestureRecognizer.onSerialTapDown when the user begins a
// tap that is part of an ongoing serial sequence (single, double,
// triple, quadruple, …). The "count" field is the discriminator that
// tells you which tap of the run we are currently on; the rest of the
// fields locate the contact and describe the input device.
//
// Fields reviewed in this demo:
//   * globalPosition  : Offset — coordinates in the screen's frame.
//   * localPosition   : Offset — coordinates inside the receiving box.
//   * kind            : PointerDeviceKind — touch, mouse, stylus, …
//   * count           : int — 1=first tap, 2=second tap, 3=third, …
//   * buttons         : int — bitmask of pressed mouse / contact bits.
//
// Theme: morse-tap / telegraph keys. Colors evoke worn copper, brushed
// charcoal, vintage cream paper, the orange spark of the contact, the
// signal-green of an indicator lamp, and the lacquer-red of a STOP key.
// =====================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------
// Color palette — morse-tap / telegraph
// ---------------------------------------------------------------------
const Color kCopper = Color(0xFFB87333);
const Color kCopperDark = Color(0xFF7A4A1F);
const Color kCharcoal = Color(0xFF2A2A2C);
const Color kCharcoalSoft = Color(0xFF45464A);
const Color kCream = Color(0xFFF6ECD2);
const Color kCreamDeep = Color(0xFFE7D9B0);
const Color kAmberSpark = Color(0xFFFFB347);
const Color kSignalGreen = Color(0xFF3FA34D);
const Color kLacquerRed = Color(0xFFB8232F);
const Color kInkBlue = Color(0xFF1F3A5F);
const Color kBrass = Color(0xFFC9A96E);
const Color kShadow = Color(0xFF111111);

// ---------------------------------------------------------------------
// Helper: pretty-print a SerialTapDownDetails to console.
// ---------------------------------------------------------------------
void _dumpDetails(String label, SerialTapDownDetails d) {
  print('--- $label ---');
  print('  runtimeType   : ${d.runtimeType}');
  print('  globalPosition: ${d.globalPosition}');
  print('  localPosition : ${d.localPosition}');
  print('  kind          : ${d.kind}');
  print('  count         : ${d.count}');
  print('  buttons       : 0x${d.buttons.toRadixString(16)}');
}

// ---------------------------------------------------------------------
// Helper: build a small framed card with a title and a body widget.
// ---------------------------------------------------------------------
Widget _frame({
  required String title,
  required Widget body,
  Color border = kCopper,
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
            color: kCharcoal,
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
// Helper: a small pill / chip with a label.
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
// Helper: divider styled as a telegraph wire.
// ---------------------------------------------------------------------
Widget _wire() {
  return Container(
    height: 2,
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [kCopperDark, kCopper, kAmberSpark, kCopper, kCopperDark],
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a tap-key icon (stack of circles), colored by count.
// ---------------------------------------------------------------------
Widget _tapKey(int count) {
  final Color cap;
  if (count == 1) {
    cap = kBrass;
  } else if (count == 2) {
    cap = kCopper;
  } else if (count == 3) {
    cap = kAmberSpark;
  } else if (count == 4) {
    cap = kSignalGreen;
  } else {
    cap = kLacquerRed;
  }
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [cap, kCopperDark],
        center: const Alignment(-0.3, -0.3),
        radius: 0.9,
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
// Helper: build a labeled field row "name : value".
// ---------------------------------------------------------------------
Widget _field(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: const TextStyle(
              color: kCharcoalSoft,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kCharcoal,
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
// Helper: a small section header.
// ---------------------------------------------------------------------
Widget _sectionHeader(int n, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kCharcoal, kCharcoalSoft],
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
            color: kCopper,
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
                  color: kBrass,
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

// =====================================================================
// build()
// =====================================================================
dynamic build(BuildContext context) {
  print('=====================================================');
  print(' SerialTapDownDetails — DEEP DEMO (telegraph edition)');
  print('=====================================================');

  // -------------------------------------------------------------------
  // SECTION 0 — Anchor instance
  // -------------------------------------------------------------------
  print('\n[Section 0] Anchor instance');
  print('Constructing the canonical SerialTapDownDetails…');
  final SerialTapDownDetails anchor = SerialTapDownDetails(
    globalPosition: const Offset(120, 80),
    localPosition: const Offset(40, 30),
    kind: PointerDeviceKind.mouse,
    count: 2,
    buttons: kPrimaryMouseButton,
  );
  _dumpDetails('anchor', anchor);

  // Identical-args twin to discuss equality semantics.
  final SerialTapDownDetails anchorTwin = SerialTapDownDetails(
    globalPosition: const Offset(120, 80),
    localPosition: const Offset(40, 30),
    kind: PointerDeviceKind.mouse,
    count: 2,
    buttons: kPrimaryMouseButton,
  );
  print('anchor == anchorTwin (identity)   : ${identical(anchor, anchorTwin)}');
  print('anchor == anchorTwin (== operator): ${anchor == anchorTwin}');
  print('anchor.runtimeType == twin.runtime: '
      '${anchor.runtimeType == anchorTwin.runtimeType}');
  print('Note: SerialTapDownDetails does not override == — two instances');
  print('      with identical fields are still distinct Dart objects.');

  // -------------------------------------------------------------------
  // SECTION 3 — Gallery instances (count = 1..5)
  // -------------------------------------------------------------------
  print('\n[Section 3] Gallery: count=1..5');
  final List<SerialTapDownDetails> gallery = <SerialTapDownDetails>[
    SerialTapDownDetails(
      globalPosition: const Offset(40, 60),
      localPosition: const Offset(10, 12),
      kind: PointerDeviceKind.touch,
      count: 1,
      buttons: 0,
    ),
    SerialTapDownDetails(
      globalPosition: const Offset(80, 90),
      localPosition: const Offset(14, 18),
      kind: PointerDeviceKind.touch,
      count: 2,
      buttons: 0,
    ),
    SerialTapDownDetails(
      globalPosition: const Offset(140, 130),
      localPosition: const Offset(20, 22),
      kind: PointerDeviceKind.mouse,
      count: 3,
      buttons: kPrimaryMouseButton,
    ),
    SerialTapDownDetails(
      globalPosition: const Offset(210, 170),
      localPosition: const Offset(28, 30),
      kind: PointerDeviceKind.mouse,
      count: 4,
      buttons: kPrimaryMouseButton,
    ),
    SerialTapDownDetails(
      globalPosition: const Offset(280, 220),
      localPosition: const Offset(34, 36),
      kind: PointerDeviceKind.stylus,
      count: 5,
      buttons: kPrimaryStylusButton,
    ),
  ];
  for (int i = 0; i < gallery.length; i++) {
    _dumpDetails('gallery[$i]', gallery[i]);
  }
  print('Gallery shows escalation: count climbs while position drifts,');
  print('mirroring how a real user trails their pointer slightly between');
  print('consecutive taps in a serial sequence.');

  // -------------------------------------------------------------------
  // SECTION 4 — PointerDeviceKind variations × button states
  // -------------------------------------------------------------------
  print('\n[Section 4] PointerDeviceKind × buttons matrix');
  final SerialTapDownDetails kindTouch = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.touch,
    count: 1,
    buttons: 0,
  );
  final SerialTapDownDetails kindMouseLeft = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.mouse,
    count: 2,
    buttons: kPrimaryMouseButton,
  );
  final SerialTapDownDetails kindMouseRight = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.mouse,
    count: 2,
    buttons: kSecondaryMouseButton,
  );
  final SerialTapDownDetails kindMouseMiddle = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.mouse,
    count: 1,
    buttons: kMiddleMouseButton,
  );
  final SerialTapDownDetails kindStylus = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.stylus,
    count: 1,
    buttons: kPrimaryStylusButton,
  );
  final SerialTapDownDetails kindInverted = SerialTapDownDetails(
    globalPosition: const Offset(50, 50),
    localPosition: const Offset(5, 5),
    kind: PointerDeviceKind.invertedStylus,
    count: 1,
    buttons: kSecondaryStylusButton,
  );
  _dumpDetails('kindTouch', kindTouch);
  _dumpDetails('kindMouseLeft', kindMouseLeft);
  _dumpDetails('kindMouseRight', kindMouseRight);
  _dumpDetails('kindMouseMiddle', kindMouseMiddle);
  _dumpDetails('kindStylus', kindStylus);
  _dumpDetails('kindInverted', kindInverted);

  // -------------------------------------------------------------------
  // SECTION 6 — Lifecycle storyboard data
  // -------------------------------------------------------------------
  print('\n[Section 6] Lifecycle: tap1 down/up → tap2 down/up → tap3 down');
  final SerialTapDownDetails lifeT1Down = SerialTapDownDetails(
    globalPosition: const Offset(100, 100),
    localPosition: const Offset(10, 10),
    kind: PointerDeviceKind.mouse,
    count: 1,
    buttons: kPrimaryMouseButton,
  );
  final SerialTapDownDetails lifeT2Down = SerialTapDownDetails(
    globalPosition: const Offset(102, 101),
    localPosition: const Offset(12, 11),
    kind: PointerDeviceKind.mouse,
    count: 2,
    buttons: kPrimaryMouseButton,
  );
  final SerialTapDownDetails lifeT3Down = SerialTapDownDetails(
    globalPosition: const Offset(105, 103),
    localPosition: const Offset(15, 13),
    kind: PointerDeviceKind.mouse,
    count: 3,
    buttons: kPrimaryMouseButton,
  );
  _dumpDetails('lifeT1Down', lifeT1Down);
  _dumpDetails('lifeT2Down', lifeT2Down);
  _dumpDetails('lifeT3Down', lifeT3Down);
  print('Each subsequent SerialTapDownDetails arrives within the recognizer');
  print('timeout (kDoubleTapTimeout) and within kDoubleTapSlop of the prior');
  print('tap. If the user dwells too long or drifts too far, count resets.');

  // -------------------------------------------------------------------
  // SECTION 7 — Button mask reference values
  // -------------------------------------------------------------------
  print('\n[Section 7] Mouse button bitmasks');
  print('  kPrimaryMouseButton    = $kPrimaryMouseButton');
  print('  kSecondaryMouseButton  = $kSecondaryMouseButton');
  print('  kMiddleMouseButton     = $kMiddleMouseButton');
  print('  kBackMouseButton       = $kBackMouseButton');
  print('  kForwardMouseButton    = $kForwardMouseButton');
  print('  kPrimaryStylusButton   = $kPrimaryStylusButton');
  print('  kSecondaryStylusButton = $kSecondaryStylusButton');
  print('  kTouchContact          = $kTouchContact');

  // -------------------------------------------------------------------
  // SECTION 8 — Cheat-sheet log
  // -------------------------------------------------------------------
  print('\n[Section 8] Where SerialTapGestureRecognizer earns its keep:');
  print('  * Text editor selection: word on count=2, paragraph on count=3.');
  print('  * Map / image viewers: progressive zoom-in on each tap.');
  print('  * Custom multi-click menus (count=4 → "advanced" panel).');
  print('  * Keyboard-free toggles (triple-tap status bar to debug).');
  print('  * Replaces ad-hoc DoubleTapGestureRecognizer chains.');

  // ===================================================================
  // Build the visual root.
  // ===================================================================
  return Container(
    color: kCream,
    padding: const EdgeInsets.all(14),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // -------------------------------------------------------------
        // SECTION 1 — Title banner
        // -------------------------------------------------------------
        _sectionHeader(
          1,
          'SerialTapDownDetails',
          'Telegraph keys, copper wires, and counted contacts',
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [kCharcoal, kInkBlue, kCharcoal],
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
              _tapKey(1),
              const SizedBox(width: 8),
              _tapKey(2),
              const SizedBox(width: 8),
              _tapKey(3),
              const SizedBox(width: 8),
              _tapKey(4),
              const SizedBox(width: 8),
              _tapKey(5),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A serial tap, decoded.',
                      style: TextStyle(
                        color: kCream,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'globalPosition · localPosition · kind · count · buttons',
                      style: TextStyle(
                        color: kBrass,
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

        // -------------------------------------------------------------
        // SECTION 2 — Anatomy diagram
        // -------------------------------------------------------------
        _sectionHeader(
          2,
          'Anatomy of SerialTapDownDetails',
          'count is the discriminator; the rest locates the tap',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCream,
            border: Border.all(color: kCopperDark, width: 2),
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
                    width: 130,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kCharcoal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'SerialTapDownDetails',
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
                        _field('count', '${anchor.count}  ← discriminator'),
                        _field('globalPosition', '${anchor.globalPosition}'),
                        _field('localPosition', '${anchor.localPosition}'),
                        _field('kind', '${anchor.kind}'),
                        _field(
                          'buttons',
                          '0x${anchor.buttons.toRadixString(16)}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _wire(),
              Wrap(
                children: [
                  _pill('count = 1  → solo tap', kBrass, kCharcoal),
                  _pill('count = 2  → double tap', kCopper, kCream),
                  _pill('count = 3  → triple tap', kAmberSpark, kCharcoal),
                  _pill('count = 4  → quad tap', kSignalGreen, kCream),
                  _pill('count ≥ 5  → keep counting', kLacquerRed, kCream),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'globalPosition is in the device\'s coordinate space; '
                'localPosition is relative to the box that received the hit.',
                style: TextStyle(
                  color: kCharcoalSoft,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------
        // SECTION 3 — Gallery
        // -------------------------------------------------------------
        _sectionHeader(
          3,
          'Gallery — count = 1..5',
          'Six framed cards showing escalating taps',
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _frame(
              title: 'count = 1 (solo)',
              border: kBrass,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(1),
                  const SizedBox(height: 4),
                  _field('global', '${gallery[0].globalPosition}'),
                  _field('local', '${gallery[0].localPosition}'),
                  _field('kind', '${gallery[0].kind}'),
                  _field('buttons', '${gallery[0].buttons}'),
                ],
              ),
            ),
            _frame(
              title: 'count = 2 (double)',
              border: kCopper,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(2),
                  const SizedBox(height: 4),
                  _field('global', '${gallery[1].globalPosition}'),
                  _field('local', '${gallery[1].localPosition}'),
                  _field('kind', '${gallery[1].kind}'),
                  _field('buttons', '${gallery[1].buttons}'),
                ],
              ),
            ),
            _frame(
              title: 'count = 3 (triple)',
              border: kAmberSpark,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(3),
                  const SizedBox(height: 4),
                  _field('global', '${gallery[2].globalPosition}'),
                  _field('local', '${gallery[2].localPosition}'),
                  _field('kind', '${gallery[2].kind}'),
                  _field('buttons', '${gallery[2].buttons}'),
                ],
              ),
            ),
            _frame(
              title: 'count = 4 (quad)',
              border: kSignalGreen,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(4),
                  const SizedBox(height: 4),
                  _field('global', '${gallery[3].globalPosition}'),
                  _field('local', '${gallery[3].localPosition}'),
                  _field('kind', '${gallery[3].kind}'),
                  _field('buttons', '${gallery[3].buttons}'),
                ],
              ),
            ),
            _frame(
              title: 'count = 5 (penta)',
              border: kLacquerRed,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(5),
                  const SizedBox(height: 4),
                  _field('global', '${gallery[4].globalPosition}'),
                  _field('local', '${gallery[4].localPosition}'),
                  _field('kind', '${gallery[4].kind}'),
                  _field('buttons', '${gallery[4].buttons}'),
                ],
              ),
            ),
            // Sixth card: a "what-if" exploration on count=2 with mouse.
            _frame(
              title: 'count = 2 (mouse)',
              border: kInkBlue,
              fill: kCreamDeep,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tapKey(2),
                  const SizedBox(height: 4),
                  _field('global', '${anchor.globalPosition}'),
                  _field('local', '${anchor.localPosition}'),
                  _field('kind', '${anchor.kind}'),
                  _field(
                    'buttons',
                    '0x${anchor.buttons.toRadixString(16)} (LMB)',
                  ),
                ],
              ),
            ),
          ],
        ),

        // -------------------------------------------------------------
        // SECTION 4 — Kind × button matrix
        // -------------------------------------------------------------
        _sectionHeader(
          4,
          'PointerDeviceKind × buttons',
          'Mouse vs touch vs stylus, with button states',
        ),
        Container(
          decoration: BoxDecoration(
            color: kCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kCharcoal, width: 1),
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
                      title: 'touch / no buttons',
                      border: kSignalGreen,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindTouch.kind}'),
                          _field('count', '${kindTouch.count}'),
                          _field('buttons', '${kindTouch.buttons}'),
                          _pill(
                            'finger contact',
                            kSignalGreen,
                            kCream,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _frame(
                      title: 'mouse / LMB',
                      border: kCopper,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindMouseLeft.kind}'),
                          _field('count', '${kindMouseLeft.count}'),
                          _field(
                            'buttons',
                            '0x${kindMouseLeft.buttons.toRadixString(16)}',
                          ),
                          _pill('LMB', kCopper, kCream),
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
                      title: 'mouse / RMB',
                      border: kLacquerRed,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindMouseRight.kind}'),
                          _field('count', '${kindMouseRight.count}'),
                          _field(
                            'buttons',
                            '0x${kindMouseRight.buttons.toRadixString(16)}',
                          ),
                          _pill('RMB', kLacquerRed, kCream),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _frame(
                      title: 'mouse / MMB',
                      border: kInkBlue,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindMouseMiddle.kind}'),
                          _field('count', '${kindMouseMiddle.count}'),
                          _field(
                            'buttons',
                            '0x${kindMouseMiddle.buttons.toRadixString(16)}',
                          ),
                          _pill('MMB / wheel', kInkBlue, kCream),
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
                      title: 'stylus / primary',
                      border: kAmberSpark,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindStylus.kind}'),
                          _field('count', '${kindStylus.count}'),
                          _field(
                            'buttons',
                            '0x${kindStylus.buttons.toRadixString(16)}',
                          ),
                          _pill('barrel button', kAmberSpark, kCharcoal),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _frame(
                      title: 'invertedStylus / sec',
                      border: kCharcoal,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _field('kind', '${kindInverted.kind}'),
                          _field('count', '${kindInverted.count}'),
                          _field(
                            'buttons',
                            '0x${kindInverted.buttons.toRadixString(16)}',
                          ),
                          _pill('eraser end', kCharcoal, kCream),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------
        // SECTION 5 — Comparison table
        // -------------------------------------------------------------
        _sectionHeader(
          5,
          'Cousins of SerialTapDownDetails',
          'Down vs Up vs Cancel, plus the non-serial TapDownDetails',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kCharcoal, width: 1),
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
                      color: kCharcoal,
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
                      color: kCharcoal,
                      padding: const EdgeInsets.all(6),
                      child: const Text(
                        'count?',
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
                      color: kCharcoal,
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
                      color: kCreamDeep,
                      child: const Text(
                        'TapDownDetails',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCreamDeep,
                      child: const Text(
                        'no',
                        style: TextStyle(fontSize: 11, color: kLacquerRed),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCreamDeep,
                      child: const Text(
                        'TapGestureRecognizer.onTapDown',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                ],
              ),
              // Row: SerialTapDownDetails (this)
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'SerialTapDownDetails ★',
                        style: TextStyle(
                          fontSize: 11,
                          color: kCopperDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'YES',
                        style: TextStyle(
                          fontSize: 11,
                          color: kSignalGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'SerialTapGestureRecognizer.onSerialTapDown',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                ],
              ),
              // Row: SerialTapUpDetails
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCreamDeep,
                      child: const Text(
                        'SerialTapUpDetails',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCreamDeep,
                      child: const Text(
                        'YES',
                        style: TextStyle(fontSize: 11, color: kSignalGreen),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCreamDeep,
                      child: const Text(
                        'SerialTapGestureRecognizer.onSerialTapUp',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                ],
              ),
              // Row: SerialTapCancelDetails
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'SerialTapCancelDetails',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'YES',
                        style: TextStyle(fontSize: 11, color: kSignalGreen),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: kCream,
                      child: const Text(
                        'SerialTapGestureRecognizer.onSerialTapCancel',
                        style: TextStyle(fontSize: 11, color: kCharcoal),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------
        // SECTION 6 — Lifecycle storyboard
        // -------------------------------------------------------------
        _sectionHeader(
          6,
          'Lifecycle storyboard',
          'tap1 → tap2 → tap3, with timestamp arrows',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [kCharcoalSoft, kCharcoal],
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
                      _tapKey(1),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              't = 0 ms — onSerialTapDown(count=1)',
                              style: TextStyle(
                                color: kCream,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            _field('global', '${lifeT1Down.globalPosition}'),
                            _field('local', '${lifeT1Down.localPosition}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _wire(),
                  const Text(
                    '↓ within kDoubleTapTimeout (~300 ms)',
                    style: TextStyle(
                      color: kAmberSpark,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                  _wire(),
                  Row(
                    children: [
                      _tapKey(2),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              't = ~150 ms — onSerialTapDown(count=2)',
                              style: TextStyle(
                                color: kCream,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            _field('global', '${lifeT2Down.globalPosition}'),
                            _field('local', '${lifeT2Down.localPosition}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _wire(),
                  const Text(
                    '↓ within kDoubleTapSlop (~18 px)',
                    style: TextStyle(
                      color: kAmberSpark,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                  _wire(),
                  Row(
                    children: [
                      _tapKey(3),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              't = ~280 ms — onSerialTapDown(count=3)',
                              style: TextStyle(
                                color: kCream,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            _field('global', '${lifeT3Down.globalPosition}'),
                            _field('local', '${lifeT3Down.localPosition}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [kInkBlue, kCharcoal],
                        ),
                      ),
                      child: const Text(
                        'After timeout / slop violation: count resets to 1.',
                        style: TextStyle(
                          color: kCream,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
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
                    color: kSignalGreen,
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

        // -------------------------------------------------------------
        // SECTION 7 — Button mask interpretation
        // -------------------------------------------------------------
        _sectionHeader(
          7,
          'Button mask interpretation',
          'Reading buttons as a bitmask of pressed contacts',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCream,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kCopperDark, width: 2),
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
                'Mouse buttons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kCharcoal,
                  fontSize: 13,
                ),
              ),
              Wrap(
                children: [
                  _pill(
                    'kPrimaryMouseButton = 0x'
                    '${kPrimaryMouseButton.toRadixString(16)}',
                    kCopper,
                    kCream,
                  ),
                  _pill(
                    'kSecondaryMouseButton = 0x'
                    '${kSecondaryMouseButton.toRadixString(16)}',
                    kLacquerRed,
                    kCream,
                  ),
                  _pill(
                    'kMiddleMouseButton = 0x'
                    '${kMiddleMouseButton.toRadixString(16)}',
                    kInkBlue,
                    kCream,
                  ),
                  _pill(
                    'kBackMouseButton = 0x'
                    '${kBackMouseButton.toRadixString(16)}',
                    kCharcoal,
                    kCream,
                  ),
                  _pill(
                    'kForwardMouseButton = 0x'
                    '${kForwardMouseButton.toRadixString(16)}',
                    kBrass,
                    kCharcoal,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Stylus buttons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kCharcoal,
                  fontSize: 13,
                ),
              ),
              Wrap(
                children: [
                  _pill(
                    'kPrimaryStylusButton = 0x'
                    '${kPrimaryStylusButton.toRadixString(16)}',
                    kAmberSpark,
                    kCharcoal,
                  ),
                  _pill(
                    'kSecondaryStylusButton = 0x'
                    '${kSecondaryStylusButton.toRadixString(16)}',
                    kCharcoal,
                    kAmberSpark,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Touch contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kCharcoal,
                  fontSize: 13,
                ),
              ),
              Wrap(
                children: [
                  _pill(
                    'kTouchContact = 0x'
                    '${kTouchContact.toRadixString(16)}',
                    kSignalGreen,
                    kCream,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kCharcoal,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Read as a bitmask: (buttons & kPrimaryMouseButton) != 0\n'
                  'means the primary mouse button is currently held down.',
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

        // -------------------------------------------------------------
        // SECTION 8 — Cheat-sheet
        // -------------------------------------------------------------
        _sectionHeader(
          8,
          'Cheat-sheet',
          'Where SerialTapGestureRecognizer earns its keep',
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
            border: Border.all(color: kCharcoal, width: 2),
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
                '✓ count == 1   single tap → place caret in a text editor',
                style: TextStyle(color: kCharcoal, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                '✓ count == 2   double tap → select word under cursor',
                style: TextStyle(color: kCharcoal, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                '✓ count == 3   triple tap → select paragraph / line',
                style: TextStyle(color: kCharcoal, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                '✓ count == 4   quad tap → select entire document',
                style: TextStyle(color: kCharcoal, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                '✓ count == 5+  custom escalation (debug overlays, etc.)',
                style: TextStyle(color: kCharcoal, fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Use SerialTapGestureRecognizer instead of stacking '
                'TapGestureRecognizer + DoubleTapGestureRecognizer; the '
                'serial recognizer keeps the count for you and lets you '
                'react to onSerialTapDown / onSerialTapUp / onSerialTapCancel '
                'with consistent SerialTap*Details payloads.',
                style: TextStyle(
                  color: kCharcoalSoft,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),
        // Footer
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kCharcoal,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: kShadow, blurRadius: 4),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: kAmberSpark, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'SerialTapDownDetails — count=${anchor.count}, '
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
  );
}
