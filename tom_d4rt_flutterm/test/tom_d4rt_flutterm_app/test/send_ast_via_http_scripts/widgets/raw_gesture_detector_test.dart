// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawGestureDetector
// Demonstrates RawGestureDetector: the low-level gesture detection widget
// that uses GestureRecognizerFactory maps instead of individual callbacks.
// Gives full control over recognizer creation and configuration.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('RawGestureDetector Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawGestureDetector Is — Concept
  // ============================================================
  print('=== Section 1: RawGestureDetector Concept ===');

  // RawGestureDetector is a low-level widget that detects gestures
  // using a Map of GestureRecognizerFactory objects.
  //
  // GestureDetector (the common one) wraps RawGestureDetector
  // internally. It provides named callbacks like onTap, onLongPress,
  // onPanUpdate. Under the hood, each callback creates a specific
  // GestureRecognizer via a factory.
  //
  // RawGestureDetector gives you direct access to this factory map:
  //   gestures: {
  //     TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
  //       () => TapGestureRecognizer(),
  //       (instance) { instance.onTap = () => handleTap(); },
  //     ),
  //   }
  //
  // Why use it?
  //   - Custom recognizer subclasses
  //   - Fine-grained control over recognizer properties
  //   - Dynamic gesture configurations
  //   - Integrating third-party recognizers

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE65100), Color(0xFFBF360C)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawGestureDetector',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Factory-based gesture detection',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direct control over gesture recognizers',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'While GestureDetector provides convenient named callbacks, '
                'RawGestureDetector exposes the raw factory map. Each entry '
                'in the map creates and configures a GestureRecognizer. '
                'This is the mechanism GestureDetector uses internally — '
                'RawGestureDetector simply makes it directly accessible.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConceptBadge('Factory Map', Icons.map),
            _buildConceptBadge('Custom Recognizers', Icons.settings),
            _buildConceptBadge('Full Control', Icons.tune),
          ],
        ),
      ],
    ),
  );

  print('  conceptCard built');

  // ============================================================
  // SECTION 2: Architecture — Factory to Recognizer Pipeline
  // ============================================================
  print('=== Section 2: Architecture ===');

  // How RawGestureDetector processes gestures:
  // 1. gestures map defines factory entries
  // 2. Each factory creates a GestureRecognizer instance
  // 3. Pointer events from the Listener are fed to recognizers
  // 4. Recognizers compete in the gesture arena
  // 5. Winner fires its callbacks

  final architectureDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: Gesture Processing Pipeline',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How RawGestureDetector turns pointer events into gesture callbacks.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        _buildPipelineStep(
          1,
          'gestures Map',
          'Map<Type, GestureRecognizerFactory> defines which recognizers '
          'to create. Each entry has a constructor and an initializer.',
          Icons.map,
          Colors.blue,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          2,
          'Factory Creates Recognizer',
          'The constructor callback creates a new GestureRecognizer. '
          'The initializer callback configures callbacks on it.',
          Icons.build,
          Colors.purple,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          3,
          'Pointer Events Arrive',
          'RawGestureDetector wraps a Listener internally. When pointer '
          'events (down, move, up) arrive, they are routed to recognizers.',
          Icons.mouse,
          Colors.orange,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          4,
          'Gesture Arena',
          'Multiple recognizers compete. The arena resolves which gesture '
          'wins (e.g., tap vs long press vs drag).',
          Icons.sports_mma,
          Colors.red,
        ),
        _buildPipelineArrow(),
        _buildPipelineStep(
          5,
          'Callback Fires',
          'The winning recognizer calls its configured callback '
          '(e.g., onTap, onLongPress, onPanUpdate).',
          Icons.check_circle,
          Colors.green,
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'GestureDetector does exactly this pipeline internally. '
                  'RawGestureDetector gives you direct access to steps 1-2.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  architectureDiagram built');

  // ============================================================
  // SECTION 3: GestureRecognizerFactory Explained
  // ============================================================
  print('=== Section 3: GestureRecognizerFactory ===');

  // GestureRecognizerFactoryWithHandlers<T> takes two functions:
  //   - constructor: () => T  (creates a new recognizer)
  //   - initializer: (T instance) => void  (configures it)
  //
  // The factory is called by the framework when the widget first
  // builds and when the gestures map changes.

  final factoryExplanation = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3: GestureRecognizerFactory',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The two-part factory pattern: create + configure.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Part 1: Constructor
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade50, Colors.indigo.shade100],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Constructor Function',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '() => TapGestureRecognizer()',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Creates a new recognizer instance. Called when the widget '
                'first builds or when the recognizer type changes.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.indigo.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.0),

        // Part 2: Initializer
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade50, Colors.green.shade100],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Initializer Function',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '(TapGestureRecognizer instance) {\n'
                  '  instance.onTap = () => handleTap();\n'
                  '  instance.onTapDown = (d) => handleDown(d);\n'
                  '}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Colors.lightGreenAccent,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Configures callbacks and properties on the recognizer. '
                'Called on every rebuild to update the recognizer with '
                'current closures and values.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.green.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // Combined card
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700,
                  size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The framework reuses recognizer instances across rebuilds. '
                  'The constructor is only called once; the initializer runs '
                  'every time to update callbacks with current state.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.amber.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  factoryExplanation built');

  // ============================================================
  // SECTION 4: Live Tap Detection
  // ============================================================
  print('=== Section 4: Live Tap Detection ===');

  // A real RawGestureDetector with a TapGestureRecognizer factory.
  // The target area shows visual feedback on tap.

  final liveTap = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Live Tap Detection',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A real RawGestureDetector with TapGestureRecognizer.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Live RawGestureDetector
        RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer instance) {
                instance.onTap = () {
                  print('  TAP detected via RawGestureDetector!');
                };
                instance.onTapDown = (TapDownDetails details) {
                  print('  TapDown at: ${details.globalPosition}');
                };
                instance.onTapUp = (TapUpDetails details) {
                  print('  TapUp at: ${details.globalPosition}');
                };
              },
            ),
          },
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade100, Colors.teal.shade200],
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.teal.shade400, width: 2.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, color: Colors.teal.shade700,
                      size: 36.0),
                  SizedBox(height: 8.0),
                  Text(
                    'Tap Target Area',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  Text(
                    'Detected via TapGestureRecognizer factory',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.teal.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Factory entry used:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<'
                'TapGestureRecognizer>(\n'
                '  () => TapGestureRecognizer(),\n'
                '  (instance) { instance.onTap = ...; },\n'
                ')',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.teal.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  liveTap built');

  // ============================================================
  // SECTION 5: Multiple Recognizers Simultaneously
  // ============================================================
  print('=== Section 5: Multiple Recognizers ===');

  // A RawGestureDetector with multiple gesture recognizer factories
  // in a single gestures map: tap, long press, and vertical drag.

  final multiRecognizer = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: Multiple Recognizers',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A single gestures map with three recognizer factories.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Multi-recognizer RawGestureDetector
        RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer instance) {
                instance.onTap = () {
                  print('  MULTI: Tap detected');
                };
              },
            ),
            LongPressGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(),
              (LongPressGestureRecognizer instance) {
                instance.onLongPress = () {
                  print('  MULTI: Long press detected');
                };
              },
            ),
            VerticalDragGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
              (VerticalDragGestureRecognizer instance) {
                instance.onStart = (DragStartDetails details) {
                  print('  MULTI: Vertical drag started');
                };
                instance.onUpdate = (DragUpdateDetails details) {
                  print('  MULTI: Drag delta: ${details.delta}');
                };
                instance.onEnd = (DragEndDetails details) {
                  print('  MULTI: Vertical drag ended');
                };
              },
            ),
          },
          child: Container(
            height: 160.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.purple.shade100,
                  Colors.pink.shade100,
                ],
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGestureIndicator(
                      'Tap',
                      Icons.touch_app,
                      Colors.blue,
                    ),
                    _buildGestureIndicator(
                      'Long Press',
                      Icons.timer,
                      Colors.orange,
                    ),
                    _buildGestureIndicator(
                      'Vert. Drag',
                      Icons.swap_vert,
                      Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Three recognizers compete in the gesture arena',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.0),

        // Recognizer table
        Text(
          'Registered Factories:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        _buildRecognizerEntry(
          'TapGestureRecognizer',
          'onTap',
          'Single quick touch',
          Colors.blue,
        ),
        SizedBox(height: 4.0),
        _buildRecognizerEntry(
          'LongPressGestureRecognizer',
          'onLongPress',
          'Touch held for 500ms+',
          Colors.orange,
        ),
        SizedBox(height: 4.0),
        _buildRecognizerEntry(
          'VerticalDragGestureRecognizer',
          'onStart, onUpdate, onEnd',
          'Finger moves vertically',
          Colors.green,
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'All three recognizers receive the same pointer events. '
            'The gesture arena determines which one wins based on '
            'user behavior (quick tap, sustained tap, or movement).',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  multiRecognizer built with 3 recognizers');

  // ============================================================
  // SECTION 6: Gesture Arena Explained
  // ============================================================
  print('=== Section 6: Gesture Arena ===');

  // When multiple recognizers receive the same pointer events,
  // they compete in the gesture arena. The arena resolves which
  // gesture "wins" based on the pointer movement and timing.

  final arenaSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Gesture Arena',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How recognizers compete to claim a gesture.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Arena visualization
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            children: [
              Text(
                'Gesture Arena',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 12.0),

              // Competing recognizers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildArenaContender(
                    'Tap',
                    'Wants: quick up',
                    Colors.blue,
                    false,
                  ),
                  _buildArenaContender(
                    'Long Press',
                    'Wants: sustained',
                    Colors.orange,
                    false,
                  ),
                  _buildArenaContender(
                    'Drag',
                    'Wants: movement',
                    Colors.green,
                    true,
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.green.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, color: Colors.green, size: 20.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Drag wins (finger moved vertically)',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // Arena resolution rules
        Text(
          'Arena Resolution Rules:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        _buildArenaRule(
          'Quick up',
          'TapGestureRecognizer wins — pointer went down and up quickly',
          Icons.touch_app,
          Colors.blue,
        ),
        SizedBox(height: 6.0),
        _buildArenaRule(
          'Sustained contact',
          'LongPressGestureRecognizer wins after duration threshold',
          Icons.timer,
          Colors.orange,
        ),
        SizedBox(height: 6.0),
        _buildArenaRule(
          'Movement detected',
          'DragGestureRecognizer wins when pointer moves past slop threshold',
          Icons.open_with,
          Colors.green,
        ),
        SizedBox(height: 6.0),
        _buildArenaRule(
          'Last one standing',
          'If only one recognizer remains, it wins by default',
          Icons.person,
          Colors.purple,
        ),

        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The gesture arena is the reason GestureDetector and '
            'RawGestureDetector do not fire multiple gesture callbacks '
            'for the same pointer sequence — only one recognizer wins.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.red.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  arenaSection built');

  // ============================================================
  // SECTION 7: API Property Reference
  // ============================================================
  print('=== Section 7: API Properties ===');

  final apiSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7: API Properties',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 16.0),

        _buildApiPropertyCard(
          'gestures',
          'Map<Type, GestureRecognizerFactory>',
          'Required. Maps recognizer types to their factories. Each factory '
          'creates and configures one GestureRecognizer.',
          Colors.teal,
        ),
        SizedBox(height: 10.0),
        _buildApiPropertyCard(
          'behavior',
          'HitTestBehavior?',
          'Controls the hit test behavior. Options: deferToChild (default), '
          'opaque (always absorbs hits), translucent (allows hits to pass '
          'through while still receiving them).',
          Colors.blue,
        ),
        SizedBox(height: 10.0),
        _buildApiPropertyCard(
          'excludeFromSemantics',
          'bool',
          'Whether to exclude the gesture detector from the semantics '
          'tree. Default: false. Set true if gestures are decorative.',
          Colors.purple,
        ),
        SizedBox(height: 10.0),
        _buildApiPropertyCard(
          'semantics',
          'SemanticsGestureDelegate?',
          'Custom semantics delegate for gesture actions. Used when '
          'the default semantics mapping is insufficient.',
          Colors.orange,
        ),
        SizedBox(height: 10.0),
        _buildApiPropertyCard(
          'child',
          'Widget?',
          'The widget below this one in the tree. Events on this child '
          'will trigger the gesture recognizers.',
          Colors.green,
        ),

        SizedBox(height: 16.0),

        // HitTestBehavior visual
        Text(
          'HitTestBehavior Values:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildBehaviorDisplay(
                'deferToChild',
                'Only responds where child has content',
                Colors.blue,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBehaviorDisplay(
                'opaque',
                'Responds anywhere in bounds',
                Colors.orange,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBehaviorDisplay(
                'translucent',
                'Responds and passes through',
                Colors.green,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('  apiSection built');

  // ============================================================
  // SECTION 8: RawGestureDetector vs GestureDetector
  // ============================================================
  print('=== Section 8: Comparison ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8: RawGestureDetector vs GestureDetector',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'GestureDetector wraps RawGestureDetector with convenience API.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Comparison header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.pink.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'RawGestureDetector',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.deepOrange.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'GestureDetector',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildComparisonRow(
          'Input API',
          'Map<Type, Factory>',
          'Named callbacks (onTap, etc.)',
        ),
        _buildComparisonRow(
          'Custom recognizers',
          'Fully supported',
          'Not supported',
        ),
        _buildComparisonRow(
          'Recognizer config',
          'Direct property access',
          'Limited to callback params',
        ),
        _buildComparisonRow(
          'Verbosity',
          'More code, more control',
          'Less code, simpler API',
        ),
        _buildComparisonRow(
          'Library',
          'widgets (framework-level)',
          'widgets (framework-level)',
        ),
        _buildComparisonRow(
          'Use case',
          'Custom, dynamic gestures',
          'Standard gesture callbacks',
        ),
        _buildComparisonRow(
          'Relationship',
          'Base widget',
          'Wrapper around Raw',
        ),

        SizedBox(height: 16.0),

        // Side-by-side code
        Text(
          'Code Comparison:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.pink.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RawGestureDetector',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'gestures: {\n'
                      '  TapGR: Factory(\n'
                      '    () => TapGR(),\n'
                      '    (i) {\n'
                      '      i.onTap = fn;\n'
                      '    },\n'
                      '  ),\n'
                      '}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GestureDetector',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'GestureDetector(\n'
                      '  onTap: fn,\n'
                      '  child: ...,\n'
                      ')\n'
                      '\n'
                      '// Much simpler!\n'
                      '// But no custom\n'
                      '// recognizer access',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates,
                  color: Colors.pink.shade600, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Use GestureDetector for 95% of cases. Use '
                  'RawGestureDetector when you need custom recognizer '
                  'subclasses, recognizer property access, or dynamic '
                  'gesture configurations.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.pink.shade800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  comparisonSection built');

  // ============================================================
  // SECTION 9: Common Recognizer Types Catalog
  // ============================================================
  print('=== Section 9: Recognizer Catalog ===');

  final recognizerCatalog = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9: Recognizer Type Catalog',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Common GestureRecognizer types usable in the gestures map.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        _buildRecognizerCatalogEntry(
          'TapGestureRecognizer',
          'Single tap on a target',
          'onTap, onTapDown, onTapUp, onTapCancel, onSecondaryTap',
          Icons.touch_app,
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'DoubleTapGestureRecognizer',
          'Two taps in quick succession',
          'onDoubleTap, onDoubleTapDown, onDoubleTapCancel',
          Icons.looks_two,
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'LongPressGestureRecognizer',
          'Sustained touch > 500ms',
          'onLongPress, onLongPressStart, onLongPressMoveUpdate, onLongPressEnd',
          Icons.timer,
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'VerticalDragGestureRecognizer',
          'Finger movement along Y axis',
          'onStart, onUpdate, onEnd, onCancel',
          Icons.swap_vert,
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'HorizontalDragGestureRecognizer',
          'Finger movement along X axis',
          'onStart, onUpdate, onEnd, onCancel',
          Icons.swap_horiz,
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'PanGestureRecognizer',
          'Free finger movement (any direction)',
          'onStart, onUpdate, onEnd, onCancel',
          Icons.open_with,
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'ScaleGestureRecognizer',
          'Pinch-to-zoom and rotate',
          'onStart, onUpdate, onEnd',
          Icons.zoom_in,
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildRecognizerCatalogEntry(
          'ForcePressGestureRecognizer',
          'Pressure-sensitive touch (3D Touch)',
          'onStart, onPeak, onUpdate, onEnd',
          Icons.fitness_center,
          Colors.brown,
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Each of these can be used as a key in the gestures map. '
            'Custom GestureRecognizer subclasses also work — simply '
            'use your custom type as the map key and create it in the factory.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.amber.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  recognizerCatalog built with 8 recognizer types');

  // ============================================================
  // Assemble all sections
  // ============================================================
  print('=== Assembling final layout ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        architectureDiagram,
        factoryExplanation,
        liveTap,
        multiRecognizer,
        arenaSection,
        apiSection,
        comparisonSection,
        recognizerCatalog,
        SizedBox(height: 32.0),
      ],
    ),
  );

  print('RawGestureDetector Deep Demo complete — 9 sections');
  return result;
}

// ============================================================
// Helper functions
// ============================================================

Widget _buildConceptBadge(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.orangeAccent.withValues(alpha: 0.5),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.orangeAccent, size: 14.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineStep(
  int number,
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color.shade700, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color.shade700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Icon(Icons.arrow_downward,
          color: Colors.grey.shade400, size: 20.0),
    ),
  );
}

Widget _buildGestureIndicator(
  String label,
  IconData icon,
  MaterialColor color,
) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.shade50,
          shape: BoxShape.circle,
          border: Border.all(color: color.shade300, width: 2.0),
        ),
        child: Icon(icon, color: color, size: 22.0),
      ),
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          color: color.shade800,
        ),
      ),
    ],
  );
}

