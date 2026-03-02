// D4rt test script: Tests TimeOfDay from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDay test executing');

  // Variation 1: Basic TimeOfDay
  final time1 = TimeOfDay(hour: 10, minute: 30);
  print('TimeOfDay(hour: 10, minute: 30) created');
  print('time1.hour: ${time1.hour}');
  print('time1.minute: ${time1.minute}');
  print('time1.period: ${time1.period}');
  print('time1.hourOfPeriod: ${time1.hourOfPeriod}');
  print('time1.format: ${time1.format(context)}');

  // Variation 2: Midnight
  final time2 = TimeOfDay(hour: 0, minute: 0);
  print('TimeOfDay(hour: 0, minute: 0) created - midnight');
  print('time2.hour: ${time2.hour}');
  print('time2.minute: ${time2.minute}');
  print('time2.period: ${time2.period}');
  print('time2.hourOfPeriod: ${time2.hourOfPeriod}');

  // Variation 3: End of day
  final time3 = TimeOfDay(hour: 23, minute: 59);
  print('TimeOfDay(hour: 23, minute: 59) created - end of day');
  print('time3.hour: ${time3.hour}');
  print('time3.minute: ${time3.minute}');
  print('time3.period: ${time3.period}');

  // Variation 4: Now
  final time4 = TimeOfDay.now();
  print('TimeOfDay.now() created');
  print('time4.hour: ${time4.hour}');
  print('time4.minute: ${time4.minute}');

  // Variation 5: Comparisons
  print('time1.hour == 10: ${time1.hour == 10}');
  print('time1.minute == 30: ${time1.minute == 30}');
  print('time2.hour == 0: ${time2.hour == 0}');
  print('time3.hour == 23: ${time3.hour == 23}');

  // Variation 6: Replacing
  final time5 = time1.replacing(hour: 12);
  print('time1.replacing(hour: 12) created');
  print('time5.hour: ${time5.hour}');
  print('time5.minute: ${time5.minute}');

  final time6 = time1.replacing(minute: 45);
  print('time1.replacing(minute: 45) created');
  print('time6.hour: ${time6.hour}');
  print('time6.minute: ${time6.minute}');

  print('TimeOfDay test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time1: ${time1.format(context)} (10:30)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time2: ${time2.format(context)} (midnight 0:00)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time3: ${time3.format(context)} (23:59)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time4 (now): ${time4.format(context)}'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time5 (replaced hour): ${time5.format(context)} (12:30)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time6 (replaced minute): ${time6.format(context)} (10:45)'),
      ),
    ],
  );
}
