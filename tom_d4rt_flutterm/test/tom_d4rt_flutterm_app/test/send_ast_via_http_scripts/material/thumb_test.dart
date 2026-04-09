// ignore_for_file: avoid_print
// D4rt deep demo: Thumb — identifies which thumb of a RangeSlider
// the user is interacting with (start or end).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Thumb deep demo executing');
  print('=' * 60);

  for (final v in Thumb.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${Thumb.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const thPrimary = Color(0xFFD84315);   // vermilion
  const thAccent = Color(0xFFFF8A65);    // sunset
  const thLight = Color(0xFFFBE9E7);     // pale sunset
  const thDark = Color(0xFF8C2A0D);      // deep vermilion
  const thSurface = Color(0xFFFFF8F5);
  const thOnSurface = Color(0xFF3E2723);
  const thMuted = Color(0xFF8D6E63);

  // thumb-specific colours
  const thStart = Color(0xFF2E7D32);    // green for start thumb
  const thEnd = Color(0xFF1565C0);      // blue for end thumb

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> thThumbs = [
    {
      'value': 'start',
      'title': 'Start',
      'desc': 'Identifies the lower-value (left in LTR) thumb of a '
          'RangeSlider. This thumb controls the beginning of the '
          'selected range. It is always positioned at or before the '
          'end thumb on the track.',
      'position': 'Left side in LTR, right in RTL',
      'controls': 'Lower bound of the selected range',
      'callback': 'Received as Thumb.start in onChanged callback',
    },
    {
      'value': 'end',
      'title': 'End',
      'desc': 'Identifies the upper-value (right in LTR) thumb of a '
          'RangeSlider. This thumb controls the end of the selected '
          'range. It is always positioned at or after the start thumb.',
      'position': 'Right side in LTR, left in RTL',
      'controls': 'Upper bound of the selected range',
      'callback': 'Received as Thumb.end in onChanged callback',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget thSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: thAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: thPrimary.withValues(alpha: 0.07),
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
                colors: [thPrimary, thDark],
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
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget thLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: thOnSurface)),
    );
  }

  Widget thBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: thMuted, height: 1.5)),
    );
  }

  Widget thChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? thLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: thAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget thDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: thAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Visual thumb circle
  Widget thThumbCircle(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.drag_handle, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: thSurface,
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
                colors: [thDark, thPrimary, thAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thumb',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Identifies which thumb of a RangeSlider the user '
                  'is currently interacting with — start or end.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    thChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    thChip('RangeSlider',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    thChip('interaction',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          thSection('Enum Overview',
            children: [
              thBody(
                'Thumb is a two-value enum used exclusively with '
                'RangeSlider. When the user drags one of the two '
                'thumbs, the callback provides a Thumb value so you '
                'can distinguish which end of the range changed.'),
              thBody(
                'This is essential for logging, analytics, haptics, '
                'and thumb-specific UI updates — for example, showing '
                'a different tooltip format for min vs max.'),
              Wrap(
                children: [
                  for (final v in Thumb.values)
                    thChip(v.name),
                ],
              ),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final t in thThumbs)
            thSection(t['title']!,
              children: [
                thChip('Thumb.${t['value']}'),
                const SizedBox(height: 8),
                thLabel('Description'),
                thBody(t['desc']!),
                thLabel('Position'),
                thBody(t['position']!),
                thLabel('Controls'),
                thBody(t['controls']!),
                thLabel('Callback'),
                thBody(t['callback']!),
              ],
            ),

          // ── 4. Live RangeSlider Demo ─────────────────────────
          thSection('Live RangeSlider with Labelled Thumbs',
            children: [
              thBody(
                'The RangeSlider below shows both thumbs. The start '
                'thumb controls the lower value and the end thumb '
                'controls the upper value:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: thLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    RangeSlider(
                      values: const RangeValues(0.25, 0.75),
                      onChanged: (values) {},
                      activeColor: thPrimary,
                      inactiveColor: thAccent.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        thThumbCircle(thStart, 'START'),
                        const Text('← active range →',
                            style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                        thThumbCircle(thEnd, 'END'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              thBody(
                'Drag either thumb to adjust the range. The Thumb '
                'enum tells you which one moved.'),
            ],
          ),

          // ── 5. Thumb Identification ──────────────────────────
          thSection('Thumb Identification in Callbacks',
            children: [
              thBody(
                'RangeSlider provides a Thumb? parameter in its '
                'onChanged callback. This is null when the range '
                'changes programmatically, or the specific Thumb '
                'value when the user drags:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: thLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'RangeSlider(',
                      '  values: rangeValues,',
                      '  onChanged: (RangeValues values) {',
                      '    // Called when either thumb moves',
                      '    setState(() => rangeValues = values);',
                      '  },',
                      '  onChangeStart: (RangeValues values) {',
                      '    // Called when drag begins',
                      '  },',
                      '  onChangeEnd: (RangeValues values) {',
                      '    // Called when drag ends',
                      '  },',
                      ')',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(line,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 6. RangeSlider Visual Anatomy ────────────────────
          thSection('RangeSlider Visual Anatomy',
            children: [
              thBody(
                'A RangeSlider consists of a track, two thumbs, and '
                'optional value indicators. The Thumb enum identifies '
                'the two draggable circles:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: thAccent.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    // Track visualisation
                    SizedBox(
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Inactive track left
                          Positioned(
                            left: 0,
                            right: 200,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: thAccent.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Active track
                          Positioned(
                            left: 80,
                            right: 80,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: thPrimary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Inactive track right
                          Positioned(
                            left: 200,
                            right: 0,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: thAccent.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Start thumb
                          Positioned(
                            left: 72,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: thStart,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: thStart.withValues(alpha: 0.3),
                                      blurRadius: 4),
                                ],
                              ),
                            ),
                          ),
                          // End thumb
                          Positioned(
                            right: 72,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: thEnd,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: thEnd.withValues(alpha: 0.3),
                                      blurRadius: 4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Inactive\ntrack',
                            style: TextStyle(fontSize: 10, color: thMuted),
                            textAlign: TextAlign.center),
                        Text('Start\n(Thumb.start)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: thStart),
                            textAlign: TextAlign.center),
                        Text('Active\ntrack',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: thPrimary),
                            textAlign: TextAlign.center),
                        Text('End\n(Thumb.end)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: thEnd),
                            textAlign: TextAlign.center),
                        Text('Inactive\ntrack',
                            style: TextStyle(fontSize: 10, color: thMuted),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── 7. Callback Usage ────────────────────────────────
          thSection('Callback Details',
            children: [
              thBody(
                'RangeSlider provides three callbacks. Each receives '
                'the current RangeValues. The Thumb? parameter '
                'appears in the semantics and overlay callbacks:'),
              for (final cb in [
                {
                  'name': 'onChanged',
                  'params': 'RangeValues values',
                  'when': 'Called on every frame while dragging',
                  'note': 'Primary callback — update state here',
                },
                {
                  'name': 'onChangeStart',
                  'params': 'RangeValues values',
                  'when': 'Called once when drag begins',
                  'note': 'Good for logging which thumb was touched',
                },
                {
                  'name': 'onChangeEnd',
                  'params': 'RangeValues values',
                  'when': 'Called once when drag finishes',
                  'note': 'Good for committing final value to backend',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: thLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cb['name']!,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace')),
                      const SizedBox(height: 4),
                      Text('Params: ${cb['params']}',
                          style: TextStyle(fontSize: 11, color: thMuted)),
                      Text('When: ${cb['when']}',
                          style: TextStyle(fontSize: 11, color: thMuted)),
                      Text('Note: ${cb['note']}',
                          style: TextStyle(fontSize: 11, color: thMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 8. SliderThemeData and Thumb Styling ─────────────
          thSection('Thumb-Specific Styling',
            children: [
              thBody(
                'SliderThemeData controls the appearance of thumbs. '
                'For RangeSlider, the inner (overlap) appearance can '
                'also be customized:'),
              for (final prop in [
                ['thumbColor', 'Base colour of both thumbs'],
                ['overlappingShapeStrokeColor', 'Outline when thumbs overlap'],
                ['thumbShape', 'Custom shape for Slider thumb (RoundSliderThumbShape)'],
                ['rangeThumbShape', 'Custom shape for RangeSlider thumbs'],
                ['overlayColor', 'Splash colour on thumb press'],
                ['overlayShape', 'Shape of the press overlay circle'],
                ['valueIndicatorColor', 'Colour of the popup label'],
                ['valueIndicatorShape', 'Shape of the popup label'],
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
                          color: thPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(prop[0],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace')),
                      ),
                      Expanded(
                        child: Text(prop[1],
                            style: TextStyle(fontSize: 11, color: thMuted)),
                      ),
                    ],
                  ),
                ),
              thDivider(),
              thBody(
                'Custom thumb shapes receive a Thumb parameter in '
                'their paint method, allowing you to render start '
                'and end thumbs differently (e.g., different colours '
                'or icons).'),
            ],
          ),

          // ── 9. Use Case Scenarios ────────────────────────────
          thSection('Use Case Scenarios',
            children: [
              for (final scenario in [
                {
                  'name': 'Price Range Filter',
                  'start': 'Minimum price (\$50)',
                  'end': 'Maximum price (\$500)',
                  'range': '0.0 – 1000.0',
                  'icon': Icons.attach_money,
                },
                {
                  'name': 'Date Range Selector',
                  'start': 'Start date (Jan 1)',
                  'end': 'End date (Dec 31)',
                  'range': 'Day 1 – Day 365',
                  'icon': Icons.calendar_today,
                },
                {
                  'name': 'Age Bracket',
                  'start': 'Minimum age (18)',
                  'end': 'Maximum age (65)',
                  'range': '0 – 100',
                  'icon': Icons.person,
                },
                {
                  'name': 'Temperature Range',
                  'start': 'Low threshold (15°C)',
                  'end': 'High threshold (30°C)',
                  'range': '-20 – 50',
                  'icon': Icons.thermostat,
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: thLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: thPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Icon(scenario['icon'] as IconData,
                            color: thPrimary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario['name'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: thStart,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                      'Start: ${scenario['start']}',
                                      style: TextStyle(
                                          fontSize: 11, color: thMuted)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: thEnd,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text('End: ${scenario['end']}',
                                      style: TextStyle(
                                          fontSize: 11, color: thMuted)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              // Live range sliders for scenarios
              thBody('Live RangeSliders for the scenarios above:'),
              for (final pair in [
                {'label': 'Price: \$50 – \$500', 'start': 0.05, 'end': 0.50},
                {'label': 'Age: 18 – 65', 'start': 0.18, 'end': 0.65},
                {'label': 'Temp: 15°C – 30°C', 'start': 0.50, 'end': 0.71},
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: thAccent.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pair['label'] as String,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600)),
                      RangeSlider(
                        values: RangeValues(
                            pair['start'] as double, pair['end'] as double),
                        onChanged: (v) {},
                        activeColor: thPrimary,
                        inactiveColor: thAccent.withValues(alpha: 0.2),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 10. Semantic Labelling ───────────────────────────
          thSection('Semantic Labelling',
            children: [
              thBody(
                'RangeSlider provides semantic labels for both thumbs '
                'to support screen readers:'),
              for (final sem in [
                {
                  'property': 'semanticFormatterCallback',
                  'desc': 'Formats the value into a semantic string for '
                      'screen readers. Called for BOTH thumbs.',
                },
                {
                  'property': 'Slider semantics',
                  'desc': 'Each thumb is an independent accessibility node '
                      'with increase/decrease actions.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: thLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sem['property']!,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace')),
                      const SizedBox(height: 4),
                      Text(sem['desc']!,
                          style: TextStyle(fontSize: 11, color: thMuted)),
                    ],
                  ),
                ),
              thDivider(),
              thBody(
                'Screen readers announce: "Start thumb, 25 percent" '
                'and "End thumb, 75 percent" — making both thumbs '
                'independently accessible.'),
            ],
          ),

          // ── 11. Custom Thumb Shapes ──────────────────────────
          thSection('Custom Thumb Shapes',
            children: [
              thBody(
                'RangeSliderThumbShape allows rendering each thumb '
                'differently based on the Thumb enum:'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: thLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          thThumbCircle(thStart, 'Start'),
                          const SizedBox(height: 8),
                          const Text('Round Shape',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600)),
                          Text('Default circle',
                              style: TextStyle(fontSize: 10, color: thMuted)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: thLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: thEnd,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: thEnd.withValues(alpha: 0.4),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2)),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.drag_handle,
                                color: Colors.white, size: 18),
                          ),
                          const SizedBox(height: 4),
                          Text('END',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: thEnd)),
                          const SizedBox(height: 4),
                          const Text('Square Shape',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600)),
                          Text('Custom rectangle',
                              style: TextStyle(fontSize: 10, color: thMuted)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              thBody(
                'The paint method of RangeSliderThumbShape receives '
                'the Thumb enum value, letting you differentiate '
                'rendering per thumb.'),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          thSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Start exceeding end',
                  'detail':
                      'RangeSlider prevents start from going past end '
                      'and vice versa. If you set initial RangeValues '
                      'where start > end, an assertion error occurs.',
                },
                {
                  'title': 'Ignoring Thumb in callbacks',
                  'detail':
                      'Not using the Thumb parameter means you cannot '
                      'provide thumb-specific feedback like haptics or '
                      'tooltip content.',
                },
                {
                  'title': 'Confusing with Slider',
                  'detail':
                      'A regular Slider has only ONE thumb and does not '
                      'use the Thumb enum at all. Thumb is exclusively '
                      'for RangeSlider.',
                },
                {
                  'title': 'Forgetting min/max validation',
                  'detail':
                      'Programmatic updates must ensure values.start <= '
                      'values.end and both are within min/max bounds.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: thPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: thDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: thMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Guide ───────────────────────────────
          thSection('When to Use RangeSlider vs Two Sliders',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: thLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      'Need a range (min AND max)?',
                      '  YES → Use RangeSlider (with Thumb enum)',
                      '  NO  → Use regular Slider',
                      '',
                      'Should thumbs be able to cross?',
                      '  NO  → RangeSlider enforces this automatically',
                      '  YES → Use two separate Sliders with manual logic',
                      '',
                      'Need discrete steps?',
                      '  → Set divisions on RangeSlider, works with both thumbs',
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

          // ── 14. Range Validation ─────────────────────────────
          thSection('Range Validation Rules',
            children: [
              thBody(
                'RangeSlider enforces these invariants automatically:'),
              for (final rule in [
                'values.start must be >= min',
                'values.end must be <= max',
                'values.start must be <= values.end',
                'If start and end are equal, thumbs overlap',
                'divisions, if set, must be > 0',
                'min must be < max',
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✓ ',
                          style: TextStyle(
                              color: thStart,
                              fontWeight: FontWeight.w700)),
                      Expanded(
                        child: Text(rule,
                            style: TextStyle(fontSize: 12, color: thMuted)),
                      ),
                    ],
                  ),
                ),
              thDivider(),
              thBody(
                'Overlapping thumbs get a special outline stroke '
                '(overlappingShapeStrokeColor) so the user can '
                'distinguish them even when stacked.'),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          thSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'RangeSlider',
                  'rel': 'Primary widget that uses Thumb enum',
                },
                {
                  'name': 'RangeValues',
                  'rel': 'Holds the start and end values of the range',
                },
                {
                  'name': 'RangeLabels',
                  'rel': 'Provides text labels for both thumbs',
                },
                {
                  'name': 'SliderThemeData',
                  'rel': 'Theme for styling slider and range slider',
                },
                {
                  'name': 'RangeSliderThumbShape',
                  'rel': 'Custom thumb rendering with Thumb parameter',
                },
                {
                  'name': 'RangeSliderTrackShape',
                  'rel': 'Custom track rendering for range sliders',
                },
                {
                  'name': 'Slider',
                  'rel': 'Single-thumb slider (no Thumb enum)',
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
                                color: thDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: thMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          thSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: thPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${Thumb.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: thDark)),
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
                          color: thAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('4',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: thDark)),
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
                          color: thLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('16',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: thDark)),
                            const Text('Sections',
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
                    color: thLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Thumb is a simple two-value enum that enables '
                    'precise identification of which RangeSlider thumb '
                    'the user is interacting with — essential for '
                    'analytics, haptics, and custom rendering.',
                    style: TextStyle(
                        fontSize: 12, color: thMuted, height: 1.5),
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
            color: thDark,
            child: Column(
              children: [
                const Text('Thumb Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Vermilion/Sunset theme  •  Batch 62  •  '
                  '${Thumb.values.length} enum values  •  '
                  '4 live RangeSliders',
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
