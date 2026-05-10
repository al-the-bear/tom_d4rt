// ignore_for_file: avoid_print, unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// D4rt test script: showTimePicker / TimePickerDialog deep demo.
//
// Theme: a horologist's atelier — brass plates, blued steel, ivory dials,
// crimson seconds-tick lacquer, and the soft glow of a workbench lamp.
// Every section is a static visualization; showTimePicker is NEVER invoked.
// All clock faces, entry-mode panes, and dialog mock-ups are rendered with
// plain Container / Stack / Transform widgets, so the demo is safe to run
// inside the D4rt sandbox where no real overlay is mounted.
import 'package:flutter/material.dart';

// ============================================================
// Atelier palette — committed for the whole walkthrough.
// ============================================================
const Color _ivory = Color(0xFFF4ECD8);
const Color _ivoryDeep = Color(0xFFE7DCC0);
const Color _brass = Color(0xFFB08D3A);
const Color _brassBright = Color(0xFFD4B164);
const Color _brassDeep = Color(0xFF6F5520);
const Color _bluedSteel = Color(0xFF2A3B5F);
const Color _bluedSteelDeep = Color(0xFF18233B);
const Color _midnight = Color(0xFF0E1422);
const Color _crimson = Color(0xFF9B2C2C);
const Color _emerald = Color(0xFF3F6E5A);
const Color _patina = Color(0xFF6E8E84);
const Color _shadow = Color(0xFF1A1A1A);
const Color _hairline = Color(0xFF8B7B5A);

// ============================================================
// Tiny helpers — declared up top so the build() body stays linear.
// ============================================================
TextStyle _serif(double size, Color color, {FontWeight? weight, double? spacing, FontStyle? italic}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight ?? FontWeight.normal,
    letterSpacing: spacing ?? 0.0,
    fontStyle: italic ?? FontStyle.normal,
  );
}

TextStyle _mono(double size, Color color, {FontWeight? weight}) {
  return TextStyle(
    fontFamily: 'monospace',
    fontSize: size,
    color: color,
    fontWeight: weight ?? FontWeight.normal,
  );
}

Widget _chip(String label, Color bg, Color fg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: fg.withValues(alpha: 0.4), width: 0.6),
    ),
    child: Text(label, style: _mono(10.5, fg, weight: FontWeight.w600)),
  );
}

Widget _dot(Color color, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget _tickRow(int count, Color color) {
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i < count; i++) {
    ticks.add(Container(
      width: 1.5,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      color: color,
    ));
  }
  return Row(mainAxisSize: MainAxisSize.min, children: ticks);
}

Widget _sectionHeader(String index, String title, String subtitle) {
  return Container(
    margin: EdgeInsets.only(top: 28.0, bottom: 14.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_bluedSteel, _bluedSteelDeep],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _brass.withValues(alpha: 0.85),
            shape: BoxShape.circle,
            border: Border.all(color: _brassBright, width: 1.5),
          ),
          child: Text(index, style: _serif(16.0, _midnight, weight: FontWeight.bold)),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _serif(18.0, _ivory, weight: FontWeight.bold, spacing: 0.6)),
              SizedBox(height: 2.0),
              Text(subtitle, style: _serif(11.5, _ivoryDeep.withValues(alpha: 0.75), italic: FontStyle.italic)),
            ],
          ),
        ),
        Icon(Icons.access_time, color: _brassBright, size: 22.0),
      ],
    ),
  );
}

Widget _paramHeaderCell(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label.toUpperCase(),
      style: _mono(10.5, _ivory, weight: FontWeight.bold),
    ),
  );
}

Widget _paramCell(String text, double width, {bool mono = false, Color? color}) {
  final Color c = color ?? _midnight;
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: mono ? _mono(11.0, c) : _serif(11.5, c),
    ),
  );
}

