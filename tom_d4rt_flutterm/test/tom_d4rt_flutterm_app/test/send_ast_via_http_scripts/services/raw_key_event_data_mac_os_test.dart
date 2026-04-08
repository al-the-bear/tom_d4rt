// ignore_for_file: avoid_print
// Deep demo: RawKeyEventDataMacOs — macOS raw keyboard event data
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Charcoal Blue / Ice Gray
// ─────────────────────────────────────────────────────────────
const Color _rmCharcoal = Color(0xFF37474F);
const Color _rmIceGray = Color(0xFFECEFF1);
const Color _rmDarkSlate = Color(0xFF263238);
const Color _rmMidGray = Color(0xFF546E7A);
const Color _rmLightSlate = Color(0xFFB0BEC5);
const Color _rmWhite = Color(0xFFFFFFFF);
const Color _rmAccentBlue = Color(0xFF1565C0);
const Color _rmAccentOrange = Color(0xFFEF6C00);
const Color _rmAccentGreen = Color(0xFF2E7D32);
const Color _rmAccentPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _rmSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _rmWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _rmLightSlate, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _rmCharcoal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _rmWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _rmLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _rmDarkSlate, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _rmBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _rmMidGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _rmChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _rmInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
              style: const TextStyle(
                  color: _rmDarkSlate, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _rmMidGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _rmDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _rmLightSlate.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  RawKeyEventDataMacOs — Deep Demo');
  print('  macOS raw keyboard event data');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _rmIceGray,
      appBarTheme: const AppBarTheme(
        backgroundColor: _rmCharcoal,
        foregroundColor: _rmWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RawKeyEventDataMacOs'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildMacOsKeyboardArchitecture(),
            _buildEventDataFields(),
            _buildKeyCodeMapping(),
            _buildModifierFlags(),
            _buildCharactersComparison(),
            _buildFunctionKeyHandling(),
            _buildDeadKeysAndIME(),
            _buildPlatformChannelIntegration(),
            _buildKeyEventMigration(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_rmDarkSlate, _rmCharcoal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x4037474F), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.keyboard, size: 52, color: _rmWhite),
        const SizedBox(height: 12),
        const Text('RawKeyEventDataMacOs',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _rmWhite, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _rmWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'NSEvent · keyCode · modifiers · characters',
            style: TextStyle(color: _rmWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rmChip('services', _rmWhite),
            _rmChip('macOS', _rmWhite),
            _rmChip('@deprecated', _rmWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is RawKeyEventDataMacOs?');
  return _rmSection('What Is RawKeyEventDataMacOs?', [
    _rmBody(
      'RawKeyEventDataMacOs is a platform-specific data class that holds '
      'raw keyboard event information from macOS\'s NSEvent system. It is '
      'the macOS implementation of RawKeyEventData, providing access to '
      'low-level keyboard details.',
    ),
    _rmDivider(),
    _rmLabel('Deprecation Notice'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmAccentOrange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _rmAccentOrange.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber, size: 20, color: _rmAccentOrange),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('This class is @deprecated',
                    style: TextStyle(
                        color: _rmAccentOrange,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _rmBody(
                  'The RawKeyEvent / RawKeyboard system is deprecated in favor '
                  'of the newer KeyEvent / HardwareKeyboard system. New code '
                  'should use KeyDownEvent, KeyUpEvent, and KeyRepeatEvent.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    _rmDivider(),
    _rmLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmIceGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHierarchyItem('RawKeyEventData', _rmMidGray, 0),
          _buildHierarchyItem('├── RawKeyEventDataAndroid', _rmLightSlate, 1),
          _buildHierarchyItem('├── RawKeyEventDataFuchsia', _rmLightSlate, 1),
          _buildHierarchyItem('├── RawKeyEventDataIos', _rmLightSlate, 1),
          _buildHierarchyItem('├── RawKeyEventDataLinux', _rmLightSlate, 1),
          _buildHierarchyItem('├── RawKeyEventDataMacOs  ★', _rmCharcoal, 1),
          _buildHierarchyItem('├── RawKeyEventDataWeb', _rmLightSlate, 1),
          _buildHierarchyItem('└── RawKeyEventDataWindows', _rmLightSlate, 1),
        ],
      ),
    ),
  ]);
}

Widget _buildHierarchyItem(String text, Color color, int indent) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 12.0, bottom: 3),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: text.contains('★') ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'monospace')),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — macOS Keyboard Architecture
// ═══════════════════════════════════════════════════════════════
Widget _buildMacOsKeyboardArchitecture() {
  print('[Section 3] macOS keyboard architecture');
  return _rmSection('macOS Keyboard Architecture', [
    _rmBody(
      'Understanding how macOS processes keyboard input helps explain '
      'why RawKeyEventDataMacOs contains the fields it does:',
    ),
    _rmDivider(),
    // Architecture pipeline
    _buildArchLayer(1, 'Hardware (IOKit HID)', 'Physical key press generates USB HID scancode',
        Icons.keyboard, _rmDarkSlate),
    _buildArchArrow(),
    _buildArchLayer(2, 'IOHIDSystem', 'macOS kernel converts HID to IOKit event',
        Icons.memory, _rmCharcoal),
    _buildArchArrow(),
    _buildArchLayer(3, 'WindowServer', 'Routes raw event to the frontmost application',
        Icons.window, _rmMidGray),
    _buildArchArrow(),
    _buildArchLayer(4, 'NSEvent', 'Cocoa framework wraps event with keyCode, characters, modifiers',
        Icons.event, _rmAccentBlue),
    _buildArchArrow(),
    _buildArchLayer(5, 'FlutterViewController', 'Flutter engine\'s macOS embedder receives NSEvent',
        Icons.extension, _rmAccentGreen),
    _buildArchArrow(),
    _buildArchLayer(6, 'Platform Channel', 'Event data serialized and sent to Dart side',
        Icons.compare_arrows, _rmAccentPurple),
    _buildArchArrow(),
    _buildArchLayer(7, 'RawKeyEventDataMacOs', 'Dart object with all macOS-specific fields',
        Icons.data_object, _rmCharcoal),
    _rmDivider(),
    _rmBody(
      'Each layer adds information. By the time it reaches Dart, '
      'the event contains both the low-level keyCode and the high-level '
      'Unicode characters produced by the macOS input system.',
    ),
  ]);
}

