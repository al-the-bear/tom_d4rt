// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DisposableBuildContext
// Demonstrates DisposableBuildContext — a wrapper that holds a
// BuildContext reference and can be explicitly disposed.  After
// disposal, the context property returns null, allowing holders
// to detect when their cached BuildContext is no longer valid.
// Used by ScrollPosition, KeepAliveHandle, and other long-lived
// objects that outlive the widget that provided the context.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DisposableBuildContext Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DisposableBuildContext?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.delete_outline,
      'title': 'Disposable Context Reference',
      'body': 'DisposableBuildContext wraps a BuildContext (specifically '
          'a State object) and adds disposal semantics. Before disposal, '
          'the context property returns the State\'s BuildContext. After '
          'disposal, it returns null. This lets long-lived objects know '
          'when their context reference is stale.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.timer_off,
      'title': 'Solving the Stale Context Problem',
      'body': 'In Flutter, BuildContext is only valid while its widget '
          'is mounted. But some objects (like ScrollPosition) outlive '
          'the widget that created them. If they hold a raw BuildContext, '
          'they can accidentally use it after disposal — causing crashes. '
          'DisposableBuildContext prevents this.',
      'accent': Colors.blueGrey[600]!,
    },
    {
      'icon': Icons.security,
      'title': 'Safe Context Access Pattern',
      'body': 'Instead of storing a raw BuildContext, store a '
          'DisposableBuildContext. Before using it, check if context '
          'is null. If null, the widget was unmounted. If non-null, '
          'you\'re safe to use it. This replaces error-prone '
          'mounted checks on State objects.',
      'accent': Colors.brown[500]!,
    },
    {
      'icon': Icons.link_off,
      'title': 'Explicit Lifecycle Control',
      'body': 'The dispose() method explicitly nulls out the context '
          'reference. This is called by the widget\'s State.dispose() '
          'method. After this, any code with a reference to the '
          'DisposableBuildContext sees null and skips operations '
          'that need a valid context.',
      'accent': Colors.blueGrey[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Stale Context Problem
  // ============================================================
  print('=== Section 2: Problem ===');

  final problemScenarios = <Map<String, dynamic>>[
    {
      'title': 'The Dangerous Pattern',
      'color': Colors.red[500]!,
      'icon': Icons.dangerous,
      'code': '// WRONG: Storing raw BuildContext\n'
          '//\n'
          '// class MyScrollPosition {\n'
          '//   BuildContext _context; // Dangerous!\n'
          '//\n'
          '//   void scrollToItem() {\n'
          '//     // _context may be unmounted!\n'
          '//     final rObj = _context.findRenderObject();\n'
          '//     // CRASH if widget was disposed\n'
          '//   }\n'
          '// }',
      'note': 'Storing a raw BuildContext in a long-lived object is '
          'dangerous. The widget might unmount while the object '
          'still holds the reference.',
    },
    {
      'title': 'The Safe Pattern',
      'color': Colors.green[600]!,
      'icon': Icons.check_circle,
      'code': '// CORRECT: Using DisposableBuildContext\n'
          '//\n'
          '// class MyScrollPosition {\n'
          '//   DisposableBuildContext? _ctx;\n'
          '//\n'
          '//   void scrollToItem() {\n'
          '//     final context = _ctx?.context;\n'
          '//     if (context == null) return;\n'
          '//     final rObj = context.findRenderObject();\n'
          '//     // Safe: context is valid\n'
          '//   }\n'
          '// }',
      'note': 'DisposableBuildContext becomes null after disposal, '
          'so the null check naturally prevents stale access.',
    },
  ];

  print('  Prepared ${problemScenarios.length} scenarios');

  // ============================================================
  // SECTION 3: API Deep Dive
  // ============================================================
  print('=== Section 3: API ===');

  final apiItems = <Map<String, dynamic>>[
    {
      'name': 'DisposableBuildContext(State state)',
      'kind': 'Constructor',
      'color': Colors.brown[600]!,
      'desc': 'Creates a DisposableBuildContext wrapping the given '
          'State object. The State must be mounted. The constructor '
          'stores the State\'s BuildContext internally. Typically '
          'called in State.initState() or during initialization.',
    },
    {
      'name': 'BuildContext? get context',
      'kind': 'Property',
      'color': Colors.blueGrey[600]!,
      'desc': 'Returns the wrapped BuildContext if the State is still '
          'mounted and dispose() hasn\'t been called. Returns null '
          'if either condition fails. This is the main access point '
          'for getting the context safely.',
    },
    {
      'name': 'void dispose()',
      'kind': 'Method',
      'color': Colors.brown[500]!,
      'desc': 'Marks this DisposableBuildContext as disposed. After '
          'this call, context always returns null. Should be called '
          'in State.dispose() to clean up the reference. Calling '
          'dispose multiple times is safe (idempotent).',
    },
  ];

  print('  Prepared ${apiItems.length} API items');

  // ============================================================
  // SECTION 4: Who Uses It?
  // ============================================================
  print('=== Section 4: Consumers ===');

  final consumers = <Map<String, dynamic>>[
    {
      'title': 'ScrollPosition',
      'icon': Icons.swap_vert,
      'color': Colors.brown[600]!,
      'desc': 'ScrollPosition is a long-lived object (managed by '
          'ScrollController) that can outlive the Scrollable widget. '
          'It stores a DisposableBuildContext to safely access the '
          'scrollable\'s context for ensureVisible(), '
          'viewportDimension calculations, and notification dispatch.',
      'lifecycle': 'Created in ScrollableState.initState()\n'
          'Disposed in ScrollableState.dispose()',
    },
    {
      'title': 'ScrollableState',
      'icon': Icons.list,
      'color': Colors.blueGrey[600]!,
      'desc': 'ScrollableState creates the DisposableBuildContext and '
          'passes it to ScrollPosition during attachment. When the '
          'State is disposed, it disposes the DisposableBuildContext, '
          'which signals to the ScrollPosition that the context '
          'is no longer valid.',
      'lifecycle': 'Creates DisposableBuildContext(this)\n'
          'Passes to position via attach()',
    },
    {
      'title': 'KeepAliveHandle',
      'icon': Icons.push_pin,
      'color': Colors.brown[500]!,
      'desc': 'KeepAliveHandle (internal to AutomaticKeepAliveClientMixin) '
          'holds a context reference to request keep-alive status. '
          'DisposableBuildContext ensures the handle doesn\'t use a '
          'stale context after the widget scrolls off screen.',
      'lifecycle': 'Created when keep-alive starts\n'
          'Disposed when keep-alive ends',
    },
    {
      'title': 'Custom Long-Lived Objects',
      'icon': Icons.extension,
      'color': Colors.blueGrey[500]!,
      'desc': 'Any custom object that needs to hold a BuildContext '
          'reference beyond a single build frame should use '
          'DisposableBuildContext. Examples: animation controllers '
          'with context-aware callbacks, lazy loaders, prefetchers.',
      'lifecycle': 'Created in initState()\n'
          'Disposed in dispose()',
    },
  ];

  print('  Prepared ${consumers.length} consumers');

  // ============================================================
  // SECTION 5: Lifecycle Flow
  // ============================================================
  print('=== Section 5: Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'State.initState()',
      'color': Colors.brown[600]!,
      'detail': 'The State creates a DisposableBuildContext wrapping '
          'itself: _disposableCtx = DisposableBuildContext(this). '
          'At this point, the State is mounted and the context '
          'is valid.',
    },
    {
      'step': 2,
      'title': 'Context Shared',
      'color': Colors.blueGrey[600]!,
      'detail': 'The DisposableBuildContext is passed to another object '
          'that needs the context reference (e.g., ScrollPosition). '
          'That object stores it and uses .context to access it '
          'when needed.',
    },
    {
      'step': 3,
      'title': 'Normal Usage',
      'color': Colors.brown[500]!,
      'detail': 'During normal operation, .context returns the valid '
          'BuildContext. The holder can call findRenderObject(), '
          'findAncestorStateOfType(), dispatch notifications, '
          'etc. All safe because the widget is mounted.',
    },
    {
      'step': 4,
      'title': 'State.dispose() Called',
      'color': Colors.blueGrey[500]!,
      'detail': 'The widget is being removed. State.dispose() calls '
          '_disposableCtx.dispose(). The internal reference is '
          'nulled out. From this point, .context returns null.',
    },
    {
      'step': 5,
      'title': 'Post-Disposal Access',
      'color': Colors.brown[400]!,
      'detail': 'The holder (e.g., ScrollPosition) still exists but '
          'its DisposableBuildContext.context now returns null. The '
          'null check prevents any stale access. The holder can '
          'clean up or skip operations gracefully.',
    },
  ];

  print('  Prepared ${lifecycle.length} lifecycle steps');

  // ============================================================
  // SECTION 6: Pattern Comparison
  // ============================================================
  print('=== Section 6: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Without DisposableBuildContext',
      'color': Colors.red[500]!,
      'code': '// class MyState extends State<MyWidget> {\n'
          '//   late final MyController _ctrl;\n'
          '//\n'
          '//   @override\n'
          '//   void initState() {\n'
          '//     super.initState();\n'
          '//     _ctrl = MyController(context);\n'
          '//     // PROBLEM: _ctrl holds raw context\n'
          '//     // even after widget is disposed\n'
          '//   }\n'
          '//\n'
          '//   @override\n'
          '//   void dispose() {\n'
          '//     _ctrl.dispose();\n'
          '//     // But _ctrl might still be in use!\n'
          '//     super.dispose();\n'
          '//   }\n'
          '// }',
    },
    {
      'title': 'With DisposableBuildContext',
      'color': Colors.green[600]!,
      'code': '// class MyState extends State<MyWidget> {\n'
          '//   late final DisposableBuildContext _dctx;\n'
          '//   late final MyController _ctrl;\n'
          '//\n'
          '//   @override\n'
          '//   void initState() {\n'
          '//     super.initState();\n'
          '//     _dctx = DisposableBuildContext(this);\n'
          '//     _ctrl = MyController(_dctx);\n'
          '//   }\n'
          '//\n'
          '//   @override\n'
          '//   void dispose() {\n'
          '//     _dctx.dispose();\n'
          '//     // Now _ctrl sees null context\n'
          '//     _ctrl.dispose();\n'
          '//     super.dispose();\n'
          '//   }\n'
          '// }',
    },
    {
      'title': 'Controller Using DisposableBuildContext',
      'color': Colors.brown[500]!,
      'code': '// class MyController {\n'
          '//   DisposableBuildContext? _dctx;\n'
          '//\n'
          '//   MyController(this._dctx);\n'
          '//\n'
          '//   void doSomething() {\n'
          '//     final ctx = _dctx?.context;\n'
          '//     if (ctx == null) {\n'
          '//       return; // Widget disposed, skip\n'
          '//     }\n'
          '//     // Safe to use ctx here\n'
          '//     final ro = ctx.findRenderObject();\n'
          '//   }\n'
          '//\n'
          '//   void dispose() {\n'
          '//     _dctx = null;\n'
          '//   }\n'
          '// }',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 7: Common Mistakes
  // ============================================================
  print('=== Section 7: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Forgetting to Dispose',
      'severity': 'error',
      'color': Colors.red[600]!,
      'icon': Icons.error,
      'body': 'If you create a DisposableBuildContext but forget to '
          'call dispose() in State.dispose(), the context reference '
          'remains non-null even after the widget unmounts. This '
          'defeats the purpose. Always dispose in State.dispose().',
    },
    {
      'title': 'Creating Too Early',
      'severity': 'warning',
      'color': Colors.amber[600]!,
      'icon': Icons.warning,
      'body': 'Don\'t create DisposableBuildContext in the constructor '
          'or before the State is mounted. Create it in initState() '
          'or later. The State must be mounted for the context to '
          'be valid. Creating before mount may give a stale context.',
    },
    {
      'title': 'Not Null-Checking context',
      'severity': 'error',
      'color': Colors.red[500]!,
      'icon': Icons.error,
      'body': 'The whole point of DisposableBuildContext is that '
          'context can be null. If you access .context without a '
          'null check, you\'re back to the same crash risk as '
          'storing a raw BuildContext. Always check for null.',
    },
    {
      'title': 'Using After dispose()',
      'severity': 'tip',
      'color': Colors.blue[500]!,
      'icon': Icons.info,
      'body': 'After dispose(), context returns null. This is safe '
          'and expected. Design your code to handle null context '
          'by skipping operations, not by trying to re-acquire '
          'a new context. A disposed context means "widget is gone".',
    },
  ];

  print('  Prepared ${mistakes.length} mistakes');

  // ============================================================
  // SECTION 8: Related Concepts
  // ============================================================
  print('=== Section 8: Related ===');

  final relatedConcepts = <Map<String, dynamic>>[
    {
      'name': 'BuildContext',
      'color': Colors.brown[600]!,
      'desc': 'The raw context interface. Every Element implements '
          'BuildContext. DisposableBuildContext wraps it to add '
          'lifecycle awareness. BuildContext itself has no disposal '
          'concept — it lives as long as the Element.',
    },
    {
      'name': 'State.mounted',
      'color': Colors.blueGrey[600]!,
      'desc': 'State has a mounted property. Before DisposableBuildContext, '
          'code would check state.mounted before using the context. '
          'But this requires holding a reference to the State, not '
          'just the context. DisposableBuildContext encapsulates this.',
    },
    {
      'name': 'ScrollPosition',
      'color': Colors.brown[500]!,
      'desc': 'The primary consumer. ScrollPosition can be shared '
          'across multiple Scrollable widgets or persist when a '
          'Scrollable is unmounted and remounted. DisposableBuildContext '
          'tells it which Scrollable context is current.',
    },
    {
      'name': 'ChangeNotifier',
      'color': Colors.blueGrey[500]!,
      'desc': 'Like DisposableBuildContext, ChangeNotifier has a '
          'dispose() pattern. They share the dispose-then-check '
          'philosophy. DisposableBuildContext is for context references; '
          'ChangeNotifier is for listener references.',
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
      'title': 'Use for Long-Lived Objects',
      'body': 'Any object that stores a BuildContext and lives longer '
          'than a single build frame should use DisposableBuildContext. '
          'This includes controllers, position objects, animation '
          'observers, and background task handlers.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Null Check is the Safety Net',
      'body': 'The entire safety benefit comes from the null check: '
          '"final ctx = disposable.context; if (ctx == null) return;". '
          'This pattern is the core of safe stale-context avoidance. '
          'Make it a habit for all DisposableBuildContext access.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Bypass With Stored State',
      'body': 'If you store both the DisposableBuildContext AND the '
          'State object, you can bypass the safety by accessing '
          'state.context directly. Don\'t do this. Only access the '
          'context through DisposableBuildContext.context.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Framework Does It Automatically',
      'body': 'For most developers, you\'ll never create a '
          'DisposableBuildContext directly. ScrollableState, '
          'KeepAliveHandle, and other framework classes do it '
          'internally. Understanding it helps debug scroll issues.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pairs Well With ?. Operator',
      'body': 'Dart\'s null-aware operators make DisposableBuildContext '
          'ergonomic: "disposable.context?.findRenderObject()" — '
          'one line, completely safe. If disposed, the whole chain '
          'short-circuits to null.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'One DisposableBuildContext Per State',
      'body': 'A State should only create one DisposableBuildContext. '
          'Creating multiple for the same State is wasteful and '
          'confusing. If multiple objects need it, share the same '
          'DisposableBuildContext instance.',
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
      title: Text('DisposableBuildContext'),
      backgroundColor: Colors.brown[600],
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
                colors: [Colors.brown[600]!, Colors.blueGrey[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.delete_outline, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DisposableBuildContext',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A safe wrapper around BuildContext that becomes null '
                  'when disposed. Prevents stale context access in long-lived '
                  'objects like ScrollPosition and KeepAliveHandle that '
                  'outlive the widget providing the context.',
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
          _dbHead('1', 'What is DisposableBuildContext?'),
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

          // ── Section 2: Problem ──
          _dbHead('2', 'The Stale Context Problem'),
          SizedBox(height: 12),
          ...problemScenarios.map((ps) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ps['color'] as Color, width: 4),
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
                        Icon(ps['icon'] as IconData,
                            color: ps['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(ps['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: ps['color'] as Color)),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ps['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.brown[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(ps['note'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: API ──
          _dbHead('3', 'API Deep Dive'),
          SizedBox(height: 12),
          ...apiItems.map((ai) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ai['color'] as Color, width: 4),
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
                        _dbTag(ai['kind'] as String,
                            ai['color'] as Color),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ai['name'] as String,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(ai['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Consumers ──
          _dbHead('4', 'Who Uses It?'),
          SizedBox(height: 12),
          ...consumers.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['color'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(c['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ]),
                      SizedBox(height: 6),
                      Text(c['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: (c['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(c['lifecycle'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: c['color'] as Color,
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Lifecycle ──
          _dbHead('5', 'Lifecycle Flow'),
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

          // ── Section 6: Patterns ──
          _dbHead('6', 'Code Patterns'),
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
                              fontSize: 13,
                              color: p['color'] as Color)),
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
                                color: Colors.brown[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Common Mistakes ──
          _dbHead('7', 'Common Mistakes'),
          SizedBox(height: 12),
          ...mistakes.map((m) {
            Color bgColor;
            switch (m['severity']) {
              case 'error':
                bgColor = Colors.red[50]!;
                break;
              case 'warning':
                bgColor = Colors.amber[50]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                        color: m['color'] as Color, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(m['icon'] as IconData,
                          color: m['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(m['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: m['color'] as Color)),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(m['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 8: Related ──
          _dbHead('8', 'Related Concepts'),
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
                      _dbTag(r['name'] as String, r['color'] as Color),
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
          _dbHead('9', 'Tips & Best Practices'),
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
              'End of DisposableBuildContext Deep Demo',
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
Widget _dbHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.brown[600],
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
Widget _dbTag(String text, Color color) {
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