// ============================================================
// build() — the demo entry point.
// ============================================================
dynamic build(BuildContext context) {
  print('showTimePicker Deep Demo executing');
  print('Theme: horologist atelier — brass, blued steel, ivory, crimson');
  print('NOTE: showTimePicker is NEVER invoked. Every dialog is a static mock.');

  // ============================================================
  // SECTION 1: Hero — atelier nameplate
  // ============================================================
  print('=== Section 1: Hero plate ===');

  final Widget hero = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_bluedSteel, _bluedSteelDeep, _midnight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _brass, width: 3.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.55),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _brassBright.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: _crimson.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: _brassBright, width: 1.0),
          ),
          child: Text(
            'ATELIER · HOROLOGIE · MMXXVI',
            style: _serif(11.0, _ivory, weight: FontWeight.bold, spacing: 3.0),
          ),
        ),
        SizedBox(height: 18.0),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 86.0,
              height: 86.0,
              decoration: BoxDecoration(
                color: _ivory,
                shape: BoxShape.circle,
                border: Border.all(color: _brass, width: 4.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
            ),
            // Hour hand at 10 o'clock-ish.
            Transform.rotate(
              angle: -0.6,
              child: Container(
                width: 4.0,
                height: 28.0,
                color: _midnight,
              ),
            ),
            // Minute hand at the 2.
            Transform.rotate(
              angle: 0.9,
              child: Container(
                width: 2.0,
                height: 36.0,
                color: _bluedSteel,
              ),
            ),
            _dot(_crimson, 10.0),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'showTimePicker',
          style: _serif(30.0, _ivory, weight: FontWeight.bold, spacing: 1.5),
        ),
        SizedBox(height: 4.0),
        Text(
          'an horologist\u2019s walkthrough of every parameter',
          style: _serif(14.0, _brassBright, italic: FontStyle.italic),
        ),
        SizedBox(height: 12.0),
        Text(
          'package:flutter/material.dart',
          style: _mono(11.0, _brassBright),
        ),
        SizedBox(height: 4.0),
        Text(
          'Future<TimeOfDay?> showTimePicker({...})',
          style: _mono(11.0, _ivoryDeep),
        ),
      ],
    ),
  );
  print('Hero built');

  // ============================================================
  // SECTION 2: Anatomy — parameter table
  // ============================================================
  print('=== Section 2: Parameter map ===');

  final List<List<String>> paramData = <List<String>>[
    <String>['context', 'BuildContext', 'required', 'host for the modal route'],
    <String>['initialTime', 'TimeOfDay', 'required', 'time selected when opened'],
    <String>['initialEntryMode', 'TimePickerEntryMode', 'optional', 'dial vs keyboard input'],
    <String>['helpText', 'String?', 'optional', 'header instruction text'],
    <String>['cancelText', 'String?', 'optional', 'label for cancel action'],
    <String>['confirmText', 'String?', 'optional', 'label for confirm action'],
    <String>['errorInvalidText', 'String?', 'optional', 'shown on invalid entry'],
    <String>['hourLabelText', 'String?', 'optional', 'label above hour field'],
    <String>['minuteLabelText', 'String?', 'optional', 'label above minute field'],
    <String>['builder', 'TransitionBuilder?', 'optional', 'wrap dialog with theme/locale'],
    <String>['useRootNavigator', 'bool', 'default true', 'route on root vs nested'],
    <String>['routeSettings', 'RouteSettings?', 'optional', 'name + args for the route'],
    <String>['anchorPoint', 'Offset?', 'optional', 'display anchor on multi-screen'],
    <String>['orientation', 'Orientation?', 'optional', 'force portrait or landscape'],
    <String>['onEntryModeChanged', 'EntryModeChangeCallback?', 'optional', 'callback when mode toggles'],
    <String>['barrierDismissible', 'bool', 'default true', 'tap-outside dismiss'],
    <String>['barrierColor', 'Color?', 'optional', 'tint behind dialog'],
    <String>['barrierLabel', 'String?', 'optional', 'a11y label for barrier'],
  ];

  final List<Widget> paramRows = <Widget>[];
  paramRows.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: _bluedSteel.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: <Widget>[
          _paramHeaderCell('parameter', 190.0),
          _paramHeaderCell('type', 200.0),
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
              ? _ivory.withValues(alpha: 0.85)
              : _ivoryDeep.withValues(alpha: 0.65),
          border: Border(
            bottom: BorderSide(color: _hairline.withValues(alpha: 0.4), width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            _paramCell(row[0], 190.0, mono: true, color: _midnight),
            _paramCell(row[1], 200.0, mono: true, color: _bluedSteelDeep),
            _paramCell(row[2], 100.0, color: _crimson),
            _paramCell(row[3], 280.0, color: _midnight),
          ],
        ),
      ),
    );
  }

  final Widget paramTable = Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _brass.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: paramRows),
  );
  print('Parameter table rows: ${paramRows.length}');

  // ============================================================
  // SECTION 3: TimeOfDay anatomy — the value object the dialog returns
  // ============================================================
  print('=== Section 3: TimeOfDay anatomy ===');

  final Widget todField = Container(
    width: 180.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('hour', style: _mono(10.5, _crimson, weight: FontWeight.bold)),
        SizedBox(height: 2.0),
        Text('int   0..23', style: _mono(11.0, _midnight)),
        SizedBox(height: 2.0),
        Text('always 24h internally', style: _serif(10.5, _patina, italic: FontStyle.italic)),
      ],
    ),
  );

  final Widget todMinute = Container(
    width: 180.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('minute', style: _mono(10.5, _crimson, weight: FontWeight.bold)),
        SizedBox(height: 2.0),
        Text('int   0..59', style: _mono(11.0, _midnight)),
        SizedBox(height: 2.0),
        Text('no seconds — none', style: _serif(10.5, _patina, italic: FontStyle.italic)),
      ],
    ),
  );

  final Widget todPeriod = Container(
    width: 180.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('period', style: _mono(10.5, _crimson, weight: FontWeight.bold)),
        SizedBox(height: 2.0),
        Text('DayPeriod.am / .pm', style: _mono(11.0, _midnight)),
        SizedBox(height: 2.0),
        Text('derived from hour', style: _serif(10.5, _patina, italic: FontStyle.italic)),
      ],
    ),
  );

  final Widget todAnatomy = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_ivory, _ivoryDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.schedule, color: _crimson, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'TimeOfDay — three small fields, one big idea',
              style: _serif(15.0, _midnight, weight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'TimeOfDay is the hand-bound little ledger Flutter passes around. '
          'It carries hour (0..23) and minute (0..59) and computes period from the hour. '
          'It has no DateTime, no time-zone, no seconds. The dialog reads it on open '
          'and returns a fresh TimeOfDay when the user confirms — or null on cancel.',
          style: _serif(12.0, _midnight),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[todField, todMinute, todPeriod],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _midnight,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('// Construct', style: _mono(10.5, _patina)),
              Text('const TimeOfDay(hour: 9, minute: 41)', style: _mono(11.5, _ivory)),
              SizedBox(height: 4.0),
              Text('// From a DateTime', style: _mono(10.5, _patina)),
              Text('TimeOfDay.fromDateTime(DateTime.now())', style: _mono(11.5, _ivory)),
              SizedBox(height: 4.0),
              Text('// Equality is by (hour, minute)', style: _mono(10.5, _patina)),
              Text('a == b   iff a.hour==b.hour && a.minute==b.minute', style: _mono(11.5, _ivory)),
            ],
          ),
        ),
      ],
    ),
  );
  print('TimeOfDay anatomy built');

  // ============================================================
  // SECTION 4: Mock dial — the round face
  // ============================================================
  print('=== Section 4: Dial mock ===');

  final List<Widget> hourMarks = <Widget>[];
  for (int h = 1; h <= 12; h++) {
    final double angle = (h / 12.0) * 6.28318;
    final double radius = 78.0;
    final double dx = radius * _sinApprox(angle);
    final double dy = -radius * _cosApprox(angle);
    hourMarks.add(
      Positioned(
        left: 100.0 + dx - 10.0,
        top: 100.0 + dy - 10.0,
        child: Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          child: Text(
            h.toString(),
            style: _serif(12.0, _midnight, weight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  final Widget dialFace = Container(
    width: 220.0,
    height: 220.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: <Color>[_ivory, _ivoryDeep],
        center: Alignment.center,
        radius: 0.85,
      ),
      border: Border.all(color: _brass, width: 4.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _shadow.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        // Selection highlight at the "9".
        Positioned(
          left: 8.0,
          top: 96.0,
          child: Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: _bluedSteel.withValues(alpha: 0.85),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('9', style: _serif(13.0, _ivory, weight: FontWeight.bold)),
          ),
        ),
        ...hourMarks,
        // Hand from center to "9".
        Positioned(
          left: 22.0,
          top: 108.0,
          child: Container(
            width: 80.0,
            height: 3.0,
            decoration: BoxDecoration(
              color: _bluedSteel,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        Positioned(
          left: 100.0,
          top: 100.0,
          child: Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: _crimson,
              shape: BoxShape.circle,
              border: Border.all(color: _ivory, width: 2.0),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget dialPanel = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _bluedSteel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('TimePickerEntryMode.dial',
            style: _mono(12.0, _brassBright, weight: FontWeight.bold)),
        SizedBox(height: 6.0),
        Text('A 12-position rotor — hours first, then minutes.',
            style: _serif(11.5, _ivoryDeep, italic: FontStyle.italic)),
        SizedBox(height: 14.0),
        Center(child: dialFace),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _chip('hour ring', _brass.withValues(alpha: 0.3), _ivory),
            _chip('minute ring', _patina.withValues(alpha: 0.3), _ivory),
            _chip('5-min snap', _crimson.withValues(alpha: 0.3), _ivory),
          ],
        ),
      ],
    ),
  );
  print('Dial mock built');

  // ============================================================
  // SECTION 5: Mock input — the keyboard pane
  // ============================================================
  print('=== Section 5: Input mock ===');

  final Widget inputPanel = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _bluedSteel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('TimePickerEntryMode.input',
            style: _mono(12.0, _brassBright, weight: FontWeight.bold)),
        SizedBox(height: 6.0),
        Text('Two pairs of digit fields — keyboard-friendly entry.',
            style: _serif(11.5, _ivoryDeep, italic: FontStyle.italic)),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Hour', style: _mono(10.0, _ivoryDeep)),
                SizedBox(height: 4.0),
                Row(children: <Widget>[
                  _digitBox('0', false),
                  SizedBox(width: 6.0),
                  _digitBox('9', true),
                ]),
              ],
            ),
            SizedBox(width: 12.0),
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(':', style: _serif(36.0, _ivory, weight: FontWeight.bold)),
            ),
            SizedBox(width: 12.0),
            Column(
              children: <Widget>[
                Text('Minute', style: _mono(10.0, _ivoryDeep)),
                SizedBox(height: 4.0),
                Row(children: <Widget>[
                  _digitBox('4', false),
                  SizedBox(width: 6.0),
                  _digitBox('1', false),
                ]),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _ivory,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: _brass, width: 1.0),
              ),
              child: Text('AM', style: _mono(11.0, _midnight, weight: FontWeight.bold)),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _crimson,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text('PM', style: _mono(11.0, _ivory, weight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    ),
  );
  print('Input mock built');

  // ============================================================
  // SECTION 6: TimePickerEntryMode — the four members side-by-side
  // ============================================================
  print('=== Section 6: Entry-mode quartet ===');

  final Widget modeQuartet = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _modeCard(
        'TimePickerEntryMode.dial',
        'Open on the round dial. The keyboard toggle is shown so the user can switch to typing.',
        Icons.access_time,
        true,
        _bluedSteel,
      ),
      _modeCard(
        'TimePickerEntryMode.input',
        'Open on the digit fields. The dial toggle is shown so the user can switch to spinning.',
        Icons.keyboard_alt,
        true,
        _emerald,
      ),
      _modeCard(
        'TimePickerEntryMode.dialOnly',
        'Dial only — locked. No toggle is visible. Use when you want a touch-only experience.',
        Icons.lock_clock,
        false,
        _crimson,
      ),
      _modeCard(
        'TimePickerEntryMode.inputOnly',
        'Input only — locked. No toggle is visible. Use for accessibility or kiosk keypads.',
        Icons.dialpad,
        false,
        _patina,
      ),
    ],
  );
  print('Mode quartet built');

  // ============================================================
  // SECTION 7: TimeOfDayFormat — the local rendering shape
  // ============================================================
  print('=== Section 7: TimeOfDayFormat panel ===');

  final Widget formatPanel = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TimeOfDayFormat — what the local face looks like',
          style: _serif(14.0, _midnight, weight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          'The dialog reads MaterialLocalizations.timeOfDayFormat to choose a layout. '
          'You generally do not pass this directly; you steer it via locale and 24h media-query.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          color: _bluedSteel,
          child: Row(
            children: <Widget>[
              SizedBox(width: 230.0, child: Text('FORMAT', style: _mono(10.5, _ivory, weight: FontWeight.bold))),
              SizedBox(width: 130.0, child: Text('SHAPE', style: _mono(10.5, _ivory, weight: FontWeight.bold))),
              SizedBox(width: 170.0, child: Text('SAMPLE', style: _mono(10.5, _ivory, weight: FontWeight.bold))),
              Expanded(child: Text('LOCALE HINT', style: _mono(10.5, _ivory, weight: FontWeight.bold))),
            ],
          ),
        ),
        _formatRow('h_colon_mm_space_a', 'h:mm a', '9:41 AM', 'en_US — the canonical 12h flavor'),
        _formatRow('HH_colon_mm', 'HH:mm', '09:41', 'fr_FR, de_DE — most 24h locales'),
        _formatRow('H_colon_mm', 'H:mm', '9:41', 'cs_CZ — 24h, no leading zero'),
        _formatRow('HH_dot_mm', 'HH.mm', '09.41', 'fi_FI — Finnish dot separator'),
        _formatRow('frenchCanadian', 'HH \u0027h\u0027 mm', '09 h 41', 'fr_CA — with stuck h-glyph'),
        _formatRow('a_space_h_colon_mm', 'a h:mm', 'AM 9:41', 'zh_CN — period leading'),
      ],
    ),
  );
  print('Format panel built');

  // ============================================================
  // SECTION 8: Localization story — 12h vs 24h
  // ============================================================
  print('=== Section 8: 12h vs 24h ===');

  final Widget localizationStory = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_ivoryDeep, _ivory],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('12-hour vs 24-hour — who decides?',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(
          'TimeOfDay is always 24h internally. The face you see is decided by '
          'MediaQuery.alwaysUse24HourFormat together with the active Locale. '
          'You change the look by wrapping the dialog in a MediaQuery via the builder.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _clockSample('alwaysUse24=false  (en_US)', '9:41 AM', _bluedSteel),
            _clockSample('alwaysUse24=true   (any locale)', '21:41', _crimson),
            _clockSample('fr_FR default', '21:41', _emerald),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _midnight,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('// Force 24h, regardless of locale', style: _mono(10.5, _patina)),
              Text('builder: (BuildContext ctx, Widget? child) {', style: _mono(11.0, _ivory)),
              Text('  return MediaQuery(', style: _mono(11.0, _ivory)),
              Text('    data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),', style: _mono(11.0, _ivory)),
              Text('    child: child!,', style: _mono(11.0, _ivory)),
              Text('  );', style: _mono(11.0, _ivory)),
              Text('},', style: _mono(11.0, _ivory)),
            ],
          ),
        ),
      ],
    ),
  );
  print('Localization story built');

  // ============================================================
  // SECTION 9: The label trio — helpText / cancelText / confirmText
  // ============================================================
  print('=== Section 9: Label trio dialog mock ===');

  final Widget labeledDialogMock = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _ivoryDeep,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // The dialog card.
        Container(
          width: 360.0,
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: _ivory,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 16.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('SELECT A SCHEDULED TIME',
                  style: _mono(11.0, _patina, weight: FontWeight.bold)),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _brass.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('09', style: _serif(38.0, _midnight, weight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(':', style: _serif(38.0, _midnight, weight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _ivoryDeep,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('41', style: _serif(38.0, _midnight, weight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    child: Text('DISMISS', style: _mono(11.0, _bluedSteel, weight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: _crimson,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('SCHEDULE', style: _mono(11.0, _ivory, weight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        // Annotation arrows.
        Row(
          children: <Widget>[
            _labeledArrow('helpText', 360.0, _bluedSteel),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _labeledArrow('cancelText', 80.0, _bluedSteel),
            SizedBox(width: 8.0),
            _labeledArrow('confirmText', 100.0, _crimson),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _midnight,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('// what the example above passes', style: _mono(10.5, _patina)),
              Text('helpText:    \u0027SELECT A SCHEDULED TIME\u0027,', style: _mono(11.0, _ivory)),
              Text('cancelText:  \u0027DISMISS\u0027,', style: _mono(11.0, _ivory)),
              Text('confirmText: \u0027SCHEDULE\u0027,', style: _mono(11.0, _ivory)),
              Text('hourLabelText:   \u0027Hour\u0027,', style: _mono(11.0, _ivory)),
              Text('minuteLabelText: \u0027Minute\u0027,', style: _mono(11.0, _ivory)),
              Text('errorInvalidText: \u0027Outside opening hours\u0027,', style: _mono(11.0, _ivory)),
            ],
          ),
        ),
      ],
    ),
  );
  print('Label trio mock built');

  // ============================================================
  // SECTION 10: builder — wrapping the dialog
  // ============================================================
  print('=== Section 10: builder param ===');

  final Widget builderExplainer = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('builder — the spell that re-themes the room',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(
          'The builder runs once per route build, wrapping the TimePickerDialog. '
          'It is the canonical place to override Theme, Directionality, MediaQuery, '
          'or Localizations for the dialog only. The child argument is the dialog itself; '
          'never return null here, and never drop the child.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 14.0),
        _wrapLayer(
          'Theme(...)',
          _bluedSteel,
          _wrapLayer(
            'Directionality(textDirection: TextDirection.rtl)',
            _emerald,
            _wrapLayer(
              'MediaQuery(alwaysUse24HourFormat: true)',
              _crimson,
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: _midnight,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'TimePickerDialog (child!)',
                  style: _mono(11.5, _ivory, weight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: _midnight, borderRadius: BorderRadius.circular(6.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('// Recipe: dark dialog over a light app', style: _mono(10.5, _patina)),
              Text('builder: (BuildContext ctx, Widget? child) => Theme(', style: _mono(11.0, _ivory)),
              Text('  data: ThemeData.dark().copyWith(', style: _mono(11.0, _ivory)),
              Text('    timePickerTheme: const TimePickerThemeData(', style: _mono(11.0, _ivory)),
              Text('      backgroundColor: Color(0xFF1B2233),', style: _mono(11.0, _ivory)),
              Text('      hourMinuteColor: Color(0xFF334466),', style: _mono(11.0, _ivory)),
              Text('      dialHandColor: Color(0xFFD4B164),', style: _mono(11.0, _ivory)),
              Text('    ),', style: _mono(11.0, _ivory)),
              Text('  ),', style: _mono(11.0, _ivory)),
              Text('  child: child!,', style: _mono(11.0, _ivory)),
              Text('),', style: _mono(11.0, _ivory)),
            ],
          ),
        ),
      ],
    ),
  );
  print('Builder explainer built');

  // ============================================================
  // SECTION 11: orientation — the portrait/landscape twins
  // ============================================================
  print('=== Section 11: orientation twins ===');

  final Widget orientationCards = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('orientation — Orientation.portrait | Orientation.landscape',
            style: _serif(14.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(
          'The dialog auto-detects orientation, but you can force it. '
          'Portrait stacks the time header above the dial; landscape places them side-by-side.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _oriCard('Orientation.portrait', 200.0, 240.0, true),
            _oriCard('Orientation.landscape', 320.0, 180.0, false),
          ],
        ),
      ],
    ),
  );
  print('Orientation twins built');

  // ============================================================
  // SECTION 12: errorInvalidText — a tiny error pavilion
  // ============================================================
  print('=== Section 12: errorInvalidText pavilion ===');

  final Widget errorPavilion = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _crimson, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.error_outline, color: _crimson, size: 20.0),
            SizedBox(width: 6.0),
            Text('errorInvalidText — only visible in input mode',
                style: _serif(14.0, _midnight, weight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'When the user types a value Flutter cannot parse — for instance "99" in the hour field — '
          'the dialog renders this string in red beneath the digit boxes. '
          'It does NOT fire when the time is otherwise out of business range; that is your job '
          'to enforce after the dialog returns.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _ivoryDeep,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: _crimson, width: 1.0),
              ),
              child: Text('99', style: _serif(20.0, _crimson, weight: FontWeight.bold)),
            ),
            SizedBox(width: 6.0),
            Text(':', style: _serif(20.0, _midnight, weight: FontWeight.bold)),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: _ivoryDeep,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: _hairline, width: 1.0),
              ),
              child: Text('41', style: _serif(20.0, _midnight, weight: FontWeight.bold)),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Enter a valid time',
          style: _serif(11.5, _crimson, weight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: _midnight, borderRadius: BorderRadius.circular(6.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('errorInvalidText: \u0027Try again — hours run 0..23\u0027,', style: _mono(11.0, _ivory)),
              Text('// Defaults to MaterialLocalizations.invalidTimeLabel.', style: _mono(10.5, _patina)),
            ],
          ),
        ),
      ],
    ),
  );
  print('Error pavilion built');

  // ============================================================
  // SECTION 13: anchorPoint, useRootNavigator, routeSettings
  // ============================================================
  print('=== Section 13: routing trio ===');

  final Widget routingTrio = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Routing — anchorPoint, useRootNavigator, routeSettings',
            style: _serif(14.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _routingCard(
              'anchorPoint',
              'Where on a multi-screen device should I appear?',
              'Pass an Offset in logical pixels. The framework picks the DisplayFeature whose '
                  'sub-region contains the point. Use Offset.zero for top-left screen.',
              _bluedSteel,
            ),
            _routingCard(
              'useRootNavigator',
              'Default true — push on the root.',
              'Set false to push on the nearest Navigator. Useful inside nested navigation '
                  '(tabs, modal sheets) when you want the picker to live in that subtree only.',
              _emerald,
            ),
            _routingCard(
              'routeSettings',
              'Name and arguments for analytics & deep-links.',
              'Pass RouteSettings(name: \u0027/time-picker\u0027, arguments: ...). '
                  'Surface it in your RouteObserver so navigation logging captures the dialog.',
              _crimson,
            ),
            _routingCard(
              'barrierDismissible',
              'Tap outside to dismiss?',
              'Default true — tapping the scrim returns null. Set false when the user MUST '
                  'pick or explicitly cancel.',
              _patina,
            ),
            _routingCard(
              'barrierColor / barrierLabel',
              'How does the dim layer look and read?',
              'barrierColor tints the underlay (Black54 by default). barrierLabel is the '
                  'semantics label spoken when the user dismisses by gesture.',
              _brassDeep,
            ),
            _routingCard(
              'onEntryModeChanged',
              'A discreet bell when the user toggles.',
              'Receives the new TimePickerEntryMode. Use it for analytics — never to mutate '
                  'the dialog itself; it is too late by then.',
              _bluedSteelDeep,
            ),
          ],
        ),
      ],
    ),
  );
  print('Routing trio built');

  // ============================================================
  // SECTION 14: TimePickerThemeData — the wardrobe
  // ============================================================
  print('=== Section 14: ThemeData wardrobe ===');

  final Widget themeWardrobe = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('TimePickerThemeData — the wardrobe',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(
          'Set on Theme.timePickerTheme or via the builder. Each property is nullable; '
          'unset fields fall back to Material defaults driven by ColorScheme.',
          style: _serif(11.5, _midnight),
        ),
        SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _swatch('backgroundColor', _ivory),
            _swatch('hourMinuteColor', _bluedSteel),
            _swatch('hourMinuteTextColor', _ivory),
            _swatch('dayPeriodColor', _ivoryDeep),
            _swatch('dayPeriodTextColor', _midnight),
            _swatch('dialHandColor', _crimson),
            _swatch('dialBackgroundColor', _ivoryDeep),
            _swatch('dialTextColor', _midnight),
            _swatch('entryModeIconColor', _brass),
            _swatch('helpTextStyle.color', _patina),
            _swatch('inputDecorationTheme.fill', _ivory),
            _swatch('cancelButtonStyle', _bluedSteel),
            _swatch('confirmButtonStyle', _crimson),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Tip: when designing dark-mode, set BOTH hourMinuteColor and dialBackgroundColor — '
          'the contrast between the active hour pill and the dial face is what readers register first.',
          style: _serif(11.0, _patina, italic: FontStyle.italic),
        ),
      ],
    ),
  );
  print('Theme wardrobe built');

  // ============================================================
  // SECTION 15: Pitfalls — the watchmaker's regrets
  // ============================================================
  print('=== Section 15: Pitfalls ===');

  final Widget pitfalls = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Pitfalls — the watchmaker\u2019s regrets',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 10.0),
        _pitfallRow(
          'Treating the result as non-null',
          'showTimePicker returns Future<TimeOfDay?>. The user can dismiss with the scrim, '
              'system back, or cancelText. Always handle null before calling .hour or .minute.',
          Icons.warning_amber,
          _crimson,
        ),
        _pitfallRow(
          'Hard-coding 12h or 24h',
          'Do not assume one or the other. Read MediaQuery.alwaysUse24HourFormat or override '
              'it through builder. Times you display elsewhere should match the dialog\u2019s shape.',
          Icons.translate,
          _bluedSteel,
        ),
        _pitfallRow(
          'Storing TimeOfDay long-term',
          'TimeOfDay carries no date and no time-zone. Persist it as (hour, minute) in business '
              'data, or combine with a DateTime for a concrete moment.',
          Icons.storage,
          _emerald,
        ),
        _pitfallRow(
          'Calling setState from the builder',
          'The builder is invoked during route build. Mutating state inside it loops the framework. '
              'Mutate state in the .then() of the future, or in onEntryModeChanged.',
          Icons.loop,
          _crimson,
        ),
        _pitfallRow(
          'Forgetting to localize labels',
          'helpText, cancelText, confirmText, hourLabelText, minuteLabelText, errorInvalidText — '
              'all are strings you control. Wire them through your AppLocalizations.',
          Icons.language,
          _patina,
        ),
        _pitfallRow(
          'Mistaking input mode for free-form',
          'Even in input mode, the field validates 0..23 and 0..59 (or 1..12 + AM/PM in 12h mode). '
              'You cannot accept "9:65" or "25:00".',
          Icons.calculate,
          _bluedSteelDeep,
        ),
        _pitfallRow(
          'Skipping useRootNavigator inside bottom sheets',
          'A picker pushed on the root navigator outlives a dismissed bottom sheet. Inside a '
              'transient sheet, set useRootNavigator: false so the picker dies with its host.',
          Icons.layers,
          _brassDeep,
        ),
        _pitfallRow(
          'Restyling the dial only',
          'When customising via TimePickerThemeData, theme BOTH hourMinute fields and the dial. '
              'Half-styled dialogs read worse than untouched ones.',
          Icons.color_lens,
          _emerald,
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 16: Recipes — small ready-to-paste calls
  // ============================================================
  print('=== Section 16: Recipes ===');

  final Widget recipes = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Recipes — small reproducible calls',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 10.0),
        _recipeBlock(
          '1. Minimal call — open at noon',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 12, minute: 0),',
            ');',
          ],
        ),
        _recipeBlock(
          '2. Force keyboard entry on opening',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: TimeOfDay.fromDateTime(DateTime.now()),',
            '  initialEntryMode: TimePickerEntryMode.input,',
            ');',
          ],
        ),
        _recipeBlock(
          '3. Locked dial, custom labels (kiosk)',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 9, minute: 30),',
            '  initialEntryMode: TimePickerEntryMode.dialOnly,',
            '  helpText: \u0027Pick your start time\u0027,',
            '  cancelText: \u0027Back\u0027,',
            '  confirmText: \u0027Set\u0027,',
            ');',
          ],
        ),
        _recipeBlock(
          '4. Always-24-hour, dark theme',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 21, minute: 41),',
            '  builder: (BuildContext ctx, Widget? child) => MediaQuery(',
            '    data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),',
            '    child: Theme(',
            '      data: ThemeData.dark(),',
            '      child: child!,',
            '    ),',
            '  ),',
            ');',
          ],
        ),
        _recipeBlock(
          '5. Right-to-left override',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 7, minute: 15),',
            '  builder: (BuildContext ctx, Widget? child) => Directionality(',
            '    textDirection: TextDirection.rtl,',
            '    child: child!,',
            '  ),',
            ');',
          ],
        ),
        _recipeBlock(
          '6. Listen to entry-mode toggles',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 14, minute: 0),',
            '  onEntryModeChanged: (TimePickerEntryMode mode) {',
            '    debugPrint(\u0027picker mode is now: \u0024mode\u0027);',
            '  },',
            ');',
          ],
        ),
        _recipeBlock(
          '7. Multi-screen — pick the right display',
          <String>[
            'showTimePicker(',
            '  context: context,',
            '  initialTime: const TimeOfDay(hour: 8, minute: 0),',
            '  anchorPoint: const Offset(1000.0, 0.0),',
            ');',
          ],
        ),
        _recipeBlock(
          '8. Validation after the dialog returns',
          <String>[
            '// (illustrative; no async in this demo)',
            '// final picked = await showTimePicker(...);',
            '// if (picked == null) return;             // cancelled',
            '// if (picked.hour < 9 || picked.hour >= 17) {',
            '//   showSnack(\u0027Outside working hours\u0027);',
            '//   return;',
            '// }',
            '// applyTime(picked);',
          ],
        ),
      ],
    ),
  );
  print('Recipes built');

  // ============================================================
  // SECTION 17: Comparison — showTimePicker vs TimePickerDialog
  // ============================================================
  print('=== Section 17: Function vs Widget ===');

  final Widget functionVsWidget = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivoryDeep.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('showTimePicker vs TimePickerDialog',
            style: _serif(15.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(
          'Two ways to do the same thing — at different layers of the stack.',
          style: _serif(11.5, _midnight, italic: FontStyle.italic),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _vsColumn(
              'showTimePicker(...)',
              <String>[
                'Top-level async function.',
                'Pushes a modal route on a Navigator.',
                'Returns Future<TimeOfDay?>.',
                'Handles barrier, anchor, and root vs nested routing.',
                'Default for 95% of apps — start here.',
              ],
              _bluedSteel,
            ),
            _vsColumn(
              'TimePickerDialog(...)',
              <String>[
                'Underlying StatefulWidget.',
                'Place inside your own showDialog or custom route.',
                'Use when you need an unusual transition or non-modal usage.',
                'Pair with Navigator.pop(context, time) to return the value.',
                'Same params (initialTime, helpText, ...) plus onEntryModeChanged.',
              ],
              _crimson,
            ),
          ],
        ),
      ],
    ),
  );
  print('Function vs Widget built');

  // ============================================================
  // SECTION 18: Footer — colophon plate
  // ============================================================
  print('=== Section 18: Footer ===');

  final Widget footer = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_midnight, _bluedSteelDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _brass, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _crimson,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text('COLOPHON',
                  style: _mono(11.0, _ivory, weight: FontWeight.bold)),
            ),
            SizedBox(width: 8.0),
            Text('horologie · MMXXVI',
                style: _serif(12.0, _brassBright, italic: FontStyle.italic)),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Set in brass and blued steel by hand. No timers, no streams, no real overlays.',
          style: _serif(12.0, _ivoryDeep),
        ),
        SizedBox(height: 4.0),
        Text(
          'A static portrait of showTimePicker — every parameter, every entry mode, every label slot, '
          'rendered for the eye and the linter alike.',
          style: _serif(12.0, _ivoryDeep),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            _chip('flutter/material', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('TimeOfDay', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('TimePickerEntryMode', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('TimePickerThemeData', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('builder', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('orientation', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('anchorPoint', _bluedSteel.withValues(alpha: 0.6), _ivory),
            _chip('errorInvalidText', _bluedSteel.withValues(alpha: 0.6), _ivory),
          ],
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(
            '— end of demo —',
            style: _serif(12.0, _brassBright, italic: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
  print('Footer built');

  // ============================================================
  // Compose all sections.
  // ============================================================
  print('=== Composing the page ===');

  final List<Widget> page = <Widget>[
    hero,
    _sectionHeader('1', 'Anatomy of the call', 'every parameter, kind, and purpose'),
    paramTable,
    _sectionHeader('2', 'TimeOfDay', 'the small ledger the dialog returns'),
    todAnatomy,
    _sectionHeader('3', 'Entry modes — dial pane', 'the round face, hour ring then minute ring'),
    dialPanel,
    _sectionHeader('4', 'Entry modes — input pane', 'two pairs of digit fields and the AM/PM pill'),
    inputPanel,
    _sectionHeader('5', 'TimePickerEntryMode', 'four members, four moods'),
    modeQuartet,
    _sectionHeader('6', 'TimeOfDayFormat', 'the local rendering shape'),
    formatPanel,
    _sectionHeader('7', '12-hour vs 24-hour', 'who decides? and how to override'),
    localizationStory,
    _sectionHeader('8', 'helpText / cancelText / confirmText', 'three strings, one labelled diagram'),
    labeledDialogMock,
    _sectionHeader('9', 'builder', 'wrapping the dialog in Theme/Locale/MediaQuery'),
    builderExplainer,
    _sectionHeader('10', 'orientation', 'portrait stacks; landscape sets side by side'),
    orientationCards,
    _sectionHeader('11', 'errorInvalidText', 'the only error label the dialog itself shows'),
    errorPavilion,
    _sectionHeader('12', 'Routing', 'anchorPoint, useRootNavigator, routeSettings, barrier*'),
    routingTrio,
    _sectionHeader('13', 'TimePickerThemeData', 'the wardrobe and the swatches'),
    themeWardrobe,
    _sectionHeader('14', 'Pitfalls', 'eight regrets the workshop has seen'),
    pitfalls,
    _sectionHeader('15', 'Recipes', 'short reproducible call samples'),
    recipes,
    _sectionHeader('16', 'showTimePicker vs TimePickerDialog', 'function or widget?'),
    functionVsWidget,
    footer,
  ];

  print('Page composed: ${page.length} top-level widgets');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'showTimePicker · Atelier · Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _bluedSteel,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: _ivory,
    ),
    home: Scaffold(
      backgroundColor: _ivory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: page,
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// More helpers — extracted from build() to keep inner closures
// out of the body. Dart cannot hoist nested functions cleanly
// when the file is also analyzed against unused_element rules.
// ============================================================
Widget _digitBox(String d, bool selected) {
  return Container(
    width: 64.0,
    height: 78.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: selected ? _brassBright.withValues(alpha: 0.25) : _ivory,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: selected ? _crimson : _hairline.withValues(alpha: 0.6),
        width: selected ? 2.0 : 1.0,
      ),
    ),
    child: Text(d, style: _serif(36.0, _midnight, weight: FontWeight.bold)),
  );
}

Widget _modeCard(String name, String description, IconData icon, bool toggle, Color tint) {
  return Container(
    width: 260.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: tint, size: 18.0),
            SizedBox(width: 6.0),
            Text(name, style: _mono(11.5, _midnight, weight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 6.0),
        Text(description, style: _serif(11.0, _midnight)),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: toggle ? _emerald.withValues(alpha: 0.25) : _hairline.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                toggle ? 'mode toggle SHOWN' : 'mode toggle HIDDEN',
                style: _mono(9.5, toggle ? _emerald : _shadow, weight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _formatRow(String name, String shape, String example, String locale) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: _ivory,
      border: Border(bottom: BorderSide(color: _hairline.withValues(alpha: 0.4), width: 0.5)),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 230.0,
          child: Text(name, style: _mono(11.0, _midnight, weight: FontWeight.bold)),
        ),
        SizedBox(
          width: 130.0,
          child: Text(shape, style: _mono(11.0, _crimson)),
        ),
        SizedBox(
          width: 170.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: _bluedSteel,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(example, style: _mono(12.0, _ivory, weight: FontWeight.bold)),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(child: Text(locale, style: _serif(11.0, _patina, italic: FontStyle.italic))),
      ],
    ),
  );
}

Widget _clockSample(String label, String time, Color tint) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint, width: 1.5),
    ),
    child: Column(
      children: <Widget>[
        Text(label, style: _mono(11.0, tint, weight: FontWeight.bold)),
        SizedBox(height: 12.0),
        Text(time, style: _serif(34.0, _midnight, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        _tickRow(8, tint.withValues(alpha: 0.6)),
      ],
    ),
  );
}

Widget _labeledArrow(String label, double width, Color color) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(width: 1.0, height: 14.0, color: color),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(label, style: _mono(9.5, _ivory, weight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

Widget _wrapLayer(String label, Color tint, Widget child) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: _mono(10.5, tint, weight: FontWeight.bold)),
        SizedBox(height: 6.0),
        child,
      ],
    ),
  );
}

