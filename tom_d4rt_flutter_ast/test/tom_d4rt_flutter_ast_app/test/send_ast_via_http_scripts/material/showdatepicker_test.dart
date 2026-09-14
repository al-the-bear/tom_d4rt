// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests showDatePicker top-level function from material
// Deep Demo: Antique wall-calendar walkthrough of every showDatePicker
// parameter, plus DatePickerMode and DatePickerEntryMode enums. The demo
// renders MOCK dialog visualizations only — showDatePicker itself is never
// invoked at runtime, so this remains safe inside the D4rt sandbox.
import 'package:flutter/material.dart';

// ============================================================
// Antique calendar palette — committed throughout the demo.
// ============================================================
const Color _parchment = Color(0xFFF5E6CA);
const Color _parchmentEdge = Color(0xFFE9D6B4);
const Color _sepia = Color(0xFF8B6F47);
const Color _sepiaDeep = Color(0xFF5C4530);
const Color _ink = Color(0xFF2C1810);
const Color _stampRed = Color(0xFFA8423C);
const Color _agedTeal = Color(0xFF5C8888);
const Color _agedGold = Color(0xFFC9A24A);
const Color _duskLavender = Color(0xFF8E7B97);
const Color _foxing = Color(0xFFD9B891);

dynamic build(BuildContext context) {
  print('showDatePicker Deep Demo executing');
  print('Theme: antique wall calendar — sepia, parchment, ink, stamped red');
  print('NOTE: showDatePicker is NEVER actually invoked. All dialogs are mocks.');

  // ============================================================
  // SECTION 1: Hero — the antique calendar nameplate
  // ============================================================
  print('=== Section 1: Hero plate ===');

  final hero = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_sepia, _sepiaDeep, _ink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _agedGold, width: 3.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _agedGold.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: _stampRed.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: _agedGold, width: 1.0),
          ),
          child: Text(
            'ANNO MMXXVI · CALENDARIUM',
            style: TextStyle(
              fontSize: 11.0,
              letterSpacing: 3.0,
              color: _parchment,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Icon(Icons.calendar_month, size: 64.0, color: _parchment),
        SizedBox(height: 10.0),
        Text(
          'showDatePicker',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: _parchment,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'an antique walk through every parameter',
          style: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
            color: _foxing,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'package:flutter/material.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _agedGold,
          ),
        ),
      ],
    ),
  );
  print('Hero built');

  // ============================================================
  // SECTION 2: Parameter map — anatomy of the call
  // ============================================================
  print('=== Section 2: Parameter map ===');

  final paramRows = <Widget>[];
  final paramData = <List<String>>[
    <String>['context', 'BuildContext', 'required', 'host for the dialog overlay'],
    <String>['initialDate', 'DateTime?', 'optional', 'date selected when opened'],
    <String>['firstDate', 'DateTime', 'required', 'earliest selectable date'],
    <String>['lastDate', 'DateTime', 'required', 'latest selectable date'],
    <String>['currentDate', 'DateTime?', 'optional', 'date drawn as "today"'],
    <String>['initialEntryMode', 'DatePickerEntryMode', 'optional', 'calendar/input on open'],
    <String>['selectableDayPredicate', 'SelectableDayPredicate?', 'optional', 'filter pickable days'],
    <String>['helpText', 'String?', 'optional', 'header instruction text'],
    <String>['cancelText', 'String?', 'optional', 'label for cancel action'],
    <String>['confirmText', 'String?', 'optional', 'label for confirm action'],
    <String>['errorFormatText', 'String?', 'optional', 'shown on parse failure'],
    <String>['errorInvalidText', 'String?', 'optional', 'shown when out of range'],
    <String>['fieldHintText', 'String?', 'optional', 'hint inside text field'],
    <String>['fieldLabelText', 'String?', 'optional', 'label above text field'],
    <String>['keyboardType', 'TextInputType?', 'optional', 'soft-keyboard variant'],
    <String>['initialDatePickerMode', 'DatePickerMode', 'optional', 'day or year on open'],
    <String>['useRootNavigator', 'bool', 'default true', 'route through root or nested'],
    <String>['routeSettings', 'RouteSettings?', 'optional', 'name + args for the route'],
    <String>['textDirection', 'TextDirection?', 'optional', 'override LTR/RTL'],
    <String>['builder', 'TransitionBuilder?', 'optional', 'wrap dialog (themes/locale)'],
    <String>['locale', 'Locale?', 'optional', 'override formatting locale'],
    <String>['barrierDismissible', 'bool', 'default true', 'tap-outside dismiss'],
    <String>['barrierColor', 'Color?', 'optional', 'tint behind the dialog'],
    <String>['barrierLabel', 'String?', 'optional', 'a11y label for barrier'],
    <String>['anchorPoint', 'Offset?', 'optional', 'pick display in nested screens'],
    <String>['switchToInputEntryModeIcon', 'Icon?', 'optional', 'toggle icon to input'],
    <String>['switchToCalendarEntryModeIcon', 'Icon?', 'optional', 'toggle icon to calendar'],
  ];

  // Header row.
  paramRows.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: _sepia.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: <Widget>[
          _paramHeaderCell('parameter', 200.0),
          _paramHeaderCell('type', 180.0),
          _paramHeaderCell('kind', 100.0),
          _paramHeaderCell('purpose', 280.0),
        ],
      ),
    ),
  );
  for (int i = 0; i < paramData.length; i++) {
    final List<String> row = paramData[i];
    final bool zebra = i.isEven;
    paramRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: zebra
              ? _parchment.withValues(alpha: 0.7)
              : _foxing.withValues(alpha: 0.5),
          border: Border(
            bottom: BorderSide(color: _sepia.withValues(alpha: 0.25), width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            _paramCell(row[0], 200.0, _ink, mono: true, bold: true),
            _paramCell(row[1], 180.0, _agedTeal, mono: true),
            _paramCell(row[2], 100.0, _stampRed, italic: true),
            _paramCell(row[3], 280.0, _sepiaDeep),
          ],
        ),
      ),
    );
    print('  param: ${row[0]} : ${row[1]} (${row[2]})');
  }

  final paramMap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_parchment, _parchmentEdge],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _sepia, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Anatomy of the call', Icons.account_tree_outlined),
        SizedBox(height: 8.0),
        Text(
          'Twenty-seven knobs control a single dialog. The required four hold '
          'the contract; everything else is decoration, localization, or '
          'navigation plumbing.',
          style: TextStyle(
            fontSize: 13.0,
            color: _sepiaDeep,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paramRows,
          ),
        ),
      ],
    ),
  );
  print('Parameter map built with ${paramData.length} entries');

  // ============================================================
  // SECTION 3: DatePickerEntryMode state machine
  // ============================================================
  print('=== Section 3: DatePickerEntryMode state machine ===');

  final entryNodes = <Widget>[
    _entryNode(DatePickerEntryMode.calendar, 'CALENDAR',
        Icons.calendar_view_month, _agedTeal,
        'opens grid; user may switch to input'),
    _entryNode(DatePickerEntryMode.calendarOnly, 'CALENDAR ONLY',
        Icons.lock_clock, _sepia,
        'grid only — toggle suppressed'),
    _entryNode(DatePickerEntryMode.input, 'INPUT',
        Icons.keyboard, _duskLavender,
        'opens text field; user may switch to calendar'),
    _entryNode(DatePickerEntryMode.inputOnly, 'INPUT ONLY',
        Icons.edit_note, _stampRed,
        'text field only — toggle suppressed'),
  ];
  for (final DatePickerEntryMode m in DatePickerEntryMode.values) {
    print('  DatePickerEntryMode.${m.name} (index ${m.index})');
  }

  final entryStateMachine = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _duskLavender.withValues(alpha: 0.18),
          _agedTeal.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _sepia, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _sepia.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Entry-mode state machine', Icons.swap_horiz),
        SizedBox(height: 6.0),
        Text(
          'initialEntryMode picks the starting room. The "Only" siblings turn '
          'off the doorway between rooms, leaving the user stranded — by '
          'design.',
          style: TextStyle(fontSize: 12.5, color: _sepiaDeep),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: entryNodes,
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _sepia.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _entryArrow('calendar', '<->', 'input', _agedTeal,
                  'switchable'),
              _entryArrow('calendarOnly', '-X-', 'input', _stampRed,
                  'locked'),
              _entryArrow('input', '<->', 'calendar', _duskLavender,
                  'switchable'),
              _entryArrow('inputOnly', '-X-', 'calendar', _stampRed,
                  'locked'),
            ],
          ),
        ),
      ],
    ),
  );
  print('Entry-mode state machine built');

  // ============================================================
  // SECTION 4: DatePickerMode (day vs year)
  // ============================================================
  print('=== Section 4: DatePickerMode toggle ===');

  for (final DatePickerMode m in DatePickerMode.values) {
    print('  DatePickerMode.${m.name} (index ${m.index})');
  }

  final dayYearToggle = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _agedGold.withValues(alpha: 0.25),
          _foxing.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _agedGold, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _agedGold.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        _sectionTitle('initialDatePickerMode', Icons.toggle_on_outlined),
        SizedBox(height: 8.0),
        Text(
          'Two leaves of the same calendar — the day grid and the year grid. '
          'Tap the header chevron to flip from one to the other.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.5, color: _sepiaDeep),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _modeFace('DAY', Icons.calendar_today, _agedTeal,
                'shows month grid', 'June 2026'),
            Icon(Icons.swap_horiz, size: 28.0, color: _sepia),
            _modeFace('YEAR', Icons.grid_view, _stampRed,
                'shows decade grid', '2020 - 2031'),
          ],
        ),
      ],
    ),
  );
  print('Day/year toggle built');

  // ============================================================
  // SECTION 5: Mock dialog — calendar mode
  // ============================================================
  print('=== Section 5: Mock dialog — calendar mode ===');

  final calendarMock = _mockDialogScaffold(
    title: 'SELECT DATE',
    helpText: 'Select your date of birth',
    confirmText: 'OK',
    cancelText: 'CANCEL',
    chip: 'calendar',
    chipColor: _agedTeal,
    initialDate: DateTime(2026, 6, 15),
    body: _calendarGridMock(
      year: 2026,
      monthLabel: 'June 2026',
      selectedDay: 15,
      currentDay: 8,
      firstSelectableDay: 1,
      lastSelectableDay: 30,
    ),
    footerNote:
        'initialDate=2026-06-15  firstDate=2026-06-01  lastDate=2026-06-30',
    switchIcon: Icons.edit,
    switchTooltip: 'switchToInputEntryModeIcon',
  );
  print('Calendar mock dialog built');

  // ============================================================
  // SECTION 6: Mock dialog — input mode
  // ============================================================
  print('=== Section 6: Mock dialog — input mode ===');

  final inputMock = _mockDialogScaffold(
    title: 'ENTER DATE',
    helpText: 'Enter the date the message arrived',
    confirmText: 'CONFIRM',
    cancelText: 'CANCEL',
    chip: 'input',
    chipColor: _duskLavender,
    initialDate: DateTime(2026, 5, 8),
    body: _inputFieldMock(
      label: 'Date of arrival',
      hint: 'mm/dd/yyyy',
      value: '05/08/2026',
      keyboardHint: 'TextInputType.datetime',
      formatError: 'Invalid format. Use mm/dd/yyyy.',
      invalidError: 'Out of range. 2020-01-01 to 2030-12-31.',
    ),
    footerNote:
        'fieldLabelText, fieldHintText, errorFormatText, errorInvalidText, '
        'keyboardType — all wired into this view',
    switchIcon: Icons.calendar_today,
    switchTooltip: 'switchToCalendarEntryModeIcon',
  );
  print('Input mock dialog built');

  // ============================================================
  // SECTION 7: Mock dialog — year-mode (initialDatePickerMode.year)
  // ============================================================
  print('=== Section 7: Mock dialog — year mode ===');

  final yearMock = _mockDialogScaffold(
    title: 'SELECT YEAR',
    helpText: 'Choose a vintage',
    confirmText: 'OK',
    cancelText: 'CANCEL',
    chip: 'year',
    chipColor: _stampRed,
    initialDate: DateTime(2026, 1, 1),
    body: _yearGridMock(
      first: 2018,
      last: 2031,
      selected: 2026,
      current: 2026,
    ),
    footerNote:
        'initialDatePickerMode=DatePickerMode.year  first=2018  last=2031',
    switchIcon: Icons.calendar_view_day,
    switchTooltip: 'tap header to return to day grid',
  );
  print('Year mock dialog built');

  // ============================================================
  // SECTION 8: Mock dialog — RTL via builder + locale + textDirection
  // ============================================================
  print('=== Section 8: Mock dialog — locale, builder, textDirection ===');

  final localeMock = _mockDialogScaffold(
    title: 'اختر التاريخ',
    helpText: 'حدد تاريخ الميلاد',
    confirmText: 'موافق',
    cancelText: 'إلغاء',
    chip: 'rtl-ar',
    chipColor: _sepia,
    initialDate: DateTime(2026, 6, 15),
    body: _calendarGridMock(
      year: 2026,
      monthLabel: 'يونيو ٢٠٢٦',
      selectedDay: 15,
      currentDay: 8,
      firstSelectableDay: 1,
      lastSelectableDay: 30,
      rtl: true,
    ),
    footerNote:
        'locale=Locale("ar")  textDirection=TextDirection.rtl  '
        'builder wraps with Directionality + Localizations',
    switchIcon: Icons.edit,
    switchTooltip: 'switchToInputEntryModeIcon',
    rtl: true,
  );
  print('Locale/RTL mock dialog built');

  // ============================================================
  // SECTION 9: selectableDayPredicate filter taxonomy
  // ============================================================
  print('=== Section 9: selectableDayPredicate ===');

  final predicateRows = <Widget>[];
  final predicateExamples = <List<String>>[
    <String>['weekdays only', '(d) => d.weekday <= 5', 'sat & sun grayed out'],
    <String>['mondays only', '(d) => d.weekday == DateTime.monday',
        '~4 selectable cells per month'],
    <String>['no holidays', '(d) => !holidaySet.contains(d)',
        'arbitrary blocked dates'],
    <String>['business days', '(d) => d.weekday <= 5 && !holidays.contains(d)',
        'composite filter'],
    <String>['even days only', '(d) => d.day.isEven', 'parity filter'],
    <String>['accept all', 'null  (or  (_) => true)', 'every day pickable'],
  ];
  for (int i = 0; i < predicateExamples.length; i++) {
    final List<String> row = predicateExamples[i];
    predicateRows.add(_predicateRow(row[0], row[1], row[2], i.isEven));
    print('  predicate "${row[0]}" => ${row[1]}');
  }

  final predicateBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _agedTeal.withValues(alpha: 0.18),
          _parchment.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _agedTeal, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _agedTeal.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('selectableDayPredicate', Icons.filter_alt),
        SizedBox(height: 6.0),
        Text(
          'A pure predicate (DateTime) -> bool. Returning false grays the cell '
          'and disables tap. The predicate runs for every visible day of every '
          'visible month, so keep it cheap.',
          style: TextStyle(fontSize: 12.5, color: _sepiaDeep),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _sepia.withValues(alpha: 0.4)),
          ),
          child: Column(children: predicateRows),
        ),
        SizedBox(height: 14.0),
        Text(
          'Visualizing a "weekdays only" predicate over June 2026:',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            color: _sepiaDeep,
          ),
        ),
        SizedBox(height: 8.0),
        _predicateGrid(),
      ],
    ),
  );
  print('selectableDayPredicate taxonomy built');

  // ============================================================
  // SECTION 10: Barrier + navigation parameters
  // ============================================================
  print('=== Section 10: Barrier & navigation ===');

  final barrierBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _ink.withValues(alpha: 0.85),
          _sepiaDeep.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _agedGold, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Barrier & navigation knobs', Icons.layers,
            light: true),
        SizedBox(height: 8.0),
        _barrierRow('barrierDismissible', 'true / false',
            'tap-outside dismiss; false locks user inside dialog'),
        _barrierRow('barrierColor', 'Color?',
            'tint behind dialog (defaults to Colors.black54)'),
        _barrierRow('barrierLabel', 'String?',
            'a11y label; required when barrierDismissible is false'),
        _barrierRow('useRootNavigator', 'bool (default true)',
            'route via Navigator.of(context, rootNavigator: true)'),
        _barrierRow('routeSettings', 'RouteSettings?',
            'name and arguments stored on the modal route'),
        _barrierRow('anchorPoint', 'Offset?',
            'pick which display in multi-display setups'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _ink.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 160.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    'barrierColor: Colors.black54',
                    style: TextStyle(
                      color: _foxing,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              Container(
                width: 220.0,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: _parchment,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 14.0,
                      offset: Offset(0.0, 8.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.calendar_month, color: _sepia, size: 28.0),
                    SizedBox(height: 6.0),
                    Text(
                      'dialog above the scrim',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Barrier/navigation block built');

  // ============================================================
  // SECTION 11: Switch icons (calendar <-> input)
  // ============================================================
  print('=== Section 11: switch icons ===');

  final switchIconsBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _duskLavender.withValues(alpha: 0.18),
          _parchment.withValues(alpha: 0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _duskLavender, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _duskLavender.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Switch-mode icons', Icons.swap_calls),
        SizedBox(height: 6.0),
        Text(
          'When the entry-mode is switchable, a single icon button in the '
          'dialog footer flips the view. These two parameters override the '
          'default glyphs.',
          style: TextStyle(fontSize: 12.5, color: _sepiaDeep),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _switchIconCard(
              'switchToInputEntryModeIcon',
              Icons.edit,
              'shown while in calendar mode',
              _duskLavender,
            ),
            _switchIconCard(
              'switchToCalendarEntryModeIcon',
              Icons.calendar_today,
              'shown while in input mode',
              _agedTeal,
            ),
          ],
        ),
      ],
    ),
  );
  print('Switch-icons block built');

  // ============================================================
  // SECTION 12: Text labels grid
  // ============================================================
  print('=== Section 12: text labels grid ===');

  final labelsBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _stampRed.withValues(alpha: 0.18),
          _foxing.withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _stampRed, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _stampRed.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Localizable text slots', Icons.translate),
        SizedBox(height: 8.0),
        Text(
          'Every visible string of the dialog is overridable. Defaults come '
          'from MaterialLocalizations; pass your own to brand the dialog or '
          'localize beyond the supported locales.',
          style: TextStyle(fontSize: 12.5, color: _sepiaDeep),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _labelChip('helpText', '"Select date"', _agedTeal),
            _labelChip('cancelText', '"CANCEL"', _stampRed),
            _labelChip('confirmText', '"OK"', _agedTeal),
            _labelChip('errorFormatText', '"Invalid format."', _stampRed),
            _labelChip('errorInvalidText', '"Out of range."', _stampRed),
            _labelChip('fieldHintText', '"mm/dd/yyyy"', _duskLavender),
            _labelChip('fieldLabelText', '"Date of birth"', _duskLavender),
          ],
        ),
      ],
    ),
  );
  print('Labels block built');

  // ============================================================
  // SECTION 13: keyboardType + currentDate spotlight
  // ============================================================
  print('=== Section 13: keyboardType + currentDate ===');

  final spotlight = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _agedGold.withValues(alpha: 0.2),
          _parchment.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _agedGold, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _agedGold.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('keyboardType & currentDate', Icons.today),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _spotlightCard(
                title: 'keyboardType',
                subtitle: 'TextInputType?',
                body:
                    'Controls the soft keyboard variant when the field is in '
                    'input mode. TextInputType.datetime gives platforms a hint '
                    'to show numeric + slash keys.',
                example: 'keyboardType: TextInputType.datetime',
                color: _agedTeal,
                icon: Icons.keyboard_alt_outlined,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _spotlightCard(
                title: 'currentDate',
                subtitle: 'DateTime?',
                body:
                    'Date drawn with the "today" ring. Defaults to '
                    'DateTime.now(). Use it to pin a deterministic "today" in '
                    'tests or screenshots.',
                example: 'currentDate: DateTime(2026, 5, 8)',
                color: _stampRed,
                icon: Icons.event_available,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Spotlight built');

  // ============================================================
  // SECTION 14: Code recipes (mock — never executed)
  // ============================================================
  print('=== Section 14: code recipes ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ink,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _agedGold.withValues(alpha: 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: _agedGold, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes (illustrative — not run here)',
              style: TextStyle(
                color: _agedGold,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeSnippet(
          '// Minimal call — only the four required arguments.\n'
          'final picked = await showDatePicker(\n'
          '  context: context,\n'
          '  initialDate: DateTime.now(),\n'
          '  firstDate: DateTime(2020),\n'
          '  lastDate: DateTime(2030),\n'
          ');',
          _agedTeal,
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          '// Input-only with localized labels and error texts.\n'
          'final picked = await showDatePicker(\n'
          '  context: context,\n'
          '  firstDate: DateTime(2020),\n'
          '  lastDate: DateTime(2030),\n'
          '  initialEntryMode: DatePickerEntryMode.inputOnly,\n'
          '  fieldLabelText: "Date of birth",\n'
          '  fieldHintText: "mm/dd/yyyy",\n'
          '  errorFormatText: "Use mm/dd/yyyy.",\n'
          '  errorInvalidText: "Out of range.",\n'
          '  keyboardType: TextInputType.datetime,\n'
          ');',
          _duskLavender,
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          '// Calendar-only with predicate and switch-icon overrides.\n'
          'final picked = await showDatePicker(\n'
          '  context: context,\n'
          '  initialDate: DateTime(2026, 6, 15),\n'
          '  firstDate: DateTime(2026, 1, 1),\n'
          '  lastDate: DateTime(2026, 12, 31),\n'
          '  initialEntryMode: DatePickerEntryMode.calendarOnly,\n'
          '  initialDatePickerMode: DatePickerMode.day,\n'
          '  selectableDayPredicate: (d) => d.weekday <= 5,\n'
          '  switchToInputEntryModeIcon: Icon(Icons.edit_calendar),\n'
          '  switchToCalendarEntryModeIcon: Icon(Icons.calendar_view_month),\n'
          ');',
          _stampRed,
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          '// Localized RTL via builder + locale + textDirection.\n'
          'final picked = await showDatePicker(\n'
          '  context: context,\n'
          '  initialDate: DateTime(2026, 6, 15),\n'
          '  firstDate: DateTime(2020),\n'
          '  lastDate: DateTime(2030),\n'
          '  locale: const Locale("ar"),\n'
          '  textDirection: TextDirection.rtl,\n'
          '  builder: (ctx, child) => Directionality(\n'
          '    textDirection: TextDirection.rtl,\n'
          '    child: child!,\n'
          '  ),\n'
          ');',
          _agedGold,
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          '// Barrier customization + nested navigator routing.\n'
          'final picked = await showDatePicker(\n'
          '  context: context,\n'
          '  initialDate: DateTime.now(),\n'
          '  firstDate: DateTime(2020),\n'
          '  lastDate: DateTime(2030),\n'
          '  barrierDismissible: false,\n'
          '  barrierColor: Colors.black87,\n'
          '  barrierLabel: "Calendar dialog backdrop",\n'
          '  useRootNavigator: false,\n'
          '  routeSettings: const RouteSettings(name: "/dob"),\n'
          ');',
          _foxing,
        ),
      ],
    ),
  );
  print('Code recipes built');

  // ============================================================
  // SECTION 15: Closing narrative
  // ============================================================
  print('=== Section 15: closing narrative ===');

  final closing = Container(
    margin: EdgeInsets.only(top: 12.0, bottom: 24.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_sepiaDeep, _ink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _agedGold, width: 2.0),
    ),
    child: Column(
      children: <Widget>[
        Icon(Icons.bookmark, color: _agedGold, size: 32.0),
        SizedBox(height: 8.0),
        Text(
          'Coda',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: _parchment,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'showDatePicker is a façade for the underlying _DatePickerDialog and '
          'its themed route. The 27 arguments map cleanly onto five concerns: '
          'data window (firstDate/lastDate/currentDate/initialDate/predicate), '
          'mode selection (entry mode + day/year), text content, scrim and '
          'route plumbing, and locale. Pick the smallest subset that survives '
          'your design review.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5,
            color: _foxing,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
  print('Closing built');

  print('showDatePicker Deep Demo completed successfully');

  // ============================================================
  // Compose final scroll
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hero,
        SizedBox(height: 22.0),
        _h2('1. Anatomy: every parameter, on a parchment'),
        paramMap,
        SizedBox(height: 18.0),
        _h2('2. DatePickerEntryMode — four rooms, two doors'),
        entryStateMachine,
        SizedBox(height: 18.0),
        _h2('3. DatePickerMode — day vs year leaf'),
        dayYearToggle,
        SizedBox(height: 18.0),
        _h2('4. Mock dialog — calendar mode'),
        Center(child: calendarMock),
        SizedBox(height: 18.0),
        _h2('5. Mock dialog — input mode'),
        Center(child: inputMock),
        SizedBox(height: 18.0),
        _h2('6. Mock dialog — year mode'),
        Center(child: yearMock),
        SizedBox(height: 18.0),
        _h2('7. Mock dialog — locale + builder + textDirection (RTL)'),
        Center(child: localeMock),
        SizedBox(height: 18.0),
        _h2('8. selectableDayPredicate — filtering days'),
        predicateBlock,
        SizedBox(height: 18.0),
        _h2('9. Barrier & navigation — beyond the dialog'),
        barrierBlock,
        SizedBox(height: 18.0),
        _h2('10. Switch-mode icons'),
        switchIconsBlock,
        SizedBox(height: 18.0),
        _h2('11. Localizable text slots'),
        labelsBlock,
        SizedBox(height: 18.0),
        _h2('12. keyboardType & currentDate'),
        spotlight,
        SizedBox(height: 18.0),
        _h2('13. Code recipes'),
        codeBlock,
        closing,
      ],
    ),
  );
}

