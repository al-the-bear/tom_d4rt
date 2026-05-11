// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use
// Visual deep demo: RawKeyEventDataIos anatomy.
//
// This file paints a long, hand-authored dossier about the iOS variant of
// Flutter's legacy raw-keyboard data carrier. RawKeyEventDataIos used to be
// the bridge that surfaced UIKey events to the framework — wrapping the iOS
// `keyCode` (a UIKeyboardHIDUsage value), the produced `characters` and
// `charactersIgnoringModifiers` strings, and the `modifiers` bitfield using
// the `kModifierFlag*` constants that mirror the bits packed inside
// UIKeyModifierFlags.
//
// The whole RawKeyEvent family — RawKeyEventDataIos included — has been
// flagged @Deprecated. New code should listen to KeyEvent through
// HardwareKeyboard, KeyboardListener, or Focus.onKeyEvent, and lookup logical
// or physical keys via LogicalKeyboardKey / PhysicalKeyboardKey. This dossier
// is intentionally retrospective: it draws the legacy shape so the reader
// understands what a migration is moving away from.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// iOS modifier flag constants — values mirror the kModifierFlag* constants
// declared next to RawKeyEventDataIos. Each bit corresponds to a flag that
// iOS packs inside UIKeyModifierFlags / UIKey.modifierFlags.
// ---------------------------------------------------------------------------
class _IosFlag {
  static const int alphaShift = 0x10000; // kModifierFlagAlphaShift  (Caps lock physical state)
  static const int shift = 0x20000; // kModifierFlagShift
  static const int control = 0x40000; // kModifierFlagControl
  static const int alternate = 0x80000; // kModifierFlagAlternate (Option)
  static const int command = 0x100000; // kModifierFlagCommand   (Cmd)
  static const int numericPad = 0x200000; // kModifierFlagNumericPad
  static const int help = 0x400000; // kModifierFlagHelp
  static const int function = 0x800000; // kModifierFlagFunction (Fn)
}

// ---------------------------------------------------------------------------
// Selected UIKeyboardHIDUsage keyCodes that surface as `keyCode` on
// RawKeyEventDataIos. Values match the HID Usage table that iOS forwards
// verbatim.
// ---------------------------------------------------------------------------
class _HidUsage {
  static const int keyboardA = 0x04;
  static const int keyboardC = 0x06;
  static const int keyboardF1 = 0x3A;
  static const int keyboardCapsLock = 0x39;
  static const int keyboardLeftShift = 0xE1;
  static const int keyboardLeftControl = 0xE0;
  static const int keyboardLeftCommand = 0xE3; // Cmd
  static const int keyboardRightCommand = 0xE7;
  static const int keyboardLeftAlt = 0xE2; // Option
  static const int keyboardReturn = 0x28;
  static const int keyboardEscape = 0x29;
  static const int keyboardSpacebar = 0x2C;
  static const int keyboardTab = 0x2B;
  static const int keyboardArrowUp = 0x52;
  static const int keyboardArrowDown = 0x51;
  static const int keypad1 = 0x59;
  static const int keypadEnter = 0x58;
  static const int keyboardHelp = 0x75;
}

// ---------------------------------------------------------------------------
// Palette — graphite + iOS-style multicolor accents, plus a rust deprecation
// accent so the legacy nature stays visually loud.
// ---------------------------------------------------------------------------
class _Palette {
  static const Color bg = Color(0xFF0B1220);
  static const Color panel = Color(0xFF131C2E);
  static const Color panelAlt = Color(0xFF1B2740);
  static const Color border = Color(0xFF2C3B58);
  static const Color silver = Color(0xFFD8DEE9);
  static const Color graphite = Color(0xFF8AA2C2);
  static const Color iosBlue = Color(0xFF0A84FF);
  static const Color iosBlueSoft = Color(0xFF5AB4FF);
  static const Color iosIndigo = Color(0xFF5E5CE6);
  static const Color iosTeal = Color(0xFF64D2FF);
  static const Color iosGreen = Color(0xFF30D158);
  static const Color iosYellow = Color(0xFFFFD60A);
  static const Color iosOrange = Color(0xFFFF9F0A);
  static const Color iosPink = Color(0xFFFF375F);
  static const Color iosPurple = Color(0xFFBF5AF2);
  static const Color rust = Color(0xFFE04A2A);
  static const Color rustSoft = Color(0xFFFF8A66);
  static const Color textPrimary = Color(0xFFEAF1FB);
  static const Color textSecondary = Color(0xFFAAB9D2);
  static const Color textMuted = Color(0xFF6F7E99);
  static const Color codeBg = Color(0xFF080E1B);
  static const Color codeKeyword = Color(0xFF5AB4FF);
  static const Color codeType = Color(0xFFBF5AF2);
  static const Color codeString = Color(0xFFFFD60A);
  static const Color codeNumber = Color(0xFFFF9F0A);
  static const Color codeComment = Color(0xFF6F7E99);
  static const Color codeIdent = Color(0xFFEAF1FB);
}

