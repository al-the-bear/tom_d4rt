// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep Demo - KeyRepeatEvent from services
// Comprehensive demonstration of KeyRepeatEvent and its relationship
// to KeyDownEvent / KeyUpEvent inside the Flutter KeyEvent hierarchy.
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 1: DOSSIER DATA
  // What KeyRepeatEvent represents and why it is distinct from down/up.
  // ==========================================================================

  final dossierFacts = <Map<String, String>>[
    {
      'label': 'Class',
      'value': 'KeyRepeatEvent',
    },
    {
      'label': 'Library',
      'value': 'package:flutter/services.dart',
    },
    {
      'label': 'Extends',
      'value': 'KeyEvent',
    },
    {
      'label': 'Origin',
      'value': 'Synthesized by the OS while a key is held down',
    },
    {
      'label': 'Cadence',
      'value': 'After an initial delay, repeats at a system interval',
    },
    {
      'label': 'Siblings',
      'value': 'KeyDownEvent, KeyUpEvent',
    },
    {
      'label': 'Delivered by',
      'value': 'HardwareKeyboard / KeyboardListener / Focus',
    },
    {
      'label': 'Carries character?',
      'value': 'Yes, for printable keys; null otherwise',
    },
  ];

  // ==========================================================================
  // SECTION 2: ANATOMY DATA
  // Constructor params and inherited KeyEvent members.
  // ==========================================================================

  final anatomyRows = <Map<String, String>>[
    {
      'field': 'physicalKey',
      'type': 'PhysicalKeyboardKey',
      'note': 'Hardware location of the key on the board',
    },
    {
      'field': 'logicalKey',
      'type': 'LogicalKeyboardKey',
      'note': 'Semantic meaning after layout and modifiers',
    },
    {
      'field': 'character',
      'type': 'String?',
      'note': 'Printable character produced; null for non-text keys',
    },
    {
      'field': 'timeStamp',
      'type': 'Duration',
      'note': 'Engine timestamp from process start',
    },
    {
      'field': 'synthesized',
      'type': 'bool',
      'note': 'True when the framework injected the event itself',
    },
    {
      'field': 'deviceType',
      'type': 'KeyEventDeviceType',
      'note': 'Where the event came from (keyboard, gamepad, hdmi, etc.)',
    },
    {
      'field': 'runtimeType',
      'type': 'Type',
      'note': 'KeyRepeatEvent - distinguishes it from down/up siblings',
    },
  ];

  // ==========================================================================
  // SECTION 3: SYNTHESIZED EVENT LOG
  // Twelve+ KeyRepeatEvent instances across many keys.
  // ==========================================================================

  final repeatA1 = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 530),
  );
  final repeatA2 = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 560),
  );
  final repeatB = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyB,
    logicalKey: LogicalKeyboardKey.keyB,
    character: 'b',
    timeStamp: Duration(milliseconds: 612),
  );
  final repeatSpace = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.space,
    logicalKey: LogicalKeyboardKey.space,
    character: ' ',
    timeStamp: Duration(milliseconds: 740),
  );
  final repeatEnter = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.enter,
    logicalKey: LogicalKeyboardKey.enter,
    character: '\n',
    timeStamp: Duration(milliseconds: 820),
  );
  final repeatBackspace = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.backspace,
    logicalKey: LogicalKeyboardKey.backspace,
    timeStamp: Duration(milliseconds: 880),
  );
  final repeatArrowDown = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.arrowDown,
    logicalKey: LogicalKeyboardKey.arrowDown,
    timeStamp: Duration(milliseconds: 920),
  );
  final repeatArrowRight = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.arrowRight,
    logicalKey: LogicalKeyboardKey.arrowRight,
    timeStamp: Duration(milliseconds: 960),
  );
  final repeatShift = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.shiftLeft,
    logicalKey: LogicalKeyboardKey.shiftLeft,
    timeStamp: Duration(milliseconds: 1020),
  );
  final repeatDigit5 = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.digit5,
    logicalKey: LogicalKeyboardKey.digit5,
    character: '5',
    timeStamp: Duration(milliseconds: 1080),
  );
  final repeatF5 = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.f5,
    logicalKey: LogicalKeyboardKey.f5,
    timeStamp: Duration(milliseconds: 1140),
  );
  final repeatTab = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.tab,
    logicalKey: LogicalKeyboardKey.tab,
    character: '\t',
    timeStamp: Duration(milliseconds: 1200),
  );
  final repeatEscape = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.escape,
    logicalKey: LogicalKeyboardKey.escape,
    timeStamp: Duration(milliseconds: 1260),
  );

  final eventLog = <KeyRepeatEvent>[
    repeatA1,
    repeatA2,
    repeatB,
    repeatSpace,
    repeatEnter,
    repeatBackspace,
    repeatArrowDown,
    repeatArrowRight,
    repeatShift,
    repeatDigit5,
    repeatF5,
    repeatTab,
    repeatEscape,
  ];

  final eventLogRows = <Map<String, dynamic>>[];
  for (int i = 0; i < eventLog.length; i++) {
    final ev = eventLog[i];
    eventLogRows.add({
      'index': i + 1,
      'physical': ev.physicalKey.debugName ?? 'unknown',
      'logical': ev.logicalKey.debugName ?? 'unknown',
      'character': ev.character ?? '',
      'hasChar': ev.character != null,
      'timeStampMs': ev.timeStamp.inMilliseconds,
      'synthesized': ev.synthesized,
    });
  }

  // ==========================================================================
  // SECTION 4: HOLD-DOWN TIMELINE
  // Down -> Repeat x N -> Up, rendered as a row of pills.
  // ==========================================================================

  final timelineDown = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 0),
  );
  final timelineRepeats = <KeyRepeatEvent>[
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 500),
    ),
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 535),
    ),
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 570),
    ),
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 605),
    ),
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 640),
    ),
    KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      character: 'a',
      timeStamp: Duration(milliseconds: 675),
    ),
  ];
  final timelineUp = KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 710),
  );

  final timelinePills = <Map<String, dynamic>>[];
  timelinePills.add({
    'kind': 'DOWN',
    'ms': timelineDown.timeStamp.inMilliseconds,
    'color': 0xFF2E7D32,
    'label': 'Key A pressed',
  });
  for (int i = 0; i < timelineRepeats.length; i++) {
    timelinePills.add({
      'kind': 'REPEAT ${i + 1}',
      'ms': timelineRepeats[i].timeStamp.inMilliseconds,
      'color': 0xFFEF6C00,
      'label': 'OS repeat',
    });
  }
  timelinePills.add({
    'kind': 'UP',
    'ms': timelineUp.timeStamp.inMilliseconds,
    'color': 0xFFC62828,
    'label': 'Key A released',
  });

  // ==========================================================================
  // SECTION 5: SYNTHESIZED vs REAL
  // ==========================================================================

  final realRepeat = KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyZ,
    logicalKey: LogicalKeyboardKey.keyZ,
    character: 'z',
    timeStamp: Duration(milliseconds: 1500),
  );
  // KeyRepeatEvent constructor does not always expose `synthesized` as a
  // named parameter across Flutter versions; describe both states declaratively.
  final synthesizedRows = <Map<String, dynamic>>[
    {
      'label': 'Real OS-driven repeat',
      'synthesized': realRepeat.synthesized,
      'note': 'Produced by the platform when the key is held down',
    },
    {
      'label': 'Framework-synthesized repeat',
      'synthesized': true,
      'note': 'Injected by Flutter to keep HardwareKeyboard state consistent',
    },
  ];

  // ==========================================================================
  // SECTION 6: KeyEventDeviceType walk-through
  // ==========================================================================

  // KeyEventDeviceType is described statically because the enum is not always
  // re-exported from package:flutter/services.dart in every Flutter version.
  final deviceTypeRows = <Map<String, dynamic>>[
    {
      'name': 'keyboard',
      'index': 0,
      'hint': 'A traditional keyboard device.',
    },
    {
      'name': 'directionalPad',
      'index': 1,
      'hint': 'A directional pad, often on remote controls.',
    },
    {
      'name': 'gamepad',
      'index': 2,
      'hint': 'A game controller with key-like buttons.',
    },
    {
      'name': 'joystick',
      'index': 3,
      'hint': 'A joystick that reports key events for its buttons.',
    },
    {
      'name': 'hdmi',
      'index': 4,
      'hint': 'A device communicating over HDMI CEC.',
    },
  ];

  // ==========================================================================
  // SECTION 7: Composition / handler discussion data
  // ==========================================================================

  final compositionNotes = <String>[
    'HardwareKeyboard.instance.addHandler((KeyEvent ev) { ... return false; }) inspects every event.',
    'KeyboardListener wraps a child and forwards KeyEvent to its onKeyEvent callback.',
    'Focus(onKeyEvent: (node, ev) => KeyEventResult.handled) routes events through the focus tree.',
    'Inside the handler, switch on ev.runtimeType to distinguish KeyDownEvent / KeyRepeatEvent / KeyUpEvent.',
    'Treat KeyRepeatEvent like KeyDownEvent for typing actions but skip it for one-shot commands.',
    'For scroll/navigation, KeyRepeatEvent is the workhorse: it fires while the arrow is held.',
  ];

  // ==========================================================================
  // SECTION 8: Recipe cards
  // ==========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Detect held-down arrow scrolling',
      'body':
          'Listen for KeyRepeatEvent with logicalKey == LogicalKeyboardKey.arrowDown and scroll by one row each repeat.',
    },
    {
      'title': 'Auto-repeating backspace',
      'body':
          'Treat both KeyDownEvent and KeyRepeatEvent on backspace as "delete one char" to mirror native text fields.',
    },
    {
      'title': 'Type accelerator for digits',
      'body':
          'Use KeyRepeatEvent.character to insert characters; skip events whose character is null.',
    },
    {
      'title': 'Ignore repeats for shortcuts',
      'body':
          'Do not fire Ctrl+S twice while Enter is still held; only handle KeyDownEvent for shortcuts.',
    },
    {
      'title': 'Game movement loop',
      'body':
          'Track held direction using onKeyDown=add, onKeyUp=remove, onKeyRepeat=ignore, then poll per frame.',
    },
    {
      'title': 'Visualize repeat cadence',
      'body':
          'Capture timeStamp on each KeyRepeatEvent and plot deltas to inspect platform repeat intervals.',
    },
    {
      'title': 'Filter synthesized repeats',
      'body':
          'Guard with if (!event.synthesized) when measuring real user input cadence.',
    },
    {
      'title': 'Combine with modifiers',
      'body':
          'HardwareKeyboard.instance.isShiftPressed remains true across repeats, so check it inline.',
    },
  ];

  // ==========================================================================
  // SECTION 9: Comparison table
  // ==========================================================================

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Trigger',
      'down': 'Initial key press',
      'repeat': 'OS auto-repeat tick',
      'up': 'Key release',
    },
    {
      'aspect': 'Cardinality',
      'down': 'Exactly one',
      'repeat': 'Zero or more',
      'up': 'Exactly one',
    },
    {
      'aspect': 'character',
      'down': 'Usually set',
      'repeat': 'Usually set, mirrors down',
      'up': 'Often null',
    },
    {
      'aspect': 'Typical use',
      'down': 'Begin action',
      'repeat': 'Continue action',
      'up': 'End action',
    },
    {
      'aspect': 'Shortcuts',
      'down': 'Fire here',
      'repeat': 'Skip',
      'up': 'Skip',
    },
    {
      'aspect': 'Text input',
      'down': 'Insert char',
      'repeat': 'Insert char',
      'up': 'Nothing',
    },
    {
      'aspect': 'synthesized',
      'down': 'Possible',
      'repeat': 'Possible',
      'up': 'Possible',
    },
  ];

  // ==========================================================================
  // SECTION 10: Glossary
  // ==========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'KeyEvent',
      'def': 'Sealed superclass for all keyboard events in Flutter.',
    },
    {
      'term': 'KeyDownEvent',
      'def': 'Fires once when a key transitions from up to pressed.',
    },
    {
      'term': 'KeyRepeatEvent',
      'def': 'Fires while a key is held, after the initial delay.',
    },
    {
      'term': 'KeyUpEvent',
      'def': 'Fires when a key is released.',
    },
    {
      'term': 'PhysicalKeyboardKey',
      'def': 'Identifies the location of a key on the hardware.',
    },
    {
      'term': 'LogicalKeyboardKey',
      'def': 'Identifies the meaning of a key after layout mapping.',
    },
    {
      'term': 'HardwareKeyboard',
      'def': 'Singleton that exposes pressed keys and modifier state.',
    },
    {
      'term': 'KeyboardListener',
      'def': 'Widget that forwards KeyEvent to a callback when focused.',
    },
    {
      'term': 'Focus',
      'def': 'Widget that owns a FocusNode and routes key events.',
    },
    {
      'term': 'KeyEventDeviceType',
      'def': 'Enum describing the device that emitted the event.',
    },
    {
      'term': 'synthesized',
      'def': 'True when the framework, not the OS, produced the event.',
    },
  ];

  // ==========================================================================
  // BUILD UI
  // ==========================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4527A0), Color(0xFF6A1B9A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KeyRepeatEvent',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Deep Demo: held-down key events from package:flutter/services.dart',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFD1C4E9)),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Dossier • Anatomy • Timeline • Recipes • Glossary',
                    style: TextStyle(fontSize: 13.0, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 1: DOSSIER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Dossier',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4527A0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'What KeyRepeatEvent is, where it comes from, and how it differs from down/up.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                for (final fact in dossierFacts)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 140.0,
                          child: Text(
                            fact['label'] ?? '',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF311B92),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            fact['value'] ?? '',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 2: ANATOMY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF81C784), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. Anatomy',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Constructor parameters and inherited KeyEvent members.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Field',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                for (final row in anatomyRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC8E6C9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['field'] ?? '',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['type'] ?? '',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              row['note'] ?? '',
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 3: EVENT LOG =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFD54F), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3. Synthesized Event Log',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Thirteen KeyRepeatEvent instances rendered as cards.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                for (final row in eventLogRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE0B2),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFFFB74D),
                          width: 1.0,
                        ),
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
                                  color: Color(0xFFE65100),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${row['index']}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  '${row['physical']}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: (row['hasChar'] as bool)
                                      ? Color(0xFF388E3C)
                                      : Color(0xFF9E9E9E),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  (row['hasChar'] as bool)
                                      ? 'char "${row['character']}"'
                                      : 'no char',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'logical: ${row['logical']}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'monospace',
                                    color: Color(0xFF424242),
                                  ),
                                ),
                              ),
                              Text(
                                't = ${row['timeStampMs']} ms',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF424242),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'synthesized: ${row['synthesized']}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color(0xFF6D4C41),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 4: HOLD-DOWN TIMELINE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4. Hold-Down Timeline',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'KeyDownEvent -> KeyRepeatEvent x N -> KeyUpEvent for the key "A".',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final pill in timelinePills)
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(pill['color'] as int),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  pill['kind'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '${pill['ms']} ms',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFF424242),
                                ),
                              ),
                              SizedBox(height: 2.0),
                              SizedBox(
                                width: 60.0,
                                child: Text(
                                  pill['label'] as String,
                                  style: TextStyle(
                                    fontSize: 9.0,
                                    color: Color(0xFF616161),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFBBDEFB),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cadence observation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Initial delay: ${timelineRepeats.first.timeStamp.inMilliseconds - timelineDown.timeStamp.inMilliseconds} ms',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      Text(
                        'Repeat interval: ~${timelineRepeats[1].timeStamp.inMilliseconds - timelineRepeats[0].timeStamp.inMilliseconds} ms',
                        style: TextStyle(fontSize: 11.0),
                      ),
                      Text(
                        'Repeat count before release: ${timelineRepeats.length}',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 5: SYNTHESIZED vs REAL =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFF06292), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5. synthesized vs real',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAD1457),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'A synthesized repeat is one Flutter injects to keep its keyboard state consistent.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                for (final row in synthesizedRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8BBD0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: (row['synthesized'] as bool)
                                  ? Color(0xFF8E24AA)
                                  : Color(0xFF388E3C),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              (row['synthesized'] as bool) ? 'SYNTH' : 'REAL',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  row['label'] as String,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  row['note'] as String,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 6: DEVICE TYPES =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF4DB6AC), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '6. KeyEventDeviceType',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Where the event originated.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                for (final dt in deviceTypeRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFB2DFDB),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF00897B),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${dt['index']}',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          SizedBox(
                            width: 90.0,
                            child: Text(
                              dt['name'] as String,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              dt['hint'] as String,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 7: COMPOSITION =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFA1887F), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7. Composition / handler patterns',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'How KeyRepeatEvent flows into your widget tree.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                for (int i = 0; i < compositionNotes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22.0,
                          height: 22.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF6D4C41),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            compositionNotes[i],
                            style: TextStyle(fontSize: 12.0, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 8: RECIPES =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '8. Recipe cards',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
                SizedBox(height: 12.0),
                for (final recipe in recipes)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE1BEE7),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFFBA68C8),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe['title'] ?? '',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A148C),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            recipe['body'] ?? '',
                            style: TextStyle(fontSize: 11.5, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 9: COMPARISON TABLE =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF7986CB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '9. Down / Repeat / Up comparison',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF283593),
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Aspect',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'KeyDown',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'KeyRepeat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'KeyUp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          color: Color(0xFFC62828),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                for (final row in comparisonRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5CAE9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['aspect'] ?? '',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['down'] ?? '',
                              style: TextStyle(fontSize: 10.5),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['repeat'] ?? '',
                              style: TextStyle(fontSize: 10.5),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              row['up'] ?? '',
                              style: TextStyle(fontSize: 10.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== SECTION 10: GLOSSARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10. Glossary',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 12.0),
                for (final entry in glossary)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF37474F),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 140.0,
                            child: Text(
                              entry['term'] ?? '',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                color: Color(0xFF80CBC4),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry['def'] ?? '',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Color(0xFFCFD8DC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ===== SECTION 11: FINAL SUMMARY =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4527A0), Color(0xFFAD1457)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'KeyRepeatEvent extends KeyEvent and is delivered while a key is held. '
                  'It carries the same physicalKey, logicalKey and (usually) character '
                  'as the corresponding KeyDownEvent, but it can fire many times in a row '
                  'between the down and the up events.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFFFFFFFF),
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Events synthesized',
                              style: TextStyle(
                                color: Color(0xFFE1BEE7),
                                fontSize: 11.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${eventLog.length + timelineRepeats.length + 2}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sections',
                              style: TextStyle(
                                color: Color(0xFFE1BEE7),
                                fontSize: 11.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '11',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Color(0xFFE1BEE7),
                                fontSize: 11.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 12.0),

          // ===== FOOTER =====
          Center(
            child: Text(
              'Deep Demo • KeyRepeatEvent • package:flutter/services.dart',
              style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