Widget _oriCard(String label, double w, double h, bool stacked) {
  return Container(
    width: w + 24.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _brass, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: _mono(11.0, _crimson, weight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: _ivoryDeep,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _hairline, width: 0.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: _bluedSteel,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        alignment: Alignment.center,
                        child: Text('09 : 41', style: _mono(13.0, _ivory, weight: FontWeight.bold)),
                      ),
                      SizedBox(height: 6.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _ivory,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: _brass, width: 1.0),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.access_time, color: _bluedSteel, size: 28.0),
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: _bluedSteel,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        alignment: Alignment.center,
                        child: Text('09:41', style: _mono(12.0, _ivory, weight: FontWeight.bold)),
                      ),
                      SizedBox(width: 6.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _ivory,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: _brass, width: 1.0),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.access_time, color: _bluedSteel, size: 28.0),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    ),
  );
}

Widget _routingCard(String name, String oneLiner, String body, Color tint) {
  return Container(
    width: 290.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: _mono(11.5, tint, weight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(oneLiner, style: _serif(12.0, _midnight, weight: FontWeight.w600)),
        SizedBox(height: 6.0),
        Text(body, style: _serif(11.0, _midnight)),
      ],
    ),
  );
}

Widget _swatch(String name, Color c) {
  return Container(
    margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
    width: 130.0,
    child: Row(
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: _midnight, width: 0.5),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(name, style: _mono(10.5, _midnight)),
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String title, String detail, IconData icon, Color tint) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: tint, width: 4.0),
        top: BorderSide(color: _hairline.withValues(alpha: 0.4), width: 0.5),
        right: BorderSide(color: _hairline.withValues(alpha: 0.4), width: 0.5),
        bottom: BorderSide(color: _hairline.withValues(alpha: 0.4), width: 0.5),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: tint, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _serif(12.0, _midnight, weight: FontWeight.bold)),
              SizedBox(height: 2.0),
              Text(detail, style: _serif(11.0, _midnight)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeBlock(String title, List<String> code) {
  final List<Widget> lines = <Widget>[];
  for (final String l in code) {
    lines.add(Text(l, style: _mono(11.0, _ivory)));
  }
  return Container(
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _midnight,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _brass.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _mono(11.5, _brassBright, weight: FontWeight.bold)),
        SizedBox(height: 6.0),
        ...lines,
      ],
    ),
  );
}

