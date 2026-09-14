// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: RawKeyEventDataFuchsia anatomy, HID usages, modifier
// bitmask, inheritance chain, and migration to KeyEvent / HardwareKeyboard.
//
// NOTE: RawKeyEventDataFuchsia is part of Flutter's now-legacy raw keyboard
// stack. The actual class is not bridged for D4rt (the bridge intentionally
// omits deprecated raw-keyboard surfaces), so we use a small local shim
// `_FuchsiaKey` to simulate construction in static demo cards. The shim is
// purely illustrative — no event plumbing happens in this demo.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Local shim simulating RawKeyEventDataFuchsia for static illustration.
// Real class lives in package:flutter/services.dart but is deprecated.
// ---------------------------------------------------------------------------
class _FuchsiaKey {
  final int hidUsage;
  final int codePoint;
  final int modifiers;
  const _FuchsiaKey({
    required this.hidUsage,
    required this.codePoint,
    required this.modifiers,
  });

  bool get isShiftPressed => (modifiers & _ModBits.shift) != 0;
  bool get isControlPressed => (modifiers & _ModBits.control) != 0;
  bool get isAltPressed => (modifiers & _ModBits.alt) != 0;
  bool get isMetaPressed => (modifiers & _ModBits.meta) != 0;
  bool get isCapsLockOn => (modifiers & _ModBits.capsLock) != 0;
  bool get isNumLockOn => (modifiers & _ModBits.numLock) != 0;

  PhysicalKeyboardKey get physicalKey =>
      PhysicalKeyboardKey(0x00070000 + hidUsage);
  LogicalKeyboardKey get logicalKey => LogicalKeyboardKey(codePoint);
}

class _ModBits {
  static const int shift = 0x01;
  static const int control = 0x08;
  static const int alt = 0x40;
  static const int meta = 0x200;
  static const int capsLock = 0x400;
  static const int numLock = 0x800;
}

// ---------------------------------------------------------------------------
// Palette — Fuchsia OS-inspired magenta/violet/teal.
// ---------------------------------------------------------------------------
class _Palette {
  static const Color bg = Color(0xFF0E0716);
  static const Color panel = Color(0xFF1B1029);
  static const Color panelAlt = Color(0xFF241638);
  static const Color border = Color(0xFF3A2257);
  static const Color magenta = Color(0xFFE0399E);
  static const Color magentaSoft = Color(0xFFFF7FD1);
  static const Color violet = Color(0xFF8C5BFF);
  static const Color violetSoft = Color(0xFFB89BFF);
  static const Color teal = Color(0xFF26D6C9);
  static const Color tealSoft = Color(0xFF6BF0E6);
  static const Color amber = Color(0xFFFFC857);
  static const Color rose = Color(0xFFFF6B91);
  static const Color sky = Color(0xFF6BC8FF);
  static const Color textPrimary = Color(0xFFF1E8FF);
  static const Color textSecondary = Color(0xFFB7A6D6);
  static const Color textMuted = Color(0xFF7E6AA0);
  static const Color codeBg = Color(0xFF120920);
  static const Color codeKeyword = Color(0xFFE0399E);
  static const Color codeType = Color(0xFF26D6C9);
  static const Color codeString = Color(0xFFFFC857);
  static const Color codeComment = Color(0xFF7E6AA0);
}

// ---------------------------------------------------------------------------
// Typography helpers
// ---------------------------------------------------------------------------
class _Type {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: _Palette.textPrimary,
    letterSpacing: 1.6,
    height: 1.05,
  );
  static const TextStyle heroSub = TextStyle(
    fontSize: 16,
    color: _Palette.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: _Palette.textPrimary,
    letterSpacing: 0.4,
  );
  static const TextStyle sectionLead = TextStyle(
    fontSize: 14,
    color: _Palette.textSecondary,
    height: 1.5,
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 13,
    color: _Palette.textPrimary,
    height: 1.5,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    color: _Palette.textMuted,
    letterSpacing: 0.6,
  );
  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.textPrimary,
    height: 1.45,
  );
  static const TextStyle codeKeyword = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeKeyword,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle codeType = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeType,
  );
  static const TextStyle codeString = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeString,
  );
  static const TextStyle codeComment = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeComment,
    fontStyle: FontStyle.italic,
  );
}

