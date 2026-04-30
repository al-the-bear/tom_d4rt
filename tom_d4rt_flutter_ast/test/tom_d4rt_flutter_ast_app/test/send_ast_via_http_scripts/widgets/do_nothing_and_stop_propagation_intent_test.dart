// ignore_for_file: avoid_print
// Deep demo: DoNothingAndStopPropagationIntent — an intent that explicitly
// does nothing and prevents the key event from propagating further through
// the widget tree or to the platform, effectively "swallowing" the key press.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Electric Indigo (#1A237E) on Lavender Ice (#E8EAF6)
// Prefix: _dn (do nothing)
// ────────────────────────────────────────────────────────────

const Color _dnIndigo = Color(0xFF1A237E);
const Color _dnLavender = Color(0xFFE8EAF6);
const Color _dnDark = Color(0xFF000051);
const Color _dnLight = Color(0xFF3949AB);
const Color _dnMuted = Color(0xFF78909C);
const Color _dnAccent = Color(0xFF5C6BC0);
const Color _dnDivider = Color(0xFF9FA8DA);
const Color _dnWhite = Color(0xFFFFFFFF);
const Color _dnBlack = Color(0xFF212121);
const Color _dnError = Color(0xFFC62828);
const Color _dnInfo = Color(0xFF0277BD);
const Color _dnWarning = Color(0xFFF57F17);
const Color _dnSuccess = Color(0xFF2E7D32);

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
              colors: [_dnIndigo, _dnDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _dnIndigo.withValues(alpha: 0.35),
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
                  Icon(Icons.block, color: _dnLavender, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DoNothingAndStop\nPropagationIntent',
                      style: TextStyle(
                        color: _dnLavender,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An intent that explicitly does nothing — AND tells the '
                'framework to stop propagating the key event. The shortcut '
                'is consumed silently: no action fires, the platform never '
                'sees the key, and no parent Shortcuts widget gets a chance '
                'to handle it.',
                style: TextStyle(
                  color: _dnLavender.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _dnSection('1. What Is DoNothingAndStopPropagationIntent?'),
        _dnBody(
          'It is a subclass of Intent with no properties, paired with '
          'DoNothingAction configured to consumeKey: true. When a '
          'Shortcuts widget maps a key to this intent, pressing that key '
          'does nothing visible — but the key event is consumed, which '
          'prevents it from bubbling up to ancestor Shortcuts widgets, '
          'to the platform, or to the browser.',
        ),
        const SizedBox(height: 12),
        _dnInfoBox(
          'Key Consumption',
          'In Flutter\'s key handling pipeline, consuming a key event '
          'means marking it as "handled." This stops the event from '
          'reaching other handlers, the OS, or (on web) the browser\'s '
          'default behavior.',
        ),
        const SizedBox(height: 24),

        // ── 2. The Three "Do Nothing" Intents ──
        _dnSection('2. The Three "Do Nothing" Intents'),
        _dnBody(
          'Flutter provides three related intents that all result in '
          'no action, but with different propagation behavior:',
        ),
        const SizedBox(height: 12),
        _buildThreeIntents(),
        const SizedBox(height: 24),

        // ── 3. How Key Events Propagate ──
        _dnSection('3. Key Event Propagation Pipeline'),
        _dnBody(
          'To understand why stopping propagation matters, here is '
          'how a key event travels through the framework:',
        ),
        const SizedBox(height: 12),
        _buildPropagationPipeline(),
        const SizedBox(height: 24),

        // ── 4. Use Case: Block Platform Shortcut ──
        _dnSection('4. Use Case: Block Platform Shortcuts'),
        _dnBody(
          'The most common reason to use this intent is to prevent '
          'a key combination from reaching the platform or browser:',
        ),
        const SizedBox(height: 12),
        _buildBlockPlatformExample(),
        const SizedBox(height: 24),

        // ── 5. Use Case: Override Parent Shortcut ──
        _dnSection('5. Use Case: Override Parent Shortcuts'),
        _dnBody(
          'When a child widget needs to disable a shortcut defined '
          'by a parent widget without introducing its own action:',
        ),
        const SizedBox(height: 12),
        _buildOverrideParentExample(),
        const SizedBox(height: 24),

        // ── 6. DoNothingAction Internals ──
        _dnSection('6. DoNothingAction Internals'),
        _dnBody(
          'DoNothingAndStopPropagationIntent pairs with DoNothingAction. '
          'The action has a consumesKey property that controls '
          'propagation:',
        ),
        const SizedBox(height: 12),
        _dnCodeBlock(
          '// DoNothingAction source (simplified)\n'
          'class DoNothingAction extends Action<Intent> {\n'
          '  DoNothingAction({this.consumesKey = true});\n'
          '\n'
          '  final bool consumesKey;\n'
          '\n'
          '  @override\n'
          '  bool consumesKey(\n'
          '    Intent intent,\n'
          '  ) => _consumesKey;\n'
          '\n'
          '  @override\n'
          '  void invoke(Intent intent) {\n'
          '    // Intentionally empty\n'
          '  }\n'
          '}\n'
          '\n'
          '// DoNothingAndStopPropagationIntent\n'
          '// uses consumesKey: true (stop)\n'
          '//\n'
          '// DoNothingIntent\n'
          '// uses consumesKey: false (bubble)',
        ),
        const SizedBox(height: 24),

        // ── 7. Visual: Consumed vs Not Consumed ──
        _dnSection('7. Key Event: Consumed vs Not Consumed'),
        _dnBody(
          'A side-by-side comparison of what happens when a key event '
          'is consumed versus when it is allowed to propagate:',
        ),
        const SizedBox(height: 12),
        _buildConsumedVsNot(),
        const SizedBox(height: 24),

        // ── 8. Web-Specific Scenarios ──
        _dnSection('8. Web-Specific Scenarios'),
        _dnBody(
          'On Flutter web, key events that are not consumed by the '
          'framework pass through to the browser. This can cause '
          'unwanted browser behavior:',
        ),
        const SizedBox(height: 12),
        _buildWebScenarios(),
        const SizedBox(height: 24),

        // ── 9. Text Field Integration ──
        _dnSection('9. Text Field Shortcut Blocking'),
        _dnBody(
          'Text fields use DoNothingAndStopPropagationIntent to prevent '
          'certain keys from triggering parent shortcuts while the '
          'field has focus:',
        ),
        const SizedBox(height: 12),
        _buildTextFieldIntegration(),
        const SizedBox(height: 24),

        // ── 10. Conditional Blocking ──
        _dnSection('10. Conditional Shortcut Blocking'),
        _dnBody(
          'You can conditionally block shortcuts by dynamically switching '
          'between DoNothingAndStopPropagationIntent and passing through:',
        ),
        const SizedBox(height: 12),
        _dnCodeBlock(
          '// Conditionally block Ctrl+S\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    if (isReadOnly)\n'
          '      const SingleActivator(\n'
          '        LogicalKeyboardKey.keyS,\n'
          '        control: true,\n'
          '      ): const DoNothingAndStop\n'
          '          PropagationIntent(),\n'
          '  },\n'
          '  child: DocumentEditor(),\n'
          ')\n'
          '\n'
          '// When isReadOnly is true:\n'
          '//   Ctrl+S is silently consumed\n'
          '// When isReadOnly is false:\n'
          '//   Ctrl+S propagates to parent\n'
          '//   (which saves the document)',
        ),
        const SizedBox(height: 24),

        // ── 11. Debugging Blocked Keys ──
        _dnSection('11. Debugging Blocked Keys'),
        _dnBody(
          'When keys seem to "disappear" and debugging shows no action '
          'fired, look for DoNothingAndStopPropagationIntent mappings:',
        ),
        const SizedBox(height: 12),
        _buildDebuggingGuide(),
        const SizedBox(height: 24),

        // ── 12. Game Controller Scenario ──
        _dnSection('12. Scenario: Game Controls'),
        _dnBody(
          'A Flutter game needs WASD for movement but must prevent '
          'these keys from triggering browser shortcuts or text input:',
        ),
        const SizedBox(height: 12),
        _buildGameScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _dnIndigo.withValues(alpha: 0.08),
                _dnLavender,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _dnIndigo.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _dnIndigo, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _dnIndigo,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _dnSummaryRow('Type', 'Intent (no properties)'),
              _dnSummaryRow('Action', 'DoNothingAction(consumesKey: true)'),
              _dnSummaryRow('Effect', 'No action fires, key event consumed'),
              _dnSummaryRow('Propagation', 'Stopped — parent Shortcuts blocked'),
              _dnSummaryRow('Platform', 'Key never reaches OS or browser'),
              _dnSummaryRow('vs DoNothingIntent', 'DoNothingIntent lets key propagate'),
              _dnSummaryRow('Primary Use', 'Block unwanted platform/browser shortcuts'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _dnSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _dnIndigo,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _dnBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _dnBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _dnCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1B2A),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFC5CAE9),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _dnInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dnInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dnInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _dnInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _dnInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _dnBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _dnSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              color: _dnMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _dnBlack,
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

Widget _buildThreeIntents() {
  final intents = <Map<String, dynamic>>[
    {
      'name': 'DoNothingIntent',
      'behavior': 'No action, key event propagates up',
      'consumesKey': false,
      'color': _dnSuccess,
      'icon': Icons.arrow_upward,
    },
    {
      'name': 'DoNothingAndStop\nPropagationIntent',
      'behavior': 'No action, key event consumed (stopped)',
      'consumesKey': true,
      'color': _dnError,
      'icon': Icons.block,
    },
    {
      'name': 'VoidCallbackIntent\n(with empty callback)',
      'behavior': 'Calls empty function, key consumed',
      'consumesKey': true,
      'color': _dnWarning,
      'icon': Icons.functions,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < intents.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (intents[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (intents[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (intents[i]['color'] as Color)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(intents[i]['icon'] as IconData,
                    color: intents[i]['color'] as Color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      intents[i]['name'] as String,
                      style: TextStyle(
                        color: intents[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      intents[i]['behavior'] as String,
                      style: TextStyle(
                          color: _dnBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (intents[i]['consumesKey'] as bool)
                      ? _dnError.withValues(alpha: 0.1)
                      : _dnSuccess.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  (intents[i]['consumesKey'] as bool)
                      ? 'STOPS'
                      : 'PASSES',
                  style: TextStyle(
                    color: (intents[i]['consumesKey'] as bool)
                        ? _dnError
                        : _dnSuccess,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (i < intents.length - 1) const SizedBox(height: 8),
      ],
    ],
  );
}

Widget _buildPropagationPipeline() {
  final stages = <Map<String, dynamic>>[
    {
      'stage': 'Hardware Key Event',
      'desc': 'Physical key press generates platform event',
      'icon': Icons.keyboard,
      'color': _dnMuted,
    },
    {
      'stage': 'RawKeyboardListener',
      'desc': 'Low-level handler receives event first',
      'icon': Icons.input,
      'color': _dnAccent,
    },
    {
      'stage': 'FocusManager',
      'desc': 'Routes event to the focused widget subtree',
      'icon': Icons.center_focus_strong,
      'color': _dnLight,
    },
    {
      'stage': 'Shortcuts Widget',
      'desc': 'Maps key combo to Intent',
      'icon': Icons.shortcut,
      'color': _dnIndigo,
    },
    {
      'stage': 'Actions Widget',
      'desc': 'Finds Action for the Intent',
      'icon': Icons.play_arrow,
      'color': _dnSuccess,
    },
    {
      'stage': 'consumesKey Check',
      'desc': 'If true: STOP. If false: propagate to parent.',
      'icon': Icons.rule,
      'color': _dnError,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dnLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dnDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < stages.length; i++) ...[
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: stages[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(stages[i]['icon'] as IconData,
                    color: _dnWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stages[i]['stage'] as String,
                      style: TextStyle(
                        color: stages[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stages[i]['desc'] as String,
                      style: TextStyle(
                          color: _dnBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < stages.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
              child: Container(width: 2, height: 10, color: _dnDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildBlockPlatformExample() {
  final examples = <Map<String, dynamic>>[
    {
      'keys': 'Ctrl+W',
      'platform': 'Closes browser tab',
      'blocked': 'Prevent tab close in web app',
      'icon': Icons.public,
      'color': _dnError,
    },
    {
      'keys': 'Ctrl+N',
      'platform': 'Opens new browser window',
      'blocked': 'Prevent new window in web app',
      'icon': Icons.open_in_new,
      'color': _dnWarning,
    },
    {
      'keys': 'Ctrl+T',
      'platform': 'Opens new browser tab',
      'blocked': 'Prevent new tab in web app',
      'icon': Icons.tab,
      'color': _dnAccent,
    },
    {
      'keys': 'F5',
      'platform': 'Refreshes the page',
      'blocked': 'Prevent page reload in web app',
      'icon': Icons.refresh,
      'color': _dnInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < examples.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (examples[i]['color'] as Color).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (examples[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: (examples[i]['color'] as Color)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  examples[i]['keys'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: examples[i]['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(examples[i]['icon'] as IconData,
                  color: examples[i]['color'] as Color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      examples[i]['platform'] as String,
                      style: TextStyle(
                        color: _dnBlack,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: _dnError,
                      ),
                    ),
                    Text(
                      examples[i]['blocked'] as String,
                      style: TextStyle(
                          color: _dnSuccess, fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < examples.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildOverrideParentExample() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dnLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dnDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parent-Child Shortcut Conflict',
          style: TextStyle(
            color: _dnIndigo, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Two layers
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dnIndigo.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dnIndigo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Parent: AppShortcuts',
                  style: TextStyle(color: _dnIndigo, fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text('Ctrl+A \u2192 SelectAllIntent',
                  style: TextStyle(color: _dnBlack, fontSize: 11,
                      fontFamily: 'monospace')),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: _dnError.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _dnError.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Child: CanvasShortcuts',
                        style: TextStyle(color: _dnError, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    Text(
                      'Ctrl+A \u2192 DoNothingAndStop\n'
                      '              PropagationIntent()',
                      style: TextStyle(color: _dnBlack, fontSize: 11,
                          fontFamily: 'monospace'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Canvas has no "select all" concept, so block '
                      'the shortcut from reaching the parent.',
                      style: TextStyle(
                          color: _dnMuted, fontSize: 11,
                          fontStyle: FontStyle.italic),
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

Widget _buildConsumedVsNot() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dnError.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dnError.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.block, color: _dnError, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Consumed (Stop)',
                        style: TextStyle(color: _dnError, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Key event marked as handled',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Parent Shortcuts NOT checked',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Platform/browser NOT notified',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Completely silent to the user',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _dnError.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'DoNothingAndStop\nPropagationIntent',
                  style: TextStyle(color: _dnError, fontSize: 10,
                      fontFamily: 'monospace', fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _dnSuccess.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _dnSuccess.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: _dnSuccess, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Not Consumed (Pass)',
                        style: TextStyle(color: _dnSuccess, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Key event still unhandled',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Parent Shortcuts checked next',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Platform may act on it',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              Text('\u2022 Browser default may trigger',
                  style: TextStyle(color: _dnBlack, fontSize: 11)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _dnSuccess.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'DoNothingIntent',
                  style: TextStyle(color: _dnSuccess, fontSize: 10,
                      fontFamily: 'monospace', fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildWebScenarios() {
  final scenarios = <Map<String, dynamic>>[
    {
      'key': 'Tab',
      'browser': 'Moves focus to next browser element',
      'solution': 'Block to keep focus inside Flutter canvas',
      'icon': Icons.tab,
      'color': _dnIndigo,
    },
    {
      'key': 'Space',
      'browser': 'Scrolls the page down',
      'solution': 'Block in game/canvas to use as action key',
      'icon': Icons.space_bar,
      'color': _dnAccent,
    },
    {
      'key': 'Backspace',
      'browser': 'Navigates back (some browsers)',
      'solution': 'Block to prevent accidental navigation',
      'icon': Icons.backspace,
      'color': _dnError,
    },
    {
      'key': 'Ctrl+P',
      'browser': 'Opens print dialog',
      'solution': 'Block to use as app-specific shortcut',
      'icon': Icons.print,
      'color': _dnWarning,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < scenarios.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (scenarios[i]['color'] as Color).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (scenarios[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (scenarios[i]['color'] as Color)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(scenarios[i]['icon'] as IconData,
                    color: scenarios[i]['color'] as Color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (scenarios[i]['color'] as Color)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            scenarios[i]['key'] as String,
                            style: TextStyle(
                              color: scenarios[i]['color'] as Color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            scenarios[i]['browser'] as String,
                            style: TextStyle(
                              color: _dnBlack,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: _dnError,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      scenarios[i]['solution'] as String,
                      style: TextStyle(
                          color: _dnSuccess, fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < scenarios.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildTextFieldIntegration() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dnLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _dnDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keys Blocked by TextField',
          style: TextStyle(
            color: _dnIndigo, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _dnKeyChip('Space', 'Text input'),
            _dnKeyChip('Enter', 'Submit or newline'),
            _dnKeyChip('Tab', 'No focus escape'),
            _dnKeyChip('Arrows', 'Cursor movement'),
            _dnKeyChip('Backspace', 'Delete char'),
            _dnKeyChip('Delete', 'Delete forward'),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'These keys are mapped to DoNothingAndStopPropagationIntent '
          'or handled directly, preventing parent shortcuts from firing.',
          style: TextStyle(
            color: _dnMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _dnKeyChip(String key, String purpose) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _dnIndigo.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _dnIndigo.withValues(alpha: 0.15)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(key,
            style: TextStyle(color: _dnIndigo, fontSize: 11,
                fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        const SizedBox(width: 6),
        Text(purpose,
            style: TextStyle(color: _dnMuted, fontSize: 11)),
      ],
    ),
  );
}

Widget _buildDebuggingGuide() {
  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Check Shortcuts widget bindings',
      'detail': 'Look for DoNothingAndStopPropagationIntent in the key map',
      'icon': Icons.search,
    },
    {
      'tip': 'Use debugPrintKeyEvents',
      'detail': 'Set debugPrintKeyboardEvents = true to trace key handling',
      'icon': Icons.bug_report,
    },
    {
      'tip': 'Inspect the focus chain',
      'detail': 'Use FocusDebugger to see which widget subtree has focus',
      'icon': Icons.center_focus_strong,
    },
    {
      'tip': 'Walk the Actions tree',
      'detail': 'Check Actions.find() to see which action handles the intent',
      'icon': Icons.account_tree,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < tips.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _dnLavender,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dnDivider),
          ),
          child: Row(
            children: [
              Icon(tips[i]['icon'] as IconData,
                  color: _dnIndigo, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tips[i]['tip'] as String,
                      style: TextStyle(
                        color: _dnDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      tips[i]['detail'] as String,
                      style: TextStyle(
                          color: _dnBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < tips.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildGameScenario() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _dnLavender,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _dnDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sports_esports, color: _dnIndigo, size: 22),
            const SizedBox(width: 8),
            Text(
              'Flutter Web Game: Block Browser Keys',
              style: TextStyle(
                color: _dnIndigo,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _dnCodeBlock(
          '// Game input layer\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    // WASD - game handles these via\n'
          '    // RawKeyboardListener, but block browser\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyW,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationIntent(),\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyA,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationIntent(),\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationIntent(),\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyD,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationIntent(),\n'
          '    // Space bar - prevent scroll\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.space,\n'
          '    ): const DoNothingAndStop\n'
          '        PropagationIntent(),\n'
          '  },\n'
          '  child: RawKeyboardListener(\n'
          '    focusNode: gameFocus,\n'
          '    onKey: handleGameInput,\n'
          '    child: GameCanvas(),\n'
          '  ),\n'
          ')',
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _dnSuccess.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _dnSuccess.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _dnSuccess, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Browser will not scroll, navigate, or trigger find-bar '
                  'when the game canvas has focus. Keys are consumed '
                  'silently by Flutter before reaching the browser.',
                  style: TextStyle(color: _dnBlack, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
