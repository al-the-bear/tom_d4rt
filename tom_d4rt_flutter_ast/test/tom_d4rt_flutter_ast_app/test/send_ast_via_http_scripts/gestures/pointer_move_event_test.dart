// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo for PointerMoveEvent (package:flutter/gestures.dart).
//
// PointerMoveEvent is the concrete PointerEvent that the engine emits while
// a pointer is in contact with the surface AND moving — the dragging frame
// between PointerDownEvent and PointerUpEvent. This script depicts every
// documented field with concrete, hand-built values, then visualises the
// trajectory of a multi-step drag, the pressure / radius geometry, the
// effect of copyWith / transformed, the device-kind mosaic, and the buttons
// bitmask layout. No StatefulWidget, no setState, no Listener — the script
// only constructs PointerMoveEvent values directly and renders their data.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ============================================================================
// Top-level palette — a deep ocean-blue + amber accent scheme picked so this
// demo reads visually distinct from sibling pointer-event demos in the same
// directory (which lean green / cyan / purple).
// ============================================================================
const Color _oceanDeep = Color(0xFF0D2B45);
const Color _oceanMid = Color(0xFF1F4068);
const Color _oceanSky = Color(0xFF2C5F8E);
const Color _amberHi = Color(0xFFFFC04C);
const Color _amberLo = Color(0xFFE08E1B);
const Color _surfaceBg = Color(0xFFF4F7FB);
const Color _cardBg = Color(0xFFFFFFFF);
const Color _gridLine = Color(0xFFCFD8E3);
const Color _ink = Color(0xFF12253D);
const Color _inkMute = Color(0xFF5A6B82);
const Color _danger = Color(0xFFD0492C);

dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // Build the section list eagerly; each section is a self-contained Widget
  // tree assembled below. Using a plain List<Widget> guarantees safe
  // iteration under d4rt (no for-in over bridged values).
  // --------------------------------------------------------------------------
  final List<Widget> sections = <Widget>[];
  sections.add(_buildHero());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildAnatomy());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildFieldGrid());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildSampleGallery());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildTrajectory());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildPressureRadii());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildCopyWithShowcase());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildTransformedShowcase());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildKindMosaic());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildButtonsBitmask());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildPitfalls());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildCodeCard());
  sections.add(const SizedBox(height: 18.0));
  sections.add(_buildFooter());

  return Container(
    color: _surfaceBg,
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    ),
  );
}

