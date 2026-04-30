// ignore_for_file: avoid_print
// Deep demo: EditableTextTapOutsideIntent — an intent dispatched when the
// user taps outside an EditableText widget, enabling custom deselection,
// unfocus, and dismiss behaviors for text fields.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Royal Indigo (#283593) on Lavender Mist (#E8EAF6)
// Prefix: _to (tap outside)
// ────────────────────────────────────────────────────────────

const Color _toIndigo = Color(0xFF283593);
const Color _toLavender = Color(0xFFE8EAF6);
const Color _toDark = Color(0xFF001064);
const Color _toLight = Color(0xFF5C6BC0);
const Color _toMuted = Color(0xFF9FA8DA);
const Color _toAccent = Color(0xFF3949AB);
const Color _toDivider = Color(0xFFC5CAE9);
const Color _toWhite = Color(0xFFFFFFFF);
const Color _toBlack = Color(0xFF212121);
const Color _toError = Color(0xFFC62828);
const Color _toInfo = Color(0xFF01579B);
const Color _toWarning = Color(0xFFF57F17);
const Color _toSuccess = Color(0xFF2E7D32);

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
              colors: [_toIndigo, _toDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _toIndigo.withValues(alpha: 0.35),
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
                  Icon(Icons.touch_app, color: _toLavender, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'EditableTextTap\nOutsideIntent',
                      style: TextStyle(
                        color: _toLavender,
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
                'An intent dispatched when the user taps outside an '
                'EditableText widget. This enables customizable behavior '
                'for text field deselection, keyboard dismissal, and '
                'focus management when tapping away from a text input.',
                style: TextStyle(
                  color: _toLavender.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _toSection('1. What Is EditableTextTapOutsideIntent?'),
        _toBody(
          'When a user taps somewhere outside the bounds of an '
          'EditableText widget (TextField, TextFormField), the '
          'framework creates an EditableTextTapOutsideIntent and '
          'dispatches it through the Actions system. The default '
          'action unfocuses the text field and hides the keyboard.',
        ),
        const SizedBox(height: 12),
        _toInfoBox(
          'Why An Intent?',
          'By modeling the "tap outside" event as an intent, Flutter '
          'enables customization through the Actions framework. Apps '
          'can override the default unfocus behavior — for example, '
          'keeping focus when tapping on a toolbar button.',
        ),
        const SizedBox(height: 24),

        // ── 2. When Is It Dispatched ──
        _toSection('2. When Is It Dispatched?'),
        _toBody(
          'The intent is dispatched by the TapRegion system that '
          'EditableText registers:',
        ),
        const SizedBox(height: 12),
        _buildDispatchFlow(),
        const SizedBox(height: 24),

        // ── 3. Default Behavior ──
        _toSection('3. Default Behavior'),
        _toBody(
          'Without any customization, the default action performs:',
        ),
        const SizedBox(height: 12),
        _buildDefaultBehavior(),
        const SizedBox(height: 24),

        // ── 4. Intent Properties ──
        _toSection('4. Intent Properties'),
        _toBody(
          'The intent carries contextual information about the tap:',
        ),
        const SizedBox(height: 12),
        _buildIntentProperties(),
        const SizedBox(height: 24),

        // ── 5. Customizing Behavior ──
        _toSection('5. Customizing Tap Outside Behavior'),
        _toBody(
          'Override the default action to customize what happens '
          'when tapping outside:',
        ),
        const SizedBox(height: 12),
        _toCodeBlock(
          '// Keep keyboard open when tapping\n'
          '// certain areas (e.g. toolbar)\n'
          'Actions(\n'
          '  actions: {\n'
          '    EditableTextTapOutsideIntent:\n'
          '      CallbackAction<\n'
          '          EditableTextTapOutsideIntent>(\n'
          '        onInvoke: (intent) {\n'
          '          final focusNode =\n'
          '              intent.focusNode;\n'
          '          // Only unfocus if tap is not\n'
          '          // on a toolbar widget\n'
          '          if (!isToolbarTap) {\n'
          '            focusNode.unfocus();\n'
          '          }\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: editorWithToolbar,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 6. TapRegion Integration ──
        _toSection('6. TapRegion Integration'),
        _toBody(
          'EditableText uses TapRegion to detect taps inside vs '
          'outside the text field boundaries:',
        ),
        const SizedBox(height: 12),
        _buildTapRegionDiagram(),
        const SizedBox(height: 24),

        // ── 7. Platform Differences ──
        _toSection('7. Platform-Specific Behavior'),
        _toBody(
          'The default tap-outside behavior varies by platform:',
        ),
        const SizedBox(height: 12),
        _buildPlatformBehavior(),
        const SizedBox(height: 24),

        // ── 8. Multi-Field Scenarios ──
        _toSection('8. Multi-Field Form Scenarios'),
        _toBody(
          'When multiple text fields are in a form, tapping between '
          'fields triggers specific behavior:',
        ),
        const SizedBox(height: 12),
        _buildMultiFieldScenarios(),
        const SizedBox(height: 24),

        // ── 9. Keyboard Dismissal ──
        _toSection('9. Keyboard Dismissal Patterns'),
        _toBody(
          'Common patterns for dismissing the keyboard using the '
          'tap-outside intent:',
        ),
        const SizedBox(height: 12),
        _buildKeyboardDismissal(),
        const SizedBox(height: 24),

        // ── 10. Comparison with TapUpOutside ──
        _toSection('10. TapOutside vs TapUpOutside'),
        _toBody(
          'Comparing EditableTextTapOutsideIntent with its sibling '
          'EditableTextTapUpOutsideIntent:',
        ),
        const SizedBox(height: 12),
        _buildTapVsTapUp(),
        const SizedBox(height: 24),

        // ── 11. Testing Strategies ──
        _toSection('11. Testing Tap Outside'),
        _toBody(
          'Testing strategies for validating tap-outside behavior:',
        ),
        const SizedBox(height: 12),
        _toCodeBlock(
          '// Widget test for tap outside\n'
          'testWidgets(\n'
          '  \'unfocuses on tap outside\',\n'
          '  (tester) async {\n'
          '    await tester.pumpWidget(\n'
          '      MaterialApp(\n'
          '        home: Scaffold(\n'
          '          body: Column(children: [\n'
          '            const TextField(),\n'
          '            // Tap target outside field\n'
          '            const SizedBox(height: 200),\n'
          '          ]),\n'
          '        ),\n'
          '      ),\n'
          '    );\n'
          '\n'
          '    // Focus the text field\n'
          '    await tester.tap(\n'
          '      find.byType(TextField),\n'
          '    );\n'
          '    await tester.pump();\n'
          '    expect(\n'
          '      FocusScope.of(...).hasFocus,\n'
          '      isTrue,\n'
          '    );\n'
          '\n'
          '    // Tap outside\n'
          '    await tester.tapAt(\n'
          '      const Offset(100, 400),\n'
          '    );\n'
          '    await tester.pump();\n'
          '    // Focus should be lost\n'
          '  },\n'
          ');',
        ),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _toIndigo.withValues(alpha: 0.06),
                _toLavender,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: _toIndigo.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _toIndigo, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _toIndigo,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _toSummaryRow('Type', 'Intent (EditableText lifecycle)'),
              _toSummaryRow('Trigger', 'Tap outside EditableText bounds'),
              _toSummaryRow('Default Action', 'Unfocus + dismiss keyboard'),
              _toSummaryRow('Detection', 'TapRegion boundary system'),
              _toSummaryRow('Customizable', 'Yes — via Actions framework'),
              _toSummaryRow('Carries', 'FocusNode reference'),
              _toSummaryRow('Sibling', 'EditableTextTapUpOutsideIntent'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _toSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _toIndigo,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _toBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _toBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _toCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E),
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

Widget _toInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _toInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _toInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _toInfo, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _toInfo,
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
            color: _toBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _toSummaryRow(String label, String value) {
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
              color: _toAccent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _toBlack,
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

Widget _buildDispatchFlow() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'EditableText registers TapRegion',
      'detail': 'Defines the tap-inside boundary around the text field',
      'icon': Icons.crop_square,
      'color': _toMuted,
    },
    {
      'step': 'User taps somewhere on screen',
      'detail': 'PointerDownEvent dispatched by the engine',
      'icon': Icons.touch_app,
      'color': _toAccent,
    },
    {
      'step': 'TapRegion evaluates hit test',
      'detail': 'Determines if tap is inside or outside the region',
      'icon': Icons.gps_fixed,
      'color': _toLight,
    },
    {
      'step': 'Tap is outside — intent created',
      'detail': 'EditableTextTapOutsideIntent dispatched through Actions',
      'icon': Icons.call_missed_outgoing,
      'color': _toIndigo,
    },
    {
      'step': 'Action invoked',
      'detail': 'Default or custom action processes the intent',
      'icon': Icons.flash_on,
      'color': _toSuccess,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _toLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _toDivider),
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
                    color: _toWhite, size: 14),
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
                          color: _toBlack, fontSize: 11, height: 1.3),
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
                  width: 2, height: 8, color: _toDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildDefaultBehavior() {
  final actions = <Map<String, dynamic>>[
    {
      'action': 'Unfocus the text field',
      'detail': 'Calls FocusNode.unfocus() to remove focus',
      'icon': Icons.highlight_off,
      'color': _toIndigo,
    },
    {
      'action': 'Dismiss keyboard',
      'detail': 'SystemChannels.textInput.invokeMethod(TextInput.hide)',
      'icon': Icons.keyboard_hide,
      'color': _toAccent,
    },
    {
      'action': 'Clear selection',
      'detail': 'Text selection is collapsed to cursor position',
      'icon': Icons.deselect,
      'color': _toLight,
    },
    {
      'action': 'Hide text handles',
      'detail': 'Selection handles and toolbar are dismissed',
      'icon': Icons.cancel_presentation,
      'color': _toMuted,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < actions.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (actions[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (actions[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(actions[i]['icon'] as IconData,
                  color: actions[i]['color'] as Color, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actions[i]['action'] as String,
                      style: TextStyle(
                        color: actions[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      actions[i]['detail'] as String,
                      style: TextStyle(
                          color: _toBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < actions.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildIntentProperties() {
  final props = <Map<String, dynamic>>[
    {
      'prop': 'focusNode',
      'type': 'FocusNode',
      'desc': 'The focus node of the EditableText that was focused when '
          'the outside tap occurred. Used to control unfocus behavior.',
      'color': _toIndigo,
    },
    {
      'prop': 'pointerDownEvent',
      'type': 'PointerDownEvent',
      'desc': 'The raw pointer event that triggered the tap outside. '
          'Contains position, device type, and pressure data.',
      'color': _toAccent,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _toLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _toDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < props.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (props[i]['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  props[i]['prop'] as String,
                  style: TextStyle(
                    color: props[i]['color'] as Color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: _toBlack.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  props[i]['type'] as String,
                  style: TextStyle(
                    color: _toMuted,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            props[i]['desc'] as String,
            style: TextStyle(color: _toBlack, fontSize: 11, height: 1.3),
          ),
          if (i < props.length - 1) const SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildTapRegionDiagram() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _toLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _toDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TapRegion Boundary Detection',
          style: TextStyle(
            color: _toIndigo, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Visual diagram of tap regions
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: _toWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _toDivider),
          ),
          child: Stack(
            children: [
              // Outside zone label
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _toError.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('OUTSIDE (intent dispatched)',
                      style: TextStyle(color: _toError, fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              // TextField region
              Center(
                child: Container(
                  width: 220,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _toSuccess.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _toSuccess,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text('TextField (TapRegion)',
                        style: TextStyle(color: _toSuccess, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              // Inside label
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _toSuccess.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('INSIDE (no intent)',
                      style: TextStyle(color: _toSuccess, fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'The TapRegion defines the boundary. Taps inside the region '
          'are normal text field interactions. Taps outside trigger '
          'the EditableTextTapOutsideIntent.',
          style: TextStyle(
            color: _toMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildPlatformBehavior() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'behavior': 'Keyboard dismissed, focus removed. '
          'Standard Material behavior.',
      'icon': Icons.android,
      'color': _toSuccess,
    },
    {
      'platform': 'iOS',
      'behavior': 'Keyboard dismissed on tap outside. '
          'Cupertino unfocus pattern.',
      'icon': Icons.phone_iphone,
      'color': _toBlack,
    },
    {
      'platform': 'Web',
      'behavior': 'Focus removed from text field. Browser '
          'keyboard hides automatically.',
      'icon': Icons.language,
      'color': _toInfo,
    },
    {
      'platform': 'Desktop',
      'behavior': 'Focus moves to tapped widget. Keyboard '
          'not typically shown.',
      'icon': Icons.desktop_mac,
      'color': _toAccent,
    },
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (var p in platforms)
        Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (p['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (p['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(p['icon'] as IconData,
                      color: p['color'] as Color, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    p['platform'] as String,
                    style: TextStyle(
                      color: p['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                p['behavior'] as String,
                style: TextStyle(color: _toBlack, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildMultiFieldScenarios() {
  final scenarios = <Map<String, dynamic>>[
    {
      'scenario': 'Tap Field A \u2192 Tap Field B',
      'result': 'Focus moves to B. No TapOutside for A because '
          'field-to-field transitions use focus transfer.',
      'icon': Icons.swap_horiz,
      'color': _toIndigo,
    },
    {
      'scenario': 'Tap Field A \u2192 Tap empty area',
      'result': 'TapOutsideIntent dispatched. Field A loses focus '
          'and keyboard is dismissed.',
      'icon': Icons.highlight_off,
      'color': _toError,
    },
    {
      'scenario': 'Tap Field A \u2192 Tap submit button',
      'result': 'Button receives tap. TapOutsideIntent for A may or '
          'may not fire depending on button Focus behavior.',
      'icon': Icons.check_circle,
      'color': _toSuccess,
    },
    {
      'scenario': 'Tap Field A \u2192 Scroll gesture',
      'result': 'Scroll is not a tap; TapOutside not dispatched. '
          'Field A retains focus during scrolling.',
      'icon': Icons.swipe_vertical,
      'color': _toWarning,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _toLavender,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _toDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < scenarios.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: scenarios[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(scenarios[i]['icon'] as IconData,
                    color: _toWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenarios[i]['scenario'] as String,
                      style: TextStyle(
                        color: scenarios[i]['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      scenarios[i]['result'] as String,
                      style: TextStyle(
                          color: _toBlack, fontSize: 10, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < scenarios.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Divider(height: 1),
            ),
        ],
      ],
    ),
  );
}

Widget _buildKeyboardDismissal() {
  final patterns = <Map<String, dynamic>>[
    {
      'pattern': 'Immediate Dismiss',
      'desc': 'Default behavior — keyboard hides immediately on tap outside',
      'code': 'focusNode.unfocus()',
      'color': _toIndigo,
    },
    {
      'pattern': 'Delayed Dismiss',
      'desc': 'Wait before dismissing to allow toolbar interactions',
      'code': 'Future.delayed(ms300, unfocus)',
      'color': _toAccent,
    },
    {
      'pattern': 'Conditional Keep',
      'desc': 'Keep keyboard open when tapping connected UI elements',
      'code': 'if (!isConnected) unfocus()',
      'color': _toLight,
    },
    {
      'pattern': 'Never Dismiss',
      'desc': 'Override to always keep keyboard (kiosk/terminal apps)',
      'code': '// no-op action',
      'color': _toWarning,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < patterns.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (patterns[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (patterns[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patterns[i]['pattern'] as String,
                      style: TextStyle(
                        color: patterns[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      patterns[i]['desc'] as String,
                      style: TextStyle(
                          color: _toBlack, fontSize: 10, height: 1.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: _toBlack.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  patterns[i]['code'] as String,
                  style: TextStyle(
                    color: _toMuted,
                    fontSize: 9,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        if (i < patterns.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildTapVsTapUp() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _toIndigo.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _toIndigo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TapOutsideIntent',
                  style: TextStyle(color: _toIndigo, fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('\u2022 Fires on pointer down',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Immediate reaction',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Cannot detect drag vs tap',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Used for keyboard dismiss',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 PointerDownEvent data',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _toAccent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _toAccent.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TapUpOutsideIntent',
                  style: TextStyle(color: _toAccent, fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('\u2022 Fires on pointer up',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Delayed — after release',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Can distinguish tap from drag',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 Used for focus transfer',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
              Text('\u2022 PointerUpEvent data',
                  style: TextStyle(color: _toBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
    ],
  );
}
