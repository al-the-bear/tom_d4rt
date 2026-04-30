// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PlatformMenuBar widget
// Demonstrates PlatformMenuBar: a widget that defines a menu bar structure
// to be rendered by the host platform's native menu system (macOS, Windows,
// Linux). Unlike Flutter's MenuBar which renders in the widget tree,
// PlatformMenuBar sends menu definitions to the operating system so that
// menus appear in the native title bar / menu bar area.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuBar Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PlatformMenuBar?
  // ============================================================
  // PlatformMenuBar is a widget that describes a menu bar structure
  // for the host platform. On macOS, the menus appear in the
  // system menu bar at the top of the screen. On Windows and Linux,
  // they appear in the application window's title bar area.
  //
  // Key characteristics:
  // • Menus are rendered by the OS, NOT by Flutter
  // • The widget itself has no visual representation in Flutter
  // • It wraps a child widget and provides menus to the platform
  // • Supports keyboard shortcuts, submenus, separators, checkmarks
  // • Only one PlatformMenuBar should exist per application
  print('=== Section 1: PlatformMenuBar Concept ===');

  // Visual explanation of what PlatformMenuBar does
  final conceptCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593)],
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
            Icon(Icons.menu_book, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformMenuBar',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Declares a menu bar to the host operating system.\n'
          'Menus appear in the native menu bar area — NOT in the\n'
          'Flutter widget tree. This provides a platform-native\n'
          'experience that matches user expectations on each OS.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Visual: simulated macOS-style menu bar
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            children: [
              Icon(Icons.apple, color: Colors.black87, size: 16.0),
              SizedBox(width: 16.0),
              Text('File', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 16.0),
              Text('Edit', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 16.0),
              Text('View', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 16.0),
              Text('Help', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              Spacer(),
              Text('Mon 10:42', style: TextStyle(fontSize: 11.0, color: Colors.black54)),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '↑ This is what the OS renders — Flutter defines the structure',
          style: TextStyle(fontSize: 10.0, color: Colors.amber.shade200, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );

  print('Created concept card explaining PlatformMenuBar');

  // ============================================================
  // SECTION 2: Basic Menu Structure
  // ============================================================
  // PlatformMenuBar takes a list of PlatformMenu items as `menus`.
  // Each PlatformMenu represents a top-level menu (File, Edit, etc.)
  // and contains a list of PlatformMenuItem entries.
  print('=== Section 2: Basic Menu Structure ===');

  // Build a real PlatformMenuBar (even though it sends to OS,
  // we test that the interpreter can construct the full widget tree)
  final basicMenuBar = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'New',
            onSelected: () => print('File > New selected'),
          ),
          PlatformMenuItem(
            label: 'Open',
            onSelected: () => print('File > Open selected'),
          ),
          PlatformMenuItem(
            label: 'Save',
            onSelected: () => print('File > Save selected'),
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Close',
                onSelected: () => print('File > Close selected'),
              ),
            ],
          ),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Undo',
            onSelected: () => print('Edit > Undo selected'),
          ),
          PlatformMenuItem(
            label: 'Redo',
            onSelected: () => print('Edit > Redo selected'),
          ),
        ],
      ),
    ],
    child: Center(
      child: Text('App content under PlatformMenuBar'),
    ),
  );
  print('Constructed basic PlatformMenuBar with File and Edit menus');
  print('basicMenuBar child: ${basicMenuBar.child}');

  // Visual representation of the menu structure
  final menuStructureVisual = Container(
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
          'Section 2: Basic Menu Structure',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenuBar wraps a child and declares menus to the OS.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Simulated menu bar
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: [
              _buildMenuBarItem('File', Colors.indigo, true),
              SizedBox(width: 4.0),
              _buildMenuBarItem('Edit', Colors.teal, false),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        // Drop-down from File
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 4.0),
            Container(
              width: 160.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8.0, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDropdownItem('New', 'Ctrl+N', false),
                  _buildDropdownItem('Open', 'Ctrl+O', false),
                  _buildDropdownItem('Save', 'Ctrl+S', false),
                  Container(height: 1.0, color: Colors.grey.shade200),
                  _buildDropdownItem('Close', 'Ctrl+W', false),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            // Edit menu (collapsed)
            Container(
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8.0, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDropdownItem('Undo', 'Ctrl+Z', false),
                  _buildDropdownItem('Redo', 'Ctrl+Y', false),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Code representation
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PlatformMenuBar(\n'
            '  menus: [\n'
            '    PlatformMenu(label: "File", menus: [\n'
            '      PlatformMenuItem(label: "New"),\n'
            '      PlatformMenuItem(label: "Open"),\n'
            '      PlatformMenuItem(label: "Save"),\n'
            '      PlatformMenuItemGroup(members: [\n'
            '        PlatformMenuItem(label: "Close"),\n'
            '      ]),\n'
            '    ]),\n'
            '    PlatformMenu(label: "Edit", menus: [\n'
            '      PlatformMenuItem(label: "Undo"),\n'
            '      PlatformMenuItem(label: "Redo"),\n'
            '    ]),\n'
            '  ],\n'
            '  child: MyAppContent(),\n'
            ')',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF80CBC4),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('Created visual menu structure display');

  // ============================================================
  // SECTION 3: Keyboard Shortcuts
  // ============================================================
  // PlatformMenuItem supports keyboard shortcuts through the
  // `shortcut` property. These take a CharacterActivator or
  // SingleActivator to define the key combination.
  print('=== Section 3: Keyboard Shortcuts ===');

  final shortcutMenuBar = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'New Document',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyN, control: true),
            onSelected: () => print('Ctrl+N: New Document'),
          ),
          PlatformMenuItem(
            label: 'Open...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyO, control: true),
            onSelected: () => print('Ctrl+O: Open'),
          ),
          PlatformMenuItem(
            label: 'Save',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
            onSelected: () => print('Ctrl+S: Save'),
          ),
          PlatformMenuItem(
            label: 'Save As...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true, shift: true),
            onSelected: () => print('Ctrl+Shift+S: Save As'),
          ),
          PlatformMenuItem(
            label: 'Print',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyP, control: true),
            onSelected: () => print('Ctrl+P: Print'),
          ),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Cut',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyX, control: true),
            onSelected: () => print('Ctrl+X: Cut'),
          ),
          PlatformMenuItem(
            label: 'Copy',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyC, control: true),
            onSelected: () => print('Ctrl+C: Copy'),
          ),
          PlatformMenuItem(
            label: 'Paste',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyV, control: true),
            onSelected: () => print('Ctrl+V: Paste'),
          ),
          PlatformMenuItem(
            label: 'Select All',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyA, control: true),
            onSelected: () => print('Ctrl+A: Select All'),
          ),
        ],
      ),
    ],
    child: Center(child: Text('Shortcut-equipped menus')),
  );
  print('Constructed PlatformMenuBar with keyboard shortcuts');
  print('shortcutMenuBar menus: ${shortcutMenuBar.menus.length}');

  // Visual shortcut showcase
  final shortcutEntries = [
    {'action': 'New Document', 'keys': 'Ctrl + N', 'icon': Icons.note_add, 'color': Colors.blue},
    {'action': 'Open...', 'keys': 'Ctrl + O', 'icon': Icons.folder_open, 'color': Colors.orange},
    {'action': 'Save', 'keys': 'Ctrl + S', 'icon': Icons.save, 'color': Colors.green},
    {'action': 'Save As...', 'keys': 'Ctrl + Shift + S', 'icon': Icons.save_as, 'color': Colors.teal},
    {'action': 'Print', 'keys': 'Ctrl + P', 'icon': Icons.print, 'color': Colors.purple},
    {'action': 'Cut', 'keys': 'Ctrl + X', 'icon': Icons.content_cut, 'color': Colors.red},
    {'action': 'Copy', 'keys': 'Ctrl + C', 'icon': Icons.copy, 'color': Colors.indigo},
    {'action': 'Paste', 'keys': 'Ctrl + V', 'icon': Icons.paste, 'color': Colors.brown},
    {'action': 'Select All', 'keys': 'Ctrl + A', 'icon': Icons.select_all, 'color': Colors.cyan},
  ];

  final shortcutCards = <Widget>[];
  for (final entry in shortcutEntries) {
    final color = entry['color'] as MaterialColor;
    shortcutCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.shade200, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(entry['icon'] as IconData, color: color.shade700, size: 18.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                entry['action'] as String,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.grey.shade800),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                entry['keys'] as String,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
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
          'Section 3: Keyboard Shortcuts',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenuItem.shortcut accepts SingleActivator or CharacterActivator.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        ...shortcutCards,
      ],
    ),
  );

  print('Created keyboard shortcut showcase with ${shortcutCards.length} entries');

  // ============================================================
  // SECTION 4: Nested Submenus
  // ============================================================
  // PlatformMenu can itself contain other PlatformMenu items,
  // creating a nested hierarchy of submenus. This allows for
  // deeply structured menus like "Format > Text > Font Family".
  print('=== Section 4: Nested Submenus ===');

  final nestedMenuBar = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Format',
        menus: <PlatformMenuItem>[
          PlatformMenu(
            label: 'Text',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Bold',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyB, control: true),
                onSelected: () => print('Format > Text > Bold'),
              ),
              PlatformMenuItem(
                label: 'Italic',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyI, control: true),
                onSelected: () => print('Format > Text > Italic'),
              ),
              PlatformMenuItem(
                label: 'Underline',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyU, control: true),
                onSelected: () => print('Format > Text > Underline'),
              ),
              PlatformMenu(
                label: 'Font Family',
                menus: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Sans Serif', onSelected: () => print('Font: Sans Serif')),
                  PlatformMenuItem(label: 'Serif', onSelected: () => print('Font: Serif')),
                  PlatformMenuItem(label: 'Monospace', onSelected: () => print('Font: Monospace')),
                ],
              ),
            ],
          ),
          PlatformMenu(
            label: 'Paragraph',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Align Left', onSelected: () => print('Align Left')),
              PlatformMenuItem(label: 'Align Center', onSelected: () => print('Align Center')),
              PlatformMenuItem(label: 'Align Right', onSelected: () => print('Align Right')),
            ],
          ),
          PlatformMenuItem(
            label: 'Clear Formatting',
            onSelected: () => print('Clear Formatting'),
          ),
        ],
      ),
    ],
    child: Center(child: Text('Nested submenu demo')),
  );
  print('Constructed nested submenu tree: Format > Text > Font Family');
  print('nestedMenuBar menus: ${nestedMenuBar.menus.length}');

  // Visual tree of nested submenu hierarchy
  final submenuTreeVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Nested Submenus',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenu can nest inside other PlatformMenu for deep hierarchies.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Tree visualization
        _buildTreeNode('Format', 0, Colors.deepPurple, true),
        _buildTreeNode('Text', 1, Colors.purple, true),
        _buildTreeNode('Bold         Ctrl+B', 2, Colors.blue, false),
        _buildTreeNode('Italic       Ctrl+I', 2, Colors.blue, false),
        _buildTreeNode('Underline    Ctrl+U', 2, Colors.blue, false),
        _buildTreeNode('Font Family', 2, Colors.indigo, true),
        _buildTreeNode('Sans Serif', 3, Colors.teal, false),
        _buildTreeNode('Serif', 3, Colors.teal, false),
        _buildTreeNode('Monospace', 3, Colors.teal, false),
        _buildTreeNode('Paragraph', 1, Colors.purple, true),
        _buildTreeNode('Align Left', 2, Colors.green, false),
        _buildTreeNode('Align Center', 2, Colors.green, false),
        _buildTreeNode('Align Right', 2, Colors.green, false),
        _buildTreeNode('Clear Formatting', 1, Colors.red, false),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Depth: PlatformMenu entries in menus list can be\n'
            'either PlatformMenuItem (leaf) or PlatformMenu (submenu).\n'
            'The OS renders the full hierarchy natively.',
            style: TextStyle(fontSize: 10.0, color: Colors.deepPurple.shade800, height: 1.4),
          ),
        ),
      ],
    ),
  );

  print('Created nested submenu tree visualization');

  // ============================================================
  // SECTION 5: Menu Item States
  // ============================================================
  // PlatformMenuItem items can be in different states:
  // • Active: onSelected callback provided → item is selectable
  // • Disabled: onSelected is null → item appears grayed out
  // • Grouped: PlatformMenuItemGroup places a separator around items
  // Note: Checkmarks use a different mechanism on different platforms
  print('=== Section 5: Menu Item States ===');

  final stateMenuBar = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'View',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Zoom In',
            shortcut: const SingleActivator(LogicalKeyboardKey.equal, control: true),
            onSelected: () => print('Zoom In'),
          ),
          PlatformMenuItem(
            label: 'Zoom Out',
            shortcut: const SingleActivator(LogicalKeyboardKey.minus, control: true),
            onSelected: () => print('Zoom Out'),
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Full Screen',
                shortcut: const SingleActivator(LogicalKeyboardKey.f11),
                onSelected: () => print('Full Screen'),
              ),
            ],
          ),
          // Disabled item: onSelected is null
          PlatformMenuItem(
            label: 'Presentation Mode',
            onSelected: null,
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Show Sidebar',
                onSelected: () => print('Show Sidebar'),
              ),
              PlatformMenuItem(
                label: 'Show Status Bar',
                onSelected: () => print('Show Status Bar'),
              ),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('State demo')),
  );
  print('Constructed state showcase menu with enabled, disabled, and grouped items');
  print('stateMenuBar menus: ${stateMenuBar.menus.length}');

  // Visual states display
  final stateItems = [
    {'label': 'Zoom In', 'state': 'Enabled', 'shortcut': 'Ctrl + =', 'icon': Icons.zoom_in, 'enabled': true, 'grouped': false},
    {'label': 'Zoom Out', 'state': 'Enabled', 'shortcut': 'Ctrl + -', 'icon': Icons.zoom_out, 'enabled': true, 'grouped': false},
    {'label': '── separator ──', 'state': 'Group', 'shortcut': '', 'icon': Icons.horizontal_rule, 'enabled': true, 'grouped': true},
    {'label': 'Full Screen', 'state': 'Enabled (grouped)', 'shortcut': 'F11', 'icon': Icons.fullscreen, 'enabled': true, 'grouped': true},
    {'label': '── separator ──', 'state': 'Group', 'shortcut': '', 'icon': Icons.horizontal_rule, 'enabled': true, 'grouped': true},
    {'label': 'Presentation Mode', 'state': 'Disabled', 'shortcut': '', 'icon': Icons.slideshow, 'enabled': false, 'grouped': false},
    {'label': '── separator ──', 'state': 'Group', 'shortcut': '', 'icon': Icons.horizontal_rule, 'enabled': true, 'grouped': true},
    {'label': 'Show Sidebar', 'state': 'Enabled (grouped)', 'shortcut': '', 'icon': Icons.vertical_split, 'enabled': true, 'grouped': true},
    {'label': 'Show Status Bar', 'state': 'Enabled (grouped)', 'shortcut': '', 'icon': Icons.view_stream, 'enabled': true, 'grouped': true},
  ];

  final stateCards = <Widget>[];
  for (final item in stateItems) {
    final isEnabled = item['enabled'] as bool;
    final isGrouped = item['grouped'] as bool;
    final isSeparator = (item['label'] as String).contains('separator');
    if (isSeparator) {
      stateCards.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.shade300,
          ),
        ),
      );
    } else {
      stateCards.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.0),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
          decoration: BoxDecoration(
            color: isGrouped ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                size: 16.0,
                color: isEnabled ? Colors.grey.shade700 : Colors.grey.shade400,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isEnabled ? Colors.grey.shade800 : Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if ((item['shortcut'] as String).isNotEmpty)
                Text(
                  item['shortcut'] as String,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade500,
                  ),
                ),
              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: isEnabled ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  item['state'] as String,
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
          'Section 5: Menu Item States',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Items can be enabled, disabled (onSelected: null), or wrapped in groups.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: stateCards,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            _buildStateLegendChip('Enabled', Colors.green),
            SizedBox(width: 8.0),
            _buildStateLegendChip('Disabled', Colors.red),
            SizedBox(width: 8.0),
            _buildStateLegendChip('Grouped', Colors.blue),
          ],
        ),
      ],
    ),
  );

  print('Created state display with ${stateCards.length} items');

  // ============================================================
  // SECTION 6: Full Application Menu Bar
  // ============================================================
  // A complete application typically has a comprehensive menu bar
  // with multiple menus, submenus, shortcuts, and grouping.
  // Here we build a full text editor menu system.
  print('=== Section 6: Full Application Menu Bar ===');

  final fullMenuBar = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'New',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyN, control: true),
            onSelected: () => print('New'),
          ),
          PlatformMenuItem(
            label: 'Open...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyO, control: true),
            onSelected: () => print('Open'),
          ),
          PlatformMenu(
            label: 'Open Recent',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(label: 'document1.txt', onSelected: () {}),
              PlatformMenuItem(label: 'report.md', onSelected: () {}),
              PlatformMenuItem(label: 'notes.txt', onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Save',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
                onSelected: () => print('Save'),
              ),
              PlatformMenuItem(
                label: 'Save As...',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true, shift: true),
                onSelected: () => print('Save As'),
              ),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Export as PDF',
                onSelected: () => print('Export PDF'),
              ),
            ],
          ),
          PlatformMenuItem(
            label: 'Quit',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyQ, control: true),
            onSelected: () => print('Quit'),
          ),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Undo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true),
            onSelected: () => print('Undo'),
          ),
          PlatformMenuItem(
            label: 'Redo',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true),
            onSelected: () => print('Redo'),
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Cut',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyX, control: true),
                onSelected: () => print('Cut'),
              ),
              PlatformMenuItem(
                label: 'Copy',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyC, control: true),
                onSelected: () => print('Copy'),
              ),
              PlatformMenuItem(
                label: 'Paste',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyV, control: true),
                onSelected: () => print('Paste'),
              ),
            ],
          ),
          PlatformMenuItem(
            label: 'Find...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyF, control: true),
            onSelected: () => print('Find'),
          ),
          PlatformMenuItem(
            label: 'Replace...',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyH, control: true),
            onSelected: () => print('Replace'),
          ),
        ],
      ),
      PlatformMenu(
        label: 'View',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'Zoom In',
            shortcut: const SingleActivator(LogicalKeyboardKey.equal, control: true),
            onSelected: () => print('Zoom In'),
          ),
          PlatformMenuItem(
            label: 'Zoom Out',
            shortcut: const SingleActivator(LogicalKeyboardKey.minus, control: true),
            onSelected: () => print('Zoom Out'),
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Show Toolbar', onSelected: () {}),
              PlatformMenuItem(label: 'Show Line Numbers', onSelected: () {}),
              PlatformMenuItem(label: 'Show Word Count', onSelected: () {}),
            ],
          ),
          PlatformMenuItem(
            label: 'Full Screen',
            shortcut: const SingleActivator(LogicalKeyboardKey.f11),
            onSelected: () => print('Full Screen'),
          ),
        ],
      ),
      PlatformMenu(
        label: 'Help',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'Documentation', onSelected: () => print('Docs')),
          PlatformMenuItem(label: 'Release Notes', onSelected: () => print('Release Notes')),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'About TextEdit', onSelected: () => print('About')),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('TextEdit application content')),
  );
  print('Constructed full TextEdit application menu bar');
  print('fullMenuBar top-level menus: ${fullMenuBar.menus.length}');

  // Visual: Complete menu bar overview
  final fullMenuVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade700],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Full Application Menu',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 4.0),
        Text(
          'A complete TextEdit application menu system.',
          style: TextStyle(fontSize: 11.0, color: Colors.white60),
        ),
        SizedBox(height: 12.0),
        // Title bar simulation
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              // Window controls
              Row(
                children: [
                  Container(width: 10.0, height: 10.0, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  SizedBox(width: 5.0),
                  Container(width: 10.0, height: 10.0, decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle)),
                  SizedBox(width: 5.0),
                  Container(width: 10.0, height: 10.0, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                ],
              ),
              SizedBox(width: 20.0),
              Text('File', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 14.0),
              Text('Edit', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 14.0),
              Text('View', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(width: 14.0),
              Text('Help', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black87)),
              Spacer(),
              Text('TextEdit', style: TextStyle(fontSize: 12.0, color: Colors.black54)),
            ],
          ),
        ),
        // App body simulation
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('The quick brown fox jumps over the lazy dog.', style: TextStyle(fontSize: 13.0, color: Colors.black87)),
              SizedBox(height: 6.0),
              Text('This text is inside the PlatformMenuBar child widget.', style: TextStyle(fontSize: 13.0, color: Colors.black87)),
              SizedBox(height: 6.0),
              Text('The menus above are rendered by the operating system.', style: TextStyle(fontSize: 13.0, color: Colors.black54, fontStyle: FontStyle.italic)),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Line 3, Col 1', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
                  SizedBox(width: 12.0),
                  Text('UTF-8', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Menu count summary
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuCountBadge('File', '8 items', Colors.blue),
            _buildMenuCountBadge('Edit', '7 items', Colors.green),
            _buildMenuCountBadge('View', '6 items', Colors.orange),
            _buildMenuCountBadge('Help', '3 items', Colors.purple),
          ],
        ),
      ],
    ),
  );

  print('Created full application menu bar visual');

  // ============================================================
  // SECTION 7: PlatformMenuBar vs MenuBar Comparison
  // ============================================================
  // Flutter provides two menu bar approaches:
  // • PlatformMenuBar — sends menus to the OS for native rendering
  // • MenuBar — renders menus as Flutter widgets in the widget tree
  // Each has trade-offs regarding appearance, customization, and
  // platform consistency.
  print('=== Section 7: PlatformMenuBar vs MenuBar ===');

  final comparisonData = [
    {'aspect': 'Rendering', 'platform': 'Native OS menu bar', 'flutter': 'Flutter widget in tree'},
    {'aspect': 'Appearance', 'platform': 'Matches OS look', 'flutter': 'Material Design style'},
    {'aspect': 'Position', 'platform': 'OS menu bar area', 'flutter': 'Anywhere in layout'},
    {'aspect': 'Customization', 'platform': 'Limited by OS', 'flutter': 'Fully customizable'},
    {'aspect': 'Accessibility', 'platform': 'OS-provided a11y', 'flutter': 'Flutter Semantics'},
    {'aspect': 'Submenus', 'platform': 'PlatformMenu nesting', 'flutter': 'SubmenuButton nesting'},
    {'aspect': 'Shortcuts', 'platform': 'SingleActivator', 'flutter': 'MenuAcceleratorLabel'},
    {'aspect': 'Icons', 'platform': 'Not supported', 'flutter': 'leadingIcon / trailingIcon'},
    {'aspect': 'Use case', 'platform': 'Desktop apps', 'flutter': 'Cross-platform UI'},
  ];

  final comparisonRows = <Widget>[];
  for (var i = 0; i < comparisonData.length; i++) {
    final data = comparisonData[i];
    final isEven = i % 2 == 0;
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        color: isEven ? Colors.grey.shade50 : Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 90.0,
              child: Text(
                data['aspect']!,
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  data['platform']!,
                  style: TextStyle(fontSize: 9.0, color: Colors.indigo.shade700),
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  data['flutter']!,
                  style: TextStyle(fontSize: 9.0, color: Colors.teal.shade700),
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
          'Section 7: PlatformMenuBar vs MenuBar',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Two different approaches to application menus in Flutter.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 10.0),
        // Table header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 90.0,
                child: Text('Aspect', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text('PlatformMenuBar', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.indigo)),
              ),
              Expanded(
                child: Text('MenuBar', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.teal)),
              ),
            ],
          ),
        ),
        ...comparisonRows,
        SizedBox(height: 12.0),
        // When to use each
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.computer, color: Colors.indigo, size: 22.0),
                    SizedBox(height: 4.0),
                    Text(
                      'Use PlatformMenuBar',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'When building native desktop\napps that should match the\nOS look and feel.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Colors.indigo.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.widgets, color: Colors.teal, size: 22.0),
                    SizedBox(height: 4.0),
                    Text(
                      'Use MenuBar',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'When you need custom styling,\ncross-platform consistency,\nor inline menu placement.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Colors.teal.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created PlatformMenuBar vs MenuBar comparison table');

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
              colors: [Colors.indigo.shade700, Colors.indigo.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.menu_open, color: Colors.white, size: 40.0),
              SizedBox(height: 8.0),
              Text(
                'PlatformMenuBar',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text(
                'Native OS Menu Bar Integration',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 8.0),
              Text(
                'Defines a menu structure that the operating system\n'
                'renders in its native menu bar, providing platform-\n'
                'consistent application menus for desktop apps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Colors.white60, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        conceptCard,
        SizedBox(height: 16.0),
        menuStructureVisual,
        SizedBox(height: 16.0),
        shortcutVisual,
        SizedBox(height: 16.0),
        submenuTreeVisual,
        SizedBox(height: 16.0),
        stateVisual,
        SizedBox(height: 16.0),
        fullMenuVisual,
        SizedBox(height: 16.0),
        comparisonVisual,
        SizedBox(height: 24.0),
        // Footer
        Center(
          child: Text(
            'PlatformMenuBar Deep Demo — 7 sections',
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

Widget _buildMenuBarItem(String label, MaterialColor color, bool isOpen) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: isOpen ? color.shade100 : Colors.transparent,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: isOpen ? color.shade800 : Colors.grey.shade700,
      ),
    ),
  );
}

Widget _buildDropdownItem(String label, String shortcut, bool disabled) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: disabled ? Colors.grey.shade400 : Colors.grey.shade800,
            ),
          ),
        ),
        if (shortcut.isNotEmpty)
          Text(
            shortcut,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade500,
              fontFamily: 'monospace',
            ),
          ),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, int depth, MaterialColor color, bool hasChildren) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 24.0, top: 2.0, bottom: 2.0),
    child: Row(
      children: [
        if (depth > 0)
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Icon(
              hasChildren ? Icons.arrow_right : Icons.remove,
              size: 14.0,
              color: Colors.grey.shade400,
            ),
          ),
        Icon(
          hasChildren ? Icons.folder : Icons.insert_drive_file,
          size: 14.0,
          color: color.shade600,
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: hasChildren ? FontWeight.w600 : FontWeight.w400,
            color: color.shade800,
            fontFamily: hasChildren ? null : 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateLegendChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color.shade700),
    ),
  );
}

Widget _buildMenuCountBadge(String menu, String count, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.shade100.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300.withValues(alpha: 0.5)),
    ),
    child: Column(
      children: [
        Text(
          menu,
          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 9.0, color: Colors.white70),
        ),
      ],
    ),
  );
}
