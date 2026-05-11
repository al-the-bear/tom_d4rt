// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Palette — Windows / Aero / Win32 inspired
// ---------------------------------------------------------------------------
const Color _kAero = Color(0xFF0078D4);
const Color _kAeroDeep = Color(0xFF005A9E);
const Color _kAeroLight = Color(0xFF50A0E0);
const Color _kSteel = Color(0xFF2D2D30);
const Color _kSteelLight = Color(0xFF3E3E42);
const Color _kSkyBg = Color(0xFFEBF1F9);
const Color _kSkyMid = Color(0xFFD5E3F2);
const Color _kInk = Color(0xFF1B1B1F);
const Color _kInkSoft = Color(0xFF42434A);
const Color _kMuted = Color(0xFF6F7884);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFC8D4E2);
const Color _kStripe = Color(0xFFF2F6FB);

// Windows logo squares
const Color _kWinRed = Color(0xFFE81123);
const Color _kWinGreen = Color(0xFF7CBA00);
const Color _kWinYellow = Color(0xFFFFB900);
const Color _kWinBlue = Color(0xFF00A4EF);

// Severity / status
const Color _kOk = Color(0xFF107C10);
const Color _kWarn = Color(0xFFCA5010);
const Color _kErr = Color(0xFFC42B1C);
const Color _kInfo = Color(0xFF0078D4);

