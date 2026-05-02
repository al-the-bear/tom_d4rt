// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// Pure-Dart hour formatting helpers.
// HourFormat.HH -> 24h, zero-padded ("00".."23")
// HourFormat.H  -> 24h, no padding ("0".."23")
// HourFormat.h  -> 12h, no padding ("12","1".."11","12","1".."11")
// ----------------------------------------------------------------------------

String _formatHour(TimeOfDay t, HourFormat fmt) {
  final h24 = t.hour;
  switch (fmt) {
    case HourFormat.HH:
      return h24.toString().padLeft(2, '0');
    case HourFormat.H:
      return h24.toString();
    case HourFormat.h:
      final h12 = h24 % 12 == 0 ? 12 : h24 % 12;
      return h12.toString();
  }
}

String _formatMinute(TimeOfDay t) {
  return t.minute.toString().padLeft(2, '0');
}

String _amPm(TimeOfDay t) => t.hour < 12 ? 'AM' : 'PM';

String _formatTime(TimeOfDay t, HourFormat fmt) {
  final base = '${_formatHour(t, fmt)}:${_formatMinute(t)}';
  if (fmt == HourFormat.h) {
    return '$base ${_amPm(t)}';
  }
  return base;
}

String _formatHourFromInt(int hour, HourFormat fmt) {
  return _formatHour(TimeOfDay(hour: hour, minute: 0), fmt);
}

String _formatHourMinuteFromInt(int hour, int minute, HourFormat fmt) {
  return _formatTime(TimeOfDay(hour: hour, minute: minute), fmt);
}

String _describeFormat(HourFormat fmt) {
  switch (fmt) {
    case HourFormat.HH:
      return '24-hour clock, zero-padded.';
    case HourFormat.H:
      return '24-hour clock, no padding.';
    case HourFormat.h:
      return '12-hour clock, no padding, with AM/PM marker.';
  }
}

String _whenItApplies(HourFormat fmt) {
  switch (fmt) {
    case HourFormat.HH:
      return 'Common in en_GB, fr_FR, de_DE, and many European locales.';
    case HourFormat.H:
      return 'Common in ja_JP, zh_CN, and locales preferring narrow digits.';
    case HourFormat.h:
      return 'Common in en_US, en_CA, en_PH, and other 12-hour locales.';
  }
}

String _shortLabel(HourFormat fmt) {
  switch (fmt) {
    case HourFormat.HH:
      return 'HH';
    case HourFormat.H:
      return 'H';
    case HourFormat.h:
      return 'h';
  }
}

// ============================================================================
// Hand-rolled list of TimeOfDay samples used across the demo.
// ----------------------------------------------------------------------------

const List<TimeOfDay> _sampleTimes = <TimeOfDay>[
  TimeOfDay(hour: 0, minute: 0),
  TimeOfDay(hour: 6, minute: 30),
  TimeOfDay(hour: 9, minute: 5),
  TimeOfDay(hour: 12, minute: 0),
  TimeOfDay(hour: 13, minute: 30),
  TimeOfDay(hour: 17, minute: 45),
  TimeOfDay(hour: 23, minute: 55),
];

