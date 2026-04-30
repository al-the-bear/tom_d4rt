// ignore_for_file: avoid_print
// Deep demo: GtkKeyHelper
// Demonstrates GtkKeyHelper — the Linux platform helper that maps
// GTK key event data (keycodes, keysyms, modifiers) to Flutter's
// LogicalKeyboardKey and PhysicalKeyboardKey representations.
import 'package:flutter/material.dart';

// ─── palette: Navy / Ice Blue ─────────────────────────────────────
const Color _gkNavy = Color(0xFF0D47A1);
const Color _gkIce = Color(0xFFE3F2FD);
const Color _gkAccent = Color(0xFF1976D2);
const Color _gkDark = Color(0xFF1A1A1A);
const Color _gkGreen = Color(0xFF2E7D32);
const Color _gkOrange = Color(0xFFEF6C00);
const Color _gkPurple = Color(0xFF6A1B9A);
const Color _gkTeal = Color(0xFF00695C);
const Color _gkRed = Color(0xFFC62828);
const Color _gkAmber = Color(0xFFF9A825);

// ─── text helpers ─────────────────────────────────────────────────
Widget _gkTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _gkNavy,
              letterSpacing: 0.3)),
    );

Widget _gkSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _gkAccent)),
    );

Widget _gkBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _gkCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _gkDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFF90CAF9),
              height: 1.5)),
    );

Widget _gkNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _gkIce,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _gkNavy.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.keyboard, size: 16, color: _gkNavy),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _gkNavy, height: 1.4)),
          ),
        ],
      ),
    );

Widget _gkDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _gkNavy.withValues(alpha: 0.1)),
    );

Widget _gkBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
                color: _gkAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _gkTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _gkLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _gkNavy,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _gkBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_gkNavy, Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.keyboard_alt_outlined, size: 48, color: _gkIce),
          const SizedBox(height: 10),
          const Text('GtkKeyHelper',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('GTK key event translation for Flutter on Linux',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _gkTag('services', _gkAccent),
              _gkTag('Linux', _gkGreen),
              _gkTag('keyboard', _gkPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _gkWhatIs() => [
      _gkTitle('§2  What Is GtkKeyHelper?'),
      _gkBody(
          'GtkKeyHelper is a platform-specific utility class that '
          'translates GTK key events from the Linux windowing system '
          'into Flutter\'s cross-platform key representations '
          '(LogicalKeyboardKey and PhysicalKeyboardKey).'),
      _gkCode(
          '// GtkKeyHelper bridges:\n'
          '//\n'
          '// GTK GdkEventKey  ──>  Flutter KeyEvent\n'
          '//   .keyval (keysym)     .logicalKey\n'
          '//   .hardware_keycode    .physicalKey\n'
          '//   .state (modifiers)   .character\n'
          '//   .type (press/rel)    .type (down/up/repeat)'),
      _gkNote(
          'On Linux with GTK, Flutter receives raw GDK key events via '
          'the embedder. GtkKeyHelper converts these into the unified '
          'Flutter key event model used by RawKeyboardListener and '
          'KeyboardListener.'),
    ];

// ─── §3 Key event pipeline ──────────────────────────────────────
List<Widget> _gkPipeline() => [
      _gkDivider(),
      _gkTitle('§3  Key Event Pipeline'),
      _gkBody(
          'On Linux, key events flow through several layers before '
          'reaching your Flutter app:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _gkPipeLayer('Linux Kernel', 'Raw scancode from hardware',
                _gkNavy, Icons.memory),
            _gkPipeArrow(),
            _gkPipeLayer('X11 / Wayland', 'Window system key event',
                _gkAccent, Icons.desktop_windows),
            _gkPipeArrow(),
            _gkPipeLayer('GTK / GDK', 'GdkEventKey with keysym + state',
                _gkGreen, Icons.widgets),
            _gkPipeArrow(),
            _gkPipeLayer('Flutter Embedder',
                'Sends raw event data to engine',
                _gkOrange, Icons.precision_manufacturing),
            _gkPipeArrow(),
            _gkPipeLayer('GtkKeyHelper',
                'Translates to LogicalKey / PhysicalKey',
                _gkPurple, Icons.swap_horiz),
            _gkPipeArrow(),
            _gkPipeLayer('Flutter Framework',
                'KeyEvent dispatched to widgets',
                _gkTeal, Icons.send),
          ],
        ),
      ),
      _gkBullet('Scancode', 'Physical key position on keyboard'),
      _gkBullet('Keysym', 'Logical key meaning (layout-dependent)'),
      _gkBullet('State', 'Bitmask of active modifiers at event time'),
    ];

Widget _gkPipeLayer(String title, String desc, Color c, IconData icon) =>
    Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: c),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

