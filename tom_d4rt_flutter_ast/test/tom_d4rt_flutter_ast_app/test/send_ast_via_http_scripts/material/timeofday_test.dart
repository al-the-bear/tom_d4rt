// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of TimeOfDay.
import 'package:flutter/material.dart';

const _showcaseTimes = <TimeOfDay>[
  TimeOfDay(hour: 0, minute: 0),
  TimeOfDay(hour: 6, minute: 30),
  TimeOfDay(hour: 9, minute: 15),
  TimeOfDay(hour: 12, minute: 0),
  TimeOfDay(hour: 13, minute: 45),
  TimeOfDay(hour: 18, minute: 5),
  TimeOfDay(hour: 23, minute: 59),
];

const _midnightInk = Color(0xFF1A1A2E);
const _twilightInk = Color(0xFF16213E);
const _dawnGold = Color(0xFFFFD27D);
const _noonAmber = Color(0xFFFFB300);
const _duskRose = Color(0xFFE57373);

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'TimeOfDay Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TimeOfDay Showcase'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildIntroCard(),
          _buildDigitalReadoutGrid(),
          _buildTwelveHourSection(context),
          _buildTwentyFourHourSection(),
          _buildPeriodSection(),
          _buildHourOfPeriodSection(),
          _buildReplacingSection(),
          _buildConstantsCard(),
          _buildClockFaceVisualization(),
          _buildGuidanceCard(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: Section header with gradient background and shadow.
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String title, String subtitle, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 12),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_midnightInk, _twilightInk],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_dawnGold, _noonAmber],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _noonAmber.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
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

// ---------------------------------------------------------------------------
// Helper: Paragraph card to explain a section.
// ---------------------------------------------------------------------------
Widget _buildParagraph(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.shade200, width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.5,
        height: 1.45,
        color: Colors.brown.shade800,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: pad an integer to two digits, written manually because d4rt sandbox
// keeps things explicit.
// ---------------------------------------------------------------------------
String _pad2(int value) {
  if (value < 10) {
    return '0$value';
  }
  return '$value';
}

// ---------------------------------------------------------------------------
// Helper: 24-hour HH:MM string from a TimeOfDay.
// ---------------------------------------------------------------------------
String _twentyFour(TimeOfDay t) {
  return '${_pad2(t.hour)}:${_pad2(t.minute)}';
}

// ---------------------------------------------------------------------------
// Helper: 12-hour H:MM AM/PM string from a TimeOfDay.
// ---------------------------------------------------------------------------
String _twelveHour(TimeOfDay t) {
  final int hour12 = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final String suffix = t.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour12:${_pad2(t.minute)} $suffix';
}

// ---------------------------------------------------------------------------
// Helper: friendly description of the period (morning, afternoon, ...).
// ---------------------------------------------------------------------------
String _periodWord(TimeOfDay t) {
  if (t.hour < 5) {
    return 'late night';
  }
  if (t.hour < 12) {
    return 'morning';
  }
  if (t.hour < 17) {
    return 'afternoon';
  }
  if (t.hour < 21) {
    return 'evening';
  }
  return 'night';
}

// ---------------------------------------------------------------------------
// Helper: pick a hue that softly maps to the time of day.
// ---------------------------------------------------------------------------
Color _tintFor(TimeOfDay t) {
  if (t.hour < 5) {
    return const Color(0xFF3F51B5);
  }
  if (t.hour < 9) {
    return const Color(0xFFFFB74D);
  }
  if (t.hour < 12) {
    return const Color(0xFFFFD54F);
  }
  if (t.hour < 14) {
    return const Color(0xFFFFB300);
  }
  if (t.hour < 18) {
    return const Color(0xFFFF8A65);
  }
  if (t.hour < 21) {
    return const Color(0xFFE57373);
  }
  return const Color(0xFF5C6BC0);
}

// ---------------------------------------------------------------------------
// Helper: build a tiny pill chip for inline labels.
// ---------------------------------------------------------------------------
Widget _pill(String label, Color color, {Color? textColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.35),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor ?? Colors.white,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 1. Intro card
// ---------------------------------------------------------------------------
Widget _buildIntroCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_midnightInk, _twilightInk, _midnightInk],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[_dawnGold, _noonAmber, _duskRose],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _noonAmber.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.access_time_filled,
                  color: Colors.white, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'TimeOfDay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Immutable hour and minute, free of dates and seconds.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Colors.white.withOpacity(0.18), width: 1),
          ),
          child: const Text(
            'TimeOfDay represents a wall-clock time independent of any calendar '
            'date. It exposes hour (0..23), minute (0..59), and a derived '
            'AM/PM period. This deep demo walks the API surface entirely from '
            'static, deterministic values to keep d4rt happy.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _pill('immutable', _dawnGold, textColor: _midnightInk),
            _pill('hour 0..23', _noonAmber),
            _pill('minute 0..59', _duskRose),
            _pill('AM / PM derived', Colors.indigo.shade300),
            _pill('locale-aware format()', Colors.teal.shade400),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 2. Digital readout grid: each TimeOfDay rendered as a fake LED display.
// ---------------------------------------------------------------------------
Widget _buildDigitalReadoutGrid() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'Digital Readouts',
        'Seven fixed times rendered as LED-style 24h displays.',
        Icons.dialpad,
      ),
      _buildParagraph(
        'Each card below is built from a constant TimeOfDay value. The hour '
        'and minute properties drive the digit text directly. The accent '
        'color is selected by a tiny lookup based on the hour, giving an '
        'immediate sense of where in the day the moment falls.',
      ),
      _digitalReadout(_showcaseTimes[0], 'Stroke of midnight'),
      _digitalReadout(_showcaseTimes[1], 'Early commute'),
      _digitalReadout(_showcaseTimes[2], 'Standup time'),
      _digitalReadout(_showcaseTimes[3], 'High noon'),
      _digitalReadout(_showcaseTimes[4], 'Post-lunch focus'),
      _digitalReadout(_showcaseTimes[5], 'Golden hour'),
      _digitalReadout(_showcaseTimes[6], 'A minute to midnight'),
    ],
  );
}

