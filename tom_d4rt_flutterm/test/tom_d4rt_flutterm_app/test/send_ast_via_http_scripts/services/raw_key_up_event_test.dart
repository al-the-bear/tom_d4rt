// ignore_for_file: avoid_print
// D4rt deep demo: RawKeyUpEvent — the deprecated key-up event from
// the old RawKeyboard system, fired when a physical key is released.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Indigo / Periwinkle palette ───
  const Color indigo = Color(0xFF4338CA);
  const Color periwinkle = Color(0xFFA5B4FC);
  const Color deepIndigo = Color(0xFF3730A3);
  const Color paleViolet = Color(0xFFE0E7FF);
  const Color iris = Color(0xFF4F46E5);
  const Color lavender = Color(0xFFC7D2FE);
  const Color violet = Color(0xFF6366F1);
  const Color midnight = Color(0xFF312E81);
  const Color lilac = Color(0xFFEEF2FF);
  const Color amethyst = Color(0xFF7C3AED);

  print('[ru] ===== RAW KEY UP EVENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget ruBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midnight, deepIndigo],
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
              color: iris,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: periwinkle, width: 1.5),
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

  Widget ruNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lilac,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lavender),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: midnight.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget ruCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: periwinkle.withValues(alpha: 0.3)),
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
              color: indigo.withValues(alpha: 0.06),
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

  Widget ruRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? indigo.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: periwinkle.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? midnight : deepIndigo)),
          );
        }).toList(),
      ),
    );
  }

  Widget ruFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? midnight : deepIndigo,
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
          child: Icon(Icons.arrow_forward, size: 12, color: iris),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is RawKeyUpEvent? ━━━━━━
  print('[ru-01] Section 1: What is RawKeyUpEvent?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('01', 'What Is RawKeyUpEvent?'),
      ruNote(
        'RawKeyUpEvent is the counterpart to RawKeyDownEvent — it fires when '
        'a physical key is released. Together they form the complete key '
        'press lifecycle: down → (repeat) → up. Deprecated in favor of '
        'KeyUpEvent via HardwareKeyboard.',
      ),
      ruCard(
        'Event Pairing',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ruFlow(['RawKeyDownEvent', 'repeat...', 'RawKeyUpEvent']),
            const SizedBox(height: 10),
            _ruEventBlock('RawKeyDownEvent', 'Key pressed', Icons.arrow_downward, midnight),
            _ruEventBlock('repeat × N', 'Key held', Icons.repeat, deepIndigo),
            _ruEventBlock('RawKeyUpEvent', 'Key released', Icons.arrow_upward, indigo),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Down vs Up ━━━━━━
  print('[ru-02] Section 2: Down vs Up');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('02', 'Key Down vs Key Up'),
      ruNote(
        'RawKeyDownEvent fires on press and repeat; RawKeyUpEvent fires '
        'once on release. Most keyboard logic uses down events. Up events '
        'matter for: (1) modifier release tracking, (2) long-press detection, '
        '(3) key-pair matching (e.g., gamepad-style controls).',
      ),
      ruCard(
        'Comparison',
        Column(
          children: [
            ruRow(['Aspect', 'RawKeyDownEvent', 'RawKeyUpEvent'], isHeader: true),
            ruRow(['Fires on', 'Press + repeat', 'Release only']),
            ruRow(['Frequency', 'Many per hold', 'Once per key']),
            ruRow(['repeat flag', 'true on hold', 'Always false']),
            ruRow(['character', 'May have value', 'Often null']),
            ruRow(['Typical use', 'Trigger actions', 'Release tracking']),
            ruRow(['Skip-able?', 'Rarely', 'Often']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: When up matters ━━━━━━
  print('[ru-03] Section 3: When up matters');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('03', 'When Key Up Events Matter'),
      ruNote(
        'Key up events are essential for: tracking modifier release (Shift '
        'up means typing becomes lowercase), implementing hold-and-release '
        'patterns (camera shutter button), and games where key-up stops '
        'movement.',
      ),
      ruCard(
        'Use Cases',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ruUseCase('Modifier tracking', 'Know when Shift is released', midnight),
            _ruUseCase('Hold-to-act', 'Record while held, stop on up', deepIndigo),
            _ruUseCase('Game controls', 'Move on down, stop on up', indigo),
            _ruUseCase('Piano keyboard', 'Note on → note off', iris),
            _ruUseCase('Long press', 'Measure down-to-up duration', violet),
            _ruUseCase('Key pairs', 'Match each down with its up', amethyst),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Event structure ━━━━━━
  print('[ru-04] Section 4: Event structure');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('04', 'Event Data Structure'),
      ruNote(
        'RawKeyUpEvent carries the same data field (RawKeyEventData) as '
        'RawKeyDownEvent. The logicalKey, physicalKey, and platform-specific '
        'data are all available. The repeat field is always false on up events.',
      ),
      ruCard(
        'Properties on Up Event',
        Column(
          children: [
            ruRow(['Property', 'Value', 'Notes'], isHeader: true),
            ruRow(['logicalKey', 'Same as down', 'The key released']),
            ruRow(['physicalKey', 'Same as down', 'The hardware key']),
            ruRow(['character', 'Often null', 'No char on release']),
            ruRow(['repeat', 'false', 'Always false']),
            ruRow(['data', 'Platform data', 'Same subclass type']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Focus tree dispatch ━━━━━━
  print('[ru-05] Section 5: Focus dispatch');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('05', 'Focus Tree Dispatch'),
      ruNote(
        'RawKeyUpEvent dispatches through the same focus tree path as the '
        'corresponding down event. If focus changed between down and up, '
        'the up event goes to the new focus — not the original handler.',
      ),
      ruCard(
        'Dispatch Scenarios',
        Column(
          children: [
            ruRow(['Scenario', 'Down goes to', 'Up goes to'], isHeader: true),
            ruRow(['Focus stays', 'FocusNode A', 'FocusNode A']),
            ruRow(['Focus changes', 'FocusNode A', 'FocusNode B']),
            ruRow(['Focus lost', 'FocusNode A', 'Root scope']),
            ruRow(['Widget removed', 'FocusNode A', 'Lost / no handler']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Modifier release ━━━━━━
  print('[ru-06] Section 6: Modifier release');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('06', 'Modifier Key Release'),
      ruNote(
        'When a modifier key is released, RawKeyUpEvent fires with that '
        'modifier\'s logicalKey. The old system updated its internal modifier '
        'state on this event. Known bug: if the app lost focus during a hold, '
        'the up event was never received and modifiers got "stuck".',
      ),
      ruCard(
        'Modifier Up Behavior',
        Column(
          children: [
            ruRow(['Modifier', 'Down event', 'Up event'], isHeader: true),
            ruRow(['Shift', 'isShiftPressed=true', 'isShiftPressed=false']),
            ruRow(['Ctrl', 'isControlPressed=true', 'isControlPressed=false']),
            ruRow(['Alt', 'isAltPressed=true', 'isAltPressed=false']),
            ruRow(['Meta', 'isMetaPressed=true', 'isMetaPressed=false']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Missing up events ━━━━━━
  print('[ru-07] Section 7: Missing up events');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('07', 'Missing Up Events'),
      ruNote(
        'Up events can be lost: (1) app loses focus while key is held — OS '
        'sends up to the new foreground app, (2) Bluetooth keyboard disconnect, '
        '(3) system key intercepts (PrintScreen, media keys). Always handle '
        'the case where up never arrives.',
      ),
      ruCard(
        'Missing Event Causes',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ruWarningItem('App background', 'OS redirects up event', midnight),
            _ruWarningItem('BT disconnect', 'No release signal', deepIndigo),
            _ruWarningItem('System intercept', 'OS consumed the key', indigo),
            _ruWarningItem('IME takeover', 'Composition absorbs keys', iris),
            _ruWarningItem('Hot plug', 'Keyboard removed mid-press', violet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Down-up pairing ━━━━━━
  print('[ru-08] Section 8: Down-up pairing');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('08', 'Down-Up Event Pairing'),
      ruNote(
        'Match down and up events using physicalKey — it uniquely identifies '
        'the hardware key. LogicalKey can change between down and up if '
        'modifiers change (e.g., Shift pressed between down and up). '
        'PhysicalKey stays constant.',
      ),
      ruCard(
        'Pairing Strategy',
        Column(
          children: [
            ruRow(['Key', 'Reliable?', 'Reason'], isHeader: true),
            ruRow(['physicalKey', 'Yes', 'Hardware identity stable']),
            ruRow(['logicalKey', 'No', 'Layout-dependent, can change']),
            ruRow(['character', 'No', 'May differ or be null']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Games and continuous input ━━━━━━
  print('[ru-09] Section 9: Games input');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('09', 'Game & Continuous Input'),
      ruNote(
        'Games track a set of currently-pressed keys: add to set on down, '
        'remove on up. The game loop reads the set each frame to determine '
        'movement. Missing up events cause stuck movement — add a timeout '
        'or focus-loss handler as fallback.',
      ),
      ruCard(
        'Game Key Tracking',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lilac,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ruCodeLine('final pressed = <PhysicalKeyboardKey>{};', midnight),
              _ruCodeLine('', midnight),
              _ruCodeLine('void onKey(RawKeyEvent event) {', deepIndigo),
              _ruCodeLine('  if (event is RawKeyDownEvent) {', indigo),
              _ruCodeLine('    pressed.add(event.physicalKey);', iris),
              _ruCodeLine('  } else if (event is RawKeyUpEvent) {', indigo),
              _ruCodeLine('    pressed.remove(event.physicalKey);', iris),
              _ruCodeLine('  }', indigo),
              _ruCodeLine('}', deepIndigo),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Long press timing ━━━━━━
  print('[ru-10] Section 10: Long press');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('10', 'Long Press Detection'),
      ruNote(
        'Measure key-hold duration by recording DateTime on down, computing '
        'delta on up. Note: RawKeyEvent does not carry timestamps — you '
        'must capture the wall clock yourself. The new KeyEvent system '
        'includes a timeStamp field.',
      ),
      ruCard(
        'Timing Comparison',
        Column(
          children: [
            ruRow(['System', 'Has Timestamp?', 'Method'], isHeader: true),
            ruRow(['RawKeyEvent', 'No', 'Use DateTime.now() manually']),
            ruRow(['KeyEvent', 'Yes', 'event.timeStamp (Duration)']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Migration ━━━━━━
  print('[ru-11] Section 11: Migration');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('11', 'Migration to KeyUpEvent'),
      ruNote(
        'Replace RawKeyUpEvent checks with KeyUpEvent. The new system '
        'guarantees paired events and tracks pressed keys via '
        'HardwareKeyboard.instance.physicalKeysPressed. Modifier state '
        'is always accurate.',
      ),
      ruCard(
        'Migration Map',
        Column(
          children: [
            ruRow(['Old', 'New'], isHeader: true),
            ruRow(['event is RawKeyUpEvent', 'event is KeyUpEvent']),
            ruRow(['RawKeyboardListener', 'KeyboardListener']),
            ruRow(['onKey:', 'onKeyEvent:']),
            ruRow(['Manual key set', 'physicalKeysPressed']),
            ruRow(['Check isShiftPressed', 'HardwareKeyboard.isShiftPressed']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Keyboard state tracking ━━━━━━
  print('[ru-12] Section 12: State tracking');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('12', 'Keyboard State Tracking'),
      ruNote(
        'The old RawKeyboard maintained an internal set of pressed keys, '
        'updated by down/up events. The new HardwareKeyboard.instance '
        'provides physicalKeysPressed and logicalKeysPressed with '
        'automatic cleanup on focus loss.',
      ),
      ruCard(
        'State APIs',
        Column(
          children: [
            ruRow(['API', 'System', 'Type'], isHeader: true),
            ruRow(['RawKeyboard.instance.keysPressed', 'Old', 'Set<LogicalKey>']),
            ruRow(['HardwareKeyboard.physicalKeysPressed', 'New', 'Set<PhysicalKey>']),
            ruRow(['HardwareKeyboard.logicalKeysPressed', 'New', 'Set<LogicalKey>']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Platform behavior ━━━━━━
  print('[ru-13] Section 13: Platform behavior');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('13', 'Platform-Specific Up Behavior'),
      ruNote(
        'Not all platforms send up events equally. Web may skip up for '
        'some system keys. Android may not send up for volume keys that '
        'the system handles. macOS sends up for modifier keys but with '
        'different timing than regular keys.',
      ),
      ruCard(
        'Platform Up Event Behavior',
        Column(
          children: [
            ruRow(['Platform', 'Regular keys', 'Modifiers', 'System keys'], isHeader: true),
            ruRow(['Android', 'Always', 'Always', 'Sometimes missing']),
            ruRow(['iOS', 'Always', 'Always', 'N/A (intercepted)']),
            ruRow(['macOS', 'Always', 'Delayed', 'Intercepted']),
            ruRow(['Windows', 'Always', 'Always', 'Some missing']),
            ruRow(['Linux', 'Always', 'Always', 'WM-dependent']),
            ruRow(['Web', 'Usually', 'Usually', 'Browser intercepts']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Testing up events ━━━━━━
  print('[ru-14] Section 14: Testing');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('14', 'Testing Key Up Events'),
      ruNote(
        'In widget tests, always send matching up events for every down. '
        'Use tester.sendKeyUpEvent(key) after sendKeyDownEvent(key). '
        'Mismatched pairs leave the test keyboard in a dirty state, '
        'causing unpredictable behavior in subsequent tests.',
      ),
      ruCard(
        'Test Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: lilac,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ruCodeLine('// Always pair down + up', midnight),
              _ruCodeLine('await tester.sendKeyDownEvent(', deepIndigo),
              _ruCodeLine('  LogicalKeyboardKey.keyA,', deepIndigo),
              _ruCodeLine(');', deepIndigo),
              _ruCodeLine('await tester.pump();', indigo),
              _ruCodeLine('// ... verify down handled ...', iris),
              _ruCodeLine('await tester.sendKeyUpEvent(', deepIndigo),
              _ruCodeLine('  LogicalKeyboardKey.keyA,', deepIndigo),
              _ruCodeLine(');', deepIndigo),
              _ruCodeLine('await tester.pump();', indigo),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Edge cases ━━━━━━
  print('[ru-15] Section 15: Edge cases');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('15', 'Edge Cases & Gotchas'),
      ruNote(
        'Edge cases: (1) Multiple keys held simultaneously — each gets its '
        'own up event, (2) Key up during text field composition — may be '
        'swallowed, (3) Screen lock while key held — up never arrives, '
        '(4) Remote desktop — extra latency between down and up.',
      ),
      ruCard(
        'Edge Case Matrix',
        Column(
          children: [
            ruRow(['Case', 'Behavior', 'Workaround'], isHeader: true),
            ruRow(['Multi-key up', 'Each key fires own up', 'Track by physicalKey']),
            ruRow(['IME swallow', 'Up not delivered', 'Ignore during compose']),
            ruRow(['Screen lock', 'No up event', 'Clear on focus loss']),
            ruRow(['Remote desktop', 'Delayed up', 'Add timeout fallback']),
            ruRow(['Key remapping', 'Up may differ', 'Compare physicalKey']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[ru-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('16', 'Summary Dashboard'),
      ruCard(
        'RawKeyUpEvent — Complete',
        Column(
          children: [
            ruRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            ruRow(['What', 'S01', 'Key release event (deprecated)']),
            ruRow(['Down vs Up', 'S02', 'One up per press cycle']),
            ruRow(['When needed', 'S03', 'Modifiers, games, hold patterns']),
            ruRow(['Structure', 'S04', 'Same data as down, repeat=false']),
            ruRow(['Focus', 'S05', 'Goes to current focus (may differ)']),
            ruRow(['Modifiers', 'S06', 'Up clears modifier state']),
            ruRow(['Missing', 'S07', 'Lost on bg, BT, system intercept']),
            ruRow(['Pairing', 'S08', 'Use physicalKey to match']),
            ruRow(['Games', 'S09', 'Add/remove from pressed set']),
            ruRow(['Long press', 'S10', 'Manual timing (no timestamp)']),
            ruRow(['Migration', 'S11', 'KeyUpEvent + HardwareKeyboard']),
            ruRow(['State', 'S12', 'physicalKeysPressed (new API)']),
            ruRow(['Platforms', 'S13', 'System keys may miss up']),
            ruRow(['Testing', 'S14', 'Always pair down + up']),
            ruRow(['Edge cases', 'S15', 'Multi-key, IME, lock, remote']),
          ],
        ),
      ),
      ruCard(
        'Indigo / Periwinkle Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ruColorSwatch('Indigo', indigo),
            _ruColorSwatch('Peri', periwinkle),
            _ruColorSwatch('Iris', iris),
            _ruColorSwatch('Violet', violet),
            _ruColorSwatch('Night', midnight),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [midnight, deepIndigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('RawKeyUpEvent — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From deprecated key-up events through modifier tracking, '
              'missing event handling, game input, long-press detection, '
              'migration, platform quirks, and testing practices.',
              style: TextStyle(color: paleViolet, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[ru] palette: $amethyst, $lavender, $paleViolet, $lilac');
  print('[ru] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RawKeyUpEvent — Key Release'),
        backgroundColor: midnight,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF7F7FF),
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

Widget _ruEventBlock(String title, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(
                  fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _ruUseCase(String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ruWarningItem(String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(Icons.warning_amber_rounded, size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ruCodeLine(String text, Color color) {
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

Widget _ruColorSwatch(String name, Color color) {
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
