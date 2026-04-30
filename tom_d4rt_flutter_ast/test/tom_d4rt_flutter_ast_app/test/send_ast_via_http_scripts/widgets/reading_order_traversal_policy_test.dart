// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ReadingOrderTraversalPolicy
// Demonstrates how ReadingOrderTraversalPolicy determines focus
// traversal order based on widget position in reading order:
// top-to-bottom, start-to-end (respecting Directionality).
// Covers the band algorithm, LTR vs RTL, nesting with
// FocusTraversalGroup, and practical navigation patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReadingOrderTraversalPolicy Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ReadingOrderTraversalPolicy?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.sort,
      'title': 'Reading Order Focus',
      'body': 'ReadingOrderTraversalPolicy determines the order in which '
          'focusable widgets receive focus when the user presses Tab. '
          'It sorts nodes by their physical position on screen in '
          '"reading order" — top-to-bottom, start-to-end.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.grid_view,
      'title': 'Band Algorithm',
      'body': 'Nodes are grouped into horizontal bands. Widgets that '
          'vertically overlap are placed in the same band. Within a '
          'band, nodes are sorted by their horizontal position '
          '(left-to-right for LTR, right-to-left for RTL).',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.language,
      'title': 'Directionality Aware',
      'body': 'The policy respects the ambient Directionality. In LTR '
          'locales, Tab moves left→right within each band. In RTL '
          'locales, Tab moves right→left. This matches natural '
          'reading patterns for each locale.',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.keyboard_tab,
      'title': 'Default Tab Policy',
      'body': 'ReadingOrderTraversalPolicy is the default policy used '
          'by FocusTraversalGroup. If you don\'t specify a policy, '
          'Tab/Shift-Tab navigation uses reading order automatically.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Band Algorithm Visualized
  // ============================================================
  print('=== Section 2: Band Algorithm ===');

  // Simulate widgets at various positions grouped into bands
  final bandRows = <Map<String, dynamic>>[
    {
      'band': 'Band A (y: 0–40)',
      'widgets': ['Button 1 (x:10)', 'Button 2 (x:120)', 'Button 3 (x:250)'],
      'color': Colors.indigo[100]!,
      'accent': Colors.indigo[700]!,
      'order': '1 → 2 → 3',
    },
    {
      'band': 'Band B (y: 50–90)',
      'widgets': ['Field A (x:20)', 'Field B (x:180)'],
      'color': Colors.teal[100]!,
      'accent': Colors.teal[700]!,
      'order': '4 → 5',
    },
    {
      'band': 'Band C (y: 100–140)',
      'widgets': ['Checkbox (x:10)', 'Radio (x:100)', 'Switch (x:200)', 'Slider (x:320)'],
      'color': Colors.indigo[100]!,
      'accent': Colors.indigo[600]!,
      'order': '6 → 7 → 8 → 9',
    },
  ];

  print('  Band rows: ${bandRows.length}');

  // ============================================================
  // SECTION 3: Live Traversal Grid
  // ============================================================
  print('=== Section 3: Live Traversal Grid ===');

  // A 3x4 grid of focusable tiles showing reading-order numbering
  final gridItems = <Map<String, dynamic>>[
    {'row': 0, 'col': 0, 'order': 1, 'label': 'A1', 'color': Colors.indigo[400]!},
    {'row': 0, 'col': 1, 'order': 2, 'label': 'A2', 'color': Colors.teal[400]!},
    {'row': 0, 'col': 2, 'order': 3, 'label': 'A3', 'color': Colors.indigo[300]!},
    {'row': 0, 'col': 3, 'order': 4, 'label': 'A4', 'color': Colors.teal[300]!},
    {'row': 1, 'col': 0, 'order': 5, 'label': 'B1', 'color': Colors.teal[400]!},
    {'row': 1, 'col': 1, 'order': 6, 'label': 'B2', 'color': Colors.indigo[400]!},
    {'row': 1, 'col': 2, 'order': 7, 'label': 'B3', 'color': Colors.teal[300]!},
    {'row': 1, 'col': 3, 'order': 8, 'label': 'B4', 'color': Colors.indigo[300]!},
    {'row': 2, 'col': 0, 'order': 9, 'label': 'C1', 'color': Colors.indigo[300]!},
    {'row': 2, 'col': 1, 'order': 10, 'label': 'C2', 'color': Colors.teal[300]!},
    {'row': 2, 'col': 2, 'order': 11, 'label': 'C3', 'color': Colors.indigo[400]!},
    {'row': 2, 'col': 3, 'order': 12, 'label': 'C4', 'color': Colors.teal[400]!},
  ];

  print('  Grid items: ${gridItems.length}');

  // ============================================================
  // SECTION 4: LTR vs RTL Comparison
  // ============================================================
  print('=== Section 4: Directionality ===');

  final ltrOrder = ['1 ← First', '2', '3', '4 ← Last'];
  final rtlOrder = ['4 ← Last', '3', '2', '1 ← First'];

  print('  LTR order: $ltrOrder');
  print('  RTL order: $rtlOrder');

  // ============================================================
  // SECTION 5: Policy Comparison
  // ============================================================
  print('=== Section 5: Policy Comparison ===');

  final policyComparison = <Map<String, dynamic>>[
    {
      'policy': 'ReadingOrderTraversalPolicy',
      'order': 'Screen position (reading)',
      'use': 'Default; general forms',
      'custom': 'None needed',
    },
    {
      'policy': 'OrderedTraversalPolicy',
      'order': 'Explicit FocusOrder values',
      'use': 'Custom tab ordering',
      'custom': 'FocusOrder per widget',
    },
    {
      'policy': 'WidgetOrderTraversalPolicy',
      'order': 'Widget tree order',
      'use': 'When tree order matches',
      'custom': 'None needed',
    },
    {
      'policy': 'NumericFocusOrder',
      'order': 'Numeric value ordering',
      'use': 'Numbered fields',
      'custom': 'order: NumericFocusOrder(n)',
    },
    {
      'policy': 'LexicalFocusOrder',
      'order': 'Lexicographic (alphabetical)',
      'use': 'Named form fields',
      'custom': 'order: LexicalFocusOrder(s)',
    },
  ];

  print('  Policy rows: ${policyComparison.length}');

  // ============================================================
  // SECTION 6: FocusTraversalGroup Nesting
  // ============================================================
  print('=== Section 6: Group Nesting ===');

  final nestingSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Outer Group',
      'detail': 'The outermost FocusTraversalGroup defines the top-level '
          'traversal scope. Tab cycles through its children, including '
          'nested groups, in reading order.',
      'icon': Icons.layers,
      'color': Colors.indigo[700]!,
    },
    {
      'step': 2,
      'title': 'Nested Group Entry',
      'detail': 'When Tab reaches a nested FocusTraversalGroup, focus '
          'enters the group and traverses its children according to '
          'the group\'s own policy (which can differ from the outer).',
      'icon': Icons.subdirectory_arrow_right,
      'color': Colors.teal[700]!,
    },
    {
      'step': 3,
      'title': 'Nested Traversal',
      'detail': 'Within the nested group, Tab follows that group\'s '
          'policy. A form section might use OrderedTraversalPolicy '
          'while the outer page uses ReadingOrderTraversalPolicy.',
      'icon': Icons.tab,
      'color': Colors.indigo[600]!,
    },
    {
      'step': 4,
      'title': 'Group Exit',
      'detail': 'After the last child in the nested group, Tab returns '
          'to the outer group and continues to the next sibling in '
          'reading order. Groups act as traversal "scopes".',
      'icon': Icons.exit_to_app,
      'color': Colors.teal[600]!,
    },
  ];

  print('  Nesting steps: ${nestingSteps.length}');

  // ============================================================
  // SECTION 7: Keyboard Navigation Reference
  // ============================================================
  print('=== Section 7: Keyboard Reference ===');

  final keyboardRef = <Map<String, dynamic>>[
    {'key': 'Tab', 'action': 'Move to next focusable in reading order', 'icon': Icons.keyboard_tab},
    {'key': 'Shift + Tab', 'action': 'Move to previous focusable in reading order', 'icon': Icons.keyboard_return},
    {'key': '↑ Arrow', 'action': 'Move focus up (directional traversal)', 'icon': Icons.arrow_upward},
    {'key': '↓ Arrow', 'action': 'Move focus down (directional traversal)', 'icon': Icons.arrow_downward},
    {'key': '← Arrow', 'action': 'Move focus left (directional traversal)', 'icon': Icons.arrow_back},
    {'key': '→ Arrow', 'action': 'Move focus right (directional traversal)', 'icon': Icons.arrow_forward},
    {'key': 'Space / Enter', 'action': 'Activate focused widget', 'icon': Icons.check_circle_outline},
    {'key': 'Escape', 'action': 'Unfocus / close overlay', 'icon': Icons.cancel_outlined},
  ];

  print('  Keyboard entries: ${keyboardRef.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final bestPractices = <Map<String, dynamic>>[
    {
      'title': 'Use FocusTraversalGroup for sections',
      'detail': 'Wrap logical form sections in FocusTraversalGroup to '
          'create independent traversal scopes. This prevents Tab '
          'from jumping across unrelated sections.',
      'icon': Icons.group_work,
      'badge': 'RECOMMENDED',
      'badgeColor': Colors.green[700]!,
    },
    {
      'title': 'Prefer reading order for general layouts',
      'detail': 'ReadingOrderTraversalPolicy works well for standard '
          'layouts. Only switch to OrderedTraversalPolicy when '
          'visual position doesn\'t match desired tab order.',
      'icon': Icons.auto_awesome,
      'badge': 'DEFAULT',
      'badgeColor': Colors.indigo[700]!,
    },
    {
      'title': 'Test RTL directionality',
      'detail': 'If your app supports RTL locales, verify that your '
          'layout gives a sensible traversal order in both directions. '
          'The band algorithm adapts automatically.',
      'icon': Icons.swap_horiz,
      'badge': 'A11Y',
      'badgeColor': Colors.teal[700]!,
    },
    {
      'title': 'Avoid skip-focus patterns',
      'detail': 'Don\'t hide focusable widgets behind conditions that '
          'make Tab skip items unpredictably. Use canRequestFocus: '
          'false on Focus nodes you want to exclude.',
      'icon': Icons.block,
      'badge': 'CAUTION',
      'badgeColor': Colors.orange[700]!,
    },
    {
      'title': 'Combine with autofocus',
      'detail': 'Set autofocus: true on the first field in a form so '
          'the user can immediately start typing after navigation. '
          'Only one widget per route should have autofocus.',
      'icon': Icons.center_focus_strong,
      'badge': 'TIP',
      'badgeColor': Colors.indigo[600]!,
    },
  ];

  print('  Best practices: ${bestPractices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[800]!, Colors.teal[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.sort, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'ReadingOrderTraversalPolicy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Focus traversal by screen position — top-to-bottom, '
                'start-to-end — the default Tab order for Flutter apps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.indigo[700]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Band Algorithm ----
        _sectionHeader('2. Band Algorithm Visualization', Icons.view_stream, Colors.teal[700]!),
        SizedBox(height: 10),
        Text(
          'Nodes are grouped into horizontal bands by vertical overlap. '
          'Within each band, nodes are sorted by reading direction:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        ...bandRows.map((b) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: b['color'] as Color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (b['accent'] as Color).withValues(alpha: 0.3)),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(b['band'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: b['accent'] as Color)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: b['accent'] as Color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Tab order: ${b['order']}',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: (b['widgets'] as List<String>).map((w) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: (b['accent'] as Color).withValues(alpha: 0.4)),
                            ),
                            child: Text(w, style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                          )).toList(),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Live Traversal Grid ----
        _sectionHeader('3. Traversal Grid (LTR)', Icons.grid_view, Colors.indigo[700]!),
        SizedBox(height: 10),
        Text(
          'Each tile shows its Tab order number. In LTR, traversal goes '
          'left→right within each row, then top→bottom between rows:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        FocusTraversalGroup(
          policy: ReadingOrderTraversalPolicy(),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.4,
            children: gridItems.map((item) => Container(
                  decoration: BoxDecoration(
                    color: item['color'] as Color,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text('${item['order']}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: item['color'] as Color)),
                      ),
                      SizedBox(height: 4),
                      Text(item['label'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                    ],
                  ),
                )).toList(),
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: LTR vs RTL ----
        _sectionHeader('4. LTR vs RTL Directionality', Icons.swap_horiz, Colors.teal[700]!),
        SizedBox(height: 10),
        Row(
          children: [
            // LTR column
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.indigo[300]!),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.indigo[700],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('LTR (English)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    SizedBox(height: 8),
                    Text('→ →', style: TextStyle(fontSize: 20, color: Colors.indigo[400])),
                    SizedBox(height: 6),
                    ...ltrOrder.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(item, style: TextStyle(fontSize: 12, fontFamily: 'monospace'), textAlign: TextAlign.center),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            // RTL column
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal[300]!),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal[700],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('RTL (Arabic)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    SizedBox(height: 8),
                    Text('← ←', style: TextStyle(fontSize: 20, color: Colors.teal[400])),
                    SizedBox(height: 6),
                    ...rtlOrder.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(item, style: TextStyle(fontSize: 12, fontFamily: 'monospace'), textAlign: TextAlign.center),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        // ---- Section 5: Policy Comparison Table ----
        _sectionHeader('5. Traversal Policy Comparison', Icons.compare_arrows, Colors.indigo[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.indigo[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(flex: 4, child: Text('Policy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Ordering', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(policyComparison.length, (i) {
                final p = policyComparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.indigo[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(p['policy'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(p['order'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(p['use'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Group Nesting ----
        _sectionHeader('6. FocusTraversalGroup Nesting', Icons.account_tree, Colors.teal[700]!),
        SizedBox(height: 10),
        ...nestingSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${s['step']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(s['icon'] as IconData, size: 16, color: s['color'] as Color),
                            SizedBox(width: 6),
                            Text(s['title'] as String,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(s['detail'] as String,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 12),

        // Visual nesting example: outer group with two nested groups
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nesting Example', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.indigo[700])),
              SizedBox(height: 8),
              // Outer group label
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FocusTraversalGroup (outer — ReadingOrder)',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.indigo[800])),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        // Nested group 1
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.teal[300]!),
                            ),
                            child: Column(
                              children: [
                                Text('Group A (ReadingOrder)',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.teal[800])),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _orderBadge('1', Colors.teal[600]!),
                                    _orderBadge('2', Colors.teal[600]!),
                                    _orderBadge('3', Colors.teal[600]!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Nested group 2
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.indigo[100],
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.indigo[300]!),
                            ),
                            child: Column(
                              children: [
                                Text('Group B (OrderedPolicy)',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.indigo[800])),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _orderBadge('4', Colors.indigo[600]!),
                                    _orderBadge('5', Colors.indigo[600]!),
                                    _orderBadge('6', Colors.indigo[600]!),
                                  ],
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
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Keyboard Reference ----
        _sectionHeader('7. Keyboard Navigation Reference', Icons.keyboard, Colors.indigo[700]!),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keyboardRef.map((k) => Container(
                width: 160,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(k['icon'] as IconData, size: 16, color: Colors.indigo[600]),
                        SizedBox(width: 6),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.indigo[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(k['key'] as String,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(k['action'] as String, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                  ],
                ),
              )).toList(),
        ),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.star_outline, Colors.teal[700]!),
        SizedBox(height: 10),
        ...bestPractices.map((bp) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(bp['icon'] as IconData, color: bp['badgeColor'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(bp['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: bp['badgeColor'] as Color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(bp['badge'] as String,
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(bp['detail'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Usage Code Example ----
        _sectionHeader('Code Example', Icons.code, Colors.indigo[700]!),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'FocusTraversalGroup(\n'
            '  policy: ReadingOrderTraversalPolicy(),\n'
            '  child: Column(\n'
            '    children: [\n'
            '      TextField(decoration: InputDecoration(\n'
            '        labelText: \'Name\')),\n'
            '      TextField(decoration: InputDecoration(\n'
            '        labelText: \'Email\')),\n'
            '      ElevatedButton(\n'
            '        onPressed: () {},\n'
            '        child: Text(\'Submit\'),\n'
            '      ),\n'
            '    ],\n'
            '  ),\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.greenAccent[200]),
          ),
        ),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.sort, color: Colors.indigo[600], size: 28),
              SizedBox(height: 6),
              Text(
                'ReadingOrderTraversalPolicy: the invisible hand that '
                'guides Tab navigation through your UI in the natural '
                'reading order of each locale.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}

Widget _orderBadge(String num, Color color) {
  return Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(num, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
  );
}
