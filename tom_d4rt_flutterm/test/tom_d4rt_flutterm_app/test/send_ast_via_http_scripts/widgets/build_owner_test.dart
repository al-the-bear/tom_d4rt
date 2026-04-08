// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BuildOwner
// Demonstrates BuildOwner — the scheduler and manager of the widget
// build pipeline. Every dirty element is tracked by a BuildOwner,
// which then drives performRebuild() during each frame. It is the
// engine behind setState(), hot reload, focus management, and more.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BuildOwner Deep Demo executing');

  // ============================================================
  // SECTION 1: What is BuildOwner?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.engineering,
      'title': 'The Build Pipeline Manager',
      'body': 'BuildOwner is the central coordinator that manages '
          'the build lifecycle of the widget tree. Every Element '
          'in the tree is owned by a single BuildOwner. When an '
          'element is marked dirty (e.g., via setState()), the '
          'BuildOwner schedules a rebuild and processes all dirty '
          'elements during the next frame.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.schedule,
      'title': 'Scheduling Builds',
      'body': 'When setState() is called on a State, it ultimately '
          'calls element.markNeedsBuild(), which adds the element '
          'to the BuildOwner\'s dirty list. The BuildOwner then '
          'calls onBuildScheduled to request a new frame from the '
          'engine. During that frame, buildScope() processes all '
          'dirty elements in depth-first order.',
      'accent': Colors.blue[600]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'One Per Tree (Usually)',
      'body': 'Typically there is one BuildOwner per widget tree, '
          'created and owned by WidgetsBinding. However, you can '
          'create additional BuildOwners for off-screen rendering, '
          'testing, or specialized build pipelines. Each operates '
          'its own dirty list and build cycle independently.',
      'accent': Colors.indigo[500]!,
    },
    {
      'icon': Icons.lock,
      'title': 'lockState & Assert Safety',
      'body': 'BuildOwner.lockState() prevents state changes during '
          'sensitive phases. During build and layout, calling '
          'setState() would corrupt the tree. lockState sets a flag '
          'so that markNeedsBuild() asserts if called during a '
          'build pass, catching bugs where widgets modify state '
          'during their own build().',
      'accent': Colors.blue[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Key Responsibilities
  // ============================================================
  print('=== Section 2: Responsibilities ===');

  final responsibilities = <Map<String, dynamic>>[
    {
      'role': 'Dirty Element Tracking',
      'icon': Icons.playlist_add_check,
      'color': Colors.indigo[700]!,
      'detail': 'Maintains an internal _dirtyElements list. When '
          'element.markNeedsBuild() is called, the element is added '
          'to this list. During buildScope(), elements are sorted '
          'by depth (shallow first) and rebuilt in order.',
    },
    {
      'role': 'Build Scope Execution',
      'icon': Icons.play_circle_filled,
      'color': Colors.blue[600]!,
      'detail': 'buildScope() is the core method. It locks state, '
          'sorts dirty elements by depth, then iterates calling '
          'element.rebuild() on each. If a rebuild creates new '
          'dirty elements (cascading rebuilds), they are added and '
          'processed in the same pass.',
    },
    {
      'role': 'Frame Scheduling',
      'icon': Icons.timer,
      'color': Colors.indigo[500]!,
      'detail': 'When an element is marked dirty for the first time '
          'in a frame, BuildOwner calls onBuildScheduled callback, '
          'which WidgetsBinding uses to schedule a frame via '
          'scheduleFrame(). This ensures the build pass happens at '
          'the next vsync.',
    },
    {
      'role': 'Tree Finalization',
      'icon': Icons.check_circle,
      'color': Colors.blue[500]!,
      'detail': 'finalizeTree() is called at the end of each frame. '
          'It unmounts elements that were deactivated during the '
          'build phase. Deactivated elements have one frame to be '
          'reinserted (via GlobalKey); if not, they are unmounted '
          'permanently.',
    },
    {
      'role': 'Focus Management',
      'icon': Icons.center_focus_strong,
      'color': Colors.indigo[400]!,
      'detail': 'BuildOwner holds the focusManager, which maintains '
          'the focus tree. After each build, the FocusManager '
          'reconciles focus state. The BuildOwner ensures focus '
          'changes are processed synchronously with builds.',
    },
    {
      'role': 'GlobalKey Deduplication',
      'icon': Icons.vpn_key,
      'color': Colors.blue[400]!,
      'detail': 'BuildOwner tracks all registered GlobalKeys and '
          'asserts that no two elements share the same GlobalKey '
          'simultaneously. This is checked during finalizeTree() '
          'and causes the famous "Multiple widgets used the same '
          'GlobalKey" error.',
    },
  ];

  print('  Prepared ${responsibilities.length} responsibilities');

  // ============================================================
  // SECTION 3: Key Methods
  // ============================================================
  print('=== Section 3: Key Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'scheduleBuildFor(element)',
      'returns': 'void',
      'color': Colors.indigo[700]!,
      'icon': Icons.schedule,
      'desc': 'Adds an element to the dirty list and triggers '
          'onBuildScheduled if this is the first dirty element '
          'since the last buildScope(). Called by '
          'Element.markNeedsBuild(). The element must be active '
          'and owned by this BuildOwner.',
    },
    {
      'name': 'buildScope(context, [callback])',
      'returns': 'void',
      'color': Colors.blue[600]!,
      'icon': Icons.loop,
      'desc': 'Executes the build pass. Sorts dirty elements by '
          'depth, then rebuilds each. If callback is provided, '
          'it is called first (used for the initial build). After '
          'processing, the dirty list is cleared. This is the hot '
          'path of the framework — called every frame.',
    },
    {
      'name': 'finalizeTree()',
      'returns': 'void',
      'color': Colors.indigo[500]!,
      'icon': Icons.delete_sweep,
      'desc': 'Called at the end of each frame. Walks through all '
          'deactivated elements. Those not reactivated are '
          'permanently unmounted. Also performs GlobalKey '
          'deduplication checks in debug mode.',
    },
    {
      'name': 'lockState(callback)',
      'returns': 'void',
      'color': Colors.blue[500]!,
      'icon': Icons.lock_outline,
      'desc': 'Executes callback with state-change assertions '
          'enabled. If any element tries to call markNeedsBuild() '
          'during the callback, an assertion fires. Used during '
          'builds and layout to catch illegal state modifications.',
    },
    {
      'name': 'reassemble(root)',
      'returns': 'void',
      'color': Colors.indigo[400]!,
      'icon': Icons.refresh,
      'desc': 'Triggers a full rebuild of the entire tree from root. '
          'Called by the framework during hot reload. Marks every '
          'element as dirty and runs a complete build pass. Also '
          'calls State.reassemble() on every StatefulElement.',
    },
  ];

  print('  Prepared ${methods.length} methods');

  // ============================================================
  // SECTION 4: Build Cycle Flow
  // ============================================================
  print('=== Section 4: Build Cycle ===');

  final cycleSteps = <Map<String, dynamic>>[
    {
      'phase': 1,
      'name': 'setState() / markNeedsBuild()',
      'color': Colors.indigo[700]!,
      'detail': 'User code calls setState(). The State\'s element '
          'calls markNeedsBuild(). This calls '
          'BuildOwner.scheduleBuildFor(this), which adds the '
          'element to _dirtyElements and calls onBuildScheduled.',
    },
    {
      'phase': 2,
      'name': 'onBuildScheduled → scheduleFrame()',
      'color': Colors.blue[600]!,
      'detail': 'WidgetsBinding sets onBuildScheduled to call '
          'ensureVisualUpdate(), which calls scheduleFrame(). '
          'This requests a vsync callback from the Flutter engine.',
    },
    {
      'phase': 3,
      'name': 'drawFrame() → buildScope()',
      'color': Colors.indigo[500]!,
      'detail': 'When the vsync fires, WidgetsBinding.drawFrame() '
          'calls buildOwner.buildScope(renderViewElement). This '
          'sorts _dirtyElements by depth and begins the rebuild.',
    },
    {
      'phase': 4,
      'name': 'element.rebuild() → performRebuild()',
      'color': Colors.blue[500]!,
      'detail': 'Each dirty element is rebuilt. For ComponentElements, '
          'performRebuild() calls build() to get a new child widget, '
          'then updateChild() to reconcile. New dirty elements from '
          'cascading changes are processed in the same pass.',
    },
    {
      'phase': 5,
      'name': 'Layout & Paint',
      'color': Colors.indigo[400]!,
      'detail': 'After buildScope() finishes, the rendering pipeline '
          'takes over. RenderObjects marked as needing layout are '
          'laid out, then those needing paint are painted. This is '
          'not part of BuildOwner but follows immediately.',
    },
    {
      'phase': 6,
      'name': 'finalizeTree()',
      'color': Colors.blue[400]!,
      'detail': 'At the end of the frame, finalizeTree() is called. '
          'Deactivated elements that were not re-inserted are '
          'permanently unmounted. GlobalKey checks are performed.',
    },
  ];

  print('  Prepared ${cycleSteps.length} cycle steps');

  // ============================================================
  // SECTION 5: Dirty List Deep Dive
  // ============================================================
  print('=== Section 5: Dirty List ===');

  final dirtyListFacts = <Map<String, dynamic>>[
    {
      'title': 'Depth-First Ordering',
      'icon': Icons.sort,
      'color': Colors.indigo[700]!,
      'body': 'Before processing, _dirtyElements is sorted by element '
          'depth (ascending). Shallow elements are rebuilt first. '
          'This ensures parents are rebuilt before children, so a '
          'child won\'t be rebuilt with stale parent data.',
    },
    {
      'title': 'Cascading Rebuilds',
      'icon': Icons.call_split,
      'color': Colors.blue[600]!,
      'body': 'When a parent rebuild changes the child widget '
          'configuration, the child element is also marked dirty. '
          'The build loop detects this and processes the new dirty '
          'element in the same pass (since it is deeper).',
    },
    {
      'title': 'Deduplication',
      'icon': Icons.filter_list,
      'color': Colors.indigo[500]!,
      'body': 'An element appears at most once in _dirtyElements. '
          'Calling markNeedsBuild() on an already-dirty element '
          'is a no-op. The element tracks its dirty state via an '
          'internal _dirty flag.',
    },
    {
      'title': 'Clean After Build',
      'icon': Icons.cleaning_services,
      'color': Colors.blue[500]!,
      'body': 'After buildScope() completes, _dirtyElements is '
          'cleared. All processed elements have _dirty set to '
          'false. The BuildOwner is ready for the next frame\'s '
          'dirty elements.',
    },
  ];

  print('  Prepared ${dirtyListFacts.length} dirty list facts');

  // ============================================================
  // SECTION 6: onBuildScheduled Callback
  // ============================================================
  print('=== Section 6: onBuildScheduled ===');

  final callbackFacts = <Map<String, dynamic>>[
    {
      'title': 'The Bridge to the Engine',
      'body': 'onBuildScheduled is a VoidCallback? property on '
          'BuildOwner. WidgetsBinding sets it during initialization '
          'to call _handleBuildScheduled(), which calls '
          'ensureVisualUpdate(). This is what connects widget state '
          'changes to the engine\'s frame scheduling.',
      'color': Colors.indigo[700]!,
    },
    {
      'title': 'Called Once Per Batch',
      'body': 'onBuildScheduled is only called when the first element '
          'in a frame becomes dirty. Subsequent elements dirtied '
          'before the next buildScope() are silently appended to '
          '_dirtyElements without re-triggering the callback.',
      'color': Colors.blue[600]!,
    },
    {
      'title': 'Custom Build Owners',
      'body': 'If you create your own BuildOwner (for off-screen '
          'rendering or testing), you must set onBuildScheduled '
          'to drive builds yourself. Without it, dirty elements '
          'will accumulate but never be processed.',
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Prepared ${callbackFacts.length} callback facts');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Accessing BuildOwner',
      'color': Colors.indigo[700]!,
      'code': '// Every Element has an owner:\n'
          '// element.owner  →  BuildOwner?\n'
          '//\n'
          '// From a BuildContext (which is an Element):\n'
          '// In framework code:\n'
          '//   (context as Element).owner\n'
          '//\n'
          '// From WidgetsBinding:\n'
          '//   WidgetsBinding.instance.buildOwner\n'
          '//\n'
          '// The main BuildOwner is created in\n'
          '// WidgetsBinding.initInstances():\n'
          '//   _buildOwner = BuildOwner();\n'
          '//   buildOwner!.onBuildScheduled =\n'
          '//     _handleBuildScheduled;',
    },
    {
      'title': 'How setState() Reaches BuildOwner',
      'color': Colors.blue[600]!,
      'code': '// setState(() { _count++; })\n'
          '//   ↓\n'
          '// State.setState:\n'
          '//   _element!.markNeedsBuild();\n'
          '//   ↓\n'
          '// Element.markNeedsBuild:\n'
          '//   _dirty = true;\n'
          '//   owner!.scheduleBuildFor(this);\n'
          '//   ↓\n'
          '// BuildOwner.scheduleBuildFor:\n'
          '//   _dirtyElements.add(element);\n'
          '//   if (!_scheduledFlushDirtyElements)\n'
          '//     onBuildScheduled?.call();\n'
          '//   ↓\n'
          '// WidgetsBinding._handleBuildScheduled:\n'
          '//   ensureVisualUpdate();\n'
          '//   scheduleFrame();',
    },
    {
      'title': 'Hot Reload via reassemble()',
      'color': Colors.indigo[500]!,
      'code': '// When hot reload triggers:\n'
          '//   WidgetsBinding.performReassemble()\n'
          '//   ↓\n'
          '//   buildOwner!.reassemble(\n'
          '//     renderViewElement!\n'
          '//   );\n'
          '//   ↓\n'
          '// BuildOwner.reassemble:\n'
          '//   timeline \'Dirty Element\'\n'
          '//   element.reassemble()\n'
          '//     → calls state.reassemble()\n'
          '//     → marks ALL elements dirty\n'
          '//   buildScope(element)\n'
          '//     → full rebuild of entire tree',
    },
    {
      'title': 'Testing with Custom BuildOwner',
      'color': Colors.blue[500]!,
      'code': '// In widget tests, the test framework\n'
          '// creates its own BuildOwner:\n'
          '//\n'
          '//   final owner = BuildOwner(\n'
          '//     focusManager: FocusManager(),\n'
          '//   );\n'
          '//   owner.onBuildScheduled = () {\n'
          '//     // pump to process builds\n'
          '//   };\n'
          '//\n'
          '// This allows the test framework\n'
          '// to control exactly when builds\n'
          '// happen (via pumpWidget / pump).',
    },
  ];

  print('  Prepared ${patterns.length} code patterns');

  // ============================================================
  // SECTION 8: Common Errors & Diagnostics
  // ============================================================
  print('=== Section 8: Diagnostics ===');

  final diagnostics = <Map<String, dynamic>>[
    {
      'error': 'setState() or markNeedsBuild() '
          'called during build',
      'icon': Icons.error_outline,
      'color': Colors.red[600]!,
      'cause': 'Code is modifying state inside a build() method. '
          'BuildOwner.lockState() is active during buildScope(), '
          'so markNeedsBuild() hits an assertion.',
      'fix': 'Move state changes to event handlers, addPostFrameCallback, '
          'or microtask. Never call setState inside build().',
    },
    {
      'error': 'Multiple widgets used the same GlobalKey',
      'icon': Icons.vpn_key,
      'color': Colors.orange[700]!,
      'cause': 'BuildOwner.finalizeTree() detected two active '
          'elements with the same GlobalKey. GlobalKeys must be '
          'unique across the entire tree.',
      'fix': 'Ensure each GlobalKey instance is used by exactly one '
          'widget. Don\'t share GlobalKeys across routes or create '
          'new ones in build().',
    },
    {
      'error': 'setState() called after dispose()',
      'icon': Icons.warning_amber,
      'color': Colors.amber[700]!,
      'cause': 'An async operation completed after the widget was '
          'unmounted and tries to call setState(). The element '
          'is no longer in the BuildOwner\'s tree.',
      'fix': 'Check mounted before calling setState(). Cancel async '
          'operations in dispose(). Use CancelableOperation or '
          'similar patterns.',
    },
    {
      'error': 'This widget has been unmounted',
      'icon': Icons.dangerous,
      'color': Colors.red[500]!,
      'cause': 'Code is accessing an element or context after '
          'finalizeTree() has unmounted it. The element\'s '
          'lifecycle is over.',
      'fix': 'Don\'t store BuildContext references. Don\'t use context '
          'in callbacks that outlive the widget\'s lifecycle.',
    },
  ];

  print('  Prepared ${diagnostics.length} diagnostics');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'BuildOwner Is Invisible',
      'body': 'You almost never interact with BuildOwner directly '
          'in production code. It works behind the scenes, driven '
          'by WidgetsBinding. Understanding it helps you diagnose '
          'framework errors and write better widgets.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Fight the Build Order',
      'body': 'BuildOwner rebuilds elements shallow-first. If you need '
          'child state to update before parent, you\'re fighting '
          'the framework. Use InheritedWidget, callbacks, or '
          'ValueNotifier to propagate state in the right direction.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Minimize Dirty Elements',
      'body': 'Every dirty element costs time in buildScope(). Push '
          'setState() as deep as possible in the tree. Use const '
          'constructors above the changing widget to prevent '
          'unnecessary parent rebuilds.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'focusManager Lives on BuildOwner',
      'body': 'BuildOwner holds the FocusManager as a property. '
          'If you create a custom BuildOwner and forget to provide '
          'a FocusManager, focus operations will fail. Always '
          'initialize: BuildOwner(focusManager: FocusManager()).',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'addPostFrameCallback for Post-Build',
      'body': 'If you need to read layout info after a build, use '
          'WidgetsBinding.instance.addPostFrameCallback(). This '
          'runs after buildScope(), layout, and paint — the '
          'safest point to inspect render objects.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'BuildOwner ≠ BuildContext',
      'body': 'BuildContext is the element (mutable node). BuildOwner '
          'is the manager that processes all elements. Many '
          'developers confuse them. context.owner is the BuildOwner, '
          'but context itself is just one element in the tree.',
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
      title: Text('BuildOwner'),
      backgroundColor: Colors.indigo[700],
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
                colors: [Colors.indigo[700]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.engineering, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'BuildOwner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The central coordinator of Flutter\'s widget build '
                  'pipeline. BuildOwner tracks dirty elements, schedules '
                  'builds, processes the dirty list each frame, finalizes '
                  'the tree, and manages focus. It is the engine that '
                  'makes setState() work.',
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
          _boHead('1', 'What is BuildOwner?'),
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

          // ── Section 2: Responsibilities ──
          _boHead('2', 'Key Responsibilities'),
          SizedBox(height: 12),
          ...responsibilities.map((r) => Padding(
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
                        Icon(r['icon'] as IconData,
                            color: r['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(r['role'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(r['detail'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Key Methods ──
          _boHead('3', 'Key Methods'),
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
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                        _boTag(m['returns'] as String,
                            m['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(m['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Build Cycle ──
          _boHead('4', 'Build Cycle Flow'),
          SizedBox(height: 12),
          ...cycleSteps.map((cs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cs['color'] as Color, width: 4),
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
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: cs['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${cs['phase']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(cs['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace')),
                            SizedBox(height: 4),
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

          // ── Section 5: Dirty List ──
          _boHead('5', 'The Dirty List'),
          SizedBox(height: 12),
          ...dirtyListFacts.map((dl) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: dl['color'] as Color, width: 4),
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
                        Icon(dl['icon'] as IconData,
                            color: dl['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(dl['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(dl['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: onBuildScheduled ──
          _boHead('6', 'onBuildScheduled Callback'),
          SizedBox(height: 12),
          ...callbackFacts.map((cf) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (cf['color'] as Color).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (cf['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cf['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: cf['color'] as Color)),
                      SizedBox(height: 8),
                      Text(cf['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _boHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 14),
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
                      Text(p['title'] as String,
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
                        child: Text(p['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.indigo[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Diagnostics ──
          _boHead('8', 'Common Errors'),
          SizedBox(height: 12),
          ...diagnostics.map((d) => Padding(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(d['icon'] as IconData,
                            color: d['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(d['error'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: d['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cause:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.red[700])),
                            Text(d['cause'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fix:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.green[700])),
                            Text(d['fix'] as String,
                                style: TextStyle(
                                    fontSize: 10,
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
          _boHead('9', 'Tips & Best Practices'),
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
              'End of BuildOwner Deep Demo',
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
Widget _boHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
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
// Helper: Return-type tag
// ──────────────────────────────────────────────────────────
Widget _boTag(String text, Color color) {
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