// ---------------------------------------------------------------------------
// Section frame
// ---------------------------------------------------------------------------
class _SectionFrame extends StatelessWidget {
  final String index;
  final String title;
  final String? lead;
  final Widget child;
  const _SectionFrame({
    required this.index,
    required this.title,
    required this.child,
    this.lead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 22),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _Palette.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _Palette.magenta.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: _Palette.magenta.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    fontSize: 12,
                    color: _Palette.magenta,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(child: Text(title, style: _Type.sectionTitle)),
            ],
          ),
          if (lead != null) ...[
            SizedBox(height: 10),
            Text(lead!, style: _Type.sectionLead),
          ],
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero card
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 22, 22, 8),
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.magenta.withValues(alpha: 0.32),
            _Palette.violet.withValues(alpha: 0.20),
            _Palette.teal.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _Palette.magenta.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _Palette.magenta,
                      _Palette.violet,
                      _Palette.teal,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _Palette.magenta.withValues(alpha: 0.55),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FLUTTER · SERVICES · LEGACY KEYBOARD',
                        style: _Type.caption.copyWith(
                          color: _Palette.magentaSoft,
                          letterSpacing: 1.8,
                        )),
                    SizedBox(height: 6),
                    Text('RawKeyEventDataFuchsia',
                        style: _Type.heroTitle),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'The platform-specific subclass of RawKeyEventData carrying '
            'keyboard data from the Fuchsia operating system. It exposes '
            'three primitives — a USB HID usage code, a Unicode code point, '
            'and a modifier bitmask — from which Flutter derives the '
            'physical and logical key. This entire RawKeyEvent surface is '
            'now deprecated; new code should consume KeyEvent through the '
            'HardwareKeyboard / KeyboardListener API instead.',
            style: _Type.heroSub,
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroChip('hidUsage', _Palette.magenta),
              _HeroChip('codePoint', _Palette.violet),
              _HeroChip('modifiers', _Palette.teal),
              _HeroChip('PhysicalKey', _Palette.amber),
              _HeroChip('LogicalKey', _Palette.rose),
              _HeroChip('@Deprecated', _Palette.textMuted),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final Color color;
  const _HeroChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — Anatomy diagram with arrows
// ---------------------------------------------------------------------------
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 02',
      title: 'Anatomy of a constructor',
      lead:
          'The named constructor takes three integers. Each one is a slice '
          'of platform-reported keyboard state. Hover over the diagram '
          'mentally and follow the arrows to each field.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CodeBlock([
            _CodeLine.tokens([
              _CodeTok('RawKeyEventDataFuchsia', _Palette.codeType),
              _CodeTok('('),
            ]),
            _CodeLine.tokens([
              _CodeTok('  hidUsage', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('0x00070004', _Palette.codeString),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  codePoint', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('0x00000061', _Palette.codeString),
              _CodeTok(',  '),
              _CodeTok('// "a"', _Palette.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('  modifiers', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('0x00000001', _Palette.codeString),
              _CodeTok(',  '),
              _CodeTok('// shift', _Palette.codeComment),
            ]),
            _CodeLine.tokens([_CodeTok(')')]),
          ]),
          SizedBox(height: 16),
          _AnatomyArrow(
            color: _Palette.magenta,
            field: 'hidUsage',
            description:
                'USB HID Usage ID. Identifies the physical key on the '
                'keyboard regardless of the OS keymap. The keyboard usage '
                'page is 0x07; the full usage is page<<16 | id.',
          ),
          SizedBox(height: 10),
          _AnatomyArrow(
            color: _Palette.violet,
            field: 'codePoint',
            description:
                'The Unicode scalar produced after the OS applies its '
                'keymap, modifiers, and IME. Zero for non-character keys '
                'like F1 or arrow up.',
          ),
          SizedBox(height: 10),
          _AnatomyArrow(
            color: _Palette.teal,
            field: 'modifiers',
            description:
                'A bitmask of currently held modifiers and toggled locks. '
                'Bit-and against the modifierShift / modifierControl / '
                'modifierAlt / modifierMeta / modifierCapsLock / '
                'modifierNumLock constants.',
          ),
        ],
      ),
    );
  }
}