// ---------------------------------------------------------------------------
// Hero — Aero-blue gradient title card
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 26.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0078D4),
            Color(0xFF005A9E),
            Color(0xFF2D2D30),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    color: const Color(0x55FFFFFF), width: 1.0),
              ),
              child: const Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE81123),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'DEPRECATED',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 14.0),
          const Text(
            'RawKeyEventDataWindows',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Win32 VK code anatomy — virtual keys, scan codes & modifier bitmasks',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFFE8F0F8),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18.0),
          Row(children: <Widget>[
            _HeroChip(label: 'subclass of', value: 'RawKeyEventData'),
            SizedBox(width: 8.0),
            _HeroChip(label: 'platform', value: 'Windows 7+'),
            SizedBox(width: 8.0),
            _HeroChip(label: 'kernel', value: 'win32/user32'),
          ]),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final String value;
  const _HeroChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: BorderRadius.circular(6.0),
        border:
            Border.all(color: const Color(0x44FFFFFF), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.0,
              color: Color(0xFFB8D4EC),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section header with windows logo flag
// ---------------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEBF1F9)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _WindowsFlag(size: 32.0),
          const SizedBox(width: 12.0),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: _kAero,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kMuted,
                    height: 1.3,
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
// Windows flag — 4 squares (red / green / yellow / blue)
// ---------------------------------------------------------------------------
class _WindowsFlag extends StatelessWidget {
  final double size;
  const _WindowsFlag({required this.size});

  @override
  Widget build(BuildContext context) {
    final double sq = (size - 4.0) / 2.0;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(children: <Widget>[
        Positioned(
          left: 0.0,
          top: 0.0,
          child: Container(width: sq, height: sq, color: _kWinRed),
        ),
        Positioned(
          left: sq + 4.0,
          top: 0.0,
          child: Container(width: sq, height: sq, color: _kWinGreen),
        ),
        Positioned(
          left: 0.0,
          top: sq + 4.0,
          child: Container(width: sq, height: sq, color: _kWinBlue),
        ),
        Positioned(
          left: sq + 4.0,
          top: sq + 4.0,
          child: Container(width: sq, height: sq, color: _kWinYellow),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// Subclass hierarchy
// ---------------------------------------------------------------------------
class _Hierarchy extends StatelessWidget {
  const _Hierarchy();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Class hierarchy',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _kMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF2D2D30), Color(0xFF3E3E42)],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'RawKeyEventData  (abstract, deprecated)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Container(
              width: 1.5,
              height: 16.0,
              color: _kMuted,
            ),
          ),
          const SizedBox(height: 6.0),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: const <Widget>[
              _SubclassChip(name: 'Android', highlight: false),
              _SubclassChip(name: 'iOS', highlight: false),
              _SubclassChip(name: 'Linux', highlight: false),
              _SubclassChip(name: 'macOS', highlight: false),
              _SubclassChip(name: 'Web', highlight: false),
              _SubclassChip(name: 'Windows', highlight: true),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEBF4FB),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                  color: const Color(0xFFB6D7EC), width: 1.0),
            ),
            child: const Text(
              'RawKeyEventDataWindows carries Win32-specific fields: the virtual-key code (VK_*), the hardware scan code from WM_KEYDOWN lParam bits 16–23, the UTF-16 character code point, and the bitmasked modifier state.',
              style: TextStyle(
                fontSize: 12.0,
                color: _kInkSoft,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubclassChip extends StatelessWidget {
  final String name;
  final bool highlight;
  const _SubclassChip({required this.name, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        gradient: highlight
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF0078D4), Color(0xFF005A9E)],
              )
            : null,
        color: highlight ? null : const Color(0xFFF2F6FB),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: highlight ? const Color(0xFF005A9E) : _kBorder,
          width: highlight ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (highlight) ...<Widget>[
            const _WindowsFlag(size: 14.0),
            const SizedBox(width: 6.0),
          ],
          Text(
            'RawKeyEventData$name',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
              color: highlight
                  ? const Color(0xFFFFFFFF)
                  : _kInkSoft,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Field anatomy
// ---------------------------------------------------------------------------
class _FieldAnatomy extends StatelessWidget {
  const _FieldAnatomy();

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      _FieldCard(
        name: 'keyCode',
        type: 'int',
        example: '0x0D  // VK_RETURN',
        description:
            'Windows virtual-key code as defined in WinUser.h. Layout-independent — VK_A is 0x41 regardless of QWERTY/AZERTY.',
        accent: _kAero,
      ),
      SizedBox(height: 10.0),
      _FieldCard(
        name: 'scanCode',
        type: 'int',
        example: '0x1C  // hardware ENTER',
        description:
            'Hardware scan code from WM_KEYDOWN lParam bits 16–23. Position-dependent — physical key location on the keyboard PCB.',
        accent: _kWinBlue,
      ),
      SizedBox(height: 10.0),
      _FieldCard(
        name: 'characterCodePoint',
        type: 'int',
        example: '0x0061  // \'a\'',
        description:
            'UTF-16 code point produced by ToUnicode() — the actual character that would be typed, accounting for shift/AltGr/dead keys.',
        accent: _kWinGreen,
      ),
      SizedBox(height: 10.0),
      _FieldCard(
        name: 'modifiers',
        type: 'int',
        example: '0x06  // CTRL + SHIFT',
        description:
            'Bitmask of held modifier keys at the moment of the event. See section 5 for the layout of the individual bits.',
        accent: _kWinYellow,
      ),
    ]);
  }
}

class _FieldCard extends StatelessWidget {
  final String name;
  final String type;
  final String example;
  final String description;
  final Color accent;
  const _FieldCard({
    required this.name,
    required this.type,
    required this.example,
    required this.description,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 6.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF4FB),
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(
                            color: const Color(0xFFB6D7EC),
                            width: 1.0),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          color: _kAeroDeep,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      example,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: _kInkSoft,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: _kInkSoft,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// VK code table
// ---------------------------------------------------------------------------
class _VkTable extends StatelessWidget {
  const _VkTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(children: const <Widget>[
        _VkHeader(),
        _VkRow(name: 'VK_RETURN',   hex: '0x0D', dec: '13',  desc: 'Enter / Return key'),
        _VkRow(name: 'VK_ESCAPE',   hex: '0x1B', dec: '27',  desc: 'Escape key'),
        _VkRow(name: 'VK_TAB',      hex: '0x09', dec: '9',   desc: 'Tab key'),
        _VkRow(name: 'VK_SPACE',    hex: '0x20', dec: '32',  desc: 'Spacebar'),
        _VkRow(name: 'VK_BACK',     hex: '0x08', dec: '8',   desc: 'Backspace'),
        _VkRow(name: 'VK_SHIFT',    hex: '0x10', dec: '16',  desc: 'Either Shift key'),
        _VkRow(name: 'VK_CONTROL',  hex: '0x11', dec: '17',  desc: 'Either Control key'),
        _VkRow(name: 'VK_MENU',     hex: '0x12', dec: '18',  desc: 'Alt key (Menu)'),
        _VkRow(name: 'VK_LWIN',     hex: '0x5B', dec: '91',  desc: 'Left Windows logo'),
        _VkRow(name: 'VK_RWIN',     hex: '0x5C', dec: '92',  desc: 'Right Windows logo'),
        _VkRow(name: 'VK_LEFT',     hex: '0x25', dec: '37',  desc: 'Arrow Left'),
        _VkRow(name: 'VK_UP',       hex: '0x26', dec: '38',  desc: 'Arrow Up'),
        _VkRow(name: 'VK_RIGHT',    hex: '0x27', dec: '39',  desc: 'Arrow Right'),
        _VkRow(name: 'VK_DOWN',     hex: '0x28', dec: '40',  desc: 'Arrow Down'),
        _VkRow(name: 'VK_F1',       hex: '0x70', dec: '112', desc: 'Function key F1'),
        _VkRow(name: 'VK_F2',       hex: '0x71', dec: '113', desc: 'Function key F2'),
        _VkRow(name: 'VK_F5',       hex: '0x74', dec: '116', desc: 'Function key F5'),
        _VkRow(name: 'VK_F11',      hex: '0x7A', dec: '122', desc: 'Function key F11'),
        _VkRow(name: 'VK_F12',      hex: '0x7B', dec: '123', desc: 'Function key F12'),
        _VkRow(name: 'VK_DELETE',   hex: '0x2E', dec: '46',  desc: 'Delete key'),
      ]),
    );
  }
}

class _VkHeader extends StatelessWidget {
  const _VkHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF2D2D30), Color(0xFF3E3E42)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(children: const <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            'VK_CONSTANT',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            'HEX',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        SizedBox(
          width: 44.0,
          child: Text(
            'DEC',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'DESCRIPTION',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ]),
    );
  }
}

class _VkRow extends StatelessWidget {
  final String name;
  final String hex;
  final String dec;
  final String desc;
  const _VkRow({
    required this.name,
    required this.hex,
    required this.dec,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 14.0, vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _kStripe, width: 1.0),
        ),
      ),
      child: Row(children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: _kAeroDeep,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            hex,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInk,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 44.0,
          child: Text(
            dec,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              fontSize: 12.0,
              color: _kInkSoft,
            ),
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// Modifier bitmask
// ---------------------------------------------------------------------------
class _Modifiers extends StatelessWidget {
  const _Modifiers();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF2F6FB)],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'modifiers — int bitmask',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(children: const <Widget>[
            _ModBit(
              name: 'SHIFT',
              bit: '0x01',
              accessor: 'isShiftPressed',
              color: _kWinRed,
            ),
            SizedBox(width: 8.0),
            _ModBit(
              name: 'CTRL',
              bit: '0x02',
              accessor: 'isControlPressed',
              color: _kWinGreen,
            ),
            SizedBox(width: 8.0),
            _ModBit(
              name: 'ALT',
              bit: '0x04',
              accessor: 'isAltPressed',
              color: _kWinBlue,
            ),
            SizedBox(width: 8.0),
            _ModBit(
              name: 'WIN',
              bit: '0x08',
              accessor: 'isMetaPressed',
              color: _kWinYellow,
            ),
          ]),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1F),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              '// bit layout (little-endian)\n'
              '//  7  6  5  4  3  2  1  0\n'
              '// ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─\n'
              '//  ·  ·  ·  ·  W  A  C  S\n'
              '// e.g. CTRL + SHIFT pressed = 0b00000011 = 0x03',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFFE8F0F8),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModBit extends StatelessWidget {
  final String name;
  final String bit;
  final String accessor;
  final Color color;
  const _ModBit({
    required this.name,
    required this.bit,
    required this.accessor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 6.0),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
            ]),
            const SizedBox(height: 6.0),
            Text(
              bit,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: _kAeroDeep,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              accessor,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: _kMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// scanCode vs keyCode
// ---------------------------------------------------------------------------
class _ScanVsKey extends StatelessWidget {
  const _ScanVsKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _CompareCard(
          title: 'scanCode',
          subtitle: 'hardware position',
          color: _kWinBlue,
          examples: <String>[
            'US "A"  → 0x1E',
            'DE "A"  → 0x1E  (same key)',
            'US "Y"  → 0x15',
            'DE "Y"  → 0x15  (key labelled Z)',
          ],
          summary:
              'Position of a physical key on the PCB. Independent of language layout. Useful for games and shortcuts that follow finger position.',
        ),
        SizedBox(width: 12.0),
        _CompareCard(
          title: 'keyCode',
          subtitle: 'logical / VK',
          color: _kAero,
          examples: <String>[
            'US "A"  → VK_A  (0x41)',
            'DE "A"  → VK_A  (0x41)',
            'US "Y"  → VK_Y  (0x59)',
            'DE "Y"  → VK_Z  (0x5A)',
          ],
          summary:
              'Layout-dependent logical key. Matches the labelled character on the user\'s keyboard. Prefer this for text-aware shortcuts.',
        ),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final List<String> examples;
  final String summary;
  const _CompareCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.examples,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kBorder, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(width: 6.0),
              Text(
                '· $subtitle',
                style: const TextStyle(
                  fontSize: 11.0,
                  color: _kMuted,
                ),
              ),
            ]),
            const SizedBox(height: 10.0),
            for (final String ex in examples)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  ex,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: _kInkSoft,
                  ),
                ),
              ),
            const SizedBox(height: 10.0),
            Container(height: 1.0, color: _kStripe),
            const SizedBox(height: 10.0),
            Text(
              summary,
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInkSoft,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Extended-key flag
// ---------------------------------------------------------------------------
class _ExtendedKey extends StatelessWidget {
  const _ExtendedKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFEBF1F9)],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The 0xE0 extended-key prefix',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Some keys share a scan code with a numpad twin. The Win32 keyboard driver emits a 0xE0 prefix byte to disambiguate them. Flutter folds this into a wider scan code.',
            style: TextStyle(
              fontSize: 12.0,
              color: _kInkSoft,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14.0),
          Row(children: const <Widget>[
            _ExtKeyRow(
              base: '0x4B',
              ext: '0xE04B',
              label: 'Numpad 4',
              labelExt: 'Arrow Left',
            ),
          ]),
          const SizedBox(height: 8.0),
          Row(children: const <Widget>[
            _ExtKeyRow(
              base: '0x48',
              ext: '0xE048',
              label: 'Numpad 8',
              labelExt: 'Arrow Up',
            ),
          ]),
          const SizedBox(height: 8.0),
          Row(children: const <Widget>[
            _ExtKeyRow(
              base: '0x1C',
              ext: '0xE01C',
              label: 'Enter (main)',
              labelExt: 'Numpad Enter',
            ),
          ]),
          const SizedBox(height: 8.0),
          Row(children: const <Widget>[
            _ExtKeyRow(
              base: '0x1D',
              ext: '0xE01D',
              label: 'Left Ctrl',
              labelExt: 'Right Ctrl',
            ),
          ]),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4CE),
              borderRadius: BorderRadius.circular(6.0),
              border:
                  Border.all(color: const Color(0xFFFFB900), width: 1.0),
            ),
            child: const Text(
              'lParam bit 24 of WM_KEYDOWN is the extended-key flag. When set, the platform channel forwards the scan code prefixed by 0xE0.',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF6B4E00),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExtKeyRow extends StatelessWidget {
  final String base;
  final String ext;
  final String label;
  final String labelExt;
  const _ExtKeyRow({
    required this.base,
    required this.ext,
    required this.label,
    required this.labelExt,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEBF4FB),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
                color: const Color(0xFFB6D7EC), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                base,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: _kAeroDeep,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: _kInkSoft,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 28.0,
          height: 1.0,
          color: _kMuted,
        ),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE81123),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            '+0xE0',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 28.0,
          height: 1.0,
          color: _kMuted,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF0078D4), Color(0xFF005A9E)],
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ext,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Text(
                  labelExt,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFFE8F0F8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// Keyboard layout diagram (stylized 104-key)
// ---------------------------------------------------------------------------
class _KeyboardDiagram extends StatelessWidget {
  const _KeyboardDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF3E3E42), Color(0xFF2D2D30)],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border:
            Border.all(color: const Color(0xFF1B1B1F), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '104-key US layout · 8 keys annotated with VK code',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFB8D4EC),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(children: const <Widget>[
            _Key(label: 'Esc', vk: 'VK_ESCAPE\n0x1B', highlight: true),
            SizedBox(width: 6.0),
            _Key(label: 'F1', vk: 'VK_F1\n0x70', highlight: true),
            SizedBox(width: 6.0),
            _Key(label: 'F2', vk: '0x71'),
            SizedBox(width: 6.0),
            _Key(label: 'F3', vk: '0x72'),
            SizedBox(width: 6.0),
            _Key(label: 'F4', vk: '0x73'),
            SizedBox(width: 6.0),
            _Key(label: 'F5', vk: '0x74'),
            SizedBox(width: 6.0),
            _Key(label: 'F6', vk: '0x75'),
            SizedBox(width: 6.0),
            _Key(label: 'F7', vk: '0x76'),
            SizedBox(width: 6.0),
            _Key(label: 'F8', vk: '0x77'),
          ]),
          const SizedBox(height: 6.0),
          Row(children: const <Widget>[
            _Key(label: '`', vk: '0xC0'),
            SizedBox(width: 6.0),
            _Key(label: '1', vk: '0x31'),
            SizedBox(width: 6.0),
            _Key(label: '2', vk: '0x32'),
            SizedBox(width: 6.0),
            _Key(label: '3', vk: '0x33'),
            SizedBox(width: 6.0),
            _Key(label: '4', vk: '0x34'),
            SizedBox(width: 6.0),
            _Key(label: '5', vk: '0x35'),
            SizedBox(width: 6.0),
            _Key(label: '6', vk: '0x36'),
            SizedBox(width: 6.0),
            _Key(label: '7', vk: '0x37'),
            SizedBox(width: 6.0),
            _Key(label: '8', vk: '0x38'),
          ]),
          const SizedBox(height: 6.0),
          Row(children: const <Widget>[
            _Key(label: 'Tab', vk: 'VK_TAB\n0x09', highlight: true, wide: true),
            SizedBox(width: 6.0),
            _Key(label: 'Q', vk: '0x51'),
            SizedBox(width: 6.0),
            _Key(label: 'W', vk: '0x57'),
            SizedBox(width: 6.0),
            _Key(label: 'E', vk: '0x45'),
            SizedBox(width: 6.0),
            _Key(label: 'R', vk: '0x52'),
            SizedBox(width: 6.0),
            _Key(label: 'T', vk: '0x54'),
            SizedBox(width: 6.0),
            _Key(label: 'Y', vk: '0x59'),
            SizedBox(width: 6.0),
            _Key(label: 'U', vk: '0x55'),
          ]),
          const SizedBox(height: 6.0),
          Row(children: const <Widget>[
            _Key(label: 'Caps', vk: '0x14', wide: true),
            SizedBox(width: 6.0),
            _Key(label: 'A', vk: '0x41'),
            SizedBox(width: 6.0),
            _Key(label: 'S', vk: 'VK_S\n0x53', highlight: true),
            SizedBox(width: 6.0),
            _Key(label: 'D', vk: '0x44'),
            SizedBox(width: 6.0),
            _Key(label: 'F', vk: '0x46'),
            SizedBox(width: 6.0),
            _Key(label: 'G', vk: '0x47'),
            SizedBox(width: 6.0),
            _Key(label: 'H', vk: '0x48'),
            SizedBox(width: 6.0),
            _Key(label: 'J', vk: '0x4A'),
          ]),
          const SizedBox(height: 6.0),
          Row(children: const <Widget>[
            _Key(
              label: 'Shift',
              vk: 'VK_SHIFT\n0x10',
              highlight: true,
              wide: true,
            ),
            SizedBox(width: 6.0),
            _Key(label: 'Z', vk: '0x5A'),
            SizedBox(width: 6.0),
            _Key(label: 'X', vk: '0x58'),
            SizedBox(width: 6.0),
            _Key(label: 'C', vk: '0x43'),
            SizedBox(width: 6.0),
            _Key(label: 'V', vk: '0x56'),
            SizedBox(width: 6.0),
            _Key(label: 'B', vk: '0x42'),
            SizedBox(width: 6.0),
            _Key(label: 'N', vk: '0x4E'),
            SizedBox(width: 6.0),
            _Key(label: 'M', vk: '0x4D'),
          ]),
          const SizedBox(height: 6.0),
          Row(children: const <Widget>[
            _Key(
              label: 'Ctrl',
              vk: 'VK_CONTROL\n0x11',
              highlight: true,
              wide: true,
            ),
            SizedBox(width: 6.0),
            _Key(label: 'Win', vk: 'VK_LWIN\n0x5B', highlight: true),
            SizedBox(width: 6.0),
            _Key(label: 'Alt', vk: 'VK_MENU\n0x12', highlight: true),
            SizedBox(width: 6.0),
            _KeySpace(),
            SizedBox(width: 6.0),
            _Key(label: 'Alt', vk: '0x12'),
            SizedBox(width: 6.0),
            _Key(label: 'Ctrl', vk: '0x11'),
          ]),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  final String label;
  final String vk;
  final bool highlight;
  final bool wide;
  const _Key({
    required this.label,
    required this.vk,
    this.highlight = false,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? 70.0 : 46.0,
      height: 54.0,
      decoration: BoxDecoration(
        gradient: highlight
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF50A0E0), Color(0xFF0078D4)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF55585E), Color(0xFF3E3E42)],
              ),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            color: const Color(0xFF1B1B1F), width: 0.5),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
          const Spacer(),
          Text(
            vk,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 8.0,
              color: Color(0xFFD5E3F2),
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeySpace extends StatelessWidget {
  const _KeySpace();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 54.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF55585E), Color(0xFF3E3E42)],
        ),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            color: const Color(0xFF1B1B1F), width: 0.5),
      ),
      child: const Center(
        child: Text(
          'VK_SPACE  0x20',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE8F0F8),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Code block — Ctrl+S example
// ---------------------------------------------------------------------------
class _CodeBlock extends StatelessWidget {
  const _CodeBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1F),
        borderRadius: BorderRadius.circular(10.0),
        border:
            Border.all(color: const Color(0xFF0F0F12), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xFF2D2D30), Color(0xFF1B1B1F)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFE81123),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB900),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF7CBA00),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'shortcut.dart  ·  Ctrl+S handler',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFFB8D4EC),
                  letterSpacing: 0.4,
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'RawKeyboard.instance.addListener((event) {',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
                  ),
                ),
                Text(
                  '  if (event.data is RawKeyEventDataWindows) {',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
                  ),
                ),
                Text(
                  '    final win = event.data as RawKeyEventDataWindows;',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
                  ),
                ),
                Text(
                  '    if (win.isControlPressed && win.keyCode == 0x53) {  // Ctrl+S',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFF7CBA00),
                  ),
                ),
                Text(
                  '      saveDocument();',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFFFB900),
                  ),
                ),
                Text(
                  '    }',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
                  ),
                ),
                Text(
                  '  }',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
                  ),
                ),
                Text(
                  '});',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFD5E3F2),
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
// Deprecation banner — old vs new
// ---------------------------------------------------------------------------
class _Deprecation extends StatelessWidget {
  const _Deprecation();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFE81123), Color(0xFFC42B1C)],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'MIGRATION',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'RawKeyboard → HardwareKeyboard',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ]),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _MigrationSide(
                title: 'OLD (deprecated)',
                lines: <String>[
                  'RawKeyboard.instance.addListener((event) {',
                  '  final w = event.data as',
                  '      RawKeyEventDataWindows;',
                  '  if (w.keyCode == 0x1B) ...',
                  '});',
                ],
                bgColor: Color(0x33000000),
              ),
              SizedBox(width: 12.0),
              _MigrationSide(
                title: 'NEW (recommended)',
                lines: <String>[
                  'HardwareKeyboard.instance',
                  '    .addHandler((event) {',
                  '  if (event.logicalKey ==',
                  '      LogicalKeyboardKey.escape) ...',
                  '  return false;',
                  '});',
                ],
                bgColor: Color(0x33007130),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'The new API is platform-agnostic — no more `data is RawKeyEventDataWindows` casts. Use LogicalKeyboardKey / PhysicalKeyboardKey constants instead of raw integers.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFFFFE0E0),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _MigrationSide extends StatelessWidget {
  final String title;
  final List<String> lines;
  final Color bgColor;
  const _MigrationSide({
    required this.title,
    required this.lines,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFE0E0),
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 8.0),
            for (final String l in lines)
              Text(
                l,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFFFFFFFF),
                  height: 1.4,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Use cases
// ---------------------------------------------------------------------------
class _UseCases extends StatelessWidget {
  const _UseCases();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _UseCaseCard(
            color: _kWinRed,
            tag: '01',
            title: 'Shortcut handling',
            body:
                'Detect Ctrl+S, Ctrl+Z, Ctrl+Shift+P with raw VK codes for fast keymap routing in code editors.',
          ),
          SizedBox(width: 10.0),
          _UseCaseCard(
            color: _kWinGreen,
            tag: '02',
            title: 'Accessibility',
            body:
                'Inspect modifier combinations to provide alternate behaviour for sticky-keys and bounce-keys users.',
          ),
        ],
      ),
      const SizedBox(height: 10.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _UseCaseCard(
            color: _kWinBlue,
            tag: '03',
            title: 'IME composition',
            body:
                'characterCodePoint reveals the composed character after IME pre-edit collapses — useful for CJK input.',
          ),
          SizedBox(width: 10.0),
          _UseCaseCard(
            color: _kWinYellow,
            tag: '04',
            title: 'Gaming / WASD',
            body:
                'scanCode is layout-independent — perfect for movement keys that follow finger position, not labels.',
          ),
        ],
      ),
    ]);
  }
}

