// D4rt test script: Tests DatePickerDialog, CalendarDatePicker, YearPicker from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DatePicker widgets test executing');

  final now = DateTime(2025, 6, 15);
  final firstDate = DateTime(2020, 1, 1);
  final lastDate = DateTime(2030, 12, 31);

  // ========== DATEPICKERDIALOG ==========
  print('--- DatePickerDialog Tests ---');

  // Variation 1: Basic DatePickerDialog
  final widget1 = DatePickerDialog(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
  );
  print('DatePickerDialog(initialDate, firstDate, lastDate) created');

  // Variation 2: DatePickerDialog with helpText
  final widget2 = DatePickerDialog(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: 'Select a date',
  );
  print('DatePickerDialog(helpText) created');

  // Variation 3: DatePickerDialog with cancelText and confirmText
  final widget3 = DatePickerDialog(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    cancelText: 'Cancel',
    confirmText: 'OK',
  );
  print('DatePickerDialog(cancelText, confirmText) created');

  // Variation 4: DatePickerDialog with initialEntryMode
  final widget4 = DatePickerDialog(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    initialEntryMode: DatePickerEntryMode.input,
  );
  print('DatePickerDialog(initialEntryMode: input) created');

  // Variation 5: DatePickerDialog in inputOnly mode
  final widget5 = DatePickerDialog(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    initialEntryMode: DatePickerEntryMode.inputOnly,
  );
  print('DatePickerDialog(initialEntryMode: inputOnly) created');

  // ========== CALENDARDATEPICKER ==========
  print('--- CalendarDatePicker Tests ---');

  // Variation 6: Basic CalendarDatePicker
  final widget6 = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    onDateChanged: (DateTime date) {
      print('Date changed: $date');
    },
  );
  print('CalendarDatePicker(basic) created');

  // Variation 7: CalendarDatePicker with initialCalendarMode.year
  final widget7 = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    initialCalendarMode: DatePickerMode.year,
    onDateChanged: (DateTime date) {
      print('Year mode date: $date');
    },
  );
  print('CalendarDatePicker(initialCalendarMode: year) created');

  // Variation 8: CalendarDatePicker with currentDate
  final widget8 = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: DateTime(2025, 6, 20),
    onDateChanged: (DateTime date) {},
  );
  print('CalendarDatePicker(currentDate) created');

  // ========== YEARPICKER ==========
  print('--- YearPicker Tests ---');

  // Variation 9: Basic YearPicker
  final widget9 = YearPicker(
    selectedDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    onChanged: (DateTime date) {
      print('Year selected: ${date.year}');
    },
  );
  print('YearPicker(basic) created');

  // Variation 10: YearPicker with currentDate
  final widget10 = YearPicker(
    selectedDate: DateTime(2025, 1, 1),
    firstDate: DateTime(2000, 1, 1),
    lastDate: DateTime(2050, 12, 31),
    currentDate: DateTime(2025, 6, 15),
    onChanged: (DateTime date) {},
  );
  print('YearPicker(currentDate) created');

  print('DatePicker widgets test completed');
  return Material(
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 400, child: widget1),
          SizedBox(height: 400, child: widget6),
          SizedBox(height: 300, child: widget9),
        ],
      ),
    ),
  );
}
