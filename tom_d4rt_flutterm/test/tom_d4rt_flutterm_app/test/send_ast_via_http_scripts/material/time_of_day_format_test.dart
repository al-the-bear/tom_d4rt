// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TimeOfDayFormat from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDayFormat test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTimeOfDayFormat values:');
  for (final value in TimeOfDayFormat.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TimeOfDayFormat has ${TimeOfDayFormat.values.length} values');

  // First and last
  final first = TimeOfDayFormat.values.first;
  final last = TimeOfDayFormat.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values with format explanation
  print('\nSpecific values:');
  print('HH_colon_mm: ${TimeOfDayFormat.HH_colon_mm.name}');
  print('  Format: 14:30 (24-hour, colon separator)');
  print('  Common in: Most European countries');
  print('HH_dot_mm: ${TimeOfDayFormat.HH_dot_mm.name}');
  print('  Format: 14.30 (24-hour, dot separator)');
  print('  Common in: Finland, Indonesia');
  print('frenchCanadian: ${TimeOfDayFormat.frenchCanadian.name}');
  print('  Format: 14h30 (Canadian French, h separator)');
  print('  Common in: Canadian French locales');
  print('H_colon_mm: ${TimeOfDayFormat.H_colon_mm.name}');
  print('  Format: 2:30 (24-hour, non-padded, colon separator)');
  print('  Common in: Some 24-hour locales');
  print('h_colon_mm_space_a: ${TimeOfDayFormat.h_colon_mm_space_a.name}');
  print('  Format: 2:30 PM (12-hour with AM/PM after)');
  print('  Common in: United States, UK');
  print('a_space_h_colon_mm: ${TimeOfDayFormat.a_space_h_colon_mm.name}');
  print('  Format: PM 2:30 (day period before time)');
  print('  Common in: Some Asian locales');

  // 12-hour vs 24-hour classification
  print('\n12-hour vs 24-hour:');
  for (final fmt in TimeOfDayFormat.values) {
    final is24 = fmt == TimeOfDayFormat.HH_colon_mm ||
        fmt == TimeOfDayFormat.HH_dot_mm ||
        fmt == TimeOfDayFormat.frenchCanadian ||
        fmt == TimeOfDayFormat.H_colon_mm;
    print('  ${fmt.name}: ${is24 ? "24-hour" : "12-hour"}');
  }

  // Equality tests
  print('\nEquality tests:');
  print('HH_colon_mm == HH_colon_mm: ${TimeOfDayFormat.HH_colon_mm == TimeOfDayFormat.HH_colon_mm}');
  print('HH_colon_mm == HH_dot_mm: ${TimeOfDayFormat.HH_colon_mm == TimeOfDayFormat.HH_dot_mm}');
  print('identical: ${identical(TimeOfDayFormat.HH_colon_mm, TimeOfDayFormat.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TimeOfDayFormat: ${first is TimeOfDayFormat}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TimeOfDayFormat.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // TimeOfDay usage
  print('\nTimeOfDay integration:');
  final morning = TimeOfDay(hour: 9, minute: 15);
  final afternoon = TimeOfDay(hour: 14, minute: 30);
  print('  morning (9:15): hour=${morning.hour}, minute=${morning.minute}');
  print('  afternoon (14:30): hour=${afternoon.hour}, minute=${afternoon.minute}');
  print('  morning.period: ${morning.period}');
  print('  afternoon.period: ${afternoon.period}');
  print('  morning.hourOfPeriod: ${morning.hourOfPeriod}');
  print('  afternoon.hourOfPeriod: ${afternoon.hourOfPeriod}');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < TimeOfDayFormat.values.length; i++) {
    final v = TimeOfDayFormat.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('TimeOfDayFormat test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TimeOfDayFormat Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TimeOfDayFormat.values.length}'),
      for (final v in TimeOfDayFormat.values)
        Text('  ${v.name} (${v.index})'),
      Text('Localization: controls time display format'),
    ],
  );
}