// ============================================================
// Helper: section heading H2 banner
// ============================================================
Widget _h2(String text) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_sepia, _sepiaDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.bookmark_border, color: _agedGold, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: _parchment,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: small section title
// ============================================================
Widget _sectionTitle(String text, IconData icon, {bool light = false}) {
  return Row(
    children: <Widget>[
      Icon(icon, color: light ? _agedGold : _sepiaDeep, size: 20.0),
      SizedBox(width: 8.0),
      Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: light ? _parchment : _sepiaDeep,
          letterSpacing: 0.4,
        ),
      ),
    ],
  );
}

// ============================================================
// Helper: parameter table cells
// ============================================================
Widget _paramHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: _parchment,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _paramCell(
  String text,
  double width,
  Color color, {
  bool mono = false,
  bool bold = false,
  bool italic = false,
}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: color,
        fontFamily: mono ? 'monospace' : null,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    ),
  );
}

// ============================================================
// Helper: entry-mode node
// ============================================================
Widget _entryNode(
  DatePickerEntryMode mode,
  String label,
  IconData icon,
  Color color,
  String description,
) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, size: 30.0, color: color),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'index ${mode.index}',
          style: TextStyle(
            fontSize: 9.5,
            fontFamily: 'monospace',
            color: _sepiaDeep,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.5, color: _sepiaDeep),
        ),
      ],
    ),
  );
}

