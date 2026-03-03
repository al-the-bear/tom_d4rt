// D4rt test script: Tests CupertinoDatePicker with CupertinoDatePickerMode values, CupertinoTimerPicker with CupertinoTimerPickerMode values from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino date/timer picker modes test executing');

  // ========== CUPERTINODATEPICKER MODES ==========
  print('--- CupertinoDatePicker Mode Tests ---');

  // Test CupertinoDatePickerMode.date
  final datePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    onDateTimeChanged: (DateTime dt) {
      print('Date changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=date created');

  // Test CupertinoDatePickerMode.time
  final timePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    onDateTimeChanged: (DateTime dt) {
      print('Time changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=time created');

  // Test CupertinoDatePickerMode.dateAndTime
  final dateAndTimePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    onDateTimeChanged: (DateTime dt) {
      print('DateTime changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=dateAndTime created');

  // Test CupertinoDatePickerMode.monthYear
  final monthYearPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.monthYear,
    initialDateTime: DateTime(2025, 6, 1),
    onDateTimeChanged: (DateTime dt) {
      print('MonthYear changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=monthYear created');

  // Test CupertinoDatePicker with minimumDate and maximumDate
  final boundedDatePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    minimumDate: DateTime(2020, 1, 1),
    maximumDate: DateTime(2030, 12, 31),
    onDateTimeChanged: (DateTime dt) {
      print('Bounded date changed: $dt');
    },
  );
  print('CupertinoDatePicker with min/max dates created');

  // Test CupertinoDatePicker with minimumYear and maximumYear
  final yearBoundedPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    minimumYear: 2000,
    maximumYear: 2050,
    onDateTimeChanged: (DateTime dt) {
      print('Year-bounded date changed: $dt');
    },
  );
  print('CupertinoDatePicker with min/max years created');

  // Test CupertinoDatePicker with use24hFormat
  final format24hPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    use24hFormat: true,
    onDateTimeChanged: (DateTime dt) {
      print('24h time changed: $dt');
    },
  );
  print('CupertinoDatePicker with use24hFormat created');

  // Test CupertinoDatePicker with minuteInterval
  final intervalPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 0),
    minuteInterval: 15,
    onDateTimeChanged: (DateTime dt) {
      print('Interval time changed: $dt');
    },
  );
  print('CupertinoDatePicker with minuteInterval created');

  // Test CupertinoDatePicker with backgroundColor
  final bgDatePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    backgroundColor: CupertinoColors.systemGroupedBackground,
    onDateTimeChanged: (DateTime dt) {},
  );
  print('CupertinoDatePicker with backgroundColor created');

  // ========== CUPERTINOTIMERPPICKER MODES ==========
  print('--- CupertinoTimerPicker Mode Tests ---');

  // Test CupertinoTimerPickerMode.hms (hours, minutes, seconds)
  final hmsTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    initialTimerDuration: Duration(hours: 1, minutes: 30, seconds: 45),
    onTimerDurationChanged: (Duration d) {
      print('HMS timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hms created');

  // Test CupertinoTimerPickerMode.hm (hours, minutes)
  final hmTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    initialTimerDuration: Duration(hours: 2, minutes: 15),
    onTimerDurationChanged: (Duration d) {
      print('HM timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hm created');

  // Test CupertinoTimerPickerMode.ms (minutes, seconds)
  final msTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.ms,
    initialTimerDuration: Duration(minutes: 5, seconds: 30),
    onTimerDurationChanged: (Duration d) {
      print('MS timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=ms created');

  // Test CupertinoTimerPicker with minuteInterval
  final intervalTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    minuteInterval: 5,
    initialTimerDuration: Duration(hours: 1, minutes: 30),
    onTimerDurationChanged: (Duration d) {
      print('Interval timer changed: $d');
    },
  );
  print('CupertinoTimerPicker with minuteInterval created');

  // Test CupertinoTimerPicker with secondInterval
  final secIntervalTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    secondInterval: 10,
    initialTimerDuration: Duration(hours: 0, minutes: 10, seconds: 30),
    onTimerDurationChanged: (Duration d) {
      print('Sec interval timer changed: $d');
    },
  );
  print('CupertinoTimerPicker with secondInterval created');

  // Test CupertinoTimerPicker with alignment
  final alignedTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    alignment: Alignment.center,
    initialTimerDuration: Duration(hours: 0, minutes: 45),
    onTimerDurationChanged: (Duration d) {},
  );
  print('CupertinoTimerPicker with alignment created');

  // Test CupertinoTimerPicker with backgroundColor
  final bgTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    backgroundColor: CupertinoColors.systemGroupedBackground,
    initialTimerDuration: Duration(hours: 0, minutes: 15, seconds: 0),
    onTimerDurationChanged: (Duration d) {},
  );
  print('CupertinoTimerPicker with backgroundColor created');

  print('All date/timer picker mode tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('DatePicker Modes Test'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Cupertino Date/Timer Pickers:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Date Mode'),
                        SizedBox(height: 4.0),
                        Expanded(child: datePicker),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Time Mode'),
                        SizedBox(height: 4.0),
                        Expanded(child: timePicker),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Timer Picker (HM):'),
            ),
            SizedBox(height: 150.0, child: hmTimer),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tests Completed:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('• CupertinoDatePickerMode.date'),
                  Text('• CupertinoDatePickerMode.time'),
                  Text('• CupertinoDatePickerMode.dateAndTime'),
                  Text('• CupertinoDatePickerMode.monthYear'),
                  Text('• CupertinoTimerPickerMode.hms'),
                  Text('• CupertinoTimerPickerMode.hm'),
                  Text('• CupertinoTimerPickerMode.ms'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
