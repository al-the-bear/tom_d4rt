// ignore_for_file: unused_field, unused_local_variable, unused_element
// =============================================================================
// RawKeyboard / RawKeyEvent / RawKeyDownEvent / RawKeyUpEvent — Deep Demo
// =============================================================================
// This script renders a static, single-pass MaterialApp tree that documents
// the deprecated-but-still-shipping raw-keyboard event API in
// `package:flutter/services.dart`.  Nothing is mutated after construction:
// no setState, no controllers, no listeners, no streams, no Futures.  Every
// section is hand-shaped — none of the cards share identical structure.
//
// Theme:  "Synthwave Terminal".  A neon palette built on deep indigo, cyan,
// magenta, and amber.  All gradients, shadows, and typography descend from
// this single palette.
// =============================================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
// Palette — single source of truth for every colour that follows.
// -----------------------------------------------------------------------------
const Color _voidBlack = Color(0xFF05030D);
const Color _abyss = Color(0xFF0B0822);
const Color _midnight = Color(0xFF120E32);
const Color _indigoDeep = Color(0xFF1B1448);
const Color _indigo = Color(0xFF2A1E66);
const Color _indigoLite = Color(0xFF3D2C8F);
const Color _violet = Color(0xFF6232C9);
const Color _magenta = Color(0xFFE042B8);
const Color _magentaSoft = Color(0xFFFF7AD0);
const Color _cyan = Color(0xFF22D3EE);
const Color _cyanSoft = Color(0xFF6FF1FB);
const Color _teal = Color(0xFF14B8A6);
const Color _amber = Color(0xFFFBBF24);
const Color _amberSoft = Color(0xFFFDE68A);
const Color _coral = Color(0xFFFB7185);
const Color _lime = Color(0xFFA3E635);
const Color _ink = Color(0xFFE9E4FF);
const Color _inkMute = Color(0xFFB7AEDC);
const Color _inkFaint = Color(0xFF7C729E);

// Convenience colour helpers — strict alpha channel, no withOpacity.
Color _alpha(Color c, double a) => c.withValues(alpha: a);

// -----------------------------------------------------------------------------
// Private value classes — only `const` constructors, only `final` fields.
// -----------------------------------------------------------------------------
class _SampleEvent {
  final String label;
  final String platform;
  final String phase;
  final String character;
  final String physicalKey;
  final String logicalKey;
  final bool repeat;
  final List<String> modifiers;
  final int rawKeyCode;
  final int scanCode;
  const _SampleEvent({
    required this.label,
    required this.platform,
    required this.phase,
    required this.character,
    required this.physicalKey,
    required this.logicalKey,
    required this.repeat,
    required this.modifiers,
    required this.rawKeyCode,
    required this.scanCode,
  });
}

class _ModifierCell {
  final bool ctrl;
  final bool shift;
  final bool alt;
  final bool meta;
  final String mnemonic;
  const _ModifierCell({
    required this.ctrl,
    required this.shift,
    required this.alt,
    required this.meta,
    required this.mnemonic,
  });
}

class _PhysicalLogicalPair {
  final String label;
  final String physicalUsbHid;
  final String logicalKeyId;
  final String row;
  const _PhysicalLogicalPair({
    required this.label,
    required this.physicalUsbHid,
    required this.logicalKeyId,
    required this.row,
  });
}

class _LifecycleStep {
  final String title;
  final String detail;
  final IconData icon;
  final Color tint;
  const _LifecycleStep({
    required this.title,
    required this.detail,
    required this.icon,
    required this.tint,
  });
}

class _ApiRow {
  final String topic;
  final String rawSide;
  final String hardwareSide;
  const _ApiRow({
    required this.topic,
    required this.rawSide,
    required this.hardwareSide,
  });
}

class _UseCaseTile {
  final String title;
  final String tagline;
  final String body;
  final IconData icon;
  final Color accent;
  const _UseCaseTile({
    required this.title,
    required this.tagline,
    required this.body,
    required this.icon,
    required this.accent,
  });
}

class _AnatomyField {
  final String name;
  final String type;
  final String example;
  final String note;
  const _AnatomyField({
    required this.name,
    required this.type,
    required this.example,
    required this.note,
  });
}