Widget _buildArchLayer(int num, String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _rmWhite, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w700)),
              Text(desc,
                  style: const TextStyle(color: _rmMidGray, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildArchArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 14),
    height: 12,
    width: 2,
    color: _rmLightSlate.withValues(alpha: 0.5),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — Event Data Fields
// ═══════════════════════════════════════════════════════════════
Widget _buildEventDataFields() {
  print('[Section 4] Event data fields');
  return _rmSection('Event Data Fields', [
    _rmBody(
      'RawKeyEventDataMacOs exposes the following properties from the '
      'macOS NSEvent:',
    ),
    _rmDivider(),
    _buildFieldCard('characters', 'String',
        'The Unicode string produced by this key press with current modifier '
        'state. For example, Shift+A produces "A", while A alone produces "a".',
        _rmCharcoal),
    _buildFieldCard('charactersIgnoringModifiers', 'String',
        'The Unicode string that would be produced without modifier keys. '
        'Shift+A still produces "a". Useful for keyboard shortcut detection.',
        _rmMidGray),
    _buildFieldCard('keyCode', 'int',
        'The hardware-independent virtual key code (macOS key code). Same '
        'regardless of keyboard layout. For example, 0 = "A" key position.',
        _rmAccentBlue),
    _buildFieldCard('modifiers', 'int',
        'Bitmask of NSEventModifierFlags representing currently held modifier '
        'keys (⌘ ⌥ ⇧ ⌃ fn Caps Lock).',
        _rmAccentPurple),
    _rmDivider(),
    _rmLabel('Inherited from RawKeyEventData'),
    _rmInfoRow('logicalKey', 'LogicalKeyboardKey — layout-dependent key identity'),
    _rmInfoRow('physicalKey', 'PhysicalKeyboardKey — layout-independent key identity'),
    _rmInfoRow('isModifierPressed', 'Check if a specific modifier is active'),
    _rmInfoRow('modifiersPressed', 'Set of all currently pressed modifiers'),
  ]);
}

Widget _buildFieldCard(String name, String type, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(name,
                  style: const TextStyle(
                      color: _rmWhite, fontSize: 12, fontWeight: FontWeight.w700,
                      fontFamily: 'monospace')),
            ),
            const SizedBox(width: 8),
            Text(type,
                style: TextStyle(
                    color: color.withValues(alpha: 0.6), fontSize: 11)),
          ],
        ),
        const SizedBox(height: 6),
        Text(desc,
            style: const TextStyle(color: _rmMidGray, fontSize: 11.5)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Key Code Mapping
// ═══════════════════════════════════════════════════════════════
Widget _buildKeyCodeMapping() {
  print('[Section 5] Key code mapping');
  return _rmSection('macOS Key Code Mapping', [
    _rmBody(
      'macOS virtual key codes are fixed integers assigned to physical '
      'key positions, independent of keyboard layout:',
    ),
    _rmDivider(),
    _rmLabel('Common Key Codes'),
    _buildKeyCodeTable([
      ['0x00', 'A key position', 'kVK_ANSI_A'],
      ['0x01', 'S key position', 'kVK_ANSI_S'],
      ['0x0C', 'Q key position', 'kVK_ANSI_Q'],
      ['0x0D', 'W key position', 'kVK_ANSI_W'],
      ['0x24', 'Return ↵', 'kVK_Return'],
      ['0x30', 'Tab ⇥', 'kVK_Tab'],
      ['0x31', 'Space', 'kVK_Space'],
      ['0x33', 'Delete ⌫', 'kVK_Delete'],
      ['0x35', 'Escape ⎋', 'kVK_Escape'],
    ]),
    _rmDivider(),
    _rmLabel('Arrow Keys'),
    _buildKeyCodeTable([
      ['0x7B', 'Left Arrow ←', 'kVK_LeftArrow'],
      ['0x7C', 'Right Arrow →', 'kVK_RightArrow'],
      ['0x7D', 'Down Arrow ↓', 'kVK_DownArrow'],
      ['0x7E', 'Up Arrow ↑', 'kVK_UpArrow'],
    ]),
    _rmDivider(),
    _rmLabel('Layout Independence'),
    _rmBody(
      'Key codes refer to physical positions, not characters. On a French '
      'AZERTY keyboard, key code 0x00 still refers to the physical "A" '
      'position, even though it produces "Q". The characters field provides '
      'the actual character output.',
    ),
  ]);
}

Widget _buildKeyCodeTable(List<List<String>> rows) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _rmLightSlate.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _rmCharcoal.withValues(alpha: 0.06),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
          ),
          child: const Row(
            children: [
              SizedBox(width: 50, child: Text('Code',
                  style: TextStyle(color: _rmDarkSlate, fontSize: 11, fontWeight: FontWeight.w700))),
              Expanded(child: Text('Key',
                  style: TextStyle(color: _rmDarkSlate, fontSize: 11, fontWeight: FontWeight.w700))),
              SizedBox(width: 110, child: Text('Constant',
                  style: TextStyle(color: _rmDarkSlate, fontSize: 11, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...rows.map((r) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: _rmLightSlate.withValues(alpha: 0.2))),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(r[0],
                        style: const TextStyle(
                            color: _rmAccentBlue, fontSize: 11,
                            fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                  ),
                  Expanded(child: Text(r[1],
                      style: const TextStyle(color: _rmMidGray, fontSize: 11))),
                  SizedBox(
                    width: 110,
                    child: Text(r[2],
                        style: const TextStyle(
                            color: _rmCharcoal, fontSize: 10,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Modifier Flags
// ═══════════════════════════════════════════════════════════════
Widget _buildModifierFlags() {
  print('[Section 6] Modifier flags');
  return _rmSection('NSEventModifierFlags', [
    _rmBody(
      'The modifiers field is a bitmask from NSEventModifierFlags. Each '
      'modifier key has a specific bit:',
    ),
    _rmDivider(),
    _buildModifierRow('⇧ Shift', '0x20002', 'NSEventModifierFlagShift', _rmCharcoal),
    _buildModifierRow('⌃ Control', '0x40001', 'NSEventModifierFlagControl', _rmMidGray),
    _buildModifierRow('⌥ Option/Alt', '0x80020', 'NSEventModifierFlagOption', _rmAccentBlue),
    _buildModifierRow('⌘ Command', '0x100008', 'NSEventModifierFlagCommand', _rmAccentPurple),
    _buildModifierRow('fn Function', '0x800000', 'NSEventModifierFlagFunction', _rmAccentOrange),
    _buildModifierRow('⇪ Caps Lock', '0x10000', 'NSEventModifierFlagCapsLock', _rmAccentGreen),
    _rmDivider(),
    _rmLabel('Modifier Combinations'),
    _rmBody(
      'Modifiers are combined using bitwise OR. For example, ⌘+⇧ produces '
      'a modifiers value of 0x120000A. Flutter\'s isModifierPressed() '
      'method handles the bitmask checking.',
    ),
    _rmDivider(),
    _rmLabel('Visual Modifier Key Layout'),
    _buildKeyboardModifiers(),
  ]);
}

Widget _buildModifierRow(String key, String hex, String constant, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(key,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _rmWhite, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
          child: Text(hex,
              style: TextStyle(
                  color: color, fontSize: 11,
                  fontFamily: 'monospace', fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(constant,
              style: const TextStyle(
                  color: _rmMidGray, fontSize: 10, fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

Widget _buildKeyboardModifiers() {
  Widget key(String label, double width, Color color, bool isModifier) {
    return Container(
      width: width,
      height: 28,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: isModifier ? color.withValues(alpha: 0.15) : _rmIceGray,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isModifier ? color : _rmLightSlate,
          width: isModifier ? 1.5 : 0.5,
        ),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                color: isModifier ? color : _rmMidGray,
                fontSize: 8,
                fontWeight: isModifier ? FontWeight.w700 : FontWeight.w500)),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _rmDarkSlate.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        // Bottom row of modifier keys
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            key('fn', 30, _rmAccentOrange, true),
            key('⌃', 30, _rmMidGray, true),
            key('⌥', 34, _rmAccentBlue, true),
            key('⌘', 42, _rmAccentPurple, true),
            key('Space', 80, _rmLightSlate, false),
            key('⌘', 42, _rmAccentPurple, true),
            key('⌥', 34, _rmAccentBlue, true),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            key('⇪ CapsLock', 50, _rmAccentGreen, true),
            const SizedBox(width: 40),
            key('⇧ Shift', 50, _rmCharcoal, true),
            const SizedBox(width: 40),
            key('⇧ Shift', 50, _rmCharcoal, true),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — Characters vs CharactersIgnoringModifiers
// ═══════════════════════════════════════════════════════════════
Widget _buildCharactersComparison() {
  print('[Section 7] characters vs charactersIgnoringModifiers');
  return _rmSection('Characters vs CharactersIgnoringModifiers', [
    _rmBody(
      'These two fields serve different purposes and can produce very '
      'different results for the same key press:',
    ),
    _rmDivider(),
    _buildCharExample('A key (no modifiers)', 'a', 'a',
        'Both produce lowercase "a"'),
    _buildCharExample('Shift + A', 'A', 'a',
        'characters is uppercase; ignoring shows base'),
    _buildCharExample('Option + E', '´', 'e',
        'characters is dead key accent; ignoring shows base "e"'),
    _buildCharExample('Option + Shift + 2', '€', '2',
        'characters is euro sign; ignoring shows base "2"'),
    _buildCharExample('Command + C', 'c', 'c',
        'Both show "c" — Command doesn\'t alter character output'),
    _buildCharExample('Function + Delete', '⌦', '',
        'characters is forward-delete; ignoring is empty'),
    _rmDivider(),
    _rmLabel('When to Use Which'),
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _rmCharcoal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text('characters',
                    style: TextStyle(
                        color: _rmCharcoal, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                _rmBody('Use for text input'),
                _rmBody('Respects all modifiers'),
                _rmBody('Layout-dependent output'),
                _rmBody('Can be empty for some keys'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _rmAccentBlue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text('...IgnoringModifiers',
                    style: TextStyle(
                        color: _rmAccentBlue, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                _rmBody('Use for keyboard shortcuts'),
                _rmBody('Ignores Shift, Option'),
                _rmBody('Shows unmodified character'),
                _rmBody('More stable across layouts'),
              ],
            ),
          ),
        ),
      ],
    ),
  ]);
}

Widget _buildCharExample(
    String input, String chars, String ignoringChars, String note) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _rmIceGray,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(input,
              style: const TextStyle(
                  color: _rmDarkSlate, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          width: 36,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: _rmCharcoal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text('"$chars"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _rmCharcoal, fontSize: 10, fontFamily: 'monospace')),
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: 36,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: _rmAccentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text('"$ignoringChars"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: _rmAccentBlue, fontSize: 10, fontFamily: 'monospace')),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(note,
              style: const TextStyle(color: _rmMidGray, fontSize: 10)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Function Key Handling
// ═══════════════════════════════════════════════════════════════
Widget _buildFunctionKeyHandling() {
  print('[Section 8] Function key handling');
  return _rmSection('Function Key Handling', [
    _rmBody(
      'macOS function keys (F1-F12) have dual roles controlled by the fn '
      'modifier. This affects how RawKeyEventDataMacOs reports them:',
    ),
    _rmDivider(),
    _rmLabel('Function Keys (F1-F12)'),
    _buildFnKeyGrid(),
    _rmDivider(),
    _rmLabel('fn Key Behavior'),
    _rmBody(
      'By default (System Preferences setting), the top row keys activate '
      'special actions (brightness, volume, etc.). Holding fn produces the '
      'actual F1-F12 key codes. This can be inverted in settings.',
    ),
    _rmDivider(),
    _rmInfoRow('Without fn', 'Special action key codes (e.g., brightness up)'),
    _rmInfoRow('With fn held', 'F1-F12 key codes (0x7A-0x6B)'),
    _rmInfoRow('fn flag in modifiers', 'NSEventModifierFlagFunction bit is set'),
    _rmInfoRow('Special keys', 'Some keys always need fn (Home, End, PageUp/Down)'),
  ]);
}

Widget _buildFnKeyGrid() {
  final fnKeys = [
    ['F1', '0x7A'], ['F2', '0x78'], ['F3', '0x63'], ['F4', '0x76'],
    ['F5', '0x60'], ['F6', '0x61'], ['F7', '0x62'], ['F8', '0x64'],
    ['F9', '0x65'], ['F10', '0x6D'], ['F11', '0x67'], ['F12', '0x6F'],
  ];

  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: fnKeys.map((k) {
      return Container(
        width: 64,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: _rmCharcoal.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _rmLightSlate.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(k[0],
                style: const TextStyle(
                    color: _rmDarkSlate, fontSize: 12, fontWeight: FontWeight.w700)),
            Text(k[1],
                style: const TextStyle(
                    color: _rmAccentBlue, fontSize: 9, fontFamily: 'monospace')),
          ],
        ),
      );
    }).toList(),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Dead Keys and IME
// ═══════════════════════════════════════════════════════════════
Widget _buildDeadKeysAndIME() {
  print('[Section 9] Dead keys and IME');
  return _rmSection('Dead Keys & Input Methods', [
    _rmBody(
      'macOS\'s input system handles dead keys and input method editors (IME) '
      'which add complexity to keyboard event handling:',
    ),
    _rmDivider(),
    _rmLabel('Dead Keys'),
    _rmBody(
      'A dead key is a key press that doesn\'t produce a character immediately '
      'but modifies the next key press. Common with accented characters:',
    ),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmIceGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDeadKeySequence('Option+E', '´ (dead accent)', 'A', 'Á'),
          _rmDivider(),
          _buildDeadKeySequence('Option+U', '¨ (dead umlaut)', 'O', 'Ö'),
          _rmDivider(),
          _buildDeadKeySequence('Option+I', 'ˆ (dead circumflex)', 'E', 'Ê'),
          _rmDivider(),
          _buildDeadKeySequence('Option+N', '˜ (dead tilde)', 'N', 'Ñ'),
          _rmDivider(),
          _buildDeadKeySequence('Option+`', '` (dead grave)', 'A', 'À'),
        ],
      ),
    ),
    _rmDivider(),
    _rmLabel('Input Method Editors (IME)'),
    _rmBody(
      'For CJK (Chinese, Japanese, Korean) input, macOS uses IME that '
      'compose multiple keystrokes into single characters. During '
      'composition, the characters field may contain partial or candidate '
      'text that hasn\'t been committed yet.',
    ),
    _rmDivider(),
    // IME stages
    _buildIMEStage('Composing', 'User types phonetic keys', _rmAccentBlue),
    _buildIMEStage('Candidates', 'System shows possible characters', _rmAccentPurple),
    _buildIMEStage('Committed', 'User selects final character', _rmAccentGreen),
    _rmDivider(),
    _rmBody(
      'RawKeyEventDataMacOs reports all intermediate events during IME '
      'composition, which can make handling tricky. The newer KeyEvent '
      'API handles this more cleanly.',
    ),
  ]);
}

Widget _buildDeadKeySequence(
    String firstKey, String intermediate, String secondKey, String result) {
  return Row(
    children: [
      _buildSmallKey(firstKey, _rmAccentOrange),
      const SizedBox(width: 4),
      const Icon(Icons.arrow_forward, size: 12, color: _rmLightSlate),
      const SizedBox(width: 4),
      Text(intermediate,
          style: const TextStyle(color: _rmMidGray, fontSize: 11)),
      const SizedBox(width: 4),
      const Icon(Icons.add, size: 12, color: _rmLightSlate),
      const SizedBox(width: 4),
      _buildSmallKey(secondKey, _rmCharcoal),
      const SizedBox(width: 4),
      const Icon(Icons.arrow_forward, size: 12, color: _rmLightSlate),
      const SizedBox(width: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _rmAccentGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _rmAccentGreen),
        ),
        child: Text(result,
            style: const TextStyle(
                color: _rmAccentGreen, fontSize: 14, fontWeight: FontWeight.w700)),
      ),
    ],
  );
}

Widget _buildSmallKey(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: color),
    ),
    child: Text(label,
        style: TextStyle(
            color: color, fontSize: 10, fontWeight: FontWeight.w600)),
  );
}

Widget _buildIMEStage(String name, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(name,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: const TextStyle(color: _rmMidGray, fontSize: 11)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Platform Channel Integration
// ═══════════════════════════════════════════════════════════════
Widget _buildPlatformChannelIntegration() {
  print('[Section 10] Platform channel integration');
  return _rmSection('Platform Channel Integration', [
    _rmBody(
      'Key events travel from macOS through the Flutter engine\'s platform '
      'channel as serialized maps:',
    ),
    _rmDivider(),
    _rmLabel('Serialized Event Map'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmDarkSlate.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMapEntry('keymap', '"macos"', _rmAccentPurple),
          _buildMapEntry('type', '"keydown" | "keyup"', _rmAccentBlue),
          _buildMapEntry('keyCode', '0 (int, A key position)', _rmCharcoal),
          _buildMapEntry('characters', '"a" (with modifiers)', _rmMidGray),
          _buildMapEntry('charactersIgnoringModifiers', '"a" (base)', _rmMidGray),
          _buildMapEntry('modifiers', '0x100108 (bitmask)', _rmAccentOrange),
          _buildMapEntry('specifiedLogicalKey', 'optional override', _rmLightSlate),
        ],
      ),
    ),
    _rmDivider(),
    _rmLabel('Processing Pipeline'),
    _rmInfoRow('1. FlutterVC', 'Receives NSEvent via keyDown/keyUp override'),
    _rmInfoRow('2. Serialize', 'Converts NSEvent fields to Map<String, dynamic>'),
    _rmInfoRow('3. Channel', 'Sends via flutter/keyevent system channel'),
    _rmInfoRow('4. Engine', 'Dart side receives and decodes the map'),
    _rmInfoRow('5. Construct', 'Creates RawKeyEventDataMacOs from map'),
    _rmInfoRow('6. Dispatch', 'Dispatched through RawKeyboard listeners'),
    _rmDivider(),
    _rmLabel('Key Map Identification'),
    _rmBody(
      'The keymap: "macos" field tells Flutter which RawKeyEventData subclass '
      'to instantiate. Each platform has its own keymap identifier: '
      '"android", "ios", "linux", "macos", "fuchsia", "windows", "web".',
    ),
  ]);
}

Widget _buildMapEntry(String key, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text('"$key": ',
            style: const TextStyle(
                color: _rmDarkSlate, fontSize: 11,
                fontFamily: 'monospace', fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: color, fontSize: 11, fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — KeyEvent Migration
// ═══════════════════════════════════════════════════════════════
Widget _buildKeyEventMigration() {
  print('[Section 11] KeyEvent migration');
  return _rmSection('Migration: RawKeyEvent → KeyEvent', [
    _rmBody(
      'The recommended migration path from the deprecated RawKeyEvent system '
      'to the new KeyEvent system:',
    ),
    _rmDivider(),
    // Comparison table
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _rmAccentOrange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _rmAccentOrange.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber, size: 14, color: _rmAccentOrange),
                    const SizedBox(width: 4),
                    const Text('Old (Deprecated)',
                        style: TextStyle(
                            color: _rmAccentOrange, fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 8),
                _rmBody('RawKeyboard'),
                _rmBody('RawKeyEvent'),
                _rmBody('RawKeyDownEvent'),
                _rmBody('RawKeyUpEvent'),
                _rmBody('RawKeyEventDataMacOs'),
                _rmBody('RawKeyboard.instance'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _rmAccentGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _rmAccentGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle, size: 14, color: _rmAccentGreen),
                    const SizedBox(width: 4),
                    const Text('New (Recommended)',
                        style: TextStyle(
                            color: _rmAccentGreen, fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 8),
                _rmBody('HardwareKeyboard'),
                _rmBody('KeyEvent'),
                _rmBody('KeyDownEvent'),
                _rmBody('KeyUpEvent / KeyRepeatEvent'),
                _rmBody('(platform-agnostic)'),
                _rmBody('HardwareKeyboard.instance'),
              ],
            ),
          ),
        ),
      ],
    ),
    _rmDivider(),
    _rmLabel('Key Differences'),
    _rmInfoRow('Platform data', 'Old: platform-specific subclasses\nNew: unified API'),
    _rmInfoRow('Repeat events', 'Old: RawKeyDownEvent with isRepeat\nNew: dedicated KeyRepeatEvent'),
    _rmInfoRow('Synchronization', 'Old: can desync on focus loss\nNew: auto-syncs modifier state'),
    _rmInfoRow('IME handling', 'Old: receives raw composition events\nNew: cleaner IME integration'),
    _rmDivider(),
    _rmLabel('Migration Steps'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmIceGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMigrationStep(1, 'Replace RawKeyboard.instance.addListener with '
              'HardwareKeyboard.instance.addHandler', _rmCharcoal),
          _buildMigrationStep(2, 'Replace RawKeyboardListener widget with '
              'KeyboardListener widget', _rmCharcoal),
          _buildMigrationStep(3, 'Replace platform-specific data access '
              '(event.data as RawKeyEventDataMacOs) with '
              'event.logicalKey / event.physicalKey', _rmCharcoal),
          _buildMigrationStep(4, 'Update modifier checking from '
              'isModifierPressed to HardwareKeyboard.instance.isLogicalKeyPressed',
              _rmCharcoal),
          _buildMigrationStep(5, 'Test on all platforms to verify behavior parity',
              _rmCharcoal),
        ],
      ),
    ),
  ]);
}

Widget _buildMigrationStep(int num, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: _rmWhite, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: const TextStyle(color: _rmMidGray, fontSize: 11.5)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('RawKeyEventDataMacOs deep demo complete.');
  return _rmSection('Summary', [
    _rmBody(
      'RawKeyEventDataMacOs is the macOS-specific carrier for raw keyboard '
      'event data. It wraps NSEvent fields — keyCode, characters, '
      'charactersIgnoringModifiers, and modifier flags — exposing them '
      'to the Dart layer.',
    ),
    _rmDivider(),
    _rmLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rmCharcoal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rmBody('✦ macOS implementation of RawKeyEventData (deprecated)'),
          _rmBody('✦ Fields: keyCode, characters, charactersIgnoringModifiers, modifiers'),
          _rmBody('✦ keyCode is layout-independent (physical position)'),
          _rmBody('✦ characters respects modifiers; ...IgnoringModifiers does not'),
          _rmBody('✦ Modifier bitmask from NSEventModifierFlags (⌘ ⌥ ⇧ ⌃ fn CapsLock)'),
          _rmBody('✦ Handles dead keys and IME composition events'),
          _rmBody('✦ Travels via flutter/keyevent platform channel'),
          _rmBody('✦ Migrate to KeyEvent / HardwareKeyboard API'),
        ],
      ),
    ),
    _rmDivider(),
    Wrap(
      children: [
        _rmChip('RawKeyEventDataMacOs', _rmCharcoal),
        _rmChip('NSEvent', _rmAccentBlue),
        _rmChip('@deprecated', _rmAccentOrange),
        _rmChip('KeyEvent', _rmAccentGreen),
        _rmChip('Modifiers', _rmAccentPurple),
      ],
    ),
  ]);
}