// ============================================================================
// SECTION 1 — Hero header
// Gradient banner declaring the subject + library coordinates.
// ============================================================================
Widget _buildHero() {
  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_oceanDeep, _oceanMid, _oceanSky],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _oceanDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 92.0,
          height: 92.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.12),
            border: Border.all(color: _amberHi, width: 3.0),
          ),
          child: const Icon(
            Icons.swipe_right_alt,
            size: 48.0,
            color: _amberHi,
          ),
        ),
        const SizedBox(width: 22.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'PointerMoveEvent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'package:flutter/gestures.dart  ·  dart:ui',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Pointer in contact, moving. The drag-frame event '
                  'between PointerDown and PointerUp.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 14.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 8.0,
                children: <Widget>[
                  _heroChip('extends PointerEvent', Icons.account_tree),
                  _heroChip('down == true', Icons.arrow_downward),
                  _heroChip('delta vector', Icons.east),
                  _heroChip('per-frame sample', Icons.timer),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _amberHi.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: _amberHi),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — Anatomy block
// Pointer event class hierarchy: PointerEvent -> PointerMoveEvent.
// Rendered as boxed nodes connected by labelled arrows.
// ============================================================================
Widget _buildAnatomy() {
  return _sectionShell(
    title: '1 · Anatomy — class hierarchy',
    accent: _oceanSky,
    icon: Icons.account_tree,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'PointerMoveEvent is one of the concrete leaves of the PointerEvent '
          'hierarchy. The base class is abstract and defines the entire field '
          'set; concrete subclasses simply pin a few invariants (e.g. for '
          'PointerMoveEvent: down == true, distance == 0).',
          style: TextStyle(fontSize: 13.5, color: _ink, height: 1.45),
        ),
        const SizedBox(height: 18.0),
        _hierarchyRow(
          'Object',
          'Dart root',
          _gridLine,
          isFirst: true,
        ),
        _arrowBlock('extends'),
        _hierarchyRow(
          'Diagnosticable',
          'mixin (debug strings)',
          _gridLine,
        ),
        _arrowBlock('implements'),
        _hierarchyRow(
          'PointerEvent',
          'abstract — defines fields',
          _oceanMid,
        ),
        _arrowBlock('extends'),
        _hierarchyRow(
          '_PointerEventDescription',
          'mixin — toString helpers',
          _gridLine,
        ),
        _arrowBlock('extends + with'),
        _hierarchyRow(
          'PointerMoveEvent',
          'this class — drag-frame event',
          _amberLo,
          isHero: true,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _surfaceBg,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gridLine),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Sibling concrete leaves',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: _ink,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'PointerAddedEvent · PointerRemovedEvent · PointerHoverEvent · '
                'PointerEnterEvent · PointerExitEvent · PointerDownEvent · '
                'PointerMoveEvent (this) · PointerUpEvent · PointerCancelEvent · '
                'PointerSignalEvent (scroll, scale) · PointerPanZoomStart/'
                'Update/EndEvent.',
                style: TextStyle(fontSize: 12.0, color: _inkMute, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyRow(
  String name,
  String tag,
  Color accent, {
  bool isFirst = false,
  bool isHero = false,
}) {
  return Container(
    margin: EdgeInsets.only(top: isFirst ? 0.0 : 0.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: isHero ? _amberHi.withValues(alpha: 0.14) : _cardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: isHero ? _amberLo : accent,
        width: isHero ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: isHero ? FontWeight.w800 : FontWeight.w600,
            fontFamily: 'monospace',
            color: _ink,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 12.0,
              color: _inkMute,
            ),
          ),
        ),
        if (isHero)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: _amberLo,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'this',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _arrowBlock(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: <Widget>[
        const SizedBox(width: 18.0),
        const Icon(Icons.south, size: 16.0, color: _inkMute),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            color: _inkMute,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — Field reference grid
// Card grid: one card per documented field with a tiny example value.
// ============================================================================
Widget _buildFieldGrid() {
  // Plain Dart List of records-ish maps (kept as List<Map<String,String>> for
  // d4rt-friendly iteration). Each entry: name, type, blurb, example.
  final List<Map<String, String>> fields = <Map<String, String>>[
    <String, String>{
      'name': 'position',
      'type': 'Offset',
      'blurb': 'pointer location in the global coordinate frame',
      'example': 'Offset(132, 78)',
    },
    <String, String>{
      'name': 'localPosition',
      'type': 'Offset',
      'blurb': 'position transformed into the receiving widget frame',
      'example': 'Offset(32, 18)',
    },
    <String, String>{
      'name': 'delta',
      'type': 'Offset',
      'blurb': 'displacement since the previous sample (global)',
      'example': 'Offset(4, -2)',
    },
    <String, String>{
      'name': 'localDelta',
      'type': 'Offset',
      'blurb': 'delta in the local frame (matches transform basis)',
      'example': 'Offset(4, -2)',
    },
    <String, String>{
      'name': 'buttons',
      'type': 'int (bitmask)',
      'blurb': 'pressed buttons; for touch always kPrimaryButton',
      'example': 'kPrimaryButton',
    },
    <String, String>{
      'name': 'obscured',
      'type': 'bool',
      'blurb': 'true when the platform reports the pointer occluded',
      'example': 'false',
    },
    <String, String>{
      'name': 'pressure',
      'type': 'double',
      'blurb': 'normalised contact force, 0.0..1.0',
      'example': '0.91',
    },
    <String, String>{
      'name': 'pressureMin',
      'type': 'double',
      'blurb': 'minimum reportable pressure for this device',
      'example': '0.0',
    },
    <String, String>{
      'name': 'pressureMax',
      'type': 'double',
      'blurb': 'maximum reportable pressure for this device',
      'example': '1.0',
    },
    <String, String>{
      'name': 'distance',
      'type': 'double',
      'blurb': 'always 0.0 for Move (pointer is in contact)',
      'example': '0.0',
    },
    <String, String>{
      'name': 'distanceMax',
      'type': 'double',
      'blurb': 'maximum distance at which the device is detected',
      'example': '0.0',
    },
    <String, String>{
      'name': 'radiusMajor',
      'type': 'double',
      'blurb': 'radius of the contact ellipse along the major axis',
      'example': '9.0',
    },
    <String, String>{
      'name': 'radiusMinor',
      'type': 'double',
      'blurb': 'radius of the contact ellipse along the minor axis',
      'example': '7.0',
    },
    <String, String>{
      'name': 'radiusMin',
      'type': 'double',
      'blurb': 'minimum radius the device can report',
      'example': '0.0',
    },
    <String, String>{
      'name': 'radiusMax',
      'type': 'double',
      'blurb': 'maximum radius the device can report',
      'example': '14.0',
    },
    <String, String>{
      'name': 'orientation',
      'type': 'double',
      'blurb': 'angle of the contact ellipse, radians',
      'example': '0.05',
    },
    <String, String>{
      'name': 'tilt',
      'type': 'double',
      'blurb': 'stylus tilt away from perpendicular, radians',
      'example': '0.12',
    },
    <String, String>{
      'name': 'synthesized',
      'type': 'bool',
      'blurb': 'true if the framework manufactured this event',
      'example': 'false',
    },
    <String, String>{
      'name': 'original',
      'type': 'PointerEvent?',
      'blurb': 'the pre-transform event when this is a transformed copy',
      'example': 'null',
    },
    <String, String>{
      'name': 'pointer',
      'type': 'int',
      'blurb': 'monotonically increasing per-pointer identifier',
      'example': '42',
    },
    <String, String>{
      'name': 'device',
      'type': 'int',
      'blurb': 'opaque platform device id',
      'example': '0',
    },
    <String, String>{
      'name': 'kind',
      'type': 'PointerDeviceKind',
      'blurb': 'touch / mouse / stylus / trackpad / unknown',
      'example': 'PointerDeviceKind.touch',
    },
    <String, String>{
      'name': 'embedderId',
      'type': 'int',
      'blurb': 'platform embedder id (0 if unused)',
      'example': '0',
    },
    <String, String>{
      'name': 'timeStamp',
      'type': 'Duration',
      'blurb': 'engine time when the sample was taken',
      'example': '1450 ms',
    },
    <String, String>{
      'name': 'pointerId',
      'type': 'int (legacy)',
      'blurb': 'historical alias for pointer; prefer "pointer"',
      'example': '42',
    },
  ];

  // Build a manual two-column grid of cards (avoid GridView for d4rt).
  final List<Widget> rows = <Widget>[];
  int i = 0;
  while (i < fields.length) {
    final Map<String, String> a = fields[i];
    final Map<String, String>? b = (i + 1 < fields.length) ? fields[i + 1] : null;
    rows.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _fieldCard(a)),
            const SizedBox(width: 10.0),
            Expanded(
              child: b == null ? const SizedBox.shrink() : _fieldCard(b),
            ),
          ],
        ),
      ),
    );
    i = i + 2;
  }

  return _sectionShell(
    title: '2 · Field reference grid',
    accent: _amberLo,
    icon: Icons.grid_view,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _fieldCard(Map<String, String> f) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _gridLine),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                f['name'] ?? '',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: _oceanSky.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                f['type'] ?? '',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: _oceanDeep,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          f['blurb'] ?? '',
          style: const TextStyle(fontSize: 12.0, color: _inkMute, height: 1.35),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: _amberHi.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'e.g.  ${f['example'] ?? ''}',
            style: const TextStyle(
              fontSize: 11.5,
              color: _amberLo,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — Constructor sample gallery (5 events)
// ============================================================================
Widget _buildSampleGallery() {
  // Construct each PointerMoveEvent in a try/catch so that if d4rt rejects a
  // particular argument combination we render a fallback card rather than
  // failing the whole build.
  final List<Widget> cards = <Widget>[];

  cards.add(_safeSampleCard(
    label: 'A — touch, mid-drag',
    note: 'classic touch drag: kPrimaryButton, pressure ≈ 0.9',
    builder: () {
      const PointerMoveEvent e = PointerMoveEvent(
        timeStamp: Duration(milliseconds: 1450),
        pointer: 42,
        kind: PointerDeviceKind.touch,
        device: 0,
        position: Offset(132.0, 78.0),
        delta: Offset(32.0, 28.0),
        buttons: kPrimaryButton,
        obscured: false,
        pressure: 0.91,
        pressureMin: 0.0,
        pressureMax: 1.0,
        size: 0.14,
        radiusMajor: 9.0,
        radiusMinor: 7.0,
        radiusMin: 0.0,
        radiusMax: 14.0,
        orientation: 0.05,
        tilt: 0.0,
        synthesized: false,
        embedderId: 0,
      );
      return e;
    },
  ));

  cards.add(_safeSampleCard(
    label: 'B — mouse drag, secondary button',
    note: 'right-button drag: kSecondaryMouseButton, pressure constant 1.0',
    builder: () {
      const PointerMoveEvent e = PointerMoveEvent(
        timeStamp: Duration(milliseconds: 2200),
        pointer: 7,
        kind: PointerDeviceKind.mouse,
        device: 0,
        position: Offset(420.0, 240.0),
        delta: Offset(-12.0, 4.0),
        buttons: kSecondaryMouseButton,
        obscured: false,
        pressure: 1.0,
        pressureMin: 1.0,
        pressureMax: 1.0,
        synthesized: false,
        embedderId: 0,
      );
      return e;
    },
  ));

  cards.add(_safeSampleCard(
    label: 'C — stylus, tilted, oriented',
    note: 'pen with non-zero tilt + orientation; thin radii',
    builder: () {
      const PointerMoveEvent e = PointerMoveEvent(
        timeStamp: Duration(milliseconds: 3100),
        pointer: 13,
        kind: PointerDeviceKind.stylus,
        device: 1,
        position: Offset(64.0, 312.0),
        delta: Offset(2.5, -1.25),
        buttons: kPrimaryButton,
        obscured: false,
        pressure: 0.42,
        pressureMin: 0.0,
        pressureMax: 1.0,
        size: 0.04,
        radiusMajor: 3.5,
        radiusMinor: 2.5,
        radiusMin: 0.0,
        radiusMax: 6.0,
        orientation: 0.78,
        tilt: 0.45,
        synthesized: false,
        embedderId: 2,
      );
      return e;
    },
  ));

  cards.add(_safeSampleCard(
    label: 'D — synthesized resampled tick',
    note: 'framework-manufactured sample (synthesized: true)',
    builder: () {
      const PointerMoveEvent e = PointerMoveEvent(
        timeStamp: Duration(milliseconds: 3116),
        pointer: 13,
        kind: PointerDeviceKind.stylus,
        device: 1,
        position: Offset(66.0, 311.5),
        delta: Offset(2.0, -0.5),
        buttons: kPrimaryButton,
        obscured: false,
        pressure: 0.43,
        pressureMin: 0.0,
        pressureMax: 1.0,
        synthesized: true,
        embedderId: 2,
      );
      return e;
    },
  ));

  cards.add(_safeSampleCard(
    label: 'E — trackpad two-button chord',
    note: 'simultaneous primary + tertiary press during drag',
    builder: () {
      // Non-const so any constructor assertion surfaces as a runtime
      // exception that our try/catch can render as a fallback card.
      final PointerMoveEvent e = PointerMoveEvent(
        timeStamp: const Duration(milliseconds: 4040),
        pointer: 91,
        kind: PointerDeviceKind.trackpad,
        device: 3,
        position: const Offset(540.0, 90.0),
        delta: const Offset(0.0, 8.0),
        buttons: kPrimaryButton | kTertiaryButton,
        obscured: false,
        pressure: 1.0,
        pressureMin: 1.0,
        pressureMax: 1.0,
        synthesized: false,
        embedderId: 0,
      );
      return e;
    },
  ));

  // Stack the gallery as one card per row so each has full width.
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < cards.length; i = i + 1) {
    if (i > 0) children.add(const SizedBox(height: 10.0));
    children.add(cards[i]);
  }

  return _sectionShell(
    title: '3 · Constructor sample gallery',
    accent: _oceanMid,
    icon: Icons.collections_bookmark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _safeSampleCard({
  required String label,
  required String note,
  required PointerMoveEvent Function() builder,
}) {
  PointerMoveEvent? evt;
  String? error;
  try {
    evt = builder();
  } catch (e) {
    error = e.toString();
  }
  if (evt == null) {
    return _fallbackEventCard(label: label, note: note, error: error ?? '?');
  }
  return _eventCard(label: label, note: note, e: evt);
}

Widget _fallbackEventCard({
  required String label,
  required String note,
  required String error,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _danger.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _danger),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.error_outline, color: _danger, size: 18.0),
            const SizedBox(width: 8.0),
            Text(
              '$label  (constructor rejected by interpreter)',
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: _danger,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          note,
          style: const TextStyle(fontSize: 12.0, color: _inkMute),
        ),
        const SizedBox(height: 6.0),
        Text(
          error,
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: _danger,
          ),
        ),
      ],
    ),
  );
}

