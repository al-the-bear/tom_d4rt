// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BuildScope
// Demonstrates BuildScope — Flutter's mechanism for isolating
// widget build passes into independent scopes.  Introduced to
// solve the problem of unnecessary rebuilds in overlays and
// persistent widgets when unrelated parts of the tree change.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BuildScope Deep Demo executing');

  // ============================================================
  // SECTION 1: What is BuildScope?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.layers,
      'title': 'Isolated Build Passes',
      'body': 'BuildScope partitions the widget tree into independent '
          'rebuild zones. Each scope has its own list of dirty elements '
          'and its own build pass. When elements in scope A are marked '
          'dirty, only scope A rebuilds — scope B is untouched. This '
          'prevents unnecessary work across unrelated tree branches.',
      'accent': Colors.red[600]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Optimization',
      'body': 'Before BuildScope, BuildOwner maintained a single global '
          'dirty list. Calling setState on ANY widget would rebuild '
          'ALL dirty elements in a single buildScope() call. With '
          'BuildScope, each scope rebuilds independently, reducing '
          'the number of elements processed per frame.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.picture_in_picture,
      'title': 'Overlay Independence',
      'body': 'The primary motivation for BuildScope: overlays (tooltips, '
          'dropdowns, dialogs, routes) should not be rebuilt when the '
          'underlying page changes. Each OverlayEntry gets its own '
          'BuildScope, so rebuilding the main content does not touch '
          'overlay widgets, and vice versa.',
      'accent': Colors.red[500]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'BuildOwner Integration',
      'body': 'BuildScope works with BuildOwner. When an Element is '
          'marked dirty, it is added to its BuildScope\'s dirty list '
          '(not a global list). BuildOwner.buildScope() then processes '
          'each scope\'s dirty elements independently. The scope is '
          'determined by the Element\'s position in the tree.',
      'accent': Colors.deepOrange[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Before vs After BuildScope
  // ============================================================
  print('=== Section 2: Before vs After ===');

  final beforeAfter = <Map<String, dynamic>>[
    {
      'label': 'BEFORE BuildScope',
      'icon': Icons.warning_amber,
      'color': Colors.orange[700]!,
      'items': [
        'Single global dirty list in BuildOwner',
        'One buildScope() call processes ALL dirty elements',
        'setState in page rebuilds overlay elements too',
        'setState in overlay rebuilds page elements too',
        'No isolation between tree branches',
        'Performance degrades with many overlays',
      ],
    },
    {
      'label': 'AFTER BuildScope',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'items': [
        'Per-scope dirty lists managed by BuildScope',
        'Each scope has independent buildScope() call',
        'setState in page only rebuilds page elements',
        'setState in overlay only rebuilds overlay elements',
        'Full isolation between scopes',
        'Overlay count does not affect page performance',
      ],
    },
  ];

  print('  Prepared before/after comparison');

  // ============================================================
  // SECTION 3: BuildScope Lifecycle
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'BuildScope Created',
      'color': Colors.red[600]!,
      'detail': 'A BuildScope is created when an overlay entry, route, '
          'or other scope-creating widget mounts. The scope is an '
          'object that holds: a dirty elements list, a scheduling '
          'callback, and a flag indicating whether a build is needed.',
    },
    {
      'step': 2,
      'title': 'Elements Assigned to Scope',
      'color': Colors.deepOrange[600]!,
      'detail': 'When elements mount inside a scope-owning widget, they '
          'inherit that BuildScope. The element\'s buildScope property '
          'points to this scope object. All descendants share the '
          'same scope unless a child creates a nested scope.',
    },
    {
      'step': 3,
      'title': 'Element Marked Dirty',
      'color': Colors.red[500]!,
      'detail': 'When setState() is called, the element is marked dirty '
          'and added to its BuildScope\'s dirty list (not a global '
          'list). The scope schedules a build if not already '
          'scheduled. Other scopes are unaffected.',
    },
    {
      'step': 4,
      'title': 'BuildOwner Processes Scope',
      'color': Colors.deepOrange[500]!,
      'detail': 'During the frame, BuildOwner calls buildScope() for '
          'each scope that has dirty elements. The scope sorts its '
          'dirty elements by depth (parent before child) and rebuilds '
          'them. Only elements in THIS scope are processed.',
    },
    {
      'step': 5,
      'title': 'Scope Clean or Disposed',
      'color': Colors.red[400]!,
      'detail': 'After processing, the scope\'s dirty list is empty. '
          'The scope remains active for future dirty elements. When '
          'the scope-owning widget unmounts, the BuildScope is '
          'disposed and its elements are reassigned or removed.',
    },
  ];

  print('  Prepared ${lifecycle.length} lifecycle steps');

  // ============================================================
  // SECTION 4: Scope Architecture
  // ============================================================
  print('=== Section 4: Architecture ===');

  final architecture = <Map<String, dynamic>>[
    {
      'title': 'BuildScope Properties',
      'color': Colors.red[600]!,
      'code': '// class BuildScope {\n'
          '//\n'
          '//   // The dirty elements in this scope\n'
          '//   List<Element> _dirtyElements = [];\n'
          '//\n'
          '//   // Whether this scope needs a build\n'
          '//   bool _building = false;\n'
          '//\n'
          '//   // Schedule callback for build frame\n'
          '//   VoidCallback? _scheduleCallback;\n'
          '//\n'
          '//   // Whether scope is active\n'
          '//   bool get active => ...;\n'
          '// }',
    },
    {
      'title': 'Element.buildScope',
      'color': Colors.deepOrange[600]!,
      'code': '// // Every Element has a buildScope:\n'
          '// abstract class Element {\n'
          '//   BuildScope get buildScope;\n'
          '//\n'
          '//   // When element is marked dirty:\n'
          '//   void markNeedsBuild() {\n'
          '//     _dirty = true;\n'
          '//     buildScope._dirtyElements.add(this);\n'
          '//     buildScope._scheduleFrame();\n'
          '//   }\n'
          '// }',
    },
    {
      'title': 'BuildOwner.buildScope()',
      'color': Colors.red[500]!,
      'code': '// // BuildOwner processes each scope:\n'
          '// void buildScope(\n'
          '//   BuildScope scope, {\n'
          '//   VoidCallback? callback,\n'
          '// }) {\n'
          '//   scope._dirtyElements.sort(\n'
          '//     Element._sort);\n'
          '//   for (final element in\n'
          '//       scope._dirtyElements) {\n'
          '//     element.rebuild();\n'
          '//   }\n'
          '//   scope._dirtyElements.clear();\n'
          '// }',
    },
  ];

  print('  Prepared ${architecture.length} architecture items');

  // ============================================================
  // SECTION 5: Scope Hierarchy Example
  // ============================================================
  print('=== Section 5: Scope Hierarchy ===');

  final scopeTree = <Map<String, dynamic>>[
    {
      'name': 'Root BuildScope',
      'depth': 0,
      'color': Colors.red[700]!,
      'widgets': 'MaterialApp → Scaffold → Column → ...',
      'note': 'Main app content — rebuilds only affect this scope',
    },
    {
      'name': 'Overlay Scope #1',
      'depth': 1,
      'color': Colors.blue[500]!,
      'widgets': 'Tooltip overlay entry',
      'note': 'Independent — page setState does not rebuild this',
    },
    {
      'name': 'Overlay Scope #2',
      'depth': 1,
      'color': Colors.green[500]!,
      'widgets': 'DropdownButton menu overlay',
      'note': 'Independent — isolated from root and scope #1',
    },
    {
      'name': 'Dialog Scope',
      'depth': 1,
      'color': Colors.orange[500]!,
      'widgets': 'showDialog → AlertDialog',
      'note': 'Route overlay — fully isolated build pass',
    },
    {
      'name': 'Nested Scope in Dialog',
      'depth': 2,
      'color': Colors.purple[400]!,
      'widgets': 'PopupMenuButton inside dialog',
      'note': 'Nested scope — isolated even from parent dialog',
    },
  ];

  print('  Prepared ${scopeTree.length} scope nodes');

  // ============================================================
  // SECTION 6: Use Cases
  // ============================================================
  print('=== Section 6: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Overlay Entries',
      'icon': Icons.picture_in_picture,
      'color': Colors.red[600]!,
      'desc': 'Each OverlayEntry gets a BuildScope. When tooltip #3 '
          'needs to rebuild (e.g., content change), tooltips #1 and '
          '#2 and the main page are unaffected. This is critical '
          'for apps with many simultaneous overlays.',
      'visual': 'Page rebuilds: 0 overlay rebuilds\n'
          'Overlay #3 rebuilds: 0 page rebuilds',
    },
    {
      'title': 'Route Transitions',
      'icon': Icons.swap_horiz,
      'color': Colors.deepOrange[600]!,
      'desc': 'During a page transition, both the old and new routes '
          'may need to rebuild independently. BuildScope ensures '
          'that the outgoing page animation does not trigger '
          'rebuilds in the incoming page content.',
      'visual': 'Old route animating out: 0 new route rebuilds\n'
          'New route building: 0 old route rebuilds',
    },
    {
      'title': 'Persistent Bottom Sheets',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.red[500]!,
      'desc': 'A persistent bottom sheet in a Scaffold can have its '
          'own BuildScope. When the page body scrolls and rebuilds '
          'list items, the bottom sheet stays untouched. Updates '
          'to the bottom sheet don\'t rebuild the scrolling list.',
      'visual': 'List scroll: 0 sheet rebuilds\n'
          'Sheet update: 0 list rebuilds',
    },
    {
      'title': 'Floating Action Buttons',
      'icon': Icons.add_circle,
      'color': Colors.deepOrange[500]!,
      'desc': 'FABs rendered as overlay entries benefit from scope '
          'isolation. Animating a FAB (scale, rotation) does not '
          'cause the underlying page to rebuild. This is especially '
          'valuable for complex pages with heavy build methods.',
      'visual': 'FAB animation: 0 page rebuilds\n'
          'Page setState: 0 FAB rebuilds',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 7: Dirty Element Processing
  // ============================================================
  print('=== Section 7: Dirty Processing ===');

  final dirtyProcessing = <Map<String, dynamic>>[
    {
      'title': 'Depth-First Ordering',
      'color': Colors.red[600]!,
      'body': 'Within a BuildScope, dirty elements are sorted by depth '
          'before processing (shallowest first). This ensures parents '
          'rebuild before children. If a parent rebuild makes a child '
          'clean, the child is skipped — saving work.',
    },
    {
      'title': 'Scope Boundary',
      'color': Colors.deepOrange[600]!,
      'body': 'A dirty element is always processed by its own scope. '
          'Even if a parent in another scope rebuilds and causes a '
          'child to become dirty, that child is added to ITS scope\'s '
          'dirty list, not the parent\'s. Scopes never cross.',
    },
    {
      'title': 'No Global Sorting',
      'color': Colors.red[500]!,
      'body': 'Before BuildScope, ALL dirty elements were sorted '
          'globally — expensive with many elements. Now each scope '
          'sorts only its own small list. With N elements across K '
          'scopes, sorting is K × O(n/K log n/K) instead of '
          'O(N log N).',
    },
    {
      'title': 'Concurrent Scope Processing',
      'color': Colors.deepOrange[500]!,
      'body': 'While scopes are processed sequentially (not actually '
          'parallel), each scope\'s buildScope() is a separate call. '
          'The framework iterates through scopes that need building '
          'and invokes buildScope() on each one in turn.',
    },
  ];

  print('  Prepared ${dirtyProcessing.length} items');

  // ============================================================
  // SECTION 8: Relationship to Other Concepts
  // ============================================================
  print('=== Section 8: Relationships ===');

  final related = <Map<String, dynamic>>[
    {
      'name': 'BuildOwner',
      'color': Colors.red[600]!,
      'relation': 'Manager',
      'desc': 'BuildOwner coordinates all BuildScopes. It maintains '
          'the list of scopes that need work and calls buildScope() '
          'on each. BuildScope cannot exist without a BuildOwner.',
    },
    {
      'name': 'Element',
      'color': Colors.deepOrange[600]!,
      'relation': 'Member',
      'desc': 'Each Element belongs to exactly one BuildScope. The '
          'element\'s buildScope property determines which scope '
          'receives its dirty notification. Elements inherit scope '
          'from their parent unless overridden.',
    },
    {
      'name': 'OverlayEntry',
      'color': Colors.red[500]!,
      'relation': 'Creator',
      'desc': 'OverlayEntry is the primary creator of BuildScopes '
          'in a typical Flutter app. Each entry creates a scope for '
          'its subtree, ensuring overlay content is isolated from '
          'the main widget tree.',
    },
    {
      'name': 'Overlay',
      'color': Colors.deepOrange[500]!,
      'relation': 'Host',
      'desc': 'Overlay hosts multiple OverlayEntries, each with its '
          'own BuildScope. The Overlay widget itself lives in the '
          'root scope, but its entries create child scopes.',
    },
    {
      'name': 'Navigator',
      'color': Colors.red[400]!,
      'relation': 'Consumer',
      'desc': 'Navigator uses Overlay internally. Each route pushed '
          'onto the Navigator creates an OverlayEntry with its own '
          'BuildScope. Route transitions benefit from scope isolation.',
    },
  ];

  print('  Prepared ${related.length} relationships');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Automatic for Overlays',
      'body': 'You don\'t need to create BuildScopes manually. The '
          'framework does it automatically for OverlayEntries, which '
          'means routes, dialogs, tooltips, dropdown menus, and '
          'popup menus all get scope isolation out of the box.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Reduced Rebuild Counting',
      'body': 'If you\'re profiling rebuilds using debugPrint or a '
          'rebuild counter, BuildScope means you\'ll see fewer '
          'rebuilds per frame. Widgets in other scopes don\'t count '
          'toward the current scope\'s rebuild pass.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Not a Replacement for const',
      'body': 'BuildScope isolates BETWEEN scopes, not within. Inside '
          'a single scope, the normal rebuild rules apply. Use const '
          'widgets, keys, and shouldRebuild to minimize work within '
          'a scope. BuildScope handles scope-to-scope isolation.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Debug with debugDumpApp()',
      'body': 'The debugDumpApp() output includes scope information '
          'for each element. Look for BuildScope annotations to '
          'verify that overlays and routes are in separate scopes. '
          'Use this to diagnose unexpected cross-scope rebuilds.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Works Transparently',
      'body': 'BuildScope is an internal optimization. Your existing '
          'code benefits from it without changes. setState, '
          'InheritedWidget, ValueNotifier — all continue to work '
          'exactly as before, just more efficiently.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'InheritedWidget Crosses Scopes',
      'body': 'InheritedWidget notifications DO cross scope boundaries. '
          'If ThemeData changes, all dependents rebuild regardless '
          'of scope. BuildScope isolates setState, not inherited '
          'notifications. This is intentional — theme changes should '
          'be global.',
      'severity': 'warning',
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
      title: Text('BuildScope'),
      backgroundColor: Colors.red[600],
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
                colors: [Colors.red[600]!, Colors.deepOrange[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.layers, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'BuildScope',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An isolation mechanism that partitions the widget tree '
                  'into independent rebuild zones. Each scope has its own '
                  'dirty element list and build pass, preventing unnecessary '
                  'cross-branch rebuilds — especially for overlays and routes.',
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
          _bsHead('1', 'What is BuildScope?'),
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

          // ── Section 2: Before vs After ──
          _bsHead('2', 'Before vs After BuildScope'),
          SizedBox(height: 12),
          ...beforeAfter.map((ba) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ba['color'] as Color, width: 4),
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
                        Icon(ba['icon'] as IconData,
                            color: ba['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Text(ba['label'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: ba['color'] as Color)),
                      ]),
                      SizedBox(height: 10),
                      ...(ba['items'] as List<String>).map((item) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('• ',
                                    style: TextStyle(
                                        color: ba['color'] as Color,
                                        fontSize: 13)),
                                Expanded(
                                  child: Text(item,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                          height: 1.3)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Lifecycle ──
          _bsHead('3', 'BuildScope Lifecycle'),
          SizedBox(height: 12),
          ...lifecycle.map((lc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: lc['color'] as Color, width: 4),
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
                          color: lc['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${lc['step']}',
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
                            Text(lc['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(lc['detail'] as String,
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

          // ── Section 4: Architecture ──
          _bsHead('4', 'Scope Architecture'),
          SizedBox(height: 12),
          ...architecture.map((a) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: a['color'] as Color, width: 4),
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
                      Text(a['title'] as String,
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
                        child: Text(a['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.red[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Scope Hierarchy ──
          _bsHead('5', 'Scope Hierarchy Example'),
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
              children: scopeTree.map((st) {
                final depth = st['depth'] as int;
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: 10, left: depth * 20.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (st['color'] as Color).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (st['color'] as Color).withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: st['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(st['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: st['color'] as Color)),
                        ]),
                        SizedBox(height: 4),
                        Text(st['widgets'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.grey[600])),
                        SizedBox(height: 2),
                        Text(st['note'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 6: Use Cases ──
          _bsHead('6', 'Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
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
                            color: uc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(uc['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ]),
                      SizedBox(height: 8),
                      Text(uc['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (uc['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: (uc['color'] as Color)
                                  .withOpacity(0.2)),
                        ),
                        child: Text(uc['visual'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: uc['color'] as Color,
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Dirty Processing ──
          _bsHead('7', 'Dirty Element Processing'),
          SizedBox(height: 12),
          ...dirtyProcessing.map((dp) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: dp['color'] as Color, width: 4),
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
                      Text(dp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Text(dp['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Relationships ──
          _bsHead('8', 'Related Concepts'),
          SizedBox(height: 12),
          ...related.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: r['color'] as Color, width: 4),
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
                        _bsTag(r['name'] as String,
                            r['color'] as Color),
                        SizedBox(width: 8),
                        _bsTag(r['relation'] as String,
                            Colors.grey[500]!),
                      ]),
                      SizedBox(height: 8),
                      Text(r['desc'] as String,
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
          _bsHead('9', 'Tips & Best Practices'),
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
              'End of BuildScope Deep Demo',
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
Widget _bsHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[600],
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
// Helper: Tag/label
// ──────────────────────────────────────────────────────────
Widget _bsTag(String text, Color color) {
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
