// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyboardKey from services
// Deep Demo: Visual demonstration of the abstract KeyboardKey API, its two
// concrete subclasses (LogicalKeyboardKey, PhysicalKeyboardKey), how they
// participate in event routing (RawKeyEvent, KeyEvent), how they are matched
// in Shortcuts via SingleActivator, and how HardwareKeyboard exposes the
// currently pressed sets.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Palette tokens used everywhere — slate / cyan / amber, mac-keycap aesthetic.
const Color _slate900 = Color(0xFF0F172A);
const Color _slate800 = Color(0xFF1E293B);
const Color _slate700 = Color(0xFF334155);
const Color _slate600 = Color(0xFF475569);
const Color _slate500 = Color(0xFF64748B);
const Color _slate400 = Color(0xFF94A3B8);
const Color _slate300 = Color(0xFFCBD5E1);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate100 = Color(0xFFF1F5F9);
const Color _slate50 = Color(0xFFF8FAFC);
const Color _cyan700 = Color(0xFF0E7490);
const Color _cyan500 = Color(0xFF06B6D4);
const Color _cyan300 = Color(0xFF67E8F9);
const Color _cyan100 = Color(0xFFCFFAFE);
const Color _amber700 = Color(0xFFB45309);
const Color _amber500 = Color(0xFFF59E0B);
const Color _amber300 = Color(0xFFFCD34D);
const Color _amber100 = Color(0xFFFEF3C7);
const Color _rose500 = Color(0xFFF43F5E);
const Color _emerald500 = Color(0xFF10B981);

