// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoLocalizations, CupertinoPageRoute, showCupertinoModalPopup, showCupertinoDialog, CupertinoSliverNavigationBar, CupertinoSegmentedControl, CupertinoSlidingSegmentedControl, CupertinoTextSelectionControls
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino misc advanced tests executing');

  // ========== CupertinoLocalizations ==========
  print('--- CupertinoLocalizations Tests ---');
  final localizations = DefaultCupertinoLocalizations();
  print('type: ${localizations.runtimeType}');
  print('datePickerMonth(1): ${localizations.datePickerMonth(1)}');
  print('datePickerDayOfMonth(15): ${localizations.datePickerDayOfMonth(15)}');
  print('timerPickerHour(3): ${localizations.timerPickerHour(3)}');
  print('timerPickerMinute(45): ${localizations.timerPickerMinute(45)}');
  print('timerPickerSecond(30): ${localizations.timerPickerSecond(30)}');
  print('selectAllButtonLabel: ${localizations.selectAllButtonLabel}');
  print('copyButtonLabel: ${localizations.copyButtonLabel}');
  print('cutButtonLabel: ${localizations.cutButtonLabel}');
  print('pasteButtonLabel: ${localizations.pasteButtonLabel}');
  print('CupertinoLocalizations tests passed');

  // ========== CupertinoPageRoute ==========
  print('--- CupertinoPageRoute Tests ---');
  final route = CupertinoPageRoute<void>(
    builder: (ctx) => const SizedBox(),
    title: 'Test Route',
  );
  print('type: ${route.runtimeType}');
  print('title: ${route.title}');
  print('maintainState: ${route.maintainState}');
  print('fullscreenDialog: ${route.fullscreenDialog}');
  print('CupertinoPageRoute tests passed');

  // ========== showCupertinoModalPopup / showCupertinoDialog ==========
  print('--- showCupertinoModalPopup / showCupertinoDialog Tests ---');
  print('showCupertinoModalPopup type: ${showCupertinoModalPopup.runtimeType}');
  print('showCupertinoDialog type: ${showCupertinoDialog.runtimeType}');
  print('Both are top-level functions from cupertino library');
  print('showCupertinoModalPopup/showCupertinoDialog reference passed');

  // ========== CupertinoSliverNavigationBar ==========
  print('--- CupertinoSliverNavigationBar Tests ---');
  final sliverNavBar = CupertinoSliverNavigationBar(largeTitle: Text('Test'));
  print('type: ${sliverNavBar.runtimeType}');
  print('CupertinoSliverNavigationBar is a StatefulWidget');
  print('Its State class (CupertinoSliverNavigationBarState) is internal');
  print('CupertinoSliverNavigationBar tests passed');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmented = CupertinoSegmentedControl<int>(
    children: const {0: Text('One'), 1: Text('Two'), 2: Text('Three')},
    onValueChanged: (int val) {
      print('selected: $val');
    },
    groupValue: 0,
  );
  print('type: ${segmented.runtimeType}');
  print('CupertinoSegmentedControl theming via CupertinoTheme');
  print('CupertinoSegmentedControl tests passed');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final sliding = CupertinoSlidingSegmentedControl<int>(
    children: const {0: Text('A'), 1: Text('B')},
    onValueChanged: (int? val) {
      print('sliding selected: $val');
    },
    groupValue: 0,
  );
  print('type: ${sliding.runtimeType}');
  print('CupertinoSlidingSegmentedControl tests passed');

  // ========== CupertinoTextSelectionControls ==========
  print('--- CupertinoTextSelectionControls Tests ---');
  final selectionControls = CupertinoTextSelectionControls();
  print('type: ${selectionControls.runtimeType}');
  print('CupertinoTextSelectionControls is a TextSelectionControls impl');
  print('CupertinoTextSelectionHandlePainter is internal/private');
  print('CupertinoTextSelectionControlsTools is not a public API');
  print('CupertinoTextSelectionControls tests passed');

  // ========== CupertinoAdaptiveTheme ==========
  print('--- CupertinoAdaptiveTheme Tests ---');
  final cupertinoTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
  );
  print('CupertinoThemeData type: ${cupertinoTheme.runtimeType}');
  print('brightness: ${cupertinoTheme.brightness}');
  print('primaryColor: ${cupertinoTheme.primaryColor}');
  print('CupertinoAdaptiveTheme is accessed via CupertinoTheme widget');
  print('Cupertino adaptive theming tests passed');

  print('All Cupertino misc advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cupertino Misc Advanced Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('CupertinoLocalizations: OK'),
            Text('CupertinoPageRoute: OK'),
            Text('showCupertinoModalPopup: referenced'),
            Text('showCupertinoDialog: referenced'),
            Text('CupertinoSliverNavigationBar: OK'),
            Text('CupertinoSegmentedControl: OK'),
            Text('CupertinoSlidingSegmentedControl: OK'),
            Text('CupertinoTextSelectionControls: OK'),
            Text('CupertinoAdaptiveTheme: OK'),
          ],
        ),
      ),
    ),
  );
}