Widget _gkPipeArrow() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(Icons.keyboard_arrow_down,
            size: 18, color: Colors.black26),
      ),
    );

// ─── §4 Keysym mapping ──────────────────────────────────────────
List<Widget> _gkKeysym() => [
      _gkDivider(),
      _gkTitle('§4  Keysym Mapping'),
      _gkBody(
          'A GDK keysym (key symbol) represents the logical meaning of '
          'a key press — what character or function it produces. '
          'GtkKeyHelper maps these to Flutter LogicalKeyboardKeys:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _gkMapHeader(),
            _gkMapRow('GDK_KEY_a', '0x0061',
                'LogicalKeyboardKey.keyA', _gkNavy),
            _gkMapRow('GDK_KEY_Return', '0xFF0D',
                'LogicalKeyboardKey.enter', _gkAccent),
            _gkMapRow('GDK_KEY_Escape', '0xFF1B',
                'LogicalKeyboardKey.escape', _gkGreen),
            _gkMapRow('GDK_KEY_Tab', '0xFF09',
                'LogicalKeyboardKey.tab', _gkOrange),
            _gkMapRow('GDK_KEY_BackSpace', '0xFF08',
                'LogicalKeyboardKey.backspace', _gkPurple),
            _gkMapRow('GDK_KEY_F1', '0xFFBE',
                'LogicalKeyboardKey.f1', _gkTeal),
            _gkMapRow('GDK_KEY_Control_L', '0xFFE3',
                'LogicalKeyboardKey.controlLeft', _gkRed),
            _gkMapRow('GDK_KEY_Super_L', '0xFFEB',
                'LogicalKeyboardKey.superKey', _gkAmber),
          ],
        ),
      ),
      _gkCode(
          '// Keysym to LogicalKeyboardKey mapping:\n'
          '// The helper uses a large lookup table:\n'
          '// Map<int, LogicalKeyboardKey> _keysymToLogical\n'
          '//\n'
          '// For printable characters (keysym < 0xFF00),\n'
          '// the keysym often matches the Unicode code point.\n'
          '// For special keys (keysym >= 0xFF00),\n'
          '// a dedicated mapping table is used.'),
    ];

Widget _gkMapHeader() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: _gkNavy.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          Expanded(
              flex: 3,
              child: Text('GTK Keysym',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
          Expanded(
              flex: 2,
              child: Text('Value',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
          Expanded(
              flex: 4,
              child: Text('Flutter Key',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
        ],
      ),
    );

Widget _gkMapRow(String keysym, String hex, String flutter, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(keysym,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
          Expanded(
            flex: 2,
            child: Text(hex,
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: Colors.black45)),
          ),
          Expanded(
            flex: 4,
            child: Text(flutter,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: c.withValues(alpha: 0.8))),
          ),
        ],
      ),
    );

// ─── §5 Physical key mapping ─────────────────────────────────────
List<Widget> _gkPhysical() => [
      _gkDivider(),
      _gkTitle('§5  Physical Key Mapping'),
      _gkBody(
          'The hardware_keycode field in GdkEventKey identifies the '
          'physical key position. GtkKeyHelper maps this to Flutter\'s '
          'PhysicalKeyboardKey, which is layout-independent:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gkLabel('Hardware keycode to PhysicalKey'),
            const SizedBox(height: 8),
            _gkPhysRow(38, 'A position', 'PhysicalKeyboardKey.keyA',
                _gkNavy),
            _gkPhysRow(36, 'Enter', 'PhysicalKeyboardKey.enter',
                _gkAccent),
            _gkPhysRow(9, 'Escape', 'PhysicalKeyboardKey.escape',
                _gkGreen),
            _gkPhysRow(23, 'Tab', 'PhysicalKeyboardKey.tab',
                _gkOrange),
            _gkPhysRow(65, 'Spacebar', 'PhysicalKeyboardKey.space',
                _gkPurple),
          ],
        ),
      ),
      _gkNote(
          'Physical keys are constant across keyboard layouts. Pressing '
          'the same physical key produces the same PhysicalKeyboardKey '
          'regardless of whether the layout is QWERTY, AZERTY, or Dvorak.'),
      _gkCode(
          '// Physical vs logical distinction:\n'
          '// On QWERTY: physical "A" key → logical "a"\n'
          '// On AZERTY: physical "A" key → logical "q"\n'
          '// On Dvorak: physical "A" key → logical "a"\n'
          '//\n'
          '// PhysicalKeyboardKey.keyA is always the same\n'
          '// LogicalKeyboardKey varies with layout'),
    ];

