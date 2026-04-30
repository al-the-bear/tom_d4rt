// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — GestureRecognizerFactory
// Demonstrates GestureRecognizerFactory and
// GestureRecognizerFactoryWithHandlers — the factory pattern
// underlying Flutter's gesture detection. Shows how recognizers
// are created, configured, and used by GestureDetector and
// RawGestureDetector.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizerFactory Deep Demo executing');

  // ============================================================
  // SECTION 1: What is GestureRecognizerFactory?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.factory,
      'title': 'Factory for Gesture Recognizers',
      'body': 'GestureRecognizerFactory is an abstract class that '
          'defines how to create and configure a GestureRecognizer. '
          'It separates construction (creating a new instance) from '
          'initialization (setting callbacks like onTap, onPan). '
          'This allows Flutter to reuse recognizers across rebuilds.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.build,
      'title': 'GestureRecognizerFactoryWithHandlers',
      'body': 'The concrete implementation you actually use. Takes '
          'two callbacks: a constructor function (() => TapGestureRecognizer()) '
          'and an initializer function ((recognizer) { recognizer.onTap = ... }). '
          'This is what GestureDetector creates under the hood.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Behind GestureDetector',
      'body': 'When you use GestureDetector(onTap: ..., onLongPress: ...), '
          'it internally creates GestureRecognizerFactoryWithHandlers '
          'for each gesture type. The factory pattern enables efficient '
          'recognizer lifecycle management by the framework.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.recycling,
      'title': 'Recognizer Reuse',
      'body': 'Flutter doesn\'t recreate gesture recognizers every '
          'build. The factory\'s constructor is called once; the '
          'initializer is called on every rebuild to update callbacks. '
          'This preserves gesture state (like an in-progress drag) '
          'across widget rebuilds.',
      'accent': Colors.cyan[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Factory Anatomy
  // ============================================================
  print('=== Section 2: Factory Anatomy ===');

  final anatomyItems = <Map<String, dynamic>>[
    {
      'part': 'GestureRecognizerFactory<T>',
      'role': 'Abstract base class',
      'icon': Icons.architecture,
      'color': Colors.teal[700]!,
      'description': 'Generic abstract class where T extends '
          'GestureRecognizer. Defines two abstract methods: '
          'constructor() returns a new T, and initializer(T) '
          'configures an existing T. You rarely implement this '
          'directly.',
    },
    {
      'part': 'constructor()',
      'role': 'Creates recognizer',
      'icon': Icons.add_circle,
      'color': Colors.cyan[700]!,
      'description': 'Called ONCE to create the GestureRecognizer '
          'instance. Must return a new T. Example: '
          '() => TapGestureRecognizer(). The framework caches '
          'the result and reuses it.',
    },
    {
      'part': 'initializer(T instance)',
      'role': 'Configures callbacks',
      'icon': Icons.settings,
      'color': Colors.teal[600]!,
      'description': 'Called on EVERY rebuild to update the recognizer\'s '
          'callbacks. Example: (r) { r.onTap = handleTap; '
          'r.onTapDown = handleTapDown; }. This is where you '
          'wire up your gesture handlers.',
    },
    {
      'part': 'GestureRecognizerFactoryWithHandlers<T>',
      'role': 'Concrete helper',
      'icon': Icons.handyman,
      'color': Colors.cyan[600]!,
      'description': 'Convenience class that takes the constructor and '
          'initializer as callback parameters. This is what you\'ll '
          'use 99% of the time instead of subclassing the abstract '
          'factory.',
    },
  ];

  print('  Prepared ${anatomyItems.length} anatomy items');

  // ============================================================
  // SECTION 3: Common Recognizer Types
  // ============================================================
  print('=== Section 3: Recognizer Types ===');

  final recognizerTypes = <Map<String, dynamic>>[
    {
      'name': 'TapGestureRecognizer',
      'icon': Icons.touch_app,
      'color': Colors.teal[700]!,
      'bgColor': Colors.teal[50]!,
      'callbacks': 'onTap, onTapDown, onTapUp, onTapCancel, '
          'onSecondaryTap, onSecondaryTapDown',
      'description': 'Detects discrete taps. The most common '
          'recognizer — every button uses it. Fires after the '
          'user touches and releases within a timeout and without '
          'exceeding a movement threshold.',
    },
    {
      'name': 'DoubleTapGestureRecognizer',
      'icon': Icons.touch_app,
      'color': Colors.cyan[700]!,
      'bgColor': Colors.cyan[50]!,
      'callbacks': 'onDoubleTap, onDoubleTapDown, onDoubleTapCancel',
      'description': 'Detects two taps in quick succession. Used for '
          'text selection (double-tap to select a word) and zoom '
          '(double-tap on maps/images).',
    },
    {
      'name': 'LongPressGestureRecognizer',
      'icon': Icons.pan_tool,
      'color': Colors.teal[600]!,
      'bgColor': Colors.teal[50]!,
      'callbacks': 'onLongPress, onLongPressStart, onLongPressMoveUpdate, '
          'onLongPressEnd, onLongPressUp',
      'description': 'Fires when the user holds down for 500ms (by '
          'default). Supports drag while long-pressing. Used for '
          'context menus, reordering, and selection.',
    },
    {
      'name': 'PanGestureRecognizer',
      'icon': Icons.open_with,
      'color': Colors.cyan[600]!,
      'bgColor': Colors.cyan[50]!,
      'callbacks': 'onPanStart, onPanUpdate, onPanEnd, onPanDown, '
          'onPanCancel',
      'description': 'Detects dragging in any direction. Reports delta '
          'offset on each frame. Used for moving objects, drawing, '
          'and custom scrolling.',
    },
    {
      'name': 'ScaleGestureRecognizer',
      'icon': Icons.zoom_in,
      'color': Colors.teal[500]!,
      'bgColor': Colors.teal[50]!,
      'callbacks': 'onScaleStart, onScaleUpdate, onScaleEnd',
      'description': 'Handles pinch-to-zoom and rotation with one or '
          'two fingers. Reports scale factor and rotation angle. '
          'Subsumes PanGestureRecognizer (handles both pan and scale).',
    },
    {
      'name': 'HorizontalDragGestureRecognizer',
      'icon': Icons.swap_horiz,
      'color': Colors.cyan[500]!,
      'bgColor': Colors.cyan[50]!,
      'callbacks': 'onHorizontalDragStart, onHorizontalDragUpdate, '
          'onHorizontalDragEnd, onHorizontalDragDown',
      'description': 'Detects horizontal-only drags. Wins the gesture '
          'arena when the user moves primarily horizontally. Used '
          'for sliders, dismissible cards, and horizontal lists.',
    },
    {
      'name': 'VerticalDragGestureRecognizer',
      'icon': Icons.swap_vert,
      'color': Colors.teal[400]!,
      'bgColor': Colors.teal[50]!,
      'callbacks': 'onVerticalDragStart, onVerticalDragUpdate, '
          'onVerticalDragEnd, onVerticalDragDown',
      'description': 'Detects vertical-only drags. Wins when movement '
          'is primarily vertical. Used by ScrollView, pull-to-refresh, '
          'and vertical carousels.',
    },
    {
      'name': 'ForcePressGestureRecognizer',
      'icon': Icons.fitness_center,
      'color': Colors.cyan[400]!,
      'bgColor': Colors.cyan[50]!,
      'callbacks': 'onForcePress, onForcePressStart, '
          'onForcePressPeak, onForcePressUpdate, onForcePressEnd',
      'description': 'Detects force/3D Touch press levels on '
          'supported devices. Reports pressure as a 0.0-1.0 value. '
          'Used for peek-and-pop interactions on iOS.',
    },
  ];

  print('  Prepared ${recognizerTypes.length} recognizer types');

  // ============================================================
  // SECTION 4: How GestureDetector Uses Factories
  // ============================================================
  print('=== Section 4: GestureDetector Internals ===');

  final internalSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'User writes GestureDetector',
      'icon': Icons.code,
      'color': Colors.teal[700]!,
      'description': 'Developer creates GestureDetector(onTap: myFunc, '
          'onLongPress: myOtherFunc, child: ...). This is the '
          'high-level API most developers use.',
    },
    {
      'step': '2',
      'title': 'GestureDetector creates factories',
      'icon': Icons.factory,
      'color': Colors.cyan[700]!,
      'description': 'Internally, GestureDetector maps each non-null '
          'callback to a factory. onTap → TapGestureRecognizer factory. '
          'onLongPress → LongPressGestureRecognizer factory. Each '
          'factory is a GestureRecognizerFactoryWithHandlers instance.',
    },
    {
      'step': '3',
      'title': 'Factories passed to RawGestureDetector',
      'icon': Icons.widgets,
      'color': Colors.teal[600]!,
      'description': 'GestureDetector returns a RawGestureDetector with '
          'a Map<Type, GestureRecognizerFactory> of all factories. '
          'RawGestureDetector is the actual widget that manages '
          'recognizer lifecycle.',
    },
    {
      'step': '4',
      'title': 'RawGestureDetectorState creates recognizers',
      'icon': Icons.play_circle,
      'color': Colors.cyan[600]!,
      'description': 'On first build, initState() calls each factory\'s '
          'constructor() to create recognizers. On subsequent builds, '
          'didUpdateWidget() calls initializer() to update callbacks. '
          'Recognizers survive rebuilds.',
    },
    {
      'step': '5',
      'title': 'Recognizers compete in gesture arena',
      'icon': Icons.sports_mma,
      'color': Colors.teal[500]!,
      'description': 'When the user touches the screen, pointer events '
          'are routed to all recognizers. They compete in the gesture '
          'arena. The winner fires its callbacks. Losers are cancelled.',
    },
    {
      'step': '6',
      'title': 'Dispose on unmount',
      'icon': Icons.delete,
      'color': Colors.cyan[500]!,
      'description': 'When the widget is removed, dispose() is called '
          'on all recognizers. This clears timers, listeners, and '
          'pending gesture state.',
    },
  ];

  print('  Prepared ${internalSteps.length} internal steps');

  // ============================================================
  // SECTION 5: RawGestureDetector Usage
  // ============================================================
  print('=== Section 5: RawGestureDetector ===');

  final rawUsages = <Map<String, dynamic>>[
    {
      'name': 'Custom Gesture Combination',
      'icon': Icons.tune,
      'color': Colors.teal[600]!,
      'code': 'RawGestureDetector(\n'
          '  gestures: {\n'
          '    TapGestureRecognizer:\n'
          '      GestureRecognizerFactoryWithHandlers<\n'
          '          TapGestureRecognizer>(\n'
          '        () => TapGestureRecognizer(),\n'
          '        (instance) {\n'
          '          instance.onTap = handleTap;\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: myWidget,\n'
          ')',
      'description': 'Direct control over which recognizers are '
          'created. This is more verbose than GestureDetector but '
          'gives you full control over recognizer configuration.',
    },
    {
      'name': 'Configuring Recognizer Properties',
      'icon': Icons.settings_applications,
      'color': Colors.cyan[600]!,
      'code': 'GestureRecognizerFactoryWithHandlers<\n'
          '    LongPressGestureRecognizer>(\n'
          '  () => LongPressGestureRecognizer(\n'
          '    duration: Duration(milliseconds: 200),\n'
          '  ),\n'
          '  (instance) {\n'
          '    instance.onLongPress = handleLongPress;\n'
          '    instance.onLongPressUp = handleLongPressUp;\n'
          '  },\n'
          ')',
      'description': 'The constructor callback can pass parameters '
          'to the recognizer constructor. Here we reduce the '
          'long-press duration from the default 500ms to 200ms.',
    },
    {
      'name': 'Multiple Custom Recognizers',
      'icon': Icons.layers,
      'color': Colors.teal[500]!,
      'code': 'RawGestureDetector(\n'
          '  gestures: {\n'
          '    TapGestureRecognizer: tapFactory,\n'
          '    PanGestureRecognizer: panFactory,\n'
          '    ScaleGestureRecognizer: scaleFactory,\n'
          '  },\n'
          '  child: myCanvas,\n'
          ')',
      'description': 'Combine multiple recognizer factories in one '
          'detector. The gesture arena resolves conflicts. Note: '
          'PanGestureRecognizer and ScaleGestureRecognizer conflict '
          '— use only ScaleGestureRecognizer (it handles pan too).',
    },
  ];

  print('  Prepared ${rawUsages.length} raw usage examples');

  // ============================================================
  // SECTION 6: GestureDetector vs RawGestureDetector
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'API Level',
      'detector': 'High-level convenience widget',
      'raw': 'Low-level — you provide factories',
    },
    {
      'aspect': 'Recognizer Config',
      'detector': 'Limited to constructor params',
      'raw': 'Full control via factory callback',
    },
    {
      'aspect': 'Custom Recognizers',
      'detector': 'Not possible — built-in set only',
      'raw': 'Any GestureRecognizer subclass',
    },
    {
      'aspect': 'Recognizer Duration',
      'detector': 'Default durations only',
      'raw': 'Configurable in constructor()',
    },
    {
      'aspect': 'Code Verbosity',
      'detector': 'Minimal — just set callbacks',
      'raw': 'Verbose — factory + callbacks',
    },
    {
      'aspect': 'When to Use',
      'detector': 'Standard gesture detection (99%)',
      'raw': 'Custom recognizers or advanced config',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 7: Gesture Arena Explained
  // ============================================================
  print('=== Section 7: Gesture Arena ===');

  final arenaPhases = <Map<String, dynamic>>[
    {
      'phase': 'Pointer Down',
      'icon': Icons.touch_app,
      'color': Colors.teal[700]!,
      'description': 'User touches the screen. A GestureArenaEntry '
          'is created for each recognizer that registered for this '
          'pointer. All competitors start in the "possible" state.',
    },
    {
      'phase': 'Pointer Move',
      'icon': Icons.swipe,
      'color': Colors.cyan[700]!,
      'description': 'As the pointer moves, each recognizer analyzes '
          'the movement. If a recognizer determines it cannot be the '
          'winning gesture (e.g., too much vertical movement for a '
          'horizontal drag), it rejects itself from the arena.',
    },
    {
      'phase': 'Resolution',
      'icon': Icons.emoji_events,
      'color': Colors.teal[600]!,
      'description': 'When only one recognizer remains (all others '
          'rejected), it wins by default. Or a recognizer can '
          'declare victory (e.g., long press timer fires). The '
          'winner\'s callbacks are called.',
    },
    {
      'phase': 'Sweep (Pointer Up)',
      'icon': Icons.cleaning_services,
      'color': Colors.cyan[600]!,
      'description': 'If the pointer is released before resolution, '
          'the arena is swept: the first remaining competitor wins. '
          'This is how TapGestureRecognizer wins — it\'s typically '
          'first and survives until pointer up.',
    },
    {
      'phase': 'Cancellation',
      'icon': Icons.cancel,
      'color': Colors.teal[500]!,
      'description': 'Losing recognizers receive a cancel callback '
          '(onTapCancel, onPanCancel). They reset their internal '
          'state and prepare for the next gesture.',
    },
  ];

  print('  Prepared ${arenaPhases.length} arena phases');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Custom Ink Splash Timing',
      'icon': Icons.water_drop,
      'color': Colors.teal[600]!,
      'body': 'Use RawGestureDetector with a TapGestureRecognizer '
          'that has a custom timeout. For buttons that should respond '
          'faster (kiosk apps), reduce the tap timeout. For buttons '
          'that must ignore accidental taps, increase it.',
    },
    {
      'title': 'Drawing Canvas',
      'icon': Icons.draw,
      'color': Colors.cyan[600]!,
      'body': 'A drawing app uses a PanGestureRecognizer factory '
          'with custom properties: a very low slop (movement '
          'threshold) for precision, immediate start without '
          'waiting for the arena to resolve. The factory '
          'configures these in the constructor callback.',
    },
    {
      'title': 'Game Input Handler',
      'icon': Icons.gamepad,
      'color': Colors.teal[500]!,
      'body': 'Game controls may need multiple simultaneous '
          'recognizers on the same widget. Use RawGestureDetector '
          'with allowedButtonsFilter to distinguish between primary '
          'and secondary touch points.',
    },
    {
      'title': 'Accessibility Gesture Override',
      'icon': Icons.accessibility,
      'color': Colors.cyan[500]!,
      'body': 'Replace standard long-press behavior with a shorter '
          'duration for users with motor impairments. The factory '
          'constructor lets you customize the LongPressGestureRecognizer '
          'duration per widget or per user preference.',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Pan + Scale Conflict',
      'body': 'PanGestureRecognizer and ScaleGestureRecognizer '
          'cannot coexist in the same detector — they compete for '
          'the same gesture. Use ScaleGestureRecognizer alone; at '
          'scale 1.0, it reports pan-like updates.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Factory Reuse Across Rebuilds',
      'body': 'The constructor() is called once, but initializer() '
          'runs on every build. Don\'t create expensive objects in '
          'the initializer. Put creation logic in constructor(), '
          'configuration in initializer().',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Prefer GestureDetector for Simple Cases',
      'body': 'For standard tap/long-press/drag, use GestureDetector. '
          'It handles factory creation internally. Only drop to '
          'RawGestureDetector + manual factories when you need '
          'custom recognizer parameters or custom recognizer types.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Map Key is the Type',
      'body': 'In RawGestureDetector\'s gestures map, the key is '
          'the recognizer Type (e.g., TapGestureRecognizer). You '
          'can only have ONE factory per type. Two TapGestureRecognizer '
          'factories in the same map won\'t work — the second '
          'overwrites the first.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'debugPrintGestureArenaDiagnostics',
      'body': 'Set debugPrintGestureArenaDiagnostics = true to '
          'see which recognizers compete and who wins. Essential '
          'when gestures don\'t fire as expected.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Gesture semantics for Testing',
      'body': 'RawGestureDetector has a semantics property. Set it '
          'to provide accessible labels for gesture-based widgets. '
          'This helps with widget testing and screen readers.',
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
      title: Text('GestureRecognizerFactory'),
      backgroundColor: Colors.teal[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
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
                Icon(Icons.touch_app, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'GestureRecognizerFactory',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The factory pattern behind Flutter\'s gesture system — '
                  'creates and configures GestureRecognizers for '
                  'GestureDetector and RawGestureDetector.',
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
          _gestHead('1', 'What is GestureRecognizerFactory?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
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
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Factory Anatomy ──
          _gestHead('2', 'Factory Anatomy'),
          SizedBox(height: 12),
          ...anatomyItems.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (item['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: item['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(item['icon'] as IconData,
                              color: Colors.white, size: 16),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['part'] as String,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: item['color'] as Color)),
                              Text(item['role'] as String,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(item['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Recognizer Types ──
          _gestHead('3', 'Common Recognizer Types'),
          SizedBox(height: 12),
          ...recognizerTypes.map((rt) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: rt['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (rt['color'] as Color).withOpacity(0.3)),
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
                            color: rt['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rt['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                  color: rt['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      _factChip(rt['callbacks'] as String,
                          rt['color'] as Color),
                      SizedBox(height: 8),
                      Text(rt['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: GestureDetector Internals ──
          _gestHead('4', 'How GestureDetector Uses Factories'),
          SizedBox(height: 12),
          ...internalSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: step['color'] as Color, width: 4),
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
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: step['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(step['step'] as String,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(step['icon'] as IconData,
                            color: step['color'] as Color, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(step['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(step['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: RawGestureDetector ──
          _gestHead('5', 'RawGestureDetector Usage'),
          SizedBox(height: 12),
          ...rawUsages.map((ru) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ru['color'] as Color, width: 4),
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
                        Icon(ru['icon'] as IconData,
                            color: ru['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ru['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              (ru['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(ru['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(ru['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparison ──
          _gestHead('6', 'GestureDetector vs RawGestureDetector'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 3,
                      child: Text('GestureDetector',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 3,
                      child: Text('RawGestureDetector',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11))),
                      Expanded(
                          flex: 3,
                          child: Text(row['detector']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['raw']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Gesture Arena ──
          _gestHead('7', 'Gesture Arena Explained'),
          SizedBox(height: 12),
          ...arenaPhases.map((phase) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: phase['color'] as Color, width: 4),
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
                        Icon(phase['icon'] as IconData,
                            color: phase['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(phase['phase'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(phase['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World ──
          _gestHead('8', 'Real-World Patterns'),
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
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
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
          _gestHead('9', 'Tips, Pitfalls & Gotchas'),
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

          // ── Footer ──
          Center(
            child: Text(
              'End of GestureRecognizerFactory Deep Demo',
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
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _gestHead(String number, String title) {
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
// Helper: Callback list chip
// ──────────────────────────────────────────────────────────
Widget _factChip(String text, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}
