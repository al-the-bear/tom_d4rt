// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawKeyboardListener
// Demonstrates the deprecated RawKeyboardListener widget that wraps a child
// and calls back when the user presses or releases keyboard keys.
// Requires a FocusNode for focus management to receive key events.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyboardListener Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawKeyboardListener Is — Concept
  // ============================================================
  print('=== Section 1: RawKeyboardListener Concept ===');

  // RawKeyboardListener is a widget that calls a callback whenever
  // the user presses or releases a key on a physical keyboard,
  // provided its FocusNode currently has input focus.
  //
  // The callback receives a RawKeyEvent which is either:
  //   - RawKeyDownEvent (key pressed down)
  //   - RawKeyUpEvent (key released)
  //
  // This widget is now DEPRECATED in favor of KeyboardListener,
  // which uses the newer HardwareKeyboard / KeyEvent system.
  // However, RawKeyboardListener is still widely used in existing
  // codebases and its event model is worth understanding.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF37474F), Color(0xFF263238)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.keyboard, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawKeyboardListener',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends StatefulWidget',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A widget that calls a callback whenever the user presses '
            'or releases a key on a physical keyboard. The callback '
            'receives RawKeyEvent objects — either RawKeyDownEvent '
            'or RawKeyUpEvent — but only when the widget\'s '
            'FocusNode currently holds input focus.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFFF9800), width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: Color(0xFFE65100), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Deprecated: Use KeyboardListener with HardwareKeyboard '
                  'for new code. RawKeyboardListener uses the older '
                  'RawKeyboard system.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFFE65100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Concept card built');

  // ============================================================
  // SECTION 2: Basic RawKeyboardListener Setup
  // ============================================================
  print('=== Section 2: Basic Setup ===');

  // A minimal RawKeyboardListener requires:
  //   1. A FocusNode — to manage when this widget listens for keys
  //   2. A child — the widget content to display
  //   3. An onKey callback (optional) — called when a key event occurs
  //
  // Optionally:
  //   - autofocus: true to immediately request focus on build
  //   - includeSemantics: whether to include keyboard-related semantics

  final focusNode1 = FocusNode(debugLabel: 'Basic Listener');

  final basicListenerWidget = RawKeyboardListener(
    focusNode: focusNode1,
    autofocus: false,
    onKey: (RawKeyEvent event) {
      print('  Key event: ${event.runtimeType}, logical: ${event.logicalKey.debugName}');
    },
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF42A5F5), width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.keyboard_alt_outlined, color: Color(0xFF1565C0), size: 36.0),
          SizedBox(height: 10.0),
          Text(
            'Basic RawKeyboardListener',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'This area is wrapped in a RawKeyboardListener. '
            'When focused, key events are received via onKey.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F)),
          ),
        ],
      ),
    ),
  );

  // A second one with autofocus enabled
  final focusNode2 = FocusNode(debugLabel: 'Autofocus Listener');

  final autofocusListenerWidget = RawKeyboardListener(
    focusNode: focusNode2,
    autofocus: true,
    onKey: (RawKeyEvent event) {
      print('  Autofocus listener received: ${event.logicalKey.debugName}');
    },
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFF66BB6A), width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.center_focus_strong, color: Color(0xFF2E7D32), size: 36.0),
          SizedBox(height: 10.0),
          Text(
            'Autofocus RawKeyboardListener',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'autofocus: true — this listener requests focus '
            'immediately when built, so it receives key events '
            'without the user needing to tap first.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Color(0xFF37474F)),
          ),
        ],
      ),
    ),
  );

  final basicSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Basic RawKeyboardListener Setup', Icons.play_circle_outline),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A minimal RawKeyboardListener requires a FocusNode '
            'and a child widget. The onKey callback is called '
            'whenever a key is pressed or released while the '
            'FocusNode has focus.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        basicListenerWidget,
        SizedBox(height: 12.0),
        autofocusListenerWidget,
        SizedBox(height: 12.0),
        _buildCodeSnippetCard(
          'Minimal Setup',
          'RawKeyboardListener(\n'
          '  focusNode: myFocusNode,\n'
          '  autofocus: true,\n'
          '  onKey: (RawKeyEvent event) {\n'
          '    if (event is RawKeyDownEvent) {\n'
          '      print(event.logicalKey);\n'
          '    }\n'
          '  },\n'
          '  child: MyContent(),\n'
          ')',
        ),
      ],
    ),
  );

  print('  Basic section built with 2 live listeners');

  // ============================================================
  // SECTION 3: FocusNode & Focus Mechanism
  // ============================================================
  print('=== Section 3: FocusNode & Focus Mechanism ===');

  // RawKeyboardListener ONLY receives key events when its
  // FocusNode has focus. Without focus, keys are not routed here.
  // This is the fundamental concept: keyboard events follow focus.
  //
  // Focus can be acquired by:
  //   1. Tapping the child widget (if it's a Focus-aware area)
  //   2. Setting autofocus: true
  //   3. Programmatically calling focusNode.requestFocus()
  //   4. Tab navigation to the focusable area

  final focusDiagram = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFAB47BC)),
    ),
    child: Column(
      children: [
        Text(
          'Focus Flow Diagram',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        SizedBox(height: 14.0),
        _buildFocusFlowStep(
          '1',
          'User Taps / autofocus / requestFocus()',
          'Focus is requested for this FocusNode',
          Color(0xFF7B1FA2),
        ),
        _buildFocusFlowArrow(),
        _buildFocusFlowStep(
          '2',
          'FocusNode Gains Focus',
          'The node becomes the primary focus owner',
          Color(0xFF6A1B9A),
        ),
        _buildFocusFlowArrow(),
        _buildFocusFlowStep(
          '3',
          'RawKeyboard Routes Events',
          'Key events from the platform are sent to focused listeners',
          Color(0xFF4A148C),
        ),
        _buildFocusFlowArrow(),
        _buildFocusFlowStep(
          '4',
          'onKey(RawKeyEvent) Called',
          'Your callback receives RawKeyDownEvent or RawKeyUpEvent',
          Color(0xFF311B92),
        ),
      ],
    ),
  );

  // Focused vs unfocused visual comparison
  final focusedVsUnfocused = Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 6.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF4CAF50), width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 8.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.radio_button_checked, color: Color(0xFF2E7D32), size: 28.0),
              SizedBox(height: 8.0),
              Text(
                'FOCUSED',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Key events are routed to onKey callback',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF33691E)),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Color(0xFFC8E6C9),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'hasFocus: true',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF1B5E20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 6.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFFBE9E7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFBDBDBD), width: 1.5),
          ),
          child: Column(
            children: [
              Icon(Icons.radio_button_unchecked, color: Color(0xFF9E9E9E), size: 28.0),
              SizedBox(height: 8.0),
              Text(
                'UNFOCUSED',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF757575),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Key events are NOT delivered; onKey is never called',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF616161)),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'hasFocus: false',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF616161),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  final focusSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('FocusNode & Focus Mechanism', Icons.center_focus_weak),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'RawKeyboardListener only receives key events when its '
            'FocusNode holds input focus. Without focus, keyboard '
            'events are not routed to this listener. Focus can be '
            'acquired via tapping, autofocus, requestFocus(), or '
            'tab navigation.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        focusDiagram,
        SizedBox(height: 14.0),
        focusedVsUnfocused,
      ],
    ),
  );

  print('  Focus mechanism section built');

  // ============================================================
  // SECTION 4: Event Data Model — RawKeyEvent
  // ============================================================
  print('=== Section 4: Event Data Model ===');

  // RawKeyEvent is the base class with two subclasses:
  //   - RawKeyDownEvent: fired when a key is pressed
  //   - RawKeyUpEvent: fired when a key is released
  //
  // Key properties on RawKeyEvent:
  //   - logicalKey (LogicalKeyboardKey) — semantic key identity
  //   - physicalKey (PhysicalKeyboardKey) — hardware key location
  //   - character (String?) — the character produced, if any
  //   - repeat (bool) — true if this is a key-repeat event
  //   - isControlPressed, isShiftPressed, isAltPressed, isMetaPressed

  final eventTypeCards = Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 6.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Icon(Icons.arrow_downward, color: Colors.white, size: 24.0),
              SizedBox(height: 8.0),
              Text(
                'RawKeyDownEvent',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Fired when a key is pressed down. Also fires on '
                'key repeat if the key is held.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.5, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 6.0),
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC62828), Color(0xFFB71C1C)],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Icon(Icons.arrow_upward, color: Colors.white, size: 24.0),
              SizedBox(height: 8.0),
              Text(
                'RawKeyUpEvent',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Fired when a key is released. Always pairs with '
                'a previous RawKeyDownEvent.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.5, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // Event lifecycle visualization
  final eventLifecycle = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Press Lifecycle',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12.0),
        _buildEventStep('User presses "A" key', 'RawKeyDownEvent', Color(0xFF1565C0)),
        SizedBox(height: 4.0),
        _buildEventStep('Key held (repeat)', 'RawKeyDownEvent (repeat: true)', Color(0xFF1976D2)),
        SizedBox(height: 4.0),
        _buildEventStep('Key held (repeat)', 'RawKeyDownEvent (repeat: true)', Color(0xFF1E88E5)),
        SizedBox(height: 4.0),
        _buildEventStep('User releases key', 'RawKeyUpEvent', Color(0xFFC62828)),
      ],
    ),
  );

  final eventModelSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Event Data Model', Icons.data_object),
        SizedBox(height: 12.0),
        eventTypeCards,
        SizedBox(height: 14.0),
        eventLifecycle,
      ],
    ),
  );

  print('  Event data model section built');

  // ============================================================
  // SECTION 5: Key Identification — Logical vs Physical
  // ============================================================
  print('=== Section 5: Key Identification ===');

  // LogicalKeyboardKey — Semantic: what the key MEANS
  //   - Abstracts away keyboard layout
  //   - LogicalKeyboardKey.keyA is "A" regardless of layout
  //   - Includes special keys: escape, enter, tab, etc.
  //
  // PhysicalKeyboardKey — Hardware: WHERE the key IS
  //   - Represents the physical location on the keyboard
  //   - PhysicalKeyboardKey.keyA is the key in the QWERTY "A" position
  //   - On Dvorak, this same physical key might produce a different letter

  final logicalKeys = <Map<String, String>>[
    {'key': 'keyA', 'desc': 'The letter A (layout-independent)'},
    {'key': 'enter', 'desc': 'Enter/Return key'},
    {'key': 'escape', 'desc': 'Escape key'},
    {'key': 'space', 'desc': 'Space bar'},
    {'key': 'tab', 'desc': 'Tab key'},
    {'key': 'backspace', 'desc': 'Backspace/Delete backward'},
    {'key': 'arrowUp', 'desc': 'Up arrow key'},
    {'key': 'arrowDown', 'desc': 'Down arrow key'},
    {'key': 'controlLeft', 'desc': 'Left Control modifier'},
    {'key': 'shiftLeft', 'desc': 'Left Shift modifier'},
  ];

  final logicalKeyGrid = Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFF1565C0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.keyboard, color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'LogicalKeyboardKey — Semantic Identity',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      ...logicalKeys.map((entry) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
            left: BorderSide(color: Color(0xFF1565C0), width: 3.0),
            right: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 100.0,
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                entry['key']!,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                entry['desc']!,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
      )),
    ],
  );

  // Physical vs Logical comparison
  final physVsLogical = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFC107)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Physical vs Logical Keys',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF57F17),
          ),
        ),
        SizedBox(height: 8.0),
        _buildKeyComparisonRow(
          'QWERTY layout:',
          'Physical: keyA',
          'Logical: keyA',
          Color(0xFF4CAF50),
        ),
        SizedBox(height: 6.0),
        _buildKeyComparisonRow(
          'Dvorak layout:',
          'Physical: keyA (same spot)',
          'Logical: different letter',
          Color(0xFFFF9800),
        ),
        SizedBox(height: 6.0),
        _buildKeyComparisonRow(
          'AZERTY layout:',
          'Physical: keyA (same spot)',
          'Logical: keyQ',
          Color(0xFF2196F3),
        ),
        SizedBox(height: 10.0),
        Text(
          'Use LogicalKeyboardKey for most cases (what the user '
          'intends). Use PhysicalKeyboardKey only for layout-'
          'independent shortcuts (like WASD game controls).',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF795548), height: 1.4),
        ),
      ],
    ),
  );

  final keyIdSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Key Identification', Icons.vpn_key),
        SizedBox(height: 12.0),
        logicalKeyGrid,
        SizedBox(height: 14.0),
        physVsLogical,
      ],
    ),
  );

  print('  Key identification section built with ${logicalKeys.length} examples');

  // ============================================================
  // SECTION 6: Modifier Key States
  // ============================================================
  print('=== Section 6: Modifier Key States ===');

  // RawKeyEvent exposes modifier key state through boolean getters:
  //   - isControlPressed
  //   - isShiftPressed
  //   - isAltPressed
  //   - isMetaPressed (Cmd on macOS, Win on Windows)
  //
  // These allow detecting keyboard shortcuts like Ctrl+S, Ctrl+C, etc.

  final modifierKeys = <Map<String, dynamic>>[
    {
      'name': 'Control',
      'property': 'isControlPressed',
      'icon': Icons.control_camera,
      'color': Color(0xFF2196F3),
      'desc': 'Ctrl key (left or right)',
      'example': 'Ctrl+S to save',
    },
    {
      'name': 'Shift',
      'property': 'isShiftPressed',
      'icon': Icons.arrow_upward,
      'color': Color(0xFF4CAF50),
      'desc': 'Shift key (left or right)',
      'example': 'Shift+A for uppercase',
    },
    {
      'name': 'Alt',
      'property': 'isAltPressed',
      'icon': Icons.alt_route,
      'color': Color(0xFFFF9800),
      'desc': 'Alt/Option key',
      'example': 'Alt+Tab to switch windows',
    },
    {
      'name': 'Meta',
      'property': 'isMetaPressed',
      'icon': Icons.laptop_mac,
      'color': Color(0xFF9C27B0),
      'desc': 'Cmd (macOS) or Win (Windows)',
      'example': 'Cmd+C to copy',
    },
  ];

  final modifierGrid = Column(
    children: modifierKeys.map((mod) {
      final color = mod['color'] as Color;
      return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(mod['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mod['name'] as String,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          mod['property'] as String,
                          style: TextStyle(
                            fontSize: 9.0,
                            fontFamily: 'monospace',
                            color: Color(0xFF616161),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '${mod['desc']} — ${mod['example']}',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // Shortcut combination visual
  final shortcutComboVisual = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF7E57C2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detecting Key Combinations',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4527A0),
          ),
        ),
        SizedBox(height: 10.0),
        _buildShortcutRow('Ctrl + S', 'Save', Color(0xFF2196F3)),
        SizedBox(height: 6.0),
        _buildShortcutRow('Ctrl + Z', 'Undo', Color(0xFF4CAF50)),
        SizedBox(height: 6.0),
        _buildShortcutRow('Ctrl + Shift + Z', 'Redo', Color(0xFFFF9800)),
        SizedBox(height: 6.0),
        _buildShortcutRow('Alt + F4', 'Close', Color(0xFFF44336)),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Check modifiers in onKey callback:\n'
            'if (event is RawKeyDownEvent &&\n'
            '    event.isControlPressed &&\n'
            '    event.logicalKey == LogicalKeyboardKey.keyS) {\n'
            '  // handle Ctrl+S\n'
            '}',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF37474F),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  final modifierSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Modifier Key States', Icons.keyboard_capslock),
        SizedBox(height: 12.0),
        modifierGrid,
        SizedBox(height: 14.0),
        shortcutComboVisual,
      ],
    ),
  );

  print('  Modifier keys section built with ${modifierKeys.length} keys');

  // ============================================================
  // SECTION 7: includeSemantics Property
  // ============================================================
  print('=== Section 7: includeSemantics ===');

  // includeSemantics determines whether the listener adds
  // focus-related semantics to the widget tree for accessibility.
  //
  // When true (default), the listener contributes to the semantics
  // tree so screen readers know this area is keyboard-focusable.
  // When false, the listener does not add semantics nodes.

  final focusNodeSem1 = FocusNode(debugLabel: 'With Semantics');
  final focusNodeSem2 = FocusNode(debugLabel: 'Without Semantics');

  final withSemantics = RawKeyboardListener(
    focusNode: focusNodeSem1,
    includeSemantics: true,
    onKey: (RawKeyEvent event) {},
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF4CAF50), width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.accessibility_new, color: Color(0xFF2E7D32), size: 28.0),
          SizedBox(height: 8.0),
          Text(
            'includeSemantics: true',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Adds focus semantics to the accessibility tree. '
            'Screen readers announce this as a focusable area.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF33691E)),
          ),
        ],
      ),
    ),
  );

  final withoutSemantics = RawKeyboardListener(
    focusNode: focusNodeSem2,
    includeSemantics: false,
    onKey: (RawKeyEvent event) {},
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFFF9800), width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.accessibility, color: Color(0xFFE65100), size: 28.0),
          SizedBox(height: 8.0),
          Text(
            'includeSemantics: false',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFFE65100),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'No focus semantics added. Use when another widget '
            'already provides the semantics for this area.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Color(0xFFBF360C)),
          ),
        ],
      ),
    ),
  );

  final semanticsSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('includeSemantics Property', Icons.accessibility_new),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'includeSemantics controls whether RawKeyboardListener '
            'contributes focus-related nodes to the accessibility '
            'semantics tree. Set to false when another widget in '
            'the tree already provides the necessary semantics.',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: withSemantics),
            SizedBox(width: 10.0),
            Expanded(child: withoutSemantics),
          ],
        ),
      ],
    ),
  );

  print('  includeSemantics section built');

  // ============================================================
  // SECTION 8: Real-World Use Patterns
  // ============================================================
  print('=== Section 8: Real-World Use Patterns ===');

  // Pattern 1: Game Controls (WASD)
  final gameControlsPattern = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A237E), Color(0xFF283593)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.games, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Game Controls (WASD)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // WASD layout
        Column(
          children: [
            _buildKeyDisplay('W', 'Forward', Color(0xFF42A5F5)),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildKeyDisplay('A', 'Left', Color(0xFF66BB6A)),
                SizedBox(width: 4.0),
                _buildKeyDisplay('S', 'Back', Color(0xFFEF5350)),
                SizedBox(width: 4.0),
                _buildKeyDisplay('D', 'Right', Color(0xFFFFA726)),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Games use PhysicalKeyboardKey for layout-independent controls. '
          'WASD always refers to the same physical position.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.5, color: Colors.white70),
        ),
      ],
    ),
  );

  // Pattern 2: Keyboard Shortcuts
  final shortcutsPattern = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF004D40), Color(0xFF00695C)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shortcut, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Keyboard Shortcuts',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildShortcutPattern('Save document', 'event.isControlPressed && key == keyS'),
        SizedBox(height: 6.0),
        _buildShortcutPattern('Find', 'event.isControlPressed && key == keyF'),
        SizedBox(height: 6.0),
        _buildShortcutPattern('Select all', 'event.isControlPressed && key == keyA'),
        SizedBox(height: 6.0),
        _buildShortcutPattern('Close tab', 'event.isControlPressed && key == keyW'),
        SizedBox(height: 10.0),
        Text(
          'Keyboard shortcuts use LogicalKeyboardKey to respect '
          'the current keyboard layout.',
          style: TextStyle(fontSize: 10.5, color: Colors.white70),
        ),
      ],
    ),
  );

  // Pattern 3: Accessible Input
  final accessibleInputPattern = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessible, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Accessible Custom Inputs',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Custom widgets that accept keyboard input wrap their '
          'content in RawKeyboardListener to receive focus and '
          'respond to key presses — for example, a custom dropdown '
          'that can be navigated with arrow keys, or a color '
          'picker that adjusts hue with left/right arrows.',
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.white54, size: 18.0),
              SizedBox(width: 4.0),
              Icon(Icons.arrow_forward, color: Colors.white54, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'Arrow keys navigate, Enter selects, Escape closes',
                style: TextStyle(fontSize: 10.0, color: Colors.white60),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final usePatternsSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Real-World Use Patterns', Icons.architecture),
        SizedBox(height: 12.0),
        gameControlsPattern,
        SizedBox(height: 12.0),
        shortcutsPattern,
        SizedBox(height: 12.0),
        accessibleInputPattern,
      ],
    ),
  );

  print('  Real-world patterns section built');

  // ============================================================
  // SECTION 9: API Property Reference
  // ============================================================
  print('=== Section 9: API Property Reference ===');

  final apiProperties = <Map<String, String>>[
    {
      'name': 'focusNode',
      'type': 'FocusNode',
      'required': 'Yes',
      'desc': 'The focus node that determines when this listener receives key events.',
    },
    {
      'name': 'autofocus',
      'type': 'bool',
      'required': 'No (false)',
      'desc': 'Whether this listener should request focus when first built.',
    },
    {
      'name': 'includeSemantics',
      'type': 'bool',
      'required': 'No (true)',
      'desc': 'Whether to add focus-related semantics to the accessibility tree.',
    },
    {
      'name': 'onKey',
      'type': 'ValueChanged<RawKeyEvent>?',
      'required': 'No',
      'desc': 'Callback invoked when a key is pressed or released while focused.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'required': 'Yes',
      'desc': 'The widget to display; receives visual focus when FocusNode has focus.',
    },
  ];

  final apiCards = Column(
    children: apiProperties.map((prop) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    prop['name']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    prop['type']!,
                    style: TextStyle(
                      fontSize: 9.0,
                      fontFamily: 'monospace',
                      color: Color(0xFFC62828),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: prop['required']!.startsWith('Yes')
                        ? Color(0xFFE8F5E9)
                        : Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    prop['required']!,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: prop['required']!.startsWith('Yes')
                          ? Color(0xFF2E7D32)
                          : Color(0xFFF57F17),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              prop['desc']!,
              style: TextStyle(fontSize: 11.0, color: Color(0xFF616161), height: 1.4),
            ),
          ],
        ),
      );
    }).toList(),
  );

  final apiSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('API Property Reference', Icons.menu_book),
        SizedBox(height: 12.0),
        apiCards,
      ],
    ),
  );

  print('  API reference section built with ${apiProperties.length} properties');

  // ============================================================
  // SECTION 10: RawKeyboardListener vs KeyboardListener
  // ============================================================
  print('=== Section 10: RawKeyboardListener vs KeyboardListener ===');

  // RawKeyboardListener (deprecated):
  //   - Uses RawKeyboard / RawKeyEvent system
  //   - onKey receives RawKeyEvent
  //   - Platform-specific key data varies
  //
  // KeyboardListener (recommended):
  //   - Uses HardwareKeyboard / KeyEvent system
  //   - onKeyEvent receives KeyEvent
  //   - Cleaner, more consistent event model

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Status',
      'raw': 'Deprecated',
      'keyboard': 'Current / Recommended',
    },
    {
      'aspect': 'Event System',
      'raw': 'RawKeyboard',
      'keyboard': 'HardwareKeyboard',
    },
    {
      'aspect': 'Event Type',
      'raw': 'RawKeyEvent',
      'keyboard': 'KeyEvent',
    },
    {
      'aspect': 'Callback',
      'raw': 'onKey',
      'keyboard': 'onKeyEvent',
    },
    {
      'aspect': 'Key Repeat',
      'raw': 'RawKeyDownEvent (repeat)',
      'keyboard': 'KeyRepeatEvent',
    },
    {
      'aspect': 'Consistency',
      'raw': 'Platform-variant data',
      'keyboard': 'Uniform across platforms',
    },
  ];

  final comparisonTable = Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFF37474F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Aspect',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'RawKeyboardListener',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEF9A9A),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'KeyboardListener',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA5D6A7),
                ),
              ),
            ),
          ],
        ),
      ),
      ...comparisonRows.map((row) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row['aspect']!,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text(
                  row['raw']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFFC62828),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text(
                  row['keyboard']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    ],
  );

  // Migration guide visual
  final migrationGuide = Container(
    margin: EdgeInsets.only(top: 14.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF66BB6A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Color(0xFF2E7D32), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Migration Steps',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _buildMigrationStep('1', 'Replace RawKeyboardListener with KeyboardListener'),
        SizedBox(height: 6.0),
        _buildMigrationStep('2', 'Change onKey to onKeyEvent'),
        SizedBox(height: 6.0),
        _buildMigrationStep('3', 'Update RawKeyEvent to KeyEvent'),
        SizedBox(height: 6.0),
        _buildMigrationStep('4', 'Replace RawKeyDownEvent with KeyDownEvent'),
        SizedBox(height: 6.0),
        _buildMigrationStep('5', 'Replace RawKeyUpEvent with KeyUpEvent'),
        SizedBox(height: 6.0),
        _buildMigrationStep('6', 'Handle new KeyRepeatEvent type'),
      ],
    ),
  );

  final comparisonSection = Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('RawKeyboardListener vs KeyboardListener', Icons.compare_arrows),
        SizedBox(height: 12.0),
        comparisonTable,
        migrationGuide,
      ],
    ),
  );

  print('  Comparison section built with ${comparisonRows.length} rows');

  // ============================================================
  // Build final scrollable layout
  // ============================================================
  print('Building final layout with all 10 sections');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(20.0),
          color: Color(0xFF263238),
          child: Column(
            children: [
              Text(
                'RawKeyboardListener',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Deep Demo — Keyboard Event Handling Widget',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF9800).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'DEPRECATED',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFCC80),
                  ),
                ),
              ),
            ],
          ),
        ),
        conceptCard,
        basicSection,
        focusSection,
        eventModelSection,
        keyIdSection,
        modifierSection,
        semanticsSection,
        usePatternsSection,
        apiSection,
        comparisonSection,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ============================================================
