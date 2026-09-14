// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — GestureRecognizerFactoryWithHandlers
// Demonstrates GestureRecognizerFactoryWithHandlers — a generic factory
// that creates gesture recognizer instances and configures their handler
// callbacks. Used with RawGestureDetector to configure recognizers inline.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizerFactoryWithHandlers Deep Demo executing');

  // ============================================================
  // SECTION 1: What is GestureRecognizerFactoryWithHandlers?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'Factory for Gesture Recognizers',
      'body': 'GestureRecognizerFactoryWithHandlers<T> is a generic '
          'implementation of GestureRecognizerFactory that takes two '
          'callbacks: a constructor callback that creates a new '
          'recognizer of type T, and an initializer callback that '
          'configures the recognizer\'s event handlers.',
      'accent': Colors.purple[700]!,
    },
    {
      'icon': Icons.settings,
      'title': 'Two Callback Pattern',
      'body': 'The factory separates creation from configuration. '
          'The first callback (constructor) is called only when a '
          'new recognizer is needed. The second callback (initializer) '
          'is called every time the widget rebuilds to update handlers. '
          'This matches the GestureRecognizer lifecycle perfectly.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Used by RawGestureDetector',
      'body': 'RawGestureDetector\'s gestures parameter takes a '
          'Map<Type, GestureRecognizerFactory>. '
          'GestureRecognizerFactoryWithHandlers is the standard way '
          'to populate that map inline, giving you strongly-typed '
          'access to configure each recognizer.',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.code,
      'title': 'GestureDetector Uses It Internally',
      'body': 'The familiar GestureDetector widget builds a '
          'RawGestureDetector internally and creates '
          'GestureRecognizerFactoryWithHandlers for each gesture. '
          'Understanding this factory means understanding how all '
          'gesture handling actually works under the hood.',
      'accent': Colors.indigo[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Constructor Anatomy
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParts = <Map<String, dynamic>>[
    {
      'part': 'Generic Type Parameter',
      'code': 'GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>',
      'detail': 'The type T must extend GestureRecognizer. This is '
          'the type of recognizer that the factory creates and '
          'configures. Examples: TapGestureRecognizer, '
          'LongPressGestureRecognizer, PanGestureRecognizer, etc.',
      'icon': Icons.data_object,
      'color': Colors.purple[700]!,
    },
    {
      'part': 'Constructor Callback',
      'code': '() => TapGestureRecognizer()',
      'detail': 'First argument — GestureRecognizerFactoryConstructor. '
          'Returns a new instance of T. Called by RawGestureDetector '
          'when it needs a new recognizer (first build or when '
          'recognizer type changes). Keep it simple: just construct.',
      'icon': Icons.add_circle_outline,
      'color': Colors.indigo[700]!,
    },
    {
      'part': 'Initializer Callback',
      'code': '(TapGestureRecognizer instance) {\n'
          '  instance.onTap = () => print(\'tapped\');\n'
          '  instance.onTapDown = (d) => print(\'down \$d\');\n'
          '}',
      'detail': 'Second argument — GestureRecognizerFactoryInitializer. '
          'Receives the recognizer instance and sets handler callbacks. '
          'Called every rebuild. This is where you assign onTap, '
          'onPanUpdate, onLongPress, etc.',
      'icon': Icons.tune,
      'color': Colors.purple[600]!,
    },
  ];

  print('  Prepared ${constructorParts.length} constructor parts');

  // ============================================================
  // SECTION 3: Lifecycle Flow
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'RawGestureDetector builds',
      'icon': Icons.play_arrow,
      'color': Colors.purple[700]!,
      'detail': 'RawGestureDetector reads its gestures map. For each '
          'entry it finds a GestureRecognizerFactory (your factory). '
          'The key is the recognizer Type.',
    },
    {
      'step': 2,
      'label': 'Constructor callback invoked',
      'icon': Icons.add_box,
      'color': Colors.indigo[700]!,
      'detail': 'If no recognizer of this type exists yet, '
          'RawGestureDetector calls factory.constructor() to create '
          'one. This calls your first callback: () => T().',
    },
    {
      'step': 3,
      'label': 'Initializer callback invoked',
      'icon': Icons.settings,
      'color': Colors.purple[600]!,
      'detail': 'RawGestureDetector calls factory.initializer(instance) '
          'passing the recognizer. Your second callback runs, setting '
          'onTap, onPanUpdate, etc. Called every rebuild.',
    },
    {
      'step': 4,
      'label': 'Recognizer registered',
      'icon': Icons.check_circle,
      'color': Colors.indigo[600]!,
      'detail': 'The recognizer is registered with the gesture arena '
          'for this widget. Pointer events are routed to it. The '
          'recognizer competes with other recognizers in the arena.',
    },
    {
      'step': 5,
      'label': 'On rebuild: reinitialize',
      'icon': Icons.refresh,
      'color': Colors.purple[800]!,
      'detail': 'On subsequent rebuilds, the constructor is NOT called '
          'again (recognizer is reused). Only the initializer runs '
          'again to update handler callbacks with the latest closures.',
    },
    {
      'step': 6,
      'label': 'On dispose: recognizer disposed',
      'icon': Icons.delete_outline,
      'color': Colors.indigo[800]!,
      'detail': 'When RawGestureDetector is removed from the tree, '
          'it disposes all recognizers. You don\'t need to manually '
          'dispose them when using the factory pattern.',
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 4: Recognizer Types Table
  // ============================================================
  print('=== Section 4: Recognizer Types ===');

  final recognizerTypes = <Map<String, dynamic>>[
    {
      'type': 'TapGestureRecognizer',
      'handlers': 'onTap, onTapDown, onTapUp, onTapCancel, '
          'onSecondaryTap, onSecondaryTapDown',
      'icon': Icons.touch_app,
      'color': Colors.purple[700]!,
      'use': 'Single taps and secondary taps',
    },
    {
      'type': 'DoubleTapGestureRecognizer',
      'handlers': 'onDoubleTap, onDoubleTapDown, onDoubleTapCancel',
      'icon': Icons.double_arrow,
      'color': Colors.indigo[700]!,
      'use': 'Double-tap gestures',
    },
    {
      'type': 'LongPressGestureRecognizer',
      'handlers': 'onLongPress, onLongPressStart, onLongPressMoveUpdate, '
          'onLongPressEnd, onLongPressUp',
      'icon': Icons.timer,
      'color': Colors.purple[600]!,
      'use': 'Press-and-hold with optional movement',
    },
    {
      'type': 'PanGestureRecognizer',
      'handlers': 'onDown, onStart, onUpdate, onEnd, onCancel',
      'icon': Icons.open_with,
      'color': Colors.indigo[600]!,
      'use': 'Free-form dragging in any direction',
    },
    {
      'type': 'ScaleGestureRecognizer',
      'handlers': 'onStart, onUpdate, onEnd',
      'icon': Icons.zoom_out_map,
      'color': Colors.purple[800]!,
      'use': 'Pinch-to-zoom and rotation',
    },
    {
      'type': 'HorizontalDragGestureRecognizer',
      'handlers': 'onDown, onStart, onUpdate, onEnd, onCancel',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo[800]!,
      'use': 'Horizontal-only dragging',
    },
    {
      'type': 'VerticalDragGestureRecognizer',
      'handlers': 'onDown, onStart, onUpdate, onEnd, onCancel',
      'icon': Icons.swap_vert,
      'color': Colors.purple[500]!,
      'use': 'Vertical-only dragging',
    },
    {
      'type': 'ForcePressGestureRecognizer',
      'handlers': 'onStart, onPeak, onUpdate, onEnd',
      'icon': Icons.compress,
      'color': Colors.indigo[500]!,
      'use': 'Force/pressure-sensitive presses (3D Touch)',
    },
  ];

  print('  Prepared ${recognizerTypes.length} recognizer types');

  // ============================================================
  // SECTION 5: GestureDetector vs RawGestureDetector
  // ============================================================
  print('=== Section 5: GestureDetector vs Raw ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'API Style',
      'gestureD': 'Named parameters: onTap, onPan, etc.',
      'rawD': 'Map<Type, GestureRecognizerFactory>',
    },
    {
      'aspect': 'Factory Visibility',
      'gestureD': 'Factories created internally, hidden',
      'rawD': 'You create factories explicitly',
    },
    {
      'aspect': 'Custom Recognizers',
      'gestureD': 'Cannot use custom recognizer types',
      'rawD': 'Any GestureRecognizer subclass',
    },
    {
      'aspect': 'Recognizer Config',
      'gestureD': 'Limited to provided parameters',
      'rawD': 'Full access to all recognizer properties',
    },
    {
      'aspect': 'Ease of Use',
      'gestureD': 'Simple — just declare handlers',
      'rawD': 'More code, but more flexible',
    },
    {
      'aspect': 'When to Use',
      'gestureD': 'Standard tap/pan/scale/longpress',
      'rawD': 'Custom recognizers, advanced config',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 6: Common Patterns
  // ============================================================
  print('=== Section 6: Common Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Simple Tap Factory',
      'icon': Icons.touch_app,
      'color': Colors.purple[700]!,
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '  TapGestureRecognizer\n'
          '>(\n'
          '  () => TapGestureRecognizer(),\n'
          '  (instance) {\n'
          '    instance.onTap = handleTap;\n'
          '    instance.onTapDown = handleDown;\n'
          '  },\n'
          ')',
      'note': 'Basic pattern — most common usage',
    },
    {
      'title': 'Pan with dragStartBehavior',
      'icon': Icons.open_with,
      'color': Colors.indigo[700]!,
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '  PanGestureRecognizer\n'
          '>(\n'
          '  () => PanGestureRecognizer()\n'
          '    ..dragStartBehavior = DragStartBehavior.down,\n'
          '  (instance) {\n'
          '    instance.onUpdate = (details) {\n'
          '      setState(() => _offset += details.delta);\n'
          '    };\n'
          '  },\n'
          ')',
      'note': 'Configure recognizer properties in constructor',
    },
    {
      'title': 'Multiple Recognizers in One Map',
      'icon': Icons.layers,
      'color': Colors.purple[600]!,
      'code': 'gestures: <Type, GestureRecognizerFactory>{\n'
          '  TapGestureRecognizer:\n'
          '    GestureRecognizerFactoryWithHandlers<\n'
          '      TapGestureRecognizer\n'
          '    >(() => TapGestureRecognizer(),\n'
          '      (i) { i.onTap = onTap; }),\n'
          '  LongPressGestureRecognizer:\n'
          '    GestureRecognizerFactoryWithHandlers<\n'
          '      LongPressGestureRecognizer\n'
          '    >(() => LongPressGestureRecognizer(),\n'
          '      (i) { i.onLongPress = onLongPress; }),\n'
          '}',
      'note': 'Each recognizer type gets its own factory entry',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Arena & Competition
  // ============================================================
  print('=== Section 7: Gesture Arena ===');

  final arenaCards = <Map<String, dynamic>>[
    {
      'icon': Icons.sports_martial_arts,
      'title': 'Gesture Arena Basics',
      'body': 'When a pointer event arrives, all registered recognizers '
          'enter a "gesture arena." Each recognizer claims the gesture '
          'as soon as it\'s confident. The arena picks a winner and '
          'rejects all others. This prevents conflicting gestures.',
      'color': Colors.purple[700]!,
    },
    {
      'icon': Icons.group_work,
      'title': 'Multiple Factories = Multiple Competitors',
      'body': 'When you register multiple factories in the gestures '
          'map, each recognizer competes in the arena. A tap recognizer '
          'might lose to a long-press recognizer if the user holds. '
          'This is the disambiguation mechanism.',
      'color': Colors.indigo[700]!,
    },
    {
      'icon': Icons.rule,
      'title': 'Eagerness & Deadlines',
      'body': 'Some recognizers are eager (accept immediately after '
          'a brief timeout), others wait for movement. '
          'TapGestureRecognizer waits to see if a double-tap follows. '
          'Understanding eagerness helps when configuring recognizers '
          'via the factory pattern.',
      'color': Colors.purple[600]!,
    },
    {
      'icon': Icons.link,
      'title': 'Factory Lifecycle & Arena',
      'body': 'The factory pattern ensures recognizers persist across '
          'rebuilds. Only the initializer re-runs. The recognizer '
          'keeps its arena state. This is critical for drag gestures '
          'that span multiple frames — the recognizer must survive '
          'rebuilds mid-drag.',
      'color': Colors.indigo[600]!,
    },
  ];

  print('  Prepared ${arenaCards.length} arena cards');

  // ============================================================
  // SECTION 8: Real-World Scenarios
  // ============================================================
  print('=== Section 8: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Drawing Canvas',
      'icon': Icons.brush,
      'color': Colors.purple[700]!,
      'description': 'A RawGestureDetector with PanGestureRecognizer '
          'factory. The initializer captures the drawing state in its '
          'closure, so each rebuild gets the latest canvas reference. '
          'dragStartBehavior is set to DragStartBehavior.down for '
          'immediate drawing response.',
    },
    {
      'name': 'Interactive Map',
      'icon': Icons.map,
      'color': Colors.indigo[700]!,
      'description': 'Multiple factories: ScaleGestureRecognizer for '
          'pinch-zoom, PanGestureRecognizer for panning, '
          'TapGestureRecognizer for placing markers. The gesture '
          'arena disambiguates between pan and scale.',
    },
    {
      'name': 'Custom Swipe Detection',
      'icon': Icons.swipe,
      'color': Colors.purple[600]!,
      'description': 'A custom SwipeGestureRecognizer that only accepts '
          'fast, short horizontal movements. Cannot be built with '
          'GestureDetector — requires RawGestureDetector with a '
          'factory for the custom recognizer.',
    },
    {
      'name': 'Game Input Handler',
      'icon': Icons.sports_esports,
      'color': Colors.indigo[600]!,
      'description': 'Multiple overlapping recognizers for a game: '
          'tap for shooting, long-press for charging, pan for aiming. '
          'The factory pattern ensures each recognizer is properly '
          'configured and the arena resolves conflicts.',
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 9: Tips & Best Practices
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Prefer GestureDetector for Standard Gestures',
      'body': 'Only use GestureRecognizerFactoryWithHandlers when '
          'GestureDetector doesn\'t provide enough control. For simple '
          'tap/pan/longpress, the higher-level widget is cleaner.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Constructor Must Be Cheap',
      'body': 'The constructor callback creates a GestureRecognizer. '
          'Don\'t do heavy work here. The recognizer may be recreated '
          'if the gestures map changes. Keep it to a single line: '
          '() => MyRecognizer().',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Initializer for All Handler Setup',
      'body': 'Set ALL event handlers in the initializer, not the '
          'constructor. The initializer runs on every rebuild, '
          'ensuring closures capture the latest state. Handlers set '
          'in the constructor might reference stale state.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Map Key Must Match Recognizer Type',
      'body': 'In the gestures map, the key (Type) must match the '
          'generic type T of GestureRecognizerFactoryWithHandlers<T>. '
          'A mismatch causes runtime errors. Always use: '
          'TapGestureRecognizer: factory<TapGestureRecognizer>.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Configure Recognizer Properties in Constructor',
      'body': 'Properties that don\'t change (like dragStartBehavior, '
          'supportedDevices) are best set in the constructor callback '
          'using cascade notation: () => PanGestureRecognizer() '
          '..dragStartBehavior = DragStartBehavior.down.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Dispose Is Automatic',
      'body': 'RawGestureDetector automatically disposes all '
          'recognizers when removed from the tree. You never need to '
          'manually dispose recognizers created via the factory. '
          'This is one of the key advantages of the factory pattern.',
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
      title: Text('GestureRecognizerFactoryWithHandlers'),
      backgroundColor: Colors.purple[700],
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
                colors: [Colors.purple[700]!, Colors.indigo[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.touch_app, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'GestureRecognizerFactory\nWithHandlers<T>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A generic factory that creates gesture recognizers '
                  'and configures their handler callbacks. The standard '
                  'way to populate RawGestureDetector\'s gestures map '
                  'for full control over gesture recognition.',
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
          _grfHead('1', 'What is It?'),
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

          // ── Section 2: Constructor Anatomy ──
          _grfHead('2', 'Constructor Anatomy'),
          SizedBox(height: 12),
          ...constructorParts.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
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
                      Row(children: [
                        Icon(cp['icon'] as IconData,
                            color: cp['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cp['part'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: Colors.purple[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(cp['detail'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Lifecycle ──
          _grfHead('3', 'Lifecycle Flow'),
          SizedBox(height: 12),
          ...lifecycleSteps.map((ls) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ls['color'] as Color, width: 4),
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(ls['icon'] as IconData,
                                  size: 14,
                                  color: ls['color'] as Color),
                              SizedBox(width: 4),
                              Text(ls['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ]),
                            SizedBox(height: 3),
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

          // ── Section 4: Recognizer Types ──
          _grfHead('4', 'Recognizer Types Reference'),
          SizedBox(height: 12),
          ...recognizerTypes.map((rt) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: rt['color'] as Color, width: 4),
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
                        Icon(rt['icon'] as IconData,
                            color: rt['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(rt['type'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: rt['color'] as Color)),
                        ),
                        _grfTag(
                            rt['use'] as String, rt['color'] as Color),
                      ]),
                      SizedBox(height: 4),
                      Text(rt['handlers'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Comparison ──
          _grfHead('5', 'GestureDetector vs Raw'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
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
              // Header row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 70,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('GestureDetector',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('RawGestureDetector',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['gestureD'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['rawD'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.purple[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _grfHead('6', 'Common Code Patterns'),
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
                      Row(children: [
                        Icon(cp['icon'] as IconData,
                            color: cp['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cp['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.purple[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(cp['note'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Arena ──
          _grfHead('7', 'Gesture Arena & Competition'),
          SizedBox(height: 12),
          ...arenaCards.map((ac) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ac['color'] as Color, width: 4),
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
                        Icon(ac['icon'] as IconData,
                            color: ac['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ac['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(ac['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Scenarios ──
          _grfHead('8', 'Real-World Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((sc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: sc['color'] as Color, width: 4),
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
                        Icon(sc['icon'] as IconData,
                            color: sc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(sc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(sc['description'] as String,
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
          _grfHead('9', 'Tips & Best Practices'),
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
              'End of GestureRecognizerFactoryWithHandlers Deep Demo',
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
Widget _grfHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.purple[700],
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
// Helper: Tag badge
// ──────────────────────────────────────────────────────────
Widget _grfTag(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 90),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis),
  );
}
