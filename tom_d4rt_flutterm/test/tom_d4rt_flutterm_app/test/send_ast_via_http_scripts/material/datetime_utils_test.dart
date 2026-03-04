// D4rt test script: Tests DateUtils, DateTimeRange, TimeOfDay,
// DatePickerEntryMode, TimePickerEntryMode, DayPeriod
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Date time utilities test executing');

  // ========== DateUtils ==========
  print('--- DateUtils Tests ---');

  final today = DateTime(2025, 6, 15);
  final dateOnly = DateUtils.dateOnly(today);
  print('DateUtils.dateOnly: $dateOnly');

  final lastDay = DateUtils.getDaysInMonth(2025, 2);
  print('DateUtils.getDaysInMonth(2025, 2): $lastDay');

  final firstDayOfMonth = DateUtils.firstDayOfMonth(today);
  print('DateUtils.firstDayOfMonth: $firstDayOfMonth');

  final lastDayOfMonth = DateUtils.lastDayOfMonth(today);
  print('DateUtils.lastDayOfMonth: $lastDayOfMonth');

  final addMonths = DateUtils.addMonthsToMonthDate(today, 3);
  print('DateUtils.addMonthsToMonthDate(3): $addMonths');

  final addDays = DateUtils.addDaysToDate(today, 10);
  print('DateUtils.addDaysToDate(10): $addDays');

  final isSame = DateUtils.isSameDay(today, DateTime(2025, 6, 15, 14, 30));
  print('DateUtils.isSameDay: $isSame');

  final isSameMonth = DateUtils.isSameMonth(today, DateTime(2025, 6, 1));
  print('DateUtils.isSameMonth: $isSameMonth');

  final monthDelta = DateUtils.monthDelta(DateTime(2025, 1, 1), DateTime(2025, 6, 1));
  print('DateUtils.monthDelta(Jan to Jun): $monthDelta');

  // ========== DateTimeRange ==========
  print('--- DateTimeRange Tests ---');

  final range = DateTimeRange(
    start: DateTime(2025, 6, 1),
    end: DateTime(2025, 6, 30),
  );
  print('DateTimeRange start: ${range.start}');
  print('DateTimeRange end: ${range.end}');
  print('DateTimeRange duration: ${range.duration}');

  // ========== TimeOfDay ==========
  print('--- TimeOfDay Tests ---');

  final time1 = TimeOfDay(hour: 14, minute: 30);
  print('TimeOfDay: ${time1.hour}:${time1.minute}');
  print('TimeOfDay hourOfPeriod: ${time1.hourOfPeriod}');
  print('TimeOfDay period: ${time1.period}');
  print('TimeOfDay format: ${time1.format(context)}');

  final time2 = TimeOfDay(hour: 0, minute: 0);
  print('TimeOfDay midnight: ${time2.hour}:${time2.minute}');
  print('TimeOfDay midnight period: ${time2.period}');

  final time3 = TimeOfDay(hour: 12, minute: 0);
  print('TimeOfDay noon: ${time3.hour}:${time3.minute}');
  print('TimeOfDay noon period: ${time3.period}');

  final timeReplacing = time1.replacing(hour: 9);
  print('TimeOfDay replacing hour: ${timeReplacing.hour}:${timeReplacing.minute}');

  // ========== DayPeriod ==========
  print('--- DayPeriod Tests ---');

  print('DayPeriod.am: ${DayPeriod.am}');
  print('DayPeriod.pm: ${DayPeriod.pm}');

  // ========== DatePickerEntryMode ==========
  print('--- DatePickerEntryMode Tests ---');

  print('DatePickerEntryMode.calendar: ${DatePickerEntryMode.calendar}');
  print('DatePickerEntryMode.input: ${DatePickerEntryMode.input}');
  print('DatePickerEntryMode.calendarOnly: ${DatePickerEntryMode.calendarOnly}');
  print('DatePickerEntryMode.inputOnly: ${DatePickerEntryMode.inputOnly}');

  // ========== TimePickerEntryMode ==========
  print('--- TimePickerEntryMode Tests ---');

  print('TimePickerEntryMode.dial: ${TimePickerEntryMode.dial}');
  print('TimePickerEntryMode.input: ${TimePickerEntryMode.input}');
  print('TimePickerEntryMode.dialOnly: ${TimePickerEntryMode.dialOnly}');
  print('TimePickerEntryMode.inputOnly: ${TimePickerEntryMode.inputOnly}');

  // ========== TimeOfDayFormat ==========
  print('--- TimeOfDayFormat Tests ---');

  print('TimeOfDayFormat.HH_colon_mm: ${TimeOfDayFormat.HH_colon_mm}');
  print('TimeOfDayFormat.H_colon_mm: ${TimeOfDayFormat.H_colon_mm}');
  print('TimeOfDayFormat.h_colon_mm_space_a: ${TimeOfDayFormat.h_colon_mm_space_a}');
  print('TimeOfDayFormat.a_space_h_colon_mm: ${TimeOfDayFormat.a_space_h_colon_mm}');

  // ========== HourFormat ==========
  print('--- HourFormat Tests ---');

  print('HourFormat.HH: ${HourFormat.HH}');
  print('HourFormat.H: ${HourFormat.H}');
  print('HourFormat.h: ${HourFormat.h}');

  print('All date time utilities tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date Time Utilities Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Today: $today'),
            Text('Days in Feb 2025: $lastDay'),
            Text('DateTimeRange duration: ${range.duration.inDays} days'),
            Text('TimeOfDay: ${time1.format(context)}'),
            Text('DatePickerEntryMode values: ${DatePickerEntryMode.values.length}'),
            Text('TimePickerEntryMode values: ${TimePickerEntryMode.values.length}'),
          ],
        ),
      ),
    ),
  );
}
