// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DefaultCupertinoLocalizations from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('DefaultCupertinoLocalizations test executing');

  // ========== DEFAULTCUPERTINOLOCALIZATIONS ==========
  print('--- DefaultCupertinoLocalizations Tests ---');

  // Construct DefaultCupertinoLocalizations directly
  final localizations = DefaultCupertinoLocalizations();
  print('DefaultCupertinoLocalizations created');

  // Test datePickerYear
  final year2025 = localizations.datePickerYear(2025);
  print('datePickerYear(2025): $year2025');

  final year2000 = localizations.datePickerYear(2000);
  print('datePickerYear(2000): $year2000');

  // Test datePickerMonth
  final jan = localizations.datePickerMonth(1);
  final feb = localizations.datePickerMonth(2);
  final mar = localizations.datePickerMonth(3);
  final apr = localizations.datePickerMonth(4);
  final may = localizations.datePickerMonth(5);
  final jun = localizations.datePickerMonth(6);
  final jul = localizations.datePickerMonth(7);
  final aug = localizations.datePickerMonth(8);
  final sep = localizations.datePickerMonth(9);
  final oct = localizations.datePickerMonth(10);
  final nov = localizations.datePickerMonth(11);
  final dec = localizations.datePickerMonth(12);
  print('datePickerMonth(1): $jan [${nov.hashCode }] [${oct.hashCode }] [${sep.hashCode }] [${aug.hashCode }] [${jul.hashCode }] [${may.hashCode }] [${apr.hashCode }] [${mar.hashCode }] [${feb.hashCode }]');
  print('datePickerMonth(6): $jun');
  print('datePickerMonth(12): $dec');

  // Test datePickerDayOfMonth
  final day1 = localizations.datePickerDayOfMonth(1);
  final day15 = localizations.datePickerDayOfMonth(15);
  final day31 = localizations.datePickerDayOfMonth(31);
  print('datePickerDayOfMonth(1): $day1');
  print('datePickerDayOfMonth(15): $day15');
  print('datePickerDayOfMonth(31): $day31');

  // Test datePickerHour
  final hour0 = localizations.datePickerHour(0);
  final hour12 = localizations.datePickerHour(12);
  final hour23 = localizations.datePickerHour(23);
  print('datePickerHour(0): $hour0');
  print('datePickerHour(12): $hour12');
  print('datePickerHour(23): $hour23');

  // Test datePickerMinute
  final min0 = localizations.datePickerMinute(0);
  final min30 = localizations.datePickerMinute(30);
  final min59 = localizations.datePickerMinute(59);
  print('datePickerMinute(0): $min0');
  print('datePickerMinute(30): $min30');
  print('datePickerMinute(59): $min59');

  // Test datePickerMediumDate
  final mediumDate = localizations.datePickerMediumDate(DateTime(2025, 6, 15));
  print('datePickerMediumDate: $mediumDate');

  // Test datePickerDateOrder
  final dateOrder = localizations.datePickerDateOrder;
  print('datePickerDateOrder: $dateOrder');

  // Test datePickerDateTimeOrder
  final dateTimeOrder = localizations.datePickerDateTimeOrder;
  print('datePickerDateTimeOrder: $dateTimeOrder');

  // Test anteMeridiemAbbreviation and postMeridiemAbbreviation
  final am = localizations.anteMeridiemAbbreviation;
  final pm = localizations.postMeridiemAbbreviation;
  print('anteMeridiemAbbreviation: $am');
  print('postMeridiemAbbreviation: $pm');

  // Test alertDialogLabel
  final alertLabel = localizations.alertDialogLabel;
  print('alertDialogLabel: $alertLabel');

  // Test timerPickerHourLabel
  final hourLabel1 = localizations.timerPickerHourLabel(1);
  final hourLabel5 = localizations.timerPickerHourLabel(5);
  print('timerPickerHourLabel(1): $hourLabel1');
  print('timerPickerHourLabel(5): $hourLabel5');

  // Test timerPickerMinuteLabel
  final minLabel1 = localizations.timerPickerMinuteLabel(1);
  final minLabel30 = localizations.timerPickerMinuteLabel(30);
  print('timerPickerMinuteLabel(1): $minLabel1');
  print('timerPickerMinuteLabel(30): $minLabel30');

  // Test timerPickerSecondLabel
  final secLabel1 = localizations.timerPickerSecondLabel(1);
  final secLabel45 = localizations.timerPickerSecondLabel(45);
  print('timerPickerSecondLabel(1): $secLabel1');
  print('timerPickerSecondLabel(45): $secLabel45');

  // Test tabSemanticsLabel
  final tabLabel = localizations.tabSemanticsLabel(tabIndex: 2, tabCount: 5);
  print('tabSemanticsLabel(tabIndex:2, tabCount:5): $tabLabel');

  // Test copyButtonLabel, cutButtonLabel, pasteButtonLabel, selectAllButtonLabel
  final copyLabel = localizations.copyButtonLabel;
  final cutLabel = localizations.cutButtonLabel;
  final pasteLabel = localizations.pasteButtonLabel;
  final selectAllLabel = localizations.selectAllButtonLabel;
  print('copyButtonLabel: $copyLabel');
  print('cutButtonLabel: $cutLabel');
  print('pasteButtonLabel: $pasteLabel');
  print('selectAllButtonLabel: $selectAllLabel');

  // Test searchTextFieldPlaceholderLabel
  final searchPlaceholder = localizations.searchTextFieldPlaceholderLabel;
  print('searchTextFieldPlaceholderLabel: $searchPlaceholder');

  // Test modalBarrierDismissLabel
  final barrierLabel = localizations.modalBarrierDismissLabel;
  print('modalBarrierDismissLabel: $barrierLabel');

  print('All DefaultCupertinoLocalizations tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Localizations Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DefaultCupertinoLocalizations:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('Year 2025: $year2025'),
              Text('Month Jan: $jan'),
              Text('Month Jun: $jun'),
              Text('Month Dec: $dec'),
              Text('Day 15: $day15'),
              Text('Hour 12: $hour12'),
              Text('Minute 30: $min30'),
              SizedBox(height: 8.0),
              Text('Medium date: $mediumDate'),
              Text('Date order: $dateOrder'),
              Text('AM: $am / PM: $pm'),
              SizedBox(height: 8.0),
              Text('Alert label: $alertLabel'),
              Text('Copy: $copyLabel'),
              Text('Cut: $cutLabel'),
              Text('Paste: $pasteLabel'),
              Text('Select All: $selectAllLabel'),
              Text('Search: $searchPlaceholder'),
              Text('Barrier: $barrierLabel'),
              SizedBox(height: 8.0),
              Text('Tab label: $tabLabel'),
              Text('Hour label(1): $hourLabel1'),
              Text('Min label(30): $minLabel30'),
              Text('Sec label(45): $secLabel45'),
              SizedBox(height: 16.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• DefaultCupertinoLocalizations'),
              Text('• Date/time picker labels'),
              Text('• Button labels'),
              Text('• Semantic labels'),
            ],
          ),
        ),
      ),
    ),
  );
}