Widget _entryArrow(
  String from,
  String arrow,
  String to,
  Color color,
  String label,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        '$from $arrow $to',
        style: TextStyle(
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(fontSize: 9.5, color: _sepiaDeep),
      ),
    ],
  );
}

// ============================================================
// Helper: mode face (DAY / YEAR)
// ============================================================
Widget _modeFace(
  String label,
  IconData icon,
  Color color,
  String description,
  String example,
) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, size: 32.0, color: color),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.0, color: _sepiaDeep),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            example,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: mock dialog scaffold
// ============================================================
Widget _mockDialogScaffold({
  required String title,
  required String helpText,
  required String confirmText,
  required String cancelText,
  required String chip,
  required Color chipColor,
  required DateTime initialDate,
  required Widget body,
  required String footerNote,
  required IconData switchIcon,
  required String switchTooltip,
  bool rtl = false,
}) {
  final Widget dialog = Container(
    width: 340.0,
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _sepia.withValues(alpha: 0.6), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: _agedGold.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Dialog header
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[chipColor, chipColor.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: _parchment.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      chip,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: chipColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.event, color: _parchment, size: 18.0),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                helpText,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _parchment.withValues(alpha: 0.95),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: _parchment,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                _formatDate(initialDate, rtl),
                style: TextStyle(
                  fontSize: 14.0,
                  color: _parchment.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        // Dialog body
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: body,
        ),
        Divider(color: _sepia.withValues(alpha: 0.3), height: 1.0),
        // Dialog footer
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
          child: Row(
            children: <Widget>[
              Tooltip(
                message: switchTooltip,
                child: Icon(switchIcon, color: _sepia, size: 20.0),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: chipColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  confirmText,
                  style: TextStyle(
                    color: chipColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Footer parameter note
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: _foxing.withValues(alpha: 0.45),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
            ),
          ),
          child: Text(
            footerNote,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: _sepiaDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // Wrap with a tinted scrim like a real modal barrier.
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Center(child: dialog),
  );
}

String _formatDate(DateTime d, bool rtl) {
  if (rtl) {
    return '${d.day} / ${d.month} / ${d.year}';
  }
  return '${_monthName(d.month)} ${d.day}, ${d.year}';
}

String _monthName(int month) {
  const List<String> names = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  if (month >= 1 && month <= 12) {
    return names[month - 1];
  }
  return 'Mon';
}

// ============================================================
// Helper: calendar grid mock
// ============================================================
Widget _calendarGridMock({
  required int year,
  required String monthLabel,
  required int selectedDay,
  required int currentDay,
  required int firstSelectableDay,
  required int lastSelectableDay,
  bool rtl = false,
}) {
  final List<String> weekdayLabels = rtl
      ? <String>['س', 'ج', 'خ', 'ر', 'ث', 'ن', 'ح']
      : <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  final List<Widget> headerRow = <Widget>[];
  for (int i = 0; i < 7; i++) {
    headerRow.add(
      SizedBox(
        width: 36.0,
        child: Text(
          weekdayLabels[i],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: _sepiaDeep,
          ),
        ),
      ),
    );
  }

  // Build a 5-row grid representing a 30-day month, starting on a Monday.
  final List<Widget> rows = <Widget>[];
  int day = 1;
  for (int r = 0; r < 5; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < 7; c++) {
      final int slot = r * 7 + c;
      if (slot < 0 || day > 30) {
        cells.add(SizedBox(width: 36.0, height: 36.0));
        continue;
      }
      final int currentDayLocal = day;
      final bool isSelected = currentDayLocal == selectedDay;
      final bool isCurrent = currentDayLocal == currentDay;
      final bool isInRange = currentDayLocal >= firstSelectableDay &&
          currentDayLocal <= lastSelectableDay;
      cells.add(
        _calendarCell(
          day: currentDayLocal,
          isSelected: isSelected,
          isCurrent: isCurrent,
          isInRange: isInRange,
        ),
      );
      day++;
    }
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _parchmentEdge.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _sepia.withValues(alpha: 0.4)),
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.chevron_left, color: _sepia, size: 20.0),
            Text(
              '$monthLabel · $year',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: _ink,
              ),
            ),
            Icon(Icons.chevron_right, color: _sepia, size: 20.0),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: headerRow,
        ),
        SizedBox(height: 4.0),
        ...rows,
      ],
    ),
  );
}

