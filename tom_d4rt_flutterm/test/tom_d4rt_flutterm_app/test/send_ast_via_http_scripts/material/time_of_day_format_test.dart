// ignore_for_file: avoid_print
// D4rt deep demo: TimeOfDayFormat — locale-specific time display formats
// used by MaterialLocalizations to format TimeOfDay.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDayFormat deep demo executing');
  print('=' * 60);

  for (final v in TimeOfDayFormat.values) {
    print('  ${v.name} (index ${v.index})');
  }
  print('Total values: ${TimeOfDayFormat.values.length}');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const tfPrimary = Color(0xFF00897B);   // jade
  const tfAccent = Color(0xFF80CBC4);    // mint
  const tfLight = Color(0xFFE0F2F1);     // pale mint
  const tfDark = Color(0xFF004D40);      // deep jade
  const tfSurface = Color(0xFFF5FFFD);
  const tfOnSurface = Color(0xFF1B3A34);
  const tfMuted = Color(0xFF607D75);

  // time-period colours
  const tfAm = Color(0xFFFFA726);       // warm amber for AM
  const tfPm = Color(0xFF5C6BC0);       // cool indigo for PM

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> tfFormats = [
    {
      'value': 'h_colon_mm_space_a',
      'title': 'h:mm a',
      'example': '2:30 PM',
      'clock': '12-hour',
      'separator': ': (colon)',
      'period': 'After time',
      'locales': 'US English, most English-speaking locales',
      'desc': 'The most common 12-hour format. Hours without leading '
          'zero, colon separator, then AM/PM with a space.',
    },
    {
      'value': 'a_space_h_colon_mm',
      'title': 'a h:mm',
      'example': 'PM 2:30',
      'clock': '12-hour',
      'separator': ': (colon)',
      'period': 'Before time',
      'locales': 'Korean, some Asian locales',
      'desc': 'The AM/PM period appears before the time, not after it. '
          'Common in languages where time qualifiers precede the value.',
    },
    {
      'value': 'HH_colon_mm',
      'title': 'HH:mm',
      'example': '14:30',
      'clock': '24-hour',
      'separator': ': (colon)',
      'period': 'None',
      'locales': 'Most European locales, formal contexts',
      'desc': 'Standard 24-hour format with leading zero and colon '
          'separator. The most widely used 24-hour notation worldwide.',
    },
    {
      'value': 'HH_dot_mm',
      'title': 'HH.mm',
      'example': '14.30',
      'clock': '24-hour',
      'separator': '. (dot)',
      'period': 'None',
      'locales': 'Finnish, Indonesian, some Nordic locales',
      'desc': 'Like HH:mm but uses a dot instead of a colon as the '
          'separator. Regionally preferred in certain European countries.',
    },
    {
      'value': 'frenchCanadian',
      'title': 'HH h mm',
      'example': '14 h 30',
      'clock': '24-hour',
      'separator': 'h (word)',
      'period': 'None',
      'locales': 'French Canadian (fr_CA)',
      'desc': 'Uses the letter "h" between hours and minutes with '
          'spaces. Uniquely Canadian French convention distinct from '
          'European French which uses HH:mm.',
    },
  ];

  // Sample times for live display
  final List<Map<String, dynamic>> tfSampleTimes = [
    {'hour': 6, 'minute': 15, 'label': 'Early morning'},
    {'hour': 12, 'minute': 0, 'label': 'Noon'},
    {'hour': 14, 'minute': 30, 'label': 'Afternoon'},
    {'hour': 23, 'minute': 45, 'label': 'Late night'},
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget tfSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tfAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: tfPrimary.withValues(alpha: 0.07),
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
                colors: [tfPrimary, tfDark],
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

  Widget tfLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tfOnSurface)),
    );
  }

  Widget tfBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: tfMuted, height: 1.5)),
    );
  }

  Widget tfChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? tfLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tfAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  // Format a time given an hour, minute, and format
  String tfFormatTime(int hour, int minute, String formatName) {
    String pad2(int n) => n.toString().padLeft(2, '0');
    final h12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    switch (formatName) {
      case 'h_colon_mm_space_a':
        return '$h12:${pad2(minute)} $period';
      case 'a_space_h_colon_mm':
        return '$period $h12:${pad2(minute)}';
      case 'HH_colon_mm':
        return '${pad2(hour)}:${pad2(minute)}';
      case 'HH_dot_mm':
        return '${pad2(hour)}.${pad2(minute)}';
      case 'frenchCanadian':
        return '${pad2(hour)} h ${pad2(minute)}';
      default:
        return '${pad2(hour)}:${pad2(minute)}';
    }
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: tfSurface,
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
                colors: [tfDark, tfPrimary, tfAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TimeOfDayFormat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Locale-specific format patterns for displaying '
                  'time values — controlling separator style, '
                  'hour notation, and AM/PM placement.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    tfChip('enum', bg: Colors.white.withValues(alpha: 0.2)),
                    tfChip('locale', bg: Colors.white.withValues(alpha: 0.2)),
                    tfChip('formatting',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Enum Overview ─────────────────────────────────
          tfSection('Enum Overview',
            children: [
              tfBody(
                'TimeOfDayFormat defines how a TimeOfDay value is '
                'rendered as a string. It controls three aspects: '
                'whether to use 12-hour or 24-hour notation, what '
                'character separates hours from minutes, and where '
                'the AM/PM indicator appears (if at all).'),
              tfBody(
                'MaterialLocalizations selects the appropriate format '
                'based on the current locale. Custom localizations '
                'can override this to match regional conventions.'),
              Wrap(
                children: [
                  for (final v in TimeOfDayFormat.values)
                    tfChip(v.name),
                ],
              ),
              const SizedBox(height: 8),
              tfBody(
                '${TimeOfDayFormat.values.length} values: '
                '2 twelve-hour formats, 3 twenty-four-hour formats.'),
            ],
          ),

          // ── 3. Individual Value Cards ────────────────────────
          for (final f in tfFormats)
            tfSection(f['title']!,
              children: [
                Row(
                  children: [
                    tfChip(f['value']!),
                    const SizedBox(width: 6),
                    tfChip(f['clock']!,
                        bg: f['clock'] == '12-hour'
                            ? tfAm.withValues(alpha: 0.15)
                            : tfPrimary.withValues(alpha: 0.1)),
                  ],
                ),
                const SizedBox(height: 10),
                // Large example display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: tfLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(f['example']!,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: tfDark,
                            fontFamily: 'monospace')),
                  ),
                ),
                const SizedBox(height: 10),
                tfBody(f['desc']!),
                tfLabel('Separator'),
                tfBody(f['separator']!),
                tfLabel('AM/PM Position'),
                tfBody(f['period']!),
                tfLabel('Common Locales'),
                tfBody(f['locales']!),
              ],
            ),

          // ── 4. Live Format Comparison ────────────────────────
          tfSection('Live Format Comparison',
            children: [
              tfBody(
                'The same four times displayed in all five formats:'),
              SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                      color: tfAccent.withValues(alpha: 0.3), width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                  },
                  children: [
                    // Header row
                    TableRow(
                      decoration: BoxDecoration(color: tfPrimary),
                      children: [
                        for (final h in [
                          'Format', '06:15', '12:00', '14:30', '23:45'
                        ])
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(h,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center),
                          ),
                      ],
                    ),
                    // Data rows
                    for (final f in tfFormats)
                      TableRow(
                        decoration: BoxDecoration(
                          color: tfFormats.indexOf(f).isEven
                              ? tfLight
                              : Colors.white,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(f['title']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ),
                          for (final t in tfSampleTimes)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                tfFormatTime(
                                    t['hour'] as int,
                                    t['minute'] as int,
                                    f['value']!),
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: tfDark),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 5. 12-Hour vs 24-Hour Comparison ────────────────
          tfSection('12-Hour vs 24-Hour Clock',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tfAm.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: tfAm.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.access_time, color: tfAm, size: 28),
                          const SizedBox(height: 6),
                          const Text('12-Hour',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final f in tfFormats.where(
                              (f) => f['clock'] == '12-hour'))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(f['title']!,
                                  style: TextStyle(
                                      fontSize: 11, color: tfMuted)),
                            ),
                          const SizedBox(height: 6),
                          tfBody('Uses AM/PM period indicator. '
                              'Hours range from 1–12.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tfPrimary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: tfPrimary.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.schedule, color: tfPrimary, size: 28),
                          const SizedBox(height: 6),
                          const Text('24-Hour',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          for (final f in tfFormats.where(
                              (f) => f['clock'] == '24-hour'))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(f['title']!,
                                  style: TextStyle(
                                      fontSize: 11, color: tfMuted)),
                            ),
                          const SizedBox(height: 6),
                          tfBody('No AM/PM. Hours range from '
                              '0–23 with leading zero.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 6. Locale Mapping ────────────────────────────────
          tfSection('Locale-to-Format Mapping',
            children: [
              tfBody(
                'MaterialLocalizations returns the format for the '
                'current locale. Here are common mappings:'),
              for (final mapping in [
                {'locale': 'en_US', 'format': 'h:mm a', 'example': '2:30 PM'},
                {'locale': 'en_GB', 'format': 'HH:mm', 'example': '14:30'},
                {'locale': 'ko_KR', 'format': 'a h:mm', 'example': 'PM 2:30'},
                {'locale': 'fi_FI', 'format': 'HH.mm', 'example': '14.30'},
                {'locale': 'fr_CA', 'format': 'HH h mm', 'example': '14 h 30'},
                {'locale': 'de_DE', 'format': 'HH:mm', 'example': '14:30'},
                {'locale': 'ja_JP', 'format': 'HH:mm', 'example': '14:30'},
                {'locale': 'fr_FR', 'format': 'HH:mm', 'example': '14:30'},
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(mapping['locale']!,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace')),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(mapping['format']!,
                            style: TextStyle(
                                fontSize: 11,
                                color: tfMuted,
                                fontFamily: 'monospace')),
                      ),
                      Text(mapping['example']!,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: tfDark)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 7. Separator Styles ──────────────────────────────
          tfSection('Separator Comparison',
            children: [
              tfBody(
                'Three separator styles exist across the five formats:'),
              for (final sep in [
                {
                  'symbol': ':',
                  'name': 'Colon',
                  'formats': 'h:mm a, a h:mm, HH:mm',
                  'icon': Icons.more_vert,
                },
                {
                  'symbol': '.',
                  'name': 'Dot',
                  'formats': 'HH.mm',
                  'icon': Icons.fiber_manual_record,
                },
                {
                  'symbol': ' h ',
                  'name': 'Letter h',
                  'formats': 'HH h mm',
                  'icon': Icons.text_fields,
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: tfLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: tfPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(sep['symbol'] as String,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: tfDark)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sep['name'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            Text('Used by: ${sep['formats']}',
                                style: TextStyle(
                                    fontSize: 11, color: tfMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 8. MaterialLocalizations Integration ─────────────
          tfSection('MaterialLocalizations Integration',
            children: [
              tfBody(
                'TimeOfDayFormat is returned by the '
                'MaterialLocalizations.timeOfDayFormat() method. '
                'The time picker and other Material widgets use '
                'this to decide how to render times.'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tfLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'final localizations =',
                      '    MaterialLocalizations.of(context);',
                      '',
                      '// Get the format for current locale',
                      'final format =',
                      '    localizations.timeOfDayFormat();',
                      '',
                      '// Can request 24-hour explicitly',
                      'final format24 =',
                      '    localizations.timeOfDayFormat(',
                      '      alwaysUse24HourFormat: true,',
                      '    );',
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
              const SizedBox(height: 10),
              tfBody(
                'The alwaysUse24HourFormat parameter overrides the '
                'locale default when the user has enabled 24-hour '
                'time in their device settings.'),
            ],
          ),

          // ── 9. Time Picker Behaviour ─────────────────────────
          tfSection('Time Picker Behaviour',
            children: [
              tfBody(
                'The TimePicker adapts its UI based on the format. '
                'Here is how each format category changes the picker:'),
              for (final beh in [
                {
                  'format': '12-hour (h:mm a / a h:mm)',
                  'dial': 'Shows 1-12 numbers, AM/PM toggle visible',
                  'input': 'Text field with AM/PM dropdown',
                  'note': 'Most familiar to US English users',
                },
                {
                  'format': '24-hour (HH:mm / HH.mm)',
                  'dial': 'Shows 0-23 numbers, no AM/PM toggle',
                  'input': 'Text field accepts 0-23 for hour',
                  'note': 'No period indicator needed',
                },
                {
                  'format': 'French Canadian (HH h mm)',
                  'dial': 'Same as 24-hour with adapted labels',
                  'input': 'Uses "h" as separator in display',
                  'note': 'Unique French Canadian convention',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tfLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(beh['format']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text('Dial: ${beh['dial']}',
                          style: TextStyle(fontSize: 11, color: tfMuted)),
                      Text('Input: ${beh['input']}',
                          style: TextStyle(fontSize: 11, color: tfMuted)),
                      Text('Note: ${beh['note']}',
                          style: TextStyle(fontSize: 11, color: tfMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 10. Visual Clock Faces ───────────────────────────
          tfSection('Visual Clock Faces',
            children: [
              tfBody(
                'A visual comparison of how 14:30 appears on a '
                'clock face in 12-hour vs 24-hour format:'),
              Row(
                children: [
                  // 12-hour clock
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tfAm.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: tfAm.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: tfAm, width: 3),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: const Text('2:30',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'monospace')),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: tfPm,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('PM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(height: 4),
                          Text('12-hour',
                              style: TextStyle(
                                  fontSize: 10, color: tfMuted)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 24-hour clock
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tfPrimary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: tfPrimary.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: tfPrimary, width: 3),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: const Text('14:30',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'monospace')),
                          ),
                          const SizedBox(height: 6),
                          const Text('No period needed',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic)),
                          const SizedBox(height: 4),
                          Text('24-hour',
                              style: TextStyle(
                                  fontSize: 10, color: tfMuted)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 11. Device Settings Integration ──────────────────
          tfSection('Device Settings Integration',
            children: [
              tfBody(
                'MediaQuery.alwaysUse24HourFormat reflects the device '
                'setting. MaterialLocalizations uses this to override '
                'the locale default:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tfLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      '// Check device-level preference',
                      'final use24hr =',
                      '  MediaQuery.of(context)',
                      '      .alwaysUse24HourFormat;',
                      '',
                      '// Localizations respect this:',
                      '// If use24hr is true AND locale is en_US,',
                      '// format switches from h:mm a → HH:mm',
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
              const SizedBox(height: 10),
              for (final platform in [
                {'name': 'iOS', 'path': 'Settings → General → Date & Time'},
                {'name': 'Android', 'path': 'Settings → System → Date & Time'},
                {'name': 'Web', 'path': 'navigator.language + Intl API'},
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(platform['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: Text(platform['path']!,
                            style: TextStyle(
                                fontSize: 11, color: tfMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          tfSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Hardcoding format',
                  'detail':
                      'Never hardcode a format string. Always use '
                      'MaterialLocalizations.timeOfDayFormat() to '
                      'respect the user locale and device settings.',
                },
                {
                  'title': 'Ignoring alwaysUse24HourFormat',
                  'detail':
                      'Device settings can override locale defaults. '
                      'A US locale user may still prefer 24-hour time. '
                      'Use the parameter in timeOfDayFormat().',
                },
                {
                  'title': 'Confusing frenchCanadian with fr_FR',
                  'detail':
                      'The French Canadian format (HH h mm) is distinct '
                      'from European French (HH:mm). They share a '
                      'language but different time conventions.',
                },
                {
                  'title': 'Not handling midnight/noon',
                  'detail':
                      'In 12-hour format, midnight is 12:00 AM and noon '
                      'is 12:00 PM. Custom formatters often get this wrong.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: tfAm.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: tfAm, size: 16),
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
                          style: TextStyle(fontSize: 11, color: tfMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Custom Localization ──────────────────────────
          tfSection('Custom Localization Override',
            children: [
              tfBody(
                'To implement a custom time format for an unsupported '
                'locale, extend MaterialLocalizations and override '
                'timeOfDayFormat():'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tfLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'class MyLocalizations',
                      '    extends DefaultMaterialLocalizations {',
                      '  @override',
                      '  TimeOfDayFormat timeOfDayFormat({',
                      '    bool alwaysUse24HourFormat = false,',
                      '  }) {',
                      '    if (alwaysUse24HourFormat) {',
                      '      return TimeOfDayFormat.HH_dot_mm;',
                      '    }',
                      '    return TimeOfDayFormat',
                      '        .h_colon_mm_space_a;',
                      '  }',
                      '}',
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

          // ── 14. Format Decision Guide ────────────────────────
          tfSection('Format Decision Guide',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tfLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      'Is user locale known?',
                      '  YES → Use MaterialLocalizations automatically',
                      '  NO  → Default to h:mm a (most universal)',
                      '',
                      'Does device prefer 24-hour?',
                      '  YES → timeOfDayFormat(alwaysUse24HourFormat:true)',
                      '  NO  → Use locale default',
                      '',
                      'Is locale French Canadian?',
                      '  YES → frenchCanadian format (HH h mm)',
                      '  NO  → Check other locale mappings',
                      '',
                      'Need a custom separator?',
                      '  → Override MaterialLocalizations',
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

          // ── 15. Related APIs ─────────────────────────────────
          tfSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'TimeOfDay',
                  'rel': 'The time class that gets formatted',
                },
                {
                  'name': 'MaterialLocalizations',
                  'rel': 'Returns TimeOfDayFormat for current locale',
                },
                {
                  'name': 'showTimePicker',
                  'rel': 'Dialog that uses format for display',
                },
                {
                  'name': 'TimePickerEntryMode',
                  'rel': 'Controls picker input method (dial/text)',
                },
                {
                  'name': 'MediaQuery',
                  'rel': 'Provides alwaysUse24HourFormat setting',
                },
                {
                  'name': 'DateFormat (intl)',
                  'rel': 'More powerful date/time formatting',
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
                                color: tfDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: tfMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          tfSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tfPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                                '${TimeOfDayFormat.values.length}',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tfDark)),
                            const Text('Formats',
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
                          color: tfAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('3',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tfDark)),
                            const Text('Separators',
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
                          color: tfLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('16',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: tfDark)),
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
                    color: tfLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TimeOfDayFormat controls locale-specific time '
                    'display — supporting 12/24 hour clocks, three '
                    'separator styles, and AM/PM placement variations '
                    'for international audiences.',
                    style: TextStyle(
                        fontSize: 12, color: tfMuted, height: 1.5),
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
            color: tfDark,
            child: Column(
              children: [
                const Text('TimeOfDayFormat Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Jade/Mint theme  •  Batch 62  •  '
                  '${TimeOfDayFormat.values.length} format values  •  '
                  '20+ time examples',
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