// ============================================================================
// Top-level build entry point.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== HourFormat Deep Demo ===');
  for (final v in HourFormat.values) {
    print('  ${v.index}: ${v.name}  -> ${_describeFormat(v)}');
  }
  for (final t in _sampleTimes) {
    print(
      '  ${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}'
      '  HH=${_formatTime(t, HourFormat.HH)}'
      '  H=${_formatTime(t, HourFormat.H)}'
      '  h=${_formatTime(t, HourFormat.h)}',
    );
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
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
              _buildLocaleLikenessPanel(),
              const SizedBox(height: 28),
              _buildHourSweep(),
              const SizedBox(height: 28),
              _buildRecipeSection(),
              const SizedBox(height: 28),
              _buildDialSection(),
              const SizedBox(height: 28),
              _buildAmPmMarkerCard(),
              const SizedBox(height: 28),
              _buildReferenceCard(),
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
// SECTION 1 — Hero card
// Palette: deep indigo + soft cream
// ----------------------------------------------------------------------------

Widget _buildHeroSection() {
  const heroBg = Color(0xFF1A237E);
  const heroAccent = Color(0xFFFFD54F);
  const heroSurface = Color(0xFFFFF8E1);
  const heroText = Color(0xFFFFFFFF);

  final introBlock = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: heroBg,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x331A237E),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'HourFormat',
          style: TextStyle(
            color: heroAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'How Material clocks display the hour',
          style: TextStyle(
            color: heroText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'HourFormat is the Material-level enum used by '
          'MaterialLocalizations.hourFormat to describe how the hour part '
          'of a clock display should be formatted. It does not change the '
          'underlying TimeOfDay value — only the surface representation.',
          style: TextStyle(color: heroText, fontSize: 13.5, height: 1.4),
        ),
        SizedBox(height: 10),
        Text(
          'There are exactly three values: HH (24h, zero-padded), '
          'H (24h, no padding), and h (12h, no padding, paired with AM/PM).',
          style: TextStyle(color: heroText, fontSize: 13.5, height: 1.4),
        ),
      ],
    ),
  );

  final sampleHours = <TimeOfDay>[
    const TimeOfDay(hour: 1, minute: 0),
    const TimeOfDay(hour: 9, minute: 5),
    const TimeOfDay(hour: 13, minute: 30),
  ];

  Widget heroRow(TimeOfDay t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '${t.hour.toString().padLeft(2, '0')}:${_formatMinute(t)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ),
          Expanded(child: _heroCell('HH', _formatTime(t, HourFormat.HH))),
          Expanded(child: _heroCell('H', _formatTime(t, HourFormat.H))),
          Expanded(child: _heroCell('h', _formatTime(t, HourFormat.h))),
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
            color: Color(0xFF1A237E),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            SizedBox(width: 70, child: Text('input')),
            Expanded(
              child: Center(
                child: Text(
                  'HH',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'H',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'h',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xFF1A237E)),
        ...sampleHours.map(heroRow),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [introBlock, tableBlock],
  );
}

Widget _heroCell(String label, String value) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E).withOpacity(0.08),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Text(
        value,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFF1A237E),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 2 — Per-value showcase
// Palette: teal / coral / violet trio
// ----------------------------------------------------------------------------

Widget _buildPerValueShowcase() {
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
        'A stylised digital-clock card per HourFormat across a hand-rolled set of times.',
        style: TextStyle(color: Color(0xFF455A64), fontSize: 13),
      ),
      const SizedBox(height: 14),
      _buildFormatShowcaseCard(
        fmt: HourFormat.HH,
        title: 'HH — 24h zero-padded',
        bg: const Color(0xFF004D40),
        accent: const Color(0xFF80CBC4),
        digit: const Color(0xFFE0F2F1),
      ),
      const SizedBox(height: 14),
      _buildFormatShowcaseCard(
        fmt: HourFormat.H,
        title: 'H — 24h no padding',
        bg: const Color(0xFF4A148C),
        accent: const Color(0xFFCE93D8),
        digit: const Color(0xFFF3E5F5),
      ),
      const SizedBox(height: 14),
      _buildFormatShowcaseCard(
        fmt: HourFormat.h,
        title: 'h — 12h with AM/PM',
        bg: const Color(0xFFB71C1C),
        accent: const Color(0xFFFFAB91),
        digit: const Color(0xFFFFEBEE),
      ),
    ],
  );
}

