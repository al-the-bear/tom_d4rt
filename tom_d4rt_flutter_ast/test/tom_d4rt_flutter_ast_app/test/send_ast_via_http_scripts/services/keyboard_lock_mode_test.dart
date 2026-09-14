// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: KeyboardLockMode from package:flutter/services.dart
// Deep Demo: Visual exploration of KeyboardLockMode (capsLock, numLock,
// scrollLock) — physical keyboard lock state, the LogicalKeyboardKey it
// pairs with, and how Flutter's HardwareKeyboard surface exposes it.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Helper: small textual descriptor of one KeyboardLockMode value. Used by
// many of the section builders below so we keep the data in one place.
// ---------------------------------------------------------------------------
class _LockSpec {
  const _LockSpec({
    required this.mode,
    required this.label,
    required this.shortLabel,
    required this.icon,
    required this.glow,
    required this.dim,
    required this.subtitle,
    required this.summary,
    required this.physicalNote,
    required this.logicalKeyName,
    required this.keyTopRow,
    required this.keyBottomRow,
    required this.exampleEffect,
  });

  final KeyboardLockMode mode;
  final String label;
  final String shortLabel;
  final IconData icon;
  final Color glow;
  final Color dim;
  final String subtitle;
  final String summary;
  final String physicalNote;
  final String logicalKeyName;
  final String keyTopRow;
  final String keyBottomRow;
  final String exampleEffect;
}

// ---------------------------------------------------------------------------
// Static catalog of every KeyboardLockMode value with descriptive metadata.
// Hand-authored — no generators, no loops — to keep prose specific.
// ---------------------------------------------------------------------------
const _capsLockSpec = _LockSpec(
  mode: KeyboardLockMode.capsLock,
  label: 'CAPS LOCK',
  shortLabel: 'Caps',
  icon: Icons.keyboard_capslock,
  glow: Color(0xFFFFC107),
  dim: Color(0xFF8A6D00),
  subtitle: 'Capital letter latch',
  summary:
      'When engaged, alpha keys produce uppercase glyphs without holding '
      'Shift. The OS reports the latched state through HardwareKeyboard '
      'so apps can mirror an indicator LED in software.',
  physicalNote:
      'Lives on the left edge of most ANSI/ISO keyboards just above the '
      'Shift row. Many modern laptops route the LED into the key cap '
      'itself instead of a dedicated indicator strip.',
  logicalKeyName: 'LogicalKeyboardKey.capsLock',
  keyTopRow: 'CAPS',
  keyBottomRow: 'LOCK',
  exampleEffect: 'a -> A, b -> B, c -> C',
);

const _numLockSpec = _LockSpec(
  mode: KeyboardLockMode.numLock,
  label: 'NUM LOCK',
  shortLabel: 'Num',
  icon: Icons.dialpad,
  glow: Color(0xFF4CAF50),
  dim: Color(0xFF1E5F23),
  subtitle: 'Numeric keypad gate',
  summary:
      'Toggles the numeric keypad between digit entry mode and the '
      'navigation aliases (Home/End/Page Up/Page Down/arrow keys) '
      'silkscreened on the lower half of each cap.',
  physicalNote:
      'Found on full-size keyboards, gaming TKLs with a side numpad, '
      'and on numeric add-on keypads. Compact (60%/65%) layouts often '
      'lack a NumLock LED entirely — software has to render it.',
  logicalKeyName: 'LogicalKeyboardKey.numLock',
  keyTopRow: 'NUM',
  keyBottomRow: 'LOCK',
  exampleEffect: '7 -> Home, 1 -> End, 8 -> Up arrow',
);

const _scrollLockSpec = _LockSpec(
  mode: KeyboardLockMode.scrollLock,
  label: 'SCROLL LOCK',
  shortLabel: 'Scroll',
  icon: Icons.swap_vert_circle_outlined,
  glow: Color(0xFFE91E63),
  dim: Color(0xFF6A0029),
  subtitle: 'Legacy scroll latch',
  summary:
      'A vestigial DOS-era latch. Modern apps mostly ignore it, but '
      'spreadsheet apps (Excel) still use it to switch arrow keys from '
      'cell-cursor movement to viewport scroll.',
  physicalNote:
      'Often shares an LED with PrintScreen and Pause. Lives on the '
      'function-row tail. Some compact boards fold it into Fn-layer '
      'combinations or omit it entirely.',
  logicalKeyName: 'LogicalKeyboardKey.scrollLock',
  keyTopRow: 'SCR',
  keyBottomRow: 'LOCK',
  exampleEffect: 'Arrow -> scroll viewport (Excel)',
);