Widget _eventCard({
  required String label,
  required String note,
  required PointerMoveEvent e,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _gridLine),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _oceanDeep.withValues(alpha: 0.04),
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
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _amberHi.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: _amberLo,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                note,
                style: const TextStyle(fontSize: 12.0, color: _inkMute),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _kvRow('timeStamp', '${e.timeStamp.inMilliseconds} ms'),
        _kvRow('pointer / device', '${e.pointer} / ${e.device}'),
        _kvRow('kind', e.kind.toString()),
        _kvRow('position', _fmtOffset(e.position)),
        _kvRow('delta', _fmtOffset(e.delta)),
        _kvRow('localPosition', _fmtOffset(e.localPosition)),
        _kvRow('localDelta', _fmtOffset(e.localDelta)),
        _kvRow('buttons (bitmask)', '0x${e.buttons.toRadixString(16)}'),
        _kvRow('pressure', e.pressure.toStringAsFixed(2)),
        _kvRow('pressure range',
            '[${e.pressureMin.toStringAsFixed(2)}, ${e.pressureMax.toStringAsFixed(2)}]'),
        _kvRow('radius (major / minor)',
            '${e.radiusMajor.toStringAsFixed(1)} / ${e.radiusMinor.toStringAsFixed(1)}'),
        _kvRow('radius range',
            '[${e.radiusMin.toStringAsFixed(1)}, ${e.radiusMax.toStringAsFixed(1)}]'),
        _kvRow('orientation / tilt',
            '${e.orientation.toStringAsFixed(2)} / ${e.tilt.toStringAsFixed(2)}'),
        _kvRow('obscured', e.obscured.toString()),
        _kvRow('synthesized', e.synthesized.toString()),
        _kvRow('embedderId', e.embedderId.toString()),
        _kvRow('original', e.original == null ? 'null' : '<PointerEvent>'),
      ],
    ),
  );
}

