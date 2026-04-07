// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PlatformMenu widget
// Demonstrates PlatformMenu: the submenu container in the native
// platform menu system. A PlatformMenu holds a list of
// PlatformMenuEntry children (PlatformMenuItem, PlatformMenuItemGroup,
// or nested PlatformMenu) and presents them as a drop-down or
// fly-out submenu rendered by the host OS.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformMenu Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PlatformMenu?
  // ============================================================
  // PlatformMenu is the container/submenu level in the native
  // platform menu hierarchy. It sits *between* PlatformMenuBar
  // (the top bar) and PlatformMenuItem (clickable leaf actions).
  //
  // Hierarchy:
  //   PlatformMenuBar → PlatformMenu → PlatformMenuItem
  //
  // A PlatformMenu has:
  // • label — the text shown in the parent bar or parent menu
  // • menus — a list of child PlatformMenuEntry items
  //
  // When the user clicks on a PlatformMenu label, the OS opens
  // a native drop-down containing the child items.
  print('=== Section 1: PlatformMenu Concept ===');

  final conceptCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)],
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
            Icon(Icons.folder_open, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformMenu',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The submenu container in native OS menus.\n'
          'Groups PlatformMenuItems under a labelled\n'
          'drop-down that is rendered natively by the OS.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 14.0),
        // Hierarchy diagram
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu Hierarchy',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHierarchyBox('PlatformMenuBar', Colors.grey, 'Top bar'),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey.shade400),
                  SizedBox(width: 6.0),
                  _buildHierarchyBox('PlatformMenu', Colors.deepPurple, 'Submenu'),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey.shade400),
                  SizedBox(width: 6.0),
                  _buildHierarchyBox('PlatformMenuItem', Colors.cyan, 'Action'),
                ],
              ),
              SizedBox(height: 8.0),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Text(
                    'PlatformMenu is the middle layer — it creates the drop-down.',
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created concept card with hierarchy');

  // ============================================================
  // SECTION 2: Basic Menu Structure
  // ============================================================
  // A PlatformMenu requires a label and a list of menus (children).
  // The children can be PlatformMenuItem, PlatformMenuItemGroup,
  // or nested PlatformMenu.
  print('=== Section 2: Basic Menu Structure ===');

  final basicMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'New', onSelected: () => print('New')),
          PlatformMenuItem(label: 'Open', onSelected: () => print('Open')),
          PlatformMenuItem(label: 'Save', onSelected: () => print('Save')),
          PlatformMenuItem(label: 'Close', onSelected: () => print('Close')),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'Undo', onSelected: () => print('Undo')),
          PlatformMenuItem(label: 'Redo', onSelected: () => print('Redo')),
          PlatformMenuItem(label: 'Cut', onSelected: () => print('Cut')),
          PlatformMenuItem(label: 'Copy', onSelected: () => print('Copy')),
          PlatformMenuItem(label: 'Paste', onSelected: () => print('Paste')),
        ],
      ),
      PlatformMenu(
        label: 'View',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'Zoom In', onSelected: () {}),
          PlatformMenuItem(label: 'Zoom Out', onSelected: () {}),
          PlatformMenuItem(label: 'Full Screen', onSelected: () {}),
        ],
      ),
    ],
    child: Center(child: Text('Basic menu structure')),
  );
  print('Constructed basic menu bar: ${basicMenu.menus.length} top-level menus');

  // Visual: Three menus showing their children
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
          'Section 2: Basic Menu Structure',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Three PlatformMenu containers, each holding PlatformMenuItems.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Simulated menu bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: Row(
            children: [
              _buildMenuBarLabel('File', Colors.blue, true),
              SizedBox(width: 12.0),
              _buildMenuBarLabel('Edit', Colors.green, false),
              SizedBox(width: 12.0),
              _buildMenuBarLabel('View', Colors.orange, false),
            ],
          ),
        ),
        // "Open" File menu
        Container(
          width: 180.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(6.0)),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(2, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSimulatedItem('New', true),
              _buildSimulatedItem('Open', false),
              _buildSimulatedItem('Save', false),
              _buildSimulatedItem('Close', false),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Code snippet showing structure
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PlatformMenu(\n'
            '  label: "File",        // ← what appears in the bar\n'
            '  menus: [              // ← child entries\n'
            '    PlatformMenuItem(label: "New", onSelected: ...),\n'
            '    PlatformMenuItem(label: "Open", onSelected: ...),\n'
            '    PlatformMenuItem(label: "Save", onSelected: ...),\n'
            '    PlatformMenuItem(label: "Close", onSelected: ...),\n'
            '  ],\n'
            ')',
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFFB2EBF2), height: 1.4),
          ),
        ),
      ],
    ),
  );

  print('Created basic menu visual');

  // ============================================================
  // SECTION 3: Nested Submenus
  // ============================================================
  // PlatformMenu can contain other PlatformMenu entries, creating
  // multi-level fly-out menus. Each nested PlatformMenu opens
  // as a separate submenu panel.
  print('=== Section 3: Nested Submenus ===');

  final nestedMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'New File', onSelected: () {}),
          PlatformMenu(
            label: 'New From Template',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Dart File', onSelected: () {}),
              PlatformMenuItem(label: 'Flutter Widget', onSelected: () {}),
              PlatformMenu(
                label: 'Test Templates',
                menus: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Unit Test', onSelected: () {}),
                  PlatformMenuItem(label: 'Widget Test', onSelected: () {}),
                  PlatformMenuItem(label: 'Integration Test', onSelected: () {}),
                ],
              ),
            ],
          ),
          PlatformMenu(
            label: 'Open Recent',
            menus: <PlatformMenuItem>[
              PlatformMenuItem(label: 'project_a.dart', onSelected: () {}),
              PlatformMenuItem(label: 'main.dart', onSelected: () {}),
              PlatformMenuItem(label: 'pubspec.yaml', onSelected: () {}),
            ],
          ),
          PlatformMenuItem(label: 'Close', onSelected: () {}),
        ],
      ),
    ],
    child: Center(child: Text('Nested menus')),
  );
  print('Constructed nested menu with 3 levels: ${nestedMenu.menus.length} top-level menus');

  // Visual: Nested menu tree
  final nestedVisual = Container(
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
          'Section 3: Nested Submenus',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenu can contain other PlatformMenus for multi-level fly-outs.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Multi-level simulated menus
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Level 1: File menu
            Container(
              width: 160.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildNestLabel('File', Colors.deepPurple, 1),
                  _buildSimulatedItem('New File', false),
                  _buildSimulatedSubmenu('New From Template ►', true),
                  _buildSimulatedSubmenu('Open Recent ►', false),
                  _buildSimulatedItem('Close', false),
                ],
              ),
            ),
            SizedBox(width: 4.0),
            // Level 2: New From Template
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.0),
                Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.orange.shade300),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNestLabel('New From Template', Colors.orange, 2),
                      _buildSimulatedItem('Dart File', false),
                      _buildSimulatedItem('Flutter Widget', false),
                      _buildSimulatedSubmenu('Test Templates ►', true),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.0),
            // Level 3: Test Templates
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.0),
                Container(
                  width: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.red.shade300),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNestLabel('Test Templates', Colors.red, 3),
                      _buildSimulatedItem('Unit Test', false),
                      _buildSimulatedItem('Widget Test', false),
                      _buildSimulatedItem('Integration Test', false),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        // Depth legend
        Row(
          children: [
            _buildDepthChip('Level 1', Colors.deepPurple),
            SizedBox(width: 6.0),
            Text('→', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
            SizedBox(width: 6.0),
            _buildDepthChip('Level 2', Colors.orange),
            SizedBox(width: 6.0),
            Text('→', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500)),
            SizedBox(width: 6.0),
            _buildDepthChip('Level 3', Colors.red),
          ],
        ),
      ],
    ),
  );

  print('Created nested submenu visual with 3 levels');

  // ============================================================
  // SECTION 4: Groups Within Menus
  // ============================================================
  // PlatformMenuItemGroup organizes children inside a PlatformMenu
  // with separator lines. Groups don't have labels — they just
  // visually partition items.
  print('=== Section 4: Groups Within Menus ===');

  final groupMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Undo', shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Redo', shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Cut', shortcut: const SingleActivator(LogicalKeyboardKey.keyX, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Copy', shortcut: const SingleActivator(LogicalKeyboardKey.keyC, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Paste', shortcut: const SingleActivator(LogicalKeyboardKey.keyV, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Select All', shortcut: const SingleActivator(LogicalKeyboardKey.keyA, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Find...', shortcut: const SingleActivator(LogicalKeyboardKey.keyF, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Replace...', shortcut: const SingleActivator(LogicalKeyboardKey.keyH, control: true), onSelected: () {}),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('Groups demo')),
  );
  print('Constructed group demo: ${groupMenu.menus.length} menus');

  // Visual: Menu with separator lines
  final groupVisual = Container(
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
          'Section 4: Groups Within Menus',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'PlatformMenuItemGroup adds separator lines between logical sections.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Simulated Edit menu with groups
        Container(
          width: 240.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNestLabel('Edit', Colors.green, 0),
              // Group 1: History
              _buildGroupItem('Undo', 'Ctrl+Z', Colors.blue),
              _buildGroupItem('Redo', 'Ctrl+Shift+Z', Colors.blue),
              _buildGroupSeparator(),
              // Group 2: Clipboard
              _buildGroupItem('Cut', 'Ctrl+X', Colors.orange),
              _buildGroupItem('Copy', 'Ctrl+C', Colors.orange),
              _buildGroupItem('Paste', 'Ctrl+V', Colors.orange),
              _buildGroupSeparator(),
              // Group 3: Selection
              _buildGroupItem('Select All', 'Ctrl+A', Colors.purple),
              _buildGroupSeparator(),
              // Group 4: Search
              _buildGroupItem('Find...', 'Ctrl+F', Colors.teal),
              _buildGroupItem('Replace...', 'Ctrl+H', Colors.teal),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Group legend
        Row(
          children: [
            _buildGroupLegendDot('History', Colors.blue),
            SizedBox(width: 10.0),
            _buildGroupLegendDot('Clipboard', Colors.orange),
            SizedBox(width: 10.0),
            _buildGroupLegendDot('Selection', Colors.purple),
            SizedBox(width: 10.0),
            _buildGroupLegendDot('Search', Colors.teal),
          ],
        ),
      ],
    ),
  );

  print('Created groups visual with 4 logical groups');

  // ============================================================
  // SECTION 5: Complete Application Menu
  // ============================================================
  // A realistic PlatformMenu setup showing how multiple menus
  // combine to form a full application menu bar — a text editor
  // with File, Edit, View, and Help menus.
  print('=== Section 5: Full Application Menu ===');

  final fullApp = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'New File', shortcut: const SingleActivator(LogicalKeyboardKey.keyN, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'New Window', shortcut: const SingleActivator(LogicalKeyboardKey.keyN, control: true, shift: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Open File...', shortcut: const SingleActivator(LogicalKeyboardKey.keyO, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Open Folder...', onSelected: () {}),
              PlatformMenu(
                label: 'Open Recent',
                menus: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'main.dart', onSelected: () {}),
                  PlatformMenuItem(label: 'pubspec.yaml', onSelected: () {}),
                  PlatformMenuItem(label: 'analysis_options.yaml', onSelected: () {}),
                ],
              ),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Save', shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Save As...', shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true, shift: true), onSelected: () {}),
              PlatformMenuItem(label: 'Save All', onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Close Editor', shortcut: const SingleActivator(LogicalKeyboardKey.keyW, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Close All', onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Exit', shortcut: const SingleActivator(LogicalKeyboardKey.keyQ, control: true), onSelected: () {}),
            ],
          ),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Undo', shortcut: const SingleActivator(LogicalKeyboardKey.keyZ, control: true), onSelected: null),
              PlatformMenuItem(label: 'Redo', shortcut: const SingleActivator(LogicalKeyboardKey.keyY, control: true), onSelected: null),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Cut', shortcut: const SingleActivator(LogicalKeyboardKey.keyX, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Copy', shortcut: const SingleActivator(LogicalKeyboardKey.keyC, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Paste', shortcut: const SingleActivator(LogicalKeyboardKey.keyV, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Find...', shortcut: const SingleActivator(LogicalKeyboardKey.keyF, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Replace...', shortcut: const SingleActivator(LogicalKeyboardKey.keyH, control: true), onSelected: () {}),
            ],
          ),
        ],
      ),
      PlatformMenu(
        label: 'View',
        menus: <PlatformMenuItem>[
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Explorer', shortcut: const SingleActivator(LogicalKeyboardKey.keyE, control: true, shift: true), onSelected: () {}),
              PlatformMenuItem(label: 'Search', shortcut: const SingleActivator(LogicalKeyboardKey.keyF, control: true, shift: true), onSelected: () {}),
              PlatformMenuItem(label: 'Terminal', shortcut: const SingleActivator(LogicalKeyboardKey.backquote, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Zoom In', shortcut: const SingleActivator(LogicalKeyboardKey.equal, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Zoom Out', shortcut: const SingleActivator(LogicalKeyboardKey.minus, control: true), onSelected: () {}),
              PlatformMenuItem(label: 'Reset Zoom', shortcut: const SingleActivator(LogicalKeyboardKey.digit0, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Full Screen', shortcut: const SingleActivator(LogicalKeyboardKey.f11), onSelected: () {}),
            ],
          ),
        ],
      ),
      PlatformMenu(
        label: 'Help',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'Documentation', onSelected: () {}),
          PlatformMenuItem(label: 'Release Notes', onSelected: () {}),
          PlatformMenuItem(label: 'Report Issue', onSelected: () {}),
          PlatformMenuItem(label: 'About', onSelected: () {}),
        ],
      ),
    ],
    child: Center(child: Text('Full application menu')),
  );
  print('Constructed full app menu: ${fullApp.menus.length} top-level menus');

  // Visual: Full app menu in IDE style
  final fullAppVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: Full Application Menu',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 4.0),
        Text(
          'A complete code editor menu system built with PlatformMenu.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade400),
        ),
        SizedBox(height: 12.0),
        // Simulated IDE title bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF333333),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              _buildDarkMenuLabel('File', true),
              _buildDarkMenuLabel('Edit', false),
              _buildDarkMenuLabel('View', false),
              _buildDarkMenuLabel('Help', false),
              Spacer(),
              Text('CodeEdit v1.0', style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        // Simulated File menu dropdown (dark theme)
        Container(
          width: 220.0,
          margin: EdgeInsets.only(left: 4.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Color(0xFF555555)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDarkItem('New File', 'Ctrl+N', true),
              _buildDarkItem('New Window', 'Ctrl+Shift+N', true),
              _buildDarkSeparator(),
              _buildDarkItem('Open File...', 'Ctrl+O', true),
              _buildDarkItem('Open Folder...', '', true),
              _buildDarkSubmenuItem('Open Recent', '►'),
              _buildDarkSeparator(),
              _buildDarkItem('Save', 'Ctrl+S', true),
              _buildDarkItem('Save As...', 'Ctrl+Shift+S', true),
              _buildDarkItem('Save All', '', true),
              _buildDarkSeparator(),
              _buildDarkItem('Close Editor', 'Ctrl+W', true),
              _buildDarkItem('Close All', '', true),
              _buildDarkSeparator(),
              _buildDarkItem('Exit', 'Ctrl+Q', true),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Menu summary badges
        Row(
          children: [
            _buildDarkBadge('File', '5 groups', Colors.blue),
            SizedBox(width: 6.0),
            _buildDarkBadge('Edit', '3 groups', Colors.green),
            SizedBox(width: 6.0),
            _buildDarkBadge('View', '3 groups', Colors.orange),
            SizedBox(width: 6.0),
            _buildDarkBadge('Help', '4 items', Colors.purple),
          ],
        ),
      ],
    ),
  );

  print('Created full application menu visual');

  // ============================================================
  // SECTION 6: PlatformMenu Properties
  // ============================================================
  // Complete property reference for PlatformMenu.
  print('=== Section 6: PlatformMenu Properties ===');

  final propsVisual = Container(
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
          'Section 6: PlatformMenu Properties',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Complete API reference for PlatformMenu.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // label property
        _buildPropertyCard(
          'label',
          'String',
          true,
          'The text shown in the parent menu bar or parent submenu.\n'
          'This is the clickable text the user sees before opening the menu.',
          'label: "File"',
          Icons.label,
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        // menus property
        _buildPropertyCard(
          'menus',
          'List<PlatformMenuEntry>',
          true,
          'The child entries inside this menu. Can contain PlatformMenuItem,\n'
          'PlatformMenuItemGroup, or nested PlatformMenu instances.',
          'menus: [PlatformMenuItem(...), PlatformMenu(...)]',
          Icons.list,
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        // onOpen property
        _buildPropertyCard(
          'onOpen',
          'VoidCallback?',
          false,
          'Called when this submenu is opened by the user.\n'
          'Useful for lazy-loading or updating menu state.',
          'onOpen: () => refreshRecentFiles()',
          Icons.open_in_new,
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        // onClose property
        _buildPropertyCard(
          'onClose',
          'VoidCallback?',
          false,
          'Called when this submenu is closed.\n'
          'Can be used for cleanup or analytics.',
          'onClose: () => logMenuUsage()',
          Icons.close,
          Colors.red,
        ),
      ],
    ),
  );

  print('Created properties reference');

  // ============================================================
  // SECTION 7: PlatformMenu vs MenuAnchor Comparison
  // ============================================================
  // PlatformMenu (native OS menus) vs MenuAnchor/SubmenuButton
  // (Flutter-rendered menus).
  print('=== Section 7: PlatformMenu vs MenuAnchor ===');

  final comparisons = [
    {'aspect': 'Rendering', 'platform': 'Native OS menus', 'flutter': 'Flutter widgets'},
    {'aspect': 'Look & feel', 'platform': 'Matches OS exactly', 'flutter': 'Custom Material/Cupertino'},
    {'aspect': 'Theming', 'platform': 'Follows OS theme', 'flutter': 'ThemeData controlled'},
    {'aspect': 'Nesting model', 'platform': 'PlatformMenu.menus', 'flutter': 'SubmenuButton.menuChildren'},
    {'aspect': 'Container class', 'platform': 'PlatformMenu', 'flutter': 'SubmenuButton'},
    {'aspect': 'Item class', 'platform': 'PlatformMenuItem', 'flutter': 'MenuItemButton'},
    {'aspect': 'Group class', 'platform': 'PlatformMenuItemGroup', 'flutter': '(manual Dividers)'},
    {'aspect': 'Bar class', 'platform': 'PlatformMenuBar', 'flutter': 'MenuBar'},
    {'aspect': 'Platform support', 'platform': 'macOS, Windows, Linux', 'flutter': 'All platforms'},
    {'aspect': 'In-app position', 'platform': 'Always at top of window', 'flutter': 'Anywhere in widget tree'},
  ];

  final compRows = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final c = comparisons[i];
    final isEven = i % 2 == 0;
    compRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        color: isEven ? Colors.grey.shade50 : Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 90.0,
              child: Text(c['aspect']!, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                margin: EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(c['platform']!, style: TextStyle(fontSize: 8.0, color: Colors.deepPurple.shade800)),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(c['flutter']!, style: TextStyle(fontSize: 8.0, color: Colors.blue.shade800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
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
          'Section 7: PlatformMenu vs MenuAnchor',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Native OS menus vs Flutter-rendered menus — when to use which.',
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
              SizedBox(width: 90.0, child: Text('Aspect', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold))),
              Expanded(child: Text('PlatformMenu', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700))),
              Expanded(child: Text('MenuAnchor', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700))),
            ],
          ),
        ),
        ...compRows,
        SizedBox(height: 12.0),
        // Decision helper
        Row(
          children: [
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
                    Icon(Icons.desktop_mac, color: Colors.deepPurple.shade600, size: 22.0),
                    SizedBox(height: 4.0),
                    Text('Use PlatformMenu', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700)),
                    SizedBox(height: 2.0),
                    Text(
                      'Desktop apps needing\nnative OS integration',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Colors.deepPurple.shade600),
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.phone_android, color: Colors.blue.shade600, size: 22.0),
                    SizedBox(height: 4.0),
                    Text('Use MenuAnchor', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
                    SizedBox(height: 2.0),
                    Text(
                      'Cross-platform apps\nor custom-themed menus',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.0, color: Colors.blue.shade600),
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

  print('Created PlatformMenu vs MenuAnchor comparison');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  print('Assembling all sections...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.folder_open, color: Colors.white, size: 40.0),
              SizedBox(height: 8.0),
              Text(
                'PlatformMenu',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text(
                'Native Submenu Container',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 8.0),
              Text(
                'The drop-down/submenu container in native\n'
                'platform menus. Groups PlatformMenuItems under\n'
                'a labelled section rendered by the OS.',
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
        nestedVisual,
        SizedBox(height: 16.0),
        groupVisual,
        SizedBox(height: 16.0),
        fullAppVisual,
        SizedBox(height: 16.0),
        propsVisual,
        SizedBox(height: 16.0),
        comparisonTable,
        SizedBox(height: 24.0),
        Center(
          child: Text(
            'PlatformMenu Deep Demo — 7 sections',
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

Widget _buildHierarchyBox(String label, MaterialColor color, String role) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      children: [
        Text(label, style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold, color: color.shade700)),
        Text(role, style: TextStyle(fontSize: 6.0, color: color.shade500)),
      ],
    ),
  );
}

Widget _buildMenuBarLabel(String label, MaterialColor color, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: active ? color.shade100 : Colors.transparent,
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
        color: active ? color.shade800 : Colors.grey.shade700,
      ),
    ),
  );
}

