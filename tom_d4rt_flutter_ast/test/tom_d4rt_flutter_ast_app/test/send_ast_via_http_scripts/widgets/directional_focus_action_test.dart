// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DirectionalFocusAction
// Demonstrates DirectionalFocusAction — the built-in Action that
// handles DirectionalFocusIntent to move focus in a given
// TraversalDirection. Covers the Action/Intent pattern, traversal
// directions, focus grids, keyboard shortcuts, and integration
// with FocusTraversalPolicy.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DirectionalFocusAction Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DirectionalFocusAction?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.arrow_circle_right,
      'title': 'An Action for Directional Focus Movement',
      'body': 'DirectionalFocusAction is the built-in Action class that '
          'responds to DirectionalFocusIntent. When invoked, it moves '
          'keyboard focus to the next focusable widget in a given '
          'direction: up, down, left, or right. It powers arrow-key '
          'focus traversal in Flutter applications.',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Part of the Shortcuts System',
      'body': 'Flutter registers DirectionalFocusAction in the default '
          'shortcut mappings. Pressing arrow keys generates a '
          'DirectionalFocusIntent with the appropriate TraversalDirection. '
          'The action looks up the nearest FocusTraversalPolicy and '
          'delegates directional focus resolution to it.',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Works with FocusTraversalPolicy',
      'body': 'The action does not decide where focus goes — it asks the '
          'current FocusTraversalPolicy to find the widget in a given '
          'direction. Policies like ReadingOrderTraversalPolicy use '
          'geometry to resolve direction, while OrderedTraversalPolicy '
          'uses explicit ordering.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.gamepad,
      'title': 'Essential for Accessibility',
      'body': 'Directional focus is critical for keyboard-only users, TV '
          'remotes, game controllers, and assistive devices. The action '
          'ensures that any Flutter app can be navigated spatially '
          'without a mouse or touchscreen.',
      'accent': Colors.purple[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Action / Intent Pattern
  // ============================================================
  print('=== Section 2: Action/Intent Pattern ===');

  final actionIntentPairs = <Map<String, dynamic>>[
    {
      'intent': 'DirectionalFocusIntent',
      'action': 'DirectionalFocusAction',
      'color': Colors.deepPurple[700]!,
      'description': 'Moves focus in a TraversalDirection (up/down/'
          'left/right). The intent carries the direction; the action '
          'resolves the target widget via the FocusTraversalPolicy.',
    },
    {
      'intent': 'NextFocusIntent',
      'action': 'NextFocusAction',
      'color': Colors.purple[600]!,
      'description': 'Moves focus to the next widget in tab order. '
          'Non-directional — follows reading order or explicit sort '
          'order. Typically triggered by the Tab key.',
    },
    {
      'intent': 'PreviousFocusIntent',
      'action': 'PreviousFocusAction',
      'color': Colors.deepPurple[600]!,
      'description': 'Moves focus to the previous widget in tab order. '
          'Reverse of NextFocusAction. Typically triggered by Shift+Tab.',
    },
    {
      'intent': 'RequestFocusIntent',
      'action': 'RequestFocusAction',
      'color': Colors.purple[700]!,
      'description': 'Requests focus on a specific FocusNode. Unlike '
          'directional movement, this targets a known node directly. '
          'Used for programmatic focus changes.',
    },
  ];

  print('  Prepared ${actionIntentPairs.length} action/intent pairs');

  // ============================================================
  // SECTION 3: TraversalDirection
  // ============================================================
  print('=== Section 3: TraversalDirection ===');

  final directions = <Map<String, dynamic>>[
    {
      'name': 'TraversalDirection.up',
      'icon': Icons.arrow_upward,
      'color': Colors.deepPurple[700]!,
      'description': 'Move focus to the nearest focusable widget above '
          'the current one. The policy uses the widget\'s geometry to '
          'find candidates above the current focus bounds.',
      'arrow': '↑',
    },
    {
      'name': 'TraversalDirection.down',
      'icon': Icons.arrow_downward,
      'color': Colors.purple[600]!,
      'description': 'Move focus to the nearest focusable widget below. '
          'In a vertical list or grid, this typically moves to the next '
          'row. Geometry-based resolution picks the closest match.',
      'arrow': '↓',
    },
    {
      'name': 'TraversalDirection.left',
      'icon': Icons.arrow_back,
      'color': Colors.deepPurple[600]!,
      'description': 'Move focus to the nearest focusable widget to the '
          'left. In LTR layout, this moves backward. In RTL layout, the '
          'policy accounts for text directionality.',
      'arrow': '←',
    },
    {
      'name': 'TraversalDirection.right',
      'icon': Icons.arrow_forward,
      'color': Colors.purple[700]!,
      'description': 'Move focus to the nearest focusable widget to the '
          'right. In LTR layout, this moves forward. Combined with '
          'up/down, enables full 2D grid navigation.',
      'arrow': '→',
    },
  ];

  print('  Prepared ${directions.length} traversal directions');

  // ============================================================
  // SECTION 4: Focus Grid Visualization
  // ============================================================
  print('=== Section 4: Focus Grid ===');

  final gridCells = <Map<String, dynamic>>[];
  final gridLabels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
  final gridColors = [
    Colors.deepPurple[100]!,
    Colors.purple[100]!,
    Colors.deepPurple[200]!,
    Colors.purple[200]!,
    Colors.deepPurple[300]!,
    Colors.purple[300]!,
    Colors.deepPurple[100]!,
    Colors.purple[100]!,
    Colors.deepPurple[200]!,
  ];

  for (var i = 0; i < 9; i++) {
    gridCells.add({
      'label': gridLabels[i],
      'color': gridColors[i],
      'row': i ~/ 3,
      'col': i % 3,
    });
  }

  final gridArrows = <Map<String, dynamic>>[
    {
      'from': 'E (center)',
      'direction': '↑ Up',
      'to': 'B',
      'color': Colors.deepPurple[700]!,
    },
    {
      'from': 'E (center)',
      'direction': '↓ Down',
      'to': 'H',
      'color': Colors.purple[600]!,
    },
    {
      'from': 'E (center)',
      'direction': '← Left',
      'to': 'D',
      'color': Colors.deepPurple[600]!,
    },
    {
      'from': 'E (center)',
      'direction': '→ Right',
      'to': 'F',
      'color': Colors.purple[700]!,
    },
  ];

  print('  Prepared ${gridCells.length} grid cells and ${gridArrows.length} arrows');

  // ============================================================
  // SECTION 5: FocusTraversalPolicy Integration
  // ============================================================
  print('=== Section 5: FocusTraversalPolicy ===');

  final policies = <Map<String, dynamic>>[
    {
      'name': 'ReadingOrderTraversalPolicy',
      'icon': Icons.menu_book,
      'color': Colors.deepPurple[700]!,
      'description': 'The default policy. Uses widget geometry to determine '
          'reading order (left-to-right, top-to-bottom for LTR). For '
          'directional focus, it finds the nearest widget in the specified '
          'direction using a spatial algorithm. Best for typical layouts.',
      'directional': 'Geometry-based: finds nearest visually in that '
          'direction. Good for grids and natural spatial layouts.',
    },
    {
      'name': 'OrderedTraversalPolicy',
      'icon': Icons.format_list_numbered,
      'color': Colors.purple[600]!,
      'description': 'Uses FocusTraversalOrder widgets to define explicit '
          'ordering. Tab order follows the numeric/lexicographic order '
          'of the assigned FocusOrder values.',
      'directional': 'Falls back to reading-order geometry for directional '
          'moves. Explicit order is mainly for tab traversal.',
    },
    {
      'name': 'WidgetOrderTraversalPolicy',
      'icon': Icons.layers,
      'color': Colors.deepPurple[600]!,
      'description': 'Uses the widget tree order — the order in which '
          'widgets appear in the build method. Simplest policy but '
          'may not match visual layout in complex cases.',
      'directional': 'Directional focus follows widget tree order rather '
          'than geometry. Can feel unexpected in grid layouts.',
    },
    {
      'name': 'Custom Policy',
      'icon': Icons.build_circle,
      'color': Colors.purple[700]!,
      'description': 'You can extend FocusTraversalPolicy to create custom '
          'logic. Override inDirection() to control how directional focus '
          'is resolved. Useful for game-like navigation or specialized UIs.',
      'directional': 'Full control: implement inDirection(FocusNode, '
          'TraversalDirection) to return the desired target node.',
    },
  ];

  print('  Prepared ${policies.length} policies');

  // ============================================================
  // SECTION 6: Keyboard Shortcuts Integration
  // ============================================================
  print('=== Section 6: Keyboard Shortcuts ===');

  final shortcutMappings = <Map<String, dynamic>>[
    {
      'key': 'Arrow Up',
      'intent': 'DirectionalFocusIntent(TraversalDirection.up)',
      'icon': Icons.keyboard_arrow_up,
      'color': Colors.deepPurple[700]!,
    },
    {
      'key': 'Arrow Down',
      'intent': 'DirectionalFocusIntent(TraversalDirection.down)',
      'icon': Icons.keyboard_arrow_down,
      'color': Colors.purple[600]!,
    },
    {
      'key': 'Arrow Left',
      'intent': 'DirectionalFocusIntent(TraversalDirection.left)',
      'icon': Icons.keyboard_arrow_left,
      'color': Colors.deepPurple[600]!,
    },
    {
      'key': 'Arrow Right',
      'intent': 'DirectionalFocusIntent(TraversalDirection.right)',
      'icon': Icons.keyboard_arrow_right,
      'color': Colors.purple[700]!,
    },
    {
      'key': 'Tab',
      'intent': 'NextFocusIntent()',
      'icon': Icons.keyboard_tab,
      'color': Colors.deepPurple[400]!,
    },
    {
      'key': 'Shift+Tab',
      'intent': 'PreviousFocusIntent()',
      'icon': Icons.keyboard_tab,
      'color': Colors.purple[400]!,
    },
  ];

  print('  Prepared ${shortcutMappings.length} shortcut mappings');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Default (Automatic)',
      'color': Colors.deepPurple[700]!,
      'code': '// No setup needed! Flutter registers\n'
          '// DirectionalFocusAction by default.\n'
          '// Arrow keys move focus automatically\n'
          '// as long as widgets are focusable.\n'
          '\n'
          'Column(\n'
          '  children: [\n'
          '    ElevatedButton(\n'
          '      onPressed: () {},\n'
          '      child: Text(\'Button 1\'),\n'
          '    ),\n'
          '    ElevatedButton(\n'
          '      onPressed: () {},\n'
          '      child: Text(\'Button 2\'),\n'
          '    ),\n'
          '  ],\n'
          ')\n'
          '// Press Arrow Down: focus moves from 1 to 2\n'
          '// Press Arrow Up: focus moves from 2 to 1',
    },
    {
      'title': 'Custom FocusTraversalGroup',
      'color': Colors.purple[600]!,
      'code': '// Group widgets with a specific policy\n'
          'FocusTraversalGroup(\n'
          '  policy: OrderedTraversalPolicy(),\n'
          '  child: Column(\n'
          '    children: [\n'
          '      FocusTraversalOrder(\n'
          '        order: NumericFocusOrder(3),\n'
          '        child: TextButton(...),\n'
          '      ),\n'
          '      FocusTraversalOrder(\n'
          '        order: NumericFocusOrder(1),\n'
          '        child: TextButton(...),\n'
          '      ),\n'
          '      FocusTraversalOrder(\n'
          '        order: NumericFocusOrder(2),\n'
          '        child: TextButton(...),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Invoking Programmatically',
      'color': Colors.deepPurple[600]!,
      'code': '// You can invoke the action manually:\n'
          'final action = Actions.find<DirectionalFocusIntent>(\n'
          '  context,\n'
          ');\n'
          '\n'
          '// Move focus right\n'
          'action.invoke(\n'
          '  DirectionalFocusIntent(\n'
          '    TraversalDirection.right,\n'
          '  ),\n'
          ');\n'
          '\n'
          '// Or use Actions.invoke directly:\n'
          'Actions.invoke(\n'
          '  context,\n'
          '  DirectionalFocusIntent(\n'
          '    TraversalDirection.down,\n'
          '  ),\n'
          ');',
    },
    {
      'title': 'Overriding with Custom Action',
      'color': Colors.purple[700]!,
      'code': '// Override default directional focus behavior\n'
          'Actions(\n'
          '  actions: {\n'
          '    DirectionalFocusIntent: CallbackAction(\n'
          '      onInvoke: (intent) {\n'
          '        final dir =\n'
          '          (intent as DirectionalFocusIntent)\n'
          '              .direction;\n'
          '        print(\'Moving: \$dir\');\n'
          '        // Custom logic here\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: FocusScope(\n'
          '    child: MyGridWidget(),\n'
          '  ),\n'
          ')',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: Comparison Table
  // ============================================================
  print('=== Section 8: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Purpose',
      'directional': 'Spatial (up/down/left/right)',
      'next': 'Sequential (tab order)',
      'previous': 'Reverse sequential',
    },
    {
      'aspect': 'Keys',
      'directional': 'Arrow keys',
      'next': 'Tab',
      'previous': 'Shift+Tab',
    },
    {
      'aspect': 'Resolution',
      'directional': 'Geometry / policy.inDirection()',
      'next': 'Policy.next()',
      'previous': 'Policy.previous()',
    },
    {
      'aspect': 'Intent',
      'directional': 'DirectionalFocusIntent',
      'next': 'NextFocusIntent',
      'previous': 'PreviousFocusIntent',
    },
    {
      'aspect': 'Best for',
      'directional': 'Grids, game pads, TV',
      'next': 'Forms, dialogs, lists',
      'previous': 'Forms, dialogs, lists',
    },
    {
      'aspect': 'Wraps?',
      'directional': 'No (stops at edge)',
      'next': 'Yes (wraps to first)',
      'previous': 'Yes (wraps to last)',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Enabled by Default',
      'body': 'You don\'t need to register DirectionalFocusAction — '
          'Flutter\'s WidgetsApp (and MaterialApp/CupertinoApp) '
          'includes it in the default Actions map. Arrow keys move '
          'focus automatically for any focusable widget.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Directional Focus Doesn\'t Wrap',
      'body': 'Unlike Tab traversal (NextFocusAction), directional '
          'focus does NOT wrap around. If you press Arrow Right at '
          'the rightmost widget, focus stays put. This is intentional — '
          'spatial navigation should respect layout boundaries.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'FocusTraversalGroup Is Your Friend',
      'body': 'Wrap related widgets in FocusTraversalGroup to create '
          'a focus scope with its own policy. Directional focus stays '
          'within the group until you reach an edge, then moves to '
          'the next group. This keeps navigation predictable.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Geometry Must Be Available',
      'body': 'Directional focus relies on widget geometry (size and '
          'position in the viewport). Widgets that are not yet laid out '
          'or are off-screen may not be reachable. Ensure focusable '
          'widgets have been laid out before expecting directional '
          'focus to find them.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'ignoreTextFields Property',
      'body': 'DirectionalFocusIntent has an ignoreTextFields property. '
          'When true (default), the action does NOT move focus away from '
          'text fields — because arrow keys have a different meaning '
          '(cursor movement) inside text fields.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'TV & Accessibility Testing',
      'body': 'Always test directional focus on TV platforms (Android TV, '
          'Apple TV) where arrow keys / D-pad are the primary input. '
          'Also test with keyboard-only navigation for accessibility '
          'compliance. DirectionalFocusAction is the backbone of these.',
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
      title: Text('DirectionalFocusAction'),
      backgroundColor: Colors.deepPurple[700],
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
                colors: [Colors.deepPurple[700]!, Colors.purple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_circle_right, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DirectionalFocusAction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The built-in Action that handles arrow-key focus traversal. '
                  'Responds to DirectionalFocusIntent with a TraversalDirection '
                  'and delegates to FocusTraversalPolicy for spatial resolution.',
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
          _dfHead('1', 'What is DirectionalFocusAction?'),
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

          // ── Section 2: Action/Intent Pattern ──
          _dfHead('2', 'The Action / Intent Pattern'),
          SizedBox(height: 12),
          ...actionIntentPairs.map((aip) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: aip['color'] as Color, width: 4),
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
                        _dfChip(aip['intent'] as String,
                            aip['color'] as Color),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward,
                            size: 14, color: Colors.grey[400]),
                        SizedBox(width: 8),
                        _dfChip(aip['action'] as String,
                            aip['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(aip['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: TraversalDirection ──
          _dfHead('3', 'TraversalDirection Enum'),
          SizedBox(height: 12),
          ...directions.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (d['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(d['arrow'] as String,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: d['color'] as Color)),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d['name'] as String,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(d['description'] as String,
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

          // ── Section 4: Focus Grid ──
          _dfHead('4', 'Focus Grid Visualization'),
          SizedBox(height: 8),
          Text(
            'A 3×3 grid of focusable cells. DirectionalFocusAction moves '
            'focus from [E] in the center to adjacent cells when arrow '
            'keys are pressed.',
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
            child: Column(children: [
              // 3x3 grid
              for (var row = 0; row < 3; row++)
                Padding(
                  padding: EdgeInsets.only(bottom: row < 2 ? 6 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var col = 0; col < 3; col++)
                        Padding(
                          padding: EdgeInsets.only(right: col < 2 ? 6 : 0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (row == 1 && col == 1)
                                  ? Colors.deepPurple[600]
                                  : Colors.deepPurple[100],
                              borderRadius: BorderRadius.circular(8),
                              border: (row == 1 && col == 1)
                                  ? Border.all(
                                      color: Colors.deepPurple[900]!,
                                      width: 3)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                gridLabels[row * 3 + col],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: (row == 1 && col == 1)
                                      ? Colors.white
                                      : Colors.deepPurple[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              SizedBox(height: 14),
              Divider(height: 1, color: Colors.grey[300]),
              SizedBox(height: 10),
              Text('Focus movement from E (center):',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700])),
              SizedBox(height: 8),
              ...gridArrows.map((ga) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color:
                              (ga['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                              (ga['direction'] as String).substring(0, 1),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ga['color'] as Color,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('${ga['direction']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: ga['color'] as Color)),
                      SizedBox(width: 6),
                      Text('→ moves to',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[500])),
                      SizedBox(width: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: (ga['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(ga['to'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: ga['color'] as Color)),
                      ),
                    ]),
                  )),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: FocusTraversalPolicy ──
          _dfHead('5', 'FocusTraversalPolicy Integration'),
          SizedBox(height: 12),
          ...policies.map((p) => Padding(
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
                                  fontFamily: 'monospace',
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (p['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_circle_right,
                                size: 14,
                                color: p['color'] as Color),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                  'Directional: ${p['directional']}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Keyboard Shortcuts ──
          _dfHead('6', 'Keyboard Shortcut Mappings'),
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
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      // Cluster H follow-up: rows below pack Icon(16) +
                      // SizedBox(6) + Text(key, fontSize 10 bold) into this
                      // SizedBox. With width 80 the inner area for the key
                      // text was 58 px, but the longest keys ("Arrow Left"
                      // 10 ch, "Arrow Right" 11 ch) measure ~62-64 px,
                      // producing the observed 4.4 / 5.7 px right overflows
                      // in two of the six rows. Bumped to 100 to accommodate
                      // the longest key with margin. Header text 'Key' (3
                      // chars) is unaffected and still left-aligns; the next
                      // Expanded cell absorbs the change so the visual is
                      // essentially identical.
                      width: 100,
                      child: Text('Key',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      child: Text('Intent Generated',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                ]),
              ),
              ...shortcutMappings.asMap().entries.map((entry) {
                final sm = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(children: [
                    SizedBox(
                      width: 100,
                      child: Row(children: [
                        Icon(sm['icon'] as IconData,
                            size: 16,
                            color: sm['color'] as Color),
                        SizedBox(width: 6),
                        Text(sm['key'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10)),
                      ]),
                    ),
                    Expanded(
                      child: Text(sm['intent'] as String,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: Colors.deepPurple[700])),
                    ),
                  ]),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _dfHead('7', 'Code Patterns'),
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
                                color: Colors.purple[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Comparison Table ──
          _dfHead('8', 'Directional vs Next vs Previous'),
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
                  color: Colors.deepPurple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 60,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Directional',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('Previous',
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
                          width: 60,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['directional'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.deepPurple[700]))),
                      Expanded(
                          child: Text(r['next'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['previous'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dfHead('9', 'Tips & Gotchas'),
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
              'End of DirectionalFocusAction Deep Demo',
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
Widget _dfHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepPurple[700],
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
// Helper: Chip badge for intent/action names
// ──────────────────────────────────────────────────────────
Widget _dfChip(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 150),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
