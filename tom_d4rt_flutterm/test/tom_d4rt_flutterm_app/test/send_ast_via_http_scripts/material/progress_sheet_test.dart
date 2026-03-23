// ignore_for_file: avoid_print
// D4rt test script: Tests LinearProgressIndicator, CircularProgressIndicator,
// ProgressIndicatorThemeData, BottomSheet, BottomSheetThemeData
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Progress/BottomSheet test executing');

  // ========== ProgressIndicatorThemeData ==========
  print('--- ProgressIndicatorThemeData Tests ---');
  final progressTheme = ProgressIndicatorThemeData(
    color: Colors.blue,
    linearTrackColor: Colors.blue.shade100,
    linearMinHeight: 6.0,
    circularTrackColor: Colors.blue.shade100,
  );
  print('ProgressIndicatorThemeData created');
  print('  linearMinHeight: ${progressTheme.linearMinHeight}');

  // ========== LinearProgressIndicator ==========
  print('--- LinearProgressIndicator Tests ---');
  final linearDeterminate = LinearProgressIndicator(
    value: 0.7,
    backgroundColor: Colors.grey.shade200,
    color: Colors.blue,
    minHeight: 8.0,
    borderRadius: BorderRadius.circular(4.0),
  );
  print('LinearProgressIndicator determinate: 0.7');

  final linearIndeterminate = LinearProgressIndicator(
    backgroundColor: Colors.grey.shade200,
    color: Colors.green,
  );
  print('LinearProgressIndicator indeterminate');

  // ========== CircularProgressIndicator ==========
  print('--- CircularProgressIndicator Tests ---');
  final circularDeterminate = CircularProgressIndicator(
    value: 0.5,
    backgroundColor: Colors.grey.shade200,
    color: Colors.red,
    strokeWidth: 6.0,
    strokeCap: StrokeCap.round,
  );
  print('CircularProgressIndicator determinate: 0.5');

  final circularIndeterminate = CircularProgressIndicator(
    strokeWidth: 4.0,
    color: Colors.purple,
  );
  print('CircularProgressIndicator indeterminate');

  // ========== RefreshProgressIndicator ==========
  print('--- RefreshProgressIndicator Tests ---');
  final refreshIndicator = RefreshProgressIndicator(
    value: 0.3,
    backgroundColor: Colors.white,
    color: Colors.blue,
    strokeWidth: 2.5,
  );
  print('RefreshProgressIndicator created');

  // ========== BottomSheetThemeData ==========
  print('--- BottomSheetThemeData Tests ---');
  final sheetTheme = BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(maxWidth: 640),
    modalBackgroundColor: Colors.white,
    modalElevation: 16.0,
    showDragHandle: true,
    dragHandleColor: Colors.grey.shade400,
    dragHandleSize: Size(32, 4),
  );
  print('BottomSheetThemeData created');
  print('  showDragHandle: ${sheetTheme.showDragHandle}');

  print('All progress/bottomsheet tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress/BottomSheet Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            linearDeterminate,
            SizedBox(height: 8.0),
            linearIndeterminate,
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                circularDeterminate,
                circularIndeterminate,
                refreshIndicator,
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
