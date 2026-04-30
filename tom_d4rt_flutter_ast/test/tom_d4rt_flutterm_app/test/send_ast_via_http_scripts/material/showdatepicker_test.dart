// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests showDatePicker from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showDatePicker test executing');

  // Schedule showDatePicker via Future.microtask
  Future.microtask(() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2024, 6, 15),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      helpText: 'Select a date',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
      initialDatePickerMode: DatePickerMode.day,
    ).then((selectedDate) {
      print('showDatePicker result: $selectedDate');
    });
    print('showDatePicker called');
  });

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('showDatePicker scheduled'),
        SizedBox(height: 8.0),
        Text('Date picker should appear as overlay'),
        SizedBox(height: 16.0),
        // Button for date range picker
        ElevatedButton(
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(2030, 12, 31),
              initialDateRange: DateTimeRange(
                start: DateTime(2024, 6, 1),
                end: DateTime(2024, 6, 30),
              ),
              helpText: 'Select date range',
            ).then((range) {
              print('showDateRangePicker result: $range');
              if (range != null) {
                print('  start: ${range.start}');
                print('  end: ${range.end}');
                print('  duration: ${range.duration}');
              }
            });
            print('showDateRangePicker called from button');
          },
          child: Text('Show Date Range Picker'),
        ),
        SizedBox(height: 8.0),
        // Button for date picker in year mode
        ElevatedButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime(2024, 1, 1),
              firstDate: DateTime(2000, 1, 1),
              lastDate: DateTime(2050, 12, 31),
              initialDatePickerMode: DatePickerMode.year,
              helpText: 'Select year first',
            ).then((date) {
              print('Year-mode date picker result: $date');
            });
            print('showDatePicker (year mode) called');
          },
          child: Text('Show Year Picker'),
        ),
        SizedBox(height: 8.0),
        // InputDatePickerFormField as inline widget alternative
        InputDatePickerFormField(
          firstDate: DateTime(2020, 1, 1),
          lastDate: DateTime(2030, 12, 31),
          initialDate: DateTime(2024, 6, 15),
          fieldLabelText: 'Enter date',
          onDateSubmitted: (date) {
            print('InputDatePickerFormField submitted: $date');
          },
          onDateSaved: (date) {
            print('InputDatePickerFormField saved: $date');
          },
        ),
      ],
    ),
  );
}
