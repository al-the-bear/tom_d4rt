// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialLocalizations from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MaterialLocalizations Visual Demo ===');
  print('Demonstrating localized strings for Material Design widgets');

  // Use DefaultMaterialLocalizations directly (no .of(context) needed)
  final DefaultMaterialLocalizations loc = DefaultMaterialLocalizations();

  // Test date and time values
  final DateTime testDate = DateTime(2026, 3, 21);
  final TimeOfDay testTime = TimeOfDay(hour: 14, minute: 30);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('MaterialLocalizations Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Intro
            _buildSectionHeader('MaterialLocalizations Overview'),
            SizedBox(height: 8),
            _buildIntroCard(),
            SizedBox(height: 24),

            // Section 2: Tooltip strings
            _buildSectionHeader('Tooltip Strings'),
            SizedBox(height: 8),
            _buildTooltipStrings(loc),
            SizedBox(height: 24),

            // Section 3: Navigation strings
            _buildSectionHeader('Navigation Strings'),
            SizedBox(height: 8),
            _buildNavigationStrings(loc),
            SizedBox(height: 24),

            // Section 4: Button labels
            _buildSectionHeader('Button Labels'),
            SizedBox(height: 8),
            _buildButtonLabels(loc),
            SizedBox(height: 24),

            // Section 5: Dialog and accessibility labels
            _buildSectionHeader('Dialog & Accessibility Labels'),
            SizedBox(height: 8),
            _buildDialogLabels(loc),
            SizedBox(height: 24),

            // Section 6: Date formatting
            _buildSectionHeader('Date Formatting'),
            SizedBox(height: 8),
            _buildDateFormatting(loc, testDate),
            SizedBox(height: 24),

            // Section 7: Time formatting
            _buildSectionHeader('Time Formatting'),
            SizedBox(height: 8),
            _buildTimeFormatting(loc, testTime),
            SizedBox(height: 24),

            // Section 8: Table and pagination strings
            _buildSectionHeader('Table & Pagination Strings'),
            SizedBox(height: 8),
            _buildTableStrings(loc),
            SizedBox(height: 24),

            // Section 9: Weekday names
            _buildSectionHeader('Weekday Names & First Day'),
            SizedBox(height: 8),
            _buildWeekdayNames(loc),
            SizedBox(height: 24),

            // Section 10: Calendar / Date picker strings
            _buildSectionHeader('Calendar & Date Picker Strings'),
            SizedBox(height: 8),
            _buildCalendarStrings(loc),
            SizedBox(height: 24),

            // Section 11: Reorder strings
            _buildSectionHeader('Reorder Item Strings'),
            SizedBox(height: 8),
            _buildReorderStrings(loc),
            SizedBox(height: 24),

            // Section 12: Account labels
            _buildSectionHeader('Account Labels'),
            SizedBox(height: 8),
            _buildAccountLabels(loc),
            SizedBox(height: 24),

            // Section 13: Summary
            _buildSectionHeader('Summary'),
            SizedBox(height: 8),
            _buildSummary(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// -- Helper widgets --

Widget _buildSectionHeader(String title) {
  print('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildInfoCard({
  required String label,
  required String value,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF1B5E20),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntroCard() {
  print('Building intro card');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.language, color: Color(0xFF1565C0), size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'MaterialLocalizations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Provides localized strings for Material Design widgets. '
          'Used by DatePickers, TimePickers, Dialogs, Drawers, '
          'DataTables, and many other components.',
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
        SizedBox(height: 8),
        Text(
          'Using DefaultMaterialLocalizations() directly',
          style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: Color(0xFF78909C),
          ),
        ),
      ],
    ),
  );
}

// -- Section 2: Tooltip strings --

Widget _buildTooltipStrings(DefaultMaterialLocalizations loc) {
  print('Building tooltip strings section');
  String openDrawer = loc.openAppDrawerTooltip;
  String backBtn = loc.backButtonTooltip;
  String closeBtn = loc.closeButtonTooltip;
  String deleteBtn = loc.deleteButtonTooltip;
  String moreBtn = loc.moreButtonTooltip;
  String showMenu = loc.showMenuTooltip;

  print('  openAppDrawerTooltip: $openDrawer');
  print('  backButtonTooltip: $backBtn');
  print('  closeButtonTooltip: $closeBtn');
  print('  deleteButtonTooltip: $deleteBtn');
  print('  moreButtonTooltip: $moreBtn');
  print('  showMenuTooltip: $showMenu');

  Color c = Color(0xFF1565C0);
  return Column(
    children: [
      _buildInfoCard(label: 'openAppDrawerTooltip', value: openDrawer, color: c),
      _buildInfoCard(label: 'backButtonTooltip', value: backBtn, color: c),
      _buildInfoCard(label: 'closeButtonTooltip', value: closeBtn, color: c),
      _buildInfoCard(label: 'deleteButtonTooltip', value: deleteBtn, color: c),
      _buildInfoCard(label: 'moreButtonTooltip', value: moreBtn, color: c),
      _buildInfoCard(label: 'showMenuTooltip', value: showMenu, color: c),
    ],
  );
}

