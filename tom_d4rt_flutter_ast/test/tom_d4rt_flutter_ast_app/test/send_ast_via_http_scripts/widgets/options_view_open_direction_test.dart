// ignore_for_file: avoid_print
// D4rt deep demo: OptionsViewOpenDirection — enum controlling autocomplete dropdown direction
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Saffron / Turmeric ────────────────────────────────────
  const deepSaffron = Color(0xFFE65100);
  const saffron = Color(0xFFEF6C00);
  const turmeric = Color(0xFFF57C00);
  const softSaffron = Color(0xFFFB8C00);
  const lightTurmeric = Color(0xFFFFCC80);
  const paleSaffron = Color(0xFFFFF3E0);
  const whiteSaffron = Color(0xFFFFF9F0);
  const darkSpice = Color(0xFF3E2723);
  const accentDeep = Color(0xFF4A148C);
  const accentTeal = Color(0xFF00695C);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkSpice)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkSpice)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('OptionsViewOpenDirection deep demo executing');
  print('=' * 60);

  print('\n--- What is OptionsViewOpenDirection ---');
  print('Enum with 3 values: up, down, mostSpace');
  print('Controls where autocomplete options appear');
  print('Used by RawAutocomplete and Material Autocomplete');

  print('\n--- Enum values ---');
  for (final v in OptionsViewOpenDirection.values) {
    print('  ${v.name}');
  }

  print('\n--- Behavior ---');
  print('down: options below the text field (default)');
  print('up: options above the text field');
  print('mostSpace: opens where there is more room');
  print('  When tied, mostSpace defaults to down');

  print('\n--- Internal logic ---');
  print('up -> alignAbove = true');
  print('down -> alignAbove = false');
  print('mostSpace -> spaceAbove > spaceBelow ? above : below');

  print('\n${'=' * 60}');
  print('OptionsViewOpenDirection deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSaffron, saffron, turmeric],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.unfold_more, size: 28,
                      color: lightTurmeric),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OptionsViewOpenDirection',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('An enum that controls whether the autocomplete '
                  'options list opens above, below, or in the direction '
                  'with the most available screen space',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('enum', turmeric, Colors.white),
                tag('up', softSaffron, darkSpice),
                tag('down', lightTurmeric, darkSpice),
                tag('mostSpace', paleSaffron, darkSpice),
              ]),
            ],
          ),
        ),

        // ── 2. What is OptionsViewOpenDirection ──────────────────────
        sectionBanner('1 \u00b7 What Is OptionsViewOpenDirection',
            'The enum that positions autocomplete dropdowns',
            deepSaffron, Colors.white),
        noteBox(
          'OptionsViewOpenDirection is an enum introduced to control '
          'the vertical placement of autocomplete options relative to '
          'the text input field. Before this enum existed, options always '
          'opened below. Now you can choose up, down, or let the framework '
          'measure available space and decide automatically.',
          saffron,
          whiteSaffron,
        ),
        dataRow('Type', 'enum OptionsViewOpenDirection', saffron),
        dataRow('Values', 'up, down, mostSpace', deepSaffron),
        dataRow('Default', 'down (options below field)', turmeric),
        dataRow('Used by', 'RawAutocomplete, Autocomplete', accentTeal),
        dataRow('Defined in', 'widgets/autocomplete.dart line 99', darkSpice),
        const SizedBox(height: 14),

        // ── 3. Enum values detail ────────────────────────────────────
        sectionBanner('2 \u00b7 The Three Enum Values',
            'Each value and its behavior',
            saffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final val in [
                ('down', 'Options appear below the text field',
                    'The default value. The options list drops down from '
                    'the bottom edge of the input. Most common and expected '
                    'behavior for dropdowns and comboboxes.',
                    Icons.arrow_downward, saffron),
                ('up', 'Options appear above the text field',
                    'The options list rises up from the top edge of the '
                    'input. Useful when the field is near the bottom of '
                    'the screen (e.g., chat input, bottom sheets).',
                    Icons.arrow_upward, deepSaffron),
                ('mostSpace', 'Opens where there is more room',
                    'The framework measures available space above and below '
                    'the field. Opens in the direction with more room. When '
                    'equal, defaults to down.',
                    Icons.swap_vert, accentDeep),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: val.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: val.$5, width: 4)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(val.$4, size: 24, color: val.$5),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: val.$5,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(val.$1,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace')),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: val.$5)),
                            const SizedBox(height: 4),
                            Text(val.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkSpice)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Visual diagram ────────────────────────────────────────
        sectionBanner('3 \u00b7 Visual Layout',
            'How each direction positions the options view',
            turmeric, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // down diagram
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: saffron.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: saffron),
                  ),
                  child: Column(
                    children: [
                      Text('down',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: saffron)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: saffron,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('TextField',
                            style: TextStyle(
                                color: Colors.white, fontSize: 9)),
                      ),
                      Icon(Icons.arrow_downward, size: 12,
                          color: saffron),
                      Container(
                        width: double.infinity,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: saffron.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: saffron.withValues(alpha: 0.4)),
                        ),
                        child: Text('Options\nList',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: saffron)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // up diagram
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: deepSaffron.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: deepSaffron),
                  ),
                  child: Column(
                    children: [
                      Text('up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: deepSaffron)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: deepSaffron.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: deepSaffron
                                  .withValues(alpha: 0.4)),
                        ),
                        child: Text('Options\nList',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: deepSaffron)),
                      ),
                      Icon(Icons.arrow_upward, size: 12,
                          color: deepSaffron),
                      Container(
                        width: double.infinity,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: deepSaffron,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('TextField',
                            style: TextStyle(
                                color: Colors.white, fontSize: 9)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // mostSpace diagram
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentDeep.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentDeep),
                  ),
                  child: Column(
                    children: [
                      Text('mostSpace',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentDeep)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accentDeep.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: accentDeep
                                  .withValues(alpha: 0.4)),
                        ),
                        child: Text('Options?',
                            style: TextStyle(
                                fontSize: 9,
                                color: accentDeep)),
                      ),
                      Icon(Icons.swap_vert, size: 12,
                          color: accentDeep),
                      Container(
                        width: double.infinity,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accentDeep,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('TextField',
                            style: TextStyle(
                                color: Colors.white, fontSize: 9)),
                      ),
                      Icon(Icons.swap_vert, size: 12,
                          color: accentDeep),
                      Container(
                        width: double.infinity,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accentDeep.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: accentDeep
                                  .withValues(alpha: 0.4)),
                        ),
                        child: Text('Options?',
                            style: TextStyle(
                                fontSize: 9,
                                color: accentDeep)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. SDK usage in RawAutocomplete ──────────────────────────
        sectionBanner('4 \u00b7 Usage in RawAutocomplete',
            'How the enum is consumed by the widget',
            deepSaffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepSaffron.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepSaffron.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'RawAutocomplete<String>(\n'
                    '  optionsViewOpenDirection:\n'
                    '      OptionsViewOpenDirection.up,\n'
                    '  optionsBuilder: (text) {\n'
                    '    return options.where(\n'
                    '      (o) => o.contains(text.text));\n'
                    '  },\n'
                    '  fieldViewBuilder: (context,\n'
                    '      controller, focusNode, onSubmit) {\n'
                    '    return TextField(\n'
                    '      controller: controller,\n'
                    '      focusNode: focusNode,\n'
                    '    );\n'
                    '  },\n'
                    '  optionsViewBuilder: ...\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepSaffron)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'The optionsViewOpenDirection parameter is optional and '
                'defaults to OptionsViewOpenDirection.down. Pass .up or '
                '.mostSpace to change the direction.',
                deepSaffron,
                paleSaffron,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Internal alignment logic ──────────────────────────────
        sectionBanner('5 \u00b7 Internal Alignment Logic',
            'How the SDK translates enum to positioning',
            saffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final logic in [
                ('OptionsViewOpenDirection.up',
                    'alignAbove = true',
                    'Options anchored to top edge of text field, expanding upward.',
                    deepSaffron),
                ('OptionsViewOpenDirection.down',
                    'alignAbove = false',
                    'Options anchored to bottom edge of text field, expanding downward.',
                    saffron),
                ('OptionsViewOpenDirection.mostSpace',
                    'alignAbove = spaceAbove > spaceBelow',
                    'Measures pixel space above and below the field. Picks '
                    'the direction with more room. Ties go to down.',
                    accentDeep),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: logic.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: logic.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(logic.$1,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: logic.$4)),
                      Text('\u2192 ${logic.$2}',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: logic.$4
                                  .withValues(alpha: 0.7))),
                      const SizedBox(height: 2),
                      Text(logic.$3,
                          style: TextStyle(
                              fontSize: 11, color: darkSpice)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Live demo: Autocomplete.down ──────────────────────────
        sectionBanner('6 \u00b7 Live Demo: Direction \u2192 Down',
            'Default behavior — options below the field',
            turmeric, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTurmeric),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: saffron.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: saffron),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_downward, size: 14,
                        color: saffron),
                    const SizedBox(width: 6),
                    Text('direction: down (type "a" to see options)',
                        style: TextStyle(
                            fontSize: 10, color: darkSpice)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Autocomplete<String>(
                optionsViewOpenDirection:
                    OptionsViewOpenDirection.down,
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return [
                    'Apple', 'Avocado', 'Apricot',
                    'Acai', 'Almond',
                  ].where((o) => o.toLowerCase().contains(
                      textEditingValue.text.toLowerCase()));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Live demo: Autocomplete.up ────────────────────────────
        sectionBanner('7 \u00b7 Live Demo: Direction \u2192 Up',
            'Options appear above the field',
            deepSaffron, Colors.white),
        const SizedBox(height: 100),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTurmeric),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: deepSaffron.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: deepSaffron),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 14,
                        color: deepSaffron),
                    const SizedBox(width: 6),
                    Text('direction: up (type "b" to see options)',
                        style: TextStyle(
                            fontSize: 10, color: darkSpice)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Autocomplete<String>(
                optionsViewOpenDirection:
                    OptionsViewOpenDirection.up,
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return [
                    'Banana', 'Blueberry', 'Blackberry',
                    'Boysenberry', 'Breadfruit',
                  ].where((o) => o.toLowerCase().contains(
                      textEditingValue.text.toLowerCase()));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. mostSpace behavior details ────────────────────────────
        sectionBanner('8 \u00b7 mostSpace Deep Dive',
            'How the framework measures and decides',
            accentDeep, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (var step = 0; step < 4; step++)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: [turmeric, saffron, deepSaffron, accentDeep][step]
                        .withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: [turmeric, saffron, deepSaffron, accentDeep][step]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: [turmeric, saffron, deepSaffron, accentDeep][step],
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${step + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text([
                          'Get the field\u0027s position in the overlay (via RenderBox)',
                          'Calculate spaceAbove = field.top in overlay',
                          'Calculate spaceBelow = overlay.height - field.bottom',
                          'if spaceAbove > spaceBelow: align above, else: align below',
                        ][step],
                            style: TextStyle(
                                fontSize: 11, color: darkSpice)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'The "equal space" tie-breaker favors down. This matches '
                'user expectations — most people expect dropdowns to open '
                'downward unless forced upward by lack of space.',
                accentDeep,
                paleSaffron,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Material Autocomplete vs RawAutocomplete ─────────────
        sectionBanner('9 \u00b7 Material vs Raw Autocomplete',
            'Both widgets accept OptionsViewOpenDirection',
            saffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: saffron.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: saffron, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.auto_awesome, size: 24,
                          color: saffron),
                      const SizedBox(height: 4),
                      Text('Autocomplete',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: saffron)),
                      const SizedBox(height: 6),
                      Text('Material design.\n'
                          'Built-in field.\n'
                          'Built-in options.\n'
                          'Simpler API.\n'
                          'Uses Material theme.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkSpice)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentDeep.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentDeep, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.build, size: 24,
                          color: accentDeep),
                      const SizedBox(height: 4),
                      Text('RawAutocomplete',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: accentDeep)),
                      const SizedBox(height: 6),
                      Text('No Material dep.\n'
                          'Custom field view.\n'
                          'Custom options view.\n'
                          'Full control.\n'
                          'Theme-agnostic.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkSpice)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        noteBox(
          'Both pass the direction to the same positioning logic on '
          '_AutocompleteCallbackAction. The only difference is which '
          'views are built — Material provides defaults, Raw requires '
          'builders.',
          saffron,
          paleSaffron,
        ),
        const SizedBox(height: 14),

        // ── 11. Common use cases ─────────────────────────────────────
        sectionBanner('10 \u00b7 Common Use Cases',
            'When to choose each direction value',
            turmeric, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final useCase in [
                ('Search bar at top', 'down',
                    'Plenty of space below for results.',
                    Icons.search, saffron),
                ('Chat message input', 'up',
                    'Input at bottom of screen — options must go up.',
                    Icons.chat, deepSaffron),
                ('Form fields anywhere', 'mostSpace',
                    'Let the framework decide based on scroll position.',
                    Icons.dynamic_form, accentDeep),
                ('Bottom sheet search', 'up',
                    'Sheet leaves no room below — options must go up.',
                    Icons.expand_less, turmeric),
                ('AppBar search field', 'down',
                    'Below the app bar is the natural expansion direction.',
                    Icons.menu, softSaffron),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: useCase.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: useCase.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(useCase.$4, size: 18,
                          color: useCase.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(useCase.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: useCase.$5)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: useCase.$5,
                                    borderRadius:
                                        BorderRadius.circular(4),
                                  ),
                                  child: Text(useCase.$2,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight:
                                              FontWeight.bold)),
                                ),
                              ],
                            ),
                            Text(useCase.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkSpice)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Enum properties ──────────────────────────────────────
        sectionBanner('11 \u00b7 Enum Properties',
            'Standard Dart enum features on OptionsViewOpenDirection',
            deepSaffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final prop in [
                ('.values', 'List of all enum values: [up, down, mostSpace]',
                    saffron),
                ('.name', 'String name of the value: "up", "down", "mostSpace"',
                    deepSaffron),
                ('.index', 'Integer index: up=0, down=1, mostSpace=2',
                    turmeric),
                ('switch()', 'Exhaustive pattern matching on all 3 values',
                    accentDeep),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: prop.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: prop.$3, width: 2)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(prop.$1,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: prop.$3)),
                      ),
                      Expanded(
                        child: Text(prop.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkSpice)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Live demo: mostSpace ─────────────────────────────────
        sectionBanner('12 \u00b7 Live Demo: Direction \u2192 mostSpace',
            'Framework decides based on available space',
            accentDeep, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightTurmeric),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentDeep.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accentDeep),
                ),
                child: Row(
                  children: [
                    Icon(Icons.swap_vert, size: 14,
                        color: accentDeep),
                    const SizedBox(width: 6),
                    Text('direction: mostSpace (type "c" to see options)',
                        style: TextStyle(
                            fontSize: 10, color: darkSpice)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Autocomplete<String>(
                optionsViewOpenDirection:
                    OptionsViewOpenDirection.mostSpace,
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return [
                    'Cherry', 'Coconut', 'Cranberry',
                    'Cantaloupe', 'Clementine',
                  ].where((o) => o.toLowerCase().contains(
                      textEditingValue.text.toLowerCase()));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Accessibility impact ─────────────────────────────────
        sectionBanner('13 \u00b7 Accessibility Impact',
            'How direction affects screen readers and keyboard navigation',
            saffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSaffron,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final a11y in [
                ('Screen readers',
                    'Options are announced regardless of direction — the '
                    'visual position does not affect semantic ordering.',
                    Icons.hearing, saffron),
                ('Keyboard navigation',
                    'Arrow keys navigate the options list in logical order. '
                    'Direction only affects visual placement, not key behavior.',
                    Icons.keyboard, deepSaffron),
                ('Focus management',
                    'Focus moves to the options list after typing begins. '
                    'The direction does not change the focus chain order.',
                    Icons.center_focus_strong, turmeric),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: a11y.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: a11y.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(a11y.$3, size: 18, color: a11y.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a11y.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: a11y.$4)),
                            Text(a11y.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkSpice)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Migration note ───────────────────────────────────────
        sectionBanner('14 \u00b7 Migration Note',
            'Upgrading from older autocomplete without direction support',
            turmeric, Colors.white),
        noteBox(
          'Before OptionsViewOpenDirection existed, options always opened '
          'downward. The enum was added as a non-breaking change with '
          'OptionsViewOpenDirection.down as the default. Existing code '
          'continues to work without modification — you only need to opt '
          'in to .up or .mostSpace when needed.',
          turmeric,
          whiteSaffron,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: turmeric.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
              '// Before:\n'
              'Autocomplete<String>(\n'
              '  optionsBuilder: ...,\n'
              ');\n'
              '\n'
              '// After (opt-in to new direction):\n'
              'Autocomplete<String>(\n'
              '  optionsViewOpenDirection:\n'
              '      OptionsViewOpenDirection.mostSpace,\n'
              '  optionsBuilder: ...,\n'
              ');',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: darkSpice)),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepSaffron, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSaffron, saffron],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Enum with three values: up, down, mostSpace',
                'Controls vertical placement of autocomplete options',
                'Default is down — options appear below the field',
                'up — options appear above (for bottom-positioned inputs)',
                'mostSpace — framework measures and picks best direction',
                'When tied, mostSpace defaults to down',
                'Used by both Autocomplete and RawAutocomplete',
                'Visual-only change — does not affect semantic order',
                'Non-breaking addition — existing code unaffected',
                'Best practice: use mostSpace for adaptive layouts',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightTurmeric,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