Widget _digitalReadout(TimeOfDay t, String caption) {
  final Color tint = _tintFor(t);
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          _midnightInk,
          tint.withOpacity(0.85),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withOpacity(0.35),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Text(
            _twentyFour(t),
            style: const TextStyle(
              color: Color(0xFFFFE082),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_periodWord(t)} \u00b7 ${_twelveHour(t)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 3. Twelve hour section: format(context) + locale-aware demo.
// ---------------------------------------------------------------------------
Widget _buildTwelveHourSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'Twelve-hour Formatting',
        'TimeOfDay.format(context) honors the ambient MaterialLocalizations.',
        Icons.schedule,
      ),
      _buildParagraph(
        'Calling format(BuildContext) hands the TimeOfDay over to the active '
        'MaterialLocalizations, which renders it according to the locale '
        'setting. Below we mix the locale-aware string with a hand-rolled '
        '12-hour fallback so you can see both sit side by side.',
      ),
      _twelveHourRow(context, _showcaseTimes[0]),
      _twelveHourRow(context, _showcaseTimes[1]),
      _twelveHourRow(context, _showcaseTimes[2]),
      _twelveHourRow(context, _showcaseTimes[3]),
      _twelveHourRow(context, _showcaseTimes[4]),
      _twelveHourRow(context, _showcaseTimes[5]),
      _twelveHourRow(context, _showcaseTimes[6]),
    ],
  );
}

Widget _twelveHourRow(BuildContext context, TimeOfDay t) {
  final String localized = t.format(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withOpacity(0.18),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _tintFor(t).withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _twentyFour(t),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _tintFor(t),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _twelveHour(t),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'localized: $localized',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        _pill(
          t.period == DayPeriod.am ? 'AM' : 'PM',
          t.period == DayPeriod.am
              ? Colors.indigo.shade400
              : Colors.deepOrange.shade400,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 4. Twenty-four hour section: side-by-side comparison table.
// ---------------------------------------------------------------------------
Widget _buildTwentyFourHourSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        '12h vs 24h Side By Side',
        'Comparing wall-clock conventions for the same TimeOfDay values.',
        Icons.compare_arrows,
      ),
      _buildParagraph(
        'TimeOfDay itself stores a 24-hour value: hour ranges 0..23. '
        'Switching between conventions is purely a presentation concern. '
        'The comparison table below shows the same constant moments in both '
        'flavors so the mapping becomes visually obvious.',
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _comparisonHeaderRow(),
            _comparisonRow(_showcaseTimes[0]),
            _comparisonRow(_showcaseTimes[1]),
            _comparisonRow(_showcaseTimes[2]),
            _comparisonRow(_showcaseTimes[3]),
            _comparisonRow(_showcaseTimes[4]),
            _comparisonRow(_showcaseTimes[5]),
            _comparisonRow(_showcaseTimes[6]),
          ],
        ),
      ),
    ],
  );
}

