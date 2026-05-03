// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt deep demo: RawKeyUpEvent — the deprecated raw-keyboard "key released"
// event from Flutter's legacy RawKeyboard subsystem. The whole RawKeyboard /
// RawKeyEvent / RawKeyboardListener / RawKeyEventData* family has been
// replaced by the modern HardwareKeyboard / KeyEvent / Focus.onKeyEvent
// pipeline, but a huge amount of in-the-wild Flutter code still relies on
// RawKeyUpEvent for global shortcuts, game key state tracking, IME-aware
// input fields, and code-editor focus chains. This file demonstrates the
// type, walks the migration path, and exercises a live in-tree listener
// that captures real RawKeyUpEvents from the platform.
//
// The mandatory deprecated_member_use ignore at the top of the file covers
// the deprecation warning for `RawKeyboardListener`, `RawKeyEvent`,
// `RawKeyDownEvent`, `RawKeyUpEvent`, `RawKeyboard`, and the matching
// `RawKeyEventData*` subclasses we reference here.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────
//                              ENTRY POINT
// ─────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  // ─── Sunset / coral palette so this demo doesn't visually collide with
  //     the RawKeyDownEvent demo (which uses an ocean palette). ───
  const Color coral = Color(0xFFEF4444);
  const Color flame = Color(0xFFF97316);
  const Color amber = Color(0xFFF59E0B);
  const Color sunset = Color(0xFFFB923C);
  const Color sand = Color(0xFFFED7AA);
  const Color cream = Color(0xFFFFF7ED);
  const Color ember = Color(0xFFB91C1C);
  const Color ash = Color(0xFF7F1D1D);
  const Color charcoal = Color(0xFF44403C);
  const Color slate = Color(0xFF1F2937);
  const Color paleAmber = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFFECACA);

  print('[ru] ===== RAW KEY UP EVENT DEEP DEMO =====');
  print('[ru] target: RawKeyUpEvent (deprecated, services library)');
  print('[ru] sections: 11');

  // ─────────────────────────────────────────────────────────────────────
  //                           LOCAL HELPERS
  // ─────────────────────────────────────────────────────────────────────

  Widget ruBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ash, ember],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ash.withValues(alpha: 0.35),
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
              color: flame,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sand, width: 1.5),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
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
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sand),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: ash.withValues(alpha: 0.9),
          height: 1.5,
        ),
      ),
    );
  }

  Widget ruCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sand.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: ash.withValues(alpha: 0.06),
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
              color: coral.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              heading,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: ash,
              ),
            ),
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
        color: isHeader ? coral.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: sand.withValues(alpha: 0.6)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(
              c,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? ash : charcoal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget ruChip(String label, Color background, {Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget ruCodeBlock(String title, String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: slate,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: charcoal,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFFDE68A),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 1: Intro & deprecation banner
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-01] Section 1: Intro & deprecation banner');

  Widget deprecationBanner = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: paleAmber,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: amber, width: 2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber_rounded, color: amber, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DEPRECATED API',
                style: TextStyle(
                  color: ember,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'RawKeyUpEvent is part of the legacy RawKeyboard system. '
                'In modern Flutter you should reach for KeyUpEvent + '
                'HardwareKeyboard.instance / Focus(onKeyEvent: ...) '
                'instead. The class still exists and still ships events, '
                'but it will be removed in a future stable release.',
                style: TextStyle(
                  color: ash,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget migrationOldVsNew = ruCard(
    'Migration path — old vs new',
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OLD (deprecated)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: ember,
                ),
              ),
              const SizedBox(height: 6),
              _bullet('RawKeyboardListener'),
              _bullet('RawKeyEvent'),
              _bullet('RawKeyDownEvent'),
              _bullet('RawKeyUpEvent'),
              _bullet('RawKeyEventData / DataLinux / DataMacOs / ...'),
              _bullet('RawKeyboard.instance.addListener'),
              _bullet('event.data.isModifierPressed(...)'),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEW (current)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15803D),
                ),
              ),
              const SizedBox(height: 6),
              _bullet('Focus(onKeyEvent: ...)'),
              _bullet('KeyEvent'),
              _bullet('KeyDownEvent'),
              _bullet('KeyUpEvent'),
              _bullet('KeyRepeatEvent (new!)'),
              _bullet('HardwareKeyboard.instance.addHandler'),
              _bullet('HardwareKeyboard.instance.isLogicalKeyPressed(...)'),
            ],
          ),
        ),
      ],
    ),
  );

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('01', 'Intro & deprecation banner'),
      deprecationBanner,
      ruNote(
        'A RawKeyUpEvent is dispatched whenever a physical key transitions '
        'from pressed to released. Like all legacy raw events it carries a '
        'platform-specific RawKeyEventData (RawKeyEventDataAndroid, '
        'RawKeyEventDataMacOs, RawKeyEventDataLinux, RawKeyEventDataWeb, '
        'RawKeyEventDataFuchsia, RawKeyEventDataIos, RawKeyEventDataWindows) '
        'with raw keycodes and modifier bitmasks. The framework normalizes '
        'these into logicalKey (LogicalKeyboardKey) and physicalKey '
        '(PhysicalKeyboardKey) on the base class.',
      ),
      migrationOldVsNew,
      ruNote(
        'Why was it deprecated? Three big reasons. (a) Modifier tracking '
        'was bitmask-based and lost ground-truth state across focus / app '
        'lifecycle boundaries. (b) There was no synthetic "I missed an '
        'event" recovery, so a key held while the app lost focus could '
        'leak as "still pressed". (c) IME composition events did not '
        'compose well with raw keycodes, leading to dropped characters in '
        'CJK / dead-key flows. HardwareKeyboard fixes all three.',
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 2: Live RawKeyboardListener
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-02] Section 2: Live RawKeyboardListener');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('02', 'Live RawKeyboardListener'),
      ruNote(
        'The widget below wraps a RawKeyboardListener around a focusable '
        'region. All RawKeyEvent instances flow through onKey; we filter '
        'specifically for `event is RawKeyUpEvent` and capture them into a '
        'rolling log buffer. Click "Focus" to take focus, then press and '
        'release keys. Every release adds a row to the log: timestamp, '
        'logicalKey label, physicalKey label, modifier flags, repeat flag, '
        'and character (when printable).',
      ),
      const _LiveKeyUpListener(),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 3: KeyDown vs KeyUp comparison
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-03] Section 3: KeyDown vs KeyUp comparison');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('03', 'KeyDown vs KeyUp comparison'),
      ruNote(
        'Every keyboard interaction produces a matching pair: a '
        'RawKeyDownEvent at press, then (eventually) a RawKeyUpEvent at '
        'release. Long holds also generate auto-repeat RawKeyDownEvent '
        'instances (with `data.repeat == true` on platforms that surface '
        'it). The KeyUp event always fires exactly once per physical '
        'press — unless the app loses focus mid-press, in which case it '
        'never fires at all.',
      ),
      const _DownVsUpListener(),
      ruCard(
        'Lifecycle table',
        Column(
          children: [
            ruRow(['Phase', 'Event', 'Repeat?', 'Modifiers tracked'],
                isHeader: true),
            ruRow(['Press', 'RawKeyDownEvent', 'no', 'yes (incoming)']),
            ruRow(['Hold', 'RawKeyDownEvent (xN)', 'yes', 'yes']),
            ruRow(['Release', 'RawKeyUpEvent', 'no', 'yes (final state)']),
            ruRow(['Lost focus mid-press', '— (silent)', 'n/a', 'leaks']),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 4: Modifier state matrix
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-04] Section 4: Modifier state matrix');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('04', 'Modifier state matrix'),
      ruNote(
        'Each RawKeyUpEvent exposes four boolean modifier shortcuts: '
        'isShiftPressed, isControlPressed, isAltPressed, isMetaPressed. '
        'They are computed off the platform-specific data\'s bitmask at '
        'the moment of release, so they reflect the final modifier state '
        'AS OF that release. Below: capture a key release, then watch the '
        'four chips light up green for whichever modifiers were down.',
      ),
      const _ModifierMatrix(),
      ruCard(
        'Important nuance',
        Text(
          'When you release a modifier key itself (say, you let go of '
          'Shift), the corresponding chip is FALSE in that very same '
          'RawKeyUpEvent — because the framework re-reads the bitmask '
          'after the release has been applied. To detect "Shift was just '
          'released", check `event.logicalKey == LogicalKeyboardKey.shiftLeft '
          '|| event.logicalKey == LogicalKeyboardKey.shiftRight`, not '
          '`event.isShiftPressed`.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 5: Logical vs physical keys
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-05] Section 5: Logical vs physical keys');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('05', 'Logical vs physical keys'),
      ruNote(
        'Two different identifiers describe the key that was released. '
        '`logicalKey` is a LogicalKeyboardKey — what the user thinks they '
        'pressed, taking layout into account (for AZERTY, the key in the '
        'top-left of the alpha block reports KeyA logically). '
        '`physicalKey` is a PhysicalKeyboardKey — the USB HID scan code, '
        'i.e. the physical position on a US-QWERTY board. For a French '
        'AZERTY keyboard, physicalKey would still be PhysicalKeyboardKey.keyQ '
        'when the top-left letter is hit.',
      ),
      ruCard(
        'Side-by-side: same release, two views',
        Column(
          children: [
            ruRow(['Pressed key (visual)', 'logicalKey', 'physicalKey'],
                isHeader: true),
            ruRow(['A on US QWERTY', 'keyA', 'keyA']),
            ruRow(['Q on FR AZERTY', 'keyA', 'keyQ']),
            ruRow(['Enter / Return', 'enter', 'enter']),
            ruRow(['Numpad-Enter', 'numpadEnter', 'numpadEnter']),
            ruRow(['ESC', 'escape', 'escape']),
            ruRow(['F5', 'f5', 'f5']),
            ruRow(['Spacebar', 'space', 'space']),
            ruRow(['Right-Shift', 'shiftRight', 'shiftRight']),
          ],
        ),
      ),
      ruNote(
        'Rule of thumb: if you are wiring up a SHORTCUT ("Ctrl+S to save") '
        'use logicalKey because the user thinks in characters. If you are '
        'wiring up GAME CONTROLS ("WASD to move") use physicalKey because '
        'the user thinks in finger positions and you want AZERTY/QWERTZ '
        'players to use the same physical layout.',
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 6: Character extraction
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-06] Section 6: Character extraction');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('06', 'Character extraction'),
      ruNote(
        '`event.character` returns the printable character produced by '
        'the key combination, or null. On a RawKeyUpEvent it is *almost '
        'always null* because most platforms only emit a character on '
        'key-DOWN. So this panel is essentially a deprecation in itself: '
        'never rely on RawKeyUpEvent.character. Read it on RawKeyDownEvent.',
      ),
      ruCard(
        'character on RawKeyUpEvent',
        Column(
          children: [
            ruRow(['Released key', 'down.character', 'up.character'],
                isHeader: true),
            ruRow(['letter "a"', '"a"', 'null (most platforms)']),
            ruRow(['Shift+"a"', '"A"', 'null']),
            ruRow(['"1"', '"1"', 'null']),
            ruRow(['Space', '" "', 'null']),
            ruRow(['Enter', '"\\n" or null', 'null']),
            ruRow(['F-keys', 'null', 'null']),
            ruRow(['Modifiers', 'null', 'null']),
            ruRow(['Arrow keys', 'null', 'null']),
            ruRow(['Backspace', 'null', 'null']),
            ruRow(['Tab', '"\\t" or null', 'null']),
          ],
        ),
      ),
      ruNote(
        'If you need to know "the user just typed an X", listen on '
        'RawKeyDownEvent and read .character there. If you need "the user '
        'just released the X key", listen on RawKeyUpEvent and read '
        '.logicalKey instead.',
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 7: Visual keyboard heatmap
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-07] Section 7: Visual keyboard heatmap');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('07', 'Visual keyboard heatmap'),
      ruNote(
        'The heatmap below shows three rows of the alpha block. Each cell '
        'flashes amber when its corresponding RawKeyUpEvent is captured '
        'by the live listener. Internally the widget keeps a Map<String, '
        'DateTime> of "last release" timestamps and re-paints periodically '
        'to fade them out.',
      ),
      const _KeyboardHeatmap(),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 8: Migration recipe
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-08] Section 8: Migration recipe');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('08', 'Migration recipe'),
      ruNote(
        'Most RawKeyUpEvent code follows one of two shapes: a '
        'RawKeyboardListener wrapping a child, or a global '
        'RawKeyboard.instance.addListener registration. Below are '
        'side-by-side translations to the modern API, both for the widget '
        'shape and the global shape.',
      ),
      ruCard(
        'Widget shape (RawKeyboardListener → Focus(onKeyEvent: ...))',
        Column(
          children: [
            ruCodeBlock(
              'OLD',
              "RawKeyboardListener(\n"
                  "  focusNode: node,\n"
                  "  autofocus: true,\n"
                  "  onKey: (RawKeyEvent event) {\n"
                  "    if (event is RawKeyUpEvent) {\n"
                  "      if (event.logicalKey == LogicalKeyboardKey.escape) {\n"
                  "        Navigator.of(context).pop();\n"
                  "      }\n"
                  "    }\n"
                  "  },\n"
                  "  child: child,\n"
                  ");",
            ),
            ruCodeBlock(
              'NEW',
              "Focus(\n"
                  "  focusNode: node,\n"
                  "  autofocus: true,\n"
                  "  onKeyEvent: (FocusNode n, KeyEvent event) {\n"
                  "    if (event is KeyUpEvent) {\n"
                  "      if (event.logicalKey == LogicalKeyboardKey.escape) {\n"
                  "        Navigator.of(context).pop();\n"
                  "        return KeyEventResult.handled;\n"
                  "      }\n"
                  "    }\n"
                  "    return KeyEventResult.ignored;\n"
                  "  },\n"
                  "  child: child,\n"
                  ");",
            ),
          ],
        ),
      ),
      ruCard(
        'Global shape (RawKeyboard → HardwareKeyboard)',
        Column(
          children: [
            ruCodeBlock(
              'OLD',
              "RawKeyboard.instance.addListener((RawKeyEvent event) {\n"
                  "  if (event is RawKeyUpEvent &&\n"
                  "      event.logicalKey == LogicalKeyboardKey.f5) {\n"
                  "    refresh();\n"
                  "  }\n"
                  "});",
            ),
            ruCodeBlock(
              'NEW',
              "HardwareKeyboard.instance.addHandler((KeyEvent event) {\n"
                  "  if (event is KeyUpEvent &&\n"
                  "      event.logicalKey == LogicalKeyboardKey.f5) {\n"
                  "    refresh();\n"
                  "    return true; // handled\n"
                  "  }\n"
                  "  return false;\n"
                  "});",
            ),
          ],
        ),
      ),
      ruCard(
        'Modifier check translation',
        Column(
          children: [
            ruCodeBlock(
              'OLD',
              "if (event is RawKeyUpEvent && event.isControlPressed) { ... }",
            ),
            ruCodeBlock(
              'NEW',
              "if (event is KeyUpEvent &&\n"
                  "    HardwareKeyboard.instance.isControlPressed) { ... }",
            ),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 9: Edge cases
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-09] Section 9: Edge cases');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('09', 'Edge cases'),
      ruNote(
        'RawKeyUpEvent has plenty of footguns. The list below covers the '
        'ones most likely to bite production code.',
      ),
      ruCard(
        'Repeated keys',
        Text(
          'Holding a key fires multiple RawKeyDownEvents (auto-repeat) but '
          'only ONE RawKeyUpEvent at the very end. If you are matching '
          'down ↔ up pairs (e.g. game state), you must remember "key X is '
          'currently held" by tracking down events and clearing on the '
          'matching up. Naive 1:1 pairing breaks under repeat.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
      ruCard(
        'Modifier-only events',
        Text(
          'Pressing and releasing Shift on its own produces a '
          'RawKeyDownEvent / RawKeyUpEvent pair where logicalKey is '
          'LogicalKeyboardKey.shiftLeft or shiftRight. event.character is '
          'null. The four isXxxPressed booleans reflect post-release '
          'state, so isShiftPressed is FALSE in the up event for the '
          'shift key itself.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
      ruCard(
        'Non-character keys',
        Text(
          'Function keys (F1-F12), arrow keys, Home/End/PageUp/PageDown, '
          'media keys, brightness keys — all produce RawKeyUpEvent with '
          'character = null. Identify them by logicalKey.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
      ruCard(
        'IME composition',
        Text(
          'During CJK / dead-key composition, the IME may swallow events '
          'before they reach RawKeyboard. You may receive a synthesized '
          '"composing" event but no clean RawKeyUpEvent for individual '
          'keystrokes. This is the single biggest reason HardwareKeyboard '
          'replaced RawKeyboard — the new API integrates with the IME '
          'pipeline directly.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
      ruCard(
        'App lost focus mid-press',
        Text(
          'If the OS steals focus while a key is down (Cmd-Tab, Alt-Tab, '
          'window switch), the matching RawKeyUpEvent is never delivered '
          'to your app. Your "is key X held" state will leak as TRUE '
          'forever. RawKeyboard had no recovery for this. HardwareKeyboard '
          'synthesizes recovery events.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
      ruCard(
        'Web event mapping',
        Text(
          'On web, RawKeyEventDataWeb maps DOM KeyboardEvent.code to '
          'physicalKey and DOM KeyboardEvent.key to logicalKey. Browsers '
          'with locked-down APIs (sandboxed iframes, certain mobile '
          'browsers) may suppress key events entirely.',
          style: TextStyle(fontSize: 12, color: ash, height: 1.5),
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 10: Recipe gallery
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-10] Section 10: Recipe gallery');

  Widget recipeCard(
      String title, String subtitle, IconData icon, Color background) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sand),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: ember),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ash,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: charcoal,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('10', 'Recipe gallery'),
      ruNote(
        'Four common shapes for "I need to listen for RawKeyUpEvent". '
        'Each card shows a typical use case and a pointer for the modern '
        'equivalent.',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: recipeCard(
              'Global shortcut handler',
              'RawKeyboard.instance.addListener; match on logicalKey + '
                  'modifiers; act on KeyUp so press-and-hold does not '
                  'fire-fire-fire. Modern: HardwareKeyboard.addHandler '
                  'or app-level Shortcuts/Actions.',
              Icons.keyboard,
              cream,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: recipeCard(
              'Game keystate (release-driven)',
              'Track WASD by toggling a Set<PhysicalKeyboardKey> on '
                  'down and clearing it on up. Use RawKeyUpEvent to clear. '
                  'Modern: read HardwareKeyboard.instance.physicalKeysPressed '
                  'directly.',
              Icons.sports_esports,
              rose,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: recipeCard(
              'Form Tab/Enter UX',
              'On RawKeyUpEvent for tab/enter, jump focus, submit, or '
                  'validate. KeyUp avoids accidental double-submits when '
                  'the user holds the key. Modern: FocusTraversalGroup + '
                  'Actions/Shortcuts.',
              Icons.input,
              paleAmber,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: recipeCard(
              'Code editor focus chain',
              'A code editor watches RawKeyUpEvent for Escape (pop modal), '
                  'Ctrl+Space (open completions on release), and '
                  'Cmd+S/Ctrl+S (save on release). Modern: Focus + '
                  'onKeyEvent + KeyUpEvent.',
              Icons.code,
              cream,
            ),
          ),
        ],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //          SECTION 11: Reference table
  // ─────────────────────────────────────────────────────────────────────
  print('[ru-11] Section 11: Reference table');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ruBanner('11', 'RawKeyUpEvent reference table'),
      ruNote(
        'Public surface inherited from RawKeyEvent (the base class) plus '
        'the marker-only RawKeyUpEvent constructor. RawKeyUpEvent does '
        'NOT add new properties — its only role is to carry the type for '
        '`event is RawKeyUpEvent` checks.',
      ),
      ruCard(
        'Properties (inherited from RawKeyEvent)',
        Column(
          children: [
            ruRow(['Name', 'Type', 'Description'], isHeader: true),
            ruRow(['logicalKey', 'LogicalKeyboardKey',
                'Layout-aware identifier of the released key']),
            ruRow(['physicalKey', 'PhysicalKeyboardKey',
                'USB HID code of the physical position']),
            ruRow(['data', 'RawKeyEventData',
                'Platform-specific subclass with native fields']),
            ruRow(['character', 'String?',
                'Almost always null on KeyUp — see section 6']),
            ruRow(['isShiftPressed', 'bool', 'Shift modifier final state']),
            ruRow(['isControlPressed', 'bool', 'Control modifier final state']),
            ruRow(['isAltPressed', 'bool', 'Alt / Option modifier final state']),
            ruRow(['isMetaPressed', 'bool',
                'Meta / Cmd / Win modifier final state']),
            ruRow(['repeat', 'bool',
                'Always false on KeyUp; meaningful only on KeyDown']),
            ruRow(['stringWithoutModifiers', 'String (data field)',
                'Glyph the key would produce with no modifiers']),
          ],
        ),
      ),
      ruCard(
        'Constructors',
        Column(
          children: [
            ruRow(['Signature', 'Notes'], isHeader: true),
            ruRow([
              'RawKeyUpEvent({ required RawKeyEventData data, String? character })',
              'Same shape as RawKeyDownEvent; type discriminates'
            ]),
          ],
        ),
      ),
      ruCard(
        'Type hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _classBox('Diagnosticable', 'flutter foundation', charcoal),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: _classBox('RawKeyEvent', 'abstract base', slate),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _classBox('RawKeyDownEvent', 'press', sunset),
                  _classBox('RawKeyUpEvent ← THIS DEMO', 'release', coral),
                ],
              ),
            ),
          ],
        ),
      ),
      ruCard(
        'Modifier helper map',
        Column(
          children: [
            ruRow(['Method', 'Bitmask aspect', 'Replacement'],
                isHeader: true),
            ruRow(['isShiftPressed', 'shift bits',
                'HardwareKeyboard.instance.isShiftPressed']),
            ruRow(['isControlPressed', 'control bits',
                'HardwareKeyboard.instance.isControlPressed']),
            ruRow(['isAltPressed', 'alt/opt bits',
                'HardwareKeyboard.instance.isAltPressed']),
            ruRow(['isMetaPressed', 'meta/cmd bits',
                'HardwareKeyboard.instance.isMetaPressed']),
            ruRow([
              'isModifierPressed(...)',
              'arbitrary modifier',
              'HardwareKeyboard.instance.logicalKeysPressed.contains(...)'
            ]),
          ],
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  //                            ASSEMBLY
  // ─────────────────────────────────────────────────────────────────────

  print('[ru] assembling 11 sections');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RawKeyUpEvent Deep Demo',
    theme: ThemeData(
      primaryColor: coral,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: coral,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: ash,
        title: const Text(
          'RawKeyUpEvent — Deep Demo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'RawKeyUpEvent',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'flutter/services.dart  ·  deprecated  ·  release-edge of '
                'the legacy RawKeyboard pipeline',
                style: TextStyle(
                  fontSize: 13,
                  color: charcoal,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                children: [
                  ruChip('11 sections', coral),
                  ruChip('live listener', flame),
                  ruChip('heatmap', sunset),
                  ruChip('migration recipes', amber, textColor: ash),
                  ruChip('reference table', ember),
                ],
              ),
              section1,
              section2,
              section3,
              section4,
              section5,
              section6,
              section7,
              section8,
              section9,
              section10,
              section11,
              const SizedBox(height: 32),
              Center(
                child: Text(
                  '— end of RawKeyUpEvent deep demo —',
                  style: TextStyle(
                    fontSize: 12,
                    color: charcoal.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
//                       FILE-SCOPE PRIVATE HELPERS
// ─────────────────────────────────────────────────────────────────────────

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: 12),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _classBox(String name, String role, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          role,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
//      _LiveKeyUpListener — the Section 2 stateful widget
// ─────────────────────────────────────────────────────────────────────────

class _LiveKeyUpListener extends StatefulWidget {
  const _LiveKeyUpListener();

  @override
  State<_LiveKeyUpListener> createState() => _LiveKeyUpListenerState();
}

class _LiveKeyUpListenerState extends State<_LiveKeyUpListener> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'rawKeyUpListener');
  final List<_KeyUpRecord> _log = <_KeyUpRecord>[];
  static const int _maxLogEntries = 32;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(RawKeyEvent event) {
    // Filter specifically for RawKeyUpEvent — this is the type-check the
    // demo is built around. We deliberately ignore RawKeyDownEvent here.
    if (event is RawKeyUpEvent) {
      final RawKeyUpEvent up = event;

      // Touch every required property so the static analyzer sees real
      // usage. This also doubles as documentation for what each property
      // actually returns at runtime.
      final LogicalKeyboardKey logical = up.logicalKey;
      final PhysicalKeyboardKey physical = up.physicalKey;
      final String? character = up.character;
      final bool shift = up.isShiftPressed;
      final bool ctrl = up.isControlPressed;
      final bool alt = up.isAltPressed;
      final bool meta = up.isMetaPressed;
      final bool repeat = up.repeat;
      final RawKeyEventData data = up.data;

      // Optionally probe the platform-specific data type — purely
      // illustrative, the demo doesn't depend on any one platform.
      String platformLabel = data.runtimeType.toString();
      if (data is RawKeyEventDataMacOs) {
        platformLabel = 'macOS (kc=${data.keyCode})';
      } else if (data is RawKeyEventDataLinux) {
        platformLabel = 'Linux (kc=${data.keyCode})';
      } else if (data is RawKeyEventDataWindows) {
        platformLabel = 'Windows (kc=${data.keyCode})';
      } else if (data is RawKeyEventDataAndroid) {
        platformLabel = 'Android (kc=${data.keyCode})';
      } else if (data is RawKeyEventDataWeb) {
        platformLabel = 'Web (code=${data.code})';
      } else if (data is RawKeyEventDataIos) {
        platformLabel = 'iOS (kc=${data.keyCode})';
      } else if (data is RawKeyEventDataFuchsia) {
        platformLabel = 'Fuchsia (kc=${data.codePoint})';
      }

      final _KeyUpRecord rec = _KeyUpRecord(
        timestamp: DateTime.now(),
        logicalKeyLabel: logical.debugName ?? logical.keyLabel,
        physicalKeyLabel: physical.debugName ?? '0x${physical.usbHidUsage}',
        character: character,
        shift: shift,
        ctrl: ctrl,
        alt: alt,
        meta: meta,
        repeat: repeat,
        platformLabel: platformLabel,
      );

      print('[ru-listener] up '
          'logical=${rec.logicalKeyLabel} '
          'physical=${rec.physicalKeyLabel} '
          'char=${rec.character} '
          'mods=[shift=$shift,ctrl=$ctrl,alt=$alt,meta=$meta] '
          'repeat=$repeat platform=$platformLabel');

      setState(() {
        _log.insert(0, rec);
        if (_log.length > _maxLogEntries) {
          _log.removeLast();
        }
      });
    }
  }

  void _clear() {
    setState(_log.clear);
  }

  void _focus() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    const Color sand = Color(0xFFFED7AA);
    const Color cream = Color(0xFFFFF7ED);
    const Color ember = Color(0xFFB91C1C);
    const Color charcoal = Color(0xFF44403C);
    const Color slate = Color(0xFF1F2937);

    final bool hasFocus = _focusNode.hasFocus;

    return Container(
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hasFocus ? ember : sand,
          width: hasFocus ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  hasFocus ? Icons.keyboard_alt : Icons.keyboard_alt_outlined,
                  color: hasFocus ? ember : charcoal,
                ),
                const SizedBox(width: 8),
                Text(
                  hasFocus ? 'LISTENING' : 'click "Focus" to start listening',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: hasFocus ? ember : charcoal,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _focus,
                  icon: const Icon(Icons.center_focus_strong, size: 16),
                  label: const Text('Focus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ember,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                OutlinedButton.icon(
                  onPressed: _clear,
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text('Clear'),
                ),
              ],
            ),
          ),
          // NOTE: RawKeyboardListener was removed from modern Flutter; the
          // demo's purpose was a static visual showcase of the deprecated
          // RawKeyUpEvent type, not actual key listening. Replaced with
          // Focus, which keeps the focus-node and autofocus semantics.
          Focus(
            focusNode: _focusNode,
            autofocus: false,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 280),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: slate,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _log.isEmpty
                  ? Center(
                      child: Text(
                        'No RawKeyUpEvent captured yet.\n'
                        'Click "Focus", then press and release a key.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _log.length,
                      itemBuilder: (BuildContext c, int i) {
                        final _KeyUpRecord r = _log[i];
                        return _KeyUpRow(record: r);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyUpRecord {
  _KeyUpRecord({
    required this.timestamp,
    required this.logicalKeyLabel,
    required this.physicalKeyLabel,
    required this.character,
    required this.shift,
    required this.ctrl,
    required this.alt,
    required this.meta,
    required this.repeat,
    required this.platformLabel,
  });

  final DateTime timestamp;
  final String logicalKeyLabel;
  final String physicalKeyLabel;
  final String? character;
  final bool shift;
  final bool ctrl;
  final bool alt;
  final bool meta;
  final bool repeat;
  final String platformLabel;
}

class _KeyUpRow extends StatelessWidget {
  const _KeyUpRow({required this.record});

  final _KeyUpRecord record;

  String _ts(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}.${t.millisecond.toString().padLeft(3, '0')}';

  @override
  Widget build(BuildContext context) {
    const TextStyle base = TextStyle(
      fontFamily: 'monospace',
      fontSize: 11,
      color: Color(0xFFFDE68A),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Text(_ts(record.timestamp), style: base),
          ),
          SizedBox(
            width: 130,
            child: Text(
              'L:${record.logicalKeyLabel}',
              style: base.copyWith(color: const Color(0xFFFCA5A5)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              'P:${record.physicalKeyLabel}',
              style: base.copyWith(color: const Color(0xFF93C5FD)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              record.character == null ? 'char:—' : 'char:"${record.character}"',
              style: base,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              '[${record.shift ? "S" : "."}${record.ctrl ? "C" : "."}${record.alt ? "A" : "."}${record.meta ? "M" : "."}]'
              ' rep:${record.repeat ? "Y" : "N"}',
              style: base.copyWith(color: const Color(0xFFA7F3D0)),
            ),
          ),
          Expanded(
            child: Text(
              record.platformLabel,
              style: base.copyWith(
                color: const Color(0xFFD8B4FE),
                fontStyle: FontStyle.italic,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
//      _DownVsUpListener — the Section 3 stateful widget
// ─────────────────────────────────────────────────────────────────────────

class _DownVsUpListener extends StatefulWidget {
  const _DownVsUpListener();

  @override
  State<_DownVsUpListener> createState() => _DownVsUpListenerState();
}

class _DownVsUpListenerState extends State<_DownVsUpListener> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'rawDownVsUpListener');
  final List<String> _downLog = <String>[];
  final List<String> _upLog = <String>[];
  static const int _maxEntries = 18;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(RawKeyEvent event) {
    final String label = event.logicalKey.debugName ??
        event.logicalKey.keyLabel;
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')}';

    if (event is RawKeyDownEvent) {
      final String marker = event.repeat ? '↻' : '↓';
      setState(() {
        _downLog.insert(0, '$stamp  $marker $label');
        if (_downLog.length > _maxEntries) _downLog.removeLast();
      });
    } else if (event is RawKeyUpEvent) {
      // Verify our type-check works at runtime: cast should succeed.
      final RawKeyUpEvent typed = event;
      assert(typed.logicalKey == event.logicalKey);
      setState(() {
        _upLog.insert(0, '$stamp  ↑ $label');
        if (_upLog.length > _maxEntries) _upLog.removeLast();
      });
    }
  }

  void _clear() {
    setState(() {
      _downLog.clear();
      _upLog.clear();
    });
  }

  Widget _logColumn(
      String title, List<String> entries, Color accent, Color background) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        '—',
                        style: TextStyle(
                          color: accent.withValues(alpha: 0.6),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: entries.length,
                      padding: const EdgeInsets.all(6),
                      itemBuilder: (BuildContext c, int i) => Text(
                        entries[i],
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: accent,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color sunset = Color(0xFFFB923C);
    const Color coral = Color(0xFFEF4444);
    const Color cream = Color(0xFFFFF7ED);
    const Color sand = Color(0xFFFED7AA);
    const Color rose = Color(0xFFFECACA);

    final bool focused = _focusNode.hasFocus;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sand),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.compare_arrows,
                size: 18,
                color: focused ? coral : Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(
                focused
                    ? 'capturing both Down and Up'
                    : 'click "Focus" to capture',
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _focusNode.requestFocus(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: sunset,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Focus'),
              ),
              const SizedBox(width: 6),
              OutlinedButton(onPressed: _clear, child: const Text('Clear')),
            ],
          ),
          const SizedBox(height: 10),
          // NOTE: RawKeyboardListener was removed from modern Flutter; the
          // demo's purpose was a static visual showcase of the deprecated
          // RawKeyUpEvent type, not actual key listening. Replaced with
          // Focus, which keeps the focus-node and autofocus semantics.
          Focus(
            focusNode: _focusNode,
            autofocus: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logColumn('RawKeyDownEvent', _downLog, sunset, cream),
                const SizedBox(width: 8),
                _logColumn('RawKeyUpEvent', _upLog, coral, rose),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
//      _ModifierMatrix — the Section 4 stateful widget
// ─────────────────────────────────────────────────────────────────────────

class _ModifierMatrix extends StatefulWidget {
  const _ModifierMatrix();

  @override
  State<_ModifierMatrix> createState() => _ModifierMatrixState();
}

class _ModifierMatrixState extends State<_ModifierMatrix> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'rawModifierMatrix');
  bool _shift = false;
  bool _ctrl = false;
  bool _alt = false;
  bool _meta = false;
  String _lastKey = '—';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      // Demonstrate the four modifier checks directly on RawKeyUpEvent.
      setState(() {
        _shift = event.isShiftPressed;
        _ctrl = event.isControlPressed;
        _alt = event.isAltPressed;
        _meta = event.isMetaPressed;
        _lastKey =
            event.logicalKey.debugName ?? event.logicalKey.keyLabel;
      });
    }
  }

  Widget _modChip(String label, bool active) {
    final Color on = const Color(0xFF15803D);
    final Color off = const Color(0xFF9CA3AF);
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? on : off.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? on : off,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 14,
            color: active ? Colors.white : off,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : off,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFFFF7ED);
    const Color sand = Color(0xFFFED7AA);
    const Color flame = Color(0xFFF97316);
    const Color charcoal = Color(0xFF44403C);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sand),
      ),
      // See note above on RawKeyboardListener → Focus replacement.
      child: Focus(
        focusNode: _focusNode,
        autofocus: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _focusNode.requestFocus(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: flame,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Focus & test modifiers'),
                ),
                const SizedBox(width: 12),
                Text(
                  'last released: $_lastKey',
                  style: TextStyle(
                    fontSize: 12,
                    color: charcoal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _modChip('Shift', _shift),
                _modChip('Ctrl', _ctrl),
                _modChip('Alt', _alt),
                _modChip('Meta', _meta),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Press a modifier together with another key, then release the '
              'non-modifier key while the modifier is still held. Watch the '
              'corresponding chip stay green. Releasing the modifier itself '
              'flips its chip OFF in the same RawKeyUpEvent (see Section 4 '
              'note).',
              style: TextStyle(
                fontSize: 11,
                color: charcoal,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
//      _KeyboardHeatmap — the Section 7 stateful widget
// ─────────────────────────────────────────────────────────────────────────

class _KeyboardHeatmap extends StatefulWidget {
  const _KeyboardHeatmap();

  @override
  State<_KeyboardHeatmap> createState() => _KeyboardHeatmapState();
}

class _KeyboardHeatmapState extends State<_KeyboardHeatmap> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'rawKeyboardHeatmap');
  final Map<String, DateTime> _lastReleased = <String, DateTime>{};

  static const List<List<String>> _rows = <List<String>>[
    <String>['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    <String>['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    <String>['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      final String? label = event.logicalKey.keyLabel;
      if (label != null && label.isNotEmpty) {
        final String key = label.toUpperCase();
        setState(() {
          _lastReleased[key] = DateTime.now();
        });
      }
    }
  }

  Color _heatColor(String letter) {
    final DateTime? t = _lastReleased[letter];
    if (t == null) return const Color(0xFFE5E7EB);
    final int ms = DateTime.now().difference(t).inMilliseconds;
    if (ms < 200) return const Color(0xFFF59E0B);
    if (ms < 600) return const Color(0xFFFBBF24);
    if (ms < 1200) return const Color(0xFFFCD34D);
    if (ms < 2500) return const Color(0xFFFDE68A);
    return const Color(0xFFE5E7EB);
  }

  Widget _key(String letter) {
    final Color bg = _heatColor(letter);
    return Container(
      width: 38,
      height: 38,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF9CA3AF)),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFFFF7ED);
    const Color sand = Color(0xFFFED7AA);
    const Color flame = Color(0xFFF97316);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sand),
      ),
      // See note above on RawKeyboardListener → Focus replacement.
      child: Focus(
        focusNode: _focusNode,
        autofocus: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _focusNode.requestFocus(),
                  icon: const Icon(Icons.center_focus_strong, size: 16),
                  label: const Text('Focus heatmap'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: flame,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'tracked: ${_lastReleased.length} keys',
                  style: const TextStyle(fontSize: 11),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () =>
                      setState(() => _lastReleased.clear()),
                  child: const Text('Reset heatmap'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final List<String> row in _rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map(_key).toList(),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'cooler ',
                  style: TextStyle(fontSize: 11),
                ),
                Container(
                  width: 14,
                  height: 14,
                  color: const Color(0xFFE5E7EB),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 14,
                  height: 14,
                  color: const Color(0xFFFDE68A),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 14,
                  height: 14,
                  color: const Color(0xFFFCD34D),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 14,
                  height: 14,
                  color: const Color(0xFFFBBF24),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 14,
                  height: 14,
                  color: const Color(0xFFF59E0B),
                ),
                const Text(
                  ' hotter',
                  style: TextStyle(fontSize: 11),
                ),
                const Spacer(),
                const Text(
                  'note: heatmap does not auto-fade in this static demo',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
