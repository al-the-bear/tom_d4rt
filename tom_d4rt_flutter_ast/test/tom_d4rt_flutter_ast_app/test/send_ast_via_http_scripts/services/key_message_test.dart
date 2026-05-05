// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyMessage from services
// Deep Demo: Visual demonstration of KeyMessage — the deprecated wrapper used
// by KeyEventManager to bundle a list of KeyEvents (KeyDownEvent / KeyUpEvent /
// KeyRepeatEvent) along with the original platform raw event before they are
// dispatched through Flutter's focus-based key routing pipeline. Because
// KeyMessage itself is no longer surfaced by the d4rt bridge, we declare a
// local shim with the same shape as the framework class and use it to render
// a richly-styled, multi-section walkthrough of the API.
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Local shim — KeyMessage not available in D4rt bridge (deprecated API).
// Mirrors the shape of `package:flutter/services` KeyMessage:
//   final List<KeyEvent> events;
//   final dynamic rawEvent; // platform-side raw event payload
class KeyMessage {
  final List<KeyEvent> events;
  final dynamic rawEvent;
  KeyMessage(this.events, this.rawEvent);
}

dynamic build(BuildContext context) {
  print('KeyMessage Deep Demo executing');

  // ============================================================
  // Themed palette — graphite + neon-cyan + amber
  // The color story: dark graphite for the keyboard chassis, neon-cyan for
  // electrical key signal flow, amber for hot/active emphasis.
  // ============================================================
  final graphite = Color(0xFF1F2933);
  final graphiteDark = Color(0xFF111720);
  final neonCyan = Color(0xFF00E5FF);
  final neonCyanDark = Color(0xFF00B8D4);
  final amber = Color(0xFFFFB300);
  final softWhite = Color(0xFFF5F7FA);

  // ============================================================
  // Reference KeyEvent samples — used throughout the demo
  // ============================================================
  final keyDown = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 100),
  );
  print('KeyDownEvent created: ${keyDown.runtimeType}');

  final keyRepeat = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 220),
  );
  print('KeyRepeatEvent created: ${keyRepeat.runtimeType}');

  final keyUp = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 380),
  );
  print('KeyUpEvent created: ${keyUp.runtimeType}');

  final message = KeyMessage([keyDown, keyRepeat, keyUp], null);
  print('KeyMessage created: ${message.runtimeType} '
      'with ${message.events.length} events');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [graphite, graphiteDark, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.45),
          blurRadius: 26.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: graphiteDark.withValues(alpha: 0.55),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
      border: Border.all(color: neonCyan.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard, size: 56.0, color: neonCyan),
            SizedBox(width: 14.0),
            Icon(Icons.electric_bolt, size: 52.0, color: amber),
            SizedBox(width: 14.0),
            Icon(Icons.message, size: 50.0, color: softWhite),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'KeyMessage',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Bundling KeyEvents on their journey from platform to focus',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: amber, width: 1.0),
              ),
              child: Text(
                'package:flutter/services.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: amber,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: neonCyan, width: 1.0),
              ),
              child: Text(
                '@Deprecated',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: neonCyan,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.0,
            ),
          ),
          child: Text(
            'final List<KeyEvent> events;\n'
            'final dynamic rawEvent;',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: softWhite,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // KeyMessage has a tiny shape — only two fields. We dramatize them and
  // include the related KeyEvent fields users will reach into.
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyData = [
    {
      'name': 'events',
      'type': 'List<KeyEvent>',
      'desc': 'One or more events delivered together from the platform',
      'icon': Icons.list_alt,
      'tag': 'KeyMessage',
    },
    {
      'name': 'rawEvent',
      'type': 'dynamic',
      'desc': 'Raw platform event (RawKeyEvent) — backwards-compat hook',
      'icon': Icons.memory,
      'tag': 'KeyMessage',
    },
    {
      'name': 'physicalKey',
      'type': 'PhysicalKeyboardKey',
      'desc': 'USB HID-style physical scan code (location on the keyboard)',
      'icon': Icons.location_on,
      'tag': 'KeyEvent',
    },
    {
      'name': 'logicalKey',
      'type': 'LogicalKeyboardKey',
      'desc': 'Layout-aware logical key (a, A, é, depending on layout)',
      'icon': Icons.text_fields,
      'tag': 'KeyEvent',
    },
    {
      'name': 'character',
      'type': 'String?',
      'desc': 'Produced character if any (text input value)',
      'icon': Icons.abc,
      'tag': 'KeyEvent',
    },
    {
      'name': 'timeStamp',
      'type': 'Duration',
      'desc': 'Monotonic time since engine startup',
      'icon': Icons.schedule,
      'tag': 'KeyEvent',
    },
    {
      'name': 'synthesized',
      'type': 'bool',
      'desc': 'true if the framework manufactured this event',
      'icon': Icons.auto_awesome,
      'tag': 'KeyEvent',
    },
    {
      'name': 'deviceType',
      'type': 'KeyboardDeviceType',
      'desc': 'Physical keyboard, on-screen, hid stylus, etc.',
      'icon': Icons.devices_other,
      'tag': 'KeyEvent',
    },
  ];

  final anatomyFields = <Widget>[];
  for (final field in anatomyData) {
    final tag = field['tag'] as String;
    final tagColor = tag == 'KeyMessage' ? neonCyan : amber;
    anatomyFields.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tagColor.withValues(alpha: 0.10),
              graphite.withValues(alpha: 0.04),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: tagColor.withValues(alpha: 0.45),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: tagColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                field['icon'] as IconData,
                color: tag == 'KeyMessage' ? neonCyanDark : amber,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        field['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: graphite,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: amber.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          field['type'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            color: graphite,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: tagColor.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: tagColor,
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9.0,
                            color: graphite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    field['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade700,
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
  print('Created ${anatomyFields.length} anatomy field rows');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.5),
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: neonCyanDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'KeyMessage / KeyEvent Anatomy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'KeyMessage has just two fields. The interesting payload lives '
          'inside each KeyEvent it carries.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...anatomyFields,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: KeyEvent Subtype Gallery
  // ============================================================
  print('=== Section 3: KeyEvent Subtype Gallery ===');

  final subtypeData = [
    {
      'name': 'KeyDownEvent',
      'icon': Icons.south,
      'color': neonCyan,
      'desc': 'A key was pressed (initial transition).',
      'detail': 'Fires once per physical press. Following events for the same '
          'key are KeyRepeatEvent until the matching KeyUpEvent.',
      'sample': keyDown,
    },
    {
      'name': 'KeyRepeatEvent',
      'icon': Icons.replay,
      'color': amber,
      'desc': 'OS-level auto-repeat while a key is held.',
      'detail': 'Cadence is decided by the platform (xkb, Win32, macOS HID). '
          'Treat the same as KeyDown for typing; ignore for shortcuts.',
      'sample': keyRepeat,
    },
    {
      'name': 'KeyUpEvent',
      'icon': Icons.north,
      'color': Color(0xFF80DEEA),
      'desc': 'A key was released (final transition).',
      'detail': 'Always paired with a prior KeyDownEvent for the same '
          'physicalKey. Use this for "release" gestures (push-to-talk).',
      'sample': keyUp,
    },
  ];

  final subtypeCards = <Widget>[];
  for (final s in subtypeData) {
    final color = s['color'] as Color;
    final sample = s['sample'] as KeyEvent;
    print(
      'Subtype ${s['name']}: physical=${sample.physicalKey.debugName} '
      'logical=${sample.logicalKey.debugName} ts=${sample.timeStamp}',
    );

    subtypeCards.add(
      Container(
        width: 270.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(s['icon'] as IconData, color: color, size: 28.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    s['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: graphite,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              s['desc'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: graphite,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              s['detail'] as String,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyValueRow(
                    'physicalKey',
                    sample.physicalKey.debugName ?? '?',
                    color,
                  ),
                  _buildKeyValueRow(
                    'logicalKey',
                    sample.logicalKey.debugName ?? '?',
                    color,
                  ),
                  _buildKeyValueRow(
                    'timeStamp',
                    '${sample.timeStamp.inMilliseconds} ms',
                    color,
                  ),
                  _buildKeyValueRow(
                    'synthesized',
                    '${sample.synthesized}',
                    color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${subtypeCards.length} subtype cards');

  // ============================================================
  // SECTION 4: Visual Keyboard with highlighted "A" key
  // We render a chunky mechanical keyboard graphic where the keys we touched
  // in the demo light up cyan to reinforce physicalKey vs logicalKey.
  // ============================================================
  print('=== Section 4: Visual Keyboard ===');

  final highlightedPhysical = {keyDown.physicalKey};
  final keyboardRows = <Widget>[
    _buildKeyboardRow(
      [
        _kk('Esc', PhysicalKeyboardKey.escape),
        _kk('1', PhysicalKeyboardKey.digit1),
        _kk('2', PhysicalKeyboardKey.digit2),
        _kk('3', PhysicalKeyboardKey.digit3),
        _kk('4', PhysicalKeyboardKey.digit4),
        _kk('5', PhysicalKeyboardKey.digit5),
        _kk('6', PhysicalKeyboardKey.digit6),
        _kk('7', PhysicalKeyboardKey.digit7),
        _kk('8', PhysicalKeyboardKey.digit8),
        _kk('9', PhysicalKeyboardKey.digit9),
        _kk('0', PhysicalKeyboardKey.digit0),
      ],
      highlightedPhysical,
      neonCyan,
      amber,
      graphite,
    ),
    _buildKeyboardRow(
      [
        _kk('Tab', PhysicalKeyboardKey.tab, width: 56.0),
        _kk('Q', PhysicalKeyboardKey.keyQ),
        _kk('W', PhysicalKeyboardKey.keyW),
        _kk('E', PhysicalKeyboardKey.keyE),
        _kk('R', PhysicalKeyboardKey.keyR),
        _kk('T', PhysicalKeyboardKey.keyT),
        _kk('Y', PhysicalKeyboardKey.keyY),
        _kk('U', PhysicalKeyboardKey.keyU),
        _kk('I', PhysicalKeyboardKey.keyI),
        _kk('O', PhysicalKeyboardKey.keyO),
        _kk('P', PhysicalKeyboardKey.keyP),
      ],
      highlightedPhysical,
      neonCyan,
      amber,
      graphite,
    ),
    _buildKeyboardRow(
      [
        _kk('Caps', PhysicalKeyboardKey.capsLock, width: 64.0),
        _kk('A', PhysicalKeyboardKey.keyA),
        _kk('S', PhysicalKeyboardKey.keyS),
        _kk('D', PhysicalKeyboardKey.keyD),
        _kk('F', PhysicalKeyboardKey.keyF),
        _kk('G', PhysicalKeyboardKey.keyG),
        _kk('H', PhysicalKeyboardKey.keyH),
        _kk('J', PhysicalKeyboardKey.keyJ),
        _kk('K', PhysicalKeyboardKey.keyK),
        _kk('L', PhysicalKeyboardKey.keyL),
        _kk('Enter', PhysicalKeyboardKey.enter, width: 70.0),
      ],
      highlightedPhysical,
      neonCyan,
      amber,
      graphite,
    ),
    _buildKeyboardRow(
      [
        _kk('Shift', PhysicalKeyboardKey.shiftLeft, width: 80.0),
        _kk('Z', PhysicalKeyboardKey.keyZ),
        _kk('X', PhysicalKeyboardKey.keyX),
        _kk('C', PhysicalKeyboardKey.keyC),
        _kk('V', PhysicalKeyboardKey.keyV),
        _kk('B', PhysicalKeyboardKey.keyB),
        _kk('N', PhysicalKeyboardKey.keyN),
        _kk('M', PhysicalKeyboardKey.keyM),
        _kk('Shift', PhysicalKeyboardKey.shiftRight, width: 100.0),
      ],
      highlightedPhysical,
      neonCyan,
      amber,
      graphite,
    ),
    _buildKeyboardRow(
      [
        _kk('Ctrl', PhysicalKeyboardKey.controlLeft, width: 60.0),
        _kk('Meta', PhysicalKeyboardKey.metaLeft, width: 60.0),
        _kk('Alt', PhysicalKeyboardKey.altLeft, width: 60.0),
        _kk('Space', PhysicalKeyboardKey.space, width: 220.0),
        _kk('Alt', PhysicalKeyboardKey.altRight, width: 60.0),
        _kk('Ctrl', PhysicalKeyboardKey.controlRight, width: 60.0),
      ],
      highlightedPhysical,
      neonCyan,
      amber,
      graphite,
    ),
  ];

  final keyboard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [graphite, graphiteDark],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.18),
          blurRadius: 30.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.3),
        width: 1.0,
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.keyboard, color: neonCyan, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  'Mechanical Reference',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: softWhite,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: neonCyan.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: neonCyan, width: 1.0),
              ),
              child: Text(
                'highlighted = physicalKey in events',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.0,
                  color: neonCyan,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...keyboardRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Lifecycle Timeline — Down -> Repeat... -> Up
  // ============================================================
  print('=== Section 5: Lifecycle Timeline ===');

  final timelineEvents = [
    {
      'event': 'KeyDownEvent',
      'time': '0 ms',
      'color': neonCyan,
      'icon': Icons.south,
      'note': 'User strikes the A key',
    },
    {
      'event': 'KeyRepeatEvent',
      'time': '~120 ms',
      'color': amber,
      'icon': Icons.replay,
      'note': 'OS auto-repeat begins',
    },
    {
      'event': 'KeyRepeatEvent',
      'time': '~200 ms',
      'color': amber,
      'icon': Icons.replay,
      'note': 'Repeat continues at platform cadence',
    },
    {
      'event': 'KeyRepeatEvent',
      'time': '~280 ms',
      'color': amber,
      'icon': Icons.replay,
      'note': 'Each repeat is its own KeyEvent',
    },
    {
      'event': 'KeyUpEvent',
      'time': '380 ms',
      'color': Color(0xFF80DEEA),
      'icon': Icons.north,
      'note': 'User releases — pair closed',
    },
  ];

  final timelineRows = <Widget>[];
  for (int i = 0; i < timelineEvents.length; i++) {
    final t = timelineEvents[i];
    final color = t['color'] as Color;
    final isLast = i == timelineEvents.length - 1;
    timelineRows.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.55),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      t['icon'] as IconData,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 3.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0.0 : 14.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.10),
                        Colors.white,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['event'] as String,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: graphite,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              t['note'] as String,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          t['time'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: color == amber
                                ? Color(0xFF8A6D00)
                                : graphite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${timelineRows.length} timeline rows');

  final timelineCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: neonCyanDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Single-key Lifecycle',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'A single press of "A" produces an entire stream of KeyEvents. '
          'KeyMessage may bundle several of them in a single platform delivery.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...timelineRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pipeline Diagram — Platform -> KeyEventManager -> Focus
  // ============================================================
  print('=== Section 6: Pipeline Diagram ===');

  final pipelineSteps = [
    {
      'title': 'Platform raw event',
      'desc': 'OS surfaces a raw key event '
          '(NSEvent / WM_KEY* / xkb_keysym).',
      'icon': Icons.public,
      'color': Color(0xFFB39DDB),
    },
    {
      'title': 'Engine encoding',
      'desc': 'Flutter engine normalizes to physical + logical keys.',
      'icon': Icons.transform,
      'color': neonCyan,
    },
    {
      'title': 'KeyMessage assembled',
      'desc': 'Engine wraps one-or-more KeyEvents + the original raw event.',
      'icon': Icons.inventory_2,
      'color': amber,
    },
    {
      'title': 'KeyEventManager dispatches',
      'desc': 'HardwareKeyboard / KeyEventManager forward the events to '
          'registered handlers.',
      'icon': Icons.alt_route,
      'color': Color(0xFF4DD0E1),
    },
    {
      'title': 'FocusManager routing',
      'desc': 'Events propagate through the FocusNode chain (focused widget '
          'first, walking ancestors).',
      'icon': Icons.center_focus_strong,
      'color': Color(0xFF66BB6A),
    },
    {
      'title': 'Shortcuts / handlers',
      'desc': 'Shortcuts, RawKeyboardListener, EditableText receive and '
          'optionally consume the event.',
      'icon': Icons.handshake,
      'color': Color(0xFFFF7043),
    },
  ];

  final pipelineCards = <Widget>[];
  for (int i = 0; i < pipelineSteps.length; i++) {
    final s = pipelineSteps[i];
    final color = s['color'] as Color;
    pipelineCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                shape: BoxShape.circle,
              ),
              child: Icon(s['icon'] as IconData, color: color, size: 22.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: graphite,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    s['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (i < pipelineSteps.length - 1) {
      pipelineCards.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.south, color: Colors.grey.shade400, size: 18.0),
            ],
          ),
        ),
      );
    }
  }
  print('Created ${pipelineCards.length} pipeline elements');

  final pipelineCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: graphite.withValues(alpha: 0.3),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: graphite, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'KeyEvent Pipeline',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'KeyMessage is the courier between platform and dispatcher. It '
          'never reaches user code directly under modern Flutter.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...pipelineCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Code Block — sample handler that consumes a KeyMessage
  // ============================================================
  print('=== Section 7: Code Block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.4),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.0),
            Icon(Icons.terminal, color: neonCyan, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'key_message_handler.dart',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeLine('// Custom dispatcher: examine every KeyMessage',
            Colors.grey.shade500),
        _buildCodeLine(
          'KeyEventManager manager = ServicesBinding.instance.keyEventManager;',
          Colors.cyan.shade300,
        ),
        _buildCodeLine(
          'manager.keyMessageHandler = (KeyMessage message) {',
          amber,
        ),
        _buildCodeLine(
          '  // 1. Optional: peek at the raw platform event',
          Colors.grey.shade500,
        ),
        _buildCodeLine(
          '  final raw = message.rawEvent; // dynamic / RawKeyEvent',
          Colors.white,
        ),
        _buildCodeLine(
          r"  print('rawEvent: ${raw.runtimeType}');",
          Colors.lightGreenAccent,
        ),
        _buildCodeLine('', Colors.white),
        _buildCodeLine(
          '  // 2. Walk the bundled KeyEvents',
          Colors.grey.shade500,
        ),
        _buildCodeLine(
          '  for (final KeyEvent ev in message.events) {',
          Colors.cyan.shade300,
        ),
        _buildCodeLine('    if (ev is KeyDownEvent) {', amber),
        _buildCodeLine(
          r"      print('down ${ev.logicalKey.debugName}');",
          Colors.lightGreenAccent,
        ),
        _buildCodeLine('    } else if (ev is KeyRepeatEvent) {', amber),
        _buildCodeLine(
          '      // ignore repeats for shortcuts',
          Colors.grey.shade500,
        ),
        _buildCodeLine('    } else if (ev is KeyUpEvent) {', amber),
        _buildCodeLine(
          r"      print('up   ${ev.logicalKey.debugName}');",
          Colors.lightGreenAccent,
        ),
        _buildCodeLine('    }', amber),
        _buildCodeLine('  }', Colors.cyan.shade300),
        _buildCodeLine('', Colors.white),
        _buildCodeLine(
          '  // 3. Returning false lets default routing continue.',
          Colors.grey.shade500,
        ),
        _buildCodeLine('  return false;', Colors.white),
        _buildCodeLine('};', amber),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Comparison Table — Old RawKeyEvent vs Modern KeyEvent vs
  // KeyMessage as the bridge between them.
  // ============================================================
  print('=== Section 8: Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: graphite, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Three Key APIs, Side-by-Side',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: graphite,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _buildTableHeader('Aspect', 100.0),
              _buildTableHeader('RawKeyEvent', 120.0),
              _buildTableHeader('KeyEvent', 110.0),
              _buildTableHeader('KeyMessage', 130.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildTableRow(
          'Status',
          'legacy',
          'current',
          'deprecated bridge',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
        _buildTableRow(
          'Per-event',
          'one event',
          'one event',
          'list of events',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
        _buildTableRow(
          'Raw payload',
          'baked-in',
          'unavailable',
          'rawEvent dynamic',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
        _buildTableRow(
          'Down/Up',
          'isKeyPressed flag',
          'subtype class',
          'subtypes inside list',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
        _buildTableRow(
          'Repeat',
          'platform-specific',
          'KeyRepeatEvent',
          'preserves repeats',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
        _buildTableRow(
          'Used by',
          'RawKeyboardListener',
          'HardwareKeyboard',
          'KeyEventManager',
          Color(0xFFB39DDB),
          neonCyan,
          amber,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Focus routing diagram — focused widget tree
  // ============================================================
  print('=== Section 9: Focus routing diagram ===');

  final focusNodes = [
    {
      'name': 'FocusScope (root)',
      'depth': 0,
      'role': 'top-level scope',
      'focused': false,
    },
    {
      'name': 'Shortcuts',
      'depth': 1,
      'role': 'maps physicalKey/logicalKey -> Intent',
      'focused': false,
    },
    {
      'name': 'Actions',
      'depth': 2,
      'role': 'maps Intent -> Action.invoke',
      'focused': false,
    },
    {
      'name': 'FocusTraversalGroup',
      'depth': 3,
      'role': 'tab order policy',
      'focused': false,
    },
    {
      'name': 'Focus(child: EditableText)',
      'depth': 4,
      'role': 'currently focused FocusNode',
      'focused': true,
    },
  ];

  final focusRows = <Widget>[];
  for (final n in focusNodes) {
    final depth = n['depth'] as int;
    final isFocused = n['focused'] as bool;
    final color = isFocused ? amber : neonCyan;
    focusRows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            SizedBox(width: depth * 22.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.10),
                    color.withValues(alpha: 0.30),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: color, width: isFocused ? 2.5 : 1.0),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.55),
                          blurRadius: 12.0,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFocused ? Icons.center_focus_strong : Icons.account_tree,
                    color: isFocused ? Color(0xFF8A6D00) : neonCyanDark,
                    size: 16.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    n['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight:
                          isFocused ? FontWeight.bold : FontWeight.normal,
                      color: graphite,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                n['role'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${focusRows.length} focus rows');

  final focusCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Color(0xFFE8F7FA)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: neonCyan, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: neonCyanDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Focus Routing After Dispatch',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Once KeyEventManager hands events to the FocusManager, the focused '
          'node receives them first; bubbling continues up the focus chain.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...focusRows,
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: amber.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amber, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.bolt, color: Color(0xFF8A6D00), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The amber-highlighted node is the focused one — it gets '
                  'the events from this KeyMessage first.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: graphite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun Cards
  // ============================================================
  print('=== Section 10: Footgun Cards ===');

  final footgunData = [
    {
      'title': 'KeyMessage is deprecated',
      'icon': Icons.history_toggle_off,
      'desc': 'New code should listen via HardwareKeyboard.instance or '
          'Shortcuts/Actions. KeyMessage exists only to keep the legacy '
          'RawKeyboard pipeline working alongside the modern KeyEvent API.',
    },
    {
      'title': 'rawEvent is dynamic',
      'icon': Icons.dangerous,
      'desc': 'rawEvent is RawKeyEvent? but typed dynamic for legacy reasons. '
          'Always null-check and prefer reading data from the events list — '
          'rawEvent will eventually go away.',
    },
    {
      'title': 'events.length can be > 1',
      'icon': Icons.format_list_numbered,
      'desc': 'A single platform delivery may unpack into multiple KeyEvents '
          '(e.g. dead-key composition). Iterate; never assume events.first is '
          'the only thing happening.',
    },
    {
      'title': 'physicalKey vs logicalKey',
      'icon': Icons.swap_horiz,
      'desc': 'physicalKey is location-based (USB HID); logicalKey reflects '
          'layout. Bind shortcuts to physicalKey for muscle memory, to '
          'logicalKey for typed-character semantics.',
    },
    {
      'title': 'Repeat events count',
      'icon': Icons.replay_circle_filled,
      'desc': 'KeyRepeatEvent fires repeatedly while a key is held. Filter '
          'them out for one-shot shortcuts; otherwise users will fire actions '
          '20 times by holding the key down for half a second.',
    },
    {
      'title': 'No setState in handlers',
      'icon': Icons.warning,
      'desc': 'KeyEventManager dispatch happens during the engine\'s native '
          'event tick. Schedule UI work via Element.markNeedsBuild or post a '
          'microtask — direct setState during handler is brittle.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final f in footgunData) {
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade50,
              Colors.orange.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.red.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade300, Colors.orange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Icon(
                f['icon'] as IconData,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: Colors.red.shade700,
                        size: 16.0,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          f['title'] as String,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    f['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
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
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Inline event dump — the actual reference KeyMessage
  // ============================================================
  print('=== Section 11: Inline event dump ===');

  final eventRows = <Widget>[];
  for (int i = 0; i < message.events.length; i++) {
    final ev = message.events[i];
    final color = ev is KeyDownEvent
        ? neonCyan
        : ev is KeyUpEvent
            ? Color(0xFF80DEEA)
            : amber;
    print(
      'event[$i] runtimeType=${ev.runtimeType} '
      'physical=${ev.physicalKey.debugName} '
      'logical=${ev.logicalKey.debugName} '
      'ts=${ev.timeStamp.inMilliseconds}ms',
    );

    eventRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              Colors.white,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
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
                    '${ev.runtimeType}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: graphite,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      _buildBadge(
                        'physical: ${ev.physicalKey.debugName ?? "?"}',
                        neonCyanDark,
                      ),
                      _buildBadge(
                        'logical: ${ev.logicalKey.debugName ?? "?"}',
                        amber,
                      ),
                      _buildBadge(
                        'ts: ${ev.timeStamp.inMilliseconds} ms',
                        Colors.grey.shade700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${eventRows.length} inline event rows');

  final eventDumpCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: neonCyanDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'KeyMessage.events (live)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: graphite,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: amber.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: amber, width: 1.0),
              ),
              child: Text(
                '${message.events.length} events',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8A6D00),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'rawEvent: ${message.rawEvent} (null in this synthetic example)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 12.0),
        ...eventRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Recap card
  // ============================================================
  print('=== Section 12: Recap card ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [graphite, graphiteDark, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: neonCyan.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
      border: Border.all(
        color: neonCyan.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: amber, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapLine(
          Icons.message,
          'KeyMessage bundles a list of KeyEvents plus the original raw '
          'platform event.',
        ),
        _buildRecapLine(
          Icons.layers,
          'KeyEvent has three concrete subtypes: KeyDownEvent, KeyRepeatEvent '
          'and KeyUpEvent.',
        ),
        _buildRecapLine(
          Icons.transform,
          'Created by KeyEventManager as the bridge between RawKeyboard and '
          'HardwareKeyboard.',
        ),
        _buildRecapLine(
          Icons.center_focus_strong,
          'Events propagate via the focus chain — focused widget first, then '
          'ancestors.',
        ),
        _buildRecapLine(
          Icons.history_toggle_off,
          'Deprecated: prefer HardwareKeyboard / Shortcuts / Actions for new '
          'code.',
        ),
        _buildRecapLine(
          Icons.replay,
          'Always handle KeyRepeatEvent explicitly (or filter it) for '
          'shortcuts.',
        ),
      ],
    ),
  );

  print('KeyMessage Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Title banner
          titleBanner,
          SizedBox(height: 28.0),

          // 2. Anatomy
          _sectionHeader('1. Anatomy', Icons.architecture, graphite),
          anatomyDiagram,
          SizedBox(height: 24.0),

          // 3. KeyEvent subtypes
          _sectionHeader('2. KeyEvent Subtypes', Icons.layers, graphite),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: subtypeCards,
          ),
          SizedBox(height: 24.0),

          // 4. Visual keyboard
          _sectionHeader(
            '3. Mechanical Reference',
            Icons.keyboard,
            graphite,
          ),
          SizedBox(height: 8.0),
          Center(child: keyboard),
          SizedBox(height: 24.0),

          // 5. Lifecycle timeline
          _sectionHeader(
            '4. Single-key Lifecycle',
            Icons.timeline,
            graphite,
          ),
          timelineCard,
          SizedBox(height: 24.0),

          // 6. Pipeline diagram
          _sectionHeader('5. Pipeline', Icons.alt_route, graphite),
          pipelineCard,
          SizedBox(height: 24.0),

          // 7. Code block
          _sectionHeader(
            '6. KeyMessage Handler',
            Icons.code,
            graphite,
          ),
          codeBlock,
          SizedBox(height: 24.0),

          // 8. Comparison table
          _sectionHeader('7. Comparison', Icons.compare, graphite),
          comparisonTable,
          SizedBox(height: 24.0),

          // 9. Focus routing
          _sectionHeader(
            '8. Focus Routing',
            Icons.account_tree,
            graphite,
          ),
          focusCard,
          SizedBox(height: 24.0),

          // 10. Footguns
          _sectionHeader(
            '9. Footguns',
            Icons.warning_amber,
            Colors.red.shade700,
          ),
          ...footgunCards,
          SizedBox(height: 24.0),

          // 11. Inline event dump
          _sectionHeader(
            '10. Live KeyMessage',
            Icons.list_alt,
            graphite,
          ),
          eventDumpCard,
          SizedBox(height: 24.0),

          // 12. Recap
          _sectionHeader('11. Recap', Icons.summarize, graphite),
          recapCard,
          SizedBox(height: 16.0),

          // Footer
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [graphite, graphiteDark],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: neonCyan, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'KeyMessage demo complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '(${message.runtimeType} / ${message.events.length} events)',
                  style: TextStyle(
                    color: amber,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
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
// Top-level helper functions
// ============================================================

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyValueRow(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeLine(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildTableHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildTableRow(
  String aspect,
  String raw,
  String key,
  String message,
  Color cRaw,
  Color cKey,
  Color cMessage,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            aspect,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        _buildTableCell(raw, 120.0, cRaw),
        _buildTableCell(key, 110.0, cKey),
        _buildTableCell(message, 130.0, cMessage),
      ],
    ),
  );
}

Widget _buildTableCell(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget _buildRecapLine(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFFFFB300), size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Compact key descriptor for the keyboard renderer.
Map<String, dynamic> _kk(
  String label,
  PhysicalKeyboardKey physical, {
  double width = 36.0,
}) {
  return {
    'label': label,
    'physical': physical,
    'width': width,
  };
}

Widget _buildKeyboardRow(
  List<Map<String, dynamic>> keys,
  Set<PhysicalKeyboardKey> highlighted,
  Color highlightColor,
  Color amber,
  Color graphite,
) {
  final widgets = <Widget>[];
  for (final k in keys) {
    final physical = k['physical'] as PhysicalKeyboardKey;
    final isHighlighted = highlighted.contains(physical);
    widgets.add(
      Container(
        width: k['width'] as double,
        height: 38.0,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isHighlighted
                ? [highlightColor.withValues(alpha: 0.85), highlightColor]
                : [
                    Color(0xFF37424B),
                    Color(0xFF22282F),
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: isHighlighted
                ? amber
                : Colors.white.withValues(alpha: 0.08),
            width: isHighlighted ? 1.8 : 1.0,
          ),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: highlightColor.withValues(alpha: 0.7),
                    blurRadius: 12.0,
                  ),
                  BoxShadow(
                    color: amber.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 1.0,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            k['label'] as String,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? graphite : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    ),
  );
}
