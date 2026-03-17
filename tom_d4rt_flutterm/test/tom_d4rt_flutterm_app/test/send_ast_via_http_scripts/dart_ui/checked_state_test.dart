// D4rt test script: Tests CheckedState from dart_ui
// CheckedState defines states for checkbox-like accessibility semantics
// Part of the accessibility/semantics system
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                   CheckedState - Deep Demo                         ║');
  print('║       Tri-State Checkbox Semantics for Accessibility               ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CheckedState Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: CheckedState Fundamentals                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CheckedState is an enum for checkbox accessibility semantics.');
  print('');
  print('Purpose:');
  print('  - Describe checkbox states to screen readers');
  print('  - Part of Flutter\'s semantics/accessibility system');
  print('  - Used in SemanticsProperties and SemanticsNode');
  print('');
  print('Context:');
  print('  - Checkboxes can have three states: checked, unchecked, mixed');
  print('  - Mixed state used when a parent checkbox has partially checked children');
  print('  - Screen readers announce these states to visually impaired users');
  print('');
  print('Package: dart:ui');
  print('Related: SemanticsProperties, SemanticsNode, Checkbox');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All CheckedState Values
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: All CheckedState Values                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CheckedState enum values:');
  for (final state in ui.CheckedState.values) {
    print('  [${state.index}] ${state.name}: $state');
  }
  print('');
  print('Total values: ${ui.CheckedState.values.length}');
  print('');
  final first = ui.CheckedState.values.first;
  final last = ui.CheckedState.values.last;
  print('First value: $first (index: ${first.index})');
  print('Last value: $last (index: ${last.index})');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CheckedState.unchecked
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: CheckedState.unchecked                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const unchecked = ui.CheckedState.unchecked;
  print('CheckedState.unchecked:');
  print('  - Name: ${unchecked.name}');
  print('  - Index: ${unchecked.index}');
  print('');
  print('Visual representation:');
  print('  ┌───┐');
  print('  │   │  Empty checkbox');
  print('  └───┘');
  print('');
  print('Screen reader announcement:');
  print('  "checkbox, not checked"');
  print('  "unchecked"');
  print('');
  print('Use cases:');
  print('  - Boolean false state');
  print('  - Option not selected');
  print('  - Permission not granted');
  print('');
  print('Mapping from widget:');
  print('  Checkbox(value: false) → CheckedState.unchecked');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CheckedState.checked
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: CheckedState.checked                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const checked = ui.CheckedState.checked;
  print('CheckedState.checked:');
  print('  - Name: ${checked.name}');
  print('  - Index: ${checked.index}');
  print('');
  print('Visual representation:');
  print('  ┌───┐');
  print('  │ ✓ │  Checkmark visible');
  print('  └───┘');
  print('');
  print('Screen reader announcement:');
  print('  "checkbox, checked"');
  print('  "selected"');
  print('');
  print('Use cases:');
  print('  - Boolean true state');
  print('  - Option selected');
  print('  - Task completed');
  print('  - Permission granted');
  print('');
  print('Mapping from widget:');
  print('  Checkbox(value: true) → CheckedState.checked');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CheckedState.mixed
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: CheckedState.mixed                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const mixed = ui.CheckedState.mixed;
  print('CheckedState.mixed:');
  print('  - Name: ${mixed.name}');
  print('  - Index: ${mixed.index}');
  print('');
  print('Visual representation:');
  print('  ┌───┐');
  print('  │ ─ │  Dash/indeterminate mark');
  print('  └───┘');
  print('');
  print('Screen reader announcement:');
  print('  "checkbox, partially checked"');
  print('  "mixed"');
  print('  "indeterminate"');
  print('');
  print('Use cases:');
  print('  - Parent checkbox with some children checked');
  print('  - Tri-state checkbox');
  print('  - Select all header with partial selection');
  print('');
  print('Example scenario:');
  print('  ┌───┐ Select all');
  print('  │ ─ │ ← Mixed (some items selected)');
  print('  └───┘');
  print('    ┌───┐');
  print('    │ ✓ │ Item 1 (checked)');
  print('    └───┘');
  print('    ┌───┐');
  print('    │   │ Item 2 (unchecked)');
  print('    └───┘');
  print('    ┌───┐');
  print('    │ ✓ │ Item 3 (checked)');
  print('    └───┘');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Tristate Checkbox Widget
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Tristate Checkbox Widget                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Flutter Checkbox supports tristate mode:');
  print('');
  print('  Checkbox(');
  print('    tristate: true,  // Enable mixed state');
  print('    value: null,     // null = mixed state');
  print('    onChanged: (bool? value) {');
  print('      // value cycles: true → false → null → true');
  print('    },');
  print('  )');
  print('');
  print('Value to CheckedState mapping:');
  print('  value = true  → CheckedState.checked');
  print('  value = false → CheckedState.unchecked');
  print('  value = null  → CheckedState.mixed');
  print('');
  print('Note: tristate: false (default) disables mixed state');
  print('  value can only be true or false');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Semantics Integration
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Semantics Integration                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using CheckedState with Semantics widget:');
  print('');
  print('  Semantics(');
  print('    checked: true,  // Sets to CheckedState.checked automatically');
  print('    child: MyCustomCheckbox(),');
  print('  )');
  print('');
  print('Or with SemanticsProperties:');
  print('');
  print('  SemanticsProperties(');
  print('    checked: value,  // bool? - null for mixed');
  print('    onTap: handleTap,');
  print('  )');
  print('');
  print('In SemanticsNode (low-level):');
  print('');
  print('  // Access via semantics debugging');
  print('  final checkedState = node.hasFlag(SemanticsFlag.isChecked)');
  print('    ? CheckedState.checked');
  print('    : node.hasFlag(SemanticsFlag.hasCheckedState)');
  print('      ? CheckedState.unchecked');
  print('      : null; // Not a checkbox');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Accessibility Best Practices
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Accessibility Best Practices                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Best practices for accessible checkboxes:');
  print('');
  print('1. Always provide semantic state:');
  print('   - Use semantic Checkbox widget, or');
  print('   - Wrap custom checkboxes with Semantics');
  print('');
  print('2. Label checkboxes properly:');
  print('   Semantics(');
  print('     checked: value,');
  print('     label: "Enable notifications",');
  print('     child: myCheckbox,');
  print('   )');
  print('');
  print('3. Handle mixed state correctly:');
  print('   - Explain what mixed means in context');
  print('   - Provide clear interaction affordance');
  print('');
  print('4. Support keyboard navigation:');
  print('   - Focus should be visible');
  print('   - Space key should toggle');
  print('');
  print('5. Test with screen readers:');
  print('   - TalkBack (Android)');
  print('   - VoiceOver (iOS)');
  print('   - Narrator (Windows)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Custom Checkbox Implementation
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Custom Checkbox Implementation                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('When building custom checkbox-like widgets:');
  print('');
  print('class CustomTriStateCheckbox extends StatelessWidget {');
  print('  final bool? value; // null = mixed');
  print('  final ValueChanged<bool?>? onChanged;');
  print('');
  print('  @override');
  print('  Widget build(BuildContext context) {');
  print('    return Semantics(');
  print('      checked: value,  // null maps to mixed');
  print('      enabled: onChanged != null,');
  print('      onTap: onChanged != null ? _handleTap : null,');
  print('      child: Container(');
  print('        decoration: BoxDecoration(');
  print('          border: Border.all(...)');
  print('        ),');
  print('        child: _getIcon(),');
  print('      ),');
  print('    );');
  print('  }');
  print('');
  print('  Widget _getIcon() {');
  print('    if (value == true) return Icon(Icons.check);');
  print('    if (value == null) return Icon(Icons.remove);');
  print('    return SizedBox.shrink();');
  print('  }');
  print('}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Platform-Specific Behavior
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Platform-Specific Behavior                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Screen reader announcements by platform:');
  print('');
  print('Android (TalkBack):');
  print('  checked:   "checked checkbox"');
  print('  unchecked: "not checked checkbox"');
  print('  mixed:     "partially checked checkbox"');
  print('');
  print('iOS (VoiceOver):');
  print('  checked:   "checkbox, checked"');
  print('  unchecked: "checkbox, unchecked"');
  print('  mixed:     "checkbox, mixed"');
  print('');
  print('Windows (Narrator):');
  print('  checked:   "checkbox checked"');
  print('  unchecked: "checkbox unchecked"');
  print('  mixed:     "checkbox indeterminate"');
  print('');
  print('macOS (VoiceOver):');
  print('  Similar to iOS VoiceOver');
  print('');
  print('Web (screen readers):');
  print('  Depends on ARIA role="checkbox"');
  print('  aria-checked="true" / "false" / "mixed"');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: CheckedState vs SemanticsFlag
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: CheckedState vs SemanticsFlag                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CheckedState complements SemanticsFlag:');
  print('');
  print('SemanticsFlag approach (bitwise):');
  print('  hasCheckedState: Widget is checkbox-like');
  print('  isChecked: Currently checked (true/false)');
  print('  Cannot directly represent mixed state');
  print('');
  print('CheckedState approach (enum):');
  print('  Clear tri-state representation');
  print('  Type-safe checked, unchecked, mixed');
  print('');
  print('Internal mapping:');
  print('  CheckedState.checked   ↔ hasCheckedState + isChecked');
  print('  CheckedState.unchecked ↔ hasCheckedState + !isChecked');
  print('  CheckedState.mixed     ↔ hasCheckedState + special handling');
  print('');
  print('Prefer CheckedState when:');
  print('  - Working with high-level semantics APIs');
  print('  - Building custom accessible widgets');
  print('  - Need clear tri-state logic');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Testing Checkbox Semantics
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Testing Checkbox Semantics                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Testing checkbox accessibility:');
  print('');
  print('  testWidgets("checkbox announces state", (tester) async {');
  print('    await tester.pumpWidget(');
  print('      MaterialApp(');
  print('        home: Checkbox(value: true, onChanged: (_) {}),');
  print('      ),');
  print('    );');
  print('');
  print('    final semantics = tester.getSemantics(');
  print('      find.byType(Checkbox),');
  print('    );');
  print('');
  print('    // Verify checked state');
  print('    expect(');
  print('      semantics.hasFlag(SemanticsFlag.hasCheckedState),');
  print('      isTrue,');
  print('    );');
  print('    expect(');
  print('      semantics.hasFlag(SemanticsFlag.isChecked),');
  print('      isTrue,');
  print('    );');
  print('  });');
  print('');
  print('Using semantic test matchers:');
  print('  expect(semantics, containsSemantics(checked: true));');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: State Transitions
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: State Transitions                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Standard checkbox (binary):');
  print('  unchecked → checked → unchecked → ...');
  print('');
  print('Tristate checkbox:');
  print('  unchecked → checked → mixed → unchecked → ...');
  print('  (order may vary by implementation)');
  print('');
  print('Flutter Checkbox tristate order:');
  print('  true (checked) → false (unchecked) → null (mixed) → true');
  print('');
  print('Implementing custom order:');
  print('  void _handleTap() {');
  print('    setState(() {');
  print('      switch (currentState) {');
  print('        case CheckedState.unchecked:');
  print('          _state = CheckedState.checked;');
  print('        case CheckedState.checked:');
  print('          _state = CheckedState.mixed;');
  print('        case CheckedState.mixed:');
  print('          _state = CheckedState.unchecked;');
  print('      }');
  print('    });');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Related Enums
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Related Enums                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CheckedState is part of a family of semantics enums:');
  print('');
  print('CheckedState:');
  print('  - For checkbox-like widgets');
  print('  - checked, unchecked, mixed');
  print('');
  print('SemanticsFlag:');
  print('  - Low-level bitwise flags');
  print('  - isChecked, hasCheckedState, etc.');
  print('');
  print('SemanticsAction:');
  print('  - User actions (tap, scroll, etc.)');
  print('');
  print('These work together in the semantics tree to provide');
  print('complete accessibility information to platform APIs.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('CheckedState summary:');
  print('');
  print('┌───────────────┬────────────────────────────────────────────────────┐');
  print('│ Value         │ Description                                        │');
  print('├───────────────┼────────────────────────────────────────────────────┤');
  print('│ unchecked     │ Checkbox is not checked (false)                    │');
  print('│ checked       │ Checkbox is checked (true)                         │');
  print('│ mixed         │ Checkbox is indeterminate/partially checked (null) │');
  print('└───────────────┴────────────────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Part of Flutter\'s accessibility system');
  print('  2. Maps to Checkbox tristate: true/false/null');
  print('  3. Used by Semantics widget and SemanticsProperties');
  print('  4. Platform-specific screen reader announcements');
  print('  5. Test with accessibility tools');
  print('');
  print('Common use cases:');
  print('  - Standard checkbox widgets');
  print('  - "Select all" with partial selection');
  print('  - Custom checkbox implementations');
  print('  - Accessibility testing');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('CheckedState deep demo completed');

  // Return visual UI demonstrating all states
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green.shade50, Colors.teal.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.check_box, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CheckedState',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Tri-State Checkbox Semantics',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // States display
        Text(
          'All CheckedState Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: ui.CheckedState.values.map((state) {
            final icons = {
              ui.CheckedState.unchecked: Icons.check_box_outline_blank,
              ui.CheckedState.checked: Icons.check_box,
              ui.CheckedState.mixed: Icons.indeterminate_check_box,
            };
            final colors = {
              ui.CheckedState.unchecked: Colors.grey,
              ui.CheckedState.checked: Colors.green,
              ui.CheckedState.mixed: Colors.orange,
            };
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: state == ui.CheckedState.mixed ? 0 : 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors[state]?.shade50 ?? Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors[state]?.shade400 ?? Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      icons[state] ?? Icons.check_box,
                      size: 48,
                      color: colors[state]?.shade700 ?? Colors.grey.shade700,
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colors[state]?.shade700 ?? Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      'index: ${state.index}',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors[state]?.shade500 ?? Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Mapping table
        Text(
          'Widget Value Mapping',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              _MappingRow(widgetValue: 'true', state: 'checked', color: Colors.green),
              Divider(height: 1),
              _MappingRow(widgetValue: 'false', state: 'unchecked', color: Colors.grey),
              Divider(height: 1),
              _MappingRow(widgetValue: 'null', state: 'mixed', color: Colors.orange),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Info cards
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.accessibility,
                title: 'Purpose',
                content: 'Screen reader\naccessibility',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.check_box,
                title: 'Widget',
                content: 'Checkbox\ntristate mode',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.hub,
                title: 'Semantics',
                content: 'SemanticsNode',
                color: Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.CheckedState.values.length} states • Part of accessibility system • Used by Checkbox and Semantics widgets',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for mapping rows
class _MappingRow extends StatelessWidget {
  final String widgetValue;
  final String state;
  final Color color;

  const _MappingRow({
    required this.widgetValue,
    required this.state,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Checkbox(value: $widgetValue)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
          Expanded(
            child: Text(
              'CheckedState.$state',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for info cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 9,
              color: color.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
