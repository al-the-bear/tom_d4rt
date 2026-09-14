// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SystemContextMenu
// Demonstrates SystemContextMenu, the widget that displays the platform's
// native context menu (right-click / long-press menu) with system actions
// like Cut, Copy, Paste, and Select All. It bridges Flutter to the OS
// context menu system, supporting iOS, Android, and desktop platforms.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemContextMenu Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.menu,
      'title': 'What is SystemContextMenu?',
      'body': 'A Flutter widget that shows the operating system\'s native '
          'context menu at a given position. Unlike custom context menus '
          'built from Flutter widgets, this uses the platform\'s own '
          'rendering, matching the OS look and feel exactly.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Trigger Mechanisms',
      'body': 'The system context menu is triggered by right-click on '
          'desktop, long-press on mobile, or programmatically via '
          'ContextMenuController. The menu appears at the anchor '
          'position and contains platform-standard actions.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.content_cut,
      'title': 'Standard Actions',
      'body': 'The OS provides default actions: Cut, Copy, Paste, Select '
          'All, and sometimes Look Up or Share. These actions are '
          'localized automatically and vary by platform.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'System vs Custom Menus',
      'body': 'System context menus look native but have limited '
          'customization. Custom menus (built with Flutter widgets) '
          'are fully customizable but don\'t match OS appearance. '
          'Many apps use both depending on context.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
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
    );
  }

  // ============================================================
  // SECTION 2: API / Properties
  // ============================================================
  print('=== Section 2: API ===');

  final apiRows = <Map<String, String>>[
    {
      'param': 'anchor',
      'type': 'Rect',
      'desc': 'The rectangle that the context menu is anchored to, in '
          'global coordinates. The OS uses this to position the menu '
          'near the selection or tap point without covering it.',
    },
    {
      'param': 'onSystemHide',
      'type': 'VoidCallback',
      'desc': 'Called when the system hides the context menu without '
          'Flutter requesting it (e.g., the user taps elsewhere). '
          'Use this to clean up state or deselect text.',
    },
  ];

  final staticMethods = <Map<String, String>>[
    {
      'name': 'SystemContextMenu.editableText',
      'desc': 'Named constructor that creates a SystemContextMenu '
          'configured for an EditableTextState. Automatically sets '
          'up Cut, Copy, Paste, and Select All based on the '
          'text field\'s current selection state.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiRows.length; i++) {
    final row = apiRows[i];
    print('API ${i + 1}: ${row['param']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepPurple.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  for (var i = 0; i < staticMethods.length; i++) {
    final sm = staticMethods[i];
    print('Static ${i + 1}: ${sm['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sm['name']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sm['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Text Selection Context Menu
  // ============================================================
  print('=== Section 3: Text Selection ===');

  final textScenarios = <Map<String, dynamic>>[
    {
      'label': 'No Selection',
      'desc': 'When no text is selected, the context menu typically shows '
          'Select All and Paste (if clipboard has content). Cut and '
          'Copy are unavailable.',
      'selection': '',
      'available': ['Paste', 'Select All'],
      'disabled': ['Cut', 'Copy'],
      'color': Colors.grey,
    },
    {
      'label': 'Partial Selection',
      'desc': 'When text is selected, all actions are available: Cut, '
          'Copy, Paste, and Select All. The menu appears near the '
          'selection handles.',
      'selection': 'selected text',
      'available': ['Cut', 'Copy', 'Paste', 'Select All'],
      'disabled': <String>[],
      'color': Colors.deepPurple,
    },
    {
      'label': 'Read-Only Field',
      'desc': 'In a read-only text field, Cut and Paste are hidden. '
          'Only Copy and Select All appear. The system automatically '
          'adapts the menu items.',
      'selection': 'copyable',
      'available': ['Copy', 'Select All'],
      'disabled': ['Cut', 'Paste'],
      'color': Colors.blue,
    },
    {
      'label': 'Empty Clipboard',
      'desc': 'When the system clipboard is empty, Paste may be disabled '
          'or hidden depending on the platform. Other actions remain '
          'functional.',
      'selection': 'text',
      'available': ['Cut', 'Copy', 'Select All'],
      'disabled': ['Paste'],
      'color': Colors.orange,
    },
  ];

  final textWidgets = <Widget>[];
  for (var i = 0; i < textScenarios.length; i++) {
    final ts = textScenarios[i];
    final tsColor = ts['color'] as Color;
    final available = ts['available'] as List<String>;
    final disabled = ts['disabled'] as List<String>;
    print('Text ${i + 1}: ${ts['label']}');

    final actionChips = <Widget>[];
    for (final action in available) {
      actionChips.add(
        Container(
          margin: const EdgeInsets.only(right: 4, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tsColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: tsColor,
            ),
          ),
        ),
      );
    }
    for (final action in disabled) {
      actionChips.add(
        Container(
          margin: const EdgeInsets.only(right: 4, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              style: BorderStyle.solid,
            ),
          ),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.withOpacity(0.5),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      );
    }

    textWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: tsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tsColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: tsColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: tsColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  ts['label'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: tsColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ts['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(children: actionChips),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Platform Differences
  // ============================================================
  print('=== Section 4: Platform ===');

  final platforms = <Map<String, dynamic>>[
    {
      'name': 'iOS',
      'icon': Icons.phone_iphone,
      'features': [
        'Horizontal pill-shaped menu above selection',
        'Look Up and Share actions available',
        'Long-press triggers menu',
        'Menu repositions to stay on screen',
        'Supports three-finger gestures for undo/redo',
      ],
      'color': Colors.blue,
    },
    {
      'name': 'Android',
      'icon': Icons.phone_android,
      'features': [
        'Material-styled popup menu near selection',
        'Cut, Copy, Paste, Select All standard items',
        'Long-press or double-tap to select and show',
        'Overflow menu for additional actions',
        'Adapts to Material You theming on Android 12+',
      ],
      'color': Colors.green,
    },
    {
      'name': 'macOS',
      'icon': Icons.laptop_mac,
      'features': [
        'Right-click shows native context menu',
        'Full text services (spelling, grammar)',
        'Font panel and color panel access',
        'Share menu integration',
        'Keyboard shortcut hints shown',
      ],
      'color': Colors.grey,
    },
    {
      'name': 'Windows / Linux',
      'icon': Icons.desktop_windows,
      'features': [
        'Right-click context menu',
        'Standard Cut/Copy/Paste/Select All',
        'May include spell-check suggestions',
        'Themed to match OS appearance',
        'Keyboard shortcut labels displayed',
      ],
      'color': Colors.deepPurple,
    },
  ];

  final platWidgets = <Widget>[];
  for (var i = 0; i < platforms.length; i++) {
    final p = platforms[i];
    final pColor = p['color'] as Color;
    final feats = p['features'] as List<String>;
    print('Platform ${i + 1}: ${p['name']}');

    final featRows = <Widget>[];
    for (var j = 0; j < feats.length; j++) {
      featRows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 5, right: 8),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  feats[j],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    platWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(p['icon'] as IconData, color: pColor, size: 22),
                const SizedBox(width: 10),
                Text(
                  p['name'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: pColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...featRows,
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Customization
  // ============================================================
  print('=== Section 5: Customization ===');

  final customTopics = <Map<String, dynamic>>[
    {
      'title': 'contextMenuBuilder',
      'desc': 'TextField and SelectableText accept a contextMenuBuilder '
          'callback. Return SystemContextMenu.editableText() for the '
          'native menu, or return a custom widget to override it.',
      'code': 'TextField(\n'
          '  contextMenuBuilder: (context, state) {\n'
          '    return SystemContextMenu.editableText(\n'
          '      editableTextState: state,\n'
          '    );\n'
          '  },\n'
          ')',
      'color': Colors.deepPurple,
    },
    {
      'title': 'Filtering Actions',
      'desc': 'Wrap SystemContextMenu in an AdaptiveTextSelectionToolbar'
          '.editableText and filter the buttonItems list to remove '
          'unwanted actions. For example, remove Paste for read-only display.',
      'code': 'AdaptiveTextSelectionToolbar.editableText(\n'
          '  editableTextState: state,\n'
          '  buttonItems: state.contextMenuButtonItems\n'
          '    .where((item) =>\n'
          '      item.type != ContextMenuButtonType.paste)\n'
          '    .toList(),\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Adding Custom Actions',
      'desc': 'Extend the default actions by appending to the buttonItems '
          'list. Add custom items like "Translate", "Share", or app-specific '
          'operations alongside the system defaults.',
      'code': 'final items = state.contextMenuButtonItems;\n'
          'items.add(\n'
          '  ContextMenuButtonItem(\n'
          '    label: "Translate",\n'
          '    onPressed: () { /* translate */ },\n'
          '  ),\n'
          ');',
      'color': Colors.teal,
    },
    {
      'title': 'Hybrid Menu',
      'desc': 'Combine the system context menu with Flutter-rendered '
          'additional items. Show the native Cut/Copy/Paste via '
          'SystemContextMenu and add custom Flutter actions below.',
      'code': 'Column(\n'
          '  mainAxisSize: MainAxisSize.min,\n'
          '  children: [\n'
          '    SystemContextMenu.editableText(\n'
          '      editableTextState: state,\n'
          '    ),\n'
          '    // Custom Flutter actions below\n'
          '    TextButton(\n'
          '      onPressed: () { },\n'
          '      child: Text("Custom Action"),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final customWidgets = <Widget>[];
  for (var i = 0; i < customTopics.length; i++) {
    final ct = customTopics[i];
    final ctColor = ct['color'] as Color;
    print('Custom ${i + 1}: ${ct['title']}');
    customWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ctColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ctColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ctColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ctColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ct['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ctColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ct['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ctColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ct['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: ctColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: ContextMenuController
  // ============================================================
  print('=== Section 6: Controller ===');

  final controllerTopics = <Map<String, dynamic>>[
    {
      'title': 'ContextMenuController Overview',
      'desc': 'ContextMenuController manages the lifecycle of context '
          'menus — both system and custom. It handles showing, hiding, '
          'and repositioning menus. SystemContextMenu works with this '
          'controller under the hood.',
      'icon': Icons.settings_remote,
      'color': Colors.deepPurple,
    },
    {
      'title': 'show() & hide()',
      'desc': 'Call controller.show() to display the menu at a position '
          'and controller.hide() to dismiss it. The controller ensures '
          'only one context menu is visible at a time globally.',
      'icon': Icons.visibility,
      'color': Colors.blue,
    },
    {
      'title': 'Anchor Management',
      'desc': 'The anchor Rect tells the system where the selection is. '
          'For text, this is the bounding box of the selected characters. '
          'The OS positions the menu above, below, or beside the anchor.',
      'icon': Icons.anchor,
      'color': Colors.teal,
    },
    {
      'title': 'Automatic Dismissal',
      'desc': 'System context menus dismiss on: tap outside, scroll, '
          'window resize, or focus change. onSystemHide fires so '
          'Flutter can sync its state with the dismissal.',
      'icon': Icons.close,
      'color': Colors.orange,
    },
    {
      'title': 'Single Instance Rule',
      'desc': 'Only one context menu can be shown at a time. Calling '
          'show() while a menu is visible first hides the current one. '
          'This prevents overlapping menus and state inconsistencies.',
      'icon': Icons.looks_one,
      'color': Colors.red,
    },
  ];

  final controlWidgets = <Widget>[];
  for (var i = 0; i < controllerTopics.length; i++) {
    final ct = controllerTopics[i];
    final ctColor = ct['color'] as Color;
    print('Controller ${i + 1}: ${ct['title']}');
    controlWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ctColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ctColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ctColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(ct['icon'] as IconData, color: ctColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ct['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ctColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ct['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Usage Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'pattern': 'Text Editing',
      'desc': 'The most common use. TextField and EditableText provide '
          'context menus by default. SystemContextMenu.editableText() '
          'gives the native menu with appropriate actions.',
      'scenario': 'contextMenuBuilder in TextField',
      'icon': Icons.edit,
      'color': Colors.deepPurple,
    },
    {
      'pattern': 'Selectable Display',
      'desc': 'SelectableText and SelectionArea show context menus for '
          'read-only text. Only Copy and Select All appear since '
          'the content cannot be modified.',
      'scenario': 'SelectableText.rich()',
      'icon': Icons.select_all,
      'color': Colors.blue,
    },
    {
      'pattern': 'Image / Widget Context',
      'desc': 'Non-text widgets can show context menus for actions like '
          'Save Image, Share, or Open in Browser. Use '
          'ContextMenuController directly with custom builder.',
      'scenario': 'GestureDetector + ContextMenuController',
      'icon': Icons.image,
      'color': Colors.green,
    },
    {
      'pattern': 'List Item Actions',
      'desc': 'Long-press on list items to show contextual actions: '
          'Delete, Archive, Edit, Share. Typically uses custom Flutter '
          'menus since system menus are text-focused.',
      'scenario': 'onLongPress + showMenu()',
      'icon': Icons.list,
      'color': Colors.orange,
    },
    {
      'pattern': 'Desktop App Menus',
      'desc': 'Desktop apps commonly need right-click menus in many '
          'areas: file trees, tabs, table rows. Combine system menus '
          'for text and custom menus for non-text elements.',
      'scenario': 'Listener + onPointerDown for right-click',
      'icon': Icons.desktop_mac,
      'color': Colors.red,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final pt = patterns[i];
    final ptColor = pt['color'] as Color;
    print('Pattern ${i + 1}: ${pt['pattern']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(pt['icon'] as IconData, color: ptColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pt['pattern'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ptColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: ptColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    pt['scenario'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: ptColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              pt['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.menu,
      'text': 'SystemContextMenu shows the OS native context menu, '
          'matching platform look and feel exactly.',
    },
    {
      'icon': Icons.rectangle_outlined,
      'text': 'The anchor Rect positions the menu near the selection. '
          'The OS handles overflow and repositioning.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'Behavior differs by platform — iOS shows a pill menu, '
          'Android a popup, desktop a right-click menu.',
    },
    {
      'icon': Icons.tune,
      'text': 'Use contextMenuBuilder to swap between system and custom '
          'menus. Filter or extend default actions.',
    },
    {
      'icon': Icons.settings_remote,
      'text': 'ContextMenuController manages lifecycle. Only one context '
          'menu is visible at a time globally.',
    },
    {
      'icon': Icons.notifications_off,
      'text': 'onSystemHide fires when the OS dismisses the menu so '
          'Flutter can sync its selection state.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepPurple,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SystemContextMenu'),
        backgroundColor: Colors.deepPurple,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.text_fields), text: 'Selection'),
            Tab(icon: Icon(Icons.devices), text: 'Platform'),
            Tab(icon: Icon(Icons.tune), text: 'Custom'),
            Tab(icon: Icon(Icons.settings_remote), text: 'Controller'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SystemContextMenu: the bridge to the OS native context '
                  'menu for text selection and platform-standard actions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Properties, constructors, and static methods.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Selection
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How text selection state affects the available menu '
                  'actions in different scenarios.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...textWidgets,
            ],
          ),

          // Tab 4: Platform
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Platform-specific context menu appearances and '
                  'capabilities across iOS, Android, and desktop.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...platWidgets,
            ],
          ),

          // Tab 5: Custom
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Customizing, filtering, extending, or replacing '
                  'the default context menu actions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...customWidgets,
            ],
          ),

          // Tab 6: Controller
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ContextMenuController: the lifecycle manager for '
                  'showing and hiding context menus.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...controlWidgets,
            ],
          ),

          // Tab 7: Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common usage patterns for context menus across '
                  'different types of Flutter content.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about SystemContextMenu.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