dynamic build(BuildContext context) {
  print('KeyboardKey Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate900, _slate700, _cyan700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _cyan500.withValues(alpha: 0.18),
          blurRadius: 40.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _amber500.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _amber300, width: 2.0),
              ),
              child: Icon(Icons.keyboard, size: 40.0, color: _amber300),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KeyboardKey',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'abstract base · LogicalKeyboardKey · PhysicalKeyboardKey',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: _cyan300,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Text(
            'package:flutter/services.dart  ·  abstract class KeyboardKey with Diagnosticable',
            style: TextStyle(
              fontSize: 13.0,
              color: _slate200,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate50, _slate100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _slate300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _anatomyNode(
              'KeyboardKey',
              'abstract',
              'with Diagnosticable',
              _slate800,
              Icons.account_tree,
              isAbstract: true,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.subdirectory_arrow_left, color: _slate500, size: 22.0),
            SizedBox(width: 80.0),
            Icon(Icons.subdirectory_arrow_right, color: _slate500, size: 22.0),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _anatomyNode(
              'LogicalKeyboardKey',
              'concrete',
              'eq on keyId',
              _cyan700,
              Icons.translate,
            ),
            _anatomyNode(
              'PhysicalKeyboardKey',
              'concrete',
              'eq on usbHidUsage',
              _amber700,
              Icons.location_on,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _slate800,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kvLine('LogicalKeyboardKey.shift.keyId',
                  '0x${LogicalKeyboardKey.shift.keyId.toRadixString(16)}', _cyan300),
              _kvLine('PhysicalKeyboardKey.shiftLeft.usbHidUsage',
                  '0x${PhysicalKeyboardKey.shiftLeft.usbHidUsage.toRadixString(16)}', _amber300),
              _kvLine('LogicalKeyboardKey.shift.debugName',
                  '${LogicalKeyboardKey.shift.debugName}', _slate300),
              _kvLine('PhysicalKeyboardKey.shiftLeft.debugName',
                  '${PhysicalKeyboardKey.shiftLeft.debugName}', _slate300),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: LogicalKeyboardKey gallery
  // ============================================================
  print('=== Section 3: LogicalKeyboardKey gallery ===');

  final logicalKeys = <Map<String, dynamic>>[
    {'key': LogicalKeyboardKey.keyA, 'glyph': 'A', 'group': 'alpha'},
    {'key': LogicalKeyboardKey.keyZ, 'glyph': 'Z', 'group': 'alpha'},
    {'key': LogicalKeyboardKey.digit1, 'glyph': '1', 'group': 'digit'},
    {'key': LogicalKeyboardKey.digit9, 'glyph': '9', 'group': 'digit'},
    {'key': LogicalKeyboardKey.shift, 'glyph': '⇧', 'group': 'modifier'},
    {'key': LogicalKeyboardKey.control, 'glyph': '⌃', 'group': 'modifier'},
    {'key': LogicalKeyboardKey.alt, 'glyph': '⌥', 'group': 'modifier'},
    {'key': LogicalKeyboardKey.meta, 'glyph': '⌘', 'group': 'modifier'},
    {'key': LogicalKeyboardKey.enter, 'glyph': '⏎', 'group': 'special'},
    {'key': LogicalKeyboardKey.escape, 'glyph': 'esc', 'group': 'special'},
    {'key': LogicalKeyboardKey.tab, 'glyph': '⇥', 'group': 'special'},
    {'key': LogicalKeyboardKey.space, 'glyph': '␣', 'group': 'special'},
  ];

  final logicalCards = <Widget>[];
  for (final entry in logicalKeys) {
    final LogicalKeyboardKey key = entry['key'] as LogicalKeyboardKey;
    final String glyph = entry['glyph'] as String;
    final String group = entry['group'] as String;
    final Color accent = _accentForGroup(group);
    print(
        'LogicalKeyboardKey.${key.debugName} keyId=0x${key.keyId.toRadixString(16)}');
    logicalCards.add(_logicalKeycap(glyph, key, accent));
  }
  print('Created ${logicalCards.length} logical key cards');

  // ============================================================
  // SECTION 4: PhysicalKeyboardKey gallery
  // ============================================================
  print('=== Section 4: PhysicalKeyboardKey gallery ===');

  final physicalKeys = <Map<String, dynamic>>[
    {'key': PhysicalKeyboardKey.keyA, 'glyph': 'A'},
    {'key': PhysicalKeyboardKey.shiftLeft, 'glyph': '⇧L'},
    {'key': PhysicalKeyboardKey.shiftRight, 'glyph': '⇧R'},
    {'key': PhysicalKeyboardKey.controlLeft, 'glyph': '⌃L'},
    {'key': PhysicalKeyboardKey.escape, 'glyph': 'esc'},
    {'key': PhysicalKeyboardKey.enter, 'glyph': '⏎'},
    {'key': PhysicalKeyboardKey.space, 'glyph': '␣'},
    {'key': PhysicalKeyboardKey.arrowUp, 'glyph': '↑'},
  ];

  final physicalCards = <Widget>[];
  for (final entry in physicalKeys) {
    final PhysicalKeyboardKey key = entry['key'] as PhysicalKeyboardKey;
    final String glyph = entry['glyph'] as String;
    print(
        'PhysicalKeyboardKey.${key.debugName} usbHidUsage=0x${key.usbHidUsage.toRadixString(16)}');
    physicalCards.add(_physicalKeycap(glyph, key));
  }
  print('Created ${physicalCards.length} physical key cards');

  // ============================================================
  // SECTION 5: Logical vs Physical comparison
  // ============================================================
  print('=== Section 5: Logical vs Physical comparison ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_slate800, _slate700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                _tableHead('aspect', 130.0),
                _tableHead('LogicalKeyboardKey', 170.0),
                _tableHead('PhysicalKeyboardKey', 170.0),
              ],
            ),
          ),
          _comparisonRow('what it represents', 'semantic key (what user pressed)',
              'physical position (USB HID)'),
          _comparisonRow(
              'equality on', 'keyId (int)', 'usbHidUsage (int)'),
          _comparisonRow('layout sensitive', 'YES — US vs AZERTY differ',
              'NO — same on every layout'),
          _comparisonRow('typical use', 'shortcuts, text input',
              'gaming, WASD, layout-independent UI'),
          _comparisonRow('example (US)',
              "press 'A' → LogicalKeyboardKey.keyA", 'PhysicalKeyboardKey.keyA'),
          _comparisonRow('example (AZERTY)',
              "press 'A' (top-left) → LogicalKeyboardKey.keyQ",
              'still PhysicalKeyboardKey.keyA',
              isLast: true),
        ],
      ),
    ),
  );
  print('Created comparison table');

  // ============================================================
  // SECTION 6: RawKeyEvent / KeyEvent integration
  // ============================================================
  print('=== Section 6: RawKeyEvent / KeyEvent integration ===');

  final integrationBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _slate900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt, color: _amber300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'RawKeyEvent / KeyEvent',
              style: TextStyle(
                fontSize: 16.0,
                color: _amber300,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: _cyan700,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text('flutter/services',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontFamily: 'monospace')),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'Focus(\n'
          '  onKeyEvent: (FocusNode node, KeyEvent event) {\n'
          '    final LogicalKeyboardKey logical = event.logicalKey;\n'
          '    final PhysicalKeyboardKey physical = event.physicalKey;\n'
          '    if (logical == LogicalKeyboardKey.escape) {\n'
          '      Navigator.of(context).pop();\n'
          '      return KeyEventResult.handled;\n'
          '    }\n'
          '    if (physical == PhysicalKeyboardKey.shiftLeft) {\n'
          '      // layout-independent left-shift detection\n'
          '    }\n'
          '    return KeyEventResult.ignored;\n'
          '  },\n'
          '  child: child,\n'
          ');',
          _cyan300,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          'Shortcuts(\n'
          "  shortcuts: <ShortcutActivator, Intent>{\n"
          '    SingleActivator(LogicalKeyboardKey.keyS, control: true):\n'
          '        const SaveIntent(),\n'
          '    SingleActivator(LogicalKeyboardKey.escape):\n'
          '        const DismissIntent(),\n'
          '  },\n'
          '  child: Actions(actions: <Type, Action<Intent>>{...}, child: focus),\n'
          ');',
          _amber300,
        ),
      ],
    ),
  );
  print('Created integration block');

  // ============================================================
  // SECTION 7: SingleActivator showcase
  // ============================================================
  print('=== Section 7: SingleActivator showcase ===');

  final shortcutsShowcase = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_amber100, _amber300.withValues(alpha: 0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _amber500, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _amber500.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shortcut, color: _amber700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'SingleActivator showcase',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: _amber700,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _shortcutRow(
          label: 'Save document',
          keys: <_ShortcutKey>[
            _ShortcutKey('⌘', isModifier: true),
            _ShortcutKey('S'),
          ],
          logicalRefs: 'LogicalKeyboardKey.meta + LogicalKeyboardKey.keyS',
        ),
        _shortcutRow(
          label: 'Command palette',
          keys: <_ShortcutKey>[
            _ShortcutKey('⌃', isModifier: true),
            _ShortcutKey('⇧', isModifier: true),
            _ShortcutKey('P'),
          ],
          logicalRefs:
              'LogicalKeyboardKey.control + LogicalKeyboardKey.shift + LogicalKeyboardKey.keyP',
        ),
        _shortcutRow(
          label: 'Dismiss / cancel',
          keys: <_ShortcutKey>[_ShortcutKey('esc')],
          logicalRefs: 'LogicalKeyboardKey.escape',
        ),
        _shortcutRow(
          label: 'DevTools',
          keys: <_ShortcutKey>[_ShortcutKey('F12')],
          logicalRefs: 'LogicalKeyboardKey.f12',
        ),
        _shortcutRow(
          label: 'Run line',
          keys: <_ShortcutKey>[
            _ShortcutKey('⌥', isModifier: true),
            _ShortcutKey('⏎'),
          ],
          logicalRefs: 'LogicalKeyboardKey.alt + LogicalKeyboardKey.enter',
        ),
      ],
    ),
  );
  print('Created shortcuts showcase');

  // ============================================================
  // SECTION 8: Real-world mocks
  // ============================================================
  print('=== Section 8: Real-world mocks ===');

  // 8a. Virtual keyboard row (top alpha row)
  final virtualKeyboard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate800, _slate900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_alt_outlined, color: _cyan300, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'virtual keyboard — top row',
              style: TextStyle(
                fontSize: 12.0,
                color: _slate300,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _virtualCap('Q', LogicalKeyboardKey.keyQ),
            _virtualCap('W', LogicalKeyboardKey.keyW),
            _virtualCap('E', LogicalKeyboardKey.keyE),
            _virtualCap('R', LogicalKeyboardKey.keyR),
            _virtualCap('T', LogicalKeyboardKey.keyT),
            _virtualCap('Y', LogicalKeyboardKey.keyY),
            _virtualCap('U', LogicalKeyboardKey.keyU),
            _virtualCap('I', LogicalKeyboardKey.keyI),
            _virtualCap('O', LogicalKeyboardKey.keyO),
            _virtualCap('P', LogicalKeyboardKey.keyP),
          ],
        ),
      ],
    ),
  );

  // 8b. Shortcut help dialog
  final helpDialog = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slate200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.12),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.help_outline, color: _slate700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Keyboard shortcuts',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: _slate900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _helpRow('Open file', <String>['⌘', 'O'], LogicalKeyboardKey.keyO),
        _helpRow('Save', <String>['⌘', 'S'], LogicalKeyboardKey.keyS),
        _helpRow('Find', <String>['⌘', 'F'], LogicalKeyboardKey.keyF),
        _helpRow('Quit', <String>['⌘', 'Q'], LogicalKeyboardKey.keyQ),
        _helpRow('Toggle theme', <String>['⌘', '⇧', 'T'],
            LogicalKeyboardKey.keyT),
      ],
    ),
  );

  // 8c. Modifier-state HUD (4 modifiers)
  final modifierHud = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate900, _slate800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _slate900.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: _amber300, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'modifier state · HUD',
              style: TextStyle(
                fontSize: 12.0,
                color: _slate300,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _modIndicator('⇧ Shift', LogicalKeyboardKey.shift, true),
            _modIndicator('⌃ Ctrl', LogicalKeyboardKey.control, false),
            _modIndicator('⌥ Alt', LogicalKeyboardKey.alt, true),
            _modIndicator('⌘ Meta', LogicalKeyboardKey.meta, false),
          ],
        ),
      ],
    ),
  );
  print('Created real-world mocks');

  // ============================================================
  // SECTION 9: HardwareKeyboard explainer
  // ============================================================
  print('=== Section 9: HardwareKeyboard explainer ===');

  final hardwareExplainer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_cyan100, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _cyan500, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _cyan500.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: _cyan700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'HardwareKeyboard',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: _cyan700,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: _cyan700,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text('singleton',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontFamily: 'monospace')),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Every key event from the embedder flows through HardwareKeyboard.instance, '
          'which keeps two live sets — the currently held LogicalKeyboardKey set and '
          'the currently held PhysicalKeyboardKey set. Shortcuts and Focus consult '
          'these to decide whether a chord like Ctrl+Shift+P is currently active.',
          style: TextStyle(
            fontSize: 13.0,
            color: _slate800,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        _kvBlock('HardwareKeyboard.instance.logicalKeysPressed',
            'Set<LogicalKeyboardKey>', _cyan700),
        SizedBox(height: 6.0),
        _kvBlock('HardwareKeyboard.instance.physicalKeysPressed',
            'Set<PhysicalKeyboardKey>', _amber700),
        SizedBox(height: 6.0),
        _kvBlock('HardwareKeyboard.instance.isLogicalKeyPressed(key)',
            'bool — fast lookup', _slate700),
        SizedBox(height: 6.0),
        _kvBlock('HardwareKeyboard.instance.isPhysicalKeyPressed(key)',
            'bool — fast lookup', _slate700),
        SizedBox(height: 14.0),
        _codeBlock(
          'final pressed = HardwareKeyboard.instance.logicalKeysPressed;\n'
          'final shiftDown = pressed.contains(LogicalKeyboardKey.shift);\n'
          'final leftShiftPhysical = HardwareKeyboard.instance\n'
          '    .physicalKeysPressed\n'
          '    .contains(PhysicalKeyboardKey.shiftLeft);',
          _slate800,
          background: _slate100,
        ),
      ],
    ),
  );
  print('Created hardware keyboard explainer');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footgun cards ===');

  final footguns = <Widget>[
    _footgun(
      title: 'Logical key changes per layout',
      body:
          'LogicalKeyboardKey.keyA on QWERTY is the top-left letter key, but on '
          'AZERTY the same physical button reports LogicalKeyboardKey.keyQ. Use '
          'logical keys for text-style shortcuts, not for spatial controls.',
      color: _rose500,
      icon: Icons.warning_amber,
    ),
    _footgun(
      title: 'Physical key is layout-independent',
      body:
          'PhysicalKeyboardKey.keyA, PhysicalKeyboardKey.shiftLeft, and '
          'PhysicalKeyboardKey.shiftRight always refer to the same physical '
          'button regardless of locale. Prefer them for WASD-style game input.',
      color: _emerald500,
      icon: Icons.shield_outlined,
    ),
    _footgun(
      title: 'Numpad vs digit keys are distinct',
      body:
          'LogicalKeyboardKey.digit1 is NOT equal to LogicalKeyboardKey.numpad1. '
          'PhysicalKeyboardKey.digit1 is NOT equal to PhysicalKeyboardKey.numpad1. '
          'A shortcut bound to digit1 will not fire on a numeric keypad.',
      color: _amber700,
      icon: Icons.dialpad,
    ),
    _footgun(
      title: 'There is no nullable modifier — only "not pressed"',
      body:
          'KeyEvent does not expose nullable modifier flags; instead query '
          'HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.shift). '
          'Treat absence in the set as "not pressed".',
      color: _cyan700,
      icon: Icons.help_center,
    ),
    _footgun(
      title: 'AZERTY vs QWERTY caveat for chords',
      body:
          'A SingleActivator(LogicalKeyboardKey.keyZ) on AZERTY fires on the key '
          'that types Z (which is physically where W is on QWERTY). To anchor a '
          'chord to a position, key the activator off PhysicalKeyboardKey instead.',
      color: _slate700,
      icon: Icons.swap_horiz,
    ),
  ];
  print('Created ${footguns.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap card ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slate900, _cyan700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _cyan500.withValues(alpha: 0.35),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _slate900.withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _amber300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapBullet(
            'KeyboardKey is abstract; you only ever construct LogicalKeyboardKey or PhysicalKeyboardKey instances.'),
        _recapBullet(
            'LogicalKeyboardKey equality is on keyId; PhysicalKeyboardKey equality is on usbHidUsage.'),
        _recapBullet(
            'Use LogicalKeyboardKey.shift for semantic shift; PhysicalKeyboardKey.shiftLeft for "the left shift button".'),
        _recapBullet(
            'KeyEvent.logicalKey + KeyEvent.physicalKey expose both views of the same press.'),
        _recapBullet(
            'Shortcuts/SingleActivator match LogicalKeyboardKey by default; switch to PhysicalKeyboardKey for layout-independent chords.'),
        _recapBullet(
            'HardwareKeyboard.instance.logicalKeysPressed and HardwareKeyboard.instance.physicalKeysPressed are the source of truth for "what is held right now".'),
      ],
    ),
  );
  print('Created recap card');

  print('KeyboardKey Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: _slate100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          SizedBox(height: 28.0),
          _sectionHeader('1. Anatomy of KeyboardKey', Icons.account_tree),
          anatomy,
          SizedBox(height: 28.0),
          _sectionHeader(
              '2. LogicalKeyboardKey gallery (12 keys)', Icons.translate),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            alignment: WrapAlignment.start,
            children: logicalCards,
          ),
          SizedBox(height: 28.0),
          _sectionHeader(
              '3. PhysicalKeyboardKey gallery (8 keys)', Icons.location_on),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            alignment: WrapAlignment.start,
            children: physicalCards,
          ),
          SizedBox(height: 28.0),
          _sectionHeader('4. Logical vs Physical', Icons.compare_arrows),
          comparisonTable,
          SizedBox(height: 28.0),
          _sectionHeader('5. RawKeyEvent / KeyEvent integration', Icons.bolt),
          integrationBlock,
          SizedBox(height: 28.0),
          _sectionHeader('6. SingleActivator showcase', Icons.shortcut),
          shortcutsShowcase,
          SizedBox(height: 28.0),
          _sectionHeader('7. Real-world mocks', Icons.dashboard_customize),
          SizedBox(height: 12.0),
          virtualKeyboard,
          SizedBox(height: 14.0),
          helpDialog,
          SizedBox(height: 14.0),
          modifierHud,
          SizedBox(height: 28.0),
          _sectionHeader('8. HardwareKeyboard explainer', Icons.memory),
          hardwareExplainer,
          SizedBox(height: 28.0),
          _sectionHeader('9. Footguns', Icons.dangerous),
          ...footguns,
          SizedBox(height: 28.0),
          _sectionHeader('10. Recap', Icons.summarize),
          recap,
          SizedBox(height: 24.0),
          Center(
            child: Text(
              'KeyboardKey · LogicalKeyboardKey · PhysicalKeyboardKey · HardwareKeyboard',
              style: TextStyle(
                fontSize: 11.0,
                color: _slate500,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Top-level helpers
// ============================================================

Color _accentForGroup(String group) {
  if (group == 'alpha') return _cyan700;
  if (group == 'digit') return _amber700;
  if (group == 'modifier') return _rose500;
  if (group == 'special') return _slate700;
  return _slate500;
}

Widget _sectionHeader(String label, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _slate900,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _slate900.withValues(alpha: 0.18),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Icon(icon, color: _amber300, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            color: _slate900,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyNode(
  String title,
  String tag,
  String detail,
  Color color,
  IconData icon, {
  bool isAbstract = false,
}) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color,
        width: 2.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontStyle: isAbstract ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 10.0,
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          detail,
          style: TextStyle(
            fontSize: 11.0,
            color: _slate700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _kvLine(String key, String value, Color valueColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.0,
              color: _slate400,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: valueColor,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _logicalKeycap(String glyph, LogicalKeyboardKey key, Color accent) {
  final String hexId =
      '0x${key.keyId.toRadixString(16).padLeft(8, '0')}';
  return Container(
    width: 140.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, _slate100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _slate900.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Mac-style keycap
        Center(
          child: Container(
            width: 80.0,
            height: 64.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[_slate100, _slate200, _slate300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _slate400, width: 1.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _slate900.withValues(alpha: 0.25),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 3.0),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1.0,
                  offset: Offset(0.0, -1.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                glyph,
                style: TextStyle(
                  fontSize: glyph.length > 2 ? 18.0 : 28.0,
                  fontWeight: FontWeight.w700,
                  color: _slate900,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          key.debugName ?? '<unknown>',
          style: TextStyle(
            fontSize: 11.0,
            color: accent,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.0),
        Text(
          'keyId  $hexId',
          style: TextStyle(
            fontSize: 10.0,
            color: _slate500,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _physicalKeycap(String glyph, PhysicalKeyboardKey key) {
  final String hex =
      '0x${key.usbHidUsage.toRadixString(16).padLeft(8, '0')}';
  return Container(
    width: 140.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_slate800, _slate900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _amber500, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _slate900.withValues(alpha: 0.45),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: _amber500.withValues(alpha: 0.22),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: 80.0,
            height: 64.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[_slate700, _slate800, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _slate900, width: 1.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 3.0),
                ),
                BoxShadow(
                  color: _slate500.withValues(alpha: 0.4),
                  blurRadius: 1.0,
                  offset: Offset(0.0, -1.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                glyph,
                style: TextStyle(
                  fontSize: glyph.length > 2 ? 18.0 : 26.0,
                  fontWeight: FontWeight.w700,
                  color: _amber300,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          key.debugName ?? '<unknown>',
          style: TextStyle(
            fontSize: 11.0,
            color: _amber300,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.0),
        Text(
          'usbHid $hex',
          style: TextStyle(
            fontSize: 10.0,
            color: _slate300,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _tableHead(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        color: _amber300,
        fontWeight: FontWeight.w800,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _comparisonRow(String aspect, String logical, String physical,
    {bool isLast = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: isLast
          ? null
          : Border(
              bottom: BorderSide(color: _slate200, width: 1.0),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            aspect,
            style: TextStyle(
              fontSize: 12.0,
              color: _slate500,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            logical,
            style: TextStyle(
              fontSize: 12.0,
              color: _cyan700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            physical,
            style: TextStyle(
              fontSize: 12.0,
              color: _amber700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor, {Color? background}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: background ?? _slate800,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: _slate700.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        height: 1.45,
        color: textColor,
      ),
    ),
  );
}

class _ShortcutKey {
  final String label;
  final bool isModifier;
  const _ShortcutKey(this.label, {this.isModifier = false});
}

Widget _shortcutRow({
  required String label,
  required List<_ShortcutKey> keys,
  required String logicalRefs,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _amber500.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 160.0,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _amber700,
                ),
              ),
            ),
            ..._buildKeyChips(keys),
          ],
        ),
        SizedBox(height: 6.0),
        Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            logicalRefs,
            style: TextStyle(
              fontSize: 10.5,
              color: _slate600,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildKeyChips(List<_ShortcutKey> keys) {
  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < keys.length; i = i + 1) {
    if (i > 0) {
      chips.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Text('+',
            style: TextStyle(
                fontSize: 13.0,
                color: _slate500,
                fontWeight: FontWeight.w700)),
      ));
    }
    chips.add(_keycapChip(keys[i].label, isModifier: keys[i].isModifier));
  }
  return chips;
}

Widget _keycapChip(String label, {bool isModifier = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isModifier
            ? <Color>[_slate200, _slate300]
            : <Color>[Colors.white, _slate100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: _slate400, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _slate900.withValues(alpha: 0.18),
          blurRadius: 2.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        color: _slate900,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _virtualCap(String label, LogicalKeyboardKey logical) {
  // Reference logical key so the symbol is meaningfully used.
  final String name = logical.debugName ?? label;
  return Container(
    width: 44.0,
    height: 52.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_slate700, _slate800, _slate900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: _slate600, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 2.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            color: _amber300,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          name.length > 6 ? name.substring(0, 6) : name,
          style: TextStyle(
            fontSize: 7.5,
            color: _slate400,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _helpRow(String label, List<String> chips, LogicalKeyboardKey key) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _slate100, width: 1.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              color: _slate800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        for (int i = 0; i < chips.length; i = i + 1) ...<Widget>[
          if (i > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Text('+',
                  style: TextStyle(fontSize: 11.0, color: _slate400)),
            ),
          _keycapChip(chips[i],
              isModifier: chips[i] == '⌘' || chips[i] == '⇧' || chips[i] == '⌃'),
        ],
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: _cyan100,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '0x${key.keyId.toRadixString(16)}',
            style: TextStyle(
              fontSize: 9.5,
              color: _cyan700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _modIndicator(String label, LogicalKeyboardKey key, bool active) {
  final Color base = active ? _emerald500 : _slate600;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          base.withValues(alpha: active ? 0.35 : 0.18),
          base.withValues(alpha: active ? 0.15 : 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: base, width: 1.2),
      boxShadow: active
          ? <BoxShadow>[
              BoxShadow(
                color: base.withValues(alpha: 0.5),
                blurRadius: 8.0,
                offset: Offset(0.0, 0.0),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: active ? _emerald500 : _slate300,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          active ? 'HELD' : 'idle',
          style: TextStyle(
            fontSize: 9.0,
            color: active ? _emerald500 : _slate500,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          '0x${key.keyId.toRadixString(16)}',
          style: TextStyle(
            fontSize: 8.5,
            color: _slate400,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _kvBlock(String key, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.5,
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: _slate700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _footgun({
  required String title,
  required String body,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.1),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _slate800,
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

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 6.0, right: 10.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: _amber300,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _amber500.withValues(alpha: 0.5),
                blurRadius: 4.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