class _AnatomyArrow extends StatelessWidget {
  final Color color;
  final String field;
  final String description;
  const _AnatomyArrow({
    required this.color,
    required this.field,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('▶', style: TextStyle(color: color, fontSize: 18)),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              field,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(description, style: _Type.bodyText)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 — HID Usage table
// ---------------------------------------------------------------------------
class _HidRow {
  final int usage;
  final String name;
  final int codePoint;
  final String glyph;
  final Color glyphColor;
  const _HidRow(this.usage, this.name, this.codePoint, this.glyph,
      this.glyphColor);
}

class _HidUsageSection extends StatelessWidget {
  const _HidUsageSection();

  static const List<_HidRow> _rows = [
    _HidRow(0x04, 'Keyboard a / A', 0x61, 'A', _Palette.magenta),
    _HidRow(0x05, 'Keyboard b / B', 0x62, 'B', _Palette.magenta),
    _HidRow(0x07, 'Keyboard d / D', 0x64, 'D', _Palette.magenta),
    _HidRow(0x14, 'Keyboard q / Q', 0x71, 'Q', _Palette.magenta),
    _HidRow(0x16, 'Keyboard s / S', 0x73, 'S', _Palette.magenta),
    _HidRow(0x1E, 'Keyboard 1', 0x31, '1', _Palette.violet),
    _HidRow(0x27, 'Keyboard 0', 0x30, '0', _Palette.violet),
    _HidRow(0x28, 'Enter / Return', 0x0A, '⏎', _Palette.teal),
    _HidRow(0x29, 'Escape', 0x1B, 'Esc', _Palette.teal),
    _HidRow(0x2A, 'Backspace', 0x08, '⌫', _Palette.teal),
    _HidRow(0x2B, 'Tab', 0x09, '⇥', _Palette.teal),
    _HidRow(0x2C, 'Spacebar', 0x20, '␣', _Palette.teal),
    _HidRow(0x3A, 'F1', 0, 'F1', _Palette.amber),
    _HidRow(0x4F, 'Right Arrow', 0, '→', _Palette.rose),
    _HidRow(0x50, 'Left Arrow', 0, '←', _Palette.rose),
    _HidRow(0x52, 'Up Arrow', 0, '↑', _Palette.rose),
    _HidRow(0xE0, 'Left Control', 0, 'Ctl', _Palette.sky),
    _HidRow(0xE1, 'Left Shift', 0, '⇧', _Palette.sky),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 03',
      title: 'HID usage table — keyboard page (0x07)',
      lead:
          'The Fuchsia stack reports keys using the USB HID specification. '
          'The keyboard page is 0x07; the usage ID below is the lower 16 '
          'bits. PhysicalKeyboardKey identifiers in Flutter are derived '
          'directly by adding 0x00070000.',
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.codeBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _Palette.border),
        ),
        child: Column(
          children: [
            _hidHeader(),
            for (int i = 0; i < _rows.length; i++)
              _hidRow(_rows[i], i.isEven),
          ],
        ),
      ),
    );
  }

  Widget _hidHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 90,
              child: Text('hidUsage',
                  style: _Type.caption
                      .copyWith(color: _Palette.magentaSoft))),
          Expanded(
              child: Text('Key name',
                  style: _Type.caption
                      .copyWith(color: _Palette.violetSoft))),
          SizedBox(
              width: 90,
              child: Text('codePoint',
                  style: _Type.caption.copyWith(color: _Palette.tealSoft))),
          SizedBox(width: 60, child: Text('glyph', style: _Type.caption)),
        ],
      ),
    );
  }

  Widget _hidRow(_HidRow row, bool zebra) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: zebra ? Colors.transparent : _Palette.panel.withValues(alpha: 0.4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '0x${row.usage.toRadixString(16).toUpperCase().padLeft(2, '0')}',
              style: _Type.code.copyWith(color: _Palette.magentaSoft),
            ),
          ),
          Expanded(child: Text(row.name, style: _Type.code)),
          SizedBox(
            width: 90,
            child: Text(
              row.codePoint == 0
                  ? '—'
                  : '0x${row.codePoint.toRadixString(16).toUpperCase().padLeft(2, '0')}',
              style: _Type.code.copyWith(color: _Palette.tealSoft),
            ),
          ),
          SizedBox(
            width: 60,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: row.glyphColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: row.glyphColor.withValues(alpha: 0.55),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                row.glyph,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: row.glyphColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — Modifier bitmask gallery
// ---------------------------------------------------------------------------
class _ModBit {
  final int bit;
  final int mask;
  final String mnemonic;
  final String name;
  final String desc;
  final Color color;
  const _ModBit({
    required this.bit,
    required this.mask,
    required this.mnemonic,
    required this.name,
    required this.desc,
    required this.color,
  });
}

class _ModifierSection extends StatelessWidget {
  const _ModifierSection();

  static const List<_ModBit> _bits = [
    _ModBit(
      bit: 0,
      mask: 0x001,
      mnemonic: 'SH',
      name: 'modifierShift',
      desc: 'Either shift key is held',
      color: _Palette.magenta,
    ),
    _ModBit(
      bit: 3,
      mask: 0x008,
      mnemonic: 'CTL',
      name: 'modifierControl',
      desc: 'Either control key is held',
      color: _Palette.violet,
    ),
    _ModBit(
      bit: 6,
      mask: 0x040,
      mnemonic: 'ALT',
      name: 'modifierAlt',
      desc: 'Either alt key is held',
      color: _Palette.teal,
    ),
    _ModBit(
      bit: 9,
      mask: 0x200,
      mnemonic: 'MET',
      name: 'modifierMeta',
      desc: 'Meta / Windows / ⌘ key held',
      color: _Palette.amber,
    ),
    _ModBit(
      bit: 10,
      mask: 0x400,
      mnemonic: 'CAP',
      name: 'modifierCapsLock',
      desc: 'Caps Lock toggle is on',
      color: _Palette.rose,
    ),
    _ModBit(
      bit: 11,
      mask: 0x800,
      mnemonic: 'NUM',
      name: 'modifierNumLock',
      desc: 'Num Lock toggle is on',
      color: _Palette.sky,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int worked =
        _ModBits.shift | _ModBits.control; // 0x009 = 0b1001
    return _SectionFrame(
      index: 'SECTION 04',
      title: 'Modifier bitmask — six bits, one integer',
      lead:
          'The modifiers integer is a flag set, not an enum. Read each '
          'flag with bitwise AND. The constants below are static fields on '
          'RawKeyEventDataFuchsia.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BinaryRegister(bits: _bits),
          SizedBox(height: 16),
          for (final b in _bits) ...[
            _BitRow(b),
            SizedBox(height: 6),
          ],
          SizedBox(height: 12),
          _WorkedExample(value: worked, bits: _bits),
        ],
      ),
    );
  }
}

