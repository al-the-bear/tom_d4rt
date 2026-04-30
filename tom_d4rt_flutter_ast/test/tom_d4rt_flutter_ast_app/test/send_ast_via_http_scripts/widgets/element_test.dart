// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — Element
// Demonstrates Element — the central runtime instantiation of a
// Widget in Flutter's three-tree architecture.  Every Widget in
// the tree has a corresponding Element that manages lifecycle,
// holds state (for StatefulWidgets), maintains parent-child
// relationships, and connects to the underlying RenderObject.
// Element IS the BuildContext — it implements that interface.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Element Deep Demo executing');

  // ============================================================
  // SECTION 1: What is an Element?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'The Runtime Widget Instance',
      'body': 'Widget objects are immutable descriptions. When Flutter '
          'inflates a Widget, it creates an Element — the runtime '
          'instantiation that actually lives in the tree. Elements '
          'are mutable, long-lived, and manage the real work of '
          'layout, painting, and hit testing via RenderObjects.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.link,
      'title': 'Bridge Between Trees',
      'body': 'Flutter has three parallel trees: Widget tree (descriptions), '
          'Element tree (instantiations), and RenderObject tree (layout+paint). '
          'Element sits in the middle. It holds a reference to its current '
          'Widget AND (for RenderObjectElements) to its RenderObject. '
          'It orchestrates updates between them.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.build,
      'title': 'Element IS BuildContext',
      'body': 'The BuildContext parameter in build() methods is actually '
          'an Element. BuildContext is an interface, and Element '
          'implements it. Methods like context.findAncestorWidgetOfExactType '
          'and context.findRenderObject() are Element methods. This is '
          'the most important thing about Element.',
      'accent': Colors.deepPurple[500]!,
    },
    {
      'icon': Icons.recycling,
      'title': 'Efficient Reuse',
      'body': 'When a Widget rebuilds, Flutter doesn\'t destroy and '
          'recreate the Element. Instead, it calls element.update(newWidget) '
          'to patch the existing Element with the new Widget configuration. '
          'This reuse is what makes Flutter\'s rebuild model efficient.',
      'accent': Colors.amber[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Three Trees
  // ============================================================
  print('=== Section 2: Three Trees ===');

  final trees = <Map<String, dynamic>>[
    {
      'name': 'Widget Tree',
      'icon': Icons.description,
      'color': Colors.blue[500]!,
      'desc': 'Immutable configuration objects. Lightweight, frequently '
          'recreated. Describe WHAT the UI should look like. Widgets '
          'are like a blueprint — they\'re cheap to create and compare.',
      'role': 'Describes → "I want a red 200x200 box"',
    },
    {
      'name': 'Element Tree',
      'icon': Icons.account_tree,
      'color': Colors.deepPurple[600]!,
      'desc': 'Mutable runtime instantiations. Long-lived, only replaced '
          'when the Widget type changes. Manages lifecycle, parent-child '
          'links, and coordinates between Widget and RenderObject.',
      'role': 'Manages → "Here is the box, it was updated"',
    },
    {
      'name': 'RenderObject Tree',
      'icon': Icons.layers,
      'color': Colors.orange[600]!,
      'desc': 'Layout and painting objects. Handles actual pixel-level '
          'work: constraints, sizing, positioning, painting, hit testing. '
          'Only exists for RenderObjectWidgets (Container, not Column).',
      'role': 'Renders → "Draw red rect at (0,0) 200x200"',
    },
  ];

  print('  Prepared ${trees.length} trees');

  // ============================================================
  // SECTION 3: Element Subclasses
  // ============================================================
  print('=== Section 3: Subclasses ===');

  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'ComponentElement',
      'parent': 'Element',
      'color': Colors.deepPurple[600]!,
      'desc': 'Base for elements that compose other elements. Has a '
          'build() method. Does NOT have a RenderObject. Used by '
          'StatelessElement and StatefulElement.',
      'children': 'StatelessElement, StatefulElement',
    },
    {
      'name': 'StatelessElement',
      'parent': 'ComponentElement',
      'color': Colors.deepPurple[400]!,
      'desc': 'Element for StatelessWidget. Its build() calls '
          'widget.build(this). Simple: no state, just delegates '
          'to the Widget\'s build method on every rebuild.',
      'children': 'None (leaf)',
    },
    {
      'name': 'StatefulElement',
      'parent': 'ComponentElement',
      'color': Colors.deepPurple[500]!,
      'desc': 'Element for StatefulWidget. Creates and owns the State '
          'object. Calls state.build(). The State is attached to the '
          'Element, not the Widget — that\'s why State persists across '
          'rebuilds when the Widget type stays the same.',
      'children': 'None (leaf)',
    },
    {
      'name': 'RenderObjectElement',
      'parent': 'Element',
      'color': Colors.amber[700]!,
      'desc': 'Base for elements that have a RenderObject. Manages '
          'the RenderObject lifecycle: creates it on mount, updates '
          'it on widget change, detaches it on unmount. Has children.',
      'children': 'SingleChildRenderObjectElement, MultiChildRenderObjectElement',
    },
    {
      'name': 'SingleChildRenderObjectElement',
      'parent': 'RenderObjectElement',
      'color': Colors.amber[600]!,
      'desc': 'For RenderObjectWidgets with exactly one child (e.g., '
          'Padding, Align, SizedBox, DecoratedBox). Manages a single '
          'child Element.',
      'children': 'None (structural)',
    },
    {
      'name': 'MultiChildRenderObjectElement',
      'parent': 'RenderObjectElement',
      'color': Colors.amber[500]!,
      'desc': 'For RenderObjectWidgets with multiple children (e.g., '
          'Row, Column, Stack, Wrap, Flex). Manages a list of child '
          'Elements. Handles reordering via keys.',
      'children': 'None (structural)',
    },
  ];

  print('  Prepared ${subclasses.length} subclasses');

  // ============================================================
  // SECTION 4: Element Lifecycle
  // ============================================================
  print('=== Section 4: Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'createElement()',
      'color': Colors.deepPurple[600]!,
      'detail': 'Widget.createElement() is called by the framework. '
          'This creates a brand-new Element. At this point it has '
          'no parent, no children, and is not in the tree. The '
          'Element holds a reference to its Widget.',
    },
    {
      'step': 2,
      'title': 'mount(parent, slot)',
      'color': Colors.amber[700]!,
      'detail': 'The framework calls mount() to insert the Element '
          'into the tree. It sets the parent, registers with the '
          'BuildOwner, and for RenderObjectElements, creates the '
          'RenderObject and attaches it to the render tree.',
    },
    {
      'step': 3,
      'title': 'build() / updateChild()',
      'color': Colors.deepPurple[500]!,
      'detail': 'For ComponentElements, build() is called to produce '
          'the child Widget, then updateChild() inflates it. For '
          'RenderObjectElements, updateChild() is called for each '
          'child slot. This recursively builds the subtree.',
    },
    {
      'step': 4,
      'title': 'update(newWidget)',
      'color': Colors.amber[600]!,
      'detail': 'When the parent rebuilds with a new Widget of the '
          'same type and key, update() is called with the new Widget. '
          'The Element updates its widget reference and (for '
          'RenderObjectElements) calls updateRenderObject(). Then '
          'it rebuilds its children.',
    },
    {
      'step': 5,
      'title': 'markNeedsBuild()',
      'color': Colors.deepPurple[400]!,
      'detail': 'When state changes (setState()), markNeedsBuild() '
          'adds the Element to the BuildOwner\'s dirty list. On '
          'the next frame, the framework calls build() again. This '
          'is the incremental rebuild mechanism.',
    },
    {
      'step': 6,
      'title': 'deactivate()',
      'color': Colors.amber[500]!,
      'detail': 'Called when the Element is removed from the tree. '
          'It\'s placed in the inactive elements list. If a widget '
          'with the same key appears elsewhere before the frame '
          'ends, the Element can be reactivated (GlobalKey).',
    },
    {
      'step': 7,
      'title': 'unmount()',
      'color': Colors.deepPurple[300]!,
      'detail': 'Called after the frame ends if the deactivated '
          'Element was not reactivated. This is permanent removal. '
          'Resources are cleaned up, the RenderObject is detached, '
          'and the Element is garbage collected.',
    },
  ];

  print('  Prepared ${lifecycle.length} lifecycle steps');

  // ============================================================
  // SECTION 5: Update Algorithm (canUpdate)
  // ============================================================
  print('=== Section 5: Update Algorithm ===');

  final updateRules = <Map<String, dynamic>>[
    {
      'title': 'Widget.canUpdate(oldWidget, newWidget)',
      'color': Colors.deepPurple[600]!,
      'icon': Icons.compare_arrows,
      'desc': 'The static method that determines whether an Element '
          'can be reused. Returns true if oldWidget.runtimeType == '
          'newWidget.runtimeType AND oldWidget.key == newWidget.key. '
          'This is the heart of Flutter\'s efficient rebuild system.',
    },
    {
      'title': 'Same Type + Same Key → Update',
      'color': Colors.green[600]!,
      'icon': Icons.check_circle,
      'desc': 'If canUpdate returns true, the existing Element stays '
          'alive. element.update(newWidget) is called. State is '
          'preserved. RenderObject is updated in place. This is the '
          'common case and why rebuilds are cheap.',
    },
    {
      'title': 'Different Type OR Different Key → Replace',
      'color': Colors.red[500]!,
      'icon': Icons.swap_horiz,
      'desc': 'If canUpdate returns false, the old Element is '
          'deactivated and unmounted. A completely new Element is '
          'created (createElement → mount). State is lost. This '
          'is why changing Widget type forces state reset.',
    },
    {
      'title': 'Keys Enable Reordering',
      'color': Colors.amber[700]!,
      'icon': Icons.vpn_key,
      'desc': 'In lists (MultiChildRenderObjectElement), keys let '
          'the framework match old and new children by key instead '
          'of by position. This enables efficient reordering without '
          'destroying and recreating elements.',
    },
  ];

  print('  Prepared ${updateRules.length} rules');

  // ============================================================
  // SECTION 6: BuildContext Methods (from Element)
  // ============================================================
  print('=== Section 6: BuildContext Interface ===');

  final contextMethods = <Map<String, dynamic>>[
    {
      'name': 'findAncestorWidgetOfExactType<T>()',
      'color': Colors.deepPurple[600]!,
      'desc': 'Walks up the Element tree looking for an ancestor '
          'Widget of exact type T. O(n) where n is tree depth. '
          'Returns the Widget, not the Element. Use for reading '
          'configuration from ancestor widgets.',
    },
    {
      'name': 'findAncestorStateOfType<T>()',
      'color': Colors.amber[700]!,
      'desc': 'Walks up the tree to find an ancestor StatefulElement '
          'whose State is of type T. Returns the State object. '
          'Used for direct imperative access: Scaffold.of(), '
          'Navigator.of() use this internally.',
    },
    {
      'name': 'dependOnInheritedWidgetOfExactType<T>()',
      'color': Colors.deepPurple[500]!,
      'desc': 'Registers the calling Element as a dependent of the '
          'nearest ancestor InheritedWidget of type T. When the '
          'InheritedWidget updates, this Element is rebuilt. This '
          'is how Theme.of(), MediaQuery.of() work.',
    },
    {
      'name': 'findRenderObject()',
      'color': Colors.amber[600]!,
      'desc': 'Returns the nearest RenderObject. For RenderObjectElements, '
          'returns their own. For ComponentElements, walks down to '
          'find the first descendant RenderObject. Used for size '
          'queries and coordinate conversions.',
    },
    {
      'name': 'getElementForInheritedWidgetOfExactType<T>()',
      'color': Colors.deepPurple[400]!,
      'desc': 'Returns the InheritedElement for type T WITHOUT '
          'registering a dependency. The calling widget won\'t rebuild '
          'when the InheritedWidget changes. Use when you only need '
          'to read a value once (e.g., in initState).',
    },
    {
      'name': 'visitChildElements(ElementVisitor)',
      'color': Colors.amber[500]!,
      'desc': 'Iterates over all direct child Elements. Used for '
          'debugging, testing, and framework internals. The visitor '
          'callback receives each child Element. Walk is breadth-first.',
    },
  ];

  print('  Prepared ${contextMethods.length} methods');

  // ============================================================
  // SECTION 7: Key Properties
  // ============================================================
  print('=== Section 7: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'Widget get widget',
      'color': Colors.deepPurple[600]!,
      'desc': 'The current Widget this Element was last configured '
          'with. Updated on update(newWidget). Immutable Widget '
          'objects come and go; the Element keeps operating with '
          'the latest one.',
    },
    {
      'name': 'bool get dirty',
      'color': Colors.amber[700]!,
      'desc': 'True if markNeedsBuild() was called and the Element '
          'hasn\'t been rebuilt yet. Dirty elements are rebuilt by '
          'the BuildOwner during the next build phase. The dirty '
          'flag is what drives incremental rebuilds.',
    },
    {
      'name': 'BuildOwner? get owner',
      'color': Colors.deepPurple[500]!,
      'desc': 'The BuildOwner that manages this Element\'s build '
          'lifecycle. Typically one per widget tree (per WidgetsBinding). '
          'The owner maintains the dirty list and schedules frame '
          'callbacks to process rebuilds.',
    },
    {
      'name': 'int get depth',
      'color': Colors.amber[600]!,
      'desc': 'The depth of this Element in the tree. Root is 1. '
          'Used by the BuildOwner to sort dirty elements depth-first '
          'for rebuilding — parent before child ensures no wasted '
          'rebuilds of children about to be unmounted.',
    },
    {
      'name': 'Key? get key',
      'color': Colors.deepPurple[400]!,
      'desc': 'Shorthand for widget.key. Keys identify Elements '
          'across rebuilds. LocalKeys help with list reordering. '
          'GlobalKeys enable cross-subtree Element migration.',
    },
    {
      'name': 'bool get mounted',
      'color': Colors.amber[500]!,
      'desc': 'True between mount() and unmount() calls. Indicates '
          'the Element is actively in the tree. Accessing element '
          'properties when !mounted can cause errors. State.mounted '
          'delegates to the Element\'s mounted.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 8: Related Concepts
  // ============================================================
  print('=== Section 8: Related ===');

  final relatedConcepts = <Map<String, dynamic>>[
    {
      'name': 'Widget',
      'color': Colors.deepPurple[600]!,
      'desc': 'The immutable description that Elements instantiate. '
          'Widget.createElement() produces the Element. Widgets are '
          'the API developers write; Elements are the runtime reality '
          'that the framework manages.',
    },
    {
      'name': 'RenderObject',
      'color': Colors.amber[700]!,
      'desc': 'The layout/paint worker that RenderObjectElements '
          'create and manage. Not all Elements have one — '
          'ComponentElements don\'t. RenderObject does the heavy '
          'lifting of measuring and painting pixels.',
    },
    {
      'name': 'BuildOwner',
      'color': Colors.deepPurple[500]!,
      'desc': 'Manages the build lifecycle across all Elements. '
          'Maintains the dirty list, orchestrates rebuilds in '
          'depth-first order, handles global key registration, '
          'and manages inactive element finalization.',
    },
    {
      'name': 'State',
      'color': Colors.amber[600]!,
      'desc': 'The mutable logic holder for StatefulWidgets. State '
          'is owned by StatefulElement and persists when the Widget '
          'is replaced with canUpdate. setState() calls Element\'s '
          'markNeedsBuild() through the Element reference.',
    },
    {
      'name': 'InheritedElement',
      'color': Colors.deepPurple[400]!,
      'desc': 'Special Element subclass for InheritedWidgets. Tracks '
          'dependent Elements and notifies them when data changes. '
          'This dependency system powers Theme.of(), MediaQuery.of(), '
          'and all "of" patterns in Flutter.',
    },
  ];

  print('  Prepared ${relatedConcepts.length} concepts');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'BuildContext IS an Element',
      'body': 'Every time you see BuildContext, think Element. The '
          'context parameter in build() is literally the Element. '
          'Understanding Element means understanding BuildContext. '
          'This is the single most important Flutter insight.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Keys for List Identity',
      'body': 'In lists, add Keys to preserve Element identity when '
          'reordering. Without keys, Flutter matches by position. '
          'With keys, it matches by identity and can efficiently '
          'move Elements without destroying state.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Hold Element References',
      'body': 'Element references can become stale after deactivation. '
          'Never store an Element or BuildContext for later use '
          'outside the build phase. Use DisposableBuildContext for '
          'long-lived context references, or use callbacks.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Widget Type Changes Are Expensive',
      'body': 'Changing a Widget\'s runtime type at a tree position '
          'causes Element replacement (new State, new RenderObject). '
          'If you only need to change properties, keep the same '
          'Widget type and pass different constructor arguments.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'GlobalKey Enables Cross-Tree Migration',
      'body': 'GlobalKey lets an Element survive being removed from '
          'one location and reinserted at another — even in a '
          'different subtree. The entire subtree (State, RenderObject) '
          'migrates. Useful but expensive. Use sparingly.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Deep Trees = Slow Lookups',
      'body': 'Methods like findAncestorStateOfType walk up the tree '
          'linearly. In very deep trees, frequent ancestor lookups '
          'get slow. Prefer InheritedWidget (O(1) cached lookup) '
          'over manual tree walking for repeated access.',
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
      title: Text('Element'),
      backgroundColor: Colors.deepPurple[600],
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
                colors: [Colors.deepPurple[600]!, Colors.amber[600]!],
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
                  'Element',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The central runtime object in Flutter\'s three-tree architecture. '
                  'Element bridges the immutable Widget descriptions with the mutable '
                  'RenderObject painting system. It IS the BuildContext, manages '
                  'lifecycle, and enables efficient incremental rebuilds through '
                  'the canUpdate + dirty mechanism.',
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
          _elHead('1', 'What is an Element?'),
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

          // ── Section 2: Three Trees ──
          _elHead('2', 'The Three Trees'),
          SizedBox(height: 12),
          ...trees.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: t['name'] == 'Element Tree'
                        ? Colors.deepPurple[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: t['color'] as Color, width: 4),
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
                        Icon(t['icon'] as IconData,
                            color: t['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(t['name'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey[900])),
                      ]),
                      SizedBox(height: 6),
                      Text(t['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (t['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(t['role'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: t['color'] as Color)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Subclasses ──
          _elHead('3', 'Element Subclass Hierarchy'),
          SizedBox(height: 12),
          ...subclasses.map((s) => Padding(
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
                        _elTag(s['name'] as String, s['color'] as Color),
                        SizedBox(width: 8),
                        Text('extends ${s['parent']}',
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[500],
                                fontFamily: 'monospace')),
                      ]),
                      SizedBox(height: 6),
                      Text(s['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 4),
                      Text('Subclasses: ${s['children']}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Lifecycle ──
          _elHead('4', 'Element Lifecycle'),
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
                                    fontSize: 12,
                                    fontFamily: 'monospace')),
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

          // ── Section 5: Update Algorithm ──
          _elHead('5', 'The Update Algorithm'),
          SizedBox(height: 12),
          ...updateRules.map((ur) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ur['color'] as Color, width: 4),
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
                        Icon(ur['icon'] as IconData,
                            color: ur['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ur['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(ur['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: BuildContext Methods ──
          _elHead('6', 'BuildContext Interface'),
          SizedBox(height: 12),
          ...contextMethods.map((cm) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cm['color'] as Color, width: 4),
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
                      Text(cm['name'] as String,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: cm['color'] as Color)),
                      SizedBox(height: 6),
                      Text(cm['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Properties ──
          _elHead('7', 'Key Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
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
                      Text(p['name'] as String,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: p['color'] as Color)),
                      SizedBox(height: 6),
                      Text(p['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Related ──
          _elHead('8', 'Related Concepts'),
          SizedBox(height: 12),
          ...relatedConcepts.map((r) => Padding(
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
                      _elTag(r['name'] as String, r['color'] as Color),
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
          _elHead('9', 'Tips & Best Practices'),
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
              'End of Element Deep Demo',
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
Widget _elHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepPurple[600],
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
Widget _elTag(String text, Color color) {
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