// ---------------------------------------------------------------------------
// Typography
// ---------------------------------------------------------------------------
class _Type {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: _Palette.textPrimary,
    letterSpacing: 1.6,
    height: 1.05,
  );
  static const TextStyle heroSub = TextStyle(
    fontSize: 16,
    color: _Palette.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: _Palette.textPrimary,
    letterSpacing: 0.5,
  );
  static const TextStyle sectionLead = TextStyle(
    fontSize: 14,
    color: _Palette.textSecondary,
    height: 1.55,
  );
  static const TextStyle body = TextStyle(
    fontSize: 13,
    color: _Palette.textPrimary,
    height: 1.55,
  );
  static const TextStyle bodyDim = TextStyle(
    fontSize: 13,
    color: _Palette.textSecondary,
    height: 1.55,
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
    height: 1.5,
  );
  static const TextStyle codeKw = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeKeyword,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle codeTy = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeType,
  );
  static const TextStyle codeStr = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeString,
  );
  static const TextStyle codeNum = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeNumber,
  );
  static const TextStyle codeCom = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeComment,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle codeId = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _Palette.codeIdent,
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
                  color: _Palette.iosBlue.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: _Palette.iosBlue.withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    fontSize: 12,
                    color: _Palette.iosBlueSoft,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3,
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
// Code primitives
// ---------------------------------------------------------------------------
class _Tok {
  final String text;
  final TextStyle style;
  _Tok(this.text, [TextStyle? s]) : style = s ?? _Type.code;
}

class _Line {
  final List<_Tok> tokens;
  _Line(this.tokens);
  _Line.plain(String t) : tokens = [_Tok(t)];
  _Line.blank() : tokens = [_Tok('')];
}

