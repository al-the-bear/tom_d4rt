// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ComponentElement
// Demonstrates ComponentElement — the abstract Element subclass that
// backs StatelessWidget and StatefulWidget. It is the bridge between
// the Widget configuration and the actual render tree. Understanding
// ComponentElement reveals how Flutter builds, updates, and disposes.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ComponentElement Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ComponentElement?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'The Element Behind Components',
      'body': 'ComponentElement is the abstract Element subclass that '
          'backs all "component" widgets — those that compose other '
          'widgets rather than directly creating RenderObjects. '
          'StatelessWidget creates a StatelessElement (extends '
          'ComponentElement). StatefulWidget creates a StatefulElement '
          '(extends ComponentElement). It is the workhorse of the '
          'widget tree.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Widget → Element → RenderObject',
      'body': 'Flutter uses a three-tree architecture: Widgets are '
          'immutable configuration, Elements are the mutable tree '
          'nodes managing lifecycle, and RenderObjects handle layout '
          'and painting. ComponentElement sits in the middle, calling '
          'build() on its widget to produce child widgets, then '
          'inflating those children into more Elements.',
      'accent': Colors.yellow[800]!,
    },
    {
      'icon': Icons.build,
      'title': 'build() Delegation',
      'body': 'ComponentElement\'s core responsibility: call build() '
          'on the widget it manages, get back a child Widget, and '
          'update the element tree accordingly. For StatelessElement, '
          'this calls widget.build(this). For StatefulElement, it '
          'calls state.build(this). The "this" is the BuildContext.',
      'accent': Colors.amber[600]!,
    },
    {
      'icon': Icons.refresh,
      'title': 'Rebuilding & Updating',
      'body': 'When setState() is called or a parent rebuilds, the '
          'framework marks the ComponentElement as dirty. During the '
          'next frame, performRebuild() is called, which invokes '
          'build() again and diffs the new child widget against the '
          'existing child element using canUpdate(). This is the '
          'core of Flutter\'s efficient update mechanism.',
      'accent': Colors.yellow[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Hierarchy ===');

  final hierarchyItems = <Map<String, dynamic>>[
    {
      'name': 'Element',
      'depth': 0,
      'color': Colors.grey[600]!,
      'note': 'Abstract base: manages lifecycle, holds Widget reference, '
          'owner, parent, slot',
    },
    {
      'name': 'ComponentElement',
      'depth': 1,
      'color': Colors.amber[700]!,
      'note': 'Abstract: calls build() on widget, manages single child '
          'element, performRebuild() logic',
    },
    {
      'name': 'StatelessElement',
      'depth': 2,
      'color': Colors.yellow[800]!,
      'note': 'Concrete: backs StatelessWidget, calls widget.build(this)',
    },
    {
      'name': 'StatefulElement',
      'depth': 2,
      'color': Colors.amber[600]!,
      'note': 'Concrete: backs StatefulWidget, creates State, calls '
          'state.build(this)',
    },
    {
      'name': 'ProxyElement',
      'depth': 2,
      'color': Colors.yellow[700]!,
      'note': 'Concrete: backs InheritedWidget, ProxyWidget — rebuilds '
          'when notifyClients is called',
    },
    {
      'name': 'RenderObjectElement',
      'depth': 1,
      'color': Colors.grey[500]!,
      'note': 'Sibling branch: creates/updates RenderObjects, not a '
          'ComponentElement',
    },
  ];

  print('  Prepared ${hierarchyItems.length} hierarchy items');

  // ============================================================
  // SECTION 3: Key Methods
  // ============================================================
  print('=== Section 3: Key Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'build()',
      'type': 'Widget (abstract)',
      'icon': Icons.build,
      'color': Colors.amber[700]!,
      'description': 'Subclasses implement this to produce the child '
          'widget. StatelessElement returns widget.build(this). '
          'StatefulElement returns state.build(this). Called by '
          'performRebuild() during the build phase.',
    },
    {
      'name': 'performRebuild()',
      'type': 'void',
      'icon': Icons.refresh,
      'color': Colors.yellow[800]!,
      'description': 'Called by the framework when the element is dirty. '
          'Calls build() to get the new child widget, then calls '
          'updateChild() to reconcile the existing child element '
          'with the new widget. This is the hot path of the rebuild.',
    },
    {
      'name': 'mount(parent, slot)',
      'type': 'void',
      'icon': Icons.login,
      'color': Colors.amber[600]!,
      'description': 'Called when the element is first inserted into '
          'the tree. Sets up the parent reference and slot, then '
          'triggers the first build via performRebuild(). After '
          'mount, the element is "active" and visible in the tree.',
    },
    {
      'name': 'update(newWidget)',
      'type': 'void',
      'icon': Icons.edit,
      'color': Colors.yellow[700]!,
      'description': 'Called when the parent provides a new widget '
          'configuration. Updates the element\'s widget reference '
          'and marks it dirty for rebuild. The framework calls this '
          'when canUpdate(oldWidget, newWidget) returns true.',
    },
    {
      'name': 'unmount()',
      'type': 'void',
      'icon': Icons.logout,
      'color': Colors.amber[500]!,
      'description': 'Called when the element is permanently removed '
          'from the tree. Clears references and notifies the widget. '
          'For StatefulElement, this calls state.dispose(). After '
          'unmount, the element is "defunct."',
    },
    {
      'name': 'visitChildren(visitor)',
      'type': 'void',
      'icon': Icons.visibility,
      'color': Colors.yellow[600]!,
      'description': 'Visits the single child element (if it exists). '
          'ComponentElement has at most one child, unlike '
          'MultiChildRenderObjectElement which has many.',
    },
  ];

  print('  Prepared ${methods.length} methods');

  // ============================================================
  // SECTION 4: Lifecycle Flow
  // ============================================================
  print('=== Section 4: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'createElement()',
      'color': Colors.amber[700]!,
      'detail': 'Framework calls widget.createElement() to create the '
          'element. StatelessWidget returns StatelessElement(this). '
          'StatefulWidget returns StatefulElement(this) and also '
          'calls createState().',
    },
    {
      'step': 2,
      'title': 'mount(parent, slot)',
      'color': Colors.yellow[800]!,
      'detail': 'Element is inserted into the tree with a parent and '
          'slot. The element is now "active." For StatefulElement, '
          'state.initState() and state.didChangeDependencies() '
          'are called.',
    },
    {
      'step': 3,
      'title': 'performRebuild() → build()',
      'color': Colors.amber[600]!,
      'detail': 'The first build happens. build() returns a child '
          'widget. updateChild() inflates it into a child element, '
          'recursively building the subtree.',
    },
    {
      'step': 4,
      'title': 'markNeedsBuild() (on state change)',
      'color': Colors.yellow[700]!,
      'detail': 'When setState() is called or a dependency changes, '
          'the element is marked dirty. It is added to the build '
          'owner\'s dirty list for the next frame.',
    },
    {
      'step': 5,
      'title': 'performRebuild() (subsequent)',
      'color': Colors.amber[500]!,
      'detail': 'On the next frame, performRebuild() runs again. '
          'build() returns new child widget. updateChild() diffs '
          'against the existing child. If canUpdate is true, the '
          'child element is reused; otherwise, it is replaced.',
    },
    {
      'step': 6,
      'title': 'deactivate() / unmount()',
      'color': Colors.yellow[600]!,
      'detail': 'When removed from the tree: deactivate() is called '
          '(element may be reinserted). If not reinserted by end '
          'of frame, unmount() is called (permanent removal). '
          'For StatefulElement, state.dispose() runs at unmount.',
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 5: The Three Trees
  // ============================================================
  print('=== Section 5: Three Trees ===');

  final treeColumns = <Map<String, dynamic>>[
    {
      'tree': 'Widget Tree',
      'color': Colors.blue[600]!,
      'icon': Icons.description,
      'items': [
        'Immutable configuration',
        'Lightweight — recreated often',
        'Describes what the UI should look like',
        'MyApp → Scaffold → Column → Text',
      ],
    },
    {
      'tree': 'Element Tree',
      'color': Colors.amber[700]!,
      'icon': Icons.account_tree,
      'items': [
        'Mutable tree nodes — long-lived',
        'Manages lifecycle and identity',
        'Links Widget ↔ RenderObject',
        'ComponentElements call build()',
      ],
    },
    {
      'tree': 'RenderObject Tree',
      'color': Colors.green[600]!,
      'icon': Icons.brush,
      'items': [
        'Handles layout, paint, hit-test',
        'Only created by RenderObjectWidgets',
        'ComponentElements do NOT have one',
        'RenderBox, RenderFlex, RenderParagraph',
      ],
    },
  ];

  print('  Prepared ${treeColumns.length} tree columns');

  // ============================================================
  // SECTION 6: canUpdate Reconciliation
  // ============================================================
  print('=== Section 6: canUpdate ===');

  final reconciliationRows = <Map<String, dynamic>>[
    {
      'scenario': 'Same runtimeType + same key',
      'result': 'canUpdate = true → element REUSED',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'detail': 'The existing element\'s widget reference is updated '
          'to the new widget. The element calls update() and '
          'rebuilds. State is preserved (for StatefulElement).',
    },
    {
      'scenario': 'Different runtimeType',
      'result': 'canUpdate = false → element REPLACED',
      'icon': Icons.cancel,
      'color': Colors.red[600]!,
      'detail': 'The old element is deactivated and unmounted. A new '
          'element is created for the new widget. All state is lost.',
    },
    {
      'scenario': 'Same runtimeType, different key',
      'result': 'canUpdate = false → element REPLACED',
      'icon': Icons.cancel,
      'color': Colors.orange[600]!,
      'detail': 'Even though the widget type is the same, different '
          'keys force replacement. This is how Key controls identity.',
    },
    {
      'scenario': 'Null keys (both)',
      'result': 'canUpdate = true (if same type)',
      'icon': Icons.check_circle,
      'color': Colors.green[500]!,
      'detail': 'When both widgets have null keys, canUpdate depends '
          'solely on runtimeType. This is the most common case.',
    },
  ];

  print('  Prepared ${reconciliationRows.length} reconciliation rows');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'StatelessWidget → StatelessElement',
      'color': Colors.amber[700]!,
      'code': 'class MyLabel extends StatelessWidget {\n'
          '  final String text;\n'
          '  const MyLabel(this.text, {super.key});\n'
          '\n'
          '  // Framework calls createElement():\n'
          '  // @override\n'
          '  // StatelessElement createElement()\n'
          '  //   => StatelessElement(this);\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    // context IS the StatelessElement\n'
          '    // StatelessElement.build()\n'
          '    //   calls widget.build(this)\n'
          '    return Text(text);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'StatefulWidget → StatefulElement',
      'color': Colors.yellow[800]!,
      'code': 'class Counter extends StatefulWidget {\n'
          '  const Counter({super.key});\n'
          '\n'
          '  // Framework calls createElement():\n'
          '  // @override\n'
          '  // StatefulElement createElement()\n'
          '  //   => StatefulElement(this);\n'
          '\n'
          '  @override\n'
          '  State<Counter> createState() =>\n'
          '      _CounterState();\n'
          '}\n'
          '\n'
          'class _CounterState\n'
          '    extends State<Counter> {\n'
          '  int _count = 0;\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    // context IS the StatefulElement\n'
          '    // StatefulElement.build()\n'
          '    //   calls state.build(this)\n'
          '    return Text(\'\$_count\');\n'
          '  }\n'
          '}',
    },
    {
      'title': 'BuildContext IS the Element',
      'color': Colors.amber[600]!,
      'code': '// BuildContext is an interface that\n'
          '// Element implements. When you write:\n'
          '//\n'
          '//   Widget build(BuildContext context)\n'
          '//\n'
          '// The \'context\' parameter IS the\n'
          '// ComponentElement itself.\n'
          '//\n'
          '// So context.findAncestorWidgetOf...\n'
          '// is actually element.findAncestor...\n'
          '//\n'
          '// context.widget → the widget config\n'
          '// context.size → render object size\n'
          '// context.mounted → element is active\n'
          '//\n'
          '// This is why you should never store\n'
          '// BuildContext — it\'s a mutable Element\n'
          '// that may be deactivated.',
    },
    {
      'title': 'How updateChild() Works',
      'color': Colors.yellow[700]!,
      'code': '// Inside performRebuild():\n'
          '//\n'
          '// Widget? newChild = build();\n'
          '// _child = updateChild(\n'
          '//   _child,      // existing element\n'
          '//   newChild,     // new widget\n'
          '//   slot,\n'
          '// );\n'
          '//\n'
          '// updateChild logic:\n'
          '// if newWidget == null:\n'
          '//   deactivate old child\n'
          '//   return null\n'
          '// if oldChild != null:\n'
          '//   if canUpdate(old, new):\n'
          '//     update old child with new widget\n'
          '//     return old child (reused!)\n'
          '//   else:\n'
          '//     deactivate old, inflate new\n'
          '// else:\n'
          '//   inflate newWidget into element',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: Common Misconceptions
  // ============================================================
  print('=== Section 8: Misconceptions ===');

  final misconceptions = <Map<String, dynamic>>[
    {
      'myth': 'Widgets are reused between frames',
      'truth': 'Widgets are immutable and recreated. Elements are '
          'reused. When you call setState(), new Widget objects are '
          'created, but the ComponentElement persists and updates '
          'its widget reference.',
      'color': Colors.amber[700]!,
    },
    {
      'myth': 'build() is expensive',
      'truth': 'build() is cheap — it just creates Widget configs. '
          'The expensive work is in the RenderObject (layout, paint). '
          'ComponentElement.performRebuild() is optimized to reuse '
          'child Elements via canUpdate(), avoiding subtree re-creation.',
      'color': Colors.yellow[800]!,
    },
    {
      'myth': 'Each widget has a RenderObject',
      'truth': 'Only RenderObjectWidgets create RenderObjects. '
          'ComponentElements (from StatelessWidget, StatefulWidget) '
          'do NOT have RenderObjects. They just produce child widgets '
          'via build(). The render tree is much shallower than the '
          'element tree.',
      'color': Colors.amber[600]!,
    },
    {
      'myth': 'BuildContext is separate from Element',
      'truth': 'BuildContext IS the Element. The BuildContext abstract '
          'class is implemented by Element. The "context" parameter '
          'in build(BuildContext context) is literally the '
          'ComponentElement that called build().',
      'color': Colors.yellow[700]!,
    },
  ];

  print('  Prepared ${misconceptions.length} misconceptions');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Understanding = Better Performance',
      'body': 'Knowing that Elements are reused via canUpdate() helps '
          'you write efficient code. Use const constructors to avoid '
          'unnecessary rebuilds. Use Keys to control element identity '
          'when the default runtimeType-based matching is wrong.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Do Not Store BuildContext',
      'body': 'Since BuildContext IS the Element, storing a context '
          'reference holds the entire element (and its subtree). '
          'After unmount, the context is defunct. Always check '
          'context.mounted before using a stored context.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Keys for Identity Control',
      'body': 'Keys influence canUpdate() and therefore which Elements '
          'get reused or replaced. Use ValueKey, ObjectKey, or '
          'UniqueKey when the default position-based matching '
          'produces wrong behavior (e.g., in AnimatedList).',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'widget.debugFillProperties for Inspection',
      'body': 'Override debugFillProperties on your Widget subclass '
          'to provide detailed information in the Flutter Inspector. '
          'The Element uses these properties for the inspector\'s '
          'widget tree view.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Avoid Heavy build() Methods',
      'body': 'While build() itself is cheap, extremely deep widget '
          'trees force deep element reconciliation. Split large '
          'build methods into smaller widgets to enable more '
          'granular rebuild boundaries.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Flutter Inspector Shows Elements',
      'body': 'The Flutter Inspector (DevTools) "Widget Tree" actually '
          'shows the Element tree. Each node is an Element holding '
          'a Widget reference. Understanding ComponentElement makes '
          'the inspector output much more readable.',
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
      title: Text('ComponentElement'),
      backgroundColor: Colors.amber[700],
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
                colors: [Colors.amber[700]!, Colors.yellow[800]!],
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
                  'ComponentElement',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The abstract Element subclass that backs StatelessWidget '
                  'and StatefulWidget. ComponentElement calls build() on '
                  'its widget to produce child widgets, managing the '
                  'whole lifecycle of composing, reconciling, and '
                  'updating the element tree.',
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
          _ceHead('1', 'What is ComponentElement?'),
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

          // ── Section 2: Hierarchy ──
          _ceHead('2', 'Class Hierarchy'),
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
                ...hierarchyItems.map((h) {
                  final depth = h['depth'] as int;
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 8, left: depth * 24.0),
                    child: Row(children: [
                      if (depth > 0)
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(depth == 1 ? '├─' : '│  └─',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: Colors.grey[400])),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (h['color'] as Color)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: h['color'] as Color),
                        ),
                        child: Text(h['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: h['color'] as Color)),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(h['note'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[600])),
                      ),
                    ]),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 3: Key Methods ──
          _ceHead('3', 'Key Methods'),
          SizedBox(height: 12),
          ...methods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
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
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _ceTag(m['type'] as String,
                            m['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Lifecycle ──
          _ceHead('4', 'Lifecycle Flow'),
          SizedBox(height: 12),
          ...lifecycleSteps.map((ls) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ls['color'] as Color, width: 4),
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
                          color: ls['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ls['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(ls['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(ls['detail'] as String,
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

          // ── Section 5: Three Trees ──
          _ceHead('5', 'The Three Trees'),
          SizedBox(height: 12),
          ...treeColumns.map((tc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: tc['color'] as Color, width: 4),
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
                        Icon(tc['icon'] as IconData,
                            color: tc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(tc['tree'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: tc['color'] as Color)),
                      ]),
                      SizedBox(height: 8),
                      ...(tc['items'] as List<String>).map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Row(children: [
                            Text('  • ',
                                style: TextStyle(
                                    color: tc['color'] as Color,
                                    fontSize: 10)),
                            Expanded(
                              child: Text(item,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                      height: 1.3)),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: canUpdate ──
          _ceHead('6', 'canUpdate() Reconciliation'),
          SizedBox(height: 12),
          ...reconciliationRows.map((rr) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: rr['color'] as Color, width: 4),
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
                        Icon(rr['icon'] as IconData,
                            color: rr['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rr['scenario'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (rr['color'] as Color)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(rr['result'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: rr['color'] as Color)),
                      ),
                      SizedBox(height: 6),
                      Text(rr['detail'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _ceHead('7', 'Code Patterns'),
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
                                color: Colors.amber[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Misconceptions ──
          _ceHead('8', 'Common Misconceptions'),
          SizedBox(height: 12),
          ...misconceptions.map((mc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: mc['color'] as Color, width: 4),
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
                        Icon(Icons.close, color: Colors.red[400], size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(mc['myth'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red[400])),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check,
                              color: Colors.green[600], size: 16),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(mc['truth'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _ceHead('9', 'Tips & Best Practices'),
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
              'End of ComponentElement Deep Demo',
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
Widget _ceHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.amber[700],
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
Widget _ceTag(String text, Color color) {
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