Widget _buildFormatShowcaseCard({
  required HourFormat fmt,
  required String title,
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
                _shortLabel(fmt),
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
                title,
                style: TextStyle(
                  color: digit,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
  HourFormat fmt,
  Color bg,
  Color accent,
  Color digit,
) {
  return Container(
    width: 130,
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
          'input ${t.hour.toString().padLeft(2, '0')}:${_formatMinute(t)}',
          style: TextStyle(color: accent, fontSize: 10, letterSpacing: 0.4),
        ),
        const SizedBox(height: 4),
        Text(
          _formatTime(t, fmt),
          style: TextStyle(
            color: digit,
            fontFamily: 'monospace',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — Locale-likeness panel
// Palette: pastel green / sky / sand
// ----------------------------------------------------------------------------

Widget _buildLocaleLikenessPanel() {
  const titleColor = Color(0xFF1B5E20);
  const subColor = Color(0xFF33691E);

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
          '3. Locale-likeness panel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Different locales typically map to different HourFormats. '
          'This is a simplified illustration — real MaterialLocalizations '
          'queries the platform.',
          style: TextStyle(color: subColor, fontSize: 13, height: 1.3),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildCountryCard(
                flag: 'US',
                country: 'United States',
                fmt: HourFormat.h,
                cardBg: const Color(0xFFFFF3E0),
                stripe: const Color(0xFFFF7043),
                ink: const Color(0xFFBF360C),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildCountryCard(
                flag: 'GB',
                country: 'United Kingdom',
                fmt: HourFormat.HH,
                cardBg: const Color(0xFFE3F2FD),
                stripe: const Color(0xFF1E88E5),
                ink: const Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildCountryCard(
                flag: 'JP',
                country: 'Japan',
                fmt: HourFormat.H,
                cardBg: const Color(0xFFFCE4EC),
                stripe: const Color(0xFFE91E63),
                ink: const Color(0xFF880E4F),
              ),
            ),
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
                'Mapping (approximate, illustrative only):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• en_US, en_CA, en_PH, fil   →   HourFormat.h',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• en_GB, fr_FR, de_DE, es_ES →   HourFormat.HH',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                '• ja_JP, zh_CN, ko_KR        →   HourFormat.H',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCountryCard({
  required String flag,
  required String country,
  required HourFormat fmt,
  required Color cardBg,
  required Color stripe,
  required Color ink,
}) {
  const showTime = TimeOfDay(hour: 9, minute: 5);
  const showTime2 = TimeOfDay(hour: 17, minute: 30);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: stripe, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: stripe,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                flag,
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
                country,
                style: TextStyle(
                  color: ink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _formatTime(showTime, fmt),
          style: TextStyle(
            color: ink,
            fontFamily: 'monospace',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _formatTime(showTime2, fmt),
          style: TextStyle(
            color: ink.withOpacity(0.75),
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'fmt: ${_shortLabel(fmt)}',
          style: TextStyle(color: stripe, fontSize: 10),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — Hour sweep
// Palette: charcoal + amber rows
// ----------------------------------------------------------------------------

Widget _buildHourSweep() {
  const headerBg = Color(0xFF263238);
  const headerInk = Color(0xFFFFC107);
  const evenRow = Color(0xFFECEFF1);
  const oddRow = Color(0xFFFFFFFF);

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
          ),
        ),
      ),
    );
  }

  Widget bodyCell(String s, Color color, {double flex = 1}) {
    return Expanded(
      flex: (flex * 10).round(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Text(
          s,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: color,
          ),
        ),
      ),
    );
  }

  final rows = <Widget>[];
  for (int h = 0; h < 24; h++) {
    final bg = h.isEven ? evenRow : oddRow;
    final tone = h < 12 ? const Color(0xFF0D47A1) : const Color(0xFFB71C1C);
    rows.add(
      Container(
        color: bg,
        child: Row(
          children: [
            bodyCell(h.toString().padLeft(2, '0'), tone, flex: 0.7),
            bodyCell(_formatHourFromInt(h, HourFormat.HH), tone),
            bodyCell(_formatHourFromInt(h, HourFormat.H), tone),
            bodyCell(_formatHourFromInt(h, HourFormat.h), tone),
            bodyCell(
              h < 12 ? 'AM' : 'PM',
              tone,
              flex: 0.7,
            ),
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
              '4. Hour sweep — 0..23',
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
                headerCell('h24', flex: 0.7),
                headerCell('HH'),
                headerCell('H'),
                headerCell('h'),
                headerCell('mer', flex: 0.7),
              ],
            ),
          ),
          ...rows,
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 5 — Recipes
// Palette: alarm orange / train slate / calendar mint
// ----------------------------------------------------------------------------

Widget _buildRecipeSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '5. Recipes',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF263238),
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        'Realistic UI mockups using each format.',
        style: TextStyle(color: Color(0xFF455A64), fontSize: 13),
      ),
      const SizedBox(height: 14),
      _buildAlarmRecipe(),
      const SizedBox(height: 14),
      _buildTrainRecipe(),
      const SizedBox(height: 14),
      _buildCalendarRecipe(),
    ],
  );
}

Widget _buildAlarmRecipe() {
  const bg = Color(0xFF263238);
  const accent = Color(0xFFFF6E40);
  const ink = Color(0xFFECEFF1);
  const fmt = HourFormat.HH;

  final alarms = <Map<String, Object>>[
    {'label': 'Wake up', 'time': const TimeOfDay(hour: 6, minute: 30)},
    {'label': 'Standup', 'time': const TimeOfDay(hour: 9, minute: 0)},
    {'label': 'Lunch', 'time': const TimeOfDay(hour: 12, minute: 30)},
    {'label': 'Sleep', 'time': const TimeOfDay(hour: 22, minute: 45)},
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.alarm, color: accent, size: 22),
            const SizedBox(width: 8),
            Text(
              'Alarm app — using HH',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Zero-padded 24h is ideal: every alarm row is the same width, '
          'so the column scans cleanly even at a glance.',
          style: TextStyle(color: accent, fontSize: 12),
        ),
        const SizedBox(height: 12),
        ...alarms.map((a) {
          final t = a['time'] as TimeOfDay;
          final label = a['label'] as String;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Text(
                  _formatTime(t, fmt),
                  style: const TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(color: ink, fontSize: 14),
                  ),
                ),
                const Icon(Icons.toggle_on, color: accent, size: 28),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildTrainRecipe() {
  const bg = Color(0xFFECEFF1);
  const accent = Color(0xFF455A64);
  const ink = Color(0xFF263238);
  const fmt = HourFormat.H;

  final schedule = <List<Object>>[
    <Object>['Express', const TimeOfDay(hour: 7, minute: 5), 'Pl. 3'],
    <Object>['Local', const TimeOfDay(hour: 8, minute: 12), 'Pl. 1'],
    <Object>['Express', const TimeOfDay(hour: 9, minute: 25), 'Pl. 3'],
    <Object>['Late', const TimeOfDay(hour: 18, minute: 40), 'Pl. 2'],
    <Object>['Night', const TimeOfDay(hour: 23, minute: 55), 'Pl. 1'],
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.train, color: accent, size: 22),
            const SizedBox(width: 8),
            Text(
              'Train schedule — using H',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Narrow-digit 24h works well for dense departure boards in '
          'East-Asian-style timetables where the leading zero is dropped.',
          style: TextStyle(color: accent, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: accent.withOpacity(0.15)),
              children: [
                _trainCell('Service', bold: true, color: ink),
                _trainCell('Departs', bold: true, color: ink),
                _trainCell('Platform', bold: true, color: ink),
              ],
            ),
            for (final row in schedule)
              TableRow(
                children: [
                  _trainCell(row[0] as String, color: ink),
                  _trainCell(
                    _formatTime(row[1] as TimeOfDay, fmt),
                    color: ink,
                    mono: true,
                  ),
                  _trainCell(row[2] as String, color: accent),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _trainCell(
  String s, {
  bool bold = false,
  bool mono = false,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    child: Text(
      s,
      style: TextStyle(
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontFamily: mono ? 'monospace' : null,
        fontSize: 13,
      ),
    ),
  );
}

Widget _buildCalendarRecipe() {
  const bg = Color(0xFFE0F2F1);
  const accent = Color(0xFF00897B);
  const ink = Color(0xFF004D40);
  const fmt = HourFormat.h;

  final entries = <Map<String, Object>>[
    {
      'title': 'Morning standup',
      'start': const TimeOfDay(hour: 9, minute: 30),
      'end': const TimeOfDay(hour: 9, minute: 45),
      'color': const Color(0xFF26A69A),
    },
    {
      'title': 'Design review',
      'start': const TimeOfDay(hour: 13, minute: 0),
      'end': const TimeOfDay(hour: 14, minute: 0),
      'color': const Color(0xFF00897B),
    },
    {
      'title': 'Dinner with team',
      'start': const TimeOfDay(hour: 18, minute: 30),
      'end': const TimeOfDay(hour: 20, minute: 0),
      'color': const Color(0xFF00695C),
    },
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.event, color: accent, size: 22),
            const SizedBox(width: 8),
            Text(
              'Calendar entry — using h',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '12-hour with AM/PM is friendly for personal calendars in '
          'en_US-style locales — the AM/PM marker disambiguates without padding.',
          style: TextStyle(color: accent, fontSize: 12),
        ),
        const SizedBox(height: 12),
        ...entries.map((e) {
          final start = e['start'] as TimeOfDay;
          final end = e['end'] as TimeOfDay;
          final title = e['title'] as String;
          final col = e['color'] as Color;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border(left: BorderSide(color: col, width: 5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: col,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: ink,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${_formatTime(start, fmt)}  →  ${_formatTime(end, fmt)}',
                        style: TextStyle(
                          color: accent,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — Time-picker dial
// Palette: navy face, ivory ticks
// ----------------------------------------------------------------------------

Widget _buildDialSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF0D47A1),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '6. Time-picker dials',
          style: TextStyle(
            color: Color(0xFFFFF8E1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Hand-drawn analog faces — HH and H both show the 24h face '
          '(0..23 around the rim), while h shows the classic 12h face.',
          style: TextStyle(color: Color(0xFFB3E5FC), fontSize: 12),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDial(HourFormat.HH),
            _buildDial(HourFormat.H),
            _buildDial(HourFormat.h),
          ],
        ),
        const SizedBox(height: 12),
        _buildDialLegend(),
      ],
    ),
  );
}

Widget _buildDial(HourFormat fmt) {
  const dialSize = 110.0;
  const radius = 46.0;
  // For HH/H -> 24 marks, for h -> 12 marks.
  final count = fmt == HourFormat.h ? 12 : 24;
  final faceColor = fmt == HourFormat.h
      ? const Color(0xFFFFF3E0)
      : const Color(0xFFE3F2FD);
  final tickColor = fmt == HourFormat.h
      ? const Color(0xFFB71C1C)
      : const Color(0xFF0D47A1);

  final positioned = <Widget>[];
  for (int i = 0; i < count; i++) {
    // 12 o'clock at top -> i=0 should be at top.
    final angle = (i / count) * 2 * 3.141592653589793 - (3.141592653589793 / 2);
    final dx = dialSize / 2 + radius * _cos(angle) - 8;
    final dy = dialSize / 2 + radius * _sin(angle) - 8;
    final label = fmt == HourFormat.h
        ? (i == 0 ? '12' : i.toString())
        : (fmt == HourFormat.HH ? i.toString().padLeft(2, '0') : i.toString());
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
              fontSize: fmt == HourFormat.HH ? 7 : 9,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }

  // Dial hand pointing at 9 (or 9 AM equivalent).
  const handAngleHour = 9;
  final handAngle = (handAngleHour / count) * 2 * 3.141592653589793
      - (3.141592653589793 / 2);
  positioned.add(
    Positioned(
      left: dialSize / 2 - 1,
      top: dialSize / 2 - radius * 0.7,
      child: Transform.rotate(
        angle: handAngle + 3.141592653589793 / 2,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 2,
          height: radius * 0.7,
          color: tickColor,
        ),
      ),
    ),
  );

  return Column(
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
        _shortLabel(fmt),
        style: const TextStyle(
          color: Color(0xFFFFF8E1),
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
          fontSize: 16,
        ),
      ),
      Text(
        fmt == HourFormat.h ? '12-hour face' : '24-hour face',
        style: const TextStyle(color: Color(0xFFB3E5FC), fontSize: 10),
      ),
    ],
  );
}

Widget _buildDialLegend() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Notes',
          style: TextStyle(
            color: Color(0xFFFFF8E1),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '• HH and H share a 24-tick face; only the rendered label differs.',
          style: TextStyle(color: Color(0xFFB3E5FC), fontSize: 11),
        ),
        Text(
          '• h uses a classic 12-tick face; AM/PM is shown elsewhere.',
          style: TextStyle(color: Color(0xFFB3E5FC), fontSize: 11),
        ),
        Text(
          '• Hand is pointing at the 9 o\'clock tick on every dial.',
          style: TextStyle(color: Color(0xFFB3E5FC), fontSize: 11),
        ),
      ],
    ),
  );
}