Widget _vsColumn(String title, List<String> rows, Color tint) {
  final List<Widget> children = <Widget>[];
  children.add(Text(title, style: _mono(12.0, tint, weight: FontWeight.bold)));
  children.add(SizedBox(height: 6.0));
  for (final String row in rows) {
    children.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('\u2022 ', style: _serif(12.0, tint, weight: FontWeight.bold)),
          Expanded(child: Text(row, style: _serif(11.5, _midnight))),
        ],
      ),
    ));
  }
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _ivory,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

// ============================================================
// Tiny trig helpers — deterministic, no dart:math import needed.
// We only need them for laying out 12 hour-marks once. Using a
// 6-term Taylor expansion is plenty accurate for placement.
// ============================================================
double _sinApprox(double x) {
  // Reduce x into [-pi, pi].
  double r = x;
  while (r > 3.14159265) {
    r = r - 6.28318530;
  }
  while (r < -3.14159265) {
    r = r + 6.28318530;
  }
  final double r2 = r * r;
  final double r3 = r2 * r;
  final double r5 = r3 * r2;
  final double r7 = r5 * r2;
  final double r9 = r7 * r2;
  return r - r3 / 6.0 + r5 / 120.0 - r7 / 5040.0 + r9 / 362880.0;
}

double _cosApprox(double x) {
  double r = x;
  while (r > 3.14159265) {
    r = r - 6.28318530;
  }
  while (r < -3.14159265) {
    r = r + 6.28318530;
  }
  final double r2 = r * r;
  final double r4 = r2 * r2;
  final double r6 = r4 * r2;
  final double r8 = r6 * r2;
  return 1.0 - r2 / 2.0 + r4 / 24.0 - r6 / 720.0 + r8 / 40320.0;
}
