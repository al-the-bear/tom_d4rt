// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Deep Demo - Material Date Picker Widget Family
// Comprehensive demonstration of CalendarDatePicker, YearPicker,
// InputDatePickerFormField, DatePickerThemeData, and related enums.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material date picker deep demo starting');

  // ============================================================================
  // SHARED CONSTANTS
  // ============================================================================

  final now = DateTime(2025, 6, 15);
  final firstDate = DateTime(2020, 1, 1);
  final lastDate = DateTime(2030, 12, 31);
  final wideFirst = DateTime(2000, 1, 1);
  final wideLast = DateTime(2050, 12, 31);

  // ============================================================================
  // SECTION 2 DATA: ANATOMY OF DATE PICKER CONSTRUCTORS
  // ============================================================================

  final anatomyRows = <Map<String, dynamic>>[
    {
      'widget': 'CalendarDatePicker',
      'required': 'initialDate, firstDate, lastDate, onDateChanged',
      'optional':
          'currentDate, initialCalendarMode, selectableDayPredicate, onDisplayedMonthChanged',
      'returns': 'Widget (inline calendar)',
    },
    {
      'widget': 'YearPicker',
      'required': 'firstDate, lastDate, selectedDate, onChanged',
      'optional': 'currentDate, initialDate, dragStartBehavior',
      'returns': 'Widget (grid of years)',
    },
    {
      'widget': 'MonthPicker (private)',
      'required': '— used inside CalendarDatePicker —',
      'optional': '—',
      'returns': '—',
    },
    {
      'widget': 'InputDatePickerFormField',
      'required': 'firstDate, lastDate',
      'optional':
          'initialDate, onDateSubmitted, onDateSaved, errorFormatText, errorInvalidText, fieldHintText, fieldLabelText',
      'returns': 'Widget (form text field)',
    },
    {
      'widget': 'showDatePicker (function)',
      'required': 'context, initialDate, firstDate, lastDate',
      'optional':
          'helpText, cancelText, confirmText, initialEntryMode, initialDatePickerMode, selectableDayPredicate',
      'returns': 'Future<DateTime?>',
    },
    {
      'widget': 'showDateRangePicker (function)',
      'required': 'context, firstDate, lastDate',
      'optional':
          'initialDateRange, helpText, cancelText, confirmText, saveText, initialEntryMode',
      'returns': 'Future<DateTimeRange?>',
    },
  ];

  // ============================================================================
  // SECTION 3: CALENDARDATEPICKER INSTANCES
  // ============================================================================

  // 3a - default day mode
  final calDay = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    onDateChanged: (DateTime d) {
      print('calDay -> $d');
    },
  );

  // 3b - year mode initial display
  final calYear = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    initialCalendarMode: DatePickerMode.year,
    onDateChanged: (DateTime d) {
      print('calYear -> $d');
    },
  );

  // 3c - weekdays-only selectable predicate.
  // initialDate must satisfy the predicate (Flutter assertion at
  // calendar_date_picker.dart:154). `now` is a Sunday, so use the
  // following Monday instead.
  final calWeekdays = CalendarDatePicker(
    initialDate: DateTime(2025, 6, 16),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: (DateTime d) =>
        d.weekday >= DateTime.monday && d.weekday <= DateTime.friday,
    onDateChanged: (DateTime d) {
      print('calWeekdays -> $d');
    },
  );

  // 3d - even days only. `now`'s day is 15 (odd) and would fail the
  // same assertion; pick a nearby even-day date instead.
  final calEvens = CalendarDatePicker(
    initialDate: DateTime(2025, 6, 16),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: (DateTime d) => d.day.isEven,
    onDateChanged: (DateTime d) {
      print('calEvens -> $d');
    },
  );

  // 3e - inside narrow window (a single quarter)
  final qStart = DateTime(2025, 6, 1);
  final qEnd = DateTime(2025, 8, 31);
  final calQuarter = CalendarDatePicker(
    initialDate: DateTime(2025, 7, 15),
    firstDate: qStart,
    lastDate: qEnd,
    currentDate: now,
    onDateChanged: (DateTime d) {
      print('calQuarter -> $d');
    },
  );

  // 3f - custom currentDate marker (artificial "today")
  final calCustomToday = CalendarDatePicker(
    initialDate: now,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: DateTime(2025, 6, 20),
    onDateChanged: (DateTime d) {},
  );

  // ============================================================================
  // SECTION 4: YEARPICKER INSTANCES
  // ============================================================================

  // 4a - decade window
  final yearDecade = YearPicker(
    firstDate: firstDate,
    lastDate: lastDate,
    selectedDate: now,
    onChanged: (DateTime d) {
      print('yearDecade -> ${d.year}');
    },
  );

  // 4b - half-century window
  final yearWide = YearPicker(
    firstDate: wideFirst,
    lastDate: wideLast,
    selectedDate: DateTime(2025, 1, 1),
    currentDate: now,
    onChanged: (DateTime d) {
      print('yearWide -> ${d.year}');
    },
  );

  // 4c - five-year tight window
  final yearTight = YearPicker(
    firstDate: DateTime(2023, 1, 1),
    lastDate: DateTime(2027, 12, 31),
    selectedDate: DateTime(2025, 1, 1),
    onChanged: (DateTime d) {
      print('yearTight -> ${d.year}');
    },
  );

  // ============================================================================
  // SECTION 5: INPUTDATEPICKERFORMFIELD INSTANCES
  // ============================================================================

  final inputBasic = InputDatePickerFormField(
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: now,
  );

  final inputLabeled = InputDatePickerFormField(
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: now,
    fieldLabelText: 'Start date',
    fieldHintText: 'mm/dd/yyyy',
  );

  final inputCustomErrors = InputDatePickerFormField(
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: now,
    fieldLabelText: 'Birth date',
    fieldHintText: 'mm/dd/yyyy',
    errorFormatText: 'Use month/day/year format',
    errorInvalidText: 'Out of allowed range',
  );

  final inputSubmit = InputDatePickerFormField(
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: now,
    fieldLabelText: 'Due date',
    onDateSubmitted: (DateTime d) {
      print('inputSubmit -> $d');
    },
    onDateSaved: (DateTime d) {
      print('inputSubmit saved -> $d');
    },
  );

  // ============================================================================
  // SECTION 6: DATEPICKERTHEMEDATA STYLED VARIANTS
  // ============================================================================

  final themeOcean = DatePickerThemeData(
    backgroundColor: Color(0xFFE0F2F1),
    headerBackgroundColor: Color(0xFF00695C),
    headerForegroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Color(0xFF26A69A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  );

  final themeSunset = DatePickerThemeData(
    backgroundColor: Color(0xFFFFF3E0),
    headerBackgroundColor: Color(0xFFE65100),
    headerForegroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Color(0xFFFF7043),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  );

  final themeNoir = DatePickerThemeData(
    backgroundColor: Color(0xFF263238),
    headerBackgroundColor: Color(0xFF000000),
    headerForegroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Color(0xFF455A64),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  Widget themedCalendar(DatePickerThemeData theme, String label) {
    return Theme(
      data: ThemeData(datePickerTheme: theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),
              ),
            ),
          ),
          SizedBox(
            height: 360.0,
            child: CalendarDatePicker(
              initialDate: now,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: (DateTime d) {},
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // SECTION 7: ENUM GALLERY DATA
  // ============================================================================

  final entryModes = <Map<String, String>>[];
  for (final v in DatePickerEntryMode.values) {
    String description;
    if (v == DatePickerEntryMode.calendar) {
      description = 'Show the calendar grid first, allow swap to text input.';
    } else if (v == DatePickerEntryMode.input) {
      description = 'Show the text-input form first, allow swap to calendar.';
    } else if (v == DatePickerEntryMode.calendarOnly) {
      description = 'Calendar only - the text-input swap button is hidden.';
    } else if (v == DatePickerEntryMode.inputOnly) {
      description = 'Text input only - the calendar swap button is hidden.';
    } else {
      description = 'Other entry mode.';
    }
    entryModes.add({
      'name': v.name,
      'index': v.index.toString(),
      'description': description,
    });
  }

  final pickerModes = <Map<String, String>>[];
  for (final v in DatePickerMode.values) {
    String description;
    if (v == DatePickerMode.day) {
      description = 'Calendar displays days inside the selected month.';
    } else if (v == DatePickerMode.year) {
      description = 'Calendar displays a grid of years for quick navigation.';
    } else {
      description = 'Other picker mode.';
    }
    pickerModes.add({
      'name': v.name,
      'index': v.index.toString(),
      'description': description,
    });
  }

  // Note: Flutter intentionally reuses DatePickerEntryMode for both single-date
  // and date-range pickers. There is no separate DateRangePickerEntryMode type.
  final rangeEntryModes = <Map<String, String>>[
    {
      'name': 'calendar (range)',
      'index': DatePickerEntryMode.calendar.index.toString(),
      'description':
          'Two-pane calendar range selection with switch-to-input toggle.',
    },
    {
      'name': 'input (range)',
      'index': DatePickerEntryMode.input.index.toString(),
      'description': 'Two text fields (start/end) with switch-to-calendar.',
    },
    {
      'name': 'calendarOnly (range)',
      'index': DatePickerEntryMode.calendarOnly.index.toString(),
      'description': 'Range calendar only - switch button hidden.',
    },
    {
      'name': 'inputOnly (range)',
      'index': DatePickerEntryMode.inputOnly.index.toString(),
      'description': 'Range inputs only - switch button hidden.',
    },
  ];

  // ============================================================================
  // SECTION 8: RECIPE CARDS
  // ============================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Inline calendar inside a settings page',
      'when':
          'You want the user to pick a date without dismissing the surrounding form.',
      'snippet':
          'CalendarDatePicker(\n  initialDate: now,\n  firstDate: first,\n  lastDate: last,\n  onDateChanged: (d) => setState(() => due = d),\n)',
    },
    {
      'title': 'Year-only birth picker',
      'when':
          'You only need the year; render YearPicker and ignore month/day.',
      'snippet':
          'YearPicker(\n  firstDate: DateTime(1900),\n  lastDate: DateTime.now(),\n  selectedDate: birth,\n  onChanged: (d) => birth = d,\n)',
    },
    {
      'title': 'Weekdays-only booking',
      'when':
          'You only allow business days; use selectableDayPredicate to disable Sat/Sun.',
      'snippet':
          'selectableDayPredicate: (d) =>\n    d.weekday >= DateTime.monday && d.weekday <= DateTime.friday,',
    },
    {
      'title': 'Form-style date input',
      'when':
          'The user is already typing into a form; reuse the same look with InputDatePickerFormField.',
      'snippet':
          'InputDatePickerFormField(\n  firstDate: first,\n  lastDate: last,\n  initialDate: now,\n  fieldLabelText: "Due",\n)',
    },
    {
      'title': 'Themed material 3 picker',
      'when':
          'You want a branded calendar - configure DatePickerThemeData on ThemeData.',
      'snippet':
          'ThemeData(\n  datePickerTheme: DatePickerThemeData(\n    backgroundColor: brand.surface,\n    headerBackgroundColor: brand.primary,\n  ),\n)',
    },
    {
      'title': 'Open a dialog picker',
      'when':
          'When you need a modal selection step, call showDatePicker from a button handler.',
      'snippet':
          'final picked = await showDatePicker(\n  context: context,\n  initialDate: now,\n  firstDate: first,\n  lastDate: last,\n);',
    },
    {
      'title': 'Pick a date range',
      'when':
          'For check-in / check-out style selection, prefer showDateRangePicker.',
      'snippet':
          'final range = await showDateRangePicker(\n  context: context,\n  firstDate: first,\n  lastDate: last,\n);',
    },
    {
      'title': 'Input-only entry for accessibility',
      'when':
          'For users who prefer typing over tapping, default to DatePickerEntryMode.input.',
      'snippet':
          'showDatePicker(\n  ...,\n  initialEntryMode: DatePickerEntryMode.input,\n);',
    },
  ];

  // ============================================================================
  // SECTION 9: COMPARISON ROWS
  // ============================================================================

  final comparison = <Map<String, String>>[
    {
      'style': 'Inline calendar',
      'class': 'CalendarDatePicker',
      'modal': 'no',
      'input': 'no',
      'useCase': 'Stays on screen, embedded',
    },
    {
      'style': 'Modal calendar',
      'class': 'showDatePicker()',
      'modal': 'yes',
      'input': 'optional',
      'useCase': 'Triggered by a button',
    },
    {
      'style': 'Text-field',
      'class': 'InputDatePickerFormField',
      'modal': 'no',
      'input': 'yes',
      'useCase': 'Inside a Form widget',
    },
    {
      'style': 'Year grid',
      'class': 'YearPicker',
      'modal': 'no',
      'input': 'no',
      'useCase': 'Year-only selection',
    },
    {
      'style': 'Date range dialog',
      'class': 'showDateRangePicker()',
      'modal': 'yes',
      'input': 'optional',
      'useCase': 'Booking from/to selection',
    },
  ];

  // ============================================================================
  // SECTION 10: GLOSSARY
  // ============================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'initialDate',
      'meaning':
          'The date highlighted when the picker opens. Must fall within '
              '[firstDate, lastDate].',
    },
    {
      'term': 'firstDate',
      'meaning': 'The earliest selectable date (inclusive).',
    },
    {
      'term': 'lastDate',
      'meaning': 'The latest selectable date (inclusive).',
    },
    {
      'term': 'currentDate',
      'meaning':
          'The date treated as "today" - decorated with a ring even if not '
              'selected. Defaults to DateTime.now().',
    },
    {
      'term': 'selectableDayPredicate',
      'meaning':
          'A bool Function(DateTime) used to gray out non-selectable days.',
    },
    {
      'term': 'DatePickerMode',
      'meaning':
          'Enum: day | year - which page the calendar renders initially.',
    },
    {
      'term': 'DatePickerEntryMode',
      'meaning':
          'Enum: calendar | input | calendarOnly | inputOnly. Controls dialog UI.',
    },
    {
      'term': 'Range entry mode',
      'meaning':
          'showDateRangePicker uses the same DatePickerEntryMode enum as '
              'showDatePicker - there is no separate range-specific type.',
    },
    {
      'term': 'DatePickerThemeData',
      'meaning':
          'Material 3 theme extension that styles all date pickers in a subtree.',
    },
    {
      'term': 'onDateChanged',
      'meaning':
          'Inline-picker callback invoked when the user taps a different day.',
    },
  ];

  // ============================================================================
  // FRAMEWORK COLORS
  // ============================================================================

  final headerStart = Color(0xFF1565C0);
  final headerEnd = Color(0xFF1976D2);

  // ============================================================================
  // BUILD THE GRAND UI TREE
  // ============================================================================

  return Material(
    color: Color(0xFFFAFAFA),
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===== HEADER =====
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [headerStart, headerEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Material Date Pickers',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Deep Demo: CalendarDatePicker, YearPicker, Input, Theme & Enums',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFBBDEFB),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _pill('CalendarDatePicker'),
                      _pill('YearPicker'),
                      _pill('InputDatePickerFormField'),
                      _pill('DatePickerThemeData'),
                      _pill('DatePickerMode'),
                      _pill('DatePickerEntryMode'),
                      _pill('Range entry mode (shared)'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.0),

            // ===== SECTION 1: DOSSIER =====
            _sectionFrame(
              tone: Color(0xFFE3F2FD),
              border: Color(0xFF90CAF9),
              titleColor: Color(0xFF0D47A1),
              title: '1. Dossier - The Material Date Picker family',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter ships several Material-styled widgets for date '
                        'entry. They differ in three axes:',
                    style: TextStyle(fontSize: 14.0, height: 1.5),
                  ),
                  SizedBox(height: 8.0),
                  _bullet('Inline vs modal - some render in place, others pop a dialog.'),
                  _bullet('Calendar vs text input - some draw a grid, others a text field.'),
                  _bullet('Single date vs range - showDatePicker vs showDateRangePicker.'),
                  SizedBox(height: 12.0),
                  Text(
                    'When to pick which:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  _bullet('Embed CalendarDatePicker when the date is the page focus.'),
                  _bullet('Use InputDatePickerFormField inside an existing Form.'),
                  _bullet('Use showDatePicker for ad-hoc modal "pick a date" buttons.'),
                  _bullet('Use YearPicker alone for year-only selection.'),
                  _bullet('Use showDateRangePicker for from/to interval selection.'),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 2: ANATOMY TABLE =====
            _sectionFrame(
              tone: Color(0xFFE8F5E9),
              border: Color(0xFF81C784),
              titleColor: Color(0xFF2E7D32),
              title: '2. Anatomy - constructor surfaces',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Widget',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Optional',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Returns',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  for (final row in anatomyRows)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFC8E6C9),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                row['widget'] as String,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                row['required'] as String,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                row['optional'] as String,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                row['returns'] as String,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 3: CALENDARDATEPICKER LIVE SHOWCASE =====
            _sectionFrame(
              tone: Color(0xFFFCE4EC),
              border: Color(0xFFF06292),
              titleColor: Color(0xFFC2185B),
              title: '3. CalendarDatePicker - inline calendar variations',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelStrong('3a. Default (DatePickerMode.day)'),
                  _calBox(calDay),
                  SizedBox(height: 12.0),
                  _labelStrong('3b. initialCalendarMode: DatePickerMode.year'),
                  _calBox(calYear),
                  SizedBox(height: 12.0),
                  _labelStrong('3c. Weekdays-only selectableDayPredicate'),
                  _calBox(calWeekdays),
                  SizedBox(height: 12.0),
                  _labelStrong('3d. Even days only selectableDayPredicate'),
                  _calBox(calEvens),
                  SizedBox(height: 12.0),
                  _labelStrong('3e. Narrow window (Jun-Aug 2025)'),
                  _calBox(calQuarter),
                  SizedBox(height: 12.0),
                  _labelStrong('3f. Custom currentDate (Jun 20 marker)'),
                  _calBox(calCustomToday),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 4: YEARPICKER LIVE SHOWCASE =====
            _sectionFrame(
              tone: Color(0xFFF3E5F5),
              border: Color(0xFFCE93D8),
              titleColor: Color(0xFF7B1FA2),
              title: '4. YearPicker - year grid variations',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelStrong('4a. Decade window 2020-2030'),
                  _yearBox(yearDecade),
                  SizedBox(height: 12.0),
                  _labelStrong('4b. Wide window 2000-2050 with currentDate'),
                  _yearBox(yearWide),
                  SizedBox(height: 12.0),
                  _labelStrong('4c. Tight 5-year window 2023-2027'),
                  _yearBox(yearTight),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 5: INPUTDATEPICKERFORMFIELD =====
            _sectionFrame(
              tone: Color(0xFFFFF3E0),
              border: Color(0xFFFFB74D),
              titleColor: Color(0xFFE65100),
              title: '5. InputDatePickerFormField - text-field date input',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelStrong('5a. Bare minimum (only date bounds + initial)'),
                  _inputBox(inputBasic),
                  SizedBox(height: 12.0),
                  _labelStrong('5b. fieldLabelText + fieldHintText'),
                  _inputBox(inputLabeled),
                  SizedBox(height: 12.0),
                  _labelStrong('5c. Custom errorFormatText + errorInvalidText'),
                  _inputBox(inputCustomErrors),
                  SizedBox(height: 12.0),
                  _labelStrong('5d. onDateSubmitted + onDateSaved'),
                  _inputBox(inputSubmit),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 6: DATEPICKERTHEMEDATA =====
            _sectionFrame(
              tone: Color(0xFFE0F7FA),
              border: Color(0xFF4DD0E1),
              titleColor: Color(0xFF00838F),
              title: '6. DatePickerThemeData - styled variants',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Below: same widget rendered inside three different Theme '
                        'subtrees configured with DatePickerThemeData.',
                    style: TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                  SizedBox(height: 12.0),
                  themedCalendar(themeOcean, '6a. Ocean theme (teal)'),
                  SizedBox(height: 12.0),
                  themedCalendar(themeSunset, '6b. Sunset theme (orange)'),
                  SizedBox(height: 12.0),
                  themedCalendar(themeNoir, '6c. Noir theme (slate)'),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 7: ENUM GALLERY =====
            _sectionFrame(
              tone: Color(0xFFE8EAF6),
              border: Color(0xFF7986CB),
              titleColor: Color(0xFF303F9F),
              title: '7. Enum gallery - entry & display modes',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelStrong('DatePickerEntryMode'),
                  for (final m in entryModes)
                    _enumRow(
                      m['name']!,
                      m['index']!,
                      m['description']!,
                      Color(0xFF3F51B5),
                    ),
                  SizedBox(height: 12.0),
                  _labelStrong('DatePickerMode'),
                  for (final m in pickerModes)
                    _enumRow(
                      m['name']!,
                      m['index']!,
                      m['description']!,
                      Color(0xFF7B1FA2),
                    ),
                  SizedBox(height: 12.0),
                  _labelStrong('Range entry mode (DatePickerEntryMode reused)'),
                  for (final m in rangeEntryModes)
                    _enumRow(
                      m['name']!,
                      m['index']!,
                      m['description']!,
                      Color(0xFF00838F),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 8: RECIPE CARDS =====
            _sectionFrame(
              tone: Color(0xFFFFF8E1),
              border: Color(0xFFFFCA28),
              titleColor: Color(0xFFF57F17),
              title: '8. Recipes - copy/paste patterns',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final r in recipes)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFDE7),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFFFFE082),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['title']!,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF57F17),
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              r['when']!,
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF263238),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                r['snippet']!,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontFamily: 'monospace',
                                  color: Color(0xFFB2EBF2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 9: COMPARISON TABLE =====
            _sectionFrame(
              tone: Color(0xFFEFEBE9),
              border: Color(0xFFA1887F),
              titleColor: Color(0xFF5D4037),
              title: '9. Comparison - which date widget fits which slot?',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Style',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Class / function',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Modal?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Input?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Use case',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  for (final c in comparison)
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFD7CCC8),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                c['style']!,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                c['class']!,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: _yesNo(c['modal']!),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: _yesNo(c['input']!),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                c['useCase']!,
                                style: TextStyle(fontSize: 11.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 10: GLOSSARY =====
            _sectionFrame(
              tone: Color(0xFFE1F5FE),
              border: Color(0xFF4FC3F7),
              titleColor: Color(0xFF01579B),
              title: '10. Glossary - vocabulary of the date picker family',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final g in glossary)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF0288D1),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              g['term']!,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              g['meaning']!,
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== SECTION 11: FINAL COMPOSED TREE =====
            _sectionFrame(
              tone: Color(0xFF263238),
              border: Color(0xFF455A64),
              titleColor: Color(0xFFFFFFFF),
              title: '11. Final composed tree',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A side-by-side composition that brings everything together.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFB0BEC5),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 360.0,
                          child: CalendarDatePicker(
                            initialDate: now,
                            firstDate: firstDate,
                            lastDate: lastDate,
                            onDateChanged: (DateTime d) {
                              print('final cal -> $d');
                            },
                          ),
                        ),
                        SizedBox(height: 12.0),
                        SizedBox(
                          height: 200.0,
                          child: YearPicker(
                            firstDate: firstDate,
                            lastDate: lastDate,
                            selectedDate: now,
                            onChanged: (DateTime d) {
                              print('final year -> ${d.year}');
                            },
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InputDatePickerFormField(
                            firstDate: firstDate,
                            lastDate: lastDate,
                            initialDate: now,
                            fieldLabelText: 'Composed picker date',
                            fieldHintText: 'mm/dd/yyyy',
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.0),

            // ===== SUMMARY =====
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [headerStart, headerEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _summary('CalendarDatePicker x 6 variations'),
                  _summary('YearPicker x 3 windows'),
                  _summary('InputDatePickerFormField x 4 form variants'),
                  _summary('DatePickerThemeData x 3 styled subtrees'),
                  _summary('DatePickerEntryMode enum gallery'),
                  _summary('DatePickerMode enum gallery'),
                  _summary('Range entry mode (shared enum) gallery'),
                  _summary('Recipes / comparison / glossary'),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Material Date Pickers: ',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'All variations rendered',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.0),

            // ===== FOOTER =====
            Center(
              child: Text(
                'Deep Demo - Material Date Pickers - Flutter Material',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// TOP-LEVEL HELPERS
// ============================================================================

Widget _pill(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionFrame({
  required Color tone,
  required Color border,
  required Color titleColor,
  required String title,
  required Widget child,
}) {
  final isDark = tone.computeLuminance() < 0.4;
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        SizedBox(height: 12.0),
        DefaultTextStyle.merge(
          style: TextStyle(
            color: isDark ? Color(0xFFFFFFFF) : Color(0xFF263238),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '- ',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.0, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _labelStrong(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF37474F),
      ),
    ),
  );
}

Widget _calBox(Widget picker) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    padding: EdgeInsets.all(4.0),
    child: SizedBox(height: 360.0, child: picker),
  );
}

Widget _yearBox(Widget picker) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    padding: EdgeInsets.all(4.0),
    child: SizedBox(height: 220.0, child: picker),
  );
}

Widget _inputBox(Widget field) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: field,
  );
}

Widget _enumRow(String name, String index, String description, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 11.0, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _yesNo(String value) {
  Color bg;
  if (value == 'yes') {
    bg = Color(0xFF4CAF50);
  } else if (value == 'no') {
    bg = Color(0xFF9E9E9E);
  } else {
    bg = Color(0xFFFFB300);
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      value,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _summary(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(
              'OK',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
      ],
    ),
  );
}
