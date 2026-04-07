// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TextFieldTapRegion
// Demonstrates TextFieldTapRegion, a convenience widget that extends
// TapRegion specifically for text-field interactions. It keeps all
// sibling TextFieldTapRegion widgets in the same implicit group,
// so tapping one text field does not unfocus another — only taps
// truly outside all text fields fire the outside callback.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextFieldTapRegion Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'What is TextFieldTapRegion?',
      'body': 'TextFieldTapRegion is a subclass of TapRegion that provides '
          'a shared implicit groupId for all text-field-related widgets. '
          'When you wrap a TextField in TextFieldTapRegion, it joins an '
          'automatic group. Tapping between fields does not trigger '
          'onTapOutside for any of them.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.link,
      'title': 'Automatic Grouping',
      'body': 'All TextFieldTapRegion instances share the same groupId '
          'under the hood: TextFieldTapRegion.groupId (a static const). '
          'This means all TextFields wrapped in TextFieldTapRegion are '
          'considered "inside" each other\'s region for tap detection.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.lightbulb,
      'title': 'Why Not Just TapRegion?',
      'body': 'Plain TapRegion requires manual groupId management. On a '
          'form with 10 fields, you would need the same groupId on all '
          'of them. TextFieldTapRegion solves this automatically — every '
          'text field is in the same group by default.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.code,
      'title': 'Built Into TextField',
      'body': 'Flutter\'s TextField already wraps its content with '
          'TextFieldTapRegion internally. This demo explores the widget '
          'in isolation — useful when building custom text inputs or '
          'adding non-field content to the text-field group.',
      'accent': Colors.purple,
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'child',
      'type': 'Widget?',
      'desc': 'The text input widget (or any widget) to include in the '
          'text-field tap group. Typically a custom text input or '
          'helper content that should be grouped with text fields.',
    },
    {
      'name': 'onTapOutside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when tapping outside ALL TextFieldTapRegion widgets. '
          'The implicit grouping means this only fires when the tap is '
          'outside every text field on screen.',
    },
    {
      'name': 'onTapInside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when tapping inside THIS specific region (not the '
          'group). Useful for focus management or analytics.',
    },
    {
      'name': 'consumeOutsideTaps',
      'type': 'bool',
      'desc': 'Inherited from TapRegion. When true, outside taps are '
          'consumed and not delivered to other widgets.',
    },
    {
      'name': 'enabled',
      'type': 'bool',
      'desc': 'Inherited from TapRegion. When false, the widget unregisters '
          'from the surface and callbacks are inactive.',
    },
    {
      'name': 'behavior',
      'type': 'HitTestBehavior?',
      'desc': 'Inherited from TapRegion. Controls how the region bounds '
          'interact with hit testing — deferToChild vs opaque.',
    },
    {
      'name': 'groupId (static)',
      'type': 'Object',
      'desc': 'A static constant that acts as the shared group identifier. '
          'Overriding groupId is not exposed — all TextFieldTapRegion '
          'widgets unconditionally share this one group.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.cyan.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.2)),
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
                    color: Colors.cyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
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
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
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
  // SECTION 3: Basic Forms
  // ============================================================
  print('=== Section 3: Basic Forms ===');

  final formExamples = <Map<String, dynamic>>[
    {
      'title': 'Single TextField',
      'desc': 'A single TextField already uses TextFieldTapRegion internally. '
          'Tapping outside the field triggers onTapOutside, which Flutter '
          'uses to unfocus the field by default.',
      'code': 'TextField(\n'
          '  decoration: InputDecoration(\n'
          '    labelText: "Email",\n'
          '    border: OutlineInputBorder(),\n'
          '  ),\n'
          ')',
      'color': Colors.cyan,
    },
    {
      'title': 'Multi-Field Form',
      'desc': 'With multiple TextFields, tapping from one to another does '
          'NOT fire onTapOutside because both are in the same group. '
          'Only tapping truly outside all fields unfocuses.',
      'code': 'Column(\n'
          '  children: [\n'
          '    TextField(decoration: ...),  // Group A\n'
          '    SizedBox(height: 16),\n'
          '    TextField(decoration: ...),  // Group A\n'
          '    SizedBox(height: 16),\n'
          '    TextField(decoration: ...),  // Group A\n'
          '  ],\n'
          ')',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Custom Input in Group',
      'desc': 'Wrap a custom widget in TextFieldTapRegion to add it to '
          'the shared text-field group. Now tapping the button is '
          'considered "inside" and does not unfocus fields.',
      'code': 'TextFieldTapRegion(\n'
          '  child: ElevatedButton(\n'
          '    onPressed: () => insertEmoji(),\n'
          '    child: Text("Insert Emoji"),\n'
          '  ),\n'
          ')',
      'color': Colors.green,
    },
  ];

  final formWidgets = <Widget>[];
  for (var i = 0; i < formExamples.length; i++) {
    final fe = formExamples[i];
    final feColor = fe['color'] as Color;
    print('Form ${i + 1}: ${fe['title']}');
    formWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: feColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: feColor.withOpacity(0.2)),
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
                      color: feColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: feColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fe['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: feColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                fe['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: feColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  fe['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: feColor,
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
  // SECTION 4: Focus Behavior
  // ============================================================
  print('=== Section 4: Focus ===');

  final focusItems = <Map<String, dynamic>>[
    {
      'title': 'Default Focus Management',
      'desc': 'When a TextField receives an onTapOutside event, it calls '
          'FocusNode.unfocus(). This is the built-in behavior. The '
          'TextFieldTapRegion grouping ensures this only happens when '
          'tapping outside ALL text fields.',
      'icon': Icons.center_focus_weak,
      'color': Colors.cyan,
    },
    {
      'title': 'Focus Stays Between Fields',
      'desc': 'Tapping from "Email" to "Password" moves focus without '
          'any onTapOutside event. The group treats both fields as '
          'a single region. Focus transfer is smooth and uninterrupted.',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
    },
    {
      'title': 'Custom onTapOutside on TextField',
      'desc': 'TextField accepts its own onTapOutside callback. This fires '
          'only when tapping outside the entire group. Override it to '
          'prevent default unfocus or add custom behavior.',
      'icon': Icons.edit,
      'color': Colors.green,
    },
    {
      'title': 'Preventing Unfocus',
      'desc': 'Pass an empty callback to onTapOutside on the TextField to '
          'prevent automatic unfocus. The field stays focused even when '
          'tapping elsewhere, which can be useful for search bars.',
      'icon': Icons.lock,
      'color': Colors.orange,
    },
  ];

  final focusWidgets = <Widget>[];
  for (var i = 0; i < focusItems.length; i++) {
    final fi = focusItems[i];
    final fiColor = fi['color'] as Color;
    print('Focus ${i + 1}: ${fi['title']}');
    focusWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [fiColor.withOpacity(0.08), fiColor.withOpacity(0.02)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fiColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: fiColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  fi['icon'] as IconData,
                  color: fiColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fi['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: fiColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      fi['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 5: Custom Inputs
  // ============================================================
  print('=== Section 5: Custom ===');

  final customExamples = <Map<String, dynamic>>[
    {
      'title': 'Emoji Toolbar in Text-Field Group',
      'desc': 'An emoji picker bar should not unfocus the text field. Wrap '
          'the toolbar in TextFieldTapRegion so tapping an emoji button '
          'is considered "inside" the text-field group.',
      'code': 'Row(\n'
          '  children: [\n'
          '    Expanded(\n'
          '      child: TextField(controller: ctrl),\n'
          '    ),\n'
          '    TextFieldTapRegion(\n'
          '      child: Row(\n'
          '        children: emojis.map((e) =>\n'
          '          IconButton(\n'
          '            icon: Text(e, style: TextStyle(fontSize: 20)),\n'
          '            onPressed: () => ctrl.text += e,\n'
          '          ),\n'
          '        ).toList(),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.cyan,
    },
    {
      'title': 'Formatting Toolbar',
      'desc': 'Bold/italic/underline buttons next to a rich text editor. '
          'TextFieldTapRegion keeps the text field focused when the '
          'user toggles formatting.',
      'code': 'Column(\n'
          '  children: [\n'
          '    TextFieldTapRegion(\n'
          '      child: Row(\n'
          '        children: [\n'
          '          IconButton(icon: Icon(Icons.format_bold), ...),\n'
          '          IconButton(icon: Icon(Icons.format_italic), ...),\n'
          '          IconButton(icon: Icon(Icons.format_underline), ...),\n'
          '        ],\n'
          '      ),\n'
          '    ),\n'
          '    TextField(maxLines: 8, controller: richCtrl),\n'
          '  ],\n'
          ')',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Suggestion Chip Bar',
      'desc': 'Autocomplete chips displayed below a search input. Tapping '
          'a chip should insert text, not unfocus the search. Wrapping '
          'the chip bar in TextFieldTapRegion handles this.',
      'code': 'Column(\n'
          '  children: [\n'
          '    TextField(decoration: searchDecoration),\n'
          '    TextFieldTapRegion(\n'
          '      child: Wrap(\n'
          '        children: suggestions.map((s) =>\n'
          '          ActionChip(\n'
          '            label: Text(s),\n'
          '            onPressed: () => searchCtrl.text = s,\n'
          '          ),\n'
          '        ).toList(),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.green,
    },
  ];

  final customWidgets = <Widget>[];
  for (var i = 0; i < customExamples.length; i++) {
    final ce = customExamples[i];
    final ceColor = ce['color'] as Color;
    print('Custom ${i + 1}: ${ce['title']}');
    customWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ceColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ceColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ce['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ceColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ce['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ceColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ce['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: ceColor,
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
  // SECTION 6: TapRegion vs TextFieldTapRegion
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Group ID',
      'tapRegion': 'Manual — you provide any Object',
      'textField': 'Automatic — shared static const',
      'color': Colors.cyan,
    },
    {
      'aspect': 'Default Grouping',
      'tapRegion': 'Ungrouped (each is independent)',
      'textField': 'All instances are in one group',
      'color': Colors.deepOrange,
    },
    {
      'aspect': 'Typical Use',
      'tapRegion': 'Menus, dropdowns, tooltips',
      'textField': 'Form fields, text editors',
      'color': Colors.green,
    },
    {
      'aspect': 'consumeOutsideTaps',
      'tapRegion': 'Supported',
      'textField': 'Supported (inherited)',
      'color': Colors.blue,
    },
    {
      'aspect': 'Custom groupId',
      'tapRegion': 'Yes — any value',
      'textField': 'No — always the shared group',
      'color': Colors.purple,
    },
    {
      'aspect': 'Built into Flutter',
      'tapRegion': 'Used in various widget internals',
      'textField': 'Used inside TextField & CupertinoTextField',
      'color': Colors.orange,
    },
  ];

  final comparisonWidgets = <Widget>[];
  for (var i = 0; i < comparisonRows.length; i++) {
    final cr = comparisonRows[i];
    final crColor = cr['color'] as Color;
    print('Compare ${i + 1}: ${cr['aspect']}');
    comparisonWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: crColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: crColor.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: crColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cr['aspect'] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: crColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TapRegion',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cr['tapRegion'] as String,
                          style: const TextStyle(fontSize: 11, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TextFieldTapRegion',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cr['textField'] as String,
                          style: const TextStyle(fontSize: 11, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Edge Cases
  // ============================================================
  print('=== Section 7: Edge Cases ===');

  final edgeCaseItems = <Map<String, dynamic>>[
    {
      'title': 'Overlays and Text Fields',
      'desc': 'Overlay entries like autocomplete dropdowns are NOT '
          'automatically in the TextFieldTapRegion group. You must '
          'wrap overlay content in TextFieldTapRegion explicitly, '
          'or tapping the dropdown will unfocus the text field.',
      'severity': 'Common Mistake',
      'color': Colors.red,
    },
    {
      'title': 'No TapRegionSurface',
      'desc': 'TextFieldTapRegion (like TapRegion) requires a '
          'TapRegionSurface ancestor. MaterialApp includes one '
          'via WidgetsApp. Without it, callbacks never fire.',
      'severity': 'Prerequisite',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Mixed Groups',
      'desc': 'Wrapping a menu trigger in TextFieldTapRegion joins it '
          'to the text-field group. If you want a separate group for '
          'the menu, use plain TapRegion with a custom groupId.',
      'severity': 'Design Choice',
      'color': Colors.blue,
    },
    {
      'title': 'Disabled State',
      'desc': 'When enabled=false, the widget no longer participates in '
          'the group. Other text fields still form a group, but this '
          'one is excluded. Tapping on it IS "outside" the group.',
      'severity': 'Gotcha',
      'color': Colors.orange,
    },
    {
      'title': 'Hot Reload Stability',
      'desc': 'TapRegionSurface tracks registered regions via '
          'RenderObject tree. Hot reload preserves these registrations, '
          'but keys changing can cause re-registration. Groups may '
          'briefly become empty during hot reload.',
      'severity': 'Debug Note',
      'color': Colors.purple,
    },
  ];

  final edgeCaseWidgets = <Widget>[];
  for (var i = 0; i < edgeCaseItems.length; i++) {
    final ec = edgeCaseItems[i];
    final ecColor = ec['color'] as Color;
    print('Edge ${i + 1}: ${ec['title']}');
    edgeCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ecColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ecColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ec['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ecColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: ecColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ec['severity'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: ecColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ec['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
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
      'icon': Icons.text_fields,
      'text': 'TextFieldTapRegion extends TapRegion with an implicit '
          'shared groupId for all text fields.',
    },
    {
      'icon': Icons.link,
      'text': 'All TextFieldTapRegion instances are automatically in the '
          'same group — no manual groupId needed.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'Tapping between text fields does not trigger onTapOutside; '
          'only taps outside ALL fields fire it.',
    },
    {
      'icon': Icons.code,
      'text': 'TextField and CupertinoTextField use TextFieldTapRegion '
          'internally — it powers the tap-to-unfocus behavior.',
    },
    {
      'icon': Icons.extension,
      'text': 'Wrap non-field widgets (toolbars, chips) in '
          'TextFieldTapRegion to include them in the group.',
    },
    {
      'icon': Icons.layers,
      'text': 'Overlay entries (autocomplete, suggestions) must be '
          'wrapped explicitly — they are NOT auto-grouped.',
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
          color: Colors.cyan.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.cyan,
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
        title: const Text('TextFieldTapRegion'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.text_fields), text: 'Forms'),
            Tab(icon: Icon(Icons.center_focus_weak), text: 'Focus'),
            Tab(icon: Icon(Icons.extension), text: 'Custom'),
            Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
            Tab(icon: Icon(Icons.warning_amber), text: 'Edge Cases'),
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextFieldTapRegion: automatic grouping for text-field '
                  'tap regions so inter-field taps stay "inside".',
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextFieldTapRegion properties (inherits from TapRegion).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Forms
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How TextFieldTapRegion works with forms and inputs.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...formWidgets,
            ],
          ),

          // Tab 4: Focus
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Focus management behavior with TextFieldTapRegion.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...focusWidgets,
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Adding non-field widgets to the text-field group.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...customWidgets,
            ],
          ),

          // Tab 6: Compare
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TapRegion vs TextFieldTapRegion: side-by-side.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...comparisonWidgets,
            ],
          ),

          // Tab 7: Edge Cases
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Gotchas and edge cases to watch for.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...edgeCaseWidgets,
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
                      Colors.cyan.withOpacity(0.12),
                      Colors.teal.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TextFieldTapRegion.',
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
