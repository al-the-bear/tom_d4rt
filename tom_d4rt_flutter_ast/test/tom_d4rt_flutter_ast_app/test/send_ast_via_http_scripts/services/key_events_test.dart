// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Keyboard Event Telemetry from services
// Comprehensive visual demonstration of Flutter keyboard event types,
// HardwareKeyboard service, LogicalKeyboardKey, PhysicalKeyboardKey,
// KeyEvent hierarchy, Focus + onKeyEvent, KeyEventResult enum, and the
// Shortcuts/Actions/Intents architecture.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // PALETTE & CONSTANTS
  // ============================================================================
  const Color kBg = Color(0xFF0E1116);
  const Color kCardBg = Color(0xFF1A1F27);
  const Color kCardBg2 = Color(0xFF222933);
  const Color kAccent = Color(0xFF7E57C2);
  const Color kAccent2 = Color(0xFF26A69A);
  const Color kAccent3 = Color(0xFFFFCA28);
  const Color kAccent4 = Color(0xFFEF5350);
  const Color kAccent5 = Color(0xFF42A5F5);
  const Color kAccent6 = Color(0xFF66BB6A);
  const Color kAccent7 = Color(0xFFEC407A);
  const Color kAccent8 = Color(0xFFFFA726);
  const Color kText = Color(0xFFE6EAF2);
  const Color kTextMuted = Color(0xFFA0AAB8);

  // ============================================================================
  // SECTION 1: LOGICAL KEYBOARD KEY INVENTORY
  // ============================================================================
  final logicalLetters = <Map<String, dynamic>>[
    {'name': 'keyA', 'key': LogicalKeyboardKey.keyA},
    {'name': 'keyB', 'key': LogicalKeyboardKey.keyB},
    {'name': 'keyC', 'key': LogicalKeyboardKey.keyC},
    {'name': 'keyD', 'key': LogicalKeyboardKey.keyD},
    {'name': 'keyE', 'key': LogicalKeyboardKey.keyE},
    {'name': 'keyF', 'key': LogicalKeyboardKey.keyF},
    {'name': 'keyG', 'key': LogicalKeyboardKey.keyG},
    {'name': 'keyH', 'key': LogicalKeyboardKey.keyH},
    {'name': 'keyS', 'key': LogicalKeyboardKey.keyS},
    {'name': 'keyZ', 'key': LogicalKeyboardKey.keyZ},
  ];

  final logicalControl = <Map<String, dynamic>>[
    {'name': 'space', 'key': LogicalKeyboardKey.space},
    {'name': 'enter', 'key': LogicalKeyboardKey.enter},
    {'name': 'escape', 'key': LogicalKeyboardKey.escape},
    {'name': 'tab', 'key': LogicalKeyboardKey.tab},
    {'name': 'backspace', 'key': LogicalKeyboardKey.backspace},
    {'name': 'delete', 'key': LogicalKeyboardKey.delete},
    {'name': 'home', 'key': LogicalKeyboardKey.home},
    {'name': 'end', 'key': LogicalKeyboardKey.end},
    {'name': 'pageUp', 'key': LogicalKeyboardKey.pageUp},
    {'name': 'pageDown', 'key': LogicalKeyboardKey.pageDown},
  ];

  final logicalArrows = <Map<String, dynamic>>[
    {'name': 'arrowUp', 'key': LogicalKeyboardKey.arrowUp, 'glyph': '↑'},
    {'name': 'arrowDown', 'key': LogicalKeyboardKey.arrowDown, 'glyph': '↓'},
    {'name': 'arrowLeft', 'key': LogicalKeyboardKey.arrowLeft, 'glyph': '←'},
    {'name': 'arrowRight', 'key': LogicalKeyboardKey.arrowRight, 'glyph': '→'},
  ];

  final logicalModifiers = <Map<String, dynamic>>[
    {'name': 'shiftLeft', 'key': LogicalKeyboardKey.shiftLeft},
    {'name': 'shiftRight', 'key': LogicalKeyboardKey.shiftRight},
    {'name': 'controlLeft', 'key': LogicalKeyboardKey.controlLeft},
    {'name': 'controlRight', 'key': LogicalKeyboardKey.controlRight},
    {'name': 'altLeft', 'key': LogicalKeyboardKey.altLeft},
    {'name': 'altRight', 'key': LogicalKeyboardKey.altRight},
    {'name': 'metaLeft', 'key': LogicalKeyboardKey.metaLeft},
    {'name': 'metaRight', 'key': LogicalKeyboardKey.metaRight},
  ];

  final logicalFunction = <Map<String, dynamic>>[
    {'name': 'f1', 'key': LogicalKeyboardKey.f1},
    {'name': 'f2', 'key': LogicalKeyboardKey.f2},
    {'name': 'f3', 'key': LogicalKeyboardKey.f3},
    {'name': 'f4', 'key': LogicalKeyboardKey.f4},
    {'name': 'f5', 'key': LogicalKeyboardKey.f5},
    {'name': 'f6', 'key': LogicalKeyboardKey.f6},
    {'name': 'f11', 'key': LogicalKeyboardKey.f11},
    {'name': 'f12', 'key': LogicalKeyboardKey.f12},
  ];

  // ============================================================================
  // SECTION 2: PHYSICAL KEYBOARD KEY (USB HID)
  // ============================================================================
  final physicalKeys = <Map<String, dynamic>>[
    {'name': 'keyA', 'key': PhysicalKeyboardKey.keyA, 'usage': 0x00070004},
    {'name': 'keyS', 'key': PhysicalKeyboardKey.keyS, 'usage': 0x00070016},
    {'name': 'keyZ', 'key': PhysicalKeyboardKey.keyZ, 'usage': 0x0007001d},
    {'name': 'enter', 'key': PhysicalKeyboardKey.enter, 'usage': 0x00070028},
    {'name': 'escape', 'key': PhysicalKeyboardKey.escape, 'usage': 0x00070029},
    {'name': 'space', 'key': PhysicalKeyboardKey.space, 'usage': 0x0007002c},
    {'name': 'tab', 'key': PhysicalKeyboardKey.tab, 'usage': 0x0007002b},
    {
      'name': 'arrowUp',
      'key': PhysicalKeyboardKey.arrowUp,
      'usage': 0x00070052,
    },
    {
      'name': 'arrowDown',
      'key': PhysicalKeyboardKey.arrowDown,
      'usage': 0x00070051,
    },
    {
      'name': 'shiftLeft',
      'key': PhysicalKeyboardKey.shiftLeft,
      'usage': 0x000700e1,
    },
    {
      'name': 'controlLeft',
      'key': PhysicalKeyboardKey.controlLeft,
      'usage': 0x000700e0,
    },
    {
      'name': 'altLeft',
      'key': PhysicalKeyboardKey.altLeft,
      'usage': 0x000700e2,
    },
  ];

  // ============================================================================
  // SECTION 3: KEY EVENT HIERARCHY (Static Records)
  // ============================================================================
  final keyEventTypes = <Map<String, dynamic>>[
    {
      'type': 'KeyEvent',
      'role': 'Abstract base for all modern keyboard events',
      'concrete': false,
      'color': kAccent,
    },
    {
      'type': 'KeyDownEvent',
      'role': 'Sent when a key is initially pressed',
      'concrete': true,
      'color': kAccent6,
    },
    {
      'type': 'KeyUpEvent',
      'role': 'Sent when a key is released',
      'concrete': true,
      'color': kAccent4,
    },
    {
      'type': 'KeyRepeatEvent',
      'role': 'Sent while a key is held (OS repeat rate)',
      'concrete': true,
      'color': kAccent3,
    },
  ];

  // Static event "records" — capturing what fields each event exposes.
  final eventRecords = <Map<String, dynamic>>[
    {
      'kind': 'KeyDownEvent',
      'physical': 'keyS',
      'logical': 'keyS',
      'character': 's',
      'timeStamp': '12.345s',
      'synthesized': false,
      'color': kAccent6,
    },
    {
      'kind': 'KeyRepeatEvent',
      'physical': 'keyS',
      'logical': 'keyS',
      'character': 's',
      'timeStamp': '12.612s',
      'synthesized': false,
      'color': kAccent3,
    },
    {
      'kind': 'KeyUpEvent',
      'physical': 'keyS',
      'logical': 'keyS',
      'character': null,
      'timeStamp': '12.844s',
      'synthesized': false,
      'color': kAccent4,
    },
    {
      'kind': 'KeyDownEvent',
      'physical': 'shiftLeft',
      'logical': 'shiftLeft',
      'character': null,
      'timeStamp': '13.001s',
      'synthesized': false,
      'color': kAccent6,
    },
    {
      'kind': 'KeyDownEvent',
      'physical': 'keyA',
      'logical': 'keyA',
      'character': 'A',
      'timeStamp': '13.110s',
      'synthesized': false,
      'color': kAccent6,
    },
    {
      'kind': 'KeyUpEvent',
      'physical': 'keyA',
      'logical': 'keyA',
      'character': null,
      'timeStamp': '13.220s',
      'synthesized': false,
      'color': kAccent4,
    },
    {
      'kind': 'KeyUpEvent',
      'physical': 'shiftLeft',
      'logical': 'shiftLeft',
      'character': null,
      'timeStamp': '13.380s',
      'synthesized': false,
      'color': kAccent4,
    },
  ];

  // ============================================================================
  // SECTION 4: HARDWARE KEYBOARD SERVICE
  // ============================================================================
  final hwKeyboard = HardwareKeyboard.instance;
  final hwSnapshot = <Map<String, String>>[
    {'field': 'instance', 'value': hwKeyboard.toString()},
    {
      'field': 'physicalKeysPressed',
      'value': hwKeyboard.physicalKeysPressed.toString(),
    },
    {
      'field': 'logicalKeysPressed',
      'value': hwKeyboard.logicalKeysPressed.toString(),
    },
    {
      'field': 'lockModesEnabled',
      'value': hwKeyboard.lockModesEnabled.toString(),
    },
  ];

  // ============================================================================
  // SECTION 5: KEY SETS & ACTIVATORS
  // ============================================================================
  final ctrlC = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  final ctrlShiftS = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyS,
  );
  final altF4 = LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.f4,
  );

  final saveActivator = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
  );
  final saveAsActivator = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
    shift: true,
    includeRepeats: false,
  );
  final escActivator = SingleActivator(LogicalKeyboardKey.escape);
  final qmarkActivator = CharacterActivator('?');
  final slashActivator = CharacterActivator('/');

  final activatorRecords = <Map<String, dynamic>>[
    {
      'name': 'Ctrl+S (Save)',
      'trigger': saveActivator.trigger.keyLabel,
      'control': saveActivator.control,
      'shift': saveActivator.shift,
      'alt': saveActivator.alt,
      'meta': saveActivator.meta,
      'repeats': saveActivator.includeRepeats,
    },
    {
      'name': 'Ctrl+Shift+S (Save As)',
      'trigger': saveAsActivator.trigger.keyLabel,
      'control': saveAsActivator.control,
      'shift': saveAsActivator.shift,
      'alt': saveAsActivator.alt,
      'meta': saveAsActivator.meta,
      'repeats': saveAsActivator.includeRepeats,
    },
    {
      'name': 'Escape',
      'trigger': escActivator.trigger.keyLabel,
      'control': escActivator.control,
      'shift': escActivator.shift,
      'alt': escActivator.alt,
      'meta': escActivator.meta,
      'repeats': escActivator.includeRepeats,
    },
  ];

  // ============================================================================
  // SECTION 6: KEY EVENT RESULT ENUM
  // ============================================================================
  final keyEventResults = <Map<String, dynamic>>[
    {
      'name': 'handled',
      'value': KeyEventResult.handled,
      'index': KeyEventResult.handled.index,
      'desc': 'The event was consumed; do not propagate further.',
      'color': kAccent6,
    },
    {
      'name': 'ignored',
      'value': KeyEventResult.ignored,
      'index': KeyEventResult.ignored.index,
      'desc': 'The handler did not act; framework keeps searching.',
      'color': kAccent3,
    },
    {
      'name': 'skipRemainingHandlers',
      'value': KeyEventResult.skipRemainingHandlers,
      'index': KeyEventResult.skipRemainingHandlers.index,
      'desc': 'Stop sibling handlers, continue up the focus tree.',
      'color': kAccent5,
    },
  ];

  // ============================================================================
  // SECTION 7: INTENT VOCABULARY
  // ============================================================================
  final intentRecords = <Map<String, dynamic>>[
    {
      'name': 'DismissIntent',
      'instance': DismissIntent().toString(),
      'purpose': 'Close the topmost dismissible surface (dialog/sheet).',
    },
    {
      'name': 'ActivateIntent',
      'instance': ActivateIntent().toString(),
      'purpose': 'Activate the focused widget (button, switch, list tile).',
    },
    {
      'name': 'ScrollIntent.down',
      'instance':
          ScrollIntent(direction: AxisDirection.down).toString(),
      'purpose': 'Request a scroll in the given direction.',
    },
    {
      'name': 'ScrollIntent.up',
      'instance':
          ScrollIntent(direction: AxisDirection.up).toString(),
      'purpose': 'Request an upward scroll.',
    },
  ];

  // ============================================================================
  // SECTION 8: STATE MACHINE TRANSITIONS
  // ============================================================================
  final stateMachine = <Map<String, dynamic>>[
    {
      'from': 'IDLE',
      'event': 'physical key pressed',
      'to': 'DOWN',
      'emit': 'KeyDownEvent',
      'color': kAccent6,
    },
    {
      'from': 'DOWN',
      'event': 'OS repeat tick',
      'to': 'DOWN (held)',
      'emit': 'KeyRepeatEvent',
      'color': kAccent3,
    },
    {
      'from': 'DOWN',
      'event': 'physical key released',
      'to': 'IDLE',
      'emit': 'KeyUpEvent',
      'color': kAccent4,
    },
    {
      'from': 'DOWN',
      'event': 'window loses focus',
      'to': 'IDLE',
      'emit': 'synthesized KeyUpEvent',
      'color': kAccent7,
    },
  ];

  // ============================================================================
  // SECTION 9: LEGACY RAW KEY EVENT NOTES
  // ============================================================================
  final legacyComparison = <Map<String, dynamic>>[
    {
      'aspect': 'Class hierarchy',
      'modern': 'KeyEvent → Down/Up/Repeat',
      'legacy': 'RawKeyEvent → RawKeyDownEvent / RawKeyUpEvent',
    },
    {
      'aspect': 'Repeat detection',
      'modern': 'Dedicated KeyRepeatEvent',
      'legacy': 'isRepeat boolean on RawKeyDownEvent',
    },
    {
      'aspect': 'Platform parity',
      'modern': 'Unified across embedders',
      'legacy': 'Platform-specific RawKeyEventDataXxx payload',
    },
    {
      'aspect': 'Listener widget',
      'modern': 'KeyboardListener / Focus.onKeyEvent',
      'legacy': 'RawKeyboardListener / Focus.onKey',
    },
    {
      'aspect': 'Status',
      'modern': 'Recommended',
      'legacy': 'Deprecated — kept for compatibility',
    },
  ];

  // ============================================================================
  // SECTION 10: SHORTCUTS / ACTIONS RECIPES
  // ============================================================================
  final recipes = <Map<String, dynamic>>[
    {
      'title': 'Cmd/Ctrl + S — Save document',
      'activator': 'SingleActivator(keyS, control: true)',
      'intent': 'DismissIntent (placeholder for SaveIntent)',
      'action': 'CallbackAction<DismissIntent> → flush to disk',
      'color': kAccent5,
    },
    {
      'title': 'Escape — Close dialog',
      'activator': 'SingleActivator(escape)',
      'intent': 'DismissIntent',
      'action': 'CallbackAction<DismissIntent> → Navigator.maybePop',
      'color': kAccent4,
    },
    {
      'title': 'Enter — Activate focused control',
      'activator': 'SingleActivator(enter)',
      'intent': 'ActivateIntent',
      'action': 'Default ButtonActivateAction',
      'color': kAccent6,
    },
    {
      'title': 'Arrow keys — Navigate list',
      'activator': 'SingleActivator(arrowDown/up)',
      'intent': 'ScrollIntent(direction: ...)',
      'action': 'PrimaryScrollController scroll-by-step',
      'color': kAccent2,
    },
    {
      'title': '? — Open help',
      'activator': 'CharacterActivator("?")',
      'intent': 'DismissIntent (placeholder for HelpIntent)',
      'action': 'CallbackAction → showHelpOverlay()',
      'color': kAccent8,
    },
    {
      'title': '/ — Focus search',
      'activator': 'CharacterActivator("/")',
      'intent': 'DismissIntent (placeholder for SearchIntent)',
      'action': 'CallbackAction → requestFocus(searchNode)',
      'color': kAccent7,
    },
  ];

  // ============================================================================
  // SECTION 11: FOCUS / KEYBOARD LISTENER (Static demo)
  // ============================================================================
  final focusDemoNode = FocusNode(debugLabel: 'demo-focus');
  final keyboardListenerNode = FocusNode(debugLabel: 'kb-listener');

  // ============================================================================
  // SECTION 12: BUILT-IN LIVE SHORTCUTS PLACEHOLDER
  // ============================================================================
  final shortcutsDemo = Shortcuts(
    shortcuts: <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.arrowDown):
          ScrollIntent(direction: AxisDirection.down),
      SingleActivator(LogicalKeyboardKey.arrowUp):
          ScrollIntent(direction: AxisDirection.up),
    },
    child: Actions(
      actions: <Type, Action<Intent>>{
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => null,
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) => null,
        ),
      },
      child: Focus(
        focusNode: focusDemoNode,
        canRequestFocus: true,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kCardBg2,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kAccent5, width: 1.0),
          ),
          child: Text(
            'Shortcuts → Actions → Focus (live wiring placeholder)',
            style: TextStyle(color: kText, fontSize: 13.0),
          ),
        ),
      ),
    ),
  );

  // ============================================================================
  // BUILD WIDGET TREE
  // ============================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== HERO =====
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF311B92), Color(0xFF1A237E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '⌨',
                          style: TextStyle(
                            color: kText,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Keyboard Event Telemetry',
                              style: TextStyle(
                                color: kText,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'A static atlas of Flutter key event types, '
                              'modifier maps, shortcut graphs, and intent '
                              'plumbing — rendered without StatefulWidget.',
                              style: TextStyle(
                                color: Color(0xFFC5CAE9),
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _heroChip('package:flutter/services.dart', kAccent),
                      _heroChip('HardwareKeyboard', kAccent2),
                      _heroChip('KeyEvent hierarchy', kAccent3),
                      _heroChip('Shortcuts + Intents', kAccent5),
                      _heroChip('LogicalKeyboardKey', kAccent6),
                      _heroChip('PhysicalKeyboardKey', kAccent7),
                    ],
                  ),
                ],
              ),
            ),

            // ===== CONCEPT OVERVIEW =====
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFF2A313D)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Concept Overview',
                      style: TextStyle(
                        color: kText,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Flutter abstracts keyboard input into TWO key '
                      'identities for every keystroke: the PHYSICAL key '
                      '(a fixed location on the hardware, identified by '
                      'USB HID usage code) and the LOGICAL key (what the '
                      'OS / keymap says the key means — affected by '
                      'layout, language, modifiers). The HardwareKeyboard '
                      'singleton tracks the live set of pressed keys, '
                      'and dispatches KeyEvent subclasses (Down / Up / '
                      'Repeat). The legacy RawKeyEvent path still exists '
                      'for backwards compatibility but is deprecated. '
                      'Above all of this sits the Shortcuts → Actions → '
                      'Intents architecture, which converts key chords '
                      'into typed Intent objects routed to the focused '
                      'subtree.',
                      style: TextStyle(
                        color: kTextMuted,
                        fontSize: 13.0,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== SECTION 1: LOGICAL KEY INVENTORY =====
            _sectionBanner(
              1,
              'LogicalKeyboardKey Inventory',
              'Letters, controls, arrows, modifiers, function row.',
              kAccent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _keyGroupCard('Letters', logicalLetters, kAccent6),
                  SizedBox(height: 12.0),
                  _keyGroupCard('Control keys', logicalControl, kAccent5),
                  SizedBox(height: 12.0),
                  _arrowsCard(logicalArrows, kAccent2),
                  SizedBox(height: 12.0),
                  _keyGroupCard('Modifiers', logicalModifiers, kAccent7),
                  SizedBox(height: 12.0),
                  _keyGroupCard('Function row', logicalFunction, kAccent3),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 2: PHYSICAL KEYS =====
            _sectionBanner(
              2,
              'PhysicalKeyboardKey · USB HID Usage Codes',
              'Hardware-location identifiers; layout-independent.',
              kAccent2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent2.withOpacity(0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Name',
                            style: TextStyle(
                              color: kAccent2,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'usbHidUsage (hex)',
                            style: TextStyle(
                              color: kAccent2,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'debugName',
                            style: TextStyle(
                              color: kAccent2,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Color(0xFF2A313D)),
                    for (final pk in physicalKeys)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                pk['name'] as String,
                                style: TextStyle(
                                  color: kText,
                                  fontSize: 12.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                '0x' +
                                    (pk['usage'] as int)
                                        .toRadixString(16)
                                        .padLeft(8, '0'),
                                style: TextStyle(
                                  color: kAccent3,
                                  fontSize: 12.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                (pk['key'] as PhysicalKeyboardKey)
                                    .debugName
                                    .toString(),
                                style: TextStyle(
                                  color: kTextMuted,
                                  fontSize: 11.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 3: KEY EVENT HIERARCHY =====
            _sectionBanner(
              3,
              'KeyEvent Class Hierarchy',
              'Abstract base + three concrete subclasses.',
              kAccent3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (final ev in keyEventTypes)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: kCardBg,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: (ev['color'] as Color).withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: ev['color'] as Color,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        ev['type'] as String,
                                        style: TextStyle(
                                          color: kText,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 2.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (ev['color'] as Color)
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Text(
                                          (ev['concrete'] as bool)
                                              ? 'concrete'
                                              : 'abstract',
                                          style: TextStyle(
                                            color: ev['color'] as Color,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    ev['role'] as String,
                                    style: TextStyle(
                                      color: kTextMuted,
                                      fontSize: 12.0,
                                    ),
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

            // ===== SECTION 4: EVENT STREAM RECORDS =====
            _sectionBanner(
              4,
              'Synthetic Event Stream',
              'A scripted sequence: type "sA" with Shift held.',
              kAccent4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg2,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < eventRecords.length; i++)
                      _eventCard(i, eventRecords[i]),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 5: STATE MACHINE =====
            _sectionBanner(
              5,
              'Key State Machine',
              'How transitions emit Down / Repeat / Up events.',
              kAccent5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent5.withOpacity(0.35)),
                ),
                child: Column(
                  children: [
                    for (final t in stateMachine)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            _stateNode(t['from'] as String, kAccent5),
                            _arrow(),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    t['event'] as String,
                                    style: TextStyle(
                                      color: kText,
                                      fontSize: 11.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 2.0),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (t['color'] as Color)
                                          .withOpacity(0.25),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      'emit: ${t['emit']}',
                                      style: TextStyle(
                                        color: t['color'] as Color,
                                        fontSize: 10.0,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _arrow(),
                            _stateNode(t['to'] as String, kAccent6),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 6: HARDWARE KEYBOARD =====
            _sectionBanner(
              6,
              'HardwareKeyboard Service',
              'Singleton snapshot — live pressed-key registry.',
              kAccent6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HardwareKeyboard.instance',
                      style: TextStyle(
                        color: kText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 12.0),
                    for (final row in hwSnapshot)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0x33000000),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                row['field']!,
                                style: TextStyle(
                                  color: kAccent3,
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                row['value']!,
                                style: TextStyle(
                                  color: kText,
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 7: LEGACY COMPARISON =====
            _sectionBanner(
              7,
              'Modern KeyEvent vs Legacy RawKeyEvent',
              'Why the new API replaced the raw event tree.',
              kAccent7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent7.withOpacity(0.35)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _thCell('Aspect', kAccent7),
                        ),
                        Expanded(
                          flex: 3,
                          child: _thCell('Modern (KeyEvent)', kAccent6),
                        ),
                        Expanded(
                          flex: 3,
                          child: _thCell('Legacy (RawKeyEvent)', kAccent4),
                        ),
                      ],
                    ),
                    Divider(color: Color(0xFF2A313D)),
                    for (final row in legacyComparison)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                row['aspect'] as String,
                                style: TextStyle(
                                  color: kText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                row['modern'] as String,
                                style: TextStyle(
                                  color: kAccent6,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                row['legacy'] as String,
                                style: TextStyle(
                                  color: kAccent4,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 8: ACTIVATORS =====
            _sectionBanner(
              8,
              'ShortcutActivator Catalogue',
              'SingleActivator, CharacterActivator, LogicalKeySet.',
              kAccent8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (final a in activatorRecords)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: kCardBg,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: kAccent8.withOpacity(0.35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a['name'] as String,
                              style: TextStyle(
                                color: kAccent8,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              'trigger: ${a['trigger']}',
                              style: TextStyle(
                                color: kText,
                                fontSize: 12.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 4.0,
                              children: [
                                _modChip('ctrl', a['control'] as bool),
                                _modChip('shift', a['shift'] as bool),
                                _modChip('alt', a['alt'] as bool),
                                _modChip('meta', a['meta'] as bool),
                                _modChip(
                                  'repeats',
                                  a['repeats'] as bool,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: kCardBg2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CharacterActivator',
                          style: TextStyle(
                            color: kAccent8,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          '"?": ${qmarkActivator.character}',
                          style: TextStyle(
                            color: kText,
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          '"/": ${slashActivator.character}',
                          style: TextStyle(
                            color: kText,
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: kCardBg2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LogicalKeySet (chord)',
                          style: TextStyle(
                            color: kAccent8,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Ctrl+C → ${ctrlC.keys.length} keys',
                          style: TextStyle(
                            color: kText,
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          'Ctrl+Shift+S → ${ctrlShiftS.keys.length} keys',
                          style: TextStyle(
                            color: kText,
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          'Alt+F4 → ${altF4.keys.length} keys',
                          style: TextStyle(
                            color: kText,
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 9: KEY EVENT RESULT ENUM =====
            _sectionBanner(
              9,
              'KeyEventResult Enum',
              'How a handler signals propagation to the framework.',
              kAccent5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (final r in keyEventResults)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: kCardBg,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: (r['color'] as Color).withOpacity(0.45),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44.0,
                              height: 44.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (r['color'] as Color)
                                    .withOpacity(0.25),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                '#${r['index']}',
                                style: TextStyle(
                                  color: r['color'] as Color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'KeyEventResult.${r['name']}',
                                    style: TextStyle(
                                      color: kText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    r['desc'] as String,
                                    style: TextStyle(
                                      color: kTextMuted,
                                      fontSize: 12.0,
                                    ),
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

            // ===== SECTION 10: SHORTCUTS / ACTIONS / INTENTS =====
            _sectionBanner(
              10,
              'Shortcuts · Actions · Intents Architecture',
              'How a key chord becomes a typed app event.',
              kAccent2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent2.withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    _archStep(
                      '1',
                      'HardwareKeyboard',
                      'Receives raw OS key signals from the embedder.',
                      kAccent6,
                    ),
                    _archArrow(),
                    _archStep(
                      '2',
                      'Focus subtree',
                      'Active FocusNode receives KeyEvent first via onKeyEvent.',
                      kAccent5,
                    ),
                    _archArrow(),
                    _archStep(
                      '3',
                      'Shortcuts',
                      'Maps ShortcutActivator → Intent for matching chords.',
                      kAccent3,
                    ),
                    _archArrow(),
                    _archStep(
                      '4',
                      'Actions',
                      'Looks up an Action<T> by the Intent type T.',
                      kAccent8,
                    ),
                    _archArrow(),
                    _archStep(
                      '5',
                      'Action.invoke',
                      'Mutates app state / runs the business effect.',
                      kAccent7,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 11: INTENT VOCABULARY =====
            _sectionBanner(
              11,
              'Intent Vocabulary',
              'Built-in semantic intents shipped with the framework.',
              kAccent7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (final i in intentRecords)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: kCardBg2,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: kAccent7.withOpacity(0.35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              i['name'] as String,
                              style: TextStyle(
                                color: kAccent7,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                fontFamily: 'monospace',
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              i['purpose'] as String,
                              style: TextStyle(
                                color: kTextMuted,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF101418),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                i['instance'] as String,
                                style: TextStyle(
                                  color: kAccent3,
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
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

            SizedBox(height: 16.0),

            // ===== SECTION 12: RECIPES =====
            _sectionBanner(
              12,
              'Real-World Recipes',
              'Common chords mapped through the pipeline.',
              kAccent3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (final r in recipes)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: kCardBg,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: (r['color'] as Color).withOpacity(0.45),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4.0,
                                  height: 18.0,
                                  decoration: BoxDecoration(
                                    color: r['color'] as Color,
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    r['title'] as String,
                                    style: TextStyle(
                                      color: kText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            _recipeRow('Activator', r['activator'] as String,
                                kAccent5),
                            _recipeRow(
                                'Intent', r['intent'] as String, kAccent8),
                            _recipeRow(
                                'Action', r['action'] as String, kAccent6),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 13: FOCUS + LIVE SHORTCUTS =====
            _sectionBanner(
              13,
              'Focus + KeyboardListener Wiring',
              'Live (static-snapshot) widget composition.',
              kAccent5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent5.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KeyboardListener',
                      style: TextStyle(
                        color: kAccent5,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    KeyboardListener(
                      focusNode: keyboardListenerNode,
                      autofocus: false,
                      includeSemantics: true,
                      onKeyEvent: (event) {},
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: kCardBg2,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: kAccent5.withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '⌨  KeyboardListener target  ⌨',
                          style: TextStyle(
                            color: kTextMuted,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    Text(
                      'Shortcuts + Actions + Focus',
                      style: TextStyle(
                        color: kAccent5,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    shortcutsDemo,
                    SizedBox(height: 14.0),
                    Text(
                      'Focus.onKeyEvent placeholder',
                      style: TextStyle(
                        color: kAccent5,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF101418),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'Focus(\n'
                        '  onKeyEvent: (node, event) {\n'
                        '    if (event is KeyDownEvent &&\n'
                        '        event.logicalKey == LogicalKeyboardKey.escape) {\n'
                        '      return KeyEventResult.handled;\n'
                        '    }\n'
                        '    return KeyEventResult.ignored;\n'
                        '  },\n'
                        '  child: ...,\n'
                        ')',
                        style: TextStyle(
                          color: kAccent3,
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 14: GLOSSARY =====
            _sectionBanner(
              14,
              'Glossary',
              'Definitions you can lift into design docs.',
              kAccent6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: kCardBg,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: kAccent6.withOpacity(0.35)),
                ),
                child: Column(
                  children: [
                    _gloss('PhysicalKeyboardKey',
                        'Hardware-location identifier (USB HID usage). '
                        'Same key, same code, regardless of layout.'),
                    _gloss('LogicalKeyboardKey',
                        'What the OS / layout says the key means. '
                        'Affected by Shift, AltGr, and locale keymaps.'),
                    _gloss('HardwareKeyboard',
                        'Singleton tracker of currently pressed keys '
                        'and lock-mode state.'),
                    _gloss('KeyEvent',
                        'Modern, unified base class for key Down / Up / '
                        'Repeat events. Replaces RawKeyEvent.'),
                    _gloss('Synthesized event',
                        'An event the framework manufactures (e.g. '
                        'when focus is lost while a key is held).'),
                    _gloss('ShortcutActivator',
                        'Anything that can decide whether a KeyEvent '
                        'should fire a shortcut (SingleActivator, '
                        'CharacterActivator, LogicalKeySet).'),
                    _gloss('Intent',
                        'A typed, semantic description of what the user '
                        'wants to do. Decoupled from its action.'),
                    _gloss('Action<T extends Intent>',
                        'A handler that knows how to perform an Intent '
                        'of type T.'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            // ===== EPILOGUE / SUMMARY =====
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF311B92), Color(0xFF0D47A1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Epilogue',
                      style: TextStyle(
                        color: kText,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'This script renders every keyboard concept as a '
                      'static visualisation: physical vs logical key '
                      'identity, the three concrete KeyEvent types, a '
                      'synthetic Down→Repeat→Up event stream, a '
                      'transition state machine, a side-by-side modern '
                      'vs legacy comparison, the Shortcuts → Actions → '
                      'Intents pipeline, recipes for save / dismiss / '
                      'navigate / help / search, and a glossary. No '
                      'StatefulWidget, no controllers, no async — just '
                      'top-level data and helper Widgets, exactly what '
                      'a D4rt analyzer-free interpreter needs.',
                      style: TextStyle(
                        color: Color(0xFFC5CAE9),
                        fontSize: 13.0,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 14.0),
                    _summaryRow('LogicalKeyboardKey inventory', 'PASS'),
                    _summaryRow('PhysicalKeyboardKey USB HID table', 'PASS'),
                    _summaryRow('KeyEvent class hierarchy', 'PASS'),
                    _summaryRow('Event stream walkthrough', 'PASS'),
                    _summaryRow('State machine transitions', 'PASS'),
                    _summaryRow('HardwareKeyboard snapshot', 'PASS'),
                    _summaryRow('Modern vs legacy comparison', 'PASS'),
                    _summaryRow('ShortcutActivator catalogue', 'PASS'),
                    _summaryRow('KeyEventResult enum', 'PASS'),
                    _summaryRow('Shortcuts/Actions/Intents pipeline', 'PASS'),
                    _summaryRow('Real-world recipes', 'PASS'),
                    _summaryRow('Focus + KeyboardListener wiring', 'PASS'),
                    _summaryRow('Glossary', 'PASS'),
                    SizedBox(height: 12.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'Keyboard Event Telemetry · All Sections Rendered ✓',
                          style: TextStyle(
                            color: kText,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== FOOTER =====
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Center(
                child: Text(
                  'Deep Demo · Keystroke Timeline Lab · package:flutter/services',
                  style: TextStyle(
                    color: Color(0xFF7B8597),
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPER WIDGETS (top-level only — no Stateful/Stateless subclassing)
// ============================================================================

Widget _heroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.25),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withOpacity(0.6)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFE6EAF2),
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionBanner(int n, String title, String subtitle, Color color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.85), color.withOpacity(0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0x33000000),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              n.toString(),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECTION $n: $title',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11.0,
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

Widget _keyGroupCard(
    String title, List<Map<String, dynamic>> entries, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A1F27),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            for (final e in entries)
              _logicalKeyTile(
                e['name'] as String,
                e['key'] as LogicalKeyboardKey,
                color,
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _logicalKeyTile(String name, LogicalKeyboardKey key, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0xFF222933),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Color(0xFFE6EAF2),
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'id=0x${key.keyId.toRadixString(16)}',
          style: TextStyle(
            color: Color(0xFFA0AAB8),
            fontSize: 9.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _arrowsCard(List<Map<String, dynamic>> arrows, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A1F27),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Arrow keys',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (final a in arrows)
              Container(
                width: 60.0,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: color),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      a['glyph'] as String,
                      style: TextStyle(
                        color: Color(0xFFE6EAF2),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      a['name'] as String,
                      style: TextStyle(
                        color: Color(0xFFA0AAB8),
                        fontSize: 9.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _eventCard(int index, Map<String, dynamic> r) {
  final color = r['color'] as Color;
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF1A1F27),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        r['kind'] as String,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'ts=${r['timeStamp']}',
                      style: TextStyle(
                        color: Color(0xFFA0AAB8),
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  'physical=${r['physical']}  logical=${r['logical']}',
                  style: TextStyle(
                    color: Color(0xFFE6EAF2),
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'character=${r['character'] ?? '∅'}'
                  '   synthesized=${r['synthesized']}',
                  style: TextStyle(
                    color: Color(0xFFA0AAB8),
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

Widget _stateNode(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFE6EAF2),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _arrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Text(
      '→',
      style: TextStyle(
        color: Color(0xFFA0AAB8),
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _thCell(String label, Color color) {
  return Text(
    label,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    ),
  );
}

Widget _modChip(String label, bool on) {
  final color = on ? Color(0xFF66BB6A) : Color(0xFF455A64);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.25),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color),
    ),
    child: Text(
      '$label: ${on ? "on" : "off"}',
      style: TextStyle(
        color: Color(0xFFE6EAF2),
        fontSize: 10.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _archStep(String n, String title, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFF222933),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            n,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(
                  color: Color(0xFFA0AAB8),
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _archArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Text(
        '↓',
        style: TextStyle(
          color: Color(0xFFA0AAB8),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _recipeRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFFE6EAF2),
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _gloss(String term, String def) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: TextStyle(
            color: Color(0xFF66BB6A),
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          def,
          style: TextStyle(
            color: Color(0xFFA0AAB8),
            fontSize: 11.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _summaryRow(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFE6EAF2),
              fontSize: 12.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
      ],
    ),
  );
}
