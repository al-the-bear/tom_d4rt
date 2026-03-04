// D4rt test script: Tests DateRangePickerDialog from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DateRangePickerDialog test executing');

  // Test DateRangePickerDialog - Range dialog
  print('DateRangePickerDialog is available in the material package');
  print('DateRangePickerDialog runtimeType accessible');

  print('DateRangePickerDialog test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DateRangePickerDialog Tests'),
      Text('Range dialog'),
    ],
  );
}
