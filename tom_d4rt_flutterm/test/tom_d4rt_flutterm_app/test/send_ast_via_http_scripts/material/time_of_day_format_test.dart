// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TimeOfDayFormat from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDayFormat test executing');
  print('=' * 50);

  // TimeOfDayFormat enum overview
  print('TimeOfDayFormat enum overview:');
  print('  - Time display format');
  print('  - Locale-specific ordering');
  print('  - 6 values for different cultures');

  // Enumerate all values
  print('\nTimeOfDayFormat values:');
  for (final value in TimeOfDayFormat.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TimeOfDayFormat has ${TimeOfDayFormat.values.length} values');

  // Test h_colon_mm_space_a
  print('\nTest TimeOfDayFormat.h_colon_mm_space_a:');
  final f1 = TimeOfDayFormat.h_colon_mm_space_a;
  print('  Name: ${f1.name}');
  print('  Pattern: HH:mm a (e.g., 10:30 AM)');
  print('  12-hour format with AM/PM after');

  // Test a_space_h_colon_mm
  print('\nTest TimeOfDayFormat.a_space_h_colon_mm:');
  final f2 = TimeOfDayFormat.a_space_h_colon_mm;
  print('  Name: ${f2.name}');
  print('  Pattern: a HH:mm (e.g., AM 10:30)');
  print('  12-hour format with AM/PM before');

  // Test HH_colon_mm
  print('\nTest TimeOfDayFormat.HH_colon_mm:');
  final f3 = TimeOfDayFormat.HH_colon_mm;
  print('  Name: ${f3.name}');
  print('  Pattern: HH:mm (e.g., 14:30)');
  print('  24-hour format');

  // Test HH_dot_mm
  print('\nTest TimeOfDayFormat.HH_dot_mm:');
  final f4 = TimeOfDayFormat.HH_dot_mm;
  print('  Name: ${f4.name}');
  print('  Pattern: HH.mm (e.g., 14.30)');
  print('  24-hour format with dot');

  // Test frenchCanadian
  print('\nTest TimeOfDayFormat.frenchCanadian:');
  final f5 = TimeOfDayFormat.frenchCanadian;
  print('  Name: ${f5.name}');
  print('  Pattern: HH h mm (e.g., 14 h 30)');
  print('  French Canadian format');

  // Test h_colon_mm_space_a
  print('\nTest TimeOfDayFormat.h_colon_mm_space_a:');
  final f6 = TimeOfDayFormat.h_colon_mm_space_a;
  print('  Name: ${f6.name}');
  print('  Pattern: h:mm a (e.g., 2:30 PM)');
  print('  12-hour format without leading zero');

  // Format categories
  print('\nFormat categories:');
  print('  12-hour: HH_colon_mm_space_a, a_space_HH_colon_mm, h_colon_mm_space_a');
  print('  24-hour: HH_colon_mm, HH_dot_mm, frenchCanadian');

  // Usage context
  print('\nUsage context:');
  print('  MaterialLocalizations.timeOfDayFormat()');
  print('  Determines time picker display');

  print('\n' + '=' * 50);
  print('TimeOfDayFormat test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TimeOfDayFormat Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: 6 format patterns'),
      Text('Purpose: Locale time formatting'),
    ],
  );
}
