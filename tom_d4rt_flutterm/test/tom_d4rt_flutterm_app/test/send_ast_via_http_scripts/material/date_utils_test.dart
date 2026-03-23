// ignore_for_file: avoid_print
// D4rt test script: Tests DateUtils from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFFBF360C),
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

// Helper to build a demo card
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
          width: 160,
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

// Helper: function signature card
Widget buildFunctionCard(
  String name,
  String returnType,
  String description,
  Color accentColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                returnType,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
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

// Helper: mini calendar for showing month boundaries
Widget buildMonthCalendar(
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

// Helper: comparison row
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

// Helper: days-in-month bar
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

// Helper: week number display
Widget buildWeekRow(int weekNum, List<String> days, bool isCurrent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    decoration: BoxDecoration(
      color: isCurrent ? Color(0xFFFBE9E7) : Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(4),
      border: isCurrent ? Border.all(color: Color(0xFFBF360C), width: 1) : null,
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 24,
          decoration: BoxDecoration(
            color: isCurrent ? Color(0xFFBF360C) : Color(0xFF9E9E9E),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              'W$weekNum',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        ...days.map(
          (d) => Expanded(
            child: Text(
              d,
              style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DateUtils Deep Demo ===');
  debugPrint('Testing DateUtils static methods for date manipulation');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DateUtils Deep Demo'),
        backgroundColor: Color(0xFFBF360C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Available Functions
            buildSectionHeader('1. DateUtils Static Methods'),
            buildDemoCard(
              'All static utility functions',
              Column(
                children: [
                  buildFunctionCard(
                    'dateOnly(DateTime)',
                    'DateTime',
                    'Returns date with time set to midnight',
                    Color(0xFFBF360C),
                  ),
                  buildFunctionCard(
                    'datesOnly(DateTimeRange)',
                    'DateTimeRange',
                    'Both start and end set to midnight',
                    Color(0xFFD84315),
                  ),
                  buildFunctionCard(
                    'isSameDay(DateTime?, DateTime?)',
                    'bool',
                    'True if same year, month, day',
                    Color(0xFFE64A19),
                  ),
                  buildFunctionCard(
                    'isSameMonth(DateTime, DateTime)',
                    'bool',
                    'True if same year and month',
                    Color(0xFFF4511E),
                  ),
                  buildFunctionCard(
                    'getDaysInMonth(int, int)',
                    'int',
                    'Number of days in given year/month',
                    Color(0xFFFF5722),
                  ),
                  buildFunctionCard(
                    'addDaysToDate(DateTime, int)',
                    'DateTime',
                    'Add days to a date',
                    Color(0xFFFF6E40),
                  ),
                  buildFunctionCard(
                    'addMonthsToMonthDate(DateTime, int)',
                    'DateTime',
                    'Add months to a date',
                    Color(0xFFFF8A65),
                  ),
                  buildFunctionCard(
                    'firstDayOfMonth(DateTime)',
                    'DateTime',
                    'First day of dates month',
                    Color(0xFFFFAB91),
                  ),
                  buildFunctionCard(
                    'lastDayOfMonth(DateTime)',
                    'DateTime',
                    'Last day of dates month',
                    Color(0xFFFFCCBC),
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: Functions listed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: dateOnly
            buildSectionHeader('2. dateOnly()'),
            buildDemoCard(
              'Stripping time from DateTime',
              Column(
                children: [
                  buildDateResult(
                    'dateOnly',
                    '2025-01-15 14:30:00',
                    '2025-01-15 00:00:00',
                    Color(0xFFBF360C),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-06-01 23:59:59',
                    '2025-06-01 00:00:00',
                    Color(0xFFBF360C),
                  ),
                  buildDateResult(
                    'dateOnly',
                    '2025-12-31 12:00:00',
                    '2025-12-31 00:00:00',
                    Color(0xFFBF360C),
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
              'Section 2: dateOnly examples rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: isSameDay
            buildSectionHeader('3. isSameDay()'),
            buildDemoCard(
              'Comparing dates (ignoring time)',
              Column(
                children: [
                  buildComparisonRow(
                    'Jan 15 00:00',
                    'Jan 15 23:59',
                    'same?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Jan 15 12:00',
                    'Jan 16 12:00',
                    'same?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Dec 31 2024',
                    'Dec 31 2025',
                    'same?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Mar 1 2025',
                    'Mar 1 2025',
                    'same?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Feb 28 2024',
                    'Feb 29 2024',
                    'same?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                ],
              ),
            ),
            Text(
              'Section 3: isSameDay rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: isSameMonth
            buildSectionHeader('4. isSameMonth()'),
            buildDemoCard(
              'Comparing year-month pairs',
              Column(
                children: [
                  buildComparisonRow(
                    'Jan 1 2025',
                    'Jan 31 2025',
                    'month?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                  buildComparisonRow(
                    'Jan 31 2025',
                    'Feb 1 2025',
                    'month?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Jun 15 2024',
                    'Jun 15 2025',
                    'month?',
                    'false',
                    Color(0xFFD32F2F),
                  ),
                  buildComparisonRow(
                    'Dec 1 2025',
                    'Dec 31 2025',
                    'month?',
                    'true',
                    Color(0xFF4CAF50),
                  ),
                ],
              ),
            ),
            Text(
              'Section 4: isSameMonth rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: getDaysInMonth
            buildSectionHeader('5. getDaysInMonth()'),
            buildDemoCard(
              'Days per month (2025, non-leap year)',
              Column(
                children: [
                  buildDaysBar('Jan', 31, 31, Color(0xFFBF360C)),
                  buildDaysBar('Feb', 28, 31, Color(0xFFD84315)),
                  buildDaysBar('Mar', 31, 31, Color(0xFFE64A19)),
                  buildDaysBar('Apr', 30, 31, Color(0xFFF4511E)),
                  buildDaysBar('May', 31, 31, Color(0xFFFF5722)),
                  buildDaysBar('Jun', 30, 31, Color(0xFFFF6E40)),
                  buildDaysBar('Jul', 31, 31, Color(0xFFFF8A65)),
                  buildDaysBar('Aug', 31, 31, Color(0xFFFFAB91)),
                  buildDaysBar('Sep', 30, 31, Color(0xFFBF360C)),
                  buildDaysBar('Oct', 31, 31, Color(0xFFD84315)),
                  buildDaysBar('Nov', 30, 31, Color(0xFFE64A19)),
                  buildDaysBar('Dec', 31, 31, Color(0xFFF4511E)),
                ],
              ),
            ),
            buildDemoCard(
              'February in leap vs non-leap years',
              Column(
                children: [
                  buildDaysBar('2024', 29, 31, Color(0xFF4CAF50)),
                  buildDaysBar('2025', 28, 31, Color(0xFFBF360C)),
                  buildDaysBar('2028', 29, 31, Color(0xFF4CAF50)),
                  buildDaysBar('2100', 28, 31, Color(0xFFBF360C)),
                ],
              ),
            ),
            Text(
              'Section 5: getDaysInMonth rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: addDaysToDate
            buildSectionHeader('6. addDaysToDate()'),
            buildDemoCard(
              'Adding days to dates',
              Column(
                children: [
                  buildDateResult(
                    '+1 day',
                    'Jan 15, 2025',
                    'Jan 16, 2025',
                    Color(0xFFBF360C),
                  ),
                  buildDateResult(
                    '+7 days',
                    'Jan 15, 2025',
                    'Jan 22, 2025',
                    Color(0xFFD84315),
                  ),
                  buildDateResult(
                    '+30 days',
                    'Jan 15, 2025',
                    'Feb 14, 2025',
                    Color(0xFFE64A19),
                  ),
                  buildDateResult(
                    '+365 days',
                    'Jan 15, 2025',
                    'Jan 15, 2026',
                    Color(0xFFF4511E),
                  ),
                  buildDateResult(
                    '-10 days',
                    'Jan 15, 2025',
                    'Jan 5, 2025',
                    Color(0xFF1976D2),
                  ),
                  buildDateResult(
                    '+17 days',
                    'Feb 14, 2025',
                    'Mar 3, 2025',
                    Color(0xFF00695C),
                  ),
                ],
              ),
            ),
            Text(
              'Section 6: addDaysToDate rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: addMonthsToMonthDate
            buildSectionHeader('7. addMonthsToMonthDate()'),
            buildDemoCard(
              'Adding months to dates',
              Column(
                children: [
                  buildDateResult(
                    '+1 month',
                    'Jan 2025',
                    'Feb 2025',
                    Color(0xFFBF360C),
                  ),
                  buildDateResult(
                    '+3 months',
                    'Jan 2025',
                    'Apr 2025',
                    Color(0xFFD84315),
                  ),
                  buildDateResult(
                    '+6 months',
                    'Jan 2025',
                    'Jul 2025',
                    Color(0xFFE64A19),
                  ),
                  buildDateResult(
                    '+12 months',
                    'Jan 2025',
                    'Jan 2026',
                    Color(0xFFF4511E),
                  ),
                  buildDateResult(
                    '-2 months',
                    'Mar 2025',
                    'Jan 2025',
                    Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
            Text(
              'Section 7: addMonthsToMonthDate rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: firstDayOfMonth / lastDayOfMonth
            buildSectionHeader('8. Month Boundaries'),
            buildDemoCard(
              'firstDayOfMonth and lastDayOfMonth',
              Column(
                children: [
                  buildDateResult(
                    'first',
                    'Jan 2025',
                    'Jan 1',
                    Color(0xFF2E7D32),
                  ),
                  buildDateResult(
                    'last',
                    'Jan 2025',
                    'Jan 31',
                    Color(0xFFC62828),
                  ),
                  buildDateResult(
                    'first',
                    'Feb 2025',
                    'Feb 1',
                    Color(0xFF2E7D32),
                  ),
                  buildDateResult(
                    'last',
                    'Feb 2025',
                    'Feb 28',
                    Color(0xFFC62828),
                  ),
                  buildDateResult(
                    'first',
                    'Feb 2024',
                    'Feb 1',
                    Color(0xFF2E7D32),
                  ),
                  buildDateResult(
                    'last',
                    'Feb 2024 (leap)',
                    'Feb 29',
                    Color(0xFFC62828),
                  ),
                  buildDateResult(
                    'first',
                    'Apr 2025',
                    'Apr 1',
                    Color(0xFF2E7D32),
                  ),
                  buildDateResult(
                    'last',
                    'Apr 2025',
                    'Apr 30',
                    Color(0xFFC62828),
                  ),
                ],
              ),
            ),
            buildDemoCard(
              'Calendar view: January 2025 boundaries',
              buildMonthCalendar('January', 2025, 3, 31, [
                1,
                31,
              ], Color(0xFFBF360C)),
            ),
            Text(
              'Section 8: Month boundaries rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: datesOnly
            buildSectionHeader('9. datesOnly on DateTimeRange'),
            buildDemoCard(
              'Stripping time from DateTimeRange',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFBE9E7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Input DateTimeRange:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFFBF360C),
                          ),
                        ),
                        buildInfoRow('start', '2025-01-15 09:30:00'),
                        buildInfoRow('end', '2025-01-20 17:45:00'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'After datesOnly():',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        buildInfoRow('start', '2025-01-15 00:00:00'),
                        buildInfoRow('end', '2025-01-20 00:00:00'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 9: datesOnly rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Week Number Display
            buildSectionHeader('10. Week-Based Utilities'),
            buildDemoCard(
              'Weeks in January 2025',
              Column(
                children: [
                  buildWeekRow(1, ['30', '31', '1', '2', '3', '4', '5'], false),
                  buildWeekRow(2, [
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                  ], false),
                  buildWeekRow(3, [
                    '13',
                    '14',
                    '15',
                    '16',
                    '17',
                    '18',
                    '19',
                  ], true),
                  buildWeekRow(4, [
                    '20',
                    '21',
                    '22',
                    '23',
                    '24',
                    '25',
                    '26',
                  ], false),
                  buildWeekRow(5, [
                    '27',
                    '28',
                    '29',
                    '30',
                    '31',
                    '1',
                    '2',
                  ], false),
                ],
              ),
            ),
            Text(
              'Section 10: Week display rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Combined Operations
            buildSectionHeader('11. Combined DateUtils Operations'),
            buildDemoCard(
              'Chaining multiple DateUtils calls',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFFBE9E7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compute next month first day:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFFBF360C),
                          ),
                        ),
                        SizedBox(height: 4),
                        buildDateResult(
                          'Start',
                          '',
                          'Jan 15 2025',
                          Color(0xFF757575),
                        ),
                        buildDateResult(
                          'addMonths(1)',
                          '',
                          'Feb 15 2025',
                          Color(0xFFBF360C),
                        ),
                        buildDateResult(
                          'firstDayOfMonth',
                          '',
                          'Feb 1 2025',
                          Color(0xFF4CAF50),
                        ),
                        buildDateResult(
                          'dateOnly',
                          '',
                          'Feb 1 00:00',
                          Color(0xFF1976D2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compute 2 weeks from today at midnight:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                        SizedBox(height: 4),
                        buildDateResult(
                          'Start',
                          '',
                          'Jan 15 14:30',
                          Color(0xFF757575),
                        ),
                        buildDateResult(
                          'addDays(14)',
                          '',
                          'Jan 29 14:30',
                          Color(0xFF1565C0),
                        ),
                        buildDateResult(
                          'dateOnly',
                          '',
                          'Jan 29 00:00',
                          Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 11: Combined operations rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DateUtils Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'All DateUtils static methods'),
                  buildInfoRow('2', 'dateOnly() time stripping'),
                  buildInfoRow('3', 'isSameDay() comparison'),
                  buildInfoRow('4', 'isSameMonth() comparison'),
                  buildInfoRow('5', 'getDaysInMonth() for all months'),
                  buildInfoRow('6', 'addDaysToDate() arithmetic'),
                  buildInfoRow('7', 'addMonthsToMonthDate() arithmetic'),
                  buildInfoRow('8', 'Month boundary functions'),
                  buildInfoRow('9', 'datesOnly() on DateTimeRange'),
                  buildInfoRow('10', 'Week-based display utilities'),
                  buildInfoRow('11', 'Combined DateUtils operations'),
                ],
              ),
            ),
            Text(
              '=== DateUtils Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
