// ignore_for_file: avoid_print
// Deep demo: DoNothingAndStopPropagationTextIntent — a text-editing-specific
// intent that blocks shortcut propagation for keys that would conflict with
// text input operations inside EditableText widgets.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Burnt Sienna (#5D4037) on Peach Cream (#EFEBE9)
// Prefix: _dt (do-nothing text)
// ────────────────────────────────────────────────────────────

const Color _dtSienna = Color(0xFF5D4037);
const Color _dtPeach = Color(0xFFEFEBE9);
const Color _dtDark = Color(0xFF321911);
const Color _dtLight = Color(0xFF795548);
const Color _dtMuted = Color(0xFF8D6E63);
const Color _dtAccent = Color(0xFF6D4C41);
const Color _dtDivider = Color(0xFFBCAAA4);
const Color _dtWhite = Color(0xFFFFFFFF);
const Color _dtBlack = Color(0xFF212121);
const Color _dtError = Color(0xFFC62828);
const Color _dtInfo = Color(0xFF0277BD);
const Color _dtWarning = Color(0xFFF57F17);
const Color _dtSuccess = Color(0xFF2E7D32);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_dtSienna, _dtDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dtSienna.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.text_fields, color: _dtPeach, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DoNothingAndStop\nPropagationTextIntent',
                      style: TextStyle(
                        color: _dtPeach,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'A specialized intent for text editing contexts that '
                'blocks keyboard shortcuts from propagating while a text '
                'field has focus. Prevents edit-mode keys like Space, '
                'arrows, and Enter from triggering app-level shortcuts.',
                style: TextStyle(
                  color: _dtPeach.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dtSection('1. What Is DoNothingAndStopPropagationTextIntent?'),
        _dtBody(
          'It extends DoNothingAndStopPropagationIntent with a text '
          'editing context marker. When EditableText registers its '
          'shortcuts, certain keys that overlap with app-level '
          'shortcuts are mapped to this intent. The intent consumes '
          'the key event (preventing propagation) but performs no '
          'text editing action itself — the actual text handling '
          'happens through the platform text input channel instead.',
        ),
        const SizedBox(height: 12),
        _dtInfoBox(
          'Why Not Just DoNothingAndStopPropagationIntent?',
          'The text-specific variant allows the Actions framework to '
          'distinguish between "block this key for text editing reasons" '
          'and "block this key for general app reasons." This enables '
          'debug tools and key tracing to identify the source of the block.',
        ),
        const SizedBox(height: 24),

        // ── 2. Inheritance Chain ──
        _dtSection('2. Intent Inheritance Chain'),
        _dtBody(
          'The intent hierarchy for the "do nothing" family shows where '
          'this class fits:',
        ),
        const SizedBox(height: 12),
        _buildInheritanceChain(),
        const SizedBox(height: 24),

        // ── 3. Text Input Pipeline ──
        _dtSection('3. Text Input Pipeline'),
        _dtBody(
          'When a text field has focus, key events go through two '
          'parallel pipelines. The shortcuts pipeline may block keys '
          'using this intent, while the platform channel handles actual '
          'text insertion:',
        ),
        const SizedBox(height: 12),
        _buildTextInputPipeline(),
        const SizedBox(height: 24),

        // ── 4. Keys Blocked in EditableText ──
        _dtSection('4. Keys Blocked by EditableText'),
        _dtBody(
          'EditableText registers these keys with '
          'DoNothingAndStopPropagationTextIntent to prevent them from '
          'escaping the text field:',
        ),
        const SizedBox(height: 12),
        _buildBlockedKeys(),
        const SizedBox(height: 24),

        // ── 5. Comparison: Text vs General ──
        _dtSection('5. Text vs General Stop-Propagation'),
        _dtBody(
          'Comparing the two stop-propagation intents:',
        ),
        const SizedBox(height: 12),
        _buildTextVsGeneral(),
        const SizedBox(height: 24),

        // ── 6. Text Input Mode vs Navigation Mode ──
        _dtSection('6. Text Input Mode vs Navigation Mode'),
        _dtBody(
          'The same key can mean completely different things depending '
          'on whether a text field has focus:',
        ),
        const SizedBox(height: 12),
        _buildModeComparison(),
        const SizedBox(height: 24),

        // ── 7. Platform Channel Interaction ──
        _dtSection('7. Platform Channel Interaction'),
        _dtBody(
          'This intent works hand-in-hand with the platform text input '
          'channel. The shortcut layer blocks, the channel inserts:',
        ),
        const SizedBox(height: 12),
        _buildPlatformChannelInteraction(),
        const SizedBox(height: 24),

        // ── 8. Conflict Resolution ──
        _dtSection('8. Shortcut Conflict Resolution'),
        _dtBody(
          'When a text field is nested inside widgets with their own '
          'shortcuts, this intent resolves the conflict:',
        ),
        const SizedBox(height: 12),
        _buildConflictResolution(),
        const SizedBox(height: 24),

        // ── 9. Custom Text Editor Scenario ──
        _dtSection('9. Custom Text Editor Scenario'),
        _dtBody(
          'Building a code editor that must block even more keys than '
          'the default EditableText:',
        ),
        const SizedBox(height: 12),
        _dtCodeBlock(
          '// Custom editor with extra blocked keys\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    // Block Tab from leaving editor focus\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.tab,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationTextIntent(),\n'
          '\n'
          '    // Block Ctrl+/ from browser search\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.slash,\n'
          '      control: true,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationTextIntent(),\n'
          '\n'
          '    // Block F1-F12 from triggering\n'
          '    // app shortcuts while editing\n'
          '    for (final key in [\n'
          '      LogicalKeyboardKey.f1,\n'
          '      LogicalKeyboardKey.f2,\n'
          '      LogicalKeyboardKey.f3,\n'
          '    ])\n'
          '      SingleActivator(key):\n'
          '        const DoNothingAndStop\n'
          '            PropagationTextIntent(),\n'
          '  },\n'
          '  child: CodeEditorField(),\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 10. IME Composition Blocking ──
        _dtSection('10. IME Composition Blocking'),
        _dtBody(
          'During IME (Input Method Editor) composition for CJK input, '
          'many keys must be blocked from triggering shortcuts:',
        ),
        const SizedBox(height: 12),
        _buildIMEBlocking(),
        const SizedBox(height: 24),

        // ── 11. Debug Tracing ──
        _dtSection('11. Debug Tracing & Identification'),
        _dtBody(
          'When debugging why a shortcut is not working, the text-specific '
          'intent type helps identify the source:',
        ),
        const SizedBox(height: 12),
        _buildDebugTracing(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dtSienna.withValues(alpha: 0.08),
                _dtPeach,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _dtSienna.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dtSienna, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dtSienna,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dtSummaryRow('Type', 'Intent (text editing marker)'),
              _dtSummaryRow('Parent', 'DoNothingAndStopPropagationIntent'),
              _dtSummaryRow('Registered By', 'EditableText Shortcuts'),
              _dtSummaryRow('Purpose', 'Block text-conflicting keys'),
              _dtSummaryRow('Propagation', 'Stopped — key consumed'),
              _dtSummaryRow('Text Input', 'Handled via platform channel'),
              _dtSummaryRow('Debug Value', 'Identifies block source as text'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dtSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dtSienna,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dtBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dtBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dtCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFD7CCC8),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _dtInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dtInfo, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _dtInfo,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _dtBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dtSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: _dtMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dtBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildInheritanceChain() {
  final chain = <Map<String, dynamic>>[
    {
      'name': 'Intent',
      'desc': 'Abstract base class for all intents',
      'color': _dtMuted,
      'indent': 0,
    },
    {
      'name': 'DoNothingAndStop\nPropagationIntent',
      'desc': 'No action, consumes key event',
      'color': _dtLight,
      'indent': 1,
    },
    {
      'name': 'DoNothingAndStop\nPropagationTextIntent',
      'desc': 'Text-editing-specific blocker',
      'color': _dtSienna,
      'indent': 2,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < chain.length; i++) ...[
          Padding(
            padding: EdgeInsets.only(left: (chain[i]['indent'] as int) * 24.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (chain[i]['color'] as Color).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (chain[i]['color'] as Color).withValues(alpha: 0.25),
                  width: i == chain.length - 1 ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    i == chain.length - 1
                        ? Icons.star
                        : Icons.circle_outlined,
                    color: chain[i]['color'] as Color,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chain[i]['name'] as String,
                          style: TextStyle(
                            color: chain[i]['color'] as Color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          chain[i]['desc'] as String,
                          style: TextStyle(
                              color: _dtBlack, fontSize: 11, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (i < chain.length - 1)
            Padding(
              padding: EdgeInsets.only(
                  left: ((chain[i]['indent'] as int) + 1) * 24.0 + 6),
              child: Container(
                  width: 2, height: 12, color: _dtDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildTextInputPipeline() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dual Pipeline for Text Fields',
          style: TextStyle(
            color: _dtSienna, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shortcuts pipeline
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dtError.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _dtError.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.shortcut, color: _dtError, size: 22),
                    const SizedBox(height: 4),
                    Text('Shortcuts Pipeline',
                        style: TextStyle(color: _dtError, fontSize: 11,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 6),
                    Text('\u2022 Checks Shortcuts widgets',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    Text('\u2022 Finds StopPropTextIntent',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    Text('\u2022 Key consumed (blocked)',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _dtError.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('BLOCKED',
                          style: TextStyle(color: _dtError, fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Platform channel pipeline
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _dtSuccess.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dtSuccess.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.input, color: _dtSuccess, size: 22),
                    const SizedBox(height: 4),
                    Text('Platform Channel',
                        style: TextStyle(color: _dtSuccess, fontSize: 11,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 6),
                    Text('\u2022 OS text input service',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    Text('\u2022 Handles character insertion',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    Text('\u2022 Manages IME composition',
                        style: TextStyle(color: _dtBlack, fontSize: 10)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _dtSuccess.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('HANDLES TEXT',
                          style: TextStyle(color: _dtSuccess, fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBlockedKeys() {
  final keys = <Map<String, dynamic>>[
    {
      'key': 'Space',
      'reason': 'Types space character in text field',
      'icon': Icons.space_bar,
      'color': _dtSienna,
    },
    {
      'key': 'Enter',
      'reason': 'Inserts newline or submits form',
      'icon': Icons.keyboard_return,
      'color': _dtAccent,
    },
    {
      'key': 'Backspace',
      'reason': 'Deletes character before cursor',
      'icon': Icons.backspace_outlined,
      'color': _dtLight,
    },
    {
      'key': 'Delete',
      'reason': 'Deletes character after cursor',
      'icon': Icons.delete_outline,
      'color': _dtError,
    },
    {
      'key': 'Arrow keys',
      'reason': 'Moves cursor position in text',
      'icon': Icons.open_with,
      'color': _dtInfo,
    },
    {
      'key': 'Home / End',
      'reason': 'Moves cursor to line start/end',
      'icon': Icons.first_page,
      'color': _dtWarning,
    },
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (var k in keys)
        Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (k['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (k['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(k['icon'] as IconData,
                      color: k['color'] as Color, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    k['key'] as String,
                    style: TextStyle(
                      color: k['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                k['reason'] as String,
                style: TextStyle(color: _dtBlack, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildTextVsGeneral() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dtSienna.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dtSienna.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('...TextIntent',
                  style: TextStyle(color: _dtSienna, fontSize: 12,
                      fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 8),
              Text('\u2022 Text editing context',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Registered by EditableText',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Blocks text-conflicting keys',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Works with platform channel',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Identifiable in debug tools',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dtInfo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dtInfo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('...Intent (general)',
                  style: TextStyle(color: _dtInfo, fontSize: 12,
                      fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 8),
              Text('\u2022 Any widget context',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Registered by any widget',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Blocks any key for any reason',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 No text input awareness',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
              Text('\u2022 Generic in debug tools',
                  style: TextStyle(color: _dtBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildModeComparison() {
  final keys = <Map<String, dynamic>>[
    {
      'key': 'Space',
      'textMode': 'Insert space character',
      'navMode': 'Scroll down / activate button',
      'color': _dtSienna,
    },
    {
      'key': 'Enter',
      'textMode': 'Insert newline',
      'navMode': 'Activate focused element',
      'color': _dtAccent,
    },
    {
      'key': 'Arrow \u2191',
      'textMode': 'Move cursor up a line',
      'navMode': 'Navigate to previous item',
      'color': _dtLight,
    },
    {
      'key': 'Backspace',
      'textMode': 'Delete previous character',
      'navMode': 'Navigate back (browser)',
      'color': _dtError,
    },
    {
      'key': 'Tab',
      'textMode': 'Insert tab or indent',
      'navMode': 'Move focus to next widget',
      'color': _dtInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      children: [
        // Header row
        Row(
          children: [
            SizedBox(
              width: 70,
              child: Text('Key',
                  style: TextStyle(color: _dtMuted, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Text Mode (blocked)',
                  style: TextStyle(color: _dtSienna, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Nav Mode (propagates)',
                  style: TextStyle(color: _dtInfo, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const Divider(height: 14),
        for (var i = 0; i < keys.length; i++) ...[
          Row(
            children: [
              SizedBox(
                width: 70,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: (keys[i]['color'] as Color)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    keys[i]['key'] as String,
                    style: TextStyle(
                      color: keys[i]['color'] as Color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  keys[i]['textMode'] as String,
                  style: TextStyle(color: _dtBlack, fontSize: 11),
                ),
              ),
              Expanded(
                child: Text(
                  keys[i]['navMode'] as String,
                  style: TextStyle(color: _dtBlack, fontSize: 11),
                ),
              ),
            ],
          ),
          if (i < keys.length - 1) const SizedBox(height: 6),
        ],
      ],
    ),
  );
}

Widget _buildPlatformChannelInteraction() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'User presses Space in TextField',
      'handler': 'Keyboard',
      'icon': Icons.keyboard,
      'color': _dtMuted,
    },
    {
      'step': 'EditableText Shortcuts matches Space',
      'handler': 'StopPropTextIntent consumed',
      'icon': Icons.shortcut,
      'color': _dtError,
    },
    {
      'step': 'Platform text input channel receives key',
      'handler': 'TextInputConnection.setEditingState',
      'icon': Icons.input,
      'color': _dtSuccess,
    },
    {
      'step': 'Space character inserted at cursor',
      'handler': 'TextEditingController updated',
      'icon': Icons.text_fields,
      'color': _dtSienna,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _dtWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step'] as String,
                      style: TextStyle(
                        color: steps[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['handler'] as String,
                      style: TextStyle(
                          color: _dtBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
              child: Container(width: 2, height: 10, color: _dtDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildConflictResolution() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shortcut Conflict: Space in Search Dialog',
          style: TextStyle(
            color: _dtSienna, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Outer scope
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dtWarning.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dtWarning.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Level: Shortcuts',
                  style: TextStyle(color: _dtWarning, fontSize: 11,
                      fontWeight: FontWeight.bold)),
              Text('Space \u2192 PlayPauseIntent (media)',
                  style: TextStyle(color: _dtBlack, fontSize: 10,
                      fontFamily: 'monospace')),
              const SizedBox(height: 8),
              // Inner scope
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: _dtSienna.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dtSienna.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TextField: EditableText Shortcuts',
                        style: TextStyle(color: _dtSienna, fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    Text('Space \u2192 StopPropagationTextIntent',
                        style: TextStyle(color: _dtBlack, fontSize: 10,
                            fontFamily: 'monospace')),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: _dtSuccess, size: 14),
                        const SizedBox(width: 4),
                        Text('Space types " " in search field',
                            style: TextStyle(color: _dtSuccess, fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.block, color: _dtError, size: 14),
                        const SizedBox(width: 4),
                        Text('PlayPauseIntent never fires',
                            style: TextStyle(color: _dtError, fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIMEBlocking() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.language, color: _dtSienna, size: 20),
            const SizedBox(width: 8),
            Text(
              'CJK Input Method Composition',
              style: TextStyle(
                color: _dtSienna, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _dtIMEChip('Japanese', 'Romaji \u2192 Hiragana', _dtSienna),
            _dtIMEChip('Chinese', 'Pinyin \u2192 Hanzi', _dtAccent),
            _dtIMEChip('Korean', 'Jamo \u2192 Hangul', _dtLight),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'During composition, all letter keys, space, enter, and arrow '
          'keys are intercepted by the IME. The text intent ensures '
          'these keys do not trigger any Flutter shortcuts while '
          'composition is active.',
          style: TextStyle(color: _dtBlack, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _dtWarning.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _dtWarning.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: _dtWarning, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Without text intent blocking, pressing Space during '
                  'IME composition could trigger app shortcuts instead '
                  'of selecting the composed character.',
                  style: TextStyle(color: _dtBlack, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dtIMEChip(String lang, String flow, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(lang,
            style: TextStyle(color: color, fontSize: 11,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 6),
        Text(flow,
            style: TextStyle(color: _dtBlack, fontSize: 11)),
      ],
    ),
  );
}

Widget _buildDebugTracing() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dtPeach,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dtDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bug_report, color: _dtSienna, size: 20),
            const SizedBox(width: 8),
            Text(
              'Debug Output Identification',
              style: TextStyle(
                color: _dtSienna, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _dtCodeBlock(
          '// Key trace when Space is blocked\n'
          '// by text intent:\n'
          'KeyEvent: Space (physical)\n'
          '  \u2192 Shortcut match: EditableText\n'
          '  \u2192 Intent: DoNothingAndStop\n'
          '       PropagationTextIntent\n'
          '  \u2192 Source: TEXT_EDITING\n'
          '  \u2192 Key consumed: true\n'
          '\n'
          '// vs generic intent:\n'
          'KeyEvent: Space (physical)\n'
          '  \u2192 Shortcut match: GameCanvas\n'
          '  \u2192 Intent: DoNothingAndStop\n'
          '       PropagationIntent\n'
          '  \u2192 Source: UNKNOWN\n'
          '  \u2192 Key consumed: true',
        ),
        const SizedBox(height: 10),
        Text(
          'The "TEXT_EDITING" source marker helps developers quickly '
          'identify that a blocked key is due to a text field having '
          'focus, not a bug in their shortcut configuration.',
          style: TextStyle(
            color: _dtMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
