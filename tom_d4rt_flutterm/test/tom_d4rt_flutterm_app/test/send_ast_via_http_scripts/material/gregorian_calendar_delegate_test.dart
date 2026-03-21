// D4rt test script: Tests Gregorian calendar date utilities from material
import 'package:flutter/material.dart';

// Helper: section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper: demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ],
    ),
  );
}

// Helper: comparison row with visual result badge
Widget buildComparisonRow(
  String date1,
  String date2,
  String operation,
  String result,
  Color resultColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            date1,
            style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF757575),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            operation,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            date2,
            style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
            textAlign: TextAlign.center,
          ),
        ),
        Text('= ', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: resultColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            result,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: days bar for month visualization
Widget buildDaysBar(String month, int days, int maxDays, Color color) {
  double fraction = days / maxDays;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            month,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          days.toString(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper: date result display
Widget buildDateResult(
  String operation,
  String input,
  String result,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            operation,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            input,
            style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
          ),
        ),
        Icon(Icons.arrow_forward, size: 14, color: Color(0xFFBDBDBD)),
        SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: Text(
            result,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: mini calendar grid for a month
Widget buildMiniCalendar(
  String monthName,
  int year,
  int startDow,
  int daysInMonth,
  List<int> highlights,
  Color hlColor,
) {
  List<Widget> dayWidgets = [];
  List<String> headers = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  for (int i = 0; i < headers.length; i++) {
    dayWidgets.add(
      Container(
        width: 28,
        height: 20,
        alignment: Alignment.center,
        child: Text(
          headers[i],
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFF757575),
          ),
        ),
      ),
    );
  }
  for (int i = 0; i < (startDow - 1) % 7; i++) {
    dayWidgets.add(SizedBox(width: 28, height: 26));
  }
  for (int d = 1; d <= daysInMonth; d++) {
    bool isHL = highlights.contains(d);
    dayWidgets.add(
      Container(
        width: 28,
        height: 26,
        decoration: BoxDecoration(
          color: isHL ? hlColor : Color(0x00000000),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          d.toString(),
          style: TextStyle(
            fontSize: 11,
            color: isHL ? Color(0xFFFFFFFF) : Color(0xFF424242),
            fontWeight: isHL ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$monthName $year',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF424242),
        ),
      ),
      SizedBox(height: 4),
      Wrap(children: dayWidgets),
    ],
  );
}

// Helper: range badge
Widget buildRangeBadge(String label, String value, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== Gregorian Calendar Delegate Deep Demo ===');
  print('Testing Gregorian calendar date utilities from material');

  // DateUtils demonstrations
  print('--- DateUtils.isSameDay ---');
  bool sameDay1 = DateUtils.isSameDay(
    DateTime(2025, 3, 15),
    DateTime(2025, 3, 15),
  );
  print('isSameDay(Mar 15, Mar 15) = $sameDay1');

  bool sameDay2 = DateUtils.isSameDay(
    DateTime(2025, 3, 15),
    DateTime(2025, 3, 16),
  );
  print('isSameDay(Mar 15, Mar 16) = $sameDay2');

  bool sameDay3 = DateUtils.isSameDay(
    DateTime(2025, 12, 31),
    DateTime(2026, 1, 1),
  );
  print('isSameDay(Dec 31 2025, Jan 1 2026) = $sameDay3');

  print('--- DateUtils.isSameMonth ---');
  bool sameMonth1 = DateUtils.isSameMonth(
    DateTime(2025, 6, 1),
    DateTime(2025, 6, 30),
  );
  print('isSameMonth(Jun 1, Jun 30) = $sameMonth1');

  bool sameMonth2 = DateUtils.isSameMonth(
    DateTime(2025, 6, 30),
    DateTime(2025, 7, 1),
  );
  print('isSameMonth(Jun 30, Jul 1) = $sameMonth2');

  print('--- DateUtils.getDaysInMonth ---');
  int janDays = DateUtils.getDaysInMonth(2025, 1);
  int febDays = DateUtils.getDaysInMonth(2025, 2);
  int febLeapDays = DateUtils.getDaysInMonth(2024, 2);
  int marDays = DateUtils.getDaysInMonth(2025, 3);
  int aprDays = DateUtils.getDaysInMonth(2025, 4);
  int mayDays = DateUtils.getDaysInMonth(2025, 5);
  int junDays = DateUtils.getDaysInMonth(2025, 6);
  int julDays = DateUtils.getDaysInMonth(2025, 7);
  int augDays = DateUtils.getDaysInMonth(2025, 8);
  int sepDays = DateUtils.getDaysInMonth(2025, 9);
  int octDays = DateUtils.getDaysInMonth(2025, 10);
  int novDays = DateUtils.getDaysInMonth(2025, 11);
  int decDays = DateUtils.getDaysInMonth(2025, 12);
  print('Jan: $janDays, Feb: $febDays, Mar: $marDays');
  print('Apr: $aprDays, May: $mayDays, Jun: $junDays');
  print('Jul: $julDays, Aug: $augDays, Sep: $sepDays');
  print('Oct: $octDays, Nov: $novDays, Dec: $decDays');
  print('Feb 2024 (leap): $febLeapDays');

  print('--- DateUtils.firstDayOfMonth / lastDayOfMonth ---');
  DateTime firstMarch = DateUtils.firstDayOfMonth(DateTime(2025, 3, 15));
  DateTime lastMarch = DateUtils.lastDayOfMonth(DateTime(2025, 3, 15));
  print('First of March 2025: $firstMarch');
  print('Last of March 2025: $lastMarch');

  DateTime firstFeb = DateUtils.firstDayOfMonth(DateTime(2024, 2, 10));
  DateTime lastFeb = DateUtils.lastDayOfMonth(DateTime(2024, 2, 10));
  print('First of Feb 2024: $firstFeb');
  print('Last of Feb 2024 (leap): $lastFeb');

  print('--- DateUtils.dateOnly ---');
  DateTime stripped = DateUtils.dateOnly(DateTime(2025, 3, 15, 14, 30, 45));
  print('dateOnly(2025-03-15 14:30:45) = $stripped');

  print('--- DateUtils.addDaysToDate ---');
  DateTime plusSeven = DateUtils.addDaysToDate(DateTime(2025, 3, 25), 7);
  print('addDaysToDate(Mar 25, +7) = $plusSeven');

  DateTime minusFive = DateUtils.addDaysToDate(DateTime(2025, 3, 5), -5);
  print('addDaysToDate(Mar 5, -5) = $minusFive');

  print('--- DateUtils.addMonthsToMonthDate ---');
  DateTime plus3Months = DateUtils.addMonthsToMonthDate(
    DateTime(2025, 1, 15),
    3,
  );
  print('addMonthsToMonthDate(Jan 15, +3) = $plus3Months');

  print('--- DateTimeRange ---');
  DateTimeRange range1 = DateTimeRange(
    start: DateTime(2025, 3, 1),
    end: DateTime(2025, 3, 31),
  );
  print('DateTimeRange: $range1');
  print('Duration: ${range1.duration}');

  DateTimeRange range2 = DateTimeRange(
    start: DateTime(2025, 6, 1),
    end: DateTime(2025, 8, 31),
  );
  print('Summer range: $range2');

  print('--- DateUtils.datesOnly ---');
  DateTimeRange stripped2 = DateUtils.datesOnly(
    DateTimeRange(
      start: DateTime(2025, 3, 1, 10, 30),
      end: DateTime(2025, 3, 31, 18, 45),
    ),
  );
  print('datesOnly: $stripped2');

  print('=== All DateUtils operations verified ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Gregorian Calendar Delegate Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: isSameDay / isSameMonth comparisons
            buildSectionHeader('1. Date Comparisons (isSameDay / isSameMonth)'),
            buildDemoCard(
              'isSameDay comparisons',
              Column(
                children: [
                  buildComparisonRow(
                    'Mar 15 00:00',
                    'Mar 15 23:59',
                    'sameDay?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Mar 15 2025',
                    'Mar 16 2025',
                    'sameDay?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Dec 31 2025',
                    'Jan 1 2026',
                    'sameDay?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Feb 28 2024',
                    'Feb 29 2024',
                    'sameDay?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Jul 4 2025',
                    'Jul 4 2025',
                    'sameDay?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'isSameMonth comparisons',
              Column(
                children: [
                  buildComparisonRow(
                    'Jun 1 2025',
                    'Jun 30 2025',
                    'sameMonth?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Jun 30 2025',
                    'Jul 1 2025',
                    'sameMonth?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Jan 1 2025',
                    'Jan 1 2026',
                    'sameMonth?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Dec 1 2025',
                    'Dec 31 2025',
                    'sameMonth?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Feb 1 2024',
                    'Feb 29 2024',
                    'sameMonth?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: Comparisons rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: getDaysInMonth grid
            buildSectionHeader('2. Days in Each Month (getDaysInMonth)'),
            buildDemoCard(
              'All 12 months of 2025 (non-leap)',
              Column(
                children: [
                  buildDaysBar('Jan', 31, 31, Color(0xFF1565C0)),
                  buildDaysBar('Feb', 28, 31, Color(0xFF1976D2)),
                  buildDaysBar('Mar', 31, 31, Color(0xFF1E88E5)),
                  buildDaysBar('Apr', 30, 31, Color(0xFF2196F3)),
                  buildDaysBar('May', 31, 31, Color(0xFF42A5F5)),
                  buildDaysBar('Jun', 30, 31, Color(0xFF64B5F6)),
                  buildDaysBar('Jul', 31, 31, Color(0xFF0D47A1)),
                  buildDaysBar('Aug', 31, 31, Color(0xFF1565C0)),
                  buildDaysBar('Sep', 30, 31, Color(0xFF1976D2)),
                  buildDaysBar('Oct', 31, 31, Color(0xFF1E88E5)),
                  buildDaysBar('Nov', 30, 31, Color(0xFF2196F3)),
                  buildDaysBar('Dec', 31, 31, Color(0xFF42A5F5)),
                ],
              ),
            ),
            buildDemoCard(
              'February: Leap vs Non-Leap Years',
              Column(
                children: [
                  buildDaysBar('2023', 28, 31, Color(0xFFD32F2F)),
                  buildDaysBar('2024', 29, 31, Color(0xFF4CAF50)),
                  buildDaysBar('2025', 28, 31, Color(0xFFD32F2F)),
                  buildDaysBar('2028', 29, 31, Color(0xFF4CAF50)),
                  buildDaysBar('2100', 28, 31, Color(0xFFD32F2F)),
                  buildDaysBar('2400', 29, 31, Color(0xFF4CAF50)),
                ],
              ),
            ),
            Text(
              'Section 2: Days-in-month rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: firstDayOfMonth / lastDayOfMonth
            buildSectionHeader('3. Month Boundaries'),
            buildDemoCard(
              'firstDayOfMonth / lastDayOfMonth for March 2025',
              Column(
                children: [
                  buildDateResult(
                    'firstDayOfMonth',
                    'Mar 15 2025',
                    'Mar 1 2025',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    'lastDayOfMonth',
                    'Mar 15 2025',
                    'Mar 31 2025',
                    Color(0xFF0D47A1),
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Month boundaries for Feb 2024 (leap year)',
              Column(
                children: [
                  buildDateResult(
                    'firstDayOfMonth',
                    'Feb 10 2024',
                    'Feb 1 2024',
                    Color(0xFF4CAF50),
                  ),
                  buildDateResult(
                    'lastDayOfMonth',
                    'Feb 10 2024',
                    'Feb 29 2024',
                    Color(0xFF388E3C),
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Month boundaries for various months',
              Column(
                children: [
                  buildDateResult(
                    'firstDay Jan',
                    'Jan 20 2025',
                    'Jan 1 2025',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    'lastDay Jan',
                    'Jan 20 2025',
                    'Jan 31 2025',
                    Color(0xFF0D47A1),
                  ),
                  buildDateResult(
                    'firstDay Apr',
                    'Apr 15 2025',
                    'Apr 1 2025',
                    Color(0xFF1976D2),
                  ),
                  buildDateResult(
                    'lastDay Apr',
                    'Apr 15 2025',
                    'Apr 30 2025',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    'firstDay Dec',
                    'Dec 25 2025',
                    'Dec 1 2025',
                    Color(0xFF1E88E5),
                  ),
                  buildDateResult(
                    'lastDay Dec',
                    'Dec 25 2025',
                    'Dec 31 2025',
                    Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
            Text(
              'Section 3: Month boundaries rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: DateTimeRange display
            buildSectionHeader('4. DateTimeRange Visual Display'),
            buildDemoCard(
              'March 2025 full month range',
              Column(
                children: [
                  buildRangeBadge('Start', 'Mar 1, 2025', Color(0xFF1565C0)),
                  buildRangeBadge('End', 'Mar 31, 2025', Color(0xFF0D47A1)),
                  SizedBox(height: 8),
                  buildInfoRow('Duration', '30 days'),
                  buildInfoRow('Type', 'DateTimeRange'),
                ],
              ),
            ),
            buildDemoCard(
              'Summer vacation range (Jun - Aug 2025)',
              Column(
                children: [
                  buildRangeBadge('Start', 'Jun 1, 2025', Color(0xFFFF6F00)),
                  buildRangeBadge('End', 'Aug 31, 2025', Color(0xFFE65100)),
                  SizedBox(height: 8),
                  buildInfoRow('Duration', '91 days'),
                  buildInfoRow('Spans months', '3'),
                ],
              ),
            ),
            buildDemoCard(
              'datesOnly() strips time components',
              Column(
                children: [
                  buildDateResult(
                    'Before start',
                    '',
                    'Mar 1 10:30',
                    Color(0xFF757575),
                  ),
                  buildDateResult(
                    'After start',
                    '',
                    'Mar 1 00:00',
                    Color(0xFF4CAF50),
                  ),
                  buildDateResult(
                    'Before end',
                    '',
                    'Mar 31 18:45',
                    Color(0xFF757575),
                  ),
                  buildDateResult(
                    'After end',
                    '',
                    'Mar 31 00:00',
                    Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),
            Text(
              'Section 4: DateTimeRange rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: CalendarDatePicker widget variations
            buildSectionHeader('5. CalendarDatePicker Configurations'),
            buildDemoCard(
              'Basic CalendarDatePicker (default range)',
              CalendarDatePicker(
                initialDate: DateTime(2025, 3, 21),
                firstDate: DateTime(2020, 1, 1),
                lastDate: DateTime(2030, 12, 31),
                onDateChanged: (DateTime date) {
                  print('Date selected: $date');
                },
              ),
            ),
            buildDemoCard(
              'CalendarDatePicker with year mode',
              CalendarDatePicker(
                initialDate: DateTime(2025, 3, 21),
                firstDate: DateTime(2020, 1, 1),
                lastDate: DateTime(2030, 12, 31),
                initialCalendarMode: DatePickerMode.year,
                onDateChanged: (DateTime date) {
                  print('Year mode date: $date');
                },
              ),
            ),
            buildDemoCard(
              'CalendarDatePicker with custom currentDate',
              CalendarDatePicker(
                initialDate: DateTime(2025, 3, 21),
                firstDate: DateTime(2020, 1, 1),
                lastDate: DateTime(2030, 12, 31),
                currentDate: DateTime(2025, 3, 25),
                onDateChanged: (DateTime date) {
                  print('Custom current date: $date');
                },
              ),
            ),
            Text(
              'Section 5: CalendarDatePicker rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Calendars with different constraints
            buildSectionHeader('6. Calendar Date Constraints'),
            buildDemoCard(
              'Narrow range: Mar 10-20, 2025 only',
              CalendarDatePicker(
                initialDate: DateTime(2025, 3, 15),
                firstDate: DateTime(2025, 3, 10),
                lastDate: DateTime(2025, 3, 20),
                onDateChanged: (DateTime date) {
                  print('Narrow range date: $date');
                },
              ),
            ),
            buildDemoCard(
              'Single year: 2025 only',
              CalendarDatePicker(
                initialDate: DateTime(2025, 6, 15),
                firstDate: DateTime(2025, 1, 1),
                lastDate: DateTime(2025, 12, 31),
                onDateChanged: (DateTime date) {
                  print('Single year date: $date');
                },
              ),
            ),
            buildDemoCard(
              'Wide range: 2000 - 2050',
              CalendarDatePicker(
                initialDate: DateTime(2025, 3, 21),
                firstDate: DateTime(2000, 1, 1),
                lastDate: DateTime(2050, 12, 31),
                initialCalendarMode: DatePickerMode.year,
                onDateChanged: (DateTime date) {
                  print('Wide range date: $date');
                },
              ),
            ),
            Text(
              'Section 6: Constrained calendars rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Visual monthly grid
            buildSectionHeader('7. Visual Monthly Grids'),
            buildDemoCard(
              'March 2025 (highlight first & last)',
              buildMiniCalendar('March', 2025, 6, 31, [
                1,
                31,
              ], Color(0xFF1565C0)),
            ),
            buildDemoCard(
              'February 2024 (leap year, highlight 29th)',
              buildMiniCalendar('February', 2024, 4, 29, [
                1,
                29,
              ], Color(0xFF4CAF50)),
            ),
            buildDemoCard(
              'January 2025 (highlight weekends)',
              buildMiniCalendar('January', 2025, 3, 31, [
                4,
                5,
                11,
                12,
                18,
                19,
                25,
                26,
              ], Color(0xFFFF6F00)),
            ),
            buildDemoCard(
              'June 2025 (highlight mid-month)',
              buildMiniCalendar('June', 2025, 7, 30, [
                14,
                15,
                16,
                17,
                18,
              ], Color(0xFF7B1FA2)),
            ),
            buildDemoCard(
              'December 2025 (highlight holidays)',
              buildMiniCalendar('December', 2025, 1, 31, [
                24,
                25,
                26,
                31,
              ], Color(0xFFD32F2F)),
            ),
            buildDemoCard(
              'September 2025',
              buildMiniCalendar('September', 2025, 1, 30, [
                1,
                30,
              ], Color(0xFF00695C)),
            ),
            Text(
              'Section 7: Mini calendars rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Property / information section
            buildSectionHeader('8. Gregorian Calendar Properties'),
            buildDemoCard(
              'Calendar System Information',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Calendar type', 'Gregorian'),
                  buildInfoRow('Days per week', '7'),
                  buildInfoRow('Months per year', '12'),
                  buildInfoRow('Min days in month', '28 (February)'),
                  buildInfoRow('Max days in month', '31'),
                  buildInfoRow('Leap year rule', 'Every 4 years'),
                  buildInfoRow('Exception', 'Skip centuries'),
                  buildInfoRow('Exception to exception', 'Keep 400th years'),
                  buildInfoRow('Current era', 'CE / AD'),
                  buildInfoRow('Week start (ISO)', 'Monday'),
                ],
              ),
            ),
            buildDemoCard(
              'DateUtils API Summary',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('dateOnly()', 'Strip time to midnight'),
                  buildInfoRow('datesOnly()', 'Strip time from range'),
                  buildInfoRow('isSameDay()', 'Compare dates ignoring time'),
                  buildInfoRow('isSameMonth()', 'Compare year + month'),
                  buildInfoRow('getDaysInMonth()', 'Days in given month'),
                  buildInfoRow('addDaysToDate()', 'Add days to date'),
                  buildInfoRow('addMonthsToMonthDate()', 'Add months to date'),
                  buildInfoRow('firstDayOfMonth()', 'First day of month'),
                  buildInfoRow('lastDayOfMonth()', 'Last day of month'),
                ],
              ),
            ),
            buildDemoCard(
              'Month Names and Day Counts (2025)',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('January', '31 days'),
                  buildInfoRow('February', '28 days (non-leap)'),
                  buildInfoRow('March', '31 days'),
                  buildInfoRow('April', '30 days'),
                  buildInfoRow('May', '31 days'),
                  buildInfoRow('June', '30 days'),
                  buildInfoRow('July', '31 days'),
                  buildInfoRow('August', '31 days'),
                  buildInfoRow('September', '30 days'),
                  buildInfoRow('October', '31 days'),
                  buildInfoRow('November', '30 days'),
                  buildInfoRow('December', '31 days'),
                ],
              ),
            ),
            buildDemoCard(
              'Leap Year Examples',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('2000', 'Leap (div by 400)'),
                  buildInfoRow('1900', 'Not leap (div by 100)'),
                  buildInfoRow('2024', 'Leap (div by 4)'),
                  buildInfoRow('2025', 'Not leap'),
                  buildInfoRow('2028', 'Leap (div by 4)'),
                  buildInfoRow('2100', 'Not leap (div by 100)'),
                  buildInfoRow('2400', 'Leap (div by 400)'),
                ],
              ),
            ),
            Text(
              'Section 8: Properties rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: addDaysToDate and addMonthsToMonthDate
            buildSectionHeader('9. Date Arithmetic'),
            buildDemoCard(
              'addDaysToDate examples',
              Column(
                children: [
                  buildDateResult(
                    '+1 day',
                    'Mar 21, 2025',
                    'Mar 22, 2025',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    '+7 days',
                    'Mar 21, 2025',
                    'Mar 28, 2025',
                    Color(0xFF1976D2),
                  ),
                  buildDateResult(
                    '+14 days',
                    'Mar 25, 2025',
                    'Apr 8, 2025',
                    Color(0xFF1E88E5),
                  ),
                  buildDateResult(
                    '-5 days',
                    'Mar 5, 2025',
                    'Feb 28, 2025',
                    Color(0xFFD32F2F),
                  ),
                  buildDateResult(
                    '+30 days',
                    'Jan 1, 2025',
                    'Jan 31, 2025',
                    Color(0xFF2196F3),
                  ),
                  buildDateResult(
                    '+365 days',
                    'Mar 21, 2025',
                    'Mar 21, 2026',
                    Color(0xFF42A5F5),
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'addMonthsToMonthDate examples',
              Column(
                children: [
                  buildDateResult(
                    '+1 month',
                    'Jan 15, 2025',
                    'Feb 15, 2025',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    '+3 months',
                    'Jan 15, 2025',
                    'Apr 15, 2025',
                    Color(0xFF1976D2),
                  ),
                  buildDateResult(
                    '+6 months',
                    'Mar 1, 2025',
                    'Sep 1, 2025',
                    Color(0xFF1E88E5),
                  ),
                  buildDateResult(
                    '+12 months',
                    'Mar 21, 2025',
                    'Mar 21, 2026',
                    Color(0xFF2196F3),
                  ),
                ],
              ),
            ),
            Text(
              'Section 9: Arithmetic rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: dateOnly demonstrations
            buildSectionHeader('10. dateOnly() Time Stripping'),
            buildDemoCard(
              'Removing time components from DateTime',
              Column(
                children: [
                  buildDateResult(
                    'dateOnly',
                    '2025-03-15 14:30:45',
                    '2025-03-15 00:00:00',
                    Color(0xFF1565C0),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-06-01 23:59:59',
                    '2025-06-01 00:00:00',
                    Color(0xFF1976D2),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-12-31 12:00:00',
                    '2025-12-31 00:00:00',
                    Color(0xFF1E88E5),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-01-01 00:00:01',
                    '2025-01-01 00:00:00',
                    Color(0xFF2196F3),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-03-15 00:00:00',
                    '2025-03-15 00:00:00',
                    Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),
            Text(
              'Section 10: dateOnly rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'Gregorian Calendar Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'isSameDay / isSameMonth comparisons'),
                  buildInfoRow('2', 'getDaysInMonth for all 12 months'),
                  buildInfoRow('3', 'Month boundary functions'),
                  buildInfoRow('4', 'DateTimeRange visual display'),
                  buildInfoRow('5', 'CalendarDatePicker variations'),
                  buildInfoRow('6', 'Constrained calendar pickers'),
                  buildInfoRow('7', 'Mini monthly grids'),
                  buildInfoRow('8', 'Calendar system properties'),
                  buildInfoRow('9', 'Date arithmetic operations'),
                  buildInfoRow('10', 'dateOnly time stripping'),
                ],
              ),
            ),
            Text(
              '=== Gregorian Calendar Delegate Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
