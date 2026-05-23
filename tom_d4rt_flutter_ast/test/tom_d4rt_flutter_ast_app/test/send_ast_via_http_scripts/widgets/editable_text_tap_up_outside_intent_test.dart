// ignore_for_file: avoid_print
// Deep demo: EditableTextTapUpOutsideIntent — an intent dispatched when the
// user completes a tap (pointer up) outside an EditableText widget. Unlike
// TapOutsideIntent which fires on pointer down, this fires on pointer up,
// enabling distinction between taps and drags.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Forest Emerald (#1B5E20) on Pale Sage (#E8F5E9)
// Prefix: _tu (tap up)
// ────────────────────────────────────────────────────────────

const Color _tuEmerald = Color(0xFF1B5E20);
const Color _tuSage = Color(0xFFE8F5E9);
const Color _tuDark = Color(0xFF003300);
const Color _tuLight = Color(0xFF43A047);
const Color _tuMuted = Color(0xFFA5D6A7);
const Color _tuAccent = Color(0xFF2E7D32);
const Color _tuDivider = Color(0xFFC8E6C9);
const Color _tuWhite = Color(0xFFFFFFFF);
const Color _tuBlack = Color(0xFF212121);
const Color _tuError = Color(0xFFC62828);
const Color _tuInfo = Color(0xFF01579B);
const Color _tuWarning = Color(0xFFF57F17);
const Color _tuSuccess = Color(0xFF388E3C);

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
              colors: [_tuEmerald, _tuDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _tuEmerald.withValues(alpha: 0.35),
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
                  Icon(Icons.back_hand_outlined,
                      color: _tuSage, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'EditableTextTapUp\nOutsideIntent',
                      style: TextStyle(
                        color: _tuSage,
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
                'An intent dispatched when the user completes a tap '
                '(pointer up) outside an EditableText widget. This fires '
                'after the pointer release, enabling apps to distinguish '
                'between completed taps and drag gestures before deciding '
                'on unfocus or keyboard dismissal behavior.',
                style: TextStyle(
                  color: _tuSage.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _tuSection('1. What Is EditableTextTapUpOutsideIntent?'),
        _tuBody(
          'While EditableTextTapOutsideIntent fires on pointer down '
          '(the moment the finger touches the screen), '
          'EditableTextTapUpOutsideIntent fires on pointer up (when '
          'the finger lifts). This timing difference is crucial for '
          'distinguishing between a quick tap and a drag that started '
          'outside the text field.',
        ),
        const SizedBox(height: 12),
        _tuInfoBox(
          'Why Pointer Up Matters',
          'A pointer down outside a text field could be the start of '
          'a scroll gesture. Only when the pointer lifts without '
          'significant movement can we be certain it was a tap. This '
          'prevents accidental keyboard dismissal during scrolling.',
        ),
        const SizedBox(height: 24),

        // ── 2. Timing Comparison ──
        _tuSection('2. Pointer Down vs Pointer Up Timing'),
        _tuBody(
          'The critical difference between the two tap-outside intents '
          'is when they fire in the gesture lifecycle:',
        ),
        const SizedBox(height: 12),
        _buildTimingComparison(),
        const SizedBox(height: 24),

        // ── 3. Gesture Disambiguation ──
        _tuSection('3. Gesture Disambiguation'),
        _tuBody(
          'The pointer-up timing enables reliable gesture detection:',
        ),
        const SizedBox(height: 12),
        _buildGestureDisambiguation(),
        const SizedBox(height: 24),

        // ── 4. Intent Properties ──
        _tuSection('4. Intent Properties'),
        _tuBody(
          'The intent carries specific data about the completed tap:',
        ),
        const SizedBox(height: 12),
        _buildIntentProperties(),
        const SizedBox(height: 24),

        // ── 5. Use Case: Scroll-Safe Dismiss ──
        _tuSection('5. Use Case — Scroll-Safe Keyboard Dismiss'),
        _tuBody(
          'The most important use case: dismissing the keyboard only '
          'on confirmed taps, not during scroll gestures:',
        ),
        const SizedBox(height: 12),
        _tuCodeBlock(
          '// Scroll-safe keyboard dismissal\n'
          'Actions(\n'
          '  actions: {\n'
          '    // Do nothing on pointer down\n'
          '    EditableTextTapOutsideIntent:\n'
          '      DoNothingAction(),\n'
          '\n'
          '    // Only dismiss on confirmed tap-up\n'
          '    EditableTextTapUpOutsideIntent:\n'
          '      CallbackAction<\n'
          '        EditableTextTapUpOutsideIntent\n'
          '      >(\n'
          '        onInvoke: (intent) {\n'
          '          intent.focusNode.unfocus();\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: scrollableForm,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 6. Gesture Lifecycle Flow ──
        _tuSection('6. Complete Gesture Lifecycle'),
        _tuBody(
          'How a tap-outside gesture flows through the system from '
          'finger down to intent dispatch:',
        ),
        const SizedBox(height: 12),
        _buildGestureLifecycle(),
        const SizedBox(height: 24),

        // ── 7. Drag vs Tap Decision Tree ──
        _tuSection('7. Drag vs Tap Decision Tree'),
        _tuBody(
          'The framework uses pointer movement between down and up to '
          'determine whether the gesture is a tap or drag:',
        ),
        const SizedBox(height: 12),
        _buildDecisionTree(),
        const SizedBox(height: 24),

        // ── 8. Platform Gesture Thresholds ──
        _tuSection('8. Platform Touch Slop Thresholds'),
        _tuBody(
          'Each platform has a different threshold for distinguishing '
          'a tap from a drag (touch slop):',
        ),
        const SizedBox(height: 12),
        _buildPlatformThresholds(),
        const SizedBox(height: 24),

        // ── 9. Form Integration ──
        _tuSection('9. Form Field Integration'),
        _tuBody(
          'In complex forms, the tap-up intent enables sophisticated '
          'focus management:',
        ),
        const SizedBox(height: 12),
        _buildFormIntegration(),
        const SizedBox(height: 24),

        // ── 10. Custom Action Patterns ──
        _tuSection('10. Custom Action Patterns'),
        _tuBody(
          'Advanced patterns for handling the tap-up-outside intent:',
        ),
        const SizedBox(height: 12),
        _buildCustomPatterns(),
        const SizedBox(height: 24),

        // ── 11. Combined Strategy ──
        _tuSection('11. Combined Tap + TapUp Strategy'),
        _tuBody(
          'Using both intents together for maximum control:',
        ),
        const SizedBox(height: 12),
        _tuCodeBlock(
          '// Combined strategy:\n'
          '// 1. On tap down: hide selection handles\n'
          '// 2. On tap up: unfocus + dismiss keyboard\n'
          'Actions(\n'
          '  actions: {\n'
          '    EditableTextTapOutsideIntent:\n'
          '      CallbackAction<\n'
          '        EditableTextTapOutsideIntent\n'
          '      >(\n'
          '        onInvoke: (intent) {\n'
          '          // Immediately hide handles\n'
          '          hideSelectionOverlay();\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '    EditableTextTapUpOutsideIntent:\n'
          '      CallbackAction<\n'
          '        EditableTextTapUpOutsideIntent\n'
          '      >(\n'
          '        onInvoke: (intent) {\n'
          '          // After confirmed tap, unfocus\n'
          '          intent.focusNode.unfocus();\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: editor,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 12. Accessibility Considerations ──
        _tuSection('12. Accessibility Considerations'),
        _tuBody(
          'How the tap-up-outside intent interacts with '
          'accessibility features:',
        ),
        const SizedBox(height: 12),
        _buildAccessibility(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _tuEmerald.withValues(alpha: 0.06),
                _tuSage,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: _tuEmerald.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _tuEmerald, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _tuEmerald,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _tuSummaryRow('Type', 'Intent (pointer up lifecycle)'),
              _tuSummaryRow('Trigger', 'Pointer up outside EditableText'),
              _tuSummaryRow('Key Benefit', 'Distinguishes tap from drag'),
              _tuSummaryRow('Default Action',
                  'Unfocus + dismiss keyboard'),
              _tuSummaryRow('Sibling', 'EditableTextTapOutsideIntent'),
              _tuSummaryRow('Carries', 'FocusNode, PointerUpEvent'),
              _tuSummaryRow('Best For', 'Scroll-safe keyboard dismiss'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _tuSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _tuEmerald,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _tuBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _tuBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _tuCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1B3A1B),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFC8E6C9),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _tuInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _tuInfo, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _tuInfo,
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
            color: _tuBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _tuSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              color: _tuAccent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _tuBlack,
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

Widget _buildTimingComparison() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gesture Timeline',
          style: TextStyle(
            color: _tuEmerald, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Timeline visualization
        Row(
          children: [
            // Finger down marker
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _tuError,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.touch_app,
                      color: _tuWhite, size: 20),
                ),
                const SizedBox(height: 4),
                Text('DOWN',
                    style: TextStyle(color: _tuError, fontSize: 9,
                        fontWeight: FontWeight.bold)),
                Text('TapOutside\nfires here',
                    style: TextStyle(color: _tuError, fontSize: 8),
                    textAlign: TextAlign.center),
              ],
            ),
            // Timeline line
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_tuError, _tuWarning, _tuSuccess],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Gesture duration (hold / move)',
                      style: TextStyle(color: _tuMuted, fontSize: 9)),
                ],
              ),
            ),
            // Finger up marker
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _tuSuccess,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.back_hand,
                      color: _tuWhite, size: 20),
                ),
                const SizedBox(height: 4),
                Text('UP',
                    style: TextStyle(color: _tuSuccess, fontSize: 9,
                        fontWeight: FontWeight.bold)),
                Text('TapUpOutside\nfires here',
                    style: TextStyle(color: _tuSuccess, fontSize: 8),
                    textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGestureDisambiguation() {
  final gestures = <Map<String, dynamic>>[
    {
      'gesture': 'Quick Tap',
      'downFires': true,
      'upFires': true,
      'movement': '< touch slop',
      'icon': Icons.touch_app,
      'color': _tuSuccess,
    },
    {
      'gesture': 'Long Press',
      'downFires': true,
      'upFires': true,
      'movement': '< touch slop (held)',
      'icon': Icons.timer,
      'color': _tuWarning,
    },
    {
      'gesture': 'Scroll / Drag',
      'downFires': true,
      'upFires': false,
      'movement': '> touch slop',
      'icon': Icons.swipe_vertical,
      'color': _tuError,
    },
    {
      'gesture': 'Fling',
      'downFires': true,
      'upFires': false,
      'movement': '>> touch slop + velocity',
      'icon': Icons.swipe,
      'color': _tuInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text('Gesture',
                  style: TextStyle(color: _tuEmerald, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 50,
              child: Text('Down',
                  style: TextStyle(color: _tuError, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 50,
              child: Text('Up',
                  style: TextStyle(color: _tuSuccess, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('Movement',
                  style: TextStyle(color: _tuEmerald, fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const Divider(height: 12),
        for (var i = 0; i < gestures.length; i++) ...[
          Row(
            children: [
              SizedBox(
                width: 80,
                // Cluster H follow-up: inner Row [Icon(14) + SizedBox(4)
                // + Text(gesture, fontSize 10 bold)] overflowed the 80 px
                // slot by 2.8 px right when gesture is 'Scroll / Drag'
                // (12 chars, the longest of the 4 labels). Wrap the Text
                // in Expanded so it can ellipsize when the natural width
                // exceeds the slot. Visual: identical at full width;
                // ellipsis triggers only for the longest label.
                child: Row(
                  children: [
                    Icon(gestures[i]['icon'] as IconData,
                        color: gestures[i]['color'] as Color, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        gestures[i]['gesture'] as String,
                        style: TextStyle(
                          color: gestures[i]['color'] as Color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: Icon(
                  (gestures[i]['downFires'] as bool)
                      ? Icons.check : Icons.close,
                  color: (gestures[i]['downFires'] as bool)
                      ? _tuSuccess : _tuError,
                  size: 14,
                ),
              ),
              SizedBox(
                width: 50,
                child: Icon(
                  (gestures[i]['upFires'] as bool)
                      ? Icons.check : Icons.close,
                  color: (gestures[i]['upFires'] as bool)
                      ? _tuSuccess : _tuError,
                  size: 14,
                ),
              ),
              Expanded(
                child: Text(
                  gestures[i]['movement'] as String,
                  style: TextStyle(color: _tuBlack, fontSize: 10,
                      fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
          if (i < gestures.length - 1) const SizedBox(height: 6),
        ],
      ],
    ),
  );
}

Widget _buildIntentProperties() {
  final props = <Map<String, dynamic>>[
    {
      'prop': 'focusNode',
      'type': 'FocusNode',
      'desc': 'The EditableText focus node that was focused when the '
          'tap up occurred. Used for programmatic unfocus.',
      'color': _tuEmerald,
    },
    {
      'prop': 'pointerUpEvent',
      'type': 'PointerUpEvent',
      'desc': 'The raw pointer up event with position, device info, '
          'and timestamp of the release.',
      'color': _tuAccent,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
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
                  color: _tuBlack.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  props[i]['type'] as String,
                  style: TextStyle(
                    color: _tuMuted,
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
            style: TextStyle(color: _tuBlack, fontSize: 11, height: 1.3),
          ),
          if (i < props.length - 1) const SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildGestureLifecycle() {
  final steps = <Map<String, dynamic>>[
    {
      'step': 'PointerDownEvent received',
      'detail': 'Engine dispatches pointer down to hit test targets',
      'icon': Icons.arrow_downward,
      'color': _tuMuted,
    },
    {
      'step': 'TapRegion evaluates: outside EditableText',
      'detail': 'TapOutsideIntent may fire (pointer down)',
      'icon': Icons.gps_fixed,
      'color': _tuWarning,
    },
    {
      'step': 'Pointer held / moves',
      'detail': 'GestureArena tracks movement distance',
      'icon': Icons.pan_tool,
      'color': _tuLight,
    },
    {
      'step': 'Movement < touch slop?',
      'detail': 'Yes: gesture classified as tap; No: classified as drag',
      'icon': Icons.compare_arrows,
      'color': _tuAccent,
    },
    {
      'step': 'PointerUpEvent received (for tap)',
      'detail': 'Finger lifted without exceeding movement threshold',
      'icon': Icons.arrow_upward,
      'color': _tuEmerald,
    },
    {
      'step': 'TapUpOutsideIntent dispatched',
      'detail': 'Carries focusNode and pointerUpEvent data',
      'icon': Icons.flash_on,
      'color': _tuSuccess,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
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
                    color: _tuWhite, size: 14),
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
                          color: _tuBlack, fontSize: 11, height: 1.3),
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
                  width: 2, height: 8, color: _tuDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildDecisionTree() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Root decision
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _tuEmerald.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _tuEmerald.withValues(alpha: 0.3)),
          ),
          child: Text('Pointer down outside EditableText',
              style: TextStyle(color: _tuEmerald, fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 4),
        // Branch
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 20,
                    width: 2,
                    color: _tuDivider,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _tuSuccess.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: _tuSuccess.withValues(alpha: 0.2)),
                    ),
                    child: Text('Movement < slop?',
                        style: TextStyle(color: _tuSuccess, fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    height: 10,
                    width: 2,
                    color: _tuDivider,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _tuSuccess.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check, color: _tuSuccess, size: 16),
                        Text('TAP confirmed',
                            style: TextStyle(color: _tuSuccess, fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Text('TapUpOutsideIntent fires',
                            style: TextStyle(color: _tuBlack, fontSize: 9)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 20,
                    width: 2,
                    color: _tuDivider,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _tuError.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: _tuError.withValues(alpha: 0.2)),
                    ),
                    child: Text('Movement > slop?',
                        style: TextStyle(color: _tuError, fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    height: 10,
                    width: 2,
                    color: _tuDivider,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _tuError.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.close, color: _tuError, size: 16),
                        Text('DRAG detected',
                            style: TextStyle(color: _tuError, fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Text('TapUpOutsideIntent skipped',
                            style: TextStyle(color: _tuBlack, fontSize: 9)),
                      ],
                    ),
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

Widget _buildPlatformThresholds() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Mobile (touch)',
      'slop': '18.0 logical px',
      'reason': 'Fingers are imprecise; larger slop prevents false drags',
      'icon': Icons.phone_android,
      'color': _tuEmerald,
    },
    {
      'platform': 'Desktop (mouse)',
      'slop': '1.0 logical px',
      'reason': 'Mouse is precise; tiny slop distinguishes click from drag',
      'icon': Icons.desktop_mac,
      'color': _tuAccent,
    },
    {
      'platform': 'Stylus / Pen',
      'slop': '2.0 logical px',
      'reason': 'Stylus is more precise than touch but less than mouse',
      'icon': Icons.edit,
      'color': _tuLight,
    },
    {
      'platform': 'Trackpad',
      'slop': '8.0 logical px',
      'reason': 'Trackpad precision is between touch and mouse',
      'icon': Icons.laptop,
      'color': _tuInfo,
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
                  Expanded(
                    child: Text(
                      p['platform'] as String,
                      style: TextStyle(
                        color: p['color'] as Color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  p['slop'] as String,
                  style: TextStyle(
                    color: p['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                p['reason'] as String,
                style: TextStyle(color: _tuBlack, fontSize: 9, height: 1.3),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildFormIntegration() {
  final scenarios = <Map<String, dynamic>>[
    {
      'scenario': 'Save on Tap Outside',
      'desc': 'Auto-save field content when user taps away from a text field',
      'icon': Icons.save,
      'color': _tuEmerald,
    },
    {
      'scenario': 'Validate on Unfocus',
      'desc': 'Run field validation when the tap-up confirms intentional exit',
      'icon': Icons.check_circle,
      'color': _tuSuccess,
    },
    {
      'scenario': 'Confirm Discard',
      'desc': 'Show discard dialog if field has unsaved changes on tap-up',
      'icon': Icons.warning_amber,
      'color': _tuWarning,
    },
    {
      'scenario': 'Smart Focus Transfer',
      'desc': 'Move focus to the tapped widget instead of just unfocusing',
      'icon': Icons.swap_horiz,
      'color': _tuAccent,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < scenarios.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (scenarios[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (scenarios[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(scenarios[i]['icon'] as IconData,
                  color: scenarios[i]['color'] as Color, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenarios[i]['scenario'] as String,
                      style: TextStyle(
                        color: scenarios[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      scenarios[i]['desc'] as String,
                      style: TextStyle(
                          color: _tuBlack, fontSize: 11, height: 1.3),
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

Widget _buildCustomPatterns() {
  final patterns = <Map<String, dynamic>>[
    {
      'pattern': 'Coordinate Check',
      'desc': 'Use pointerUpEvent position to determine context-aware '
          'behavior based on where the tap landed.',
      'code': 'final pos = intent.pointerUpEvent.position;',
      'color': _tuEmerald,
    },
    {
      'pattern': 'Debounced Unfocus',
      'desc': 'Add a small delay before unfocusing to allow toolbar '
          'buttons to process their taps first.',
      'code': 'Timer(ms100, () => node.unfocus());',
      'color': _tuAccent,
    },
    {
      'pattern': 'Conditional by Field',
      'desc': 'Different behavior depending on which text field was '
          'focused (e.g. search vs compose).',
      'code': 'if (node.debugLabel == "search") ...',
      'color': _tuLight,
    },
    {
      'pattern': 'Analytics Hook',
      'desc': 'Track when users tap outside fields for UX analytics '
          'without changing any behavior.',
      'code': 'analytics.track("unfocus_tap_up");',
      'color': _tuInfo,
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
              const SizedBox(height: 2),
              Text(
                patterns[i]['desc'] as String,
                style: TextStyle(
                    color: _tuBlack, fontSize: 11, height: 1.3),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _tuBlack.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  patterns[i]['code'] as String,
                  style: TextStyle(
                    color: _tuMuted,
                    fontSize: 10,
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

Widget _buildAccessibility() {
  final items = <Map<String, dynamic>>[
    {
      'feature': 'Screen Reader',
      'behavior': 'Announce "text field unfocused" when tap-up triggers '
          'unfocus. Custom actions should maintain this announcement.',
      'icon': Icons.hearing,
      'color': _tuEmerald,
    },
    {
      'feature': 'Switch Control',
      'behavior': 'Switch control taps are always confirmed taps (no drag '
          'possible). TapUpOutside fires reliably.',
      'icon': Icons.toggle_on,
      'color': _tuAccent,
    },
    {
      'feature': 'Voice Control',
      'behavior': 'Voice-triggered taps generate synthetic pointer events. '
          'The tap-up intent fires normally.',
      'icon': Icons.mic,
      'color': _tuLight,
    },
    {
      'feature': 'Large Text / Zoom',
      'behavior': 'Zoomed interfaces may shift tap positions. Use logical '
          'coordinates from pointerUpEvent, not physical pixels.',
      'icon': Icons.zoom_in,
      'color': _tuInfo,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _tuSage,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _tuDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: items[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(items[i]['icon'] as IconData,
                    color: _tuWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[i]['feature'] as String,
                      style: TextStyle(
                        color: items[i]['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      items[i]['behavior'] as String,
                      style: TextStyle(
                          color: _tuBlack, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < items.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}
