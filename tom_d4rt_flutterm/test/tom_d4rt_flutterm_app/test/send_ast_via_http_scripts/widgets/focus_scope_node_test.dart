// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FocusScopeNode
// Demonstrates FocusScopeNode, the scope-level node in Flutter's
// focus system. Covers how it groups FocusNodes, manages traversal
// order, handles autofocus, interacts with FocusScope widget,
// and enables keyboard navigation in complex UIs.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusScopeNode Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusScopeNode?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'A Scope in the Focus Tree',
      'body': 'FocusScopeNode is a special FocusNode that acts as '
          'a scope — a group that contains other FocusNodes and '
          'potentially other FocusScopeNodes. It is the "folder" '
          'in Flutter\'s focus tree, while regular FocusNodes '
          'are the "files".',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Keyboard Navigation Container',
      'body': 'When the user presses Tab or arrow keys, focus '
          'traverses within a scope before leaving it. FocusScopeNode '
          'defines the boundary: focus cycles through its children '
          'before escaping to the parent scope.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.star,
      'title': 'Manages Autofocus',
      'body': 'FocusScopeNode tracks which child should receive '
          'focus automatically when the scope gains focus. The '
          'autofocus property on child FocusNodes registers with '
          'their enclosing FocusScopeNode.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Backed by FocusScope Widget',
      'body': 'The FocusScope widget creates and manages a '
          'FocusScopeNode. Most developers interact with the '
          'widget; the node is the lower-level API for programmatic '
          'focus management.',
      'accent': Colors.brown[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties & Methods
  // ============================================================
  print('=== Section 2: Properties & Methods ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'focusedChild',
      'type': 'FocusNode?',
      'icon': Icons.child_care,
      'color': Colors.deepOrange[600]!,
      'bgColor': Colors.deepOrange[50]!,
      'description': 'The descendant FocusNode that currently has '
          'focus within this scope (or null if none). This is the '
          '"active" element in the scope — the one receiving '
          'keyboard events.',
    },
    {
      'name': 'hasFocus',
      'type': 'bool',
      'icon': Icons.visibility,
      'color': Colors.brown[600]!,
      'bgColor': Colors.brown[50]!,
      'description': 'True if this scope or any descendant has focus. '
          'A scope "has focus" even if the actual focused node is '
          'a deeply nested child. Useful for highlighting the '
          'entire scope when any child is focused.',
    },
    {
      'name': 'hasPrimaryFocus',
      'type': 'bool',
      'icon': Icons.filter_center_focus,
      'color': Colors.deepOrange[700]!,
      'bgColor': Colors.deepOrange[50]!,
      'description': 'True only if THIS scope node itself is the '
          'primary focused node (rare). Usually false because focus '
          'passes through scopes to leaf FocusNodes.',
    },
    {
      'name': 'canRequestFocus',
      'type': 'bool',
      'icon': Icons.lock_open,
      'color': Colors.brown[500]!,
      'bgColor': Colors.brown[50]!,
      'description': 'Whether this scope (and its descendants) can '
          'receive focus. Set to false to disable an entire section '
          'of the UI. All children become unfocusable.',
    },
    {
      'name': 'traversalChildren',
      'type': 'Iterable<FocusNode>',
      'icon': Icons.swap_vert,
      'color': Colors.deepOrange[500]!,
      'bgColor': Colors.orange[50]!,
      'description': 'The ordered list of focusable children for '
          'traversal (Tab key). The order is determined by the '
          'FocusTraversalPolicy attached to this scope.',
    },
    {
      'name': 'requestFocus([FocusNode?])',
      'type': 'void',
      'icon': Icons.touch_app,
      'color': Colors.brown[700]!,
      'bgColor': Colors.brown[50]!,
      'description': 'Requests focus for a specific child, or for '
          'the scope\'s remembered focused child, or for the first '
          'autofocus child. The most common method for programmatic '
          'focus changes.',
    },
    {
      'name': 'unfocus()',
      'type': 'void',
      'icon': Icons.blur_off,
      'color': Colors.deepOrange[800]!,
      'bgColor': Colors.deepOrange[50]!,
      'description': 'Removes focus from this scope. Depending on '
          'the disposition parameter, focus either moves to the '
          'nearest ancestor scope or to the root scope.',
    },
    {
      'name': 'setFirstFocus(FocusScopeNode)',
      'type': 'void',
      'icon': Icons.first_page,
      'color': Colors.brown[600]!,
      'bgColor': Colors.brown[50]!,
      'description': 'Makes a child scope the first-focused scope. '
          'When this parent scope gains focus, it will delegate '
          'to the specified child scope first.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: The Focus Tree Structure
  // ============================================================
  print('=== Section 3: Focus Tree Structure ===');

  final treeNodes = <Map<String, dynamic>>[
    {
      'name': 'Root FocusScopeNode',
      'icon': Icons.foundation,
      'color': Colors.deepOrange[800]!,
      'depth': 0,
      'description': 'Created by WidgetsBinding. The topmost scope '
          'in the entire application. Every other scope is a '
          'descendant of this root.',
    },
    {
      'name': 'MaterialApp Scope',
      'icon': Icons.web,
      'color': Colors.deepOrange[700]!,
      'depth': 1,
      'description': 'MaterialApp creates a FocusScope. Routes and '
          'overlays attach their scopes under this.',
    },
    {
      'name': 'Route Scope (Scaffold)',
      'icon': Icons.web_stories,
      'color': Colors.deepOrange[600]!,
      'depth': 2,
      'description': 'Each Route (page) gets its own FocusScopeNode. '
          'When navigating, the new route\'s scope gains focus. The '
          'old route\'s scope becomes unfocused but remembers which '
          'child had focus.',
    },
    {
      'name': 'Dialog / Sheet Scope',
      'icon': Icons.picture_in_picture,
      'color': Colors.brown[500]!,
      'depth': 3,
      'description': 'Dialogs and bottom sheets create their own '
          'scopes. Focus is trapped within the dialog until it closes '
          '(focus trap pattern).',
    },
    {
      'name': 'Form / Section Scope',
      'icon': Icons.text_fields,
      'color': Colors.brown[600]!,
      'depth': 3,
      'description': 'Developers add custom FocusScope widgets to '
          'group related inputs (e.g., a login form). Tab traversal '
          'stays within the form before leaving.',
    },
    {
      'name': 'Leaf FocusNode (TextField, Button)',
      'icon': Icons.radio_button_unchecked,
      'color': Colors.grey[600]!,
      'depth': 4,
      'description': 'Individual focusable widgets. They receive '
          'keyboard events when focused. They register with the '
          'nearest ancestor FocusScopeNode.',
    },
  ];

  print('  Prepared ${treeNodes.length} tree nodes');

  // ============================================================
  // SECTION 4: FocusScope Widget Usage
  // ============================================================
  print('=== Section 4: FocusScope Widget ===');

  final widgetUsages = <Map<String, dynamic>>[
    {
      'name': 'Basic FocusScope',
      'icon': Icons.crop_free,
      'color': Colors.deepOrange[600]!,
      'code': 'FocusScope(\n'
          '  autofocus: true,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TextField(),  // auto-focused\n'
          '      TextField(),\n'
          '      ElevatedButton(...),\n'
          '    ],\n'
          '  ),\n'
          ')',
      'description': 'The most common usage. Wraps a group of '
          'focusable widgets. autofocus: true means the first '
          'focusable child gets focus when the scope appears.',
    },
    {
      'name': 'Accessing the Node',
      'icon': Icons.search,
      'color': Colors.brown[600]!,
      'code': '// Inside build():\n'
          'final scope = FocusScope.of(context);\n'
          'scope.requestFocus(myNode);\n'
          'scope.unfocus();\n'
          'print(scope.hasFocus);',
      'description': 'FocusScope.of(context) returns the nearest '
          'FocusScopeNode. Use it for programmatic focus control. '
          'This is the bridge from widget to node.',
    },
    {
      'name': 'Focus Trap (Dialog)',
      'icon': Icons.lock,
      'color': Colors.deepOrange[700]!,
      'code': 'showDialog(\n'
          '  ...\n'
          '  builder: (_) => FocusScope(\n'
          '    autofocus: true,\n'
          '    child: AlertDialog(\n'
          '      content: TextField(),\n'
          '      actions: [TextButton(...)],\n'
          '    ),\n'
          '  ),\n'
          ')',
      'description': 'Dialog creates a FocusScope. Tab traversal '
          'is trapped: pressing Tab cycles through the dialog\'s '
          'focusable children without escaping to the background.',
    },
    {
      'name': 'Disabling a Section',
      'icon': Icons.not_interested,
      'color': Colors.brown[700]!,
      'code': 'FocusScope(\n'
          '  canRequestFocus: false,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TextField(),  // can\'t get focus\n'
          '      Button(),     // can\'t get focus\n'
          '    ],\n'
          '  ),\n'
          ')',
      'description': 'Setting canRequestFocus to false on the scope '
          'disables all children. No child can receive focus. '
          'Useful for grayed-out form sections.',
    },
  ];

  print('  Prepared ${widgetUsages.length} widget usage examples');

  // ============================================================
  // SECTION 5: Traversal Policies
  // ============================================================
  print('=== Section 5: Focus Traversal ===');

  final policies = <Map<String, dynamic>>[
    {
      'name': 'ReadingOrderTraversalPolicy',
      'icon': Icons.format_textdirection_l_to_r,
      'color': Colors.deepOrange[500]!,
      'description': 'Default policy. Traverses in reading order '
          '(top-to-bottom, left-to-right in LTR, right-to-left in '
          'RTL). Matches how users visually scan the page.',
    },
    {
      'name': 'OrderedTraversalPolicy',
      'icon': Icons.sort,
      'color': Colors.brown[500]!,
      'description': 'Traverses children by explicit order numbers. '
          'Each FocusNode is wrapped with FocusTraversalOrder and '
          'given a NumericFocusOrder(n). Lower n gets focus first.',
    },
    {
      'name': 'WidgetOrderTraversalPolicy',
      'icon': Icons.list,
      'color': Colors.deepOrange[600]!,
      'description': 'Traverses in the order widgets appear in the '
          'widget tree. Simplest policy — the first child in the '
          'Column/Row gets focus first.',
    },
    {
      'name': 'DirectionalFocusTraversalPolicyMixin',
      'icon': Icons.arrow_circle_up,
      'color': Colors.brown[600]!,
      'description': 'Enables arrow-key navigation. Focus moves in '
          'the direction of the pressed arrow key to the nearest '
          'focusable widget in that direction.',
    },
  ];

  print('  Prepared ${policies.length} traversal policies');

  // ============================================================
  // SECTION 6: FocusScopeNode vs FocusNode
  // ============================================================
  print('=== Section 6: Scope vs Node ===');

  final comparison = <Map<String, String>>[
    {
      'aspect': 'Purpose',
      'scope': 'Groups and manages children',
      'node': 'Represents one focusable widget',
    },
    {
      'aspect': 'Widget',
      'scope': 'FocusScope widget',
      'node': 'Focus widget',
    },
    {
      'aspect': 'Has children?',
      'scope': 'Yes — contains FocusNodes and '
          'child FocusScopeNodes',
      'node': 'No — it\'s a leaf in the focus tree',
    },
    {
      'aspect': 'focusedChild',
      'scope': 'Returns the currently focused '
          'descendant',
      'node': 'N/A (not a scope)',
    },
    {
      'aspect': 'Traversal',
      'scope': 'Defines traversal boundary — Tab '
          'stays within before leaving',
      'node': 'Participates in traversal as a '
          'stop point',
    },
    {
      'aspect': 'onKey',
      'scope': 'Can intercept keys for all children',
      'node': 'Handles keys for itself only',
    },
    {
      'aspect': 'canRequestFocus=false',
      'scope': 'Disables entire subtree',
      'node': 'Disables just this one node',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 7: Common Patterns
  // ============================================================
  print('=== Section 7: Common Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Form Tab Order',
      'icon': Icons.tab,
      'color': Colors.deepOrange[600]!,
      'body': 'Wrap form fields in a FocusScope. Tab moves through '
          'fields in order. After the last field, Tab moves to the '
          'submit button. Pressing Shift+Tab goes backward.',
    },
    {
      'title': 'Focus on Route Push',
      'icon': Icons.arrow_forward,
      'color': Colors.brown[600]!,
      'body': 'When a new route is pushed, its FocusScopeNode steals '
          'focus. The previous route remembers its focused child. '
          'When the user pops back, focus restores automatically.',
    },
    {
      'title': 'Search Field Autofocus',
      'icon': Icons.search,
      'color': Colors.deepOrange[500]!,
      'body': 'Set autofocus: true on the search TextField. When '
          'the scope appears (drawer opens, dialog shows), the '
          'search field receives focus immediately — the keyboard '
          'opens on mobile.',
    },
    {
      'title': 'Focus Restoration',
      'icon': Icons.restore,
      'color': Colors.brown[500]!,
      'body': 'FocusScopeNode remembers which child had focus. '
          'Use the restorationId parameter on FocusScope to '
          'persist this across app restarts via the restoration '
          'framework.',
    },
    {
      'title': 'Skip Navigation to Content',
      'icon': Icons.skip_next,
      'color': Colors.deepOrange[700]!,
      'body': 'Accessibility pattern: a hidden "Skip to content" '
          'button is the first focusable item. Pressing Enter '
          'calls scope.requestFocus(contentNode) to jump past '
          'navigation elements.',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 8: Keyboard Shortcuts Integration
  // ============================================================
  print('=== Section 8: Keyboard Shortcuts ===');

  final shortcuts = <Map<String, dynamic>>[
    {
      'name': 'Focus + onKeyEvent',
      'icon': Icons.keyboard,
      'color': Colors.deepOrange[600]!,
      'description': 'FocusScopeNode inherits onKeyEvent from '
          'FocusNode. Set it to intercept keyboard events for the '
          'entire scope. Return KeyEventResult.handled to consume '
          'the event, .ignored to pass it on.',
    },
    {
      'name': 'Shortcuts Widget',
      'icon': Icons.shortcut,
      'color': Colors.brown[600]!,
      'description': 'The Shortcuts widget sits above a FocusScope '
          'and maps key combinations to Intents. The Actions widget '
          'below handles those Intents. Focus must be within the '
          'scope for shortcuts to fire.',
    },
    {
      'name': 'CallbackShortcuts',
      'icon': Icons.bolt,
      'color': Colors.deepOrange[500]!,
      'description': 'Simpler alternative — CallbackShortcuts maps '
          'key combinations directly to callbacks. No Intent/Action '
          'ceremony. Must be below a FocusScope.',
    },
    {
      'name': 'FocusableActionDetector',
      'icon': Icons.ads_click,
      'color': Colors.brown[500]!,
      'description': 'Combines Focus, Actions, Shortcuts, and '
          'MouseRegion into one widget. Automatically manages hover '
          'and focus states. Used extensively in Material widgets.',
    },
  ];

  print('  Prepared ${shortcuts.length} shortcut integrations');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'FocusScope.of Finds the Nearest Scope',
      'body': 'FocusScope.of(context) returns the nearest ANCESTOR '
          'FocusScopeNode. If your widget IS a FocusScope, calling '
          'FocusScope.of(context) inside its builder returns the '
          'PARENT scope, not its own scope. Use the node parameter '
          'in the FocusScope widget instead.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Every Route Has Its Own Scope',
      'body': 'Navigator creates a FocusScopeNode per Route. When '
          'you push a new page, the new scope steals focus. Pop and '
          'focus returns to the previous route\'s scope. You rarely '
          'need to manage this manually.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Prefer Focus Widget Over Raw FocusNode',
      'body': 'Instead of creating and managing FocusScopeNode '
          'directly, use the FocusScope widget. It handles node '
          'lifecycle, attachment, and disposal. Direct node usage '
          'is for advanced scenarios only.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'debugFocusChanges for Debugging',
      'body': 'Set debugFocusChanges = true to see focus changes '
          'logged to the console. Extremely helpful when Tab '
          'traversal doesn\'t go where you expect or focus seems '
          'to "disappear".',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Focus and Semantics',
      'body': 'Focus nodes automatically contribute to the semantics '
          'tree for accessibility. Screen readers use the focus tree '
          'to navigate. Proper FocusScope structure improves '
          'accessibility for keyboard and screen reader users.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Don\'t Fight the Framework',
      'body': 'Many focus issues come from fighting the default '
          'behavior. Before adding custom focus management, check '
          'if autofocus, FocusTraversalGroup, and the default '
          'policies already do what you need. They usually do.',
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
      title: Text('FocusScopeNode'),
      backgroundColor: Colors.deepOrange[700],
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
                colors: [Colors.deepOrange[700]!, Colors.brown[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_tree, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FocusScopeNode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The scope-level node in Flutter\'s focus system — '
                  'groups focusable children, manages traversal, '
                  'and enables keyboard navigation.',
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
          _heading('1', 'What is FocusScopeNode?'),
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
                          color: card['accent'] as Color, width: 4),
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
          _heading('2', 'Properties & Methods'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: prop['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (prop['color'] as Color).withOpacity(0.4)),
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
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: prop['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(prop['icon'] as IconData,
                              color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('.${prop['name']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: prop['color'] as Color)),
                              Text(prop['type'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Focus Tree ──
          _heading('3', 'The Focus Tree Structure'),
          SizedBox(height: 12),
          ...treeNodes.map((node) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (node['depth'] as int) * 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                            color: node['color'] as Color, width: 4),
                      ),
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
                          Icon(node['icon'] as IconData,
                              color: node['color'] as Color, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(node['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ]),
                        SizedBox(height: 4),
                        Text(node['description'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.3)),
                      ],
                    ),
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Widget Usage ──
          _heading('4', 'FocusScope Widget Usage'),
          SizedBox(height: 12),
          ...widgetUsages.map((wu) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: wu['color'] as Color, width: 4),
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
                        Icon(wu['icon'] as IconData,
                            color: wu['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(wu['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (wu['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(wu['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(wu['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Traversal Policies ──
          _heading('5', 'Focus Traversal Policies'),
          SizedBox(height: 12),
          ...policies.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 6),
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

          // ── Section 6: Comparison Table ──
          _heading('6', 'FocusScopeNode vs FocusNode'),
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
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.deepOrange[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _tcell('Aspect', bold: true, white: true, flex: 2),
                  _tcell('FocusScopeNode', bold: true, white: true, flex: 3),
                  _tcell('FocusNode', bold: true, white: true, flex: 3),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tcell(row['aspect']!, bold: true, flex: 2),
                      _tcell(row['scope']!, flex: 3),
                      _tcell(row['node']!, flex: 3),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Common Patterns ──
          _heading('7', 'Common Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
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
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Keyboard Shortcuts ──
          _heading('8', 'Keyboard Shortcuts Integration'),
          SizedBox(height: 12),
          ...shortcuts.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                            color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(s['description'] as String,
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
          _heading('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FocusScopeNode Deep Demo',
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
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepOrange[700],
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
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _tcell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}