Widget _buildRecognizerEntry(
  String type,
  String callbacks,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: color.shade900,
                ),
              ),
              Text(
                '$callbacks — $description',
                style: TextStyle(fontSize: 10.0, color: color.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildArenaContender(
  String name,
  String wants,
  MaterialColor color,
  bool isWinner,
) {
  return Container(
    width: 90.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isWinner ? color.shade100 : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: isWinner ? color : Colors.grey.shade300,
        width: isWinner ? 2.0 : 1.0,
      ),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: isWinner ? color.shade900 : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          wants,
          style: TextStyle(
            fontSize: 9.0,
            color: isWinner ? color.shade700 : Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.0),
        Icon(
          isWinner ? Icons.emoji_events : Icons.close,
          color: isWinner ? Colors.amber : Colors.grey.shade400,
          size: 16.0,
        ),
      ],
    ),
  );
}

Widget _buildArenaRule(
  String condition,
  String result,
  IconData icon,
  MaterialColor color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color.shade100,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(icon, color: color.shade700, size: 16.0),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              condition,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: color.shade900,
              ),
            ),
            Text(
              result,
              style: TextStyle(fontSize: 11.0, color: color.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildApiPropertyCard(
  String name,
  String type,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color.shade900,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              type,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color.shade600,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 6.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: color.shade800,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBehaviorDisplay(
  String name,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 9.0, color: color.shade700),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String feature,
  String rawValue,
  String gestureValue,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.pink.shade100, width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
              color: Colors.pink.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            rawValue,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.deepOrange.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            gestureValue,
            style: TextStyle(fontSize: 10.0, color: Colors.blue.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecognizerCatalogEntry(
  String type,
  String description,
  String callbacks,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color.shade700, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: color.shade900,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: color.shade700),
              ),
              SizedBox(height: 2.0),
              Text(
                callbacks,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: color.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