Widget _calendarCell({
  required int day,
  required bool isSelected,
  required bool isCurrent,
  required bool isInRange,
}) {
  Color background = Colors.transparent;
  Color border = Colors.transparent;
  Color textColor = _ink;
  if (isSelected) {
    background = _stampRed;
    textColor = _parchment;
  }
  if (isCurrent && !isSelected) {
    border = _stampRed;
    textColor = _stampRed;
  }
  if (!isInRange) {
    textColor = _sepia.withValues(alpha: 0.4);
  }
  return Container(
    width: 36.0,
    height: 36.0,
    margin: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      color: background,
      shape: BoxShape.circle,
      border: Border.all(color: border, width: 1.5),
    ),
    alignment: Alignment.center,
    child: Text(
      day.toString(),
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: isSelected || isCurrent ? FontWeight.bold : FontWeight.normal,
        color: textColor,
      ),
    ),
  );
}

// ============================================================
// Helper: input field mock
// ============================================================
Widget _inputFieldMock({
  required String label,
  required String hint,
  required String value,
  required String keyboardHint,
  required String formatError,
  required String invalidError,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          color: _sepiaDeep,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: _parchmentEdge,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: _sepia.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'monospace',
                  color: _ink,
                ),
              ),
            ),
            Text(
              hint,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: _sepia.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: _agedTeal.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.keyboard, size: 14.0, color: _agedTeal),
            SizedBox(width: 6.0),
            Text(
              keyboardHint,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: _agedTeal,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      _errorPill(formatError, Icons.format_clear),
      SizedBox(height: 4.0),
      _errorPill(invalidError, Icons.event_busy),
    ],
  );
}

