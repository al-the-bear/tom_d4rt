// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PlatformMenuItem widget
// Demonstrates PlatformMenuItem: the leaf-level (non-submenu) entry in a
// native platform menu hierarchy. Each PlatformMenuItem represents a single
// clickable action with an optional keyboard shortcut, rendered natively
// by the host operating system's menu system.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuItem Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PlatformMenuItem?
  // ============================================================
  // PlatformMenuItem is the atomic building block of native platform
  // menus. While PlatformMenu creates a submenu container and
  // PlatformMenuItemGroup creates separator-bounded sections,
  // PlatformMenuItem is the actual clickable action.
  //
  // Properties:
  // • label — The text displayed in the menu
  // • onSelected — Callback when user clicks the item (null = disabled)
  // • shortcut — Optional keyboard shortcut (SingleActivator/CharacterActivator)
  //
  // PlatformMenuItem extends PlatformMenuEntry, which is the base
  // type accepted by PlatformMenu.menus.
  print('=== Section 1: PlatformMenuItem Concept ===');

  final conceptCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF006064), Color(0xFF00838F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformMenuItem',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The clickable leaf item in native OS menus.\n'
          'Each PlatformMenuItem maps to one selectable\n'
          'action with a label and optional keyboard shortcut.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 14.0),
        // Visual: anatomy of a single menu item
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                'Anatomy of a PlatformMenuItem',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.cyan.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Save Document',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey.shade800),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        'Ctrl+S',
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward, size: 10.0, color: Colors.cyan.shade600),
                        SizedBox(width: 2.0),
                        Text('label', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade700)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, size: 10.0, color: Colors.orange.shade600),
                      SizedBox(width: 2.0),
                      Text('shortcut', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.arrow_upward, size: 10.0, color: Colors.green.shade600),
                  SizedBox(width: 2.0),
                  Text('onSelected → callback fires on click', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created concept card with PlatformMenuItem anatomy');

  // ============================================================
  // SECTION 2: Basic Items with Labels
  // ============================================================
  // The simplest PlatformMenuItem has just a label and an
  // onSelected callback. The label is what the user sees in
  // the native menu.
  print('=== Section 2: Basic Items ===');

  final basicItems = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Actions',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Create Project',
            onSelected: () => print('Create Project triggered'),
          ),
          PlatformMenuItem(
            label: 'Import Data',
            onSelected: () => print('Import Data triggered'),
          ),
          PlatformMenuItem(
            label: 'Export Report',
            onSelected: () => print('Export Report triggered'),
          ),
          PlatformMenuItem(
            label: 'Clear Cache',
            onSelected: () => print('Clear Cache triggered'),
          ),
          PlatformMenuItem(
            label: 'Refresh All',
            onSelected: () => print('Refresh All triggered'),
          ),
        ],
      ),
    ],
    child: Center(child: Text('Basic items')),
  );
  print('Constructed 5 basic menu items: ${basicItems.menus.length} menus');

  // Visual showcase of the 5 basic items
  final basicItemData = [
    {'label': 'Create Project', 'icon': Icons.create_new_folder, 'desc': 'Starts a new project wizard', 'color': Colors.blue},
    {'label': 'Import Data', 'icon': Icons.file_download, 'desc': 'Import from CSV, JSON, or XML', 'color': Colors.green},
    {'label': 'Export Report', 'icon': Icons.file_upload, 'desc': 'Generate and download report', 'color': Colors.orange},
    {'label': 'Clear Cache', 'icon': Icons.cleaning_services, 'desc': 'Remove temporary cached files', 'color': Colors.red},
    {'label': 'Refresh All', 'icon': Icons.refresh, 'desc': 'Reload all data sources', 'color': Colors.purple},
  ];

  final basicVisualCards = <Widget>[];
  for (final item in basicItemData) {
    final color = item['color'] as MaterialColor;
    basicVisualCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.shade200, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Icon(item['icon'] as IconData, color: color.shade700, size: 18.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['label'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: color.shade800),
                  ),
                  Text(
                    item['desc'] as String,
                    style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'label only',
                style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final basicVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: Basic Items with Labels',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each PlatformMenuItem needs only a label and an onSelected callback.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        ...basicVisualCards,
      ],
    ),
  );

  print('Created basic items visual with ${basicVisualCards.length} items');

  // ============================================================
  // SECTION 3: Keyboard Shortcuts Deep Dive
  // ============================================================
  // PlatformMenuItem.shortcut accepts MenuSerializableShortcut
  // implementations. The most common are:
  // • SingleActivator — Ctrl/Alt/Shift/Meta + a key
  // • CharacterActivator — a specific character
  print('=== Section 3: Keyboard Shortcuts Deep Dive ===');

  final shortcutMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Shortcuts',
        menus: <PlatformMenuItem>[
          // Single modifier
          PlatformMenuItem(
            label: 'Save',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
            onSelected: () {},
          ),
          // Shift + modifier
          PlatformMenuItem(
            label: 'Save As',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true, shift: true),
            onSelected: () {},
          ),
          // Alt + modifier
          PlatformMenuItem(
            label: 'Preferences',
            shortcut: const SingleActivator(LogicalKeyboardKey.comma, control: true),
            onSelected: () {},
          ),
          // Function key
          PlatformMenuItem(
            label: 'Full Screen',
            shortcut: const SingleActivator(LogicalKeyboardKey.f11),
            onSelected: () {},
          ),
          // Triple modifier
          PlatformMenuItem(
            label: 'Developer Tools',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyI, control: true, shift: true),
            onSelected: () {},
          ),
          // Character activator
          PlatformMenuItem(
            label: 'Zoom In',
            shortcut: const CharacterActivator('+'),
            onSelected: () {},
          ),
        ],
      ),
    ],
    child: Center(child: Text('Shortcuts demo')),
  );
  print('Constructed shortcut demo: ${shortcutMenu.menus.length} menus');

  // Visual: Shortcut type breakdown
  final shortcutTypes = [
    {
      'type': 'SingleActivator(key, control: true)',
      'example': 'Ctrl + S',
      'desc': 'One modifier + one key',
      'color': Colors.blue,
      'keys': ['Ctrl', 'S'],
    },
    {
      'type': 'SingleActivator(key, control: true, shift: true)',
      'example': 'Ctrl + Shift + S',
      'desc': 'Two modifiers + one key',
      'color': Colors.indigo,
      'keys': ['Ctrl', 'Shift', 'S'],
    },
    {
      'type': 'SingleActivator(functionKey)',
      'example': 'F11',
      'desc': 'Function key alone',
      'color': Colors.green,
      'keys': ['F11'],
    },
    {
      'type': 'CharacterActivator(char)',
      'example': '+',
      'desc': 'Character-based trigger',
      'color': Colors.orange,
      'keys': ['+'],
    },
  ];

  final shortcutTypeCards = <Widget>[];
  for (final st in shortcutTypes) {
    final color = st['color'] as MaterialColor;
    final keys = st['keys'] as List<String>;
    final keyWidgets = <Widget>[];
    for (var ki = 0; ki < keys.length; ki++) {
      if (ki > 0) {
        keyWidgets.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Text('+', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
          ),
        );
      }
      keyWidgets.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1.0, offset: Offset(0, 1))],
          ),
          child: Text(
            keys[ki],
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', fontWeight: FontWeight.w600, color: Colors.grey.shade700),
          ),
        ),
      );
    }

    shortcutTypeCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ...keyWidgets,
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: color.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    st['desc'] as String,
                    style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color.shade700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              st['type'] as String,
              style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: color.shade700),
            ),
          ],
        ),
      ),
    );
  }

  final shortcutVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3: Keyboard Shortcuts Deep Dive',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenuItem.shortcut supports SingleActivator and CharacterActivator.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...shortcutTypeCards,
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PlatformMenuItem(\n'
            '  label: "Save",\n'
            '  shortcut: SingleActivator(\n'
            '    LogicalKeyboardKey.keyS,\n'
            '    control: true,\n'
            '  ),\n'
            '  onSelected: () => saveDocument(),\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF80DEEA), height: 1.4),
          ),
        ),
      ],
    ),
  );

  print('Created keyboard shortcut deep dive with ${shortcutTypeCards.length} types');

  // ============================================================
  // SECTION 4: Enabled vs Disabled Items
  // ============================================================
  // Setting onSelected to null makes the item appear grayed out
  // and un-clickable in the native menu. This is standard for
  // items that are not currently applicable (e.g., "Undo" when
  // there's nothing to undo).
  print('=== Section 4: Enabled vs Disabled ===');

  final stateMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Undo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true),
            onSelected: null, // Disabled — nothing to undo
          ),
          PlatformMenuItem(
            label: 'Redo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true),
            onSelected: null, // Disabled — nothing to redo
          ),
          PlatformMenuItem(
            label: 'Cut',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyX, control: true),
            onSelected: () => print('Cut'), // Enabled
          ),
          PlatformMenuItem(
            label: 'Copy',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyC, control: true),
            onSelected: () => print('Copy'), // Enabled
          ),
          PlatformMenuItem(
            label: 'Paste',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyV, control: true),
            onSelected: () => print('Paste'), // Enabled (clipboard has content)
          ),
          PlatformMenuItem(
            label: 'Paste Special...',
            onSelected: null, // Disabled
          ),
        ],
      ),
    ],
    child: Center(child: Text('State demo')),
  );
  print('Constructed state demo: ${stateMenu.menus.length} menus');

  // Visual: Enabled vs Disabled comparison
  final stateItems = [
    {'label': 'Undo', 'shortcut': 'Ctrl+Z', 'enabled': false, 'reason': 'Nothing to undo'},
    {'label': 'Redo', 'shortcut': 'Ctrl+Shift+Z', 'enabled': false, 'reason': 'Nothing to redo'},
    {'label': 'Cut', 'shortcut': 'Ctrl+X', 'enabled': true, 'reason': 'Text is selected'},
    {'label': 'Copy', 'shortcut': 'Ctrl+C', 'enabled': true, 'reason': 'Text is selected'},
    {'label': 'Paste', 'shortcut': 'Ctrl+V', 'enabled': true, 'reason': 'Clipboard has content'},
    {'label': 'Paste Special...', 'shortcut': '', 'enabled': false, 'reason': 'Feature not available'},
  ];

  final stateRows = <Widget>[];
  for (final item in stateItems) {
    final enabled = item['enabled'] as bool;
    stateRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: enabled ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: enabled ? Colors.green.shade200 : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              enabled ? Icons.check_circle : Icons.block,
              size: 16.0,
              color: enabled ? Colors.green.shade600 : Colors.grey.shade400,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                item['label'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: enabled ? Colors.grey.shade800 : Colors.grey.shade400,
                ),
              ),
            ),
            if ((item['shortcut'] as String).isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  item['shortcut'] as String,
                  style: TextStyle(
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    color: enabled ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                ),
              ),
            SizedBox(
              width: 120.0,
              child: Text(
                item['reason'] as String,
                style: TextStyle(fontSize: 8.0, color: enabled ? Colors.green.shade600 : Colors.red.shade400, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final stateVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Enabled vs Disabled Items',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'onSelected: null → disabled. onSelected: () {} → enabled.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        ...stateRows,
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, size: 16.0, color: Colors.amber.shade700),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Disabled items remain visible but cannot be selected.\n'
                  'Use this for context-dependent actions (e.g., Undo when history is empty).',
                  style: TextStyle(fontSize: 9.0, color: Colors.amber.shade800, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created enabled vs disabled items visual');

  // ============================================================
  // SECTION 5: Items Across Menu Contexts
  // ============================================================
  // PlatformMenuItem is used in every part of a menu hierarchy:
  // directly under PlatformMenu, inside PlatformMenuItemGroup,
  // and in nested submenus. Here we show the same item type
  // serving different roles across a complete menu system.
  print('=== Section 5: Items in Different Contexts ===');

  final contextMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          // Direct child of PlatformMenu
          PlatformMenuItem(label: 'New', onSelected: () {}),
          // Inside a group
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Save', onSelected: () {}),
            ],
          ),
          // Inside a submenu
          PlatformMenu(
            label: 'Recent',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(label: 'file1.txt', onSelected: () {}),
              PlatformMenuItem(label: 'file2.txt', onSelected: () {}),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('Context demo')),
  );
  print('Constructed context demo: ${contextMenu.menus.length} menus');

  // Visual: Where PlatformMenuItem can appear
  final contextVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: Items in Different Contexts',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenuItem appears in three different positions within menus.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Context 1: Direct child
        _buildContextCard(
          'Direct child of PlatformMenu',
          'PlatformMenu(menus: [PlatformMenuItem(...)])',
          Icons.arrow_forward,
          Colors.blue,
          'Most common usage — items directly inside a top-level menu.',
        ),
        SizedBox(height: 8.0),
        // Context 2: Inside a group
        _buildContextCard(
          'Inside PlatformMenuItemGroup',
          'PlatformMenuItemGroup(members: [PlatformMenuItem(...)])',
          Icons.view_list,
          Colors.orange,
          'Grouped items get separator lines above and below the section.',
        ),
        SizedBox(height: 8.0),
        // Context 3: Inside nested submenu
        _buildContextCard(
          'Inside a nested PlatformMenu (submenu)',
          'PlatformMenu(menus: [PlatformMenu(menus: [PlatformMenuItem(...)])])',
          Icons.account_tree,
          Colors.purple,
          'Leaf items in deeply nested submenu hierarchies.',
        ),
        SizedBox(height: 12.0),
        // Visual tree showing all three
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PlatformMenu "File"', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
              _buildTreeLine('├─ PlatformMenuItem "New"', Colors.blue, 1),
              _buildTreeLine('├─ PlatformMenuItemGroup', Colors.orange, 1),
              _buildTreeLine('│  └─ PlatformMenuItem "Save"', Colors.orange, 2),
              _buildTreeLine('└─ PlatformMenu "Recent"', Colors.purple, 1),
              _buildTreeLine('   ├─ PlatformMenuItem "file1.txt"', Colors.purple, 2),
              _buildTreeLine('   └─ PlatformMenuItem "file2.txt"', Colors.purple, 2),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created context positions visual');

  // ============================================================
  // SECTION 6: PlatformMenuItem vs PlatformMenu
  // ============================================================
  // It's important to distinguish PlatformMenuItem (leaf action)
  // from PlatformMenu (submenu container). Both extend
  // PlatformMenuEntry and can appear in PlatformMenu.menus,
  // but they serve very different purposes.
  print('=== Section 6: PlatformMenuItem vs PlatformMenu ===');

  final comparisonData = [
    {'aspect': 'Type', 'menuItem': 'Leaf — clickable action', 'menu': 'Container — opens submenu'},
    {'aspect': 'Behavior', 'menuItem': 'Fires onSelected callback', 'menu': 'Shows nested menu list'},
    {'aspect': 'Children', 'menuItem': 'None', 'menu': 'List of PlatformMenuEntry'},
    {'aspect': 'Visual indicator', 'menuItem': 'None or shortcut text', 'menu': 'Arrow (►) at right'},
    {'aspect': 'Shortcut', 'menuItem': 'Supports shortcut property', 'menu': 'No shortcut support'},
    {'aspect': 'onSelected', 'menuItem': 'Callback or null (disabled)', 'menu': 'Not applicable'},
    {'aspect': 'Label', 'menuItem': 'Action name (e.g., "Save")', 'menu': 'Category (e.g., "File")'},
    {'aspect': 'Nesting', 'menuItem': 'Cannot contain children', 'menu': 'Can contain menus & items'},
  ];

  final comparisonRows = <Widget>[];
  for (var i = 0; i < comparisonData.length; i++) {
    final data = comparisonData[i];
    final isEven = i % 2 == 0;
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        color: isEven ? Colors.grey.shade50 : Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                data['aspect']!,
                style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                margin: EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  data['menuItem']!,
                  style: TextStyle(fontSize: 8.0, color: Colors.cyan.shade800),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  data['menu']!,
                  style: TextStyle(fontSize: 8.0, color: Colors.deepPurple.shade800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: PlatformMenuItem vs PlatformMenu',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Leaf actions vs submenu containers — both extend PlatformMenuEntry.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: Row(
            children: [
              SizedBox(width: 80.0, child: Text('Aspect', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold))),
              Expanded(child: Text('PlatformMenuItem', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade700))),
              Expanded(child: Text('PlatformMenu', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700))),
            ],
          ),
        ),
        ...comparisonRows,
        SizedBox(height: 12.0),
        // Visual metaphor
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: Colors.cyan.shade600, size: 24.0),
                    SizedBox(height: 4.0),
                    Text('PlatformMenuItem', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800)),
                    Text('= Button', style: TextStyle(fontSize: 9.0, color: Colors.cyan.shade600)),
                    SizedBox(height: 4.0),
                    Text('Click → Action', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.folder, color: Colors.deepPurple.shade600, size: 24.0),
                    SizedBox(height: 4.0),
                    Text('PlatformMenu', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800)),
                    Text('= Folder', style: TextStyle(fontSize: 9.0, color: Colors.deepPurple.shade600)),
                    SizedBox(height: 4.0),
                    Text('Hover → Submenu opens', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created PlatformMenuItem vs PlatformMenu comparison');

  // ============================================================
  // SECTION 7: Property Reference
  // ============================================================
  // Complete reference of all PlatformMenuItem properties
  // with visual explanation of each.
  print('=== Section 7: Property Reference ===');

  final properties = [
    {
      'name': 'label',
      'type': 'String',
      'required': true,
      'desc': 'The text displayed for this menu item. This is what\nthe user reads in the native menu.',
      'example': 'label: "Save Document"',
      'icon': Icons.label,
      'color': Colors.blue,
    },
    {
      'name': 'shortcut',
      'type': 'MenuSerializableShortcut?',
      'required': false,
      'desc': 'Keyboard shortcut for this item. Usually SingleActivator\nor CharacterActivator. Shown alongside the label.',
      'example': 'shortcut: SingleActivator(LogicalKeyboardKey.keyS, control: true)',
      'icon': Icons.keyboard,
      'color': Colors.orange,
    },
    {
      'name': 'onSelected',
      'type': 'VoidCallback?',
      'required': false,
      'desc': 'Callback invoked when user selects this item.\nIf null, the item appears grayed out (disabled).',
      'example': 'onSelected: () => saveDocument()',
      'icon': Icons.play_arrow,
      'color': Colors.green,
    },
  ];

  final propertyCards = <Widget>[];
  for (final prop in properties) {
    final color = prop['color'] as MaterialColor;
    final required = prop['required'] as bool;
    propertyCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(prop['icon'] as IconData, color: color.shade600, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  prop['name'] as String,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color.shade800),
                ),
                SizedBox(width: 6.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    prop['type'] as String,
                    style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: required ? Colors.red.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    required ? 'required' : 'optional',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.bold,
                      color: required ? Colors.red.shade700 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              prop['desc'] as String,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.4),
            ),
            SizedBox(height: 6.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                prop['example'] as String,
                style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF80DEEA)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final propertyVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7: Property Reference',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Complete property reference for PlatformMenuItem.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...propertyCards,
      ],
    ),
  );

  print('Created property reference with ${propertyCards.length} properties');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  print('Assembling all sections...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade700, Colors.cyan.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.touch_app, color: Colors.white, size: 40.0),
              SizedBox(height: 8.0),
              Text(
                'PlatformMenuItem',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text(
                'Clickable Leaf Action in Native Menus',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 8.0),
              Text(
                'The atomic action element in PlatformMenuBar.\n'
                'Each PlatformMenuItem represents one selectable\n'
                'command with a label, shortcut, and callback.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Colors.white60, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        conceptCard,
        SizedBox(height: 16.0),
        basicVisual,
        SizedBox(height: 16.0),
        shortcutVisual,
        SizedBox(height: 16.0),
        stateVisual,
        SizedBox(height: 16.0),
        contextVisual,
        SizedBox(height: 16.0),
        comparisonVisual,
        SizedBox(height: 16.0),
        propertyVisual,
        SizedBox(height: 24.0),
        Center(
          child: Text(
            'PlatformMenuItem Deep Demo — 7 sections',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildContextCard(String title, String code, IconData icon, MaterialColor color, String desc) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: color.shade700, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: color.shade800)),
              Text(desc, style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
              SizedBox(height: 2.0),
              Text(code, style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: color.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeLine(String text, MaterialColor color, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: 8.0, top: 1.0, bottom: 1.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        fontFamily: 'monospace',
        color: color.shade700,
      ),
    ),
  );
}
