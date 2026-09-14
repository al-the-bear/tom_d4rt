// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MenuSerializableShortcut mixin from widgets/services
// Deep Demo: Visual demonstration of menu-serializable keyboard shortcuts
// covering SingleActivator, CharacterActivator, LogicalKeySet, modifier
// glyphs, macOS-style menu bar mock, and ShortcutSerialization anatomy.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('MenuSerializableShortcut Deep Demo executing');

  // ============================================================
  // PALETTE — steel-grey / ember / mac-blue
  // ============================================================
  final steel = Color(0xFF455A64);
  final steelLight = Color(0xFF78909C);
  final steelDark = Color(0xFF263238);
  final ember = Color(0xFFE65100);
  final emberLight = Color(0xFFFF8A50);
  final macBlue = Color(0xFF0A84FF);
  final macBlueDark = Color(0xFF0050B3);
  final paper = Color(0xFFF5F5F7);
  final ink = Color(0xFF1D1D1F);

  // ============================================================
  // SECTION 1 — Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [steelDark, steel, macBlueDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: steelDark.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: macBlue.withValues(alpha: 0.25),
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
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.keyboard_command_key,
                size: 56.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MenuSerializableShortcut',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'mixin · package:flutter/widgets.dart',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.85),
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
            color: Colors.black.withValues(alpha: 0.32),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 18.0, color: emberLight),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Mixin applied to ShortcutActivator subclasses so they can be '
                  'serialized into the PlatformMenuBar (e.g. macOS menu bar). '
                  'Single API: ShortcutSerialization serializeForMenu().',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _chip('SingleActivator', macBlue),
            _chip('CharacterActivator', ember),
            _chip('LogicalKeySet (deprecated)', steelLight),
            _chip('ShortcutSerialization', Colors.white24),
          ],
        ),
      ],
    ),
  );
  print('Title banner built');

  // ============================================================
  // SECTION 2 — Anatomy of ShortcutSerialization
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: steelLight.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: steel.withValues(alpha: 0.18),
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
            Icon(Icons.account_tree, size: 22.0, color: steelDark),
            SizedBox(width: 8.0),
            Text(
              'Anatomy — ShortcutSerialization',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: steelDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'serializeForMenu() returns a ShortcutSerialization carrying:',
          style: TextStyle(fontSize: 13.0, color: steel),
        ),
        SizedBox(height: 14.0),
        _anatomyRow(
          'trigger',
          'LogicalKeyboardKey?',
          'Primary key (e.g. keyS, enter, f4)',
          Icons.keyboard,
          macBlue,
        ),
        _anatomyRow(
          'character',
          'String?',
          'Single character (CharacterActivator only)',
          Icons.text_fields,
          ember,
        ),
        _anatomyRow(
          'alt',
          'bool',
          'Option/Alt modifier — glyph ⌥',
          Icons.keyboard_alt,
          steel,
        ),
        _anatomyRow(
          'control',
          'bool',
          'Control modifier — glyph ⌃',
          Icons.keyboard_control_key,
          steel,
        ),
        _anatomyRow(
          'meta',
          'bool',
          'Command/Win modifier — glyph ⌘',
          Icons.keyboard_command_key,
          macBlue,
        ),
        _anatomyRow(
          'shift',
          'bool',
          'Shift modifier — glyph ⇧',
          Icons.arrow_upward,
          steel,
        ),
      ],
    ),
  );
  print('Anatomy card built');

  // ============================================================
  // SECTION 3 — Implementing Classes Gallery
  // ============================================================
  print('=== Section 3: Implementing Classes Gallery ===');

  final implementingGallery = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [steelDark, steel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: steelDark.withValues(alpha: 0.4),
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
            Icon(Icons.layers, color: emberLight, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Implementing Classes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            _classCard(
              'SingleActivator',
              'Modifier-based key combo',
              'Cmd+S, Ctrl+Shift+P',
              Icons.keyboard,
              macBlue,
              false,
            ),
            _classCard(
              'CharacterActivator',
              'Triggered by character',
              '"?" "/" "@"',
              Icons.text_fields,
              ember,
              false,
            ),
            _classCard(
              'LogicalKeySet',
              'Set of keys (any order)',
              'meta+shift+s',
              Icons.warning_amber,
              steelLight,
              true,
            ),
          ],
        ),
      ],
    ),
  );
  print('Implementing gallery built');

  // ============================================================
  // SECTION 4 — Real SingleActivator cards
  // ============================================================
  print('=== Section 4: SingleActivator cards ===');

  final saSave = SingleActivator(LogicalKeyboardKey.keyS, meta: true);
  final saPalette = SingleActivator(
    LogicalKeyboardKey.keyP,
    control: true,
    shift: true,
  );
  final saQuit = SingleActivator(LogicalKeyboardKey.f4, alt: true);
  final saAll = SingleActivator(LogicalKeyboardKey.keyA, meta: true);
  final saFind = SingleActivator(LogicalKeyboardKey.keyF, control: true);
  final saUndo = SingleActivator(
    LogicalKeyboardKey.keyZ,
    meta: true,
    shift: true,
  );

  print('saSave trigger=${saSave.trigger} meta=${saSave.meta}');
  print(
    'saPalette trigger=${saPalette.trigger} control=${saPalette.control} '
    'shift=${saPalette.shift}',
  );
  print('saQuit trigger=${saQuit.trigger} alt=${saQuit.alt}');
  print('saAll trigger=${saAll.trigger} meta=${saAll.meta}');
  print('saFind trigger=${saFind.trigger} control=${saFind.control}');
  print(
    'saUndo trigger=${saUndo.trigger} meta=${saUndo.meta} '
    'shift=${saUndo.shift}',
  );

  final singleActivatorCards = <Widget>[
    _activatorCard(
      'Save',
      saSave,
      '\u2318S',
      'File · Save document',
      Icons.save,
      macBlue,
    ),
    _activatorCard(
      'Command Palette',
      saPalette,
      '\u2303\u21E7P',
      'View · Show palette',
      Icons.menu_open,
      ember,
    ),
    _activatorCard(
      'Close Window',
      saQuit,
      '\u2325F4',
      'Window · Close',
      Icons.close,
      Colors.redAccent,
    ),
    _activatorCard(
      'Select All',
      saAll,
      '\u2318A',
      'Edit · Select all',
      Icons.select_all,
      macBlue,
    ),
    _activatorCard(
      'Find',
      saFind,
      '\u2303F',
      'Edit · Find in file',
      Icons.search,
      steel,
    ),
    _activatorCard(
      'Redo',
      saUndo,
      '\u2318\u21E7Z',
      'Edit · Redo action',
      Icons.redo,
      Colors.deepPurple,
    ),
  ];
  print('Built ${singleActivatorCards.length} SingleActivator cards');

  // ============================================================
  // SECTION 5 — CharacterActivator showcase
  // ============================================================
  print('=== Section 5: CharacterActivator ===');

  final charHelp = CharacterActivator('?');
  final charSearch = CharacterActivator('/');
  final charMention = CharacterActivator('@');
  final charHash = CharacterActivator('#');

  print('charHelp character=${charHelp.character}');
  print('charSearch character=${charSearch.character}');
  print('charMention character=${charMention.character}');
  print('charHash character=${charHash.character}');

  final characterCards = <Widget>[
    _characterCard(
      'Help',
      charHelp,
      'Vim-style help marker',
      Icons.help_outline,
      ember,
    ),
    _characterCard(
      'Quick Search',
      charSearch,
      'Slash to focus search',
      Icons.search,
      macBlue,
    ),
    _characterCard(
      'Mention User',
      charMention,
      'Open mention picker',
      Icons.alternate_email,
      Colors.teal,
    ),
    _characterCard(
      'Channel Picker',
      charHash,
      'Open channel selector',
      Icons.tag,
      steel,
    ),
  ];
  print('Built ${characterCards.length} CharacterActivator cards');

  // ============================================================
  // SECTION 6 — Modifier visualizer
  // ============================================================
  print('=== Section 6: Modifier glyphs ===');

  final modifierVisualizer = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, Color(0xFFE8EEF3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: steelLight.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: steel.withValues(alpha: 0.18),
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
            Icon(Icons.keyboard_alt_outlined, color: steelDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Modifier Glyphs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: steelDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Modifiers are encoded as bool flags on SingleActivator and rendered '
          'with platform glyphs in the macOS menu bar.',
          style: TextStyle(fontSize: 13.0, color: steel, height: 1.45),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _modifierTile('alt', '\u2325', 'Option', macBlue),
            _modifierTile('control', '\u2303', 'Control', steel),
            _modifierTile('meta', '\u2318', 'Command', ember),
            _modifierTile('shift', '\u21E7', 'Shift', Colors.deepPurple),
          ],
        ),
      ],
    ),
  );
  print('Modifier visualizer built');

  // ============================================================
  // SECTION 7 — macOS-style Menu Bar Mock
  // ============================================================
  print('=== Section 7: Menu bar mock ===');

  final menuBarMock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: steelDark.withValues(alpha: 0.3),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8E8EA), Color(0xFFD1D1D6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border(
                bottom: BorderSide(
                  color: steelLight.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: [
                _trafficLight(Color(0xFFFF5F57)),
                SizedBox(width: 8.0),
                _trafficLight(Color(0xFFFEBC2E)),
                SizedBox(width: 8.0),
                _trafficLight(Color(0xFF28C840)),
                SizedBox(width: 18.0),
                Icon(Icons.apple, size: 16.0, color: ink),
                SizedBox(width: 18.0),
                _menuLabel('File', true),
                _menuLabel('Edit', false),
                _menuLabel('View', false),
                _menuLabel('Window', false),
                _menuLabel('Help', false),
              ],
            ),
          ),
          // Drop-down content
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _menuItem('New File', '\u2318N', Icons.note_add, ink),
                _menuItem('Open\u2026', '\u2318O', Icons.folder_open, ink),
                _menuItem('Save', '\u2318S', Icons.save, ink),
                _menuItem('Save As\u2026', '\u2318\u21E7S', Icons.save_as, ink),
                _menuDivider(),
                _menuItem('Find', '\u2303F', Icons.search, ink),
                _menuItem(
                  'Find Next',
                  '\u2318G',
                  Icons.skip_next,
                  ink,
                ),
                _menuDivider(),
                _menuItem('Quit', '\u2318Q', Icons.power_settings_new, ink),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  print('Menu bar mock built');

  // ============================================================
  // SECTION 8 — Comparison table
  // ============================================================
  print('=== Section 8: Comparison table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: ember.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: ember.withValues(alpha: 0.2),
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
            Icon(Icons.compare_arrows, color: ember, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Comparison — Mixin / Activator / KeySet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B3F00),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: ember.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              _tableHeader(['Aspect', 'MenuSerial', 'ShortcutAct.', 'KeySet']),
              _tableRow(
                ['Type', 'mixin', 'abstract', 'class', '(deprecated)'],
                false,
              ),
              _tableRow(
                ['Menu serializable', 'yes', 'maybe', 'no', ''],
                true,
              ),
              _tableRow(
                ['serializeForMenu()', 'required', 'optional', 'absent', ''],
                false,
              ),
              _tableRow(['Modifiers', 'yes', 'yes', 'yes', ''], true),
              _tableRow(
                ['Character trigger', 'via CA', 'via CA', 'no', ''],
                false,
              ),
              _tableRow(
                ['Order matters', 'yes', 'yes', 'no', ''],
                true,
              ),
              _tableRow(
                ['Use in PlatformMenuBar', 'YES', 'no', 'no', ''],
                false,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Comparison table built');

  // ============================================================
  // SECTION 9 — Code block
  // ============================================================
  print('=== Section 9: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E2F),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.code, color: Color(0xFF82AAFF), size: 20.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformMenuItem with menu-serializable shortcut',
              style: TextStyle(
                color: Color(0xFF82AAFF),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _code(
          '// SingleActivator already implements MenuSerializableShortcut',
          Color(0xFF676E95),
        ),
        _code(
          'final saveShortcut = SingleActivator(',
          Color(0xFFC3E88D),
        ),
        _code(
          '  LogicalKeyboardKey.keyS,',
          Color(0xFFFFCB6B),
        ),
        _code(
          '  meta: true,',
          Color(0xFFFFCB6B),
        ),
        _code(
          ');',
          Color(0xFFC3E88D),
        ),
        SizedBox(height: 8.0),
        _code(
          '// Custom activator — mix in MenuSerializableShortcut',
          Color(0xFF676E95),
        ),
        _code(
          'class MyShortcut extends ShortcutActivator',
          Color(0xFFF07178),
        ),
        _code(
          '    with MenuSerializableShortcut {',
          Color(0xFFF07178),
        ),
        _code(
          '  @override',
          Color(0xFF82AAFF),
        ),
        _code(
          '  ShortcutSerialization serializeForMenu() {',
          Color(0xFFFFCB6B),
        ),
        _code(
          '    return ShortcutSerialization.modifier(',
          Color(0xFFC3E88D),
        ),
        _code(
          '      LogicalKeyboardKey.keyS,',
          Color(0xFFFFCB6B),
        ),
        _code(
          '      meta: true, shift: true,',
          Color(0xFFFFCB6B),
        ),
        _code(
          '    );',
          Color(0xFFC3E88D),
        ),
        _code(
          '  }',
          Color(0xFFFFCB6B),
        ),
        _code(
          '}',
          Color(0xFFF07178),
        ),
        SizedBox(height: 8.0),
        _code(
          '// Wire it into the platform menu bar',
          Color(0xFF676E95),
        ),
        _code(
          'PlatformMenuItem(',
          Color(0xFFC3E88D),
        ),
        _code(
          '  label: "Save",',
          Color(0xFFC3E88D),
        ),
        _code(
          '  shortcut: saveShortcut,',
          Color(0xFFC3E88D),
        ),
        _code(
          '  onSelected: () => doSave(),',
          Color(0xFFC3E88D),
        ),
        _code(
          ');',
          Color(0xFFC3E88D),
        ),
      ],
    ),
  );
  print('Code block built');

  // ============================================================
  // SECTION 10 — Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = Column(
    children: [
      _footgun(
        'LogicalKeySet does NOT serialize for menus',
        'LogicalKeySet pre-dates the mixin and is deprecated for menu use. '
            'Use SingleActivator/CharacterActivator in PlatformMenuBar.',
        Icons.report,
        Colors.redAccent,
      ),
      _footgun(
        'Platform conventions vary',
        'macOS uses ⌘ for primary; Windows/Linux use ⌃. Avoid hard-coding meta '
            'or control — pick the one matching the platform menu.',
        Icons.public,
        ember,
      ),
      _footgun(
        'macOS modifier order is fixed',
        'Serialized order on macOS is ⌃⌥⇧⌘<key>. Don\'t try to override it; '
            'the platform menu renders the canonical sequence.',
        Icons.format_list_numbered,
        macBlue,
      ),
      _footgun(
        'Missing serialization breaks menu items',
        'A ShortcutActivator without MenuSerializableShortcut throws when '
            'placed in PlatformMenuItem.shortcut. Always pick a mixed-in type.',
        Icons.error_outline,
        steelDark,
      ),
      _footgun(
        'character vs key trigger',
        'CharacterActivator triggers on the produced character (layout-aware). '
            'SingleActivator triggers on a logical key. Don\'t mix them up for '
            'localized layouts.',
        Icons.translate,
        Colors.deepPurple,
      ),
    ],
  );
  print('Footguns built');

  // ============================================================
  // SECTION 11 — Recap
  // ============================================================
  print('=== Section 11: Recap ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [macBlueDark, steelDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: macBlueDark.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle_outline, color: emberLight, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapLine(
          'Mixin on ShortcutActivator subclasses → menu-serializable.',
          emberLight,
        ),
        _recapLine(
          'Single API: ShortcutSerialization serializeForMenu().',
          emberLight,
        ),
        _recapLine(
          'SingleActivator covers Cmd/Ctrl/Alt/Shift+key combos.',
          emberLight,
        ),
        _recapLine(
          'CharacterActivator covers character-based shortcuts (?, /, @).',
          emberLight,
        ),
        _recapLine(
          'PlatformMenuBar consumes serialized shortcuts → native menu glyphs.',
          emberLight,
        ),
        _recapLine(
          'LogicalKeySet is deprecated for menu use — prefer the mixed-ins.',
          emberLight,
        ),
      ],
    ),
  );
  print('Recap built');

  print('MenuSerializableShortcut Deep Demo completed successfully');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    backgroundColor: paper,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),

          _sectionTitle('1. Anatomy', steelDark),
          anatomyCard,
          SizedBox(height: 18.0),

          _sectionTitle('2. Implementing classes', steelDark),
          implementingGallery,
          SizedBox(height: 18.0),

          _sectionTitle('3. SingleActivator gallery', steelDark),
          Wrap(
            alignment: WrapAlignment.center,
            children: singleActivatorCards,
          ),
          SizedBox(height: 18.0),

          _sectionTitle('4. CharacterActivator showcase', steelDark),
          Wrap(
            alignment: WrapAlignment.center,
            children: characterCards,
          ),
          SizedBox(height: 18.0),

          _sectionTitle('5. Modifier glyphs', steelDark),
          modifierVisualizer,
          SizedBox(height: 18.0),

          _sectionTitle('6. macOS menu bar mock', steelDark),
          menuBarMock,
          SizedBox(height: 18.0),

          _sectionTitle('7. Comparison', steelDark),
          comparisonTable,
          SizedBox(height: 18.0),

          _sectionTitle('8. Code', steelDark),
          codeBlock,
          SizedBox(height: 18.0),

          _sectionTitle('9. Footguns', steelDark),
          footguns,
          SizedBox(height: 18.0),

          _sectionTitle('10. Recap', steelDark),
          recap,
        ],
      ),
    ),
  );
}

