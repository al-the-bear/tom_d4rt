// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawRadio
// Demonstrates the RawRadio widget — the unstyled, low-level radio button
// building block. RawRadio<T> handles selection logic, toggleable behavior,
// focus management, accessibility semantics, and the ToggleableStateMixin
// animation state — while delegating ALL visual rendering to a custom builder.
// Used by Radio (Material) and CupertinoRadio under the hood.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawRadio Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawRadio Is — Concept
  // ============================================================
  print('=== Section 1: RawRadio Concept ===');

  // RawRadio<T> is a StatefulWidget that provides the behavioral
  // foundation for radio buttons without any visual design.
  //
  // Key characteristics:
  //   - Generic type T for the value (enums, strings, ints, etc.)
  //   - Uses ToggleableStateMixin for animation state
  //   - Requires a RadioGroupRegistry<T> (from RadioGroup widget)
  //   - Builder receives ToggleableStateMixin for reading state
  //   - Handles tap → selection, focus, hover, disabled states
  //   - Semantics: inMutuallyExclusiveGroup, checked, selected
  //
  // Constructor (all required):
  //   value: T — the value this radio represents
  //   mouseCursor: WidgetStateProperty<MouseCursor>
  //   toggleable: bool — whether re-selecting unselects
  //   focusNode: FocusNode
  //   autofocus: bool
  //   groupRegistry: RadioGroupRegistry<T>?
  //   enabled: bool
  //   builder: RadioBuilder (Widget Function(BuildContext, ToggleableStateMixin))

  final conceptCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF4CAF50), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawRadio<T>',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The unstyled radio button foundation. Provides selection '
          'logic, toggleable animation state, focus management, and '
          'accessibility — while delegating every pixel of visual '
          'rendering to a custom builder.',
          style: TextStyle(fontSize: 14, color: Color(0xFF2E7D32)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildConceptChip('Generic<T>', Icons.code),
            _buildConceptChip('ToggleableState', Icons.swap_horiz),
            _buildConceptChip('RadioGroup', Icons.group_work),
            _buildConceptChip('Custom Builder', Icons.brush),
            _buildConceptChip('Accessibility', Icons.accessibility_new),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor Parameters
  // ============================================================
  print('=== Section 2: Constructor Parameters ===');

  // Every parameter is required (no optional ones).

  final paramCards = Column(
    children: [
      _buildParamCard('value', 'T', 'The value this radio represents. '
          'When groupValue == value, this radio is selected.'),
      const SizedBox(height: 8),
      _buildParamCard('mouseCursor', 'WidgetStateProperty<MouseCursor>',
          'Resolves cursor for states: selected, hovered, focused, disabled.'),
      const SizedBox(height: 8),
      _buildParamCard('toggleable', 'bool',
          'When true, re-tapping selected radio sets groupValue to null. '
          'When false, once selected it can only be deselected by selecting '
          'another radio.'),
      const SizedBox(height: 8),
      _buildParamCard('focusNode', 'FocusNode',
          'Focus node for keyboard navigation and focus state tracking.'),
      const SizedBox(height: 8),
      _buildParamCard('autofocus', 'bool',
          'Whether this radio requests focus on first build.'),
      const SizedBox(height: 8),
      _buildParamCard('groupRegistry', 'RadioGroupRegistry<T>?',
          'The registry from the ancestor RadioGroup. Required when enabled. '
          'Get via RadioGroup.maybeOf<T>(context). Tracks groupValue and '
          'onChanged callback.'),
      const SizedBox(height: 8),
      _buildParamCard('enabled', 'bool',
          'Whether the radio is interactive. When false, it ignores taps and '
          'shows the disabled mouse cursor.'),
      const SizedBox(height: 8),
      _buildParamCard('builder', 'RadioBuilder',
          'Widget Function(BuildContext, ToggleableStateMixin state)\n'
          'Builds the visual. Use state.position for animation, '
          'state.value for selection, state.isFocused/isHovered for visual feedback.'),
    ],
  );

  // ============================================================
  // SECTION 3: RadioGroup Integration
  // ============================================================
  print('=== Section 3: RadioGroup Integration ===');

  // RawRadio requires a RadioGroup<T> ancestor:
  //
  //   RadioGroup<String>(
  //     groupValue: selectedValue,
  //     onChanged: (String? val) => setState(() => selectedValue = val),
  //     child: Column(children: [
  //       RawRadio<String>(value: 'a', ...),
  //       RawRadio<String>(value: 'b', ...),
  //     ]),
  //   )
  //
  // RadioGroup handles:
  //   - Maintains groupValue shared across all radios
  //   - Provides RadioGroupRegistry via maybeOf<T>(context)
  //   - Keyboard navigation: Arrow keys move selection
  //   - Tab/Shift+Tab focus management
  //   - Space to toggle selection

  final radioGroupCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFF9800)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RadioGroup<T> Hierarchy',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 12),
        _buildTreeLine('RadioGroup<T>', 0, const Color(0xFFE65100)),
        _buildTreeLine('├─ groupValue: T?', 1, const Color(0xFF757575)),
        _buildTreeLine('├─ onChanged: ValueChanged<T?>', 1, const Color(0xFF757575)),
        _buildTreeLine('└─ child:', 1, const Color(0xFF757575)),
        _buildTreeLine('   ├─ RawRadio<T>(value: \'a\', ...)', 2, const Color(0xFF2E7D32)),
        _buildTreeLine('   ├─ RawRadio<T>(value: \'b\', ...)', 2, const Color(0xFF2E7D32)),
        _buildTreeLine('   └─ RawRadio<T>(value: \'c\', ...)', 2, const Color(0xFF2E7D32)),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0B2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Access registry from child:\n'
            '  final registry = RadioGroup.maybeOf<T>(context);\n\n'
            'Keyboard navigation of RadioGroup:\n'
            '  Tab/Shift+Tab → enter/leave group\n'
            '  Arrow keys → move selection\n'
            '  Space → toggle focused radio',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFFE65100),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: ToggleableStateMixin — Builder State
  // ============================================================
  print('=== Section 4: ToggleableStateMixin — Builder State ===');

  // The builder receives a ToggleableStateMixin which exposes:
  //
  //   position      → CurvedAnimation (0.0 = unselected, 1.0 = selected)
  //   value         → bool? (true = selected, false = unselected, null = tristate)
  //   states        → Set<WidgetState> (hovered, focused, selected, disabled)
  //   isInteractive → bool (whether enabled)
  //
  // Use position.value for smooth animation between states.
  // Use value for discrete state checks.
  // Use states.contains(WidgetState.hovered) for hover detection.

  final stateCards = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF3F51B5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ToggleableStateMixin Properties',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        const SizedBox(height: 12),
        _buildStateRow('position', 'CurvedAnimation',
            '0.0 → 1.0 animation. Drives smooth transition between '
            'unselected (0.0) and selected (1.0). Use for custom painting.',
            const Color(0xFF1565C0)),
        const SizedBox(height: 8),
        _buildStateRow('value', 'bool?',
            'true = selected, false = unselected, null = tristate '
            '(when toggleable is true and deselected).',
            const Color(0xFF2E7D32)),
        const SizedBox(height: 8),
        _buildStateRow('states', 'Set<WidgetState>',
            'Contains hovered, focused, selected, disabled. Check with '
            'states.contains(WidgetState.hovered) etc.',
            const Color(0xFFE65100)),
        const SizedBox(height: 8),
        _buildStateRow('isInteractive', 'bool',
            'Whether the radio is enabled and can be tapped.',
            const Color(0xFFC62828)),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live RawRadio with Custom Builder
  // ============================================================
  print('=== Section 5: Live RawRadio with Custom Builder ===');

  final liveDemo = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF9C27B0), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live: Custom-Painted RawRadio Buttons',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each radio uses a custom builder to render its own visual. '
          'The builder checks state.value, state.position.value, '
          'state.isFocused, and state.isHovered to decide rendering.',
          style: TextStyle(fontSize: 12, color: Color(0xFF7B1FA2)),
        ),
        const SizedBox(height: 12),
        _LiveRadioGroupDemo(),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: toggleable Behavior
  // ============================================================
  print('=== Section 6: toggleable Behavior ===');

  final toggleableCards = Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF4CAF50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.radio_button_checked, color: Color(0xFF2E7D32), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'false (default)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Standard radio behavior:\n\n'
                '• Tap unselected → selects\n'
                '• Tap selected → nothing\n'
                '• Only another radio can deselect\n'
                '• groupValue is never null after\n'
                '  first selection',
                style: TextStyle(fontSize: 11, color: Color(0xFF1B5E20)),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFF9800)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.toggle_on, color: Color(0xFFE65100), size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'true',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Toggle-deselect behavior:\n\n'
                '• Tap unselected → selects\n'
                '• Tap selected → deselects\n'
                '• onChanged called with null\n'
                '• groupValue can become null\n'
                '• value property returns null',
                style: TextStyle(fontSize: 11, color: Color(0xFFBF360C)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 7: Accessibility & Semantics
  // ============================================================
  print('=== Section 7: Accessibility & Semantics ===');

  // RawRadio wraps its builder output in a Semantics node:
  //
  //   Semantics(
  //     inMutuallyExclusiveGroup: true,
  //     checked: value,           // for Android/Linux/Windows/Fuchsia
  //     selected: value,          // for iOS/macOS
  //     hint: localizations.radioButtonUnselectedLabel,  // iOS/macOS only
  //     child: ...
  //   )

  final semanticsCard = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF009688)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accessibility Semantics',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        const SizedBox(height: 12),
        _buildSemanticRow('inMutuallyExclusiveGroup', 'true',
            'Tells screen reader this is part of a radio group'),
        const SizedBox(height: 6),
        _buildSemanticRow('checked', 'value (Android/Linux/Win)',
            'Reports selection via checked property'),
        const SizedBox(height: 6),
        _buildSemanticRow('selected', 'value (iOS/macOS)',
            'Reports selection via selected property'),
        const SizedBox(height: 6),
        _buildSemanticRow('hint', 'radioButtonUnselectedLabel',
            'iOS/macOS: provided only when unselected'),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFB2DFDB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Color(0xFF004D40)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'RadioGroup also adds keyboard navigation semantics '
                  'and ARIA radiogroup role. The combination provides '
                  'full APG (ARIA Authoring Practices Guide) compliance.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF004D40)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Custom Builder Patterns
  // ============================================================
  print('=== Section 8: Custom Builder Patterns ===');

  // Three visual patterns showing different builder approaches.

  final builderPatterns = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE91E63)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Builder Patterns',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        const SizedBox(height: 12),
        _buildPatternCard(
          'Circle Dot (Material-style)',
          'Outer circle always visible. Inner dot scales with '
          'state.position.value (0.0 → 1.0). Color changes on '
          'selected/disabled.',
          Icons.radio_button_checked,
          const Color(0xFF1565C0),
        ),
        const SizedBox(height: 10),
        _buildPatternCard(
          'Checkmark (Custom)',
          'Container with rounded corners. When state.value == true, '
          'show a checkmark icon. Background color lerps with '
          'position.value.',
          Icons.check_circle,
          const Color(0xFF2E7D32),
        ),
        const SizedBox(height: 10),
        _buildPatternCard(
          'Segmented Chip (Custom)',
          'Styled container with text label. Selected state adds '
          'colored border and fill. Use state.isFocused for focus '
          'ring, state.isHovered for hover effect.',
          Icons.smart_button,
          const Color(0xFFE65100),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8BBD0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Builder example:\n'
            '  builder: (context, state) {\n'
            '    final selected = state.value == true;\n'
            '    final t = state.position.value; // 0.0..1.0\n'
            '    return Container(\n'
            '      width: 24, height: 24,\n'
            '      decoration: BoxDecoration(\n'
            '        shape: BoxShape.circle,\n'
            '        border: Border.all(\n'
            '          color: selected ? Colors.blue : Colors.grey,\n'
            '        ),\n'
            '      ),\n'
            '      child: Center(\n'
            '        child: Container(\n'
            '          width: 12 * t, height: 12 * t,\n'
            '          decoration: BoxDecoration(\n'
            '            shape: BoxShape.circle,\n'
            '            color: Colors.blue,\n'
            '          ),\n'
            '        ),\n'
            '      ),\n'
            '    );\n'
            '  }',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF880E4F),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Comparison — RawRadio vs Radio vs CupertinoRadio
  // ============================================================
  print('=== Section 9: RawRadio vs Radio vs CupertinoRadio ===');

  final comparisonTable = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF9E9E9E)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RawRadio vs Radio vs CupertinoRadio',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 12),
        _buildComparisonHeader(),
        _buildComparisonRow('Layer', 'widgets', 'material', 'cupertino'),
        _buildComparisonRow('Visual', 'Custom builder', 'MD circle dot', 'iOS gradient dot'),
        _buildComparisonRow('Theming', 'None', 'RadioTheme', 'CupertinoTheme'),
        _buildComparisonRow('Ink Splash', 'Manual', 'Built-in', 'None'),
        _buildComparisonRow('Size', 'Custom', '48×48 (touch)', '20×20 (visual)'),
        _buildComparisonRow('Animation', 'position curve', 'Radial + paint', 'Scale animation'),
        _buildComparisonRow('Colors', 'Custom', 'activeColor', 'activeColor'),
        _buildComparisonRow('Use Case', 'Fully custom', 'Standard MD', 'iOS style'),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: API Property Reference
  // ============================================================
  print('=== Section 10: API Property Reference ===');

  final apiReference = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF4CAF50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete API Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 12),
        _buildApiRow('value', 'T'),
        _buildApiRow('mouseCursor', 'WidgetStateProperty<MouseCursor>'),
        _buildApiRow('toggleable', 'bool'),
        _buildApiRow('focusNode', 'FocusNode'),
        _buildApiRow('autofocus', 'bool'),
        _buildApiRow('groupRegistry', 'RadioGroupRegistry<T>?'),
        _buildApiRow('enabled', 'bool'),
        _buildApiRow('builder', 'RadioBuilder'),
        const SizedBox(height: 14),
        const Text(
          'All parameters are required',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Related Types',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF388E3C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'RadioBuilder:\n'
            '  Widget Function(BuildContext, ToggleableStateMixin)\n\n'
            'RadioGroupRegistry<T>:\n'
            '  - groupValue → T?\n'
            '  - onChanged(T?) → void\n\n'
            'ToggleableStateMixin:\n'
            '  - position → CurvedAnimation (0.0..1.0)\n'
            '  - value → bool? (selected state)\n'
            '  - states → Set<WidgetState>\n'
            '  - isInteractive → bool',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Assemble all sections
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'RawRadio — Deep Demo',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Unstyled radio button with custom rendering',
          style: TextStyle(fontSize: 14, color: Color(0xFF388E3C)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Section 1
        _buildSectionHeader(1, 'Concept'),
        const SizedBox(height: 8),
        conceptCard,
        const SizedBox(height: 24),

        // Section 2
        _buildSectionHeader(2, 'Constructor Parameters'),
        const SizedBox(height: 8),
        paramCards,
        const SizedBox(height: 24),

        // Section 3
        _buildSectionHeader(3, 'RadioGroup Integration'),
        const SizedBox(height: 8),
        radioGroupCard,
        const SizedBox(height: 24),

        // Section 4
        _buildSectionHeader(4, 'ToggleableStateMixin — Builder State'),
        const SizedBox(height: 8),
        stateCards,
        const SizedBox(height: 24),

        // Section 5
        _buildSectionHeader(5, 'Live RawRadio with Custom Builder'),
        const SizedBox(height: 8),
        liveDemo,
        const SizedBox(height: 24),

        // Section 6
        _buildSectionHeader(6, 'toggleable Behavior'),
        const SizedBox(height: 8),
        toggleableCards,
        const SizedBox(height: 24),

        // Section 7
        _buildSectionHeader(7, 'Accessibility & Semantics'),
        const SizedBox(height: 8),
        semanticsCard,
        const SizedBox(height: 24),

        // Section 8
        _buildSectionHeader(8, 'Custom Builder Patterns'),
        const SizedBox(height: 8),
        builderPatterns,
        const SizedBox(height: 24),

        // Section 9
        _buildSectionHeader(9, 'RawRadio vs Radio vs CupertinoRadio'),
        const SizedBox(height: 8),
        comparisonTable,
        const SizedBox(height: 24),

        // Section 10
        _buildSectionHeader(10, 'API Property Reference'),
        const SizedBox(height: 8),
        apiReference,
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ============================================================
// Helper: Section header
// ============================================================
Widget _buildSectionHeader(int number, String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF388E3C), Color(0xFF1B5E20)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Concept chip
// ============================================================
Widget _buildConceptChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFA5D6A7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF1B5E20)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E20),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Parameter card
// ============================================================
Widget _buildParamCard(String name, String type, String description) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFC5E1A5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Color(0xFF33691E),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFDCEDC8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Color(0xFF33691E),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Required',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFC62828),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(fontSize: 11, color: Color(0xFF558B2F)),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Tree line
// ============================================================
Widget _buildTreeLine(String text, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 12.0, top: 3, bottom: 3),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'monospace',
        fontWeight: depth == 0 ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    ),
  );
}