// Tiny power-series cos/sin so we don't pull dart:math into the script.
double _cos(double x) {
  // Reduce to [-pi, pi]
  const pi = 3.141592653589793;
  double a = x % (2 * pi);
  if (a > pi) a -= 2 * pi;
  if (a < -pi) a += 2 * pi;
  // 8-term Taylor series
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
// SECTION 7 — AM/PM marker card
// Palette: warm sunset
// ----------------------------------------------------------------------------

Widget _buildAmPmMarkerCard() {
  const bg = Color(0xFFFFF3E0);
  const morning = Color(0xFFFFB74D);
  const evening = Color(0xFF6A1B9A);
  const ink = Color(0xFF4E342E);

  final amTimes = <TimeOfDay>[
    const TimeOfDay(hour: 0, minute: 0),
    const TimeOfDay(hour: 6, minute: 30),
    const TimeOfDay(hour: 9, minute: 5),
    const TimeOfDay(hour: 11, minute: 59),
  ];
  final pmTimes = <TimeOfDay>[
    const TimeOfDay(hour: 12, minute: 0),
    const TimeOfDay(hour: 13, minute: 30),
    const TimeOfDay(hour: 17, minute: 45),
    const TimeOfDay(hour: 23, minute: 55),
  ];

  Widget marker(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget timeRow(TimeOfDay t) {
    final isAm = t.hour < 12;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              _formatTime(t, HourFormat.h),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ),
          marker(
            isAm ? 'AM' : 'PM',
            isAm ? morning : evening,
            isAm ? Icons.wb_sunny : Icons.brightness_3,
          ),
          const SizedBox(width: 10),
          Text(
            'h24=${t.hour.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: ink.withOpacity(0.7),
              fontFamily: 'monospace',
              fontSize: 12,
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
      border: Border.all(color: morning, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.brightness_5, color: morning, size: 22),
            SizedBox(width: 8),
            Text(
              '7. AM/PM marker (paired with h)',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'When using HourFormat.h, the AM/PM marker disambiguates which '
          'half of the day a given hour belongs to. Below: 24h hours split '
          'into AM and PM groups.',
          style: TextStyle(color: ink, fontSize: 12, height: 1.3),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: morning, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AM (h24 < 12)',
                      style: TextStyle(
                        color: morning,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ...amTimes.map(timeRow),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: evening, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PM (h24 >= 12)',
                      style: TextStyle(
                        color: evening,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ...pmTimes.map(timeRow),
                  ],
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
// SECTION 8 — Reference card
// Palette: paper / red ribbon
// ----------------------------------------------------------------------------

Widget _buildReferenceCard() {
  const paper = Color(0xFFFFFDE7);
  const ribbon = Color(0xFFC62828);
  const ink = Color(0xFF3E2723);

  Widget refRow(HourFormat fmt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
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
            width: 50,
            child: Text(
              fmt.name,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
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
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _whenItApplies(fmt),
                  style: TextStyle(
                    color: ink.withOpacity(0.75),
                    fontSize: 11.5,
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
            Container(
              width: 4,
              height: 22,
              color: ribbon,
            ),
            const SizedBox(width: 8),
            const Text(
              '8. Reference card',
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
          'index · name · explanation · when it applies',
          style: TextStyle(color: ink, fontSize: 11),
        ),
        const Divider(color: ribbon),
        ...HourFormat.values.map(refRow),
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
                'HH = h24.toString().padLeft(2, "0")',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'H  = h24.toString()',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
              Text(
                'h  = (h24 % 12 == 0 ? 12 : h24 % 12).toString()',
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
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
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'HourFormat deep demo · ${HourFormat.values.length} values · '
        '${_formatHourMinuteFromInt(13, 30, HourFormat.HH)} / '
        '${_formatHourMinuteFromInt(13, 30, HourFormat.H)} / '
        '${_formatHourMinuteFromInt(13, 30, HourFormat.h)}',
        style: const TextStyle(
          color: Color(0xFF607D8B),
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );
}