// Helper Functions
// ============================================================

Widget _buildSectionTitle(String title, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippetCard(String label, String code) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF80CBC4),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          code,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Color(0xFFCFD8DC),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFocusFlowStep(String number, String title, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFocusFlowArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(Icons.arrow_downward, color: Color(0xFF9575CD), size: 18.0),
    ),
  );
}

Widget _buildEventStep(String action, String event, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: color, width: 3.0)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            action,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              event,
              style: TextStyle(
                fontSize: 9.5,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyComparisonRow(String layout, String physical, String logical, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 100.0,
        child: Text(
          layout,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF795548),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            physical,
            style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: color),
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            logical,
            style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: color),
          ),
        ),
      ),
    ],
  );
}

Widget _buildShortcutRow(String keys, String action, Color color) {
  return Row(
    children: [
      Container(
        width: 120.0,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          keys,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(width: 10.0),
      Icon(Icons.arrow_forward, color: Colors.white54, size: 16.0),
      SizedBox(width: 10.0),
      Text(
        action,
        style: TextStyle(fontSize: 12.0, color: Colors.white70),
      ),
    ],
  );
}

Widget _buildShortcutPattern(String action, String code) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, color: Color(0xFF80CBC4), size: 14.0),
        SizedBox(width: 6.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                action,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                code,
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF80CBC4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyDisplay(String key, String label, Color color) {
  return Container(
    width: 56.0,
    height: 56.0,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 2.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 7.0, color: Colors.white70),
        ),
      ],
    ),
  );
}

Widget _buildMigrationStep(String number, String instruction) {
  return Row(
    children: [
      Container(
        width: 22.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: Color(0xFF2E7D32),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Text(
          instruction,
          style: TextStyle(fontSize: 11.5, color: Color(0xFF33691E)),
        ),
      ),
    ],
  );
}
