// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// Pure-Dart TimeOfDayFormat helpers.
//
// TimeOfDayFormat values, paired with the ICU pattern from
// flutter/lib/src/material/time.dart:
//
//   HH_colon_mm        -> "HH:mm"        (24h, zero-padded)
//   HH_dot_mm          -> "HH.mm"        (24h, zero-padded, dot separator)
//   frenchCanadian     -> "HH 'h' mm"    (24h, zero-padded, "h" separator)
//   H_colon_mm         -> "H:mm"         (24h, no padding)
//   h_colon_mm_space_a -> "h:mm a"       (12h, no padding, day-period after)
//   a_space_h_colon_mm -> "a h:mm"       (12h, no padding, day-period before)
//
// Real Flutter resolves these via MaterialLocalizations.formatTimeOfDay,
// which requires a real localization context. The harness here is a
// hand-rolled mirror of the same semantics so the demo can render time
// labels without bringing in MaterialLocalizations.
// ----------------------------------------------------------------------------

String _two(int v) => v.toString().padLeft(2, '0');

String _formatMinute(TimeOfDay t) => _two(t.minute);

String _amPm(TimeOfDay t) => t.hour < 12 ? 'AM' : 'PM';

int _twelveHour(TimeOfDay t) {
  final h = t.hour % 12;
  return h == 0 ? 12 : h;
}

String formatTime(TimeOfDay t, TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
      return '${_two(t.hour)}:${_formatMinute(t)}';
    case TimeOfDayFormat.HH_dot_mm:
      return '${_two(t.hour)}.${_formatMinute(t)}';
    case TimeOfDayFormat.frenchCanadian:
      return '${_two(t.hour)} h ${_formatMinute(t)}';
    case TimeOfDayFormat.H_colon_mm:
      return '${t.hour}:${_formatMinute(t)}';
    case TimeOfDayFormat.h_colon_mm_space_a:
      return '${_twelveHour(t)}:${_formatMinute(t)} ${_amPm(t)}';
    case TimeOfDayFormat.a_space_h_colon_mm:
      return '${_amPm(t)} ${_twelveHour(t)}:${_formatMinute(t)}';
  }
}

String _icuPattern(TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
      return 'HH:mm';
    case TimeOfDayFormat.HH_dot_mm:
      return 'HH.mm';
    case TimeOfDayFormat.frenchCanadian:
      return "HH 'h' mm";
    case TimeOfDayFormat.H_colon_mm:
      return 'H:mm';
    case TimeOfDayFormat.h_colon_mm_space_a:
      return 'h:mm a';
    case TimeOfDayFormat.a_space_h_colon_mm:
      return 'a h:mm';
  }
}

String _describeFormat(TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
      return '24-hour, zero-padded, colon separator. Most common European '
          'pattern.';
    case TimeOfDayFormat.HH_dot_mm:
      return '24-hour, zero-padded, dot separator. Used in some Nordic and '
          'Central-European locales.';
    case TimeOfDayFormat.frenchCanadian:
      return "24-hour, zero-padded, separated by the letter 'h'. Used in "
          "Canadian French.";
    case TimeOfDayFormat.H_colon_mm:
      return '24-hour, no padding, colon separator. Common in East-Asian '
          'locales preferring narrow digits.';
    case TimeOfDayFormat.h_colon_mm_space_a:
      return '12-hour, no padding, with day period (AM/PM) trailing. The '
          'classic en_US-style pattern.';
    case TimeOfDayFormat.a_space_h_colon_mm:
      return '12-hour, no padding, with day period (AM/PM) leading. Used in '
          'Korean and some other locales where the day period precedes.';
  }
}

String _whenItApplies(TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
      return 'en_GB, fr_FR, de_DE, es_ES, it_IT, pt_PT, ru_RU, and many more.';
    case TimeOfDayFormat.HH_dot_mm:
      return 'pl_PL, fi_FI and a handful of locales using the dot separator.';
    case TimeOfDayFormat.frenchCanadian:
      return 'fr_CA — the only locale that uses this pattern by default.';
    case TimeOfDayFormat.H_colon_mm:
      return 'ja_JP, zh_CN, ko_KR (when the locale uses 24-hour clock).';
    case TimeOfDayFormat.h_colon_mm_space_a:
      return 'en_US, en_CA (English), en_PH, fil_PH, and other 12h locales.';
    case TimeOfDayFormat.a_space_h_colon_mm:
      return 'ko_KR (when the locale uses 12-hour clock), some Asian locales.';
  }
}

bool _is24h(TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
    case TimeOfDayFormat.HH_dot_mm:
    case TimeOfDayFormat.frenchCanadian:
    case TimeOfDayFormat.H_colon_mm:
      return true;
    case TimeOfDayFormat.h_colon_mm_space_a:
    case TimeOfDayFormat.a_space_h_colon_mm:
      return false;
  }
}

String _hourFamily(TimeOfDayFormat fmt) {
  switch (fmt) {
    case TimeOfDayFormat.HH_colon_mm:
    case TimeOfDayFormat.HH_dot_mm:
    case TimeOfDayFormat.frenchCanadian:
      return 'HH';
    case TimeOfDayFormat.H_colon_mm:
      return 'H';
    case TimeOfDayFormat.h_colon_mm_space_a:
    case TimeOfDayFormat.a_space_h_colon_mm:
      return 'h';
  }
}

