// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ContextMenuButtonType
// Demonstrates ContextMenuButtonType — the enum that categorizes
// each button in a context menu. Determines default labels, icons,
// keyboard shortcuts, and ordering. Covers all six values, label
// resolution, localization, filtering, and platform behavior.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ContextMenuButtonType Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ContextMenuButtonType?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.category,
      'title': 'Semantic Classification',
      'body': 'ContextMenuButtonType is an enum that classifies '
          'each ContextMenuButtonItem. It tells the framework '
          'what kind of action the button represents — cut, '
          'copy, paste, selectAll, delete, or custom. The type '
          'drives default labels, ordering, and platform behavior.',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.label,
      'title': 'Label Resolution',
      'body': 'For standard types (cut, copy, paste, etc.), '
          'Flutter automatically provides platform-localized '
          'labels. You don\'t need to specify "Cut" or "Copier" — '
          'the type alone determines the correct string for '
          'the user\'s locale.',
      'accent': Colors.red[700]!,
    },
    {
      'icon': Icons.sort,
      'title': 'Ordering Control',
      'body': 'The type determines where the item appears in the '
          'menu. Standard types follow a predictable order: '
          'Cut → Copy → Paste → Select All → Delete. Custom '
          'items are placed after all standard items.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.add_circle,
      'title': 'Custom Extensibility',
      'body': 'The "custom" type is the escape hatch for any '
          'app-specific action. Unlike standard types, custom '
          'items MUST provide an explicit label. This is how '
          'you add "Translate", "Share", "Define", or any '
          'other action to context menus.',
      'accent': Colors.red[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: All Six Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'cut',
      'fullName': 'ContextMenuButtonType.cut',
      'icon': Icons.content_cut,
      'color': Colors.orange[800]!,
      'keyboard': 'Ctrl+X / Cmd+X',
      'defaultLabel': 'Cut (localized)',
      'description': 'Represents a Cut operation that removes '
          'selected content and places it on the clipboard. '
          'Only meaningful when content is selected and the '
          'field is editable.',
      'availability': 'Editable + has selection',
    },
    {
      'name': 'copy',
      'fullName': 'ContextMenuButtonType.copy',
      'icon': Icons.content_copy,
      'color': Colors.red[700]!,
      'keyboard': 'Ctrl+C / Cmd+C',
      'defaultLabel': 'Copy (localized)',
      'description': 'Represents a Copy operation that places '
          'selected content on the clipboard without removing '
          'it. Available whenever text is selected, regardless '
          'of whether the field is editable.',
      'availability': 'Has selection (any field)',
    },
    {
      'name': 'paste',
      'fullName': 'ContextMenuButtonType.paste',
      'icon': Icons.content_paste,
      'color': Colors.orange[700]!,
      'keyboard': 'Ctrl+V / Cmd+V',
      'defaultLabel': 'Paste (localized)',
      'description': 'Represents a Paste operation that inserts '
          'clipboard content at the cursor position. Replaces '
          'selected text if any exists. Only available when the '
          'field is editable and clipboard has content.',
      'availability': 'Editable + clipboard has content',
    },
    {
      'name': 'selectAll',
      'fullName': 'ContextMenuButtonType.selectAll',
      'icon': Icons.select_all,
      'color': Colors.red[600]!,
      'keyboard': 'Ctrl+A / Cmd+A',
      'defaultLabel': 'Select All (localized)',
      'description': 'Represents selecting all content in the '
          'field. Available when the field contains text that '
          'is not already fully selected. Some platforms hide '
          'this when all text is already selected.',
      'availability': 'Has text + not fully selected',
    },
    {
      'name': 'delete',
      'fullName': 'ContextMenuButtonType.delete',
      'icon': Icons.delete_outline,
      'color': Colors.orange[900]!,
      'keyboard': 'Del / Backspace',
      'defaultLabel': 'Delete (localized)',
      'description': 'Represents removing selected content without '
          'copying to clipboard. Unlike Cut, the content is '
          'discarded. Less common in context menus; some '
          'platforms omit it entirely from the menu.',
      'availability': 'Editable + has selection',
    },
    {
      'name': 'custom',
      'fullName': 'ContextMenuButtonType.custom',
      'icon': Icons.add_circle_outline,
      'color': Colors.red[800]!,
      'keyboard': 'App-defined',
      'defaultLabel': 'MUST provide explicit label',
      'description': 'Used for any app-specific action. There is '
          'no default label — you must provide one. The type '
          'signals to the framework that this is not a standard '
          'text editing operation and should be placed after '
          'standard items.',
      'availability': 'Always (developer-controlled)',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: Label Resolution Pipeline
  // ============================================================
  print('=== Section 3: Label Resolution ===');

  final labelPipeline = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Check explicit label',
      'icon': Icons.text_fields,
      'color': Colors.orange[800]!,
      'detail': 'If the ContextMenuButtonItem has a non-null label '
          'property, use it directly. This overrides any default. '
          'Custom types always use this path since they have no '
          'default label.',
    },
    {
      'step': 2,
      'label': 'Look up type default',
      'icon': Icons.search,
      'color': Colors.red[700]!,
      'detail': 'For standard types (cut, copy, etc.) with null '
          'label, look up the default string. The default depends '
          'on the current locale and platform.',
    },
    {
      'step': 3,
      'label': 'Apply localization',
      'icon': Icons.language,
      'color': Colors.orange[700]!,
      'detail': 'The MaterialLocalizations (or CupertinoLocalizations) '
          'provides the localized string. "Copy" in English becomes '
          '"Copier" in French, "Kopieren" in German, etc.',
    },
    {
      'step': 4,
      'label': 'Render in menu widget',
      'icon': Icons.widgets,
      'color': Colors.red[600]!,
      'detail': 'The context menu builder receives the resolved label '
          'and renders it as a Text widget inside the menu button. '
          'The builder can also add icons, spacing, or keyboard '
          'shortcut hints.',
    },
  ];

  print('  Prepared ${labelPipeline.length} pipeline steps');

  // ============================================================
  // SECTION 4: Type-Based Filtering
  // ============================================================
  print('=== Section 4: Filtering ===');

  final filterPatterns = <Map<String, dynamic>>[
    {
      'name': 'Remove Select All',
      'icon': Icons.filter_list,
      'color': Colors.orange[800]!,
      'code': 'items.removeWhere(\n'
          '  (i) => i.type ==\n'
          '    ContextMenuButtonType\n'
          '        .selectAll,\n'
          ')',
      'description': 'Remove Select All from small input fields '
          'where selecting all text is trivially done by '
          'double-tapping. Keeps the context menu compact.',
    },
    {
      'name': 'Keep only Copy',
      'icon': Icons.content_copy,
      'color': Colors.red[700]!,
      'code': 'items.retainWhere(\n'
          '  (i) => i.type ==\n'
          '    ContextMenuButtonType.copy,\n'
          ')',
      'description': 'For a read-only display where only copying '
          'makes sense. Strips Cut, Paste, Select All, and Delete. '
          'Results in a single-item context menu.',
    },
    {
      'name': 'Check if type exists',
      'icon': Icons.check,
      'color': Colors.orange[700]!,
      'code': 'final hasPaste =\n'
          '  items.any(\n'
          '    (i) => i.type ==\n'
          '      ContextMenuButtonType\n'
          '          .paste,\n'
          '  );',
      'description': 'Check before inserting to avoid duplicates. '
          'Useful when conditionally adding items based on what '
          'the default list already contains.',
    },
    {
      'name': 'Insert custom after Copy',
      'icon': Icons.add,
      'color': Colors.red[600]!,
      'code': 'final idx = items\n'
          '  .indexWhere(\n'
          '    (i) => i.type ==\n'
          '      ContextMenuButtonType\n'
          '          .copy,\n'
          '  );\n'
          'if (idx >= 0) {\n'
          '  items.insert(\n'
          '    idx + 1, customItem);\n'
          '}',
      'description': 'Insert a custom item immediately after Copy '
          'for a natural flow: Copy → Share. Use indexWhere with '
          'the type to find the insertion point.',
    },
  ];

  print('  Prepared ${filterPatterns.length} filter patterns');

  // ============================================================
  // SECTION 5: Default Items by Widget
  // ============================================================
  print('=== Section 5: Items by Widget ===');

  final widgetItems = <Map<String, dynamic>>[
    {
      'widget': 'TextField (empty, no selection)',
      'icon': Icons.text_fields,
      'color': Colors.orange[800]!,
      'items': 'Paste (if clipboard has content)',
      'description': 'With no selection and editable, only Paste '
          'is relevant. Cut and Copy need selection. Select All '
          'may appear if the field has text.',
    },
    {
      'widget': 'TextField (text selected)',
      'icon': Icons.text_fields,
      'color': Colors.red[700]!,
      'items': 'Cut, Copy, Paste, Select All',
      'description': 'Full menu. All standard operations available. '
          'The most common context menu scenario. Cut and Copy work '
          'on selection, Paste replaces selection.',
    },
    {
      'widget': 'TextField (read-only, selected)',
      'icon': Icons.lock_outline,
      'color': Colors.orange[700]!,
      'items': 'Copy, Select All',
      'description': 'No Cut or Paste since field is read-only. '
          'Copy works on the selection. Select All extends '
          'the selection to all content.',
    },
    {
      'widget': 'SelectableText (selected)',
      'icon': Icons.select_all,
      'color': Colors.red[600]!,
      'items': 'Copy, Select All',
      'description': 'SelectableText is inherently non-editable. '
          'Only Copy and Select All make sense. Same as a '
          'read-only TextField.',
    },
    {
      'widget': 'SelectionArea (multi-widget)',
      'icon': Icons.text_snippet,
      'color': Colors.orange[900]!,
      'items': 'Copy, Select All',
      'description': 'SelectionArea spans multiple widgets. The '
          'context menu provides Copy for the selected range '
          'and Select All for the entire selectable region.',
    },
  ];

  print('  Prepared ${widgetItems.length} widget items');

  // ============================================================
  // SECTION 6: Platform Ordering
  // ============================================================
  print('=== Section 6: Platform Ordering ===');

  final platformOrders = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'icon': Icons.android,
      'color': Colors.orange[800]!,
      'order': 'Cut → Copy → Paste → Select All → [custom]',
      'description': 'Android floating toolbar shows items left to '
          'right. Standard operations first, then custom items. '
          'Overflow items appear in a "More" section if the '
          'toolbar runs out of space.',
    },
    {
      'platform': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.red[700]!,
      'order': 'Cut → Copy → Paste → Select All → Look Up → [custom]',
      'description': 'iOS bubble menu scrolls horizontally. Items '
          'appear in standard Apple order. System items (Look Up, '
          'Share) may be injected by the system between standard '
          'and custom items.',
    },
    {
      'platform': 'macOS',
      'icon': Icons.desktop_mac,
      'color': Colors.orange[700]!,
      'order': 'Cut → Copy → Paste → Select All → [custom]',
      'description': 'macOS right-click menu is vertical. Each '
          'item shows the text label and keyboard shortcut. '
          'Custom items appear at the bottom separated by a '
          'visual divider.',
    },
    {
      'platform': 'Windows / Linux',
      'icon': Icons.desktop_windows,
      'color': Colors.red[600]!,
      'order': 'Cut → Copy → Paste → Delete → Select All → [custom]',
      'description': 'Windows/Linux may include Delete between '
          'Paste and Select All. This follows the native context '
          'menu convention on these platforms. Custom items '
          'are appended at the end.',
    },
  ];

  print('  Prepared ${platformOrders.length} platform orders');

  // ============================================================
  // SECTION 7: Comparison Table
  // ============================================================
  print('=== Section 7: Type Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Type',
      'cut': 'cut',
      'copy': 'copy',
      'paste': 'paste',
      'selAll': 'selectAll',
      'del': 'delete',
      'custom': 'custom',
    },
    {
      'aspect': 'Default label',
      'cut': 'Yes',
      'copy': 'Yes',
      'paste': 'Yes',
      'selAll': 'Yes',
      'del': 'Yes',
      'custom': 'No',
    },
    {
      'aspect': 'Localized',
      'cut': 'Yes',
      'copy': 'Yes',
      'paste': 'Yes',
      'selAll': 'Yes',
      'del': 'Yes',
      'custom': 'Manual',
    },
    {
      'aspect': 'Needs selection',
      'cut': 'Yes',
      'copy': 'Yes',
      'paste': 'No',
      'selAll': 'No',
      'del': 'Yes',
      'custom': 'Varies',
    },
    {
      'aspect': 'Needs editable',
      'cut': 'Yes',
      'copy': 'No',
      'paste': 'Yes',
      'selAll': 'No',
      'del': 'Yes',
      'custom': 'Varies',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'name': 'Messaging App: Forward',
      'icon': Icons.forward,
      'color': Colors.orange[800]!,
      'description': 'Add a custom "Forward" button to message '
          'bubbles. When text is selected in a received message, '
          'the user can forward it to another chat. Uses '
          'ContextMenuButtonType.custom with label "Forward".',
    },
    {
      'name': 'Note App: Format Text',
      'icon': Icons.format_bold,
      'color': Colors.red[700]!,
      'description': 'Add "Bold", "Italic", "Highlight" custom '
          'items. Each applies formatting to selected text. '
          'Multiple custom items can control the rich text '
          'editor directly from the context menu.',
    },
    {
      'name': 'Browser: Open Link',
      'icon': Icons.open_in_new,
      'color': Colors.orange[700]!,
      'description': 'Detect if selected text looks like a URL. '
          'If so, add "Open Link" as a custom item. The '
          'onPressed callback launches the URL in the browser. '
          'Shows dynamic custom items based on content.',
    },
    {
      'name': 'Code Editor: Comment Toggle',
      'icon': Icons.code,
      'color': Colors.red[600]!,
      'description': 'Add "Toggle Comment" for selected code lines. '
          'Also add "Indent" and "Unindent" custom items. '
          'IDE-style context menus that go beyond basic '
          'text editing operations.',
    },
    {
      'name': 'Photo App: Copy Image',
      'icon': Icons.image,
      'color': Colors.orange[900]!,
      'description': 'Override the default Copy behavior to copy '
          'the image to clipboard instead of text. Replace '
          'the standard copy item\'s onPressed with custom '
          'logic. Same type, different callback.',
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
      'title': 'Type Drives Default Label',
      'body': 'Setting type to ContextMenuButtonType.copy means '
          'the button automatically gets the localized "Copy" '
          'label. You don\'t need to specify label unless you '
          'want to override it (e.g., "Copy Reference" instead '
          'of just "Copy").',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Custom Type REQUIRES Label',
      'body': 'If type is custom and label is null, the button '
          'will have no visible text. Always provide an explicit '
          'label for custom items. This is the most common '
          'mistake when adding custom context menu actions.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Filter by Type, Not by Label',
      'body': 'When removing standard items, filter by type not '
          'by label string. Labels are localized and change '
          'with locale. Types are constants. '
          'removeWhere((i) => i.type == ...type.paste) works '
          'in all languages.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Same Type, Different Callback',
      'body': 'You can create an item with type copy but a custom '
          'onPressed. It still gets the "Copy" label and standard '
          'ordering, but does something different when tapped. '
          'Useful for intercepting standard actions.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Create Duplicate Types',
      'body': 'Having two items with type copy is confusing — the '
          'menu shows two "Copy" buttons. If you need multiple '
          'copy-like actions, make the second one custom with '
          'a distinct label like "Copy Link" or "Copy as HTML".',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Enum Values Are Exhaustive',
      'body': 'Switch statements on ContextMenuButtonType should '
          'handle all six cases. Dart analyzer will warn about '
          'missing cases. Using custom as the default case is '
          'acceptable for extensibility.',
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
      title: Text('ContextMenuButtonType'),
      backgroundColor: Colors.orange[800],
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
                colors: [Colors.orange[800]!, Colors.red[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.category, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ContextMenuButtonType',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An enum that classifies context menu buttons — '
                  'cut, copy, paste, selectAll, delete, or custom. '
                  'Determines default labels, localization, and '
                  'ordering within the menu.',
                  style: TextStyle(
                    color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _typHead('1', 'What is ContextMenuButtonType?'),
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

          // ── Section 2: Enum Values ──
          _typHead('2', 'All Six Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ev['color'] as Color, width: 5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ev['icon'] as IconData,
                            color: ev['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ev['fullName'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: ev['color'] as Color)),
                        ),
                        _typDot(ev['keyboard'] as String,
                            Colors.grey[600]!),
                      ]),
                      SizedBox(height: 8),
                      Text(ev['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Row(children: [
                        _typDot('Label: ${ev['defaultLabel']}',
                            ev['color'] as Color),
                        SizedBox(width: 6),
                        _typDot(ev['availability'] as String,
                            Colors.grey[500]!),
                      ]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Label Resolution ──
          _typHead('3', 'Label Resolution Pipeline'),
          SizedBox(height: 12),
          ...labelPipeline.map((lp) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: lp['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: lp['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${lp['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(lp['icon'] as IconData,
                                  color: lp['color'] as Color,
                                  size: 14),
                              SizedBox(width: 4),
                              Text(lp['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ]),
                            SizedBox(height: 3),
                            Text(lp['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Filtering ──
          _typHead('4', 'Type-Based Filtering'),
          SizedBox(height: 12),
          ...filterPatterns.map((fp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: fp['color'] as Color, width: 4)),
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
                        Icon(fp['icon'] as IconData,
                            color: fp['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(fp['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(fp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.orange[300],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(fp['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Items by Widget ──
          _typHead('5', 'Default Items by Widget'),
          SizedBox(height: 12),
          ...widgetItems.map((wi) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: wi['color'] as Color, width: 4)),
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
                        Icon(wi['icon'] as IconData,
                            color: wi['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(wi['widget'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      _typDot(wi['items'] as String,
                          wi['color'] as Color),
                      SizedBox(height: 4),
                      Text(wi['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Platform Ordering ──
          _typHead('6', 'Platform Ordering'),
          SizedBox(height: 12),
          ...platformOrders.map((po) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: po['color'] as Color, width: 4)),
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
                        Icon(po['icon'] as IconData,
                            color: po['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(po['platform'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (po['color'] as Color).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(po['order'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: po['color'] as Color)),
                      ),
                      SizedBox(height: 4),
                      Text(po['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _typHead('7', 'Type Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[800],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text('Aspect',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9))),
                        for (final h in [
                          'cut',
                          'copy',
                          'paste',
                          'selAll',
                          'del',
                          'custom'
                        ])
                          SizedBox(
                              width: 50,
                              child: Text(h,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8))),
                      ],
                    ),
                  ),
                  ...comparisonRows.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final row = entry.value;
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      color:
                          idx.isEven ? Colors.grey[50] : Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(row['aspect'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9))),
                          for (final k in [
                            'cut',
                            'copy',
                            'paste',
                            'selAll',
                            'del',
                            'custom'
                          ])
                            SizedBox(
                                width: 50,
                                child: Text(row[k] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.grey[700]))),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _typHead('8', 'Real-World Patterns'),
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
          _typHead('9', 'Tips & Gotchas'),
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
              'End of ContextMenuButtonType Deep Demo',
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
Widget _typHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[800],
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
// Helper: Small rounded dot/label
// ──────────────────────────────────────────────────────────
Widget _typDot(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