// -- Section 3: Navigation strings --

Widget _buildNavigationStrings(DefaultMaterialLocalizations loc) {
  print('Building navigation strings section');
  String nextMonth = loc.nextMonthTooltip;
  String prevMonth = loc.previousMonthTooltip;
  String firstPage = loc.firstPageTooltip;
  String lastPage = loc.lastPageTooltip;
  String nextPage = loc.nextPageTooltip;
  String prevPage = loc.previousPageTooltip;

  print('  nextMonthTooltip: $nextMonth');
  print('  previousMonthTooltip: $prevMonth');
  print('  firstPageTooltip: $firstPage');
  print('  lastPageTooltip: $lastPage');
  print('  nextPageTooltip: $nextPage');
  print('  previousPageTooltip: $prevPage');

  Color c = Color(0xFF2E7D32);
  return Column(
    children: [
      _buildInfoCard(label: 'nextMonthTooltip', value: nextMonth, color: c),
      _buildInfoCard(label: 'previousMonthTooltip', value: prevMonth, color: c),
      _buildInfoCard(label: 'firstPageTooltip', value: firstPage, color: c),
      _buildInfoCard(label: 'lastPageTooltip', value: lastPage, color: c),
      _buildInfoCard(label: 'nextPageTooltip', value: nextPage, color: c),
      _buildInfoCard(label: 'previousPageTooltip', value: prevPage, color: c),
    ],
  );
}

// -- Section 4: Button labels --

Widget _buildButtonLabels(DefaultMaterialLocalizations loc) {
  print('Building button labels section');
  String cancel = loc.cancelButtonLabel;
  String close = loc.closeButtonLabel;
  String cont = loc.continueButtonLabel;
  String copy = loc.copyButtonLabel;
  String cut = loc.cutButtonLabel;
  String ok = loc.okButtonLabel;
  String paste = loc.pasteButtonLabel;
  String selectAll = loc.selectAllButtonLabel;
  String viewLicenses = loc.viewLicensesButtonLabel;

  print('  cancelButtonLabel: $cancel');
  print('  closeButtonLabel: $close');
  print('  continueButtonLabel: $cont');
  print('  copyButtonLabel: $copy');
  print('  cutButtonLabel: $cut');
  print('  okButtonLabel: $ok');
  print('  pasteButtonLabel: $paste');
  print('  selectAllButtonLabel: $selectAll');
  print('  viewLicensesButtonLabel: $viewLicenses');

  Color c = Color(0xFFE65100);
  return Column(
    children: [
      _buildInfoCard(label: 'cancelButtonLabel', value: cancel, color: c),
      _buildInfoCard(label: 'closeButtonLabel', value: close, color: c),
      _buildInfoCard(label: 'continueButtonLabel', value: cont, color: c),
      _buildInfoCard(label: 'copyButtonLabel', value: copy, color: c),
      _buildInfoCard(label: 'cutButtonLabel', value: cut, color: c),
      _buildInfoCard(label: 'okButtonLabel', value: ok, color: c),
      _buildInfoCard(label: 'pasteButtonLabel', value: paste, color: c),
      _buildInfoCard(label: 'selectAllButtonLabel', value: selectAll, color: c),
      _buildInfoCard(label: 'viewLicensesButtonLabel', value: viewLicenses, color: c),
    ],
  );
}

// -- Section 5: Dialog and accessibility labels --

Widget _buildDialogLabels(DefaultMaterialLocalizations loc) {
  print('Building dialog and accessibility labels section');
  String drawer = loc.drawerLabel;
  String popup = loc.popupMenuLabel;
  String dialog = loc.dialogLabel;
  String alertDialog = loc.alertDialogLabel;
  String searchField = loc.searchFieldLabel;
  String modalBarrier = loc.modalBarrierDismissLabel;

  print('  drawerLabel: $drawer');
  print('  popupMenuLabel: $popup');
  print('  dialogLabel: $dialog');
  print('  alertDialogLabel: $alertDialog');
  print('  searchFieldLabel: $searchField');
  print('  modalBarrierDismissLabel: $modalBarrier');

  Color c = Color(0xFF6A1B9A);
  return Column(
    children: [
      _buildInfoCard(label: 'drawerLabel', value: drawer, color: c),
      _buildInfoCard(label: 'popupMenuLabel', value: popup, color: c),
      _buildInfoCard(label: 'dialogLabel', value: dialog, color: c),
      _buildInfoCard(label: 'alertDialogLabel', value: alertDialog, color: c),
      _buildInfoCard(label: 'searchFieldLabel', value: searchField, color: c),
      _buildInfoCard(
        label: 'modalBarrierDismissLabel',
        value: modalBarrier,
        color: c,
      ),
    ],
  );
}