// ============================================================
// Helper: State property row
// ============================================================
Widget _buildStateRow(String name, String type, String description, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Semantic row
// ============================================================
Widget _buildSemanticRow(String property, String value, String description) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Text(
          property,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Color(0xFF00695C),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Color(0xFF00897B),
              ),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 11, color: Color(0xFF4DB6AC)),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// Helper: Pattern card
// ============================================================
Widget _buildPatternCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Comparison header
// ============================================================
Widget _buildComparisonHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: const BoxDecoration(
      color: Color(0xFF616161),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'RawRadio',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Radio',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'CupertinoRadio',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: Comparison row (4 columns)
// ============================================================
Widget _buildComparisonRow(String aspect, String rawVal, String matVal, String cupVal) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            aspect,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(rawVal, style: const TextStyle(fontSize: 10, color: Color(0xFF616161))),
        ),
        Expanded(
          flex: 2,
          child: Text(matVal, style: const TextStyle(fontSize: 10, color: Color(0xFF616161))),
        ),
        Expanded(
          flex: 2,
          child: Text(cupVal, style: const TextStyle(fontSize: 10, color: Color(0xFF616161))),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: API row
// ============================================================
Widget _buildApiRow(String name, String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFC8E6C9))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Color(0xFF388E3C),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Live Demo: Custom radical group with RawRadio
// ============================================================
class _LiveRadioGroupDemo extends StatefulWidget {
  @override
  State<_LiveRadioGroupDemo> createState() => _LiveRadioGroupDemoState();
}

