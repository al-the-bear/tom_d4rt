// ignore_for_file: avoid_print
// Deep demo: ButtonActivateIntent — keyboard activation of buttons
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Amber / Warm Cream
// ─────────────────────────────────────────────────────────────
const Color _baAmber = Color(0xFFFF6F00);
const Color _baCream = Color(0xFFFFF8E1);
const Color _baDarkAmber = Color(0xFFE65100);
const Color _baMedAmber = Color(0xFFFFA000);
const Color _baLightAmber = Color(0xFFFFE082);
const Color _baWhite = Color(0xFFFFFFFF);
const Color _baGray = Color(0xFFBF360C);
const Color _baAccentGreen = Color(0xFF2E7D32);
const Color _baAccentBlue = Color(0xFF1565C0);
const Color _baAccentTeal = Color(0xFF00796B);
const Color _baAccentPurple = Color(0xFF6A1B9A);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _baSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _baWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _baLightAmber, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x1AFF6F00), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _baAmber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _baWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _baLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _baDarkAmber,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _baBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _baGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _baCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _baLightAmber.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _baDarkAmber,
            height: 1.45)),
  );
}

Widget _baChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _baDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _baLightAmber.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: ButtonActivateIntent');
  print('  Keyboard activation of interactive buttons');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _baCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: _baAmber,
        foregroundColor: _baWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ButtonActivateIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_baDarkAmber, _baAmber, _baMedAmber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _baWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.touch_app_rounded,
                        color: _baWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('ButtonActivateIntent',
                      style: TextStyle(
                          color: _baWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Keyboard-driven button activation via Intent system',
                      style: TextStyle(
                          color: _baWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _baChip('Intent', _baWhite.withValues(alpha: 0.25), _baWhite),
                      _baChip('Enter / Space', _baWhite.withValues(alpha: 0.25), _baWhite),
                      _baChip('Activation', _baWhite.withValues(alpha: 0.25), _baWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('1 · What Is ButtonActivateIntent?', [
              _baBody(
                'ButtonActivateIntent is the semantic intent that represents '
                '"activate this button". When the user presses Enter or Space '
                'while a button has keyboard focus, Flutter dispatches this '
                'intent through the Shortcuts/Actions system.',
              ),
              _baLabel('Class definition'),
              _baCodeBlock(
                'Intent  (abstract base)\n'
                '  └─ ButtonActivateIntent\n'
                '       • Concrete, no extra fields\n'
                '       • const constructor\n'
                '       • Dispatched by Enter and Space keys\n'
                '       • Triggers the button\'s onPressed callback',
              ),
              _baDivider(),
              _baBody(
                'This intent ensures that buttons work identically whether '
                'activated by mouse click, touch tap, or keyboard. It is '
                'the bridge between key events and button behavior.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Intent → Action → Button chain
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('2 · Intent → Action → Button Chain', [
              _baBody(
                'The activation flows through three layers, separating '
                'the key binding from the semantic action from the '
                'actual button callback.',
              ),
              ..._buildActivationChain(),
              _baDivider(),
              _baLabel('Wiring code'),
              _baCodeBlock(
                '// Flutter wires this automatically for all buttons:\n'
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    const SingleActivator(LogicalKeyboardKey.enter):\n'
                '        const ButtonActivateIntent(),\n'
                '    const SingleActivator(LogicalKeyboardKey.space):\n'
                '        const ButtonActivateIntent(),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: {\n'
                '      ButtonActivateIntent:\n'
                '          _ButtonActivateAction(onPressed),\n'
                '    },\n'
                '    child: focusableButton,\n'
                '  ),\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Button types that respond
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('3 · Button Types That Respond', [
              _baBody(
                'All standard Material and Cupertino buttons automatically '
                'respond to ButtonActivateIntent when focused.',
              ),
              _buildButtonTypeGrid(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Enter vs Space activation
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('4 · Enter vs Space — Two Keys, One Intent', [
              _baBody(
                'Both Enter and Space produce the same ButtonActivateIntent, '
                'but they exhibit different behavior on the web and in '
                'certain platform contexts.',
              ),
              _buildKeyComparisonTable(),
              _baDivider(),
              _baLabel('Why two keys?'),
              _baBody(
                'Enter has been the standard form-submission key since '
                'terminals. Space has been the standard button-toggle key '
                'since early GUIs. Flutter supports both for maximum '
                'accessibility and user expectation coverage.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Focus + activation flow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('5 · Focus and Activation Flow', [
              _baBody(
                'A button must have keyboard focus before it can receive '
                'ButtonActivateIntent. Tab navigation moves focus, then '
                'Enter/Space activates.',
              ),
              _buildFocusActivationFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Platform activation keys
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('6 · Platform-Specific Activation Keys', [
              _baBody(
                'While Enter and Space are universal, certain platforms '
                'have additional activation conventions.',
              ),
              ..._buildPlatformActivationCards(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Disabled state
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('7 · Disabled State — Intent Blocked', [
              _baBody(
                'When a button is disabled (onPressed is null), it removes '
                'its Action mapping. The intent is dispatched but no Action '
                'handles it — so nothing happens.',
              ),
              _buildDisabledStateVisual(),
              _baDivider(),
              _baLabel('Implementation detail'),
              _baCodeBlock(
                '// Button internally:\n'
                'Actions(\n'
                '  actions: widget.onPressed != null\n'
                '    ? { ButtonActivateIntent: _ActivateAction(...) }\n'
                '    : const {},  // No action → intent ignored\n'
                '  child: ...\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Custom action override
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('8 · Custom Action Override', [
              _baBody(
                'You can intercept ButtonActivateIntent to add custom '
                'behavior — logging, animations, confirmations — before '
                'or instead of the default activation.',
              ),
              _baCodeBlock(
                'Actions(\n'
                '  actions: {\n'
                '    ButtonActivateIntent: CallbackAction(\n'
                '      onInvoke: (intent) {\n'
                '        print(\'Button activated via keyboard!\');\n'
                '        _showRippleEffect();\n'
                '        _originalOnPressed();\n'
                '        return null;\n'
                '      },\n'
                '    ),\n'
                '  },\n'
                '  child: myButton,\n'
                ')',
              ),
              _baDivider(),
              _buildCustomOverrideDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Simulated button row
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('9 · Simulated Button Row with Activation', [
              _baBody(
                'A row of buttons showing different focus and activation '
                'states. The second button has focus and is being activated '
                'via Enter key.',
              ),
              _buildSimulatedButtonRow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Form submission
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('10 · Real-World: Form Submission', [
              _baBody(
                'In forms, ButtonActivateIntent enables the common pattern '
                'of Tab-to-submit-button, then Enter-to-submit. The user '
                'never needs to reach for the mouse.',
              ),
              _buildFormSubmissionDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Accessibility role
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('11 · Accessibility Significance', [
              _baBody(
                'Keyboard activation is a WCAG requirement for all '
                'interactive elements. ButtonActivateIntent is Flutter\'s '
                'implementation of this standard.',
              ),
              _buildAccessibilityGrid(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _baSection('12 · Summary', [
              _baBody(
                'ButtonActivateIntent is the semantic bridge between '
                'keyboard keys and button activation in Flutter.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_baAmber, _baMedAmber],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _baSummaryRow(Icons.touch_app, 'Triggers button\'s onPressed via keyboard'),
                    _baSummaryRow(Icons.keyboard, 'Bound to Enter and Space by default'),
                    _baSummaryRow(Icons.widgets, 'All Material/Cupertino buttons respond'),
                    _baSummaryRow(Icons.block, 'Disabled buttons ignore the intent'),
                    _baSummaryRow(Icons.tune, 'Can be overridden with custom Actions'),
                    _baSummaryRow(Icons.accessible, 'WCAG-compliant keyboard interaction'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Activation chain
// ─────────────────────────────────────────────────────────────
List<Widget> _buildActivationChain() {
  final layers = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut Layer',
      'detail': 'Enter/Space → ButtonActivateIntent()',
      'color': _baAccentBlue,
    },
    {
      'icon': Icons.send,
      'title': 'Intent Layer',
      'detail': 'Carries "activate this button" semantics',
      'color': _baAmber,
    },
    {
      'icon': Icons.play_circle,
      'title': 'Action Layer',
      'detail': 'Calls button.onPressed() callback',
      'color': _baAccentGreen,
    },
  ];
  return layers.map((l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (l['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (l['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: l['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Icon(l['icon'] as IconData, color: _baWhite, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l['title'] as String,
                    style: TextStyle(
                        color: l['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Text(l['detail'] as String,
                    style: const TextStyle(
                        color: _baGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 3: Button type grid
// ─────────────────────────────────────────────────────────────
Widget _buildButtonTypeGrid() {
  final buttons = <Map<String, dynamic>>[
    {'name': 'ElevatedButton', 'icon': Icons.arrow_upward, 'color': _baAccentBlue},
    {'name': 'TextButton', 'icon': Icons.text_fields, 'color': _baAccentGreen},
    {'name': 'OutlinedButton', 'icon': Icons.crop_square, 'color': _baAccentPurple},
    {'name': 'IconButton', 'icon': Icons.star, 'color': _baAmber},
    {'name': 'FloatingActionButton', 'icon': Icons.add, 'color': _baDarkAmber},
    {'name': 'PopupMenuButton', 'icon': Icons.more_vert, 'color': _baAccentTeal},
    {'name': 'DropdownButton', 'icon': Icons.arrow_drop_down, 'color': _baAccentBlue},
    {'name': 'CupertinoButton', 'icon': Icons.apple, 'color': _baGray},
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: buttons.map((b) {
      return Container(
        width: 145,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (b['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (b['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: b['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child:
                  Icon(b['icon'] as IconData, color: _baWhite, size: 14),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(b['name'] as String,
                  style: TextStyle(
                      color: b['color'] as Color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Key comparison table
// ─────────────────────────────────────────────────────────────
Widget _buildKeyComparisonTable() {
  final rows = <List<String>>[
    ['Aspect', 'Enter', 'Space'],
    ['Intent dispatched', 'ButtonActivateIntent', 'ButtonActivateIntent'],
    ['Web behavior', 'Also submits forms', 'Scrolls page (if not consumed)'],
    ['Hold behavior', 'No repeat typically', 'May repeat on some platforms'],
    ['Toggle buttons', 'Activates once', 'Activates once'],
    ['Tradition', 'Form submission', 'GUI button toggle'],
  ];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _baLightAmber),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        final row = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: isHeader
              ? _baAmber
              : entry.key.isEven
                  ? _baCream
                  : _baWhite,
          child: Row(
            children: row.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 0 ? 2 : 3,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _baWhite : _baGray,
                        fontSize: 10.5,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Focus activation flow
// ─────────────────────────────────────────────────────────────
Widget _buildFocusActivationFlow() {
  final steps = <Map<String, dynamic>>[
    {'step': '1', 'title': 'User presses Tab', 'desc': 'Focus moves to button', 'icon': Icons.tab, 'color': _baAccentBlue},
    {'step': '2', 'title': 'Focus ring appears', 'desc': 'Visual indicator shown', 'icon': Icons.radio_button_checked, 'color': _baAccentTeal},
    {'step': '3', 'title': 'User presses Enter', 'desc': 'Shortcut dispatches intent', 'icon': Icons.keyboard_return, 'color': _baAmber},
    {'step': '4', 'title': 'Action runs', 'desc': 'onPressed callback fires', 'icon': Icons.bolt, 'color': _baAccentGreen},
    {'step': '5', 'title': 'Visual feedback', 'desc': 'Splash/highlight shown', 'icon': Icons.animation, 'color': _baAccentPurple},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _baCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _baLightAmber),
    ),
    child: Column(
      children: steps.map((s) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (s['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: (s['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: s['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Icon(s['icon'] as IconData,
                    color: _baWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Step ${s['step']}: ${s['title']}',
                        style: TextStyle(
                            color: s['color'] as Color,
                            fontWeight: FontWeight.w700,
                            fontSize: 11.5)),
                    Text(s['desc'] as String,
                        style: const TextStyle(
                            color: _baGray, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Platform activation cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildPlatformActivationCards() {
  final platforms = <Map<String, dynamic>>[
    {'platform': 'macOS', 'keys': 'Space (primary), Enter', 'note': 'macOS natively uses Space for buttons', 'icon': Icons.desktop_mac},
    {'platform': 'Windows', 'keys': 'Enter (primary), Space', 'note': 'Enter is default in Win32 dialogs', 'icon': Icons.desktop_windows},
    {'platform': 'Linux', 'keys': 'Enter, Space', 'note': 'Both equally standard', 'icon': Icons.computer},
    {'platform': 'Web', 'keys': 'Enter, Space', 'note': 'Space also scrolls if not handled', 'icon': Icons.language},
  ];
  return platforms.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _baCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _baLightAmber.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(p['icon'] as IconData, size: 18, color: _baAmber),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['platform'] as String,
                    style: const TextStyle(
                        color: _baDarkAmber,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Text(p['keys'] as String,
                    style: const TextStyle(
                        color: _baGray,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                Text(p['note'] as String,
                    style: TextStyle(
                        color: _baGray.withValues(alpha: 0.7),
                        fontSize: 9.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 7: Disabled state visual
// ─────────────────────────────────────────────────────────────
Widget _buildDisabledStateVisual() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _baCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _baLightAmber),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _baAccentGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _baAccentGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.check_circle,
                    color: _baAccentGreen, size: 24),
                const SizedBox(height: 6),
                const Text('Enabled',
                    style: TextStyle(
                        color: _baAccentGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _baAccentGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Submit',
                      style: TextStyle(
                          color: _baWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 4),
                const Text('Enter → onPressed fires',
                    style: TextStyle(
                        color: _baAccentGreen, fontSize: 9)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0x0A000000),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x30000000)),
            ),
            child: Column(
              children: [
                Icon(Icons.block,
                    color: _baGray.withValues(alpha: 0.5), size: 24),
                const SizedBox(height: 6),
                Text('Disabled',
                    style: TextStyle(
                        color: _baGray.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x1A000000),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Submit',
                      style: TextStyle(
                          color: _baGray.withValues(alpha: 0.4),
                          fontSize: 11)),
                ),
                const SizedBox(height: 4),
                Text('Enter → nothing happens',
                    style: TextStyle(
                        color: _baGray.withValues(alpha: 0.5),
                        fontSize: 9)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Custom override demo
// ─────────────────────────────────────────────────────────────
Widget _buildCustomOverrideDemo() {
  final overrides = <Map<String, dynamic>>[
    {'name': 'Logging', 'desc': 'Log every keyboard activation', 'icon': Icons.notes, 'color': _baAccentBlue},
    {'name': 'Confirmation', 'desc': 'Show dialog before action', 'icon': Icons.help, 'color': _baAccentPurple},
    {'name': 'Animation', 'desc': 'Play custom press animation', 'icon': Icons.animation, 'color': _baAccentGreen},
    {'name': 'Throttle', 'desc': 'Prevent rapid re-activation', 'icon': Icons.timer, 'color': _baAmber},
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: overrides.map((o) {
      return Container(
        width: 145,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (o['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (o['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(o['icon'] as IconData,
                size: 20, color: o['color'] as Color),
            const SizedBox(height: 6),
            Text(o['name'] as String,
                style: TextStyle(
                    color: o['color'] as Color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
            Text(o['desc'] as String,
                style: const TextStyle(
                    color: _baGray, fontSize: 9.5, height: 1.3)),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 9: Simulated button row
// ─────────────────────────────────────────────────────────────
Widget _buildSimulatedButtonRow() {
  final buttons = <Map<String, dynamic>>[
    {'label': 'Cancel', 'state': 'unfocused', 'color': _baGray},
    {'label': 'Save Draft', 'state': 'focused + activating', 'color': _baAmber},
    {'label': 'Publish', 'state': 'unfocused', 'color': _baAccentGreen},
    {'label': 'Delete', 'state': 'disabled', 'color': const Color(0xFF9E9E9E)},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _baCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _baLightAmber),
    ),
    child: Column(
      children: [
        Row(
          children: buttons.map((b) {
            final isFocused = (b['state'] as String).contains('focused');
            final isDisabled = b['state'] == 'disabled';
            final isActivating = (b['state'] as String).contains('activating');
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? const Color(0x1A000000)
                            : isActivating
                                ? (b['color'] as Color).withValues(alpha: 0.2)
                                : b['color'] as Color,
                        borderRadius: BorderRadius.circular(8),
                        border: isFocused
                            ? Border.all(color: _baAccentBlue, width: 2.5)
                            : null,
                        boxShadow: isActivating
                            ? [
                                BoxShadow(
                                  color: (b['color'] as Color)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(b['label'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isDisabled
                                  ? const Color(0x66000000)
                                  : isActivating
                                      ? b['color'] as Color
                                      : _baWhite,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 4),
                    Text(b['state'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isFocused ? _baAmber : _baGray,
                            fontSize: 8.5,
                            fontWeight: isFocused
                                ? FontWeight.w700
                                : FontWeight.w400)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _baAmber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _baKeyHint('Tab', 'Move focus'),
              const SizedBox(width: 12),
              _baKeyHint('Enter', 'Activate'),
              const SizedBox(width: 12),
              _baKeyHint('Space', 'Activate'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _baKeyHint(String key, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: _baWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _baLightAmber),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0FFF6F00),
                blurRadius: 2,
                offset: Offset(0, 1)),
          ],
        ),
        child: Text(key,
            style: const TextStyle(
                color: _baDarkAmber,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
      ),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(color: _baGray, fontSize: 9.5)),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Form submission demo
// ─────────────────────────────────────────────────────────────
Widget _buildFormSubmissionDemo() {
  return Container(
    decoration: BoxDecoration(
      color: _baWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _baLightAmber),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: _baCream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: const Row(
            children: [
              Icon(Icons.login, color: _baAmber, size: 18),
              SizedBox(width: 8),
              Text('Login Form — Keyboard Flow',
                  style: TextStyle(
                      color: _baDarkAmber,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        _buildFormField('Email', 'user@example.com', false, false),
        _buildFormField('Password', '••••••••', false, false),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _baAmber.withValues(alpha: 0.06),
            border: Border(
                bottom: BorderSide(
                    color: _baLightAmber.withValues(alpha: 0.3))),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: _baAmber,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _baAccentBlue, width: 2),
                ),
                child: const Text('Sign In',
                    style: TextStyle(
                        color: _baWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('← Focus here (Tab×2)',
                      style: TextStyle(
                          color: _baAccentBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                  Text('Enter → ButtonActivateIntent → onPressed',
                      style: TextStyle(
                          color: _baGray.withValues(alpha: 0.7),
                          fontSize: 9)),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: _baCream,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: const Text(
              'Tab → Tab → Tab → Enter = complete login without mouse',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _baAmber,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget _buildFormField(String label, String value, bool focused, bool filled) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      border: Border(
          bottom:
              BorderSide(color: _baLightAmber.withValues(alpha: 0.3))),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label,
              style: const TextStyle(
                  color: _baGray,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _baCream,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: focused ? _baAccentBlue : _baLightAmber),
            ),
            child: Text(value,
                style: TextStyle(
                    color: _baDarkAmber.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontFamily: 'monospace')),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Accessibility grid
// ─────────────────────────────────────────────────────────────
Widget _buildAccessibilityGrid() {
  final items = <Map<String, dynamic>>[
    {'req': 'Keyboard operable', 'check': true, 'detail': 'Enter/Space activates'},
    {'req': 'Focus visible', 'check': true, 'detail': 'Focus ring shown'},
    {'req': 'Role announced', 'check': true, 'detail': 'Semantics: button'},
    {'req': 'State communicated', 'check': true, 'detail': 'Enabled/disabled'},
    {'req': 'No mouse required', 'check': true, 'detail': 'Full keyboard flow'},
  ];
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _baCream,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _baLightAmber),
    ),
    child: Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _baWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: _baAccentGreen.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle,
                  size: 16, color: _baAccentGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item['req'] as String,
                    style: const TextStyle(
                        color: _baDarkAmber,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600)),
              ),
              Text(item['detail'] as String,
                  style: TextStyle(
                      color: _baGray.withValues(alpha: 0.7),
                      fontSize: 10)),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _baSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _baWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _baWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}