Widget _buildSimulatedItem(String label, bool highlighted) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    color: highlighted ? Colors.blue.shade50 : Colors.transparent,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        color: highlighted ? Colors.blue.shade800 : Colors.grey.shade700,
      ),
    ),
  );
}

Widget _buildSimulatedSubmenu(String label, bool highlighted) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    color: highlighted ? Colors.orange.shade50 : Colors.transparent,
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: highlighted ? Colors.orange.shade800 : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNestLabel(String label, MaterialColor color, int level) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
    ),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color.shade800)),
        if (level > 0) ...[
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: color.shade200,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text('L$level', style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold, color: color.shade800)),
          ),
        ],
      ],
    ),
  );
}

Widget _buildDepthChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color.shade700)),
  );
}

Widget _buildGroupItem(String label, String shortcut, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 4.0,
          decoration: BoxDecoration(color: color.shade400, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
        ),
        if (shortcut.isNotEmpty)
          Text(shortcut, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Colors.grey.shade400)),
      ],
    ),
  );
}

Widget _buildGroupSeparator() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 1.0,
    color: Colors.grey.shade300,
  );
}

Widget _buildGroupLegendDot(String label, MaterialColor color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 6.0, height: 6.0, decoration: BoxDecoration(color: color.shade400, shape: BoxShape.circle)),
      SizedBox(width: 3.0),
      Text(label, style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
    ],
  );
}