class _LiveRadioGroupDemoState extends State<_LiveRadioGroupDemo> {
  String? _selectedFruit;

  final _options = const [
    ('apple', 'Apple', Color(0xFFC62828), Icons.energy_savings_leaf),
    ('banana', 'Banana', Color(0xFFF9A825), Icons.eco),
    ('cherry', 'Cherry', Color(0xFFAD1457), Icons.favorite),
    ('date', 'Date', Color(0xFF4E342E), Icons.calendar_today),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioGroup<String>(
          groupValue: _selectedFruit,
          onChanged: (String? value) {
            setState(() => _selectedFruit = value);
          },
          child: Builder(
            builder: (BuildContext groupContext) {
              final registry = RadioGroup.maybeOf<String>(groupContext);
              return Column(
                children: _options.map((option) {
                  final (value, label, color, icon) = option;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        RawRadio<String>(
                          value: value,
                          mouseCursor: WidgetStateProperty.resolveWith(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.disabled)) {
                                return SystemMouseCursors.forbidden;
                              }
                              return SystemMouseCursors.click;
                            },
                          ),
                          toggleable: false,
                          focusNode: FocusNode(),
                          autofocus: false,
                          groupRegistry: registry,
                          enabled: true,
                          builder: (BuildContext ctx, ToggleableStateMixin state) {
                            final selected = state.value == true;
                            final t = state.position.value;
                            final hovered = state.states.contains(WidgetState.hovered);
                            return Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? color : const Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                                color: hovered
                                    ? color.withOpacity(0.08)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Container(
                                  width: 14 * t,
                                  height: 14 * t,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color.withOpacity(t),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        Icon(icon, size: 18, color: color),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _selectedFruit == value
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedFruit == value
                                ? color
                                : const Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Selected: ${_selectedFruit ?? 'None'}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF4527A0),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Disabled example
        const Text(
          'Disabled Radio:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF757575),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            RawRadio<String>(
              value: 'disabled_example',
              mouseCursor: WidgetStateProperty.all(SystemMouseCursors.forbidden),
              toggleable: false,
              focusNode: FocusNode(),
              autofocus: false,
              groupRegistry: null,
              enabled: false,
              builder: (BuildContext ctx, ToggleableStateMixin state) {
                return Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 2,
                    ),
                    color: const Color(0xFFFAFAFA),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Not interactive (enabled: false, registry: null)',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