// ---------------------------------------------------------------------------
// build() — the single entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('KeyboardLockMode Deep Demo executing');

  // Quick sanity probe — print the live values from the framework so the
  // d4rt log mirrors what we render. Helpful when comparing AST output to
  // a regular Dart run.
  print('KeyboardLockMode.values.length = ${KeyboardLockMode.values.length}');
  for (final value in KeyboardLockMode.values) {
    print(
      '  ${value.name.padRight(12)} '
      'index=${value.index} '
      'runtimeType=${value.runtimeType}',
    );
  }

  // ==========================================================================
  // SECTION 1: Hero header — the curtain raiser
  // ==========================================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0D1B2A),
          Color(0xFF1B263B),
          Color(0xFF415A77),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0x331FB6FF),
          blurRadius: 36.0,
          offset: Offset(0.0, 0.0),
          spreadRadius: 2.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF1FB6FF), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x551FB6FF),
                    blurRadius: 14.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.keyboard_alt_outlined,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'KeyboardLockMode',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF9BB7D4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        const Text(
          'Three latching states reported by the operating system: '
          'CapsLock, NumLock, ScrollLock. They are distinct from regular '
          'key presses — pressing the key flips a sticky bit, and the OS '
          'echoes that bit back to apps through HardwareKeyboard.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFD8E2F0),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _heroPill('${KeyboardLockMode.values.length} values', 0xFF1FB6FF),
            const SizedBox(width: 8.0),
            _heroPill('enum-style instances', 0xFF8B5CF6),
            const SizedBox(width: 8.0),
            _heroPill('logicalKey getter', 0xFFEC4899),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: Anatomy diagram — KeyboardLockMode <-> LogicalKeyboardKey
  // ==========================================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomy = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFF1F5F9), Color(0xFFDBEAFE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFF93C5FD), width: 1.5),
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
          'How the pieces fit together',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'A KeyboardLockMode value is paired with a LogicalKeyboardKey. '
          'The lock mode represents the latched state, the logical key '
          'represents the physical key that toggles it.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF1E3A8A),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _anatomyNode(
              title: 'KeyboardLockMode',
              subtitle: 'enum-like\nstate latch',
              accent: const Color(0xFF8B5CF6),
              icon: Icons.toggle_on_outlined,
            ),
            const _AnatomyArrow(label: 'logicalKey'),
            _anatomyNode(
              title: 'LogicalKeyboardKey',
              subtitle: 'symbolic\nkey identity',
              accent: const Color(0xFFEC4899),
              icon: Icons.vpn_key_outlined,
            ),
            const _AnatomyArrow(label: 'physical'),
            _anatomyNode(
              title: 'Hardware key',
              subtitle: 'a real cap\non the board',
              accent: const Color(0xFF0EA5E9),
              icon: Icons.keyboard,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: const Text(
            'Reading direction:\n'
            '  user presses CapsLock cap\n'
            '  -> LogicalKeyboardKey.capsLock fires\n'
            '  -> OS toggles the latch\n'
            '  -> HardwareKeyboard.lockModesEnabled now contains'
            ' KeyboardLockMode.capsLock',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
              color: Color(0xFF334155),
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3: Per-value cards — caps / num / scroll
  // ==========================================================================
  print('=== Section 3: Per-value cards ===');

  final perValueCards = <Widget>[
    _lockSpecCard(_capsLockSpec),
    _lockSpecCard(_numLockSpec),
    _lockSpecCard(_scrollLockSpec),
  ];

  // ==========================================================================
  // SECTION 4: Mock physical keyboard layout — caps highlighted on the left,
  // numpad on the right, scroll lock on the function row.
  // ==========================================================================
  print('=== Section 4: Mock keyboard layout ===');

  final mockKeyboard = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF1F2937)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x88000000),
          blurRadius: 28.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16.0),
            const Text(
              'mock_keyboard.layout — lock keys highlighted',
              style: TextStyle(
                color: Color(0xFFE5E7EB),
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Function row
        Row(
          children: <Widget>[
            _keyCap('Esc', 36.0),
            const SizedBox(width: 12.0),
            _keyCap('F1', 32.0),
            _keyCap('F2', 32.0),
            _keyCap('F3', 32.0),
            _keyCap('F4', 32.0),
            const SizedBox(width: 8.0),
            _keyCap('F5', 32.0),
            _keyCap('F6', 32.0),
            _keyCap('F7', 32.0),
            _keyCap('F8', 32.0),
            const SizedBox(width: 8.0),
            _keyCap('F9', 32.0),
            _keyCap('F10', 32.0),
            _keyCap('F11', 32.0),
            _keyCap('F12', 32.0),
            const SizedBox(width: 12.0),
            _keyCap('PrtSc', 36.0),
            // Highlighted: scrollLock
            _highlightedKeyCap(
              top: _scrollLockSpec.keyTopRow,
              bottom: _scrollLockSpec.keyBottomRow,
              accent: _scrollLockSpec.glow,
              width: 40.0,
            ),
            _keyCap('Pause', 40.0),
          ],
        ),
        const SizedBox(height: 6.0),
        // Number row
        Row(
          children: <Widget>[
            _keyCap('`', 32.0),
            _keyCap('1', 32.0),
            _keyCap('2', 32.0),
            _keyCap('3', 32.0),
            _keyCap('4', 32.0),
            _keyCap('5', 32.0),
            _keyCap('6', 32.0),
            _keyCap('7', 32.0),
            _keyCap('8', 32.0),
            _keyCap('9', 32.0),
            _keyCap('0', 32.0),
            _keyCap('-', 32.0),
            _keyCap('=', 32.0),
            _keyCap('Bksp', 56.0),
          ],
        ),
        const SizedBox(height: 6.0),
        // Tab row
        Row(
          children: <Widget>[
            _keyCap('Tab', 48.0),
            _keyCap('Q', 32.0),
            _keyCap('W', 32.0),
            _keyCap('E', 32.0),
            _keyCap('R', 32.0),
            _keyCap('T', 32.0),
            _keyCap('Y', 32.0),
            _keyCap('U', 32.0),
            _keyCap('I', 32.0),
            _keyCap('O', 32.0),
            _keyCap('P', 32.0),
            _keyCap('[', 32.0),
            _keyCap(']', 32.0),
            _keyCap('\\', 40.0),
          ],
        ),
        const SizedBox(height: 6.0),
        // Caps row — highlighted: capsLock
        Row(
          children: <Widget>[
            _highlightedKeyCap(
              top: _capsLockSpec.keyTopRow,
              bottom: _capsLockSpec.keyBottomRow,
              accent: _capsLockSpec.glow,
              width: 56.0,
            ),
            _keyCap('A', 32.0),
            _keyCap('S', 32.0),
            _keyCap('D', 32.0),
            _keyCap('F', 32.0),
            _keyCap('G', 32.0),
            _keyCap('H', 32.0),
            _keyCap('J', 32.0),
            _keyCap('K', 32.0),
            _keyCap('L', 32.0),
            _keyCap(';', 32.0),
            _keyCap('\'', 32.0),
            _keyCap('Enter', 64.0),
          ],
        ),
        const SizedBox(height: 6.0),
        // Shift row
        Row(
          children: <Widget>[
            _keyCap('Shift', 72.0),
            _keyCap('Z', 32.0),
            _keyCap('X', 32.0),
            _keyCap('C', 32.0),
            _keyCap('V', 32.0),
            _keyCap('B', 32.0),
            _keyCap('N', 32.0),
            _keyCap('M', 32.0),
            _keyCap(',', 32.0),
            _keyCap('.', 32.0),
            _keyCap('/', 32.0),
            _keyCap('Shift', 80.0),
          ],
        ),
        const SizedBox(height: 6.0),
        // Bottom row
        Row(
          children: <Widget>[
            _keyCap('Ctrl', 44.0),
            _keyCap('Win', 36.0),
            _keyCap('Alt', 36.0),
            _keyCap('Space', 220.0),
            _keyCap('Alt', 36.0),
            _keyCap('Fn', 36.0),
            _keyCap('Ctrl', 44.0),
          ],
        ),
        const SizedBox(height: 16.0),
        // Numpad indicator strip
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1220),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFF1E293B)),
          ),
          child: Row(
            children: <Widget>[
              const Text(
                'numpad/  ',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
              _highlightedKeyCap(
                top: _numLockSpec.keyTopRow,
                bottom: _numLockSpec.keyBottomRow,
                accent: _numLockSpec.glow,
                width: 44.0,
              ),
              _keyCap('/', 32.0),
              _keyCap('*', 32.0),
              _keyCap('-', 32.0),
              const SizedBox(width: 12.0),
              _keyCap('7', 32.0),
              _keyCap('8', 32.0),
              _keyCap('9', 32.0),
              const SizedBox(width: 6.0),
              _keyCap('4', 32.0),
              _keyCap('5', 32.0),
              _keyCap('6', 32.0),
            ],
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: LED indicator panel
  // ==========================================================================
  print('=== Section 5: LED indicator panel ===');

  final ledPanel = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF111827)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: const Color(0xFF1E293B), width: 1.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'INDICATOR LEDs',
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontFamily: 'monospace',
            fontSize: 12.0,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _ledIndicator(spec: _capsLockSpec, on: true),
            _ledIndicator(spec: _numLockSpec, on: true),
            _ledIndicator(spec: _scrollLockSpec, on: false),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Glowing means HardwareKeyboard.lockModesEnabled contains the '
          'corresponding KeyboardLockMode value. Dark means the latch is '
          'released. The OS — not Flutter — owns this state.',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6: Status banner row — three different "states" of an app
  // reacting to lock mode changes.
  // ==========================================================================
  print('=== Section 6: Status banners ===');

  final banners = Column(
    children: <Widget>[
      _statusBanner(
        title: 'Caps Lock is ON',
        message:
            'Your password may be entered in uppercase. Many sign-in '
            'screens listen for KeyboardLockMode.capsLock and surface this '
            'warning to prevent failed logins.',
        accent: _capsLockSpec.glow,
        background: const Color(0xFFFFF7E6),
        icon: Icons.warning_amber_rounded,
      ),
      const SizedBox(height: 10.0),
      _statusBanner(
        title: 'Num Lock is ON',
        message:
            'Numeric keypad is sending digits, not navigation. Useful '
            'for accounting forms; confusing on a 60% layout where '
            'numpad keys are layered onto the right side of the alphas.',
        accent: _numLockSpec.glow,
        background: const Color(0xFFE8F8EE),
        icon: Icons.check_circle_outline,
      ),
      const SizedBox(height: 10.0),
      _statusBanner(
        title: 'Scroll Lock is OFF',
        message:
            'Modern apps mostly ignore Scroll Lock. Spreadsheet apps use '
            'it to swap arrow-key behavior between cell movement and '
            'viewport scrolling. Detect it via HardwareKeyboard.',
        accent: _scrollLockSpec.glow,
        background: const Color(0xFFFFE5EE),
        icon: Icons.info_outline,
      ),
    ],
  );

  // ==========================================================================
  // SECTION 7: Recipes for HardwareKeyboard.lockModesEnabled
  // ==========================================================================
  print('=== Section 7: Recipes ===');

  final recipes = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0B1220), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.terminal, color: Color(0xFF22D3EE), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Reading lock state at runtime',
              style: TextStyle(
                color: Color(0xFF22D3EE),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'final Set<KeyboardLockMode> locks =\n'
          '    HardwareKeyboard.instance.lockModesEnabled;\n'
          '\n'
          'final bool capsOn  = locks.contains(KeyboardLockMode.capsLock);\n'
          'final bool numOn   = locks.contains(KeyboardLockMode.numLock);\n'
          'final bool scrollOn = locks.contains(KeyboardLockMode.scrollLock);',
          textColor: const Color(0xFF93C5FD),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          '// Reacting to a key event:\n'
          'HardwareKeyboard.instance.addHandler((KeyEvent event) {\n'
          '  if (event.logicalKey == LogicalKeyboardKey.capsLock) {\n'
          '    setState(() {\n'
          '      _capsOn = HardwareKeyboard.instance\n'
          '        .lockModesEnabled\n'
          '        .contains(KeyboardLockMode.capsLock);\n'
          '    });\n'
          '  }\n'
          '  return false;\n'
          '});',
          textColor: const Color(0xFFA7F3D0),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          '// Iterating all values:\n'
          'for (final KeyboardLockMode m in KeyboardLockMode.values) {\n'
          '  print("\${m.name} -> \${m.logicalKey.keyLabel}");\n'
          '}',
          textColor: const Color(0xFFFBCFE8),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8: Pitfalls / things to know
  // ==========================================================================
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFF1F2), Color(0xFFFFE4E6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFFB7185), width: 1.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33FB7185),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.report_gmailerrorred,
                color: Color(0xFFB91C1C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Common pitfalls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7F1D1D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallRow(
          icon: Icons.web_asset_off,
          title: 'Web limitations',
          body:
              'On Flutter Web, browsers expose lock state through KeyboardEvent.'
              'getModifierState. Coverage is solid for CapsLock and NumLock '
              'but inconsistent for ScrollLock across engines.',
        ),
        _pitfallRow(
          icon: Icons.devices_other,
          title: 'Mobile platforms',
          body:
              'Phones rarely emit lock state. iOS/Android keyboards do not '
              'use latching modifiers in the desktop sense, so the set is '
              'usually empty even when shift-lock is engaged on a hardware '
              'attachment.',
        ),
        _pitfallRow(
          icon: Icons.sync_problem,
          title: 'Initial state can lag',
          body:
              'After app launch, the first lockModesEnabled read may not '
              'include latches that were already on. The set updates after '
              'the first key event arrives or focus enters a key listener.',
        ),
        _pitfallRow(
          icon: Icons.lock_clock,
          title: 'No write API',
          body:
              'There is no Flutter API to change the lock state from code. '
              'KeyboardLockMode is observational only — you mirror it in '
              'the UI, you do not toggle it.',
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9: ASCII footer signing off the demo.
  // ==========================================================================
  print('=== Section 9: ASCII footer ===');

  final footer = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF0F172A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '+--------------------------------------------------------+',
          style: TextStyle(
              color: Color(0xFF22D3EE),
              fontFamily: 'monospace',
              fontSize: 12.0),
        ),
        const Text(
          '|         K E Y B O A R D   L O C K   M O D E            |',
          style: TextStyle(
              color: Color(0xFFE0F2FE),
              fontFamily: 'monospace',
              fontSize: 12.0),
        ),
        const Text(
          '|  caps . . . num . . . scroll . . .  HardwareKeyboard   |',
          style: TextStyle(
              color: Color(0xFFCBD5E1),
              fontFamily: 'monospace',
              fontSize: 12.0),
        ),
        const Text(
          '+--------------------------------------------------------+',
          style: TextStyle(
              color: Color(0xFF22D3EE),
              fontFamily: 'monospace',
              fontSize: 12.0),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Build by tom_d4rt_flutter_ast — KeyboardLockMode deep demo.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11.0),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            const Icon(Icons.bolt, color: Color(0xFFFACC15), size: 14.0),
            const SizedBox(width: 6.0),
            const Text(
              'AlwaysStoppedAnimation<double>(1.0) — frozen frame, no ticker',
              style: TextStyle(color: Color(0xFFFACC15), fontSize: 11.0),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Duration.zero — emphasises that nothing animates.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11.0),
        ),
      ],
    ),
  );

  // Pre-create animation/duration objects for completeness — many real
  // implementations of "lock state mirror" widgets cross-fade between an
  // on and off variant. Here we keep them frozen so the snapshot is stable.
  const Duration zeroDuration = Duration.zero;
  const AlwaysStoppedAnimation<double> frozenOpaque =
      AlwaysStoppedAnimation<double>(1.0);
  const AlwaysStoppedAnimation<double> frozenTransparent =
      AlwaysStoppedAnimation<double>(0.0);
  print('Frozen anim duration: $zeroDuration');
  print('Frozen opaque value:  ${frozenOpaque.value}');
  print('Frozen transp value:  ${frozenTransparent.value}');

  print('KeyboardLockMode Deep Demo completed successfully');

  // ==========================================================================
  // Final layout assembly — single MaterialApp with a scrolling body.
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              const SizedBox(height: 24.0),
              _sectionTitle('1. Anatomy: lock-mode <-> logical key'),
              const SizedBox(height: 8.0),
              anatomy,
              const SizedBox(height: 24.0),
              _sectionTitle('2. The three KeyboardLockMode values'),
              const SizedBox(height: 8.0),
              perValueCards[0],
              const SizedBox(height: 12.0),
              perValueCards[1],
              const SizedBox(height: 12.0),
              perValueCards[2],
              const SizedBox(height: 24.0),
              _sectionTitle('3. Mock keyboard layout'),
              const SizedBox(height: 8.0),
              mockKeyboard,
              const SizedBox(height: 24.0),
              _sectionTitle('4. LED indicator panel'),
              const SizedBox(height: 8.0),
              ledPanel,
              const SizedBox(height: 24.0),
              _sectionTitle('5. App-side status banners'),
              const SizedBox(height: 8.0),
              banners,
              const SizedBox(height: 24.0),
              _sectionTitle('6. Recipes — reading lockModesEnabled'),
              const SizedBox(height: 8.0),
              recipes,
              const SizedBox(height: 24.0),
              _sectionTitle('7. Pitfalls and platform caveats'),
              const SizedBox(height: 8.0),
              pitfalls,
              const SizedBox(height: 24.0),
              footer,
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION TITLE HELPER — consistent typography across the demo.
// ===========================================================================
Widget _sectionTitle(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 5.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1FB6FF), Color(0xFF8B5CF6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// HERO PILL — small rounded chip beneath the hero subtitle.
// ===========================================================================
Widget _heroPill(String text, int colorValue) {
  final Color tint = Color(colorValue);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: tint.withValues(alpha: 0.6)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: tint,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ===========================================================================
// ANATOMY NODE — one of the three nodes in the "how the pieces fit" diagram.
// ===========================================================================
Widget _anatomyNode({
  required String title,
  required String subtitle,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    width: 110.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: accent, size: 28.0),
        const SizedBox(height: 6.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.0,
            height: 1.25,
            color: Color(0xFF334155),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// ANATOMY ARROW — connects two anatomy nodes with a labelled chevron.
// ===========================================================================
class _AnatomyArrow extends StatelessWidget {
  const _AnatomyArrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.arrow_right_alt,
          color: Color(0xFF64748B),
          size: 28.0,
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// LOCK SPEC CARD — one big card per KeyboardLockMode value.
// ===========================================================================
Widget _lockSpecCard(_LockSpec spec) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          spec.glow.withValues(alpha: 0.18),
          spec.glow.withValues(alpha: 0.04),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: spec.glow.withValues(alpha: 0.6), width: 1.6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: spec.glow.withValues(alpha: 0.25),
          blurRadius: 20.0,
          offset: const Offset(0.0, 8.0),
        ),
        const BoxShadow(
          color: Color(0x11000000),
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
            // Big keycap badge
            Container(
              width: 84.0,
              height: 84.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    spec.glow,
                    spec.dim,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: spec.glow.withValues(alpha: 0.6),
                    blurRadius: 14.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(spec.icon, color: Colors.white, size: 26.0),
                  const SizedBox(height: 4.0),
                  Text(
                    spec.shortLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    spec.label,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      color: spec.dim,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    spec.subtitle,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF334155),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: <Widget>[
                      _miniTag('KeyboardLockMode.${spec.mode.name}',
                          const Color(0xFF1E293B)),
                      _miniTag('index ${spec.mode.index}',
                          const Color(0xFF334155)),
                      _miniTag(spec.logicalKeyName, spec.dim),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: spec.glow.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'What it does',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: spec.dim,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                spec.summary,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.45,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Where it lives',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: spec.dim,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                spec.physicalNote,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.45,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: spec.glow.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: spec.glow.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'Effect: ${spec.exampleEffect}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: spec.dim,
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
// MINI TAG — small labelled chip used inside lock-spec cards.
// ===========================================================================
Widget _miniTag(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.5,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ===========================================================================
// KEY CAP — a single rounded block standing in for a physical key.
// ===========================================================================
Widget _keyCap(String label, double width) {
  return Container(
    width: width,
    height: 32.0,
    margin: const EdgeInsets.symmetric(horizontal: 1.5),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF374151), Color(0xFF1F2937)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: const Color(0xFF111827), width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 3.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFD1D5DB),
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

// ===========================================================================
// HIGHLIGHTED KEY CAP — used to mark caps/num/scroll lock on the mock board.
// ===========================================================================
Widget _highlightedKeyCap({
  required String top,
  required String bottom,
  required Color accent,
  required double width,
}) {
  return Container(
    width: width,
    height: 32.0,
    margin: const EdgeInsets.symmetric(horizontal: 1.5),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent,
          accent.withValues(alpha: 0.7),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.7),
          blurRadius: 10.0,
          offset: const Offset(0.0, 0.0),
          spreadRadius: 1.0,
        ),
        const BoxShadow(
          color: Color(0x88000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          top,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          bottom,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// LED INDICATOR — round glowing circle painted with a custom painter.
// ===========================================================================
Widget _ledIndicator({required _LockSpec spec, required bool on}) {
  return Column(
    children: <Widget>[
      SizedBox(
        width: 60.0,
        height: 60.0,
        child: CustomPaint(
          painter: _LedGlowPainter(
            colorOn: spec.glow,
            colorOff: spec.dim,
            on: on,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        spec.shortLabel.toUpperCase(),
        style: TextStyle(
          color: on ? spec.glow : const Color(0xFF64748B),
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          letterSpacing: 1.5,
          fontFamily: 'monospace',
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        on ? 'latched' : 'released',
        style: TextStyle(
          color: on ? spec.glow.withValues(alpha: 0.85) : const Color(0xFF475569),
          fontSize: 10.0,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

// ===========================================================================
// LED GLOW PAINTER — paints a small filled circle plus an outer halo when on.
// ===========================================================================
class _LedGlowPainter extends CustomPainter {
  _LedGlowPainter({
    required this.colorOn,
    required this.colorOff,
    required this.on,
  });

  final Color colorOn;
  final Color colorOff;
  final bool on;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = size.width * 0.28;

    if (on) {
      // Outer halo
      final Paint halo = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            colorOn.withValues(alpha: 0.55),
            colorOn.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));
      canvas.drawCircle(center, size.width / 2, halo);
    }

    // Bezel ring
    final Paint bezel = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius + 4.0, bezel);

    // Core
    final Paint core = Paint()
      ..shader = RadialGradient(
        colors: on
            ? <Color>[Colors.white, colorOn]
            : <Color>[colorOff.withValues(alpha: 0.4), const Color(0xFF111827)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, core);

    // Specular highlight
    if (on) {
      final Paint specular = Paint()
        ..color = Colors.white.withValues(alpha: 0.85);
      canvas.drawCircle(
        Offset(center.dx - radius * 0.3, center.dy - radius * 0.3),
        radius * 0.18,
        specular,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LedGlowPainter old) =>
      old.on != on || old.colorOn != colorOn || old.colorOff != colorOff;
}

// ===========================================================================
// STATUS BANNER — coloured strip used in the "App-side status banners" row.
// ===========================================================================
Widget _statusBanner({
  required String title,
  required String message,
  required Color accent,
  required Color background,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          background,
          background.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF1F2937),
                  height: 1.4,
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
// PITFALL ROW — used inside the pitfalls section.
// ===========================================================================
Widget _pitfallRow({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFB7185).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFFB7185).withValues(alpha: 0.5),
            ),
          ),
          child: Icon(icon, color: const Color(0xFFB91C1C), size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7F1D1D),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF334155),
                  height: 1.4,
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
// CODE BLOCK — monospace block for the recipes section.
// ===========================================================================
Widget _codeBlock(String code, {required Color textColor}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFF020617),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFF1E293B)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}
