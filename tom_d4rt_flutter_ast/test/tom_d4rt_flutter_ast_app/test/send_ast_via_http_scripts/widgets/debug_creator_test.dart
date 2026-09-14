// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DebugCreator
// Demonstrates DebugCreator — a DiagnosticsNode used to associate
// RenderObjects with the Widget (and Element) that created them.
// It powers Flutter's error messages ("The relevant error-causing
// widget was:") and the Flutter Inspector's widget-render object link.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DebugCreator Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DebugCreator?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.bug_report,
      'title': 'Linking Widgets to RenderObjects',
      'body': 'DebugCreator is a DiagnosticsNode that stores a '
          'reference to the Element that created a RenderObject. '
          'When a RenderObject throws an error during layout or '
          'paint, Flutter uses the DebugCreator to report which '
          'widget caused the problem. Without it, error messages '
          'would only show raw RenderObject types.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.link,
      'title': 'The debugCreator Property',
      'body': 'Every RenderObject has a debugCreator property '
          '(type Object?). When the framework creates a '
          'RenderObject via RenderObjectElement.mount(), it sets '
          'renderObject.debugCreator = DebugCreator(this). '
          '"this" is the Element, which holds the Widget reference.',
      'accent': Colors.purple[500]!,
    },
    {
      'icon': Icons.error_outline,
      'title': 'Error Message Enhancement',
      'body': 'When a layout or paint error occurs, the framework '
          'walks up from the RenderObject and inspects debugCreator. '
          'It extracts the widget and element to produce messages '
          'like "The relevant error-causing widget was: Container" '
          'followed by the exact location in your source code.',
      'accent': Colors.deepPurple[400]!,
    },
    {
      'icon': Icons.search,
      'title': 'Inspector Integration',
      'body': 'The Flutter Inspector (DevTools) uses debugCreator '
          'to link the render tree back to the widget tree. When '
          'you select a RenderObject in the inspector, it can '
          'highlight the corresponding widget because of this '
          'debug information chain.',
      'accent': Colors.purple[400]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: DiagnosticsNode Hierarchy
  // ============================================================
  print('=== Section 2: Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'name': 'DiagnosticsNode',
      'depth': 0,
      'color': Colors.grey[600]!,
      'note': 'Abstract base: name, value, style, properties, children',
    },
    {
      'name': 'DiagnosticsProperty<T>',
      'depth': 1,
      'color': Colors.grey[500]!,
      'note': 'Typed property node for diagnostic information',
    },
    {
      'name': 'DebugCreator',
      'depth': 1,
      'color': Colors.deepPurple[600]!,
      'note': 'Wraps an Element reference for render-to-widget linking',
    },
    {
      'name': 'StringProperty',
      'depth': 1,
      'color': Colors.grey[400]!,
      'note': 'String diagnostic property (sibling, not related)',
    },
    {
      'name': 'FlagProperty',
      'depth': 1,
      'color': Colors.grey[400]!,
      'note': 'Boolean flag summary (sibling, not related)',
    },
  ];

  print('  Prepared ${hierarchy.length} hierarchy items');

  // ============================================================
  // SECTION 3: How the Framework Uses It
  // ============================================================
  print('=== Section 3: Framework Usage ===');

  final frameworkSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'RenderObjectElement.mount()',
      'color': Colors.deepPurple[600]!,
      'detail': 'When a RenderObjectElement is mounted, it calls '
          'widget.createRenderObject(this). Immediately after, in '
          'debug mode, it sets renderObject.debugCreator = '
          'DebugCreator(this). The "this" is the element.',
    },
    {
      'step': 2,
      'title': 'RenderObject stores reference',
      'color': Colors.purple[500]!,
      'detail': 'RenderObject has a debugCreator property of type '
          'Object?. In release mode this is compiled away (it\'s '
          'inside assert blocks). In debug mode, it holds the '
          'DebugCreator instance with the creating element.',
    },
    {
      'step': 3,
      'title': 'Error occurs in RenderObject',
      'color': Colors.deepPurple[400]!,
      'detail': 'During layout, paint, or hit-testing, a RenderObject '
          'throws (e.g., "A RenderFlex overflowed"). The framework '
          'catches this and creates a FlutterError with diagnostic '
          'information.',
    },
    {
      'step': 4,
      'title': 'debugCreator inspected',
      'color': Colors.purple[400]!,
      'detail': 'The error handler inspects renderObject.debugCreator. '
          'If it is a DebugCreator, the framework extracts the '
          'Element, gets the Widget reference, and produces the '
          '"relevant error-causing widget" line in the error report.',
    },
    {
      'step': 5,
      'title': 'Error message displayed',
      'color': Colors.deepPurple[300]!,
      'detail': 'The final error message includes: the error itself, '
          'the RenderObject type, the widget name and location, '
          'and often the parent chain. All of this is possible '
          'because DebugCreator linked render to widget.',
    },
  ];

  print('  Prepared ${frameworkSteps.length} steps');

  // ============================================================
  // SECTION 4: Error Messages With & Without
  // ============================================================
  print('=== Section 4: Error Messages ===');

  final errorExamples = <Map<String, dynamic>>[
    {
      'title': 'WITH DebugCreator (normal)',
      'color': Colors.green[600]!,
      'icon': Icons.check_circle,
      'message': '══╡ EXCEPTION CAUGHT BY RENDERING ╞══\n'
          'A RenderFlex overflowed by 42 pixels\n'
          'on the right.\n'
          '\n'
          'The relevant error-causing widget was:\n'
          '  Row\n'
          '  lib/main.dart:47:12\n'
          '\n'
          'The overflowing RenderFlex has an\n'
          'orientation of Axis.horizontal.',
      'note': 'DebugCreator tells you exactly which Row widget '
          'caused the overflow and where in your source code.',
    },
    {
      'title': 'WITHOUT DebugCreator (hypothetical)',
      'color': Colors.red[500]!,
      'icon': Icons.cancel,
      'message': '══╡ EXCEPTION CAUGHT BY RENDERING ╞══\n'
          'A RenderFlex overflowed by 42 pixels\n'
          'on the right.\n'
          '\n'
          'The overflowing RenderFlex has an\n'
          'orientation of Axis.horizontal.\n'
          '\n'
          '(No widget information available)',
      'note': 'Without DebugCreator, you would only know a RenderFlex '
          'overflowed, but not which widget or file it came from.',
    },
  ];

  print('  Prepared ${errorExamples.length} error examples');

  // ============================================================
  // SECTION 5: DebugCreator Internals
  // ============================================================
  print('=== Section 5: Internals ===');

  final internals = <Map<String, dynamic>>[
    {
      'title': 'Constructor',
      'color': Colors.deepPurple[600]!,
      'code': '// DebugCreator(Element element)\n'
          '//\n'
          '// Takes the Element that created the\n'
          '// RenderObject. The element holds:\n'
          '//   element.widget  → Widget reference\n'
          '//   element.toStringShort() → type name\n'
          '//   element.debugGetCreatorChain()\n'
          '//     → ancestor widget chain',
    },
    {
      'title': 'element Property',
      'color': Colors.purple[500]!,
      'code': '// DebugCreator exposes:\n'
          '//   final Element element;\n'
          '//\n'
          '// Through element, you can access:\n'
          '//   element.widget       → the Widget\n'
          '//   element.widget.key   → the Key\n'
          '//   element.depth        → tree depth\n'
          '//   element.owner        → BuildOwner\n'
          '//   element.renderObject → the RenderObj',
    },
    {
      'title': 'toString() Override',
      'color': Colors.deepPurple[400]!,
      'code': '// DebugCreator.toString() returns:\n'
          '//   element.debugGetCreatorChain(12)\n'
          '//\n'
          '// This produces a chain like:\n'
          '//   "Container ← Padding ← Column ←\n'
          '//    Scaffold ← MyHomePage"\n'
          '//\n'
          '// The number 12 is the maximum chain\n'
          '// depth to report.',
    },
    {
      'title': 'Debug-Only Nature',
      'color': Colors.purple[400]!,
      'code': '// debugCreator is set inside assert():\n'
          '//\n'
          '// assert(() {\n'
          '//   renderObject.debugCreator =\n'
          '//     DebugCreator(this);\n'
          '//   return true;\n'
          '// }());\n'
          '//\n'
          '// In release builds, this code is\n'
          '// stripped. debugCreator is always null\n'
          '// in release mode. Zero overhead.',
    },
  ];

  print('  Prepared ${internals.length} internals');

  // ============================================================
  // SECTION 6: Creator Chain Visualization
  // ============================================================
  print('=== Section 6: Creator Chain ===');

  final creatorChain = <Map<String, dynamic>>[
    {
      'widget': 'MaterialApp',
      'depth': 0,
      'color': Colors.blue[600]!,
    },
    {
      'widget': 'Scaffold',
      'depth': 1,
      'color': Colors.blue[500]!,
    },
    {
      'widget': 'Column',
      'depth': 2,
      'color': Colors.indigo[400]!,
    },
    {
      'widget': 'Container',
      'depth': 3,
      'color': Colors.deepPurple[400]!,
    },
    {
      'widget': 'DecoratedBox (RenderObjectWidget)',
      'depth': 4,
      'color': Colors.deepPurple[600]!,
    },
  ];

  final chainDetails = <Map<String, dynamic>>[
    {
      'title': 'What debugGetCreatorChain() Shows',
      'body': 'Starting from the RenderObject\'s creating Element, '
          'it walks up the element tree collecting widget names. '
          'This creates the "Container ← Column ← Scaffold" style '
          'chain you see in error messages. It stops at the given '
          'depth limit (default 12).',
      'color': Colors.deepPurple[600]!,
    },
    {
      'title': 'Only RenderObjectElements Create',
      'body': 'DebugCreator is only set on RenderObjects created by '
          'RenderObjectElements. StatelessElement and '
          'StatefulElement (ComponentElements) do NOT create '
          'RenderObjects, so they never produce a DebugCreator. '
          'They appear in the chain as ancestors.',
      'color': Colors.purple[500]!,
    },
    {
      'title': 'InspectorSelection Uses It',
      'body': 'When DevTools\' widget inspector highlights a widget, '
          'it finds the RenderObject, reads debugCreator, extracts '
          'the Element, and highlights the Widget. The whole '
          'Widget Inspector relies on this debug-mode link.',
      'color': Colors.deepPurple[400]!,
    },
  ];

  print('  Prepared creator chain with ${creatorChain.length} nodes');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Framework Sets debugCreator',
      'color': Colors.deepPurple[600]!,
      'code': '// In RenderObjectElement.mount():\n'
          '//\n'
          '// @override\n'
          '// void mount(Element? parent, Object? slot) {\n'
          '//   super.mount(parent, slot);\n'
          '//   _renderObject =\n'
          '//     (widget as RenderObjWidget)\n'
          '//       .createRenderObject(this);\n'
          '//\n'
          '//   assert(() {\n'
          '//     _renderObject!.debugCreator =\n'
          '//       DebugCreator(this);\n'
          '//     return true;\n'
          '//   }());\n'
          '//\n'
          '//   attachRenderObject(slot);\n'
          '//   super.performRebuild();\n'
          '// }',
    },
    {
      'title': 'Error Handler Reads debugCreator',
      'color': Colors.purple[500]!,
      'code': '// In the error reporting code:\n'
          '//\n'
          '// if (renderObj.debugCreator != null) {\n'
          '//   final creator = renderObj.debugCreator;\n'
          '//   if (creator is DebugCreator) {\n'
          '//     information.add(\n'
          '//       DiagnosticsDebugCreator(creator)\n'
          '//     );\n'
          '//   }\n'
          '// }\n'
          '//\n'
          '// This adds the widget chain to the\n'
          '// FlutterError\'s diagnostic properties.',
    },
    {
      'title': 'Custom RenderObject with Creator',
      'color': Colors.deepPurple[400]!,
      'code': '// If you create a custom RenderObject\n'
          '// outside the widget framework, you can\n'
          '// manually set debugCreator:\n'
          '//\n'
          '// final myRenderObj = MyRenderBox();\n'
          '// assert(() {\n'
          '//   myRenderObj.debugCreator =\n'
          '//     \'Created by MySpecialWidget\';\n'
          '//   return true;\n'
          '// }());\n'
          '//\n'
          '// debugCreator is Object?, so you can\n'
          '// set it to any debug-helpful value.',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 8: Related Debug Tools
  // ============================================================
  print('=== Section 8: Related ===');

  final relatedTools = <Map<String, dynamic>>[
    {
      'tool': 'debugGetCreatorChain()',
      'color': Colors.deepPurple[600]!,
      'desc': 'Element method that walks ancestors collecting widget '
          'names. DebugCreator.toString() calls this. Returns a '
          'string like "Container ← Padding ← Column ← Scaffold".',
    },
    {
      'tool': 'DiagnosticsDebugCreator',
      'color': Colors.purple[500]!,
      'desc': 'A specialized DiagnosticsNode that wraps a DebugCreator '
          'for inclusion in FlutterError diagnostic outputs. Formats '
          'the creator chain for error messages.',
    },
    {
      'tool': 'debugFillProperties()',
      'color': Colors.deepPurple[400]!,
      'desc': 'Override on Widget and RenderObject to provide custom '
          'diagnostic properties. Works alongside DebugCreator to '
          'give rich error information.',
    },
    {
      'tool': 'debugDescribeChildren()',
      'color': Colors.purple[400]!,
      'desc': 'Returns diagnostic info about a node\'s children. '
          'Used by the widget inspector to build the tree view. '
          'Complementary to DebugCreator.',
    },
    {
      'tool': 'FlutterError.reportError()',
      'color': Colors.deepPurple[300]!,
      'desc': 'The central error reporting function. Reads DebugCreator '
          'from the error\'s informationCollector to include widget '
          'context in the error output.',
    },
  ];

  print('  Prepared ${relatedTools.length} tools');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Debug-Only, Zero Cost',
      'body': 'DebugCreator and debugCreator exist only in debug mode. '
          'In release builds, they are compiled away via assert(). '
          'There is zero memory or performance cost in production.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Read Error Messages Carefully',
      'body': 'When you see "The relevant error-causing widget was:", '
          'that information was produced by DebugCreator. It tells '
          'you exactly which widget and source location caused the '
          'problem. Always look for this line first.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Custom RenderObjects Need It',
      'body': 'If you create RenderObjects manually (outside the widget '
          'framework), set debugCreator yourself in an assert block. '
          'Otherwise, errors from your RenderObject will lack '
          'widget context in debug messages.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Inspector Depends on It',
      'body': 'The Flutter DevTools widget inspector uses debugCreator '
          'to link render objects to widgets. If debugCreator is '
          'null, the inspector cannot show the creating widget for '
          'that render object.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use debugFillProperties Too',
      'body': 'While DebugCreator provides the "which widget" info, '
          'debugFillProperties provides the "what properties" info. '
          'Together they create rich, actionable error messages. '
          'Always override debugFillProperties in custom widgets.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Access in Release',
      'body': 'Never write production code that depends on debugCreator. '
          'It is null in release mode. Use it only for debugging, '
          'logging, and testing. Accessing it in release code will '
          'always give you null.',
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
      title: Text('DebugCreator'),
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
                colors: [Colors.deepPurple[600]!, Colors.purple[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.bug_report, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DebugCreator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A DiagnosticsNode that links each RenderObject to the '
                  'Widget and Element that created it. Powers Flutter\'s '
                  '"relevant error-causing widget" messages, the widget '
                  'inspector, and the debug creator chain.',
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
          _dcHead('1', 'What is DebugCreator?'),
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
          _dcHead('2', 'DiagnosticsNode Hierarchy'),
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
              children: hierarchy.map((h) {
                final depth = h['depth'] as int;
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: 8, left: depth * 20.0),
                  child: Row(children: [
                    if (depth > 0)
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text('└─',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.grey[400])),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (h['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: h['color'] as Color),
                      ),
                      child: Text(h['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
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
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 3: Framework Usage ──
          _dcHead('3', 'How the Framework Uses It'),
          SizedBox(height: 12),
          ...frameworkSteps.map((fs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: fs['color'] as Color, width: 4),
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
                          color: fs['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${fs['step']}',
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
                            Text(fs['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace')),
                            SizedBox(height: 4),
                            Text(fs['detail'] as String,
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

          // ── Section 4: Error Messages ──
          _dcHead('4', 'Error Messages Comparison'),
          SizedBox(height: 12),
          ...errorExamples.map((ee) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ee['color'] as Color, width: 4),
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
                        Icon(ee['icon'] as IconData,
                            color: ee['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Text(ee['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: ee['color'] as Color)),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ee['message'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.red[200],
                                height: 1.5)),
                      ),
                      SizedBox(height: 8),
                      Text(ee['note'] as String,
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

          // ── Section 5: Internals ──
          _dcHead('5', 'DebugCreator Internals'),
          SizedBox(height: 12),
          ...internals.map((ic) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ic['color'] as Color, width: 4),
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
                      Text(ic['title'] as String,
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
                        child: Text(ic['code'] as String,
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

          // ── Section 6: Creator Chain ──
          _dcHead('6', 'Creator Chain Visualization'),
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
                Text('Widget Creator Chain (bottom → top):',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[800])),
                SizedBox(height: 12),
                ...creatorChain.reversed.map((cc) {
                  final depth = cc['depth'] as int;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        SizedBox(width: depth * 16.0),
                        if (depth > 0)
                          Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.arrow_upward,
                                size: 12,
                                color: cc['color'] as Color),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: (cc['color'] as Color)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: cc['color'] as Color),
                          ),
                          child: Text(cc['widget'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: cc['color'] as Color)),
                        ),
                        if (depth == creatorChain.length - 1)
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: _dcTag('debugCreator set here',
                                Colors.deepPurple[600]!),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 10),
          ...chainDetails.map((cd) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (cd['color'] as Color).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (cd['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cd['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: cd['color'] as Color)),
                      SizedBox(height: 4),
                      Text(cd['body'] as String,
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
          _dcHead('7', 'Code Patterns'),
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
                                color: Colors.purple[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Related ──
          _dcHead('8', 'Related Debug Tools'),
          SizedBox(height: 12),
          ...relatedTools.map((rt) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: rt['color'] as Color, width: 4),
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
                      _dcTag(rt['tool'] as String,
                          rt['color'] as Color),
                      SizedBox(height: 8),
                      Text(rt['desc'] as String,
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
          _dcHead('9', 'Tips & Best Practices'),
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
              'End of DebugCreator Deep Demo',
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
Widget _dcHead(String number, String title) {
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
Widget _dcTag(String text, Color color) {
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