// -- Section 6: Date formatting --

Widget _buildDateFormatting(DefaultMaterialLocalizations loc, DateTime date) {
  print('Building date formatting section');
  String compact = loc.formatCompactDate(date);
  String shortD = loc.formatShortDate(date);
  String medium = loc.formatMediumDate(date);
  String full = loc.formatFullDate(date);
  String monthYear = loc.formatMonthYear(date);
  String year = loc.formatYear(date);

  print('  formatCompactDate: $compact');
  print('  formatShortDate: $shortD');
  print('  formatMediumDate: $medium');
  print('  formatFullDate: $full');
  print('  formatMonthYear: $monthYear');
  print('  formatYear: $year');

  Color c = Color(0xFF00838F);
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80DEEA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, color: c, size: 20),
            SizedBox(width: 8),
            Text(
              'Test date: 2026-03-21',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF006064),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(label: 'formatCompactDate', value: compact, color: c),
        _buildInfoCard(label: 'formatShortDate', value: shortD, color: c),
        _buildInfoCard(label: 'formatMediumDate', value: medium, color: c),
        _buildInfoCard(label: 'formatFullDate', value: full, color: c),
        _buildInfoCard(label: 'formatMonthYear', value: monthYear, color: c),
        _buildInfoCard(label: 'formatYear', value: year, color: c),
      ],
    ),
  );
}

// -- Section 7: Time formatting --

Widget _buildTimeFormatting(DefaultMaterialLocalizations loc, TimeOfDay time) {
  print('Building time formatting section');
  String formatted = loc.formatTimeOfDay(time);
  TimeOfDayFormat todFormat = loc.timeOfDayFormat();
  String dialHelp = loc.timePickerDialHelpText;
  String inputHelp = loc.timePickerInputHelpText;
  String hourAnnounce = loc.timePickerHourModeAnnouncement;
  String minAnnounce = loc.timePickerMinuteModeAnnouncement;
  String formatHr = loc.formatHour(time);
  String formatMin = loc.formatMinute(time);
  String formatDec = loc.formatDecimal(42);

  print('  formatTimeOfDay: $formatted');
  print('  timeOfDayFormat: $todFormat');
  print('  timePickerDialHelpText: $dialHelp');
  print('  timePickerInputHelpText: $inputHelp');
  print('  timePickerHourModeAnnouncement: $hourAnnounce');
  print('  timePickerMinuteModeAnnouncement: $minAnnounce');
  print('  formatHour: $formatHr');
  print('  formatMinute: $formatMin');
  print('  formatDecimal(42): $formatDec');

  Color c = Color(0xFFAD1457);
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: c, size: 20),
            SizedBox(width: 8),
            Text(
              'Test time: 14:30',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF880E4F),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(label: 'formatTimeOfDay', value: formatted, color: c),
        _buildInfoCard(
          label: 'timeOfDayFormat',
          value: todFormat.toString(),
          color: c,
        ),
        _buildInfoCard(label: 'timePickerDialHelpText', value: dialHelp, color: c),
        _buildInfoCard(label: 'timePickerInputHelpText', value: inputHelp, color: c),
        _buildInfoCard(
          label: 'hourModeAnnouncement',
          value: hourAnnounce,
          color: c,
        ),
        _buildInfoCard(
          label: 'minuteModeAnnouncement',
          value: minAnnounce,
          color: c,
        ),
        _buildInfoCard(label: 'formatHour', value: formatHr, color: c),
        _buildInfoCard(label: 'formatMinute', value: formatMin, color: c),
        _buildInfoCard(label: 'formatDecimal(42)', value: formatDec, color: c),
      ],
    ),
  );
}

// -- Section 8: Table and pagination strings --