class _BinaryRegister extends StatelessWidget {
  final List<_ModBit> bits;
  const _BinaryRegister({required this.bits});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 11; i >= 0; i--) _bitCell(i),
        ],
      ),
    );
  }

  Widget _bitCell(int idx) {
    _ModBit? b;
    for (final candidate in bits) {
      if (candidate.bit == idx) {
        b = candidate;
        break;
      }
    }
    final bool active = b != null;
    final Color activeColor = b?.color ?? _Palette.textMuted;
    final String mnemonic = b?.mnemonic ?? '·';
    return Container(
      width: 44,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: active
            ? activeColor.withValues(alpha: 0.20)
            : _Palette.panel.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active
              ? activeColor.withValues(alpha: 0.6)
              : _Palette.border,
        ),
      ),
      child: Column(
        children: [
          Text(
            '$idx',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: active ? activeColor : _Palette.textMuted,
            ),
          ),
          SizedBox(height: 4),
          Text(
            mnemonic,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: active ? activeColor : _Palette.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BitRow extends StatelessWidget {
  final _ModBit b;
  const _BitRow(this.b);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: b.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: b.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            alignment: Alignment.center,
            child: Text('bit ${b.bit}',
                style: _Type.code.copyWith(color: b.color)),
          ),
          SizedBox(width: 8),
          Container(
            width: 70,
            child: Text(
              '0x${b.mask.toRadixString(16).toUpperCase().padLeft(3, '0')}',
              style: _Type.code.copyWith(color: b.color),
            ),
          ),
          Container(
            width: 130,
            child: Text(
              b.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _Palette.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(b.desc, style: _Type.bodyText)),
        ],
      ),
    );
  }
}

class _WorkedExample extends StatelessWidget {
  final int value;
  final List<_ModBit> bits;
  const _WorkedExample({required this.value, required this.bits});

