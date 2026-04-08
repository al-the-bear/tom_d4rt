// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — FocusOrder
// Demonstrates FocusOrder — the abstract base class for defining
// custom focus traversal ordering. Covers NumericFocusOrder,
// LexicalFocusOrder, the doCompare protocol, OrderedTraversalPolicy,
// visual traversal demonstrations, and practical patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusOrder Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusOrder?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.sort,
      'title': 'Custom Focus Traversal Order',
      'body': 'FocusOrder is an abstract class that defines a sort '
          'order for focusable widgets. Instead of relying on widget '
          'tree position (top-to-bottom, left-to-right), you assign '
          'explicit ordering to each focusable element. When the user '
          'presses Tab, focus moves in your defined order.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.format_list_numbered,
      'title': 'Works with OrderedTraversalPolicy',
      'body': 'FocusOrder alone doesn\'t do anything. It must be used '
          'with a FocusTraversalGroup that has an '
          'OrderedTraversalPolicy. The policy collects all focusable '
          'children, sorts them by their FocusOrder, and tab-navigates '
          'in that sorted order.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.extension,
      'title': 'Extensible via Subclasses',
      'body': 'Flutter provides two built-in subclasses: '
          'NumericFocusOrder (sort by double value) and '
          'LexicalFocusOrder (sort alphabetically by string). '
          'You can create custom subclasses for complex ordering '
          'like grid coordinates, priority queues, or groups.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Comparable Protocol',
      'body': 'FocusOrder extends Comparable<FocusOrder> but only '
          'between instances of the same subclass. Comparing a '
          'NumericFocusOrder with a LexicalFocusOrder throws. This '
          'ensures type-safe ordering within each traversal group.',
      'accent': Colors.cyan[800]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Built-in Subclasses
  // ============================================================
  print('=== Section 2: Subclasses ===');

  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'NumericFocusOrder',
      'icon': Icons.pin,
      'color': Colors.teal[700]!,
      'constructor': 'NumericFocusOrder(3.0)',
      'description': 'Orders by a double value. Lower numbers come '
          'first. This is the most common ordering: assign 1.0, '
          '2.0, 3.0 to your widgets and focus will traverse in '
          'that numeric sequence.',
      'sortBy': 'double order value',
      'example': '1.0 → "First Name", 2.0 → "Last Name", '
          '3.0 → "Email", 4.0 → "Submit"',
    },
    {
      'name': 'LexicalFocusOrder',
      'icon': Icons.sort_by_alpha,
      'color': Colors.cyan[700]!,
      'constructor': 'LexicalFocusOrder(\'b-lastname\')',
      'description': 'Orders alphabetically by a string key. Useful '
          'when you want human-readable ordering or when the order '
          'is derived from data keys rather than numeric indices.',
      'sortBy': 'String.compareTo() alphabetical order',
      'example': '\'a-first\' → \'b-last\' → \'c-email\' → '
          '\'d-submit\'',
    },
  ];

  print('  Prepared ${subclasses.length} subclasses');

  // ============================================================
  // SECTION 3: Visual Traversal Comparison
  // ============================================================
  print('=== Section 3: Traversal Comparison ===');

  // Show a grid of numbered elements in tree order vs custom order
  final treeOrder = <Map<String, dynamic>>[
    {'label': 'Row 1 Left', 'position': 1, 'color': Colors.grey[400]!},
    {'label': 'Row 1 Right', 'position': 2, 'color': Colors.grey[400]!},
    {'label': 'Row 2 Left', 'position': 3, 'color': Colors.grey[400]!},
    {'label': 'Row 2 Right', 'position': 4, 'color': Colors.grey[400]!},
    {'label': 'Row 3 Left', 'position': 5, 'color': Colors.grey[400]!},
    {'label': 'Row 3 Right', 'position': 6, 'color': Colors.grey[400]!},
  ];

  final customOrder = <Map<String, dynamic>>[
    {'label': 'Row 1 Left', 'position': 1, 'color': Colors.teal[400]!},
    {'label': 'Row 1 Right', 'position': 4, 'color': Colors.teal[400]!},
    {'label': 'Row 2 Left', 'position': 2, 'color': Colors.cyan[400]!},
    {'label': 'Row 2 Right', 'position': 5, 'color': Colors.cyan[400]!},
    {'label': 'Row 3 Left', 'position': 3, 'color': Colors.teal[300]!},
    {'label': 'Row 3 Right', 'position': 6, 'color': Colors.teal[300]!},
  ];

  print('  Prepared ${treeOrder.length + customOrder.length} traversal items');

  // ============================================================
  // SECTION 4: The doCompare Protocol
  // ============================================================
  print('=== Section 4: doCompare Protocol ===');

  final compareSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'compareTo() called',
      'icon': Icons.compare_arrows,
      'color': Colors.teal[700]!,
      'detail': 'When the policy sorts focusable children, it calls '
          'a.compareTo(b) on their FocusOrder objects. This is the '
          'public entry point defined on the base class.',
    },
    {
      'step': 2,
      'label': 'Type check performed',
      'icon': Icons.security,
      'color': Colors.cyan[700]!,
      'detail': 'compareTo checks that both instances are the same '
          'concrete type. If you compare NumericFocusOrder with '
          'LexicalFocusOrder, it throws an assertion error. This '
          'prevents nonsensical cross-type comparisons.',
    },
    {
      'step': 3,
      'label': 'doCompare() delegated',
      'icon': Icons.code,
      'color': Colors.teal[600]!,
      'detail': 'After the type check passes, compareTo delegates to '
          'your subclass\'s doCompare(other). You implement the '
          'actual ordering logic here. Return negative, zero, or '
          'positive following standard Comparable protocol.',
    },
    {
      'step': 4,
      'label': 'Sort result applied',
      'icon': Icons.sort,
      'color': Colors.cyan[800]!,
      'detail': 'The policy uses the comparison results to sort all '
          'focusable children. Tab traversal then follows this '
          'sorted order. The entire process happens transparently '
          'when the user presses Tab.',
    },
  ];

  print('  Prepared ${compareSteps.length} compare steps');

  // ============================================================
  // SECTION 5: Widget Tree Integration
  // ============================================================
  print('=== Section 5: Widget Integration ===');

  final widgetIntegration = <Map<String, dynamic>>[
    {
      'name': 'FocusTraversalOrder widget',
      'icon': Icons.reorder,
      'color': Colors.teal[700]!,
      'role': 'Assigns order',
      'description': 'Wrap any focusable widget in FocusTraversalOrder '
          'to assign a FocusOrder value. This widget is an '
          'InheritedWidget that the traversal policy reads during '
          'sorting. Must be a descendant of a FocusTraversalGroup.',
    },
    {
      'name': 'FocusTraversalGroup widget',
      'icon': Icons.workspaces,
      'color': Colors.cyan[700]!,
      'role': 'Defines scope',
      'description': 'Groups focusable descendants under one traversal '
          'policy. Set policy: OrderedTraversalPolicy() to enable '
          'FocusOrder-based traversal. Without this group, the '
          'FocusTraversalOrder widgets have no effect.',
    },
    {
      'name': 'OrderedTraversalPolicy',
      'icon': Icons.sort,
      'color': Colors.teal[600]!,
      'role': 'Sorts by order',
      'description': 'The traversal policy that honors FocusOrder. It '
          'collects all children with FocusTraversalOrder, sorts them '
          'by their FocusOrder value, and traverses in that order. '
          'Children without an order are placed at the end.',
    },
    {
      'name': 'Focus / FocusableActionDetector',
      'icon': Icons.center_focus_weak,
      'color': Colors.cyan[800]!,
      'role': 'Receives focus',
      'description': 'The actual focusable widgets. They don\'t know '
          'about ordering — they just participate in focus. The order '
          'is determined externally by the FocusTraversalOrder '
          'wrapper and the policy.',
    },
  ];

  print('  Prepared ${widgetIntegration.length} integration points');

  // ============================================================
  // SECTION 6: Numeric Ordering Examples
  // ============================================================
  print('=== Section 6: Numeric Examples ===');

  final numExamples = <Map<String, dynamic>>[
    {
      'label': 'Simple form',
      'items': [
        {'field': 'First Name', 'order': 1.0},
        {'field': 'Last Name', 'order': 2.0},
        {'field': 'Email', 'order': 3.0},
        {'field': 'Password', 'order': 4.0},
        {'field': 'Submit', 'order': 5.0},
      ],
      'color': Colors.teal[700]!,
      'note': 'Sequential integer ordering — simplest case',
    },
    {
      'label': 'Grid with column-first order',
      'items': [
        {'field': 'Cell (0,0)', 'order': 0.0},
        {'field': 'Cell (1,0)', 'order': 0.1},
        {'field': 'Cell (2,0)', 'order': 0.2},
        {'field': 'Cell (0,1)', 'order': 1.0},
        {'field': 'Cell (1,1)', 'order': 1.1},
        {'field': 'Cell (2,1)', 'order': 1.2},
      ],
      'color': Colors.cyan[700]!,
      'note': 'Using decimals for column-first traversal in a grid',
    },
    {
      'label': 'Insertable ordering',
      'items': [
        {'field': 'Header', 'order': 10.0},
        {'field': 'Search', 'order': 20.0},
        {'field': 'NEW: Filter', 'order': 15.0},
        {'field': 'Results', 'order': 30.0},
      ],
      'color': Colors.teal[600]!,
      'note': 'Leave gaps (10, 20, 30) so new items can be inserted '
          'without renumbering all existing items',
    },
  ];

  print('  Prepared ${numExamples.length} numeric examples');

  // ============================================================
  // SECTION 7: Custom FocusOrder Subclass
  // ============================================================
  print('=== Section 7: Custom Subclass ===');

  final customFields = <Map<String, dynamic>>[
    {
      'name': 'Grid Coordinate Order',
      'icon': Icons.grid_on,
      'color': Colors.teal[700]!,
      'description': 'A custom FocusOrder that takes (row, col) '
          'coordinates. doCompare first compares rows, then columns. '
          'This gives row-major traversal in a grid layout where '
          'numeric order alone would be awkward.',
      'fields': 'int row, int col',
      'compare': 'row != other.row ? row - other.row : col - other.col',
    },
    {
      'name': 'Priority + Timestamp Order',
      'icon': Icons.priority_high,
      'color': Colors.cyan[700]!,
      'description': 'A custom order for task lists: sort by priority '
          'first (high before low), then by creation time for items '
          'with the same priority. Focus goes to urgent items first.',
      'fields': 'int priority, DateTime created',
      'compare': 'priority != other.priority ? priority - other.priority '
          ': created.compareTo(other.created)',
    },
    {
      'name': 'Semantic Group Order',
      'icon': Icons.category,
      'color': Colors.teal[600]!,
      'description': 'A custom order that groups widgets by semantic '
          'category (header, nav, content, footer) with ordering '
          'within each group. Ensures focus traversal follows '
          'logical page structure rather than DOM order.',
      'fields': 'String group, int index',
      'compare': 'group != other.group ? groupRank(group) - '
          'groupRank(other.group) : index - other.index',
    },
  ];

  print('  Prepared ${customFields.length} custom order designs');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Accessible Form Navigation',
      'icon': Icons.description,
      'color': Colors.teal[700]!,
      'description': 'Use NumericFocusOrder to ensure form fields are '
          'navigated in label order, not layout order. In a two-column '
          'form, fields might be laid out left-right but should be '
          'navigated top-to-bottom in reading order.',
    },
    {
      'name': 'Toolbar with Priority',
      'icon': Icons.view_headline,
      'color': Colors.cyan[700]!,
      'description': 'In a toolbar, the most important actions should '
          'receive focus first. Assign lower order numbers to primary '
          'actions, higher to secondary. Tab jumps to the most useful '
          'button first.',
    },
    {
      'name': 'Dialog Focus Flow',
      'icon': Icons.open_in_new,
      'color': Colors.teal[600]!,
      'description': 'In a dialog, focus should flow: title field → '
          'body field → secondary button → primary button. The primary '
          'button is visually to the right but should be reached last. '
          'FocusOrder makes this explicit.',
    },
    {
      'name': 'Dashboard Tile Navigation',
      'icon': Icons.dashboard,
      'color': Colors.cyan[800]!,
      'description': 'A dashboard with tiles of varying sizes. The '
          'default tree-order traversal might be wrong because tiles '
          'are in a Wrap or GridView. NumericFocusOrder ensures '
          'meaningful left-to-right, top-to-bottom navigation.',
    },
    {
      'name': 'Keyboard-First App',
      'icon': Icons.keyboard,
      'color': Colors.teal[800]!,
      'description': 'For apps designed for keyboard power users '
          '(IDEs, data entry), define a comprehensive focus order '
          'across all panels. Use FocusTraversalGroup per panel '
          'with inter-panel ordering via numeric values.',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Leave Gaps in Numeric Order',
      'body': 'Use 10, 20, 30 instead of 1, 2, 3. This lets you '
          'insert new items between existing ones (15) without '
          'renumbering everything. Especially important for '
          'dynamically generated UI.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'All Children Must Use Same Type',
      'body': 'Within one FocusTraversalGroup, all FocusTraversalOrder '
          'widgets must use the same FocusOrder subclass. Mixing '
          'NumericFocusOrder with LexicalFocusOrder in the same '
          'group throws an assertion error during sort.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test Tab Navigation',
      'body': 'Always test your focus ordering by pressing Tab '
          'repeatedly in your app. This is the fastest way to '
          'verify that FocusOrder values produce the intended '
          'traversal sequence.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Group Without Policy Has No Effect',
      'body': 'FocusTraversalOrder widgets are ignored unless their '
          'enclosing FocusTraversalGroup uses OrderedTraversalPolicy. '
          'The default policy (WidgetOrderTraversalPolicy) ignores '
          'order annotations entirely.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Unordered Children Go Last',
      'body': 'If some children have FocusTraversalOrder and others '
          'don\'t, the ordered ones come first (sorted by their '
          'order) and the unordered ones follow in widget tree order. '
          'Use this to prioritize key elements.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with FocusTraversalGroup',
      'body': 'Nest FocusTraversalGroup widgets for hierarchical '
          'ordering. Each group is its own traversal domain. The '
          'outer group orders the inner groups, and each inner '
          'group orders its own children independently.',
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
      title: Text('FocusOrder'),
      backgroundColor: Colors.teal[700],
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
                colors: [Colors.teal[700]!, Colors.cyan[700]!],
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
                  'FocusOrder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Abstract base class for defining focus traversal '
                  'order. Subclasses define how focusable widgets are '
                  'sorted when the user presses Tab. Works with '
                  'OrderedTraversalPolicy and FocusTraversalOrder.',
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
          _ordHead('1', 'What is FocusOrder?'),
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

          // ── Section 2: Subclasses ──
          _ordHead('2', 'Built-in Subclasses'),
          SizedBox(height: 12),
          ...subclasses.map((sc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border(
                      left: BorderSide(
                          color: sc['color'] as Color, width: 5),
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
                        Icon(sc['icon'] as IconData,
                            color: sc['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(sc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: sc['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(sc['constructor'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: Colors.teal[300])),
                      ),
                      SizedBox(height: 8),
                      Text(sc['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Row(children: [
                        Text('Sort by: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),
                        Expanded(
                          child: Text(sc['sortBy'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600])),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: (sc['color'] as Color).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(sc['example'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[700],
                                fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Traversal Comparison ──
          _ordHead('3', 'Tree Order vs Custom Order'),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tree order column
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                    Text('Default (Tree Order)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.grey[700])),
                    SizedBox(height: 8),
                    ...treeOrder.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text('${item['position']}',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(item['label'] as String,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white)),
                            ]),
                          ),
                        )),
                  ]),
                ),
              ),
              SizedBox(width: 8),
              // Custom order column
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                    Text('Column-First Order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.teal[700])),
                    SizedBox(height: 8),
                    ...customOrder.map((item) => Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text('${item['position']}',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(item['label'] as String,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white)),
                            ]),
                          ),
                        )),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Left: 1→2→3→4→5→6 (row by row, default)\n'
              'Right: 1→2→3→4→5→6 (column by column, custom order)',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.teal[900],
                  height: 1.4),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: doCompare ──
          _ordHead('4', 'The doCompare Protocol'),
          SizedBox(height: 12),
          ...compareSteps.map((cs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: cs['color'] as Color, width: 4),
                    ),
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
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: cs['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${cs['step']}',
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
                              Icon(cs['icon'] as IconData,
                                  color: cs['color'] as Color,
                                  size: 14),
                              SizedBox(width: 4),
                              Text(cs['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ]),
                            SizedBox(height: 3),
                            Text(cs['detail'] as String,
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

          // ── Section 5: Widget Integration ──
          _ordHead('5', 'Widget Tree Integration'),
          SizedBox(height: 12),
          ...widgetIntegration.map((wi) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: wi['color'] as Color, width: 4),
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
                        Icon(wi['icon'] as IconData,
                            color: wi['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(wi['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _ordDot(
                            wi['role'] as String, wi['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(wi['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Numeric Examples ──
          _ordHead('6', 'Numeric Ordering Strategies'),
          SizedBox(height: 12),
          ...numExamples.map((ex) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ex['color'] as Color, width: 4),
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
                      Text(ex['label'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: ex['color'] as Color)),
                      SizedBox(height: 6),
                      ...(ex['items'] as List<Map<String, dynamic>>)
                          .map((item) => Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Row(children: [
                                  Container(
                                    width: 40,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (ex['color'] as Color)
                                          .withOpacity(0.15),
                                      borderRadius:
                                          BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                        (item['order'] as double)
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                ex['color'] as Color)),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      size: 10,
                                      color: Colors.grey[400]),
                                  SizedBox(width: 8),
                                  Text(item['field'] as String,
                                      style: TextStyle(fontSize: 12)),
                                ]),
                              )),
                      SizedBox(height: 4),
                      Text(ex['note'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Custom Subclass ──
          _ordHead('7', 'Custom FocusOrder Designs'),
          SizedBox(height: 12),
          ...customFields.map((cf) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cf['color'] as Color, width: 4),
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
                        Icon(cf['icon'] as IconData,
                            color: cf['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cf['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(cf['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('fields: ${cf['fields']}',
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: Colors.teal[300])),
                            Text('compare: ${cf['compare']}',
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: Colors.cyan[300])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Patterns ──
          _ordHead('8', 'Real-World Patterns'),
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
          _ordHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FocusOrder Deep Demo',
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
Widget _ordHead(String number, String title) {
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
// Helper: Dot badge
// ──────────────────────────────────────────────────────────
Widget _ordDot(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