Widget _comparisonHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade700, Colors.amber.shade500],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            '24h',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            '12h',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'period',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(TimeOfDay t) {
  final Color tint = _tintFor(t);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            _twentyFour(t),
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: tint,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            _twelveHour(t),
            style: const TextStyle(fontSize: 13.5),
          ),
        ),
        Expanded(
          flex: 3,
          child: _pill(
            t.period == DayPeriod.am ? 'am' : 'pm',
            t.period == DayPeriod.am
                ? Colors.indigo.shade400
                : Colors.deepOrange.shade400,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 5. Period (DayPeriod) section
// ---------------------------------------------------------------------------
Widget _buildPeriodSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'DayPeriod Enum',
        'The .period property splits the day into am and pm halves.',
        Icons.brightness_4,
      ),
      _buildParagraph(
        'TimeOfDay.period returns a DayPeriod value: am for 00:00..11:59, '
        'pm for 12:00..23:59. The enum values match common timepicker UI '
        'and are stable across locales. The two cards below summarize the '
        'split and tally how many of the showcase times fall into each '
        'half.',
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: _periodCard(
              'am',
              DayPeriod.am,
              Icons.brightness_5,
              const <Color>[Color(0xFFB39DDB), Color(0xFF7E57C2)],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _periodCard(
              'pm',
              DayPeriod.pm,
              Icons.brightness_3,
              const <Color>[Color(0xFFFFB74D), Color(0xFFE65100)],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      _periodTallyCard(),
    ],
  );
}

Widget _periodCard(
    String label, DayPeriod period, IconData icon, List<Color> gradient) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: gradient[1].withOpacity(0.4),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              'DayPeriod.$label',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          period == DayPeriod.am
              ? 'Hours 0..11 — the first half of the day, before noon.'
              : 'Hours 12..23 — the second half, from noon onward.',
          style: const TextStyle(color: Colors.white, fontSize: 12.5),
        ),
      ],
    ),
  );
}

Widget _periodTallyCard() {
  int amCount = 0;
  int pmCount = 0;
  for (int i = 0; i < _showcaseTimes.length; i++) {
    if (_showcaseTimes[i].period == DayPeriod.am) {
      amCount++;
    } else {
      pmCount++;
    }
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: _tallyBlock(
            'am',
            amCount,
            _showcaseTimes.length,
            Colors.indigo.shade400,
          ),
        ),
        Container(
          width: 1,
          height: 50,
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
        Expanded(
          child: _tallyBlock(
            'pm',
            pmCount,
            _showcaseTimes.length,
            Colors.deepOrange.shade400,
          ),
        ),
      ],
    ),
  );
}

Widget _tallyBlock(String label, int count, int total, Color color) {
  return Column(
    children: <Widget>[
      Text(
        '$count / $total',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'showcase times in $label',
        style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6. hourOfPeriod section: shows mapping from hour -> 1..12.
// ---------------------------------------------------------------------------
Widget _buildHourOfPeriodSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'hourOfPeriod & periodOffset',
        'Translating raw hour into a 12-hour clock face index.',
        Icons.timeline,
      ),
      _buildParagraph(
        'hourOfPeriod returns hour modulo 12 (0..11). Combined with '
        'periodOffset (0 for am, 12 for pm) the original hour can be '
        'reconstructed: hour == hourOfPeriod + periodOffset. The matrix '
        'below makes that identity visible for each showcase time.',
      ),
      _hopRow(_showcaseTimes[0]),
      _hopRow(_showcaseTimes[1]),
      _hopRow(_showcaseTimes[2]),
      _hopRow(_showcaseTimes[3]),
      _hopRow(_showcaseTimes[4]),
      _hopRow(_showcaseTimes[5]),
      _hopRow(_showcaseTimes[6]),
    ],
  );
}

