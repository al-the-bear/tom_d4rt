// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FocusTraversalOrder
// Demonstrates FocusTraversalOrder, the widget that assigns explicit
// traversal ordering to focusable children. Covers NumericFocusOrder,
// LexicalFocusOrder, FocusTraversalGroup, and practical patterns for
// controlling Tab-key navigation in complex layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusTraversalOrder Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusTraversalOrder?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.sort,
      'title': 'Explicit Tab Order',
      'body': 'FocusTraversalOrder is a widget that wraps a focusable '
          'child and assigns it a specific position in the Tab-key '
          'traversal sequence. Without it, Flutter uses the default '
          'reading-order (top-to-bottom, left-to-right). With it, you '
          'control EXACTLY which widget gets focus next.',
      'accent': Colors.purple[700]!,
    },
    {
      'icon': Icons.format_list_numbered,
      'title': 'Order Objects',
      'body': 'The order property takes a FocusOrder subclass. '
          'Flutter provides NumericFocusOrder (double-based ordering) '
          'and LexicalFocusOrder (string-based alphabetical ordering). '
          'You can also create custom FocusOrder subclasses by '
          'implementing doCompare().',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.group_work,
      'title': 'Works with FocusTraversalGroup',
      'body': 'FocusTraversalOrder only works inside a '
          'FocusTraversalGroup that uses OrderedTraversalPolicy. '
          'The group defines the boundary; the order widgets define '
          'the sequence within that boundary.',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'Accessibility Foundation',
      'body': 'Explicit traversal order is critical for accessible '
          'applications. Screen readers and keyboard-only users rely '
          'on a logical Tab order. FocusTraversalOrder ensures the '
          'Tab sequence matches the user\'s mental model.',
      'accent': Colors.deepPurple[500]!,
    },
  ];

  print('  Prepared ${conceptPoints.length} concept points');

  // ============================================================
  // SECTION 2: Widget Anatomy
  // ============================================================
  print('=== Section 2: Widget Anatomy ===');

  final anatomyParts = <Map<String, dynamic>>[
    {
      'part': 'FocusTraversalOrder',
      'role': 'Wrapper widget',
      'icon': Icons.wrap_text,
      'color': Colors.purple[600]!,
      'description': 'The outer widget that attaches an order to its '
          'child. It\'s an InheritedWidget — it doesn\'t render '
          'anything itself, it just annotates the subtree.',
    },
    {
      'part': 'order (FocusOrder)',
      'role': 'Required property',
      'icon': Icons.tag,
      'color': Colors.deepPurple[600]!,
      'description': 'A FocusOrder instance that determines where this '
          'child sits in the traversal sequence. Lower values come '
          'first. Comparison is type-specific.',
    },
    {
      'part': 'child (Widget)',
      'role': 'Required property',
      'icon': Icons.child_care,
      'color': Colors.purple[500]!,
      'description': 'The focusable widget (or subtree containing '
          'focusable widgets) to which the order applies. The child '
          'itself must be focusable (e.g., TextField, Button, Focus).',
    },
    {
      'part': 'FocusTraversalGroup',
      'role': 'Required ancestor',
      'icon': Icons.folder,
      'color': Colors.deepPurple[500]!,
      'description': 'A FocusTraversalGroup with OrderedTraversalPolicy '
          'must be an ancestor. Without it, FocusTraversalOrder has no '
          'effect — the default ReadingOrderTraversalPolicy ignores '
          'explicit order annotations.',
    },
    {
      'part': 'OrderedTraversalPolicy',
      'role': 'Policy',
      'icon': Icons.policy,
      'color': Colors.purple[700]!,
      'description': 'The traversal policy that reads FocusTraversalOrder '
          'annotations. Assigned to FocusTraversalGroup via its policy '
          'parameter. Sorts children by their FocusOrder values.',
    },
  ];

  print('  Prepared ${anatomyParts.length} anatomy parts');

  // ============================================================
  // SECTION 3: NumericFocusOrder
  // ============================================================
  print('=== Section 3: NumericFocusOrder ===');

  final numericExamples = <Map<String, dynamic>>[
    {
      'order': 1.0,
      'label': 'Submit Button',
      'icon': Icons.send,
      'color': Colors.purple[700]!,
      'note': 'Gets focus first (lowest number)',
    },
    {
      'order': 2.0,
      'label': 'Email Field',
      'icon': Icons.email,
      'color': Colors.purple[600]!,
      'note': 'Gets focus second',
    },
    {
      'order': 3.0,
      'label': 'Password Field',
      'icon': Icons.lock,
      'color': Colors.purple[500]!,
      'note': 'Gets focus third',
    },
    {
      'order': 4.5,
      'label': 'Cancel Button',
      'icon': Icons.cancel,
      'color': Colors.purple[400]!,
      'note': 'Decimals are fine — 4.5 after 4.0',
    },
    {
      'order': 10.0,
      'label': 'Help Link',
      'icon': Icons.help,
      'color': Colors.purple[300]!,
      'note': 'Gaps in numbers are OK — easy to insert later',
    },
    {
      'order': -1.0,
      'label': 'Skip Navigation',
      'icon': Icons.skip_next,
      'color': Colors.deepPurple[700]!,
      'note': 'Negative numbers work — comes before 1.0',
    },
  ];

  print('  Prepared ${numericExamples.length} numeric order examples');

  // ============================================================
  // SECTION 4: LexicalFocusOrder
  // ============================================================
  print('=== Section 4: LexicalFocusOrder ===');

  final lexicalExamples = <Map<String, dynamic>>[
    {
      'order': 'a-submit',
      'label': 'Submit Button',
      'icon': Icons.send,
      'color': Colors.deepPurple[700]!,
      'note': '"a-" prefix means first alphabetically',
    },
    {
      'order': 'b-email',
      'label': 'Email Field',
      'icon': Icons.email,
      'color': Colors.deepPurple[600]!,
      'note': '"b-" prefix means second',
    },
    {
      'order': 'c-password',
      'label': 'Password Field',
      'icon': Icons.lock,
      'color': Colors.deepPurple[500]!,
      'note': '"c-" prefix means third',
    },
    {
      'order': 'z-help',
      'label': 'Help Link',
      'icon': Icons.help,
      'color': Colors.deepPurple[400]!,
      'note': '"z-" prefix pushes to the end',
    },
  ];

  print('  Prepared ${lexicalExamples.length} lexical order examples');

  // ============================================================
  // SECTION 5: Default vs Explicit Ordering
  // ============================================================
  print('=== Section 5: Default vs Explicit ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Policy Used',
      'default_': 'ReadingOrderTraversalPolicy',
      'explicit': 'OrderedTraversalPolicy',
    },
    {
      'aspect': 'How Order Is Determined',
      'default_': 'Visual position on screen '
          '(top→bottom, left→right)',
      'explicit': 'FocusTraversalOrder annotations '
          '(numbers or strings)',
    },
    {
      'aspect': 'Setup Required',
      'default_': 'None — this is the default',
      'explicit': 'FocusTraversalGroup + '
          'FocusTraversalOrder on each child',
    },
    {
      'aspect': 'When Layout Changes',
      'default_': 'Order changes with visual '
          'position (may surprise users)',
      'explicit': 'Order stays fixed regardless '
          'of layout changes',
    },
    {
      'aspect': 'Best For',
      'default_': 'Simple linear layouts '
          '(forms, lists)',
      'explicit': 'Complex layouts, grids, '
          'toolbars, non-linear flows',
    },
    {
      'aspect': 'Accessibility',
      'default_': 'Good for visually ordered UIs',
      'explicit': 'Required when visual order '
          'doesn\'t match logical order',
    },
    {
      'aspect': 'Maintenance',
      'default_': 'Zero maintenance — automatic',
      'explicit': 'Must update order values when '
          'adding/removing widgets',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 6: FocusTraversalGroup Patterns
  // ============================================================
  print('=== Section 6: Group Patterns ===');

  final groupPatterns = <Map<String, dynamic>>[
    {
      'name': 'Single Ordered Group',
      'icon': Icons.view_list,
      'color': Colors.purple[600]!,
      'code': 'FocusTraversalGroup(\n'
          '  policy: OrderedTraversalPolicy(),\n'
          '  child: Column(\n'
          '    children: [\n'
          '      FocusTraversalOrder(\n'
          '        order: NumericFocusOrder(2),\n'
          '        child: TextField(),  // 2nd\n'
          '      ),\n'
          '      FocusTraversalOrder(\n'
          '        order: NumericFocusOrder(1),\n'
          '        child: TextField(),  // 1st\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
      'description': 'Simplest pattern — one group with ordered '
          'children. Tab goes to order 1 first, then order 2, '
          'regardless of their position in the Column.',
    },
    {
      'name': 'Nested Groups',
      'icon': Icons.account_tree,
      'color': Colors.deepPurple[600]!,
      'code': 'FocusTraversalGroup(\n'
          '  policy: OrderedTraversalPolicy(),\n'
          '  child: Row([\n'
          '    FocusTraversalGroup(  // Sidebar\n'
          '      child: Column([...]),\n'
          '    ),\n'
          '    FocusTraversalGroup(  // Content\n'
          '      child: Column([...]),\n'
          '    ),\n'
          '  ]),\n'
          ')',
      'description': 'Each group is traversed completely before '
          'moving to the next. Tab goes through all sidebar items, '
          'then all content items. Groups themselves can be ordered.',
    },
    {
      'name': 'Mixed: Ordered + Reading',
      'icon': Icons.shuffle,
      'color': Colors.purple[500]!,
      'code': 'FocusTraversalGroup(\n'
          '  policy: OrderedTraversalPolicy(),\n'
          '  child: Row([\n'
          '    FocusTraversalOrder(\n'
          '      order: NumericFocusOrder(2),\n'
          '      child: FocusTraversalGroup(\n'
          '        // Uses default reading order\n'
          '        child: Column([...]),\n'
          '      ),\n'
          '    ),\n'
          '    FocusTraversalOrder(\n'
          '      order: NumericFocusOrder(1),\n'
          '      child: inputField,\n'
          '    ),\n'
          '  ]),\n'
          ')',
      'description': 'The outer group uses explicit ordering, but a '
          'nested group can use reading-order within itself. This '
          'gives segment-level control with automatic intra-segment '
          'ordering.',
    },
  ];

  print('  Prepared ${groupPatterns.length} group patterns');

  // ============================================================
  // SECTION 7: Custom FocusOrder
  // ============================================================
  print('=== Section 7: Custom FocusOrder ===');

  final customOrderSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Extend FocusOrder',
      'icon': Icons.code,
      'color': Colors.deepPurple[700]!,
      'description': 'Create a class that extends FocusOrder. '
          'Add whatever properties you need for your ordering '
          'logic (priority, category, creation time, etc.).',
    },
    {
      'step': '2',
      'title': 'Implement doCompare()',
      'icon': Icons.compare_arrows,
      'color': Colors.purple[600]!,
      'description': 'Override doCompare(FocusOrder other) and return '
          'negative (this before other), zero (equal), or positive '
          '(this after other). This defines your custom sort logic.',
    },
    {
      'step': '3',
      'title': 'Use with FocusTraversalOrder',
      'icon': Icons.wrap_text,
      'color': Colors.deepPurple[600]!,
      'description': 'Pass an instance of your custom FocusOrder to '
          'FocusTraversalOrder(order: MyCustomOrder(...)). The '
          'OrderedTraversalPolicy will call your doCompare() to sort.',
    },
    {
      'step': '4',
      'title': 'Example: PriorityFocusOrder',
      'icon': Icons.star,
      'color': Colors.purple[500]!,
      'description': 'A custom order that sorts by priority (high, '
          'medium, low) then by name. High-priority widgets get focus '
          'first. Within the same priority, alphabetical order.',
    },
  ];

  print('  Prepared ${customOrderSteps.length} custom order steps');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'title': 'Form Field Reordering',
      'icon': Icons.text_fields,
      'color': Colors.purple[700]!,
      'body': 'In a two-column form, the visual order is left-right '
          'but the logical order should be top-to-bottom within each '
          'section. Use FocusTraversalOrder to make Tab go through '
          'personal info first, then address fields, regardless of '
          'column layout.',
    },
    {
      'title': 'Toolbar Priority',
      'icon': Icons.construction,
      'color': Colors.deepPurple[600]!,
      'body': 'Give primary actions (Save, Submit) lower order '
          'numbers and secondary actions (Cancel, Help) higher '
          'numbers. Keyboard users reach the most important buttons '
          'first without tabbing through the entire toolbar.',
    },
    {
      'title': 'Dialog Focus Flow',
      'icon': Icons.open_in_new,
      'color': Colors.purple[600]!,
      'body': 'In a confirmation dialog: order 1 = message text, '
          'order 2 = primary action button (Confirm), order 3 = '
          'secondary action (Cancel). The user can Tab directly to '
          'the confirm button without passing through decorative '
          'elements.',
    },
    {
      'title': 'Grid → Logical Sequence',
      'icon': Icons.grid_on,
      'color': Colors.deepPurple[500]!,
      'body': 'A settings grid shows toggles in a 3×3 layout. '
          'Reading order would zigzag. Use NumericFocusOrder to '
          'create a column-first traversal: all toggles in column 1, '
          'then column 2, then column 3.',
    },
    {
      'title': 'Skip Decorative Elements',
      'icon': Icons.skip_next,
      'color': Colors.purple[500]!,
      'body': 'Give large order numbers (e.g., 999) to decorative '
          'but focusable items (dividers with tooltips, info icons). '
          'Users tab through actionable items first. Or use '
          'ExcludeFocus to remove them from traversal entirely.',
    },
  ];

  print('  Prepared ${realWorldPatterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Must Have OrderedTraversalPolicy',
      'body': 'FocusTraversalOrder is IGNORED unless an ancestor '
          'FocusTraversalGroup has policy: OrderedTraversalPolicy(). '
          'This is the #1 reason explicit ordering doesn\'t work — '
          'the policy is missing.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use Gaps in Order Numbers',
      'body': 'Don\'t use 1, 2, 3 — use 10, 20, 30. This leaves '
          'room to insert items later (15 goes between 10 and 20) '
          'without renumbering everything.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'FocusTraversalOrder.of(context)',
      'body': 'You can read the order assigned to any context with '
          'FocusTraversalOrder.of(context). Returns null if no order '
          'is set. Useful for debugging traversal issues.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Mix Order Types',
      'body': 'All children within a single FocusTraversalGroup '
          'should use the SAME FocusOrder type. Mixing '
          'NumericFocusOrder and LexicalFocusOrder in one group '
          'throws an assertion error.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Order Doesn\'t Affect Z-Order',
      'body': 'FocusTraversalOrder only affects keyboard traversal '
          '(Tab/Shift+Tab). It does NOT change paint order, '
          'hit-testing, or any visual layering.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Tab Key',
      'body': 'The easiest way to verify traversal order: run the '
          'app on desktop and press Tab repeatedly. Watch which '
          'widget gets focus. If the sequence doesn\'t match your '
          'order values, check that the policy is correct.',
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
      title: Text('FocusTraversalOrder'),
      backgroundColor: Colors.purple[700],
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
                colors: [Colors.purple[700]!, Colors.deepPurple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.sort, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FocusTraversalOrder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Explicit Tab-key ordering for focusable widgets — '
                  'assigns a specific position in the traversal '
                  'sequence using NumericFocusOrder or LexicalFocusOrder.',
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
          _secLabel('1', 'What is FocusTraversalOrder?'),
          SizedBox(height: 12),
          ...conceptPoints.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['accent'] as Color, width: 4),
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
                        Icon(cp['icon'] as IconData,
                            color: cp['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(cp['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(cp['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Widget Anatomy ──
          _secLabel('2', 'Widget Anatomy'),
          SizedBox(height: 12),
          ...anatomyParts.map((part) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (part['color'] as Color).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (part['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: part['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(part['icon'] as IconData,
                              color: Colors.white, size: 16),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(part['part'] as String,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: part['color'] as Color)),
                              Text(part['role'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(part['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: NumericFocusOrder ──
          _secLabel('3', 'NumericFocusOrder'),
          SizedBox(height: 8),
          Text(
            'NumericFocusOrder uses a double value to sort. Lower '
            'values come first. Decimals and negatives are supported.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          ...numericExamples.map((ex) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ex['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    children: [
                      _orderBadge(ex['order'].toString(),
                          ex['color'] as Color),
                      SizedBox(width: 12),
                      Icon(ex['icon'] as IconData,
                          color: ex['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex['label'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            Text(ex['note'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: LexicalFocusOrder ──
          _secLabel('4', 'LexicalFocusOrder'),
          SizedBox(height: 8),
          Text(
            'LexicalFocusOrder uses a string and sorts '
            'alphabetically. Useful when meaningful names are '
            'more readable than numbers in code.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          ...lexicalExamples.map((ex) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ex['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ex['color'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('"${ex['order']}"',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace')),
                      ),
                      SizedBox(width: 12),
                      Icon(ex['icon'] as IconData,
                          color: ex['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex['label'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            Text(ex['note'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Comparison Table ──
          _secLabel('5', 'Default vs Explicit Ordering'),
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
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 3,
                      child: Text('Default (Reading)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 3,
                      child: Text('Explicit (Ordered)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11))),
                      Expanded(
                          flex: 3,
                          child: Text(row['default_']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['explicit']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Group Patterns ──
          _secLabel('6', 'FocusTraversalGroup Patterns'),
          SizedBox(height: 12),
          ...groupPatterns.map((gp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: gp['color'] as Color, width: 4),
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
                        Icon(gp['icon'] as IconData,
                            color: gp['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(gp['name'] as String,
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
                          color:
                              (gp['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(gp['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(gp['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Custom FocusOrder ──
          _secLabel('7', 'Custom FocusOrder'),
          SizedBox(height: 12),
          ...customOrderSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: step['color'] as Color, width: 4),
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
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: step['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(step['step'] as String,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(step['icon'] as IconData,
                            color: step['color'] as Color, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(step['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(step['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _secLabel('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realWorldPatterns.map((rp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: rp['color'] as Color, width: 4),
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
                        Icon(rp['icon'] as IconData,
                            color: rp['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rp['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(rp['body'] as String,
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
          _secLabel('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FocusTraversalOrder Deep Demo',
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
// Helper: Section label with numbered badge
// ──────────────────────────────────────────────────────────
Widget _secLabel(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.purple[700],
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
// Helper: Numeric order badge
// ──────────────────────────────────────────────────────────
Widget _orderBadge(String value, Color color) {
  return Container(
    width: 44,
    height: 28,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Text(value,
          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace')),
    ),
  );
}