Widget _buildPropertyCard(String name, String type, bool required, String desc, String example, IconData icon, MaterialColor color) {
  return Container(
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
            Icon(icon, color: color.shade600, size: 18.0),
            SizedBox(width: 8.0),
            Text(name, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color.shade800)),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(type, style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
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
                style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: required ? Colors.red.shade700 : Colors.grey.shade600),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(desc, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.4)),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(example, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFFB2EBF2))),
        ),
      ],
    ),
  );
}

Widget _buildDarkMenuLabel(String label, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    margin: EdgeInsets.only(right: 4.0),
    decoration: BoxDecoration(
      color: active ? Color(0xFF555555) : Colors.transparent,
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11.0, color: active ? Colors.white : Colors.grey.shade400),
    ),
  );
}

Widget _buildDarkItem(String label, String shortcut, bool enabled) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: enabled ? Colors.grey.shade300 : Colors.grey.shade600,
            ),
          ),
        ),
        if (shortcut.isNotEmpty)
          Text(shortcut, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
      ],
    ),
  );
}

Widget _buildDarkSubmenuItem(String label, String arrow) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
    child: Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade300)),
        ),
        Text(arrow, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500)),
      ],
    ),
  );
}

Widget _buildDarkSeparator() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 1.0,
    color: Color(0xFF555555),
  );
}

Widget _buildDarkBadge(String label, String count, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade900.withOpacity(0.4),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color.shade200)),
        SizedBox(width: 4.0),
        Text(count, style: TextStyle(fontSize: 8.0, color: color.shade300)),
      ],
    ),
  );
}