Widget _hopRow(TimeOfDay t) {
  final int sum = t.hourOfPeriod + t.periodOffset;
  final bool ok = sum == t.hour;
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.white,
          _tintFor(t).withOpacity(0.08),
        ],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Text(
            _twentyFour(t),
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: _tintFor(t),
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: <Widget>[
              _miniBadge('hour', '${t.hour}', Colors.blueGrey.shade400),
              _miniBadge('hourOfPeriod', '${t.hourOfPeriod}',
                  Colors.teal.shade400),
              _miniBadge('periodOffset', '${t.periodOffset}',
                  Colors.purple.shade400),
              _miniBadge('sum', '$sum',
                  ok ? Colors.green.shade500 : Colors.red.shade500),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _miniBadge(String key, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.4), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$key: ',
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 7. replacing() section: a pair of original -> replaced visualizations.
// ---------------------------------------------------------------------------
Widget _buildReplacingSection() {
  final TimeOfDay base = _showcaseTimes[2]; // 09:15
  final TimeOfDay r1 = base.replacing(hour: 14);
  final TimeOfDay r2 = base.replacing(minute: 0);
  final TimeOfDay r3 = base.replacing(hour: 22, minute: 30);
  final TimeOfDay r4 = _showcaseTimes[5].replacing(minute: 45); // 18:05 -> 18:45
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'TimeOfDay.replacing(...)',
        'Returning a fresh value with one or both fields swapped.',
        Icons.update,
      ),
      _buildParagraph(
        'replacing() never mutates the receiver. Both arguments are optional, '
        'so it is convenient for nudging just the hour, just the minute, or '
        'both at once. The arrows below trace several rewrites; each row '
        'preserves the original value unchanged.',
      ),
      _replacingRow(base, r1, 'replacing(hour: 14)'),
      _replacingRow(base, r2, 'replacing(minute: 0)'),
      _replacingRow(base, r3, 'replacing(hour: 22, minute: 30)'),
      _replacingRow(_showcaseTimes[5], r4, 'replacing(minute: 45)'),
    ],
  );
}

Widget _replacingRow(TimeOfDay before, TimeOfDay after, String label) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFECB3)],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withOpacity(0.18),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
            color: Colors.brown.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(child: _miniReadout(before)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child:
                  Icon(Icons.arrow_forward, color: Colors.deepOrange, size: 22),
            ),
            Expanded(child: _miniReadout(after)),
          ],
        ),
      ],
    ),
  );
}

Widget _miniReadout(TimeOfDay t) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_midnightInk, _tintFor(t).withOpacity(0.85)],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _tintFor(t).withOpacity(0.3),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Text(
          _twentyFour(t),
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFFFE082),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _twelveHour(t),
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 8. Constants card: minutesPerHour, hoursPerPeriod, hoursPerDay.
// ---------------------------------------------------------------------------
Widget _buildConstantsCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'Static Constants',
        'Helpful integer constants exposed by TimeOfDay.',
        Icons.straighten,
      ),
      _buildParagraph(
        'TimeOfDay exposes three integer constants that codify the shape of '
        'the wall clock. They are useful for arithmetic over hours and '
        'minutes without sprinkling magic numbers through your code.',
      ),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.amber.shade300),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.amber.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _constantRow('minutesPerHour', '${TimeOfDay.minutesPerHour}',
                'Minutes inside a single hour.'),
            const SizedBox(height: 8),
            _constantRow('hoursPerPeriod', '${TimeOfDay.hoursPerPeriod}',
                'Hours per AM or PM half.'),
            const SizedBox(height: 8),
            _constantRow('hoursPerDay', '${TimeOfDay.hoursPerDay}',
                'Hours from midnight to midnight.'),
          ],
        ),
      ),
    ],
  );
}

