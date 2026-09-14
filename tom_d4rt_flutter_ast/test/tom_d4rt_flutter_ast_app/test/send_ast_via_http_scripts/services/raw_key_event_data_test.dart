// ignore_for_file: avoid_print
// D4rt deep demo: RawKeyEventData — the abstract base class that
// carries platform-specific keyboard information in the old RawKeyboard
// system (deprecated in favor of KeyEvent).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Copper / Terracotta palette ───
  const Color copper = Color(0xFFB45309);
  const Color terracotta = Color(0xFFF59E0B);
  const Color deepCopper = Color(0xFF92400E);
  const Color paleAmber = Color(0xFFFEF3C7);
  const Color bronze = Color(0xFFD97706);
  const Color sand = Color(0xFFFDE68A);
  const Color amber = Color(0xFFF59E0B);
  const Color umber = Color(0xFF78350F);
  const Color cream = Color(0xFFFFFBEB);
  const Color burnished = Color(0xFFCA8A04);

  print('[re] ===== RAW KEY EVENT DATA DEEP DEMO =====');

  // ─── Local helpers ───

  Widget reBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [umber, deepCopper],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: umber.withValues(alpha: 0.35),
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
              color: bronze,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: terracotta, width: 1.5),
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

  Widget reNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sand),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: umber.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget reCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: terracotta.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: umber.withValues(alpha: 0.06),
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
              color: copper.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: umber)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget reRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? copper.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: terracotta.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? umber : deepCopper)),
          );
        }).toList(),
      ),
    );
  }

  Widget reFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? umber : deepCopper,
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
          child: Icon(Icons.arrow_forward, size: 12, color: bronze),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is RawKeyEventData? ━━━━━━
  print('[re-01] Section 1: What is RawKeyEventData?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('01', 'What Is RawKeyEventData?'),
      reNote(
        'RawKeyEventData is the abstract base class that carries '
        'platform-specific keyboard information inside RawKeyEvent. '
        'Each platform has its own subclass carrying native key codes, '
        'modifier flags, and character data from the OS keyboard API.',
      ),
      reCard(
        'Class Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _reClassNode('RawKeyEventData', 'abstract base', 0, umber),
            _reClassNode('RawKeyEventDataAndroid', 'Android', 1, deepCopper),
            _reClassNode('RawKeyEventDataFuchsia', 'Fuchsia', 1, copper),
            _reClassNode('RawKeyEventDataIos', 'iOS', 1, bronze),
            _reClassNode('RawKeyEventDataLinux', 'Linux', 1, amber),
            _reClassNode('RawKeyEventDataMacOs', 'macOS', 1, burnished),
            _reClassNode('RawKeyEventDataWeb', 'Web', 1, terracotta),
            _reClassNode('RawKeyEventDataWindows', 'Windows', 1, copper),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Base class properties ━━━━━━
  print('[re-02] Section 2: Base class properties');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('02', 'Base Class Properties'),
      reNote(
        'RawKeyEventData defines the common interface all subclasses must '
        'implement: logicalKey, physicalKey, and keyLabel. These abstract '
        'over the native platform key representation.',
      ),
      reCard(
        'Abstract Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Description'], isHeader: true),
            reRow(['logicalKey', 'LogicalKeyboardKey', 'What the user intended to press']),
            reRow(['physicalKey', 'PhysicalKeyboardKey', 'Which hardware button']),
            reRow(['keyLabel', 'String', 'Printable label for the key']),
            reRow(['isModifierPressed()', 'bool', 'Test specific modifier']),
            reRow(['modifiersPressed', 'Map', 'All active modifiers']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Android data ━━━━━━
  print('[re-03] Section 3: Android data');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('03', 'RawKeyEventDataAndroid'),
      reNote(
        'Android provides keyCode (KeyEvent.KEYCODE_*), scanCode (HID usage), '
        'metaState (modifier bitmask), and flags. The metaState encodes '
        'Ctrl, Shift, Alt, Meta, and CapsLock as individual bits.',
      ),
      reCard(
        'Android Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['keyCode', 'int', 'KEYCODE_A = 29']),
            reRow(['scanCode', 'int', 'HID 0x04']),
            reRow(['metaState', 'int', '0x41 (Shift+A)']),
            reRow(['flags', 'int', 'FLAG_SOFT_KEYBOARD']),
            reRow(['plainCodePoint', 'int', '97 (char "a")']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: iOS data ━━━━━━
  print('[re-04] Section 4: iOS data');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('04', 'RawKeyEventDataIos'),
      reNote(
        'iOS key data includes characters (unmodified), charactersIgnoringModifiers '
        '(base character), keyCode (USB HID usage), and modifiers (NSEvent '
        'modifier flags).',
      ),
      reCard(
        'iOS Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['characters', 'String', '"A" (with Shift)']),
            reRow(['charactersIgnoringModifiers', 'String', '"a" (base)']),
            reRow(['keyCode', 'int', '0x04 (USB HID A)']),
            reRow(['modifiers', 'int', 'NSEvent flags']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: macOS data ━━━━━━
  print('[re-05] Section 5: macOS data');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('05', 'RawKeyEventDataMacOs'),
      reNote(
        'macOS provides characters, charactersIgnoringModifiers, keyCode '
        '(virtual keycode), and modifiers (NSEvent flags). Virtual keycodes '
        'are positional — keyCode 0 is A on a QWERTY layout regardless of '
        'what character it produces on other layouts.',
      ),
      reCard(
        'macOS Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['characters', 'String', '"a" or "A"']),
            reRow(['charactersIgnoringModifiers', 'String', '"a" (always base)']),
            reRow(['keyCode', 'int', '0 = kVK_ANSI_A']),
            reRow(['modifiers', 'int', 'NSEventModifierFlags']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Web data ━━━━━━
  print('[re-06] Section 6: Web data');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('06', 'RawKeyEventDataWeb'),
      reNote(
        'Web key data follows the W3C UI Events specification. code is the '
        'physical key (e.g., "KeyA"), key is the character or key name '
        '(e.g., "a" or "Shift"), location identifies left/right variant, '
        'and metaState encodes modifier flags.',
      ),
      reCard(
        'Web Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['code', 'String', '"KeyA", "ShiftLeft"']),
            reRow(['key', 'String', '"a", "Shift"']),
            reRow(['location', 'int', '0=standard, 1=left, 2=right']),
            reRow(['metaState', 'int', 'Modifier bitmask']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Windows data ━━━━━━
  print('[re-07] Section 7: Windows data');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('07', 'RawKeyEventDataWindows'),
      reNote(
        'Windows provides keyCode (VK_* virtual key), scanCode (hardware '
        'scan code), characterCodePoint, and modifiers (GetKeyState flags). '
        'The AltGr key is represented as Ctrl+Alt, a known complication.',
      ),
      reCard(
        'Windows Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['keyCode', 'int', 'VK_A = 0x41']),
            reRow(['scanCode', 'int', 'Hardware scan code']),
            reRow(['characterCodePoint', 'int', '97 = "a"']),
            reRow(['modifiers', 'int', 'GetKeyState flags']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Linux data ━━━━━━
  print('[re-08] Section 8: Linux data');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('08', 'RawKeyEventDataLinux'),
      reNote(
        'Linux key data uses a toolkit-specific representation. With GTK, '
        'keyCode is a GDK keyval, scanCode is the evdev code, '
        'unicodeScalarValues provides the Unicode character, and '
        'modifiers are GdkModifierType flags.',
      ),
      reCard(
        'Linux / GTK Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['keyCode', 'int', 'GDK_KEY_a = 0x61']),
            reRow(['scanCode', 'int', 'evdev 38']),
            reRow(['unicodeScalarValues', 'int', '97 = "a"']),
            reRow(['modifiers', 'int', 'GdkModifierType']),
            reRow(['isKeypad', 'bool', 'Numpad key?']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Fuchsia data ━━━━━━
  print('[re-09] Section 9: Fuchsia data');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('09', 'RawKeyEventDataFuchsia'),
      reNote(
        'Fuchsia uses USB HID usage codes directly. The hidUsage field '
        'contains the HID usage page and usage ID. codePoint provides '
        'the Unicode character. Modifiers follow a Fuchsia-specific scheme.',
      ),
      reCard(
        'Fuchsia Properties',
        Column(
          children: [
            reRow(['Property', 'Type', 'Example'], isHeader: true),
            reRow(['hidUsage', 'int', 'HID 0x070004 (A)']),
            reRow(['codePoint', 'int', '97 = "a"']),
            reRow(['modifiers', 'int', 'Fuchsia modifier mask']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Modifier mapping ━━━━━━
  print('[re-10] Section 10: Modifier mapping');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('10', 'Cross-Platform Modifier Mapping'),
      reNote(
        'Each platform encodes modifiers differently. RawKeyEventData.isModifierPressed() '
        'provides a unified interface, but the underlying bits vary. This led to '
        'inconsistencies that HardwareKeyboard resolves by tracking state directly.',
      ),
      reCard(
        'Modifier Bit Comparison',
        Column(
          children: [
            reRow(['Modifier', 'Android', 'macOS', 'Windows', 'Web'], isHeader: true),
            reRow(['Shift', 'META_SHIFT', 'NSShift', 'VK_SHIFT', 'shiftKey']),
            reRow(['Ctrl', 'META_CTRL', 'NSControl', 'VK_CONTROL', 'ctrlKey']),
            reRow(['Alt', 'META_ALT', 'NSOption', 'VK_MENU', 'altKey']),
            reRow(['Meta', 'META_META', 'NSCommand', 'VK_LWIN', 'metaKey']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: LogicalKey resolution ━━━━━━
  print('[re-11] Section 11: LogicalKey resolution');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('11', 'Logical Key Resolution'),
      reNote(
        'Each subclass implements logicalKey by mapping its native key '
        'representation to LogicalKeyboardKey. The mapping considers '
        'keyboard layout, modifier state, and platform-specific rules. '
        'Edge cases include dead keys, compose sequences, and IME.',
      ),
      reCard(
        'Resolution Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reFlow(['Native code', 'Platform map', 'LogicalKeyboardKey']),
            const SizedBox(height: 10),
            _reMapStep(1, 'Read native key code', 'keyCode / code / keyval', umber),
            _reMapStep(2, 'Check character output', 'Was a character produced?', deepCopper),
            _reMapStep(3, 'Lookup in platform table', 'Static mapping tables', copper),
            _reMapStep(4, 'Apply layout correction', 'Handle non-US layouts', bronze),
            _reMapStep(5, 'Fallback to USB HID', 'Generic mapping', amber),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: PhysicalKey resolution ━━━━━━
  print('[re-12] Section 12: PhysicalKey resolution');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('12', 'Physical Key Resolution'),
      reNote(
        'physicalKey maps the hardware scan code to PhysicalKeyboardKey. '
        'This is layout-independent — PhysicalKeyboardKey.keyA always '
        'refers to the physical key in the QWERTY "A" position, regardless '
        'of what character the current layout assigns to it.',
      ),
      reCard(
        'Physical Key Sources',
        Column(
          children: [
            reRow(['Platform', 'Source', 'Type'], isHeader: true),
            reRow(['Android', 'scanCode', 'HID usage code']),
            reRow(['iOS', 'keyCode', 'USB HID']),
            reRow(['macOS', 'keyCode', 'Virtual keycode']),
            reRow(['Web', 'code', 'W3C code string']),
            reRow(['Windows', 'scanCode', 'Hardware scan']),
            reRow(['Linux', 'scanCode', 'evdev code']),
            reRow(['Fuchsia', 'hidUsage', 'HID usage']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Deprecation path ━━━━━━
  print('[re-13] Section 13: Deprecation');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('13', 'Deprecation & Migration'),
      reNote(
        'RawKeyEventData and all subclasses are deprecated. The new KeyEvent '
        'system does not use per-platform data subclasses — all platform '
        'data is normalized at the engine level. This simplifies code and '
        'improves cross-platform consistency.',
      ),
      reCard(
        'Old → New Mapping',
        Column(
          children: [
            reRow(['Old (RawKeyEventData)', 'New (KeyEvent)'], isHeader: true),
            reRow(['data.logicalKey', 'event.logicalKey']),
            reRow(['data.physicalKey', 'event.physicalKey']),
            reRow(['data.keyLabel', 'event.character']),
            reRow(['data is ...Android', 'Not needed']),
            reRow(['data.metaState', 'HardwareKeyboard state']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Common issues ━━━━━━
  print('[re-14] Section 14: Common issues');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('14', 'Common Issues'),
      reNote(
        'Known problems with RawKeyEventData: (1) modifier state can desynchronize '
        'if the app loses focus while a modifier is held, (2) IME composition '
        'events may contain incomplete data, (3) some platform subclasses '
        'expose different levels of detail.',
      ),
      reCard(
        'Issue Matrix',
        Column(
          children: [
            reRow(['Issue', 'Cause', 'Fix'], isHeader: true),
            reRow(['Stuck modifier', 'Lost focus during press', 'Use HardwareKeyboard']),
            reRow(['Wrong logicalKey', 'Layout mapping bug', 'Report + use physical']),
            reRow(['Null character', 'Non-printable key', 'Check keyLabel']),
            reRow(['Duplicate events', 'IME composition', 'Filter by type']),
            reRow(['Missing data', 'Platform difference', 'Platform-check first']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Type checking patterns ━━━━━━
  print('[re-15] Section 15: Type checking');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('15', 'Type Checking & Casting'),
      reNote(
        'To access platform-specific fields you must check the runtime type '
        'of event.data. Use "is" checks: if (event.data is RawKeyEventDataAndroid). '
        'This pattern is the main reason for deprecation — it forces '
        'platform-aware code in what should be platform-agnostic handlers.',
      ),
      reCard(
        'Type Check Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cream,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reCodeLine('final data = event.data;', umber),
              _reCodeLine('if (data is RawKeyEventDataAndroid) {', deepCopper),
              _reCodeLine('  print("keyCode: \${data.keyCode}");', copper),
              _reCodeLine('  print("metaState: \${data.metaState}");', copper),
              _reCodeLine('} else if (data is RawKeyEventDataWeb) {', deepCopper),
              _reCodeLine('  print("code: \${data.code}");', bronze),
              _reCodeLine('  print("key: \${data.key}");', bronze),
              _reCodeLine('} else if (data is RawKeyEventDataMacOs) {', deepCopper),
              _reCodeLine('  print("keyCode: \${data.keyCode}");', amber),
              _reCodeLine('}', deepCopper),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[re-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reBanner('16', 'Summary Dashboard'),
      reCard(
        'RawKeyEventData — Complete',
        Column(
          children: [
            reRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            reRow(['What', 'S01', 'Abstract base for platform key data']),
            reRow(['Base props', 'S02', 'logicalKey + physicalKey + keyLabel']),
            reRow(['Android', 'S03', 'keyCode + scanCode + metaState']),
            reRow(['iOS', 'S04', 'characters + keyCode + modifiers']),
            reRow(['macOS', 'S05', 'Virtual keycodes + NSEvent flags']),
            reRow(['Web', 'S06', 'W3C code + key + location']),
            reRow(['Windows', 'S07', 'VK codes + scan + AltGr issue']),
            reRow(['Linux', 'S08', 'GDK keyval + evdev + GTK mods']),
            reRow(['Fuchsia', 'S09', 'HID usage + codePoint']),
            reRow(['Modifiers', 'S10', 'Platform-specific bit mappings']),
            reRow(['LogicalKey', 'S11', 'Native → LogicalKeyboardKey']),
            reRow(['PhysicalKey', 'S12', 'Scan → PhysicalKeyboardKey']),
            reRow(['Deprecation', 'S13', 'Replaced by unified KeyEvent']),
            reRow(['Issues', 'S14', 'Modifier desync, IME gaps']),
            reRow(['Type checks', 'S15', 'Platform-specific "is" casts']),
          ],
        ),
      ),
      reCard(
        'Copper / Terracotta Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _reColorSwatch('Copper', copper),
            _reColorSwatch('Terra', terracotta),
            _reColorSwatch('Bronze', bronze),
            _reColorSwatch('Amber', amber),
            _reColorSwatch('Umber', umber),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [umber, deepCopper],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('RawKeyEventData — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From abstract base through every platform subclass: Android, '
              'iOS, macOS, Web, Windows, Linux, Fuchsia — key codes, '
              'modifiers, resolution, deprecation, and migration.',
              style: TextStyle(color: paleAmber, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[re] palette: $burnished, $sand, $paleAmber, $cream');
  print('[re] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RawKeyEventData — Platform Key Data'),
        backgroundColor: umber,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFFCF5),
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

Widget _reClassNode(String name, String role, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 24.0, bottom: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (depth > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Icon(Icons.subdirectory_arrow_right, size: 12, color: color),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 9, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(width: 4),
              Text(role,
                  style: TextStyle(
                      fontSize: 8, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _reMapStep(int num, String title, String desc, Color color) {
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

Widget _reCodeLine(String text, Color color) {
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

Widget _reColorSwatch(String name, Color color) {
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