class _UseCaseCard extends StatelessWidget {
  final Color color;
  final String tag;
  final String title;
  final String body;
  const _UseCaseCard({
    required this.color,
    required this.tag,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kBorder, width: 1.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 8.0),
            Text(
              body,
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInkSoft,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pitfalls
// ---------------------------------------------------------------------------
class _Pitfalls extends StatelessWidget {
  const _Pitfalls();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFF4CE), Color(0xFFFFE8A8)],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border:
            Border.all(color: const Color(0xFFFFB900), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Pitfalls & gotchas',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF6B4E00),
            ),
          ),
          SizedBox(height: 10.0),
          _Pitfall(
            n: '1',
            text:
                'Extended scan codes (0xE0xx) make naive scanCode comparisons miss arrow keys when the user is on a keyboard that emits the prefix.',
          ),
          _Pitfall(
            n: '2',
            text:
                'AltGr on European keyboards is reported as Ctrl+Alt — `isControlPressed && isAltPressed` will misfire for users typing @ or €.',
          ),
          _Pitfall(
            n: '3',
            text:
                'Dead keys (^, ¨, ~) emit two events: the dead-key with characterCodePoint = 0, followed by the composed character on the next press.',
          ),
          _Pitfall(
            n: '4',
            text:
                'keyCode is layout-dependent — Z and Y are swapped between QWERTY and QWERTZ. Match on scanCode for position-anchored shortcuts.',
          ),
          _Pitfall(
            n: '5',
            text:
                'Auto-repeat fires WM_KEYDOWN repeatedly without an intervening WM_KEYUP — check lParam bit 30 (previous state) before debouncing.',
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  final String n;
  final String text;
  const _Pitfall({required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22.0,
            height: 22.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFFFB900),
              shape: BoxShape.circle,
            ),
            child: Text(
              n,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF4A3700),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Color(0xFF2D2D30), Color(0xFF1B1B1F)],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: <Widget>[
        const _WindowsFlag(size: 22.0),
        const SizedBox(width: 10.0),
        const Expanded(
          child: Text(
            'RawKeyEventDataWindows · visual deep demo · Flutter services.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFB8D4EC),
              letterSpacing: 0.4,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0078D4),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: const Text(
            'v1.0 · 2026',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
              letterSpacing: 0.4,
            ),
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Touch flutter/services symbols to justify the import even though the
  // actual deprecated RawKeyEventDataWindows is not directly instantiated.
  const LogicalKeyboardKey _touch = LogicalKeyboardKey.keyS;
  const PhysicalKeyboardKey _touch2 = PhysicalKeyboardKey(0x70016);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFEBF1F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 60.0),
          child: Column(children: const <Widget>[
            _Hero(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '02',
              title: 'Subclass hierarchy',
              subtitle:
                  'Where RawKeyEventDataWindows sits in the RawKeyEventData family',
            ),
            SizedBox(height: 10.0),
            _Hierarchy(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '03',
              title: 'Field anatomy',
              subtitle:
                  'The four Win32-specific properties exposed by the subclass',
            ),
            SizedBox(height: 10.0),
            _FieldAnatomy(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '04',
              title: 'Virtual-key code table',
              subtitle: 'Twenty common VK_* constants from WinUser.h',
            ),
            SizedBox(height: 10.0),
            _VkTable(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '05',
              title: 'Modifier bitmask',
              subtitle: 'Bit layout of the `modifiers` int field',
            ),
            SizedBox(height: 10.0),
            _Modifiers(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '06',
              title: 'scanCode vs keyCode',
              subtitle:
                  'Hardware position versus logical, layout-dependent key',
            ),
            SizedBox(height: 10.0),
            _ScanVsKey(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '07',
              title: 'Extended-key 0xE0 flag',
              subtitle:
                  'Disambiguating numpad arrows from real arrows and L/R modifiers',
            ),
            SizedBox(height: 10.0),
            _ExtendedKey(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '08',
              title: 'Keyboard layout diagram',
              subtitle: '104-key US layout with annotated VK codes',
            ),
            SizedBox(height: 10.0),
            _KeyboardDiagram(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '09',
              title: 'Code example',
              subtitle: 'Listening for Ctrl+S with the deprecated raw API',
            ),
            SizedBox(height: 10.0),
            _CodeBlock(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '10',
              title: 'Deprecation & migration',
              subtitle:
                  'Replace RawKeyboard with HardwareKeyboard + KeyEvent',
            ),
            SizedBox(height: 10.0),
            _Deprecation(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '11',
              title: 'Use cases',
              subtitle:
                  'Where Windows-specific key data still matters today',
            ),
            SizedBox(height: 10.0),
            _UseCases(),
            SizedBox(height: 22.0),
            _SectionHeader(
              number: '12',
              title: 'Pitfalls',
              subtitle: 'Edge cases that bite when handling Win32 keys',
            ),
            SizedBox(height: 10.0),
            _Pitfalls(),
            SizedBox(height: 22.0),
            _Footer(),
          ]),
        ),
      ),
    ),
  );
}