// ============================================================================
// Hand-rolled list of TimeOfDay samples used across the demo.
// ----------------------------------------------------------------------------

const List<TimeOfDay> _sampleTimes = <TimeOfDay>[
  TimeOfDay(hour: 0, minute: 0),
  TimeOfDay(hour: 6, minute: 30),
  TimeOfDay(hour: 12, minute: 0),
  TimeOfDay(hour: 13, minute: 45),
  TimeOfDay(hour: 23, minute: 59),
];

const List<TimeOfDay> _wideSampleTimes = <TimeOfDay>[
  TimeOfDay(hour: 0, minute: 0),
  TimeOfDay(hour: 6, minute: 30),
  TimeOfDay(hour: 9, minute: 5),
  TimeOfDay(hour: 12, minute: 0),
  TimeOfDay(hour: 13, minute: 45),
  TimeOfDay(hour: 18, minute: 15),
  TimeOfDay(hour: 23, minute: 59),
];

// ============================================================================
// Top-level build entry point.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== TimeOfDayFormat Deep Demo ===');
  for (final v in TimeOfDayFormat.values) {
    print(
      '  ${v.index}: ${v.name.padRight(20)} -> ${_icuPattern(v).padRight(10)} '
      '${_describeFormat(v)}',
    );
  }
  for (final t in _sampleTimes) {
    print(
      '  input ${_two(t.hour)}:${_formatMinute(t)} | '
      'HH:mm=${formatTime(t, TimeOfDayFormat.HH_colon_mm)} | '
      'HH.mm=${formatTime(t, TimeOfDayFormat.HH_dot_mm)} | '
      "fr_CA=${formatTime(t, TimeOfDayFormat.frenchCanadian)} | "
      'H:mm=${formatTime(t, TimeOfDayFormat.H_colon_mm)} | '
      'h:mm a=${formatTime(t, TimeOfDayFormat.h_colon_mm_space_a)} | '
      'a h:mm=${formatTime(t, TimeOfDayFormat.a_space_h_colon_mm)}',
    );
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 28),
              _buildPerValueShowcase(),
              const SizedBox(height: 28),
              _buildSideBySideTable(),
              const SizedBox(height: 28),
              _buildLocaleStyleExamples(),
              const SizedBox(height: 28),
              _buildLivePickerMock(),
              const SizedBox(height: 28),
              _buildHourFamilyGrouping(),
              const SizedBox(height: 28),
              _buildClockFaceMock(),
              const SizedBox(height: 28),
              _buildAlarmListRecipe(),
              const SizedBox(height: 28),
              _buildAlwaysUse24HCard(),
              const SizedBox(height: 28),
              _buildDecisionGuide(),
              const SizedBox(height: 28),
              _buildReferenceTable(),
              const SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — Hero section
// Palette: deep purple + warm cream
// ----------------------------------------------------------------------------

Widget _buildHeroSection() {
  const heroBg = Color(0xFF311B92);
  const heroAccent = Color(0xFFFFD180);
  const heroSurface = Color(0xFFFFF8E1);
  const heroText = Color(0xFFFFFFFF);

  final intro = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: heroBg,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33311B92),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'TimeOfDayFormat',
          style: TextStyle(
            color: heroAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'How Material expresses an entire time string',
          style: TextStyle(
            color: heroText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'TimeOfDayFormat is the Material-level enum returned by '
          'MaterialLocalizations.timeOfDayFormat. Where HourFormat only '
          'covers the hour portion, TimeOfDayFormat covers the full '
          'pattern: hour, separator, minute, and (sometimes) day period.',
          style: TextStyle(color: heroText, fontSize: 13.5, height: 1.4),
        ),
        SizedBox(height: 10),
        Text(
          'There are exactly six values, each tied to an ICU pattern and a '
          'set of locales. The harness in this file mirrors the same '
          'semantics with hand-rolled formatters because the real '
          'MaterialLocalizations.formatTimeOfDay needs a localization '
          'context that the script harness does not have.',
          style: TextStyle(color: heroText, fontSize: 13.5, height: 1.4),
        ),
      ],
    ),
  );

  Widget heroCell(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: heroBg.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 9,
                color: Color(0xFF311B92),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF311B92),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget heroRow(TimeOfDay t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              '${_two(t.hour)}:${_formatMinute(t)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ),
          for (final fmt in TimeOfDayFormat.values)
            Expanded(child: heroCell(_hourFamily(fmt), formatTime(t, fmt))),
        ],
      ),
    );
  }

  final tableBlock = Container(
    margin: const EdgeInsets.only(top: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: heroSurface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: heroAccent, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sample renderings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ..._sampleTimes.take(3).map(heroRow),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [intro, tableBlock],
  );
}

// ============================================================================
// SECTION 2 — Per-value showcase
// Palette: per-value distinct stripes
// ----------------------------------------------------------------------------

