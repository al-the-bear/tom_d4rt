// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for Material `DateUtils` and surrounding date helpers.
///
/// Sections:
///   1. Hero header with palette + reference epoch.
///   2. Method-by-method breakdown of the static `DateUtils` API.
///   3. Static calendar grid gallery built from `getDaysInMonth` and
///      `firstDayOffset`, showcasing leap-year vs. non-leap-year February,
///      31-day months, and the year boundary (Dec/Jan).
///   4. `DateTimeRange` viewer with start/end/duration breakdown.
///   5. `DatePickerEntryMode` and `DatePickerMode` enum tables.
///   6. `CalendarDatePicker` and `InputDatePickerFormField` static
///      instance galleries (try/catch wrapped).
///   7. `MaterialLocalizations` formatting cheat-sheet.
///   8. Comparison: DateUtils vs DateTime vs Duration.
///   9. Edge cases (month overflow, leap-year Feb 29, time-zone effects).
///  10. Footer.
dynamic build(BuildContext context) {
  // ===== Palette: dusk indigo -> teal pastel =====
  const Color cInk = Color(0xFF1B1B2F);
  const Color cMid = Color(0xFF3F3D56);
  const Color cAccent = Color(0xFF4B86B4);
  const Color cTeal = Color(0xFF2EC4B6);
  const Color cSand = Color(0xFFFFE9B0);
  const Color cBlush = Color(0xFFFFB5A7);
  const Color cMint = Color(0xFFCDEAC0);
  const Color cPaper = Color(0xFFF7F3E9);

  // Reference dates used throughout the demo.
  final DateTime epoch = DateTime(2024, 2, 14, 9, 30, 15, 250, 7);
  final DateTime epochOnly = DateUtils.dateOnly(epoch);
  final DateTime nextMonth = DateUtils.addMonthsToMonthDate(
    DateTime(epoch.year, epoch.month),
    1,
  );
  final DateTime plus10Days = DateUtils.addDaysToDate(epoch, 10);
  final DateTime fiveBefore = DateTime(2023, 9, 1);
  final DateTime fiveAfter = DateTime(2024, 2, 1);
  final int delta = DateUtils.monthDelta(fiveBefore, fiveAfter);
  final bool sameDayA = DateUtils.isSameDay(epoch, epochOnly);
  final bool sameDayB = DateUtils.isSameDay(epoch, plus10Days);
  final bool sameMonthA = DateUtils.isSameMonth(epoch, epochOnly);
  final bool sameMonthB = DateUtils.isSameMonth(epoch, nextMonth);
  final int daysInFeb24 = DateUtils.getDaysInMonth(2024, 2);
  final int daysInFeb23 = DateUtils.getDaysInMonth(2023, 2);
  final int daysInJan = DateUtils.getDaysInMonth(2024, 1);
  final int daysInApr = DateUtils.getDaysInMonth(2024, 4);
  final MaterialLocalizations loc = MaterialLocalizations.of(context);

  // DateTimeRange used by viewer + picker galleries.
  final DateTimeRange range = DateTimeRange(
    start: DateTime(2024, 1, 5),
    end: DateTime(2024, 3, 21),
  );
  // dateRangeStart/dateRangeEnd live on DateTimeRange itself (start/end);
  // we still demonstrate the date-only truncation path via `dateOnly`.
  final DateTime rangeStart = DateUtils.dateOnly(range.start);
  final DateTime rangeEnd = DateUtils.dateOnly(range.end);
  final Duration rangeDuration = range.duration;

  // ===== Hero header =====
  final Widget hero = Container(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cInk, cMid, cAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: cSand,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cBlush, width: 2),
              ),
              child: const Center(
                child: Icon(Icons.event_note, color: cInk, size: 26),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Material DateUtils',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'static helpers for date-only manipulation',
                    style: TextStyle(
                      color: cMint,
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            _pill('epoch', '$epoch', cTeal),
            const SizedBox(width: 6),
            _pill('dateOnly', '$epochOnly', cBlush),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            _pill('+10 days', '$plus10Days', cSand),
            const SizedBox(width: 6),
            _pill('+1 month', '$nextMonth', cMint),
          ],
        ),
      ],
    ),
  );

  // ===== Section 2: method-by-method breakdown =====
  final List<List<String>> methodRows = <List<String>>[
    <String>['dateOnly(dt)', 'strip h/m/s/ms', '$epochOnly'],
    <String>['isSameDay(a,b)', 'a/b same calendar day', '$sameDayA / $sameDayB'],
    <String>['isSameMonth(a,b)', 'a/b same month+year', '$sameMonthA / $sameMonthB'],
    <String>['monthDelta(a,b)', 'months from Sep23 -> Feb24', '$delta'],
    <String>['addMonthsToMonthDate', 'epoch month + 1', '$nextMonth'],
    <String>['addDaysToDate', 'epoch + 10 days', '$plus10Days'],
    <String>['getDaysInMonth(2024,2)', 'leap-year February', '$daysInFeb24'],
    <String>['getDaysInMonth(2023,2)', 'non-leap February', '$daysInFeb23'],
    <String>['getDaysInMonth(2024,1)', '31-day January', '$daysInJan'],
    <String>['getDaysInMonth(2024,4)', '30-day April', '$daysInApr'],
    <String>['dateOnly(r.start)', 'truncated range start', '$rangeStart'],
    <String>['dateOnly(r.end)', 'truncated range end', '$rangeEnd'],
  ];
  final List<Widget> methodCards = <Widget>[];
  for (int i = 0; i < methodRows.length; i++) {
    final List<String> row = methodRows[i];
    final Color tone = i.isEven ? cMint : cSand;
    methodCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cMid.withValues(alpha: 0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 140,
              child: Text(
                row[0],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: cInk,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 2,
              child: Text(
                row[1],
                style: const TextStyle(fontSize: 10, color: cMid),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 3,
              child: Text(
                row[2],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                  color: cInk,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section2 = _section(
    'Section 2 // DateUtils method reference',
    cAccent,
    cPaper,
    Column(children: methodCards),
  );

  // ===== Section 3: static calendar grid gallery =====
  final List<List<int>> calMonths = <List<int>>[
    <int>[2024, 2], // leap-year February
    <int>[2023, 2], // non-leap February
    <int>[2024, 1], // 31-day January
    <int>[2024, 4], // 30-day April
    <int>[2024, 12], // year boundary
    <int>[2025, 1], // following year start
    <int>[2000, 2], // century-divisible-by-400 leap year
    <int>[1900, 2], // century non-leap year
    <int>[2024, 7], // July (mid-year, 31 days)
    <int>[2024, 8], // August (31 days, back-to-back long months)
  ];
  final List<Widget> calendars = <Widget>[];
  for (int m = 0; m < calMonths.length; m++) {
    final int yr = calMonths[m][0];
    final int mo = calMonths[m][1];
    int days = 30;
    int offset = 0;
    String err = '';
    try {
      days = DateUtils.getDaysInMonth(yr, mo);
      offset = DateUtils.firstDayOffset(yr, mo, loc);
    } catch (e) {
      err = e.toString();
    }
    final List<Widget> cells = <Widget>[];
    // Weekday header row (Sun-Sat).
    const List<String> head = <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    for (int h = 0; h < head.length; h++) {
      cells.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cInk.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            head[h],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    // Leading blanks.
    for (int b = 0; b < offset; b++) {
      cells.add(const SizedBox.shrink());
    }
    // Day cells.
    for (int d = 1; d <= days; d++) {
      final bool isLeapEdge = (yr == 2024 && mo == 2 && d == 29);
      cells.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isLeapEdge
                ? cBlush.withValues(alpha: 0.9)
                : cMint.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '$d',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: isLeapEdge ? FontWeight.bold : FontWeight.normal,
              color: cInk,
            ),
          ),
        ),
      );
    }
    calendars.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cAccent.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: cAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$yr-${mo.toString().padLeft(2, "0")}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'days=$days  offset=$offset',
                  style: const TextStyle(fontSize: 10, color: cMid),
                ),
                if (err.isNotEmpty)
                  Expanded(
                    child: Text(
                      ' ERR: $err',
                      style: const TextStyle(fontSize: 9, color: Colors.red),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1.6,
              children: cells,
            ),
          ],
        ),
      ),
    );
  }
  final Widget section3 = _section(
    'Section 3 // calendar grid via getDaysInMonth + firstDayOffset',
    cTeal,
    cPaper,
    Column(children: calendars),
  );

  // ===== Section 4: DateTimeRange viewer =====
  final Widget section4 = _section(
    'Section 4 // DateTimeRange',
    cBlush,
    cPaper,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _kv('range.start', '${range.start}', cInk, cMint),
        _kv('range.end', '${range.end}', cInk, cMint),
        _kv('dateRangeStart', '$rangeStart', cInk, cSand),
        _kv('dateRangeEnd', '$rangeEnd', cInk, cSand),
        _kv(
          'duration',
          '${rangeDuration.inDays} d / ${rangeDuration.inHours} h',
          cInk,
          cBlush,
        ),
        _kv(
          'duration.toString',
          rangeDuration.toString(),
          cInk,
          cBlush,
        ),
      ],
    ),
  );

  // ===== Section 5: enum tables =====
  final List<List<String>> entryRows = <List<String>>[
    <String>['calendar', 'show calendar grid'],
    <String>['input', 'show text input field'],
    <String>['calendarOnly', 'lock to calendar'],
    <String>['inputOnly', 'lock to input'],
  ];
  final List<List<String>> modeRows = <List<String>>[
    <String>['day', 'day-grid mode'],
    <String>['year', 'year-list mode'],
  ];
  final List<Widget> entryWidgets = <Widget>[];
  for (int i = 0; i < DatePickerEntryMode.values.length && i < entryRows.length; i++) {
    final DatePickerEntryMode v = DatePickerEntryMode.values[i];
    entryWidgets.add(_enumRow(v.name, entryRows[i][1], cAccent));
  }
  final List<Widget> modeWidgets = <Widget>[];
  for (int i = 0; i < DatePickerMode.values.length && i < modeRows.length; i++) {
    final DatePickerMode v = DatePickerMode.values[i];
    modeWidgets.add(_enumRow(v.name, modeRows[i][1], cTeal));
  }
  final Widget section5 = _section(
    'Section 5 // DatePickerEntryMode + DatePickerMode',
    cMint,
    cPaper,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'DatePickerEntryMode',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Column(children: entryWidgets),
        const SizedBox(height: 8),
        const Text(
          'DatePickerMode',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Column(children: modeWidgets),
      ],
    ),
  );

  // ===== Section 6: CalendarDatePicker static gallery =====
  final List<Widget> calPickerCards = <Widget>[];
  final List<List<DateTime>> pickerCfg = <List<DateTime>>[
    <DateTime>[DateTime(2024, 2, 29), DateTime(2024, 1, 1), DateTime(2024, 12, 31)],
    <DateTime>[DateTime(2024, 6, 15), DateTime(2024, 1, 1), DateTime(2025, 12, 31)],
    <DateTime>[DateTime(2025, 1, 1), DateTime(2024, 1, 1), DateTime(2025, 12, 31)],
  ];
  for (int i = 0; i < pickerCfg.length; i++) {
    final DateTime initial = pickerCfg[i][0];
    final DateTime first = pickerCfg[i][1];
    final DateTime last = pickerCfg[i][2];
    Widget child;
    try {
      child = CalendarDatePicker(
        initialDate: initial,
        firstDate: first,
        lastDate: last,
        onDateChanged: (DateTime _) {},
      );
    } catch (e) {
      child = Text('error: $e', style: const TextStyle(color: Colors.red));
    }
    calPickerCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cTeal.withValues(alpha: 0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CalendarDatePicker  initial=$initial',
              style: const TextStyle(fontSize: 10, color: cMid),
            ),
            const SizedBox(height: 4),
            SizedBox(height: 280, child: child),
          ],
        ),
      ),
    );
  }
  final Widget section6 = _section(
    'Section 6 // CalendarDatePicker (static gallery)',
    cAccent,
    cPaper,
    Column(children: calPickerCards),
  );

  // ===== Section 7: InputDatePickerFormField gallery =====
  final List<Widget> inputCards = <Widget>[];
  for (int i = 0; i < pickerCfg.length; i++) {
    final DateTime initial = pickerCfg[i][0];
    final DateTime first = pickerCfg[i][1];
    final DateTime last = pickerCfg[i][2];
    Widget child;
    try {
      child = InputDatePickerFormField(
        initialDate: initial,
        firstDate: first,
        lastDate: last,
        fieldLabelText: 'Pick date #$i',
      );
    } catch (e) {
      child = Text('error: $e', style: const TextStyle(color: Colors.red));
    }
    inputCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cSand.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cBlush.withValues(alpha: 0.6)),
        ),
        child: child,
      ),
    );
  }
  final Widget section7 = _section(
    'Section 7 // InputDatePickerFormField (static gallery)',
    cBlush,
    cPaper,
    Column(children: inputCards),
  );

  // ===== Section 8: MaterialLocalizations format cheat sheet =====
  String fc = '';
  String ff = '';
  String fm = '';
  String fmy = '';
  String fdec = '';
  try {
    fc = loc.formatCompactDate(epoch);
    ff = loc.formatFullDate(epoch);
    fm = loc.formatMediumDate(epoch);
    fmy = loc.formatMonthYear(epoch);
    fdec = loc.formatDecimal(2024);
  } catch (e) {
    fc = 'err: $e';
  }
  final Widget section8 = _section(
    'Section 8 // MaterialLocalizations format cheat sheet',
    cSand,
    cPaper,
    Column(
      children: <Widget>[
        _kv('formatCompactDate', fc, cInk, cMint),
        _kv('formatFullDate', ff, cInk, cMint),
        _kv('formatMediumDate', fm, cInk, cSand),
        _kv('formatMonthYear', fmy, cInk, cSand),
        _kv('formatDecimal(2024)', fdec, cInk, cBlush),
      ],
    ),
  );

  // ===== Section 9: DateUtils vs DateTime vs Duration =====
  final List<List<String>> cmpRows = <List<String>>[
    <String>['DateUtils', 'static date-only utilities (no time)'],
    <String>['DateTime', 'instantaneous moment incl. time + tz'],
    <String>['Duration', 'span between moments (microseconds)'],
    <String>['DateTimeRange', 'pair of DateTimes (start/end)'],
  ];
  final List<Widget> cmpWidgets = <Widget>[];
  for (int i = 0; i < cmpRows.length; i++) {
    cmpWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: <Widget>[
            Container(
              width: 110,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: cMid,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cmpRows[i][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                cmpRows[i][1],
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section9 = _section(
    'Section 9 // comparison',
    cTeal,
    cPaper,
    Column(children: cmpWidgets),
  );

  // ===== Section 10: edge cases =====
  // addMonthsToMonthDate from Jan(31) + 1 -> Feb (intentionally month-only).
  final DateTime jan31 = DateTime(2024, 1, 31);
  final DateTime jan31MonthOnly = DateTime(jan31.year, jan31.month);
  final DateTime febFromJan = DateUtils.addMonthsToMonthDate(jan31MonthOnly, 1);
  // Leap-year Feb 29 sanity.
  final bool feb29Leap = DateUtils.getDaysInMonth(2024, 2) == 29;
  // Time-zone effect on dateOnly (UTC vs local).
  final DateTime utcMidnight = DateTime.utc(2024, 6, 1, 0, 30);
  final DateTime utcAsLocal = utcMidnight.toLocal();
  final DateTime utcDateOnly = DateUtils.dateOnly(utcAsLocal);
  final Widget section10 = _section(
    'Section 10 // edge cases',
    cBlush,
    cPaper,
    Column(
      children: <Widget>[
        _kv('addMonths(Jan2024,1)', '$febFromJan', cInk, cMint),
        _kv('Feb-29 leap?', '$feb29Leap', cInk, cSand),
        _kv('utcMidnight', '$utcMidnight', cInk, cBlush),
        _kv('utcAsLocal', '$utcAsLocal', cInk, cMint),
        _kv('utcDateOnly', '$utcDateOnly', cInk, cSand),
      ],
    ),
  );

  // ===== Section 11: weekday distribution (DateTime.weekday + DateUtils) =====
  // For a fixed month, show how many of each weekday occur.
  final List<int> weekdayCounts = <int>[0, 0, 0, 0, 0, 0, 0];
  const List<String> weekdayNames = <String>[
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];
  final int distYear = 2024;
  final int distMonth = 3;
  int distDays = 31;
  try {
    distDays = DateUtils.getDaysInMonth(distYear, distMonth);
  } catch (_) {
    distDays = 31;
  }
  for (int d = 1; d <= distDays; d++) {
    final DateTime cur = DateTime(distYear, distMonth, d);
    final int wd = cur.weekday; // 1=Mon ... 7=Sun
    weekdayCounts[wd - 1] = weekdayCounts[wd - 1] + 1;
  }
  final List<Widget> wdRows = <Widget>[];
  int maxCount = 1;
  for (int i = 0; i < weekdayCounts.length; i++) {
    if (weekdayCounts[i] > maxCount) {
      maxCount = weekdayCounts[i];
    }
  }
  for (int i = 0; i < weekdayCounts.length; i++) {
    final int c = weekdayCounts[i];
    final double frac = c / maxCount;
    wdRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 36,
              child: Text(
                weekdayNames[i],
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: cMid.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: frac,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: cAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 24,
              child: Text(
                '$c',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section11 = _section(
    'Section 11 // weekday distribution March 2024',
    cTeal,
    cPaper,
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'count of each weekday in the month',
          style: TextStyle(fontSize: 11, color: cMid, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 6),
        Column(children: wdRows),
      ],
    ),
  );

  // ===== Section 12: DateTime arithmetic primer (sanity) =====
  // Walk a few combined uses of DateUtils + DateTime arithmetic.
  final List<List<String>> primerRows = <List<String>>[];
  final DateTime base = DateTime(2024, 5, 15, 14, 30);
  primerRows.add(<String>['base', '$base']);
  primerRows.add(<String>['dateOnly(base)', '${DateUtils.dateOnly(base)}']);
  primerRows.add(<String>[
    'addDays(base,7)',
    '${DateUtils.addDaysToDate(base, 7)}',
  ]);
  primerRows.add(<String>[
    'addMonths(monthOf(base),3)',
    '${DateUtils.addMonthsToMonthDate(DateTime(base.year, base.month), 3)}',
  ]);
  primerRows.add(<String>[
    'addDays(base,-30)',
    '${DateUtils.addDaysToDate(base, -30)}',
  ]);
  primerRows.add(<String>[
    'monthDelta(Jan2020,Dec2024)',
    '${DateUtils.monthDelta(DateTime(2020, 1), DateTime(2024, 12))}',
  ]);
  primerRows.add(<String>[
    'isSameDay(base,base+1d)',
    '${DateUtils.isSameDay(base, DateUtils.addDaysToDate(base, 1))}',
  ]);
  primerRows.add(<String>[
    'isSameMonth(base,base+30d)',
    '${DateUtils.isSameMonth(base, DateUtils.addDaysToDate(base, 30))}',
  ]);
  final List<Widget> primerWidgets = <Widget>[];
  for (int i = 0; i < primerRows.length; i++) {
    final Color tone = i.isEven ? cMint : cSand;
    primerWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                primerRows[i][0],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: cInk,
                ),
              ),
            ),
            Expanded(
              child: Text(
                primerRows[i][1],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: cInk,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section12 = _section(
    'Section 12 // DateTime arithmetic primer',
    cAccent,
    cPaper,
    Column(children: primerWidgets),
  );

  // ===== Section 13: showDatePicker / showDateRangePicker signature notes =====
  final List<List<String>> sigRows = <List<String>>[
    <String>['showDatePicker', 'modal calendar/input picker'],
    <String>['showDateRangePicker', 'modal date-range picker'],
    <String>['initialEntryMode', 'DatePickerEntryMode.calendar (default)'],
    <String>['initialDatePickerMode', 'DatePickerMode.day (default)'],
    <String>['firstDate', 'earliest selectable DateTime'],
    <String>['lastDate', 'latest selectable DateTime'],
    <String>['selectableDayPredicate', 'bool Function(DateTime)'],
    <String>['confirmText / cancelText', 'override action labels'],
    <String>['errorFormatText', 'shown for invalid input'],
    <String>['errorInvalidText', 'shown for out-of-range input'],
  ];
  final List<Widget> sigWidgets = <Widget>[];
  for (int i = 0; i < sigRows.length; i++) {
    sigWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        child: Row(
          children: <Widget>[
            Container(
              width: 170,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: cInk,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                sigRows[i][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                sigRows[i][1],
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section13 = _section(
    'Section 13 // picker function signatures',
    cBlush,
    cPaper,
    Column(children: sigWidgets),
  );

  // ===== Section 14: months-of-year cheat sheet =====
  // For each calendar month of 2024, list the day count and the
  // weekday on which the 1st falls (Sun=0 by convention used here).
  final List<Widget> moyRows = <Widget>[];
  const List<String> monthNames = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  for (int m = 1; m <= 12; m++) {
    int dim = 30;
    int fdo = 0;
    String tag = '';
    try {
      dim = DateUtils.getDaysInMonth(2024, m);
      fdo = DateUtils.firstDayOffset(2024, m, loc);
    } catch (e) {
      tag = 'err';
    }
    final Color tone = (m % 3 == 0)
        ? cMint
        : (m % 3 == 1)
            ? cSand
            : cBlush;
    moyRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 36,
              child: Text(
                monthNames[m - 1],
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: cInk,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                'days=$dim',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: cInk,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                'firstDayOffset=$fdo',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: cInk,
                ),
              ),
            ),
            if (tag.isNotEmpty)
              Text(
                tag,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
  final Widget section14 = _section(
    'Section 14 // 2024 month-by-month cheat sheet',
    cAccent,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: moyRows),
  );

  // ===== Section 15: leap-year detection across decades =====
  // DateUtils.getDaysInMonth implicitly encodes leap-year logic.
  final List<int> leapYears = <int>[
    1900, 1904, 1996, 2000, 2001, 2004, 2024, 2025, 2100, 2400,
  ];
  final List<Widget> leapRows = <Widget>[];
  for (int i = 0; i < leapYears.length; i++) {
    final int yr = leapYears[i];
    int feb = 28;
    try {
      feb = DateUtils.getDaysInMonth(yr, 2);
    } catch (_) {
      feb = -1;
    }
    final bool isLeap = feb == 29;
    leapRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 60,
              child: Text(
                '$yr',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isLeap ? cTeal : cMid.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isLeap ? 'LEAP (29)' : 'non-leap (28)',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isLeap
                    ? 'div by 4 and (not 100 or div by 400)'
                    : 'fails Gregorian leap-year rule',
                style: const TextStyle(fontSize: 10, color: cMid),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section15 = _section(
    'Section 15 // leap-year detection via getDaysInMonth',
    cTeal,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: leapRows),
  );

  // ===== Section 16: format matrix across multiple sample dates =====
  final List<DateTime> samples = <DateTime>[
    DateTime(2024, 1, 1),
    DateTime(2024, 2, 29),
    DateTime(2024, 7, 4),
    DateTime(2024, 12, 25),
    DateTime(2025, 6, 30),
  ];
  final List<Widget> matrixRows = <Widget>[];
  matrixRows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: cInk,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 92,
            child: Text(
              'date',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 84,
            child: Text(
              'compact',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'medium',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'full',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < samples.length; i++) {
    final DateTime s = samples[i];
    String c = '';
    String m = '';
    String f = '';
    try {
      c = loc.formatCompactDate(s);
      m = loc.formatMediumDate(s);
      f = loc.formatFullDate(s);
    } catch (e) {
      c = 'err';
    }
    final Color tone = i.isEven ? cMint : cSand;
    matrixRows.add(
      Container(
        margin: const EdgeInsets.only(top: 3),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 92,
              child: Text(
                '${s.year}-${s.month.toString().padLeft(2, "0")}-${s.day.toString().padLeft(2, "0")}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                ),
              ),
            ),
            SizedBox(
              width: 84,
              child: Text(
                c,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                m,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                f,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section16 = _section(
    'Section 16 // format matrix',
    cBlush,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: matrixRows),
  );

  // ===== Section 17: DateTimeRange.toString + helpers =====
  final List<DateTimeRange> ranges = <DateTimeRange>[
    DateTimeRange(start: DateTime(2024, 1, 1), end: DateTime(2024, 1, 31)),
    DateTimeRange(start: DateTime(2024, 2, 1), end: DateTime(2024, 2, 29)),
    DateTimeRange(start: DateTime(2024, 1, 1), end: DateTime(2024, 12, 31)),
    DateTimeRange(start: DateTime(2024, 6, 15), end: DateTime(2024, 6, 15)),
  ];
  final List<Widget> rangeRows = <Widget>[];
  for (int i = 0; i < ranges.length; i++) {
    final DateTimeRange r = ranges[i];
    final Duration d = r.duration;
    rangeRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: cMint.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'r#$i  ${r.start.toIso8601String().substring(0, 10)} -> ${r.end.toIso8601String().substring(0, 10)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'duration ${d.inDays}d (${d.inHours}h, ${d.inMinutes}m)',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section17 = _section(
    'Section 17 // DateTimeRange catalog',
    cSand,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rangeRows),
  );

  // ===== Section 18: addMonthsToMonthDate negative + zero deltas =====
  final List<int> deltas = <int>[-24, -12, -6, -3, -1, 0, 1, 3, 6, 12, 24];
  final DateTime anchor = DateTime(2024, 6); // June 2024
  final List<Widget> deltaRows = <Widget>[];
  for (int i = 0; i < deltas.length; i++) {
    final int d = deltas[i];
    DateTime result = anchor;
    String marker = '';
    try {
      result = DateUtils.addMonthsToMonthDate(anchor, d);
    } catch (e) {
      marker = ' (err: $e)';
    }
    final bool zero = d == 0;
    final bool negative = d < 0;
    final Color tone = zero
        ? cInk
        : negative
            ? cBlush
            : cTeal;
    deltaRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Container(
              width: 56,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                d >= 0 ? '+$d' : '$d',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'June 2024 + $d months -> ${result.year}-${result.month.toString().padLeft(2, "0")}$marker',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section18 = _section(
    'Section 18 // addMonthsToMonthDate delta sweep',
    cMid,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: deltaRows),
  );

  // ===== Section 19: addDaysToDate sweep with weekday tags =====
  final List<int> daySweeps = <int>[-30, -14, -7, -1, 0, 1, 7, 14, 30, 60, 90];
  const List<String> wdShort = <String>[
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];
  final DateTime dayAnchor = DateTime(2024, 6, 15);
  final List<Widget> dayRows = <Widget>[];
  for (int i = 0; i < daySweeps.length; i++) {
    final int d = daySweeps[i];
    DateTime res = dayAnchor;
    try {
      res = DateUtils.addDaysToDate(dayAnchor, d);
    } catch (_) {
      res = dayAnchor;
    }
    final String wname = wdShort[res.weekday - 1];
    final Color tone = (i % 2 == 0) ? cMint : cSand;
    dayRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Text(
                d >= 0 ? '+$d d' : '$d d',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                '${res.year}-${res.month.toString().padLeft(2, "0")}-${res.day.toString().padLeft(2, "0")}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: cAccent,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                wname,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 9.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget section19 = _section(
    'Section 19 // addDaysToDate sweep with weekday',
    cTeal,
    cPaper,
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: dayRows),
  );

  // ===== Footer =====
  final Widget footer = Container(
    padding: const EdgeInsets.all(14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cMid, cInk],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ),
    child: Row(
      children: const <Widget>[
        Icon(Icons.calendar_view_month, color: cTeal, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'DateUtils — static helpers for calendar arithmetic, '
            'designed for Material date pickers.',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );

  // ===== Compose =====
  return Scaffold(
    backgroundColor: cPaper,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          hero,
          const SizedBox(height: 10),
          section2,
          const SizedBox(height: 10),
          section3,
          const SizedBox(height: 10),
          section4,
          const SizedBox(height: 10),
          section5,
          const SizedBox(height: 10),
          section6,
          const SizedBox(height: 10),
          section7,
          const SizedBox(height: 10),
          section8,
          const SizedBox(height: 10),
          section9,
          const SizedBox(height: 10),
          section10,
          const SizedBox(height: 10),
          section11,
          const SizedBox(height: 10),
          section12,
          const SizedBox(height: 10),
          section13,
          const SizedBox(height: 10),
          section14,
          const SizedBox(height: 10),
          section15,
          const SizedBox(height: 10),
          section16,
          const SizedBox(height: 10),
          section17,
          const SizedBox(height: 10),
          section18,
          const SizedBox(height: 10),
          section19,
          const SizedBox(height: 10),
          footer,
        ],
      ),
    ),
  );
}

// ===== Helpers =====

Widget _section(String title, Color stripeColor, Color bgColor, Widget child) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: stripeColor.withValues(alpha: 0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: stripeColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(10), child: child),
      ],
    ),
  );
}

Widget _pill(String key, String val, Color tint) {
  return Flexible(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$key: ',
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B1B2F),
            ),
          ),
          Flexible(
            child: Text(
              val,
              style: const TextStyle(
                fontSize: 9,
                fontFamily: 'monospace',
                color: Color(0xFF1B1B2F),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _kv(String k, String v, Color textColor, Color tone) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            k,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.5,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _enumRow(String name, String desc, Color tone) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: tone,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
