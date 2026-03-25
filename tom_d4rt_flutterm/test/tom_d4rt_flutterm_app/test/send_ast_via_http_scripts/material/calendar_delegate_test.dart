// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests calendar-related delegates from material
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange.shade800,
      ),
    ),
  );
}

// Helper to build description
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper: build a mini calendar grid for a given month
Widget buildMiniCalendar({
  required int year,
  required int month,
  Color? headerColor,
  Color? selectedDayColor,
  int? selectedDay,
  Color? todayColor,
  int? todayDay,
  Set<int>? highlightedDays,
  Color? highlightColor,
}) {
  Color hdrColor = headerColor ?? Colors.deepOrange;
  Color selColor = selectedDayColor ?? Colors.deepOrange;
  Color tdyColor = todayColor ?? Colors.orange;
  Color hlColor = highlightColor ?? Colors.orange.shade100;
  Set<int> highlighted = highlightedDays ?? <int>{};

  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  DateTime firstDay = DateTime(year, month, 1);
  int daysInMonth = DateTime(year, month + 1, 0).day;
  int startWeekday = firstDay.weekday; // 1 = Monday

  List<Widget> dayHeaders = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
      .map(
        (d) => Expanded(
          child: Center(
            child: Text(
              d,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      )
      .toList();

  List<Widget> dayCells = [];
  // Add empty cells for days before the 1st
  for (int i = 1; i < startWeekday; i++) {
    dayCells.add(Expanded(child: SizedBox(height: 32)));
  }

  for (int day = 1; day <= daysInMonth; day++) {
    bool isSelected = day == selectedDay;
    bool isToday = day == todayDay;
    bool isHighlighted = highlighted.contains(day);

    Color? bgColor;
    Color textColor = Colors.black87;
    FontWeight weight = FontWeight.normal;

    if (isSelected) {
      bgColor = selColor;
      textColor = Colors.white;
      weight = FontWeight.bold;
    } else if (isToday) {
      bgColor = tdyColor.withAlpha(50);
      textColor = tdyColor;
      weight = FontWeight.w600;
    } else if (isHighlighted) {
      bgColor = hlColor;
    }

    dayCells.add(
      Expanded(
        child: Container(
          height: 32,
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: bgColor,
            shape: isSelected ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isSelected ? null : BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: weight,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Pad to complete the last week row
  int totalCells = dayCells.length;
  int remainder = totalCells % 7;
  if (remainder != 0) {
    for (int i = 0; i < 7 - remainder; i++) {
      dayCells.add(Expanded(child: SizedBox(height: 32)));
    }
  }

  List<Widget> weeks = [];
  for (int i = 0; i < dayCells.length; i += 7) {
    weeks.add(Row(children: dayCells.sublist(i, i + 7)));
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      children: [
        // Month header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: hdrColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.chevron_left, color: Colors.white, size: 20),
              Text(
                '${monthNames[month - 1]} $year',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white, size: 20),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(children: dayHeaders),
              SizedBox(height: 4),
              ...weeks,
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: build a date range display
Widget buildDateRange({
  required String label,
  required String startDate,
  required String endDate,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(Icons.date_range, color: color, size: 20),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '$startDate  >>  $endDate',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper: day cell style legend
Widget buildLegendItem(String label, Color color, {bool isCircle = false}) {
  return Padding(
    padding: EdgeInsets.only(right: 16, bottom: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

// Helper: property chip
Widget buildPropertyChip(String label, String value, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color.withAlpha(180)),
        ),
        SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Calendar Delegate Deep Demo ===');
  debugPrint(
    'Demonstrating calendar visuals: DatePicker themes, day cells, month grids',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade700, Colors.deepOrange.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calendar Delegate Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Calendar visuals: month grids, day cells, date headers, navigation themes',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Basic Month Grids
        buildSectionTitle('1. Basic Month Grids'),
        buildDescription('Mini calendar grids with standard layout'),

        buildMiniCalendar(year: 2025, month: 1, selectedDay: 15, todayDay: 8),
        buildMiniCalendar(
          year: 2025,
          month: 2,
          selectedDay: 14,
          todayDay: 8,
          headerColor: Colors.pink,
          selectedDayColor: Colors.pink,
        ),
        buildMiniCalendar(
          year: 2025,
          month: 3,
          selectedDay: 21,
          todayDay: 8,
          headerColor: Colors.green.shade700,
          selectedDayColor: Colors.green,
          todayColor: Colors.lightGreen,
        ),

        // Day cell legend
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Day Cell Legend',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Wrap(
                children: [
                  buildLegendItem(
                    'Selected Day',
                    Colors.deepOrange,
                    isCircle: true,
                  ),
                  buildLegendItem('Today', Colors.orange.shade100),
                  buildLegendItem('Highlighted', Colors.orange.shade50),
                  buildLegendItem('Normal', Colors.white),
                ],
              ),
            ],
          ),
        ),

        // Section 2: Highlighted Days
        buildSectionTitle('2. Highlighted Days'),
        buildDescription('Days with special highlights (events, reminders)'),

        buildMiniCalendar(
          year: 2025,
          month: 4,
          selectedDay: 10,
          todayDay: 5,
          highlightedDays: {1, 7, 14, 21, 28},
          highlightColor: Colors.blue.shade100,
          headerColor: Colors.blue.shade700,
          selectedDayColor: Colors.blue,
        ),
        buildMiniCalendar(
          year: 2025,
          month: 5,
          selectedDay: 25,
          todayDay: 12,
          highlightedDays: {3, 5, 8, 12, 15, 19, 22, 26},
          highlightColor: Colors.purple.shade100,
          headerColor: Colors.purple,
          selectedDayColor: Colors.purple,
        ),

        // Section 3: Color Themed Calendars
        buildSectionTitle('3. Color Themed Calendars'),
        buildDescription('Different color themes for calendar presentation'),

        buildMiniCalendar(
          year: 2025,
          month: 6,
          selectedDay: 15,
          todayDay: 3,
          headerColor: Colors.teal,
          selectedDayColor: Colors.teal,
          todayColor: Colors.tealAccent,
        ),
        buildMiniCalendar(
          year: 2025,
          month: 7,
          selectedDay: 4,
          todayDay: 20,
          headerColor: Colors.red.shade800,
          selectedDayColor: Colors.red,
          todayColor: Colors.redAccent,
          highlightedDays: {4, 14},
          highlightColor: Colors.red.shade50,
        ),
        buildMiniCalendar(
          year: 2025,
          month: 8,
          selectedDay: 1,
          todayDay: 30,
          headerColor: Colors.grey.shade800,
          selectedDayColor: Colors.grey.shade700,
          todayColor: Colors.blueGrey,
        ),

        // Section 4: Date Range Display
        buildSectionTitle('4. Date Range Displays'),
        buildDescription('Visual representation of date ranges'),

        buildDateRange(
          label: 'Sprint Period',
          startDate: 'Jan 6, 2025',
          endDate: 'Jan 17, 2025',
          color: Colors.blue,
        ),
        buildDateRange(
          label: 'Vacation',
          startDate: 'Feb 10, 2025',
          endDate: 'Feb 21, 2025',
          color: Colors.green,
        ),
        buildDateRange(
          label: 'Project Deadline',
          startDate: 'Mar 1, 2025',
          endDate: 'Mar 31, 2025',
          color: Colors.red,
        ),
        buildDateRange(
          label: 'Conference',
          startDate: 'Apr 15, 2025',
          endDate: 'Apr 18, 2025',
          color: Colors.purple,
        ),

        // Section 5: DatePicker Theme Showcase
        buildSectionTitle('5. DatePicker Theme Colors'),
        buildDescription('Color palettes used in DatePickerThemeData'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DatePickerThemeData Properties',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Wrap(
                children: [
                  buildPropertyChip('backgroundColor', 'surface', Colors.blue),
                  buildPropertyChip('headerBgColor', 'primary', Colors.blue),
                  buildPropertyChip('headerFgColor', 'onPrimary', Colors.blue),
                  buildPropertyChip('dayBgColor', 'primary', Colors.green),
                  buildPropertyChip('dayFgColor', 'onPrimary', Colors.green),
                  buildPropertyChip(
                    'todayBgColor',
                    'transparent',
                    Colors.orange,
                  ),
                  buildPropertyChip('todayFgColor', 'primary', Colors.orange),
                  buildPropertyChip('yearBgColor', 'primary', Colors.purple),
                  buildPropertyChip('yearFgColor', 'onPrimary', Colors.purple),
                  buildPropertyChip(
                    'rangeHighlight',
                    'primaryContainer',
                    Colors.red,
                  ),
                  buildPropertyChip('surfaceTint', 'surfaceTint', Colors.teal),
                  buildPropertyChip('elevation', '6.0', Colors.grey),
                  buildPropertyChip('shape', 'rounded', Colors.grey),
                ],
              ),
            ],
          ),
        ),

        // Section 6: Themed DatePicker Examples
        buildSectionTitle('6. Themed DatePicker Previews'),
        buildDescription('Full DatePickerDialog with theme customization'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.deepOrange,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              datePickerTheme: DatePickerThemeData(
                backgroundColor: Colors.white,
                headerBackgroundColor: Colors.deepOrange,
                headerForegroundColor: Colors.white,
                dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black87;
                }),
                dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.deepOrange;
                  }
                  return null;
                }),
                todayForegroundColor: WidgetStateProperty.all(
                  Colors.deepOrange,
                ),
                todayBorder: BorderSide(color: Colors.deepOrange),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: DatePickerDialog(
              firstDate: DateTime(2024, 1, 1),
              lastDate: DateTime(2026, 12, 31),
              initialDate: DateTime(2025, 1, 15),
            ),
          ),
        ),

        SizedBox(height: 16),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Theme(
            data: ThemeData.dark().copyWith(
              datePickerTheme: DatePickerThemeData(
                backgroundColor: Colors.grey.shade900,
                headerBackgroundColor: Colors.teal.shade700,
                headerForegroundColor: Colors.white,
                dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.grey.shade300;
                }),
                dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) return Colors.teal;
                  return null;
                }),
                todayForegroundColor: WidgetStateProperty.all(
                  Colors.tealAccent,
                ),
                todayBorder: BorderSide(color: Colors.tealAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: DatePickerDialog(
              firstDate: DateTime(2024, 1, 1),
              lastDate: DateTime(2026, 12, 31),
              initialDate: DateTime(2025, 3, 10),
            ),
          ),
        ),

        // Section 7: Year Picker Grid
        buildSectionTitle('7. Year Selection Grid'),
        buildDescription('Visual representation of year picker grid'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Year Selection',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(12, (i) {
                  int year = 2020 + i;
                  bool isSelected = year == 2025;
                  bool isCurrent = year == 2025;
                  return Container(
                    width: 72,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.deepOrange
                          : (isCurrent
                                ? Colors.deepOrange.withAlpha(30)
                                : Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(18),
                      border: isCurrent && !isSelected
                          ? Border.all(color: Colors.deepOrange)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected || isCurrent
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : (isCurrent
                                    ? Colors.deepOrange
                                    : Colors.black87),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),

        // Section 8: Month Navigation
        buildSectionTitle('8. Month Navigation Visualization'),
        buildDescription(
          'Navigation header patterns for calendar month switching',
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildNavHeader('January 2025', Colors.deepOrange),
              _buildNavHeader('February 2025', Colors.blue),
              _buildNavHeader('March 2025', Colors.green.shade700),
              _buildNavHeader('April 2025', Colors.purple),
              _buildNavHeader('May 2025', Colors.teal),
            ],
          ),
        ),

        // Section 9: Calendar Property Overview
        buildSectionTitle('9. Calendar Properties Summary'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DatePicker Key Components',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              _buildComponentRow(
                'Header',
                'Month/year display with navigation arrows',
                Colors.deepOrange,
              ),
              _buildComponentRow(
                'Day Grid',
                '7-column layout with weekday headers',
                Colors.blue,
              ),
              _buildComponentRow(
                'Day Cell',
                'Individual day with selected/today/disabled states',
                Colors.green,
              ),
              _buildComponentRow(
                'Year Picker',
                'Grid of selectable years',
                Colors.purple,
              ),
              _buildComponentRow(
                'Month Picker',
                'Grid of selectable months',
                Colors.teal,
              ),
              _buildComponentRow(
                'Actions',
                'Cancel/OK buttons at bottom',
                Colors.orange,
              ),
            ],
          ),
        ),

        // Summary
        buildSectionTitle('10. Summary'),
        buildInfoBox(
          'Calendar delegates manage date selection, validation, and formatting. '
          'DatePickerThemeData customizes colors, shapes, and text styles.',
          Colors.deepOrange,
        ),
        buildInfoBox(
          'Individual day cells support selected, today, disabled, and range '
          'highlight states through WidgetStateProperty.',
          Colors.blue,
        ),
        buildInfoBox(
          'Month/year navigation, year picker grid, and date range selection '
          'can all be themed via DatePickerThemeData.',
          Colors.green,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}

// Helper: month navigation header
Widget _buildNavHeader(String monthYear, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_left, color: color),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        Text(
          monthYear,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_right, color: color),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    ),
  );
}

// Helper: component description row
Widget _buildComponentRow(String name, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}