Widget _gkPhysRow(int code, String desc, String physKey, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 24,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: c.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Text('$code',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: c,
                      fontFamily: 'monospace')),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black54)),
          ),
          Expanded(
            child: Text(physKey,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: c,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

// ─── §6 Modifier handling ────────────────────────────────────────
List<Widget> _gkModifiers() => [
      _gkDivider(),
      _gkTitle('§6  Modifier Handling'),
      _gkBody(
          'GDK represents active modifiers as a bitmask in the state '
          'field of GdkEventKey. GtkKeyHelper decodes these flags:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _gkModRow('GDK_SHIFT_MASK', '1 << 0', 'Shift',
                _gkNavy, Icons.arrow_upward),
            _gkModRow('GDK_CONTROL_MASK', '1 << 2', 'Ctrl',
                _gkAccent, Icons.settings_outlined),
            _gkModRow('GDK_MOD1_MASK', '1 << 3', 'Alt',
                _gkGreen, Icons.alt_route),
            _gkModRow('GDK_SUPER_MASK', '1 << 26', 'Super',
                _gkOrange, Icons.computer),
            _gkModRow('GDK_LOCK_MASK', '1 << 1', 'Caps Lock',
                _gkPurple, Icons.lock_outline),
            _gkModRow('GDK_MOD2_MASK', '1 << 4', 'Num Lock',
                _gkTeal, Icons.numbers),
          ],
        ),
      ),
      _gkCode(
          '// Modifier bitmask decoding:\n'
          '// state = GDK_CONTROL_MASK | GDK_SHIFT_MASK\n'
          '//       = 0x04 | 0x01 = 0x05\n'
          '//\n'
          '// GtkKeyHelper checks each bit:\n'
          '// isShiftPressed  = state & GDK_SHIFT_MASK   != 0\n'
          '// isControlPressed = state & GDK_CONTROL_MASK != 0\n'
          '// isAltPressed    = state & GDK_MOD1_MASK    != 0'),
    ];

Widget _gkModRow(String name, String mask, String label, Color c,
    IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 16, color: c),
        const SizedBox(width: 8),
        Container(
          width: 44,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(name,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: c)),
        ),
        Text(mask,
            style: const TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.black45)),
      ],
    ),
  );
}

// ─── §7 Toolkit comparison ───────────────────────────────────────
List<Widget> _gkComparison() => [
      _gkDivider(),
      _gkTitle('§7  Platform Key Helpers Compared'),
      _gkBody(
          'Each desktop platform has its own key helper in Flutter:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _gkCompRow('Linux (GTK)', 'GtkKeyHelper',
                'GDK keysyms + hardware keycodes', _gkNavy),
            _gkCompRow('Linux (GLFW)', 'GLFWKeyHelper',
                'GLFW key tokens (alternative)', _gkAccent),
            _gkCompRow('macOS', 'KeyCodeToLogical',
                'macOS key codes + Carbon events', _gkGreen),
            _gkCompRow('Windows', 'WinKeyHelper',
                'Virtual key codes + scan codes', _gkOrange),
            _gkCompRow('Android', 'AndroidKeyHelper',
                'Android KeyEvent codes', _gkPurple),
            _gkCompRow('iOS', 'IOSKeyHelper',
                'UIKey + HIDUsage codes', _gkTeal),
            _gkCompRow('Web', 'WebKeyHelper',
                'DOM KeyboardEvent.code + key', _gkRed),
          ],
        ),
      ),
      _gkBullet('All helpers produce',
          'The same LogicalKeyboardKey/PhysicalKeyboardKey'),
      _gkBullet('Platform differences',
          'Only in input format (keysym vs keycode vs VK)'),
      _gkBullet('Cross-platform goal',
          'Widget code sees identical KeyEvents on all platforms'),
    ];

Widget _gkCompRow(String platform, String helper, String input, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 30,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(platform,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: c)),
                    const SizedBox(width: 8),
                    Text(helper,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: c.withValues(alpha: 0.7))),
                  ],
                ),
                Text(input,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §8 Keyboard layout handling ─────────────────────────────────
List<Widget> _gkLayouts() => [
      _gkDivider(),
      _gkTitle('§8  Keyboard Layout Handling'),
      _gkBody(
          'One of GtkKeyHelper\'s key challenges is handling different '
          'keyboard layouts correctly. The same physical key produces '
          'different keysyms depending on the active input method:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _gkLayoutCard('QWERTY (US)', [
                _GkKeyPair('Q', 'W', 'E'),
                _GkKeyPair('A', 'S', 'D'),
                _GkKeyPair('Z', 'X', 'C'),
              ], _gkNavy),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _gkLayoutCard('AZERTY (FR)', [
                _GkKeyPair('A', 'Z', 'E'),
                _GkKeyPair('Q', 'S', 'D'),
                _GkKeyPair('W', 'X', 'C'),
              ], _gkGreen),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _gkLayoutCard('QWERTZ (DE)', [
                _GkKeyPair('Q', 'W', 'E'),
                _GkKeyPair('A', 'S', 'D'),
                _GkKeyPair('Y', 'X', 'C'),
              ], _gkOrange),
            ),
          ],
        ),
      ),
      _gkCode(
          '// Same physical key, different logical keys:\n'
          '//\n'
          '// Physical key at position 38 (left of "S"):\n'
          '//   QWERTY → keysym 0x0061 (a) → keyA\n'
          '//   AZERTY → keysym 0x0071 (q) → keyQ\n'
          '//   Dvorak → keysym 0x0061 (a) → keyA\n'
          '//\n'
          '// PhysicalKeyboardKey is always keyA (position).\n'
          '// LogicalKeyboardKey varies with layout.'),
    ];