  @override
  Widget build(BuildContext context) {
    final binary = value.toRadixString(2).padLeft(12, '0');
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.amber.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.amber.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate_outlined,
                  color: _Palette.amber, size: 18),
              SizedBox(width: 8),
              Text('Worked example: shift + control',
                  style: TextStyle(
                    color: _Palette.amber,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  )),
            ],
          ),
          SizedBox(height: 10),
          _CodeBlock([
            _CodeLine.tokens([
              _CodeTok('final', _Palette.codeKeyword),
              _CodeTok(' '),
              _CodeTok('mods', _Palette.textPrimary),
              _CodeTok(' = '),
              _CodeTok('modifierShift', _Palette.codeType),
              _CodeTok(' | '),
              _CodeTok('modifierControl', _Palette.codeType),
              _CodeTok(';'),
            ]),
            _CodeLine.tokens([
              _CodeTok('// = 0x001 | 0x008 = 0x009 = 0b000000001001',
                  _Palette.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('data', _Palette.textPrimary),
              _CodeTok('.'),
              _CodeTok('isShiftPressed', _Palette.codeType),
              _CodeTok('   // true', _Palette.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('data', _Palette.textPrimary),
              _CodeTok('.'),
              _CodeTok('isControlPressed', _Palette.codeType),
              _CodeTok(' // true', _Palette.codeComment),
            ]),
            _CodeLine.tokens([
              _CodeTok('data', _Palette.textPrimary),
              _CodeTok('.'),
              _CodeTok('isAltPressed', _Palette.codeType),
              _CodeTok('     // false', _Palette.codeComment),
            ]),
          ]),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _Palette.codeBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('binary: $binary',
                style: _Type.code.copyWith(color: _Palette.amber)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — Sample event cards
// ---------------------------------------------------------------------------
class _SampleEvent {
  final String title;
  final String scenario;
  final _FuchsiaKey data;
  final Color accent;
  const _SampleEvent({
    required this.title,
    required this.scenario,
    required this.data,
    required this.accent,
  });
}

class _SampleEventsSection extends StatelessWidget {
  const _SampleEventsSection();

  static final List<_SampleEvent> _samples = [
    _SampleEvent(
      title: "'A' (no modifiers)",
      scenario: 'User taps the A key with caps off and no modifiers held.',
      data: _FuchsiaKey(hidUsage: 0x04, codePoint: 0x61, modifiers: 0),
      accent: _Palette.magenta,
    ),
    _SampleEvent(
      title: "shift + 'a' → 'A'",
      scenario: 'Left shift held, then A pressed. Code point becomes 0x41.',
      data: _FuchsiaKey(
          hidUsage: 0x04, codePoint: 0x41, modifiers: _ModBits.shift),
      accent: _Palette.violet,
    ),
    _SampleEvent(
      title: 'F1 function key',
      scenario:
          'F1 has no Unicode code point. codePoint is zero; only hidUsage '
          'identifies it.',
      data: _FuchsiaKey(hidUsage: 0x3A, codePoint: 0, modifiers: 0),
      accent: _Palette.teal,
    ),
    _SampleEvent(
      title: 'Arrow up',
      scenario:
          'Navigation key. No code point, just a HID usage in the keyboard '
          'page.',
      data: _FuchsiaKey(hidUsage: 0x52, codePoint: 0, modifiers: 0),
      accent: _Palette.amber,
    ),
    _SampleEvent(
      title: 'Enter',
      scenario:
          'Carriage-return-ish. Some platforms emit 0x0A, some 0x0D — '
          'usage 0x28 is canonical.',
      data: _FuchsiaKey(hidUsage: 0x28, codePoint: 0x0A, modifiers: 0),
      accent: _Palette.rose,
    ),
    _SampleEvent(
      title: 'cmd + s (save)',
      scenario:
          'Meta (⌘) held while pressing S. Modifier bit 9 set; codePoint '
          'reflects cooked output.',
      data: _FuchsiaKey(
          hidUsage: 0x16, codePoint: 0x73, modifiers: _ModBits.meta),
      accent: _Palette.sky,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 05',
      title: 'Sample event cards',
      lead:
          'Six concrete scenarios. Each card constructs the data object '
          'with literal integers and dumps a JSON-ish view of its derived '
          'values.',
      child: Column(
        children: [
          for (final s in _samples) ...[
            _SampleEventCard(sample: s),
            SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SampleEventCard extends StatelessWidget {
  final _SampleEvent sample;
  const _SampleEventCard({required this.sample});

  @override
  Widget build(BuildContext context) {
    final data = sample.data;
    final hidHex = '0x${data.hidUsage.toRadixString(16).toUpperCase().padLeft(2, '0')}';
    final cpHex = data.codePoint == 0
        ? '0x00'
        : '0x${data.codePoint.toRadixString(16).toUpperCase().padLeft(2, '0')}';
    final modHex =
        '0x${data.modifiers.toRadixString(16).toUpperCase().padLeft(3, '0')}';
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: sample.accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: sample.accent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('SAMPLE',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: sample.accent,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  sample.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _Palette.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(sample.scenario, style: _Type.bodyText),
          SizedBox(height: 12),
          _CodeBlock([
            _CodeLine.tokens([_CodeTok('{')]),
            _CodeLine.tokens([
              _CodeTok('  "runtimeType"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('"RawKeyEventDataFuchsia"', _Palette.codeString),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "hidUsage"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok(hidHex, _Palette.codeString),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "codePoint"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok(cpHex, _Palette.codeString),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "modifiers"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok(modHex, _Palette.codeString),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "isShiftPressed"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('${data.isShiftPressed}', _Palette.codeType),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "isControlPressed"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('${data.isControlPressed}', _Palette.codeType),
              _CodeTok(','),
            ]),
            _CodeLine.tokens([
              _CodeTok('  "isMetaPressed"', _Palette.codeKeyword),
              _CodeTok(': '),
              _CodeTok('${data.isMetaPressed}', _Palette.codeType),
            ]),
            _CodeLine.tokens([_CodeTok('}')]),
          ]),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — Inheritance chain
// ---------------------------------------------------------------------------
class _InheritanceSection extends StatelessWidget {
  const _InheritanceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 06',
      title: 'Inheritance — one parent, many platforms',
      lead:
          'RawKeyEventData is the abstract @immutable base class. Each '
          'platform ships a sibling subclass with its own raw integer '
          'fields. Flutter dispatches on Platform at receive time and '
          'wraps the right subclass.',
      child: Column(
        children: [
          _InheritanceNode(
            label: 'RawKeyEventData',
            sub: 'abstract @immutable',
            color: _Palette.violet,
            isRoot: true,
          ),
          _DownArrow(color: _Palette.violet),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _SiblingChip('RawKeyEventDataFuchsia',
                  'Fuchsia', _Palette.magenta, highlight: true),
              _SiblingChip('RawKeyEventDataLinux',
                  'Linux / GTK', _Palette.teal),
              _SiblingChip('RawKeyEventDataMacOs',
                  'macOS / Carbon', _Palette.amber),
              _SiblingChip('RawKeyEventDataWindows',
                  'Windows / Win32', _Palette.rose),
              _SiblingChip('RawKeyEventDataAndroid',
                  'Android / NDK', _Palette.sky),
              _SiblingChip('RawKeyEventDataIos',
                  'iOS / UIKey', _Palette.violet),
              _SiblingChip('RawKeyEventDataWeb',
                  'Web / KeyboardEvent', _Palette.tealSoft),
            ],
          ),
        ],
      ),
    );
  }
}

class _InheritanceNode extends StatelessWidget {
  final String label;
  final String sub;
  final Color color;
  final bool isRoot;
  const _InheritanceNode({
    required this.label,
    required this.sub,
    required this.color,
    this.isRoot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isRoot ? 0.20 : 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: isRoot ? 1.6 : 1),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              )),
          Text(sub, style: _Type.caption),
        ],
      ),
    );
  }
}

class _DownArrow extends StatelessWidget {
  final Color color;
  const _DownArrow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Container(width: 2, height: 16, color: color),
          Text('▼', style: TextStyle(color: color, fontSize: 14)),
        ],
      ),
    );
  }
}