Widget _kvRow(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text(
            k,
            style: const TextStyle(
              fontSize: 11.5,
              color: _inkMute,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              fontSize: 12.0,
              color: _ink,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

String _fmtOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
}

// ============================================================================
// SECTION 5 — Trajectory visualiser
// 12 manually-chosen waypoints rendered as Stack/Positioned dots; below the
// canvas a list of computed deltas (current − previous).
// ============================================================================
Widget _buildTrajectory() {
  final List<Offset> waypoints = <Offset>[
    const Offset(20.0, 200.0),
    const Offset(60.0, 180.0),
    const Offset(100.0, 152.0),
    const Offset(140.0, 124.0),
    const Offset(180.0, 100.0),
    const Offset(220.0, 88.0),
    const Offset(260.0, 96.0),
    const Offset(300.0, 122.0),
    const Offset(340.0, 156.0),
    const Offset(380.0, 188.0),
    const Offset(420.0, 210.0),
    const Offset(460.0, 220.0),
  ];

  // Build the dot stack (manual layout — this is the visual canvas).
  final List<Widget> stackChildren = <Widget>[];

  // Faint grid behind the dots.
  stackChildren.add(_buildGrid(width: 480.0, height: 260.0));

  // Connector segments between successive waypoints — drawn as Containers
  // rotated would require a Transform — skipped here; instead we render
  // chevron-arrows between the dots to imply direction.
  for (int i = 0; i < waypoints.length; i = i + 1) {
    final Offset p = waypoints[i];
    final double size = 12.0 + (i * 0.6);
    stackChildren.add(
      Positioned(
        left: p.dx - size / 2,
        top: p.dy - size / 2,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _amberHi,
            shape: BoxShape.circle,
            border: Border.all(color: _amberLo, width: 2.0),
          ),
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: const TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.bold,
              color: _oceanDeep,
            ),
          ),
        ),
      ),
    );
  }

  // Build the delta table beneath.
  final List<Widget> deltaRows = <Widget>[];
  deltaRows.add(_deltaHeaderRow());
  for (int i = 0; i < waypoints.length; i = i + 1) {
    final Offset cur = waypoints[i];
    final Offset prev = i == 0 ? cur : waypoints[i - 1];
    final Offset d = Offset(cur.dx - prev.dx, cur.dy - prev.dy);
    deltaRows.add(_deltaRow(i, cur, d));
  }

  return _sectionShell(
    title: '4 · Trajectory visualiser (12 waypoints)',
    accent: _amberHi,
    icon: Icons.timeline,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 260.0,
          decoration: BoxDecoration(
            color: _surfaceBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _gridLine),
          ),
          child: Stack(children: stackChildren),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _gridLine),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: deltaRows,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'delta is computed as (position[i] − position[i−1]). For i = 0 the '
          'delta is the zero vector by convention.',
          style: TextStyle(fontSize: 12.0, color: _inkMute),
        ),
      ],
    ),
  );
}

