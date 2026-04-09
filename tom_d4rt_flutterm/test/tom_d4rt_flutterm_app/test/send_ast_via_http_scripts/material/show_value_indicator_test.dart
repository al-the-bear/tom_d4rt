// ignore_for_file: avoid_print
// D4rt deep demo: ShowValueIndicator — controls when slider value
// indicator bubbles appear (never, onDrag, only discrete, only continuous).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShowValueIndicator deep demo executing');
  print('=' * 60);

  // --- Enumerate all values ---
  for (final v in ShowValueIndicator.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${ShowValueIndicator.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const svPrimary = Color(0xFFFF8C00);   // tangerine
  const svAccent = Color(0xFFFFAB40);    // apricot
  const svLight = Color(0xFFFFF3E0);     // light apricot
  const svDark = Color(0xFFE65100);      // deep tangerine
  const svSurface = Color(0xFFFFFBF5);
  const svOnSurface = Color(0xFF3E2723);
  const svMuted = Color(0xFF8D6E63);

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> svEnumData = [
    {
      'value': 'onlyForDiscrete',
      'desc': 'Shows the value indicator only when the slider has '
          'discrete divisions. The default in Material 2.',
      'when': 'Slider has divisions != null',
      'icon': '⬡',
    },
    {
      'value': 'onlyForContinuous',
      'desc': 'Shows the value indicator only for continuous '
          'sliders (no divisions). Useful when continuous '
          'precision matters more.',
      'when': 'Slider has divisions == null',
      'icon': '━',
    },
    {
      'value': 'onDrag',
      'desc': 'Shows the value indicator while the user is '
          'actively dragging the slider thumb, regardless of '
          'whether the slider is discrete or continuous.',
      'when': 'Any slider interaction (drag)',
      'icon': '●',
    },
    {
      'value': 'never',
      'desc': 'Never shows the value indicator. The user only sees '
          'the thumb position without numeric feedback.',
      'when': 'Indicator permanently hidden',
      'icon': '○',
    },
  ];

  // ── helper builders ─────────────────────────────────────────
  Widget svSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: svAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: svPrimary.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [svPrimary, svAccent],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child ?? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children ?? [],
            ),
          ),
        ],
      ),
    );
  }

  Widget svLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: svOnSurface)),
    );
  }

  Widget svBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: svMuted, height: 1.5)),
    );
  }

  Widget svChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? svLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: svAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget svDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: svAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // ── live slider helper ──────────────────────────────────────
  Widget svSliderDemo({
    required String label,
    required ShowValueIndicator mode,
    required double value,
    int? divisions,
    String? note,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: svLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: svAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: svPrimary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderThemeData(
              showValueIndicator: mode,
              activeTrackColor: svPrimary,
              inactiveTrackColor: svAccent.withValues(alpha: 0.3),
              thumbColor: svDark,
              valueIndicatorColor: svDark,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: divisions,
              label: value.toStringAsFixed(0),
              onChanged: (_) {},
            ),
          ),
          if (note != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(note,
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: svMuted)),
            ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: svSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [svPrimary, svDark],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ShowValueIndicator',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Controls when the slider value-indicator '
                  'bubble is displayed during interaction.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    svChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    svChip('SliderThemeData',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    svChip('Material',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          svSection('Enum Overview',
            children: [
              svBody(
                'ShowValueIndicator is an enum that determines when '
                'the tooltip-like value indicator is shown on a Slider. '
                'It is specified through SliderThemeData.showValueIndicator '
                'and affects both Slider and RangeSlider widgets.'),
              svBody(
                'The four values correspond to different levels of '
                'indicator visibility based on whether the slider is '
                'discrete (has divisions) or continuous.'),
              Wrap(
                children: [
                  for (final v in ShowValueIndicator.values)
                    svChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final item in svEnumData)
            svSection('${item['icon']}  ${item['value']}',
              children: [
                svLabel('Description'),
                svBody(item['desc']!),
                svLabel('Visible When'),
                svBody(item['when']!),
                svLabel('Index'),
                svBody(ShowValueIndicator.values
                    .firstWhere((v) => v.name == item['value'])
                    .index
                    .toString()),
              ],
            ),

          // ── 4. Live Slider Demos (Discrete) ──────────────────
          svSection('Live Demos — Discrete Slider (10 divisions)',
            children: [
              svBody(
                'Each slider below is themed with a different '
                'ShowValueIndicator mode. Discrete sliders have a '
                'fixed number of positions (divisions). Try interacting:'),
              svSliderDemo(
                label: 'onlyForDiscrete — indicator SHOWN',
                mode: ShowValueIndicator.onlyForDiscrete,
                value: 40,
                divisions: 10,
                note: 'Default mode. Since this is discrete, the bubble shows.',
              ),
              svSliderDemo(
                label: 'onlyForContinuous — indicator HIDDEN',
                mode: ShowValueIndicator.onlyForContinuous,
                value: 60,
                divisions: 10,
                note: 'This mode hides the indicator for discrete sliders.',
              ),
              svSliderDemo(
                label: 'onDrag — indicator SHOWN',
                mode: ShowValueIndicator.onDrag,
                value: 30,
                divisions: 10,
                note: 'Shows during drag regardless of discrete/continuous.',
              ),
              svSliderDemo(
                label: 'never — indicator HIDDEN',
                mode: ShowValueIndicator.never,
                value: 80,
                divisions: 10,
                note: 'Permanently hidden, no bubble feedback.',
              ),
            ],
          ),

          // ── 5. Live Slider Demos (Continuous) ────────────────
          svSection('Live Demos — Continuous Slider (no divisions)',
            children: [
              svBody(
                'Same four modes but on continuous sliders. '
                'Notice how the visibility behaviour inverts for '
                'onlyForDiscrete / onlyForContinuous:'),
              svSliderDemo(
                label: 'onlyForDiscrete — indicator HIDDEN',
                mode: ShowValueIndicator.onlyForDiscrete,
                value: 50,
                note: 'Continuous slider → discrete-only mode hides bubble.',
              ),
              svSliderDemo(
                label: 'onlyForContinuous — indicator SHOWN',
                mode: ShowValueIndicator.onlyForContinuous,
                value: 25,
                note: 'Continuous slider → this mode shows the bubble.',
              ),
              svSliderDemo(
                label: 'onDrag — indicator SHOWN',
                mode: ShowValueIndicator.onDrag,
                value: 75,
                note: 'onDrag mode: visible for continuous too.',
              ),
              svSliderDemo(
                label: 'never — indicator HIDDEN',
                mode: ShowValueIndicator.never,
                value: 10,
                note: 'Still hidden on continuous sliders.',
              ),
            ],
          ),

          // ── 6. Comparison Table ──────────────────────────────
          svSection('Visibility Matrix',
            child: Table(
              border: TableBorder.all(
                  color: svAccent.withValues(alpha: 0.3), width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: svPrimary.withValues(alpha: 0.1)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Discrete',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Continuous',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ],
                ),
                for (final row in [
                  ['onlyForDiscrete', '✓ Shown', '✗ Hidden'],
                  ['onlyForContinuous', '✗ Hidden', '✓ Shown'],
                  ['onDrag', '✓ Shown', '✓ Shown'],
                  ['never', '✗ Hidden', '✗ Hidden'],
                ])
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(row[0],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: svDark)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(row[1],
                            style: TextStyle(
                                fontSize: 12,
                                color: row[1].startsWith('✓')
                                    ? Colors.green.shade700
                                    : Colors.red.shade600)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(row[2],
                            style: TextStyle(
                                fontSize: 12,
                                color: row[2].startsWith('✓')
                                    ? Colors.green.shade700
                                    : Colors.red.shade600)),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // ── 7. Usage Patterns ────────────────────────────────
          svSection('Usage Patterns',
            children: [
              svLabel('Pattern 1: Form Slider with Precision Feedback'),
              svBody(
                'For a form slider where users need exact values '
                '(e.g., age selector), use "onDrag" so the indicator '
                'appears on both continuous and discrete variants.'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Age Selector — onDrag',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.onDrag,
                        activeTrackColor: svPrimary,
                        thumbColor: svDark,
                        valueIndicatorColor: svDark,
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white, fontSize: 11),
                      ),
                      child: Slider(
                        value: 28,
                        min: 18,
                        max: 80,
                        divisions: 62,
                        label: '28',
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
              svDivider(),
              svLabel('Pattern 2: Volume Slider without Bubble'),
              svBody(
                'For a simple volume slider where position is '
                'sufficient feedback, use "never" to reduce visual '
                'clutter.'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.volume_down, color: svMuted, size: 20),
                        const SizedBox(width: 4),
                        const Text('Volume — never',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.never,
                        activeTrackColor: svAccent,
                        thumbColor: svPrimary,
                      ),
                      child: Slider(
                        value: 0.65,
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
              svDivider(),
              svLabel('Pattern 3: Rating Steps'),
              svBody(
                'For a step selector (1-5 stars), use onlyForDiscrete '
                'so the value indicator only appears for that stepped '
                'slider and stays hidden for any other continuous '
                'slider on the same page.'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: svPrimary, size: 18),
                        const SizedBox(width: 4),
                        const Text('Rating — onlyForDiscrete',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator:
                            ShowValueIndicator.onlyForDiscrete,
                        activeTrackColor: svPrimary,
                        thumbColor: svDark,
                        valueIndicatorColor: svDark,
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white, fontSize: 11),
                      ),
                      child: Slider(
                        value: 3,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: '3',
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── 8. SliderThemeData Integration ───────────────────
          svSection('SliderThemeData Integration',
            children: [
              svBody(
                'ShowValueIndicator is one property in SliderThemeData. '
                'It works together with other properties to customise '
                'the entire slider appearance:'),
              for (final prop in [
                ['showValueIndicator', 'When to show the bubble'],
                ['valueIndicatorColor', 'Bubble background colour'],
                ['valueIndicatorTextStyle', 'Text style inside bubble'],
                ['valueIndicatorShape', 'Shape of the indicator'],
                ['overlayColor', 'Ripple colour when tapped'],
                ['thumbColor', 'Colour of the draggable thumb'],
                ['activeTrackColor', 'Colour of the filled track'],
                ['inactiveTrackColor', 'Colour of the unfilled track'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: BoxDecoration(
                          color: svPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 12, color: svMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 9. Material 2 vs Material 3 ──────────────────────
          svSection('Material 2 vs Material 3 Defaults',
            children: [
              svBody(
                'In Material 2, the default is onlyForDiscrete. '
                'In Material 3 the indicator behaviour remains the same '
                'but styling changes: the indicator uses a rounded '
                'rect shape instead of the paddle shape.'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: svLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text('Material 2',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          const Text('Paddle shape',
                              style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 4),
                          Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: svDark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text('42',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: svLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text('Material 3',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          const Text('Rounded rect',
                              style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 4),
                          Container(
                            width: 44,
                            height: 28,
                            decoration: BoxDecoration(
                              color: svDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: const Text('42',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 10. Accessibility ────────────────────────────────
          svSection('Accessibility Considerations',
            children: [
              svBody(
                'The value indicator primarily provides visual feedback. '
                'Screen readers announce slider values via semantics '
                'regardless of indicator visibility, so hiding the '
                'indicator does NOT remove accessibility information.'),
              for (final tip in [
                'Always provide a semanticFormatterCallback for '
                    'meaningful spoken labels.',
                '"never" is safe for accessibility — semantics '
                    'still announce values.',
                'The indicator adds visual redundancy for sighted '
                    'users; ensure the label text is readable.',
                'High-contrast themes may override indicator colours.',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('→ ',
                          style: TextStyle(
                              color: svPrimary, fontWeight: FontWeight.w700)),
                      Expanded(
                        child: Text(tip,
                            style: TextStyle(fontSize: 12, color: svMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 11. Common Pitfalls ──────────────────────────────
          svSection('Common Pitfalls',
            children: [
              for (final pitfall in [
                {
                  'title': 'Missing label property',
                  'detail':
                      'If Slider.label is null the indicator has nothing '
                      'to display even when the mode allows it.',
                },
                {
                  'title': 'Deprecated .always value',
                  'detail':
                      'ShowValueIndicator.always was deprecated. Use '
                      'onDrag instead, which provides equivalent '
                      'behaviour for showing the indicator on interaction.',
                },
                {
                  'title': 'Theme scope confusion',
                  'detail':
                      'Setting ShowValueIndicator on SliderTheme wrapping '
                      'a single slider is fine, but a top-level ThemeData '
                      'affects every slider in the app.',
                },
                {
                  'title': 'RangeSlider differences',
                  'detail':
                      'RangeSlider shows two indicators (start and end). '
                      'The same enum controls both; you cannot show one '
                      'and hide the other.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: svPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: svDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pitfall['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pitfall['detail']!,
                          style: TextStyle(fontSize: 11, color: svMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 12. Decision Guide ───────────────────────────────
          svSection('Decision Guide',
            children: [
              svBody(
                'Use this flowchart to pick the right mode:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      '1. Does the user need exact numeric feedback?',
                      '   YES → Do both discrete and continuous need it?',
                      '         YES → use "onDrag"',
                      '         NO  → is the slider discrete?',
                      '               YES → use "onlyForDiscrete"',
                      '               NO  → use "onlyForContinuous"',
                      '   NO  → use "never"',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 13. RangeSlider Demo ─────────────────────────────
          svSection('RangeSlider with ShowValueIndicator',
            children: [
              svBody(
                'ShowValueIndicator applies identically to '
                'RangeSlider. Both start and end thumbs show '
                'the indicator based on the same mode:'),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('RangeSlider — onDrag mode',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.onDrag,
                        activeTrackColor: svPrimary,
                        inactiveTrackColor: svAccent.withValues(alpha: 0.3),
                        thumbColor: svDark,
                        valueIndicatorColor: svDark,
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white, fontSize: 11),
                      ),
                      child: RangeSlider(
                        values: const RangeValues(20, 80),
                        min: 0,
                        max: 100,
                        divisions: 20,
                        labels:
                            const RangeLabels('20', '80'),
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: svLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('RangeSlider — never mode',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.never,
                        activeTrackColor: svMuted,
                        inactiveTrackColor: svMuted.withValues(alpha: 0.3),
                        thumbColor: svMuted,
                      ),
                      child: RangeSlider(
                        values: const RangeValues(30, 70),
                        min: 0,
                        max: 100,
                        onChanged: (_) {},
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('No bubbles — track position only.',
                        style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: svMuted)),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. Performance Notes ────────────────────────────
          svSection('Performance Notes',
            children: [
              svBody(
                'The value indicator is painted as an overlay during '
                'user interaction. Performance impact is negligible '
                'but worth understanding:'),
              for (final note in [
                'Indicator rendering happens only during active gestures.',
                '"never" avoids even creating the overlay painter — '
                    'marginally faster for scenarios with many sliders.',
                'Custom valueIndicatorShape can introduce paint cost; '
                    'keep shapes simple.',
                'AnimationController drives the indicator show/hide '
                    'transition at ~200ms by default.',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(
                              color: svDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                      Expanded(
                        child: Text(note,
                            style: TextStyle(
                                fontSize: 12, color: svMuted, height: 1.4)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          svSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'SliderThemeData',
                  'rel': 'Parent theme data that holds this enum',
                },
                {
                  'name': 'Slider',
                  'rel': 'Primary widget affected by this setting',
                },
                {
                  'name': 'RangeSlider',
                  'rel': 'Range variant; same indicator behaviour',
                },
                {
                  'name': 'SliderComponentShape',
                  'rel': 'Base for custom indicator shapes',
                },
                {
                  'name': 'PaddleSliderValueIndicatorShape',
                  'rel': 'M2 paddle-shaped indicator',
                },
                {
                  'name': 'RectangularSliderValueIndicatorShape',
                  'rel': 'M3 rectangular indicator',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: svDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: svMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          svSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: svPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${ShowValueIndicator.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: svDark)),
                            const Text('Enum Values',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: svAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('8',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: svDark)),
                            const Text('Live Sliders',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: svLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('2',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: svDark)),
                            const Text('Range Sliders',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: svLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ShowValueIndicator gives fine-grained control '
                    'over the value bubble on Slider and RangeSlider. '
                    'Choose the right mode to balance visual feedback '
                    'with interface clarity.',
                    style: TextStyle(
                        fontSize: 12, color: svMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: svDark,
            child: Column(
              children: [
                const Text('ShowValueIndicator Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Tangerine/Apricot theme  •  Batch 61  •  '
                  '${ShowValueIndicator.values.length} enum values  •  '
                  '10 live sliders',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
