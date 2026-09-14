// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PlatformMenuItemGroup widget
// Demonstrates PlatformMenuItemGroup: a grouping mechanism that places
// visual separators (divider lines) around a set of related menu items
// in native platform menus. Used inside PlatformMenu to logically
// organize menu entries into visual sections.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuItemGroup Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PlatformMenuItemGroup?
  // ============================================================
  // PlatformMenuItemGroup wraps a list of PlatformMenuItem entries
  // (its `members`) and tells the operating system to draw separator
  // lines above and below the group. This provides visual structure
  // in native menus, helping users scan and locate related actions.
  //
  // Key points:
  // • It does NOT render any Flutter widget — it's metadata for the OS
  // • Adjacent groups share a single separator (no double lines)
  // • Groups are a list of PlatformMenuItem placed inside PlatformMenu.menus
  // • Members can be PlatformMenuItem or even PlatformMenu (submenus)
  print('=== Section 1: PlatformMenuItemGroup Concept ===');

  final conceptCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
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
            Icon(Icons.view_list, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PlatformMenuItemGroup',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Groups related menu items together by placing\n'
          'separator lines above and below the group.\n'
          'This organizes native OS menus into logical\n'
          'sections, making them easier to scan.',
          style: TextStyle(fontSize: 12.0, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 14.0),
        // Visual: menu with groups
        Container(
          width: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
          ),
          child: Column(
            children: [
              _buildMenuItem('New', '', false, false),
              _buildMenuItem('Open', '', false, false),
              _buildSeparatorLine(),
              Container(
                color: Colors.purple.shade50,
                child: Column(
                  children: [
                    _buildMenuItem('Save', 'Ctrl+S', false, true),
                    _buildMenuItem('Save As', '', false, true),
                  ],
                ),
              ),
              _buildSeparatorLine(),
              _buildMenuItem('Close', '', false, false),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              '= Grouped items (with separators above & below)',
              style: TextStyle(fontSize: 9.0, color: Colors.amber.shade200),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created concept card with grouped menu visual');

  // ============================================================
  // SECTION 2: Basic Grouping
  // ============================================================
  // The simplest use: wrap related items in PlatformMenuItemGroup
  // to separate them visually from other menu items.
  print('=== Section 2: Basic Grouping ===');

  // Build actual PlatformMenuBar with grouping
  final basicGroupMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(
            label: 'New',
            onSelected: () => print('New'),
          ),
          PlatformMenuItem(
            label: 'Open',
            onSelected: () => print('Open'),
          ),
          // GROUP: Save operations
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Save',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
                onSelected: () => print('Save'),
              ),
              PlatformMenuItem(
                label: 'Save As...',
                onSelected: () => print('Save As'),
              ),
              PlatformMenuItem(
                label: 'Save All',
                onSelected: () => print('Save All'),
              ),
            ],
          ),
          PlatformMenuItem(
            label: 'Close',
            onSelected: () => print('Close'),
          ),
        ],
      ),
    ],
    child: Center(child: Text('Basic grouping demo')),
  );
  print('Constructed basic grouping menu: ${basicGroupMenu.menus.length} top-level menus');

  // Visual: Before and After comparison
  final basicGroupVisual = Container(
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
          'Section 2: Basic Grouping',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Wrap related items in PlatformMenuItemGroup to add separator lines.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Without grouping
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'Without Group',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.red.shade800),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem('New', '', false, false),
                        _buildMenuItem('Open', '', false, false),
                        _buildMenuItem('Save', 'Ctrl+S', false, false),
                        _buildMenuItem('Save As...', '', false, false),
                        _buildMenuItem('Save All', '', false, false),
                        _buildMenuItem('Close', '', false, false),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'All items run together,\nhard to scan quickly',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 9.0, color: Colors.red.shade600),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            // With grouping
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'With Group',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem('New', '', false, false),
                        _buildMenuItem('Open', '', false, false),
                        _buildSeparatorLine(),
                        Container(
                          color: Colors.green.shade50,
                          child: Column(
                            children: [
                              _buildMenuItem('Save', 'Ctrl+S', false, true),
                              _buildMenuItem('Save As...', '', false, true),
                              _buildMenuItem('Save All', '', false, true),
                            ],
                          ),
                        ),
                        _buildSeparatorLine(),
                        _buildMenuItem('Close', '', false, false),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Related Save items are\nvisually grouped together',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 9.0, color: Colors.green.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Code snippet
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PlatformMenuItemGroup(\n'
            '  members: [\n'
            '    PlatformMenuItem(label: "Save"),\n'
            '    PlatformMenuItem(label: "Save As..."),\n'
            '    PlatformMenuItem(label: "Save All"),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFFA5D6A7),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('Created basic grouping before/after comparison');

  // ============================================================
  // SECTION 3: Multiple Groups in One Menu
  // ============================================================
  // A single PlatformMenu can contain multiple PlatformMenuItemGroup
  // entries, each creating its own visual section. Items between
  // groups automatically get separators between them.
  print('=== Section 3: Multiple Groups ===');

  final multiGroupMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Edit',
        menus: <PlatformMenuItem>[
          // Group 1: History
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
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
            ],
          ),
          // Group 2: Clipboard
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
          // Group 3: Selection
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(
                label: 'Select All',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyA, control: true),
                onSelected: () => print('Select All'),
              ),
              PlatformMenuItem(
                label: 'Select None',
                onSelected: () => print('Select None'),
              ),
            ],
          ),
          // Group 4: Search
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
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
        ],
      ),
    ],
    child: Center(child: Text('Multi-group demo')),
  );
  print('Constructed multi-group Edit menu: ${multiGroupMenu.menus.length} top-level menus');

  // Visual display of multiple groups
  final groupColorMap = [
    {'label': 'History', 'color': Colors.blue, 'items': ['Undo    Ctrl+Z', 'Redo    Ctrl+Shift+Z']},
    {'label': 'Clipboard', 'color': Colors.orange, 'items': ['Cut      Ctrl+X', 'Copy    Ctrl+C', 'Paste   Ctrl+V']},
    {'label': 'Selection', 'color': Colors.green, 'items': ['Select All   Ctrl+A', 'Select None']},
    {'label': 'Search', 'color': Colors.purple, 'items': ['Find...       Ctrl+F', 'Replace...  Ctrl+H']},
  ];

  final groupSections = <Widget>[];
  for (var gi = 0; gi < groupColorMap.length; gi++) {
    final group = groupColorMap[gi];
    final color = group['color'] as MaterialColor;
    final items = group['items'] as List<String>;
    if (gi > 0) {
      groupSections.add(_buildSeparatorLine());
    }
    groupSections.add(
      Container(
        color: color.shade50,
        child: Column(
          children: [
            // Group label (not part of actual menu—just for visualization)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: Text(
                group['label'] as String,
                style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color.shade400),
              ),
            ),
            ...items.map((item) => _buildMenuItem(item.split('  ')[0].trim(), item.contains('  ') ? item.split('  ').last.trim() : '', false, true)),
          ],
        ),
      ),
    );
  }

  final multiGroupVisual = Container(
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
          'Section 3: Multiple Groups in One Menu',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Edit menu organized into 4 logical groups with auto-separators.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulated menu
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
              ),
              child: Column(
                children: groupSections,
              ),
            ),
            SizedBox(width: 16.0),
            // Legend
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group Legend',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 8.0),
                  _buildGroupLegendRow('History', Colors.blue, '2 items'),
                  SizedBox(height: 4.0),
                  _buildGroupLegendRow('Clipboard', Colors.orange, '3 items'),
                  SizedBox(height: 4.0),
                  _buildGroupLegendRow('Selection', Colors.green, '2 items'),
                  SizedBox(height: 4.0),
                  _buildGroupLegendRow('Search', Colors.purple, '2 items'),
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'Adjacent groups\nshare one separator\nline (no doubles).',
                      style: TextStyle(fontSize: 9.0, color: Colors.amber.shade800, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created multi-group visual with ${groupColorMap.length} groups');

  // ============================================================
  // SECTION 4: Single-Item Groups as Dividers
  // ============================================================
  // You can use PlatformMenuItemGroup with a single member to
  // effectively create a divider between other items. This is
  // a common pattern when one menu item stands alone logically.
  print('=== Section 4: Single-Item Groups ===');

  final singleGroupMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'File',
        menus: <PlatformMenuItem>[
          PlatformMenuItem(label: 'New', onSelected: () {}),
          PlatformMenuItem(label: 'Open', onSelected: () {}),
          PlatformMenuItem(label: 'Save', onSelected: () {}),
          // Single-item group acts as a section break
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Export as PDF', onSelected: () {}),
            ],
          ),
          PlatformMenuItem(label: 'Print', onSelected: () {}),
          // Another single-item group
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Quit', onSelected: () {}),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('Single-item group demo')),
  );
  print('Constructed single-item group demo: ${singleGroupMenu.menus.length} menus');

  final singleGroupVisual = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Single-Item Groups',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'A group with one member creates a visual divider around that item.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulated menu
            Container(
              width: 180.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0)],
              ),
              child: Column(
                children: [
                  _buildMenuItem('New', '', false, false),
                  _buildMenuItem('Open', '', false, false),
                  _buildMenuItem('Save', '', false, false),
                  _buildSeparatorLine(),
                  Container(
                    color: Colors.orange.shade50,
                    child: _buildMenuItem('Export as PDF', '', false, true),
                  ),
                  _buildSeparatorLine(),
                  _buildMenuItem('Print', '', false, false),
                  _buildSeparatorLine(),
                  Container(
                    color: Colors.red.shade50,
                    child: _buildMenuItem('Quit', '', false, true),
                  ),
                  _buildSeparatorLine(),
                ],
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnnotation('Regular items', 'No separators between them', Colors.grey),
                  SizedBox(height: 8.0),
                  _buildAnnotation('Export (single group)', 'Isolated from neighbors by separators', Colors.orange),
                  SizedBox(height: 8.0),
                  _buildAnnotation('Quit (single group)', 'Visually separated for safety — destructive actions are often isolated', Colors.red),
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Text(
                      'Pattern: Use single-item\n'
                      'groups to visually\n'
                      'separate important or\n'
                      'destructive actions.',
                      style: TextStyle(fontSize: 9.0, color: Colors.orange.shade800, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created single-item group visual');

  // ============================================================
  // SECTION 5: Groups in Nested Submenus
  // ============================================================
  // PlatformMenuItemGroup works inside nested PlatformMenu entries
  // too, organizing submenu items into logical sections.
  print('=== Section 5: Groups in Submenus ===');

  final nestedGroupMenu = PlatformMenuBar(
    menus: <PlatformMenuItem>[
      PlatformMenu(
        label: 'Format',
        menus: <PlatformMenuItem>[
          PlatformMenu(
            label: 'Text Style',
            menus: <PlatformMenuItem>[
              PlatformMenuItemGroup(
                members: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Bold', onSelected: () {}),
                  PlatformMenuItem(label: 'Italic', onSelected: () {}),
                  PlatformMenuItem(label: 'Underline', onSelected: () {}),
                ],
              ),
              PlatformMenuItemGroup(
                members: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Strikethrough', onSelected: () {}),
                  PlatformMenuItem(label: 'Superscript', onSelected: () {}),
                  PlatformMenuItem(label: 'Subscript', onSelected: () {}),
                ],
              ),
            ],
          ),
          PlatformMenu(
            label: 'Alignment',
            menus: <PlatformMenuItem>[
              PlatformMenuItemGroup(
                members: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Left', onSelected: () {}),
                  PlatformMenuItem(label: 'Center', onSelected: () {}),
                  PlatformMenuItem(label: 'Right', onSelected: () {}),
                  PlatformMenuItem(label: 'Justify', onSelected: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('Nested group demo')),
  );
  print('Constructed nested group menu: ${nestedGroupMenu.menus.length} top-level menus');

  // Visual: nested submenu structure with groups highlighted
  final nestedGroupVisual = Container(
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
          'Section 5: Groups in Nested Submenus',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Groups organize items inside submenus too, adding separators at any depth.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top menu
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                    child: Row(
                      children: [
                        Expanded(child: Text('Text Style', style: TextStyle(fontSize: 11.0))),
                        Icon(Icons.arrow_right, size: 14.0, color: Colors.grey),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                    child: Row(
                      children: [
                        Expanded(child: Text('Alignment', style: TextStyle(fontSize: 11.0))),
                        Icon(Icons.arrow_right, size: 14.0, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.0),
            // Text Style submenu with two groups
            Container(
              width: 130.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6.0)],
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.indigo.shade50,
                    child: Column(
                      children: [
                        _buildMenuItem('Bold', '', false, true),
                        _buildMenuItem('Italic', '', false, true),
                        _buildMenuItem('Underline', '', false, true),
                      ],
                    ),
                  ),
                  _buildSeparatorLine(),
                  Container(
                    color: Colors.deepPurple.shade50,
                    child: Column(
                      children: [
                        _buildMenuItem('Strikethrough', '', false, true),
                        _buildMenuItem('Superscript', '', false, true),
                        _buildMenuItem('Subscript', '', false, true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            _buildGroupChip('Group A: Common styles', Colors.indigo),
            SizedBox(width: 8.0),
            _buildGroupChip('Group B: Special styles', Colors.deepPurple),
          ],
        ),
      ],
    ),
  );

  print('Created nested group submenu visual');

  // ============================================================
  // SECTION 6: Real-World Application Menu
  // ============================================================
  // A comprehensive IDE-style application menu demonstrating
  // practical grouping patterns used in real desktop applications.
  print('=== Section 6: Real-World IDE Menu ===');

  final ideMenu = PlatformMenuBar(
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
              PlatformMenu(label: 'Open Recent', menus: <PlatformMenuItem>[
                PlatformMenuItem(label: 'project_a/', onSelected: () {}),
                PlatformMenuItem(label: 'project_b/', onSelected: () {}),
                PlatformMenuItemGroup(members: <PlatformMenuItem>[
                  PlatformMenuItem(label: 'Clear Recent', onSelected: () {}),
                ]),
              ]),
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
              PlatformMenuItem(label: 'Preferences...', shortcut: const SingleActivator(LogicalKeyboardKey.comma, control: true), onSelected: () {}),
            ],
          ),
          PlatformMenuItemGroup(
            members: <PlatformMenuItem>[
              PlatformMenuItem(label: 'Exit', shortcut: const SingleActivator(LogicalKeyboardKey.keyQ, control: true), onSelected: () {}),
            ],
          ),
        ],
      ),
    ],
    child: Center(child: Text('IDE menu')),
  );
  print('Constructed IDE File menu: ${ideMenu.menus.length} top-level menus');

  // Visual: Complete IDE File menu
  final ideMenuVisual = Container(
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
          'Section 6: IDE File Menu (Real-World)',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 4.0),
        Text(
          'How an IDE organizes its File menu using PlatformMenuItemGroup.',
          style: TextStyle(fontSize: 11.0, color: Colors.white60),
        ),
        SizedBox(height: 12.0),
        // Simulated title bar
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF333333),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Color(0xFF505050),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text('File', style: TextStyle(fontSize: 11.0, color: Colors.white)),
              ),
              SizedBox(width: 8.0),
              Text('Edit', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade400)),
              SizedBox(width: 8.0),
              Text('View', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade400)),
              SizedBox(width: 8.0),
              Text('Run', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade400)),
              Spacer(),
              Text('CodeEdit', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500)),
            ],
          ),
        ),
        // File dropdown
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 220.0,
              decoration: BoxDecoration(
                color: Color(0xFF252526),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(6.0)),
                boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8.0)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Group: Create
                  _buildDarkMenuItem('New File', 'Ctrl+N', Icons.insert_drive_file),
                  _buildDarkMenuItem('New Window', 'Ctrl+Shift+N', Icons.open_in_new),
                  _buildDarkSeparator(),
                  // Group: Open
                  _buildDarkMenuItem('Open File...', 'Ctrl+O', Icons.folder_open),
                  _buildDarkMenuItem('Open Folder...', '', Icons.folder),
                  _buildDarkMenuSubmenuItem('Open Recent', Icons.history),
                  _buildDarkSeparator(),
                  // Group: Save
                  _buildDarkMenuItem('Save', 'Ctrl+S', Icons.save),
                  _buildDarkMenuItem('Save As...', 'Ctrl+Shift+S', Icons.save_as),
                  _buildDarkMenuItem('Save All', '', Icons.save_alt),
                  _buildDarkSeparator(),
                  // Group: Settings
                  _buildDarkMenuItem('Preferences...', 'Ctrl+,', Icons.settings),
                  _buildDarkSeparator(),
                  // Group: Exit
                  _buildDarkMenuItem('Exit', 'Ctrl+Q', Icons.exit_to_app),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            // Group annotations
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.0),
                  _buildGroupBracket('Create', Colors.blue, 2),
                  _buildGroupBracket('Open', Colors.orange, 3),
                  _buildGroupBracket('Save', Colors.green, 3),
                  _buildGroupBracket('Settings', Colors.purple, 1),
                  _buildGroupBracket('Exit', Colors.red, 1),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created IDE File menu visual');

  // ============================================================
  // SECTION 7: Grouping Patterns Comparison
  // ============================================================
  // Different approaches to organizing menu items and when to
  // use PlatformMenuItemGroup vs simple item ordering.
  print('=== Section 7: Grouping Patterns ===');

  final patterns = [
    {
      'name': 'Action Groups',
      'desc': 'Related actions by category\n(Clipboard: Cut, Copy, Paste)',
      'icon': Icons.category,
      'color': Colors.blue,
      'example': 'Group(Cut, Copy, Paste)',
    },
    {
      'name': 'Isolation',
      'desc': 'Separate dangerous actions\n(Quit, Delete, Format Disk)',
      'icon': Icons.warning,
      'color': Colors.red,
      'example': 'Group(Quit) — alone',
    },
    {
      'name': 'Feature Tiers',
      'desc': 'Basic vs advanced features\n(Save vs Export/Convert)',
      'icon': Icons.layers,
      'color': Colors.purple,
      'example': 'Group(basic) + Group(advanced)',
    },
    {
      'name': 'Mode Switches',
      'desc': 'Toggle/checkbox-like items\n(Show Toolbar, Show Sidebar)',
      'icon': Icons.toggle_on,
      'color': Colors.teal,
      'example': 'Group(toggles)',
    },
    {
      'name': 'Navigation',
      'desc': 'Window/tab management\n(Next Tab, Prev Tab, Split)',
      'icon': Icons.tab,
      'color': Colors.orange,
      'example': 'Group(nav items)',
    },
  ];

  final patternCards = <Widget>[];
  for (final p in patterns) {
    final color = p['color'] as MaterialColor;
    patternCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(p['icon'] as IconData, color: color.shade700, size: 20.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color.shade800),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700, height: 1.3),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: color.shade300),
              ),
              child: Text(
                p['example'] as String,
                style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: color.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final patternsVisual = Container(
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
          'Section 7: Grouping Patterns',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
        ),
        SizedBox(height: 4.0),
        Text(
          'Common patterns for organizing menu items with PlatformMenuItemGroup.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        ...patternCards,
      ],
    ),
  );

  print('Created grouping patterns display with ${patternCards.length} patterns');

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
              colors: [Colors.purple.shade700, Colors.purple.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.view_list, color: Colors.white, size: 40.0),
              SizedBox(height: 8.0),
              Text(
                'PlatformMenuItemGroup',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text(
                'Logical Menu Section Grouping',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 8.0),
              Text(
                'Groups related menu items together by adding\n'
                'separator lines above and below the group,\n'
                'creating visual structure in native OS menus.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Colors.white60, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        conceptCard,
        SizedBox(height: 16.0),
        basicGroupVisual,
        SizedBox(height: 16.0),
        multiGroupVisual,
        SizedBox(height: 16.0),
        singleGroupVisual,
        SizedBox(height: 16.0),
        nestedGroupVisual,
        SizedBox(height: 16.0),
        ideMenuVisual,
        SizedBox(height: 16.0),
        patternsVisual,
        SizedBox(height: 24.0),
        Center(
          child: Text(
            'PlatformMenuItemGroup Deep Demo — 7 sections',
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

Widget _buildMenuItem(String label, String shortcut, bool disabled, bool highlighted) {
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
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade500),
          ),
      ],
    ),
  );
}

