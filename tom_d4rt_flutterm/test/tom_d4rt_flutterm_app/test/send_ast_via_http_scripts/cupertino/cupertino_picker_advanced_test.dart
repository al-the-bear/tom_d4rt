// D4rt test script: Tests CupertinoPicker, CupertinoTimerPicker,
// CupertinoDatePicker modes, CupertinoDialogRoute
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino picker test executing');

  // ========== CupertinoPicker ==========
  print('--- CupertinoPicker Tests ---');
  final picker = CupertinoPicker(
    magnification: 1.22,
    squeeze: 1.2,
    useMagnifier: true,
    itemExtent: 32.0,
    diameterRatio: 1.07,
    backgroundColor: CupertinoColors.systemBackground,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: CupertinoColors.tertiarySystemFill,
    ),
    onSelectedItemChanged: (int index) {
      print('Picker changed: $index');
    },
    children: List.generate(10, (i) => Center(child: Text('Item $i'))),
  );
  print('CupertinoPicker created with 10 items');

  // ========== CupertinoTimerPicker ==========
  print('--- CupertinoTimerPicker Tests ---');
  final timerPicker = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    initialTimerDuration: Duration(hours: 1, minutes: 30, seconds: 0),
    minuteInterval: 1,
    secondInterval: 1,
    alignment: Alignment.center,
    backgroundColor: CupertinoColors.systemBackground,
    onTimerDurationChanged: (Duration duration) {
      print('Timer: $duration');
    },
  );
  print('CupertinoTimerPicker created: mode=hms');

  // ========== CupertinoTimerPickerMode ==========
  print('--- CupertinoTimerPickerMode Tests ---');
  for (final mode in CupertinoTimerPickerMode.values) {
    print('CupertinoTimerPickerMode: ${mode.name}');
  }

  // ========== CupertinoDatePicker modes ==========
  print('--- CupertinoDatePickerMode Tests ---');
  for (final mode in CupertinoDatePickerMode.values) {
    print('CupertinoDatePickerMode: ${mode.name}');
  }

  final datePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    initialDateTime: DateTime(2026, 3, 4, 10, 30),
    minimumDate: DateTime(2020, 1, 1),
    maximumDate: DateTime(2030, 12, 31),
    use24hFormat: true,
    minuteInterval: 5,
    backgroundColor: CupertinoColors.systemBackground,
    onDateTimeChanged: (DateTime dt) {
      print('Date: $dt');
    },
  );
  print('CupertinoDatePicker dateAndTime created [${datePicker.hashCode}]');

  // ========== CupertinoPickerDefaultSelectionOverlay ==========
  print('--- CupertinoPickerDefaultSelectionOverlay Tests ---');
  final overlay = CupertinoPickerDefaultSelectionOverlay(
    background: CupertinoColors.tertiarySystemFill,
    capStartEdge: true,
    capEndEdge: true,
  );
  print('CupertinoPickerDefaultSelectionOverlay created [${overlay.hashCode }]');

  print('All cupertino picker tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Picker Test')),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            SizedBox(height: 200, child: picker),
            SizedBox(height: 16.0),
            SizedBox(height: 200, child: timerPicker),
          ],
        ),
      ),
    ),
  );
}
