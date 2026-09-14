// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ExcludeFocusTraversal
// Demonstrates ExcludeFocusTraversal — a widget that removes its
// descendant subtree from keyboard focus traversal (Tab/Shift+Tab)
// while still allowing programmatic focus via requestFocus().
// Contrast with ExcludeFocus which blocks ALL focus entirely.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExcludeFocusTraversal Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ExcludeFocusTraversal?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.tab_unselected,
      'title': 'Skip in Tab Order Only',
      'body': 'ExcludeFocusTraversal removes descendant widgets from '
          'the Tab/Shift+Tab keyboard focus traversal sequence, but '
          'crucially, those widgets can STILL receive focus via '
          'programmatic calls like FocusNode.requestFocus(). This '
          'is the key difference from ExcludeFocus, which blocks '
          'all focus entirely.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Tap Focus Still Works',
      'body': 'Widgets inside ExcludeFocusTraversal are still tappable '
          'and can receive focus from user taps. Only the sequential '
          'keyboard Tab traversal skips them. This makes it ideal '
          'for decorative elements or auxiliary controls that '
          'should not interrupt the main Tab flow.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'skipTraversal Under the Hood',
      'body': 'ExcludeFocusTraversal works by setting skipTraversal = '
          'true on the FocusNode of the focus scope it creates. The '
          'node still exists in the focus tree and can hold focus — '
          'it is simply invisible to the traversal algorithm that '
          'determines Tab order.',
      'accent': Colors.orange[600]!,
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Dynamic Toggling',
      'body': 'The excluding property can be toggled at run-time. Set '
          'excluding: true to remove from Tab order, false to restore. '
          'This enables patterns like temporarily removing a panel '
          'from Tab flow while an overlay is shown, then restoring '
          'when the overlay dismisses.',
      'accent': Colors.deepOrange[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: ExcludeFocusTraversal vs ExcludeFocus
  // ============================================================
  print('=== Section 2: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Widget',
      'traversal': 'ExcludeFocusTraversal',
      'focus': 'ExcludeFocus',
    },
    {
      'aspect': 'Tab/Shift+Tab',
      'traversal': 'Skipped — Tab jumps past descendants',
      'focus': 'Skipped — Tab jumps past descendants',
    },
    {
      'aspect': 'requestFocus()',
      'traversal': 'WORKS — can be focused programmatically',
      'focus': 'BLOCKED — requestFocus() is ignored',
    },
    {
      'aspect': 'Tap to focus',
      'traversal': 'WORKS — tapping focuses the widget',
      'focus': 'BLOCKED — tapping does not give focus',
    },
    {
      'aspect': 'Mechanism',
      'traversal': 'Sets skipTraversal = true on FocusNode',
      'focus': 'Sets canRequestFocus = false on FocusNode',
    },
    {
      'aspect': 'Use case',
      'traversal': 'Decorative elements, auxiliary panels, '
          'custom focus management',
      'focus': 'Disabled sections, modal backgrounds, '
          'completely inaccessible areas',
    },
    {
      'aspect': 'Focus tree',
      'traversal': 'Node stays in tree with focus capability',
      'focus': 'Node stays in tree but cannot hold focus',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 3: Properties
  // ============================================================
  print('=== Section 3: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'excluding',
      'type': 'bool',
      'icon': Icons.toggle_off,
      'color': Colors.orange[700]!,
      'description': 'When true, descendant widgets are removed from '
          'keyboard Tab traversal. When false, traversal proceeds '
          'normally. Defaults to true. Toggling this at runtime '
          'immediately updates the traversal order.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'icon': Icons.widgets,
      'color': Colors.deepOrange[700]!,
      'description': 'The widget subtree whose focusable descendants '
          'will be excluded from keyboard traversal. Can be any '
          'widget tree — buttons, text fields, entire form sections. '
          'All focusable descendants are affected.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 4: Focus Tree Visualization
  // ============================================================
  print('=== Section 4: Focus Tree ===');

  final treeNodes = <Map<String, dynamic>>[
    {'label': 'MaterialApp', 'depth': 0, 'skip': false, 'focusable': false},
    {'label': 'Scaffold', 'depth': 1, 'skip': false, 'focusable': false},
    {'label': 'Search Field', 'depth': 2, 'skip': false, 'focusable': true},
    {'label': 'Main Form', 'depth': 2, 'skip': false, 'focusable': false},
    {'label': 'Name Input', 'depth': 3, 'skip': false, 'focusable': true},
    {'label': 'Email Input', 'depth': 3, 'skip': false, 'focusable': true},
    {'label': 'ExcludeFocusTraversal', 'depth': 2, 'skip': true, 'focusable': false},
    {'label': 'Preview Button', 'depth': 3, 'skip': true, 'focusable': true},
    {'label': 'Info Icon', 'depth': 3, 'skip': true, 'focusable': true},
    {'label': 'Footer', 'depth': 2, 'skip': false, 'focusable': false},
    {'label': 'Submit Button', 'depth': 3, 'skip': false, 'focusable': true},
    {'label': 'Cancel Button', 'depth': 3, 'skip': false, 'focusable': true},
  ];

  print('  Prepared ${treeNodes.length} tree nodes');

  // ============================================================
  // SECTION 5: Tab Traversal Comparison
  // ============================================================
  print('=== Section 5: Tab Traversal ===');

  final normalTraversal = <Map<String, dynamic>>[
    {'label': 'Search', 'order': 1, 'skipped': false},
    {'label': 'Name', 'order': 2, 'skipped': false},
    {'label': 'Email', 'order': 3, 'skipped': false},
    {'label': 'Preview', 'order': 4, 'skipped': false},
    {'label': 'Info', 'order': 5, 'skipped': false},
    {'label': 'Submit', 'order': 6, 'skipped': false},
    {'label': 'Cancel', 'order': 7, 'skipped': false},
  ];

  final excludedTraversal = <Map<String, dynamic>>[
    {'label': 'Search', 'order': 1, 'skipped': false},
    {'label': 'Name', 'order': 2, 'skipped': false},
    {'label': 'Email', 'order': 3, 'skipped': false},
    {'label': 'Preview', 'order': null, 'skipped': true},
    {'label': 'Info', 'order': null, 'skipped': true},
    {'label': 'Submit', 'order': 4, 'skipped': false},
    {'label': 'Cancel', 'order': 5, 'skipped': false},
  ];

  print('  Prepared traversal comparisons');

  // ============================================================
  // SECTION 6: Use Cases
  // ============================================================
  print('=== Section 6: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Decorative / Informational Elements',
      'icon': Icons.info_outline,
      'color': Colors.orange[700]!,
      'description': 'Help icons, info badges, and decorative buttons '
          'that should not interrupt the main form Tab flow. Users '
          'can still tap them to see tooltips or trigger info panels, '
          'but Tab skips right past them.',
      'example': 'An icon button showing a tooltip — tappable for info '
          'but should not receive Tab focus during form entry.',
    },
    {
      'title': 'Auxiliary Toolbars',
      'icon': Icons.build,
      'color': Colors.deepOrange[700]!,
      'description': 'A secondary toolbar with utility actions (zoom, '
          'sort, filter) that is useful but should not break the '
          'primary content Tab flow. Users use mouse/touch to '
          'interact with it, not keyboard navigation.',
      'example': 'A formatting toolbar in a text editor — keyboard '
          'users Tab through the document, not the toolbar.',
    },
    {
      'title': 'Custom Focus Management',
      'icon': Icons.keyboard,
      'color': Colors.orange[600]!,
      'description': 'When you handle focus programmatically (e.g., '
          'moving focus on arrow keys, on selection change, or on '
          'completion), exclude widgets from Tab traversal but '
          'focus them via code when needed.',
      'example': 'A grid where arrow keys move focus — items excluded '
          'from Tab but receive focus via custom arrow handler.',
    },
    {
      'title': 'Preview Panels',
      'icon': Icons.preview,
      'color': Colors.deepOrange[600]!,
      'description': 'A live preview panel showing a document or widget '
          'rendering. The preview may contain focusable elements '
          '(links, buttons) that should not participate in the '
          'editor Tab flow. Users interact with preview via mouse.',
      'example': 'Markdown editor with live preview — preview links '
          'excluded from Tab, editor fields in Tab order.',
    },
    {
      'title': 'Media Player Controls',
      'icon': Icons.play_circle,
      'color': Colors.orange[700]!,
      'description': 'Video or audio player controls embedded in a '
          'content page. The play/pause/seek buttons should be '
          'operable by tap or dedicated shortcuts but should not '
          'interrupt the content reading Tab order.',
      'example': 'Embedded video player — controls tappable but Tab '
          'goes through the article text, not the player.',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Usage',
      'color': Colors.orange[700]!,
      'code': '// Skip decorative icon buttons in Tab\n'
          'Row(\n'
          '  children: [\n'
          '    Expanded(\n'
          '      child: TextField(\n'
          '        decoration: InputDecoration(\n'
          '          labelText: \'Search\',\n'
          '        ),\n'
          '      ),\n'
          '    ),\n'
          '    // This icon is tappable but\n'
          '    // skipped by Tab key\n'
          '    ExcludeFocusTraversal(\n'
          '      child: IconButton(\n'
          '        icon: Icon(Icons.info),\n'
          '        onPressed: _showInfo,\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
    },
    {
      'title': 'Dynamic Excluding',
      'color': Colors.deepOrange[700]!,
      'code': '// Toggle based on state\n'
          'ExcludeFocusTraversal(\n'
          '  excluding: _isPreviewMode,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TextField(\n'
          '        decoration: InputDecoration(\n'
          '          labelText: \'Title\',\n'
          '        ),\n'
          '      ),\n'
          '      TextField(\n'
          '        decoration: InputDecoration(\n'
          '          labelText: \'Body\',\n'
          '        ),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')\n'
          '\n'
          '// In preview mode: Tab skips fields\n'
          '// In edit mode: Tab visits fields',
    },
    {
      'title': 'Programmatic Focus with Excluded Traversal',
      'color': Colors.orange[600]!,
      'code': '// Excluded from Tab, but focused by code\n'
          'final _previewFocus = FocusNode();\n'
          '\n'
          'ExcludeFocusTraversal(\n'
          '  child: Focus(\n'
          '    focusNode: _previewFocus,\n'
          '    child: GestureDetector(\n'
          '      onTap: () {\n'
          '        // This WORKS because\n'
          '        // ExcludeFocusTraversal\n'
          '        // only skips traversal,\n'
          '        // not programmatic focus\n'
          '        _previewFocus.requestFocus();\n'
          '      },\n'
          '      child: _buildPreview(),\n'
          '    ),\n'
          '  ),\n'
          ')\n'
          '\n'
          '// Compare: ExcludeFocus would block\n'
          '// requestFocus() entirely',
    },
    {
      'title': 'Toolbar Exclusion Pattern',
      'color': Colors.deepOrange[600]!,
      'code': '// Full toolbar excluded from Tab\n'
          'Column(\n'
          '  children: [\n'
          '    // Toolbar: mouse/touch only\n'
          '    ExcludeFocusTraversal(\n'
          '      child: Row(\n'
          '        children: [\n'
          '          IconButton(\n'
          '            icon: Icon(Icons.format_bold),\n'
          '            onPressed: _toggleBold,\n'
          '          ),\n'
          '          IconButton(\n'
          '            icon: Icon(Icons.format_italic),\n'
          '            onPressed: _toggleItalic,\n'
          '          ),\n'
          '        ],\n'
          '      ),\n'
          '    ),\n'
          '    // Editor: in Tab order\n'
          '    TextField(maxLines: 20),\n'
          '  ],\n'
          ')',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: How It Works Under the Hood
  // ============================================================
  print('=== Section 8: Under the Hood ===');

  final mechanismSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'FocusScopeNode Created',
      'color': Colors.orange[700]!,
      'detail': 'ExcludeFocusTraversal creates a FocusScopeNode in '
          'the focus tree. This scope node wraps all descendant '
          'focusable nodes and acts as a grouping boundary.',
    },
    {
      'step': 2,
      'title': 'skipTraversal Set to True',
      'color': Colors.deepOrange[700]!,
      'detail': 'When excluding is true, the scope node\'s '
          'skipTraversal property is set to true. This flag tells '
          'the FocusTraversalPolicy to ignore this scope and all '
          'its children during traversal computation.',
    },
    {
      'step': 3,
      'title': 'Tab Key Pressed',
      'color': Colors.orange[600]!,
      'detail': 'When the user presses Tab, the active '
          'FocusTraversalPolicy iterates through focusable nodes. '
          'It queries each node\'s skipTraversal flag. Nodes with '
          'skipTraversal = true are simply omitted from the '
          'sorted traversal list.',
    },
    {
      'step': 4,
      'title': 'Focus Skips to Next Non-Excluded',
      'color': Colors.deepOrange[600]!,
      'detail': 'The traversal algorithm jumps from the last '
          'non-excluded node before the scope directly to the first '
          'non-excluded node after the scope. The excluded nodes '
          'are invisible to the Tab sequence.',
    },
    {
      'step': 5,
      'title': 'requestFocus() Still Works',
      'color': Colors.orange[500]!,
      'detail': 'Unlike ExcludeFocus (canRequestFocus = false), the '
          'nodes still have canRequestFocus = true. Calling '
          'requestFocus() on any node inside the scope succeeds. '
          'The node receives focus and can respond to key events.',
    },
  ];

  print('  Prepared ${mechanismSteps.length} mechanism steps');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Choose ExcludeFocusTraversal for Auxiliary UI',
      'body': 'Use ExcludeFocusTraversal when widgets should be '
          'interactive (tappable, programmable) but should not '
          'interrupt keyboard Tab flow. This is the right choice '
          'for toolbars, action icons, and secondary controls.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Users Can Still Tap Into Excluded Fields',
      'body': 'ExcludeFocusTraversal does NOT prevent focus on tap. '
          'If you need to prevent ALL focus, use ExcludeFocus instead. '
          'If you also need to block taps, add IgnorePointer. The '
          'widget only affects Tab-key sequential navigation.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Accessibility: Use with ARIA Equivalents in Mind',
      'body': 'In web accessibility, this is like tabindex="-1" — the '
          'element is focusable by script but not by Tab. Apply this '
          'pattern to elements that have programmatic focus roles but '
          'should not appear in the sequential Tab/reading order.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Does Not Hide from Screen Readers',
      'body': 'ExcludeFocusTraversal only affects keyboard Tab '
          'traversal. Screen reader users using other navigation '
          'modes (e.g., swiping on mobile, virtual cursor) may still '
          'encounter these widgets. Use Semantics(excludeSemantics: '
          'true) if you need to hide from assistive technology.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Nesting: Parent Wins',
      'body': 'An ExcludeFocusTraversal(excluding: false) nested inside '
          'an ExcludeFocusTraversal(excluding: true) does NOT re-enable '
          'traversal. The outer exclusion takes precedence. Plan your '
          'focus scopes carefully in deeply nested layouts.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pair with FocusTraversalGroup',
      'body': 'Use FocusTraversalGroup to define a custom Tab order '
          'within a section, then ExcludeFocusTraversal to remove '
          'that entire section from the parent Tab flow. This gives '
          'fine-grained control over complex layouts.',
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
      title: Text('ExcludeFocusTraversal'),
      backgroundColor: Colors.orange[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[700]!, Colors.deepOrange[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tab_unselected, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ExcludeFocusTraversal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Removes descendants from keyboard Tab traversal while '
                  'preserving programmatic focus and tap focus. Unlike '
                  'ExcludeFocus, widgets remain fully focusable — they '
                  'are just invisible to the Tab key sequence.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _etHead('1', 'What is ExcludeFocusTraversal?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Comparison ──
          _etHead('2', 'ExcludeFocusTraversal vs ExcludeFocus'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 68,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('ExcludeFocusTraversal',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('ExcludeFocus',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 68,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(r['traversal'] as String,
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.orange[700])),
                      )),
                      Expanded(
                          child: Text(r['focus'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 3: Properties ──
          _etHead('3', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
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
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _etTag(p['type'] as String, p['color'] as Color),
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

          // ── Section 4: Focus Tree ──
          _etHead('4', 'Focus Tree Visualization'),
          SizedBox(height: 8),
          Text(
            'Orange nodes are excluded from Tab traversal but can '
            'still receive focus via tap or requestFocus().',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                Text('Widget Focus Tree',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[800])),
                SizedBox(height: 10),
                ...treeNodes.map((node) {
                  final depth = node['depth'] as int;
                  final skip = node['skip'] as bool;
                  final focusable = node['focusable'] as bool;
                  final indent = depth * 20.0;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 3, left: indent),
                    child: Row(children: [
                      if (depth > 0)
                        Text(depth == 1
                                ? '├─ '
                                : depth == 2
                                    ? '│  ├─ '
                                    : '│  │  ├─ ',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.grey[400])),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: skip
                              ? Colors.orange[50]
                              : focusable
                                  ? Colors.green[50]
                                  : Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: skip
                                ? Colors.orange[400]!
                                : focusable
                                    ? Colors.green[400]!
                                    : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(node['label'] as String,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: skip
                                        ? Colors.orange[800]
                                        : Colors.grey[800])),
                            if (focusable && !skip) ...[
                              SizedBox(width: 4),
                              Icon(Icons.keyboard,
                                  size: 8,
                                  color: Colors.green[600]),
                            ],
                            if (skip && focusable) ...[
                              SizedBox(width: 4),
                              Icon(Icons.tab_unselected,
                                  size: 8,
                                  color: Colors.orange[600]),
                            ],
                            if (skip && !focusable) ...[
                              SizedBox(width: 4),
                              Icon(Icons.swipe_right_alt,
                                  size: 8,
                                  color: Colors.orange[400]),
                            ],
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
                SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.keyboard, size: 10, color: Colors.green[600]),
                  SizedBox(width: 4),
                  Text('In Tab order',
                      style: TextStyle(fontSize: 8, color: Colors.grey[600])),
                  SizedBox(width: 12),
                  Icon(Icons.tab_unselected,
                      size: 10, color: Colors.orange[600]),
                  SizedBox(width: 4),
                  Text('Skipped in Tab (still focusable)',
                      style: TextStyle(fontSize: 8, color: Colors.grey[600])),
                ]),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 5: Tab Traversal Comparison ──
          _etHead('5', 'Tab Traversal Order'),
          SizedBox(height: 12),
          // Without exclusion
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Without ExcludeFocusTraversal',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.green[700])),
                SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: normalTraversal.map((t) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.green[400]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green[700],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('${t['order']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(t['label'] as String,
                              style: TextStyle(fontSize: 9)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 6),
                Text('Tab: 1→2→3→4→5→6→7 (all 7 fields)',
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: Colors.grey[600])),
              ],
            ),
          ),
          SizedBox(height: 10),
          // With exclusion
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('With ExcludeFocusTraversal (Preview + Info)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.orange[700])),
                SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: excludedTraversal.map((t) {
                    final skipped = t['skipped'] as bool;
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: skipped
                            ? Colors.orange[50]
                            : Colors.green[50],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: skipped
                                ? Colors.orange[300]!
                                : Colors.green[400]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!skipped)
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text('${t['order']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          else
                            Icon(Icons.tab_unselected,
                                size: 14, color: Colors.orange[500]),
                          SizedBox(width: 4),
                          Text(t['label'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: skipped
                                      ? Colors.orange[600]
                                      : Colors.grey[800])),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 6),
                Text('Tab: 1→2→3→[skip]→[skip]→4→5 (5 fields)',
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: Colors.grey[600])),
                SizedBox(height: 4),
                Text(
                    'But Preview & Info can still be focused by tap or code!',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700])),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 6: Use Cases ──
          _etHead('6', 'When to Use ExcludeFocusTraversal'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
                    ),
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
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(uc['example'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.orange[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _etHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
                    ),
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
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.orange[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Under the Hood ──
          _etHead('8', 'How It Works Under the Hood'),
          SizedBox(height: 12),
          ...mechanismSteps.map((ms) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ms['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
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
                          color: ms['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ms['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ms['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(ms['detail'] as String,
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

          // ── Section 9: Tips ──
          _etHead('9', 'Tips & Best Practices'),
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
          Center(
            child: Text(
              'End of ExcludeFocusTraversal Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _etHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[700],
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
// Helper: Type tag
// ──────────────────────────────────────────────────────────
Widget _etTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