Widget _buildGrid({required double width, required double height}) {
  // Horizontal + vertical guide lines as 1-px Containers in a Stack.
  final List<Widget> lines = <Widget>[];
  final int hCount = (height ~/ 26).toInt();
  for (int i = 0; i < hCount; i = i + 1) {
    lines.add(Positioned(
      left: 0.0,
      right: 0.0,
      top: (i * 26.0) + 4.0,
      child: Container(height: 1.0, color: _gridLine),
    ));
  }
  final int vCount = (width ~/ 40).toInt();
  for (int i = 0; i < vCount; i = i + 1) {
    lines.add(Positioned(
      top: 0.0,
      bottom: 0.0,
      left: (i * 40.0) + 4.0,
      child: Container(width: 1.0, color: _gridLine),
    ));
  }
  return Stack(children: lines);
}

Widget _deltaHeaderRow() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 30.0,
          child: Text(
            'i',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: _ink,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'position',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: _ink,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'delta',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: _ink,
            ),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            '|delta|',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: _ink,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _deltaRow(int i, Offset p, Offset d) {
  final double mag = _magnitude(d);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 30.0,
          child: Text(
            '$i',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _inkMute,
            ),
          ),
        ),
        Expanded(
          child: Text(
            _fmtOffset(p),
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _ink,
            ),
          ),
        ),
        Expanded(
          child: Text(
            _fmtOffset(d),
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _amberLo,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            mag.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _oceanMid,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

double _magnitude(Offset d) {
  final double sq = (d.dx * d.dx) + (d.dy * d.dy);
  // Tiny constant table to avoid pulling in dart:math under d4rt.
  if (sq <= 0.0) return 0.0;
  // Newton's method, 6 iterations — plenty for visual approximation.
  double x = sq;
  for (int i = 0; i < 6; i = i + 1) {
    x = 0.5 * (x + (sq / x));
  }
  return x;
}

// ============================================================================
// SECTION 6 — Pressure / radius depiction
// Six labelled circles whose radii reflect increasing radiusMajor.
// ============================================================================
Widget _buildPressureRadii() {
  final List<double> radii = <double>[4.0, 8.0, 12.0, 18.0, 24.0, 32.0];
  final List<double> pressures = <double>[0.10, 0.25, 0.45, 0.65, 0.85, 1.00];

  final List<Widget> circles = <Widget>[];
  for (int i = 0; i < radii.length; i = i + 1) {
    final double r = radii[i];
    final double p = pressures[i];
    circles.add(
      Expanded(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80.0,
              child: Center(
                child: Container(
                  width: r * 2.0,
                  height: r * 2.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _amberHi.withValues(alpha: 0.35),
                    border: Border.all(color: _amberLo, width: 2.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'r=${r.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: _ink,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              'p=${p.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 10.5,
                color: _inkMute,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: '5 · Pressure / radius depiction',
    accent: _oceanSky,
    icon: Icons.radio_button_checked,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'radiusMajor / radiusMinor describe the contact ellipse — a '
          'larger thumb pressing harder reports a larger major radius. The '
          'circles below grow from r = 4 to r = 32 with rising pressure.',
          style: TextStyle(fontSize: 13.0, color: _ink, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: _surfaceBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _gridLine),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: circles,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — copyWith showcase
// Show original event, then copy with shifted position, then with delta
// override.
// ============================================================================
Widget _buildCopyWithShowcase() {
  // We hold base-typed PointerEvent references because copyWith returns
  // the base type — that lets us avoid a redundant `as` cast.
  PointerEvent? original;
  PointerEvent? shifted;
  PointerEvent? deltaOverride;
  String? err;

  try {
    const PointerMoveEvent e = PointerMoveEvent(
      timeStamp: Duration(milliseconds: 5000),
      pointer: 21,
      kind: PointerDeviceKind.touch,
      device: 0,
      position: Offset(100.0, 100.0),
      delta: Offset(8.0, 4.0),
      buttons: kPrimaryButton,
      pressure: 0.7,
      pressureMin: 0.0,
      pressureMax: 1.0,
      synthesized: false,
    );
    original = e;
    // copyWith returns PointerEvent; PointerMoveEvent.copyWith narrows to
    // PointerMoveEvent at runtime, but the static return type is the base
    // class. We accept the base type here and access only PointerEvent
    // fields, so no cast is required.
    shifted = e.copyWith(position: const Offset(180.0, 130.0));
    deltaOverride = e.copyWith(delta: const Offset(-2.0, -16.0));
  } catch (ex) {
    err = ex.toString();
  }

  Widget body;
  if (original == null || shifted == null || deltaOverride == null) {
    body = Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _danger),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'copyWith unavailable in this interpreter — depicting parameters '
            'symbolically.',
            style: TextStyle(fontSize: 12.5, color: _danger),
          ),
          const SizedBox(height: 6.0),
          Text(
            err ?? '',
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _danger,
            ),
          ),
          const SizedBox(height: 8.0),
          _copyWithSymbolic(),
        ],
      ),
    );
  } else {
    body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _copyWithCard('original', original, _oceanMid),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _copyWithCard(
            'copyWith(position:)',
            shifted,
            _amberLo,
            highlight: 'position',
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _copyWithCard(
            'copyWith(delta:)',
            deltaOverride,
            _amberLo,
            highlight: 'delta',
          ),
        ),
      ],
    );
  }

  return _sectionShell(
    title: '6 · copyWith showcase',
    accent: _amberLo,
    icon: Icons.copy_all,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'copyWith returns a new PointerMoveEvent with selected fields '
          'overridden. The original is unchanged. This is how the framework '
          'transports an event through hit-test transforms.',
          style: TextStyle(fontSize: 13.0, color: _ink, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        body,
      ],
    ),
  );
}

Widget _copyWithSymbolic() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
      Text(
        'original.position = Offset(100, 100)',
        style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
      ),
      Text(
        'copyWith(position: Offset(180, 130))',
        style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
      ),
      Text(
        'copyWith(delta: Offset(-2, -16))',
        style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
      ),
    ],
  );
}

