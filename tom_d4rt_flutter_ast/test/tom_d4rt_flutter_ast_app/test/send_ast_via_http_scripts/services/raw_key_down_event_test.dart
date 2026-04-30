// ignore_for_file: avoid_print
// D4rt deep demo: RawKeyDownEvent — the deprecated key-down event from
// the old RawKeyboard system replaced by KeyDownEvent / HardwareKeyboard.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Ocean / Sky palette ───
  const Color ocean = Color(0xFF0369A1);
  const Color sky = Color(0xFF7DD3FC);
  const Color deepOcean = Color(0xFF0C4A6E);
  const Color paleSky = Color(0xFFE0F2FE);
  const Color tidal = Color(0xFF0284C7);
  const Color mist = Color(0xFFBAE6FD);
  const Color iceBlue = Color(0xFF38BDF8);
  const Color abyss = Color(0xFF082F49);
  const Color foam = Color(0xFFF0F9FF);
  const Color surf = Color(0xFF0EA5E9);

  print('[rd] ===== RAW KEY DOWN EVENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget rdBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [abyss, deepOcean],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: abyss.withValues(alpha: 0.35),
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
              color: tidal,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sky, width: 1.5),
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

  Widget rdNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: foam,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mist),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: abyss.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget rdCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sky.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: abyss.withValues(alpha: 0.06),
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
              color: ocean.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: abyss)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget rdRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? ocean.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: sky.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? abyss : deepOcean)),
          );
        }).toList(),
      ),
    );
  }

  Widget rdFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? abyss : deepOcean,
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
          child: Icon(Icons.arrow_forward, size: 12, color: tidal),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is RawKeyDownEvent? ━━━━━━
  print('[rd-01] Section 1: What is RawKeyDownEvent?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('01', 'What Is RawKeyDownEvent?'),
      rdNote(
        'RawKeyDownEvent is a deprecated class from Flutter\'s old keyboard '
        'system. It fires whenever a physical key is pressed down. Each '
        'event carries a RawKeyEventData subclass with platform-specific '
        'key information. Replaced by KeyDownEvent via HardwareKeyboard.',
      ),
      rdCard(
        'Inheritance',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rdClassBox('RawKeyEvent', 'abstract base', abyss),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rdClassBox('RawKeyDownEvent', 'key pressed', ocean),
                  _rdClassBox('RawKeyUpEvent', 'key released', tidal),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: RawKeyboard vs HardwareKeyboard ━━━━━━
  print('[rd-02] Section 2: Old vs New');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('02', 'RawKeyboard vs HardwareKeyboard'),
      rdNote(
        'The old RawKeyboard system dispatched RawKeyDownEvent and '
        'RawKeyUpEvent. The new HardwareKeyboard system dispatches '
        'KeyDownEvent and KeyUpEvent. The new system has better support '
        'for modifier keys, IME input, and cross-platform consistency.',
      ),
      rdCard(
        'System Comparison',
        Column(
          children: [
            rdRow(['Aspect', 'RawKeyboard (old)', 'HardwareKeyboard (new)'], isHeader: true),
            rdRow(['Down event', 'RawKeyDownEvent', 'KeyDownEvent']),
            rdRow(['Up event', 'RawKeyUpEvent', 'KeyUpEvent']),
            rdRow(['Data', 'RawKeyEventData', 'KeyEvent']),
            rdRow(['Modifiers', 'Bitmask flags', 'Tracked state']),
            rdRow(['IME', 'Partial support', 'Full support']),
            rdRow(['Status', 'Deprecated', 'Current']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Event dispatch ━━━━━━
  print('[rd-03] Section 3: Event dispatch');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('03', 'How Key Down Events Dispatch'),
      rdNote(
        'When a physical key is pressed, the platform sends a key message '
        'to Flutter. The engine converts it to a RawKeyDownEvent which '
        'propagates through the focus tree — from the focused node up to '
        'the root, stopping at the first handler that returns '
        'KeyEventResult.handled.',
      ),
      rdCard(
        'Dispatch Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rdFlow(['Key press', 'Platform msg', 'Engine', 'RawKeyDownEvent',
                'Focus tree']),
            const SizedBox(height: 10),
            _rdPipelineStep(1, 'Platform', 'OS generates key event', abyss),
            _rdPipelineStep(2, 'Channel', 'JSON message to engine', deepOcean),
            _rdPipelineStep(3, 'Engine', 'Create RawKeyDownEvent', ocean),
            _rdPipelineStep(4, 'Framework', 'Traverse focus tree', tidal),
            _rdPipelineStep(5, 'Handler', 'onKey callback invoked', iceBlue),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: RawKeyEventData subclasses ━━━━━━
  print('[rd-04] Section 4: Data subclasses');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('04', 'Platform-Specific Data'),
      rdNote(
        'Each RawKeyDownEvent contains a data field typed as one of the '
        'platform subclasses of RawKeyEventData. Each carries native key '
        'codes and modifier flags specific to that OS.',
      ),
      rdCard(
        'Data Subclasses',
        Column(
          children: [
            rdRow(['Subclass', 'Platform', 'Native Key'], isHeader: true),
            rdRow(['RawKeyEventDataAndroid', 'Android', 'keyCode + scanCode']),
            rdRow(['RawKeyEventDataFuchsia', 'Fuchsia', 'hidUsage']),
            rdRow(['RawKeyEventDataIos', 'iOS', 'characters + keyCode']),
            rdRow(['RawKeyEventDataLinux', 'Linux', 'keyCode + scanCode']),
            rdRow(['RawKeyEventDataMacOs', 'macOS', 'keyCode + chars']),
            rdRow(['RawKeyEventDataWeb', 'Web', 'code + key']),
            rdRow(['RawKeyEventDataWindows', 'Windows', 'keyCode + scanCode']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Key properties ━━━━━━
  print('[rd-05] Section 5: Key properties');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('05', 'Key Identification Properties'),
      rdNote(
        'A RawKeyDownEvent surfaces key identity via logicalKey (what the '
        'user intended — e.g. LogicalKeyboardKey.keyA) and physicalKey '
        '(the hardware button — e.g. PhysicalKeyboardKey.keyA). On non-US '
        'layouts these can differ.',
      ),
      rdCard(
        'Identity Properties',
        Column(
          children: [
            rdRow(['Property', 'Type', 'Meaning'], isHeader: true),
            rdRow(['logicalKey', 'LogicalKeyboardKey', 'What character / function']),
            rdRow(['physicalKey', 'PhysicalKeyboardKey', 'Which hardware key']),
            rdRow(['character', 'String?', 'Character produced (if text)']),
            rdRow(['repeat', 'bool', 'Is auto-repeat event']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Modifier keys ━━━━━━
  print('[rd-06] Section 6: Modifier keys');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('06', 'Modifier Key Tracking'),
      rdNote(
        'RawKeyDownEvent tracks modifiers via isControlPressed, isShiftPressed, '
        'isAltPressed, isMetaPressed. These reflect the physical state when '
        'the key was pressed. Caution: the old system had known issues with '
        'modifier synchronization — HardwareKeyboard is more reliable.',
      ),
      rdCard(
        'Modifier Properties',
        Column(
          children: [
            rdRow(['Modifier', 'Property', 'macOS', 'Windows'], isHeader: true),
            rdRow(['Control', 'isControlPressed', 'Ctrl ⌃', 'Ctrl']),
            rdRow(['Shift', 'isShiftPressed', 'Shift ⇧', 'Shift']),
            rdRow(['Alt', 'isAltPressed', 'Option ⌥', 'Alt']),
            rdRow(['Meta', 'isMetaPressed', 'Command ⌘', 'Win ⊞']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Focus integration ━━━━━━
  print('[rd-07] Section 7: Focus integration');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('07', 'Focus & RawKeyboardListener'),
      rdNote(
        'RawKeyboardListener wraps a FocusNode and listens for raw key '
        'events. When focused, it receives RawKeyDownEvent (and up). '
        'RawKeyboardListener is deprecated — use KeyboardListener instead. '
        'Both integrate with the Focus widget tree.',
      ),
      rdCard(
        'Listener Comparison',
        Column(
          children: [
            rdRow(['Widget', 'Events', 'Status'], isHeader: true),
            rdRow(['RawKeyboardListener', 'RawKeyDownEvent', 'Deprecated']),
            rdRow(['KeyboardListener', 'KeyDownEvent', 'Current']),
            rdRow(['Focus(onKeyEvent:)', 'KeyEvent', 'Current']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Shortcuts integration ━━━━━━
  print('[rd-08] Section 8: Shortcuts');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('08', 'Shortcuts & Key Bindings'),
      rdNote(
        'The Shortcuts widget uses activators that test incoming key events. '
        'SingleActivator and CharacterActivator work with the new KeyEvent '
        'system. The old RawKeyboard system could use raw key events for '
        'shortcuts but with less precise matching.',
      ),
      rdCard(
        'Activator Types',
        Column(
          children: [
            rdRow(['Activator', 'System', 'Match On'], isHeader: true),
            rdRow(['SingleActivator', 'New', 'LogicalKey + modifiers']),
            rdRow(['CharacterActivator', 'New', 'Character produced']),
            rdRow(['LogicalKeySet', 'Old', 'Set of logical keys']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Character generation ━━━━━━
  print('[rd-09] Section 9: Character generation');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('09', 'Character Generation'),
      rdNote(
        'The character property on RawKeyDownEvent may be null for non-'
        'printable keys (Shift, Control, F1) but contains the generated '
        'character for text keys. Dead keys and IME composition may '
        'produce multi-character strings or null depending on platform.',
      ),
      rdCard(
        'Character Behavior',
        Column(
          children: [
            rdRow(['Key', 'character', 'logicalKey'], isHeader: true),
            rdRow(['A', '"a"', 'LogicalKeyboardKey.keyA']),
            rdRow(['Shift+A', '"A"', 'LogicalKeyboardKey.keyA']),
            rdRow(['Enter', 'null', 'LogicalKeyboardKey.enter']),
            rdRow(['Space', '" "', 'LogicalKeyboardKey.space']),
            rdRow(['F1', 'null', 'LogicalKeyboardKey.f1']),
            rdRow(['Dead ´', 'null', 'platform dependent']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Auto-repeat ━━━━━━
  print('[rd-10] Section 10: Auto-repeat');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('10', 'Auto-Repeat Events'),
      rdNote(
        'When a key is held, the OS sends repeat events. RawKeyDownEvent '
        'fires repeatedly with repeat=true. The first press has repeat=false. '
        'Use this to distinguish initial press from hold-to-repeat behavior.',
      ),
      rdCard(
        'Repeat Timeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rdTimelineEvent('T+0ms', 'Key down', 'repeat: false', abyss),
            _rdTimelineEvent('T+500ms', 'Repeat start', 'repeat: true', deepOcean),
            _rdTimelineEvent('T+530ms', 'Repeat', 'repeat: true', ocean),
            _rdTimelineEvent('T+560ms', 'Repeat', 'repeat: true', tidal),
            _rdTimelineEvent('T+590ms', 'Repeat', 'repeat: true', iceBlue),
            _rdTimelineEvent('T+???ms', 'Key up', 'RawKeyUpEvent', surf),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Migration path ━━━━━━
  print('[rd-11] Section 11: Migration');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('11', 'Migration to KeyDownEvent'),
      rdNote(
        'To migrate from RawKeyDownEvent to KeyDownEvent: (1) Replace '
        'RawKeyboardListener with KeyboardListener, (2) Change onKey '
        'to onKeyEvent, (3) Use KeyDownEvent type check instead of '
        'RawKeyDownEvent, (4) Access properties directly from KeyEvent.',
      ),
      rdCard(
        'Migration Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rdMigrationStep('1', 'RawKeyboardListener → KeyboardListener', abyss),
            _rdMigrationStep('2', 'onKey → onKeyEvent', deepOcean),
            _rdMigrationStep('3', 'event is RawKeyDownEvent → event is KeyDownEvent', ocean),
            _rdMigrationStep('4', 'event.data.logicalKey → event.logicalKey', tidal),
            _rdMigrationStep('5', 'event.isShiftPressed → HardwareKeyboard.instance...', iceBlue),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Common patterns ━━━━━━
  print('[rd-12] Section 12: Common patterns');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('12', 'Common RawKeyDownEvent Patterns'),
      rdNote(
        'Typical uses: checking for specific keys, detecting Ctrl+key '
        'combos, arrow key navigation, escape to close. All these patterns '
        'have equivalents in the new system.',
      ),
      rdCard(
        'Code Patterns',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: foam,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rdCodeLine('// Old: check Ctrl+S', abyss),
              _rdCodeLine('if (event is RawKeyDownEvent &&', ocean),
              _rdCodeLine('    event.isControlPressed &&', ocean),
              _rdCodeLine('    event.logicalKey ==', tidal),
              _rdCodeLine('        LogicalKeyboardKey.keyS) {', tidal),
              _rdCodeLine('  save();', iceBlue),
              _rdCodeLine('}', ocean),
              const SizedBox(height: 8),
              _rdCodeLine('// New: equivalent', abyss),
              _rdCodeLine('if (event is KeyDownEvent &&', ocean),
              _rdCodeLine('    HardwareKeyboard.instance', ocean),
              _rdCodeLine('        .isControlPressed &&', tidal),
              _rdCodeLine('    event.logicalKey ==', tidal),
              _rdCodeLine('        LogicalKeyboardKey.keyS) {', tidal),
              _rdCodeLine('  save();', iceBlue),
              _rdCodeLine('}', ocean),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Platform differences ━━━━━━
  print('[rd-13] Section 13: Platform differences');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('13', 'Platform Differences'),
      rdNote(
        'Key down events differ across platforms. Web may fire events for '
        'IME composition keys that native platforms don\'t. macOS sends '
        'different modifier key events than Windows. Linux varies by '
        'display server (X11 vs Wayland).',
      ),
      rdCard(
        'Platform Quirks',
        Column(
          children: [
            rdRow(['Platform', 'Quirk', 'Impact'], isHeader: true),
            rdRow(['Web', 'IME composition events', 'Extra key downs']),
            rdRow(['macOS', 'Fn key as modifier', 'Different mapping']),
            rdRow(['Windows', 'AltGr = Ctrl+Alt', 'Modifier confusion']),
            rdRow(['Linux/X11', 'X keysym mapping', 'Layout dependent']),
            rdRow(['Linux/Wayland', 'Different key model', 'Timing differs']),
            rdRow(['Android', 'Volume keys as HW', 'May reach app']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Debugging ━━━━━━
  print('[rd-14] Section 14: Debugging');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('14', 'Debugging Key Events'),
      rdNote(
        'Debug key events by adding RawKeyboard.instance.addListener() '
        'and printing event details — logicalKey, physicalKey, character, '
        'modifiers. Or use the new ServicesBinding.instance.keyboard '
        'for the KeyEvent stream.',
      ),
      rdCard(
        'Debug Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rdCheckItem('Print logicalKey for each event', abyss),
            _rdCheckItem('Verify physicalKey matches expected', deepOcean),
            _rdCheckItem('Check repeat flag on hold events', ocean),
            _rdCheckItem('Test modifier combinations', tidal),
            _rdCheckItem('Run on target platform (not just desktop)', iceBlue),
            _rdCheckItem('Verify character output for text keys', surf),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[rd-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('15', 'Testing Key Events'),
      rdNote(
        'In widget tests, simulate key events with '
        'tester.sendKeyDownEvent(LogicalKeyboardKey.keyA). For the old '
        'system, use simulateKeyDownEvent(). Both trigger the event '
        'dispatch pipeline in tests.',
      ),
      rdCard(
        'Test Methods',
        Column(
          children: [
            rdRow(['Method', 'System', 'Usage'], isHeader: true),
            rdRow(['sendKeyDownEvent', 'New', 'tester.sendKeyDownEvent(key)']),
            rdRow(['sendKeyUpEvent', 'New', 'tester.sendKeyUpEvent(key)']),
            rdRow(['simulateKeyDownEvent', 'Old', 'simulateKeyDownEvent(key)']),
            rdRow(['simulateKeyUpEvent', 'Old', 'simulateKeyUpEvent(key)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[rd-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rdBanner('16', 'Summary Dashboard'),
      rdCard(
        'RawKeyDownEvent — Complete',
        Column(
          children: [
            rdRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            rdRow(['What', 'S01', 'Deprecated key-down event']),
            rdRow(['Old vs New', 'S02', 'RawKeyboard → HardwareKeyboard']),
            rdRow(['Dispatch', 'S03', 'Platform → engine → focus tree']),
            rdRow(['Data', 'S04', 'Per-platform RawKeyEventData']),
            rdRow(['Properties', 'S05', 'logicalKey + physicalKey']),
            rdRow(['Modifiers', 'S06', 'Bitmask with known issues']),
            rdRow(['Focus', 'S07', 'RawKeyboardListener (deprecated)']),
            rdRow(['Shortcuts', 'S08', 'LogicalKeySet (old activator)']),
            rdRow(['Characters', 'S09', 'Nullable for non-text keys']),
            rdRow(['Repeat', 'S10', 'repeat flag for held keys']),
            rdRow(['Migration', 'S11', '5-step conversion to KeyEvent']),
            rdRow(['Patterns', 'S12', 'Old vs new code side-by-side']),
            rdRow(['Platforms', 'S13', 'Web/macOS/Windows/Linux quirks']),
            rdRow(['Debug', 'S14', 'Print + check modifiers']),
            rdRow(['Testing', 'S15', 'simulateKeyDownEvent']),
          ],
        ),
      ),
      rdCard(
        'Ocean / Sky Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _rdColorSwatch('Ocean', ocean),
            _rdColorSwatch('Sky', sky),
            _rdColorSwatch('Tidal', tidal),
            _rdColorSwatch('Ice', iceBlue),
            _rdColorSwatch('Abyss', abyss),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [abyss, deepOcean],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('RawKeyDownEvent — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From deprecated key-down events through platform data, '
              'modifier tracking, focus integration, migration to KeyEvent, '
              'platform quirks, debugging, and testing — the full story.',
              style: TextStyle(color: paleSky, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[rd] palette: $surf, $mist, $paleSky, $foam');
  print('[rd] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RawKeyDownEvent — Old Key System'),
        backgroundColor: abyss,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5FAFF),
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

Widget _rdClassBox(String name, String role, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 6),
        Text(role,
            style: TextStyle(
                fontSize: 9, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _rdPipelineStep(int num, String layer, String action, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
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
        SizedBox(
          width: 65,
          child: Text(layer,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(action,
              style: TextStyle(
                  fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _rdTimelineEvent(String time, String event, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(time,
              style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: color,
                  fontWeight: FontWeight.w600)),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text('$event  —  $detail',
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rdMigrationStep(String num, String desc, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rdCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _rdCheckItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rdColorSwatch(String name, Color color) {
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