Widget _constantRow(String name, String value, String desc) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_dawnGold, _noonAmber],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.brown.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Clock face visualization: a Stack with 12 tick markers + hands.
// ---------------------------------------------------------------------------
Widget _buildClockFaceVisualization() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionHeader(
        'Static Clock Face',
        'Twelve fixed ticks rendered with Stack + Positioned children.',
        Icons.access_time,
      ),
      _buildParagraph(
        'A clock dial built entirely from boring rectangular Containers. The '
        'twelve hour markers and the highlighted "12 o\'clock" pointer are '
        'placed by hand into a Stack with explicit Positioned coordinates. '
        'No CustomPaint, no Transform.rotate, no animation: just static '
        'geometry that the d4rt sandbox is happy to evaluate.',
      ),
      Center(
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: <Color>[Color(0xFFFFFDE7), Color(0xFFFFE0B2)],
              radius: 0.85,
            ),
            border: Border.all(color: Colors.brown.shade400, width: 4),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.brown.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _tick(0, 12, true),
              _tick(1, 1, false),
              _tick(2, 2, false),
              _tick(3, 3, true),
              _tick(4, 4, false),
              _tick(5, 5, false),
              _tick(6, 6, true),
              _tick(7, 7, false),
              _tick(8, 8, false),
              _tick(9, 9, true),
              _tick(10, 10, false),
              _tick(11, 11, false),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: <Color>[_noonAmber, _midnightInk],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
      _buildClockLegend(),
    ],
  );
}

// Compute a position for a tick at index 0..11 on a 280x280 dial.
// Hard-coded radius math, no trig - the relative offsets are precomputed.
Widget _tick(int index, int label, bool emphasised) {
  final List<List<double>> offsets = <List<double>>[
    <double>[0, -120],     // 12 (top)
    <double>[60, -103.92], // 1
    <double>[103.92, -60], // 2
    <double>[120, 0],      // 3
    <double>[103.92, 60],  // 4
    <double>[60, 103.92],  // 5
    <double>[0, 120],      // 6
    <double>[-60, 103.92], // 7
    <double>[-103.92, 60], // 8
    <double>[-120, 0],     // 9
    <double>[-103.92, -60], // 10
    <double>[-60, -103.92], // 11
  ];
  final double dx = offsets[index][0];
  final double dy = offsets[index][1];
  return Positioned(
    left: 140 + dx - 16,
    top: 140 + dy - 16,
    child: Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: emphasised
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_noonAmber, _duskRose],
              )
            : LinearGradient(
                colors: <Color>[
                  Colors.white,
                  Colors.amber.shade100,
                ],
              ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: emphasised
                ? _noonAmber.withOpacity(0.5)
                : Colors.brown.withOpacity(0.18),
            blurRadius: emphasised ? 10 : 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: emphasised ? Colors.white : Colors.brown.shade300,
          width: 1.5,
        ),
      ),
      child: Text(
        '$label',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: emphasised ? 14 : 12,
          color: emphasised ? Colors.white : Colors.brown.shade700,
        ),
      ),
    ),
  );
}

Widget _buildClockLegend() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Wrap(
      spacing: 8,
      runSpacing: 6,
      children: <Widget>[
        _pill('cardinal hours', _noonAmber),
        _pill('quarter hours', Colors.brown.shade400),
        _pill('hub', _midnightInk),
        _pill('static dial', Colors.teal.shade400),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 10. Guidance card: closing notes for d4rt usage.
// ---------------------------------------------------------------------------
Widget _buildGuidanceCard() {
  return Container(
    margin: const EdgeInsets.only(top: 24, bottom: 16),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade300, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.green.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.lightbulb_outline,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'd4rt-friendly TimeOfDay tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _guidanceItem(
          Icons.check_circle,
          'Use TimeOfDay(hour: ..., minute: ...) — fully deterministic, '
          'safe inside the static sandbox.',
        ),
        _guidanceItem(
          Icons.cancel_outlined,
          'Avoid TimeOfDay.now(); the demo deliberately hardcodes seven '
          'showcase times instead.',
        ),
        _guidanceItem(
          Icons.compare_arrows,
          'Mix hour, minute, hourOfPeriod and periodOffset to derive 12h '
          'and 24h presentations without external libraries.',
        ),
        _guidanceItem(
          Icons.refresh,
          'replacing() makes nudging values painless and keeps the original '
          'instance untouched.',
        ),
        _guidanceItem(
          Icons.translate,
          'format(context) defers to MaterialLocalizations and produces a '
          'locale-respecting string — perfect for surfaces that need to '
          'follow user preferences.',
        ),
      ],
    ),
  );
}

Widget _guidanceItem(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Colors.green.shade700, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
      ],
    ),
  );
}
