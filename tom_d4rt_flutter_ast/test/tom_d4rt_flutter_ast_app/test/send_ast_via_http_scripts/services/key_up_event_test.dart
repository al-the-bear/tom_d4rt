// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyUpEvent from services
// Deep Demo: Visual demonstration of KeyUpEvent — physical/logical keys,
// device type, synthesized flag, lifecycle, and integration patterns.
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ===========================================================================
// PALETTE — cool slate/teal/amber Mac-keycap aesthetic
// ===========================================================================
const Color _kSlateDeep = Color(0xFF0F172A);
const Color _kSlateMid = Color(0xFF1E293B);
const Color _kSlateSoft = Color(0xFF334155);
const Color _kSlateMist = Color(0xFFE2E8F0);
const Color _kTealDeep = Color(0xFF0F766E);
const Color _kTealMid = Color(0xFF14B8A6);
const Color _kTealSoft = Color(0xFF99F6E4);
const Color _kAmberDeep = Color(0xFFB45309);
const Color _kAmberMid = Color(0xFFF59E0B);
const Color _kAmberSoft = Color(0xFFFEF3C7);
const Color _kRoseDeep = Color(0xFFBE123C);
const Color _kSkyDeep = Color(0xFF0369A1);
const Color _kSkyMid = Color(0xFF38BDF8);

