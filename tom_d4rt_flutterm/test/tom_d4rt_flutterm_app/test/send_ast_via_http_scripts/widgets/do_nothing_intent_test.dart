// ignore_for_file: avoid_print
// Deep demo: DoNothingIntent — an intent that performs no action but allows
// the key event to propagate to parent widgets. The permissive counterpart
// to DoNothingAndStopPropagationIntent.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Deep Teal (#004D40) on Mint Foam (#E0F2F1)
// Prefix: _ni (nothing intent)
// ────────────────────────────────────────────────────────────

const Color _niTeal = Color(0xFF004D40);
const Color _niMint = Color(0xFFE0F2F1);
const Color _niDark = Color(0xFF00251A);
const Color _niLight = Color(0xFF26A69A);
const Color _niMuted = Color(0xFF80CBC4);
const Color _niAccent = Color(0xFF00897B);
const Color _niDivider = Color(0xFFB2DFDB);
const Color _niWhite = Color(0xFFFFFFFF);
const Color _niBlack = Color(0xFF212121);
const Color _niError = Color(0xFFC62828);
const Color _niInfo = Color(0xFF01579B);
const Color _niWarning = Color(0xFFF57F17);
const Color _niSuccess = Color(0xFF2E7D32);

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
              colors: [_niTeal, _niDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _niTeal.withValues(alpha: 0.35),
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
                  Icon(Icons.do_not_touch_outlined,
                      color: _niMint, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DoNothingIntent',
                      style: TextStyle(
                        color: _niMint,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An intent that explicitly performs no action. Unlike its '
                'stop-propagation siblings, the key event continues to '
                'propagate up the widget tree. Used to mark a shortcut '
                'as recognized without consuming or blocking it.',
                style: TextStyle(
                  color: _niMint.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _niSection('1. What Is DoNothingIntent?'),
        _niBody(
          'DoNothingIntent is a concrete Intent subclass that maps to '
          'DoNothingAction. When a Shortcuts widget matches a key combo '
          'to DoNothingIntent, the framework recognizes the shortcut '
          'but takes no action. Crucially, the key event is NOT consumed '
          '— it continues to propagate to parent Shortcuts widgets.',
        ),
        const SizedBox(height: 12),
        _niInfoBox(
          'Key Propagation Matters',
          'Because the key continues upward, a parent widget can still '
          'respond to it. This is useful when you want to mark a shortcut '
          'as "handled at this level" for debugging while letting parents '
          'optionally process the same key.',
        ),
        const SizedBox(height: 24),

        // ── 2. The Do-Nothing Family ──
        _niSection('2. The "Do Nothing" Intent Family'),
        _niBody(
          'Flutter provides three "do nothing" intents with different '
          'propagation behaviors:',
        ),
        const SizedBox(height: 12),
        _buildIntentFamily(),
        const SizedBox(height: 24),

        // ── 3. Propagation Comparison ──
        _niSection('3. Propagation Behavior Comparison'),
        _niBody(
          'The key difference between the three intents is what happens '
          'to the key event after the intent is matched:',
        ),
        const SizedBox(height: 12),
        _buildPropagationComparison(),
        const SizedBox(height: 24),

        // ── 4. Use Case: Debug Tracing ──
        _niSection('4. Use Case — Shortcut Debug Tracing'),
        _niBody(
          'Register DoNothingIntent to trace key bindings without '
          'affecting behavior:',
        ),
        const SizedBox(height: 12),
        _niCodeBlock(
          '// Trace which keys reach this level\n'
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyA,\n'
          '      control: true,\n'
          '    ): const DoNothingIntent(),\n'
          '    // Key still propagates upward\n'
          '    // Parent can handle Ctrl+A\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: {\n'
          '      DoNothingIntent:\n'
          '        CallbackAction<DoNothingIntent>(\n'
          '          onInvoke: (intent) {\n'
          '            debugPrint(\n'
          '              \'Shortcut passed through\',\n'
          '            );\n'
          '            return null;\n'
          '          },\n'
          '        ),\n'
          '    },\n'
          '    child: child,\n'
          '  ),\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 5. Use Case: Shortcut Placeholder ──
        _niSection('5. Use Case — Shortcut Placeholder'),
        _niBody(
          'Reserve a key binding in a Shortcuts map for a feature that '
          'is not yet implemented, without blocking the key:',
        ),
        const SizedBox(height: 12),
        _buildPlaceholderScenario(),
        const SizedBox(height: 24),

        // ── 6. Layered Shortcuts Architecture ──
        _niSection('6. Layered Shortcuts Architecture'),
        _niBody(
          'In a multi-layer shortcut setup, DoNothingIntent lets each '
          'layer observe keys without intercepting them:',
        ),
        const SizedBox(height: 12),
        _buildLayeredShortcuts(),
        const SizedBox(height: 24),

        // ── 7. Conditional Pass-Through ──
        _niSection('7. Conditional Pass-Through Pattern'),
        _niBody(
          'Use DoNothingIntent as a fallback when a condition is not met, '
          'allowing the key to reach handlers higher in the tree:',
        ),
        const SizedBox(height: 12),
        _niCodeBlock(
          '// Only handle Ctrl+S when dirty\n'
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '      control: true,\n'
          '    ): isDirty\n'
          '        ? const SaveIntent()\n'
          '        : const DoNothingIntent(),\n'
          '    // When not dirty, Ctrl+S propagates\n'
          '    // to parent shortcuts (e.g. global save)\n'
          '  },\n'
          '  child: editor,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 8. DoNothingAction ──
        _niSection('8. DoNothingAction — The Handler'),
        _niBody(
          'DoNothingAction is the Action that processes DoNothingIntent. '
          'It has a consumesKey property that defaults to false:',
        ),
        const SizedBox(height: 12),
        _buildActionDetails(),
        const SizedBox(height: 24),

        // ── 9. Keyboard Focus Context ──
        _niSection('9. Keyboard Focus & Shortcut Resolution'),
        _niBody(
          'How keyboard focus and shortcut resolution interact when a '
          'DoNothingIntent is in the chain:',
        ),
        const SizedBox(height: 12),
        _buildFocusResolution(),
        const SizedBox(height: 24),

        // ── 10. Common Mistakes ──
        _niSection('10. Common Mistakes'),
        _niBody(
          'Pitfalls when using DoNothingIntent:',
        ),
        const SizedBox(height: 12),
        _buildCommonMistakes(),
        const SizedBox(height: 24),

        // ── 11. When to Use Which ──
        _niSection('11. Decision Matrix'),
        _niBody(
          'A quick reference for choosing the right "do nothing" variant:',
        ),
        const SizedBox(height: 12),
        _buildDecisionMatrix(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _niTeal.withValues(alpha: 0.06),
                _niMint,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: _niTeal.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _niTeal, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _niTeal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _niSummaryRow('Type', 'Intent (no-op with propagation)'),
              _niSummaryRow('Paired Action', 'DoNothingAction'),
              _niSummaryRow('Key Consumed', 'No — event propagates'),
              _niSummaryRow('Use Cases', 'Debug tracing, placeholders'),
              _niSummaryRow('Siblings',
                  'StopPropagation, StopPropTextIntent'),
              _niSummaryRow('consumesKey', 'false by default'),
              _niSummaryRow('Key Behavior', 'Passes through to parent'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _niSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _niTeal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _niBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _niBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _niCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1B2631),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFB2DFDB),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _niInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _niInfo, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _niInfo,
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
            color: _niBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _niSummaryRow(String label, String value) {
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
              color: _niAccent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _niBlack,
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

Widget _buildIntentFamily() {
  final intents = <Map<String, dynamic>>[
    {
      'name': 'DoNothingIntent',
      'propagates': true,
      'desc': 'No action, key propagates upward',
      'icon': Icons.arrow_upward,
      'color': _niTeal,
    },
    {
      'name': 'DoNothingAndStop\nPropagationIntent',
      'propagates': false,
      'desc': 'No action, key consumed (blocked)',
      'icon': Icons.block,
      'color': _niError,
    },
    {
      'name': 'DoNothingAndStop\nPropagationTextIntent',
      'propagates': false,
      'desc': 'No action, key consumed (text editing)',
      'icon': Icons.text_fields,
      'color': _niWarning,
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
              color: (intents[i]['color'] as Color).withValues(alpha: 0.2),
              width: i == 0 ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: intents[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(intents[i]['icon'] as IconData,
                    color: _niWhite, size: 18),
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      intents[i]['desc'] as String,
                      style: TextStyle(
                          color: _niBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (intents[i]['propagates'] as bool)
                      ? _niSuccess.withValues(alpha: 0.1)
                      : _niError.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  (intents[i]['propagates'] as bool)
                      ? 'PROPAGATES'
                      : 'BLOCKS',
                  style: TextStyle(
                    color: (intents[i]['propagates'] as bool)
                        ? _niSuccess : _niError,
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

Widget _buildPropagationComparison() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Event After Intent Match',
          style: TextStyle(
            color: _niTeal, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Visual propagation flow
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DoNothingIntent — propagates up
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _niSuccess.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _niSuccess.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('DoNothingIntent',
                            style: TextStyle(color: _niSuccess, fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 4),
                        Icon(Icons.arrow_upward,
                            color: _niSuccess, size: 20),
                        const SizedBox(height: 4),
                        Text('Parent receives key',
                            style: TextStyle(
                                color: _niBlack, fontSize: 9),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.arrow_upward, color: _niSuccess, size: 14),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _niTeal.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Parent Shortcuts',
                        style: TextStyle(color: _niTeal, fontSize: 9,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // StopPropagation — blocked
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _niError.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _niError.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text('StopPropagation',
                            style: TextStyle(color: _niError, fontSize: 10,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 4),
                        Icon(Icons.block, color: _niError, size: 20),
                        const SizedBox(height: 4),
                        Text('Key consumed here',
                            style: TextStyle(
                                color: _niBlack, fontSize: 9),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.close, color: _niError, size: 14),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _niError.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Parent never sees it',
                        style: TextStyle(color: _niError, fontSize: 9,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPlaceholderScenario() {
  final phases = <Map<String, dynamic>>[
    {
      'phase': 'Phase 1: Reserved',
      'desc': 'Key binding reserved with DoNothingIntent. Key propagates '
          'past this level.',
      'icon': Icons.bookmark_border,
      'color': _niMuted,
    },
    {
      'phase': 'Phase 2: Implemented',
      'desc': 'Replace DoNothingIntent with actual intent when the feature '
          'is ready.',
      'icon': Icons.code,
      'color': _niAccent,
    },
    {
      'phase': 'Phase 3: Active',
      'desc': 'Shortcut now triggers the actual action. Key is consumed '
          'at this level.',
      'icon': Icons.flash_on,
      'color': _niTeal,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < phases.length; i++) ...[
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: phases[i]['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Icon(phases[i]['icon'] as IconData,
                    color: _niWhite, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      phases[i]['phase'] as String,
                      style: TextStyle(
                        color: phases[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      phases[i]['desc'] as String,
                      style: TextStyle(
                          color: _niBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < phases.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                  width: 2, height: 14, color: _niDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildLayeredShortcuts() {
  final layers = <Map<String, dynamic>>[
    {
      'layer': 'App Layer',
      'shortcut': 'Ctrl+P \u2192 PrintIntent',
      'note': 'Final handler — prints document',
      'color': _niTeal,
    },
    {
      'layer': 'Page Layer',
      'shortcut': 'Ctrl+P \u2192 DoNothingIntent',
      'note': 'Observes key, lets it propagate',
      'color': _niAccent,
    },
    {
      'layer': 'Widget Layer',
      'shortcut': 'Ctrl+P \u2192 DoNothingIntent',
      'note': 'Observes key, lets it propagate',
      'color': _niLight,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key passes through all DoNothingIntent layers',
          style: TextStyle(
            color: _niTeal, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        for (var i = layers.length - 1; i >= 0; i--) ...[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: (layers.length - 1 - i) * 16.0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (layers[i]['color'] as Color).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: (layers[i]['color'] as Color).withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  layers[i]['layer'] as String,
                  style: TextStyle(
                    color: layers[i]['color'] as Color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  layers[i]['shortcut'] as String,
                  style: TextStyle(color: _niBlack, fontSize: 10,
                      fontFamily: 'monospace'),
                ),
                Text(
                  layers[i]['note'] as String,
                  style: TextStyle(
                      color: _niMuted, fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          if (i > 0)
            Padding(
              padding: EdgeInsets.only(
                  left: (layers.length - 1 - i) * 16.0 + 16),
              child: Icon(Icons.arrow_upward, color: _niSuccess, size: 14),
            ),
        ],
      ],
    ),
  );
}

Widget _buildActionDetails() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DoNothingAction Properties',
          style: TextStyle(
            color: _niTeal, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _niSuccess.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _niSuccess.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('consumesKey: false',
                        style: TextStyle(color: _niSuccess, fontSize: 11,
                            fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                    const SizedBox(height: 4),
                    Text('Default behavior for DoNothingAction. '
                        'Key event propagates to parent.',
                        style: TextStyle(color: _niBlack, fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _niError.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _niError.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('consumesKey: true',
                        style: TextStyle(color: _niError, fontSize: 11,
                            fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                    const SizedBox(height: 4),
                    Text('When set explicitly. Mimics '
                        'StopPropagationIntent behavior.',
                        style: TextStyle(color: _niBlack, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _niCodeBlock(
          '// DoNothingAction defaults:\n'
          'DoNothingAction({bool consumesKey = false})\n'
          '\n'
          '// For DoNothingAndStopPropagationIntent:\n'
          'DoNothingAction(consumesKey: true)',
        ),
      ],
    ),
  );
}

Widget _buildFocusResolution() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'Key event dispatched from platform',
      'detail': 'HardwareKeyboard receives RawKeyEvent',
      'icon': Icons.keyboard,
      'color': _niMuted,
    },
    {
      'step': 'Focus scope determines target',
      'detail': 'FocusManager.primaryFocus identifies the focused widget',
      'icon': Icons.center_focus_strong,
      'color': _niAccent,
    },
    {
      'step': 'Walk up from focus node',
      'detail': 'ShortcutManager checks each Shortcuts ancestor',
      'icon': Icons.account_tree,
      'color': _niLight,
    },
    {
      'step': 'Match found: DoNothingIntent',
      'detail': 'Shortcut recognized, action invoked (no-op)',
      'icon': Icons.check,
      'color': _niTeal,
    },
    {
      'step': 'consumesKey = false',
      'detail': 'Key event continues to propagate upward',
      'icon': Icons.arrow_upward,
      'color': _niSuccess,
    },
    {
      'step': 'Parent Shortcuts may also match',
      'detail': 'Same key can trigger a different intent higher up',
      'icon': Icons.layers,
      'color': _niInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _niWhite, size: 14),
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
                      steps[i]['detail'] as String,
                      style: TextStyle(
                          color: _niBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Container(
                  width: 2, height: 8, color: _niDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildCommonMistakes() {
  final mistakes = <Map<String, dynamic>>[
    {
      'mistake': 'Using DoNothingIntent to block keys',
      'fix': 'Use DoNothingAndStopPropagationIntent instead',
      'icon': Icons.warning_amber,
      'color': _niError,
    },
    {
      'mistake': 'Expecting DoNothingIntent to consume key',
      'fix': 'Key propagates by default; check consumesKey',
      'icon': Icons.error_outline,
      'color': _niWarning,
    },
    {
      'mistake': 'Not providing a DoNothingAction in Actions',
      'fix': 'Register CallbackAction or DoNothingAction',
      'icon': Icons.help_outline,
      'color': _niInfo,
    },
    {
      'mistake': 'Infinite shortcut loops with propagation',
      'fix': 'Ensure parent does not re-dispatch same key',
      'icon': Icons.loop,
      'color': _niTeal,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < mistakes.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (mistakes[i]['color'] as Color).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (mistakes[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(mistakes[i]['icon'] as IconData,
                  color: mistakes[i]['color'] as Color, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mistakes[i]['mistake'] as String,
                      style: TextStyle(
                        color: mistakes[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: _niSuccess, size: 12),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            mistakes[i]['fix'] as String,
                            style: TextStyle(
                                color: _niSuccess, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < mistakes.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildDecisionMatrix() {
  final decisions = <Map<String, dynamic>>[
    {
      'goal': 'Debug/trace key events',
      'intent': 'DoNothingIntent',
      'reason': 'Key passes through, can be observed',
      'color': _niTeal,
    },
    {
      'goal': 'Reserve unimplemented shortcut',
      'intent': 'DoNothingIntent',
      'reason': 'Key propagates, no disruption',
      'color': _niAccent,
    },
    {
      'goal': 'Block key from all widgets',
      'intent': 'StopPropagationIntent',
      'reason': 'Key consumed, nothing happens',
      'color': _niError,
    },
    {
      'goal': 'Block key in text field',
      'intent': 'StopPropTextIntent',
      'reason': 'Text editing context marker',
      'color': _niWarning,
    },
    {
      'goal': 'Conditional shortcut fallback',
      'intent': 'DoNothingIntent',
      'reason': 'Lets parent handle when condition fails',
      'color': _niLight,
    },
    {
      'goal': 'Silence a key completely',
      'intent': 'StopPropagationIntent',
      'reason': 'No action, no propagation',
      'color': _niInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _niMint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _niDivider),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text('Goal',
                  style: TextStyle(color: _niTeal, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 3,
              child: Text('Intent',
                  style: TextStyle(color: _niTeal, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 4,
              child: Text('Reason',
                  style: TextStyle(color: _niTeal, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const Divider(height: 12),
        for (var i = 0; i < decisions.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  decisions[i]['goal'] as String,
                  style: TextStyle(
                    color: decisions[i]['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  decisions[i]['intent'] as String,
                  style: TextStyle(color: _niBlack, fontSize: 10,
                      fontFamily: 'monospace'),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  decisions[i]['reason'] as String,
                  style: TextStyle(color: _niBlack, fontSize: 10),
                ),
              ),
            ],
          ),
          if (i < decisions.length - 1) const SizedBox(height: 6),
        ],
      ],
    ),
  );
}
