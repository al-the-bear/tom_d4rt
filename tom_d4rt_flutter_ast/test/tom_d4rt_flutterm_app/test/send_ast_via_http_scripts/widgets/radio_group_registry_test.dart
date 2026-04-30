// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RadioGroupRegistry
// Demonstrates RadioGroupRegistry — an inherited widget that
// coordinates mutual exclusion across Radio, RadioListTile, and
// RadioMenuButton widgets. Covers group registration, selection
// handling, keyboard navigation, focus management, and real-world
// patterns with multiple independent radio groups.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RadioGroupRegistry Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RadioGroupRegistry?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.radio_button_checked,
      'title': 'Mutual Exclusion Coordinator',
      'body': 'RadioGroupRegistry is an InheritedWidget that manages '
          'the set of Radio buttons in a group. It ensures that when '
          'one radio button is selected, all others in the same '
          'group are deselected — the classic mutual exclusion pattern.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.group_work,
      'title': 'Automatic Group Membership',
      'body': 'Radio, RadioListTile, and RadioMenuButton widgets '
          'automatically register and unregister themselves with '
          'the nearest RadioGroupRegistry ancestor. You normally '
          'don\'t interact with the registry directly — it works '
          'behind the scenes whenever you use groupValue/onChanged.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Keyboard Navigation',
      'body': 'The registry enables arrow-key navigation between radios '
          'in a group. Pressing Up/Left moves focus to the previous '
          'radio; Down/Right moves to the next. The registry tracks '
          'registration order to determine traversal order.',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'Accessibility Integration',
      'body': 'By grouping radios in a registry, screen readers can '
          'announce "N of M" positioning within a group. The registry '
          'provides the structural information needed for assistive '
          'technology to convey the radio group semantics.',
      'accent': Colors.deepPurple[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: How Radio Groups Work Internally
  // ============================================================
  print('=== Section 2: Internal Mechanics ===');

  final mechanicsSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Registry Creation',
      'detail': 'A RadioGroupRegistry widget is placed in the tree '
          '(often implicitly by form or layout containers). It '
          'creates a _RadioGroupRegistryState that holds the list '
          'of registered radio members.',
      'icon': Icons.add_circle_outline,
      'color': Colors.indigo[700]!,
    },
    {
      'step': 2,
      'title': 'Member Registration',
      'detail': 'Each Radio widget\'s State calls register() on '
          'initState. This adds the radio to the registry\'s '
          'ordered member list. The registration order determines '
          'arrow-key traversal order.',
      'icon': Icons.app_registration,
      'color': Colors.deepPurple[600]!,
    },
    {
      'step': 3,
      'title': 'Selection Propagation',
      'detail': 'When a radio is tapped or activated via keyboard, '
          'it calls its onChanged callback with its value. The '
          'parent rebuilds with a new groupValue, which causes '
          'all radios to re-evaluate their selected state.',
      'icon': Icons.sync_alt,
      'color': Colors.indigo[600]!,
    },
    {
      'step': 4,
      'title': 'Keyboard Traversal',
      'detail': 'Arrow keys invoke the registry to find the next '
          'or previous member. The registry returns the appropriate '
          'FocusNode so focus moves between radios without tabbing.',
      'icon': Icons.keyboard_arrow_down,
      'color': Colors.deepPurple[700]!,
    },
    {
      'step': 5,
      'title': 'Unregistration',
      'detail': 'When a Radio\'s State is disposed, it calls '
          'unregister(). This removes it from the list, keeping '
          'the traversal order correct for remaining members.',
      'icon': Icons.remove_circle_outline,
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Prepared ${mechanicsSteps.length} mechanics steps');

  // ============================================================
  // SECTION 3: Single Group — Favorite Color
  // ============================================================
  print('=== Section 3: Single Group Demo ===');

  final colorOptions = <Map<String, dynamic>>[
    {'value': 'red', 'label': 'Red', 'color': Colors.red, 'icon': Icons.circle},
    {'value': 'green', 'label': 'Green', 'color': Colors.green, 'icon': Icons.circle},
    {'value': 'blue', 'label': 'Blue', 'color': Colors.blue, 'icon': Icons.circle},
    {'value': 'purple', 'label': 'Purple', 'color': Colors.purple, 'icon': Icons.circle},
    {'value': 'orange', 'label': 'Orange', 'color': Colors.orange, 'icon': Icons.circle},
  ];

  String selectedColor = 'blue';

  print('  Color group: ${colorOptions.length} options, selected=$selectedColor');

  // ============================================================
  // SECTION 4: Multiple Independent Groups
  // ============================================================
  print('=== Section 4: Multiple Groups ===');

  final sizeOptions = <Map<String, dynamic>>[
    {'value': 'small', 'label': 'Small', 'icon': Icons.text_fields, 'subtitle': '12px body text'},
    {'value': 'medium', 'label': 'Medium', 'icon': Icons.format_size, 'subtitle': '16px body text'},
    {'value': 'large', 'label': 'Large', 'icon': Icons.title, 'subtitle': '20px body text'},
  ];

  final themeOptions = <Map<String, dynamic>>[
    {'value': 'light', 'label': 'Light', 'icon': Icons.light_mode, 'subtitle': 'White background'},
    {'value': 'dark', 'label': 'Dark', 'icon': Icons.dark_mode, 'subtitle': 'Dark background'},
    {'value': 'system', 'label': 'System', 'icon': Icons.settings_brightness, 'subtitle': 'Match OS theme'},
  ];

  String selectedSize = 'medium';
  String selectedTheme = 'system';

  print('  Size group: ${sizeOptions.length} options, selected=$selectedSize');
  print('  Theme group: ${themeOptions.length} options, selected=$selectedTheme');

  // ============================================================
  // SECTION 5: RadioListTile Integration
  // ============================================================
  print('=== Section 5: RadioListTile Integration ===');

  final priorityOptions = <Map<String, dynamic>>[
    {
      'value': 'low',
      'title': 'Low Priority',
      'subtitle': 'Handle when convenient — no deadline',
      'icon': Icons.arrow_downward,
      'color': Colors.green[600]!,
    },
    {
      'value': 'medium',
      'title': 'Medium Priority',
      'subtitle': 'Address this week — standard queue',
      'icon': Icons.remove,
      'color': Colors.orange[600]!,
    },
    {
      'value': 'high',
      'title': 'High Priority',
      'subtitle': 'Needs attention today — escalated',
      'icon': Icons.arrow_upward,
      'color': Colors.red[600]!,
    },
    {
      'value': 'critical',
      'title': 'Critical',
      'subtitle': 'Immediate action required — blocking',
      'icon': Icons.priority_high,
      'color': Colors.red[900]!,
    },
  ];

  String selectedPriority = 'medium';

  print('  Priority group: ${priorityOptions.length} options, selected=$selectedPriority');

  // ============================================================
  // SECTION 6: Keyboard Navigation Detail
  // ============================================================
  print('=== Section 6: Keyboard Navigation ===');

  final navRules = <Map<String, dynamic>>[
    {
      'keys': '↓ / →',
      'action': 'Move to Next',
      'detail': 'Focuses the next radio button in registration order. '
          'Wraps around to the first if at the end.',
      'icon': Icons.keyboard_arrow_down,
      'color': Colors.indigo[700]!,
    },
    {
      'keys': '↑ / ←',
      'action': 'Move to Previous',
      'detail': 'Focuses the previous radio button. Wraps around to '
          'the last if at the beginning.',
      'icon': Icons.keyboard_arrow_up,
      'color': Colors.indigo[600]!,
    },
    {
      'keys': 'Space',
      'action': 'Select Focused',
      'detail': 'Activates the currently focused radio button, calling '
          'onChanged with its value.',
      'icon': Icons.space_bar,
      'color': Colors.deepPurple[600]!,
    },
    {
      'keys': 'Tab',
      'action': 'Leave Group',
      'detail': 'Tab moves focus out of the radio group entirely to '
          'the next focusable widget. Shift+Tab goes backward.',
      'icon': Icons.keyboard_tab,
      'color': Colors.deepPurple[700]!,
    },
  ];

  print('  Navigation rules: ${navRules.length} entries');

  // ============================================================
  // SECTION 7: Styling and Customization
  // ============================================================
  print('=== Section 7: Styling ===');

  final styleExamples = <Map<String, dynamic>>[
    {
      'name': 'Active Color',
      'code': 'Radio(activeColor: Colors.indigo, ...)',
      'description': 'Changes the color of the selected radio dot. '
          'Applies to the fill color when the radio is checked.',
      'icon': Icons.color_lens,
      'color': Colors.indigo[700]!,
    },
    {
      'name': 'Focus Color',
      'code': 'Radio(focusColor: Colors.indigo.withValues(alpha: 0.12), ...)',
      'description': 'The overlay color when the radio has keyboard focus. '
          'Important for accessibility — shows which radio is active.',
      'icon': Icons.center_focus_strong,
      'color': Colors.indigo[600]!,
    },
    {
      'name': 'Hover Color',
      'code': 'Radio(hoverColor: Colors.indigo.withValues(alpha: 0.08), ...)',
      'description': 'The overlay on mouse hover. Provides visual feedback '
          'on desktop platforms.',
      'icon': Icons.mouse,
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'Splash Radius',
      'code': 'Radio(splashRadius: 24, ...)',
      'description': 'Controls the size of the ink splash and overlay '
          'circle around the radio button.',
      'icon': Icons.radio_button_unchecked,
      'color': Colors.deepPurple[700]!,
    },
    {
      'name': 'Visual Density',
      'code': 'Radio(visualDensity: VisualDensity.compact, ...)',
      'description': 'Adjusts the overall size and spacing. Compact '
          'density reduces the hit area for denser layouts.',
      'icon': Icons.view_compact,
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Style examples: ${styleExamples.length} entries');

  // ============================================================
  // SECTION 8: Common Patterns and Best Practices
  // ============================================================
  print('=== Section 8: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Enum-Based Groups',
      'description': 'Define radio values as enum members for type safety. '
          'Use Radio<MyEnum> with groupValue and onChanged typed to the enum. '
          'This prevents accidental value mismatches at compile time.',
      'icon': Icons.data_object,
      'color': Colors.indigo[700]!,
    },
    {
      'title': 'Form Integration',
      'description': 'Radio buttons work inside Form widgets. Use '
          'FormField to validate that a selection has been made. '
          'The group value can be saved and restored with form state.',
      'icon': Icons.description,
      'color': Colors.deepPurple[600]!,
    },
    {
      'title': 'Disabled States',
      'description': 'Set onChanged to null to disable a radio option. '
          'The radio appears grayed out and is skipped during keyboard '
          'navigation. Use this for unavailable options rather than hiding.',
      'icon': Icons.block,
      'color': Colors.indigo[600]!,
    },
    {
      'title': 'Dynamic Options',
      'description': 'Radio groups can have dynamic members. Adding or '
          'removing options automatically updates the registry. If the '
          'selected value is removed, handle the stale groupValue in '
          'your state management.',
      'icon': Icons.dynamic_feed,
      'color': Colors.deepPurple[700]!,
    },
    {
      'title': 'Horizontal Layout',
      'description': 'While radios are often vertical, use Row or Wrap '
          'for horizontal arrangement. The registry still tracks them in '
          'registration order. Ensure adequate spacing for touch targets.',
      'icon': Icons.view_column,
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Patterns: ${patterns.length} entries');

  // ============================================================
  // SECTION 9: Comparison Table
  // ============================================================
  print('=== Section 9: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'widget': 'Radio<T>',
      'use': 'Standalone radio circle',
      'registry': 'Auto-registered',
      'features': 'Minimal — just the radio indicator',
    },
    {
      'widget': 'RadioListTile<T>',
      'use': 'Radio + label + subtitle',
      'registry': 'Auto-registered',
      'features': 'Leading/trailing, subtitle, dense, full row tap',
    },
    {
      'widget': 'RadioMenuButton<T>',
      'use': 'Radio inside a menu',
      'registry': 'Auto-registered',
      'features': 'Menu item styling, shortcut labels',
    },
    {
      'widget': 'SegmentedButton<T>',
      'use': 'Chip-like toggle group',
      'registry': 'Own mechanism',
      'features': 'Multi-select option, Material 3 styling',
    },
    {
      'widget': 'ToggleButtons',
      'use': 'Button bar toggle',
      'registry': 'Own mechanism',
      'features': 'Border styling, icon buttons',
    },
  ];

  print('  Comparison entries: ${comparisons.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[800]!, Colors.deepPurple[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.radio_button_checked, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RadioGroupRegistry',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Mutual-exclusion coordinator for Radio widgets — manages '
                'group membership, keyboard traversal, and selection state.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.indigo[700]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(color: c['accent'] as Color, width: 4),
                  ),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c['title'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: c['accent'] as Color,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Internal Mechanics ----
        _sectionHeader('2. Internal Mechanics', Icons.engineering, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        ...mechanicsSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${s['step']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['title'] as String,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 3),
                        Text(s['detail'] as String, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Single Group — Favorite Color ----
        _sectionHeader('3. Single Group — Favorite Color', Icons.palette, Colors.indigo[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All radios share one groupValue. Selecting any one '
                'deselects the rest — exactly one is active at a time.',
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              ...colorOptions.map((opt) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: opt['value'] as String,
                          groupValue: selectedColor,
                          onChanged: (v) {},
                          activeColor: opt['color'] as Color,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: opt['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          opt['label'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: opt['value'] == selectedColor
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.indigo[700], size: 18),
                    SizedBox(width: 8),
                    Text('Selected: $selectedColor',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Multiple Independent Groups ----
        _sectionHeader('4. Independent Groups', Icons.view_module, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        Text(
          'Each group has its own groupValue — changing one does not '
          'affect another. The registry scopes membership per ancestor.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        // Size group
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Text Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple[800])),
              SizedBox(height: 8),
              ...sizeOptions.map((opt) => Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: RadioListTile<String>(
                      value: opt['value'] as String,
                      groupValue: selectedSize,
                      onChanged: (v) {},
                      title: Text(opt['label'] as String, style: TextStyle(fontSize: 14)),
                      subtitle: Text(opt['subtitle'] as String, style: TextStyle(fontSize: 12)),
                      secondary: Icon(opt['icon'] as IconData, color: Colors.deepPurple[600]),
                      dense: true,
                      activeColor: Colors.deepPurple[700],
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Theme group
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Theme Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo[800])),
              SizedBox(height: 8),
              ...themeOptions.map((opt) => Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: RadioListTile<String>(
                      value: opt['value'] as String,
                      groupValue: selectedTheme,
                      onChanged: (v) {},
                      title: Text(opt['label'] as String, style: TextStyle(fontSize: 14)),
                      subtitle: Text(opt['subtitle'] as String, style: TextStyle(fontSize: 12)),
                      secondary: Icon(opt['icon'] as IconData, color: Colors.indigo[600]),
                      dense: true,
                      activeColor: Colors.indigo[700],
                    ),
                  )),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 5: RadioListTile Priority ----
        _sectionHeader('5. RadioListTile — Priority Picker', Icons.flag, Colors.red[700]!),
        SizedBox(height: 10),
        ...priorityOptions.map((opt) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (opt['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    left: BorderSide(color: opt['color'] as Color, width: 4),
                  ),
                ),
                child: RadioListTile<String>(
                  value: opt['value'] as String,
                  groupValue: selectedPriority,
                  onChanged: (v) {},
                  title: Text(
                    opt['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: opt['color'] as Color,
                    ),
                  ),
                  subtitle: Text(opt['subtitle'] as String, style: TextStyle(fontSize: 12)),
                  secondary: Icon(opt['icon'] as IconData, color: opt['color'] as Color),
                  activeColor: opt['color'] as Color,
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Keyboard Navigation ----
        _sectionHeader('6. Keyboard Navigation', Icons.keyboard, Colors.indigo[700]!),
        SizedBox(height: 10),
        ...navRules.map((r) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (r['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 40,
                      decoration: BoxDecoration(
                        color: r['color'] as Color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        r['keys'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['action'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 2),
                          Text(r['detail'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Styling & Customization ----
        _sectionHeader('7. Styling & Customization', Icons.brush, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        ...styleExamples.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(s['icon'] as IconData, color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(s['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(s['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                    ),
                    SizedBox(height: 6),
                    Text(s['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Patterns & Best Practices ----
        _sectionHeader('8. Best Practices', Icons.lightbulb_outline, Colors.indigo[700]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                          SizedBox(height: 4),
                          Text(p['description'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 9: Comparison Table ----
        _sectionHeader('9. Selection Widget Comparison', Icons.compare, Colors.deepPurple[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header row
              Container(
                color: Colors.deepPurple[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('Registry', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(comparisons.length, (i) {
                final c = comparisons[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.grey[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(c['widget'] as String,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(c['use'] as String, style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c['registry'] as String, style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.radio_button_checked, color: Colors.indigo[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RadioGroupRegistry: automatic mutual-exclusion, '
                'keyboard navigation, and accessibility for radio '
                'button groups — working silently behind every '
                'Radio, RadioListTile, and RadioMenuButton.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