Widget _errorPill(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: _stampRed.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: _stampRed.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 14.0, color: _stampRed),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.0,
              color: _stampRed,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: year grid mock
// ============================================================
Widget _yearGridMock({
  required int first,
  required int last,
  required int selected,
  required int current,
}) {
  final int span = last - first + 1;
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < span; i++) {
    final int year = first + i;
    final bool isSelected = year == selected;
    final bool isCurrent = year == current;
    cells.add(
      Container(
        width: 64.0,
        height: 36.0,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: isSelected ? _stampRed : Colors.transparent,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: isCurrent && !isSelected
                ? _stampRed
                : _sepia.withValues(alpha: 0.4),
            width: isCurrent && !isSelected ? 1.5 : 1.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          year.toString(),
          style: TextStyle(
            fontSize: 12.0,
            fontWeight:
                isSelected || isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? _parchment : _ink,
          ),
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _parchmentEdge.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _sepia.withValues(alpha: 0.4)),
    ),
    child: Wrap(alignment: WrapAlignment.center, children: cells),
  );
}

// ============================================================
// Helper: predicate row + grid
// ============================================================
Widget _predicateRow(String name, String code, String effect, bool zebra) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: zebra
          ? _foxing.withValues(alpha: 0.4)
          : _parchment.withValues(alpha: 0.7),
      border: Border(
        bottom: BorderSide(color: _sepia.withValues(alpha: 0.2), width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: _ink,
            ),
          ),
        ),
        SizedBox(
          width: 240.0,
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _agedTeal,
            ),
          ),
        ),
        Expanded(
          child: Text(
            effect,
            style: TextStyle(
              fontSize: 11.0,
              color: _sepiaDeep,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _predicateGrid() {
  // Same shape as a calendar grid; weekday <=5 is selectable.
  final List<Widget> rows = <Widget>[];
  int day = 1;
  for (int r = 0; r < 5; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < 7; c++) {
      if (day > 30) {
        cells.add(SizedBox(width: 32.0, height: 32.0));
        continue;
      }
      // Pretend the month starts on a Monday. c==5 is Saturday, c==6 Sunday.
      final bool selectable = c <= 4;
      cells.add(
        Container(
          width: 32.0,
          height: 32.0,
          margin: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: selectable
                ? _agedTeal.withValues(alpha: 0.2)
                : _foxing.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: selectable
                  ? _agedTeal
                  : _sepia.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            day.toString(),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight:
                  selectable ? FontWeight.bold : FontWeight.normal,
              color: selectable
                  ? _agedTeal
                  : _sepia.withValues(alpha: 0.6),
              decoration: selectable
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
        ),
      );
      day++;
    }
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _agedTeal.withValues(alpha: 0.6)),
    ),
    child: Column(children: rows),
  );
}

// ============================================================
// Helper: barrier row
// ============================================================
Widget _barrierRow(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: _agedGold,
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _foxing,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 11.5,
              color: _parchment,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: switch icon card
// ============================================================
Widget _switchIconCard(
  String title,
  IconData icon,
  String description,
  Color color,
) {
  return Container(
    width: 200.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28.0, color: color),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            color: _sepiaDeep,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: label chip
// ============================================================
Widget _labelChip(String name, String example, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          example,
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            color: _sepiaDeep,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: spotlight card
// ============================================================
Widget _spotlightCard({
  required String title,
  required String subtitle,
  required String body,
  required String example,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 5.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: _sepiaDeep,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          body,
          style: TextStyle(fontSize: 11.5, color: _ink, height: 1.4),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            example,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: code snippet
// ============================================================
Widget _codeSnippet(String text, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _sepiaDeep.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: color,
        height: 1.45,
      ),
    ),
  );
}