Widget _buildSeparatorLine() {
  return Container(
    height: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    color: Colors.grey.shade300,
  );
}

Widget _buildGroupLegendRow(String label, MaterialColor color, String count) {
  return Row(
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color.shade100,
          borderRadius: BorderRadius.circular(2.0),
          border: Border.all(color: color.shade300, width: 0.5),
        ),
      ),
      SizedBox(width: 6.0),
      Text(label, style: TextStyle(fontSize: 10.0, color: color.shade700, fontWeight: FontWeight.w600)),
      Spacer(),
      Text(count, style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
    ],
  );
}

Widget _buildGroupChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color.shade700),
    ),
  );
}

Widget _buildAnnotation(String title, String desc, MaterialColor color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.only(top: 3.0),
        decoration: BoxDecoration(
          color: color.shade400,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 6.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color.shade800)),
            Text(desc, style: TextStyle(fontSize: 9.0, color: color.shade600)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDarkMenuItem(String label, String shortcut, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Row(
      children: [
        Icon(icon, size: 14.0, color: Colors.grey.shade400),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade300)),
        ),
        if (shortcut.isNotEmpty)
          Text(shortcut, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Colors.grey.shade600)),
      ],
    ),
  );
}

Widget _buildDarkMenuSubmenuItem(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Row(
      children: [
        Icon(icon, size: 14.0, color: Colors.grey.shade400),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade300)),
        ),
        Icon(Icons.arrow_right, size: 14.0, color: Colors.grey.shade500),
      ],
    ),
  );
}

Widget _buildDarkSeparator() {
  return Container(
    height: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 6.0),
    color: Color(0xFF404040),
  );
}

Widget _buildGroupBracket(String label, MaterialColor color, int itemCount) {
  final height = itemCount * 24.0;
  return Container(
    margin: EdgeInsets.only(bottom: 2.0),
    height: height,
    child: Row(
      children: [
        Container(
          width: 3.0,
          height: height,
          decoration: BoxDecoration(
            color: color.shade400,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 6.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color.shade200),
            ),
            Text(
              '$itemCount items',
              style: TextStyle(fontSize: 8.0, color: color.shade400),
            ),
          ],
        ),
      ],
    ),
  );
}
