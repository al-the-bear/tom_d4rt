// ignore_for_file: avoid_print
// Deep demo: DismissIntent — an intent representing the user's desire to
// dismiss the current modal, dialog, popup, or route, typically triggered by
// pressing the Escape key or an equivalent platform gesture.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Deep Rose (#880E4F) on Blush Pink (#FCE4EC)
// Prefix: _di (dismiss)
// ────────────────────────────────────────────────────────────

const Color _diRose = Color(0xFF880E4F);
const Color _diBlush = Color(0xFFFCE4EC);
const Color _diDark = Color(0xFF560027);
const Color _diLight = Color(0xFFC2185B);
const Color _diMuted = Color(0xFF9E9E9E);
const Color _diAccent = Color(0xFFD81B60);
const Color _diDivider = Color(0xFFF48FB1);
const Color _diWhite = Color(0xFFFFFFFF);
const Color _diBlack = Color(0xFF212121);
const Color _diError = Color(0xFFC62828);
const Color _diInfo = Color(0xFF0277BD);
const Color _diWarning = Color(0xFFF57F17);

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
              colors: [_diRose, _diDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _diRose.withValues(alpha: 0.35),
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
                  Icon(Icons.close_rounded, color: _diBlush, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DismissIntent',
                      style: TextStyle(
                        color: _diBlush,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An intent that signals the desire to dismiss the currently '
                'focused overlay, dialog, modal bottom sheet, dropdown menu, '
                'or navigable route — the standard "close this thing" action.',
                style: TextStyle(
                  color: _diBlush.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _diSection('1. What Is DismissIntent?'),
        _diBody(
          'DismissIntent is a simple Intent subclass with no additional '
          'properties — it is the pure signal for "dismiss the current '
          'thing." It is typically bound to the Escape key via the '
          'Shortcuts widget. When invoked, the DismissAction handler '
          'determines what to dismiss based on the current widget '
          'context: it may close a dialog, pop a route, collapse a '
          'dropdown, or hide a tooltip.',
        ),
        const SizedBox(height: 12),
        _diInfoBox(
          'Escape Key Convention',
          'On desktop and web platforms, pressing Escape is the standard '
          'way to dismiss overlays. DismissIntent abstracts this into '
          'a platform-agnostic intent that works across all input methods.',
        ),
        const SizedBox(height: 24),

        // ── 2. Intent Hierarchy ──
        _diSection('2. Intent Class Structure'),
        _diBody(
          'DismissIntent is intentionally minimal — a marker class '
          'with no configuration. The Action determines behavior:',
        ),
        const SizedBox(height: 12),
        _diCodeBlock(
          '// DismissIntent source\n'
          'class DismissIntent extends Intent {\n'
          '  const DismissIntent();\n'
          '}\n'
          '\n'
          '// It has no properties — the action\n'
          '// decides what to dismiss based on context.\n'
          '\n'
          '// Default binding in WidgetsApp\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    const SingleActivator(\n'
          '      LogicalKeyboardKey.escape,\n'
          '    ): const DismissIntent(),\n'
          '  },\n'
          '  child: ...,\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 3. Dismissable Targets ──
        _diSection('3. What Can Be Dismissed'),
        _diBody(
          'DismissIntent can close many different overlay types, '
          'depending on what is currently on top of the widget tree:',
        ),
        const SizedBox(height: 12),
        _buildDismissableTargets(),
        const SizedBox(height: 24),

        // ── 4. Dismiss vs Pop ──
        _diSection('4. DismissIntent vs Navigator.pop'),
        _diBody(
          'While both can close routes, they serve different purposes '
          'and are handled differently by the framework:',
        ),
        const SizedBox(height: 12),
        _buildDismissVsPop(),
        const SizedBox(height: 24),

        // ── 5. DismissAction Handler ──
        _diSection('5. DismissAction Handler'),
        _diBody(
          'DismissAction is the default action that processes '
          'DismissIntent. Its invoke method walks the context to '
          'find the nearest dismissable overlay:',
        ),
        const SizedBox(height: 12),
        _buildDismissActionFlow(),
        const SizedBox(height: 12),
        _diCodeBlock(
          '// Custom DismissAction implementation\n'
          'class MyDismissAction\n'
          '    extends Action<DismissIntent> {\n'
          '  MyDismissAction(this.onDismiss);\n'
          '  final VoidCallback onDismiss;\n'
          '\n'
          '  @override\n'
          '  Object? invoke(DismissIntent intent) {\n'
          '    onDismiss();\n'
          '    return null;\n'
          '  }\n'
          '}\n'
          '\n'
          '// Register custom dismiss behavior\n'
          'Actions(\n'
          '  actions: <Type, Action<Intent>>{\n'
          '    DismissIntent: MyDismissAction(() {\n'
          '      // Custom dismiss logic\n'
          '      state.closePanel();\n'
          '    }),\n'
          '  },\n'
          '  child: MyPanel(),\n'
          ')',
        ),
        const SizedBox(height: 24),

        // ── 6. Barrier Dismiss ──
        _diSection('6. Barrier Dismiss Interaction'),
        _diBody(
          'When a dialog has barrierDismissible set to true, tapping '
          'the barrier AND pressing Escape both trigger dismissal. '
          'DismissIntent handles the keyboard path:',
        ),
        const SizedBox(height: 12),
        _buildBarrierDismiss(),
        const SizedBox(height: 24),

        // ── 7. Nested Dismiss Scopes ──
        _diSection('7. Nested Dismiss Scopes'),
        _diBody(
          'When multiple dismissable overlays are stacked, the '
          'innermost one receives the DismissIntent first. Only '
          'after it is dismissed does the next layer become reachable:',
        ),
        const SizedBox(height: 12),
        _buildNestedDismissScopes(),
        const SizedBox(height: 24),

        // ── 8. Dismissible Widget vs DismissIntent ──
        _diSection('8. Dismissible Widget vs DismissIntent'),
        _diBody(
          'Despite similar names, Dismissible (the swipe-to-dismiss '
          'widget) and DismissIntent serve very different purposes:',
        ),
        const SizedBox(height: 12),
        _buildDismissibleComparison(),
        const SizedBox(height: 24),

        // ── 9. Platform Differences ──
        _diSection('9. Platform-Specific Behavior'),
        _diBody(
          'Different platforms map the dismiss action to different '
          'gestures:',
        ),
        const SizedBox(height: 12),
        _buildPlatformDismiss(),
        const SizedBox(height: 24),

        // ── 10. Accessibility ──
        _diSection('10. Accessibility & Screen Readers'),
        _diBody(
          'DismissIntent supports accessibility by providing a '
          'consistent keyboard path to close overlays:',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityDismiss(),
        const SizedBox(height: 24),

        // ── 11. Confirm Before Dismiss ──
        _diSection('11. Confirm Before Dismiss Pattern'),
        _diBody(
          'For unsaved changes or destructive operations, you can '
          'intercept DismissIntent to show a confirmation dialog:',
        ),
        const SizedBox(height: 12),
        _buildConfirmDismiss(),
        const SizedBox(height: 24),

        // ── 12. Modal Stack Scenario ──
        _diSection('12. Modal Stack Navigation Scenario'),
        _diBody(
          'A multi-level modal flow where each Escape press '
          'dismisses one layer:',
        ),
        const SizedBox(height: 12),
        _buildModalStackScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _diRose.withValues(alpha: 0.08),
                _diBlush,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _diRose.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _diRose, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _diRose,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _diSummaryRow('Type', 'Intent (no properties)'),
              _diSummaryRow('Trigger', 'Escape key (default binding)'),
              _diSummaryRow('Targets', 'Dialogs, modals, menus, tooltips, routes'),
              _diSummaryRow('Handler', 'DismissAction (customizable)'),
              _diSummaryRow('Nesting', 'Innermost overlay dismissed first'),
              _diSummaryRow('Not Same As', 'Dismissible widget (swipe-to-remove)'),
              _diSummaryRow('Accessibility', 'Consistent keyboard dismiss path'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _diSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _diRose,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _diBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _diBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _diCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF3E2723),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFF8BBD0),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _diInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _diInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: _diInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _diInfo,
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
            color: _diBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _diSummaryRow(String label, String value) {
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
              color: _diMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _diBlack,
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

Widget _buildDismissableTargets() {
  final targets = <Map<String, dynamic>>[
    {
      'target': 'Dialog',
      'trigger': 'Escape closes showDialog()',
      'icon': Icons.picture_in_picture,
      'color': _diRose,
    },
    {
      'target': 'Modal Bottom Sheet',
      'trigger': 'Escape closes showModalBottomSheet()',
      'icon': Icons.vertical_align_bottom,
      'color': _diAccent,
    },
    {
      'target': 'Dropdown Menu',
      'trigger': 'Escape collapses DropdownButton',
      'icon': Icons.arrow_drop_down_circle,
      'color': _diLight,
    },
    {
      'target': 'Popup Menu',
      'trigger': 'Escape closes showMenu()',
      'icon': Icons.menu_open,
      'color': _diInfo,
    },
    {
      'target': 'Tooltip',
      'trigger': 'Escape hides visible tooltip',
      'icon': Icons.chat_bubble_outline,
      'color': _diMuted,
    },
    {
      'target': 'Modal Route',
      'trigger': 'Escape pops the topmost modal route',
      'icon': Icons.layers_clear,
      'color': _diWarning,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var t in targets)
        Container(
          width: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (t['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (t['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(t['icon'] as IconData,
                      color: t['color'] as Color, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      t['target'] as String,
                      style: TextStyle(
                        color: t['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                t['trigger'] as String,
                style: TextStyle(
                  color: _diBlack, fontSize: 11, height: 1.3),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildDismissVsPop() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _diRose.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _diRose.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.close, color: _diRose, size: 18),
                  const SizedBox(width: 6),
                  Text('DismissIntent',
                      style: TextStyle(color: _diRose, fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Keyboard-triggered (Escape)',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Respects barrier dismissibility',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Context-aware (overlay vs route)',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Can be overridden per-widget',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Part of the Actions framework',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _diInfo.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _diInfo.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back, color: _diInfo, size: 18),
                  const SizedBox(width: 6),
                  Text('Navigator.pop()',
                      style: TextStyle(color: _diInfo, fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Programmatic (code-triggered)',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Always pops the top route',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Does not check dismissibility',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Can return a result value',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
              Text('\u2022 Part of the Navigator API',
                  style: TextStyle(color: _diBlack, fontSize: 12)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildDismissActionFlow() {
  final steps = <Map<String, dynamic>>[
    {
      'label': 'Escape Pressed',
      'desc': 'Key event triggers DismissIntent through Shortcuts',
      'icon': Icons.keyboard,
      'color': _diMuted,
    },
    {
      'label': 'Find DismissAction',
      'desc': 'Actions framework looks up nearest registered handler',
      'icon': Icons.search,
      'color': _diRose,
    },
    {
      'label': 'Check isEnabled',
      'desc': 'Action verifies something dismissable is in scope',
      'icon': Icons.verified,
      'color': _diAccent,
    },
    {
      'label': 'Identify Target',
      'desc': 'Closest: tooltip > menu > dropdown > dialog > modal > route',
      'icon': Icons.layers,
      'color': _diLight,
    },
    {
      'label': 'Execute Dismiss',
      'desc': 'Close the identified target and clean up overlay entries',
      'icon': Icons.close_rounded,
      'color': _diError,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diBlush,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _diDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _diWhite, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['label'] as String,
                      style: TextStyle(
                        color: steps[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['desc'] as String,
                      style: TextStyle(color: _diBlack, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
              child: Container(width: 2, height: 12, color: _diDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildBarrierDismiss() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diBlush,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _diDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Two Dismiss Paths for Dialogs',
          style: TextStyle(
            color: _diRose, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // Touch path
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _diWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _diDivider),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: _diAccent, size: 28),
                    const SizedBox(height: 6),
                    Text('Tap Barrier',
                        style: TextStyle(color: _diAccent, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      'User taps the semi-transparent backdrop '
                      'behind the dialog',
                      style: TextStyle(color: _diBlack, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Keyboard path
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _diWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _diDivider),
                ),
                child: Column(
                  children: [
                    Icon(Icons.keyboard, color: _diRose, size: 28),
                    const SizedBox(height: 6),
                    Text('Press Escape',
                        style: TextStyle(color: _diRose, fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      'DismissIntent fires and DismissAction '
                      'pops the dialog route',
                      style: TextStyle(color: _diBlack, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _diWarning.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _diWarning.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: _diWarning, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'If barrierDismissible: false, Escape is still active '
                  'by default! Override DismissAction to block it.',
                  style: TextStyle(color: _diBlack, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildNestedDismissScopes() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diBlush,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _diDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layered Overlay Dismissal Order',
          style: TextStyle(
            color: _diRose, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Layer stack
        for (var i = 0; i < 4; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: EdgeInsets.only(left: i * 16.0),
            decoration: BoxDecoration(
              color: [
                _diRose.withValues(alpha: 0.08),
                _diAccent.withValues(alpha: 0.08),
                _diLight.withValues(alpha: 0.08),
                _diInfo.withValues(alpha: 0.08),
              ][i],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: [_diRose, _diAccent, _diLight, _diInfo][i]
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Esc ${4 - i}',
                  style: TextStyle(
                    color: [_diRose, _diAccent, _diLight, _diInfo][i],
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ['Page Route', 'Dialog', 'Dropdown Menu', 'Tooltip'][i],
                    style: TextStyle(
                      color: _diBlack,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  i == 3 ? Icons.arrow_upward : Icons.remove,
                  color: _diMuted,
                  size: 16,
                ),
              ],
            ),
          ),
          if (i < 3) const SizedBox(height: 4),
        ],
        const SizedBox(height: 10),
        Text(
          'First Escape closes tooltip, second closes dropdown, '
          'third closes dialog, fourth pops route.',
          style: TextStyle(
            color: _diMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildDismissibleComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _diRose.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _diRose.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard, color: _diRose, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('DismissIntent',
                        style: TextStyle(color: _diRose, fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Keyboard-driven (Escape)',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Closes overlays and routes',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Part of Shortcuts/Actions',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 No animation direction',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Context-sensitive target',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _diWarning.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _diWarning.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.swipe, color: _diWarning, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Dismissible',
                        style: TextStyle(color: _diWarning, fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('\u2022 Gesture-driven (swipe)',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Removes list items',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Standalone widget',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Directional animation',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
              Text('\u2022 Fixed target (its child)',
                  style: TextStyle(color: _diBlack, fontSize: 11)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildPlatformDismiss() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Desktop (all)',
      'gesture': 'Escape key \u2192 DismissIntent',
      'icon': Icons.desktop_mac,
      'color': _diRose,
    },
    {
      'platform': 'Android',
      'gesture': 'Back button / gesture \u2192 PopScope',
      'icon': Icons.phone_android,
      'color': _diAccent,
    },
    {
      'platform': 'iOS',
      'gesture': 'Swipe from left edge \u2192 route pop',
      'icon': Icons.phone_iphone,
      'color': _diLight,
    },
    {
      'platform': 'Web',
      'gesture': 'Escape key + browser back button',
      'icon': Icons.public,
      'color': _diInfo,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < platforms.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (platforms[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (platforms[i]['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(platforms[i]['icon'] as IconData,
                  color: platforms[i]['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      platforms[i]['platform'] as String,
                      style: TextStyle(
                        color: platforms[i]['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      platforms[i]['gesture'] as String,
                      style: TextStyle(
                        color: _diBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < platforms.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildAccessibilityDismiss() {
  final features = <Map<String, dynamic>>[
    {
      'feature': 'Keyboard Users',
      'desc': 'Escape provides consistent close mechanism without mouse',
      'icon': Icons.keyboard,
    },
    {
      'feature': 'Screen Readers',
      'desc': 'Announce "dialog dismissed" when DismissAction completes',
      'icon': Icons.record_voice_over,
    },
    {
      'feature': 'Switch Access',
      'desc': 'Dismiss mapped to switch device escape action',
      'icon': Icons.accessibility,
    },
    {
      'feature': 'Focus Management',
      'desc': 'After dismiss, focus returns to the element that triggered the overlay',
      'icon': Icons.center_focus_strong,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < features.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _diBlush,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _diDivider),
          ),
          child: Row(
            children: [
              Icon(features[i]['icon'] as IconData,
                  color: _diRose, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      features[i]['feature'] as String,
                      style: TextStyle(
                        color: _diDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      features[i]['desc'] as String,
                      style: TextStyle(
                        color: _diBlack, fontSize: 12, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (i < features.length - 1) const SizedBox(height: 6),
      ],
    ],
  );
}

Widget _buildConfirmDismiss() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diBlush,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _diDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: _diWarning, size: 20),
            const SizedBox(width: 8),
            Text(
              'Intercept Escape for Unsaved Changes',
              style: TextStyle(
                color: _diWarning, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _diCodeBlock(
          '// Wrap content in custom Actions\n'
          'Actions(\n'
          '  actions: <Type, Action<Intent>>{\n'
          '    DismissIntent: CallbackAction<\n'
          '      DismissIntent\n'
          '    >(\n'
          '      onInvoke: (intent) {\n'
          '        if (hasUnsavedChanges) {\n'
          '          // Show confirmation instead\n'
          '          showDialog(\n'
          '            context: context,\n'
          '            builder: (_) => AlertDialog(\n'
          '              title: Text("Unsaved changes"),\n'
          '              content: Text(\n'
          '                "Discard changes?",\n'
          '              ),\n'
          '              actions: [\n'
          '                TextButton(\n'
          '                  onPressed: () {\n'
          '                    Navigator.of(context)\n'
          '                        .pop(); // close confirm\n'
          '                  },\n'
          '                  child: Text("Cancel"),\n'
          '                ),\n'
          '                TextButton(\n'
          '                  onPressed: () {\n'
          '                    Navigator.of(context)\n'
          '                        .pop(); // close confirm\n'
          '                    Navigator.of(context)\n'
          '                        .pop(); // close editor\n'
          '                  },\n'
          '                  child: Text("Discard"),\n'
          '                ),\n'
          '              ],\n'
          '            ),\n'
          '          );\n'
          '        } else {\n'
          '          Navigator.of(context).pop();\n'
          '        }\n'
          '        return null;\n'
          '      },\n'
          '    ),\n'
          '  },\n'
          '  child: EditorContent(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildModalStackScenario() {
  final layers = <Map<String, String>>[
    {
      'layer': 'Settings Page (Route)',
      'action': 'Escape pops route back to home',
    },
    {
      'layer': 'Theme Picker (Dialog)',
      'action': 'Escape closes dialog, stays on settings',
    },
    {
      'layer': 'Color Dropdown (Popup)',
      'action': 'Escape collapses dropdown, dialog stays open',
    },
    {
      'layer': 'Color Tooltip (Overlay)',
      'action': 'Escape hides tooltip, dropdown stays open',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _diBlush,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _diDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.stacked_bar_chart, color: _diRose, size: 20),
            const SizedBox(width: 8),
            Text(
              'Theme Settings with Layered Overlays',
              style: TextStyle(
                color: _diRose,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = layers.length - 1; i >= 0; i--) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: EdgeInsets.only(left: (layers.length - 1 - i) * 14.0),
            decoration: BoxDecoration(
              color: _diRose.withValues(
                  alpha: 0.04 + (i * 0.03)),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _diRose.withValues(alpha: 0.15 + (i * 0.06)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _diRose.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Layer ${i + 1}',
                        style: TextStyle(
                          color: _diRose,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        layers[i]['layer']!,
                        style: TextStyle(
                          color: _diDark,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  layers[i]['action']!,
                  style: TextStyle(
                    color: _diBlack, fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
          if (i > 0) const SizedBox(height: 4),
        ],
        const SizedBox(height: 12),
        Text(
          'Each Escape press peels off one layer from the top. '
          'After 4 presses, the user is back at the home screen.',
          style: TextStyle(
            color: _diMuted, fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
