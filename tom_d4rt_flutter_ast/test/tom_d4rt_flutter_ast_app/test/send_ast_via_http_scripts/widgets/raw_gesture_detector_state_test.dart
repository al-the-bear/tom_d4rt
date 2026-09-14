// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RawGestureDetectorState
// Demonstrates RawGestureDetectorState — the State object that
// manages gesture recognizer lifecycle for RawGestureDetector.
// Covers recognizer creation, sync, disposal, keyboard gestural
// navigation, semantic action mapping, and practical patterns
// for custom gesture handling in Flutter.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawGestureDetectorState Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RawGestureDetectorState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'Gesture Recognizer Manager',
      'body': 'RawGestureDetectorState is the State class for '
          'RawGestureDetector. It manages the lifecycle of gesture '
          'recognizers — creating them from factories, syncing them '
          'on widget updates, and disposing them when the state is '
          'destroyed.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.sync,
      'title': 'Factory-Based Sync',
      'body': 'Gesture recognizers are defined via GestureRecognizerFactory '
          'instances. The state compares old and new factory maps, disposes '
          'removed recognizers, creates new ones, and re-configures existing '
          'ones — all automatically on each widget rebuild.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.accessibility,
      'title': 'Semantics Integration',
      'body': 'The state provides semantic gesture delegates that map '
          'gesture recognizer actions to accessibility actions. Screen '
          'readers can invoke taps, long-presses, and drags through the '
          'semantics tree without physical touch input.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.gamepad,
      'title': 'Dynamic Replacement',
      'body': 'The replaceGestureRecognizers() method allows changing '
          'the gesture map during the layout phase — used by Scrollable '
          'to dynamically enable/disable scroll gestures based on '
          'content size and scroll direction.',
      'accent': Colors.orange[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Lifecycle Overview
  // ============================================================
  print('=== Section 2: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'initState()',
      'detail': 'Initializes the semantics gesture delegate and calls '
          '_syncAll() to create initial gesture recognizers from the '
          'widget\'s gesture factory map.',
      'icon': Icons.play_arrow,
      'color': Colors.deepOrange[700]!,
    },
    {
      'step': 2,
      'title': '_syncAll()',
      'detail': 'Iterates the factory map. For each Type key: if a '
          'recognizer exists, reconfigure it. If new, create one. '
          'Dispose recognizers whose Type is no longer in the map.',
      'icon': Icons.sync,
      'color': Colors.orange[700]!,
    },
    {
      'step': 3,
      'title': 'didUpdateWidget()',
      'detail': 'Called when the parent rebuilds with new properties. '
          'Updates the semantics delegate and calls _syncAll() again '
          'to reconcile the recognizer map with new factories.',
      'icon': Icons.refresh,
      'color': Colors.deepOrange[600]!,
    },
    {
      'step': 4,
      'title': 'replaceGestureRecognizers()',
      'detail': 'Public method for layout-phase replacement. Temporarily '
          'swaps the factory map and re-syncs recognizers. Used by '
          'Scrollable when axis or direction changes.',
      'icon': Icons.swap_horiz,
      'color': Colors.orange[600]!,
    },
    {
      'step': 5,
      'title': 'dispose()',
      'detail': 'Disposes all recognizers unconditionally and clears '
          'the map. After disposal, the state holds no references '
          'to gesture arena participants.',
      'icon': Icons.delete_outline,
      'color': Colors.deepOrange[500]!,
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 3: Key Methods & Properties
  // ============================================================
  print('=== Section 3: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'replaceGestureRecognizers',
      'signature': 'void replaceGestureRecognizers(\n'
          '  Map<Type, GestureRecognizerFactory> gestures\n'
          ')',
      'icon': Icons.swap_horiz,
      'color': Colors.deepOrange[700]!,
      'description': 'Replaces the current gesture recognizer map during '
          'the layout phase. Must be called from within a build or layout '
          'callback. Disposes removed recognizers, creates new ones. '
          'Used by Scrollable to adapt scroll gestures dynamically.',
    },
    {
      'name': 'replaceSemanticsActions',
      'signature': 'void replaceSemanticsActions(\n'
          '  Set<SemanticsAction>? actions\n'
          ')',
      'icon': Icons.accessibility_new,
      'color': Colors.orange[700]!,
      'description': 'Filters which semantic actions the gesture detector '
          'advertises to the accessibility framework. A null set means '
          'all actions. Used by Scrollable to restrict semantic scroll '
          'directions to only the active axis.',
    },
    {
      'name': '_recognizers',
      'signature': 'Map<Type, GestureRecognizer>?',
      'icon': Icons.map,
      'color': Colors.deepOrange[600]!,
      'description': 'Internal map from recognizer Type to recognizer '
          'instance. Null after disposal. Each entry corresponds to a '
          'factory in the widget\'s gestures map. The key type is used '
          'for diffing during _syncAll().',
    },
    {
      'name': '_semantics',
      'signature': 'SemanticsGestureDelegate?',
      'icon': Icons.record_voice_over,
      'color': Colors.orange[600]!,
      'description': 'The delegate that translates recognizer gestures '
          'into semantic actions. Created in initState, updated in '
          'didUpdateWidget. Provides tap, long-press, vertical/horizontal '
          'drag callbacks to the RenderSemanticsGestureHandler.',
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 4: GestureRecognizerFactory Explained
  // ============================================================
  print('=== Section 4: Recognizer Factories ===');

  final factoryExamples = <Map<String, dynamic>>[
    {
      'name': 'TapGestureRecognizer',
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '    TapGestureRecognizer>(\n'
          '  () => TapGestureRecognizer(),\n'
          '  (recognizer) {\n'
          '    recognizer.onTap = handleTap;\n'
          '    recognizer.onTapDown = handleTapDown;\n'
          '  },\n'
          ')',
      'description': 'Single-tap detection. The factory creates a '
          'TapGestureRecognizer and configures its callbacks.',
      'icon': Icons.touch_app,
      'color': Colors.deepOrange[700]!,
    },
    {
      'name': 'LongPressGestureRecognizer',
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '    LongPressGestureRecognizer>(\n'
          '  () => LongPressGestureRecognizer(),\n'
          '  (recognizer) {\n'
          '    recognizer.onLongPress = handleLongPress;\n'
          '  },\n'
          ')',
      'description': 'Long-press detection with configurable duration '
          'threshold and callbacks for start, move, end.',
      'icon': Icons.timer,
      'color': Colors.orange[700]!,
    },
    {
      'name': 'PanGestureRecognizer',
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '    PanGestureRecognizer>(\n'
          '  () => PanGestureRecognizer(),\n'
          '  (recognizer) {\n'
          '    recognizer.onStart = handleDragStart;\n'
          '    recognizer.onUpdate = handleDragUpdate;\n'
          '    recognizer.onEnd = handleDragEnd;\n'
          '  },\n'
          ')',
      'description': 'Pan (2D drag) detection. Reports start, update, '
          'and end callbacks with positional details.',
      'icon': Icons.open_with,
      'color': Colors.deepOrange[600]!,
    },
    {
      'name': 'ScaleGestureRecognizer',
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '    ScaleGestureRecognizer>(\n'
          '  () => ScaleGestureRecognizer(),\n'
          '  (recognizer) {\n'
          '    recognizer.onStart = handleScaleStart;\n'
          '    recognizer.onUpdate = handleScaleUpdate;\n'
          '    recognizer.onEnd = handleScaleEnd;\n'
          '  },\n'
          ')',
      'description': 'Multi-touch scale and rotation detection. Reports '
          'scale factor, focal point, and rotation angle.',
      'icon': Icons.zoom_in,
      'color': Colors.orange[600]!,
    },
  ];

  print('  Factory examples: ${factoryExamples.length}');

  // ============================================================
  // SECTION 5: RawGestureDetector vs GestureDetector
  // ============================================================
  print('=== Section 5: Raw vs High-Level ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'API Level',
      'raw': 'Low-level — factory map',
      'highlevel': 'High-level — callbacks',
    },
    {
      'aspect': 'Gesture Setup',
      'raw': 'Manual factory creation',
      'highlevel': 'Auto-creates from callbacks',
    },
    {
      'aspect': 'Dynamic Gestures',
      'raw': 'replaceGestureRecognizers()',
      'highlevel': 'Rebuild with new callbacks',
    },
    {
      'aspect': 'Semantics Control',
      'raw': 'replaceSemanticsActions()',
      'highlevel': 'Automatic',
    },
    {
      'aspect': 'Use Case',
      'raw': 'Custom scroll, Drag target',
      'highlevel': 'Buttons, cards, list items',
    },
    {
      'aspect': 'State Access',
      'raw': 'Direct via GlobalKey',
      'highlevel': 'Not needed',
    },
  ];

  print('  Comparison rows: ${comparisonRows.length}');

  // ============================================================
  // SECTION 6: Gesture Arena Participation
  // ============================================================
  print('=== Section 6: Gesture Arena ===');

  final arenaCards = <Map<String, dynamic>>[
    {
      'title': 'Pointer Down → Arena Entry',
      'body': 'When a pointer contacts the screen, each recognizer '
          'that covers the hit-test area enters the gesture arena '
          'for that pointer. The are tracks all competitors.',
      'icon': Icons.touch_app,
      'color': Colors.deepOrange[700]!,
    },
    {
      'title': 'Recognition vs Rejection',
      'body': 'As pointer events arrive (move, up), recognizers decide '
          'whether the gesture matches their pattern. A recognizer can '
          'accept (win) or reject (lose). The arena resolves when one '
          'winner remains or the gesture is forced to resolve.',
      'icon': Icons.gavel,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Eager vs Lazy Resolution',
      'body': 'Some recognizers (like TapGestureRecognizer) resolve '
          'eagerly — they accept on pointer up if no competing gesture '
          'won. Others (like LongPressGestureRecognizer) wait for a '
          'duration threshold before accepting.',
      'icon': Icons.timer,
      'color': Colors.deepOrange[600]!,
    },
    {
      'title': 'Winner Takes All',
      'body': 'Once a recognizer wins the arena, all others for that '
          'pointer are rejected and receive no further callbacks. '
          'The winner processes the entire gesture sequence exclusively.',
      'icon': Icons.emoji_events,
      'color': Colors.orange[600]!,
    },
  ];

  print('  Arena cards: ${arenaCards.length}');

  // ============================================================
  // SECTION 7: Practical Patterns
  // ============================================================
  print('=== Section 7: Practical Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Custom Draggable Widget',
      'description': 'Use RawGestureDetector with PanGestureRecognizer '
          'to build a custom draggable that updates position in '
          'onUpdate and snaps back in onEnd. Full control over hit '
          'testing and animation.',
      'icon': Icons.open_with,
      'color': Colors.deepOrange[700]!,
    },
    {
      'title': 'Multi-Recognizer Widget',
      'description': 'Combine tap, long-press, and drag in one factory '
          'map. The arena resolves which gesture wins. Common for '
          'interactive canvas elements that respond to tap for select, '
          'long-press for context menu, and drag for move.',
      'icon': Icons.layers,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Scrollable Integration',
      'description': 'Scrollable uses RawGestureDetector internally. '
          'It calls replaceGestureRecognizers() to switch between '
          'vertical and horizontal drag recognizers based on scroll '
          'axis and content overflow.',
      'icon': Icons.view_list,
      'color': Colors.deepOrange[600]!,
    },
    {
      'title': 'Gesture Exclusion Zones',
      'description': 'Nest RawGestureDetectors with different recognizer '
          'sets to create zones where certain gestures are disabled. '
          'Inner detectors can win the arena over outer ones based on '
          'hit-test order.',
      'icon': Icons.block,
      'color': Colors.orange[600]!,
    },
    {
      'title': 'Accessibility Override',
      'description': 'Use replaceSemanticsActions() to expose only '
          'specific actions to screen readers. For instance, a slider '
          'might expose horizontal drag but suppress tap semantics.',
      'icon': Icons.accessibility,
      'color': Colors.deepOrange[500]!,
    },
  ];

  print('  Patterns: ${patterns.length}');

  // ============================================================
  // SECTION 8: Visual Gesture Demo
  // ============================================================
  print('=== Section 8: Visual Gesture Demo ===');

  // Build a visual representation of different gesture recognizer types
  final gestureTypes = <Map<String, dynamic>>[
    {'name': 'Tap', 'icon': Icons.touch_app, 'color': Colors.deepOrange[700]!, 'desc': 'Single touch down + up'},
    {'name': 'Double Tap', 'icon': Icons.double_arrow, 'color': Colors.orange[700]!, 'desc': 'Two taps in quick succession'},
    {'name': 'Long Press', 'icon': Icons.timer, 'color': Colors.deepOrange[600]!, 'desc': 'Hold without moving'},
    {'name': 'Horizontal Drag', 'icon': Icons.swap_horiz, 'color': Colors.orange[600]!, 'desc': 'Move finger left/right'},
    {'name': 'Vertical Drag', 'icon': Icons.swap_vert, 'color': Colors.deepOrange[500]!, 'desc': 'Move finger up/down'},
    {'name': 'Pan', 'icon': Icons.open_with, 'color': Colors.orange[500]!, 'desc': 'Move in any direction'},
    {'name': 'Scale / Pinch', 'icon': Icons.zoom_in, 'color': Colors.deepOrange[400]!, 'desc': 'Two-finger spread/pinch'},
    {'name': 'Force Press', 'icon': Icons.compress, 'color': Colors.orange[400]!, 'desc': 'Pressure-sensitive press'},
  ];

  print('  Gesture types: ${gestureTypes.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange[800]!, Colors.orange[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.touch_app, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RawGestureDetectorState',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Manages gesture recognizer lifecycle — creation, sync, '
                'disposal, semantic actions, and dynamic replacement for '
                'RawGestureDetector widgets.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.deepOrange[700]!),
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

        // ---- Section 2: Lifecycle ----
        _sectionHeader('2. Lifecycle', Icons.loop, Colors.orange[700]!),
        SizedBox(height: 10),
        ...lifecycleSteps.map((s) => Padding(
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
                        Text(s['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace')),
                        SizedBox(height: 3),
                        Text(s['detail'] as String,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: API ----
        _sectionHeader('3. Key Methods & Properties', Icons.api, Colors.deepOrange[700]!),
        SizedBox(height: 10),
        ...apiEntries.map((a) => Padding(
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
                        Icon(a['icon'] as IconData, color: a['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(a['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: a['color'] as Color)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(a['signature'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                    SizedBox(height: 6),
                    Text(a['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Factory Examples ----
        _sectionHeader('4. GestureRecognizerFactory', Icons.factory, Colors.orange[700]!),
        SizedBox(height: 10),
        ...factoryExamples.map((f) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: (f['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: f['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(f['icon'] as IconData, color: f['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Text(f['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: f['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(f['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(f['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Comparison Table ----
        _sectionHeader('5. Raw vs. GestureDetector', Icons.compare, Colors.deepOrange[700]!),
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
                color: Colors.deepOrange[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Aspect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('RawGestureDetector', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('GestureDetector', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(comparisonRows.length, (i) {
                final row = comparisonRows[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.grey[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(row['aspect'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                      Expanded(flex: 3, child: Text(row['raw'] as String, style: TextStyle(fontSize: 12))),
                      Expanded(flex: 3, child: Text(row['highlevel'] as String, style: TextStyle(fontSize: 12))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Gesture Arena ----
        _sectionHeader('6. Gesture Arena', Icons.sports_mma, Colors.orange[700]!),
        SizedBox(height: 10),
        ...arenaCards.map((a) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (a['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: a['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(a['icon'] as IconData, color: a['color'] as Color, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: a['color'] as Color)),
                          SizedBox(height: 4),
                          Text(a['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Practical Patterns ----
        _sectionHeader('7. Practical Patterns', Icons.lightbulb, Colors.deepOrange[700]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                          SizedBox(height: 4),
                          Text(p['description'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Gesture Types Grid ----
        _sectionHeader('8. Gesture Recognizer Types', Icons.grid_view, Colors.orange[700]!),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: gestureTypes.map((g) => Container(
                width: 160,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (g['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (g['color'] as Color).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(g['icon'] as IconData, color: g['color'] as Color, size: 20),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(g['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: g['color'] as Color)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(g['desc'] as String, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                  ],
                ),
              )).toList(),
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
              Icon(Icons.touch_app, color: Colors.deepOrange[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RawGestureDetectorState: the engine behind every gesture '
                'interaction — factory-based recognizer management, arena '
                'participation, semantic actions, and dynamic replacement.',
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
