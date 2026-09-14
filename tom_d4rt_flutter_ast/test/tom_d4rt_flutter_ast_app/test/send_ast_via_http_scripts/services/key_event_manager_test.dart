// ignore_for_file: avoid_print
// D4rt deep demo: KeyEventManager — central keyboard event dispatching
// system that routes KeyEvents through the widget tree focus chain.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Cobalt / Azure palette ───
  const Color cobalt = Color(0xFF0047AB);
  const Color azure = Color(0xFF007FFF);
  const Color deepCobalt = Color(0xFF002D6D);
  const Color paleCobalt = Color(0xFFF0F5FF);
  const Color royalBlue = Color(0xFF4169E1);
  const Color sapphire = Color(0xFF0F52BA);
  const Color skyAzure = Color(0xFFBFDBFE);
  const Color midnight = Color(0xFF191970);
  const Color iceBlue = Color(0xFFE0F0FF);
  const Color indigo = Color(0xFF3F51B5);

  print('[ke] ===== KEY EVENT MANAGER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget keBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midnight, deepCobalt],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: midnight.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: cobalt,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: skyAzure, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget keNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleCobalt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: skyAzure),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: midnight.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget keCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: skyAzure.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: midnight.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cobalt.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: midnight)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget keRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? cobalt.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: skyAzure.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? midnight : deepCobalt)),
          );
        }).toList(),
      ),
    );
  }

  Widget keFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? midnight : deepCobalt,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: cobalt),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is KeyEventManager? ━━━━━━
  print('[ke-01] Section 1: What is KeyEventManager?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('01', 'What Is KeyEventManager?'),
      keNote(
        'KeyEventManager is the central dispatcher for keyboard events in '
        'Flutter. It receives raw platform key events, translates them to '
        'Flutter KeyEvent objects (KeyDownEvent, KeyUpEvent, KeyRepeatEvent), '
        'and routes them through the focus tree. It tracks which keys are '
        'currently pressed and synthesizes missing events.',
      ),
      keCard(
        'Role in the Framework',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keFlow(['Platform Event', 'KeyEventManager', 'HardwareKeyboard',
                'Focus Tree', 'Shortcuts']),
            const SizedBox(height: 10),
            _keRoleRow('Receives', 'Raw platform key messages', cobalt),
            _keRoleRow('Translates', 'To Flutter KeyEvent objects', azure),
            _keRoleRow('Tracks', 'Currently-pressed key set', sapphire),
            _keRoleRow('Routes', 'Through focus node chain', royalBlue),
            _keRoleRow('Synthesizes', 'Missing up/down events', indigo),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: KeyEvent types ━━━━━━
  print('[ke-02] Section 2: KeyEvent types');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('02', 'KeyEvent Types'),
      keNote(
        'Flutter defines three KeyEvent subclasses: KeyDownEvent (key pressed), '
        'KeyUpEvent (key released), and KeyRepeatEvent (key held, auto-repeat). '
        'KeyEventManager creates the appropriate type based on the platform '
        'event and the currently-tracked key state.',
      ),
      keCard(
        'Event Class Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keEventBox('KeyEvent', 'Abstract base', Icons.keyboard, cobalt),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  _keEventBox('KeyDownEvent', 'Key first pressed', Icons.arrow_downward, azure),
                  _keEventBox('KeyUpEvent', 'Key released', Icons.arrow_upward, sapphire),
                  _keEventBox('KeyRepeatEvent', 'Auto-repeat tick', Icons.repeat, royalBlue),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Dispatch pipeline ━━━━━━
  print('[ke-03] Section 3: Dispatch pipeline');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('03', 'Dispatch Pipeline'),
      keNote(
        'When a platform key event arrives, KeyEventManager processes it '
        'through a pipeline: (1) translate to KeyEvent, (2) update '
        'HardwareKeyboard state, (3) call global handlers, (4) propagate '
        'through focus tree from primary focus upward.',
      ),
      keCard(
        'Pipeline Stages',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleCobalt,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _kePipelineStep(1, 'Platform message received', 'MethodChannel callback', midnight),
              _kePipelineStep(2, 'Translate to KeyEvent', 'Platform-specific helper', deepCobalt),
              _kePipelineStep(3, 'Update pressed-keys set', 'HardwareKeyboard.pressedKeys', cobalt),
              _kePipelineStep(4, 'Fire global handlers', 'HardwareKeyboard.addHandler', azure),
              _kePipelineStep(5, 'Walk focus tree upward', 'FocusNode.onKeyEvent chain', sapphire),
              _kePipelineStep(6, 'Return handled/unhandled', 'KeyEventResult', royalBlue),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Focus tree routing ━━━━━━
  print('[ke-04] Section 4: Focus tree routing');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('04', 'Focus Tree Routing'),
      keNote(
        'Key events propagate from the primary focus node up through its '
        'ancestors. Each FocusNode\'s onKeyEvent callback has a chance to '
        'handle the event. If a node returns KeyEventResult.handled, '
        'propagation stops. If all return ignored, the event is unhandled.',
      ),
      keCard(
        'Focus Propagation',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleCobalt,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _keFocusNode('FocusScope (root)', 'Last chance', midnight, 4),
              _keFocusNode('FocusScope (page)', 'Shortcuts here', deepCobalt, 3),
              _keFocusNode('Focus (list tile)', 'Navigation', cobalt, 2),
              _keFocusNode('Focus (text field)', 'Primary focus ★', azure, 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward, size: 16, color: cobalt),
                  const SizedBox(width: 4),
                  Text('Events bubble upward',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: cobalt)),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: HardwareKeyboard state ━━━━━━
  print('[ke-05] Section 5: HardwareKeyboard state');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('05', 'HardwareKeyboard State Tracking'),
      keNote(
        'KeyEventManager updates HardwareKeyboard.instance.pressedKeys '
        'on every key event. This set tracks all currently-held physical '
        'keys. It enables queries like "is Ctrl pressed?" without '
        'subscribing to events.',
      ),
      keCard(
        'State Management',
        Column(
          children: [
            keRow(['Event', 'Action', 'pressedKeys'], isHeader: true),
            keRow(['KeyDownEvent(A)', 'Add A', '{A}']),
            keRow(['KeyDownEvent(Ctrl)', 'Add Ctrl', '{A, Ctrl}']),
            keRow(['KeyRepeatEvent(A)', 'No change', '{A, Ctrl}']),
            keRow(['KeyUpEvent(A)', 'Remove A', '{Ctrl}']),
            keRow(['KeyUpEvent(Ctrl)', 'Remove Ctrl', '{}']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Key synthesis ━━━━━━
  print('[ke-06] Section 6: Key synthesis');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('06', 'Key Event Synthesis'),
      keNote(
        'Platforms sometimes miss events (e.g., key-up lost when window loses '
        'focus). KeyEventManager detects stale pressed keys and synthesizes '
        'matching key-up events to keep HardwareKeyboard consistent.',
      ),
      keCard(
        'Synthesis Scenarios',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keSynthItem('Window loses focus with keys held', 'Synthesize KeyUpEvent for all', cobalt),
            _keSynthItem('Modifier state disagrees', 'Synthesize missing down/up', azure),
            _keSynthItem('Platform sends down for tracked key', 'Synthesize up first', sapphire),
            _keSynthItem('Lock key toggled while unfocused', 'Sync on next event', royalBlue),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Global handlers ━━━━━━
  print('[ke-07] Section 7: Global handlers');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('07', 'Global Key Handlers'),
      keNote(
        'HardwareKeyboard.addHandler registers a callback that receives every '
        'KeyEvent before focus-tree routing. This is useful for app-wide '
        'shortcuts (like Ctrl+Q to quit) that should work regardless of focus.',
      ),
      keCard(
        'Handler Priority',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keHandlerRow(1, 'Global handlers', 'HardwareKeyboard.addHandler', 'First', midnight),
            _keHandlerRow(2, 'Focus tree walk', 'FocusNode.onKeyEvent', 'If not handled', deepCobalt),
            _keHandlerRow(3, 'Default handling', 'Unhandled event', 'Last resort', cobalt),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paleCobalt,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Global handlers see ALL key events. If any returns true, '
                'the event is still passed to the focus tree (unlike old '
                'RawKeyboard where it stopped).',
                style: TextStyle(fontSize: 10, color: midnight),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: KeyEventResult ━━━━━━
  print('[ke-08] Section 8: KeyEventResult');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('08', 'KeyEventResult Values'),
      keNote(
        'onKeyEvent callbacks return a KeyEventResult to tell the manager '
        'what happened. There are three values: handled (consumed, stop '
        'propagation), ignored (not interested, keep propagating), and '
        'skipRemainingHandlers (handled, skip other handlers at same level).',
      ),
      keCard(
        'Result Behaviors',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keResultBox('KeyEventResult.handled', 'Event consumed, stop bubbling',
                const Color(0xFF2E7D32)),
            const SizedBox(height: 4),
            _keResultBox('KeyEventResult.ignored', 'Pass to next node',
                cobalt),
            const SizedBox(height: 4),
            _keResultBox('KeyEventResult.skipRemainingHandlers',
                'Handled + skip sibling handlers', const Color(0xFFFF6F00)),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Shortcuts integration ━━━━━━
  print('[ke-09] Section 9: Shortcuts integration');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('09', 'Integration with Shortcuts'),
      keNote(
        'The Shortcuts widget listens for key events via the focus tree '
        'and matches them against registered shortcut activators '
        '(SingleActivator, CharacterActivator, etc.). KeyEventManager '
        'provides the events that Shortcuts consumes.',
      ),
      keCard(
        'Shortcuts Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keFlow(['KeyEvent', 'Focus → Shortcuts',
                'Match activator', 'Invoke Intent', 'Execute Action']),
            const SizedBox(height: 10),
            keRow(['Component', 'Role', 'Example'], isHeader: true),
            keRow(['SingleActivator', 'Key combination', 'Ctrl+C']),
            keRow(['CharacterActivator', 'Character match', '"?" key']),
            keRow(['ShortcutManager', 'Resolves intent', 'CopyIntent']),
            keRow(['Actions', 'Executes action', 'CopyAction']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: RawKeyboard migration ━━━━━━
  print('[ke-10] Section 10: RawKeyboard migration');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('10', 'Migration from RawKeyboard'),
      keNote(
        'KeyEventManager is part of the new key handling system that '
        'replaces RawKeyboard (deprecated). RawKeyboard used RawKeyEvent '
        'with rawKeyData; the new system uses KeyEvent with logical/physical '
        'keys and is more cross-platform consistent.',
      ),
      keCard(
        'Old vs New',
        Column(
          children: [
            keRow(['Aspect', 'Old (RawKeyboard)', 'New (KeyEvent)'], isHeader: true),
            keRow(['Event class', 'RawKeyEvent', 'KeyEvent']),
            keRow(['Dispatcher', 'RawKeyboard', 'KeyEventManager']),
            keRow(['State', 'keysPressed (logical)', 'pressedKeys (physical)']),
            keRow(['Listener', 'RawKeyListener', 'Focus.onKeyEvent']),
            keRow(['Platform data', 'In event', 'In platform record']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Platform-specific translation ━━━━━━
  print('[ke-11] Section 11: Platform translation');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('11', 'Platform-Specific Translation'),
      keNote(
        'Each platform sends different raw data. KeyEventManager uses '
        'platform-specific key helpers (GLFWKeyHelper for Linux, etc.) '
        'to translate raw data into a uniform KeyEvent. The manager '
        'normalizes all platforms to the same event model.',
      ),
      keCard(
        'Per-Platform Key Data',
        Column(
          children: [
            keRow(['Platform', 'Raw Data', 'Key Helper'], isHeader: true),
            keRow(['Android', 'KeyEvent + keyCode', 'Android key map']),
            keRow(['iOS', 'UIKey + usage', 'iOS key map']),
            keRow(['Windows', 'WM_KEY* + vk', 'Win32 key map']),
            keRow(['macOS', 'NSEvent + keyCode', 'macOS key map']),
            keRow(['Linux GLFW', 'GLFW key + scan', 'GLFWKeyHelper']),
            keRow(['Linux GTK', 'GDK keyval', 'GtkKeyHelper']),
            keRow(['Web', 'DOM code + key', 'Web key map']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Lock keys ━━━━━━
  print('[ke-12] Section 12: Lock keys');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('12', 'Lock Key Handling'),
      keNote(
        'Lock keys (CapsLock, NumLock, ScrollLock) toggle state rather than '
        'hold state. KeyEventManager tracks lock state separately from '
        'pressed-keys. HardwareKeyboard.lockModesEnabled reports which '
        'locks are currently active.',
      ),
      keCard(
        'Lock Key States',
        Column(
          children: [
            keRow(['Lock Key', 'Toggle', 'Query Method'], isHeader: true),
            keRow(['CapsLock', 'On/Off', 'lockModesEnabled.contains(capsLock)']),
            keRow(['NumLock', 'On/Off', 'lockModesEnabled.contains(numLock)']),
            keRow(['ScrollLock', 'On/Off', 'lockModesEnabled.contains(scrollLock)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Text input interaction ━━━━━━
  print('[ke-13] Section 13: Text input interaction');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('13', 'Interaction with TextInput'),
      keNote(
        'When a text field has focus, key events are shared between the '
        'KeyEventManager (for shortcuts) and the TextInput system (for '
        'character insertion). The manager dispatches first; if no handler '
        'consumes the event, it falls through to text input.',
      ),
      keCard(
        'TextInput Coexistence',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keFlow(['Key pressed', 'Manager dispatch',
                'Focus handlers', 'TextInput fallback']),
            const SizedBox(height: 10),
            keRow(['Event', 'Who handles?', 'Result'], isHeader: true),
            keRow(['Ctrl+C', 'Shortcut widget', 'Copy, don\'t insert "c"']),
            keRow(['"a" key', 'Nobody handles', 'TextInput inserts "a"']),
            keRow(['Enter', 'May be handled', 'Submit or newline']),
            keRow(['Escape', 'Focus manager', 'Unfocus text field']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Debugging key events ━━━━━━
  print('[ke-14] Section 14: Debugging');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('14', 'Debugging Key Events'),
      keNote(
        'Debug key issues with HardwareKeyboard.addHandler to log all events. '
        'Also check HardwareKeyboard.pressedKeys for state issues. Common '
        'problems: stuck keys (missing up event), duplicate events, wrong '
        'logical key on non-US layouts.',
      ),
      keCard(
        'Debug Techniques',
        Column(
          children: [
            keRow(['Technique', 'What', 'When'], isHeader: true),
            keRow(['Global handler', 'Log all events', 'See raw flow']),
            keRow(['pressedKeys dump', 'Check state', 'Stuck key issues']),
            keRow(['Focus debugger', 'Print focus chain', 'Routing issues']),
            keRow(['debugPrintKeyEvents', 'Framework flag', 'Complete log']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing key events ━━━━━━
  print('[ke-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('15', 'Testing Key Event Handling'),
      keNote(
        'Test key event handling with WidgetTester.sendKeyEvent, '
        'sendKeyDownEvent, sendKeyUpEvent. These simulate the full '
        'KeyEventManager pipeline. For unit tests of handlers, construct '
        'KeyEvent objects directly.',
      ),
      keCard(
        'Test Methods',
        Column(
          children: [
            keRow(['Method', 'What', 'Level'], isHeader: true),
            keRow(['sendKeyEvent', 'Down + up pair', 'Integration']),
            keRow(['sendKeyDownEvent', 'Single down', 'Integration']),
            keRow(['sendKeyUpEvent', 'Single up', 'Integration']),
            keRow(['simulateKeyEvent', 'Platform message', 'Low-level']),
            keRow(['KeyEvent constructor', 'Direct object', 'Unit']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ke-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      keBanner('16', 'Summary Dashboard'),
      keCard(
        'KeyEventManager — Complete',
        Column(
          children: [
            keRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            keRow(['What', 'S01', 'Central key event dispatcher']),
            keRow(['Events', 'S02', 'Down/Up/Repeat event types']),
            keRow(['Pipeline', 'S03', '6-stage dispatch pipeline']),
            keRow(['Focus', 'S04', 'Bottom-up tree propagation']),
            keRow(['State', 'S05', 'pressedKeys tracking']),
            keRow(['Synthesis', 'S06', 'Fill missing events']),
            keRow(['Global', 'S07', 'App-wide handlers']),
            keRow(['Result', 'S08', 'handled/ignored/skip']),
            keRow(['Shortcuts', 'S09', 'Activator → Intent → Action']),
            keRow(['Migration', 'S10', 'RawKeyboard replacement']),
            keRow(['Platforms', 'S11', 'Platform-specific helpers']),
            keRow(['Locks', 'S12', 'CapsLock/NumLock toggle']),
            keRow(['TextInput', 'S13', 'Shortcut vs text priority']),
            keRow(['Debug', 'S14', 'Global logging techniques']),
            keRow(['Testing', 'S15', 'sendKeyEvent methods']),
          ],
        ),
      ),
      keCard(
        'Cobalt / Azure Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _keColorSwatch('Cobalt', cobalt),
            _keColorSwatch('Azure', azure),
            _keColorSwatch('Sapphire', sapphire),
            _keColorSwatch('Royal', royalBlue),
            _keColorSwatch('Midnight', midnight),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [midnight, deepCobalt],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('KeyEventManager — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From platform translation through state tracking, focus '
              'routing, key synthesis, shortcuts integration, and text input '
              'coexistence — the full keyboard event management story.',
              style: TextStyle(color: skyAzure, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ke] palette: $indigo, $iceBlue');
  print('[ke] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('KeyEventManager — Key Dispatching'),
        backgroundColor: midnight,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F8FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _keRoleRow(String label, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _keEventBox(String name, String desc, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(name,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _kePipelineStep(int num, String action, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(action,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          flex: 3,
          child: Text(detail,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _keFocusNode(String label, String note, Color color, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: (4 - depth) * 16.0, bottom: 4),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
          const Spacer(),
          Text(note,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.6))),
        ],
      ),
    ),
  );
}

Widget _keSynthItem(String scenario, String action, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.auto_fix_high, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(scenario,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(action,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _keHandlerRow(int order, String name, String api, String when, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$order',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(name,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          flex: 3,
          child: Text(api,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace', color: color.withValues(alpha: 0.7))),
        ),
        SizedBox(
          width: 60,
          child: Text(when,
              style: TextStyle(fontSize: 9, color: color)),
        ),
      ],
    ),
  );
}

Widget _keResultBox(String name, String desc, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(name,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color)),
        ),
        Expanded(
          flex: 3,
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _keColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