Widget _buildPerValueShowcase() {
  const palettes = <TimeOfDayFormat, List<Color>>{
    TimeOfDayFormat.HH_colon_mm: [
      Color(0xFF004D40),
      Color(0xFF80CBC4),
      Color(0xFFE0F2F1),
    ],
    TimeOfDayFormat.HH_dot_mm: [
      Color(0xFF1A237E),
      Color(0xFF7986CB),
      Color(0xFFE8EAF6),
    ],
    TimeOfDayFormat.frenchCanadian: [
      Color(0xFFB71C1C),
      Color(0xFFFFAB91),
      Color(0xFFFFEBEE),
    ],
    TimeOfDayFormat.H_colon_mm: [
      Color(0xFF4A148C),
      Color(0xFFCE93D8),
      Color(0xFFF3E5F5),
    ],
    TimeOfDayFormat.h_colon_mm_space_a: [
      Color(0xFF0D47A1),
      Color(0xFF64B5F6),
      Color(0xFFE3F2FD),
    ],
    TimeOfDayFormat.a_space_h_colon_mm: [
      Color(0xFF33691E),
      Color(0xFFAED581),
      Color(0xFFF1F8E9),
    ],
  };

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '2. Per-value showcase',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF263238),
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        'A stylised digital-clock card per TimeOfDayFormat across a hand-'
        'rolled set of times.',
        style: TextStyle(color: Color(0xFF455A64), fontSize: 13),
      ),
      const SizedBox(height: 14),
      for (final fmt in TimeOfDayFormat.values) ...[
        _buildFormatShowcaseCard(
          fmt: fmt,
          bg: palettes[fmt]![0],
          accent: palettes[fmt]![1],
          digit: palettes[fmt]![2],
        ),
        const SizedBox(height: 14),
      ],
    ],
  );
}

