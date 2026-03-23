// ignore_for_file: avoid_print
// D4rt test script: Tests showTimePicker from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showTimePicker test executing');

  // Schedule showTimePicker via Future.microtask
  Future.microtask(() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 30),
      helpText: 'Select time',
      cancelText: 'Cancel',
      confirmText: 'OK',
      hourLabelText: 'Hour',
      minuteLabelText: 'Minute',
      initialEntryMode: TimePickerEntryMode.dial,
    ).then((selectedTime) {
      print('showTimePicker result: $selectedTime');
      if (selectedTime != null) {
        print('  hour: ${selectedTime.hour}');
        print('  minute: ${selectedTime.minute}');
        print('  period: ${selectedTime.period}');
        print('  hourOfPeriod: ${selectedTime.hourOfPeriod}');
        print('  format: ${selectedTime.format(context)}');
      }
    });
    print('showTimePicker called');
  });

  // Test TimeOfDay constructors and properties
  final time1 = TimeOfDay(hour: 14, minute: 30);
  print('TimeOfDay(14:30): $time1');
  print('  hour: ${time1.hour}');
  print('  minute: ${time1.minute}');
  print('  period: ${time1.period}');
  print('  hourOfPeriod: ${time1.hourOfPeriod}');
  print('  format: ${time1.format(context)}');

  final timeNow = TimeOfDay.now();
  print('TimeOfDay.now(): $timeNow');
  print('  hour: ${timeNow.hour}');
  print('  minute: ${timeNow.minute}');

  // TimeOfDay.hoursPerDay and minutesPerHour
  print('TimeOfDay.hoursPerDay: ${TimeOfDay.hoursPerDay}');
  print('TimeOfDay.hoursPerPeriod: ${TimeOfDay.hoursPerPeriod}');
  print('TimeOfDay.minutesPerHour: ${TimeOfDay.minutesPerHour}');

  // Test replacing
  final time2 = time1.replacing(hour: 9);
  print('replacing(hour: 9): $time2');
  final time3 = time1.replacing(minute: 0);
  print('replacing(minute: 0): $time3');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('showTimePicker scheduled'),
        SizedBox(height: 8.0),
        Text('Time picker should appear as overlay'),
        SizedBox(height: 8.0),
        Text('TimeOfDay(14:30): $time1'),
        Text('TimeOfDay.now(): $timeNow'),
        Text('format: ${time1.format(context)}'),
        SizedBox(height: 16.0),
        // Button for input-mode time picker
        ElevatedButton(
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 8, minute: 0),
              initialEntryMode: TimePickerEntryMode.input,
              helpText: 'Enter time',
            ).then((time) {
              print('Input-mode time picker result: $time');
            });
            print('showTimePicker (input mode) called');
          },
          child: Text('Show Time Input'),
        ),
        SizedBox(height: 8.0),
        // Button for dial-mode time picker
        ElevatedButton(
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 16, minute: 45),
              initialEntryMode: TimePickerEntryMode.dialOnly,
              helpText: 'Dial only',
            ).then((time) {
              print('Dial-only time picker result: $time');
            });
            print('showTimePicker (dialOnly) called');
          },
          child: Text('Show Dial Only'),
        ),
      ],
    ),
  );
}
