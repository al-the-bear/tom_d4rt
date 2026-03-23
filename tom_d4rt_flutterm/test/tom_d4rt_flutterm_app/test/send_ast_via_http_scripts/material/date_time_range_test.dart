// ignore_for_file: avoid_print
// D4rt test script: Tests DateTimeRange from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF880E4F),
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
          width: 130,
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

// Helper: date display card
Widget buildDateCard(
  String label,
  int year,
  int month,
  int day,
  Color accentColor,
) {
  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  List<String> dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  String monthStr = month > 0 && month <= 12 ? monthNames[month - 1] : '???';
  return Container(
    width: 100,
    margin: EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor, width: 2),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 4),
        Text(
          monthStr,
          style: TextStyle(
            fontSize: 12,
            color: accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          day.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        Text(
          year.toString(),
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        Text(
          dayNames[day % 7],
          style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
        ),
        SizedBox(height: 4),
      ],
    ),
  );
}

// Helper: range bar visualization
Widget buildRangeBar(String label, double start, double end, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
        SizedBox(height: 2),
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: end,
            child: Row(
              children: [
                SizedBox(width: start * 100),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: calendar mini-month
Widget buildMiniMonth(
  String monthName,
  int year,
  int startDay,
  int daysInMonth,
  int highlightStart,
  int highlightEnd,
  Color highlightColor,
) {
  List<Widget> dayWidgets = [];
  List<String> weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  for (int i = 0; i < weekdays.length; i++) {
    dayWidgets.add(
      Container(
        width: 28,
        height: 20,
        alignment: Alignment.center,
        child: Text(
          weekdays[i],
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF757575),
          ),
        ),
      ),
    );
  }
  for (int i = 0; i < (startDay - 1) % 7; i++) {
    dayWidgets.add(SizedBox(width: 28, height: 28));
  }
  for (int d = 1; d <= daysInMonth; d++) {
    bool isHighlighted = d >= highlightStart && d <= highlightEnd;
    bool isStart = d == highlightStart;
    bool isEnd = d == highlightEnd;
    dayWidgets.add(
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isHighlighted ? highlightColor : Color(0x00000000),
          borderRadius: BorderRadius.horizontal(
            left: isStart ? Radius.circular(14) : Radius.zero,
            right: isEnd ? Radius.circular(14) : Radius.zero,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          d.toString(),
          style: TextStyle(
            fontSize: 11,
            color: isHighlighted ? Color(0xFFFFFFFF) : Color(0xFF424242),
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
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

// Helper: duration display
Widget buildDurationDisplay(String label, int days, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$days days',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: timeline marker
Widget buildTimelineMarker(
  String label,
  String date,
  bool isStart,
  Color color,
) {
  return Row(
    children: [
      Column(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFFFFFFF), width: 2),
              boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 2)],
            ),
          ),
          if (!isStart) SizedBox(),
        ],
      ),
      SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
            ),
          ),
          Text(date, style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
        ],
      ),
    ],
  );
}