class _CodeBlock extends StatelessWidget {
  final List<_Line> lines;
  final EdgeInsets padding;
  const _CodeBlock(
    this.lines, {
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < lines.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${i + 1}'.padLeft(2),
                      style: _Type.codeCom.copyWith(fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: _Type.code,
                        children: [
                          for (final tok in lines[i].tokens)
                            TextSpan(text: tok.text, style: tok.style),
                        ],
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
}

// ---------------------------------------------------------------------------
// SECTION 0 — Deprecation banner
// ---------------------------------------------------------------------------
class _DeprecationBanner extends StatelessWidget {
  const _DeprecationBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 22, 22, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.rust.withValues(alpha: 0.32),
            _Palette.rust.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _Palette.rust.withValues(alpha: 0.7),
          width: 1.4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _Palette.rust.withValues(alpha: 0.92),
              boxShadow: [
                BoxShadow(
                  color: _Palette.rust.withValues(alpha: 0.55),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 26,
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
                Text(
                  'DEPRECATED  ·  prefer KeyEvent / HardwareKeyboard',
                  style: TextStyle(
                    fontSize: 12,
                    color: _Palette.rustSoft,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.6,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'RawKeyEventDataIos belongs to the legacy raw keyboard '
                  'subsystem. The whole RawKeyEvent / RawKeyboard family is '
                  'annotated @Deprecated; new code should consume KeyEvent '
                  'objects through HardwareKeyboard.instance, '
                  'KeyboardListener, or Focus.onKeyEvent. The legacy iOS '
                  'wrapper still ships during the migration window but no '
                  'new fields will be added to it.',
                  style: _Type.bodyDim,
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _DepChip('@Deprecated', _Palette.rust),
                    _DepChip('Use KeyEvent', _Palette.iosBlue),
                    _DepChip('Use HardwareKeyboard', _Palette.iosTeal),
                    _DepChip('Use LogicalKeyboardKey', _Palette.iosIndigo),
                    _DepChip('Migration ongoing', _Palette.rustSoft),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DepChip extends StatelessWidget {
  final String label;
  final Color color;
  const _DepChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.65)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — Hero
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 22, 22, 8),
      padding: EdgeInsets.fromLTRB(28, 30, 28, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Palette.iosBlue.withValues(alpha: 0.22),
            _Palette.iosIndigo.withValues(alpha: 0.18),
            _Palette.panel,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PillTag('flutter/services', _Palette.iosBlue),
              SizedBox(width: 8),
              _PillTag('legacy', _Palette.rust),
              SizedBox(width: 8),
              _PillTag('iOS', _Palette.silver),
              SizedBox(width: 8),
              _PillTag('UIKey', _Palette.iosIndigo),
            ],
          ),
          SizedBox(height: 18),
          Text('RawKeyEventDataIos', style: _Type.heroTitle),
          SizedBox(height: 6),
          Text(
            'The legacy iOS adapter for raw keyboard data',
            style: TextStyle(
              fontSize: 17,
              color: _Palette.iosBlueSoft,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Surfaces a snapshot of an iOS UIKey: the HID-usage keyCode, the '
            'characters as iOS produced them, the unmodified glyphs that '
            'would have been produced without modifiers, and the '
            'UIKeyModifierFlags packed into a single integer. Always reached '
            'as `(rawEvent.data as RawKeyEventDataIos)`.',
            style: _Type.heroSub,
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroFact('keyCode', 'UIKeyboardHIDUsage', _Palette.iosTeal),
              _HeroFact('characters', 'iOS-produced text', _Palette.iosGreen),
              _HeroFact(
                  'charactersIgnoringModifiers', 'unmodified', _Palette.iosYellow),
              _HeroFact('modifiers', 'UIKeyModifierFlags', _Palette.iosOrange),
              _HeroFact('platform', "'ios'", _Palette.iosPink),
            ],
          ),
        ],
      ),
    );
  }
}

class _PillTag extends StatelessWidget {
  final String label;
  final Color color;
  const _PillTag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _HeroFact extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _HeroFact(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Text(label,
              style: TextStyle(
                fontFamily: 'monospace',
                color: _Palette.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(width: 10),
          Text(value,
              style: TextStyle(
                fontFamily: 'monospace',
                color: _Palette.textSecondary,
                fontSize: 11,
              )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — Anatomy diagram of a RawKeyEventDataIos instance
// ---------------------------------------------------------------------------
class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _Palette.panelAlt,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _Palette.iosBlue.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _Palette.iosBlue.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'class',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _Palette.iosBlueSoft,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'RawKeyEventDataIos extends RawKeyEventData',
                    style: _Type.code.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              _FieldRow(
                name: 'keyCode',
                type: 'int',
                role: 'UIKeyboardHIDUsage value of the key',
                color: _Palette.iosTeal,
                example: '0x04 (keyboardA)',
              ),
              _FieldRow(
                name: 'characters',
                type: 'String',
                role: 'iOS-produced text (modifier-applied)',
                color: _Palette.iosGreen,
                example: '"A" when Shift is held with keyCode 0x04',
              ),
              _FieldRow(
                name: 'charactersIgnoringModifiers',
                type: 'String',
                role: 'glyphs without applying modifiers',
                color: _Palette.iosYellow,
                example: '"a" for the same Shift+A press',
              ),
              _FieldRow(
                name: 'modifiers',
                type: 'int',
                role: 'UIKeyModifierFlags bitfield',
                color: _Palette.iosOrange,
                example: '0x20000 (kModifierFlagShift)',
              ),
              _FieldRow(
                name: 'platform',
                type: 'String',
                role: 'always literal value "ios"',
                color: _Palette.iosPink,
                example: '"ios"',
                isLast: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        _CodeBlock([
          _Line([
            _Tok('// ', _Type.codeCom),
            _Tok('Sketch of the legacy iOS path. Reads as:', _Type.codeCom),
          ]),
          _Line([
            _Tok('// ', _Type.codeCom),
            _Tok('UIKey -> platform channel -> RawKeyEventDataIos', _Type.codeCom),
          ]),
          _Line.blank(),
          _Line([
            _Tok('class ', _Type.codeKw),
            _Tok('RawKeyEventDataIos ', _Type.codeTy),
            _Tok('extends ', _Type.codeKw),
            _Tok('RawKeyEventData ', _Type.codeTy),
            _Tok('{', _Type.code),
          ]),
          _Line([
            _Tok('  final ', _Type.codeKw),
            _Tok('int ', _Type.codeTy),
            _Tok('keyCode;', _Type.code),
          ]),
          _Line([
            _Tok('  final ', _Type.codeKw),
            _Tok('String ', _Type.codeTy),
            _Tok('characters;', _Type.code),
          ]),
          _Line([
            _Tok('  final ', _Type.codeKw),
            _Tok('String ', _Type.codeTy),
            _Tok('charactersIgnoringModifiers;', _Type.code),
          ]),
          _Line([
            _Tok('  final ', _Type.codeKw),
            _Tok('int ', _Type.codeTy),
            _Tok('modifiers;', _Type.code),
          ]),
          _Line([
            _Tok('  ', _Type.code),
            _Tok('@override ', _Type.codeKw),
            _Tok('String ', _Type.codeTy),
            _Tok('get ', _Type.codeKw),
            _Tok('keyLabel ', _Type.code),
            _Tok('=> ', _Type.codeKw),
            _Tok('charactersIgnoringModifiers;', _Type.code),
          ]),
          _Line.plain('}'),
        ]),
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  final String name;
  final String type;
  final String role;
  final Color color;
  final String example;
  final bool isLast;
  const _FieldRow({
    required this.name,
    required this.type,
    required this.role,
    required this.color,
    required this.example,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: _Palette.border.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 30,
            margin: EdgeInsets.only(top: 2, right: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: _Palette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: _Type.body),
                SizedBox(height: 3),
                Text('e.g. $example', style: _Type.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 — Modifier bitfield visualization (iOS-specific kModifierFlag*)
// ---------------------------------------------------------------------------
class _ModifierFieldDiagram extends StatelessWidget {
  const _ModifierFieldDiagram();

  @override
  Widget build(BuildContext context) {
    final flags = <_FlagSpec>[
      _FlagSpec(
        name: 'kModifierFlagAlphaShift',
        bit: 16,
        mask: _IosFlag.alphaShift,
        glyph: 'A',
        description:
            'Set when Caps Lock is engaged. iOS reports this as a state bit '
            'rather than as a press, so it stays on across key events.',
        color: _Palette.iosTeal,
      ),
      _FlagSpec(
        name: 'kModifierFlagShift',
        bit: 17,
        mask: _IosFlag.shift,
        glyph: 'shift',
        description:
            'Set while either physical Shift key is held. RawKeyEventDataIos '
            'has no notion of left vs right Shift here — only the combined bit.',
        color: _Palette.iosBlue,
      ),
      _FlagSpec(
        name: 'kModifierFlagControl',
        bit: 18,
        mask: _IosFlag.control,
        glyph: 'ctrl',
        description:
            'Set while Control is held. Used for terminal-style chords and as '
            'a remap target for accessibility hardware.',
        color: _Palette.iosIndigo,
      ),
      _FlagSpec(
        name: 'kModifierFlagAlternate',
        bit: 19,
        mask: _IosFlag.alternate,
        glyph: 'opt',
        description:
            'iOS-side name for the Option / Alt modifier. Matches '
            'UIKeyModifierAlternate; sometimes referred to as "Alt" but the '
            'kModifierFlag* constant uses the Apple name.',
        color: _Palette.iosPurple,
      ),
      _FlagSpec(
        name: 'kModifierFlagCommand',
        bit: 20,
        mask: _IosFlag.command,
        glyph: 'cmd',
        description:
            'Set while either Command key is held. The signature Apple '
            'modifier — used for Cmd+C / Cmd+V style menu shortcuts on '
            'iPad keyboards.',
        color: _Palette.iosPink,
      ),
      _FlagSpec(
        name: 'kModifierFlagNumericPad',
        bit: 21,
        mask: _IosFlag.numericPad,
        glyph: '123',
        description:
            'Set when the originating key belongs to the numeric keypad '
            'cluster. Consumers use it to disambiguate Enter (return) from '
            'numpad-Enter, or to detect numpad arrow keys.',
        color: _Palette.iosGreen,
      ),
      _FlagSpec(
        name: 'kModifierFlagHelp',
        bit: 22,
        mask: _IosFlag.help,
        glyph: '?',
        description:
            'Surfaces the (now historical) Help key on Apple keyboards. '
            'Rarely emitted on modern hardware but the bit remains reserved.',
        color: _Palette.iosYellow,
      ),
      _FlagSpec(
        name: 'kModifierFlagFunction',
        bit: 23,
        mask: _IosFlag.function,
        glyph: 'fn',
        description:
            'Set while the Fn key is held — used to access the F1..F12 '
            'cluster on compact keyboards and to type media-control keys.',
        color: _Palette.iosOrange,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BitRuler(flags: flags),
        SizedBox(height: 18),
        Column(
          children: [
            for (int i = 0; i < flags.length; i++) _FlagCard(flags[i]),
          ],
        ),
        SizedBox(height: 18),
        _CodeBlock([
          _Line([
            _Tok('// ', _Type.codeCom),
            _Tok('Reading the bitfield with bitwise AND.', _Type.codeCom),
          ]),
          _Line.blank(),
          _Line([
            _Tok('final ', _Type.codeKw),
            _Tok('shiftHeld ', _Type.codeId),
            _Tok('= ', _Type.code),
            _Tok('(d.modifiers & 0x20000) != 0;', _Type.code),
          ]),
          _Line([
            _Tok('final ', _Type.codeKw),
            _Tok('cmdHeld ', _Type.codeId),
            _Tok('= ', _Type.code),
            _Tok('(d.modifiers & 0x100000) != 0;', _Type.code),
          ]),
          _Line([
            _Tok('final ', _Type.codeKw),
            _Tok('fnHeld ', _Type.codeId),
            _Tok('= ', _Type.code),
            _Tok('(d.modifiers & 0x800000) != 0;', _Type.code),
          ]),
          _Line.blank(),
          _Line([
            _Tok('// ', _Type.codeCom),
            _Tok('In practice, prefer the helpers:', _Type.codeCom),
          ]),
          _Line([
            _Tok('d.isModifierPressed(ModifierKey.shiftModifier);', _Type.code),
          ]),
          _Line([
            _Tok('d.isModifierPressed(ModifierKey.metaModifier); ', _Type.code),
            _Tok('// Cmd', _Type.codeCom),
          ]),
        ]),
      ],
    );
  }
}

class _FlagSpec {
  final String name;
  final int bit;
  final int mask;
  final String glyph;
  final String description;
  final Color color;
  const _FlagSpec({
    required this.name,
    required this.bit,
    required this.mask,
    required this.glyph,
    required this.description,
    required this.color,
  });
}

class _BitRuler extends StatelessWidget {
  final List<_FlagSpec> flags;
  const _BitRuler({required this.flags});

  @override
  Widget build(BuildContext context) {
    // Show bits 23..0 in a row, highlighting flag bits.
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UIKeyModifierFlags · 24-bit window',
              style: _Type.caption),
          SizedBox(height: 10),
          Row(
            children: [
              for (int b = 23; b >= 0; b--)
                Expanded(
                  child: _BitCell(
                    bit: b,
                    spec: _findSpec(flags, b),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              for (int b = 23; b >= 0; b--)
                Expanded(
                  child: Text(
                    b.toString().padLeft(2, '0'),
                    textAlign: TextAlign.center,
                    style: _Type.codeCom.copyWith(fontSize: 9),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  _FlagSpec? _findSpec(List<_FlagSpec> all, int bit) {
    for (final f in all) {
      if (f.bit == bit) return f;
    }
    return null;
  }
}

class _BitCell extends StatelessWidget {
  final int bit;
  final _FlagSpec? spec;
  const _BitCell({required this.bit, required this.spec});

  @override
  Widget build(BuildContext context) {
    final color = spec?.color ?? _Palette.border;
    final filled = spec != null;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 32,
      decoration: BoxDecoration(
        color: filled
            ? color.withValues(alpha: 0.30)
            : _Palette.panel,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: filled
              ? color.withValues(alpha: 0.75)
              : _Palette.border.withValues(alpha: 0.5),
          width: filled ? 1.2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          filled ? '1' : '0',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: filled ? color : _Palette.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _FlagCard extends StatelessWidget {
  final _FlagSpec spec;
  const _FlagCard(this.spec);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: spec.color.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: spec.color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: spec.color.withValues(alpha: 0.7),
              ),
            ),
            child: Center(
              child: Text(
                spec.glyph,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: spec.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      spec.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: _Palette.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: spec.color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'bit ${spec.bit}  ·  0x${spec.mask.toRadixString(16).toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: spec.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(spec.description, style: _Type.bodyDim),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — Sample event journeys (5 illustrative iOS key presses)
// ---------------------------------------------------------------------------
class _EventJourneys extends StatelessWidget {
  const _EventJourneys();

  @override
  Widget build(BuildContext context) {
    final journeys = <_Journey>[
      _Journey(
        title: "Plain 'a'",
        subtitle: 'Bare letter, no modifiers',
        keyCap: 'a',
        keyCapColor: _Palette.iosBlue,
        keyCode: _HidUsage.keyboardA,
        keyCodeName: 'keyboardA',
        characters: 'a',
        charactersIgnoringModifiers: 'a',
        modifiers: 0,
        activeFlags: const <String>[],
        notes:
            'Simplest possible iOS path: keyCode is the HID usage for A '
            '(0x04), characters and charactersIgnoringModifiers agree, and '
            'modifiers is zero — no UIKeyModifierFlag is set.',
      ),
      _Journey(
        title: "Shift+'A'",
        subtitle: 'Single modifier · case shift',
        keyCap: 'A',
        keyCapColor: _Palette.iosBlueSoft,
        keyCode: _HidUsage.keyboardA,
        keyCodeName: 'keyboardA',
        characters: 'A',
        charactersIgnoringModifiers: 'a',
        modifiers: _IosFlag.shift,
        activeFlags: const ['kModifierFlagShift'],
        notes:
            'Same physical key, but iOS surfaces "A" in characters because '
            'Shift was held. charactersIgnoringModifiers still reports the '
            'unmodified glyph — useful for shortcut matching that should '
            'compare against the unshifted letter.',
      ),
      _Journey(
        title: 'Cmd+C',
        subtitle: 'Menu shortcut · classic copy',
        keyCap: 'C',
        keyCapColor: _Palette.iosPink,
        keyCode: _HidUsage.keyboardC,
        keyCodeName: 'keyboardC',
        characters: '',
        charactersIgnoringModifiers: 'c',
        modifiers: _IosFlag.command,
        activeFlags: const ['kModifierFlagCommand'],
        notes:
            'Cmd+C frequently arrives with empty characters because iOS '
            'consumes the command-modified press as a menu shortcut and '
            "doesn't generate text. charactersIgnoringModifiers still "
            'returns "c", which is the right field to read when matching a '
            'shortcut against a logical key.',
      ),
      _Journey(
        title: "CapsLock + 'a'",
        subtitle: 'AlphaShift latch active',
        keyCap: 'A',
        keyCapColor: _Palette.iosTeal,
        keyCode: _HidUsage.keyboardA,
        keyCodeName: 'keyboardA',
        characters: 'A',
        charactersIgnoringModifiers: 'a',
        modifiers: _IosFlag.alphaShift,
        activeFlags: const ['kModifierFlagAlphaShift'],
        notes:
            'CapsLock is reported as a *state* via kModifierFlagAlphaShift '
            'rather than a held modifier; the bit stays set across multiple '
            'subsequent key events until CapsLock is toggled off. iOS does '
            'apply the case shift to characters.',
      ),
      _Journey(
        title: 'Fn+F1',
        subtitle: 'Function key cluster',
        keyCap: 'F1',
        keyCapColor: _Palette.iosOrange,
        keyCode: _HidUsage.keyboardF1,
        keyCodeName: 'keyboardF1',
        characters: '',
        charactersIgnoringModifiers: '',
        modifiers: _IosFlag.function,
        activeFlags: const ['kModifierFlagFunction'],
        notes:
            'Function keys typically produce no text on iOS — both '
            'character fields are empty. The press is discriminated purely '
            'by keyCode (UIKeyboardHIDUsage F1) plus the function flag set '
            'in the modifier bitfield.',
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < journeys.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: _JourneyCard(j: journeys[i], index: i + 1),
          ),
      ],
    );
  }
}

class _Journey {
  final String title;
  final String subtitle;
  final String keyCap;
  final Color keyCapColor;
  final int keyCode;
  final String keyCodeName;
  final String characters;
  final String charactersIgnoringModifiers;
  final int modifiers;
  final List<String> activeFlags;
  final String notes;
  const _Journey({
    required this.title,
    required this.subtitle,
    required this.keyCap,
    required this.keyCapColor,
    required this.keyCode,
    required this.keyCodeName,
    required this.characters,
    required this.charactersIgnoringModifiers,
    required this.modifiers,
    required this.activeFlags,
    required this.notes,
  });
}

class _JourneyCard extends StatelessWidget {
  final _Journey j;
  final int index;
  const _JourneyCard({required this.j, required this.index});

  @override
  Widget build(BuildContext context) {
    final modifiersHex =
        '0x${j.modifiers.toRadixString(16).toUpperCase().padLeft(6, '0')}';
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: j.keyCapColor.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _KeyCap(label: j.keyCap, color: j.keyCapColor),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: j.keyCapColor.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'JOURNEY · ${index.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: j.keyCapColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(j.title,
                        style: _Type.body.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: 3),
                    Text(j.subtitle, style: _Type.bodyDim),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          _JourneyFieldRow(
            label: 'keyCode',
            value:
                '0x${j.keyCode.toRadixString(16).toUpperCase().padLeft(2, '0')}  ·  ${j.keyCodeName}',
            color: _Palette.iosTeal,
          ),
          _JourneyFieldRow(
            label: 'characters',
            value: j.characters.isEmpty ? '"" (empty)' : '"${j.characters}"',
            color: _Palette.iosGreen,
          ),
          _JourneyFieldRow(
            label: 'charactersIgnoringModifiers',
            value: j.charactersIgnoringModifiers.isEmpty
                ? '"" (empty)'
                : '"${j.charactersIgnoringModifiers}"',
            color: _Palette.iosYellow,
          ),
          _JourneyFieldRow(
            label: 'modifiers',
            value: j.modifiers == 0 ? '$modifiersHex  ·  none' : modifiersHex,
            color: _Palette.iosOrange,
          ),
          if (j.activeFlags.isNotEmpty) ...[
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final f in j.activeFlags)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: _Palette.iosOrange.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: _Palette.iosOrange.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.5,
                        color: _Palette.iosOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _Palette.panel,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _Palette.border.withValues(alpha: 0.7),
              ),
            ),
            child: Text(j.notes, style: _Type.bodyDim),
          ),
        ],
      ),
    );
  }
}

class _KeyCap extends StatelessWidget {
  final String label;
  final Color color;
  const _KeyCap({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      height: 78,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.35),
            color.withValues(alpha: 0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.8),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.30),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 26,
            color: _Palette.textPrimary,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class _JourneyFieldRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _JourneyFieldRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _Palette.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — characters vs charactersIgnoringModifiers explainer
// ---------------------------------------------------------------------------
class _CharactersExplainer extends StatelessWidget {
  const _CharactersExplainer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CharColumn(
                label: 'characters',
                color: _Palette.iosGreen,
                lead:
                    'iOS-produced text after applying modifiers and dead-key '
                    'composition. This is what would normally be inserted '
                    'into a text field — and is intentionally a String, not '
                    'a single code unit, because composing keys can produce '
                    'multiple glyphs.',
                examples: [
                  _CharEx("'a' alone", '"a"', _Palette.iosGreen),
                  _CharEx("Shift+'a'", '"A"', _Palette.iosBlue),
                  _CharEx("Option+'e'", '"" (then "é")', _Palette.iosPurple),
                  _CharEx('Cmd+C', '"" (consumed)', _Palette.iosPink),
                  _CharEx('F1', '"" (no glyph)', _Palette.iosOrange),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _CharColumn(
                label: 'charactersIgnoringModifiers',
                color: _Palette.iosYellow,
                lead:
                    'The glyph the key would have produced *without* '
                    'modifiers — the field to use when matching against a '
                    'shortcut. iOS still uses the active keyboard layout '
                    'for the lookup, but skips Shift / Caps / Cmd / Option.',
                examples: [
                  _CharEx("'a' alone", '"a"', _Palette.iosGreen),
                  _CharEx("Shift+'a'", '"a"', _Palette.iosBlue),
                  _CharEx("Option+'e'", '"e"', _Palette.iosPurple),
                  _CharEx('Cmd+C', '"c"', _Palette.iosPink),
                  _CharEx('F1', '""', _Palette.iosOrange),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _Palette.iosTeal.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _Palette.iosTeal.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  color: _Palette.iosTeal, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Rule of thumb: read characters when echoing typed text '
                  'into a buffer; read charactersIgnoringModifiers (or, in '
                  'modern code, LogicalKeyboardKey) when implementing '
                  'shortcut bindings — otherwise Shift+/ vs Shift+? mapping '
                  'breaks across keyboard layouts.',
                  style: _Type.bodyDim,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CharEx {
  final String trigger;
  final String value;
  final Color color;
  const _CharEx(this.trigger, this.value, this.color);
}

class _CharColumn extends StatelessWidget {
  final String label;
  final Color color;
  final String lead;
  final List<_CharEx> examples;
  const _CharColumn({
    required this.label,
    required this.color,
    required this.lead,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _Palette.panelAlt,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(lead, style: _Type.bodyDim),
          SizedBox(height: 14),
          for (final ex in examples)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: ex.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(ex.trigger, style: _Type.body),
                  ),
                  Text(
                    ex.value,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
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
// SECTION 6 — UIKeyboardHIDUsage keyCode reference table
// ---------------------------------------------------------------------------
class _HidUsageTable extends StatelessWidget {
  const _HidUsageTable();

  @override
  Widget build(BuildContext context) {
    final entries = <_UsageRow>[
      _UsageRow('keyboardA', _HidUsage.keyboardA, 'letter A',
          _Palette.iosBlue),
      _UsageRow('keyboardC', _HidUsage.keyboardC, 'letter C',
          _Palette.iosBlueSoft),
      _UsageRow('keyboardReturn', _HidUsage.keyboardReturn, 'main Return',
          _Palette.iosGreen),
      _UsageRow('keyboardEscape', _HidUsage.keyboardEscape, 'Escape',
          _Palette.iosPink),
      _UsageRow('keyboardTab', _HidUsage.keyboardTab, 'horizontal Tab',
          _Palette.iosTeal),
      _UsageRow('keyboardSpacebar', _HidUsage.keyboardSpacebar,
          'Space (0x2C)', _Palette.iosYellow),
      _UsageRow('keyboardCapsLock', _HidUsage.keyboardCapsLock,
          'Caps Lock toggle', _Palette.iosOrange),
      _UsageRow('keyboardF1', _HidUsage.keyboardF1, 'F1 function key',
          _Palette.iosPurple),
      _UsageRow('keyboardArrowUp', _HidUsage.keyboardArrowUp, 'arrow up',
          _Palette.iosBlueSoft),
      _UsageRow('keyboardArrowDown', _HidUsage.keyboardArrowDown,
          'arrow down', _Palette.iosBlue),
      _UsageRow('keyboardLeftShift', _HidUsage.keyboardLeftShift,
          'left Shift modifier', _Palette.iosIndigo),
      _UsageRow('keyboardLeftControl', _HidUsage.keyboardLeftControl,
          'left Control modifier', _Palette.iosTeal),
      _UsageRow('keyboardLeftCommand', _HidUsage.keyboardLeftCommand,
          'left Command (Cmd)', _Palette.iosPink),
      _UsageRow('keyboardRightCommand', _HidUsage.keyboardRightCommand,
          'right Command (Cmd)', _Palette.iosPink),
      _UsageRow('keyboardLeftAlt', _HidUsage.keyboardLeftAlt,
          'left Option (Alt)', _Palette.iosPurple),
      _UsageRow('keyboardHelp', _HidUsage.keyboardHelp,
          'Help (legacy Apple)', _Palette.iosYellow),
      _UsageRow('keypad1', _HidUsage.keypad1,
          'numpad 1 (with kModifierFlagNumericPad)', _Palette.iosGreen),
      _UsageRow('keypadEnter', _HidUsage.keypadEnter,
          'numpad Enter (distinct from Return)', _Palette.iosGreen),
    ];

    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: _Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: _Palette.border, width: 1),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: Text('Constant', style: _Type.caption),
                ),
                SizedBox(
                  width: 90,
                  child: Text('Hex', style: _Type.caption),
                ),
                SizedBox(
                  width: 90,
                  child: Text('Decimal', style: _Type.caption),
                ),
                Expanded(
                  child: Text('Meaning', style: _Type.caption),
                ),
              ],
            ),
          ),
          for (int i = 0; i < entries.length; i++)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: i.isEven
                    ? Colors.transparent
                    : _Palette.panel.withValues(alpha: 0.5),
                border: Border(
                  bottom: BorderSide(
                    color: _Palette.border.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 220,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 18,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: entries[i].color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Expanded(
                          child: Text(entries[i].name,
                              style: _Type.code.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      '0x${entries[i].value.toRadixString(16).toUpperCase().padLeft(2, '0')}',
                      style: _Type.codeStr,
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      entries[i].value.toString(),
                      style: _Type.codeNum,
                    ),
                  ),
                  Expanded(
                    child: Text(entries[i].meaning, style: _Type.bodyDim),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _UsageRow {
  final String name;
  final int value;
  final String meaning;
  final Color color;
  const _UsageRow(this.name, this.value, this.meaning, this.color);
}
