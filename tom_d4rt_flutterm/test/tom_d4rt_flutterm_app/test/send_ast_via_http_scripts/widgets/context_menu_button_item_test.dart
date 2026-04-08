// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ContextMenuButtonItem
// Demonstrates ContextMenuButtonItem — the data class representing a
// single button in a context menu (long-press or right-click menus).
// Covers properties, standard button creation, custom items, ordering,
// platform differences, and integration with text editing widgets.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ContextMenuButtonItem Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ContextMenuButtonItem?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.menu,
      'title': 'Context Menu Data Model',
      'body': 'ContextMenuButtonItem is a simple data class that '
          'describes one button in a context menu — its label, '
          'callback, and type. It is not a widget itself; it\'s '
          'the model that a context menu builder converts into '
          'actual menu item widgets.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Long-Press & Right-Click',
      'body': 'When a user long-presses text in a TextField or '
          'right-clicks on a desktop, Flutter builds a context '
          'menu. The framework creates a list of '
          'ContextMenuButtonItem objects and passes them to a '
          'context menu builder for rendering.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.build_circle,
      'title': 'Builder Pattern',
      'body': 'Widgets like EditableText, SelectableText, and '
          'SelectionArea expose a contextMenuBuilder callback. '
          'This callback receives a list of default '
          'ContextMenuButtonItems. Developers can modify this '
          'list — adding, removing, or reordering items.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.content_cut,
      'title': 'Standard & Custom Items',
      'body': 'Flutter provides factory methods for standard '
          'items: Cut, Copy, Paste, Select All, Delete, and '
          'custom. You can create ContextMenuButtonItem with any '
          'label and callback to add app-specific actions like '
          '"Translate", "Define", or "Share".',
      'accent': Colors.cyan[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'label',
      'type': 'String?',
      'icon': Icons.label,
      'color': Colors.teal[700]!,
      'description': 'The text displayed on the button. For '
          'standard types (cut, copy, paste), this can be null — '
          'the platform provides a localized label automatically. '
          'For custom types, this is required.',
      'example': '\'Translate to English\'',
    },
    {
      'name': 'onPressed',
      'type': 'VoidCallback?',
      'icon': Icons.touch_app,
      'color': Colors.cyan[700]!,
      'description': 'The callback invoked when the button is '
          'tapped. If null, the button is shown as disabled '
          '(greyed out). For standard types, Flutter provides '
          'default implementations (e.g., copy to clipboard).',
      'example': '() => copyToClipboard(text)',
    },
    {
      'name': 'type',
      'type': 'ContextMenuButtonType',
      'icon': Icons.category,
      'color': Colors.teal[600]!,
      'description': 'The semantic type of the button — cut, '
          'copy, paste, selectAll, delete, or custom. Determines '
          'the default label on each platform and ordering '
          'within the menu.',
      'example': 'ContextMenuButtonType.copy',
    },
    {
      'name': 'freeform',
      'type': 'bool',
      'icon': Icons.aspect_ratio,
      'color': Colors.cyan[600]!,
      'description': 'Whether this item should be rendered as a '
          'free-form widget rather than a standard button. '
          'Defaults to false. When true, the context menu '
          'builder can render arbitrary content.',
      'example': 'freeform: true',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: Standard Button Types
  // ============================================================
  print('=== Section 3: Standard Types ===');

  final standardTypes = <Map<String, dynamic>>[
    {
      'name': 'Cut',
      'icon': Icons.content_cut,
      'color': Colors.teal[700]!,
      'keyboard': 'Ctrl+X / Cmd+X',
      'description': 'Removes selected text and places it on the '
          'clipboard. Only available when text is selected and '
          'the field is editable. Disabled for read-only fields.',
      'platforms': 'All platforms. On iOS, may use system menu.',
    },
    {
      'name': 'Copy',
      'icon': Icons.content_copy,
      'color': Colors.cyan[700]!,
      'keyboard': 'Ctrl+C / Cmd+C',
      'description': 'Copies selected text to the clipboard '
          'without removing it. Available whenever text is '
          'selected, regardless of the field being editable '
          'or read-only.',
      'platforms': 'All platforms. Most common context menu item.',
    },
    {
      'name': 'Paste',
      'icon': Icons.content_paste,
      'color': Colors.teal[600]!,
      'keyboard': 'Ctrl+V / Cmd+V',
      'description': 'Inserts clipboard content at the cursor '
          'position. Replaces selected text if any. Only '
          'available when the field is editable and the clipboard '
          'contains text.',
      'platforms': 'All platforms. Clipboard access may need '
          'permission on web.',
    },
    {
      'name': 'Select All',
      'icon': Icons.select_all,
      'color': Colors.cyan[600]!,
      'keyboard': 'Ctrl+A / Cmd+A',
      'description': 'Selects all text in the current field. '
          'Available when the field contains text. Some '
          'platforms show this only when not all text is already '
          'selected.',
      'platforms': 'All platforms. Positioning varies by platform.',
    },
    {
      'name': 'Delete',
      'icon': Icons.delete_outline,
      'color': Colors.teal[800]!,
      'keyboard': 'Del / Backspace',
      'description': 'Removes selected text without copying to '
          'clipboard. Less common than Cut in context menus. '
          'Some platforms include it, others rely on Cut instead.',
      'platforms': 'Desktop primarily. Rare on mobile context menus.',
    },
    {
      'name': 'Custom',
      'icon': Icons.add_circle_outline,
      'color': Colors.cyan[800]!,
      'keyboard': 'App-defined',
      'description': 'Any developer-defined action. Requires an '
          'explicit label string. Examples: "Translate", '
          '"Look Up", "Share", "Define", "Search Web". '
          'The most powerful type for app-specific features.',
      'platforms': 'All platforms. Rendered by the context menu '
          'builder alongside standard items.',
    },
  ];

  print('  Prepared ${standardTypes.length} standard types');

  // ============================================================
  // SECTION 4: Creating Items
  // ============================================================
  print('=== Section 4: Creation Patterns ===');

  final creationPatterns = <Map<String, dynamic>>[
    {
      'name': 'Standard item (copy)',
      'icon': Icons.content_copy,
      'color': Colors.teal[700]!,
      'code': 'ContextMenuButtonItem(\n'
          '  onPressed: () {\n'
          '    // copy logic\n'
          '  },\n'
          '  type: ContextMenuButtonType.copy,\n'
          ')',
      'description': 'For standard types, omit the label — Flutter '
          'uses the platform-localized string. The framework knows '
          'that "copy" means "Copy" in English, "Copier" in French.',
    },
    {
      'name': 'Custom item',
      'icon': Icons.translate,
      'color': Colors.cyan[700]!,
      'code': 'ContextMenuButtonItem(\n'
          '  onPressed: () {\n'
          '    translateSelection();\n'
          '  },\n'
          '  type: ContextMenuButtonType\n'
          '      .custom,\n'
          '  label: \'Translate\',\n'
          ')',
      'description': 'Custom items require a label. Choose a concise, '
          'action-oriented label. The callback receives no '
          'arguments — capture needed context via closures.',
    },
    {
      'name': 'Disabled item (null callback)',
      'icon': Icons.block,
      'color': Colors.teal[600]!,
      'code': 'ContextMenuButtonItem(\n'
          '  onPressed: null,\n'
          '  type: ContextMenuButtonType.paste,\n'
          ')',
      'description': 'Setting onPressed to null shows the item as '
          'disabled/greyed out. Useful when clipboard is empty '
          '(paste disabled) or no text is selected (copy disabled).',
    },
    {
      'name': 'Modifying default items',
      'icon': Icons.edit,
      'color': Colors.cyan[600]!,
      'code': 'contextMenuBuilder:\n'
          '  (context, editableState) {\n'
          '  final items = editableState\n'
          '      .contextMenuButtonItems;\n'
          '  items.add(\n'
          '    ContextMenuButtonItem(\n'
          '      onPressed: doCustom,\n'
          '      label: \'Custom\',\n'
          '    )\n'
          '  );\n'
          '  return buildMenu(items);\n'
          '}',
      'description': 'In contextMenuBuilder, receive default items '
          'from the editable state. Add, remove, or reorder them '
          'before building the menu widget. This is the primary '
          'customization pattern.',
    },
  ];

  print('  Prepared ${creationPatterns.length} creation patterns');

  // ============================================================
  // SECTION 5: Platform Differences
  // ============================================================
  print('=== Section 5: Platform Behavior ===');

  final platformDiffs = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'icon': Icons.android,
      'color': Colors.teal[700]!,
      'menuStyle': 'Floating toolbar above selection',
      'items': 'Cut, Copy, Paste, Select All, Share',
      'description': 'Android shows a floating toolbar with icons '
          'and text. The toolbar repositions as selection handles '
          'move. Custom items appear at the end. Some OEMs add '
          'their own items (Samsung clipboard, etc.).',
    },
    {
      'platform': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.cyan[700]!,
      'menuStyle': 'Bubble menu above selection',
      'items': 'Cut, Copy, Paste, Select All, Look Up, Share',
      'description': 'iOS uses a native-style bubble menu. Flutter '
          'recreates this look. The menu uses horizontal scrolling '
          'when items overflow. System items like "Look Up" and '
          '"Share" may be added automatically.',
    },
    {
      'platform': 'Desktop (macOS/Win/Linux)',
      'icon': Icons.desktop_mac,
      'color': Colors.teal[600]!,
      'menuStyle': 'Vertical dropdown at cursor',
      'items': 'Cut, Copy, Paste, Select All',
      'description': 'Desktop shows a vertical popup menu at the '
          'right-click position. Items use text labels only (no '
          'icons by default). Keyboard shortcuts shown alongside. '
          'Custom items blend seamlessly.',
    },
    {
      'platform': 'Web',
      'icon': Icons.web,
      'color': Colors.cyan[600]!,
      'menuStyle': 'Browser-dependent',
      'items': 'Cut, Copy, Paste (with permissions)',
      'description': 'Web behavior depends on the browser. Flutter '
          'provides its own context menu that overrides the '
          'browser default. Clipboard Paste requires the '
          'Clipboard API permission, which the user must grant.',
    },
  ];

  print('  Prepared ${platformDiffs.length} platform entries');

  // ============================================================
  // SECTION 6: Integration Points
  // ============================================================
  print('=== Section 6: Widget Integration ===');

  final integrations = <Map<String, dynamic>>[
    {
      'name': 'TextField / TextFormField',
      'icon': Icons.text_fields,
      'color': Colors.teal[700]!,
      'provides': 'Cut, Copy, Paste, Select All',
      'description': 'Text fields automatically create standard '
          'ContextMenuButtonItems based on current state (has '
          'selection, is editable, clipboard has content). Use '
          'contextMenuBuilder to customize.',
    },
    {
      'name': 'SelectableText',
      'icon': Icons.select_all,
      'color': Colors.cyan[700]!,
      'provides': 'Copy, Select All',
      'description': 'Read-only selectable text provides only '
          'Copy and Select All — no Cut or Paste since the text '
          'is not editable. Custom items can still be added.',
    },
    {
      'name': 'SelectionArea',
      'icon': Icons.text_snippet,
      'color': Colors.teal[600]!,
      'provides': 'Copy, Select All',
      'description': 'Wraps multiple child widgets to enable text '
          'selection across all of them. Context menu items '
          'depend on the selected content. Custom items are '
          'supported via contextMenuBuilder.',
    },
    {
      'name': 'EditableText',
      'icon': Icons.edit,
      'color': Colors.cyan[600]!,
      'provides': 'All standard items',
      'description': 'The low-level editable text widget. '
          'contextMenuButtonItems getter returns the computed '
          'list of items. Higher-level widgets (TextField) wrap '
          'this and add their own contextMenuBuilder.',
    },
    {
      'name': 'CupertinoTextField',
      'icon': Icons.phone_iphone,
      'color': Colors.teal[800]!,
      'provides': 'Cut, Copy, Paste, Select All',
      'description': 'Cupertino-style text field with iOS-style '
          'context menu. Same ContextMenuButtonItem model, but '
          'rendered with CupertinoTextSelectionToolbar for '
          'native iOS look.',
    },
  ];

  print('  Prepared ${integrations.length} integration points');

  // ============================================================
  // SECTION 7: Ordering & Filtering
  // ============================================================
  print('=== Section 7: Ordering & Filtering ===');

  final orderingRules = <Map<String, dynamic>>[
    {
      'rule': 'Standard items come first',
      'icon': Icons.format_list_numbered,
      'color': Colors.teal[700]!,
      'description': 'Flutter orders standard items by type: '
          'Cut → Copy → Paste → Select All → Delete. This order '
          'is consistent across all platforms. Custom items are '
          'appended after standard items.',
    },
    {
      'rule': 'Disabled items may be hidden',
      'icon': Icons.visibility_off,
      'color': Colors.cyan[700]!,
      'description': 'On some platforms, items with null onPressed '
          'are hidden entirely rather than shown as disabled. '
          'The behavior depends on the context menu builder '
          'implementation.',
    },
    {
      'rule': 'Custom items preserve insertion order',
      'icon': Icons.reorder,
      'color': Colors.teal[600]!,
      'description': 'When you add custom items to the list, they '
          'appear in the order you insert them. Use list methods '
          'like insert() for precise positioning between standard '
          'items.',
    },
    {
      'rule': 'Remove by type filtering',
      'icon': Icons.filter_list,
      'color': Colors.cyan[600]!,
      'description': 'To remove a standard item, filter the list '
          'by type: items.removeWhere((item) => '
          'item.type == ContextMenuButtonType.selectAll). '
          'This is cleaner than removing by index.',
    },
  ];

  print('  Prepared ${orderingRules.length} ordering rules');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'name': 'Add "Share" to text selection',
      'icon': Icons.share,
      'color': Colors.teal[700]!,
      'description': 'Append a custom "Share" button that captures '
          'the selected text and opens the platform share sheet. '
          'Common in messaging apps, reading apps, and social '
          'media apps where sharing text is frequent.',
    },
    {
      'name': 'Add "Define" / "Look Up"',
      'icon': Icons.auto_stories,
      'color': Colors.cyan[700]!,
      'description': 'Add a dictionary lookup item that sends the '
          'selected word to a definition API. Useful in e-readers, '
          'language learning apps, and educational platforms. '
          'iOS provides this natively; Android needs custom code.',
    },
    {
      'name': 'Remove "Select All" for short fields',
      'icon': Icons.remove_circle_outline,
      'color': Colors.teal[600]!,
      'description': 'For single-word input fields (search bar, '
          'username), "Select All" is redundant. Filter it out to '
          'keep the menu compact. The user can double-tap to '
          'select the word instead.',
    },
    {
      'name': 'Add "Translate" for multilingual apps',
      'icon': Icons.translate,
      'color': Colors.cyan[600]!,
      'description': 'Detect the language of selected text and '
          'offer translation. The custom item label can be '
          'dynamic: "Translate to English" when Spanish text is '
          'selected, "Translate to Spanish" for English text.',
    },
    {
      'name': 'Code editor actions',
      'icon': Icons.code,
      'color': Colors.teal[800]!,
      'description': 'Code editors can add items like "Format '
          'Selection", "Extract Method", "Toggle Comment". Each '
          'is a custom ContextMenuButtonItem with an appropriate '
          'callback. This extends the standard text editing menu '
          'with IDE-style features.',
    },
  ];

  print('  Prepared ${realWorldPatterns.length} patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'It\'s a Data Class, Not a Widget',
      'body': 'ContextMenuButtonItem describes what a menu item '
          'IS (label, callback, type). The actual rendered '
          'widget is created by the context menu builder. Don\'t '
          'try to put ContextMenuButtonItem in a widget tree — '
          'it goes into a list that the builder consumes.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Null Label for Standard Types Only',
      'body': 'Omitting the label works for standard types '
          '(cut, copy, paste) because Flutter provides localized '
          'defaults. For custom type, a null label results in '
          'no visible text — always provide an explicit label '
          'for custom items.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Capture State in Closures',
      'body': 'The onPressed callback receives no arguments. '
          'To access the selected text, editing controller, or '
          'other state, capture it in the closure when creating '
          'the item. This is the standard Dart closure pattern.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'contextMenuButtonItems vs contextMenuBuilder',
      'body': 'contextMenuButtonItems provides the DATA (list of '
          'items). contextMenuBuilder provides the RENDERING '
          '(widget that displays items). Override '
          'contextMenuBuilder to get default items and build '
          'a custom menu widget around them.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Clipboard Permission on Web',
      'body': 'On web, Paste requires async Clipboard API '
          'permission. The paste item may be disabled initially '
          'until the browser grants access. This is a browser '
          'security requirement, not a Flutter limitation.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test All Platforms',
      'body': 'Context menus look very different on each platform. '
          'Android uses a floating toolbar, iOS uses a bubble, '
          'desktop uses a dropdown. Test your custom items on '
          'each target platform to ensure they fit visually.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('ContextMenuButtonItem'),
      backgroundColor: Colors.teal[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[700]!, Colors.cyan[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.menu, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ContextMenuButtonItem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A data class representing one button in a '
                  'context menu — the model behind Cut, Copy, '
                  'Paste, and custom actions in long-press and '
                  'right-click menus.',
                  style: TextStyle(
                    color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _ctxHead('1', 'What is ContextMenuButtonItem?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _ctxHead('2', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: prop['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(prop['icon'] as IconData,
                            color: prop['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Text(prop['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                fontSize: 13)),
                        SizedBox(width: 8),
                        _ctxPill(prop['type'] as String,
                            prop['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(prop['example'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.teal[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Standard Types ──
          _ctxHead('3', 'Standard Button Types'),
          SizedBox(height: 12),
          ...standardTypes.map((st) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: st['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(st['icon'] as IconData,
                            color: st['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(st['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        _ctxPill(st['keyboard'] as String,
                            Colors.grey[600]!),
                      ]),
                      SizedBox(height: 8),
                      Text(st['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Text(st['platforms'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic,
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Creation Patterns ──
          _ctxHead('4', 'Creating Items'),
          SizedBox(height: 12),
          ...creationPatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(cp['icon'] as IconData,
                            color: cp['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cp['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.green[300],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(cp['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Platform Differences ──
          _ctxHead('5', 'Platform Behavior'),
          SizedBox(height: 12),
          ...platformDiffs.map((pd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pd['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pd['icon'] as IconData,
                            color: pd['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(pd['platform'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Row(children: [
                        _ctxPill(pd['menuStyle'] as String,
                            pd['color'] as Color),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(pd['items'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(pd['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Widget Integration ──
          _ctxHead('6', 'Widget Integration'),
          SizedBox(height: 12),
          ...integrations.map((intg) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: intg['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(intg['icon'] as IconData,
                            color: intg['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(intg['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _ctxPill(intg['provides'] as String,
                            Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(intg['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Ordering ──
          _ctxHead('7', 'Ordering & Filtering'),
          SizedBox(height: 12),
          ...orderingRules.map((rule) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: rule['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(rule['icon'] as IconData,
                            color: rule['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(rule['rule'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Text(rule['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _ctxHead('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realWorldPatterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _ctxHead('9', 'Tips & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of ContextMenuButtonItem Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _ctxHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small rounded pill/badge
// ──────────────────────────────────────────────────────────
Widget _ctxPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
