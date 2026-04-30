// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ExcludeFocus
// Demonstrates ExcludeFocus — a widget that conditionally excludes
// its descendant widgets from the focus traversal order. When
// excluding is true, Tab / Shift-Tab skip the entire subtree.
// Useful for hiding disabled forms, modal backgrounds, and
// off-screen content from keyboard focus.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExcludeFocus Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ExcludeFocus?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.block,
      'title': 'Remove Subtrees from Focus',
      'body': 'ExcludeFocus wraps a subtree and, when its excluding '
          'property is true, prevents every focusable descendant '
          'from receiving focus via keyboard traversal. The widgets '
          'still exist in the tree — they are just invisible to the '
          'focus system. This is different from removing them or '
          'making them disabled.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.keyboard_tab,
      'title': 'Tab Key Skips Over',
      'body': 'When a user presses Tab to move focus through a form, '
          'fields inside an active ExcludeFocus are skipped entirely. '
          'Focus moves directly from the last focusable before the '
          'excluded subtree to the first focusable after it.',
      'accent': Colors.lime[800]!,
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Dynamically Toggleable',
      'body': 'The excluding property can change at run-time. Set it '
          'to true when a section is disabled or hidden; set it back '
          'to false to restore focus. This makes it ideal for forms '
          'with conditionally visible sections, tabbed views, and '
          'modal overlays.',
      'accent': Colors.green[600]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Works at Any Depth',
      'body': 'ExcludeFocus affects its entire descendant subtree, '
          'no matter how deeply nested. If a subtree contains '
          'Rows, Columns, custom widgets, and deeply nested '
          'TextFields — all of them are excluded. No need to '
          'individually disable each one.',
      'accent': Colors.lime[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: ExcludeFocus vs ExcludeFocusTraversal
  // ============================================================
  print('=== Section 2: ExcludeFocus vs ExcludeFocusTraversal ===');

  final vsRows = <Map<String, dynamic>>[
    {
      'aspect': 'Widget',
      'excludeFocus': 'ExcludeFocus',
      'excludeTraversal': 'ExcludeFocusTraversal',
    },
    {
      'aspect': 'What it does',
      'excludeFocus': 'Removes descendants from '
          'focus entirely — cannot be focused by Tab OR programmatically',
      'excludeTraversal': 'Removes descendants from '
          'traversal order — Tab skips them, but requestFocus() works',
    },
    {
      'aspect': 'Programmatic focus',
      'excludeFocus': 'Blocked — FocusNode.requestFocus() '
          'has no effect while excluded',
      'excludeTraversal': 'Allowed — can still be focused via '
          'FocusNode.requestFocus() or FocusScope.of()',
    },
    {
      'aspect': 'Typical use',
      'excludeFocus': 'Completely disabled sections, '
          'background content behind modals',
      'excludeTraversal': 'Skip decorative elements in Tab order '
          'while keeping them programmatically focusable',
    },
    {
      'aspect': 'Key property',
      'excludeFocus': 'excluding (bool)',
      'excludeTraversal': 'excluding (bool)',
    },
    {
      'aspect': 'Underneath',
      'excludeFocus': 'Sets FocusNode.canRequestFocus = false '
          'on the scope node',
      'excludeTraversal': 'Sets FocusNode.skipTraversal = true '
          'on the scope node',
    },
  ];

  print('  Prepared ${vsRows.length} comparison rows');

  // ============================================================
  // SECTION 3: Focus Tree Visualization
  // ============================================================
  print('=== Section 3: Focus Tree ===');

  // Simulated focus tree nodes
  final treeNodes = <Map<String, dynamic>>[
    {'label': 'App Root', 'depth': 0, 'excluded': false, 'focusable': false},
    {'label': 'Header Bar', 'depth': 1, 'excluded': false, 'focusable': false},
    {'label': 'Search Field', 'depth': 2, 'excluded': false, 'focusable': true},
    {'label': 'Main Content', 'depth': 1, 'excluded': false, 'focusable': false},
    {'label': 'ExcludeFocus', 'depth': 2, 'excluded': true, 'focusable': false},
    {'label': 'Name Field', 'depth': 3, 'excluded': true, 'focusable': true},
    {'label': 'Email Field', 'depth': 3, 'excluded': true, 'focusable': true},
    {'label': 'Submit Btn', 'depth': 3, 'excluded': true, 'focusable': true},
    {'label': 'Sidebar', 'depth': 1, 'excluded': false, 'focusable': false},
    {'label': 'Nav Link 1', 'depth': 2, 'excluded': false, 'focusable': true},
    {'label': 'Nav Link 2', 'depth': 2, 'excluded': false, 'focusable': true},
    {'label': 'Footer', 'depth': 1, 'excluded': false, 'focusable': false},
    {'label': 'Help Button', 'depth': 2, 'excluded': false, 'focusable': true},
  ];

  print('  Prepared ${treeNodes.length} tree nodes');

  // ============================================================
  // SECTION 4: Properties
  // ============================================================
  print('=== Section 4: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'excluding',
      'type': 'bool',
      'icon': Icons.toggle_off,
      'color': Colors.green[700]!,
      'description': 'When true, the entire descendant subtree is excluded '
          'from focus. When false, focus works normally. Defaults to true. '
          'Toggle this value to dynamically include/exclude sections.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'icon': Icons.widgets,
      'color': Colors.lime[700]!,
      'description': 'The widget subtree to conditionally exclude from focus. '
          'Can contain any widget — forms, buttons, text fields, entire '
          'layouts. All focusable descendants in this subtree are affected.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 5: When to Use
  // ============================================================
  print('=== Section 5: When to Use ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Disabled Form Sections',
      'icon': Icons.text_fields,
      'color': Colors.green[700]!,
      'description': 'A multi-section form where some sections are '
          'conditionally disabled. Wrap the disabled section in '
          'ExcludeFocus. Tab traversal skips the disabled fields '
          'entirely instead of landing on grayed-out inputs.',
      'example': 'Shipping address form disabled when "Same as billing" '
          'is checked.',
    },
    {
      'title': 'Modal / Dialog Background',
      'icon': Icons.layers,
      'color': Colors.lime[800]!,
      'description': 'When showing a modal dialog, the background page '
          'should not be keyboard-focusable. Wrap the page content '
          'in ExcludeFocus(excluding: isModalOpen) to prevent Tab from '
          'reaching background widgets.',
      'example': 'Full-screen modal overlay with form — background '
          'buttons and links are excluded.',
    },
    {
      'title': 'Hidden / Offscreen Content',
      'icon': Icons.visibility_off,
      'color': Colors.green[600]!,
      'description': 'Content in collapsed accordion panels, hidden tabs, '
          'or offscreen drawers should be excluded from focus. Users '
          'should not Tab into content they cannot see.',
      'example': 'TabBarView where inactive tab pages have '
          'ExcludeFocus(excluding: !isActive).',
    },
    {
      'title': 'Read-Only Preview Mode',
      'icon': Icons.preview,
      'color': Colors.lime[700]!,
      'description': 'A document editor with a preview/edit toggle. In '
          'preview mode, the editing toolbar and input fields should '
          'be excluded from focus so keyboard users only navigate '
          'the preview content.',
      'example': 'Markdown editor with live preview pane — editing '
          'controls excluded in preview mode.',
    },
    {
      'title': 'Wizard / Stepper Steps',
      'icon': Icons.linear_scale,
      'color': Colors.green[700]!,
      'description': 'A multi-step wizard where only the current step '
          'should be focusable. Previous and future steps are visible '
          '(for progress indication) but should not receive focus.',
      'example': 'Checkout stepper — step 1 visible but excluded when '
          'user is on step 3.',
    },
    {
      'title': 'Loading / Skeleton States',
      'icon': Icons.hourglass_top,
      'color': Colors.lime[800]!,
      'description': 'While content is loading and skeleton placeholder '
          'widgets are shown, exclude all focusable elements. Once '
          'loading completes and real content appears, remove the '
          'exclusion.',
      'example': 'Data table with skeleton rows — excluded until data '
          'is fetched and real rows are rendered.',
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codeBlocks = <Map<String, dynamic>>[
    {
      'title': 'Basic ExcludeFocus',
      'color': Colors.green[700]!,
      'code': '// Wrap any widget subtree\n'
          'ExcludeFocus(\n'
          '  excluding: _isSectionDisabled,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TextField(decoration: InputDecoration(\n'
          '        labelText: \'Name\',\n'
          '      )),\n'
          '      TextField(decoration: InputDecoration(\n'
          '        labelText: \'Email\',\n'
          '      )),\n'
          '      ElevatedButton(\n'
          '        onPressed: _isSectionDisabled\n'
          '            ? null : _submit,\n'
          '        child: Text(\'Submit\'),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Modal Background Exclusion',
      'color': Colors.lime[800]!,
      'code': 'Stack(\n'
          '  children: [\n'
          '    // Background page\n'
          '    ExcludeFocus(\n'
          '      excluding: _isModalOpen,\n'
          '      child: _buildPageContent(),\n'
          '    ),\n'
          '\n'
          '    // Modal overlay\n'
          '    if (_isModalOpen)\n'
          '      _buildModalDialog(),\n'
          '  ],\n'
          ')\n'
          '\n'
          '// When modal opens, background cannot\n'
          '// receive focus. When modal closes,\n'
          '// background becomes focusable again.',
    },
    {
      'title': 'Tab Page Exclusion',
      'color': Colors.green[600]!,
      'code': '// Exclude inactive tab pages\n'
          'TabBarView(\n'
          '  children: List.generate(\n'
          '    _tabs.length,\n'
          '    (index) => ExcludeFocus(\n'
          '      excluding: _currentTab != index,\n'
          '      child: _tabs[index].buildContent(),\n'
          '    ),\n'
          '  ),\n'
          ')\n'
          '\n'
          '// Only the active tab receives focus.\n'
          '// All other tabs are excluded from\n'
          '// keyboard traversal.',
    },
    {
      'title': 'Combined with Opacity',
      'color': Colors.lime[700]!,
      'code': '// Visually dim AND exclude from focus\n'
          'IgnorePointer(\n'
          '  ignoring: _isDisabled,\n'
          '  child: ExcludeFocus(\n'
          '    excluding: _isDisabled,\n'
          '    child: AnimatedOpacity(\n'
          '      opacity: _isDisabled ? 0.4 : 1.0,\n'
          '      duration: Duration(milliseconds: 250),\n'
          '      child: _buildSectionContent(),\n'
          '    ),\n'
          '  ),\n'
          ')\n'
          '\n'
          '// Triple disable pattern:\n'
          '// 1. IgnorePointer: no tap events\n'
          '// 2. ExcludeFocus: no keyboard focus\n'
          '// 3. Opacity: visual dim indicator',
    },
  ];

  print('  Prepared ${codeBlocks.length} code blocks');

  // ============================================================
  // SECTION 7: Focus Traversal Order
  // ============================================================
  print('=== Section 7: Focus Traversal Order ===');

  // Visual demonstration of traversal order with/without exclude
  final traversalWithout = <Map<String, dynamic>>[
    {'label': 'Search', 'order': 1, 'excluded': false},
    {'label': 'Name', 'order': 2, 'excluded': false},
    {'label': 'Email', 'order': 3, 'excluded': false},
    {'label': 'Submit', 'order': 4, 'excluded': false},
    {'label': 'Nav 1', 'order': 5, 'excluded': false},
    {'label': 'Nav 2', 'order': 6, 'excluded': false},
    {'label': 'Help', 'order': 7, 'excluded': false},
  ];

  final traversalWith = <Map<String, dynamic>>[
    {'label': 'Search', 'order': 1, 'excluded': false},
    {'label': 'Name', 'order': null, 'excluded': true},
    {'label': 'Email', 'order': null, 'excluded': true},
    {'label': 'Submit', 'order': null, 'excluded': true},
    {'label': 'Nav 1', 'order': 2, 'excluded': false},
    {'label': 'Nav 2', 'order': 3, 'excluded': false},
    {'label': 'Help', 'order': 4, 'excluded': false},
  ];

  print('  Prepared traversal demos (${traversalWithout.length} fields)');

  // ============================================================
  // SECTION 8: Related Widgets
  // ============================================================
  print('=== Section 8: Related Widgets ===');

  final relatedRows = <Map<String, dynamic>>[
    {
      'widget': 'ExcludeFocus',
      'effect': 'Cannot be focused at all',
      'tabKey': 'Skipped',
      'requestFocus': 'Ignored',
      'touchTap': 'Normal (if not wrapped in IgnorePointer)',
    },
    {
      'widget': 'ExcludeFocusTraversal',
      'effect': 'Skipped in Tab order',
      'tabKey': 'Skipped',
      'requestFocus': 'Works',
      'touchTap': 'Normal',
    },
    {
      'widget': 'IgnorePointer',
      'effect': 'Pointer events blocked',
      'tabKey': 'Normal',
      'requestFocus': 'Works',
      'touchTap': 'Blocked',
    },
    {
      'widget': 'AbsorbPointer',
      'effect': 'Pointer events absorbed',
      'tabKey': 'Normal',
      'requestFocus': 'Works',
      'touchTap': 'Absorbed (no pass-through)',
    },
    {
      'widget': 'FocusScope(canRequestFocus: false)',
      'effect': 'Same as ExcludeFocus',
      'tabKey': 'Skipped',
      'requestFocus': 'Ignored',
      'touchTap': 'Normal',
    },
  ];

  print('  Prepared ${relatedRows.length} related widget rows');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'ExcludeFocus defaults to excluding: true',
      'body': 'The excluding parameter defaults to true. If you just '
          'write ExcludeFocus(child: ...), the subtree IS excluded. '
          'You almost always want to control it with a boolean variable '
          'like ExcludeFocus(excluding: _isDisabled, child: ...).',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Does NOT disable pointer (tap) events',
      'body': 'ExcludeFocus only affects keyboard focus. Users can still '
          'tap or click widgets inside the excluded subtree. Combine '
          'with IgnorePointer to fully disable interaction, or disable '
          'individual buttons via onPressed: null.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use for Accessibility',
      'body': 'ExcludeFocus is essential for accessible applications. '
          'Screen reader users rely on focus order. If disabled or '
          'hidden content is focusable, it confuses navigation. Always '
          'exclude non-interactive sections from focus.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Focus Can Be Trapped',
      'body': 'If you exclude everything around the currently focused '
          'widget, focus may get trapped. Always ensure at least one '
          'focusable widget remains accessible when toggling '
          'exclusion. Test with keyboard-only navigation.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine Triple: Exclude + Ignore + Opacity',
      'body': 'The "triple disable" pattern covers all interaction modes:\n'
          '• ExcludeFocus: blocks Tab traversal\n'
          '• IgnorePointer: blocks taps/clicks\n'
          '• AnimatedOpacity: visual feedback (dim)\n'
          'Stack them outside-in: IgnorePointer → ExcludeFocus → '
          'AnimatedOpacity → child.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Nest ExcludeFocus Widgets',
      'body': 'ExcludeFocus can nest. A child ExcludeFocus(excluding: false) '
          'inside a parent ExcludeFocus(excluding: true) does NOT re-enable '
          'focus — the parent wins. The entire subtree under an excluding '
          'parent is always excluded.',
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
      title: Text('ExcludeFocus'),
      backgroundColor: Colors.green[700],
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
                colors: [Colors.green[700]!, Colors.lime[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.block, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ExcludeFocus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A widget that conditionally removes its entire '
                  'descendant subtree from the focus traversal system. '
                  'When excluding is true, no descendant can receive '
                  'keyboard focus via Tab, Shift+Tab, or programmatic '
                  'requestFocus(). Essential for accessible apps.',
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
          _efHead('1', 'What is ExcludeFocus?'),
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

          // ── Section 2: ExcludeFocus vs ExcludeFocusTraversal ──
          _efHead('2', 'ExcludeFocus vs ExcludeFocusTraversal'),
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
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 70,
                      child: Text('Aspect',
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
                  Expanded(
                      child: Text('ExcludeFocusTraversal',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...vsRows.asMap().entries.map((entry) {
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
                          width: 70,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(r['excludeFocus'] as String,
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.green[700])),
                      )),
                      Expanded(
                          child: Text(r['excludeTraversal'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.lime[800]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 3: Focus Tree ──
          _efHead('3', 'Focus Tree Visualization'),
          SizedBox(height: 8),
          Text(
            'Nodes highlighted in red are excluded from the focus system. '
            'Focusable nodes shown with a focus indicator.',
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
                  final excluded = node['excluded'] as bool;
                  final focusable = node['focusable'] as bool;
                  final indent = depth * 20.0;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 3, left: indent),
                    child: Row(children: [
                      if (depth > 0)
                        Text(depth == 1 ? '├─ ' : '│  ├─ ',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.grey[400])),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: excluded
                              ? Colors.red[50]
                              : focusable
                                  ? Colors.green[50]
                                  : Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: excluded
                                ? Colors.red[300]!
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
                                    color: excluded
                                        ? Colors.red[700]
                                        : Colors.grey[800])),
                            if (focusable && !excluded) ...[
                              SizedBox(width: 4),
                              Icon(Icons.keyboard,
                                  size: 8,
                                  color: Colors.green[600]),
                            ],
                            if (excluded) ...[
                              SizedBox(width: 4),
                              Icon(Icons.block,
                                  size: 8,
                                  color: Colors.red[400]),
                            ],
                          ],
                        ),
                      ),
                    ]),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: Properties ──
          _efHead('4', 'Properties'),
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
                        _efTag(p['type'] as String, p['color'] as Color),
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

          // ── Section 5: When to Use ──
          _efHead('5', 'When to Use ExcludeFocus'),
          SizedBox(height: 12),
          ...scenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
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
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(s['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(s['example'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.green[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _efHead('6', 'Code Patterns'),
          SizedBox(height: 12),
          ...codeBlocks.map((cb) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cb['color'] as Color, width: 4),
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
                      Text(cb['title'] as String,
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
                        child: Text(cb['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.lime[300],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Focus Traversal Order ──
          _efHead('7', 'Focus Traversal Order'),
          SizedBox(height: 8),
          Text(
            'Compare Tab order with and without ExcludeFocus wrapping '
            'the Name, Email, and Submit fields.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          // Without ExcludeFocus
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
                Text('Without ExcludeFocus — All 7 fields focusable',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.green[700])),
                SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: traversalWithout.map((t) {
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
                Text('Tab order: 1 → 2 → 3 → 4 → 5 → 6 → 7',
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: Colors.grey[600])),
              ],
            ),
          ),
          SizedBox(height: 12),
          // With ExcludeFocus
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'With ExcludeFocus — Name, Email, Submit excluded',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.red[700])),
                SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: traversalWith.map((t) {
                    final excluded = t['excluded'] as bool;
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: excluded
                            ? Colors.red[50]
                            : Colors.green[50],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: excluded
                                ? Colors.red[300]!
                                : Colors.green[400]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!excluded)
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
                            Icon(Icons.block,
                                size: 14, color: Colors.red[400]),
                          SizedBox(width: 4),
                          Text(t['label'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  decoration: excluded
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: excluded
                                      ? Colors.red[400]
                                      : Colors.grey[800])),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 6),
                Text('Tab order: 1 → [skip] → [skip] → [skip] → 2 → 3 → 4',
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'monospace',
                        color: Colors.grey[600])),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 8: Related Widgets Comparison ──
          _efHead('8', 'Related Widget Comparison'),
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
                    EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 70,
                      child: Text('Widget',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('Tab',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('requestFocus',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                  Expanded(
                      child: Text('Tap/Click',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8))),
                ]),
              ),
              ...relatedRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6, vertical: 4),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(r['widget'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['tabKey'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['requestFocus'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['touchTap'] as String,
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _efHead('9', 'Tips & Gotchas'),
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
              'End of ExcludeFocus Deep Demo',
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
Widget _efHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green[700],
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
// Helper: Type tag badge
// ──────────────────────────────────────────────────────────
Widget _efTag(String text, Color color) {
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