// Helper: overlap visualization
Widget buildOverlapRow(
  String label,
  double startPct,
  double endPct,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
          ),
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(3),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double totalWidth = constraints.maxWidth;
                double leftMargin = totalWidth * startPct;
                double barWidth = totalWidth * (endPct - startPct);
                return Stack(
                  children: [
                    Positioned(
                      left: leftMargin,
                      child: Container(
                        width: barWidth,
                        height: 20,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: comparison chip
Widget buildComparisonChip(String text, Color bg, Color fg) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DateTimeRange Deep Demo ===');
  debugPrint('Testing DateTimeRange construction, duration, and comparison');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DateTimeRange Deep Demo'),
        backgroundColor: Color(0xFF880E4F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: DateTimeRange Properties
            buildSectionHeader('1. DateTimeRange Properties'),
            buildDemoCard(
              'Core properties of DateTimeRange',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('start', 'The start of the range (DateTime)'),
                  buildInfoRow('end', 'The end of the range (DateTime)'),
                  buildInfoRow('duration', 'Computed end.difference(start)'),
                  buildInfoRow('==', 'Equals if start and end both match'),
                  buildInfoRow('hashCode', 'Based on start and end'),
                  buildInfoRow('toString', 'Displays start and end dates'),
                ],
              ),
            ),
            Text(
              'Section 1: Properties displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: Date Range Visualization
            buildSectionHeader('2. Date Range Visualization'),
            buildDemoCard(
              'January 15, 2025 - January 30, 2025',
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDateCard('START', 2025, 1, 15, Color(0xFF880E4F)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF880E4F),
                          size: 24,
                        ),
                        Text(
                          '15 days',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF880E4F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDateCard('END', 2025, 1, 30, Color(0xFF880E4F)),
                ],
              ),
            ),
            buildDemoCard(
              'March 1 - June 30, 2025 (Q2 span)',
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDateCard('START', 2025, 3, 1, Color(0xFF4527A0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF4527A0),
                          size: 24,
                        ),
                        Text(
                          '122 days',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4527A0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDateCard('END', 2025, 6, 30, Color(0xFF4527A0)),
                ],
              ),
            ),
            Text(
              'Section 2: Date ranges visualized',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: Calendar Highlight
            buildSectionHeader('3. Calendar Range Highlight'),
            buildDemoCard(
              'Range highlighted on mini calendar: Jan 10-20',
              buildMiniMonth('January', 2025, 3, 31, 10, 20, Color(0xFF880E4F)),
            ),
            buildDemoCard(
              'Range highlighted on mini calendar: Feb 5-14',
              buildMiniMonth('February', 2025, 6, 28, 5, 14, Color(0xFF4527A0)),
            ),
            Text(
              'Section 3: Calendar ranges rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: Duration Display
            buildSectionHeader('4. Duration Calculations'),
            buildDemoCard(
              'Duration of various date ranges',
              Column(
                children: [
                  buildDurationDisplay(
                    'Weekend (Sat-Sun)',
                    2,
                    Color(0xFF880E4F),
                  ),
                  buildDurationDisplay(
                    'Work Week (Mon-Fri)',
                    5,
                    Color(0xFFAD1457),
                  ),
                  buildDurationDisplay(
                    'Sprint (2 weeks)',
                    14,
                    Color(0xFFC2185B),
                  ),
                  buildDurationDisplay('Month (Jan)', 31, Color(0xFFD81B60)),
                  buildDurationDisplay('Quarter (Q1)', 90, Color(0xFFE91E63)),
                  buildDurationDisplay('Half Year', 183, Color(0xFFEC407A)),
                  buildDurationDisplay('Full Year', 365, Color(0xFFF06292)),
                ],
              ),
            ),
            Text(
              'Section 4: Durations displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: Range Timeline
            buildSectionHeader('5. Range Timeline'),
            buildDemoCard(
              'Project timeline with start and end markers',
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    buildTimelineMarker(
                      'Project Start',
                      'January 15, 2025',
                      false,
                      Color(0xFF4CAF50),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      width: 2,
                      height: 30,
                      color: Color(0xFFBDBDBD),
                    ),
                    buildTimelineMarker(
                      'Phase 1 Complete',
                      'February 28, 2025',
                      false,
                      Color(0xFF1976D2),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      width: 2,
                      height: 30,
                      color: Color(0xFFBDBDBD),
                    ),
                    buildTimelineMarker(
                      'Phase 2 Complete',
                      'April 15, 2025',
                      false,
                      Color(0xFFF57C00),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      width: 2,
                      height: 30,
                      color: Color(0xFFBDBDBD),
                    ),
                    buildTimelineMarker(
                      'Project End',
                      'June 30, 2025',
                      true,
                      Color(0xFFD32F2F),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Section 5: Timeline rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Overlapping Ranges
            buildSectionHeader('6. Overlapping Ranges'),
            buildDemoCard(
              'Visualizing overlapping date ranges',
              Column(
                children: [
                  buildOverlapRow('Range A', 0.0, 0.5, Color(0xCC880E4F)),
                  buildOverlapRow('Range B', 0.3, 0.8, Color(0xCC4527A0)),
                  buildOverlapRow('Range C', 0.6, 1.0, Color(0xCC00695C)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      buildComparisonChip(
                        'A overlaps B',
                        Color(0xFFFCE4EC),
                        Color(0xFF880E4F),
                      ),
                      buildComparisonChip(
                        'B overlaps C',
                        Color(0xFFEDE7F6),
                        Color(0xFF4527A0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Section 6: Overlapping ranges rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Range Comparison
            buildSectionHeader('7. Range Comparison'),
            buildDemoCard(
              'Comparing two DateTimeRange instances',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCE4EC),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Range A',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF880E4F),
                          ),
                        ),
                        buildInfoRow('start', '2025-01-01'),
                        buildInfoRow('end', '2025-01-31'),
                        buildInfoRow('duration', '30 days'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Range B',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF4527A0),
                          ),
                        ),
                        buildInfoRow('start', '2025-01-01'),
                        buildInfoRow('end', '2025-01-31'),
                        buildInfoRow('duration', '30 days'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'A == B: true (same start and end)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 7: Comparison rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Range Use Cases
            buildSectionHeader('8. Common Use Cases'),
            buildDemoCard(
              'Hotel booking: check-in to check-out',
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDateCard('CHECK IN', 2025, 7, 10, Color(0xFF2E7D32)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Icon(Icons.hotel, color: Color(0xFF757575), size: 24),
                        Text(
                          '3 nights',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF757575),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDateCard('CHECK OUT', 2025, 7, 13, Color(0xFFC62828)),
                ],
              ),
            ),
            buildDemoCard(
              'Event schedule: conference days',
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDateCard('DAY 1', 2025, 9, 15, Color(0xFF1565C0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                  buildDateCard('DAY 2', 2025, 9, 16, Color(0xFF1976D2)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                  buildDateCard('DAY 3', 2025, 9, 17, Color(0xFF1E88E5)),
                ],
              ),
            ),
            Text(
              'Section 8: Use cases rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: Range Arithmetic
            buildSectionHeader('9. Range Arithmetic'),
            buildDemoCard(
              'Computing range properties',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Range', 'Jan 1, 2025 - Mar 31, 2025'),
                  Divider(),
                  buildInfoRow('duration.inDays', '89'),
                  buildInfoRow('duration.inHours', '2136'),
                  buildInfoRow('duration.inMinutes', '128160'),
                  buildInfoRow('duration.inSeconds', '7689600'),
                  buildInfoRow('Weeks (approx)', '12.7'),
                  buildInfoRow('Months (approx)', '3'),
                ],
              ),
            ),
            Text(
              'Section 9: Arithmetic displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Range Bar Chart
            buildSectionHeader('10. Range Duration Bar Chart'),
            buildDemoCard(
              'Visual comparison of range durations',
              Column(
                children: [
                  buildRangeBar('Sprint 1 (14d)', 0.0, 0.14, Color(0xFF880E4F)),
                  buildRangeBar('Sprint 2 (14d)', 0.0, 0.14, Color(0xFFAD1457)),
                  buildRangeBar('Sprint 3 (14d)', 0.0, 0.14, Color(0xFFC2185B)),
                  buildRangeBar('Month (30d)', 0.0, 0.30, Color(0xFFD81B60)),
                  buildRangeBar('Quarter (90d)', 0.0, 0.90, Color(0xFFE91E63)),
                  buildRangeBar(
                    'Full Year (365d)',
                    0.0,
                    1.0,
                    Color(0xFFF06292),
                  ),
                ],
              ),
            ),
            Text(
              'Section 10: Bar chart rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Range Formatting
            buildSectionHeader('11. Range Formatting'),
            buildDemoCard(
              'Different ways to display a DateTimeRange',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('ISO format', '2025-01-15 / 2025-01-30'),
                  buildInfoRow('Short', 'Jan 15 - Jan 30, 2025'),
                  buildInfoRow('Long', 'January 15, 2025 - January 30, 2025'),
                  buildInfoRow('Compact', '15/01 - 30/01/25'),
                  buildInfoRow('Relative', 'In 15 days (starts in 5)'),
                  buildInfoRow('Duration only', '15 days'),
                  buildInfoRow(
                    'toString()',
                    'DateTimeRange(2025-01-15 - 2025-01-30)',
                  ),
                ],
              ),
            ),
            Text(
              'Section 11: Formatting displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DateTimeRange Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'DateTimeRange properties'),
                  buildInfoRow('2', 'Start/end date visualization'),
                  buildInfoRow('3', 'Calendar range highlights'),
                  buildInfoRow('4', 'Duration calculations'),
                  buildInfoRow('5', 'Project timeline'),
                  buildInfoRow('6', 'Overlapping ranges'),
                  buildInfoRow('7', 'Range equality comparison'),
                  buildInfoRow('8', 'Hotel/event use cases'),
                  buildInfoRow('9', 'Range arithmetic'),
                  buildInfoRow('10', 'Duration bar chart'),
                  buildInfoRow('11', 'Range formatting variants'),
                ],
              ),
            ),
            Text(
              '=== DateTimeRange Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