Widget _buildFormatShowcaseCard({
  required TimeOfDayFormat fmt,
  required Color bg,
  required Color accent,
  required Color digit,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: bg.withOpacity(0.35),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _icuPattern(fmt),
                style: TextStyle(
                  color: bg,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                fmt.name,
                style: TextStyle(
                  color: digit,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          _describeFormat(fmt),
          style: TextStyle(color: accent, fontSize: 13, height: 1.3),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final t in _sampleTimes)
              _buildDigitalClockTile(t, fmt, bg, accent, digit),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDigitalClockTile(
  TimeOfDay t,
  TimeOfDayFormat fmt,
  Color bg,
  Color accent,
  Color digit,
) {
  return Container(
    width: 150,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
      color: bg.withOpacity(0.55),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'input ${_two(t.hour)}:${_formatMinute(t)}',
          style: TextStyle(color: accent, fontSize: 10, letterSpacing: 0.4),
        ),
        const SizedBox(height: 4),
        Text(
          formatTime(t, fmt),
          style: TextStyle(
            color: digit,
            fontFamily: 'monospace',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — Side-by-side comparison table
// Palette: charcoal + amber rows
// ----------------------------------------------------------------------------

Widget _buildSideBySideTable() {
  const headerBg = Color(0xFF263238);
  const headerInk = Color(0xFFFFC107);
  const evenRow = Color(0xFFECEFF1);
  const oddRow = Color(0xFFFFFFFF);
  const ink = Color(0xFF263238);

  Widget headerCell(String s, {double flex = 1}) {
    return Expanded(
      flex: (flex * 10).round(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Text(
          s,
          style: const TextStyle(
            color: headerInk,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget bodyCell(String s, Color color, {double flex = 1, bool mono = true}) {
    return Expanded(
      flex: (flex * 10).round(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Text(
          s,
          style: TextStyle(
            fontFamily: mono ? 'monospace' : null,
            fontSize: 11.5,
            color: color,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
      ),
    );
  }

  final rows = <Widget>[];
  for (int i = 0; i < _wideSampleTimes.length; i++) {
    final t = _wideSampleTimes[i];
    final bg = i.isEven ? evenRow : oddRow;
    final tone = t.hour < 12 ? const Color(0xFF0D47A1) : const Color(0xFFB71C1C);
    rows.add(
      Container(
        color: bg,
        child: Row(
          children: [
            bodyCell('${_two(t.hour)}:${_formatMinute(t)}', tone, flex: 0.9),
            for (final fmt in TimeOfDayFormat.values)
              bodyCell(formatTime(t, fmt), tone, flex: 1.1),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: headerBg),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: headerBg,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            width: double.infinity,
            child: const Text(
              '3. Side-by-side comparison',
              style: TextStyle(
                color: Color(0xFFFFC107),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: headerBg,
            child: Row(
              children: [
                headerCell('h24', flex: 0.9),
                headerCell('HH:mm', flex: 1.1),
                headerCell('HH.mm', flex: 1.1),
                headerCell("HH 'h' mm", flex: 1.1),
                headerCell('H:mm', flex: 1.1),
                headerCell('h:mm a', flex: 1.1),
                headerCell('a h:mm', flex: 1.1),
              ],
            ),
          ),
          ...rows,
          Container(
            color: const Color(0xFFFAFAFA),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: const Text(
              'Same TimeOfDay rendered through every TimeOfDayFormat. The '
              'underlying value never changes — only the surface text.',
              style: TextStyle(color: ink, fontSize: 11),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 4 — Locale-style examples
// Palette: pastel green / sky / sand
// ----------------------------------------------------------------------------

Widget _buildLocaleStyleExamples() {
  const titleColor = Color(0xFF1B5E20);
  const subColor = Color(0xFF33691E);

  final entries = <_LocaleEntry>[
    _LocaleEntry(
      flag: 'US',
      country: 'United States',
      locale: 'en_US',
      fmt: TimeOfDayFormat.h_colon_mm_space_a,
      cardBg: const Color(0xFFFFF3E0),
      stripe: const Color(0xFFFF7043),
      ink: const Color(0xFFBF360C),
    ),
    _LocaleEntry(
      flag: 'GB',
      country: 'United Kingdom',
      locale: 'en_GB',
      fmt: TimeOfDayFormat.HH_colon_mm,
      cardBg: const Color(0xFFE3F2FD),
      stripe: const Color(0xFF1E88E5),
      ink: const Color(0xFF0D47A1),
    ),
    _LocaleEntry(
      flag: 'DE',
      country: 'Germany',
      locale: 'de_DE',
      fmt: TimeOfDayFormat.HH_colon_mm,
      cardBg: const Color(0xFFFFFDE7),
      stripe: const Color(0xFFFBC02D),
      ink: const Color(0xFFF57F17),
    ),
    _LocaleEntry(
      flag: 'CA',
      country: 'Canada (French)',
      locale: 'fr_CA',
      fmt: TimeOfDayFormat.frenchCanadian,
      cardBg: const Color(0xFFFFEBEE),
      stripe: const Color(0xFFE53935),
      ink: const Color(0xFFB71C1C),
    ),
    _LocaleEntry(
      flag: 'KR',
      country: 'South Korea',
      locale: 'ko_KR',
      fmt: TimeOfDayFormat.a_space_h_colon_mm,
      cardBg: const Color(0xFFF3E5F5),
      stripe: const Color(0xFF8E24AA),
      ink: const Color(0xFF4A148C),
    ),
    _LocaleEntry(
      flag: 'PL',
      country: 'Poland',
      locale: 'pl_PL',
      fmt: TimeOfDayFormat.HH_dot_mm,
      cardBg: const Color(0xFFE8F5E9),
      stripe: const Color(0xFF43A047),
      ink: const Color(0xFF1B5E20),
    ),
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFAED581)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '4. Locale-style examples',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Different locales typically resolve TimeOfDayFormat differently. '
          'This is a simplified illustration — real MaterialLocalizations '
          'queries the platform and returns the per-locale ICU pattern.',
          style: TextStyle(color: subColor, fontSize: 13, height: 1.3),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final e in entries)
              SizedBox(width: 200, child: _buildLocaleCard(e)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFC5E1A5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mapping (illustrative only):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• en_US, en_PH, fil_PH         -> h_colon_mm_space_a',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• en_GB, fr_FR, de_DE, es_ES   -> HH_colon_mm',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• ja_JP, zh_CN                 -> H_colon_mm',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• fr_CA                        -> frenchCanadian',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• pl_PL, fi_FI                 -> HH_dot_mm',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• ko_KR (12h preference)       -> a_space_h_colon_mm',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _LocaleEntry {
  const _LocaleEntry({
    required this.flag,
    required this.country,
    required this.locale,
    required this.fmt,
    required this.cardBg,
    required this.stripe,
    required this.ink,
  });
  final String flag;
  final String country;
  final String locale;
  final TimeOfDayFormat fmt;
  final Color cardBg;
  final Color stripe;
  final Color ink;
}

Widget _buildLocaleCard(_LocaleEntry e) {
  const showTime = TimeOfDay(hour: 9, minute: 5);
  const showTime2 = TimeOfDay(hour: 17, minute: 30);
  const showTime3 = TimeOfDay(hour: 0, minute: 0);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: e.cardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: e.stripe, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: e.stripe,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                e.flag,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                e.country,
                style: TextStyle(
                  color: e.ink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          e.locale,
          style: TextStyle(
            color: e.stripe,
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          formatTime(showTime, e.fmt),
          style: TextStyle(
            color: e.ink,
            fontFamily: 'monospace',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formatTime(showTime2, e.fmt),
          style: TextStyle(
            color: e.ink.withOpacity(0.75),
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
        Text(
          formatTime(showTime3, e.fmt),
          style: TextStyle(
            color: e.ink.withOpacity(0.55),
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'fmt: ${_icuPattern(e.fmt)}',
          style: TextStyle(color: e.stripe, fontSize: 10),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — Live picker mock (StatefulBuilder)
// Palette: ocean teal + cream
// ----------------------------------------------------------------------------

Widget _buildLivePickerMock() {
  const bg = Color(0xFF006064);
  const accent = Color(0xFF80DEEA);
  const ink = Color(0xFFE0F7FA);

  // Hand-rolled list of TimeOfDay selections that the user will "pick" — the
  // mock cycles through these as the user taps the picker pad.
  const candidatePicks = <TimeOfDay>[
    TimeOfDay(hour: 0, minute: 0),
    TimeOfDay(hour: 7, minute: 15),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 14, minute: 5),
    TimeOfDay(hour: 17, minute: 45),
    TimeOfDay(hour: 21, minute: 10),
    TimeOfDay(hour: 23, minute: 59),
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _LivePickerBody(
          bg: bg,
          accent: accent,
          ink: ink,
          candidates: candidatePicks,
        );
      },
    ),
  );
}

class _LivePickerBody extends StatefulWidget {
  const _LivePickerBody({
    required this.bg,
    required this.accent,
    required this.ink,
    required this.candidates,
  });
  final Color bg;
  final Color accent;
  final Color ink;
  final List<TimeOfDay> candidates;

  @override
  State<_LivePickerBody> createState() => _LivePickerBodyState();
}

class _LivePickerBodyState extends State<_LivePickerBody> {
  TimeOfDayFormat _selectedFormat = TimeOfDayFormat.HH_colon_mm;
  final List<TimeOfDay> _picks = <TimeOfDay>[
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 13, minute: 30),
  ];
  int _candidateIndex = 0;

  void _addPick() {
    setState(() {
      _picks.add(widget.candidates[_candidateIndex]);
      _candidateIndex = (_candidateIndex + 1) % widget.candidates.length;
    });
  }

  void _clearPicks() {
    setState(() {
      _picks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5. Live picker mock',
          style: TextStyle(
            color: widget.ink,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A stateful list of TimeOfDay selections rendered in the chosen '
          'format. The SegmentedButton drives the format; the FAB-style '
          'button cycles through hand-rolled candidate picks.',
          style: TextStyle(color: widget.accent, fontSize: 12),
        ),
        const SizedBox(height: 14),
        SegmentedButton<TimeOfDayFormat>(
          segments: <ButtonSegment<TimeOfDayFormat>>[
            for (final fmt in TimeOfDayFormat.values)
              ButtonSegment<TimeOfDayFormat>(
                value: fmt,
                label: Text(
                  _icuPattern(fmt),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
          ],
          selected: <TimeOfDayFormat>{_selectedFormat},
          showSelectedIcon: false,
          onSelectionChanged: (s) {
            setState(() {
              _selectedFormat = s.first;
            });
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return widget.accent;
              }
              return Colors.white.withOpacity(0.08);
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return widget.bg;
              }
              return widget.ink;
            }),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.accent.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Picks (${_picks.length})',
                style: TextStyle(
                  color: widget.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              if (_picks.isEmpty)
                Text(
                  'No picks yet. Tap "Add pick" to append a TimeOfDay.',
                  style: TextStyle(
                    color: widget.ink.withOpacity(0.7),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (int i = 0; i < _picks.length; i++)
                      _buildPickChip(
                        index: i,
                        time: _picks[i],
                        fmt: _selectedFormat,
                      ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _addPick,
              icon: const Icon(Icons.add_alarm, size: 16),
              label: const Text('Add pick'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.accent,
                foregroundColor: widget.bg,
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: _clearPicks,
              icon: const Icon(Icons.clear_all, size: 16),
              label: const Text('Clear'),
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.ink,
                side: BorderSide(color: widget.accent.withOpacity(0.6)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Selected format: ${_selectedFormat.name} '
          '(${_icuPattern(_selectedFormat)})',
          style: TextStyle(
            color: widget.accent,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildPickChip({
    required int index,
    required TimeOfDay time,
    required TimeOfDayFormat fmt,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: widget.accent.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: widget.accent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#${index + 1}',
            style: TextStyle(
              color: widget.accent,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            formatTime(time, fmt),
            style: TextStyle(
              color: widget.ink,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 6 — 24-hour vs 12-hour grouping summary
// Palette: blue / amber split
// ----------------------------------------------------------------------------

Widget _buildHourFamilyGrouping() {
  const titleColor = Color(0xFF263238);
  const subColor = Color(0xFF455A64);

  final twentyFour = TimeOfDayFormat.values.where(_is24h).toList();
  final twelve = TimeOfDayFormat.values.where((f) => !_is24h(f)).toList();

  Widget groupCard({
    required String title,
    required List<TimeOfDayFormat> formats,
    required Color bg,
    required Color stripe,
    required Color ink,
    required String summary,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: stripe, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            summary,
            style: TextStyle(color: ink.withOpacity(0.8), fontSize: 12),
          ),
          const SizedBox(height: 8),
          for (final fmt in formats)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: stripe.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: stripe.withOpacity(0.5)),
                    ),
                    child: Text(
                      _icuPattern(fmt),
                      style: TextStyle(
                        color: ink,
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      fmt.name,
                      style: TextStyle(
                        color: ink,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Text(
                    'hourFmt=${_hourFamily(fmt)}',
                    style: TextStyle(
                      color: stripe,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFCFD8DC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '6. 24-hour vs 12-hour grouping',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each TimeOfDayFormat reduces to one of three HourFormat values '
          '(HH, H, h). The Material function hourFormat(of:) implements '
          'this mapping; this section reflects it visually.',
          style: TextStyle(color: subColor, fontSize: 12, height: 1.3),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: groupCard(
                title: '24-hour family (4 values)',
                formats: twentyFour,
                bg: const Color(0xFFE3F2FD),
                stripe: const Color(0xFF1976D2),
                ink: const Color(0xFF0D47A1),
                summary:
                    '24h-clock formats. No AM/PM marker. Differ in the '
                    'separator (":", ".", " h ") and in whether the hour '
                    'is zero-padded.',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: groupCard(
                title: '12-hour family (2 values)',
                formats: twelve,
                bg: const Color(0xFFFFF3E0),
                stripe: const Color(0xFFFB8C00),
                ink: const Color(0xFFBF360C),
                summary:
                    '12h-clock formats with day period (AM/PM). Differ '
                    'only in whether the day period leads or trails the '
                    'hour:minute.',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — Clock face mock
// Palette: navy face, ivory ticks
// ----------------------------------------------------------------------------

Widget _buildClockFaceMock() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7. Clock-face mock',
          style: TextStyle(
            color: Color(0xFFFFF8E1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'A hand-drawn analog face whose centre label uses the chosen '
          'TimeOfDayFormat. The 24h family shares a 24-tick face; the 12h '
          'family uses a classic 12-tick face.',
          style: TextStyle(color: Color(0xFFB3E5FC), fontSize: 12),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.spaceAround,
          children: [
            for (final fmt in TimeOfDayFormat.values) _buildClockFace(fmt),
          ],
        ),
      ],
    ),
  );
}

Widget _buildClockFace(TimeOfDayFormat fmt) {
  const dialSize = 110.0;
  const radius = 46.0;
  final isTwelve = !_is24h(fmt);
  final count = isTwelve ? 12 : 24;
  final faceColor = isTwelve
      ? const Color(0xFFFFF3E0)
      : const Color(0xFFE3F2FD);
  final tickColor = isTwelve
      ? const Color(0xFFB71C1C)
      : const Color(0xFF0D47A1);

  // Display time fixed at 09:05 across all faces, so the comparison is fair.
  const displayTime = TimeOfDay(hour: 9, minute: 5);

  final positioned = <Widget>[];
  for (int i = 0; i < count; i++) {
    final angle = (i / count) * 2 * 3.141592653589793 - (3.141592653589793 / 2);
    final dx = dialSize / 2 + radius * _cos(angle) - 8;
    final dy = dialSize / 2 + radius * _sin(angle) - 8;
    final label = isTwelve
        ? (i == 0 ? '12' : i.toString())
        : (fmt == TimeOfDayFormat.H_colon_mm
              ? i.toString()
              : i.toString().padLeft(2, '0'));
    positioned.add(
      Positioned(
        left: dx,
        top: dy,
        width: 16,
        height: 16,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: tickColor,
              fontSize: isTwelve ? 9 : 7,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }

  // Dial hand at 9 o'clock.
  const handTarget = 9;
  final handAngle = (handTarget / count) * 2 * 3.141592653589793
      - (3.141592653589793 / 2);
  positioned.add(
    Positioned(
      left: dialSize / 2 - 1,
      top: dialSize / 2 - radius * 0.7,
      child: Transform.rotate(
        angle: handAngle + 3.141592653589793 / 2,
        alignment: Alignment.bottomCenter,
        child: Container(width: 2, height: radius * 0.7, color: tickColor),
      ),
    ),
  );

  return SizedBox(
    width: 140,
    child: Column(
      children: [
        Container(
          width: dialSize,
          height: dialSize,
          decoration: BoxDecoration(
            color: faceColor,
            shape: BoxShape.circle,
            border: Border.all(color: tickColor, width: 2),
          ),
          child: Stack(children: positioned),
        ),
        const SizedBox(height: 6),
        Text(
          formatTime(displayTime, fmt),
          style: const TextStyle(
            color: Color(0xFFFFF8E1),
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
        Text(
          fmt.name,
          style: const TextStyle(
            color: Color(0xFFB3E5FC),
            fontSize: 9,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Tiny power-series cos/sin so we don't pull dart:math into the script.
double _cos(double x) {
  const pi = 3.141592653589793;
  double a = x % (2 * pi);
  if (a > pi) a -= 2 * pi;
  if (a < -pi) a += 2 * pi;
  double term = 1;
  double sum = 1;
  for (int n = 1; n <= 8; n++) {
    term *= -a * a / ((2 * n - 1) * (2 * n));
    sum += term;
  }
  return sum;
}

double _sin(double x) {
  const pi = 3.141592653589793;
  double a = x % (2 * pi);
  if (a > pi) a -= 2 * pi;
  if (a < -pi) a += 2 * pi;
  double term = a;
  double sum = a;
  for (int n = 1; n <= 8; n++) {
    term *= -a * a / ((2 * n) * (2 * n + 1));
    sum += term;
  }
  return sum;
}

// ============================================================================
// SECTION 8 — Alarm-list recipe
// Palette: per-row tinted by morning/evening
// ----------------------------------------------------------------------------

Widget _buildAlarmListRecipe() {
  const bg = Color(0xFF1B1B2F);
  const morning = Color(0xFFFFB74D);
  const evening = Color(0xFF7E57C2);
  const ink = Color(0xFFECEFF1);

  final morningAlarms = <Map<String, Object>>[
    {'label': 'Sunrise stretch', 'time': const TimeOfDay(hour: 5, minute: 30)},
    {'label': 'Wake up', 'time': const TimeOfDay(hour: 6, minute: 30)},
    {'label': 'Standup', 'time': const TimeOfDay(hour: 9, minute: 0)},
    {'label': 'Mid-morning break', 'time': const TimeOfDay(hour: 10, minute: 30)},
  ];
  final eveningAlarms = <Map<String, Object>>[
    {'label': 'Wind down', 'time': const TimeOfDay(hour: 21, minute: 0)},
    {'label': 'Read', 'time': const TimeOfDay(hour: 22, minute: 15)},
    {'label': 'Lights off', 'time': const TimeOfDay(hour: 23, minute: 30)},
  ];

  Widget alarmCard({
    required String title,
    required List<Map<String, Object>> alarms,
    required Color sectionColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: sectionColor.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: sectionColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: sectionColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final alarm in alarms)
            _buildAlarmRow(
              alarm['label'] as String,
              alarm['time'] as TimeOfDay,
              sectionColor,
            ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.alarm, color: Color(0xFFFFB74D), size: 22),
            SizedBox(width: 8),
            Text(
              '8. Alarm list across formats',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Each alarm row renders the same TimeOfDay through every '
          'TimeOfDayFormat. Notice how zero-padding (HH-family) keeps a '
          'rectangular column, while the variable-length H/h families '
          'create ragged trailing edges.',
          style: TextStyle(color: Color(0xFFB39DDB), fontSize: 12),
        ),
        const SizedBox(height: 14),
        alarmCard(
          title: 'Morning',
          alarms: morningAlarms,
          sectionColor: morning,
          icon: Icons.wb_sunny_outlined,
        ),
        alarmCard(
          title: 'Evening',
          alarms: eveningAlarms,
          sectionColor: evening,
          icon: Icons.brightness_3_outlined,
        ),
      ],
    ),
  );
}

Widget _buildAlarmRow(String label, TimeOfDay time, Color sectionColor) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_active, color: sectionColor, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: sectionColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Text(
              'h24=${_two(time.hour)}:${_formatMinute(time)}',
              style: TextStyle(
                color: sectionColor.withOpacity(0.7),
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            for (final fmt in TimeOfDayFormat.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: sectionColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: sectionColor.withOpacity(0.4)),
                ),
                child: Text(
                  formatTime(time, fmt),
                  style: TextStyle(
                    color: sectionColor,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — alwaysUse24HourFormat compatibility
// Palette: paper + slate
// ----------------------------------------------------------------------------

Widget _buildAlwaysUse24HCard() {
  const bg = Color(0xFFFAFAFA);
  const stripe = Color(0xFF455A64);
  const ink = Color(0xFF263238);

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•  ',
            style: TextStyle(color: ink, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: ink,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      border: Border(left: BorderSide(color: stripe, width: 6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '9. TimePicker.alwaysUse24HourFormat',
          style: TextStyle(
            color: ink,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'When MediaQuery.alwaysUse24HourFormatOf(context) is true, '
          'Material forces TimeOfDayFormat into the 24-hour family. The '
          'effective behaviour is roughly:',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 8),
        bullet(
          'h_colon_mm_space_a and a_space_h_colon_mm are replaced with '
          'HH_colon_mm — the most neutral 24-hour form.',
        ),
        bullet(
          'HH_dot_mm and frenchCanadian remain as-is when they are the '
          "locale's natural choice — they are already 24-hour.",
        ),
        bullet(
          'H_colon_mm remains as-is in locales that prefer non-padded '
          'narrow digits (ja, zh, ko on platforms that report H_colon_mm).',
        ),
        bullet(
          'On the user side, this means: never assume the format you see '
          'in code matches what the user will see — always go through '
          'MaterialLocalizations to respect their accessibility setting.',
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: stripe.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sketch',
                style: TextStyle(
                  color: ink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'final mq = MediaQuery.of(context);',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                'final format = mq.alwaysUse24HourFormat',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "    ? TimeOfDayFormat.HH_colon_mm",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                '    : MaterialLocalizations.of(context).timeOfDayFormat;',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Accessibility note: screen-reader announcements typically '
          "ignore the surface separator and read the time as 'nine oh five "
          "AM' or 'nine hours five'. Choosing a wrong TimeOfDayFormat will "
          'still produce sensible audio — but visually it can look wrong '
          'to the user, so respect the platform setting.',
          style: TextStyle(color: ink, fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — Decision-guide card
// Palette: pale yellow / olive
// ----------------------------------------------------------------------------

Widget _buildDecisionGuide() {
  const bg = Color(0xFFFFFDE7);
  const stripe = Color(0xFF827717);
  const ink = Color(0xFF3E2723);

  final entries = <_DecisionEntry>[
    const _DecisionEntry(
      fmt: TimeOfDayFormat.HH_colon_mm,
      audience: 'Most Europeans, neutral default',
      use:
          'Default fallback when alwaysUse24HourFormat is true. Best for '
          'columns of times that need to align (logs, schedules).',
      color: Color(0xFF1976D2),
    ),
    const _DecisionEntry(
      fmt: TimeOfDayFormat.HH_dot_mm,
      audience: 'pl_PL, fi_FI',
      use:
          'Use only when the underlying locale prefers a dot separator. '
          'Reading code: this is the only difference vs HH_colon_mm.',
      color: Color(0xFF388E3C),
    ),
    const _DecisionEntry(
      fmt: TimeOfDayFormat.frenchCanadian,
      audience: 'fr_CA',
      use:
          "Specific to Canadian French. Looks distinctive ('h' as the "
          'separator); never override it for that locale.',
      color: Color(0xFFD32F2F),
    ),
    const _DecisionEntry(
      fmt: TimeOfDayFormat.H_colon_mm,
      audience: 'ja_JP, zh_CN, ko_KR',
      use:
          'Choose for locales that prefer narrow digits and drop the '
          'leading zero. Common on East-Asian platforms.',
      color: Color(0xFF7B1FA2),
    ),
    const _DecisionEntry(
      fmt: TimeOfDayFormat.h_colon_mm_space_a,
      audience: 'en_US, en_PH, fil_PH',
      use:
          'The default 12-hour pattern with trailing AM/PM. Friendly for '
          'consumer apps in en_US-style audiences.',
      color: Color(0xFFFB8C00),
    ),
    const _DecisionEntry(
      fmt: TimeOfDayFormat.a_space_h_colon_mm,
      audience: 'ko_KR (12h preference)',
      use:
          '12-hour pattern with leading AM/PM. Use only when the locale '
          'reports it explicitly via MaterialLocalizations.',
      color: Color(0xFF00838F),
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: stripe, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '10. Decision guide',
          style: TextStyle(
            color: ink,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'When each format is appropriate by region/audience. As a rule '
          'of thumb, never hard-code a TimeOfDayFormat unless the user '
          'has explicitly asked for it — defer to MaterialLocalizations.',
          style: TextStyle(color: ink, fontSize: 12, height: 1.3),
        ),
        const SizedBox(height: 12),
        for (final e in entries) _buildDecisionRow(e),
      ],
    ),
  );
}

class _DecisionEntry {
  const _DecisionEntry({
    required this.fmt,
    required this.audience,
    required this.use,
    required this.color,
  });
  final TimeOfDayFormat fmt;
  final String audience;
  final String use;
  final Color color;
}

Widget _buildDecisionRow(_DecisionEntry e) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: e.color, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: e.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _icuPattern(e.fmt),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                e.fmt.name,
                style: TextStyle(
                  color: e.color,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Audience: ${e.audience}',
          style: const TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          e.use,
          style: const TextStyle(
            color: Color(0xFF5D4037),
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'sample: ${formatTime(const TimeOfDay(hour: 9, minute: 5), e.fmt)}'
          '  /  ${formatTime(const TimeOfDay(hour: 17, minute: 30), e.fmt)}',
          style: TextStyle(
            color: e.color,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — Reference table
// Palette: paper / red ribbon
// ----------------------------------------------------------------------------

Widget _buildReferenceTable() {
  const paper = Color(0xFFFFFDE7);
  const ribbon = Color(0xFFC62828);
  const ink = Color(0xFF3E2723);

  Widget refRow(TimeOfDayFormat fmt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Text(
              fmt.index.toString(),
              style: const TextStyle(
                color: ribbon,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              fmt.name,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              _icuPattern(fmt),
              style: TextStyle(
                color: ribbon,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _describeFormat(fmt),
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _whenItApplies(fmt),
                  style: TextStyle(
                    color: ink.withOpacity(0.75),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: ribbon, width: 2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 22, color: ribbon),
            const SizedBox(width: 8),
            const Text(
              '11. Reference table',
              style: TextStyle(
                color: ink,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'index · name · ICU pattern · explanation · use case',
          style: TextStyle(color: ink, fontSize: 11),
        ),
        const Divider(color: ribbon),
        ...TimeOfDayFormat.values.map(refRow),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ribbon.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Quick formula',
                style: TextStyle(
                  color: ribbon,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "HH:mm  -> '\${_two(t.hour)}:\${_two(t.minute)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "HH.mm  -> '\${_two(t.hour)}.\${_two(t.minute)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "fr_CA  -> '\${_two(t.hour)} h \${_two(t.minute)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "H:mm   -> '\${t.hour}:\${_two(t.minute)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "h:mm a -> '\${_twelve(t)}:\${_two(t.minute)} \${ampm(t)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
              Text(
                "a h:mm -> '\${ampm(t)} \${_twelve(t)}:\${_two(t.minute)}'",
                style: TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Footer
// ----------------------------------------------------------------------------

Widget _buildFooter() {
  const sample = TimeOfDay(hour: 13, minute: 45);
  final samples = [
    for (final fmt in TimeOfDayFormat.values) formatTime(sample, fmt),
  ];
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            'TimeOfDayFormat deep demo · ${TimeOfDayFormat.values.length} '
            'values · sample 13:45 ->',
            style: const TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            samples.join('  ·  '),
            style: const TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 10,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
