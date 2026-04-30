// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsDebugger – a widget that overlays the
// semantics tree visualization on top of its child, showing labels, rects,
// and actions. Deep Demo: Concept, how it works, constructor, live demo,
// interpretation guide, comparison with tools, practical uses, summary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsDebugger Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.bug_report,
      'title': 'Semantics Visualization Tool',
      'body': 'SemanticsDebugger renders the semantics tree as a visual '
          'overlay on top of your app. Each semantic node is drawn as a '
          'colored rectangle with its label, making the invisible '
          'accessibility tree visible for debugging.',
    },
    {
      'icon': Icons.accessibility,
      'title': 'Accessibility Debugging',
      'body': 'Shows exactly what assistive technologies (screen readers, '
          'switch access) see in your app. If a widget has no semantic '
          'node, it will not appear in the debugger overlay.',
    },
    {
      'icon': Icons.layers,
      'title': 'Transparent Overlay',
      'body': 'The debugger draws semi-transparent rectangles over the '
          'normal UI. You can still see the widget underneath but with '
          'semantic boundaries and labels superimposed.',
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Toggle at Runtime',
      'body': 'Wrap your app in SemanticsDebugger and toggle it on/off '
          'with a boolean flag. Useful during development to quickly '
          'verify semantic annotations are correct.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.teal.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.teal.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: How It Works
  // ============================================================
  print('=== Section 2: How It Works ===');

  final howSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Semantics Tree Collection',
      'color': Colors.blue,
      'desc': 'SemanticsDebugger attaches a PipelineOwner listener to '
          'the semantics pipeline. When the semantics tree updates, '
          'it receives the latest SemanticsNode tree.',
    },
    {
      'step': '2',
      'title': 'Node Traversal',
      'color': Colors.purple,
      'desc': 'Walks the SemanticsNode tree recursively. Each node has '
          'a rect (position/size), label, actions, and flags. The '
          'debugger collects all this information.',
    },
    {
      'step': '3',
      'title': 'Overlay Painting',
      'color': Colors.green,
      'desc': 'A custom painter draws colored rectangles for each node. '
          'Labels are rendered as text. Different colors indicate '
          'different semantic properties (actions, labels, etc.).',
    },
    {
      'step': '4',
      'title': 'Gesture Translation',
      'color': Colors.orange,
      'desc': 'Taps and gestures on the overlay are translated into '
          'semantic actions. Tapping triggers the semantic tap action '
          'on the node at that position.',
    },
  ];

  final howWidgets = <Widget>[];
  for (final hs in howSteps) {
    final color = hs['color'] as Color;
    howWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                child: Text(
                  hs['step'] as String,
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hs['title'] as String,
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    hs['desc'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Constructor Parameters
  // ============================================================
  print('=== Section 3: Constructor ===');

  final ctorParams = <Map<String, dynamic>>[
    {
      'name': 'child',
      'type': 'Widget',
      'required': true,
      'desc': 'The widget subtree to overlay the semantics debugger on.',
    },
    {
      'name': 'labelStyle',
      'type': 'TextStyle',
      'required': false,
      'desc': 'Style for the label text drawn on each semantic node. '
          'Defaults to a small font. Customize to change visibility.',
    },
  ];

  final ctorCards = <Widget>[];
  for (final cp in ctorParams) {
    final isReq = cp['required'] as bool;
    ctorCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: isReq ? Colors.red.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                isReq ? 'required' : 'optional',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  color: isReq ? Colors.red.shade700 : Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        cp['name'] as String,
                        style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                            fontWeight: FontWeight.w700, color: Colors.teal.shade700),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        cp['type'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    cp['desc'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Live Demo
  // ============================================================
  print('=== Section 4: Live Demo ===');

  final liveDemo = _SDLiveDemo();

  // ============================================================
  // SECTION 5: Interpretation Guide
  // ============================================================
  print('=== Section 5: Interpretation ===');

  final interpretations = <Map<String, dynamic>>[
    {
      'visual': 'Colored Rectangle',
      'meaning': 'Bounds of a semantic node',
      'color': Colors.blue,
      'detail': 'Each rectangle shows the exact area an assistive '
          'technology considers as a single interactive element.',
    },
    {
      'visual': 'Text Label Inside',
      'meaning': 'Semantic label / value',
      'color': Colors.green,
      'detail': 'The text shown inside the rectangle is what a screen '
          'reader would announce. Missing labels mean the element '
          'is invisible to assistive tech.',
    },
    {
      'visual': 'Thick Border',
      'meaning': 'Has semantic actions',
      'color': Colors.orange,
      'detail': 'Thicker borders indicate the node has actions like tap, '
          'long press, scroll. These are the interactive elements.',
    },
    {
      'visual': 'Nested Rectangles',
      'meaning': 'Semantic tree hierarchy',
      'color': Colors.purple,
      'detail': 'Nested rectangles show the parent-child relationship. '
          'MergeSemantics collapses multiple nodes into one.',
    },
    {
      'visual': 'No Rectangle',
      'meaning': 'Not in semantics tree',
      'color': Colors.red,
      'detail': 'Widgets without any semantic annotation have no rectangle. '
          'They are invisible to screen readers.',
    },
  ];

  final interpCards = <Widget>[];
  for (final ip in interpretations) {
    final color = ip['color'] as Color;
    interpCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.0,
              height: 24.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: color, width: 1.5),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        ip['visual'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        '= ${ip['meaning']}',
                        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    ip['detail'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Comparison with Other Tools
  // ============================================================
  print('=== Section 6: Comparison ===');

  final compTools = <Map<String, dynamic>>[
    {
      'tool': 'SemanticsDebugger',
      'type': 'Widget',
      'pros': 'Visual overlay, sees semantic tree structure, works on device',
      'cons': 'Overlays change UI, limited detail',
      'color': Colors.teal,
    },
    {
      'tool': 'Flutter Inspector (DevTools)',
      'type': 'External Tool',
      'pros': 'Full tree inspection, searchable, non-invasive',
      'cons': 'Requires connection, separate window',
      'color': Colors.blue,
    },
    {
      'tool': 'debugDumpSemanticsTree()',
      'type': 'Function',
      'pros': 'Complete text dump, includes all properties',
      'cons': 'Console output only, hard to correlate with UI',
      'color': Colors.purple,
    },
    {
      'tool': 'Accessibility Scanner',
      'type': 'Platform Tool',
      'pros': 'Tests real screen reader behavior',
      'cons': 'Platform-specific, manual process',
      'color': Colors.orange,
    },
  ];

  final compCards = <Widget>[];
  for (final ct in compTools) {
    final color = ct['color'] as Color;
    compCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Text(
                    ct['tool'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      ct['type'] as String,
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: color),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pros', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.green.shade700)),
                        Text(ct['pros'] as String, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cons', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.red.shade700)),
                        Text(ct['cons'] as String, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Practical Uses
  // ============================================================
  print('=== Section 7: Practical Uses ===');

  final useCases = <Map<String, dynamic>>[
    {
      'icon': Icons.search,
      'title': 'Finding Missing Labels',
      'color': Colors.blue,
      'body': 'Quickly spot buttons and icons that lack semantic labels. '
          'Elements without rectangles in the debugger are invisible '
          'to screen readers.',
      'code': '// Missing semantic label:\n'
          'IconButton(\n'
          '  icon: Icon(Icons.share),\n'
          '  onPressed: share,\n'
          ')\n\n'
          '// Fixed:\n'
          'IconButton(\n'
          '  icon: Icon(Icons.share),\n'
          '  onPressed: share,\n'
          '  tooltip: "Share",\n'
          ')',
    },
    {
      'icon': Icons.merge,
      'title': 'Verifying MergeSemantics',
      'color': Colors.green,
      'body': 'Check that related elements are properly merged into a '
          'single semantic node. Without MergeSemantics, each child '
          'appears as a separate node.',
      'code': '// Before (3 separate nodes):\n'
          'Row(children: [\n'
          '  icon, Text("label"), badge\n'
          '])\n\n'
          '// After (1 merged node):\n'
          'MergeSemantics(\n'
          '  child: Row(children: [\n'
          '    icon, Text("label"), badge\n'
          '  ]),\n'
          ')',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'Checking ExcludeSemantics',
      'color': Colors.orange,
      'body': 'Verify that decorative elements are properly excluded from '
          'the semantics tree. Background images and ornaments should '
          'not clutter screen reader output.',
      'code': 'ExcludeSemantics(\n'
          '  child: DecorativeImage(...),\n'
          ')\n'
          '// No rectangle in debugger\n'
          '// = invisible to screen readers',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Testing Tap Targets',
      'color': Colors.purple,
      'body': 'Verify that tap targets are large enough and properly labeled. '
          'Small semantic rectangles indicate hard-to-reach targets for '
          'users with motor impairments.',
      'code': '// Minimum tap target size:\n'
          'Semantics(\n'
          '  button: true,\n'
          '  label: "Submit",\n'
          '  child: SizedBox(\n'
          '    width: 48, height: 48,\n'
          '    child: icon,\n'
          '  ),\n'
          ')',
    },
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCases) {
    final color = uc['color'] as Color;
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(uc['icon'] as IconData, color: color, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    uc['title'] as String,
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                uc['body'] as String,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                uc['code'] as String,
                style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.bug_report, 'text': 'SemanticsDebugger overlays the semantics tree on your widget UI'},
    {'icon': Icons.accessibility, 'text': 'Shows what assistive technologies see: labels, actions, boundaries'},
    {'icon': Icons.toggle_on, 'text': 'Wrap app in SemanticsDebugger and toggle with a boolean flag'},
    {'icon': Icons.search, 'text': 'Use to find missing labels, wrong merge, and tiny tap targets'},
    {'icon': Icons.touch_app, 'text': 'Taps on overlay translate to semantic actions on nodes'},
    {'icon': Icons.compare, 'text': 'Complements DevTools inspector and platform accessibility tools'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.teal.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SemanticsDebugger'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'How It Works'),
            Tab(text: 'Constructor'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Interpretation'),
            Tab(text: 'Comparison'),
            Tab(text: 'Practical Uses'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('What is SemanticsDebugger?',
                    'A widget that visualizes the semantics tree as a '
                    'colored overlay on your app, showing what screen '
                    'readers and assistive technologies see.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: How It Works
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Under the Hood',
                    'How SemanticsDebugger collects and renders '
                    'the semantic tree information.'),
                const SizedBox(height: 14.0),
                ...howWidgets,
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'The debugger intercepts all pointer events and '
                          'translates them into semantic actions. This means '
                          'tapping on a button in the debugger overlay will '
                          'trigger the semantic tap action, not the gesture '
                          'detector. This lets you test the semantic layer.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Constructor
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Constructor Parameters',
                    'SemanticsDebugger has a minimal API – just a child '
                    'and an optional label style.'),
                const SizedBox(height: 14.0),
                ...ctorCards,
                const SizedBox(height: 14.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Minimal Usage',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                              color: Colors.teal.shade700)),
                      const SizedBox(height: 8.0),
                      Text(
                        'SemanticsDebugger(\n'
                        '  child: MaterialApp(\n'
                        '    home: MyHomePage(),\n'
                        '  ),\n'
                        ')',
                        style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 10.0),
                      Text('Toggle Pattern',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                              color: Colors.teal.shade700)),
                      const SizedBox(height: 8.0),
                      Text(
                        'if (showSemanticsDebugger)\n'
                        '  SemanticsDebugger(\n'
                        '    child: app,\n'
                        '  )\n'
                        'else\n'
                        '  app',
                        style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Interactive SemanticsDebugger',
                    'Toggle the debugger overlay to see the semantics tree '
                    'drawn over the sample widgets.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 5: Interpretation
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Reading the Overlay',
                    'Understanding what each visual element in the '
                    'debugger overlay means.'),
                const SizedBox(height: 14.0),
                ...interpCards,
              ],
            ),
          ),
          // Tab 6: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Accessibility Debug Tools',
                    'Comparison of different tools for debugging '
                    'accessibility in Flutter apps.'),
                const SizedBox(height: 14.0),
                ...compCards,
              ],
            ),
          ),
          // Tab 7: Practical Uses
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('When to Use SemanticsDebugger',
                    'Common debugging scenarios where the visual '
                    'overlay is most helpful.'),
                const SizedBox(height: 14.0),
                ...useCaseCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSDBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withValues(alpha: 0.05),
                        Colors.green.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSDBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.teal.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.teal.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.teal.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Demo with toggle
// ---------------------------------------------------------------------------
class _SDLiveDemo extends StatefulWidget {
  @override
  State<_SDLiveDemo> createState() => _SDLiveDemoState();
}

class _SDLiveDemoState extends State<_SDLiveDemo> {
  bool _showDebugger = false;
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    // Build the sample content
    final sampleContent = Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle button (outside debugger scope)
          Row(
            children: [
              Icon(Icons.bug_report, color: Colors.teal.shade700, size: 20.0),
              const SizedBox(width: 8.0),
              Text('SemanticsDebugger',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                      color: Colors.teal.shade700)),
              const Spacer(),
              Switch(
                value: _showDebugger,
                activeColor: Colors.teal,
                onChanged: (v) => setState(() => _showDebugger = v),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          // The content to debug
          _buildSampleUI(),
        ],
      ),
    );

    if (_showDebugger) {
      return SizedBox(
        height: 440.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SemanticsDebugger(
            child: sampleContent,
          ),
        ),
      );
    }
    return sampleContent;
  }

  Widget _buildSampleUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _showDebugger
                ? Colors.teal.withValues(alpha: 0.08)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _showDebugger
                  ? Colors.teal.withValues(alpha: 0.3)
                  : Colors.grey.shade200,
            ),
          ),
          child: Text(
            _showDebugger
                ? 'Debugger is ON. You should see colored rectangles '
                  'overlaid on each semantic node below.'
                : 'Debugger is OFF. Toggle the switch above to see '
                  'the semantics overlay.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
          ),
        ),
        const SizedBox(height: 14.0),
        // Sample widgets with various semantics
        Semantics(
          label: 'Welcome heading',
          header: true,
          child: Text(
            'Welcome to the App',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,
                color: Colors.grey.shade800),
          ),
        ),
        const SizedBox(height: 10.0),
        Semantics(
          label: 'Description text',
          child: Text(
            'This sample UI demonstrates how SemanticsDebugger shows '
            'the semantic tree overlay.',
            style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600, height: 1.4),
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => setState(() => _tapCount++),
                icon: const Icon(Icons.add, size: 16.0),
                label: Text('Count: $_tapCount'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _tapCount = 0),
                icon: const Icon(Icons.refresh, size: 16.0),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        // Checkbox with semantics
        Row(
          children: [
            Semantics(
              label: 'Accept terms',
              child: Checkbox(
                value: _tapCount.isEven,
                onChanged: (_) {},
                activeColor: Colors.teal,
              ),
            ),
            const SizedBox(width: 6.0),
            const Text('Accept terms and conditions',
                style: TextStyle(fontSize: 13.0)),
          ],
        ),
        const SizedBox(height: 10.0),
        // Slider
        Semantics(
          label: 'Volume slider',
          child: Slider(
            value: (_tapCount % 10) / 10.0,
            onChanged: (_) {},
            activeColor: Colors.teal,
          ),
        ),
        const SizedBox(height: 10.0),
        // Excluded element
        ExcludeSemantics(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'This decorative element is excluded from semantics',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade400,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    );
  }
}