Widget _buildTableStrings(DefaultMaterialLocalizations loc) {
  print('Building table and pagination strings section');
  String rowsPerPage = loc.rowsPerPageTitle;
  String pageInfo1 = loc.pageRowsInfoTitle(1, 10, 50, false);
  String pageInfo2 = loc.pageRowsInfoTitle(1, 10, 50, true);
  String selected0 = loc.selectedRowCountTitle(0);
  String selected1 = loc.selectedRowCountTitle(1);
  String selected5 = loc.selectedRowCountTitle(5);

  print('  rowsPerPageTitle: $rowsPerPage');
  print('  pageRowsInfoTitle(1,10,50,false): $pageInfo1');
  print('  pageRowsInfoTitle(1,10,50,true): $pageInfo2');
  print('  selectedRowCountTitle(0): $selected0');
  print('  selectedRowCountTitle(1): $selected1');
  print('  selectedRowCountTitle(5): $selected5');

  Color c = Color(0xFF4527A0);
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.table_chart, color: c, size: 20),
            SizedBox(width: 8),
            Text(
              'DataTable Strings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(label: 'rowsPerPageTitle', value: rowsPerPage, color: c),
        _buildInfoCard(
          label: 'pageRowsInfoTitle(exact)',
          value: pageInfo1,
          color: c,
        ),
        _buildInfoCard(
          label: 'pageRowsInfoTitle(approx)',
          value: pageInfo2,
          color: c,
        ),
        _buildInfoCard(
          label: 'selectedRowCountTitle(0)',
          value: selected0,
          color: c,
        ),
        _buildInfoCard(
          label: 'selectedRowCountTitle(1)',
          value: selected1,
          color: c,
        ),
        _buildInfoCard(
          label: 'selectedRowCountTitle(5)',
          value: selected5,
          color: c,
        ),
      ],
    ),
  );
}

// -- Section 9: Weekday names --

Widget _buildWeekdayNames(DefaultMaterialLocalizations loc) {
  print('Building weekday names section');
  List<String> weekdays = loc.narrowWeekdays;
  int firstDay = loc.firstDayOfWeekIndex;
  print('  narrowWeekdays: $weekdays');
  print('  firstDayOfWeekIndex: $firstDay');

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.date_range, color: Color(0xFFE65100), size: 20),
            SizedBox(width: 8),
            Text(
              'Narrow Weekdays',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFFBF360C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(weekdays.length, (i) {
            bool isFirst = i == firstDay;
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isFirst ? Color(0xFFE65100) : Color(0xFFFFE0B2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isFirst ? Color(0xFFBF360C) : Color(0xFFFFCC80),
                  width: isFirst ? 2.0 : 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                weekdays[i],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isFirst ? Color(0xFFFFFFFF) : Color(0xFF424242),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 10),
        _buildInfoCard(
          label: 'firstDayOfWeekIndex',
          value: firstDay.toString(),
          color: Color(0xFFE65100),
        ),
      ],
    ),
  );
}

// -- Section 10: Calendar/Date picker strings --

Widget _buildCalendarStrings(DefaultMaterialLocalizations loc) {
  print('Building calendar and date picker strings section');
  String calMode = loc.calendarModeButtonLabel;
  String inputMode = loc.inputDateModeButtonLabel;
  String dpHelp = loc.datePickerHelpText;
  String drpHelp = loc.dateRangePickerHelpText;
  String unspecDate = loc.unspecifiedDate;
  String unspecRange = loc.unspecifiedDateRange;
  String dateHelp = loc.dateHelpText;
  String licensesTitle = loc.licensesPageTitle;
  String aboutTitle = loc.aboutListTileTitle('MyApp');

  print('  calendarModeButtonLabel: $calMode');
  print('  inputDateModeButtonLabel: $inputMode');
  print('  datePickerHelpText: $dpHelp');
  print('  dateRangePickerHelpText: $drpHelp');
  print('  unspecifiedDate: $unspecDate');
  print('  unspecifiedDateRange: $unspecRange');
  print('  dateHelpText: $dateHelp');
  print('  licensesPageTitle: $licensesTitle');
  print('  aboutListTileTitle(MyApp): $aboutTitle');

  Color c = Color(0xFF00695C);
  return Column(
    children: [
      _buildInfoCard(label: 'calendarModeButtonLabel', value: calMode, color: c),
      _buildInfoCard(label: 'inputDateModeButtonLabel', value: inputMode, color: c),
      _buildInfoCard(label: 'datePickerHelpText', value: dpHelp, color: c),
      _buildInfoCard(label: 'dateRangePickerHelpText', value: drpHelp, color: c),
      _buildInfoCard(label: 'unspecifiedDate', value: unspecDate, color: c),
      _buildInfoCard(
        label: 'unspecifiedDateRange',
        value: unspecRange,
        color: c,
      ),
      _buildInfoCard(label: 'dateHelpText', value: dateHelp, color: c),
      _buildInfoCard(label: 'licensesPageTitle', value: licensesTitle, color: c),
      _buildInfoCard(
        label: 'aboutListTileTitle(MyApp)',
        value: aboutTitle,
        color: c,
      ),
    ],
  );
}