Widget _copyWithCard(
  String label,
  PointerEvent e,
  Color accent, {
  String? highlight,
}) {
  return Container(
    padding: const EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            color: accent,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6.0),
        _miniRow('position', _fmtOffset(e.position),
            highlight: highlight == 'position'),
        _miniRow('delta', _fmtOffset(e.delta),
            highlight: highlight == 'delta'),
        _miniRow('pressure', e.pressure.toStringAsFixed(2)),
        _miniRow('pointer', e.pointer.toString()),
        _miniRow('buttons', '0x${e.buttons.toRadixString(16)}'),
      ],
    ),
  );
}

Widget _miniRow(String k, String v, {bool highlight = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 70.0,
          child: Text(
            k,
            style: const TextStyle(
              fontSize: 10.5,
              color: _inkMute,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: highlight
                  ? _amberHi.withValues(alpha: 0.40)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              v,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
                color: highlight ? _amberLo : _ink,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — transformed(Matrix4) showcase
// ============================================================================
Widget _buildTransformedShowcase() {
  // Manually compute what .transformed() does for two simple matrices —
  // we don't actually call it, because the Matrix4 type may have limited
  // bridging in d4rt; instead we depict the math.
  const Offset globalPos = Offset(160.0, 120.0);
  const Offset globalDelta = Offset(8.0, 4.0);

  // Translate by (-50, -30)
  const Offset translatedPos = Offset(110.0, 90.0);
  const Offset translatedDelta = Offset(8.0, 4.0); // translation does not affect delta

  // Scale by 0.5
  const Offset scaledPos = Offset(80.0, 60.0);
  const Offset scaledDelta = Offset(4.0, 2.0);

  return _sectionShell(
    title: '7 · transformed(Matrix4) showcase',
    accent: _oceanDeep,
    icon: Icons.transform,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'PointerMoveEvent.transformed(Matrix4 m) returns a new event whose '
          'localPosition / localDelta have been pushed through m. The global '
          'position and delta stay the same; only the *local* views change. '
          'translation does not affect deltas (deltas are vectors, not '
          'points), but scale and rotation do.',
          style: TextStyle(fontSize: 13.0, color: _ink, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _matrixCard(
                'identity (no transform)',
                'Matrix4.identity()',
                globalPos,
                globalDelta,
                globalPos,
                globalDelta,
                _oceanMid,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _matrixCard(
                'translate (−50, −30)',
                'Matrix4.translationValues(−50, −30, 0)',
                globalPos,
                globalDelta,
                translatedPos,
                translatedDelta,
                _amberLo,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _matrixCard(
                'scale 0.5',
                'Matrix4.diagonal3Values(0.5, 0.5, 1)',
                globalPos,
                globalDelta,
                scaledPos,
                scaledDelta,
                _oceanDeep,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _matrixCard(
  String title,
  String code,
  Offset gPos,
  Offset gDelta,
  Offset lPos,
  Offset lDelta,
  Color accent,
) {
  return Container(
    padding: const EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            color: accent,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          code,
          style: const TextStyle(
            fontSize: 10.5,
            color: _inkMute,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8.0),
        _miniRow('position', _fmtOffset(gPos)),
        _miniRow('delta', _fmtOffset(gDelta)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(height: 1.0, color: _gridLine),
        ),
        _miniRow('localPosition', _fmtOffset(lPos), highlight: true),
        _miniRow('localDelta', _fmtOffset(lDelta), highlight: true),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — Kind mosaic
// ============================================================================
Widget _buildKindMosaic() {
  // Manually enumerate to avoid for-in over a bridged enum collection.
  final List<Map<String, String>> kinds = <Map<String, String>>[
    <String, String>{'name': 'touch', 'icon': 'touch'},
    <String, String>{'name': 'mouse', 'icon': 'mouse'},
    <String, String>{'name': 'stylus', 'icon': 'stylus'},
    <String, String>{'name': 'invertedStylus', 'icon': 'inv'},
    <String, String>{'name': 'trackpad', 'icon': 'trackpad'},
    <String, String>{'name': 'unknown', 'icon': 'unknown'},
  ];

  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < kinds.length; i = i + 1) {
    final Map<String, String> k = kinds[i];
    final IconData ic = _kindIcon(k['icon'] ?? '');
    chips.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: _oceanSky),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(ic, size: 16.0, color: _oceanMid),
            const SizedBox(width: 6.0),
            Text(
              'PointerDeviceKind.${k['name']}',
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: _ink,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: '8 · Kind mosaic — PointerDeviceKind.values',
    accent: _oceanMid,
    icon: Icons.devices_other,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'PointerMoveEvent.kind tells you what kind of input device produced '
          'the sample. Each kind has its own conventions — for example, '
          'PointerDeviceKind.touch always reports buttons == kPrimaryButton.',
          style: TextStyle(fontSize: 13.0, color: _ink, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: chips,
        ),
      ],
    ),
  );
}

IconData _kindIcon(String key) {
  if (key == 'touch') return Icons.touch_app;
  if (key == 'mouse') return Icons.mouse;
  if (key == 'stylus') return Icons.brush;
  if (key == 'inv') return Icons.brush_outlined;
  if (key == 'trackpad') return Icons.touch_app_outlined;
  return Icons.help_outline;
}

// ============================================================================
// SECTION 10 — Buttons bitmask diagram
// ============================================================================
Widget _buildButtonsBitmask() {
  final List<Map<String, dynamic>> bits = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'kPrimaryButton',
      'value': kPrimaryButton,
      'desc': 'left mouse / pen tip / single touch',
    },
    <String, dynamic>{
      'name': 'kSecondaryButton',
      'value': kSecondaryButton,
      'desc': 'right mouse / pen barrel button',
    },
    <String, dynamic>{
      'name': 'kTertiaryButton',
      'value': kTertiaryButton,
      'desc': 'middle mouse / wheel-press',
    },
    <String, dynamic>{
      'name': 'kPrimaryMouseButton',
      'value': kPrimaryMouseButton,
      'desc': 'alias for primary on mouse devices',
    },
    <String, dynamic>{
      'name': 'kSecondaryMouseButton',
      'value': kSecondaryMouseButton,
      'desc': 'alias for secondary on mouse devices',
    },
    <String, dynamic>{
      'name': 'kBackMouseButton',
      'value': kBackMouseButton,
      'desc': 'mouse "back" side button',
    },
    <String, dynamic>{
      'name': 'kForwardMouseButton',
      'value': kForwardMouseButton,
      'desc': 'mouse "forward" side button',
    },
    <String, dynamic>{
      'name': 'kStylusContact',
      'value': kStylusContact,
      'desc': 'stylus tip in contact with the surface',
    },
    <String, dynamic>{
      'name': 'kPrimaryStylusButton',
      'value': kPrimaryStylusButton,
      'desc': 'primary side button on a stylus',
    },
    <String, dynamic>{
      'name': 'kSecondaryStylusButton',
      'value': kSecondaryStylusButton,
      'desc': 'secondary side button on a stylus',
    },
  ];

  final List<Widget> bitRows = <Widget>[];
  for (int i = 0; i < bits.length; i = i + 1) {
    final Map<String, dynamic> b = bits[i];
    final int v = (b['value'] as int);
    bitRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Text(
                (b['name'] as String),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
            SizedBox(
              width: 110.0,
              child: Text(
                '0x${v.toRadixString(16).padLeft(4, '0')}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _amberLo,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(child: _bitVisual(v)),
          ],
        ),
      ),
    );
    bitRows.add(
      Padding(
        padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
        child: Text(
          (b['desc'] as String),
          style: const TextStyle(fontSize: 11.0, color: _inkMute),
        ),
      ),
    );
  }

  return _sectionShell(
    title: '9 · Buttons bitmask diagram',
    accent: _amberLo,
    icon: Icons.calculate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'PointerMoveEvent.buttons is an int with one bit per button. '
          'Multiple buttons can be pressed simultaneously by OR-ing the '
          'constants. Below: the canonical bit positions used by the '
          'framework (low 16 bits shown).',
          style: TextStyle(fontSize: 13.0, color: _ink, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _gridLine),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: bitRows,
          ),
        ),
      ],
    ),
  );
}

Widget _bitVisual(int v) {
  // Render the low 16 bits as little squares: filled if set, hollow if not.
  final List<Widget> cells = <Widget>[];
  for (int i = 15; i >= 0; i = i - 1) {
    final int mask = 1 << i;
    final bool on = (v & mask) != 0;
    cells.add(
      Container(
        width: 14.0,
        height: 14.0,
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        decoration: BoxDecoration(
          color: on ? _amberHi : Colors.transparent,
          border: Border.all(
            color: on ? _amberLo : _gridLine,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: cells,
  );
}

// ============================================================================
// SECTION 11 — Pitfalls panel
// ============================================================================
Widget _buildPitfalls() {
  final List<Map<String, String>> pitfalls = <Map<String, String>>[
    <String, String>{
      'title': 'synthesized vs original',
      'body': 'When the framework resamples or replays an event, it sets '
          'synthesized = true and links the source via "original". Treat '
          'synthesized events as informational — they are not driven by a '
          'real engine sample.',
    },
    <String, String>{
      'title': 'pressure is normalised',
      'body': 'pressure is always in the range [pressureMin, pressureMax], '
          'NOT a raw force value. For touch this is conventionally 0.0..1.0; '
          'for mouse it is constant 1.0. Compare with the *Min/*Max bounds '
          'rather than absolute thresholds.',
    },
    <String, String>{
      'title': 'localPosition vs position',
      'body': 'position is in the global coordinate frame; localPosition is '
          'in the receiving widget\'s frame, computed by the hit-test '
          'transform. Without a transform they are equal.',
    },
    <String, String>{
      'title': 'delta != position[i] − position[i−1]',
      'body': 'The engine computes delta on its side and may apply '
          'micro-corrections (resampling, prediction). Trust the field over '
          'reconstructing it from successive positions.',
    },
    <String, String>{
      'title': 'distance is always 0',
      'body': 'For PointerMoveEvent the pointer is in contact, so distance '
          'is always 0.0. distanceMax is informational.',
    },
    <String, String>{
      'title': 'PointerHoverEvent is not the same',
      'body': 'A pointer that is moving but NOT pressed produces '
          'PointerHoverEvent — a different concrete subclass.',
    },
  ];

  final List<Widget> children = <Widget>[];
  for (int i = 0; i < pitfalls.length; i = i + 1) {
    final Map<String, String> p = pitfalls[i];
    children.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.all(11.0),
          decoration: BoxDecoration(
            color: _danger.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _danger.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.warning_amber, color: _danger, size: 16.0),
                  const SizedBox(width: 6.0),
                  Text(
                    p['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: _danger,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(
                p['body'] ?? '',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: _ink,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return _sectionShell(
    title: '10 · Pitfalls',
    accent: _danger,
    icon: Icons.report_problem,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

// ============================================================================
// SECTION 12 — Code card showing typical Listener-based usage
// ============================================================================
Widget _buildCodeCard() {
  const String code = '''
// Listener delivers raw PointerMoveEvent to its onPointerMove
// callback whenever the pointer moves while pressed inside its
// hit-test region. This is the lowest-level integration point.
Listener(
  onPointerDown: (PointerDownEvent e) {
    print('down at \${e.position}');
  },
  onPointerMove: (PointerMoveEvent e) {
    // e.delta is the vector since the previous sample.
    // e.localPosition is in this Listener's coordinate frame.
    print('move \${e.delta} -> \${e.localPosition}');
  },
  onPointerUp: (PointerUpEvent e) {
    print('up at \${e.position}');
  },
  child: const ColoredBox(
    color: Color(0x11000000),
    child: SizedBox(width: 200, height: 200),
  ),
)''';

  return _sectionShell(
    title: '11 · Typical Listener usage',
    accent: _oceanDeep,
    icon: Icons.code,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _oceanDeep,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Text(
        code,
        style: TextStyle(
          fontSize: 12.5,
          color: _amberHi,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 13 — Footer summary
// ============================================================================
Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_oceanMid, _oceanDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.flag, color: _amberHi, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Summary — when you see PointerMoveEvent',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _footerBullet('the pointer is currently in contact (down == true)'),
        _footerBullet('it is moving (delta is the per-sample displacement)'),
        _footerBullet('it carries the full per-sample geometry: '
            'position / localPosition / delta / localDelta / pressure / '
            'radii / orientation / tilt / buttons'),
        _footerBullet('synthesized events are framework-manufactured; '
            'original holds the source event when present'),
        _footerBullet('copyWith returns a fresh event; transformed pushes '
            'the local* views through a Matrix4 — global position / delta '
            'stay invariant'),
        _footerBullet('to consume it: GestureDetector for high-level '
            'gestures, Listener for raw events, RawGestureDetector for '
            'custom recognisers'),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'PointerMoveEvent — the drag-frame heartbeat of every Flutter '
            'gesture stream.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footerBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.chevron_right, color: _amberHi, size: 18.0),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SHARED — section shell used by every numbered section above.
// ============================================================================
Widget _sectionShell({
  required String title,
  required Color accent,
  required IconData icon,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _gridLine),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _oceanDeep.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: accent, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}