class _SiblingChip extends StatelessWidget {
  final String label;
  final String platform;
  final Color color;
  final bool highlight;
  const _SiblingChip(
    this.label,
    this.platform,
    this.color, {
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: highlight
            ? color.withValues(alpha: 0.30)
            : color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: highlight ? 0.85 : 0.4),
          width: highlight ? 1.5 : 1,
        ),
        boxShadow: highlight
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight:
                    highlight ? FontWeight.w800 : FontWeight.w600,
              )),
          Text(platform, style: _Type.caption),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 — Migration note
// ---------------------------------------------------------------------------
class _MigrationSection extends StatelessWidget {
  const _MigrationSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 07',
      title: 'Migration — RawKeyEvent → KeyEvent',
      lead:
          'The RawKeyboard / RawKeyEvent stack is deprecated. Modern '
          'Flutter apps consume HardwareKeyboard, KeyboardListener, or '
          'Focus. KeyEvent is unified across platforms and gives '
          'consistent logical/physical keys without platform-specific '
          'subclasses.',
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.amber.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: _Palette.amber.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: _Palette.amber),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'The entire RawKeyEvent / RawKeyEventData family is '
                    'marked @Deprecated. Existing code keeps working, but '
                    'new code should not subscribe to RawKeyboard.instance.',
                    style: _Type.bodyText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MigrationColumn(
                  title: 'Legacy — RawKeyEvent',
                  badge: 'DEPRECATED',
                  badgeColor: _Palette.rose,
                  lines: [
                    _CodeLine.tokens([
                      _CodeTok('// before', _Palette.codeComment),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('RawKeyboard', _Palette.codeType),
                      _CodeTok('.'),
                      _CodeTok('instance', _Palette.textPrimary),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  .'),
                      _CodeTok('addListener', _Palette.codeKeyword),
                      _CodeTok('('),
                      _CodeTok('(', _Palette.textPrimary),
                      _CodeTok('event', _Palette.textPrimary),
                      _CodeTok(') {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    final', _Palette.codeKeyword),
                      _CodeTok(' '),
                      _CodeTok('data', _Palette.textPrimary),
                      _CodeTok(' = '),
                      _CodeTok('event', _Palette.textPrimary),
                      _CodeTok('.'),
                      _CodeTok('data', _Palette.codeType),
                      _CodeTok(';'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    if', _Palette.codeKeyword),
                      _CodeTok(' ('),
                      _CodeTok('data', _Palette.textPrimary),
                      _CodeTok(' '),
                      _CodeTok('is', _Palette.codeKeyword),
                      _CodeTok(' '),
                      _CodeTok('RawKeyEventDataFuchsia', _Palette.codeType),
                      _CodeTok(') {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('      // data.hidUsage / data.codePoint',
                          _Palette.codeComment),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    }'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  });'),
                    ]),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MigrationColumn(
                  title: 'Modern — KeyEvent',
                  badge: 'RECOMMENDED',
                  badgeColor: _Palette.teal,
                  lines: [
                    _CodeLine.tokens([
                      _CodeTok('// after', _Palette.codeComment),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('HardwareKeyboard', _Palette.codeType),
                      _CodeTok('.'),
                      _CodeTok('instance', _Palette.textPrimary),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  .'),
                      _CodeTok('addHandler', _Palette.codeKeyword),
                      _CodeTok('('),
                      _CodeTok('(', _Palette.textPrimary),
                      _CodeTok('KeyEvent', _Palette.codeType),
                      _CodeTok(' '),
                      _CodeTok('e', _Palette.textPrimary),
                      _CodeTok(') {'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    final', _Palette.codeKeyword),
                      _CodeTok(' '),
                      _CodeTok('logical', _Palette.textPrimary),
                      _CodeTok(' = '),
                      _CodeTok('e', _Palette.textPrimary),
                      _CodeTok('.'),
                      _CodeTok('logicalKey', _Palette.codeType),
                      _CodeTok(';'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    final', _Palette.codeKeyword),
                      _CodeTok(' '),
                      _CodeTok('physical', _Palette.textPrimary),
                      _CodeTok(' = '),
                      _CodeTok('e', _Palette.textPrimary),
                      _CodeTok('.'),
                      _CodeTok('physicalKey', _Palette.codeType),
                      _CodeTok(';'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    // unified across platforms',
                          _Palette.codeComment),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('    return', _Palette.codeKeyword),
                      _CodeTok(' '),
                      _CodeTok('false', _Palette.codeType),
                      _CodeTok(';'),
                    ]),
                    _CodeLine.tokens([
                      _CodeTok('  });'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MigrationColumn extends StatelessWidget {
  final String title;
  final String badge;
  final Color badgeColor;
  final List<_CodeLine> lines;
  const _MigrationColumn({
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: badgeColor.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title,
                    style: TextStyle(
                      color: _Palette.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(badge,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: badgeColor,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ],
          ),
          SizedBox(height: 8),
          _CodeBlock(lines),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 — Logical / Physical key derivation
// ---------------------------------------------------------------------------
class _DerivationRow {
  final int hidUsage;
  final String physicalLabel;
  final String physicalConst;
  final int physicalId;
  final int codePoint;
  final String logicalLabel;
  final int logicalId;
  const _DerivationRow({
    required this.hidUsage,
    required this.physicalLabel,
    required this.physicalConst,
    required this.physicalId,
    required this.codePoint,
    required this.logicalLabel,
    required this.logicalId,
  });
}

class _DerivationSection extends StatelessWidget {
  const _DerivationSection();

  static const List<_DerivationRow> _rows = [
    _DerivationRow(
      hidUsage: 0x04,
      physicalLabel: 'KeyA',
      physicalConst: 'PhysicalKeyboardKey.keyA',
      physicalId: 0x00070004,
      codePoint: 0x61,
      logicalLabel: 'a (lowercase)',
      logicalId: 0x00000061,
    ),
    _DerivationRow(
      hidUsage: 0x04,
      physicalLabel: 'KeyA + shift',
      physicalConst: 'PhysicalKeyboardKey.keyA',
      physicalId: 0x00070004,
      codePoint: 0x41,
      logicalLabel: 'A (uppercase)',
      logicalId: 0x00000041,
    ),
    _DerivationRow(
      hidUsage: 0x28,
      physicalLabel: 'Enter',
      physicalConst: 'PhysicalKeyboardKey.enter',
      physicalId: 0x00070028,
      codePoint: 0,
      logicalLabel: 'enter',
      logicalId: 0x00100000D,
    ),
    _DerivationRow(
      hidUsage: 0x52,
      physicalLabel: 'Arrow Up',
      physicalConst: 'PhysicalKeyboardKey.arrowUp',
      physicalId: 0x00070052,
      codePoint: 0,
      logicalLabel: 'arrowUp',
      logicalId: 0x100000301,
    ),
    _DerivationRow(
      hidUsage: 0x3A,
      physicalLabel: 'F1',
      physicalConst: 'PhysicalKeyboardKey.f1',
      physicalId: 0x0007003A,
      codePoint: 0,
      logicalLabel: 'f1',
      logicalId: 0x100000801,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 08',
      title: 'logicalKey & physicalKey derivation',
      lead:
          'Flutter exposes physicalKey (where the key is on the board) and '
          'logicalKey (what the user meant). The Fuchsia subclass derives '
          'physicalKey purely from hidUsage and logicalKey from a lookup '
          'on (codePoint, locks, layout).',
      child: Column(
        children: [
          for (int i = 0; i < _rows.length; i++) ...[
            _DerivationCard(row: _rows[i], idx: i + 1),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _DerivationCard extends StatelessWidget {
  final _DerivationRow row;
  final int idx;
  const _DerivationCard({required this.row, required this.idx});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _Palette.violet.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text('$idx',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: _Palette.violet,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              SizedBox(width: 8),
              Text(
                'hidUsage 0x${row.hidUsage.toRadixString(16).toUpperCase().padLeft(2, '0')}',
                style: _Type.code.copyWith(color: _Palette.magentaSoft),
              ),
              SizedBox(width: 12),
              Text(
                'codePoint 0x${row.codePoint.toRadixString(16).toUpperCase().padLeft(2, '0')}',
                style: _Type.code.copyWith(color: _Palette.tealSoft),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _DerivationBox(
                  label: 'physicalKey',
                  color: _Palette.amber,
                  body: row.physicalConst,
                  rawId:
                      '0x${row.physicalId.toRadixString(16).toUpperCase().padLeft(8, '0')}',
                  caption: row.physicalLabel,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _DerivationBox(
                  label: 'logicalKey',
                  color: _Palette.rose,
                  body: row.logicalLabel,
                  rawId:
                      '0x${row.logicalId.toRadixString(16).toUpperCase().padLeft(9, '0')}',
                  caption: '(layout-aware)',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DerivationBox extends StatelessWidget {
  final String label;
  final Color color;
  final String body;
  final String rawId;
  final String caption;
  const _DerivationBox({
    required this.label,
    required this.color,
    required this.body,
    required this.rawId,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                letterSpacing: 1.2,
                color: color,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(height: 6),
          Text(body, style: _Type.code),
          SizedBox(height: 4),
          Text(rawId,
              style: _Type.code.copyWith(color: color)),
          SizedBox(height: 4),
          Text(caption, style: _Type.caption),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — Pitfalls
// ---------------------------------------------------------------------------
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: 'SECTION 09',
      title: 'Pitfalls & misconceptions',
      lead:
          'Common mistakes when reading Fuchsia raw key events. Each item '
          'below has bitten production code at least once.',
      child: Column(
        children: [
          _Pitfall(
            color: _Palette.rose,
            title: 'hidUsage is not a Unicode code point',
            body:
                'hidUsage 0x04 is the keyboard usage for the A key — it is '
                'NOT 0x41 ("A") nor 0x61 ("a"). Reading hidUsage as a '
                'character is wrong. Use codePoint for characters.',
          ),
          _Pitfall(
            color: _Palette.amber,
            title: 'modifiers is a bitmask, not an enum',
            body:
                'data.modifiers == modifierShift only fires when ONLY '
                'shift is held. With ctrl + shift, modifiers is 0x009 — '
                'use bitwise AND or the convenience getters instead.',
          ),
          _Pitfall(
            color: _Palette.teal,
            title: 'codePoint is zero for non-character keys',
            body:
                'F1, arrow keys, and modifier keys themselves carry '
                'codePoint 0. Do not display them as String.fromCharCode '
                '— check for zero first.',
          ),
          _Pitfall(
            color: _Palette.violet,
            title: 'Caps lock toggles a bit, it does not rewrite codePoint',
            body:
                'The caps lock indicator is in modifiers (bit 10). Whether '
                'codePoint comes through as 0x41 or 0x61 is decided by '
                'the OS keymap before Fuchsia builds the event.',
          ),
          _Pitfall(
            color: _Palette.sky,
            title: 'Do not switch on RawKeyEventDataFuchsia in new code',
            body:
                'New code should ignore the RawKeyEvent.data subclass '
                'entirely and read e.logicalKey / e.physicalKey from the '
                'unified KeyEvent API. Subclass switching is a portability '
                'smell.',
          ),
          _Pitfall(
            color: _Palette.magenta,
            title: 'PhysicalKeyboardKey ids are not the bare HID usage',
            body:
                'The constant id is hidUsagePage<<16 | hidUsageId. For '
                'keyboard usages that is 0x00070000 + hidUsage. Comparing '
                'data.hidUsage to PhysicalKeyboardKey.keyA.usbHidUsage '
                'will mismatch because of the page bits.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final Color color;
  final String title;
  final String body;
  const _Pitfall({
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: color, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    )),
                SizedBox(height: 4),
                Text(body, style: _Type.bodyText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10 — Footer
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 12, 22, 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _Palette.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _Palette.magenta,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text('END · RawKeyEventDataFuchsia · visual deep demo',
                  style: TextStyle(
                    color: _Palette.textSecondary,
                    letterSpacing: 1.4,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Subject: Flutter platform-specific RawKeyEventData subclass '
            'for Fuchsia OS, modeled on USB HID usage codes plus a '
            'modifier bitmask. Status: deprecated alongside the rest of '
            'the RawKeyboard family. Successor: HardwareKeyboard / '
            'KeyEvent / KeyboardListener.',
            style: _Type.sectionLead,
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FooterTag('package:flutter/services.dart'),
              _FooterTag('@Deprecated'),
              _FooterTag('USB HID 0x07 page'),
              _FooterTag('Fuchsia / Zircon'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterTag extends StatelessWidget {
  final String label;
  const _FooterTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _Palette.violet.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _Palette.violet.withValues(alpha: 0.4),
        ),
      ),
      child: Text(label,
          style: _Type.code.copyWith(color: _Palette.violetSoft)),
    );
  }
}

// ---------------------------------------------------------------------------
// Code block helpers (token-coloured)
// ---------------------------------------------------------------------------
class _CodeTok {
  final String text;
  final Color? color;
  const _CodeTok(this.text, [this.color]);
}

class _CodeLine {
  final List<_CodeTok> tokens;
  const _CodeLine.tokens(this.tokens);
}

class _CodeBlock extends StatelessWidget {
  final List<_CodeLine> lines;
  const _CodeBlock(this.lines);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in lines)
            RichText(
              text: TextSpan(
                style: _Type.code,
                children: [
                  for (final t in line.tokens)
                    TextSpan(
                      text: t.text,
                      style: t.color == null
                          ? null
                          : TextStyle(color: t.color),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyEventDataFuchsia · visual deep demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _Palette.bg,
      primaryColor: _Palette.magenta,
      colorScheme: ColorScheme.dark(
        primary: _Palette.magenta,
        secondary: _Palette.teal,
        surface: _Palette.panel,
      ),
    ),
    home: Scaffold(
      backgroundColor: _Palette.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Hero(),
            _AnatomySection(),
            _HidUsageSection(),
            _ModifierSection(),
            _SampleEventsSection(),
            _InheritanceSection(),
            _MigrationSection(),
            _DerivationSection(),
            _PitfallsSection(),
            _Footer(),
          ],
        ),
      ),
    ),
  );
}
