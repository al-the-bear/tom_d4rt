// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests DayPeriod from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DayPeriod test executing');
  print('=' * 50);

  // DayPeriod is an enum with 2 values
  print('DayPeriod enum values:');
  for (final period in DayPeriod.values) {
    print('  ${period.name}: index=${period.index}');
  }
  print('DayPeriod has ${DayPeriod.values.length} values');

  // Test first and last
  final first = DayPeriod.values.first;
  final last = DayPeriod.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test AM
  print('\nTesting DayPeriod.am:');
  final am = DayPeriod.am;
  print('  name: ${am.name}');
  print('  index: ${am.index}');
  print('  toString: $am');
  print('  Meaning: Ante meridiem (before noon)');

  // Test PM
  print('\nTesting DayPeriod.pm:');
  final pm = DayPeriod.pm;
  print('  name: ${pm.name}');
  print('  index: ${pm.index}');
  print('  toString: $pm');
  print('  Meaning: Post meridiem (after noon)');

  // Test equality
  print('\nEquality tests:');
  print('am == am: ${am == am}');
  print('am == pm: ${am == pm}');
  print('pm == pm: ${pm == pm}');

  // Usage with TimeOfDay
  print('\nUsage with TimeOfDay:');
  final morningTime = TimeOfDay(hour: 9, minute: 30);
  print('Morning time (9:30): ${morningTime.format(context)}');
  print('Period: ${morningTime.period}');
  print('Is AM: ${morningTime.period == DayPeriod.am}');

  final afternoonTime = TimeOfDay(hour: 14, minute: 45);
  print('\nAfternoon time (14:45): ${afternoonTime.format(context)}');
  print('Period: ${afternoonTime.period}');
  print('Is PM: ${afternoonTime.period == DayPeriod.pm}');

  final noonTime = TimeOfDay(hour: 12, minute: 0);
  print('\nNoon time (12:00): ${noonTime.format(context)}');
  print('Period: ${noonTime.period}');

  final midnightTime = TimeOfDay(hour: 0, minute: 0);
  print('\nMidnight time (0:00): ${midnightTime.format(context)}');
  print('Period: ${midnightTime.period}');

  // Test hourOfPeriod
  print('\nhourOfPeriod examples:');
  print('9:30 hourOfPeriod: ${morningTime.hourOfPeriod}');
  print('14:45 hourOfPeriod: ${afternoonTime.hourOfPeriod}');
  print('12:00 hourOfPeriod: ${noonTime.hourOfPeriod}');
  print('0:00 hourOfPeriod: ${midnightTime.hourOfPeriod}');

  // Test periodOffset
  print('\nperiodOffset:');
  print('TimeOfDay.hoursPerPeriod: ${TimeOfDay.hoursPerPeriod}');

  // Switch statement usage
  String describePeriod(DayPeriod period) {
    switch (period) {
      case DayPeriod.am:
        return 'Morning (12:00 AM - 11:59 AM)';
      case DayPeriod.pm:
        return 'Afternoon/Evening (12:00 PM - 11:59 PM)';
    }
  }
  print('\nPeriod descriptions:');
  print('AM: ${describePeriod(DayPeriod.am)}');
  print('PM: ${describePeriod(DayPeriod.pm)}');

  print('\n' + '=' * 50);
  print('DayPeriod test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DayPeriod Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${DayPeriod.values.length}'),
      Text('am: Ante meridiem'),
      Text('pm: Post meridiem'),
      Text('Used by TimeOfDay.period'),
    ],
  );
}