// ===========================================================================
// build — single top-level entry point required by the D4rt sandbox.
// ===========================================================================
dynamic build(BuildContext context) {
  print('KeyUpEvent Deep Demo executing');

  // -------------------------------------------------------------------------
  // SECTION 0 — Construct a representative KeyUpEvent we'll reference throughout
  // -------------------------------------------------------------------------
  print('=== Section 0: anchor instance ===');
  final anchorEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: const Duration(milliseconds: 1842),
  );
  print('anchorEvent.runtimeType = ${anchorEvent.runtimeType}');
  print('anchorEvent.physicalKey = ${anchorEvent.physicalKey.debugName}');
  print('anchorEvent.logicalKey = ${anchorEvent.logicalKey.keyLabel}');
  print('anchorEvent.character = ${anchorEvent.character}');
  print('anchorEvent.timeStamp = ${anchorEvent.timeStamp}');
  print('anchorEvent.deviceType = ${anchorEvent.deviceType}');
  print('anchorEvent.synthesized = ${anchorEvent.synthesized}');

  // -------------------------------------------------------------------------
  // SECTION 1 — Title banner
  // -------------------------------------------------------------------------
  print('=== Section 1: title banner ===');
  final titleBanner = _buildTitleBanner();

  // -------------------------------------------------------------------------
  // SECTION 2 — Anatomy diagram
  // -------------------------------------------------------------------------
  print('=== Section 2: anatomy diagram ===');
  final anatomyDiagram = _buildAnatomyDiagram(anchorEvent);

  // -------------------------------------------------------------------------
  // SECTION 3 — Six instance gallery
  // -------------------------------------------------------------------------
  print('=== Section 3: six instance gallery ===');
  final shiftEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.shiftLeft,
    logicalKey: LogicalKeyboardKey.shift,
    timeStamp: const Duration(milliseconds: 120),
  );
  final ctrlEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.controlLeft,
    logicalKey: LogicalKeyboardKey.control,
    timeStamp: const Duration(milliseconds: 240),
  );
  final escEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.escape,
    logicalKey: LogicalKeyboardKey.escape,
    timeStamp: const Duration(milliseconds: 360),
  );
  final aEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: const Duration(milliseconds: 480),
  );
  final enterEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.enter,
    logicalKey: LogicalKeyboardKey.enter,
    timeStamp: const Duration(milliseconds: 600),
  );
  final spaceEvent = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.space,
    logicalKey: LogicalKeyboardKey.space,
    timeStamp: const Duration(milliseconds: 720),
  );

  print('Built 6 KeyUpEvent gallery instances');
  print('  shift   = ${shiftEvent.logicalKey.keyLabel}');
  print('  ctrl    = ${ctrlEvent.logicalKey.keyLabel}');
  print('  escape  = ${escEvent.logicalKey.keyLabel}');
  print('  a       = ${aEvent.character}');
  print('  enter   = ${enterEvent.logicalKey.keyLabel}');
  print('  space   = ${spaceEvent.logicalKey.keyLabel}');

  final galleryGrid = _buildGalleryGrid(<Map<String, Object?>>[
    {
      'event': shiftEvent,
      'label': 'Shift',
      'glyph': '⇧',
      'tone': _kTealMid,
      'kind': 'modifier',
    },
    {
      'event': ctrlEvent,
      'label': 'Control',
      'glyph': '⌃',
      'tone': _kTealDeep,
      'kind': 'modifier',
    },
    {
      'event': escEvent,
      'label': 'Escape',
      'glyph': 'esc',
      'tone': _kRoseDeep,
      'kind': 'control',
    },
    {
      'event': aEvent,
      'label': 'Letter A',
      'glyph': 'A',
      'tone': _kAmberMid,
      'kind': 'character',
    },
    {
      'event': enterEvent,
      'label': 'Return',
      'glyph': '⏎',
      'tone': _kSkyDeep,
      'kind': 'control',
    },
    {
      'event': spaceEvent,
      'label': 'Space',
      'glyph': '␣',
      'tone': _kSlateSoft,
      'kind': 'character',
    },
  ]);

  // -------------------------------------------------------------------------
  // SECTION 4 — KeyDown vs KeyUp vs KeyRepeat comparison table
  // -------------------------------------------------------------------------
  print('=== Section 4: comparison table ===');
  final comparisonTable = _buildComparisonTable();

  // -------------------------------------------------------------------------
  // SECTION 5 — PhysicalKey vs LogicalKey distinction
  // -------------------------------------------------------------------------
  print('=== Section 5: physical vs logical ===');
  final physicalLogicalSection = _buildPhysicalLogicalSection();

  // -------------------------------------------------------------------------
  // SECTION 6 — KeyEventDeviceType showcase
  // -------------------------------------------------------------------------
  print('=== Section 6: device type showcase ===');
  final deviceTypeSection = _buildDeviceTypeShowcase();

  // -------------------------------------------------------------------------
  // SECTION 7 — Real-world mock: virtual keyboard with release indicator
  // -------------------------------------------------------------------------
  print('=== Section 7: virtual keyboard mock ===');
  final virtualKeyboard = _buildVirtualKeyboard(anchorEvent);

  // -------------------------------------------------------------------------
  // SECTION 8 — Code block: HardwareKeyboard / Focus.onKeyEvent
  // -------------------------------------------------------------------------
  print('=== Section 8: code block ===');
  final codeBlock = _buildCodeBlock();

  // -------------------------------------------------------------------------
  // SECTION 9 — Lifecycle (down → repeat → up)
  // -------------------------------------------------------------------------
  print('=== Section 9: lifecycle ===');
  final lifecycle = _buildLifecycle();

  // -------------------------------------------------------------------------
  // SECTION 10 — Footgun cards
  // -------------------------------------------------------------------------
  print('=== Section 10: footguns ===');
  final footgunsSection = _buildFootguns();

  // -------------------------------------------------------------------------
  // SECTION 11 — Recap card
  // -------------------------------------------------------------------------
  print('=== Section 11: recap ===');
  final recap = _buildRecap();

  print('KeyUpEvent Deep Demo completed successfully');

  // -------------------------------------------------------------------------
  // Compose the layout: Scaffold → SingleChildScrollView → Column
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: _kSlateMist,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          const SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy of a KeyUpEvent', _kTealDeep),
          anatomyDiagram,
          const SizedBox(height: 28.0),
          _sectionHeader('2. Six KeyUpEvent instances', _kTealDeep),
          galleryGrid,
          const SizedBox(height: 28.0),
          _sectionHeader('3. KeyDown vs KeyUp vs KeyRepeat', _kSlateDeep),
          comparisonTable,
          const SizedBox(height: 28.0),
          _sectionHeader('4. Physical key vs Logical key', _kAmberDeep),
          physicalLogicalSection,
          const SizedBox(height: 28.0),
          _sectionHeader('5. KeyEventDeviceType showcase', _kSkyDeep),
          deviceTypeSection,
          const SizedBox(height: 28.0),
          _sectionHeader('6. Virtual keyboard — release in flight', _kTealDeep),
          virtualKeyboard,
          const SizedBox(height: 28.0),
          _sectionHeader('7. Integration code', _kSlateDeep),
          codeBlock,
          const SizedBox(height: 28.0),
          _sectionHeader('8. Key lifecycle', _kAmberDeep),
          lifecycle,
          const SizedBox(height: 28.0),
          _sectionHeader('9. Five footguns to avoid', _kRoseDeep),
          footgunsSection,
          const SizedBox(height: 28.0),
          _sectionHeader('10. Recap', _kTealDeep),
          recap,
          const SizedBox(height: 40.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION HEADER
// ===========================================================================
Widget _sectionHeader(String label, Color tone) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 28.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[tone, tone.withValues(alpha: 0.4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: tone,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 1. TITLE BANNER
// ===========================================================================
Widget _buildTitleBanner() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kSlateDeep, _kSlateMid, _kTealDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _kTealMid.withValues(alpha: 0.18),
          blurRadius: 36.0,
          offset: const Offset(0.0, 4.0),
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
                gradient: LinearGradient(
                  colors: <Color>[
                    _kTealMid.withValues(alpha: 0.4),
                    _kTealDeep.withValues(alpha: 0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: _kTealSoft.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                Icons.keyboard_alt_outlined,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'KeyUpEvent',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: <Shadow>[
                        Shadow(
                          color: _kSlateDeep.withValues(alpha: 0.6),
                          offset: const Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: _kTealSoft.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 14.0,
          ),
          decoration: BoxDecoration(
            color: _kSlateDeep.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kTealMid.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Text(
            'A KeyEvent dispatched the moment a key transitions from pressed '
            'to released. Subclass of KeyEvent, sibling to KeyDownEvent and '
            'KeyRepeatEvent.',
            style: TextStyle(
              fontSize: 14.0,
              height: 1.45,
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: <Widget>[
            _bannerChip('extends KeyEvent', _kTealMid),
            _bannerChip('hardware_keyboard', _kAmberMid),
            _bannerChip('synthesized? no', _kSkyMid),
            _bannerChip('immutable', _kTealSoft),
          ],
        ),
      ],
    ),
  );
}

Widget _bannerChip(String text, Color tone) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: tone.withValues(alpha: 0.55), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ===========================================================================
// 2. ANATOMY DIAGRAM
// ===========================================================================
Widget _buildAnatomyDiagram(KeyUpEvent anchor) {
  final List<Map<String, Object?>> fields = <Map<String, Object?>>[
    {
      'name': 'physicalKey',
      'value': anchor.physicalKey.debugName ?? '<unnamed>',
      'descr': 'The location on the keyboard hardware. Layout-independent.',
      'type': 'PhysicalKeyboardKey',
      'tone': _kTealDeep,
      'icon': Icons.location_on_outlined,
    },
    {
      'name': 'logicalKey',
      'value': anchor.logicalKey.keyLabel,
      'descr': 'The meaning produced by the active layout. Layout-aware.',
      'type': 'LogicalKeyboardKey',
      'tone': _kTealMid,
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'name': 'character',
      'value': anchor.character ?? 'null',
      'descr': 'Always null for KeyUpEvent — releases never produce text.',
      'type': 'String?',
      'tone': _kAmberMid,
      'icon': Icons.text_fields,
    },
    {
      'name': 'timeStamp',
      'value': '${anchor.timeStamp.inMilliseconds} ms',
      'descr': 'Engine-monotonic time. Use for press duration math.',
      'type': 'Duration',
      'tone': _kSkyDeep,
      'icon': Icons.schedule,
    },
    {
      'name': 'deviceType',
      'value': anchor.deviceType.name,
      'descr': 'Source category: keyboard, hid, directional, gamepad…',
      'type': 'KeyEventDeviceType',
      'tone': _kAmberDeep,
      'icon': Icons.devices_other,
    },
    {
      'name': 'synthesized',
      'value': anchor.synthesized.toString(),
      'descr': 'True when Flutter inferred the release (focus loss, etc.).',
      'type': 'bool',
      'tone': _kRoseDeep,
      'icon': Icons.science_outlined,
    },
  ];

  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Colors.white, _kSlateMist],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _kSlateSoft.withValues(alpha: 0.25), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.10),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: _kTealMid.withValues(alpha: 0.08),
          blurRadius: 28.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: _kSlateDeep,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.schema, color: _kTealSoft, size: 20.0),
              const SizedBox(width: 10.0),
              Text(
                'KeyUpEvent — six observable fields',
                style: TextStyle(
                  color: _kTealSoft,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        for (final field in fields) _anatomyRow(field),
      ],
    ),
  );
}

Widget _anatomyRow(Map<String, Object?> field) {
  final Color tone = field['tone'] as Color;
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tone.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[tone, tone.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tone.withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Icon(field['icon'] as IconData, color: Colors.white, size: 22.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    field['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: tone,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: tone.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      field['type'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: tone,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                field['descr'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kSlateSoft,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: _kSlateDeep,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '= ${field['value']}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: _kTealSoft,
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

// ===========================================================================
// 3. SIX-INSTANCE GALLERY
// ===========================================================================
Widget _buildGalleryGrid(List<Map<String, Object?>> entries) {
  final List<Widget> tiles = <Widget>[];
  for (final entry in entries) {
    tiles.add(_galleryTile(entry));
  }
  return Wrap(
    spacing: 14.0,
    runSpacing: 14.0,
    alignment: WrapAlignment.center,
    children: tiles,
  );
}

Widget _galleryTile(Map<String, Object?> entry) {
  final KeyUpEvent event = entry['event'] as KeyUpEvent;
  final String label = entry['label'] as String;
  final String glyph = entry['glyph'] as String;
  final Color tone = entry['tone'] as Color;
  final String kind = entry['kind'] as String;

  return Container(
    width: 180.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, tone.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tone.withValues(alpha: 0.55), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Mac-style keycap
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Colors.white, _kSlateMist],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kSlateSoft, width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kSlateDeep.withValues(alpha: 0.18),
                blurRadius: 6.0,
                offset: const Offset(0.0, 4.0),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.9),
                blurRadius: 2.0,
                offset: const Offset(0.0, -1.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              glyph,
              style: TextStyle(
                fontSize: glyph.length > 2 ? 22.0 : 38.0,
                fontWeight: FontWeight.w800,
                color: _kSlateDeep,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: tone,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: tone.withValues(alpha: 0.6),
                    blurRadius: 4.0,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _kSlateDeep,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                kind,
                style: TextStyle(
                  fontSize: 9.0,
                  color: tone,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _galleryRow('logical', event.logicalKey.keyLabel),
        _galleryRow('physical', event.physicalKey.debugName ?? '?'),
        _galleryRow('character', event.character ?? 'null'),
        _galleryRow('t', '${event.timeStamp.inMilliseconds}ms'),
      ],
    ),
  );
}

Widget _galleryRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 56.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 10.0,
              color: _kSlateSoft,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.0,
              color: _kSlateDeep,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 4. COMPARISON TABLE
// ===========================================================================
Widget _buildComparisonTable() {
  final List<Map<String, Object?>> rows = <Map<String, Object?>>[
    {
      'attr': 'Trigger',
      'down': 'Initial press transition',
      'up': 'Release transition',
      'repeat': 'OS auto-repeat tick',
    },
    {
      'attr': 'Has character',
      'down': 'Often',
      'up': 'Never (always null)',
      'repeat': 'Often',
    },
    {
      'attr': 'Frequency',
      'down': 'Once per press',
      'up': 'Once per press',
      'repeat': 'OS-defined cadence',
    },
    {
      'attr': 'Use to',
      'down': 'Activate / start gesture',
      'up': 'Commit / end gesture',
      'repeat': 'Auto-scroll, hold-to-fire',
    },
    {
      'attr': 'Synthesized',
      'down': 'Rare',
      'up': 'On focus loss / alt-tab',
      'repeat': 'No',
    },
    {
      'attr': 'Tracks state',
      'down': 'Adds key to pressed set',
      'up': 'Removes key from set',
      'repeat': 'Key stays pressed',
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSlateSoft.withValues(alpha: 0.3), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_kSlateDeep, _kSlateMid],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              _tableHeader('Attribute', 110.0, _kTealSoft),
              _tableHeader('KeyDownEvent', 0.0, _kAmberSoft, expanded: true),
              _tableHeader('KeyUpEvent', 0.0, _kTealSoft, expanded: true),
              _tableHeader(
                'KeyRepeatEvent',
                0.0,
                _kSkyMid,
                expanded: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? _kSlateMist.withValues(alpha: 0.4)
                  : Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _tableCell(
                  rows[i]['attr'] as String,
                  110.0,
                  _kSlateDeep,
                  bold: true,
                ),
                _tableCell(
                  rows[i]['down'] as String,
                  0.0,
                  _kAmberDeep,
                  expanded: true,
                ),
                _tableCell(
                  rows[i]['up'] as String,
                  0.0,
                  _kTealDeep,
                  expanded: true,
                  bold: true,
                ),
                _tableCell(
                  rows[i]['repeat'] as String,
                  0.0,
                  _kSkyDeep,
                  expanded: true,
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _tableHeader(
  String text,
  double width,
  Color color, {
  bool expanded = false,
}) {
  final Widget content = Text(
    text,
    style: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: 0.3,
    ),
  );
  if (expanded) {
    return Expanded(child: content);
  }
  return SizedBox(width: width, child: content);
}

Widget _tableCell(
  String text,
  double width,
  Color color, {
  bool expanded = false,
  bool bold = false,
}) {
  final Widget content = Text(
    text,
    style: TextStyle(
      fontSize: 11.5,
      color: color,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      height: 1.35,
    ),
  );
  if (expanded) {
    return Expanded(child: Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: content,
    ));
  }
  return SizedBox(width: width, child: content);
}

// ===========================================================================
// 5. PHYSICAL VS LOGICAL
// ===========================================================================
Widget _buildPhysicalLogicalSection() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _kAmberSoft.withValues(alpha: 0.6),
          Colors.white,
          _kTealSoft.withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _kAmberMid.withValues(alpha: 0.4), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kAmberMid.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Same hardware key, different layouts produce different logicals.',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: _kSlateDeep,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(child: _layoutCard('QWERTY', 'A', 'a', 'keyA', _kTealDeep)),
            const SizedBox(width: 12.0),
            Expanded(child: _layoutCard('AZERTY', 'A', 'q', 'keyA', _kAmberDeep)),
            const SizedBox(width: 12.0),
            Expanded(child: _layoutCard('Dvorak', 'A', 'a', 'keyA', _kSkyDeep)),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _kSlateDeep,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Rule of thumb',
                style: TextStyle(
                  color: _kAmberSoft,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                '• Use physicalKey for shortcuts that follow position (WASD, '
                'arrow keys, modifiers).\n'
                '• Use logicalKey for shortcuts that follow meaning '
                '(Ctrl+S regardless of mapping).\n'
                '• character mirrors logicalKey but only on KeyDown/KeyRepeat.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  height: 1.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _layoutCard(
  String layoutName,
  String physicalGlyph,
  String logicalGlyph,
  String physicalCode,
  Color tone,
) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tone.withValues(alpha: 0.5), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Text(
          layoutName,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            color: tone,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10.0),
        // Physical position
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Colors.white, _kSlateMist],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kSlateSoft, width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kSlateDeep.withValues(alpha: 0.18),
                blurRadius: 4.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              physicalGlyph,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: _kSlateDeep,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          physicalCode,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: _kSlateSoft,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'logical = "$logicalGlyph"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: tone,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 6. KEY EVENT DEVICE TYPE SHOWCASE
// ===========================================================================
Widget _buildDeviceTypeShowcase() {
  final List<Map<String, Object?>> devices = <Map<String, Object?>>[
    {
      'type': KeyEventDeviceType.keyboard,
      'label': 'keyboard',
      'icon': Icons.keyboard_alt_outlined,
      'descr': 'A traditional alphanumeric keyboard.',
      'tone': _kTealDeep,
    },
    {
      'type': KeyEventDeviceType.directionalPad,
      'label': 'directionalPad',
      'icon': Icons.dialpad_outlined,
      'descr': 'Phone d-pad / TV remote four-direction cluster.',
      'tone': _kAmberDeep,
    },
    {
      'type': KeyEventDeviceType.gamepad,
      'label': 'gamepad',
      'icon': Icons.sports_esports_outlined,
      'descr': 'Console-style gamepad buttons mapped to keys.',
      'tone': _kRoseDeep,
    },
    {
      'type': KeyEventDeviceType.joystick,
      'label': 'joystick',
      'icon': Icons.gamepad_outlined,
      'descr': 'Joystick / flight stick reporting key-style events.',
      'tone': _kSkyDeep,
    },
    {
      'type': KeyEventDeviceType.hdmi,
      'label': 'hdmi',
      'icon': Icons.cable_outlined,
      'descr': 'HDMI-CEC remote (TV / receiver).',
      'tone': _kTealMid,
    },
    {
      'type': KeyEventDeviceType.unknown,
      'label': 'unknown',
      'icon': Icons.help_outline,
      'descr': 'Source unspecified — treat as generic input.',
      'tone': _kSlateSoft,
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (final entry in devices) {
    cards.add(_deviceCard(entry));
  }

  return Wrap(spacing: 12.0, runSpacing: 12.0, children: cards);
}

Widget _deviceCard(Map<String, Object?> entry) {
  final Color tone = entry['tone'] as Color;
  final KeyEventDeviceType deviceType = entry['type'] as KeyEventDeviceType;
  // Construct an example KeyUpEvent with this deviceType (no setState — pure data).
  final KeyUpEvent example = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.enter,
    logicalKey: LogicalKeyboardKey.enter,
    timeStamp: const Duration(milliseconds: 1000),
    deviceType: deviceType,
  );
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, tone.withValues(alpha: 0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tone.withValues(alpha: 0.5), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withValues(alpha: 0.18),
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
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(entry['icon'] as IconData, color: tone, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                entry['label'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  color: tone,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          entry['descr'] as String,
          style: TextStyle(
            fontSize: 11.5,
            color: _kSlateSoft,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: _kSlateDeep,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'event.deviceType\n  = ${example.deviceType.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: _kTealSoft,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 7. VIRTUAL KEYBOARD
// ===========================================================================
Widget _buildVirtualKeyboard(KeyUpEvent releasedEvent) {
  // Top row of the QWERTY layout.
  const List<String> row1 = <String>['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
  const List<String> row2 = <String>['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  const List<String> row3 = <String>['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

  final String releasedLabel = releasedEvent.logicalKey.keyLabel.toUpperCase();

  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kSlateDeep, _kSlateMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _kTealMid.withValues(alpha: 0.18),
          blurRadius: 28.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Indicator strip
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 14.0,
          ),
          decoration: BoxDecoration(
            color: _kTealDeep.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kTealMid.withValues(alpha: 0.55),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: _kTealMid,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _kTealMid.withValues(alpha: 0.7),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'KeyUpEvent in flight: ',
                style: TextStyle(
                  color: _kTealSoft,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                releasedLabel,
                style: TextStyle(
                  color: _kAmberSoft,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const Spacer(),
              Text(
                't=${releasedEvent.timeStamp.inMilliseconds}ms',
                style: TextStyle(
                  color: _kSkyMid,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _kbRow(row1, releasedLabel),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: _kbRow(row2, releasedLabel),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: _kbRow(row3, releasedLabel),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: _kSlateDeep.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: _kSlateSoft.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              _kbLegend('idle', _kSlateMist),
              const SizedBox(width: 16.0),
              _kbLegend('just released', _kAmberMid),
              const SizedBox(width: 16.0),
              _kbLegend('still down', _kTealMid),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kbRow(List<String> labels, String releasedLabel) {
  final List<Widget> caps = <Widget>[];
  for (int i = 0; i < labels.length; i++) {
    final String l = labels[i];
    final bool isReleased = l == releasedLabel;
    caps.add(_keycap(l, isReleased));
    if (i < labels.length - 1) caps.add(const SizedBox(width: 6.0));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: caps,
  );
}

Widget _keycap(String label, bool justReleased) {
  final Color baseTop = justReleased ? _kAmberSoft : Colors.white;
  final Color baseBottom = justReleased ? _kAmberMid : _kSlateMist;
  final Color border = justReleased
      ? _kAmberDeep
      : _kSlateSoft.withValues(alpha: 0.7);
  final Color textColor = justReleased ? _kAmberDeep : _kSlateDeep;

  return Container(
    width: 36.0,
    height: 44.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[baseTop, baseBottom],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: border, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.45),
          blurRadius: 4.0,
          offset: const Offset(0.0, 3.0),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.85),
          blurRadius: 1.0,
          offset: const Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget _kbLegend(String label, Color tone) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
      ),
      const SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          color: _kSlateMist,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// ===========================================================================
// 8. CODE BLOCK
// ===========================================================================
Widget _buildCodeBlock() {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kSlateDeep,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: _kTealMid.withValues(alpha: 0.12),
          blurRadius: 20.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14.0),
            Text(
              'integration.dart',
              style: TextStyle(
                color: _kTealSoft,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeLine('// 1) Listen globally via HardwareKeyboard.', _kSlateMist),
        _codeLine('HardwareKeyboard.instance.addHandler((KeyEvent e) {', Colors.white),
        _codeLine('  if (e is KeyUpEvent) {', _kSkyMid),
        _codeLine('    debugPrint("released \${e.logicalKey.keyLabel}");', _kTealSoft),
        _codeLine('  }', _kSkyMid),
        _codeLine('  return false;', Colors.white),
        _codeLine('});', Colors.white),
        const SizedBox(height: 12.0),
        _codeLine('// 2) Scoped listener via Focus.', _kSlateMist),
        _codeLine('Focus(', Colors.white),
        _codeLine('  autofocus: true,', Colors.white),
        _codeLine('  onKeyEvent: (FocusNode node, KeyEvent e) {', Colors.white),
        _codeLine('    if (e is KeyUpEvent &&', _kSkyMid),
        _codeLine('        e.logicalKey == LogicalKeyboardKey.escape) {', _kSkyMid),
        _codeLine('      Navigator.of(context).maybePop();', _kAmberSoft),
        _codeLine('      return KeyEventResult.handled;', _kAmberSoft),
        _codeLine('    }', _kSkyMid),
        _codeLine('    return KeyEventResult.ignored;', Colors.white),
        _codeLine('  },', Colors.white),
        _codeLine('  child: child,', Colors.white),
        _codeLine(');', Colors.white),
        const SizedBox(height: 12.0),
        _codeLine('// 3) KeyboardListener — declarative widget form.', _kSlateMist),
        _codeLine('KeyboardListener(', Colors.white),
        _codeLine('  focusNode: focusNode,', Colors.white),
        _codeLine('  onKeyEvent: (KeyEvent e) {', Colors.white),
        _codeLine('    if (e is KeyUpEvent && !e.synthesized) {', _kSkyMid),
        _codeLine('      onUserReleased(e);', _kTealSoft),
        _codeLine('    }', _kSkyMid),
        _codeLine('  },', Colors.white),
        _codeLine('  child: child,', Colors.white),
        _codeLine(');', Colors.white),
      ],
    ),
  );
}

Widget _codeLine(String text, Color tone) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: tone,
        height: 1.45,
      ),
    ),
  );
}

// ===========================================================================
// 9. LIFECYCLE (down → repeat → up)
// ===========================================================================
Widget _buildLifecycle() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.white,
          _kAmberSoft.withValues(alpha: 0.45),
          _kTealSoft.withValues(alpha: 0.45),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _kAmberDeep.withValues(alpha: 0.3), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kAmberDeep.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Down → (Repeat) → Up',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: _kSlateDeep,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _lifecycleNode(
                'KeyDownEvent',
                't = 0 ms',
                'character: "a"',
                _kAmberDeep,
                Icons.arrow_downward,
              ),
            ),
            _lifecycleArrow(),
            Expanded(
              child: _lifecycleNode(
                'KeyRepeatEvent',
                't = 350 ms',
                'character: "a"',
                _kSkyDeep,
                Icons.repeat,
              ),
            ),
            _lifecycleArrow(),
            Expanded(
              child: _lifecycleNode(
                'KeyUpEvent',
                't = 612 ms',
                'character: null',
                _kTealDeep,
                Icons.arrow_upward,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _lifecycleTimeline(),
      ],
    ),
  );
}

Widget _lifecycleNode(
  String title,
  String timeLabel,
  String detail,
  Color tone,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tone.withValues(alpha: 0.55), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: tone, size: 22.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            color: tone,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          timeLabel,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: _kSlateSoft,
          ),
        ),
        Text(
          detail,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: _kSlateDeep,
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: Icon(Icons.arrow_forward, color: _kSlateSoft, size: 22.0),
  );
}

Widget _lifecycleTimeline() {
  return Container(
    height: 36.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kSlateSoft.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _kAmberDeep.withValues(alpha: 0.2),
                  _kAmberMid.withValues(alpha: 0.4),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Text(
                'down',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: _kAmberDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _kSkyDeep.withValues(alpha: 0.2),
                  _kSkyMid.withValues(alpha: 0.35),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Text(
                'repeat × N',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: _kSkyDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  _kTealMid.withValues(alpha: 0.4),
                  _kTealDeep.withValues(alpha: 0.5),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Text(
                'up',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 10. FOOTGUNS
// ===========================================================================
Widget _buildFootguns() {
  final List<Map<String, Object?>> footguns = <Map<String, Object?>>[
    {
      'title': 'Synthesized releases',
      'body':
          'On focus loss, alt-tab, or window deactivation Flutter will fire '
          'KeyUpEvent with synthesized=true so its tracking stays consistent. '
          'Filter on synthesized if you only want real user releases.',
      'tone': _kRoseDeep,
      'icon': Icons.psychology_alt_outlined,
    },
    {
      'title': 'character is always null on KeyUp',
      'body':
          'KeyUpEvent.character is contractually null because a release '
          'produces no glyph. If you read text input, sample it on KeyDown / '
          'KeyRepeat instead.',
      'tone': _kAmberDeep,
      'icon': Icons.text_decrease,
    },
    {
      'title': 'Layout-dependent character',
      'body':
          'Even on KeyDownEvent the character depends on the OS layout. Map '
          'shortcuts via logicalKey or physicalKey explicitly — never via '
          'event.character == "s".',
      'tone': _kAmberMid,
      'icon': Icons.translate,
    },
    {
      'title': 'Forgetting deviceType',
      'body':
          'A gamepad button can arrive as a KeyUpEvent with '
          'deviceType=KeyEventDeviceType.gamepad. Filter it out of text-input '
          'shortcuts unless you really mean to consume gamepad keys.',
      'tone': _kSkyDeep,
      'icon': Icons.sports_esports_outlined,
    },
    {
      'title': 'Order with HardwareKeyboard.pressed',
      'body':
          'Inside an addHandler callback, the pressed-key set is updated '
          'after the handler returns for KeyUpEvent. Read state with care '
          'when reasoning about which keys are still down.',
      'tone': _kTealDeep,
      'icon': Icons.layers_outlined,
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (final fg in footguns) {
    cards.add(_footgunCard(fg));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

Widget _footgunCard(Map<String, Object?> entry) {
  final Color tone = entry['tone'] as Color;
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, tone.withValues(alpha: 0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border(
        left: BorderSide(color: tone, width: 5.0),
        top: BorderSide(color: tone.withValues(alpha: 0.25), width: 1.0),
        right: BorderSide(color: tone.withValues(alpha: 0.25), width: 1.0),
        bottom: BorderSide(color: tone.withValues(alpha: 0.25), width: 1.0),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tone.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[tone, tone.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tone.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(entry['icon'] as IconData, color: Colors.white, size: 22.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry['title'] as String,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: tone,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                entry['body'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kSlateDeep,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// 11. RECAP
// ===========================================================================
Widget _buildRecap() {
  final List<Map<String, Object?>> bullets = <Map<String, Object?>>[
    {
      'icon': Icons.check_circle_outline,
      'tone': _kTealDeep,
      'text':
          'KeyUpEvent fires once when a key is released. character is always null.',
    },
    {
      'icon': Icons.layers_outlined,
      'tone': _kTealMid,
      'text':
          'It is a sibling of KeyDownEvent and KeyRepeatEvent, all extending KeyEvent.',
    },
    {
      'icon': Icons.location_on_outlined,
      'tone': _kAmberDeep,
      'text':
          'Use physicalKey for position-based shortcuts; logicalKey for meaning-based ones.',
    },
    {
      'icon': Icons.devices_other,
      'tone': _kSkyDeep,
      'text':
          'deviceType lets you discriminate keyboard, gamepad, dpad, joystick, hdmi, unknown.',
    },
    {
      'icon': Icons.science_outlined,
      'tone': _kRoseDeep,
      'text':
          'synthesized=true means Flutter inferred the release — handle or filter accordingly.',
    },
    {
      'icon': Icons.code,
      'tone': _kSlateDeep,
      'text':
          'Plug in via HardwareKeyboard.addHandler, Focus.onKeyEvent, or KeyboardListener.',
    },
  ];

  final List<Widget> rows = <Widget>[];
  for (final b in bullets) {
    rows.add(_recapBullet(b));
  }

  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kSlateDeep, _kTealDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSlateDeep.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _kTealMid.withValues(alpha: 0.2),
          blurRadius: 28.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.bookmark_outline, color: _kAmberSoft, size: 24.0),
            const SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ...rows,
      ],
    ),
  );
}

Widget _recapBullet(Map<String, Object?> entry) {
  final Color tone = entry['tone'] as Color;
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: tone.withValues(alpha: 0.7), width: 1.0),
          ),
          child: Icon(entry['icon'] as IconData, color: Colors.white, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            entry['text'] as String,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