// -- Section 11: Reorder strings --

Widget _buildReorderStrings(DefaultMaterialLocalizations loc) {
  print('Building reorder strings section');
  String down = loc.reorderItemDown;
  String up = loc.reorderItemUp;
  String left = loc.reorderItemLeft;
  String right = loc.reorderItemRight;
  String toStart = loc.reorderItemToStart;
  String toEnd = loc.reorderItemToEnd;

  print('  reorderItemDown: $down');
  print('  reorderItemUp: $up');
  print('  reorderItemLeft: $left');
  print('  reorderItemRight: $right');
  print('  reorderItemToStart: $toStart');
  print('  reorderItemToEnd: $toEnd');

  Color c = Color(0xFF33691E);
  List<Map<String, dynamic>> items = [
    {'label': 'reorderItemDown', 'value': down, 'icon': Icons.arrow_downward},
    {'label': 'reorderItemUp', 'value': up, 'icon': Icons.arrow_upward},
    {'label': 'reorderItemLeft', 'value': left, 'icon': Icons.arrow_back},
    {'label': 'reorderItemRight', 'value': right, 'icon': Icons.arrow_forward},
    {'label': 'reorderItemToStart', 'value': toStart, 'icon': Icons.first_page},
    {'label': 'reorderItemToEnd', 'value': toEnd, 'icon': Icons.last_page},
  ];

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFC5E1A5)),
    ),
    child: Column(
      children: items.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFDCEDC8)),
          ),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                color: c,
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Text(
                item['value'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1B5E20),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// -- Section 12: Account labels --

Widget _buildAccountLabels(DefaultMaterialLocalizations loc) {
  print('Building account labels section');
  String signedIn = loc.signedInLabel;
  String hideAccounts = loc.hideAccountsLabel;
  String showAccounts = loc.showAccountsLabel;

  print('  signedInLabel: $signedIn');
  print('  hideAccountsLabel: $hideAccounts');
  print('  showAccountsLabel: $showAccounts');

  Color c = Color(0xFF37474F);
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_circle, color: c, size: 20),
            SizedBox(width: 8),
            Text(
              'User Account Drawer Labels',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(label: 'signedInLabel', value: signedIn, color: c),
        _buildInfoCard(
          label: 'hideAccountsLabel',
          value: hideAccounts,
          color: c,
        ),
        _buildInfoCard(
          label: 'showAccountsLabel',
          value: showAccounts,
          color: c,
        ),
      ],
    ),
  );
}

// -- Section 13: Summary --

Widget _buildSummary() {
  print('Building summary section');
  List<Map<String, dynamic>> sections = [
    {'name': 'Tooltip Strings', 'count': 6, 'color': Color(0xFF1565C0)},
    {'name': 'Navigation Strings', 'count': 6, 'color': Color(0xFF2E7D32)},
    {'name': 'Button Labels', 'count': 9, 'color': Color(0xFFE65100)},
    {'name': 'Dialog/Accessibility', 'count': 6, 'color': Color(0xFF6A1B9A)},
    {'name': 'Date Formatting', 'count': 6, 'color': Color(0xFF00838F)},
    {'name': 'Time Formatting', 'count': 9, 'color': Color(0xFFAD1457)},
    {'name': 'Table/Pagination', 'count': 6, 'color': Color(0xFF4527A0)},
    {'name': 'Weekday Names', 'count': 2, 'color': Color(0xFFE65100)},
    {'name': 'Calendar/DatePicker', 'count': 9, 'color': Color(0xFF00695C)},
    {'name': 'Reorder Strings', 'count': 6, 'color': Color(0xFF33691E)},
    {'name': 'Account Labels', 'count': 3, 'color': Color(0xFF37474F)},
  ];

  int total = 0;
  for (int i = 0; i < sections.length; i++) {
    total = total + (sections[i]['count'] as int);
  }
  print('  Total localized strings demonstrated: $total');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Demo Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Total strings demonstrated: $total',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFB3E5FC),
          ),
        ),
        SizedBox(height: 14),
        ...sections.map((s) {
          return Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: s['color'] as Color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    s['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE8EAF6),
                    ),
                  ),
                ),
                Text(
                  '${s['count']} strings',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF90CAF9),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF303F9F),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'DefaultMaterialLocalizations - English (US)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFB3E5FC),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}
