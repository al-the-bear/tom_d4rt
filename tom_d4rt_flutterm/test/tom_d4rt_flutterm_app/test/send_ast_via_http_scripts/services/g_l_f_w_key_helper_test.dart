// ignore_for_file: avoid_print
// D4rt deep demo: GLFWKeyHelper — translating GLFW keyboard scan codes and
// key codes to Flutter LogicalKeyboardKey / PhysicalKeyboardKey on Linux.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Pine / Emerald palette ───
  const Color pine = Color(0xFF1B5E20);
  const Color emerald = Color(0xFF2E7D32);
  const Color deepPine = Color(0xFF0D3311);
  const Color palePine = Color(0xFFF1F8E9);
  const Color forestGreen = Color(0xFF33691E);
  const Color mossGreen = Color(0xFF558B2F);
  const Color lichen = Color(0xFF8BC34A);
  const Color sage = Color(0xFFA5D6A7);
  const Color darkForest = Color(0xFF0A280E);
  const Color treeGold = Color(0xFFCDDC39);

  print('[gk] ===== GLFW KEY HELPER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget gkBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepPine, pine],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepPine.withValues(alpha: 0.35),
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
              color: emerald,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: sage, width: 1.5),
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

  Widget gkNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palePine,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepPine.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget gkCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sage.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: deepPine.withValues(alpha: 0.06),
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
              color: emerald.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepPine)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget gkRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? emerald.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: sage.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? deepPine : forestGreen)),
          );
        }).toList(),
      ),
    );
  }

  Widget gkFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? deepPine : pine,
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
          child: Icon(Icons.east, size: 12, color: emerald),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget gkCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: palePine.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: emerald, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: deepPine,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: forestGreen)),
          ),
        ],
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is GLFWKeyHelper? ━━━━━━
  print('[gk-01] Section 1: What is GLFWKeyHelper?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('01', 'What Is GLFWKeyHelper?'),
      gkNote(
        'GLFWKeyHelper translates GLFW keyboard event data into Flutter\'s '
        'LogicalKeyboardKey and PhysicalKeyboardKey on Linux desktop. GLFW '
        '(Graphics Library Framework) is the window system used by the '
        'Linux Flutter embedder. Every key press/release from GLFW passes '
        'through this helper to become a Flutter KeyEvent.',
      ),
      gkCard(
        'Role in the Key Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gkFlow(['GLFW Event', 'GLFWKeyHelper', 'FlutterKeyEvent',
                'Focus System', 'Widget']),
            const SizedBox(height: 10),
            _gkRoleRow('GLFW', 'Window system events (raw scan codes)', pine),
            _gkRoleRow('GLFWKeyHelper', 'Translates to Flutter key model', emerald),
            _gkRoleRow('KeyEvent', 'Logical + Physical key objects', forestGreen),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: GLFW key codes ━━━━━━
  print('[gk-02] Section 2: GLFW key codes');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('02', 'GLFW Key Codes'),
      gkNote(
        'GLFW defines integer key codes (GLFW_KEY_A = 65, GLFW_KEY_SPACE = 32, '
        'etc.) based on ASCII positions for printable keys. Non-printable keys '
        'start at 256 (GLFW_KEY_ESCAPE = 256, GLFW_KEY_ENTER = 257). These '
        'are different from USB HID codes used by Flutter internally.',
      ),
      gkCard(
        'Common GLFW Key Codes',
        Column(
          children: [
            gkRow(['Key', 'GLFW Code', 'Flutter Logical'], isHeader: true),
            gkRow(['A', '65', 'LogicalKeyboardKey.keyA']),
            gkRow(['Space', '32', 'LogicalKeyboardKey.space']),
            gkRow(['Enter', '257', 'LogicalKeyboardKey.enter']),
            gkRow(['Escape', '256', 'LogicalKeyboardKey.escape']),
            gkRow(['Tab', '258', 'LogicalKeyboardKey.tab']),
            gkRow(['Left Shift', '340', 'LogicalKeyboardKey.shiftLeft']),
            gkRow(['Left Ctrl', '341', 'LogicalKeyboardKey.controlLeft']),
            gkRow(['F1', '290', 'LogicalKeyboardKey.f1']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Scan codes vs key codes ━━━━━━
  print('[gk-03] Section 3: Scan codes vs key codes');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('03', 'Scan Codes vs Key Codes'),
      gkNote(
        'GLFW provides both scan codes and key codes. Scan codes identify the '
        'physical key position on the keyboard (hardware-dependent). Key codes '
        'identify the logical meaning (layout-dependent). GLFWKeyHelper maps '
        'scan codes to PhysicalKeyboardKey and key codes to LogicalKeyboardKey.',
      ),
      gkCard(
        'Mapping Model',
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palePine,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sage),
                ),
                child: Column(
                  children: [
                    Icon(Icons.keyboard, size: 22, color: pine),
                    const SizedBox(height: 4),
                    Text('Scan Code',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold, color: pine)),
                    const SizedBox(height: 6),
                    _gkMappingItem('Physical position', pine),
                    _gkMappingItem('Hardware-dependent', pine),
                    _gkMappingItem('layout-agnostic', pine),
                    const SizedBox(height: 4),
                    Icon(Icons.arrow_downward, size: 14, color: emerald),
                    const SizedBox(height: 4),
                    Text('PhysicalKeyboardKey',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: emerald)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sage.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: emerald),
                ),
                child: Column(
                  children: [
                    Icon(Icons.text_fields, size: 22, color: emerald),
                    const SizedBox(height: 4),
                    Text('Key Code',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold, color: emerald)),
                    const SizedBox(height: 6),
                    _gkMappingItem('Logical meaning', emerald),
                    _gkMappingItem('Layout-dependent', emerald),
                    _gkMappingItem('Includes modifiers', emerald),
                    const SizedBox(height: 4),
                    Icon(Icons.arrow_downward, size: 14, color: pine),
                    const SizedBox(height: 4),
                    Text('LogicalKeyboardKey',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            color: pine)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Keyboard layouts ━━━━━━
  print('[gk-04] Section 4: Keyboard layouts');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('04', 'Keyboard Layout Handling'),
      gkNote(
        'Different keyboard layouts (QWERTY, AZERTY, QWERTZ, Dvorak) assign '
        'different characters to the same physical key positions. The scan '
        'code stays the same but the key code changes. GLFWKeyHelper handles '
        'this by using GLFW\'s layout-aware key code for LogicalKeyboardKey.',
      ),
      gkCard(
        'Physical Key 16 (top-left letter) Across Layouts',
        Column(
          children: [
            gkRow(['Layout', 'Char', 'Key Code', 'Physical'], isHeader: true),
            gkRow(['QWERTY', 'Q', '81', 'Same scan code']),
            gkRow(['AZERTY', 'A', '65', 'Same scan code']),
            gkRow(['QWERTZ', 'Q', '81', 'Same scan code']),
            gkRow(['Dvorak', "'", '39', 'Same scan code']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Modifier keys ━━━━━━
  print('[gk-05] Section 5: Modifier keys');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('05', 'Modifier Key Handling'),
      gkNote(
        'GLFW reports modifier state (Shift, Ctrl, Alt, Super) as a bitmask. '
        'GLFWKeyHelper parses these flags and ensures the modifier keys are '
        'tracked correctly in Flutter\'s HardwareKeyboard state.',
      ),
      gkCard(
        'GLFW Modifier Flags',
        Column(
          children: [
            gkRow(['Modifier', 'GLFW Flag', 'Bit', 'Flutter Key'], isHeader: true),
            gkRow(['Shift', 'GLFW_MOD_SHIFT', '0x01', 'shiftLeft/Right']),
            gkRow(['Control', 'GLFW_MOD_CONTROL', '0x02', 'controlLeft/Right']),
            gkRow(['Alt', 'GLFW_MOD_ALT', '0x04', 'altLeft/Right']),
            gkRow(['Super', 'GLFW_MOD_SUPER', '0x08', 'metaLeft/Right']),
            gkRow(['CapsLock', 'GLFW_MOD_CAPS_LOCK', '0x10', 'capsLock']),
            gkRow(['NumLock', 'GLFW_MOD_NUM_LOCK', '0x20', 'numLock']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Key event types ━━━━━━
  print('[gk-06] Section 6: Key event types');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('06', 'GLFW Key Event Types'),
      gkNote(
        'GLFW sends three event types: GLFW_PRESS (key down), GLFW_RELEASE '
        '(key up), and GLFW_REPEAT (auto-repeat while held). GLFWKeyHelper '
        'maps these to Flutter\'s KeyDownEvent, KeyUpEvent, and KeyRepeatEvent.',
      ),
      gkCard(
        'Event Type Mapping',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gkEventType('GLFW_PRESS (1)', 'KeyDownEvent', Icons.arrow_downward, pine),
            _gkEventType('GLFW_RELEASE (0)', 'KeyUpEvent', Icons.arrow_upward, emerald),
            _gkEventType('GLFW_REPEAT (2)', 'KeyRepeatEvent', Icons.repeat, mossGreen),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: keyCodeToLogicalKey ━━━━━━
  print('[gk-07] Section 7: keyCodeToLogicalKey');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('07', 'keyCodeToLogicalKey Method'),
      gkNote(
        'The keyCodeToLogicalKey method takes a GLFW key code integer and '
        'returns the corresponding LogicalKeyboardKey. It uses a lookup table '
        'generated from the GLFW key definitions. Unknown key codes return '
        'a synthesized key based on the numeric value.',
      ),
      gkCard(
        'Method Signature',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gkCode('LogicalKeyboardKey',
                'Return: the Flutter logical key'),
            gkCode('keyCodeToLogicalKey(int glfwKeyCode)',
                'Input: GLFW key code integer'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: palePine,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'For unknown codes: returns a synthesized key with plane 0x0700000000, '
                'preserving the original GLFW code value for debugging.',
                style: TextStyle(fontSize: 10, color: deepPine),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: scanCodeToPhysicalKey ━━━━━━
  print('[gk-08] Section 8: scanCodeToPhysicalKey');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('08', 'scanCodeToPhysicalKey Method'),
      gkNote(
        'The scanCodeToPhysicalKey method maps GLFW scan codes to Flutter\'s '
        'PhysicalKeyboardKey. On Linux, scan codes are X11 keycodes, which are '
        'evdev codes plus 8. The helper maintains a mapping table from these '
        'platform-specific codes to USB HID-based PhysicalKeyboardKey.',
      ),
      gkCard(
        'Scan Code Mapping Examples',
        Column(
          children: [
            gkRow(['X11 Code', 'evdev', 'Physical Key Name'], isHeader: true),
            gkRow(['38', '30', 'keyA']),
            gkRow(['56', '48', 'keyB']),
            gkRow(['9', '1', 'escape']),
            gkRow(['36', '28', 'enter']),
            gkRow(['65', '57', 'space']),
            gkRow(['50', '42', 'shiftLeft']),
            gkRow(['23', '15', 'tab']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform-specific behavior ━━━━━━
  print('[gk-09] Section 9: Platform-specific behavior');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('09', 'Platform-Specific Behavior'),
      gkNote(
        'GLFWKeyHelper is specific to the GLFW-based Linux embedder. Other '
        'platforms use different key helpers: XKB for GTK embedder, '
        'KeyEventChannel for Android, etc. This layered approach isolates '
        'platform-specific keyboard quirks.',
      ),
      gkCard(
        'Platform Key Helpers',
        Column(
          children: [
            gkRow(['Platform', 'Helper', 'Underlying System'], isHeader: true),
            gkRow(['Linux (GLFW)', 'GLFWKeyHelper', 'GLFW 3.3+']),
            gkRow(['Linux (GTK)', 'GtkKeyHelper', 'GDK/XKB']),
            gkRow(['macOS', 'KeyEventChannel', 'NSEvent']),
            gkRow(['Windows', 'KeyEventChannel', 'WinAPI']),
            gkRow(['Android', 'KeyEventChannel', 'Android KeyEvent']),
            gkRow(['iOS', 'N/A (no hw keyboard)', 'UIKey']),
            gkRow(['Web', 'KeyEventChannel', 'DOM KeyboardEvent']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Dead keys and compose ━━━━━━
  print('[gk-10] Section 10: Dead keys and compose sequences');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('10', 'Dead Keys & Compose Sequences'),
      gkNote(
        'Dead keys (accent keys on European keyboards) produce no immediate '
        'character — they modify the next key press. GLFW_KEY_UNKNOWN is '
        'returned for the dead key itself. GLFWKeyHelper must handle these '
        'lookups gracefully without crashing.',
      ),
      gkCard(
        'Dead Key Sequence Example',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gkDeadKeyStep(1, 'Press ´ (dead acute)', 'GLFW_KEY_UNKNOWN', 'No char yet', pine),
            _gkDeadKeyStep(2, 'Press e', 'GLFW_KEY_E (65)', 'é produced', emerald),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: palePine,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'GLFWKeyHelper returns a synthesized key for GLFW_KEY_UNKNOWN '
                '(-1), keeping Flutter\'s key tracking consistent.',
                style: TextStyle(fontSize: 10, color: deepPine),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Number pad keys ━━━━━━
  print('[gk-11] Section 11: Number pad keys');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('11', 'Numpad Key Handling'),
      gkNote(
        'GLFW distinguishes numpad keys from main keyboard keys via separate '
        'key codes. Numpad 0-9 are GLFW_KEY_KP_0 (320) through GLFW_KEY_KP_9 '
        '(329). GLFWKeyHelper maps these to LogicalKeyboardKey.numpad0-9 '
        'and distinct PhysicalKeyboardKey entries.',
      ),
      gkCard(
        'Numpad GLFW Codes',
        Column(
          children: [
            gkRow(['Key', 'GLFW Code', 'Logical Key'], isHeader: true),
            gkRow(['KP 0', '320', 'numpad0']),
            gkRow(['KP 1', '321', 'numpad1']),
            gkRow(['KP Enter', '335', 'numpadEnter']),
            gkRow(['KP +', '334', 'numpadAdd']),
            gkRow(['KP -', '333', 'numpadSubtract']),
            gkRow(['KP *', '332', 'numpadMultiply']),
            gkRow(['KP /', '331', 'numpadDivide']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Function keys ━━━━━━
  print('[gk-12] Section 12: Function keys');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('12', 'Function Keys (F1-F25)'),
      gkNote(
        'GLFW supports F1 through F25 (GLFW_KEY_F1 = 290 through '
        'GLFW_KEY_F25 = 314), though most keyboards only have F1-F12. '
        'GLFWKeyHelper maps all 25 to corresponding LogicalKeyboardKey.f1-f25.',
      ),
      gkCard(
        'Function Key Range',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _gkKeyBlock('F1-F4', '290-293', pine)),
                const SizedBox(width: 4),
                Expanded(child: _gkKeyBlock('F5-F8', '294-297', emerald)),
                const SizedBox(width: 4),
                Expanded(child: _gkKeyBlock('F9-F12', '298-301', forestGreen)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _gkKeyBlock('F13-F16', '302-305', mossGreen)),
                const SizedBox(width: 4),
                Expanded(child: _gkKeyBlock('F17-F20', '306-309', const Color(0xFF689F38))),
                const SizedBox(width: 4),
                Expanded(child: _gkKeyBlock('F21-F25', '310-314', const Color(0xFF7CB342))),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Character generation ━━━━━━
  print('[gk-13] Section 13: Character generation');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('13', 'Character Generation'),
      gkNote(
        'GLFW also provides a separate char callback that sends Unicode '
        'codepoints. GLFWKeyHelper helps correlate key events with character '
        'events so that Flutter can associate a character with a KeyDownEvent. '
        'Modifier-only keys (Shift, Ctrl) produce no character.',
      ),
      gkCard(
        'Key vs Character Events',
        Column(
          children: [
            gkRow(['Key Press', 'Key Code', 'Character', 'Unicode'], isHeader: true),
            gkRow(['a', '65', 'a', 'U+0061']),
            gkRow(['Shift+a', '65', 'A', 'U+0041']),
            gkRow(['Ctrl+a', '65', '(none)', 'Ctrl blocks char']),
            gkRow(['Enter', '257', '(none)', 'Non-printable']),
            gkRow(['€ via compose', '-1', '€', 'U+20AC']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Key sync on focus ━━━━━━
  print('[gk-14] Section 14: Key sync on focus');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('14', 'Key State Synchronization'),
      gkNote(
        'When the Flutter window gains focus, modifier keys might already be '
        'held down. GLFWKeyHelper assists the KeyboardManager in synthesizing '
        'key-down events for any modifiers that are held but not yet tracked. '
        'This prevents stuck-modifier bugs.',
      ),
      gkCard(
        'Focus Sync Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gkFlow(['Window Focus', 'Poll Modifiers',
                'Compare Tracked', 'Synthesize Events']),
            const SizedBox(height: 10),
            gkRow(['Modifier', 'OS State', 'Flutter State', 'Action'], isHeader: true),
            gkRow(['Shift', 'Held', 'Not tracked', 'Synthesize down']),
            gkRow(['Ctrl', 'Released', 'Tracked', 'Synthesize up']),
            gkRow(['Alt', 'Held', 'Tracked', 'No action']),
            gkRow(['Super', 'Released', 'Not tracked', 'No action']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing patterns ━━━━━━
  print('[gk-15] Section 15: Testing patterns');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('15', 'Testing Key Translation'),
      gkNote(
        'Test GLFWKeyHelper by creating raw GLFW event data and verifying '
        'the resulting Flutter key objects. The key tables are code-generated, '
        'so tests focus on edge cases: unknown keys, dead keys, numpad vs main.',
      ),
      gkCard(
        'Test Scenarios',
        Column(
          children: [
            gkRow(['Test', 'Input', 'Verify'], isHeader: true),
            gkRow(['Normal key', 'GLFW_KEY_A (65)', 'LogicalKeyboardKey.keyA']),
            gkRow(['Unknown key', 'GLFW_KEY_UNKNOWN (-1)', 'Synthesized key']),
            gkRow(['Numpad', 'GLFW_KEY_KP_5 (325)', 'numpad5']),
            gkRow(['Modifier', 'GLFW_KEY_LEFT_SHIFT (340)', 'shiftLeft']),
            gkRow(['Layout-dep.', 'Same scan, diff code', 'Correct logical']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[gk-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      gkBanner('16', 'Summary Dashboard'),
      gkCard(
        'GLFWKeyHelper — Complete',
        Column(
          children: [
            gkRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            gkRow(['What', 'S01', 'GLFW → Flutter key translation']),
            gkRow(['GLFW codes', 'S02', 'Integer codes, ASCII-based']),
            gkRow(['Scan vs key', 'S03', 'Physical vs logical split']),
            gkRow(['Layouts', 'S04', 'QWERTY/AZERTY/Dvorak handling']),
            gkRow(['Modifiers', 'S05', 'Bitmask flags parsing']),
            gkRow(['Event types', 'S06', 'Press/Release/Repeat']),
            gkRow(['Logical map', 'S07', 'keyCodeToLogicalKey API']),
            gkRow(['Physical map', 'S08', 'scanCodeToPhysicalKey API']),
            gkRow(['Platform', 'S09', 'GLFW-specific, Linux only']),
            gkRow(['Dead keys', 'S10', 'Compose sequence support']),
            gkRow(['Numpad', 'S11', 'Separate from main keys']),
            gkRow(['F-keys', 'S12', 'F1-F25 range']),
            gkRow(['Characters', 'S13', 'Key + char event correlation']),
            gkRow(['Sync', 'S14', 'Focus gain modifier sync']),
            gkRow(['Testing', 'S15', 'Edge case verification']),
          ],
        ),
      ),
      gkCard(
        'Pine / Emerald Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _gkColorSwatch('Pine', pine),
            _gkColorSwatch('Emerald', emerald),
            _gkColorSwatch('Forest', forestGreen),
            _gkColorSwatch('Moss', mossGreen),
            _gkColorSwatch('Deep', deepPine),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepPine, pine],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('GLFWKeyHelper — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From GLFW scan codes and key codes through layout handling, '
              'modifier parsing, dead key sequences, numpad mapping, and '
              'focus synchronization — the full Linux keyboard pipeline.',
              style: TextStyle(color: sage, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[gk] palette: $treeGold, $lichen, $darkForest');
  print('[gk] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('GLFWKeyHelper — Linux Key Mapping'),
        backgroundColor: deepPine,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5FAF5),
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

Widget _gkRoleRow(String label, String desc, Color color) {
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
          width: 100,
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

Widget _gkMappingItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 9, color: color)),
        ),
      ],
    ),
  );
}

Widget _gkEventType(String glfw, String flutter, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(glfw,
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
        Icon(Icons.arrow_forward, size: 12, color: color.withValues(alpha: 0.5)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(flutter,
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: color)),
        ),
      ],
    ),
  );
}

Widget _gkDeadKeyStep(int num, String input, String glfwCode, String result, Color color) {
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
          flex: 3,
          child: Text(input,
              style: TextStyle(fontSize: 10, color: color)),
        ),
        Expanded(
          flex: 2,
          child: Text(glfwCode,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace', color: color.withValues(alpha: 0.7))),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(result,
                style: TextStyle(
                    fontSize: 9, fontWeight: FontWeight.w600, color: color)),
          ),
        ),
      ],
    ),
  );
}

Widget _gkKeyBlock(String label, String codes, Color color) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        Text(codes,
            style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _gkColorSwatch(String name, Color color) {
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