class _GkKeyPair {
  final String k1, k2, k3;
  const _GkKeyPair(this.k1, this.k2, this.k3);
}

Widget _gkLayoutCard(
    String name, List<_GkKeyPair> rows, Color c) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: c)),
        const SizedBox(height: 6),
        ...rows.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gkKeyCap(r.k1, c),
                  const SizedBox(width: 3),
                  _gkKeyCap(r.k2, c),
                  const SizedBox(width: 3),
                  _gkKeyCap(r.k3, c),
                ],
              ),
            )),
      ],
    ),
  );
}

Widget _gkKeyCap(String label, Color c) => Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: c,
                fontFamily: 'monospace')),
      ),
    );

// ─── §9 Dead keys and compose ────────────────────────────────────
List<Widget> _gkDeadKeys() => [
      _gkDivider(),
      _gkTitle('§9  Dead Keys & Compose Sequences'),
      _gkBody(
          'GTK supports dead keys and compose sequences for entering '
          'accented characters. GtkKeyHelper must handle these '
          'multi-keypress sequences correctly:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gkLabel('Dead key example: typing "e" with acute accent'),
            const SizedBox(height: 10),
            _gkDeadStep(1, 'Press dead acute (\')',
                'No character emitted yet', _gkNavy),
            _gkDeadStep(2, 'Press "e"',
                'Combines: dead acute + e = e with acute', _gkAccent),
            _gkDeadStep(3, 'Character generated',
                'Flutter receives "e with acute" as text input', _gkGreen),
          ],
        ),
      ),
      _gkSubtitle('Compose sequences'),
      _gkBody(
          'Compose key sequences work similarly. The compose key '
          'starts a sequence, and subsequent keys produce a composed '
          'character:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _gkIce,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gkComposeRow('Compose + o + c', '\u00A9', 'Copyright symbol',
                _gkNavy),
            _gkComposeRow('Compose + - + >', '\u2192', 'Right arrow',
                _gkAccent),
            _gkComposeRow("Compose + ' + e", '\u00E9', 'e with acute accent',
                _gkGreen),
            _gkComposeRow('Compose + s + s', '\u00DF', 'German eszett',
                _gkOrange),
          ],
        ),
      ),
    ];

Widget _gkDeadStep(int step, String key, String result, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text('$step',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$key — ',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: c)),
                TextSpan(
                    text: result,
                    style: const TextStyle(
                        fontSize: 11.5, color: Colors.black54)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _gkComposeRow(
    String seq, String result, String desc, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(seq,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
          const SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(result,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black54)),
          ),
        ],
      ),
    );

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _gkSummary() => [
      _gkDivider(),
      _gkTitle('§10  Summary'),
      _gkBody(
          'GtkKeyHelper is the critical bridge between Linux GTK '
          'keyboard events and Flutter\'s unified key system, '
          'enabling cross-platform keyboard handling on Linux.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_gkNavy.withValues(alpha: 0.07), _gkIce],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _gkNavy.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _gkNavy)),
            const SizedBox(height: 10),
            _gkSumPt('Keysym mapping',
                'GDK keysyms to LogicalKeyboardKey'),
            _gkSumPt('Hardware mapping',
                'Scancodes to PhysicalKeyboardKey'),
            _gkSumPt('Modifier decoding',
                'GDK state bitmask to modifier flags'),
            _gkSumPt('Layout aware',
                'Correct logical keys across QWERTY/AZERTY/etc'),
            _gkSumPt('Dead keys',
                'Handles compose sequences for accented input'),
            _gkSumPt('Cross-platform',
                'Output matches other platform key helpers'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _gkNavy,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of GtkKeyHelper Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _gkSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _gkAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _gkNavy)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _gkBanner(),
        const SizedBox(height: 20),
        ..._gkWhatIs(),
        ..._gkPipeline(),
        ..._gkKeysym(),
        ..._gkPhysical(),
        ..._gkModifiers(),
        ..._gkComparison(),
        ..._gkLayouts(),
        ..._gkDeadKeys(),
        ..._gkSummary(),
      ],
    ),
  );
}
