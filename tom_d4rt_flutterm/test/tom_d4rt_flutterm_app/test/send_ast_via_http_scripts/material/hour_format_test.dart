// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests HourFormat from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HourFormat test executing');
  print('=' * 50);

  // HourFormat is an enum with 3 values
  print('HourFormat enum values:');
  for (final format in HourFormat.values) {
    print('  ${format.name}: index=${format.index}');
  }
  print('HourFormat has ${HourFormat.values.length} values');

  // Test first and last
  final first = HourFormat.values.first;
  final last = HourFormat.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test HH (24-hour zero-padded)
  print('\nTesting HourFormat.HH:');
  final hh = HourFormat.HH;
  print('  name: ${hh.name}');
  print('  index: ${hh.index}');
  print('  toString: $hh');
  print('  Format: Zero-padded 24-hour (00-23)');
  print('  Example: 08, 14, 23');

  // Test H (24-hour non-padded)
  print('\nTesting HourFormat.H:');
  final h = HourFormat.H;
  print('  name: ${h.name}');
  print('  index: ${h.index}');
  print('  Format: Non-padded 24-hour (0-23)');
  print('  Example: 8, 14, 23');

  // Test h (12-hour)
  print('\nTesting HourFormat.h:');
  final h12 = HourFormat.h;
  print('  name: ${h12.name}');
  print('  index: ${h12.index}');
  print('  Format: 12-hour period (1-12)');
  print('  Example: 8, 2, 11');

  // Test equality
  print('\nEquality tests:');
  print('HH == HH: ${hh == hh}');
  print('HH == H: ${hh == h}');
  print('H == h: ${h == h12}');

  // Test hourFormat function
  print('\nhourFormat() function:');
  print('HH for h_colon_mm_space_a: ${hourFormat(of: TimeOfDayFormat.h_colon_mm_space_a)}');
  print('H for H_colon_mm: ${hourFormat(of: TimeOfDayFormat.H_colon_mm)}');
  print('HH for HH_colon_mm: ${hourFormat(of: TimeOfDayFormat.HH_colon_mm)}');

  // Time formatting examples
  print('\nTime formatting examples:');
  final time1 = TimeOfDay(hour: 8, minute: 30);
  final time2 = TimeOfDay(hour: 14, minute: 0);
  final time3 = TimeOfDay(hour: 0, minute: 15);
  print('Time 8:30 formatted: ${time1.format(context)}');
  print('Time 14:00 formatted: ${time2.format(context)}');
  print('Time 0:15 formatted: ${time3.format(context)}');

  // Index ordering
  print('\nIndex ordering:');
  print('HH.index: ${hh.index}');
  print('H.index: ${h.index}');
  print('h.index: ${h12.index}');

  // Use cases
  print('\nUse cases by locale:');
  print('HH: European 24-hour format');
  print('H: Some 24-hour locales');
  print('h: US/UK 12-hour format');

  // Test TimeOfDayFormat relationship
  print('\nTimeOfDayFormat values:');
  for (final fmt in TimeOfDayFormat.values) {
    print('  ${fmt.name}: hourFormat=${hourFormat(of: fmt).name}');
  }

  print('\n' + '=' * 50);
  print('HourFormat test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HourFormat Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${HourFormat.values.length}'),
      Text('HH: 00-23 (padded)'),
      Text('H: 0-23 (non-padded)'),
      Text('h: 1-12 (period)'),
    ],
  );
}