// ============================================================
// HELPERS — top-level only (no classes)
// ============================================================

Widget _sectionTitle(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: [
        Container(
          width: 5.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: color.withValues(alpha: 0.6),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: Colors.white,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _anatomyRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20.0, color: color),
        SizedBox(width: 12.0),
        SizedBox(
          width: 80.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _classCard(
  String name,
  String tagline,
  String example,
  IconData icon,
  Color color,
  bool deprecated,
) {
  return Container(
    width: 210.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: color.withValues(alpha: 0.7),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        if (deprecated)
          Container(
            margin: EdgeInsets.only(bottom: 6.0),
            padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'DEPRECATED for menus',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Text(
          tagline,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.white.withValues(alpha: 0.92),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            example,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _activatorCard(
  String title,
  SingleActivator sa,
  String glyphs,
  String menuPath,
  IconData icon,
  Color color,
) {
  final mods = <String>[];
  if (sa.meta) mods.add('meta');
  if (sa.control) mods.add('control');
  if (sa.alt) mods.add('alt');
  if (sa.shift) mods.add('shift');
  final modString = mods.isEmpty ? 'none' : mods.join(', ');

  return Container(
    width: 240.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: color.withValues(alpha: 0.55),
        width: 1.4,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            glyphs,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          menuPath,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        _kvRow('trigger', sa.trigger.keyLabel, color),
        _kvRow('mods', modString, color),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 56.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _characterCard(
  String title,
  CharacterActivator ca,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: color.withValues(alpha: 0.55),
        width: 1.4,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Center(
          child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.25), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                ca.character,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            'CharacterActivator("${ca.character}")',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _modifierTile(String name, String glyph, String label, Color color) {
  return Container(
    width: 90.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.32),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          glyph,
          style: TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _trafficLight(Color color) {
  return Container(
    width: 12.0,
    height: 12.0,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
  );
}

Widget _menuLabel(String label, bool active) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: active ? Color(0xFF0A84FF) : Colors.transparent,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        color: active ? Colors.white : Color(0xFF1D1D1F),
        fontWeight: active ? FontWeight.bold : FontWeight.w500,
      ),
    ),
  );
}

Widget _menuItem(String label, String shortcut, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
    child: Row(
      children: [
        Icon(icon, size: 14.0, color: Colors.grey.shade600),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13.0, color: color),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            shortcut,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _menuDivider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
    height: 1.0,
    color: Color(0xFFE0E0E2),
  );
}

Widget _tableHeader(List<String> labels) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFE0B2),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: [
        for (final l in labels)
          Expanded(
            child: Text(
              l,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B3F00),
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, bool alt) {
  // The table has 4 visible columns; we accept up to 5 cells (extra ignored).
  final visible = cells.length > 4 ? cells.sublist(0, 4) : cells;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: alt ? Color(0xFFFFF8F0) : Colors.white,
      border: Border(
        top: BorderSide(color: Color(0xFFFFE0B2), width: 0.5),
      ),
    ),
    child: Row(
      children: [
        for (int i = 0; i < visible.length; i++)
          Expanded(
            child: Text(
              visible[i],
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: i == 0 ? null : 'monospace',
                color: i == 0 ? Color(0xFF7B3F00) : Colors.grey.shade800,
                fontWeight: i == 0 ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}

Widget _code(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: color,
        height: 1.45,
      ),
    ),
  );
}

Widget _footgun(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #121, P5(a)):
  // Flutter forbids `borderRadius` on a `Border(...)` with non-uniform
  // colors (thick colored `left` + thin `color.withValues(alpha: 0.3)`
  // on `top/right/bottom`). Refactor to the canonical pattern:
  // ClipRRect > IntrinsicHeight > Row(stretch, [accent strip Container,
  // Expanded(Padding(content))]) with uniform `Border.all`. The outer
  // Container keeps the margin + `boxShadow` (shadows can't be clipped
  // inside ClipRRect) and carries the borderRadius so the shadow's
  // corner shape matches the visual; the inner ClipRRect applies the
  // same radius to clip the gradient + accent strip. Preserves the
  // visual: colored left accent strip, light border on the other
  // sides, uniform 12 px rounded corners, gradient fill, soft drop
  // shadow. Five call sites all run through this helper, producing
  // five identical framework errors at baseline.
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.08),
                color.withValues(alpha: 0.16),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4.0, color: color),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: color, size: 22.0),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: color,
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              body,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade800,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _recapLine(String text, Color bullet) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.0, right: 10.0),
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: bullet,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.95),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