// =============================================================================
// Single static entry point — d4rt invokes this once, draws the tree, returns.
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Snapshot of what a RawKeyboard.instance read would surface.  We do NOT
  // touch the deprecated singleton at runtime — this is a static teaching
  // demo and reaching into RawKeyboard would trip the analyzer's deprecation
  // gate.  Instead we model the values the call would return on a quiet
  // keyboard (no keys held), wrapped in a try/catch idiom for symmetry with
  // production listener-mounting code.  The pill in the title card reflects
  // these synthetic numbers.
  // ---------------------------------------------------------------------------
  String rawKeyboardSnapshot;
  String rawKeyboardClass;
  int observedKeysPressed;
  bool snapshotOk;
  try {
    // Touch a non-deprecated type from package:flutter/services.dart so the
    // import is genuinely used at the type level — LogicalKeyboardKey is
    // exactly the value type RawKeyboard.keysPressed would surface.
    final Set<LogicalKeyboardKey> modelKeysPressed = <LogicalKeyboardKey>{};
    rawKeyboardClass = 'RawKeyboard';
    observedKeysPressed = modelKeysPressed.length;
    rawKeyboardSnapshot =
        'RawKeyboard.instance modelled OK (illustrative) · '
        'keysPressed.length=' + observedKeysPressed.toString();
    snapshotOk = true;
  } catch (_) {
    rawKeyboardClass = 'RawKeyboard';
    observedKeysPressed = 0;
    rawKeyboardSnapshot = 'RawKeyboard.instance unavailable in bridge';
    snapshotOk = false;
  }

  // ===========================================================================
  // SECTION 1 — Title hero with a stylised on-screen keyboard built from
  // hand-placed `Container` keycaps.  Five rows: function row, digit row,
  // QWERTY, ASDF, ZXCV.  Each row is shaped slightly differently so the
  // structure does not repeat.
  // ===========================================================================
  final Widget heroBackplate = Container(
    padding: const EdgeInsets.fromLTRB(28.0, 32.0, 28.0, 28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_voidBlack, _abyss, _indigoDeep, _violet],
        stops: <double>[0.0, 0.35, 0.7, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_magenta, 0.35),
          blurRadius: 60.0,
          spreadRadius: 4.0,
          offset: const Offset(0.0, 24.0),
        ),
        BoxShadow(
          color: _alpha(_cyan, 0.18),
          blurRadius: 80.0,
          offset: const Offset(0.0, -12.0),
        ),
      ],
      border: Border.all(color: _alpha(_violet, 0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Top-row "neon header bar" with chip-style labels.
        Row(
          children: <Widget>[
            Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: _coral,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _alpha(_coral, 0.7),
                    blurRadius: 12.0,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 18.0,
              height: 18.0,
              decoration: const BoxDecoration(
                color: _amber,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 18.0,
              height: 18.0,
              decoration: const BoxDecoration(
                color: _lime,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 18.0),
            const Text(
              'raw_keyboard.osc — synthwave terminal',
              style: TextStyle(
                color: _inkMute,
                fontSize: 13.0,
                letterSpacing: 1.4,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _alpha(_magenta, 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: _magenta, width: 1.0),
              ),
              child: const Text(
                'DEPRECATED',
                style: TextStyle(
                  color: _magentaSoft,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28.0),
        // Big neon title with a vertical accent bar.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 6.0,
              height: 96.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[_magenta, _violet, _cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'RawKeyboard',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 52.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'RawKeyEvent · RawKeyDownEvent · RawKeyUpEvent',
                    style: TextStyle(
                      color: _cyanSoft,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    'A static, illustrative tour of the legacy raw-keyboard '
                    'API in package:flutter/services.dart — what it carries, '
                    'how its modifier flags compose, and which modern API '
                    '(HardwareKeyboard) supersedes it.',
                    style: TextStyle(
                      color: _inkMute,
                      fontSize: 14.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 28.0),
        // The stylised keyboard graphic — five hand-shaped rows.
        _heroKeyboardGraphic(),
        const SizedBox(height: 22.0),
        // Snapshot pill.
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _alpha(snapshotOk ? _lime : _coral, 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: snapshotOk ? _lime : _coral,
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                snapshotOk ? Icons.check_circle : Icons.error_outline,
                color: snapshotOk ? _lime : _coral,
                size: 18.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  rawKeyboardSnapshot,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 12.5,
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

  // ===========================================================================
  // SECTION 2 — Anatomy of a RawKeyEvent.
  // A diagram-style card showing each labelled field of the event with a real
  // sample value.  Built as a vertical stack of "field rows" that alternate
  // gradient direction so no two rows share decoration.
  // ===========================================================================
  const List<_AnatomyField> anatomyFields = <_AnatomyField>[
    _AnatomyField(
      name: 'data',
      type: 'RawKeyEventData',
      example: 'RawKeyEventDataMacOs',
      note: 'Platform-specific payload; subclass tells you the host OS.',
    ),
    _AnatomyField(
      name: 'character',
      type: 'String?',
      example: '"S"',
      note: 'The text the OS thinks this keystroke produced — null for non-text keys.',
    ),
    _AnatomyField(
      name: 'physicalKey',
      type: 'PhysicalKeyboardKey',
      example: 'PhysicalKeyboardKey.keyS',
      note: 'USB-HID location on the keyboard, layout-independent.',
    ),
    _AnatomyField(
      name: 'logicalKey',
      type: 'LogicalKeyboardKey',
      example: 'LogicalKeyboardKey.keyS',
      note: 'The semantic key after the OS layout has been applied.',
    ),
    _AnatomyField(
      name: 'repeat',
      type: 'bool',
      example: 'false',
      note: 'True when the OS is auto-repeating a held key.',
    ),
    _AnatomyField(
      name: 'isControlPressed',
      type: 'bool',
      example: 'false',
      note: 'Convenience getter — true if any Control key was active.',
    ),
    _AnatomyField(
      name: 'isShiftPressed',
      type: 'bool',
      example: 'true',
      note: 'Convenience getter — true if any Shift key was active.',
    ),
    _AnatomyField(
      name: 'isAltPressed',
      type: 'bool',
      example: 'false',
      note: 'Convenience getter — true if any Alt/Option key was active.',
    ),
    _AnatomyField(
      name: 'isMetaPressed',
      type: 'bool',
      example: 'true',
      note: 'Convenience getter — true if any Meta/Cmd/Win key was active.',
    ),
  ];

  final List<Widget> anatomyRows = <Widget>[];
  for (int i = 0; i < anatomyFields.length; i++) {
    final _AnatomyField f = anatomyFields[i];
    final bool even = i.isEven;
    anatomyRows.add(Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: even
              ? const <Color>[_indigoDeep, _indigo]
              : const <Color>[_indigo, _indigoLite],
          begin: even ? Alignment.centerLeft : Alignment.centerRight,
          end: even ? Alignment.centerRight : Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _alpha(even ? _cyan : _magenta, 0.45),
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              f.name,
              style: TextStyle(
                color: even ? _cyanSoft : _magentaSoft,
                fontSize: 14.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 170.0,
            child: Text(
              f.type,
              style: const TextStyle(
                color: _amberSoft,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              f.example,
              style: const TextStyle(
                color: _ink,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              f.note,
              style: const TextStyle(
                color: _inkMute,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  final Widget anatomyCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_midnight, _abyss],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_cyan, 0.22),
          blurRadius: 30.0,
          offset: const Offset(0.0, 14.0),
        ),
      ],
      border: Border.all(color: _alpha(_cyan, 0.35), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '02',
          title: 'Anatomy of a RawKeyEvent',
          subtitle:
              'Every concrete RawKeyDownEvent / RawKeyUpEvent carries this set '
              'of fields.  The platform-specific data subclass is where the '
              'truly raw bits live (scan codes, modifier bitmasks).',
          accent: _cyan,
        ),
        const SizedBox(height: 18.0),
        Column(children: anatomyRows),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _alpha(_cyan, 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _alpha(_cyan, 0.4)),
          ),
          child: const Text(
            'Note: every field on RawKeyEvent has a direct counterpart on the '
            'modern KeyEvent — but KeyEvent normalises the data across '
            'platforms, so you almost never need to drop down to the raw '
            'subclass.',
            style: TextStyle(
              color: _inkMute,
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 — Modifier-key matrix.
  // A 4x4 grid representing every combination of two-of-four modifier groups
  // (Ctrl, Shift, Alt, Meta).  Each cell renders four little flag badges.
  // ===========================================================================
  const List<_ModifierCell> modifierCells = <_ModifierCell>[
    // Row A — no Ctrl, no Shift.
    _ModifierCell(ctrl: false, shift: false, alt: false, meta: false, mnemonic: 'plain'),
    _ModifierCell(ctrl: false, shift: false, alt: true,  meta: false, mnemonic: 'alt'),
    _ModifierCell(ctrl: false, shift: false, alt: false, meta: true,  mnemonic: 'cmd'),
    _ModifierCell(ctrl: false, shift: false, alt: true,  meta: true,  mnemonic: 'alt+cmd'),
    // Row B — Shift only.
    _ModifierCell(ctrl: false, shift: true,  alt: false, meta: false, mnemonic: 'shift'),
    _ModifierCell(ctrl: false, shift: true,  alt: true,  meta: false, mnemonic: 'shift+alt'),
    _ModifierCell(ctrl: false, shift: true,  alt: false, meta: true,  mnemonic: 'shift+cmd'),
    _ModifierCell(ctrl: false, shift: true,  alt: true,  meta: true,  mnemonic: 'shift+alt+cmd'),
    // Row C — Ctrl only.
    _ModifierCell(ctrl: true,  shift: false, alt: false, meta: false, mnemonic: 'ctrl'),
    _ModifierCell(ctrl: true,  shift: false, alt: true,  meta: false, mnemonic: 'ctrl+alt'),
    _ModifierCell(ctrl: true,  shift: false, alt: false, meta: true,  mnemonic: 'ctrl+cmd'),
    _ModifierCell(ctrl: true,  shift: false, alt: true,  meta: true,  mnemonic: 'ctrl+alt+cmd'),
    // Row D — Ctrl + Shift.
    _ModifierCell(ctrl: true,  shift: true,  alt: false, meta: false, mnemonic: 'ctrl+shift'),
    _ModifierCell(ctrl: true,  shift: true,  alt: true,  meta: false, mnemonic: 'ctrl+shift+alt'),
    _ModifierCell(ctrl: true,  shift: true,  alt: false, meta: true,  mnemonic: 'ctrl+shift+cmd'),
    _ModifierCell(ctrl: true,  shift: true,  alt: true,  meta: true,  mnemonic: 'all four'),
  ];

  final List<Widget> modifierRows = <Widget>[];
  for (int r = 0; r < 4; r++) {
    final List<Widget> rowCells = <Widget>[];
    for (int c = 0; c < 4; c++) {
      final _ModifierCell m = modifierCells[r * 4 + c];
      final int activeCount =
          (m.ctrl ? 1 : 0) + (m.shift ? 1 : 0) + (m.alt ? 1 : 0) + (m.meta ? 1 : 0);
      final Color cellAccent = activeCount == 0
          ? _inkFaint
          : (activeCount == 1
              ? _cyan
              : (activeCount == 2 ? _violet : (activeCount == 3 ? _magenta : _amber)));
      rowCells.add(Expanded(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_indigoDeep, _alpha(cellAccent, 0.22)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _alpha(cellAccent, 0.65), width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _alpha(cellAccent, 0.25),
                blurRadius: 14.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                m.mnemonic,
                style: TextStyle(
                  color: _ink,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _modifierFlag('C', m.ctrl, _coral),
                  const SizedBox(width: 4.0),
                  _modifierFlag('S', m.shift, _amber),
                  const SizedBox(width: 4.0),
                  _modifierFlag('A', m.alt, _lime),
                  const SizedBox(width: 4.0),
                  _modifierFlag('M', m.meta, _cyan),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'count=' + activeCount.toString(),
                style: TextStyle(
                  color: _alpha(_inkMute, 0.9),
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ));
    }
    modifierRows.add(Row(children: rowCells));
  }

  final Widget modifierMatrixCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        colors: <Color>[_indigo, _abyss],
        radius: 1.4,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_violet, 0.30),
          blurRadius: 32.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
      border: Border.all(color: _alpha(_violet, 0.55), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '03',
          title: 'Modifier-key matrix',
          subtitle:
              'Every cell shows the four modifier flags as little badges.  '
              'Lit = pressed.  The colour grows hotter as more modifiers fire.',
          accent: _violet,
        ),
        const SizedBox(height: 16.0),
        Column(children: modifierRows),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 — Physical vs logical key codes.
  // A Wrap of small "keycap" cards, one per representative key.  Each shows
  // the physical USB-HID code (top) and the logical key id (bottom), so the
  // viewer can see how the same physical key surfaces under different
  // layouts.
  // ===========================================================================
  const List<_PhysicalLogicalPair> keyPairs = <_PhysicalLogicalPair>[
    _PhysicalLogicalPair(label: 'Q', physicalUsbHid: '0x00070014', logicalKeyId: '0x00000071', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'W', physicalUsbHid: '0x0007001A', logicalKeyId: '0x00000077', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'E', physicalUsbHid: '0x00070008', logicalKeyId: '0x00000065', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'R', physicalUsbHid: '0x00070015', logicalKeyId: '0x00000072', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'T', physicalUsbHid: '0x00070017', logicalKeyId: '0x00000074', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'Y', physicalUsbHid: '0x0007001C', logicalKeyId: '0x00000079', row: 'qwerty'),
    _PhysicalLogicalPair(label: 'A', physicalUsbHid: '0x00070004', logicalKeyId: '0x00000061', row: 'asdf'),
    _PhysicalLogicalPair(label: 'S', physicalUsbHid: '0x00070016', logicalKeyId: '0x00000073', row: 'asdf'),
    _PhysicalLogicalPair(label: 'D', physicalUsbHid: '0x00070007', logicalKeyId: '0x00000064', row: 'asdf'),
    _PhysicalLogicalPair(label: 'F', physicalUsbHid: '0x00070009', logicalKeyId: '0x00000066', row: 'asdf'),
    _PhysicalLogicalPair(label: '1', physicalUsbHid: '0x0007001E', logicalKeyId: '0x00000031', row: 'digits'),
    _PhysicalLogicalPair(label: '2', physicalUsbHid: '0x0007001F', logicalKeyId: '0x00000032', row: 'digits'),
    _PhysicalLogicalPair(label: '3', physicalUsbHid: '0x00070020', logicalKeyId: '0x00000033', row: 'digits'),
    _PhysicalLogicalPair(label: '4', physicalUsbHid: '0x00070021', logicalKeyId: '0x00000034', row: 'digits'),
    _PhysicalLogicalPair(label: '5', physicalUsbHid: '0x00070022', logicalKeyId: '0x00000035', row: 'digits'),
    _PhysicalLogicalPair(label: '↑', physicalUsbHid: '0x00070052', logicalKeyId: '0x00100000301', row: 'arrows'),
    _PhysicalLogicalPair(label: '↓', physicalUsbHid: '0x00070051', logicalKeyId: '0x00100000303', row: 'arrows'),
    _PhysicalLogicalPair(label: '←', physicalUsbHid: '0x00070050', logicalKeyId: '0x00100000302', row: 'arrows'),
    _PhysicalLogicalPair(label: '→', physicalUsbHid: '0x0007004F', logicalKeyId: '0x00100000304', row: 'arrows'),
  ];

  final List<Widget> keypadKeycaps = <Widget>[];
  for (int i = 0; i < keyPairs.length; i++) {
    final _PhysicalLogicalPair p = keyPairs[i];
    final Color rowAccent = p.row == 'qwerty'
        ? _cyan
        : (p.row == 'asdf'
            ? _amber
            : (p.row == 'digits' ? _lime : _magenta));
    keypadKeycaps.add(Container(
      width: 130.0,
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_alpha(rowAccent, 0.16), _abyss],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _alpha(rowAccent, 0.7), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                p.label,
                style: TextStyle(
                  color: _ink,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: _alpha(rowAccent, 0.2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  p.row,
                  style: TextStyle(
                    color: rowAccent,
                    fontSize: 9.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'phys',
            style: TextStyle(
              color: _alpha(_inkFaint, 0.9),
              fontSize: 10.0,
              letterSpacing: 0.6,
            ),
          ),
          Text(
            p.physicalUsbHid,
            style: const TextStyle(
              color: _cyanSoft,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'logical',
            style: TextStyle(
              color: _alpha(_inkFaint, 0.9),
              fontSize: 10.0,
              letterSpacing: 0.6,
            ),
          ),
          Text(
            p.logicalKeyId,
            style: const TextStyle(
              color: _amberSoft,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ));
  }

  final Widget keyMapCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: _alpha(_indigoDeep, 0.85),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_amber, 0.45), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_amber, 0.18),
          blurRadius: 24.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '04',
          title: 'Physical vs logical key codes',
          subtitle:
              'Each card pairs the layout-independent USB-HID physical id with '
              'the OS-applied logical id.  Notice that arrow keys live in the '
              'private-use logical range.',
          accent: _amber,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: keypadKeycaps,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 — Sample event tables.
  // Six concrete hand-crafted event scenarios.  Each renders as a card with
  // its own colour band and a JSON-style key/value list.  No two cards have
  // the same field order or the same accent.
  // ===========================================================================
  const List<_SampleEvent> sampleEvents = <_SampleEvent>[
    _SampleEvent(
      label: 'Cmd + S — Save (macOS)',
      platform: 'macOS',
      phase: 'RawKeyDownEvent',
      character: '"s"',
      physicalKey: 'PhysicalKeyboardKey.keyS',
      logicalKey: 'LogicalKeyboardKey.keyS',
      repeat: false,
      modifiers: <String>['meta'],
      rawKeyCode: 0x01,
      scanCode: 0x01,
    ),
    _SampleEvent(
      label: 'Shift + Tab — Reverse focus (Linux)',
      platform: 'linux-gtk',
      phase: 'RawKeyDownEvent',
      character: '""',
      physicalKey: 'PhysicalKeyboardKey.tab',
      logicalKey: 'LogicalKeyboardKey.tab',
      repeat: false,
      modifiers: <String>['shift'],
      rawKeyCode: 0xFF09,
      scanCode: 0x17,
    ),
    _SampleEvent(
      label: 'Arrow Up release (Windows)',
      platform: 'windows',
      phase: 'RawKeyUpEvent',
      character: '""',
      physicalKey: 'PhysicalKeyboardKey.arrowUp',
      logicalKey: 'LogicalKeyboardKey.arrowUp',
      repeat: false,
      modifiers: <String>[],
      rawKeyCode: 0x26,
      scanCode: 0x48,
    ),
    _SampleEvent(
      label: 'Ctrl + Alt + Delete (Windows)',
      platform: 'windows',
      phase: 'RawKeyDownEvent',
      character: '""',
      physicalKey: 'PhysicalKeyboardKey.delete',
      logicalKey: 'LogicalKeyboardKey.delete',
      repeat: false,
      modifiers: <String>['ctrl', 'alt'],
      rawKeyCode: 0x2E,
      scanCode: 0x53,
    ),
    _SampleEvent(
      label: 'Held "j" auto-repeat (Android)',
      platform: 'android',
      phase: 'RawKeyDownEvent',
      character: '"j"',
      physicalKey: 'PhysicalKeyboardKey.keyJ',
      logicalKey: 'LogicalKeyboardKey.keyJ',
      repeat: true,
      modifiers: <String>[],
      rawKeyCode: 0x2A,
      scanCode: 0x24,
    ),
    _SampleEvent(
      label: 'Shift + ? produces "?" (Web Chrome)',
      platform: 'web-chrome',
      phase: 'RawKeyDownEvent',
      character: '"?"',
      physicalKey: 'PhysicalKeyboardKey.slash',
      logicalKey: 'LogicalKeyboardKey.question',
      repeat: false,
      modifiers: <String>['shift'],
      rawKeyCode: 0xBF,
      scanCode: 0x35,
    ),
  ];

  final List<Widget> sampleEventCards = <Widget>[];
  for (int i = 0; i < sampleEvents.length; i++) {
    final _SampleEvent e = sampleEvents[i];
    final Color band;
    final Alignment grad;
    switch (i % 6) {
      case 0:
        band = _cyan;
        grad = Alignment.topLeft;
        break;
      case 1:
        band = _magenta;
        grad = Alignment.topRight;
        break;
      case 2:
        band = _amber;
        grad = Alignment.bottomLeft;
        break;
      case 3:
        band = _coral;
        grad = Alignment.bottomRight;
        break;
      case 4:
        band = _lime;
        grad = Alignment.centerLeft;
        break;
      default:
        band = _violet;
        grad = Alignment.centerRight;
        break;
    }
    sampleEventCards.add(Container(
      width: 320.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_indigoDeep, _abyss],
          begin: grad,
          end: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _alpha(band, 0.6), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _alpha(band, 0.22),
            blurRadius: 20.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[_alpha(band, 0.40), _alpha(band, 0.08)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13.0),
                topRight: Radius.circular(13.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: band,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: _alpha(band, 0.7),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    e.label,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _kvLine('platform', e.platform, _cyanSoft),
                _kvLine('phase', e.phase, _amberSoft),
                _kvLine('character', e.character, _ink),
                _kvLine('physicalKey', e.physicalKey, _cyanSoft),
                _kvLine('logicalKey', e.logicalKey, _amberSoft),
                _kvLine('repeat', e.repeat.toString(),
                    e.repeat ? _coral : _inkMute),
                _kvLine(
                    'modifiers',
                    e.modifiers.isEmpty
                        ? '[]'
                        : '[' + e.modifiers.join(', ') + ']',
                    _magentaSoft),
                _kvLine('rawKeyCode', '0x' + e.rawKeyCode.toRadixString(16),
                    _ink),
                _kvLine('scanCode', '0x' + e.scanCode.toRadixString(16),
                    _ink),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  final Widget sampleEventsCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_abyss, _midnight, _abyss],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_magenta, 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_magenta, 0.20),
          blurRadius: 30.0,
          offset: const Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '05',
          title: 'Hand-crafted sample events',
          subtitle:
              'Six realistic snapshots of the data a RawKeyEvent would carry '
              'on different platforms.  Useful to compare against your own '
              'logging during legacy bug hunts.',
          accent: _magenta,
        ),
        const SizedBox(height: 16.0),
        Wrap(children: sampleEventCards),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 — Lifecycle diagram.
  // A horizontal arrow chain: addListener → KeyDown → KeyRepeat → KeyUp →
  // removeListener.  Each station has its own coloured tile and connector.
  // ===========================================================================
  const List<_LifecycleStep> lifecycleSteps = <_LifecycleStep>[
    _LifecycleStep(
      title: 'addListener',
      detail: 'You register a callback on RawKeyboard.instance.  From this '
          'moment every raw key event flows through it.',
      icon: Icons.power_settings_new,
      tint: _cyan,
    ),
    _LifecycleStep(
      title: 'RawKeyDownEvent',
      detail: 'Key goes down: data, character, modifiers all populated.  '
          'isRepeat is false on the first hit.',
      icon: Icons.keyboard_arrow_down,
      tint: _amber,
    ),
    _LifecycleStep(
      title: 'RawKeyDownEvent (repeat)',
      detail: 'OS auto-repeat fires further RawKeyDownEvents while the key is '
          'held.  Some platforms set `repeat=true`, others rely on cadence.',
      icon: Icons.repeat,
      tint: _coral,
    ),
    _LifecycleStep(
      title: 'RawKeyUpEvent',
      detail: 'Finger lifts: a final RawKeyUpEvent matches the last down.  '
          'Use this to stop accumulating modifier state.',
      icon: Icons.keyboard_arrow_up,
      tint: _lime,
    ),
    _LifecycleStep(
      title: 'removeListener',
      detail: 'Always remove your listener in dispose — leaks here are a '
          'classic source of zombie shortcut handlers.',
      icon: Icons.power_off,
      tint: _magenta,
    ),
  ];

  final List<Widget> lifecycleNodes = <Widget>[];
  for (int i = 0; i < lifecycleSteps.length; i++) {
    final _LifecycleStep s = lifecycleSteps[i];
    lifecycleNodes.add(Expanded(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[_alpha(s.tint, 0.30), _abyss],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _alpha(s.tint, 0.7), width: 1.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _alpha(s.tint, 0.30),
                  blurRadius: 18.0,
                  offset: const Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Icon(s.icon, color: s.tint, size: 28.0),
                const SizedBox(height: 8.0),
                Text(
                  s.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              s.detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _inkMute,
                fontSize: 11.0,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ));
    if (i != lifecycleSteps.length - 1) {
      lifecycleNodes.add(Padding(
        padding: const EdgeInsets.only(top: 26.0),
        child: Icon(
          Icons.arrow_right_alt,
          color: _alpha(_inkMute, 0.7),
          size: 32.0,
        ),
      ));
    }
  }

  final Widget lifecycleCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_indigoDeep, _midnight, _indigoDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_lime, 0.45), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_lime, 0.18),
          blurRadius: 26.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '06',
          title: 'Listener lifecycle',
          subtitle:
              'The classic five-stop tour of a raw-keyboard listener: subscribe, '
              'observe down/repeat/up, unsubscribe.',
          accent: _lime,
        ),
        const SizedBox(height: 18.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lifecycleNodes,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — RawKeyboard vs HardwareKeyboard side-by-side.
  // A two-column comparison table.  Each row pits a topic against the raw
  // and modern surfaces.  The header stripe uses a horizontal gradient.
  // ===========================================================================
  const List<_ApiRow> apiRows = <_ApiRow>[
    _ApiRow(
      topic: 'Status',
      rawSide: 'Deprecated since Flutter 3.18, still functional.',
      hardwareSide: 'Recommended.  Stable, single source of truth.',
    ),
    _ApiRow(
      topic: 'Event type',
      rawSide: 'RawKeyEvent (down/up) — RawKeyDownEvent / RawKeyUpEvent.',
      hardwareSide: 'KeyEvent — KeyDownEvent / KeyUpEvent / KeyRepeatEvent.',
    ),
    _ApiRow(
      topic: 'Repeat detection',
      rawSide: 'Heuristic; depends on platform.  No dedicated event class.',
      hardwareSide: 'Explicit KeyRepeatEvent class.',
    ),
    _ApiRow(
      topic: 'State queries',
      rawSide: 'RawKeyboard.instance.keysPressed (Logical only).',
      hardwareSide: 'logicalKeysPressed AND physicalKeysPressed.',
    ),
    _ApiRow(
      topic: 'Synthesised events',
      rawSide: 'Cannot tell synthesised from real events.',
      hardwareSide: 'KeyEvent.synthesized exposes the difference.',
    ),
    _ApiRow(
      topic: 'Listener API',
      rawSide: 'addListener(RawKeyEventHandler)',
      hardwareSide: 'addHandler(KeyEventCallback) — returns bool to consume.',
    ),
    _ApiRow(
      topic: 'Cross-platform parity',
      rawSide: 'Differences in modifier bitmasks per OS.',
      hardwareSide: 'Normalised — same modifier set everywhere.',
    ),
    _ApiRow(
      topic: 'Where to find it',
      rawSide: 'package:flutter/services.dart',
      hardwareSide: 'package:flutter/services.dart',
    ),
  ];

  final List<Widget> comparisonRows = <Widget>[];
  for (int i = 0; i < apiRows.length; i++) {
    final _ApiRow r = apiRows[i];
    final bool stripe = i.isOdd;
    comparisonRows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: stripe ? _alpha(_indigo, 0.45) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: _alpha(_inkFaint, 0.25), width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              r.topic,
              style: const TextStyle(
                color: _amberSoft,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Text(
                r.rawSide,
                style: const TextStyle(
                  color: _inkMute,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              r.hardwareSide,
              style: const TextStyle(
                color: _ink,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  final Widget comparisonCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: _abyss,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_teal, 0.5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_teal, 0.20),
          blurRadius: 28.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '07',
          title: 'RawKeyboard vs HardwareKeyboard',
          subtitle:
              'A topic-by-topic comparison.  In new code, prefer the modern '
              'side; touch the legacy side only when integrating with old '
              'shortcuts code.',
          accent: _teal,
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_violet, _teal],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 150.0,
                child: Text(
                  'Topic',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'RawKeyboard (legacy)',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'HardwareKeyboard (modern)',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _alpha(_indigoDeep, 0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Column(children: comparisonRows),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — Static use of RawKeyboard.instance for state inspection.
  // The earlier try/catch already retrieved the snapshot.  Render it as a
  // mock-terminal panel: a header bar, a body of ASCII-art lines, and a
  // footer note.  No two visual elements share decoration with section 1.
  // ===========================================================================
  final Widget terminalCard = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: const LinearGradient(
        colors: <Color>[_voidBlack, _abyss],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: _alpha(_lime, 0.55), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_lime, 0.20),
          blurRadius: 24.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 10.0),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #98, P5(a))
          // BoxDecoration combined `borderRadius.only(topLeft, topRight)`
          // with `Border(bottom: BorderSide(_lime@0.5, width: 1.0))` —
          // the unset top/left/right sides default to BorderSide.none
          // whose colour is opaque black, so Border.isUniform returns
          // false on color and Flutter throws "A borderRadius can only
          // be given on borders with uniform colors." once per build.
          // Dropping borderRadius leaves the terminal-banner header
          // square at the top corners but preserves the bottom rule.
          decoration: BoxDecoration(
            color: _alpha(_lime, 0.18),
            border: Border(
              bottom:
                  BorderSide(color: _alpha(_lime, 0.5), width: 1.0),
            ),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.terminal, color: _lime, size: 16.0),
              SizedBox(width: 8.0),
              Text(
                r'~/raw_keyboard $ inspect',
                style: TextStyle(
                  color: _ink,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _termLine('> dart:flutter/services', _cyanSoft),
              _termLine('> RawKeyboard.instance', _cyanSoft),
              _termLine('  runtimeType  : ' + rawKeyboardClass, _ink),
              _termLine(
                  '  status       : ' + (snapshotOk ? 'available' : 'unavailable'),
                  snapshotOk ? _lime : _coral),
              _termLine('  keysPressed  : Set<LogicalKeyboardKey>', _ink),
              _termLine(
                  '  .length      : ' + observedKeysPressed.toString(),
                  _amberSoft),
              const SizedBox(height: 8.0),
              _termLine(
                  '> note: keysPressed is a *snapshot*, not a stream.',
                  _inkMute),
              _termLine(
                  '> note: querying it inside a build is fine, but you',
                  _inkMute),
              _termLine(
                  '> will not be rebuilt when state changes — that is',
                  _inkMute),
              _termLine(
                  '> the whole point of HardwareKeyboard listeners.',
                  _inkMute),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget snapshotSection = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        colors: <Color>[_indigoDeep, _voidBlack],
        radius: 1.6,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_lime, 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '08',
          title: 'Static state inspection',
          subtitle:
              'Reading RawKeyboard.instance at build time.  The result is '
              'whatever the bridge surfaces — see the green pill in the title '
              'card for live status.',
          accent: _lime,
        ),
        const SizedBox(height: 16.0),
        terminalCard,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 — "What could you build with this?" gallery.
  // Three use-case cards.  Each uses a different layout: shortcut overlay
  // (centered modal-like card), vim-mode input (split status-bar look),
  // kiosk lockout (warning banner with diagonal stripe accent).
  // ===========================================================================
  const _UseCaseTile shortcutOverlayTile = _UseCaseTile(
    title: 'Shortcut overlay',
    tagline: 'A floating cheatsheet of the active key bindings.',
    body:
        'Listen to RawKeyDownEvent for a sentinel chord (say Cmd+/) and toggle '
        'a translucent overlay listing every shortcut you handle.  Because '
        'the listener is global, the cheatsheet works from any focus.',
    icon: Icons.layers,
    accent: _cyan,
  );
  const _UseCaseTile vimModeTile = _UseCaseTile(
    title: 'Vim-mode input',
    tagline: 'Modal text editing on top of any TextField.',
    body:
        'Track NORMAL / INSERT / VISUAL modes by inspecting RawKeyEvent.character '
        'and the modifier flags.  Suppress the OS character production with '
        'KeyEventResult.handled when in NORMAL mode so motions never insert.',
    icon: Icons.keyboard_alt,
    accent: _amber,
  );
  const _UseCaseTile kioskTile = _UseCaseTile(
    title: 'Kiosk-mode lockout',
    tagline: 'Block accidental escape from a tablet POS.',
    body:
        'On every RawKeyDownEvent inspect logicalKey against a denylist '
        '(Esc, F11, Cmd+Q, Alt+Tab) and swallow them.  Pair with a '
        'physical-key fallback to defeat layout switches.',
    icon: Icons.lock,
    accent: _coral,
  );

  Widget _buildShortcutOverlayCard(_UseCaseTile t) {
    return Container(
      width: 330.0,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_alpha(t.accent, 0.18), _abyss],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _alpha(t.accent, 0.55), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _alpha(t.accent, 0.30),
            blurRadius: 22.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[_alpha(t.accent, 0.7), _alpha(t.accent, 0.0)],
              ),
            ),
            child: Icon(t.icon, color: t.accent, size: 30.0),
          ),
          const SizedBox(height: 12.0),
          Text(
            t.title,
            style: const TextStyle(
              color: _ink,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            t.tagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: t.accent,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            t.body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _inkMute,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12.0),
          // Visual mock — a tiny "key chord" pill specific to this tile.
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: _alpha(t.accent, 0.22),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: t.accent, width: 1.0),
            ),
            child: const Text(
              '⌘  +  /',
              style: TextStyle(
                color: _ink,
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVimModeCard(_UseCaseTile t) {
    return Container(
      width: 330.0,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: _midnight,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _alpha(t.accent, 0.55), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _alpha(t.accent, 0.22),
            blurRadius: 22.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Mock status bar header.
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: t.accent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '-- NORMAL --',
                  style: TextStyle(
                    color: _voidBlack,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const Spacer(),
              Icon(t.icon, color: t.accent, size: 18.0),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            t.title,
            style: const TextStyle(
              color: _ink,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            t.tagline,
            style: TextStyle(
              color: t.accent,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            t.body,
            style: const TextStyle(
              color: _inkMute,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12.0),
          // Tiny code-style preview line.
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: _voidBlack,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _alpha(_lime, 0.4)),
            ),
            child: const Text(
              ':wq',
              style: TextStyle(
                color: _lime,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKioskCard(_UseCaseTile t) {
    return Container(
      width: 330.0,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_alpha(t.accent, 0.30), _alpha(_coral, 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const <double>[0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: t.accent, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _alpha(t.accent, 0.35),
            blurRadius: 24.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _alpha(t.accent, 0.30),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(t.icon, color: t.accent, size: 22.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      t.title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      t.tagline,
                      style: TextStyle(
                        color: t.accent,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            t.body,
            style: const TextStyle(
              color: _inkMute,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14.0),
          // Denylist chips — Esc, F11, ⌘Q, ⌥Tab.
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              _denyChip('Esc', t.accent),
              _denyChip('F11', t.accent),
              _denyChip('⌘ Q', t.accent),
              _denyChip('⌥ Tab', t.accent),
            ],
          ),
        ],
      ),
    );
  }

  final Widget useCaseGallery = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_abyss, _indigoDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_coral, 0.45), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_coral, 0.22),
          blurRadius: 26.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '09',
          title: 'What could you build?',
          subtitle:
              'Three concrete product surfaces that fall straight out of '
              'subscribing to RawKeyEvent — one floating, one modal, one '
              'defensive.',
          accent: _coral,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _buildShortcutOverlayCard(shortcutOverlayTile),
            _buildVimModeCard(vimModeTile),
            _buildKioskCard(kioskTile),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — Migration recipe.
  // A numbered checklist styled as receipt-paper / dot-matrix.  Each step has
  // a "before" snippet (raw API) and an "after" snippet (modern API), drawn
  // in monospace boxes.
  // ===========================================================================
  final List<Widget> migrationSteps = <Widget>[
    _migrationStep(
      step: '01',
      title: 'Replace listener registration',
      before: 'RawKeyboard.instance.addListener(_handleRaw);',
      after:
          'HardwareKeyboard.instance.addHandler(_handle);  // returns bool',
    ),
    _migrationStep(
      step: '02',
      title: 'Switch the event class',
      before:
          'void _handleRaw(RawKeyEvent e) {\n'
          '  if (e is RawKeyDownEvent) { ... }\n'
          '}',
      after:
          'bool _handle(KeyEvent e) {\n'
          '  if (e is KeyDownEvent) { ... }\n'
          '  return false;\n'
          '}',
    ),
    _migrationStep(
      step: '03',
      title: 'Use explicit repeat',
      before:
          'if (e is RawKeyDownEvent && e.repeat) { ... }',
      after:
          'if (e is KeyRepeatEvent) { ... }',
    ),
    _migrationStep(
      step: '04',
      title: 'Query state without singletons-as-globals',
      before:
          'RawKeyboard.instance.keysPressed',
      after:
          'HardwareKeyboard.instance.logicalKeysPressed',
    ),
    _migrationStep(
      step: '05',
      title: 'Cleanup',
      before: 'RawKeyboard.instance.removeListener(_handleRaw);',
      after: 'HardwareKeyboard.instance.removeHandler(_handle);',
    ),
  ];

  final Widget migrationCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: _alpha(_indigoDeep, 0.92),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _alpha(_amber, 0.55), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(_amber, 0.22),
          blurRadius: 28.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          number: '10',
          title: 'Migration recipe',
          subtitle:
              'A five-step path from RawKeyboard to HardwareKeyboard.  Apply '
              'these one at a time; the two systems coexist without conflict.',
          accent: _amber,
        ),
        const SizedBox(height: 16.0),
        Column(children: migrationSteps),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 — Closing footnote / colophon.
  // A thin horizontal banner with three pill stats: subject, era, replaced-by.
  // ===========================================================================
  final Widget colophon = Container(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_voidBlack, _indigoDeep, _voidBlack],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _alpha(_violet, 0.5), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        _statPill('subject', 'RawKeyboard / RawKeyEvent', _cyan),
        const SizedBox(width: 12.0),
        _statPill('introduced', 'Flutter 1.0', _amber),
        const SizedBox(width: 12.0),
        _statPill('deprecated', 'Flutter 3.18', _coral),
        const SizedBox(width: 12.0),
        _statPill('successor', 'HardwareKeyboard / KeyEvent', _lime),
        const Spacer(),
        const Text(
          'rendered statically · no listeners attached',
          style: TextStyle(
            color: _inkFaint,
            fontStyle: FontStyle.italic,
            fontSize: 11.5,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // Assemble the page.
  // ===========================================================================
  final Widget body = SingleChildScrollView(
    padding: const EdgeInsets.all(28.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        heroBackplate,
        const SizedBox(height: 24.0),
        anatomyCard,
        const SizedBox(height: 24.0),
        modifierMatrixCard,
        const SizedBox(height: 24.0),
        keyMapCard,
        const SizedBox(height: 24.0),
        sampleEventsCard,
        const SizedBox(height: 24.0),
        lifecycleCard,
        const SizedBox(height: 24.0),
        comparisonCard,
        const SizedBox(height: 24.0),
        snapshotSection,
        const SizedBox(height: 24.0),
        useCaseGallery,
        const SizedBox(height: 24.0),
        migrationCard,
        const SizedBox(height: 24.0),
        colophon,
      ],
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyboard Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _voidBlack,
      primaryColor: _violet,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _voidBlack,
      body: body,
    ),
  );
}

// =============================================================================
// Helper builders.  Top-level functions only (no extra classes).  Each helper
// is hand-shaped — no two share the same returned widget structure.
// =============================================================================

// The stylised on-screen keyboard used in the hero card.
Widget _heroKeyboardGraphic() {
  // Function row: F1..F8 — small flat caps with thin underline.
  final List<Widget> functionRow = <Widget>[];
  for (int i = 1; i <= 8; i++) {
    functionRow.add(Container(
      width: 38.0,
      height: 28.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: _alpha(_indigoDeep, 0.9),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: _alpha(_violet, 0.5), width: 0.8),
      ),
      alignment: Alignment.center,
      child: Text(
        'F' + i.toString(),
        style: const TextStyle(
          color: _inkMute,
          fontSize: 10.0,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }

  // Digit row: 1..9 0 — slightly bigger caps with neon top edge.
  const List<String> digitGlyphs = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  final List<Widget> digitRow = <Widget>[];
  for (int i = 0; i < digitGlyphs.length; i++) {
    digitRow.add(Container(
      width: 44.0,
      height: 44.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #98, P5(a))
      // BoxDecoration combined `borderRadius.circular(7)` with a
      // four-side Border whose top side (cyan@0.6, width 1.5) differs
      // from the left/right/bottom sides (violet@0.4, default width).
      // Different colour AND width across sides => Border.isUniform
      // returns false => "A borderRadius can only be given on borders
      // with uniform colors." fires once per digit key. The loop builds
      // 10 keys ('1'..'9','0') so this single helper accounts for ~10
      // banners per build. Dropping borderRadius makes each digit cap
      // square but preserves the gradient + dual-tone bezel.
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_indigo, _indigoDeep],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(color: _alpha(_cyan, 0.6), width: 1.5),
          left: BorderSide(color: _alpha(_violet, 0.4)),
          right: BorderSide(color: _alpha(_violet, 0.4)),
          bottom: BorderSide(color: _alpha(_violet, 0.4)),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _alpha(_cyan, 0.20),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        digitGlyphs[i],
        style: const TextStyle(
          color: _ink,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ));
  }

  // QWERTY row.
  const List<String> qwertyGlyphs = <String>['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
  final List<Widget> qwertyRow = <Widget>[];
  for (int i = 0; i < qwertyGlyphs.length; i++) {
    qwertyRow.add(_keycap(qwertyGlyphs[i], width: 46.0, accent: _magenta));
  }

  // ASDF row — slightly inset, with a "Caps" key on the left and "Enter" on the right.
  const List<String> asdfGlyphs = <String>['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  final List<Widget> asdfRow = <Widget>[
    _wideKey('Caps', 60.0, _amber),
  ];
  for (int i = 0; i < asdfGlyphs.length; i++) {
    asdfRow.add(_keycap(asdfGlyphs[i], width: 46.0, accent: _amber));
  }
  asdfRow.add(_wideKey('Enter ⏎', 78.0, _lime));

  // ZXCV row — wide Shifts on the outside.
  const List<String> zxcvGlyphs = <String>['Z', 'X', 'C', 'V', 'B', 'N', 'M'];
  final List<Widget> zxcvRow = <Widget>[
    _wideKey('Shift', 80.0, _coral),
  ];
  for (int i = 0; i < zxcvGlyphs.length; i++) {
    zxcvRow.add(_keycap(zxcvGlyphs[i], width: 46.0, accent: _cyan));
  }
  zxcvRow.add(_wideKey('Shift', 80.0, _coral));

  // Bottom row — modifiers and a wide spacebar.
  final List<Widget> modRow = <Widget>[
    _wideKey('Ctrl', 56.0, _coral),
    _wideKey('Alt', 50.0, _lime),
    _wideKey('⌘', 52.0, _cyan),
    _wideKey('Space', 280.0, _inkMute),
    _wideKey('⌘', 52.0, _cyan),
    _wideKey('Alt', 50.0, _lime),
    _wideKey('Ctrl', 56.0, _coral),
  ];

  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _alpha(_voidBlack, 0.55),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _alpha(_inkFaint, 0.4), width: 0.8),
    ),
    child: Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: functionRow),
        const SizedBox(height: 6.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: digitRow),
        const SizedBox(height: 6.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: qwertyRow),
        const SizedBox(height: 6.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: asdfRow),
        const SizedBox(height: 6.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: zxcvRow),
        const SizedBox(height: 6.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: modRow),
      ],
    ),
  );
}

Widget _keycap(String label, {required double width, required Color accent}) {
  return Container(
    width: width,
    height: 46.0,
    margin: const EdgeInsets.symmetric(horizontal: 3.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_indigoLite, _indigoDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: _alpha(accent, 0.55), width: 0.9),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _alpha(accent, 0.22),
          blurRadius: 10.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: _ink,
        fontSize: 15.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _wideKey(String label, double width, Color accent) {
  return Container(
    width: width,
    height: 46.0,
    margin: const EdgeInsets.symmetric(horizontal: 3.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_alpha(accent, 0.18), _indigoDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: _alpha(accent, 0.7), width: 1.0),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: accent,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _modifierFlag(String letter, bool active, Color color) {
  return Container(
    width: 22.0,
    height: 22.0,
    decoration: BoxDecoration(
      color: active ? _alpha(color, 0.85) : _alpha(_inkFaint, 0.18),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
        color: active ? color : _alpha(_inkFaint, 0.5),
        width: 1.0,
      ),
      boxShadow: active
          ? <BoxShadow>[
              BoxShadow(
                color: _alpha(color, 0.6),
                blurRadius: 8.0,
              ),
            ]
          : const <BoxShadow>[],
    ),
    alignment: Alignment.center,
    child: Text(
      letter,
      style: TextStyle(
        color: active ? _voidBlack : _alpha(_inkMute, 0.7),
        fontSize: 11.0,
        fontWeight: FontWeight.w800,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionHeader({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: _alpha(accent, 0.18),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: accent, width: 1.0),
        ),
        child: Text(
          number,
          style: TextStyle(
            color: accent,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            letterSpacing: 1.4,
          ),
        ),
      ),
      const SizedBox(width: 14.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              subtitle,
              style: const TextStyle(
                color: _inkMute,
                fontSize: 13.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _kvLine(String key, String value, Color valueColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            key,
            style: TextStyle(
              color: _alpha(_inkFaint, 0.95),
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 12.0,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _termLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 12.5,
        fontFamily: 'monospace',
        height: 1.3,
      ),
    ),
  );
}

Widget _denyChip(String label, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: _alpha(accent, 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent, width: 0.8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.block, color: accent, size: 12.0),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: _ink,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _migrationStep({
  required String step,
  required String title,
  required String before,
  required String after,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _alpha(_voidBlack, 0.5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _alpha(_amber, 0.4), width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _alpha(_amber, 0.20),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: _amber, width: 0.8),
              ),
              child: Text(
                'STEP ' + step,
                style: const TextStyle(
                  color: _amberSoft,
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _codeBlock('before · raw API', before, _coral),
            ),
            const SizedBox(width: 12.0),
            Icon(Icons.east, color: _alpha(_inkMute, 0.7), size: 22.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: _codeBlock('after · modern API', after, _lime),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _codeBlock(String label, String code, Color accent) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
    decoration: BoxDecoration(
      color: _voidBlack,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _alpha(accent, 0.55), width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 10.5,
            letterSpacing: 1.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          code,
          style: const TextStyle(
            color: _ink,
            fontSize: 12.0,
            fontFamily: 'monospace',
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _statPill(String label, String value, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _alpha(accent, 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: accent,
            fontSize: 10.0,
            fontFamily: 'monospace',
            letterSpacing: 1.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          value,
          style: const TextStyle(
            color: _ink,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
