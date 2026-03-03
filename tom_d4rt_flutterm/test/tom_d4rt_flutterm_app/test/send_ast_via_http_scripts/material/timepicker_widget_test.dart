// D4rt test script: Tests TimePickerDialog from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerDialog test executing');

  // Variation 1: Basic TimePickerDialog
  final widget1 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 10, minute: 30),
  );
  print('TimePickerDialog(initialTime: 10:30) created');

  // Variation 2: TimePickerDialog with helpText
  final widget2 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 14, minute: 0),
    helpText: 'Select time',
  );
  print('TimePickerDialog(helpText) created');

  // Variation 3: TimePickerDialog with cancelText and confirmText
  final widget3 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 8, minute: 15),
    cancelText: 'Dismiss',
    confirmText: 'Set',
  );
  print('TimePickerDialog(cancelText, confirmText) created');

  // Variation 4: TimePickerDialog with initialEntryMode input
  final widget4 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 16, minute: 45),
    initialEntryMode: TimePickerEntryMode.input,
  );
  print('TimePickerDialog(initialEntryMode: input) created');

  // Variation 5: TimePickerDialog with initialEntryMode inputOnly
  final widget5 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 23, minute: 59),
    initialEntryMode: TimePickerEntryMode.inputOnly,
  );
  print('TimePickerDialog(initialEntryMode: inputOnly) created');

  // Variation 6: TimePickerDialog with initialEntryMode dialOnly
  final widget6 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 6, minute: 0),
    initialEntryMode: TimePickerEntryMode.dialOnly,
  );
  print('TimePickerDialog(initialEntryMode: dialOnly) created');

  // Variation 7: TimePickerDialog with orientation
  final widget7 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 12, minute: 0),
    orientation: Orientation.landscape,
  );
  print('TimePickerDialog(orientation: landscape) created');

  // Variation 8: TimePickerDialog with errorInvalidText
  final widget8 = TimePickerDialog(
    initialTime: TimeOfDay(hour: 9, minute: 0),
    errorInvalidText: 'Invalid time entered',
    hourLabelText: 'Hour',
    minuteLabelText: 'Minute',
  );
  print('TimePickerDialog(errorInvalidText, hourLabelText, minuteLabelText) created');

  print('TimePickerDialog test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget4),
      Expanded(child: widget6),
    ],
  );
}
